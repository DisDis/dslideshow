import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

enum PipelineFunction {
  eglSwap(1, 'eglSwapBuffers'),
  eglMakeCurrent(2, 'eglMakeCurrent'),
  gbmLock(3, 'gbm_surface_lock_front_buffer'),
  gbmRelease(4, 'gbm_surface_release_buffer'),
  drmAtomic(5, 'drmModeAtomicCommit'),
  drmPageFlip(6, 'drmModePageFlip'),
  eglCreateWindow(7, 'eglCreateWindowSurface');

  const PipelineFunction(this.id, this.label);
  final int id;
  final String label;
}

enum NativeClosure {
  normalDestructor('normal_destructor'),
  externalFinalization('external_finalization'),
  unverified('unverified');

  const NativeClosure(this.wire);
  final String wire;
  static NativeClosure parse(Object? value) => values.firstWhere((item) => item.wire == value);
}

Map<String, dynamic> decodeHeader(Uint8List raw) {
  if (raw.length < 128) throw const FormatException('truncated native header');
  final data = ByteData.sublistView(raw);
  return {
    'magic': ascii.decode(raw.sublist(0, 8)),
    for (final (index, key) in [
      'version',
      'endian',
      'header_size',
      'record_size',
      'capacity',
      'pid',
      'flags',
      'init_errno',
    ].indexed)
      key: data.getUint32(8 + index * 4, Endian.little),
    for (final (index, key) in [
      'reserved_count',
      'committed_count',
      'dropped_count',
      'start_monotonic_ns',
      'start_realtime_ns',
      'closed_monotonic_ns',
    ].indexed)
      key: data.getUint64(40 + index * 8, Endian.little),
    'lifecycle': data.getUint32(88, Endian.little),
    'clock_errors': data.getUint32(92, Endian.little),
  };
}

List<int> decodeRecord(Uint8List raw) {
  if (raw.length != 128) throw const FormatException('truncated native record');
  final data = ByteData.sublistView(raw);
  return [
    data.getUint32(0, Endian.little),
    data.getUint16(4, Endian.little),
    data.getUint16(6, Endian.little),
    for (var i = 0; i < 5; i++) data.getUint64(8 + i * 8, Endian.little),
    data.getUint32(48, Endian.little),
    data.getInt32(52, Endian.little),
    data.getInt64(56, Endian.little),
    for (var i = 0; i < 6; i++) data.getUint64(64 + i * 8, Endian.little),
    data.getUint32(112, Endian.little),
  ];
}

Map<String, dynamic> readNative(String path) {
  final diagnostics = <String>[], warnings = <String>[], calls = <Map<String, dynamic>>[];
  var header = <String, dynamic>{};
  try {
    final source = File(path).openSync();
    try {
      header = decodeHeader(source.readSync(128));
      final h = header;
      if (h['magic'] != 'NPIPV001' ||
          h['version'] != 1 ||
          h['endian'] != 0x01020304 ||
          h['header_size'] != 128 ||
          h['record_size'] != 128 ||
          (h['capacity'] as int) <= 0 ||
          (h['pid'] as int) <= 0 ||
          (h['start_monotonic_ns'] as int) <= 0) {
        throw const FormatException('unsupported/invalid native binary header');
      }
      final int capacity = (h['capacity'] as int),
          reserved = (h['reserved_count'] as int),
          committed = (h['committed_count'] as int);
      final int started = (h['start_monotonic_ns'] as int), closed = (h['closed_monotonic_ns'] as int);
      if (source.lengthSync() != 128 + capacity * 128) {
        diagnostics.add('native file length differs from preallocated header capacity');
      }
      if (h['init_errno'] != 0 || h['clock_errors'] != 0) {
        diagnostics.add(
          'native initialization/clock errors: errno=${h['init_errno']}, clock_errors=${h['clock_errors']}',
        );
      }
      if (h['flags'] != 3) diagnostics.add('native v1 capture flags do not identify instrumented mmap timings');
      if (h['dropped_count'] != 0 || reserved > capacity) {
        diagnostics.add(
          'native capture overflow: dropped=${h['dropped_count']}, reserved=$reserved, capacity=$capacity',
        );
      }
      if (![1, 2].contains(h['lifecycle']) || (closed != 0 && closed < started)) {
        diagnostics.add('invalid native lifecycle timestamps');
      }
      if (h['lifecycle'] == 2 && closed == 0) diagnostics.add('normal native destructor has no closing timestamp');
      if (h['lifecycle'] != 2 || closed == 0) {
        warnings.add('native capture has no normal-destructor closure; committed records remain observable');
      }
      var observed = 0, pending = 0;
      for (var index = 0; index < (reserved < capacity ? reserved : capacity); index++) {
        final raw = source.readSync(128);
        if (raw.length != 128) {
          diagnostics.add('native record ${index + 1}: truncated');
          break;
        }
        final v = decodeRecord(raw);
        if (v[0] == 0) {
          pending++;
          continue;
        }
        if (v[0] != 1) {
          diagnostics.add('native record ${index + 1}: unknown commit state ${v[0]}');
          continue;
        }
        observed++;
        final functions = PipelineFunction.values.where((f) => f.id == v[1]);
        if (functions.isEmpty) {
          diagnostics.add('native record ${index + 1}: unknown function ${v[1]}');
          continue;
        }
        if (v[3] != index + 1 ||
            v[8] == 0 ||
            v[4] < started ||
            v[5] < v[4] ||
            v[7] < v[6] ||
            v[7] - v[6] > v[5] - v[4] + 1000 ||
            (closed != 0 && v[5] > closed)) {
          diagnostics.add('native record ${index + 1}: invalid sequence/clock/thread fields');
          continue;
        }
        final function = functions.single;
        final failed = switch (function) {
          PipelineFunction.eglSwap ||
          PipelineFunction.eglMakeCurrent ||
          PipelineFunction.gbmLock ||
          PipelineFunction.eglCreateWindow => v[10] == 0,
          PipelineFunction.drmAtomic || PipelineFunction.drmPageFlip => v[10] != 0,
          PipelineFunction.gbmRelease => false,
        };
        calls.add({
          'function': function.label,
          'function_id': function.id,
          'sequence': v[3],
          'depth': v[2],
          'start_ns': v[4],
          'end_ns': v[5],
          'cpu_start_ns': v[6],
          'cpu_end_ns': v[7],
          'tid': v[8],
          'result': v[10],
          'result_errno': v[9],
          'entry_errno': v[17],
          'args': [
            for (final arg in v.sublist(11, 17))
              '0x${BigInt.from(arg).toUnsigned(64).toRadixString(16).padLeft(16, '0')}',
          ],
          'failed': failed,
        });
      }
      h.addAll({'observed_committed': observed, 'pending_count': pending});
      if (pending != 0 || observed != committed || committed > reserved) {
        diagnostics.add('native uncommitted/counter mismatch: pending=$pending, header=$committed, observed=$observed');
      }
      if (calls.isEmpty) diagnostics.add('native capture contains no valid committed calls');
    } finally {
      source.closeSync();
    }
  } on Object catch (error) {
    diagnostics.add('$path: $error');
  }
  header.remove('magic');
  final closed = header['lifecycle'] == 2 && (header['closed_monotonic_ns'] ?? 0) != 0;
  return {
    'path': path,
    'header': header,
    'calls': calls,
    'diagnostics': diagnostics,
    'warnings': warnings,
    'complete': header.isNotEmpty && diagnostics.isEmpty && closed,
    'closure': (closed ? NativeClosure.normalDestructor : NativeClosure.unverified).wire,
    'effective_end_ns': closed ? header['closed_monotonic_ns'] : null,
    'clock': 'CLOCK_MONOTONIC',
    'cpu_clock': 'CLOCK_THREAD_CPUTIME_ID',
  };
}
