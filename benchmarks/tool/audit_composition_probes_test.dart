import 'package:benchmarks/src/composition_probes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dslideshow_flutter/test/composition_effect_test.dart' as pixels;
import '../../dslideshow_flutter/test/support/composition_reference.dart';

void main() {
  for (final probe in [
    CompositionProbe.accordionReference,
    CompositionProbe.accordionGrouped,
    CompositionProbe.liquidReference,
  ]) {
    testWidgets('${probe.name} matches the independent regression reference', (
      tester,
    ) async {
      await pixels.compare(
        tester,
        probe.createEffect(),
        probe.effect == CompositionProbe.accordionReference.effect
            ? ReferenceAccordionEffect()
            : ReferenceLiquidMorphEffect(),
      );
    });
  }
  for (final probe in [
    CompositionProbe.liquidBounded,
    CompositionProbe.liquidRectTail,
  ]) {
    testWidgets('${probe.name} preserves full resolution reference pixels', (
      tester,
    ) async {
      final effect = probe.createEffect();
      final reference = ReferenceLiquidMorphEffect();
      await pixels.compare(tester, effect, reference);
      const size = Size(2560, 1600);
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = size;
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetPhysicalSize);
      await pixels.compare(
        tester,
        effect,
        reference,
        size: size,
        progress: List.generate(21, (i) => i / 20),
      );
    });
  }
}
