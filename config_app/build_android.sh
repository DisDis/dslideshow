#!/bin/sh
set -eu
cd "$(dirname "$0")/../tools"
exec dart run bin/dslideshow_tools.dart build-android "$@"
