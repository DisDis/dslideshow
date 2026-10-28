#!/usr/bin/env bash
# Invoke through the documented run-managed.sh supervisor, which restores service.
# One attempt only: native faults remain failed results and are never retried.
set -euo pipefail
ulimit -c 0
app_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
bundle=${BENCHMARK_BUNDLE:-$app_dir/bundle}
runtime=${FLUTTER_PI:-/opt/dslideshow/flutter-pi}
output=${BENCHMARK_OUTPUT:-$app_dir/reports/$(date -u +%Y%m%dT%H%M%SZ)-renderer}
timeout_s=${BENCHMARK_TIMEOUT_SECONDS:-900}
python3 - "$output" <<'PY'
from pathlib import Path
import sys
output = Path(sys.argv[1])
output.mkdir(parents=True, exist_ok=True)
if any(output.iterdir()):
    raise SystemExit('Refusing nonempty benchmark output: ' + str(output))
PY
export BENCHMARK_OUTPUT="$output" BENCHMARK_RENDERER=opengl DSLIDESHOW_EMBEDDED=true
export LD_LIBRARY_PATH="$bundle:$bundle/lib:$(dirname "$runtime")${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
exec 9>"${XDG_RUNTIME_DIR:-/tmp}/dslideshow-benchmarks.lock"
flock -n 9 || { echo 'Another benchmark launcher is active' >&2; exit 2; }
python3 - "$output/launch.json" "$runtime" "$bundle" <<'PY'
import hashlib, json, pathlib, sys
runtime, bundle = pathlib.Path(sys.argv[2]), pathlib.Path(sys.argv[3])
pathlib.Path(sys.argv[1]).write_text(json.dumps({
    'runtime': str(runtime),
    'runtime_sha256': hashlib.sha256(runtime.read_bytes()).hexdigest(),
    'app_so_sha256': hashlib.sha256((bundle / 'app.so').read_bytes()).hexdigest(),
    'renderer': 'opengl', 'videomode': '2560x1600', 'attempts': 1,
}, indent=2) + '\n')
PY
child=''
interrupted=0
stop() {
  interrupted=1
  [[ -z "$child" ]] || kill -TERM "$child" 2>/dev/null || true
}
trap stop INT TERM
code=0
timeout --signal=TERM --kill-after=30s "$timeout_s" \
  "$runtime" --release --videomode 2560x1600 "$bundle" \
  > >(tee "$output/native.log") 2>&1 &
child=$!
wait "$child" || code=$?
if ((interrupted)); then
  # A trapped signal interrupts bash's wait before timeout/runtime have exited.
  # Reap them before the supervisor may restore the GPU-owning service.
  while kill -0 "$child" 2>/dev/null; do
    wait "$child" || true
  done
  code=130
fi
child=''
python3 - "$output/launcher-status.json" "$code" <<'PY'
import json, pathlib, sys
pathlib.Path(sys.argv[1]).write_text(json.dumps({'exit_code': int(sys.argv[2])}) + '\n')
PY
tar -czf "$output.tar.gz" -C "$(dirname "$output")" "$(basename "$output")"
echo "RENDERER_ARCHIVE=$output.tar.gz"
exit "$code"
