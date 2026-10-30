import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

enum Scenario { happy, frontendNull, timeout, authRejection, disconnectPending, malformed, nestedError }

void main() {
  const secret = 'loopback-camera-probe-secret-never-log';
  final repository = p.normalize(p.join(Directory.current.path, '..'));
  late Directory directory;
  late String executable;
  setUpAll(() async {
    directory = Directory.systemTemp.createTempSync('camera-device-probe-');
    executable = p.join(directory.path, 'probe');
    final result = await Process.run(Platform.resolvedExecutable, [
      '--suppress-analytics',
      'compile',
      'exe',
      p.join(repository, 'benchmarks/tool/camera_device_probe.dart'),
      '-o',
      executable,
    ]);
    expect(result.exitCode, 0, reason: '${result.stdout}\n${result.stderr}');
  });
  tearDownAll(() => directory.deleteSync(recursive: true));

  Future<(int, String)> probe(int port, {Duration timeout = const Duration(seconds: 20)}) async {
    final process = await Process.start(executable, ['127.0.0.1:$port', '1']);
    final output = process.stdout.transform(utf8.decoder).join(), error = process.stderr.transform(utf8.decoder).join();
    process.stdin.writeln(secret);
    await process.stdin.close();
    final status = await process.exitCode.timeout(
      timeout,
      onTimeout: () {
        process.kill(ProcessSignal.sigkill);
        throw TimeoutException('Probe did not complete teardown');
      },
    );
    final result = await output, diagnostics = await error;
    // Do not include captured streams in assertion messages: they are untrusted.
    expect(result.contains(secret), false, reason: 'Auth code leaked to stdout');
    expect(diagnostics.contains(secret), false, reason: 'Auth code leaked to stderr');
    return (status, result);
  }

  Future<(int, Map<String, dynamic>)> runCase(Scenario scenario) async {
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    addTearDown(() => server.close(force: true));
    final closed = Completer<void>(), errors = <String>[], received = <(String, String?)>[];
    unawaited(() async {
      await for (final request in server) {
        final socket = await WebSocketTransformer.upgrade(request);
        try {
          await for (final raw in socket) {
            final message = jsonDecode(raw as String) as List<dynamic>,
                tag = message.first as String,
                body = message[1] as Map<String, dynamic>;
            final data = body['commandData'] as List<dynamic>?;
            received.add((tag, data?.first as String?));
            final id = body['id'];
            if (tag == 'WSAuthCommand') {
              if (body['code'] != secret) throw StateError('Unexpected local authentication input');
              if (scenario == Scenario.authRejection) {
                socket.add(
                  jsonEncode([
                    'WSErrorResult',
                    {'id': id, 'error': 'denied $secret'},
                  ]),
                );
              } else {
                socket.add(
                  jsonEncode([
                    'WSHelloCommand',
                    {'id': 77, 'type': 'ws_hello'},
                  ]),
                );
                socket.add(
                  jsonEncode([
                    'WSResultOk',
                    {'id': id},
                  ]),
                );
              }
            } else if (tag == 'WSResultOk') {
              // The diagnostic is permitted to acknowledge an unsolicited hello.
            } else if (tag == 'WSEchoCommand') {
              if (scenario == Scenario.disconnectPending) {
                await socket.close();
                break;
              }
              if (scenario == Scenario.malformed) {
                socket.add('invalid $secret');
                continue;
              }
              socket.add(
                jsonEncode([
                  'WSEchoResult',
                  {'id': id, 'msg': body['msg']},
                ]),
              );
            } else if (tag == 'WSSendRpcCommand') {
              final innerTag = data!.first as String, innerBody = data[1] as Map<String, dynamic>;
              List<dynamic> inner;
              if (innerTag == 'EchoCommand') {
                inner = [
                  'EchoCommandResult',
                  {'id': innerBody['id'], 'resultText': 'alive'},
                ];
              } else if (innerTag == 'GetFrameStateCommand') {
                if (scenario == Scenario.timeout) continue;
                inner = scenario == Scenario.nestedError
                    ? [
                        'ErrorResult',
                        {'id': innerBody['id'], 'error': 'frontend unavailable'},
                      ]
                    : [
                        'GetFrameStateResult',
                        {
                          'id': innerBody['id'],
                          'state': {
                            'frontend': scenario == Scenario.frontendNull ? null : {'isPaused': false},
                          },
                        },
                      ];
              } else {
                throw StateError('Unexpected nested RPC');
              }
              socket.add(
                jsonEncode([
                  'WSRpcResult',
                  {'id': id, 'resultData': inner},
                ]),
              );
            } else {
              throw StateError('Unexpected websocket command');
            }
          }
        } on WebSocketException {
          /* Expected connection failures are the test input. */
        } on SocketException {
          /* Closing a pending request must settle the probe. */
        } on Object catch (error) {
          errors.add(error.runtimeType.toString());
        } finally {
          await socket.close();
          if (!closed.isCompleted) closed.complete();
        }
      }
    }());
    final (status, text) = await probe(server.port);
    await closed.future.timeout(const Duration(seconds: 3));
    expect(errors, isEmpty);
    expect(
      received.every(
        (value) =>
            ['WSAuthCommand', 'WSResultOk', 'WSEchoCommand', 'WSSendRpcCommand'].contains(value.$1) &&
            [null, 'EchoCommand', 'GetFrameStateCommand'].contains(value.$2),
      ),
      true,
      reason: 'Probe sent a command outside passive read-only set',
    );
    final result = jsonDecode(text) as Map<String, dynamic>;
    expect(result['authenticated'], scenario != Scenario.authRejection);
    expect(
      result['completed'],
      ![Scenario.authRejection, Scenario.disconnectPending, Scenario.malformed].contains(scenario),
    );
    return (status, result);
  }

  Map<String, Map<String, dynamic>> kinds(Map<String, dynamic> result) => {
    for (final value in (result['samples'] as List<dynamic>).cast<Map<String, dynamic>>())
      value['kind'] as String: value,
  };
  test('auth hello web echo and nested RPC preserve passive response types', () async {
    final (status, result) = await runCase(Scenario.happy);
    final rows = kinds(result);
    expect(status, 0);
    expect(rows.keys.toSet(), {'web_echo', 'backend_echo', 'frame_state'});
    expect(rows['web_echo']!['response_type'], 'WSEchoResult');
    expect(rows['backend_echo']!['rpc_type'], 'EchoCommandResult');
    expect(rows['frame_state']!['frontend_available'], true);
  });
  test('frontend null is preserved', () async {
    final (status, result) = await runCase(Scenario.frontendNull);
    expect(status, 0);
    expect(kinds(result)['frame_state']!['frontend_available'], false);
  });
  test('frame timeout keeps successful echo samples', () async {
    final (status, result) = await runCase(Scenario.timeout);
    final rows = kinds(result);
    expect(status, 0);
    expect(rows['web_echo']!['response_type'], 'WSEchoResult');
    expect(rows['backend_echo']!['rpc_type'], 'EchoCommandResult');
    expect(rows['frame_state']!['failure_type'], 'TimeoutException');
  });
  test('auth rejection exits nonzero without exposing code', () async {
    final (status, result) = await runCase(Scenario.authRejection);
    expect(status, isNonZero);
    expect(result['samples'], isEmpty);
  });
  test('disconnect settles every pending sample', () async {
    final (status, result) = await runCase(Scenario.disconnectPending);
    final rows = kinds(result);
    expect(status, isNonZero);
    expect(rows.length, 3);
    expect(rows.values.every((row) => row.containsKey('failure_type')), true);
  });
  test('nested RPC error remains typed', () async {
    final (status, result) = await runCase(Scenario.nestedError);
    expect(status, 0);
    expect(kinds(result)['frame_state']!['rpc_type'], 'ErrorResult');
  });
  test('malformed untrusted frame is bounded and cannot leak auth', () async {
    final (status, result) = await runCase(Scenario.malformed);
    final rows = kinds(result);
    expect(status, isNonZero);
    expect(rows.length, 3);
    expect(rows.values.any((row) => row.containsKey('failure_type')), true);
  });
  test('stalled accepted TCP upgrade closes after actual connect deadline', () async {
    final server = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0),
        closed = Completer<void>(),
        upgrade = Completer<void>();
    addTearDown(server.close);
    unawaited(() async {
      await for (final socket in server) {
        try {
          await for (final bytes in socket) {
            if (utf8.decode(bytes, allowMalformed: true).toLowerCase().contains('upgrade: websocket') &&
                !upgrade.isCompleted) {
              upgrade.complete();
            }
          }
        } finally {
          socket.destroy();
          if (!closed.isCompleted) closed.complete();
        }
      }
    }());
    final (status, _) = await probe(server.port, timeout: const Duration(seconds: 24));
    await upgrade.future.timeout(const Duration(seconds: 2));
    await closed.future.timeout(const Duration(seconds: 3));
    expect(status, isNonZero);
  }, timeout: const Timeout(Duration(seconds: 30)));
}
