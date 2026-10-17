#!/usr/bin/env bash
# Installs the Swift SDK that matches the active toolchain.
#
# A Swift SDK must match the compiler version exactly. CI runs in `swift:X.Y.Z`
# containers whose tag Renovate bumps, so the SDK URL and checksum are looked up
# from the official swift.org release API for whatever toolchain is installed.
#
# Usage: Scripts/install-swift-sdk.sh <static|wasm|android>
# Prints the installed Swift SDK ID on the last line of output.
set -euo pipefail

KIND="${1:?usage: install-swift-sdk.sh <static|wasm|android>}"

# e.g. "Swift version 6.4.1 (swift-6.4.1-RELEASE)"
TOOLCHAIN_TAG=$(swift --version 2>&1 | grep -oE 'swift-[0-9]+(\.[0-9]+)+-RELEASE' | head -n 1)
if [ -z "${TOOLCHAIN_TAG}" ]; then
    echo "error: could not determine the toolchain release tag from 'swift --version'" >&2
    exit 1
fi
# The API spells x.y.0 releases with a trailing ".0" even when the compiler omits it.
TOOLCHAIN_TAG_PATCHED=$(echo "${TOOLCHAIN_TAG}" | sed -E 's/^swift-([0-9]+\.[0-9]+)-RELEASE$/swift-\1.0-RELEASE/')

RELEASE=$(curl -fsSL https://www.swift.org/api/v1/install/releases.json \
    | jq -c --arg t "${TOOLCHAIN_TAG}" --arg t0 "${TOOLCHAIN_TAG_PATCHED}" \
        '[.[] | select(.tag == $t or .tag == $t0)] | first')
if [ "${RELEASE}" = "null" ]; then
    echo "error: ${TOOLCHAIN_TAG} not found in the swift.org release API" >&2
    exit 1
fi
TAG=$(echo "${RELEASE}" | jq -r .tag)
VERSION=${TAG#swift-}
VERSION=${VERSION%-RELEASE}

PLATFORM=$(echo "${RELEASE}" | jq -c --arg p "${KIND}-sdk" '.platforms[] | select(.platform == $p)')
if [ -z "${PLATFORM}" ]; then
    echo "error: ${TAG} has no ${KIND} SDK" >&2
    exit 1
fi
CHECKSUM=$(echo "${PLATFORM}" | jq -r .checksum)

case "${KIND}" in
    static) FILE="${TAG}_static-linux-$(echo "${PLATFORM}" | jq -r .version).artifactbundle.tar.gz" ;;
    wasm) FILE="${TAG}_wasm.artifactbundle.tar.gz" ;;
    android) FILE="${TAG}_android.artifactbundle.tar.gz" ;;
    *) echo "error: unknown SDK kind '${KIND}'" >&2; exit 1 ;;
esac

URL="https://download.swift.org/swift-${VERSION}-release/${KIND}-sdk/${TAG}/${FILE}"
echo "Installing ${URL}"
swift sdk install "${URL}" --checksum "${CHECKSUM}"
