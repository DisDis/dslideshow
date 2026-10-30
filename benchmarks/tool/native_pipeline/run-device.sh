#!/usr/bin/env bash
# Invoked in nohup on the Pi; the existing supervisor owns service/GPU recovery.
set -euo pipefail
if [[ $# != 5 ]]; then
  echo 'Usage: run-device.sh control|diagnostic BENCHMARK_ROOT EXPERIMENT_ROOT FROZEN_BUNDLE UNIQUE_JOB' >&2
  exit 2
fi
mode=$1
benchmark_root=$(realpath "$2")
experiment=$(realpath "$3")
bundle=$(realpath "$4")
job=$5
case "$mode" in control|diagnostic) ;; *) exit 2;; esac
[[ "$job" =~ ^[a-zA-Z0-9_-]+$ ]] || exit 2
tool_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
runtime=${BENCH_NATIVE_PIPELINE_RUNTIME:-/opt/dslideshow/flutter-pi}
runtime=$(realpath "$runtime")
: "${BENCH_NATIVE_PIPELINE_RUNTIME_SHA256:?Set the frozen runtime hash}"
: "${BENCH_NATIVE_PIPELINE_ENGINE_SHA256:?Set the frozen engine hash}"
config="$experiment/config/native-pipeline-photo.json"
[[ -x "$runtime" && -x "$benchmark_root/run-managed.sh" && -f "$bundle/app.so" && -f "$config" ]]
export BENCH_NATIVE_PIPELINE_RUNTIME="$runtime"
export BENCH_NATIVE_PIPELINE_ENGINE="$bundle/libflutter_engine.so"
export BENCH_NATIVE_PIPELINE_ENGINE_SHA256
unset LD_PRELOAD BENCHMARK_PIXEL_CAPTURE_BACKEND BENCH_NATIVE_PIPELINE_OUTPUT BENCH_NATIVE_PIPELINE_TARGET
tool_executable=${BENCHMARK_TOOLS_EXECUTABLE:-$benchmark_root/tools/dslideshow_tools}
[[ -x "$tool_executable" ]] || { echo 'Missing compiled benchmark Dart tools' >&2; exit 2; }
tool_executable=$(realpath "$tool_executable")
export BENCHMARK_TOOLS_EXECUTABLE="$tool_executable"
"$tool_executable" native inputs "$experiment/$job-inputs.json" "$mode" "$runtime" "$bundle" "$config" "$tool_dir" "$benchmark_root"
trace_name="dslideshow_native_${job//-/_}"
trace_output="$experiment/trace-$job"
trace_owned=0
trace_started=0
finish() {
  local result=$?
  trap - EXIT
  set +e
  if ((trace_owned)); then
    if ((trace_started)); then
      sudo -n "$tool_executable" native trace stop "$trace_name" "$trace_output" || result=2
    fi
    sudo -n "$tool_executable" native trace close "$trace_name" "$trace_output" || result=2
    sudo -n chown -R "$(id -u):$(id -g)" "$trace_output" || result=2
  fi
  printf '%s\n' "$result" > "$experiment/$job-exit-code"
  exit "$result"
}
trap finish EXIT
trap 'exit 130' INT
trap 'exit 143' TERM
args=(--bundle "$bundle" --config "$config" --output "$experiment/reports" --renderers opengl --timeout 1800)
launcher="$runtime"
if [[ "$mode" == diagnostic ]]; then
  [[ -x "$tool_dir/runtime-wrapper.sh" && -f "$tool_dir/libnative_pipeline.so" ]]
  sudo -n "$tool_executable" native trace init "$trace_name" "$trace_output"
  trace_owned=1
  sudo -n "$tool_executable" native trace start "$trace_name" "$trace_output"
  trace_started=1
  launcher="$tool_dir/runtime-wrapper.sh"
  "$tool_executable" native previous "$experiment" "$experiment/$job-previous-captures.json"
fi
args+=(--flutter-pi "$launcher")
"$benchmark_root/run-managed.sh" "$job" "${args[@]}"
if [[ "$mode" == diagnostic ]]; then
  "$tool_executable" native finalize-new "$experiment" "$experiment/$job-previous-captures.json"
fi
