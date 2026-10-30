#!/usr/bin/env bash
# A separate AOT target that mounts the production SlideShowPage.
set -euo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")"
app_dir=$PWD
source "$app_dir/tool/cli.sh"
lock_backup=$(mktemp)
cp pubspec.lock "$lock_backup"
restore_lock() { cp "$lock_backup" pubspec.lock; rm -f "$lock_backup"; }
trap restore_lock EXIT
flutter pub get --offline
helper_payload="$PWD/build/benchmark-tools-arm64"
bash tool/build_tools.sh "$helper_payload"
benchmark_tool build-info pi5 release
flutterpi_tool build --arch=arm64 --cpu=pi5 --release --target=lib/renderer_main.dart
package=$(mktemp -d "$PWD/build/renderer-pi5-release-XXXXXXXX")
mkdir -p "$package/bundle" "$package/tool"
cp -a build/flutter-pi/pi5-64/. "$package/bundle/"
cp run_renderer.sh "$package/run.sh"
cp -a "$helper_payload/tools" "$package/"
cp tool/cli.sh "$package/tool/cli.sh"
cp assets/build-info.json "$package/build-info.json"
sha256sum "$package/bundle/app.so" > "$package/app-so.sha256"
tar -czf "$package.tar.gz" -C "$package" .
echo "RENDERER_PACKAGE=$package"
echo "RENDERER_ARCHIVE=$package.tar.gz"
