#!/usr/bin/env python3
"""Checks that every public FirebladeMath function has cross-platform reference values.

Covered declarations:
- every public top-level function (except deprecated ones),
- every public static function and initializer declared in extensions of the concrete
  matrix and quaternion types (Mat2x2f ... Mat4x4d, Quat4f, Quat4d).

Each must be registered in Tests/FirebladeMathTests/ReferenceValues/ReferenceFunctions.swift,
keyed `name(ParameterTypes)` or `Type.name(ParameterTypes)`; generic functions are registered
once per instantiation with a ` [Float]` / ` [Double]` suffix. Fails on missing and on
stale registrations.
"""

import importlib.util
import pathlib
import re
import sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
REGISTRY = ROOT / "Tests" / "FirebladeMathTests" / "ReferenceValues" / "ReferenceFunctions.swift"

# Reuse the declaration parsing of the differential coverage check (without leaving
# __pycache__ behind).
sys.dont_write_bytecode = True
_spec = importlib.util.spec_from_file_location("simd_coverage", ROOT / "Scripts" / "check-simd-differential-coverage.py")
simd_coverage = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(simd_coverage)

TOP_LEVEL = re.compile(
    r"^(?P<attributes>(?:[ \t]*@[^\n]*\n)*)public\s+func\s+(?P<name>\w+)\s*(?:<[^>(]*>)?\s*\((?P<parameters>[^)]*)\)",
    re.MULTILINE,
)
CONCRETE_EXTENSION = re.compile(r"^extension\s+(Mat[234]x[234][fd]|Quat4[fd])\b")
MEMBER = re.compile(r"^\s+(?:@\w+\s+)*public\s+(?:static\s+func\s+(?P<name>\w+)|init)\s*\((?P<parameters>[^)]*)\)")
REGISTERED = re.compile(r'r\.add\("(?P<key>[^"]+)"')
GENERIC_SUFFIX = re.compile(r" \[(?:Float|Double)\]$")


def member_key(type_name, name, parameters):
    # Default values (`= .zero`) are not part of the key.
    parameters = re.sub(r"\s*=\s*[^,)]+", "", parameters)
    return f"{type_name}.{simd_coverage.key(name, parameters)}"


def public_functions():
    keys = set()
    for path in sorted(simd_coverage.SOURCES.rglob("*.swift")):
        text = path.read_text()
        for match in TOP_LEVEL.finditer(text):
            if "deprecated" not in match.group("attributes"):
                keys.add(simd_coverage.key(match.group("name"), match.group("parameters")))
        extension = None
        for line in text.split("\n"):
            if found := CONCRETE_EXTENSION.match(line):
                extension = found.group(1)
                continue
            if re.match(r"^(extension|struct|public|func)\b", line):
                extension = None
            if extension and (member := MEMBER.match(line)):
                keys.add(member_key(extension, member.group("name") or "init", member.group("parameters")))
    return keys


def registered_functions():
    keys = set()
    for match in REGISTERED.finditer(REGISTRY.read_text()):
        keys.add(GENERIC_SUFFIX.sub("", match.group("key")))
    return keys


def main():
    functions = public_functions()
    registered = registered_functions()

    missing = sorted(functions - registered)
    # Registrations of computed properties (`Type.property`, no parameter list) are extras.
    stale = sorted(key for key in registered - functions if "(" in key)

    if missing:
        print(f"error: {len(missing)} public function(s) have no reference values; register them in {REGISTRY.relative_to(ROOT)}:")
        for key in missing:
            print(f"  {key}")
    if stale:
        print(f"error: {len(stale)} registration(s) name no public function:")
        for key in stale:
            print(f"  {key}")
    if missing or stale:
        return 1

    print(f"All {len(functions)} public functions have cross-platform reference values.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
