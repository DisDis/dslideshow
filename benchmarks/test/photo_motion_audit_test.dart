import 'dart:typed_data';

import 'package:benchmarks/src/visual_audit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'camera audit requires motion but does not require a transition to B',
    () {
      Uint8List frame(int value) =>
          Uint8List.fromList([value, value, value, 255]);
      final frames = List.generate(21, (i) => frame(i * 5));
      expect(
        assessVisualFrames(
          frames,
          frame(0),
          frame(255),
          photoMotion: true,
        )['status'],
        'passed',
      );
      expect(
        assessVisualFrames(frames, frame(0), frame(255))['status'],
        'failed',
      );
      expect(
        assessVisualFrames(
          List.filled(21, frame(0)),
          frame(0),
          frame(255),
          photoMotion: true,
        )['status'],
        'failed',
      );
    },
  );
}
