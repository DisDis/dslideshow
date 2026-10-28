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
python3 - "$BENCHMARK_EGL_CAPTURE_DIR/runtime-provenance.json" "$real_runtime" "$library" "$(realpath -- "${BASH_SOURCE[0]}")" "$@" <<'PY'
import hashlib, json, os, pathlib, sys
from datetime import datetime, timezone
paths = [pathlib.Path(value) for value in sys.argv[2:5]]
record = dict(schema_version=1, kind='egl_backbuffer_capture',
    utc=datetime.now(timezone.utc).isoformat(), argv=sys.argv[5:],
    capture_directory=os.environ['BENCHMARK_EGL_CAPTURE_DIR'],
    inherited_ld_preload=os.environ.get('LD_PRELOAD'),
    effective_ld_library_path=os.environ.get('LD_LIBRARY_PATH'),
    source='real EGL FBO0 backbuffer before swap; physical scanout unverified',
    timing_results_valid=False)
for name, file in zip(('real_runtime', 'interposer', 'wrapper'), paths):
    record[name] = dict(path=str(file), sha256=hashlib.sha256(file.read_bytes()).hexdigest())
destination = pathlib.Path(sys.argv[1])
temporary = destination.with_suffix('.json.tmp')
temporary.write_text(json.dumps(record, indent=2) + '\n')
temporary.replace(destination)
PY
export LD_PRELOAD="$library${LD_PRELOAD:+:$LD_PRELOAD}"
exec "$real_runtime" "$@"
