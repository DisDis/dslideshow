import 'package:benchmarks/src/composition_probes.dart';
import 'package:benchmarks/src/config.dart';
import 'package:benchmarks/src/plan.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('composition controls are opt-in, unique and support live media', () {
    expect(
      buildPlan(BenchmarkConfig()).every((c) => c.compositionProbe == null),
      true,
    );
    final plan = buildPlan(
      BenchmarkConfig(
        effects: CompositionProbe.values.map((p) => p.effectName).toList(),
      ),
    );
    expect(plan.length, CompositionProbe.values.length * mediaPairs.length);
    expect(plan.map((c) => c.id).toSet().length, plan.length);
    for (final c in plan) {
      expect(c.toJson()['composition_probe'], c.compositionProbe!.name);
      expect(c.name, c.compositionProbe!.effectName);
      expect(c.effect, c.compositionProbe!.effect);
    }
    expect(
      () => buildPlan(BenchmarkConfig(effects: ['CompositionProbe-typo'])),
      throwsArgumentError,
    );
  });
}
