#!/usr/bin/env bash
# Run unattended on the device. No service, display configuration or OS settings are changed.
set -euo pipefail
ulimit -c 0
app_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
source "$app_dir/tool/cli.sh"
suite=${BENCHMARK_SUITE:-}
renderers=${BENCHMARK_RENDERERS:-opengl}
bundle=${BENCHMARK_BUNDLE:-$app_dir/bundle}
runtime=${FLUTTER_PI:-/opt/dslideshow/flutter-pi}
output=${BENCHMARK_REPORT_ROOT:-$app_dir/reports}
config=${BENCHMARK_CONFIG:-}
timeout_s=${BENCHMARK_TIMEOUT_SECONDS:-172800}
video_mode=${BENCHMARK_VIDEO_MODE:-2560x1600}
vulkan_video=${BENCHMARK_VULKAN_VIDEO:-}
extra=()
while (($#)); do
  case "$1" in
    --suite) suite=$2; shift 2;;
    --renderers) renderers=$2; shift 2;;
    --bundle) bundle=$2; shift 2;;
    --flutter-pi) runtime=$2; shift 2;;
    --output) output=$2; shift 2;;
    --config) config=$2; shift 2;;
    --timeout) timeout_s=$2; shift 2;;
    --vulkan-video) vulkan_video=true; shift;;
    --no-vulkan-video) vulkan_video=false; shift;;
    --) shift; extra=("$@"); break;;
    -h|--help) echo 'run.sh [--suite smoke|standard|soak] [--renderers opengl|vulkan|both (default: opengl)] [--vulkan-video|--no-vulkan-video] [--bundle DIR] [--flutter-pi FILE] [--output DIR] [--config JSON] [--timeout SECONDS] [-- ENGINE_ARGS]'; exit 0;;
    *) echo "Unknown argument: $1" >&2; exit 2;;
  esac
done
if [[ -z "$suite" ]]; then
  if [[ -n "$config" ]]; then
    suite=$(benchmark_tool json-field "$config" suite standard)
  else
    suite=standard
  fi
fi
case "$suite" in smoke|standard|soak) ;; *) echo 'Invalid suite' >&2; exit 2;; esac
case "$renderers" in both) renderer_list=(opengl vulkan);; opengl|vulkan) renderer_list=("$renderers");; *) echo 'Invalid renderers' >&2; exit 2;; esac
[[ "$timeout_s" =~ ^[1-9][0-9]*$ ]] || { echo 'timeout must be a positive integer' >&2; exit 2; }
case "$vulkan_video" in '') unset BENCHMARK_VULKAN_VIDEO;; true|false) export BENCHMARK_VULKAN_VIDEO="$vulkan_video";; *) echo 'BENCHMARK_VULKAN_VIDEO must be true or false' >&2; exit 2;; esac
for dependency in timeout flock tar tee sha256sum; do command -v "$dependency" >/dev/null; done
if [[ ! -d "$bundle" && -d "$app_dir/build/flutter-pi/pi5-64" ]]; then bundle="$app_dir/build/flutter-pi/pi5-64"; fi
bundle=$(realpath "$bundle")
runtime=$(realpath "$runtime")
[[ -x "$runtime" && -f "$bundle/app.so" ]] || { echo 'Missing flutter-pi executable or AOT bundle' >&2; exit 2; }
[[ -z "$config" ]] || config=$(realpath "$config")
mkdir -p "$output"
output=$(realpath "$output")
exec 9>"${XDG_RUNTIME_DIR:-/tmp}/dslideshow-benchmarks.lock"
flock -n 9 || { echo 'Another benchmark launcher is active' >&2; exit 2; }
collection=$(mktemp -d "$output/$(date -u +%Y%m%dT%H%M%SZ)-$suite-XXXXXXXX")
mode=release
if [[ -f "$bundle/assets/build-info.json" ]]; then
  mode=$(benchmark_tool json-field "$bundle/assets/build-info.json" mode release)
elif [[ -f "$app_dir/build-info.json" ]]; then
  mode=$(benchmark_tool json-field "$app_dir/build-info.json" mode release)
elif [[ -f "$app_dir/assets/build-info.json" ]]; then
  mode=$(benchmark_tool json-field "$app_dir/assets/build-info.json" mode release)
fi
case "$mode" in release|profile) ;; *) echo 'Invalid build mode' >&2; exit 2;; esac
export DSLIDESHOW_EMBEDDED=true
export LD_LIBRARY_PATH="$bundle:$bundle/lib:$(dirname "$runtime")${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
export BENCHMARK_SUITE="$suite"
export BENCHMARK_CONFIG="$config"
export BENCHMARK_MEDIA_DIR=${BENCHMARK_MEDIA_DIR:-}
export BENCHMARK_OUTPUT
export BENCHMARK_RENDERER
export BENCHMARK_SKIP_FILE
child=''
interrupted=0
finished=0
collection_result=0
finish() {
  ((finished)) && return
  finished=1
  benchmark_tool collect-reports "$collection" --fail-on-errors || collection_result=$?
  tar -czf "$collection.tar.gz" -C "$output" "$(basename "$collection")"
  echo "BENCHMARK_ARCHIVE=$collection.tar.gz"
}
stop() {
  interrupted=1
  if [[ -n "$child" ]]; then kill -TERM "$child" 2>/dev/null || true; fi
}
trap stop INT TERM
trap finish EXIT
result=0
for renderer in "${renderer_list[@]}"; do
  ((interrupted)) && break
  BENCHMARK_RENDERER=$renderer
  renderer_dir="$collection/$renderer"
  mkdir -p "$renderer_dir"
  BENCHMARK_SKIP_FILE="$renderer_dir/skip.json"
  printf '[]\n' > "$BENCHMARK_SKIP_FILE"
  attempt=0
  renderer_deadline=$((SECONDS + timeout_s))
  while ((interrupted == 0)); do
  remaining_budget=$((renderer_deadline - SECONDS))
  ((remaining_budget > 0)) || break
  attempt=$((attempt + 1))
  printf -v attempt_name 'attempt-%03d' "$attempt"
  BENCHMARK_OUTPUT="$renderer_dir/$attempt_name"
  mkdir -p "$BENCHMARK_OUTPUT"
  args=("$runtime" "--$mode")
  [[ "$renderer" != vulkan ]] || args+=(--vulkan)
  [[ "$video_mode" == none ]] || args+=(--videomode "$video_mode")
  args+=("$bundle" "${extra[@]}")
  benchmark_tool launch-argv "$BENCHMARK_OUTPUT/launch.json" "$renderer" "${args[@]}"
  timeout --kill-after=2s 5s "$runtime" --help > "$BENCHMARK_OUTPUT/flutter-pi-help.txt" 2>&1 || true
  # timeout forwards TERM and kills a stuck engine after the grace period.
  # Native logs are preserved even if Dart cannot start or the GPU process aborts.
  timeout --signal=TERM --kill-after=30s "$remaining_budget" "${args[@]}" > >(tee "$BENCHMARK_OUTPUT/native.log") 2>&1 &
  child=$!
  code=0
  wait "$child" || code=$?
  if ((interrupted)); then
    # Reap the timeout/runtime before collecting or restoring the GPU service.
    while kill -0 "$child" 2>/dev/null; do wait "$child" 2>/dev/null || true; done
    code=130
  fi
  child=''
  benchmark_tool status "$BENCHMARK_OUTPUT/launcher-status.json" "$code"
  ((code == 0)) || result=2
  decision=$(benchmark_tool resume-plan "$renderer_dir" "$BENCHMARK_OUTPUT" "$code")
  [[ "$decision" == resume && "$suite" != soak ]] || break
  echo "BENCHMARK_RESUME renderer=$renderer after=$attempt_name"
  done
done
finish
((collection_result == 0)) || result=2
((interrupted == 0)) || result=130
exit "$result"
