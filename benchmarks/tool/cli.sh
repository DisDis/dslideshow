#!/usr/bin/env bash
# Shared host/bundle routing. A device bundle contains its own ARM64 executable.
benchmark_tools() {
  local selected=${BENCHMARK_TOOLS_EXECUTABLE:-$app_dir/tools/dslideshow_tools}
  if [[ -x "$selected" ]]; then
    "$selected" "$@"
  elif [[ -f "$app_dir/../tools/bin/dslideshow_tools.dart" ]]; then
    local dart=${DART_EXECUTABLE:-$(command -v dart)}
    "$dart" --suppress-analytics run "$app_dir/../tools/bin/dslideshow_tools.dart" "$@"
  else
    echo 'Missing benchmark Dart executable; rebuild the benchmark bundle' >&2
    return 2
  fi
}
benchmark_tool() { benchmark_tools benchmark "$@"; }
