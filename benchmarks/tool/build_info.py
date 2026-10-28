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


def source_fingerprint(root: Path, app: Path) -> str:
    """Hash build inputs, excluding generated build-info and build outputs."""
    source = hashlib.sha256()
    for folder in [app / "lib", app / "shaders", root / "dslideshow_flutter/lib",
                   root / "backend/lib", root / "common/lib"]:
        for file in sorted(f for f in folder.rglob("*") if f.is_file()):
            source.update(str(file.relative_to(root)).encode())
            source.update(file.read_bytes())
    for file in [app / "pubspec.lock", app / "pubspec.yaml", app / "assets/media/manifest.json",
                 root / "dslideshow_flutter/pubspec.yaml", *sorted((app / "tool").glob("*.py")),
                 *sorted(app.glob("*.sh")), *sorted((app / "config").glob("*.json"))]:
        source.update(file.read_bytes())
    return source.hexdigest()


def main():
    result = dict(application="benchmarks", built_utc=datetime.now(timezone.utc).isoformat(),
                  cpu=sys.argv[1], mode=sys.argv[2], source_sha256=source_fingerprint(ROOT, APP),
                  git_commit=output("git", "rev-parse", "HEAD"),
                  git_status=output("git", "status", "--porcelain", "--untracked-files=normal"),
                  flutter=json.loads(output("flutter", "--version", "--machine")))
    (APP / "assets/build-info.json").write_text(json.dumps(result, indent=2) + "\n")


if __name__ == "__main__":
    main()
