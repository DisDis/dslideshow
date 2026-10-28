#!/usr/bin/env python3
"""Exercise the preload IPC and RGBA rows with a fake EGL; never opens a GPU."""
import json
import hashlib
import os
from pathlib import Path
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parent


class CaptureProtocolTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.build = tempfile.TemporaryDirectory(prefix='egl-capture-build-')
        directory = Path(cls.build.name)
        cls.interposer = directory / 'libcapture.so'
        subprocess.run([str(ROOT / 'build.sh'), str(cls.interposer)], check=True,
                       capture_output=True, text=True)
        cls.fake = directory / 'libfakeegl.so'
        subprocess.run(['gcc', '-std=c11', '-Wall', '-Wextra', '-Werror', '-fPIC', '-shared',
                        str(ROOT / 'test/fake_egl.c'), '-o', str(cls.fake)], check=True)
        cls.engine = directory / 'libflutter_engine.so'
        subprocess.run(['gcc', '-std=c11', '-Wall', '-Wextra', '-Werror', '-fPIC', '-shared',
                        str(ROOT / 'test/fake_engine.c'), '-o', str(cls.engine)], check=True)
        cls.hash_probe = directory / 'hash-probe'
        subprocess.run(['gcc', '-std=c11', '-Wall', '-Wextra', '-Werror',
                        str(ROOT / 'test/hash_probe.c'), '-o', str(cls.hash_probe)], check=True)
        cls.no_engine_probe = directory / 'no-engine-probe'
        subprocess.run(['gcc', '-std=c11', '-Wall', '-Wextra', '-Werror', '-DNO_ENGINE',
                        str(ROOT / 'test/probe.c'), '-L' + str(directory), '-lfakeegl',
                        '-Wl,-rpath,' + str(directory), '-o', str(cls.no_engine_probe)], check=True)
        cls.probe = directory / 'probe'
        subprocess.run(['gcc', '-std=c11', '-Wall', '-Wextra', '-Werror',
                        str(ROOT / 'test/probe.c'), '-L' + str(directory), '-lfakeegl', '-lflutter_engine',
                        '-Wl,-rpath,' + str(directory), '-o', str(cls.probe)], check=True)

    @classmethod
    def tearDownClass(cls):
        cls.build.cleanup()

    def setUp(self):
        self.directory = tempfile.TemporaryDirectory(prefix='egl-capture-ipc-')
        self.capture = Path(self.directory.name)
        self.processes = []

    def tearDown(self):
        for process in self.processes:
            process.stdin.close()
            process.wait(timeout=5)
            process.stdout.close()
            process.stderr.close()
        self.directory.cleanup()

    def process(self, executable=None, **extra):
        environment = {**os.environ, **extra,
                       'BENCHMARK_EGL_CAPTURE_DIR': str(self.capture),
                       'LD_PRELOAD': str(self.interposer)}
        process = subprocess.Popen([str(executable or self.probe)], env=environment, text=True,
                                   stdin=subprocess.PIPE, stdout=subprocess.PIPE,
                                   stderr=subprocess.PIPE)
        self.processes.append(process)
        return process

    def swap(self, process):
        process.stdin.write('swap\n')
        process.stdin.flush()
        return tuple(map(int, process.stdout.readline().split()))

    def request(self, text):
        temporary = self.capture / 'request.tmp'
        temporary.write_bytes(text)
        temporary.rename(self.capture / 'request')

    def ack(self):
        self.assertFalse((self.capture / 'request.active').exists())
        self.assertFalse((self.capture / 'request').exists())
        return json.loads((self.capture / 'ack.json').read_text())

    def test_ordinary_barrier_capture_and_top_left_rgba(self):
        process = self.process()
        self.assertEqual(self.swap(process), (1, 0, 1, 0))
        self.assertFalse((self.capture / 'ack.json').exists())
        for request_id in range(1, 4):
            self.request(f'{request_id} barrier\n'.encode())
            self.assertEqual(self.swap(process)[1], 0)
            ack = self.ack()
            self.assertEqual((ack['request_id'], ack['kind'], ack['status']),
                             (request_id, 'barrier', 'ok'))
            self.assertTrue(ack['swap_success'])
            self.assertIsNone(ack['file'])
            self.assertEqual(ack['bytes'], 0)
        self.request(b'4\n')
        result = self.swap(process)
        ack = self.ack()
        self.assertEqual(result[:3], (1, 1, 5))
        self.assertEqual((ack['request_id'], ack['swap_index'], ack['kind'], ack['status']),
                         (4, 5, 'capture', 'ok'))
        self.assertEqual((ack['width'], ack['height'], ack['stride'], ack['bytes']),
                         (2560, 1600, 10240, 16384000))
        self.assertEqual((ack['format'], ack['row_order'], ack['origin']),
                         ('RGBA8888', 'top_to_bottom', 'top-left'))
        raw = (self.capture / ack['file']).read_bytes()
        self.assertEqual(len(raw), ack['bytes'])
        self.assertEqual(raw[:8], bytes((1599 & 255, 0, 37, 255, 1599 & 255, 1, 37, 255)))
        self.assertEqual(raw[-4:], bytes((0, 2559 & 255, 37, 255)))
        queries = result[3]
        self.assertEqual(self.swap(process), (1, 1, 6, queries))

    def test_invalid_surface_and_fbo_never_read_pixels(self):
        for environment, error in [({'FAKE_WIDTH': '1920'}, 'surface_dimensions_not_2560x1600'),
                                   ({'FAKE_FBO': '7'}, 'draw_framebuffer_is_not_zero'),
                                   ({'FAKE_GL_ERROR': '1'}, 'preexisting_gl_error'),
                                   ({'FAKE_READ_MISMATCH': '1'}, 'current_egl_surface_or_context_mismatch')]:
            with self.subTest(error=error):
                process = self.process(**environment)
                self.request(b'100\n')
                self.assertEqual(self.swap(process)[:2], (1, 0))
                ack = self.ack()
                self.assertEqual((ack['status'], ack['error']), ('error', error))
                self.assertEqual(ack['bytes'], 0)
                self.assertIsNone(ack['file'])

    def test_invalid_and_duplicate_requests_are_explicit_errors(self):
        process = self.process()
        for request in (b'0\n', b'-1\n', b'18446744073709551616\n', b'1 garbage\n', b'2\x00extra'):
            self.request(request)
            self.assertEqual(self.swap(process)[1], 0)
            self.assertEqual(self.ack()['status'], 'error')
        self.request(b'9 barrier\n')
        self.swap(process)
        self.assertEqual(self.ack()['status'], 'ok')
        self.request(b'9 barrier\n')
        self.swap(process)
        ack = self.ack()
        self.assertEqual((ack['status'], ack['error']), ('error', 'request_id_not_increasing'))

    def test_loaded_engine_metadata_uses_mapped_library_and_hash(self):
        library_path = '/preserved:/engine path/"quoted"\\segment\nline'
        process = self.process(LD_LIBRARY_PATH=library_path)
        self.request(b'1 barrier\n')
        self.swap(process)
        self.assertEqual(self.ack()['status'], 'ok')
        metadata = json.loads((self.capture / 'capture-runtime.json').read_text())
        self.assertEqual(metadata['kind'], 'egl_capture_loaded_runtime')
        self.assertEqual(metadata['pid'], process.pid)
        self.assertEqual(metadata['engine']['path'], str(self.engine))
        self.assertEqual(metadata['engine']['mapped_inode'], self.engine.stat().st_ino)
        self.assertEqual(metadata['engine']['sha256'],
                         hashlib.sha256(self.engine.read_bytes()).hexdigest())
        self.assertEqual(metadata['effective_ld_library_path'], library_path)
        self.assertFalse((self.capture / 'capture-runtime.json.tmp').exists())

    def test_missing_loaded_engine_cannot_accept_a_capture(self):
        process = self.process(executable=self.no_engine_probe)
        self.request(b'1 barrier\n')
        self.assertEqual(self.swap(process)[:2], (1, 0))
        ack = self.ack()
        self.assertEqual((ack['status'], ack['error']), ('error', 'loaded_runtime_metadata_failed'))
        self.assertFalse((self.capture / 'capture-runtime.json').exists())

    def test_native_sha256_matches_hashlib_across_padding_boundaries(self):
        for size in [0, 1, 55, 56, 63, 64, 65, 4096, 16385]:
            with self.subTest(size=size):
                data = bytes((index * 37 + 19) % 256 for index in range(size))
                file = self.capture / 'hash-input'
                file.write_bytes(data)
                result = subprocess.run([str(self.hash_probe), str(file)], text=True,
                                        capture_output=True, check=True)
                self.assertEqual(result.stdout.strip(), hashlib.sha256(data).hexdigest())

    def test_existing_raw_file_is_never_replaced(self):
        original = self.capture / 'frame-1.rgba'
        original.write_bytes(b'previous evidence')
        process = self.process()
        self.request(b'1\n')
        self.swap(process)
        ack = self.ack()
        self.assertEqual((ack['status'], ack['error']), ('error', 'publish_raw_failed'))
        self.assertEqual(original.read_bytes(), b'previous evidence')
        self.assertFalse(list(self.capture.glob('*.tmp-*')))

    def test_wrapper_preserves_arguments_and_records_actual_runtime(self):
        runtime = self.capture / 'fake runtime'
        runtime.write_text('#!/usr/bin/env python3\n'
                           'import json, os, sys\n'
                           'print(json.dumps(dict(argv=sys.argv[1:], '
                           'preload=os.environ.get("LD_PRELOAD"), '
                           'library_path=os.environ.get("LD_LIBRARY_PATH"))))\n'
                           'sys.exit(7)\n')
        runtime.chmod(0o755)
        output = self.capture / 'wrapped output'
        arguments = ['--release', '/a bundle', '--engine-value=a b']
        environment = {**os.environ, 'BENCHMARK_OUTPUT': str(output),
                       'BENCHMARK_EGL_REAL_RUNTIME': str(runtime),
                       'BENCHMARK_EGL_CAPTURE_LIBRARY': str(self.interposer),
                       'BENCHMARK_RENDERER': 'opengl', 'LD_LIBRARY_PATH': '/original/bundle'}
        environment.pop('BENCHMARK_EGL_CAPTURE_DIR', None)
        environment.pop('LD_PRELOAD', None)
        result = subprocess.run([str(ROOT / 'flutter-pi-capture.sh'), *arguments],
                                env=environment, text=True, capture_output=True, check=False)
        self.assertEqual(result.returncode, 7, result.stderr)
        actual = json.loads(result.stdout)
        self.assertEqual(actual['argv'], arguments)
        self.assertEqual(actual['preload'], str(self.interposer))
        self.assertEqual(actual['library_path'], '/original/bundle:' + str(self.capture))
        metadata = json.loads((output / 'egl-capture/runtime-provenance.json').read_text())
        self.assertEqual(metadata['real_runtime']['sha256'],
                         hashlib.sha256(runtime.read_bytes()).hexdigest())
        self.assertEqual(metadata['interposer']['sha256'],
                         hashlib.sha256(self.interposer.read_bytes()).hexdigest())
        self.assertFalse(metadata['timing_results_valid'])
        self.assertEqual(metadata['effective_ld_library_path'],
                         '/original/bundle:' + str(self.capture))
        self.assertEqual(metadata['argv'], arguments)

    def test_real_swap_failure_is_not_hidden(self):
        process = self.process(FAKE_SWAP_FALSE='1')
        self.request(b'1 barrier\n')
        self.assertEqual(self.swap(process)[:2], (0, 0))
        ack = self.ack()
        self.assertEqual((ack['status'], ack['error']), ('error', 'egl_swap_buffers_failed'))
        self.assertFalse(ack['swap_success'])


if __name__ == '__main__':
    unittest.main()
