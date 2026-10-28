import 'package:dslideshow_flutter/src/effect/accordion_effect.dart';
import 'package:dslideshow_flutter/src/effect/liquid_morph_effect.dart';
import 'package:dslideshow_flutter/src/effect/media_slider_item_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/composition_reference.dart';
import 'zoom_blur_effect_test.dart' as pixels;

Future<void> compare(
  WidgetTester tester,
  MediaSliderItemEffect actual,
  MediaSliderItemEffect reference, {
  Size size = const Size(160, 100),
  List<double> progress = const [0, .001, .05, .13, .25, .5, .75, .95, .999, 1],
}) async {
  final a = pixels.bitmap(false, size: size);
  final b = pixels.bitmap(true, size: size);
  try {
    for (final t in progress) {
      Future<List<int>> frame(MediaSliderItemEffect effect) => pixels.capture(
        tester,
        (context) => effect.createTransformWidget(
          context,
          EffectSlideInput(view: pixels.slide(a)),
          EffectSlideInput(view: pixels.slide(b)),
          AlwaysStoppedAnimation(t),
          size.width,
          size.height,
        ),
        size: size,
      );
      final expected = await frame(reference);
      final observed = await frame(actual);
      var max = 0, changed = 0;
      for (var i = 0; i < expected.length; i++) {
        final delta = (expected[i] - observed[i]).abs();
        if (delta > max) max = delta;
        if (delta > 0) changed++;
      }
      expect(changed, 0, reason: '${actual.runtimeType} $size t=$t max=$max');
    }
  } finally {
    await tester.pumpWidget(const SizedBox.shrink());
    a.dispose();
    b.dispose();
  }
}

void main() {
  testWidgets(
    'Accordion preserves squeezing, shadow rounding and transparency',
    (tester) async {
      for (final size in [const Size(160, 100), const Size(97, 163)]) {
        await compare(
          tester,
          AccordionEffect(),
          ReferenceAccordionEffect(),
          size: size,
        );
      }
    },
  );

  testWidgets('LiquidMorph preserves wave geometry and anti-aliased edges', (
    tester,
  ) async {
    for (final count in [1, 12, 25]) {
      for (final intensity in [0.0, 15.0, 90.0]) {
        final effect = LiquidMorphEffect(
          waveCount: count,
          waveIntensity: intensity,
        );
        final reference = ReferenceLiquidMorphEffect(
          waveCount: count,
          waveIntensity: intensity,
        );
        for (final size in [const Size(160, 100), const Size(97, 163)]) {
          await compare(tester, effect, reference, size: size);
        }
      }
    }
  });

  testWidgets('Both preserve full-resolution RaPi5 pixels', (tester) async {
    const size = Size(2560, 1600);
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = size;
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    final progress = List.generate(21, (i) => i / 20);
    await compare(
      tester,
      AccordionEffect(),
      ReferenceAccordionEffect(),
      size: size,
      progress: progress,
    );
    await compare(
      tester,
      LiquidMorphEffect(),
      ReferenceLiquidMorphEffect(),
      size: size,
      progress: progress,
    );
  });

  testWidgets(
    'Both keep source states mounted across endpoints and reverse progress',
    (tester) async {
      for (final effect in <MediaSliderItemEffect>[
        AccordionEffect(),
        LiquidMorphEffect(),
      ]) {
        var fromMounts = 0, toMounts = 0;
        final from = _MountProbe(() => fromMounts++);
        final to = _MountProbe(() => toMounts++);
        for (final t in [0.0, .01, .5, .99, 1.0, .5, 0.0]) {
          await tester.pumpWidget(
            Directionality(
              textDirection: TextDirection.ltr,
              child: Builder(
                builder: (context) => effect.createTransformWidget(
                  context,
                  EffectSlideInput(view: from),
                  EffectSlideInput(view: to),
                  AlwaysStoppedAnimation(t),
                  160,
                  100,
                ),
              ),
            ),
          );
          expect(fromMounts, 1);
          expect(toMounts, 1);
        }
        await tester.pumpWidget(const SizedBox.shrink());
      }
    },
  );
}

class _MountProbe extends StatefulWidget {
  final VoidCallback onMount;
  const _MountProbe(this.onMount);
  @override
  State<_MountProbe> createState() => _MountProbeState();
}

class _MountProbeState extends State<_MountProbe> {
  @override
  void initState() {
    super.initState();
    widget.onMount();
  }

  @override
  Widget build(BuildContext context) => const SizedBox.expand();
}
