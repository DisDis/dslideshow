#!/usr/bin/env python3
"""Write build provenance before the Flutter asset bundle is compiled."""
import hashlib
import json
from pathlib import Path
import subprocess
import sys
from datetime import datetime, timezone

APP = Path(__file__).resolve().parents[1]
ROOT = APP.parent


def output(*args):
    result = subprocess.run(args, cwd=ROOT, text=True, capture_output=True, check=True)
    return result.stdout.strip()


def main():
    source = hashlib.sha256()
    for folder in [APP / "lib", ROOT / "dslideshow_flutter/lib", ROOT / "backend/lib", ROOT / "common/lib"]:
        for file in sorted(f for f in folder.rglob("*") if f.is_file()):
            source.update(str(file.relative_to(ROOT)).encode())
            source.update(file.read_bytes())
    for file in [APP / "pubspec.lock", APP / "pubspec.yaml", APP / "assets/media/manifest.json",
                 ROOT / "dslideshow_flutter/pubspec.yaml", *sorted((APP / "tool").glob("*.py")),
                 *sorted(APP.glob("*.sh")), *sorted((APP / "config").glob("*.json"))]:
        source.update(file.read_bytes())
    result = dict(application="benchmarks", built_utc=datetime.now(timezone.utc).isoformat(),
                  cpu=sys.argv[1], mode=sys.argv[2], source_sha256=source.hexdigest(),
                  git_commit=output("git", "rev-parse", "HEAD"),
                  git_status=output("git", "status", "--porcelain", "--untracked-files=normal"),
                  flutter=json.loads(output("flutter", "--version", "--machine")))
    (APP / "assets/build-info.json").write_text(json.dumps(result, indent=2) + "\n")


if __name__ == "__main__":
    main()
