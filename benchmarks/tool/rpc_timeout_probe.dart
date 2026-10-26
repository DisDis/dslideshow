// Reproduces result-port retention after an external RPC Future.timeout.
// Run from the repository root, using existing backend dependencies only:
//   dart --packages=backend/.dart_tool/package_config.json \
//     benchmarks/tool/rpc_timeout_probe.dart
// Prints one JSON result to stdout and exits with code 1 on an unexpected result.
// This pure Dart probe uses real production RPC transports and two result ports.
// A separate control port releases held replies, so teardown never depends on
// obtaining a free RPC result port. It does not start MQTT, Flutter or hardware.

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/serializers.dart';
// This standalone tool uses the backend package config without pub changes.
// ignore: depend_on_referenced_packages
import 'package:dslideshow_common/rpc.dart';

const _deadline = Duration(seconds: 5);
const _callerTimeout = Duration(milliseconds: 100);
const _portCount = 2;

class _ProbeService implements RpcService {
  final SendPort events;
  final _held = <EchoCommand, Completer<RpcResult>>{};

  _ProbeService(this.events);

  @override
  Future<RpcResult> executeCommand(RpcCommand command) async {
    final echo = command as EchoCommand;
    if (echo.text == 'hold') {
      final completion = Completer<RpcResult>();
      _held[echo] = completion;
      events.send(['held', echo.id]);
      return completion.future;
    }
    return EchoCommandResult(id: echo.id, resultText: 'alive');
  }

  void release() {
    for (final entry in _held.entries) {
      entry.value.complete(
        EchoCommandResult(id: entry.key.id, resultText: 'released'),
      );
    }
    _held.clear();
  }
}

void _worker(Map<String, dynamic> handshake) async {
  final remote = RemoteServiceImpl(serializers: serializers);
  remote.connect(HandshakeMessage.fromMap(handshake));
  final service = _ProbeService(remote.service.commanOPort);
  final control = ReceivePort();
  final subscription = control.listen((message) {
    if (message == 'release') service.release();
  });
  remote.service.commanOPort.send(control.sendPort);
  try {
    await remote.service.processing(service, serializers);
  } finally {
    service.release();
    await subscription.cancel();
    control.close();
    remote.service.commandIPort.close();
    for (final port in remote.service.resultIPorts) {
      port.close();
    }
    remote.service.commanOPort.send('stopped');
  }
}

Future<void> _expectTimeout(Future<RpcResult> request) async {
  try {
    await request.timeout(_callerTimeout);
  } on TimeoutException {
    return;
  }
  throw StateError('The held/queued request unexpectedly completed');
}

Future<Map<String, Object?>> _probe() async {
  final remote = RemoteServiceImpl(serializers: serializers);
  final controlReady = Completer<SendPort>();
  final stopped = Completer<void>();
  final held = <int, Completer<void>>{};
  final requests = <Future<RpcResult>>[];
  StreamSubscription<dynamic>? events;
  SendPort? control;
  var spawned = false;

  Future<RpcResult> send(int id, String text) {
    final request = remote.send(EchoCommand(id: id, text: text));
    // Keep the underlying request observable after a caller-side timeout, and
    // handle possible teardown errors even if an earlier assertion fails.
    request.ignore();
    requests.add(request);
    return request;
  }

  Future<void> hold(int id) async {
    final accepted = Completer<void>();
    held[id] = accepted;
    send(id, 'hold');
    await accepted.future.timeout(_deadline);
  }

  try {
    await remote.spawn(
      _worker,
      debugName: 'rpc-timeout-probe',
      resultIPortCount: _portCount,
    );
    spawned = true;
    events = remote.service.commandIPort.listen((dynamic message) {
      if (message is SendPort) {
        controlReady.complete(message);
      } else if (message == 'stopped') {
        stopped.complete();
      } else if (message is List && message.first == 'held') {
        held[message[1] as int]!.complete();
      }
    });
    control = await controlReady.future.timeout(_deadline);

    // Await acceptance only; the worker deliberately holds the RPC response.
    await hold(1);
    final firstEcho = await send(2, 'ping').timeout(_deadline);
    if (firstEcho is! EchoCommandResult || firstEcho.resultText != 'alive') {
      throw StateError('A concurrent Echo did not return alive');
    }

    await hold(3);
    await _expectTimeout(requests.last);
    final queuedEcho = send(4, 'ping');
    await _expectTimeout(queuedEcho);

    control.send('release');
    final replies = await Future.wait(requests).timeout(_deadline);
    if (replies.map((reply) => reply.id).join(',') != '1,2,3,4' ||
        (replies.last as EchoCommandResult).resultText != 'alive') {
      throw StateError('Replies did not recover with their original IDs');
    }
    return {
      'probe': 'rpc_external_timeout',
      'status': 'observed',
      'result_port_count': _portCount,
      'production_default_result_port_count': 5,
      'caller_timeout_ms': _callerTimeout.inMilliseconds,
      'one_held_request_allows_concurrent_echo': true,
      'caller_timeout_observed': true,
      'external_timeout_releases_transport_slot': false,
      'all_slots_held_queues_echo': true,
      'late_reply_restores_queued_echo': true,
      'reply_ids': replies.map((reply) => reply.id).toList(),
    };
  } finally {
    if (spawned) {
      control?.send('release');
      // This raw shutdown marker bypasses the exhausted request pool.
      remote.service.commanOPort.send(null);
      try {
        await stopped.future.timeout(_deadline);
      } finally {
        await events?.cancel();
        remote.service.commandIPort.close();
        for (final port in remote.service.resultIPorts) {
          port.close();
        }
        await Future.wait(
          remote.results.map((queue) async {
            await queue.cancel(immediate: true);
          }),
        );
      }
    }
  }
}

Future<void> main() async {
  try {
    final result = await _probe();
    stdout.writeln(jsonEncode({...result, 'worker_stopped': true}));
  } catch (error, stack) {
    stdout.writeln(
      jsonEncode({
        'probe': 'rpc_external_timeout',
        'status': 'failed',
        'error': error.toString(),
      }),
    );
    stderr.writeln(stack);
    exitCode = 1;
  }
}
