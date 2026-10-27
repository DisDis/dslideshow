"""Exercise OAuth, device lifecycle, paging and actual bounded HTTP downloads."""

import contextlib
import io
import json
from pathlib import Path
import stat
import subprocess
import sys
import tempfile
import threading
import unittest
from unittest.mock import patch
import urllib.error
import urllib.parse
import urllib.request
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer

import ambient_api_probe as p


PHOTO = {'id': 'photo/../id', 'mediaFile': {
    'baseUrl': 'https://lh3.googleusercontent.com/photo', 'mimeType': 'image/jpeg'}}
VIDEO = {'id': 'video-id', 'mediaFile': {
    'baseUrl': 'https://lh3.googleusercontent.com/video', 'mimeType': 'video/mp4'}}
CLIENT = {'installed': {'client_id': 'test-client', 'client_secret': 'test-secret'}}


class Clock:
    def __init__(self):
        self.now = 0
        self.waits = []

    def sleep(self, delay):
        self.waits.append(delay)
        self.now += delay

    def time(self):
        return self.now


class FakeHttp(p.Http):
    def __init__(self, values):
        super().__init__()
        self.values = list(values)
        self.calls = []

    def json(self, url, **kwargs):
        self.calls.append((url, kwargs))
        if not self.values:
            raise AssertionError(f'Unexpected request: {url}')
        value = self.values.pop(0)
        if isinstance(value, Exception):
            raise value
        return value


class Response(io.BytesIO):
    def __init__(self, data, headers=None, status=200):
        super().__init__(data)
        self.headers = headers or {}
        self.status = status


class ProbeTest(unittest.TestCase):
    def setUp(self):
        self.directory = tempfile.TemporaryDirectory()
        self.addCleanup(self.directory.cleanup)
        self.root = Path(self.directory.name)
        self.client = self.root / 'client.json'
        self.client.write_text(json.dumps(CLIENT))

    def probe(self, values=(), **changes):
        options = p.parser().parse_args(['--client-file', str(self.client),
                                         '--state-dir', str(self.root / 'state')])
        for key, value in changes.items():
            setattr(options, key, value)
        self.clock = Clock()
        self.messages = []
        probe = p.Probe(options, FakeHttp(values), sleep=self.clock.sleep,
                        monotonic=self.clock.time, wall=self.clock.time,
                        say=self.messages.append, prompt=lambda _: '2')
        probe.output = p.private_directory(self.root / 'output')
        probe.load()
        return probe

    def test_pending_and_slow_down_respect_poll_interval_and_save_private_tokens(self):
        probe = self.probe([
            {'device_code': 'private-device-code', 'user_code': 'ABCD',
             'verification_url': 'https://www.google.com/device', 'expires_in': 100, 'interval': 2},
            p.ApiError(428, {'error': 'authorization_pending'}),
            p.ApiError(403, {'error': 'slow_down'}),
            {'access_token': 'private-access', 'refresh_token': 'private-refresh',
             'expires_in': 3600, 'scope': p.SCOPE},
        ])
        self.assertEqual(probe.token(), 'private-access')
        self.assertEqual(self.clock.waits, [2, 2, 7])
        form = probe.http.calls[-1][1]['form']
        self.assertEqual(form['grant_type'], 'urn:ietf:params:oauth:grant-type:device_code')
        self.assertEqual(form['client_secret'], 'test-secret')
        self.assertNotIn('private-device-code', '\n'.join(self.messages))
        self.assertEqual(stat.S_IMODE(probe.state_path.stat().st_mode), 0o600)
        self.assertEqual(stat.S_IMODE(probe.state_path.parent.stat().st_mode), 0o700)

    def test_auth_denied_and_expired_are_not_retried(self):
        for code in ('access_denied', 'expired_token', 'unrecognized_error'):
            with self.subTest(code=code):
                probe = self.probe([
                    {'device_code': 'secret', 'user_code': 'A',
                     'verification_url': 'https://www.google.com/device', 'expires_in': 60},
                    p.ApiError(403, {'error': code}),
                ])
                with self.assertRaisesRegex(p.ApiError, code):
                    probe.authorize()
                self.assertEqual(len(probe.http.calls), 2)

    def test_auth_deadline_does_not_poll_forever(self):
        probe = self.probe([{'device_code': 'code', 'user_code': 'A',
                            'verification_url': 'https://www.google.com/device',
                            'expires_in': 4, 'interval': 5}])
        with self.assertRaisesRegex(p.ProbeError, 'Истекло'):
            probe.authorize()
        self.assertEqual(self.clock.waits, [])

    def test_api_401_refreshes_once_and_preserves_refresh_token(self):
        probe = self.probe([
            p.ApiError(401, {'error': {'status': 'UNAUTHENTICATED'}}),
            {'access_token': 'new-access', 'expires_in': 3600},
            {'id': 'device'},
        ])
        probe.state.update(access_token='old-access', refresh_token='refresh', expires_at=3600)
        self.assertEqual(probe.api('devices/device'), {'id': 'device'})
        self.assertEqual(probe.http.calls[0][1]['token'], 'old-access')
        self.assertEqual(probe.http.calls[-1][1]['token'], 'new-access')
        self.assertEqual(probe.state['refresh_token'], 'refresh')

    def test_permission_reason_is_preserved_without_assuming_partnership(self):
        probe = self.probe([p.ApiError(403, {'error': {
            'status': 'PERMISSION_DENIED', 'message': 'Denied test-secret https://example.test/private',
            'details': [{'reason': 'SERVICE_DISABLED'}],
        }})])
        probe.state.update(access_token='access', expires_at=3600)
        with self.assertRaises(p.ApiError) as result:
            probe.api('devices/id')
        message = probe.http.clean(result.exception)
        self.assertIn('SERVICE_DISABLED', message)
        self.assertNotIn('test-secret', message)
        self.assertNotIn('example.test', message)
        self.assertEqual(len(probe.http.calls), 1)

    def test_client_change_is_rejected_before_network(self):
        probe = self.probe()
        probe.save()
        self.client.write_text(json.dumps({'installed': {
            'client_id': 'different', 'client_secret': 'different-secret'}}))
        with self.assertRaisesRegex(p.ProbeError, 'другому OAuth'):
            probe.load()
        self.assertEqual(probe.http.calls, [])

    def test_device_request_id_survives_create_failure_and_restart(self):
        probe = self.probe([p.ProbeError('connection lost')])
        probe.state.update(access_token='access', expires_at=3600)
        with self.assertRaises(p.ProbeError):
            probe.device()
        request_id = json.loads(probe.state_path.read_text())['request_id']
        probe = self.probe([{'id': 'device', 'mediaSourcesSet': True}])
        probe.device()
        self.assertEqual(urllib.parse.parse_qs(urllib.parse.urlsplit(probe.http.calls[0][0]).query),
                         {'requestId': [request_id]})
        self.assertEqual(probe.state['device_id'], 'device')

    def test_selection_polling_uses_server_duration_and_keeps_device(self):
        probe = self.probe([
            {'id': 'device', 'settingsUri': 'https://photos.google.com/settings',
             'mediaSourcesSet': False, 'pollingConfig': {'pollInterval': '2.5s'}},
            {'id': 'device', 'mediaSourcesSet': True, 'mediaSources': [{'id': 'album'}]},
        ])
        probe.state.update(access_token='access', expires_at=3600)
        self.assertTrue(probe.device()['mediaSourcesSet'])
        self.assertEqual(self.clock.waits, [2.5])
        self.assertEqual(probe.state['device_id'], 'device')
        self.assertTrue(any('photos.google.com' in message for message in self.messages))

    def test_selection_timeout_can_resume_without_creating_device(self):
        probe = self.probe([{'id': 'device', 'settingsUri': 'https://photos.google.com/settings',
                             'mediaSourcesSet': False, 'pollingConfig': {'pollInterval': '10s'}}],
                           selection_timeout=5)
        probe.state.update(access_token='access', expires_at=3600)
        with self.assertRaisesRegex(p.ProbeError, 'выбора альбома'):
            probe.device()
        self.assertEqual(json.loads(probe.state_path.read_text())['device_id'], 'device')

    def test_source_selection_uses_media_source_id_and_rejects_highlights(self):
        probe = self.probe()
        device = {'mediaSources': [{'id': 'highlights'}, {'id': 'first', 'displayName': 'A'},
                                   {'id': 'second', 'displayName': 'B'}]}
        self.assertEqual(probe.source(device), 'second')
        self.assertEqual(probe.source(device), 'second')  # saved choice
        probe.options.source_id = 'foreign-library-album-id'
        with self.assertRaisesRegex(p.ProbeError, 'не входит'):
            probe.source(device)

    def test_pagination_deduplicates_and_never_persists_base_urls(self):
        probe = self.probe([{'mediaItems': [PHOTO], 'nextPageToken': 'next'},
                            {'mediaItems': [PHOTO, VIDEO]}])
        probe.state.update(access_token='access', expires_at=3600)
        self.assertEqual(len(probe.list_media('device', 'album')), 2)
        query = urllib.parse.parse_qs(urllib.parse.urlsplit(probe.http.calls[1][0]).query)
        self.assertEqual(query['mediaSourceId'], ['album'])
        self.assertEqual(query['pageToken'], ['next'])
        self.assertEqual(probe.report['counts'], {'photo': 1, 'video': 1, 'unknown': 0})
        self.assertFalse(probe.report['truncated'])
        self.assertNotIn('baseUrl', (probe.output / 'media.json').read_text())

    def test_page_limit_is_partial_and_repeated_tokens_fail(self):
        probe = self.probe([{'mediaItems': [PHOTO], 'nextPageToken': 'next'}], max_pages=1)
        probe.state.update(access_token='access', expires_at=3600)
        probe.list_media('device', 'album')
        self.assertTrue(probe.report['truncated'])
        probe.http.values = [{'nextPageToken': 'same'}, {'nextPageToken': 'same'}]
        probe.options.max_pages = 10
        with self.assertRaisesRegex(p.ProbeError, 'повторил nextPageToken'):
            probe.list_media('device', 'album')

    def test_stream_limit_truncation_mime_error_and_interrupt_remove_partial(self):
        responses = [
            (Response(b'12345', {'Content-Type': 'image/jpeg'}), 4, p.ProbeError),
            (Response(b'123', {'Content-Type': 'image/jpeg', 'Content-Length': '10'}), 20, p.ProbeError),
            (Response(b'<html>', {'Content-Type': 'text/html'}), 20, p.ProbeError),
            (Response(b'123', {'Content-Type': 'image/jpeg'}, status=206), 20, p.ProbeError),
        ]
        interrupted = Response(b'', {'Content-Type': 'image/jpeg'})
        interrupted.read1 = lambda _: (_ for _ in ()).throw(KeyboardInterrupt())
        responses.append((interrupted, 20, KeyboardInterrupt))
        for response, limit, error in responses:
            with self.subTest(limit=limit, error=error):
                probe = self.probe(max_download_bytes=limit)
                probe.state.update(access_token='access', expires_at=3600)
                with patch.object(probe.http, 'open', return_value=response):
                    with self.assertRaises(error):
                        probe.download(PHOTO)
                self.assertTrue(response.closed)
                self.assertEqual(list(probe.output.glob('*.part')), [])
                self.assertEqual(list(probe.output.glob('*.jpg')), [])

    def test_state_lock_prevents_concurrent_probes(self):
        with p.state_lock(self.root / 'state'):
            with self.assertRaisesRegex(p.ProbeError, 'Другой probe'):
                with p.state_lock(self.root / 'state'):
                    self.fail('Second lock succeeded')

    def test_download_deadline_closes_response_without_retaining_partial(self):
        probe = self.probe(download_timeout=1)
        probe.state.update(access_token='access', expires_at=3600)
        response = Response(b'', {'Content-Type': 'image/jpeg'})

        def slow_chunk(_):
            self.clock.now += 2
            return b'\xff\xd8\xfffirst-chunk'

        response.read1 = slow_chunk
        with patch.object(probe.http, 'open', return_value=response):
            with self.assertRaisesRegex(p.ProbeError, 'время скачивания'):
                probe.download(PHOTO)
        self.assertTrue(response.closed)
        self.assertEqual(list(probe.output.iterdir()), [])

    def test_octet_stream_needs_recognizable_media_signature(self):
        probe = self.probe()
        probe.state.update(access_token='access', expires_at=3600)
        for body, valid in ((b'\xff\xd8\xffjpeg-test', True), (b'<html>error</html>', False)):
            with self.subTest(valid=valid):
                response = Response(body, {'Content-Type': 'application/octet-stream'})
                with patch.object(probe.http, 'open', return_value=response):
                    if valid:
                        result = probe.download(PHOTO)
                        (probe.output / result['file']).unlink()
                    else:
                        with self.assertRaisesRegex(p.ProbeError, 'Сигнатура'):
                            probe.download(PHOTO)
                self.assertTrue(response.closed)
                self.assertEqual(list(probe.output.iterdir()), [])

    def test_transcoded_photo_uses_response_extension(self):
        probe = self.probe()
        probe.state.update(access_token='access', expires_at=3600)
        body = b'\x89PNG\r\n\x1a\npng-test'
        response = Response(body, {'Content-Type': 'image/png; charset=binary'})
        with patch.object(probe.http, 'open', return_value=response):
            result = probe.download(PHOTO)  # API metadata says image/jpeg.
        self.assertEqual(result['mime_type'], 'image/png')
        self.assertTrue(result['file'].endswith('.png'))
        self.assertEqual((probe.output / result['file']).read_bytes(), body)
        self.assertTrue(response.closed)
        self.assertEqual(list(probe.output.glob('*.part')), [])

    def test_malformed_credentials_and_media_shape_fail_clearly(self):
        self.client.write_text(json.dumps({'installed': 'not-an-object'}))
        with self.assertRaisesRegex(p.ProbeError, 'client_id'):
            self.probe()
        self.client.write_text(json.dumps(CLIENT))
        probe = self.probe([{'mediaItems': [{'id': 'bad', 'mediaFile': None}]}])
        probe.state.update(access_token='access', expires_at=3600)
        with self.assertRaisesRegex(p.ProbeError, 'mediaFile'):
            probe.list_media('device', 'album')

    def test_duration_boundary_and_unknown_mime_are_explicit(self):
        self.assertEqual(p.duration('1.250s'), 1.25)
        for value in (None, 5, 'forever', '-1s', '0s', 'NaNs'):
            with self.subTest(value=value), self.assertRaises(p.ProbeError):
                p.duration(value)
        self.assertEqual(p.MediaKind.from_mime('application/pdf'), p.MediaKind.UNKNOWN)

    def test_bad_json_and_json_limit_close_http_response(self):
        for body in (b'<html>error</html>', b' ' * (p.JSON_LIMIT + 1)):
            with self.subTest(size=len(body)):
                response = Response(body)
                http = p.Http()
                with patch.object(http, 'open', return_value=response):
                    with self.assertRaises(p.ProbeError):
                        http.json(p.TOKEN)
                self.assertTrue(response.closed)

    def test_cli_help_needs_no_credentials_or_network(self):
        result = subprocess.run([sys.executable, str(Path(p.__file__)), '--help'],
                                capture_output=True, text=True)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn('--client-file', result.stdout)


class HttpTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        class Handler(BaseHTTPRequestHandler):
            protocol_version = 'HTTP/1.1'

            def log_message(self, *args):
                pass

            def reply(self, value, mime='application/json', code=200):
                body = json.dumps(value).encode() if isinstance(value, dict) else value
                self.send_response(code)
                self.send_header('Content-Type', mime)
                self.send_header('Content-Length', str(len(body)))
                self.end_headers()
                self.wfile.write(body)

            def do_POST(self):
                data = self.rfile.read(int(self.headers['Content-Length']))
                cls.requests.append(('POST', self.path, dict(self.headers), data))
                if self.path == '/device/code':
                    self.reply({'device_code': 'secret-device-code', 'user_code': 'CODE',
                                'verification_url': 'https://www.google.com/device',
                                'expires_in': 10, 'interval': 0.001})
                elif self.path == '/token':
                    self.reply({'access_token': 'secret-access-token', 'refresh_token': 'secret-refresh',
                                'scope': p.SCOPE, 'expires_in': 3600})
                else:
                    self.reply({'id': 'created-device', 'mediaSourcesSet': False,
                                'settingsUri': 'https://photos.google.com/settings',
                                'pollingConfig': {'pollInterval': '0.001s'}})

            def do_GET(self):
                cls.requests.append(('GET', self.path, dict(self.headers), None))
                if self.path.startswith('/v1/devices/'):
                    self.reply({'id': 'created-device', 'mediaSourcesSet': True,
                                'mediaSources': [{'id': 'album', 'displayName': 'Test album'}]})
                elif self.path.startswith('/v1/mediaItems'):
                    self.reply({'mediaItems': [PHOTO] if cls.photos_only else [PHOTO, VIDEO]})
                elif self.path == '/photo=d':
                    self.reply(b'\xff\xd8\xffjpeg-test', mime='image/jpeg')
                elif self.path == '/video=dv':
                    self.reply(b'\x00\x00\x00\x18ftypmp42video-test', mime='video/mp4')
                elif self.path == '/redirect':
                    self.send_response(302)
                    self.send_header('Location', cls.redirect)
                    self.send_header('Content-Length', '0')
                    self.end_headers()
                else:
                    self.reply({'error': {'status': 'PERMISSION_DENIED', 'message': 'Denied',
                                         'details': [{'reason': 'ACCESS_TOKEN_SCOPE_INSUFFICIENT'}]}}, code=403)

            def do_DELETE(self):
                cls.requests.append(('DELETE', self.path, dict(self.headers), None))
                self.reply(b'', code=204)

        cls.server = ThreadingHTTPServer(('127.0.0.1', 0), Handler)
        cls.thread = threading.Thread(target=cls.server.serve_forever, daemon=True)
        cls.thread.start()

    @classmethod
    def tearDownClass(cls):
        cls.server.shutdown()
        cls.server.server_close()
        cls.thread.join()

    def setUp(self):
        self.requests = type(self).requests = []
        type(self).photos_only = False
        type(self).redirect = 'https://attacker.invalid/collect'
        self.directory = tempfile.TemporaryDirectory()
        self.addCleanup(self.directory.cleanup)
        self.root = Path(self.directory.name)
        self.client = self.root / 'client.json'
        self.client.write_text(json.dumps(CLIENT))
        port = self.server.server_port

        class LocalOpener:
            """Redirect trusted production URLs to loopback only inside the test."""
            def open(self, request, timeout):
                parts = urllib.parse.urlsplit(request.full_url)
                url = f'http://127.0.0.1:{port}' + parts.path
                if parts.query:
                    url += '?' + parts.query
                local = urllib.request.Request(url, data=request.data,
                                               headers=dict(request.headers), method=request.get_method())
                return urllib.request.build_opener(p.NoRedirect()).open(local, timeout=timeout)

        self.http = p.Http(opener=LocalOpener())

    def cli(self, *extra):
        output, error = io.StringIO(), io.StringIO()
        with patch.object(p, 'Http', return_value=self.http), contextlib.redirect_stdout(output), contextlib.redirect_stderr(error):
            status = p.main(['--client-file', str(self.client), '--state-dir', str(self.root / 'state'), *extra])
        report_file = max((self.root / 'state' / 'runs').glob('*/report.json'),
                          key=lambda path: path.stat().st_mtime_ns)
        return status, json.loads(report_file.read_text()), output.getvalue() + error.getvalue(), report_file.parent

    def test_full_cli_authorizes_selects_lists_downloads_and_reuses_device(self):
        status, report, output, folder = self.cli()
        self.assertEqual(status, p.Exit.OK, output)
        self.assertEqual(report['source']['id'], 'album')
        self.assertEqual({item['kind'] for item in report['downloads']}, {'photo', 'video'})
        for item in report['downloads']:
            file = folder / item['file']
            self.assertEqual(file.stat().st_size, item['bytes'])
            self.assertEqual(stat.S_IMODE(file.stat().st_mode), 0o600)
        self.assertNotIn('secret-access-token', output)
        self.assertNotIn('secret-refresh', report.__str__())
        self.assertNotIn('baseUrl', (folder / 'media.json').read_text())
        create = [entry for entry in self.requests if entry[0] == 'POST' and entry[1].startswith('/v1/devices')]
        self.assertEqual(len(create), 1)
        self.assertIn('requestId=', create[0][1])
        state = json.loads((self.root / 'state/state.json').read_text())
        self.assertEqual(state['device_id'], 'created-device')
        status, _, output, _ = self.cli()
        self.assertEqual(status, p.Exit.OK, output)
        self.assertEqual(sum(entry[0] == 'POST' and entry[1].startswith('/v1/devices')
                             for entry in self.requests), 1)

    def test_no_returned_video_is_incomplete_not_success(self):
        type(self).photos_only = True
        status, report, output, _ = self.cli()
        self.assertEqual(status, p.Exit.INCOMPLETE, output)
        self.assertEqual(report['counts']['video'], 0)
        self.assertIn({'kind': 'video', 'wanted': 1, 'downloaded': 0}, report['errors'])

    def test_cleanup_uses_real_delete_and_forgets_only_owned_device(self):
        self.cli()
        status, _, output, _ = self.cli('--delete-device')
        self.assertEqual(status, p.Exit.OK, output)
        self.assertTrue(any(method == 'DELETE' and path == '/v1/devices/created-device'
                            for method, path, _, _ in self.requests))
        state = json.loads((self.root / 'state/state.json').read_text())
        self.assertNotIn('device_id', state)
        self.assertIn('refresh_token', state)

    def test_untrusted_redirect_does_not_receive_bearer_token(self):
        with self.assertRaisesRegex(p.ProbeError, 'HTTPS media URL'):
            self.http.open('https://lh3.googleusercontent.com/redirect', media=True,
                           headers={'Authorization': 'Bearer private-token'})
        self.assertEqual(len(self.requests), 1)
        self.assertEqual(self.requests[0][1], '/redirect')

    def test_trusted_media_redirect_is_followed(self):
        type(self).redirect = 'https://lh4.googleusercontent.com/photo=d'
        with self.http.open('https://lh3.googleusercontent.com/redirect', media=True) as response:
            self.assertEqual(response.read(), b'\xff\xd8\xffjpeg-test')
        self.assertEqual(len(self.requests), 2)

    def test_real_http_error_reports_google_reason(self):
        with self.assertRaises(p.ApiError) as result:
            self.http.json('https://photosambient.googleapis.com/denied')
        self.assertEqual(result.exception.status, 403)
        self.assertIn('ACCESS_TOKEN_SCOPE_INSUFFICIENT', str(result.exception))


if __name__ == '__main__':
    unittest.main()
