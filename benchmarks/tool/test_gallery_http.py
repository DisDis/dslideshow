"""Regression checks for provenance and the gallery load client's observations."""
import http.server
import json
from pathlib import Path
import tempfile
import threading
import unittest

import gallery_http as bench


class GallerySnapshotTest(unittest.TestCase):
    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory()
        self.addCleanup(self.temporary.cleanup)
        self.root = Path(self.temporary.name)

    def test_snapshot_keeps_uncommitted_sources_and_detects_snapshot_mutation(self):
        packages = []
        for name in ('dslideshow_backend', 'dslideshow_common'):
            package = self.root / name
            (package / 'lib').mkdir(parents=True)
            (package / 'lib/example.dart').write_text('// current uncommitted source\n')
            packages.append({'name': name, 'rootUri': package.as_uri(), 'packageUri': 'lib/'})
        config = self.root / 'packages.json'
        config.write_text(json.dumps({'configVersion': 2, 'packages': packages}))
        variant = self.root / 'candidate'
        frozen = bench.snapshot_current(config, variant)
        (self.root / 'dslideshow_backend/lib/example.dart').write_text('// later edit\n')
        bench.verify_snapshot(variant)
        self.assertTrue(all(entry['rootUri'].startswith('file:///')
                            for entry in json.loads(frozen.read_text())['packages']))
        copied = variant / 'sources/backend/lib/example.dart'
        self.assertIn('current uncommitted', copied.read_text())
        copied.write_text('// accidental snapshot mutation\n')
        with self.assertRaisesRegex(ValueError, 'Frozen source changed'):
            bench.verify_snapshot(variant)

    def test_refuses_to_replace_existing_variant_or_fixture(self):
        existing = self.root / 'existing'
        existing.mkdir()
        (existing / 'preserve.txt').write_text('preserve')
        with self.assertRaises(FileExistsError):
            bench.snapshot_current(self.root / 'does-not-exist.json', existing)
        with self.assertRaises(FileExistsError):
            bench.prepare_fixture(existing, 1, [])
        self.assertEqual((existing / 'preserve.txt').read_text(), 'preserve')

    def test_fixtures_preserve_original_media_and_mark_fake_jpgs(self):
        photo = self.root / 'original.jpg'
        photo.write_bytes(b'original bytes, never resized by benchmark')
        fixture = self.root / 'fixture'
        manifest = bench.prepare_fixture(fixture, 7, [photo])
        self.assertEqual(manifest['real_media']['original.jpg']['sha256'], bench.digest(photo))
        self.assertEqual((fixture / 'media/original.jpg').read_bytes(), photo.read_bytes())
        self.assertEqual(len(list((fixture / 'media').glob('empty-*.jpg'))), 7)
        self.assertEqual(manifest['metadata_only_jpgs'], 7)

    def test_missing_quantiles_are_not_reported_as_zero(self):
        self.assertEqual(bench.distribution([]), {'n': 0, 'p50': None, 'p95': None, 'p99': None, 'max': None})
        self.assertEqual(bench.distribution([3, 2, 50])['p99'], 50)


class GalleryHttpClientTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        class Handler(http.server.BaseHTTPRequestHandler):
            def do_GET(self):
                if self.path == '/missing':
                    self.send_response(404)
                    self.end_headers()
                    self.wfile.write(b'missing')
                    return
                if self.path == '/truncated':
                    self.send_response(200)
                    self.send_header('Content-Length', '200000')
                    self.end_headers()
                    self.wfile.write(b'too short')
                    return
                payload = b'a' * 262144
                self.send_response(200)
                self.send_header('Content-Length', str(len(payload)))
                self.end_headers()
                try:
                    self.wfile.write(payload)
                except (BrokenPipeError, ConnectionResetError):
                    pass

            def log_message(self, *args):
                pass

        try:
            cls.server = http.server.ThreadingHTTPServer(('127.0.0.1', 0), Handler)
        except PermissionError as error:
            raise unittest.SkipTest(f'Local loopback bind unavailable: {error}') from error
        cls.thread = threading.Thread(target=cls.server.serve_forever, daemon=True)
        cls.thread.start()

    @classmethod
    def tearDownClass(cls):
        cls.server.shutdown()
        cls.server.server_close()
        cls.thread.join(timeout=5)

    def test_stream_counts_bytes_without_buffering_body(self):
        result, body = bench.request(self.server.server_port, '/original')
        self.assertEqual(result['status'], 200)
        self.assertEqual(result['body_bytes'], 262144)
        self.assertIsNone(result['error'])
        self.assertEqual(body, b'')
        self.assertFalse(result['cancelled'])

    def test_explicit_capture_keeps_metadata_body(self):
        result, body = bench.request(self.server.server_port, '/missing', capture_body=True)
        self.assertEqual(result['status'], 404)
        self.assertEqual(result['body_bytes'], 7)
        self.assertEqual(body, b'missing')

    def test_disconnect_stops_client_body_consumption_at_threshold(self):
        result, _ = bench.request(self.server.server_port, '/original', cancel_after=65536)
        self.assertTrue(result['cancelled'])
        self.assertEqual(result['body_bytes'], 65536)
        self.assertIsNone(result['error'])

    def test_truncation_is_an_error_not_a_successful_short_body(self):
        result, _ = bench.request(self.server.server_port, '/truncated')
        self.assertIsNotNone(result['error'])
        self.assertIn('IncompleteRead', result['error'])


if __name__ == '__main__':
    unittest.main()
