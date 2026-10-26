import http.server
import threading
import time
import unittest

from camera_http_probe import probe


class _Handler(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        self.server.paths.append(self.path)
        if self.server.send_headers:
            self.send_response(200)
            self.send_header('Content-Length', '1000000')
            self.end_headers()
        # Deliberately never provide the body, or even headers in the timeout
        # case. The probe must still finish within its overall deadline.
        self.server.release.wait(4)

    def log_message(self, *_args):
        pass


class CameraHttpProbeTest(unittest.TestCase):
    def setUp(self):
        self.server = http.server.ThreadingHTTPServer(('127.0.0.1', 0), _Handler)
        self.server.paths = []
        self.server.release = threading.Event()
        self.server.send_headers = True
        self.thread = threading.Thread(target=self.server.serve_forever, daemon=True)
        self.thread.start()
        self.authority = f'127.0.0.1:{self.server.server_port}'

    def tearDown(self):
        self.server.release.set()
        self.server.shutdown()
        self.server.server_close()
        self.thread.join()

    def test_records_headers_without_waiting_for_or_retaining_body(self):
        result = probe(self.authority, 1)
        self.assertEqual(self.server.paths, ['/info'])
        sample = result['samples'][0]
        self.assertEqual(sample['status'], 200)
        self.assertNotIn('exception_type', sample)
        self.assertEqual(set(sample), {'utc', 'elapsed_s', 'status', 'rtt_ms'})
        self.assertLess(result['actual_duration_s'], 1.8)

    def test_stalled_headers_respect_remaining_run_deadline(self):
        self.server.send_headers = False
        started = time.monotonic()
        result = probe(self.authority, 1)
        self.assertLess(time.monotonic() - started, 1.8)
        self.assertEqual(len(result['samples']), 1)
        self.assertEqual(result['samples'][0]['exception_type'], 'TimeoutError')
        self.assertNotIn('status', result['samples'][0])


if __name__ == '__main__':
    unittest.main()
