#!/bin/sh
set -eu

REPO_DIR=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)

for PACKAGE in common backend; do
  echo "--- Test '$PACKAGE' ---"
  (
    cd "$REPO_DIR/$PACKAGE"
    if [ "$PACKAGE" = backend ]; then
      # Backend suites share loopback ports; run files sequentially.
      dart test --concurrency=1
    else
      dart test
    fi
  )
done

for PACKAGE in i18n system_metrics_widget dslideshow_flutter config_app; do
  echo "--- Test '$PACKAGE' ---"
  (
    cd "$REPO_DIR/$PACKAGE"
    flutter test --no-pub
  )
done

for TEST_DIR in dslideshow_flutter/tool deb_factory; do
  echo "--- Test '$TEST_DIR' tools ---"
  python3 -m unittest discover -s "$REPO_DIR/$TEST_DIR" -p 'test_*.py' -v
done
