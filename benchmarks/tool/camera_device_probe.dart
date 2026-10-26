// Read-only live-frame RPC probe. Pass the current web auth code on stdin.
// dart --packages=benchmarks/.dart_tool/package_config.json \
//   benchmarks/tool/camera_device_probe.dart HOST [SECONDS]
// Does not change settings or send frame/MQTT control commands.
import 'dart:async';
import 'dart:convert';
import 'dart:io';

Future<void> main(List<String> args) async {
  if (args.isEmpty || args.length > 2) {
    stderr.writeln('Usage: camera_device_probe.dart HOST[:PORT] [SECONDS]');
    exitCode = 64;
    return;
  }
  final duration = int.parse(args.length > 1 ? args[1] : '240');
  if (duration < 1 || duration > 1800) {
    throw ArgumentError('Invalid duration');
  }
  final code = stdin.readLineSync();
  if (code == null || code.isEmpty) {
    throw ArgumentError('Auth code on stdin required');
  }
  final authority = args[0].contains(':') ? args[0] : '${args[0]}:8080';
  final client = HttpClient();
  late final WebSocket socket;
  var connectExpired = false;
  try {
    socket = await WebSocket.connect('ws://$authority/ws', customClient: client)
        .then((value) {
          if (connectExpired) unawaited(value.close());
          return value;
        })
        .timeout(const Duration(seconds: 15));
  } catch (_) {
    connectExpired = true;
    client.close(force: true);
    rethrow;
  }
  final pending = <int, Completer<List<dynamic>>>{};
  var nextId = 1000000;
  final samples = <Map<String, Object?>>[];
  var authenticated = false;
  var completed = false;
  var connectionClosed = false;
  String? runFailure;
  void failPending(Object error) {
    for (final completion in pending.values.toList()) {
      if (!completion.isCompleted) completion.completeError(error);
    }
    pending.clear();
  }

  final subscription = socket.listen(
    (raw) {
      try {
        final message = jsonDecode(raw as String) as List<dynamic>;
        final body = message[1] as Map<String, dynamic>;
        pending.remove(body['id'])?.complete(message);
      } catch (_) {
        connectionClosed = true;
        runFailure = 'MalformedResponse';
        failPending(const FormatException('Malformed WebSocket response'));
        unawaited(socket.close());
      }
    },
    onError: (Object error) {
      connectionClosed = true;
      failPending(error);
    },
    onDone: () {
      connectionClosed = true;
      failPending(StateError('WebSocket closed'));
    },
  );
  Future<List<dynamic>> send(String tag, Map<String, Object?> data) async {
    final id = nextId++;
    final completion = Completer<List<dynamic>>();
    if (connectionClosed) throw StateError('WebSocket closed');
    pending[id] = completion;
    try {
      socket.add(
        jsonEncode([
          tag,
          {...data, 'id': id},
        ]),
      );
      return await completion.future.timeout(const Duration(seconds: 6));
    } finally {
      pending.remove(id);
    }
  }

  Future<void> sample(
    String kind,
    String tag,
    Map<String, Object?> data,
  ) async {
    final start = DateTime.now().toUtc().toIso8601String();
    final clock = Stopwatch()..start();
    try {
      final result = await send(tag, data);
      final body = result[1] as Map<String, dynamic>;
      final inner = body['resultData'] as List<dynamic>?;
      samples.add({
        'utc': start,
        'kind': kind,
        'elapsed_ms': clock.elapsedMicroseconds / 1000,
        'response_type': result.first,
        if (inner != null) 'rpc_type': inner.first,
        if (kind == 'frame_state' && inner?.first == 'GetFrameStateResult')
          'frontend_available': (inner![1]['state'] as Map)['frontend'] != null,
      });
    } catch (error) {
      samples.add({
        'utc': start,
        'kind': kind,
        'elapsed_ms': clock.elapsedMicroseconds / 1000,
        'failure_type': error.runtimeType.toString(),
      });
    }
  }

  try {
    final auth = await send('WSAuthCommand', {
      'type': 'ws_auth',
      'userName': 'camera-diagnostic',
      'code': code,
    });
    if (auth.first != 'WSResultOk') throw StateError('Authentication failed');
    authenticated = true;
    final watch = Stopwatch()..start();
    while (watch.elapsed.inSeconds < duration && !connectionClosed) {
      await Future.wait([
        sample('web_echo', 'WSEchoCommand', {
          'type': 'ws_echo',
          'msg': 'probe',
        }),
        sample('backend_echo', 'WSSendRpcCommand', {
          'type': 'ws_rpc',
          'commandData': [
            'EchoCommand',
            {'type': 'echo', 'id': nextId++, 'text': 'probe'},
          ],
        }),
        sample('frame_state', 'WSSendRpcCommand', {
          'type': 'ws_rpc',
          'commandData': [
            'GetFrameStateCommand',
            {'type': 'get_frame_state', 'id': nextId++},
          ],
        }),
      ]);
      await Future<void>.delayed(const Duration(seconds: 1));
    }
    completed = !connectionClosed;
    if (!completed) runFailure ??= 'ConnectionClosed';
  } catch (error) {
    runFailure ??= error.runtimeType.toString();
  } finally {
    await socket.close().timeout(const Duration(seconds: 3), onTimeout: () {});
    await subscription.cancel();
    client.close(force: true);
    stdout.writeln(
      const JsonEncoder.withIndent('  ').convert({
        'scope': 'read-only live web/backend/frontend probe; no MQTT commands',
        'authenticated': authenticated,
        'completed': completed,
        'run_failure_type': ?runFailure,
        'samples': samples,
      }),
    );
    if (!completed) exitCode = 1;
  }
}
