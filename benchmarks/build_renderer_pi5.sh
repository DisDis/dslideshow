#!/usr/bin/env bash
# A separate AOT target that mounts the production SlideShowPage.
set -euo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")"
lock_backup=$(mktemp)
cp pubspec.lock "$lock_backup"
restore_lock() { cp "$lock_backup" pubspec.lock; rm -f "$lock_backup"; }
trap restore_lock EXIT
flutter pub get --offline
python3 tool/build_info.py pi5 release
flutterpi_tool build --arch=arm64 --cpu=pi5 --release --target=lib/renderer_main.dart
package=$(mktemp -d "$PWD/build/renderer-pi5-release-XXXXXXXX")
mkdir -p "$package/bundle"
cp -a build/flutter-pi/pi5-64/. "$package/bundle/"
cp run_renderer.sh "$package/run.sh"
cp assets/build-info.json "$package/build-info.json"
sha256sum "$package/bundle/app.so" > "$package/app-so.sha256"
tar -czf "$package.tar.gz" -C "$package" .
echo "RENDERER_PACKAGE=$package"
echo "RENDERER_ARCHIVE=$package.tar.gz"
