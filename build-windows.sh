#!/usr/bin/env bash
# Build a single-file Windows .exe and package it into a zip,
# ready to send to anyone on Windows 11.
set -euo pipefail

BUILDDIR=build-windows
DISTDIR=dist

cmake -B "$BUILDDIR" \
    -DCMAKE_TOOLCHAIN_FILE=cmake/mingw-w64-x86_64.cmake \
    -DCMAKE_BUILD_TYPE=Release
cmake --build "$BUILDDIR" -j"$(nproc)"

mkdir -p "$DISTDIR"
cp "$BUILDDIR/Wayterra.exe" "$DISTDIR/Wayterra.exe"
x86_64-w64-mingw32-strip "$DISTDIR/Wayterra.exe"
command -v zip >/dev/null && (cd "$DISTDIR" && zip -q Wayterra-windows.zip Wayterra.exe)

echo
echo "Done. Send dist/Wayterra-windows.zip (or the bare Wayterra.exe) to your friend."
echo "On Windows 11 the first launch may show a SmartScreen warning:"
echo "  'More info' -> 'Run anyway'."
