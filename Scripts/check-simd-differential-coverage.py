#!/usr/bin/env python3
"""Checks that every FirebladeMath function with a simd branch has a differential test.

Functions whose body contains `#if FRB_MATH_USE_SIMD` have a simd implementation and a
portable one. The PortableVsSIMD tests compare the two; each test names the functions it
covers with `// covers: name(ParameterTypes)` comments, e.g.

    // covers: multiply(Mat4x4f, Mat4x4f)
    // covers: quaternion(angle: Float, axis: SIMD3<Float>)

Fails if a simd-backed function has no `covers:` annotation, or if an annotation names
a function that does not exist (or no longer has a simd branch).
"""

import pathlib
import re
import sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
SOURCES = ROOT / "Sources" / "FirebladeMath"
TESTS = ROOT / "Tests" / "FirebladeMathTests" / "PortableVsSIMD"

DECLARATION = re.compile(
    r"^(?P<attributes>(?:[ \t]*@[^\n]*\n)*)[ \t]*public\s+(?:static\s+)?func\s+(?P<name>\w+)\s*\((?P<parameters>[^)]*)\)[^{]*\{",
    re.MULTILINE,
)
COVERS = re.compile(r"^[ \t]*//[ \t]*covers:[ \t]*(.+?)[ \t]*$", re.MULTILINE)


def split_parameters(parameters):
    """Splits a parameter list on top-level commas (ignoring commas inside <...>)."""
    parts, depth, current = [], 0, ""
    for character in parameters:
        if character == "<":
            depth += 1
        elif character == ">":
            depth -= 1
        if character == "," and depth == 0:
            parts.append(current)
            current = ""
        else:
            current += character
    if current.strip():
        parts.append(current)
    return [part.strip() for part in parts]


def key(name, parameters):
    """`name(Type, label: Type)`: unlabeled parameters by type, labeled ones with their label."""
    rendered = []
    for parameter in split_parameters(parameters):
        names, type_name = parameter.split(":", 1)
        external = names.split()[0]
        type_name = " ".join(type_name.split())
        rendered.append(type_name if external == "_" else f"{external}: {type_name}")
    return f"{name}({', '.join(rendered)})"


def body_end(text, start):
    depth = 1
    index = start
    while depth and index < len(text):
        depth += {"{": 1, "}": -1}.get(text[index], 0)
        index += 1
    return index


def simd_backed_functions():
    functions = {}
    for path in sorted(SOURCES.rglob("*.swift")):
        text = path.read_text()
        for match in DECLARATION.finditer(text):
            if "deprecated" in match.group("attributes"):
                continue
            body = text[match.end():body_end(text, match.end())]
            if "FRB_MATH_USE_SIMD" in body:
                functions[key(match.group("name"), match.group("parameters"))] = path.relative_to(ROOT)
    return functions


def covered_functions():
    covered = {}
    for path in sorted(TESTS.rglob("*.swift")):
        for match in COVERS.finditer(path.read_text()):
            covered[" ".join(match.group(1).split())] = path.relative_to(ROOT)
    return covered


def main():
    functions = simd_backed_functions()
    covered = covered_functions()

    missing = sorted(set(functions) - set(covered))
    unknown = sorted(set(covered) - set(functions))

    if missing:
        print(f"error: {len(missing)} simd-backed function(s) have no differential test (`// covers:` annotation):")
        for name in missing:
            print(f"  {name}    [{functions[name]}]")
    if unknown:
        print(f"error: {len(unknown)} `// covers:` annotation(s) name no simd-backed function:")
        for name in unknown:
            print(f"  {name}    [{covered[name]}]")
    if missing or unknown:
        return 1

    print(f"All {len(functions)} simd-backed functions have differential tests.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
