#!/bin/sh
flutter pub get
#--pwa-strategy none
flutter build web --release --dart-define=FLUTTER_WEB_CANVASKIT_URL=/canvaskit/