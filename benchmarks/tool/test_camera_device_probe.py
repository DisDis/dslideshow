"""Loopback-only checks for the passive camera RPC diagnostic.

Run from the repository root:
  python3 -m unittest discover -s benchmarks/tool -p test_camera_device_probe.py -v

Uses only the standard library, an existing Dart SDK and optional, already
installed websockets. Missing prerequisites explicitly skip the tests. No pub
commands, device addresses, MQTT commands or dependency changes are involved.
"""

import asyncio
import json
import os
from pathlib import Path
import shutil
import unittest

try:
    from websockets.asyncio.server import serve
    from websockets.exceptions import ConnectionClosed
except ImportError:
    serve = None
    ConnectionClosed = Exception


ROOT = Path(__file__).resolve().parents[2]
PROBE = ROOT / 'benchmarks/tool/camera_device_probe.dart'
PACKAGES = ROOT / 'benchmarks/.dart_tool/package_config.json'
DEFAULT_DART = '/home/dis/bin/flutter/bin/cache/dart-sdk/bin/dart'
SECRET = 'loopback-camera-probe-secret-never-log'


@unittest.skipIf(serve is None, 'Existing optional websockets is unavailable')
class CameraDeviceProbeTest(unittest.IsolatedAsyncioTestCase):
    async def asyncSetUp(self):
        self.dart = os.environ.get('DART_EXECUTABLE')
        if not self.dart:
            self.dart = DEFAULT_DART if Path(DEFAULT_DART).is_file() else shutil.which('dart')
        if not self.dart or not Path(self.dart).is_file():
            self.skipTest('Existing Dart SDK is unavailable')
        if not PACKAGES.is_file():
            self.skipTest('Existing benchmarks package config is unavailable')
        # Check loopback availability explicitly, so a restricted sandbox is
        # reported as unavailable coverage, rather than a network regression.
        try:
            server = await asyncio.start_server(lambda *_: None, '127.0.0.1', 0)
        except OSError as error:
            self.skipTest(f'Local loopback bind unavailable: {type(error).__name__}')
        server.close()
        await server.wait_closed()

    async def run_probe(self, port, timeout=18):
        process = await asyncio.create_subprocess_exec(
            self.dart, f'--packages={PACKAGES}', str(PROBE), f'127.0.0.1:{port}', '1',
            cwd=ROOT, stdin=asyncio.subprocess.PIPE,
            stdout=asyncio.subprocess.PIPE, stderr=asyncio.subprocess.PIPE,
        )
        try:
            output, error = await asyncio.wait_for(
                process.communicate((SECRET + '\n').encode()), timeout,
            )
        except asyncio.TimeoutError:
            process.kill()
            await process.communicate()
            self.fail('Probe process did not exit within its teardown deadline')
        # Avoid including captured output in failures: it may contain secrets
        # when testing a parser regression against untrusted server frames.
        self.assertFalse(SECRET.encode() in output, 'Auth code leaked to stdout')
        self.assertFalse(SECRET.encode() in error, 'Auth code leaked to stderr')
        return process.returncode, output

    async def run_case(self, scenario):
        received = []
        closed = asyncio.Event()
        hello_ack = False
        handler_errors = []

        async def handler(socket):
            nonlocal hello_ack
            try:
                async for raw in socket:
                    tag, body = json.loads(raw)
                    received.append((tag, body.get('commandData', [None])[0]))
                    request_id = body['id']
                    if tag == 'WSAuthCommand':
                        if body.get('code') != SECRET:
                            raise ValueError('Unexpected local authentication input')
                        if scenario == 'auth_rejection':
                            await socket.send(json.dumps([
                                'WSErrorResult', {'id': request_id, 'error': 'denied ' + SECRET},
                            ]))
                        else:
                            await socket.send(json.dumps([
                                'WSHelloCommand', {'id': 77, 'type': 'ws_hello'},
                            ]))
                            await socket.send(json.dumps(['WSResultOk', {'id': request_id}]))
                    elif tag == 'WSResultOk':
                        hello_ack = request_id == 77
                    elif tag == 'WSEchoCommand':
                        if scenario == 'disconnect_pending':
                            await socket.close()
                            continue
                        if scenario == 'malformed':
                            await socket.send('invalid ' + SECRET)
                            continue
                        await socket.send(json.dumps([
                            'WSEchoResult', {'id': request_id, 'msg': body['msg']},
                        ]))
                    elif tag == 'WSSendRpcCommand':
                        inner_tag, inner_body = body['commandData']
                        if inner_tag == 'EchoCommand':
                            inner = ['EchoCommandResult', {
                                'id': inner_body['id'], 'resultText': 'alive',
                            }]
                        elif inner_tag == 'GetFrameStateCommand':
                            if scenario == 'timeout':
                                continue
                            if scenario == 'nested_error':
                                inner = ['ErrorResult', {
                                    'id': inner_body['id'], 'error': 'frontend unavailable',
                                }]
                            else:
                                frontend = None if scenario == 'frontend_null' else {'isPaused': False}
                                inner = ['GetFrameStateResult', {
                                    'id': inner_body['id'], 'state': {'frontend': frontend},
                                }]
                        else:
                            raise ValueError('Unexpected local nested RPC')
                        await socket.send(json.dumps([
                            'WSRpcResult', {'id': request_id, 'resultData': inner},
                        ]))
                    else:
                        raise ValueError('Unexpected local websocket command')
            except ConnectionClosed:
                pass
            except Exception as error:
                handler_errors.append(type(error).__name__)
            finally:
                closed.set()

        async with serve(handler, '127.0.0.1', 0) as server:
            port = server.sockets[0].getsockname()[1]
            return_code, output = await self.run_probe(port)
            await asyncio.wait_for(closed.wait(), 2)
        self.assertEqual(handler_errors, [])
        self.assertTrue(closed.is_set(), 'WebSocket connection was not closed')
        self.assertTrue(all(
            tag in ('WSAuthCommand', 'WSResultOk', 'WSEchoCommand', 'WSSendRpcCommand')
            and inner in (None, 'EchoCommand', 'GetFrameStateCommand')
            for tag, inner in received
        ), 'Probe sent a command outside the passive read-only set')
        try:
            result = json.loads(output)
        except (ValueError, UnicodeError):
            self.fail('Probe stdout did not contain a JSON result')
        self.assertEqual(result['authenticated'], scenario != 'auth_rejection')
        self.assertEqual(result['completed'], scenario not in (
            'auth_rejection', 'disconnect_pending', 'malformed',
        ))
        return return_code, result['samples'], hello_ack

    async def test_auth_hello_web_echo_and_nested_rpc(self):
        code, rows, _ = await self.run_case('happy')
        self.assertEqual(code, 0)
        kinds = {row['kind']: row for row in rows}
        self.assertEqual(set(kinds), {'web_echo', 'backend_echo', 'frame_state'})
        self.assertEqual(kinds['web_echo']['response_type'], 'WSEchoResult')
        self.assertEqual(kinds['backend_echo']['rpc_type'], 'EchoCommandResult')
        self.assertTrue(kinds['frame_state']['frontend_available'])

    async def test_frontend_null_is_preserved(self):
        code, rows, _ = await self.run_case('frontend_null')
        self.assertEqual(code, 0)
        frame = next(row for row in rows if row['kind'] == 'frame_state')
        self.assertFalse(frame['frontend_available'])

    async def test_frame_timeout_keeps_successful_echo_samples(self):
        code, rows, _ = await self.run_case('timeout')
        self.assertEqual(code, 0)
        kinds = {row['kind']: row for row in rows}
        self.assertEqual(kinds['web_echo']['response_type'], 'WSEchoResult')
        self.assertEqual(kinds['backend_echo']['rpc_type'], 'EchoCommandResult')
        self.assertEqual(kinds['frame_state']['failure_type'], 'TimeoutException')

    async def test_auth_rejection_is_nonzero_without_logging_code(self):
        code, rows, _ = await self.run_case('auth_rejection')
        self.assertNotEqual(code, 0)
        self.assertEqual(rows, [])

    async def test_disconnect_settles_all_pending_samples(self):
        code, rows, _ = await self.run_case('disconnect_pending')
        self.assertNotEqual(code, 0)
        self.assertEqual(len(rows), 3)
        self.assertTrue(all('failure_type' in row for row in rows))

    async def test_nested_rpc_error_type_is_preserved(self):
        code, rows, _ = await self.run_case('nested_error')
        self.assertEqual(code, 0)
        frame = next(row for row in rows if row['kind'] == 'frame_state')
        self.assertEqual(frame['rpc_type'], 'ErrorResult')

    async def test_malformed_frame_is_bounded_and_does_not_leak_auth_code(self):
        code, rows, _ = await self.run_case('malformed')
        self.assertNotEqual(code, 0)
        self.assertEqual(len(rows), 3)
        self.assertTrue(any('failure_type' in row for row in rows))

    async def test_accepted_tcp_stalled_handshake_closes_after_timeout(self):
        closed = asyncio.Event()
        received_headers = asyncio.Event()

        async def handler(reader, writer):
            try:
                while data := await reader.read(4096):
                    if b'Upgrade: websocket' in data or b'upgrade: websocket' in data.lower():
                        received_headers.set()
                    # Accept TCP and read the upgrade, but send no HTTP reply.
            finally:
                writer.close()
                await writer.wait_closed()
                closed.set()

        server = await asyncio.start_server(handler, '127.0.0.1', 0)
        async with server:
            port = server.sockets[0].getsockname()[1]
            code, _ = await self.run_probe(port, timeout=24)
            await asyncio.wait_for(closed.wait(), 2)
        self.assertTrue(received_headers.is_set(), 'Client did not send a websocket upgrade')
        self.assertNotEqual(code, 0)
        self.assertTrue(closed.is_set(), 'Stalled handshake retained its TCP connection')


if __name__ == '__main__':
    unittest.main()
