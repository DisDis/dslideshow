#!/bin/sh
set -eu

if [ "${1:-}" = --no-pub ]; then
  shift
else
  flutter pub get
fi
#--pwa-strategy none
flutter build web --release --no-pub --no-web-resources-cdn "$@"
#--dart-define=FLUTTER_WEB_CANVASKIT_URL=/canvaskit/
#flutter build web --release --web-renderer html
