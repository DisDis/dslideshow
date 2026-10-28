import 'dart:ui' as ui;
import 'dart:io';

import 'package:crypto/crypto.dart';

import 'package:dslideshow_flutter/effect.dart';
import 'package:flutter/material.dart';

import 'support/effect_capture.dart';

import 'package:flutter_test/flutter_test.dart';

Future<ui.Image> _photo(bool incoming, {bool portrait = false}) async {
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  final width = portrait ? 80 : 160;
  final height = portrait ? 120 : 100;
  final gradient = ui.Gradient.linear(
    Offset.zero,
    Offset(width.toDouble(), height.toDouble()),
    incoming
        ? [const Color(0xff001030), const Color(0xff80f0e0)]
        : [const Color(0xff200000), const Color(0xffffa080)],
  );
  canvas.drawRect(
    Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()),
    Paint()..shader = gradient,
  );
  for (var x = 5; x < width; x += 17) {
    canvas.drawRect(
      Rect.fromLTWH(x.toDouble(), 11, 3, height - 22.0),
      Paint()..color = incoming ? Colors.white : Colors.black,
    );
  }
  final picture = recorder.endRecording();
  try {
    return await picture.toImage(width, height);
  } finally {
    picture.dispose();
    gradient.dispose();
  }
}

void main() {
  test(
    'Radial reconstruction fixture stays frozen and distinct from production',
    () {
      final reference = File('shaders/radial_shared_uv_reference.frag')
          .readAsBytesSync();
      expect(
        sha256.convert(reference).toString(),
        'f44658804c0eec4f0fec015477a82464aa5802839f97a1b61c14e64a26a65e5b',
      );
      final production = File(
        '../dslideshow_flutter/lib/src/effect/shaders/radial_blur.frag',
      ).readAsBytesSync();
      expect(
        sha256.convert(production).toString(),
        isNot(sha256.convert(reference).toString()),
      );
    },
  );
  testWidgets(
    'shared UV retains all nine rays and original camera fallback within max2',
    (tester) async {
      final from = (await tester.runAsync(() => _photo(false)))!;
      final to = (await tester.runAsync(() => _photo(true)))!;
      final referenceProgram = (await tester.runAsync(
        () => ui.FragmentProgram.fromAsset(
          'shaders/radial_shared_uv_reference.frag',
        ),
      ))!;
      var worst = 0;
      var worstMean = 0.0;
      try {
        for (final origin in EffectOrigin.values) {
          for (final angle in [0.0, 23.0, 44.0]) {
            for (final camera in [
              Matrix4.identity(),
              Matrix4.identity()
                ..translateByDouble(-5.25, 3.5, 0, 1)
                ..scaleByDouble(1.17, 1.17, 1, 1),
            ]) {
              final options = RadialBlurEffectOptions(
                origin: origin,
                angleDegrees: angle,
              );
              final baseline = RadialBlurEffect(
                options: options,
                shaderFactory: (_) => referenceProgram.fragmentShader(),
              )..bindPhotos(from, to, fromCamera: camera);
              final candidate = RadialBlurEffect(options: options)
                ..bindPhotos(from, to, fromCamera: camera);
              await tester.runAsync(() async {
                await baseline.prepare();
                await candidate.prepare();
              });
              for (final phase in [.15, .4, .75]) {
                final expected = await captureEffect(
                  tester,
                  baseline,
                  GlobalKey(),
                  phase,
                  from,
                  to,
                );
                final actual = await captureEffect(
                  tester,
                  candidate,
                  GlobalKey(),
                  phase,
                  from,
                  to,
                );
                var maximum = 0, sum = 0;
                for (var index = 0; index < actual.length; index++) {
                  final delta = (actual[index] - expected[index]).abs();
                  sum += delta;
                  if (delta > maximum) maximum = delta;
                }
                final mean = sum / actual.length;
                if (maximum > worst) worst = maximum;
                if (mean > worstMean) worstMean = mean;
                expect(
                  maximum,
                  lessThanOrEqualTo(2),
                  reason: '$origin/$angle/$phase',
                );
                expect(mean, lessThan(.05), reason: '$origin/$angle/$phase');
              }
            }
          }
        }
      } finally {
        await tester.pumpWidget(const SizedBox.shrink());
        from.dispose();
        to.dispose();
      }
      debugPrint('Radial shared UV local delta: max=$worst mean=$worstMean');
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'production shared UV reuses the shader and retains borrowed ownership',
    (tester) async {
      final from = (await tester.runAsync(() => _photo(false)))!;
      final to = (await tester.runAsync(() => _photo(true)))!;
      final shaders = <ui.FragmentShader>[];
      final effect = RadialBlurEffect(
        shaderFactory: (program) {
          final shader = program.fragmentShader();
          shaders.add(shader);
          return shader;
        },
      )..bindPhotos(from, to);
      try {
        await tester.runAsync(effect.prepare);
        final key = GlobalKey();
        for (final phase in [.2, .4, .6]) {
          expect(
            await captureEffect(tester, effect, key, phase, from, to),
            hasLength(160 * 100 * 4),
          );
        }
        expect(shaders, hasLength(1));
        expect(shaders.single.debugDisposed, isFalse);
        final before = await captureEffect(tester, effect, key, .6, from, to);
        effect.bindPhotos(to, from);
        final after = await captureEffect(tester, effect, key, .6, to, from);
        expect(after, isNot(orderedEquals(before)));
        expect(shaders, hasLength(1));
        await tester.pumpWidget(const SizedBox.shrink());
        expect(shaders.single.debugDisposed, isTrue);
        expect(from.debugDisposed, isFalse);
        expect(to.debugDisposed, isFalse);
      } finally {
        await tester.pumpWidget(const SizedBox.shrink());
        from.dispose();
        to.dispose();
      }
      expect(tester.takeException(), isNull);
    },
  );
  testWidgets('different photo aspects preserve independent contain sampling', (
    tester,
  ) async {
    final from = (await tester.runAsync(() => _photo(false)))!;
    final to = (await tester.runAsync(() => _photo(true, portrait: true)))!;
    final reference = (await tester.runAsync(
      () => ui.FragmentProgram.fromAsset(
        'shaders/radial_shared_uv_reference.frag',
      ),
    ))!;
    const options = RadialBlurEffectOptions(
      origin: EffectOrigin.bottomRight,
      angleDegrees: 23,
    );
    final baseline = RadialBlurEffect(
      options: options,
      shaderFactory: (_) => reference.fragmentShader(),
    )..bindPhotos(from, to);
    final candidate = RadialBlurEffect(options: options)..bindPhotos(from, to);
    try {
      await tester.runAsync(() async {
        await baseline.prepare();
        await candidate.prepare();
      });
      final expected = await captureEffect(
        tester,
        baseline,
        GlobalKey(),
        .43,
        from,
        to,
      );
      final actual = await captureEffect(
        tester,
        candidate,
        GlobalKey(),
        .43,
        from,
        to,
      );
      var maximum = 0;
      for (var index = 0; index < actual.length; index++) {
        final delta = (actual[index] - expected[index]).abs();
        if (delta > maximum) maximum = delta;
      }
      expect(maximum, lessThanOrEqualTo(2));
    } finally {
      await tester.pumpWidget(const SizedBox.shrink());
      from.dispose();
      to.dispose();
    }
  });
}
