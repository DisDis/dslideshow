import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:path/path.dart' as p;

import '../json_io.dart';
import 'binary.dart';
import 'clock.dart';
import 'posix.dart';

final _sha = RegExp(r'^[0-9a-f]{64}$');

Map<String, dynamic> verifyCapture(
  String attempt, {
  String procRoot = '/proc',
  int Function() clock = monotonicNanoseconds,
  (Uint8List, List<String>) Function(String) takeSnapshot = snapshot,
  void Function(String) absent = assertProcessAbsent,
}) {
  final native = p.join(attempt, 'native-pipeline.bin');
  final (raw, nativeIdentity) = takeSnapshot(native);
  final h = decodeHeader(raw);
  final int processId = (h['pid'] as int),
      reserved = (h['reserved_count'] as int),
      committed = (h['committed_count'] as int),
      started = (h['start_monotonic_ns'] as int),
      closed = (h['closed_monotonic_ns'] as int);
  if (h['magic'] != 'NPIPV001' ||
      h['version'] != 1 ||
      h['endian'] != 0x01020304 ||
      h['header_size'] != 128 ||
      h['record_size'] != 128 ||
      processId <= 0 ||
      h['flags'] != 3 ||
      h['init_errno'] != 0) {
    throw StateError('Invalid native capture header');
  }
  if (reserved <= 0 ||
      reserved != committed ||
      reserved > (h['capacity'] as int) ||
      h['dropped_count'] != 0 ||
      h['clock_errors'] != 0 ||
      ![1, 2].contains(h['lifecycle']) ||
      raw.length != 128 + (h['capacity'] as int) * 128) {
    throw StateError('Incomplete or invalid native capture');
  }
  absent(p.join(procRoot, '$processId'));
  var lastEnd = started;
  for (var index = 0; index < reserved; index++) {
    final v = decodeRecord(Uint8List.sublistView(raw, 128 + index * 128, 256 + index * 128));
    if (v[0] != 1 || v[3] != index + 1 || v[4] < started || v[5] < v[4] || v[7] < v[6]) {
      throw StateError('Incomplete or invalid native record');
    }
    if (v[5] > lastEnd) lastEnd = v[5];
  }
  final launchPath = p.join(attempt, 'launcher-status.json');
  final (launchBytes, launchIdentity) = takeSnapshot(launchPath);
  final launch = asMap(decodeStrictJson(utf8.decode(launchBytes)));
  if (launch['exit_code'] is! int || launch['exit_code'] != 0) {
    throw StateError('Launcher does not confirm a successful process exit');
  }
  final proofPath = p.join(attempt, 'native-pipeline-provenance.json');
  final (proofBytes, proofIdentity) = takeSnapshot(proofPath);
  final proof = asMap(decodeStrictJson(utf8.decode(proofBytes)));
  final engine = asMap(proof['engine']);
  if (proof['schema_version'] != 1 ||
      proof['kind'] != 'native_pipeline_loaded_engine' ||
      proof['status'] != 'verified' ||
      proof['pid'] != processId ||
      proof['process_start_ticks'] is! int ||
      (proof['process_start_ticks'] as int) <= 0 ||
      engine['path'] is! String ||
      !p.isAbsolute(engine['path'] as String) ||
      engine['sha256'] is! String ||
      !_sha.hasMatch(engine['sha256'] as String) ||
      proof['timing_results_valid'] != false ||
      proof['captured_monotonic_ns'] is! int ||
      (proof['captured_monotonic_ns'] as int) < started) {
    throw StateError('Loaded-engine proof does not identify this process');
  }
  for (final (path, identity, original) in [
    (native, nativeIdentity, raw),
    (launchPath, launchIdentity, launchBytes),
    (proofPath, proofIdentity, proofBytes),
  ]) {
    final (bytes, current) = takeSnapshot(path);
    if (!sameIdentity(identity, current) || !sameBytes(bytes, original)) {
      throw StateError('File changed during finalization: $path');
    }
  }
  absent(p.join(procRoot, '$processId'));
  final validated = clock();
  if (validated < lastEnd || validated < closed || validated < (proof['captured_monotonic_ns'] as int)) {
    throw StateError('Capture belongs to a different or invalid monotonic clock');
  }
  return {
    'schema_version': 1,
    'kind': 'native_pipeline_external_finalization',
    'status': 'verified',
    'pid': processId,
    'process_start_ticks': proof['process_start_ticks'],
    'native_capture': {'sha256': sha256.convert(raw).toString(), 'size_bytes': raw.length},
    'launcher_status': {
      'file': 'launcher-status.json',
      'sha256': sha256.convert(launchBytes).toString(),
      'exit_code': 0,
    },
    'engine_provenance_sha256': sha256.convert(proofBytes).toString(),
    'process_absent': true,
    'hash_stable': true,
    'validated_at_monotonic_ns': validated,
    'raw_lifecycle': h['lifecycle'],
    'raw_closed_monotonic_ns': closed,
    'reserved_count': reserved,
    'committed_count': committed,
    'timing_results_valid': false,
  };
}

bool sameBytes(List<int> a, List<int> b) =>
    a.length == b.length && Iterable<int>.generate(a.length).every((i) => a[i] == b[i]);
