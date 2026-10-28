"""The renderer launcher preserves a native failure without retrying it."""
import hashlib
import json
import os
from pathlib import Path
import signal
import subprocess
import tarfile
import tempfile
import time
import unittest


SCRIPT = Path(__file__).resolve().parents[1] / 'run_renderer.sh'


class RendererLauncherTest(unittest.TestCase):
    def launch(self, code):
        temporary = tempfile.TemporaryDirectory()
        self.addCleanup(temporary.cleanup)
        root = Path(temporary.name)
        bundle = root / 'bundle'
        bundle.mkdir()
        (bundle / 'app.so').write_bytes(b'frozen renderer application')
        runtime = root / 'flutter-pi'
        calls = root / 'calls'
        runtime.write_text(
            '#!/bin/sh\n'
            f'echo invocation >> "{calls}"\n'
            'echo native-stdout\n'
            'echo native-fault-operation >&2\n'
            f'exit {code}\n'
        )
        runtime.chmod(0o755)
        output = root / 'results'
        result = subprocess.run(
            ['bash', str(SCRIPT)], text=True, capture_output=True,
            env={**os.environ, 'FLUTTER_PI': str(runtime),
                 'BENCHMARK_BUNDLE': str(bundle), 'BENCHMARK_OUTPUT': str(output),
                 'XDG_RUNTIME_DIR': str(root), 'BENCHMARK_TIMEOUT_SECONDS': '10'},
            timeout=20,
        )
        return root, output, runtime, calls, result

    def test_native_fault_is_archived_and_never_retried(self):
        root, output, runtime, calls, result = self.launch(139)
        self.assertEqual(139, result.returncode, result.stderr)
        self.assertEqual(['invocation'], calls.read_text().splitlines())
        self.assertEqual(139, json.loads((output / 'launcher-status.json').read_text())['exit_code'])
        log = (output / 'native.log').read_text()
        self.assertIn('native-stdout', log)
        self.assertIn('native-fault-operation', log)
        launch = json.loads((output / 'launch.json').read_text())
        self.assertEqual('opengl', launch['renderer'])
        self.assertEqual(hashlib.sha256(runtime.read_bytes()).hexdigest(), launch['runtime_sha256'])
        self.assertEqual(hashlib.sha256((root / 'bundle/app.so').read_bytes()).hexdigest(), launch['app_so_sha256'])
        with tarfile.open(f'{output}.tar.gz') as archive:
            self.assertIn('results/native.log', archive.getnames())
            self.assertIn('results/launcher-status.json', archive.getnames())

    def test_success_is_preserved(self):
        _, output, _, calls, result = self.launch(0)
        self.assertEqual(0, result.returncode, result.stderr)
        self.assertEqual(['invocation'], calls.read_text().splitlines())
        self.assertEqual(0, json.loads((output / 'launcher-status.json').read_text())['exit_code'])

    def test_nonempty_output_is_refused_before_invoking_runtime(self):
        root, output, runtime, calls, _ = self.launch(0)
        original = (output / 'launcher-status.json').read_bytes()
        result = subprocess.run(
            ['bash', str(SCRIPT)], text=True, capture_output=True,
            env={**os.environ, 'FLUTTER_PI': str(runtime),
                 'BENCHMARK_BUNDLE': str(root / 'bundle'),
                 'BENCHMARK_OUTPUT': str(output), 'XDG_RUNTIME_DIR': str(root)},
            timeout=10,
        )
        self.assertNotEqual(0, result.returncode)
        self.assertIn('Refusing nonempty benchmark output', result.stderr)
        self.assertEqual(['invocation'], calls.read_text().splitlines())
        self.assertEqual(original, (output / 'launcher-status.json').read_bytes())

    def test_signal_waits_for_runtime_teardown_before_archive(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            bundle = root / 'bundle'
            bundle.mkdir()
            (bundle / 'app.so').write_bytes(b'aot')
            runtime = root / 'flutter-pi'
            started, stopping, gate, exited = [root / name for name in
                                                ['started', 'stopping', 'gate', 'exited']]
            runtime.write_text(
                '#!/usr/bin/env python3\n'
                'import pathlib, signal, sys, time\n'
                f'started, stopping, gate, exited = map(pathlib.Path, {[str(p) for p in [started, stopping, gate, exited]]!r})\n'
                'def stop(*args):\n'
                '    signal.signal(signal.SIGTERM, signal.SIG_IGN)\n'
                '    stopping.touch()\n'
                '    deadline = time.monotonic() + 10\n'
                '    while not gate.exists() and time.monotonic() < deadline: time.sleep(.01)\n'
                '    exited.touch()\n'
                '    sys.exit(0)\n'
                'signal.signal(signal.SIGTERM, stop)\n'
                'started.touch()\n'
                'while True: signal.pause()\n'
            )
            runtime.chmod(0o755)
            output = root / 'results'
            process = subprocess.Popen(
                ['bash', str(SCRIPT)], stdout=subprocess.PIPE, stderr=subprocess.PIPE,
                text=True, env={**os.environ, 'FLUTTER_PI': str(runtime),
                    'BENCHMARK_BUNDLE': str(bundle), 'BENCHMARK_OUTPUT': str(output),
                    'XDG_RUNTIME_DIR': str(root), 'BENCHMARK_TIMEOUT_SECONDS': '20'},
            )

            def wait_file(path):
                deadline = time.monotonic() + 5
                while not path.exists() and time.monotonic() < deadline:
                    self.assertIsNone(process.poll(), f'launcher exited before {path.name}')
                    time.sleep(.01)
                self.assertTrue(path.exists(), path)

            try:
                wait_file(started)
                process.send_signal(signal.SIGTERM)
                wait_file(stopping)
                # An explicit held teardown is the contract under test.
                with self.assertRaises(subprocess.TimeoutExpired):
                    process.wait(timeout=.25)
                self.assertFalse(Path(f'{output}.tar.gz').exists())
                gate.touch()
                stdout, stderr = process.communicate(timeout=5)
                self.assertEqual(130, process.returncode, stdout + stderr)
                self.assertTrue(exited.exists())
                self.assertEqual(130, json.loads((output / 'launcher-status.json').read_text())['exit_code'])
                self.assertTrue(Path(f'{output}.tar.gz').exists())
            finally:
                gate.touch()
                if process.poll() is None:
                    process.terminate()
                    process.communicate(timeout=5)


if __name__ == '__main__':
    unittest.main()
