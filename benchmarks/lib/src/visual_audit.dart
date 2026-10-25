import 'dart:typed_data';

import 'package:crypto/crypto.dart';

double pixelDifference(Uint8List a, Uint8List b) {
  if (a.length != b.length || a.isEmpty || a.length % 4 != 0) {
    throw ArgumentError('Pixel buffers must have the same nonzero size');
  }
  var sum = 0;
  for (var i = 0; i < a.length; i += 4) {
    for (var channel = 0; channel < 3; channel++) {
      sum += (a[i + channel] - b[i + channel]).abs();
    }
  }
  return sum / (a.length / 4 * 3 * 255);
}

Map<String, Object?> assessVisualFrames(
  List<Uint8List> frames,
  Uint8List from,
  Uint8List to, {
  bool baseline = false,
  bool photoMotion = false,
}) {
  if (frames.length < 2) {
    throw ArgumentError('At least two frames are required');
  }
  final hashes = frames
      .map((bytes) => sha256.convert(bytes).toString())
      .toList();
  final sourceDifference = pixelDifference(from, to);
  final opaque = from.opaquePixels / (from.length / 4);
  var longestStatic = 0, streak = 0;
  final changes = <double>[];
  for (var i = 1; i < frames.length; i++) {
    final difference = pixelDifference(frames[i - 1], frames[i]);
    changes.add(difference);
    streak = hashes[i] == hashes[i - 1] ? streak + 1 : 0;
    if (streak > longestStatic) longestStatic = streak;
  }
  final initialError = pixelDifference(frames.first, from);
  final finalError = baseline || photoMotion
      ? null
      : pixelDifference(frames.last, to);
  final issues = <String>[
    if (!baseline && hashes.toSet().length < 5)
      'Fewer than five distinct control frames',
    if (!baseline && longestStatic >= frames.length ~/ 2)
      'Long static sequence',
    if (initialError > .01) 'Initial frame differs from source A',
    if (finalError != null && finalError > .01)
      'Final frame differs from source B',
  ];
  return {
    'status': sourceDifference < .02 || opaque < .95
        ? 'unverified_capture'
        : baseline
        ? 'static_reference'
        : issues.isEmpty
        ? 'passed'
        : 'failed',
    'issues': issues,
    'frame_count': frames.length,
    'distinct_frames': hashes.toSet().length,
    'longest_static_steps': longestStatic,
    'source_difference': sourceDifference,
    'reference_opaque_fraction': opaque,
    'initial_error': initialError,
    'final_error': finalError,
    'adjacent_mean_abs_changes': changes,
    'sha256': hashes,
    'kind': photoMotion ? 'photo_motion' : 'transition',
    'note': 'Static composition captures, not physical scanout; motion timing is measured separately',
  };
}

extension on Uint8List {
  int get opaquePixels {
    var count = 0;
    for (var i = 3; i < length; i += 4) {
      if (this[i] >= 250) count++;
    }
    return count;
  }
}
