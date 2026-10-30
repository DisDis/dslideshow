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
source "$app_dir/tool/cli.sh"
benchmark_tool prepare-output "$output"
export BENCHMARK_OUTPUT="$output" BENCHMARK_RENDERER=opengl DSLIDESHOW_EMBEDDED=true
export LD_LIBRARY_PATH="$bundle:$bundle/lib:$(dirname "$runtime")${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
exec 9>"${XDG_RUNTIME_DIR:-/tmp}/dslideshow-benchmarks.lock"
flock -n 9 || { echo 'Another benchmark launcher is active' >&2; exit 2; }
benchmark_tool launch "$output/launch.json" "$runtime" "$bundle" --compact
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
benchmark_tool status "$output/launcher-status.json" "$code"
tar -czf "$output.tar.gz" -C "$(dirname "$output")" "$(basename "$output")"
echo "RENDERER_ARCHIVE=$output.tar.gz"
exit "$code"
