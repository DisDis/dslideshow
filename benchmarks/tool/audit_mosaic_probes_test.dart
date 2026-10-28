import 'dart:convert';
import 'dart:io';

import 'package:benchmarks/src/mosaic_probes.dart';
import 'package:dslideshow_flutter/src/effect/mosaic_fade_effect.dart';
import 'package:dslideshow_flutter/effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dslideshow_flutter/test/zoom_blur_effect_test.dart' as pixels;

void main() {
  testWidgets(
    'mosaic probes preserve original pixels including dense boundaries',
    (tester) async {
      final a = pixels.bitmap(false), b = pixels.bitmap(true);
      final rows = <Map<String, Object>>[];
      try {
        for (final grid in [100, 150, 200]) {
          for (final binary in [false, true]) {
            final reference = MosaicFadeEffect(
              gridSize: grid,
              fadeFraction: binary ? 0 : .3,
              seed: 42,
            );
            for (final t in [0.0, .01, .05, .13, .25, .5, .75, .95, 1.0]) {
              final expected = await pixels.capture(
                tester,
                (context) => reference.createTransformWidget(
                  context,
                  EffectSlideInput(view: pixels.slide(a)),
                  EffectSlideInput(view: pixels.slide(b)),
                  AlwaysStoppedAnimation(t),
                  160,
                  100,
                ),
              );
              for (final mode in MosaicProbe.values) {
                final effect = MosaicProbeEffect(
                  mode,
                  grid: grid,
                  binary: binary,
                  seed: 42,
                );
                final actual = await pixels.capture(
                  tester,
                  (context) => effect.createTransformWidget(
                    context,
                    EffectSlideInput(view: pixels.slide(a)),
                    EffectSlideInput(view: pixels.slide(b)),
                    AlwaysStoppedAnimation(t),
                    160,
                    100,
                  ),
                );
                var max = 0, sum = 0;
                for (var i = 0; i < expected.length; i++) {
                  final delta = (expected[i] - actual[i]).abs();
                  sum += delta;
                  if (delta > max) max = delta;
                }
                rows.add({
                  'grid': grid,
                  'binary': binary,
                  't': t,
                  'mode': mode.name,
                  'max': max,
                  'mean': sum / expected.length,
                });
              }
            }
          }
        }
        final output = Platform.environment['MOSAIC_PROBE_PIXELS'];
        if (output != null) {
          File(
            output,
          ).writeAsStringSync(const JsonEncoder.withIndent('  ').convert(rows));
        }
        for (final mode in MosaicProbe.values) {
          final errors = rows.where(
            (r) => r['mode'] == mode.name && r['max'] != 0,
          );
          debugPrint(
            '${mode.name}: ${errors.length} differing frames; ${errors.take(3).toList()}',
          );
          expect(errors, isEmpty, reason: mode.name);
        }
      } finally {
        await tester.pumpWidget(const SizedBox.shrink());
        a.dispose();
        b.dispose();
      }
    },
  );
  testWidgets('mosaic probes preserve full native 2560x1600 pixels', (
    tester,
  ) async {
    const size = Size(2560, 1600);
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final a = pixels.bitmap(false, size: size),
        b = pixels.bitmap(true, size: size);
    try {
      for (final grid in [100, 150, 200]) {
        for (final binary in [false, true]) {
          final reference = MosaicFadeEffect(
            gridSize: grid,
            fadeFraction: binary ? 0 : .3,
            seed: 42,
          );
          for (final t in [.13, .5, .87]) {
            final expected = await pixels.capture(
              tester,
              (c) => reference.createTransformWidget(
                c,
                EffectSlideInput(view: pixels.slide(a)),
                EffectSlideInput(view: pixels.slide(b)),
                AlwaysStoppedAnimation(t),
                size.width,
                size.height,
              ),
              size: size,
            );
            for (final mode in MosaicProbe.values) {
              final effect = MosaicProbeEffect(
                mode,
                grid: grid,
                binary: binary,
                seed: 42,
              );
              final actual = await pixels.capture(
                tester,
                (c) => effect.createTransformWidget(
                  c,
                  EffectSlideInput(view: pixels.slide(a)),
                  EffectSlideInput(view: pixels.slide(b)),
                  AlwaysStoppedAnimation(t),
                  size.width,
                  size.height,
                ),
                size: size,
              );
              var max = 0;
              for (var i = 0; i < expected.length; i++) {
                final delta = (expected[i] - actual[i]).abs();
                if (delta > max) max = delta;
              }
              expect(max, 0, reason: '$mode grid=$grid binary=$binary t=$t');
            }
          }
        }
      }
    } finally {
      await tester.pumpWidget(const SizedBox.shrink());
      a.dispose();
      b.dispose();
    }
  });
}
