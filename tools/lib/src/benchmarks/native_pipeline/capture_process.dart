import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:path/path.dart' as p;

import 'clock.dart';
import 'posix.dart';

final _mapping = RegExp(r'^\S+\s+\S+\s+\S+\s+([0-9a-fA-F]+):([0-9a-fA-F]+)\s+(\d+)\s+(.*)$');

class EngineNotMapped implements Exception {
  const EngineNotMapped();
  @override
  String toString() => 'Engine has not been mapped yet';
}

Map<String, dynamic> captureProcess(
  int processId,
  String engine,
  String expectedSha, {
  String procRoot = '/proc',
  int Function() clock = monotonicNanoseconds,
  int Function(String) startTicks = processStartTicks,
}) {
  engine = File(engine).resolveSymbolicLinksSync();
  final process = p.join(procRoot, '$processId');
  final ticks = startTicks(process);
  final maps = File(p.join(process, 'maps')).readAsStringSync();
  final mappings = <(String, int, int, int)>[];
  for (final line in const LineSplitter().convert(maps)) {
    final match = _mapping.firstMatch(line);
    if (match == null) continue;
    final mapped = match[4]!;
    final clean = mapped.endsWith(' (deleted)') ? mapped.substring(0, mapped.length - 10) : mapped;
    if (p.basename(clean) != p.basename(engine)) continue;
    if (clean != mapped) throw StateError('Mapped engine was deleted');
    mappings.add((mapped, int.parse(match[1]!, radix: 16), int.parse(match[2]!, radix: 16), int.parse(match[3]!)));
  }
  if (mappings.isEmpty) throw const EngineNotMapped();
  final before = fileIdentity(engine);
  final device = int.parse(before[0]);
  final expected = (engine, deviceMajor(device), deviceMinor(device), int.parse(before[1]));
  if (mappings.any((value) => value != expected)) {
    throw StateError('Actual mapped engine path/device/inode differs from frozen engine');
  }
  final digest = sha256.convert(File(engine).readAsBytesSync()).toString();
  if (digest != expectedSha) throw StateError('Mapped engine SHA-256 differs from frozen engine');
  if (!sameIdentity(before, fileIdentity(engine)) || startTicks(process) != ticks) {
    throw StateError('Engine or process changed during provenance capture');
  }
  final argv = utf8.decode(File(p.join(process, 'cmdline')).readAsBytesSync()).split('\u0000');
  while (argv.isNotEmpty && argv.last.isEmpty) {
    argv.removeLast();
  }
  return {
    'schema_version': 1,
    'kind': 'native_pipeline_loaded_engine',
    'status': 'verified',
    'pid': processId,
    'process_start_ticks': ticks,
    'captured_monotonic_ns': clock(),
    'engine': {
      'path': engine,
      'sha256': digest,
      'inode': expected.$4,
      'device_major': expected.$2,
      'device_minor': expected.$3,
    },
    'argv': argv,
    'maps': maps,
    'timing_results_valid': false,
  };
}
