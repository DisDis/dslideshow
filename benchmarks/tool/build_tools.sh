#!/usr/bin/env bash
set -euo pipefail
root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../.." && pwd)
[[ $# == 1 ]] || { echo 'build_tools.sh PACKAGE_DIRECTORY' >&2; exit 64; }
package=$1
mkdir -p "$package/tools" "$package/tool"
package=$(cd -- "$package" && pwd)
dart=${DART_EXECUTABLE:-$(command -v dart)}
(cd "$root/tools" && "$dart" --suppress-analytics compile exe \
  --target-os=linux --target-arch=arm64 bin/dslideshow_tools.dart \
  -o "$package/tools/dslideshow_tools")
cp "$root/benchmarks/tool/cli.sh" "$package/tool/cli.sh"
(cd "$package" && sha256sum tools/dslideshow_tools > tools/dslideshow_tools.sha256)
