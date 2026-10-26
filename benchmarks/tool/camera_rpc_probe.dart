// Pure Dart transport diagnostic; no device, Flutter engine, or MQTT broker.
// From benchmarks/:
// DART_SUPPRESS_ANALYTICS=true /home/dis/bin/flutter/bin/cache/dart-sdk/bin/dart \
//   --packages=.dart_tool/package_config.json tool/camera_rpc_probe.dart
// Optional: --timeout-ms=10000 --requests=8
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/serializers.dart';
// This diagnostic uses existing transitive package configuration, without pub.
// ignore: depend_on_referenced_packages
import 'package:dslideshow_common/rpc.dart';
import 'package:dslideshow_flutter/src/service/camera_snapshot_client.dart';

enum FailureMode { stalledHeaders, stalledBody, refusedConnection }

class EchoService implements RpcService {
  @override
  Future<RpcResult> executeCommand(RpcCommand command) async {
    if (command is! EchoCommand) {
      throw ArgumentError('Only EchoCommand is supported by this diagnostic');
    }
    return EchoCommandResult(id: command.id, resultText: command.text);
  }
}

Future<void> closeRemote(RemoteServiceImpl remote) async {
  remote.service.commandIPort.close();
  for (final port in remote.service.resultIPorts) {
    port.close();
  }
  for (final result in remote.results) {
    await result.cancel(immediate: true);
  }
}

void echoWorker(Map<String, dynamic> handshake) async {
  final remote = RemoteServiceImpl(serializers: serializers);
  remote.connect(HandshakeMessage.fromMap(handshake));
  try {
    await remote.service.processing(EchoService(), serializers);
  } finally {
    await closeRemote(remote);
  }
}

class LocalFailureEndpoint {
  final ServerSocket? server;
  final int port;
  final sockets = <Socket>{};
  StreamSubscription<Socket>? subscription;
  var accepted = 0;
  var requestsReceived = 0;
  LocalFailureEndpoint._(this.server, this.port);

  static Future<LocalFailureEndpoint> open(FailureMode mode) async {
    final server = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
    if (mode == FailureMode.refusedConnection) {
      final port = server.port;
      await server.close();
      return LocalFailureEndpoint._(null, port);
    }
    final result = LocalFailureEndpoint._(server, server.port);
    result.subscription = server.listen((socket) {
      result.accepted++;
      result.sockets.add(socket);
      var replied = false;
      socket.listen(
        (_) {
          if (replied) return;
          replied = true;
          result.requestsReceived++;
          if (mode == FailureMode.stalledBody) {
            socket.add(
              ascii.encode(
                'HTTP/1.1 200 OK\r\n'
                'Content-Type: image/jpeg\r\n'
                'Content-Length: 100000\r\n'
                'Connection: close\r\n\r\n',
              ),
            );
            // Valid JPEG signature, but never send the remaining declared body.
            socket.add([255, 216, 255]);
          }
        },
        onError: (Object _) {
          result.sockets.remove(socket);
          socket.destroy();
        },
        onDone: () {
          result.sockets.remove(socket);
          socket.destroy();
        },
      );
    });
    return result;
  }

  Future<void> close() async {
    await subscription?.cancel();
    await server?.close();
    for (final socket in sockets.toList()) {
      socket.destroy();
    }
    sockets.clear();
  }
}

Map<String, Object?> summary(List<int> values) {
  if (values.isEmpty) return {'count': 0, 'p99_ms': null, 'max_ms': null};
  final sorted = values.toList()..sort();
  return {
    'count': sorted.length,
    'p99_ms': sorted[((sorted.length - 1) * .99).ceil()] / 1000,
    'max_ms': sorted.last / 1000,
    'largest_ms': sorted.reversed.take(5).map((v) => v / 1000).toList(),
  };
}

int longestGap(int begin, int end, Iterable<int> timestamps) {
  var previous = begin;
  var longest = 0;
  for (final timestamp in timestamps.toList()..sort()) {
    longest = math.max(longest, timestamp - previous);
    previous = timestamp;
  }
  return math.max(longest, end - previous);
}

Future<Map<String, Object?>> runCase(
  FailureMode mode,
  RemoteServiceImpl remote,
  Duration timeout,
  int requestCount,
) async {
  final endpoint = await LocalFailureEndpoint.open(mode);
  final camera = CameraSnapshotClient(timeout: timeout);
  final clock = Stopwatch()..start();
  final heartbeatSamples = <({int at, int lag, int skipped})>[];
  final rpcSamples = <({int sent, int received})>[];
  final rpcTimerSamples = <({int at, int skipped, bool capacitySkip})>[];
  final snapshotResults = <Map<String, Object?>>[];
  final rpcErrors = <String, int>{};
  final pending = <Future<void>>{};
  var skippedHeartbeatIntervals = 0;
  var skippedRpcIntervals = 0;
  var nextHeartbeat = 10000;
  var nextRpc = 50000;
  var rpcCapacitySkips = 0;
  final heartbeat = Timer.periodic(const Duration(milliseconds: 10), (_) {
    final now = clock.elapsedMicroseconds;
    final lag = (now - nextHeartbeat).clamp(0, 1 << 60);
    final skipped = lag ~/ 10000;
    heartbeatSamples.add((at: now, lag: lag, skipped: skipped));
    skippedHeartbeatIntervals += skipped;
    nextHeartbeat += (skipped + 1) * 10000;
  });
  final rpcTimer = Timer.periodic(const Duration(milliseconds: 50), (_) {
    final sent = clock.elapsedMicroseconds;
    final skipped = (sent - nextRpc).clamp(0, 1 << 60) ~/ 50000;
    skippedRpcIntervals += skipped;
    nextRpc += (skipped + 1) * 50000;
    rpcTimerSamples.add((
      at: sent,
      skipped: skipped,
      capacitySkip: pending.length >= 4,
    ));
    if (pending.length >= 4) {
      rpcCapacitySkips++;
      return;
    }
    late Future<void> operation;
    operation = () async {
      try {
        final id = RpcCommand.generateId();
        final result = await remote
            .send(EchoCommand(id: id, text: 'camera-transport-probe'))
            .timeout(const Duration(seconds: 2));
        if (result is! EchoCommandResult ||
            result.id != id ||
            result.resultText != 'camera-transport-probe') {
          throw StateError('Echo result mismatch');
        }
        rpcSamples.add((sent: sent, received: clock.elapsedMicroseconds));
      } catch (error) {
        final kind = error.runtimeType.toString();
        rpcErrors.update(kind, (count) => count + 1, ifAbsent: () => 1);
      }
    }().whenComplete(() => pending.remove(operation));
    pending.add(operation);
  });
  try {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    final begin = clock.elapsedMicroseconds;
    await Future.wait(
      List.generate(requestCount, (index) async {
        final started = clock.elapsedMicroseconds;
        try {
          await camera.fetch(
            'request-$index',
            CameraConfig(
              id: 'local-diagnostic',
              url: 'http://127.0.0.1:${endpoint.port}/snapshot.jpg',
            ),
          );
          snapshotResults.add({
            'index': index,
            'status': 'unexpected_success',
            'elapsed_ms': (clock.elapsedMicroseconds - started) / 1000,
          });
        } catch (error) {
          snapshotResults.add({
            'index': index,
            'status': 'error',
            'error_type': error.runtimeType.toString(),
            'expected_failure': mode == FailureMode.refusedConnection
                ? error is SocketException
                : error is TimeoutException,
            'elapsed_ms': (clock.elapsedMicroseconds - started) / 1000,
          });
        }
      }),
    ).timeout(timeout * ((requestCount + 3) ~/ 4) + const Duration(seconds: 5));
    final end = clock.elapsedMicroseconds;
    await Future<void>.delayed(const Duration(milliseconds: 150));
    rpcTimer.cancel();
    heartbeat.cancel();
    await Future.wait(pending.toList());
    snapshotResults.sort(
      (a, b) => (a['index'] as int).compareTo(b['index'] as int),
    );
    final windowUs = end - begin;
    final windowRpc = rpcSamples
        .where((sample) => sample.sent >= begin && sample.received <= end)
        .toList();
    final windowHeartbeats = heartbeatSamples
        .where((sample) => sample.at >= begin && sample.at <= end)
        .toList();
    final windowRpcTimers = rpcTimerSamples
        .where((sample) => sample.at >= begin && sample.at <= end)
        .toList();
    final windowRpcSkipped = windowRpcTimers.fold<int>(
      0,
      (total, sample) => total + sample.skipped,
    );
    final windowCapacitySkipped = windowRpcTimers
        .where((sample) => sample.capacitySkip)
        .length;
    final windowHeartbeatSkipped = windowHeartbeats.fold<int>(
      0,
      (total, sample) => total + sample.skipped,
    );
    final rpcGapUs = longestGap(
      begin,
      end,
      windowRpc.map((sample) => sample.received),
    );
    final heartbeatGapUs = longestGap(
      begin,
      end,
      windowHeartbeats.map((sample) => sample.at),
    );
    // This is a responsiveness check, not a tight performance threshold.
    // Allow brief JIT/host scheduling noise, but require samples throughout
    // the stalled request window. Warmup/tail samples cannot satisfy it.
    const longStallUs = 2000000;
    final minimumRpcSamples = math.max(1, windowUs ~/ 100000);
    final minimumHeartbeats = math.max(1, windowUs ~/ 20000);
    final allowedRpcSkipped = math.max(1, windowUs ~/ 500000);
    final allowedHeartbeatSkipped = math.max(1, windowUs ~/ 100000);
    final coverageRequired = mode != FailureMode.refusedConnection;
    final coverageChecks = {
      'rpc_samples_in_window': windowRpc.length >= minimumRpcSamples,
      'heartbeat_samples_in_window':
          windowHeartbeats.length >= minimumHeartbeats,
      'rpc_no_long_gap': rpcGapUs < longStallUs,
      'heartbeat_no_long_gap': heartbeatGapUs < longStallUs,
      'rpc_no_long_round_trip': windowRpc.every(
        (sample) => sample.received - sample.sent < longStallUs,
      ),
      'rpc_skips_within_budget':
          windowRpcSkipped + windowCapacitySkipped <= allowedRpcSkipped,
      'heartbeat_skips_within_budget':
          windowHeartbeatSkipped <= allowedHeartbeatSkipped,
    };
    final coveragePassed =
        !coverageRequired || coverageChecks.values.every((passed) => passed);
    final casePassed =
        rpcSamples.isNotEmpty &&
        rpcErrors.isEmpty &&
        snapshotResults.every((sample) => sample['expected_failure'] == true) &&
        coveragePassed;
    return {
      'mode': mode.name,
      'passed': casePassed,
      'request_timeout_ms': timeout.inMilliseconds,
      'request_count': requestCount,
      'max_concurrent': camera.maxConcurrent,
      'snapshot_window_ms': (end - begin) / 1000,
      'accepted_connections': endpoint.accepted,
      'requests_received': endpoint.requestsReceived,
      'snapshots': snapshotResults,
      'heartbeat_lag': summary(heartbeatSamples.map((s) => s.lag).toList()),
      'heartbeat_skipped_intervals': skippedHeartbeatIntervals,
      'rpc_round_trip': summary(
        rpcSamples.map((sample) => sample.received - sample.sent).toList(),
      ),
      'rpc_errors': rpcErrors,
      'rpc_successes_sent_during_snapshots': rpcSamples
          .where((sample) => sample.sent >= begin && sample.sent <= end)
          .length,
      'rpc_round_trip_during_snapshots': summary(
        windowRpc.map((sample) => sample.received - sample.sent).toList(),
      ),
      'heartbeat_lag_during_snapshots': summary(
        windowHeartbeats.map((sample) => sample.lag).toList(),
      ),
      'snapshot_window_coverage': {
        'required': coverageRequired,
        'passed': coveragePassed,
        'checks': coverageChecks,
        'long_stall_threshold_ms': longStallUs / 1000,
        'minimum_rpc_successes': minimumRpcSamples,
        'minimum_heartbeat_samples': minimumHeartbeats,
        'allowed_rpc_skipped_intervals': allowedRpcSkipped,
        'allowed_heartbeat_skipped_intervals': allowedHeartbeatSkipped,
        'rpc_max_completion_gap_ms': rpcGapUs / 1000,
        'heartbeat_max_gap_ms': heartbeatGapUs / 1000,
        'rpc_skipped_intervals': windowRpcSkipped,
        'rpc_capacity_skips': windowCapacitySkipped,
        'heartbeat_skipped_intervals': windowHeartbeatSkipped,
      },
      'rpc_skipped_intervals': skippedRpcIntervals,
      'rpc_capacity_skips': rpcCapacitySkips,
    };
  } finally {
    rpcTimer.cancel();
    heartbeat.cancel();
    camera.dispose();
    await endpoint.close();
    await Future.wait(pending.toList());
  }
}

Future<void> main(List<String> args) async {
  var timeoutMs = 10000;
  var requests = 8;
  for (final arg in args) {
    if (arg.startsWith('--timeout-ms=')) {
      timeoutMs = int.parse(arg.substring('--timeout-ms='.length));
    } else if (arg.startsWith('--requests=')) {
      requests = int.parse(arg.substring('--requests='.length));
    } else {
      throw ArgumentError('Expected --timeout-ms=N or --requests=N');
    }
  }
  if (timeoutMs <= 0 || requests <= 0) {
    throw ArgumentError('Timeout and request count must be positive');
  }
  final remote = RemoteServiceImpl(serializers: serializers);
  await remote.spawn(echoWorker, debugName: 'camera-rpc-probe');
  try {
    final results = <Map<String, Object?>>[];
    for (final mode in FailureMode.values) {
      results.add(
        await runCase(
          mode,
          remote,
          Duration(milliseconds: timeoutMs),
          requests,
        ),
      );
    }
    final passed = results.every((result) => result['passed'] == true);
    stdout.writeln(
      jsonEncode({
        'diagnostic': 'camera_snapshot_real_io_and_echo_rpc',
        'passed': passed,
        'dart_version': Platform.version.split(' ').first,
        'utc': DateTime.now().toUtc().toIso8601String(),
        'limitations': [
          'Localhost TCP failures; no DNS, Wi-Fi, physical device, or Flutter UI',
          'Real RPC transport with Echo service; no MQTT connection or broker',
          'Refused connection uses a recently closed ephemeral loopback port',
        ],
        'results': results,
      }),
    );
    await stdout.flush();
    if (!passed) exitCode = 1;
  } finally {
    remote.service.commanOPort.send(null);
    await closeRemote(remote);
  }
}
