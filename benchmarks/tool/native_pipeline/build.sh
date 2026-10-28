#!/usr/bin/env bash
set -euo pipefail
script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
output=${1:-$script_dir/../../build/native_pipeline/libnative_pipeline.so}
command -v "${CC:-cc}" >/dev/null
command -v pkg-config >/dev/null
mkdir -p -- "$(dirname -- "$output")"
read -r -a flags <<< "$(pkg-config --cflags egl gbm libdrm)"
"${CC:-cc}" -std=c11 -O2 -Wall -Wextra -Werror -fPIC -shared \
  -Wl,-z,defs "$script_dir/pipeline_probe.c" -o "$output" \
  "${flags[@]}" -ldl
sha256sum -- "$output"
