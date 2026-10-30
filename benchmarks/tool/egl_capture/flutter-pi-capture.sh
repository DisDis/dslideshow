#!/usr/bin/env bash
# Optional quality-only wrapper; never use for FPS/latency measurements.
set -euo pipefail
script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
real_runtime=$(realpath -- "${BENCHMARK_EGL_REAL_RUNTIME:-/opt/dslideshow/flutter-pi}")
library=$(realpath -- "${BENCHMARK_EGL_CAPTURE_LIBRARY:-$script_dir/../../build/egl_capture/libegl_capture.so}")
[[ -x "$real_runtime" && -f "$library" ]] || { echo 'Missing real flutter-pi or EGL capture library; run egl_capture/build.sh first.' >&2; exit 2; }
[[ "$real_runtime" != "$(realpath -- "${BASH_SOURCE[0]}")" ]] || { echo 'EGL capture wrapper cannot wrap itself.' >&2; exit 2; }
for argument in "$@"; do
  [[ "$argument" != --vulkan ]] || { echo 'EGL capture supports OpenGL only.' >&2; exit 2; }
done
[[ "${BENCHMARK_RENDERER:-opengl}" == opengl ]] || { echo 'EGL capture supports OpenGL only.' >&2; exit 2; }
if [[ -z "${BENCHMARK_OUTPUT:-}" && -z "${BENCHMARK_EGL_CAPTURE_DIR:-}" ]]; then
  if [[ "${1:-}" == --help || "${1:-}" == -h ]]; then exec "$real_runtime" "$@"; fi
  echo 'Set BENCHMARK_OUTPUT or BENCHMARK_EGL_CAPTURE_DIR for EGL capture.' >&2
  exit 2
fi
export BENCHMARK_EGL_CAPTURE_DIR=${BENCHMARK_EGL_CAPTURE_DIR:-$BENCHMARK_OUTPUT/egl-capture}
mkdir -p -- "$BENCHMARK_EGL_CAPTURE_DIR"
BENCHMARK_EGL_CAPTURE_DIR=$(realpath -- "$BENCHMARK_EGL_CAPTURE_DIR")
export BENCHMARK_EGL_CAPTURE_DIR
# run.sh bases this path on the wrapper. Preserve bundle/engine precedence and
# restore the actual runtime's directory as the final fallback.
export LD_LIBRARY_PATH="${LD_LIBRARY_PATH:+$LD_LIBRARY_PATH:}$(dirname -- "$real_runtime")"
app_dir=$(cd -- "$script_dir/../.." && pwd)
source "$script_dir/../cli.sh"
benchmark_tools native egl-provenance "$BENCHMARK_EGL_CAPTURE_DIR/runtime-provenance.json" \
  "$real_runtime" "$library" "$(realpath -- "${BASH_SOURCE[0]}")" "$@"
export LD_PRELOAD="$library${LD_PRELOAD:+:$LD_PRELOAD}"
exec "$real_runtime" "$@"
