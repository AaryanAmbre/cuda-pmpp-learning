#!/usr/bin/env bash
# profile.sh – Profile a CUDA module binary with Nsight Systems
# Usage: ./scripts/profile.sh <module_folder> [binary_name]
# Example: ./scripts/profile.sh 01_vector_add vector_add

set -euo pipefail

MODULE="${1:?Usage: $0 <module_folder> [binary_name]}"
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
BUILD_DIR="$ROOT_DIR/$MODULE/build"
REPORT_DIR="$ROOT_DIR/$MODULE/profiling/nsys_reports"

# Resolve binary
if [[ -n "${2:-}" ]]; then
  BINARY="$BUILD_DIR/$2"
else
  BINARY="$(find "$BUILD_DIR" -maxdepth 1 -type f -executable | head -n1)"
fi

if [[ -z "$BINARY" || ! -f "$BINARY" ]]; then
  echo "ERROR: No executable found in $BUILD_DIR. Run build.sh first." >&2
  exit 1
fi

mkdir -p "$REPORT_DIR"
REPORT_FILE="$REPORT_DIR/$(basename "$BINARY")_$(date +%Y%m%d_%H%M%S)"

echo "==> Profiling: $BINARY"
echo "    Report  : ${REPORT_FILE}.nsys-rep"
nsys profile \
  --output "$REPORT_FILE" \
  --trace cuda,nvtx,osrt \
  --force-overwrite true \
  "$BINARY"

echo "==> Profiling complete. Open the report with Nsight Systems GUI."
