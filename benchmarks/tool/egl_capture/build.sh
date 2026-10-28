#!/usr/bin/env bash
set -euo pipefail
script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
output=${1:-$script_dir/../../build/egl_capture/libegl_capture.so}
command -v gcc >/dev/null
command -v pkg-config >/dev/null
mkdir -p -- "$(dirname -- "$output")"
read -r -a flags <<< "$(pkg-config --cflags --libs egl glesv2)"
gcc -std=c11 -O2 -Wall -Wextra -Werror -fPIC -shared \
  -Wl,-z,defs "$script_dir/egl_capture.c" -o "$output" \
  "${flags[@]}" -ldl -pthread
sha256sum -- "$output"
