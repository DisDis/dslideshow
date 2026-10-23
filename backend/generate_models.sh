#!/bin/bash
set -eu
cd "$(dirname "$0")"
dart run build_runner watch "$@"
