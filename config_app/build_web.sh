#!/bin/sh
flutter pub get
#--pwa-strategy none
flutter build web --release --no-web-resources-cdn
#--dart-define=FLUTTER_WEB_CANVASKIT_URL=/canvaskit/
#flutter build web --release --web-renderer html