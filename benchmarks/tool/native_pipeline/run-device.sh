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
python3 - "$experiment/$job-inputs.json" "$mode" "$runtime" "$bundle" "$config" "$tool_dir" "$benchmark_root" <<'PY'
import hashlib, json, os, pathlib, sys
output, mode, runtime, bundle, config, tools, benchmark = sys.argv[1:]
paths = [runtime, f'{bundle}/app.so', f'{bundle}/libflutter_engine.so', config,
         f'{benchmark}/run-managed.sh', f'{benchmark}/run.sh']
if mode == 'diagnostic':
    paths += [str(path) for path in pathlib.Path(tools).glob('*') if path.is_file() and path.suffix in {'.py', '.sh', '.so', '.c'}]
hashes = {path: hashlib.sha256(pathlib.Path(path).read_bytes()).hexdigest() for path in paths}
if hashes[runtime] != os.environ['BENCH_NATIVE_PIPELINE_RUNTIME_SHA256']:
    raise ValueError('Actual runtime differs from pinned runtime')
if hashes[f'{bundle}/libflutter_engine.so'] != os.environ['BENCH_NATIVE_PIPELINE_ENGINE_SHA256']:
    raise ValueError('Actual engine differs from pinned engine')
with open(output, 'x') as stream:
    json.dump({'schema_version': 1, 'mode': mode, 'timing_results_valid': mode == 'control',
               'sha256': hashes}, stream, indent=2)
    stream.write('\n')
PY
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
      sudo -n python3 "$tool_dir/trace_instance.py" stop "$trace_name" "$trace_output" || result=2
    fi
    sudo -n python3 "$tool_dir/trace_instance.py" close "$trace_name" "$trace_output" || result=2
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
  sudo -n python3 "$tool_dir/trace_instance.py" init "$trace_name" "$trace_output"
  trace_owned=1
  sudo -n python3 "$tool_dir/trace_instance.py" start "$trace_name" "$trace_output"
  trace_started=1
  launcher="$tool_dir/runtime-wrapper.sh"
  python3 - "$experiment" "$experiment/$job-previous-captures.json" <<'PY'
import json, pathlib, sys
experiment, output = map(pathlib.Path, sys.argv[1:])
with output.open('x') as stream:
    json.dump([str(path.resolve()) for path in (experiment/'reports').glob('*/opengl/attempt-*/native-pipeline.bin')], stream)
PY
fi
args+=(--flutter-pi "$launcher")
"$benchmark_root/run-managed.sh" "$job" "${args[@]}"
if [[ "$mode" == diagnostic ]]; then
  python3 - "$experiment" "$experiment/$job-previous-captures.json" "$tool_dir/finalize_capture.py" <<'PY'
import json, pathlib, subprocess, sys
experiment, previous, finalizer = map(pathlib.Path, sys.argv[1:])
old = set(json.loads(previous.read_text()))
new = [path for path in (experiment/'reports').glob('*/opengl/attempt-*/native-pipeline.bin') if str(path.resolve()) not in old]
if len(new) != 1:
    raise ValueError(f'Expected exactly one new native capture, got {len(new)}; preserve all attempts for diagnosis')
subprocess.run([sys.executable, str(finalizer), str(new[0].parent)], check=True)
PY
fi
