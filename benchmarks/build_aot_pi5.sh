#!/usr/bin/env bash
set -euo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")"
app_dir=$PWD
source "$app_dir/tool/cli.sh"

cpu=${BENCHMARK_CPU:-pi5}
mode=${BENCHMARK_BUILD_MODE:-release}
case "$cpu" in pi4|pi5) ;; *) echo 'BENCHMARK_CPU must be pi4 or pi5' >&2; exit 2;; esac
case "$mode" in release|profile) ;; *) echo 'BENCHMARK_BUILD_MODE must be release or profile' >&2; exit 2;; esac
command -v flutter >/dev/null
command -v flutterpi_tool >/dev/null
flutter pub get
helper_payload="$PWD/build/benchmark-tools-arm64"
bash tool/build_tools.sh "$helper_payload"
benchmark_tool build-info "$cpu" "$mode"
flutterpi_tool build --arch=arm64 --cpu="$cpu" --"$mode" --target=lib/main.dart "$@"

bundle="$PWD/build/flutter-pi/$cpu-64"
test -f "$bundle/app.so"
mkdir -p build/package
package=$(mktemp -d "$PWD/build/package/benchmarks-$cpu-$mode-XXXXXXXX")
mkdir -p "$package/bundle" "$package/tool" "$package/tool"
cp -a "$bundle/." "$package/bundle/"
cp run.sh README.md "$package/"
cp -a config "$package/"
cp -a "$helper_payload/tools" "$package/"
cp tool/cli.sh "$package/tool/cli.sh"
cp assets/build-info.json "$package/build-info.json"
archive="$PWD/build/$(basename "$package").tar.gz"
tar -czf "$archive" -C "$package" .
echo "SSH package: $archive"
