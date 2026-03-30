#!/usr/bin/env bash
# build.sh – Compile a CUDA module
# Usage: ./scripts/build.sh <module_folder>
# Example: ./scripts/build.sh 01_vector_add

set -euo pipefail

MODULE="${1:?Usage: $0 <module_folder>}"
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SRC_DIR="$ROOT_DIR/$MODULE/src"
BUILD_DIR="$ROOT_DIR/$MODULE/build"

if [[ ! -d "$SRC_DIR" ]]; then
  echo "ERROR: Source directory not found: $SRC_DIR" >&2
  exit 1
fi

mkdir -p "$BUILD_DIR"

echo "==> Building module: $MODULE"
for cu_file in "$SRC_DIR"/*.cu; do
  [[ -e "$cu_file" ]] || { echo "No .cu files found in $SRC_DIR"; exit 1; }
  bin_name="$BUILD_DIR/$(basename "${cu_file%.cu}")"
  echo "    nvcc $cu_file -o $bin_name"
  nvcc "$cu_file" -I "$ROOT_DIR/$MODULE/include" -o "$bin_name"
done
echo "==> Build complete: $BUILD_DIR"
