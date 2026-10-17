#!/usr/bin/env bash
# Verifies that every public function, initializer, subscript and computed property
# of FirebladeMath is @inlinable, i.e. that its body is visible to client modules.
#
# The module is built with library evolution so the compiler emits a .swiftinterface.
# Inlinable declarations carry their bodies in the interface; anything else shows up
# as a bare signature (`func f()` / `var v: T { get }`) and is reported.
#
# Usage: Scripts/check-inlinable.sh [extra swift build args...]
set -euo pipefail

BUILD_DIR="${CHECK_INLINABLE_BUILD_DIR:-.build/check-inlinable}"

echo "=== Building FirebladeMath with library evolution ==="
swift build -c release --target FirebladeMath --scratch-path "${BUILD_DIR}" \
    -Xswiftc -enable-library-evolution -Xswiftc -emit-module-interface "$@"

INTERFACE=$(find "${BUILD_DIR}" -name 'FirebladeMath.swiftinterface' | head -n 1)
if [ -z "${INTERFACE}" ]; then
    echo "error: FirebladeMath.swiftinterface not found in ${BUILD_DIR}" >&2
    exit 1
fi

echo "=== Checking ${INTERFACE} ==="
python3 - "${INTERFACE}" << 'EOF'
import re
import sys

# Members the compiler synthesizes (Hashable/Codable); they cannot be marked @inlinable.
ALLOWED = (
    re.compile(r"\bfunc hash\(into hasher: inout Swift::Hasher\)"),
    re.compile(r"\bfunc encode\(to encoder: any Swift::Encoder\) throws"),
    re.compile(r"\binit\(from decoder: any Swift::Decoder\) throws"),
    re.compile(r"\bvar hashValue: Swift::Int"),
)
DECL = re.compile(r"^\s*(?:@\S+\s+)*public\s+(?:(?:static|mutating|nonmutating|prefix|postfix|final)\s+)*(func|init|subscript|var)\b")

violations = []
protocol_depth = None
depth = 0
with open(sys.argv[1]) as interface:
    for number, line in enumerate(interface, 1):
        if protocol_depth is None and re.match(r"^\s*(?:@\S+\s+)*public\s+protocol\b", line):
            protocol_depth = depth
        match = DECL.match(line)
        if match and protocol_depth is None and not any(p.search(line) for p in ALLOWED):
            kind = match.group(1)
            if kind == "var":
                # Stored properties have no accessor block; opaque computed ones print `{ get }`.
                bodyless = re.search(r"\{\s*get\b", line) is not None
            else:
                bodyless = "{" not in line
            if bodyless:
                violations.append(f"{number}: {line.strip()}")
        depth += line.count("{") - line.count("}")
        if protocol_depth is not None and depth <= protocol_depth:
            protocol_depth = None

if violations:
    print(f"error: {len(violations)} public declaration(s) are not @inlinable:")
    print("\n".join(violations))
    sys.exit(1)
print("All public declarations are @inlinable.")
EOF
