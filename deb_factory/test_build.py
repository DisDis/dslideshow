"""Exercise the DEB packaging step with small, already-built fixture assets."""

import hashlib
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest


FACTORY = Path(__file__).resolve().parent


@unittest.skipUnless(
    shutil.which("md5deep") and shutil.which("dpkg-deb"),
    "md5deep and dpkg-deb are required",
)
class DebBuildTest(unittest.TestCase):
    def test_package_checksums_are_relative_and_match_extracted_assets(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            factory = root / "deb_factory"
            shutil.copytree(FACTORY / "template_build_arm64", factory / "template_build_arm64")
            shutil.copy2(FACTORY / "build.sh", factory / "build.sh")
            runtime = factory / "source_arm64/flutter-pi/flutter-pi"
            runtime.parent.mkdir(parents=True)
            runtime.write_bytes(b"fixture native runtime\n")

            def script(relative_path, content):
                path = root / relative_path
                path.parent.mkdir(parents=True, exist_ok=True)
                path.write_text("#!/bin/sh\nset -eu\n" + content)
                path.chmod(0o755)

            script("deb_factory/run_tests.sh", "touch tests-passed\n")
            # Tests and compilation/version generation are stubbed. The production
            # copy, checksum and dpkg-deb steps run unchanged.
            script(
                "bin/dart",
                "test -f ../deb_factory/tests-passed\n"
                "sed 's/_FRONT_/1.0.0+1/g; s/_BACK_/1.0.0+1/g' "
                "../deb_factory/dslideshow_arm64/DEBIAN/control.template "
                "> ../deb_factory/dslideshow_arm64/DEBIAN/control\n"
                "printf '1.0.0+1\\n' > ../deb_factory/dslideshow_arm64/opt/dslideshow/version\n",
            )
            script(
                "dslideshow_flutter/build_aot_pi4.sh",
                "mkdir -p build/flutter-pi/pi4-64\n"
                "printf 'fixture AOT\\n' > build/flutter-pi/pi4-64/app.so\n"
                "printf 'fixture asset\\n' > 'build/flutter-pi/pi4-64/test asset.txt'\n",
            )
            script(
                "config_app/build_web.sh",
                "mkdir -p build/web\n"
                "printf '<html>fixture</html>\\n' > build/web/index.html\n",
            )
            env = dict(os.environ, PATH=f"{root / 'bin'}{os.pathsep}{os.environ['PATH']}")
            subprocess.run(
                ["./build.sh"], cwd=factory, env=env, check=True, capture_output=True
            )
            package = factory / "dslideshow-1.0.0+1-arm64-pi4.deb"
            extracted = root / "extracted"
            subprocess.run(
                ["dpkg-deb", "--raw-extract", str(package), str(extracted)],
                check=True, capture_output=True,
            )
            manifest = (extracted / "DEBIAN/md5sums").read_text().splitlines()
            names = set()
            for line in manifest:
                digest, name = line.split(maxsplit=1)
                path = Path(name)
                self.assertFalse(path.is_absolute(), name)
                self.assertNotIn("..", path.parts, name)
                self.assertEqual(path.parts[0], "opt", name)
                self.assertNotIn(name, names)
                names.add(name)
                self.assertEqual(
                    hashlib.md5((extracted / path).read_bytes()).hexdigest(), digest, name
                )
            self.assertEqual(
                names,
                {str(path.relative_to(extracted)) for path in (extracted / "opt").rglob("*") if path.is_file()},
            )
            self.assertEqual(
                (extracted / "opt/dslideshow/flutter-pi").read_bytes(), runtime.read_bytes()
            )
            self.assertEqual((extracted / "opt/dslideshow/version").read_text(), "1.0.0+1\n")


class DebPreflightTest(unittest.TestCase):
    def test_failed_tests_preserve_versions_and_staging_without_starting_build(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            factory = root / "deb_factory"
            staging = factory / "dslideshow_arm64"
            staging.mkdir(parents=True)
            sentinel = staging / "previous-build"
            sentinel.write_text("keep me\n")
            shutil.copy2(FACTORY / "build.sh", factory / "build.sh")
            runner = factory / "run_tests.sh"
            runner.write_text("#!/bin/sh\nexit 7\n")
            runner.chmod(0o755)
            versions = []
            for package in ("backend", "dslideshow_flutter"):
                version = root / package / "pubspec.yaml"
                version.parent.mkdir()
                version.write_text("version: 1.0.0+3\n")
                versions.append(version)
            forbidden = root / "build-started"
            binary_dir = root / "bin"
            binary_dir.mkdir()
            for command in ("dart", "flutter", "dpkg-deb"):
                executable = binary_dir / command
                executable.write_text(f'#!/bin/sh\ntouch "{forbidden}"\nexit 99\n')
                executable.chmod(0o755)
            env = dict(os.environ, PATH=f"{binary_dir}{os.pathsep}{os.environ['PATH']}")
            # Also verify that build.sh can be invoked outside deb_factory.
            result = subprocess.run(
                [str(factory / "build.sh")], cwd=root, env=env, capture_output=True,
                text=True,
            )
            self.assertNotEqual(result.returncode, 0)
            self.assertIn("pre-build tests", result.stderr)
            self.assertEqual(sentinel.read_text(), "keep me\n")
            for version in versions:
                self.assertEqual(version.read_text(), "version: 1.0.0+3\n")
            self.assertFalse(forbidden.exists())
            self.assertEqual(list(factory.glob("*.deb")), [])


if __name__ == "__main__":
    unittest.main()
