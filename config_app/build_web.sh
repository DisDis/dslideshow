#!/bin/sh
set -eu

if [ "${1:-}" = --no-pub ]; then
  shift
else
  flutter pub get
fi
flutter build web --release --no-pub --no-web-resources-cdn --wasm "$@"
