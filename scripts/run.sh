#!/usr/bin/env bash
# run.sh – Execute a compiled CUDA module binary
# Usage: ./scripts/run.sh <module_folder> [binary_name]
# Example: ./scripts/run.sh 01_vector_add vector_add

set -euo pipefail

MODULE="${1:?Usage: $0 <module_folder> [binary_name]}"
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
BUILD_DIR="$ROOT_DIR/$MODULE/build"

# If a specific binary name is provided, run it; otherwise run the first found.
if [[ -n "${2:-}" ]]; then
  BINARY="$BUILD_DIR/$2"
else
  BINARY="$(find "$BUILD_DIR" -maxdepth 1 -type f -executable | head -n1)"
fi

if [[ -z "$BINARY" || ! -f "$BINARY" ]]; then
  echo "ERROR: No executable found in $BUILD_DIR. Run build.sh first." >&2
  exit 1
fi

echo "==> Running: $BINARY"
"$BINARY"
