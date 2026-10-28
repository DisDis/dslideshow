#!/bin/sh
set -eu

REPO_DIR=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)

for PACKAGE in common rpc_serializers_generator backend autover autover/example; do
  echo "--- Analyze '$PACKAGE' ---"
  (
    cd "$REPO_DIR/$PACKAGE"
    # Dart keeps infos non-fatal unless --fatal-infos is explicitly enabled.
    dart analyze --fatal-warnings
  )
done

for PACKAGE in i18n system_metrics_widget dslideshow_flutter config_app benchmarks; do
  echo "--- Analyze '$PACKAGE' ---"
  (
    cd "$REPO_DIR/$PACKAGE"
    flutter analyze --no-pub --fatal-warnings --no-fatal-infos
  )
done
