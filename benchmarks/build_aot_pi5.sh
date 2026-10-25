#!/usr/bin/env bash
set -euo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")"

cpu=${BENCHMARK_CPU:-pi5}
mode=${BENCHMARK_BUILD_MODE:-release}
case "$cpu" in pi4|pi5) ;; *) echo 'BENCHMARK_CPU must be pi4 or pi5' >&2; exit 2;; esac
case "$mode" in release|profile) ;; *) echo 'BENCHMARK_BUILD_MODE must be release or profile' >&2; exit 2;; esac
command -v flutter >/dev/null
command -v flutterpi_tool >/dev/null
flutter pub get
python3 tool/build_info.py "$cpu" "$mode"
flutterpi_tool build --arch=arm64 --cpu="$cpu" --"$mode" --target=lib/main.dart "$@"

bundle="$PWD/build/flutter-pi/$cpu-64"
test -f "$bundle/app.so"
mkdir -p build/package
package=$(mktemp -d "$PWD/build/package/benchmarks-$cpu-$mode-XXXXXXXX")
mkdir -p "$package/bundle" "$package/tool"
cp -a "$bundle/." "$package/bundle/"
cp run.sh README.md "$package/"
cp -a config "$package/"
cp tool/collect_reports.py tool/resume_plan.py "$package/tool/"
cp assets/build-info.json "$package/build-info.json"
archive="$PWD/build/$(basename "$package").tar.gz"
tar -czf "$archive" -C "$package" .
echo "SSH package: $archive"
