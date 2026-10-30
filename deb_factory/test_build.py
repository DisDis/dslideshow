"""Exercise parallel release work and DEB packaging with small fixture assets."""

from contextlib import contextmanager
import hashlib
import os
from pathlib import Path
import shutil
import signal
import socket
import subprocess
import sys
import tempfile
import unittest


FACTORY = Path(__file__).resolve().parent


def write_script(root, relative_path, content, interpreter="/bin/sh"):
    path = root / relative_path
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(f"#!{interpreter}\n" + content)
    path.chmod(0o755)


@contextmanager
def build_fixture():
    with tempfile.TemporaryDirectory() as directory:
        root = Path(directory)
        factory = root / "deb_factory"
        shutil.copytree(FACTORY / "template_build_arm64", factory / "template_build_arm64")
        for name in ("build.sh", "run_parallel.py"):
            shutil.copy2(FACTORY / name, factory / name)
        runtime = factory / "source_arm64/flutter-pi/flutter-pi"
        runtime.parent.mkdir(parents=True)
        runtime.write_bytes(b"fixture native runtime\n")
        for package in ("backend", "dslideshow_flutter"):
            pubspec = root / package / "pubspec.yaml"
            pubspec.parent.mkdir(exist_ok=True)
            pubspec.write_text("version: 1.0.0\n")
        # Only version generation, tests and compilation are stubbed. The actual
        # supervisor, file copying, checksums and dpkg-deb run unchanged.
        write_script(root, "bin/dart", """set -eu
if [ "${BUILD_TEST_VERSION_FAIL:-}" = 1 ]; then exit 7; fi
sed 's/_FRONT_/1.0.0+1/g; s/_BACK_/1.0.0+1/g' \
  ../deb_factory/dslideshow_arm64/DEBIAN/control.template \
  > ../deb_factory/dslideshow_arm64/DEBIAN/control
printf '1.0.0+1\\n' > ../deb_factory/dslideshow_arm64/opt/dslideshow/version
printf 'version: 1.0.0+1\\n' > pubspec.yaml
printf 'version: 1.0.0+1\\n' > ../backend/pubspec.yaml
touch ../deb_factory/version-generated
""")

        def worker(relative_path, label, body):
            bootstrap = f"""import os, pathlib, signal, socket, subprocess, sys
root = pathlib.Path(os.environ['BUILD_TEST_ROOT'])
assert (root / 'deb_factory/version-generated').is_file()
label = {label!r}
if os.environ.get('BUILD_TEST_CHILD') == label:
    child_code = \"import os, signal, socket; signal.signal(signal.SIGTERM, signal.SIG_IGN); s = socket.socket(socket.AF_UNIX); s.connect(os.environ['BUILD_TEST_SOCKET']); s.sendall(b'{label}.child'); s.recv(1)\"
    subprocess.Popen([sys.executable, '-c', child_code])
connection = socket.socket(socket.AF_UNIX)
connection.connect(os.environ['BUILD_TEST_SOCKET'])
connection.sendall(label.encode())
action = connection.recv(1)
if action == b'F': sys.exit(7)
if action != b'P': sys.exit(99)
"""
            write_script(root, relative_path, bootstrap + body, sys.executable)

        worker("deb_factory/run_tests.sh", "checks", "(root / 'checks-passed').touch()\n")
        worker("dslideshow_flutter/build_aot_pi4.sh", "aot", """out = root / 'dslideshow_flutter/build/flutter-pi/pi4-64'
out.mkdir(parents=True)
(out / 'app.so').write_bytes(b'fixture AOT\\n')
(out / 'test asset.txt').write_bytes(b'fixture asset\\n')
""")
        worker("config_app/build_web.sh", "web", """assert sys.argv[1:] == ['--no-pub']
out = root / 'config_app/build/web'
out.mkdir(parents=True)
(out / 'index.html').write_text('<html>fixture</html>\\n')
""")
        env = dict(os.environ, PATH=f"{root / 'bin'}{os.pathsep}{os.environ['PATH']}",
                   BUILD_TEST_ROOT=str(root))
        yield root, env


@contextmanager
def controlled_build(root, env, child=None):
    with socket.socket(socket.AF_UNIX) as server:
        address = str(root / "control.sock")
        server.bind(address)
        server.listen(4)
        server.settimeout(10)
        env = dict(env, BUILD_TEST_SOCKET=address, BUILD_TEST_CHILD=child or "")
        process = subprocess.Popen(
            [str(root / "deb_factory/build.sh")], cwd=root, env=env,
            stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True,
        )
        connections = {}
        try:
            # Each worker blocks on its own socket. Seeing all three starts
            # before releasing any proves that compilation overlaps the tests.
            for _ in range(4 if child else 3):
                connection, _ = server.accept()
                connection.settimeout(10)
                label = connection.recv(64).decode()
                connections[label] = connection
            yield process, connections
        finally:
            if process.poll() is None:
                process.terminate()
            try:
                process.communicate(timeout=10)
            except subprocess.TimeoutExpired:
                process.kill()
                process.communicate(timeout=10)
            for connection in connections.values():
                connection.close()


@unittest.skipUnless(
    shutil.which("md5deep") and shutil.which("dpkg-deb"),
    "md5deep and dpkg-deb are required",
)
class DebBuildTest(unittest.TestCase):
    def test_parallel_work_finishes_before_packaging_valid_assets(self):
        with build_fixture() as (root, env):
            factory = root / "deb_factory"
            runtime = factory / "source_arm64/flutter-pi/flutter-pi"
            with controlled_build(root, env) as (process, connections):
                self.assertEqual(set(connections), {"checks", "aot", "web"})
                for label in ("aot", "web"):
                    connections[label].sendall(b"P")
                    self.assertEqual(connections[label].recv(1), b"")
                self.assertFalse(list(factory.glob("*.deb")))
                self.assertFalse((factory / "dslideshow_arm64/DEBIAN/md5sums").exists())
                connections["checks"].sendall(b"P")
                stdout, stderr = process.communicate(timeout=15)
                self.assertEqual(process.returncode, 0, stdout + stderr)
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
            control = (extracted / "DEBIAN/control").read_text().splitlines()
            dependencies = next(line.removeprefix('Depends:') for line in control if line.startswith('Depends:'))
            dependency_items = [item.strip() for item in dependencies.split(',')]
            self.assertIn('ffmpeg', dependency_items)
            self.assertIn('libjpeg-progs | libjpeg-turbo-progs', dependency_items)
            self.assertNotIn('libimage-exiftool-perl', dependency_items)
            for dependency in ('curl', 'ca-certificates', 'libc6 (>= 2.34)', 'libgcc-s1'):
                self.assertIn(dependency, dependency_items)
            self.assertNotIn('czkawka-cli', '\n'.join(control))
            for name in ('postinst', 'postrm'):
                script = extracted / 'DEBIAN' / name
                self.assertEqual(script.read_bytes(), (FACTORY / 'template_build_arm64/DEBIAN' / name).read_bytes())
                self.assertTrue(os.access(script, os.X_OK))
            installer = extracted / 'opt/dslideshow/scripts/install_czkawka.sh'
            self.assertTrue(os.access(installer, os.X_OK))
            # Download happens on the frame during configure, not during build.
            self.assertFalse((extracted / 'opt/dslideshow/bin/czkawka_cli').exists())


class DebParallelFailureTest(unittest.TestCase):
    def test_worker_failure_cancels_other_jobs_and_prevents_packaging(self):
        for failed in ("checks", "aot", "web"):
            with self.subTest(failed=failed), build_fixture() as (root, env):
                with controlled_build(root, env) as (process, connections):
                    connections[failed].sendall(b"F")
                    stdout, stderr = process.communicate(timeout=10)
                    self.assertNotEqual(process.returncode, 0)
                    self.assertIn("checks or application builds", stderr)
                    self.assertNotIn("Create DEB package", stdout)
                    for connection in connections.values():
                        self.assertEqual(connection.recv(1), b"")
                self.assertFalse(list((root / "deb_factory").glob("*.deb")))
                # The single version generation happens before all workers.
                for package in ("backend", "dslideshow_flutter"):
                    self.assertEqual((root / package / "pubspec.yaml").read_text(),
                                     "version: 1.0.0+1\n")

    def test_interrupt_reaps_workers_and_stubborn_descendants(self):
        for signum in (signal.SIGINT, signal.SIGTERM):
            with self.subTest(signal=signum), build_fixture() as (root, env):
                with controlled_build(root, env, child="aot") as (process, connections):
                    process.send_signal(signum)
                    stdout, stderr = process.communicate(timeout=10)
                    self.assertEqual(process.returncode, 128 + signum, stdout + stderr)
                    for connection in connections.values():
                        self.assertEqual(connection.recv(1), b"")
                    self.assertNotIn("Create DEB package", stdout)
                self.assertFalse(list((root / "deb_factory").glob("*.deb")))

    def test_version_failure_stops_before_workers(self):
        with build_fixture() as (root, env):
            result = subprocess.run(
                [str(root / "deb_factory/build.sh")], cwd=root,
                env=dict(env, BUILD_TEST_VERSION_FAIL="1"),
                capture_output=True, text=True, timeout=10,
            )
            self.assertNotEqual(result.returncode, 0)
            self.assertIn("version generation", result.stderr)
            self.assertNotIn("Start '", result.stdout)
            self.assertFalse(list((root / "deb_factory").glob("*.deb")))


if __name__ == "__main__":
    unittest.main()
