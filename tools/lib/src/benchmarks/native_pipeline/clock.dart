import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';

import '../../third_party/posix_clock.g.dart' as native;

int monotonicNanoseconds() {
  if (!Platform.isLinux || sizeOf<IntPtr>() != 8) throw UnsupportedError('Native diagnostics require Linux LP64');
  final value = calloc<native.timespec>();
  try {
    if (native.clock_gettime(1, value) != 0) throw StateError('CLOCK_MONOTONIC unavailable');
    return value.ref.tv_sec * 1000000000 + value.ref.tv_nsec;
  } finally {
    calloc.free(value);
  }
}
