// Explicit diagnostic command: reports differences, not quality acceptance.
import 'dart:convert';
import 'dart:io';

import 'package:benchmarks/src/blur_probes.dart';
import 'package:dslideshow_flutter/effect.dart';
import 'package:flutter/material.dart';

import 'dart:ui' as ui;

import 'package:flutter_test/flutter_test.dart';

import '../../dslideshow_flutter/test/zoom_blur_effect_test.dart' as pixels;

void main() {
  testWidgets('measure prototype pixels against the original blur composition', (
    tester,
  ) async {
    final a = pixels.bitmap(false), b = pixels.bitmap(true);
    final rows = <Map<String, Object>>[];
    try {
      for (final probe in BlurFadeProbe.values) {
        final effect = BlurProbeEffect(probe, bitmap: a);
        for (final t in [0.0, .05, .13, .25, .5, .75, .95, 1.0]) {
          // Direct prototypes operate on one prepared bitmap, not arbitrary
          // multi-widget content. Others must preserve the whole source group.
          Widget slide(ui.Image uiImage) => probe.needsBitmap
              ? RepaintBoundary(
                  child: RawImage(
                    image: uiImage,
                    filterQuality: FilterQuality.high,
                  ),
                )
              : pixels.slide(uiImage);
          final expected = await pixels.capture(
            tester,
            (_) => pixels.reference(slide(a), slide(b), t, blur: true),
          );
          final actual = await pixels.capture(
            tester,
            (context) => effect.createTransformWidget(
              context,
              EffectSlideInput(view: slide(a)),
              EffectSlideInput(view: slide(b)),
              AlwaysStoppedAnimation(t),
              160,
              100,
            ),
          );
          var max = 0, sum = 0, changed = 0;
          for (var i = 0; i < expected.length; i++) {
            final delta = (expected[i] - actual[i]).abs();
            if (delta > max) max = delta;
            sum += delta;
            if (delta > 0) changed++;
          }
          if ([
            BlurFadeProbe.reference,
            BlurFadeProbe.noBoundary,
            BlurFadeProbe.composeDecal,
          ].contains(probe)) {
            expect(max, 0, reason: '${probe.name} t=$t');
          }
          rows.add({
            'probe': probe.name,
            't': t,
            'max': max,
            'mean': sum / expected.length,
            'changed_channels': changed,
          });
        }
      }
      final output = Platform.environment['BLUR_PROBE_PIXELS'];
      if (output != null) {
        File(
          output,
        ).writeAsStringSync(const JsonEncoder.withIndent('  ').convert(rows));
      }
      for (final p in BlurFadeProbe.values) {
        final values = rows.where((r) => r['probe'] == p.name);
        debugPrint('${p.name}: max=${values.map((r) => r['max']).toList()}');
      }
    } finally {
      await tester.pumpWidget(const SizedBox.shrink());
      a.dispose();
      b.dispose();
    }
  });
}
