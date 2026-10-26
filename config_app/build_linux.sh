#!/bin/sh
set -eu

cd "$(dirname "$0")"

for tool in flutter cmake ninja pkg-config clang++; do
  if ! command -v "$tool" >/dev/null 2>&1; then
    echo "Missing build tool: $tool" >&2
    echo "See README.md for Linux build prerequisites." >&2
    exit 1
  fi
done

if ! pkg-config --exists gtk+-3.0 glib-2.0 gio-2.0; then
  echo "GTK 3 development libraries are missing or pkg-config is misconfigured." >&2
  echo "Debian/Ubuntu: sudo apt-get install clang lld cmake ninja-build pkg-config libgtk-3-dev liblzma-dev" >&2
  echo "For a cross-build, check PKG_CONFIG_LIBDIR and PKG_CONFIG_SYSROOT_DIR." >&2
  exit 1
fi

if ! pkg-config --exists mpv epoxy; then
  echo "Linux video development libraries are missing (mpv/epoxy)." >&2
  echo "Debian/Ubuntu: sudo apt-get install libmpv-dev libepoxy-dev" >&2
  exit 1
fi

# Only discard the native CMake cache; keep Dart assets and downloaded packages.
# It can contain include paths that no longer exist after a system upgrade.
if [ -d build/linux ]; then
  find build/linux -type f -name CMakeCache.txt -exec rm -f {} +
  find build/linux -type d -name CMakeFiles -prune -exec rm -rf {} +
fi

flutter pub get
flutter build linux "$@"

