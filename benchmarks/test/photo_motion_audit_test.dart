import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:benchmarks/src/config.dart';
import 'package:benchmarks/src/plan.dart';
import 'package:benchmarks/src/visual_audit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'PhotoMotion configuration keeps controls and full-size photo paths',
    () {
      final config = BenchmarkConfig.fromJson(
        jsonDecode(File('config/photo-motion.json').readAsStringSync())
            as Map<String, dynamic>,
      );
      final plan = buildPlan(config);
      expect(plan, hasLength(6));
      expect(plan.map((test) => test.name).toSet(), {
        'Baseline',
        'Fade',
        'PhotoMotion-KenBurns',
      });
      expect(plan.map((test) => test.media.name).toSet(), {
        'photo-photo',
        'large-photo',
      });
      expect(plan.every((test) => test.unsupportedReason == null), isTrue);
      expect(config.warmups, 1);
      expect(config.repeats, 3);
      expect(config.soakSeconds, 0);
      expect(config.vulkanVideo, isFalse);
      for (final test in plan.where((test) => test.photoMotion)) {
        expect(test.effect, isNull);
        expect(test.toJson()['photo_motion'], 'kenBurns');
      }
      final allMedia = buildPlan(
        BenchmarkConfig(suite: 'smoke', effects: ['PhotoMotion-KenBurns']),
      );
      expect(
        allMedia
            .where((test) => test.unsupportedReason == null)
            .map((test) => test.media.name),
        ['photo-photo', 'large-photo'],
      );
    },
  );

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
