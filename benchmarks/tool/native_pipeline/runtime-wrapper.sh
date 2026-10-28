#!/usr/bin/env bash
set -euo pipefail
tool_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
runtime=${BENCH_NATIVE_PIPELINE_RUNTIME:-/opt/dslideshow/flutter-pi}
runtime=$(realpath "$runtime")
export LD_LIBRARY_PATH="${LD_LIBRARY_PATH:+$LD_LIBRARY_PATH:}$(dirname -- "$runtime")"
for argument in "$@"; do
  if [[ "$argument" == --help || "$argument" == -h ]]; then
    exec "$runtime" "$@"
  fi
done
: "${BENCHMARK_OUTPUT:?Missing benchmark attempt directory}"
: "${BENCH_NATIVE_PIPELINE_ENGINE:?Missing frozen engine path}"
: "${BENCH_NATIVE_PIPELINE_ENGINE_SHA256:?Missing frozen engine hash}"
[[ -x "$runtime" && -f "$tool_dir/libnative_pipeline.so" ]]
python3 "$tool_dir/capture_process.py" "$$" \
  "$BENCH_NATIVE_PIPELINE_ENGINE" "$BENCH_NATIVE_PIPELINE_ENGINE_SHA256" \
  "$BENCHMARK_OUTPUT/native-pipeline-provenance.json" \
  > "$BENCHMARK_OUTPUT/native-pipeline-provenance.log" 2>&1 &
export BENCH_NATIVE_PIPELINE_TARGET="$runtime"
export BENCH_NATIVE_PIPELINE_OUTPUT="$BENCHMARK_OUTPUT/native-pipeline.bin"
export LD_PRELOAD="$tool_dir/libnative_pipeline.so${LD_PRELOAD:+:$LD_PRELOAD}"
exec "$runtime" "$@"
