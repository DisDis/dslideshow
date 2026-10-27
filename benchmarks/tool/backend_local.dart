// Pure Dart backend measurements. No Flutter, hardware service or network setup.
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/serializers.dart';
import 'package:dslideshow_backend/src/service/hardware/src/hardware_service_config.dart';
import 'package:dslideshow_backend/src/service/storage/disk/disk_storage.dart';
import 'package:dslideshow_backend/src/service/storage/disk/disk_storage_config.dart';
import 'package:dslideshow_backend/src/service/system_info/system_info_service.dart';
// This standalone tool runs with the backend package config, without pub changes.
// ignore: depend_on_referenced_packages
import 'package:dslideshow_common/rpc.dart';

final _whitespacePattern = RegExp(r'\s+');
final _rssPattern = RegExp(r'^VmRSS:\s+(\d+) kB', multiLine: true);
final _hwmPattern = RegExp(r'^VmHWM:\s+(\d+) kB', multiLine: true);
final _threadsPattern = RegExp(r'^Threads:\s+(\d+)', multiLine: true);

Map<String, String> options(List<String> args) {
  final result = <String, String>{};
  for (final argument in args) {
    final split = argument.indexOf('=');
    if (!argument.startsWith('--') || split < 3) {
      throw FormatException('Expected --name=value: $argument');
    }
    result[argument.substring(2, split)] = argument.substring(split + 1);
  }
  return result;
}

Future<Map<String, Object?>> processSnapshot() async {
  final status = await File('/proc/self/status').readAsString();
  final stat = await File('/proc/self/stat').readAsString();
  final fields = stat
      .substring(stat.lastIndexOf(')') + 1)
      .trim()
      .split(_whitespacePattern);
  int? kib(RegExp pattern) {
    final value = pattern.firstMatch(status)?[1];
    return value == null ? null : int.parse(value) * 1024;
  }

  final ticks = int.parse(Platform.environment['BENCHMARK_CLK_TCK'] ?? '100');
  return {
    'rss_bytes': kib(_rssPattern),
    'hwm_bytes': kib(_hwmPattern),
    'cpu_ms': (int.parse(fields[11]) + int.parse(fields[12])) * 1000 / ticks,
    'threads': int.tryParse(_threadsPattern.firstMatch(status)?[1] ?? ''),
    'open_fds': await Directory('/proc/self/fd').list().length,
  };
}

double milliseconds(Stopwatch watch) => watch.elapsedMicroseconds / 1000;

Future<Map<String, Object?>> storageCycle(int count) async {
  if (count < 1) throw ArgumentError.value(count, 'count');
  final storage = DiskStorage(DiskStorageConfig());
  try {
    final before = await processSnapshot();
    final firstWatch = Stopwatch()..start();
    final first = await storage.next();
    final firstMs = milliseconds(firstWatch);
    final selected = <String?>[first?.id];
    final remainingWatch = Stopwatch()..start();
    for (var index = 1; index < count; index++) {
      selected.add((await storage.next())?.id);
    }
    final remainingMs = milliseconds(remainingWatch);
    final after = await processSnapshot();
    final unique = selected.toSet();
    if (unique.contains(null) || unique.length != count) {
      throw StateError('Cycle lost or repeated files: ${unique.length}/$count');
    }
    if ((await storage.getNext())?.id != selected.last ||
        (await storage.getCurrent())?.id !=
            (count == 1 ? null : selected[count - 2])) {
      throw StateError('Inconsistent current/next pair');
    }
    return {
      'kind': 'storage',
      'count': count,
      'index_first_selection_ms': firstMs,
      'remaining_selection_ms': remainingMs,
      'whole_cycle_ms': firstMs + remainingMs,
      'selected_count': selected.length,
      'unique_count': unique.length,
      'before': before,
      'after': after,
    };
  } finally {
    await storage.release();
  }
}

class LoopProbe {
  final Stopwatch clock = Stopwatch()..start();
  final List<Map<String, Object?>> samples = [];
  late final Timer timer;
  int nextDue = 5000;
  LoopProbe() {
    timer = Timer.periodic(const Duration(milliseconds: 5), (_) {
      final now = clock.elapsedMicroseconds;
      final lag = (now - nextDue).clamp(0, 1 << 60);
      final skipped = lag ~/ 5000;
      samples.add({
        'due_us': nextDue,
        'actual_us': now,
        'lag_ms': lag / 1000,
        'skipped_intervals': skipped,
      });
      nextDue += (skipped + 1) * 5000;
    });
  }
}

class ProbeService implements RpcService {
  final DiskStorage storage = DiskStorage(DiskStorageConfig());
  final LoopProbe loop = LoopProbe();
  @override
  Future<RpcResult> executeCommand(RpcCommand command) async {
    if (command is! EchoCommand) {
      throw ArgumentError('Only EchoCommand probes are supported');
    }
    var result = 'pong';
    if (command.text == 'index') {
      final watch = Stopwatch()..start();
      try {
        await storage.next();
      } catch (error) {
        // A failed worker operation must complete its RPC instead of leaving
        // the client waiting until the outer process deadline.
        return EchoCommandResult(
          id: command.id,
          resultText: jsonEncode({'error': '$error'}),
        );
      }
      result = jsonEncode({'index_first_selection_ms': milliseconds(watch)});
    } else if (command.text == 'stats') {
      result = jsonEncode({'event_loop_samples': loop.samples});
    }
    return EchoCommandResult(id: command.id, resultText: result);
  }
}

void probeWorker(Map<String, dynamic> handshake) async {
  final remote = RemoteServiceImpl(serializers: serializers);
  final service = ProbeService();
  remote.connect(HandshakeMessage.fromMap(handshake));
  try {
    await remote.service.processing(service, serializers);
  } finally {
    service.loop.timer.cancel();
    await service.storage.release();
    remote.service.commandIPort.close();
    for (final port in remote.service.resultIPorts) {
      port.close();
    }
  }
}

Future<Map<String, Object?>> responsiveness() async {
  final remote = RemoteServiceImpl(serializers: serializers);
  await remote.spawn(probeWorker, debugName: 'backend-local-probe');
  final rows = <Map<String, Object?>>[];
  final pending = <Future<void>>{};
  final clock = Stopwatch()..start();
  var nextDue = 5000;
  var dropped = 0;
  Future<EchoCommandResult> send(String text) async =>
      (await remote.send(EchoCommand(text: text, id: RpcCommand.generateId())))
          as EchoCommandResult;
  final timer = Timer.periodic(const Duration(milliseconds: 5), (_) {
    final actual = clock.elapsedMicroseconds;
    final missed = ((actual - nextDue).clamp(0, 1 << 60)) ~/ 5000;
    final due = nextDue;
    nextDue += (missed + 1) * 5000;
    if (pending.length >= 4) {
      dropped += missed + 1;
      rows.add({
        'due_us': due,
        'sent_us': null,
        'skipped_intervals': missed,
        'status': 'capacity_skipped',
      });
      return;
    }
    dropped += missed;
    final row = <String, Object?>{
      'due_us': due,
      'sent_us': actual,
      'skipped_intervals': missed,
    };
    rows.add(row);
    late final Future<void> operation;
    operation = send('ping')
        .then((_) {
          row['received_us'] = clock.elapsedMicroseconds;
          row['latency_ms'] = (clock.elapsedMicroseconds - actual) / 1000;
          row['scheduled_latency_ms'] =
              (clock.elapsedMicroseconds - due) / 1000;
          row['status'] = 'ok';
        })
        .whenComplete(() => pending.remove(operation));
    pending.add(operation);
  });
  try {
    await Future<void>.delayed(const Duration(milliseconds: 60));
    final start = clock.elapsedMicroseconds;
    final result = await send('index');
    final indexResult = jsonDecode(result.resultText!) as Map<String, dynamic>;
    if (indexResult.containsKey('error')) {
      throw StateError('Worker scan failed: ${indexResult['error']}');
    }
    final end = clock.elapsedMicroseconds;
    await Future<void>.delayed(const Duration(milliseconds: 60));
    timer.cancel();
    await Future.wait(pending.toList());
    final stats =
        jsonDecode((await send('stats')).resultText!) as Map<String, dynamic>;
    return {
      'kind': 'responsiveness',
      'index_start_us': start,
      'index_end_us': end,
      'index': indexResult,
      'rpc_probes': rows,
      'dropped_probe_intervals': dropped,
      ...stats,
      'process': await processSnapshot(),
    };
  } finally {
    timer.cancel();
    // Shut down the worker's processing loop, then close all client receive ports.
    remote.service.commanOPort.send(null);
    remote.service.commandIPort.close();
    for (final port in remote.service.resultIPorts) {
      port.close();
    }
  }
}

Future<Map<String, Object?>> metrics(int repeats, int intervalMs) async {
  final config = HardwareConfig.fromJson({
    'systemDiskDev': Platform.environment['BENCHMARK_DISK_SOURCE'] ?? 'overlay',
    'sensorsScript': Platform.environment['BENCHMARK_SENSOR_SCRIPT']!,
  });
  final service = SystemInfoService(config);
  final rows = <Map<String, Object?>>[];
  Future<void> collect(String phase, int concurrency) async {
    final before = await processSnapshot();
    final watch = Stopwatch()..start();
    final values = await Future.wait(
      List.generate(concurrency, (_) => service.getUpdateInfo()),
    );
    final elapsed = milliseconds(watch);
    rows.add({
      'phase': phase,
      'concurrency': concurrency,
      'elapsed_ms': elapsed,
      'snapshots': values.map((value) => value.toJson()).toList(),
      'before': before,
      'after': await processSnapshot(),
    });
  }

  await collect('cold', 1);
  await collect('immediate', 1);
  for (var index = 0; index < repeats; index++) {
    await Future<void>.delayed(Duration(milliseconds: intervalMs));
    await collect('expired_refresh', 1);
  }
  for (final concurrency in [2, 5]) {
    await Future<void>.delayed(Duration(milliseconds: intervalMs));
    await collect('expired_burst', concurrency);
    await collect('cached_burst', concurrency);
  }
  return {'kind': 'metrics', 'interval_ms': intervalMs, 'rows': rows};
}

Future<void> main(List<String> arguments) async {
  var code = 0;
  try {
    final args = options(arguments);
    final result = switch (args['scenario']) {
      'storage' => await storageCycle(int.parse(args['count']!)),
      'responsiveness' => await responsiveness(),
      'metrics' => await metrics(
        int.parse(args['repeats'] ?? '3'),
        int.parse(args['interval-ms'] ?? '1100'),
      ),
      _ => throw ArgumentError('Unknown --scenario'),
    };
    stdout.writeln(
      jsonEncode({
        'status': 'ok',
        'pid': pid,
        'dart': Platform.version,
        ...result,
      }),
    );
  } catch (error, stack) {
    code = 2;
    stdout.writeln(
      jsonEncode({'status': 'failed', 'error': '$error', 'stack': '$stack'}),
    );
  }
  // Explicitly exit: the baseline RPC pool retains receive-port queues.
  exit(code);
}
