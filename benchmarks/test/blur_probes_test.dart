import 'package:benchmarks/src/blur_probes.dart';
import 'package:benchmarks/src/config.dart';
import 'package:benchmarks/src/plan.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('diagnostics are opt-in and their identifiers round trip', () {
    expect(
      buildPlan(BenchmarkConfig()).every((c) => c.blurProbe == null),
      true,
    );
    for (final probe in BlurFadeProbe.values) {
      expect(BlurFadeProbe.parseEffect(probe.effectName), probe);
      final plan = buildPlan(
        BenchmarkConfig.fromJson({
          'suite': 'smoke',
          'effects': [probe.effectName],
          'media_cases': ['photo-photo'],
        }),
      );
      expect(plan.single.blurProbe, probe);
      expect(plan.single.toJson()['blur_probe'], probe.name);
      expect(plan.single.id, '${probe.effectName}--photo-photo');
    }
    expect(BlurFadeProbe.parseEffect('BlurProbe-typo'), null);
    expect(
      () => buildPlan(BenchmarkConfig(effects: ['BlurProbe-typo'])),
      throwsArgumentError,
    );
  });

  test('static bitmap probes cannot freeze GIF or video', () {
    final plan = buildPlan(
      BenchmarkConfig(
        effects: ['BlurFade', ...BlurFadeProbe.values.map((p) => p.effectName)],
      ),
    );
    for (final c in plan.where((c) => c.blurProbe?.needsBitmap == true)) {
      expect(c.media.from.endsWith('.jpg'), true);
    }
    expect(
      plan.where((c) => c.blurProbe == BlurFadeProbe.directImage).length,
      4,
    );
  });
}
