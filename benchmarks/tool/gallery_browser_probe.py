#!/usr/bin/env python3
"""Compile the production loader to JS and exercise Chrome's actual Fetch/CORS.

Two loopback origins and temporary browser state only. No installs or device I/O.
"""
import argparse
from contextlib import contextmanager
import hashlib
import http.server
import json
import os
from pathlib import Path
import shutil
import socket
import subprocess
import tempfile
import threading
import time
from urllib.parse import parse_qs, quote, unquote, urljoin, urlparse

import gallery_http

ROOT = Path(__file__).resolve().parents[2]
TOOL = Path(__file__).resolve().parent


@contextmanager
def chrome_profile():
    profile = Path(tempfile.mkdtemp(prefix='gallery-chrome-'))
    try:
        yield profile
    finally:
        # Chrome's last child can finish a preference write just after the main
        # process exits. Retry only local profile cleanup, never a test failure.
        for attempt in range(20):
            try:
                shutil.rmtree(profile)
                break
            except FileNotFoundError:
                break
            except OSError:
                if attempt == 19:
                    raise
                time.sleep(.05)


class State:
    def __init__(self):
        self.lock = threading.Lock()
        self.phases = {}
        self.result = None
        self.finished = threading.Event()

    def record(self, phase):
        return self.phases.setdefault(phase, {'requests': 0, 'active': 0, 'peak': 0,
                                              'bytes': 0, 'cancelled': 0, 'completed': 0, 'options': 0})


def make_server(state, script, cross=False):
    class Handler(http.server.BaseHTTPRequestHandler):
        protocol_version = 'HTTP/1.1'

        def log_message(self, *args):
            pass

        def cors(self):
            if self.path.startswith('/denied'):
                return
            self.send_header('Access-Control-Allow-Origin', '*')
            self.send_header('Access-Control-Allow-Methods', 'GET, HEAD, POST, OPTIONS')
            self.send_header('Access-Control-Allow-Headers', 'If-None-Match, If-Modified-Since, Range, If-Range, Content-Type')
            self.send_header('Access-Control-Expose-Headers',
                             'ETag, Last-Modified, Content-Length, Content-Range, Accept-Ranges, Retry-After')

        def answer(self, status, body, headers=None):
            self.send_response(status)
            self.cors()
            self.send_header('Content-Length', str(len(body)))
            self.send_header('Cache-Control', 'no-store')
            for key, value in (headers or {}).items():
                self.send_header(key, value)
            self.end_headers()
            if self.command != 'HEAD':
                self.wfile.write(body)

        def do_OPTIONS(self):
            phase = parse_qs(urlparse(self.path).query).get('phase', [''])[0]
            with state.lock:
                state.record(phase)['options'] += 1
            self.answer(204, b'')

        def do_HEAD(self):
            self.do_GET()

        def do_POST(self):
            if self.path != '/result':
                self.answer(404, b'')
                return
            result = json.loads(self.rfile.read(int(self.headers['Content-Length'])))
            with state.lock:
                state.result = result
            self.answer(200, b'saved')
            state.finished.set()

        def do_GET(self):
            parsed = urlparse(self.path)
            phase = parse_qs(parsed.query).get('phase', [''])[0]
            if parsed.path == '/':
                self.answer(200, b'<html><script src="/probe.js"></script></html>', {'Content-Type': 'text/html'})
                return
            if parsed.path == '/probe.js':
                self.answer(200, script.read_bytes(), {'Content-Type': 'application/javascript'})
                return
            if parsed.path == '/stats':
                with state.lock:
                    payload = json.dumps(state.record(phase)).encode()
                self.answer(200, payload, {'Content-Type': 'application/json'})
                return
            if parsed.path in ('/headers', '/denied'):
                with state.lock:
                    state.record(phase)['requests'] += 1
                headers = {'ETag': '"gallery-probe"', 'Last-Modified': 'Mon, 26 Oct 2026 12:00:00 GMT',
                           'Content-Range': 'bytes 0-9/10', 'Accept-Ranges': 'bytes', 'Retry-After': '1'}
                if self.headers.get('If-None-Match') == '"gallery-probe"':
                    self.answer(304, b'', headers)
                elif self.headers.get('Range') == 'bytes=2-4':
                    self.answer(206, b'234', headers | {'Content-Range': 'bytes 2-4/10'})
                else:
                    self.answer(200, b'0123456789', headers)
                return
            if parsed.path not in ('/body', '/large-body', '/slow-headers'):
                self.answer(404, b'')
                return
            with state.lock:
                record = state.record(phase)
                record['requests'] += 1
                record['active'] += 1
                record['peak'] = max(record['peak'], record['active'])
            cancelled = False
            try:
                if parsed.path == '/slow-headers':
                    deadline = time.monotonic() + 3
                    while time.monotonic() < deadline:
                        try:
                            if self.connection.recv(1, socket.MSG_PEEK | socket.MSG_DONTWAIT) == b'':
                                raise ConnectionResetError('client aborted before headers')
                        except BlockingIOError:
                            pass
                        time.sleep(.01)
                length = 33554432 if parsed.path == '/large-body' else 262144
                self.send_response(200)
                self.cors()
                self.send_header('Content-Length', str(length))
                self.send_header('Content-Type', 'application/octet-stream')
                self.send_header('Cache-Control', 'no-store')
                self.end_headers()
                for index in range(length // 32768):
                    if index:
                        time.sleep(.01)
                    self.wfile.write(b'x' * 32768)
                    self.wfile.flush()
                    with state.lock:
                        state.record(phase)['bytes'] += 32768
            except (BrokenPipeError, ConnectionResetError, ConnectionAbortedError):
                cancelled = True
                self.close_connection = True
            finally:
                with state.lock:
                    record = state.record(phase)
                    record['active'] -= 1
                    record['cancelled' if cancelled else 'completed'] += 1

    server = http.server.ThreadingHTTPServer(('127.0.0.1', 0), Handler)
    server.daemon_threads = True
    return server


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--chrome', default=shutil.which('google-chrome') or shutil.which('chromium'))
    parser.add_argument('--dart', default='/home/dis/bin/flutter/bin/cache/dart-sdk/bin/dart')
    parser.add_argument('--backend-binary', type=Path,
                        help='Optional frozen actual WebService AOT server from gallery_http.py')
    args = parser.parse_args()
    if not args.chrome:
        parser.error('No installed Chrome/Chromium found; does not install a browser')
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    dart = output / 'gallery_browser_probe.dart'
    shutil.copy2(TOOL / dart.name, dart)
    loader = ROOT / 'config_app/lib/src/gallery/media_image_loader.dart'
    frozen_loader = output / 'sources/config_app/lib/src/gallery/media_image_loader.dart'
    frozen_loader.parent.mkdir(parents=True)
    shutil.copy2(loader, frozen_loader)
    package_file = ROOT / 'config_app/.dart_tool/package_config.json'
    config = json.loads(package_file.read_text())
    for entry in config['packages']:
        if entry['name'] == 'config_app':
            source = output / 'sources/config_app'
        else:
            source = Path(unquote(urlparse(urljoin(package_file.as_uri(), entry['rootUri'])).path))
        entry['rootUri'] = source.as_uri() + '/'
    frozen_packages = output / 'package_config.json'
    frozen_packages.write_text(json.dumps(config, indent=2) + '\n')
    shutil.copy2(__file__, output / 'gallery_browser_probe.py')
    script = output / 'probe.js'
    command = [args.dart, 'compile', 'js', f'--packages={frozen_packages}',
               str(dart), '-o', str(script)]
    environment = os.environ | {'DASH__SUPPRESS_ANALYTICS': 'true'}
    compiled = subprocess.run(command, capture_output=True, text=True, env=environment, timeout=120)
    (output / 'compile.log').write_text(compiled.stdout + compiled.stderr)
    if compiled.returncode:
        raise RuntimeError('Browser probe compilation failed; see compile.log')
    source_hashes = {str(path.relative_to(output)): hashlib.sha256(path.read_bytes()).hexdigest()
                     for path in [dart, output / 'gallery_browser_probe.py', frozen_loader, frozen_packages, script]}
    (output / 'provenance.json').write_text(json.dumps({
        'command': command, 'source_sha256': source_hashes,
        'chrome_version': subprocess.check_output([args.chrome, '--version'], text=True).strip(),
        'scope': 'real Chrome Fetch/BrowserClient and production pure-Dart loader; no Flutter UI or Pi',
        'fixtures': 'controlled arbitrary encoded bytes; no image decoder is invoked',
    }, indent=2) + '\n')
    state = State()
    first = make_server(state, script)
    second = make_server(state, script, cross=True)
    for server in (first, second):
        threading.Thread(target=server.serve_forever, daemon=True).start()
    backend = None
    backend_fixture = None
    production_url = None
    if args.backend_binary:
        backend_fixture = tempfile.TemporaryDirectory(prefix='gallery-browser-backend-')
        fixture = Path(backend_fixture.name) / 'fixture'
        gallery_http.prepare_fixture(fixture, 0, [ROOT / 'benchmarks/assets/media/photo_a.jpg'])
        backend, ready = gallery_http.start_server(args.backend_binary.resolve(), fixture,
                                                   output / 'backend.stderr.log')
        production_url = f'http://127.0.0.1:{ready["port"]}/cache/{ready["code"]}/get/photo_a.jpg'
        (output / 'backend-provenance.json').write_text(json.dumps({
            'binary': str(args.backend_binary.resolve()),
            'binary_sha256': gallery_http.digest(args.backend_binary), 'ready': ready,
        }, indent=2) + '\n')
    try:
        with chrome_profile() as profile:
            url = f'http://127.0.0.1:{first.server_port}/?cross=' + quote(f'http://127.0.0.1:{second.server_port}/', safe='')
            if production_url:
                url += '&backend=' + quote(production_url, safe='')
            with (output / 'chrome.stderr.log').open('w') as log:
                browser = subprocess.Popen([args.chrome, '--headless', '--no-sandbox', '--disable-gpu',
                                            '--disable-dev-shm-usage', '--no-first-run', '--no-default-browser-check',
                                            '--disable-background-networking', '--disable-extensions',
                                            '--disable-component-update', '--disable-sync',
                                            f'--user-data-dir={profile}', url],
                                           stdout=log, stderr=log)
                try:
                    if not state.finished.wait(60):
                        raise RuntimeError('Browser did not report within 60 seconds; see Chrome stderr')
                finally:
                    browser.terminate()
                    try: browser.wait(timeout=5)
                    except subprocess.TimeoutExpired:
                        browser.kill()
                        browser.wait(timeout=5)
        result = state.result
        if backend:
            result['production_backend'] = gallery_http.settle(ready['port'])
            bodies = result['production_backend']['bodies']
            result['production_wire'] = {
                'range_206_three_bytes': any(body['status'] == 206 and body['source_bytes'] == 3
                                             for body in bodies),
                'conditional_304_empty': any(body['status'] == 304 and body['source_bytes'] == 0
                                             for body in bodies),
                'head_200_empty': any(body['status'] == 200 and body['source_bytes'] == 0
                                      for body in bodies),
            }
            result['passed'] = result['passed'] and all(result['production_wire'].values())
        with state.lock:
            result['server_phases'] = state.phases
        (output / 'result.json').write_text(json.dumps(result, indent=2) + '\n')
        print(json.dumps({'passed': result['passed'], 'cases': len(result['cases']), 'output': str(output)}))
        if not result['passed']:
            raise SystemExit(1)
    finally:
        if backend:
            try:
                gallery_http.request(ready['port'], '/__probe/stop')
                backend.wait(timeout=5)
            except Exception:
                backend.kill()
                backend.wait(timeout=5)
            finally:
                backend._gallery_stderr.close()
                backend_fixture.cleanup()
        for server in (first, second):
            server.shutdown()
            server.server_close()


if __name__ == '__main__':
    main()
