#!/usr/bin/env bash
# A separate release target for the real OTA page and simulated external streams.
set -euo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")"
lock_backup=$(mktemp)
info_backup=$(mktemp)
cp pubspec.lock "$lock_backup"
cp assets/build-info.json "$info_backup"
restore_lock() {
  cp "$lock_backup" pubspec.lock
  cp "$info_backup" assets/build-info.json
  rm -f "$lock_backup" "$info_backup"
}
trap restore_lock EXIT
flutter pub get --offline
python3 tool/build_info.py pi5 release
flutterpi_tool build --arch=arm64 --cpu=pi5 --release --target=lib/ota_main.dart
package=$(mktemp -d "$PWD/build/ota-pi5-release-XXXXXXXX")
mkdir -p "$package/bundle"
cp -a build/flutter-pi/pi5-64/. "$package/bundle/"
cp run_ota.sh "$package/run.sh"
cp assets/build-info.json "$package/build-info.json"
sha256sum "$package/bundle/app.so" > "$package/app-so.sha256"
tar -czf "$package.tar.gz" -C "$package" .
echo "OTA_PACKAGE=$package"
echo "OTA_ARCHIVE=$package.tar.gz"
