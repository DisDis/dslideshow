import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dslideshow_flutter/effect.dart';
import 'package:dslideshow_flutter/src/effect/geometric_transition_effect.dart';
import 'package:dslideshow_flutter/src/effect/glass_effect.dart';
import 'package:dslideshow_flutter/src/effect/optical_transition_effect.dart';
import 'package:dslideshow_flutter/src/effect/soft_wipe_effect.dart';
import 'package:dslideshow_flutter/src/effect/slice_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

import 'zoom_blur_effect_test.dart' as pixels;

final _effects = <Effect>[
  Effect.softWipeEffect,
  (const Effect(
    EffectType.softWipe,
    options: SoftWipeEffectOptions(style: SoftWipeStyle.lightSweep),
  )),
  Effect.sliceEffect,
  Effect.lumaFadeEffect,
  Effect.pagePeelEffect,
  Effect.lightLeakEffect,
  Effect.filmRollEffect,
  Effect.crossZoomEffect,
  Effect.whipEffect,
  Effect.glassEffect,
  Effect.clockWipeEffect,
  Effect.splitEffect,
  Effect.panelWipeEffect,
  Effect.stretchEffect,
  Effect.starWipeEffect,
  Effect.filmDissolveEffect,
  Effect.frameEffect,
  Effect.louverEffect,
  Effect.mirrorEffect,
  (const Effect(
    EffectType.softWipe,
    options: SoftWipeEffectOptions(style: SoftWipeStyle.neon),
  )),
  Effect.burnAlphaEffect,
  Effect.foldMotionEffect,
  Effect.glowEffect,
  Effect.kaleidoscopeEffect,
  Effect.tvPowerEffect,
  Effect.springMotionEffect,
  Effect.shapeDissolveEffect,
  Effect.vhsDamageEffect,
  Effect.radialBlurEffect,
  Effect.phosphorEffect,
];

List<int> _pixel(Uint8List image, int x, int y, {int width = 160}) =>
    image.sublist((y * width + x) * 4, (y * width + x) * 4 + 4);

Future<Uint8List> _frame(
  WidgetTester tester,
  Effect descriptor,
  double progress, {
  Widget from = const ColoredBox(color: Color(0xffff0000)),
  Widget to = const ColoredBox(color: Color(0xff0000ff)),
  Size size = const Size(160, 100),
}) => pixels.capture(
  tester,
  (context) => descriptor.createEffect().createTransformWidget(
    context,
    EffectSlideInput(view: from),
    EffectSlideInput(view: to),
    AlwaysStoppedAnimation(progress),
    size.width,
    size.height,
  ),
  size: size,
);

void main() {
  test('new persisted names round-trip and support every media pair', () {
    expect(_effects.map((e) => e.name), [
      'Soft Wipe',
      'Soft Wipe',
      'Slice',
      'Luma Fade',
      'Page Peel',
      'Light Leak',
      'Film Roll',
      'Cross Zoom',
      'Whip',
      'Glass',
      'Clock Wipe',
      'Split',
      'Panel Wipe',
      'Stretch',
      'Star Wipe',
      'Film Dissolve',
      'Frame',
      'Louver',
      'Mirror',
      'Soft Wipe',
      'Burn Alpha',
      'Fold Motion',
      'Glow',
      'Kaleidoscope',
      'TV Power',
      'Spring Motion',
      'Shape Dissolve',
      'VHS Damage',
      'Radial Blur',
      'Phosphor',
    ]);
    for (final effect in _effects) {
      expect(
        Effect.values.map((e) => e.type),
        contains(canonicalEffectType(effect.type)),
      );
      expect(Effect.parse(effect.name).type, effect.type);
      expect(
        Effect.fromConfig(
          effect.type,
          EffectConfig.fromJson(effect.type, effect.toConfig().toJson()),
        ),
        effect.canonical,
      );
      for (final from in TransitionMedia.values) {
        for (final to in TransitionMedia.values) {
          expect(effect.supportsMedia(from, to), isTrue);
        }
      }
    }
  });

  testWidgets(
    'exact endpoints and evolving opaque frames in both orientations',
    (tester) async {
      for (final size in [const Size(160, 100), const Size(97, 163)]) {
        const source = DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.red, Colors.black],
            ),
          ),
        );
        final from = await pixels.capture(tester, (_) => source, size: size);
        final to = await pixels.capture(
          tester,
          (_) => const ColoredBox(color: Color(0xff0000ff)),
          size: size,
        );
        for (final effect in _effects) {
          expect(
            await _frame(tester, effect, 0, size: size, from: source),
            from,
            reason: '${effect.name} start $size',
          );
          expect(
            await _frame(tester, effect, 1, size: size, from: source),
            to,
            reason: '${effect.name} end $size',
          );
          final frames = <String>{};
          for (final t in [.15, .35, .55, .75, .95]) {
            final frame = await _frame(
              tester,
              effect,
              t,
              size: size,
              from: source,
            );
            frames.add(frame.toString());
            expect(
              [for (var i = 3; i < frame.length; i += 4) frame[i]],
              everyElement(255),
              reason: '${effect.name} alpha at $t',
            );
          }
          expect(frames.length, greaterThanOrEqualTo(4), reason: effect.name);
        }
      }
      await tester.pumpWidget(const SizedBox());
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('soft wipe has a feathered edge; sweep lights that edge only', (
    tester,
  ) async {
    final soft = await _frame(tester, Effect.softWipeEffect, .5);
    final light = await _frame(
      tester,
      (const Effect(
        EffectType.softWipe,
        options: SoftWipeEffectOptions(style: SoftWipeStyle.lightSweep),
      )),
      .5,
    );
    expect(_pixel(soft, 5, 50), [0, 0, 255, 255]);
    expect(_pixel(soft, 155, 50), [255, 0, 0, 255]);
    final edge = _pixel(soft, 80, 50);
    expect(edge[0], inExclusiveRange(20, 235));
    expect(edge[2], inExclusiveRange(20, 235));
    expect(_pixel(light, 80, 50)[1], greaterThan(100));
    expect(_pixel(light, 5, 50), _pixel(soft, 5, 50));
    expect(_pixel(light, 155, 50), _pixel(soft, 155, 50));
  });

  testWidgets(
    'letterboxed and transparent media have opaque endpoint backing',
    (tester) async {
      const letterboxed = Center(
        child: SizedBox(
          width: 80,
          height: 50,
          child: ColoredBox(color: Colors.white),
        ),
      );
      const transparent = ColoredBox(color: Color(0x80ff0000));
      for (final source in [letterboxed, transparent]) {
        final expected = await pixels.capture(tester, (_) => source);
        for (final descriptor in _effects) {
          expect(
            await _frame(tester, descriptor, 0, from: source),
            expected,
            reason: '${descriptor.name} start',
          );
          expect(
            await _frame(tester, descriptor, 1, to: source),
            expected,
            reason: '${descriptor.name} end',
          );
        }
      }
    },
  );

  testWidgets('luma fade removes bright pixels before dark pixels', (
    tester,
  ) async {
    const source = Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(child: ColoredBox(color: Color(0xff202020))),
        Expanded(child: ColoredBox(color: Color(0xffe0e0e0))),
      ],
    );
    final frame = await _frame(tester, Effect.lumaFadeEffect, .5, from: source);
    expect(_pixel(frame, 20, 50), [32, 32, 32, 255]);
    expect(_pixel(frame, 140, 50), [0, 0, 255, 255]);
    // Identical images must not dim/brighten during the dissolve.
    const gray = ColoredBox(color: Color(0xff777777));
    final same = await _frame(
      tester,
      Effect.lumaFadeEffect,
      .5,
      from: gray,
      to: gray,
    );
    expect(_pixel(same, 80, 50), [119, 119, 119, 255]);
  });

  testWidgets('slice moves image content in alternating delayed strips', (
    tester,
  ) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    canvas.drawColor(const Color(0xffff0000), BlendMode.src);
    canvas.drawRect(
      const Rect.fromLTWH(78, 0, 4, 100),
      Paint()..color = const Color(0xff00ff00),
    );
    final picture = recorder.endRecording();
    final image = picture.toImageSync(160, 100);
    picture.dispose();
    try {
      final frame = await _frame(
        tester,
        Effect.sliceEffect,
        .3,
        from: RawImage(image: image),
      );
      List<int> greenXs(int y) => [
        for (var x = 0; x < 160; x++)
          if (_pixel(frame, x, y)[1] > 80) x,
      ];
      expect(
        greenXs(6).reduce((a, b) => a + b) / greenXs(6).length,
        lessThan(60),
      );
      expect(
        greenXs(18).reduce((a, b) => a + b) / greenXs(18).length,
        greaterThan(100),
      );
      expect(greenXs(93), [78, 79, 80, 81]);
    } finally {
      await tester.pumpWidget(const SizedBox());
      image.dispose();
    }
  });

  testWidgets('page peel exposes the corner and a shaded paper back', (
    tester,
  ) async {
    final frame = await _frame(tester, Effect.pagePeelEffect, .4);
    expect(_pixel(frame, 158, 1), [0, 0, 255, 255]);
    expect(_pixel(frame, 1, 98), [255, 0, 0, 255]);
    final paper = _pixel(frame, 60, 30);
    expect(paper[0], greaterThan(120));
    expect(paper[1], greaterThan(120));
    expect(paper[2], greaterThan(120));
    expect(_pixel(frame, 60, 5), isNot(paper), reason: 'Fold has shading');
  });

  testWidgets('light leak sweeps a warm light over even identical dark media', (
    tester,
  ) async {
    const black = ColoredBox(color: Colors.black);
    final early = await _frame(
      tester,
      Effect.lightLeakEffect,
      .25,
      from: black,
      to: black,
    );
    final middle = await _frame(
      tester,
      Effect.lightLeakEffect,
      .5,
      from: black,
      to: black,
    );
    final late = await _frame(
      tester,
      Effect.lightLeakEffect,
      .75,
      from: black,
      to: black,
    );
    expect(_pixel(middle, 80, 30)[0], greaterThan(150));
    final warm = _pixel(middle, 20, 70);
    expect(warm[0], greaterThan(warm[2]));
    expect(early, isNot(late), reason: 'The light moves across the frame');
  });

  testWidgets(
    'film roll moves vertically and whip moves with horizontal blur',
    (tester) async {
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder)..drawColor(Colors.black, BlendMode.src);
      canvas.drawRect(
        const Rect.fromLTWH(78, 0, 4, 100),
        Paint()..color = const Color(0xff00ff00),
      );
      canvas.drawRect(
        const Rect.fromLTWH(0, 48, 160, 4),
        Paint()..color = const Color(0xffff0000),
      );
      final picture = recorder.endRecording();
      final image = picture.toImageSync(160, 100);
      picture.dispose();
      try {
        final source = RawImage(image: image);
        final film = await _frame(
          tester,
          Effect.filmRollEffect,
          .25,
          from: source,
        );
        // The horizontal red marker moves up while the vertical green marker
        // stays at its original x position, away from the film's edge holes.
        expect(_pixel(film, 40, 43)[0], greaterThan(100));
        expect(_pixel(film, 40, 50)[0], lessThan(10));
        expect(_pixel(film, 80, 20)[1], greaterThan(200));
        final whip = await _frame(tester, Effect.whipEffect, .25, from: source);
        expect(_pixel(whip, 70, 20)[1], greaterThan(_pixel(whip, 80, 20)[1]));
        expect(
          _pixel(whip, 66, 20)[1],
          greaterThan(10),
          reason: 'Motion blur spreads beyond the four-pixel marker',
        );
        expect(_pixel(whip, 40, 50)[0], greaterThan(200));
      } finally {
        await tester.pumpWidget(const SizedBox());
        image.dispose();
      }
    },
  );

  testWidgets('cross zoom enlarges outgoing detail and softens its edges', (
    tester,
  ) async {
    const source = Center(
      child: SizedBox(
        width: 40,
        height: 20,
        child: ColoredBox(color: Colors.white),
      ),
    );
    final frame = await _frame(
      tester,
      Effect.crossZoomEffect,
      .5,
      from: source,
      to: const ColoredBox(color: Colors.black),
    );
    expect(
      _pixel(frame, 56, 50)[0],
      greaterThan(50),
      reason: 'Outgoing content expands beyond its original x=60 boundary',
    );
    expect(
      _pixel(frame, 52, 50)[0],
      inExclusiveRange(0, 100),
      reason: 'The zoom has a soft edge',
    );
    expect(
      _pixel(frame, 80, 50)[0],
      closeTo(128, 8),
      reason: 'The midpoint remains close to a half blend under easing',
    );
  });

  testWidgets('glass displaces live image detail in separate facets', (
    tester,
  ) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder)..drawColor(Colors.black, BlendMode.src);
    for (var x = 0; x < 160; x += 8) {
      canvas.drawRect(
        Rect.fromLTWH(x.toDouble(), 0, 3, 100),
        Paint()..color = const Color(0xff00ff00),
      );
    }
    final picture = recorder.endRecording();
    final image = picture.toImageSync(160, 100);
    picture.dispose();
    try {
      final source = RawImage(image: image);
      final frame = await _frame(
        tester,
        Effect.glassEffect,
        .5,
        from: source,
        to: source,
      );
      final original = await pixels.capture(tester, (_) => source);
      var displacedBars = 0;
      for (var x = 0; x < 160; x++) {
        if (_pixel(frame, x, 50)[1] > 180 && _pixel(original, x, 50)[1] < 10) {
          displacedBars++;
        }
      }
      expect(
        displacedBars,
        greaterThan(10),
        reason: 'Refraction moves the bars, in addition to the glass glint',
      );
    } finally {
      await tester.pumpWidget(const SizedBox());
      image.dispose();
    }
  });

  testWidgets('clock wipe opens clockwise from twelve oclock', (tester) async {
    final quarter = await _frame(tester, Effect.clockWipeEffect, .25);
    expect(_pixel(quarter, 120, 20), [0, 0, 255, 255]);
    expect(_pixel(quarter, 120, 80), [255, 0, 0, 255]);
    expect(_pixel(quarter, 40, 20), [255, 0, 0, 255]);
    final half = await _frame(tester, Effect.clockWipeEffect, .5);
    expect(_pixel(half, 120, 80), [0, 0, 255, 255]);
    expect(_pixel(half, 40, 80), [255, 0, 0, 255]);
    final threeQuarters = await _frame(tester, Effect.clockWipeEffect, .75);
    expect(_pixel(threeQuarters, 40, 80), [0, 0, 255, 255]);
    expect(_pixel(threeQuarters, 40, 20), [255, 0, 0, 255]);
  });

  testWidgets('split moves the two image halves away from the center', (
    tester,
  ) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder)
      ..drawColor(const Color(0xffff0000), BlendMode.src);
    for (final x in [24.0, 132.0]) {
      canvas.drawRect(
        Rect.fromLTWH(x, 0, 4, 100),
        Paint()..color = const Color(0xff00ff00),
      );
    }
    final picture = recorder.endRecording();
    final image = picture.toImageSync(160, 100);
    picture.dispose();
    try {
      final frame = await _frame(
        tester,
        Effect.splitEffect,
        .25,
        from: RawImage(image: image),
      );
      final left = <int>[], right = <int>[];
      for (var x = 0; x < 160; x++) {
        if (_pixel(frame, x, 50)[1] > 100) (x < 80 ? left : right).add(x);
      }
      expect(left, isNotEmpty);
      expect(right, isNotEmpty);
      expect(left.reduce((a, b) => a + b) / left.length, lessThan(22));
      expect(right.reduce((a, b) => a + b) / right.length, greaterThan(138));
      expect(_pixel(frame, 80, 50), [0, 0, 255, 255]);
      expect(_pixel(frame, 5, 50), [255, 0, 0, 255]);
    } finally {
      await tester.pumpWidget(const SizedBox());
      image.dispose();
    }
  });

  testWidgets('panel wipe alternates directions and delays lower panels', (
    tester,
  ) async {
    final frame = await _frame(tester, Effect.panelWipeEffect, .5);
    expect(_pixel(frame, 5, 6), [0, 0, 255, 255]);
    expect(_pixel(frame, 155, 6), [255, 0, 0, 255]);
    expect(_pixel(frame, 5, 18), [255, 0, 0, 255]);
    expect(_pixel(frame, 155, 18), [0, 0, 255, 255]);
    expect(_pixel(frame, 80, 6), [0, 0, 255, 255]);
    expect(_pixel(frame, 80, 93), [255, 0, 0, 255]);
    const size = Size(161, 103);
    for (final count in [1, 8, 13]) {
      for (final t in [0.0, 1.0]) {
        final pixelsAtEndpoint = await pixels.capture(
          tester,
          (context) =>
              GeometricTransitionEffect(
                GeometricTransitionKind.panelWipe,
                panelCount: count,
              ).createTransformWidget(
                context,
                EffectSlideInput(
                  view: const ColoredBox(color: Color(0xffff0000)),
                ),
                EffectSlideInput(
                  view: const ColoredBox(color: Color(0xff0000ff)),
                ),
                AlwaysStoppedAnimation(t),
                size.width,
                size.height,
              ),
          size: size,
        );
        expect([
          for (var i = 0; i < pixelsAtEndpoint.length; i += 4)
            pixelsAtEndpoint[i],
        ], everyElement(t == 0 ? 255 : 0));
      }
    }
  });

  testWidgets('stretch expands horizontal detail without changing its height', (
    tester,
  ) async {
    const source = Center(
      child: SizedBox(
        width: 20,
        height: 20,
        child: ColoredBox(color: Colors.white),
      ),
    );
    final frame = await _frame(
      tester,
      Effect.stretchEffect,
      .5,
      from: source,
      to: const ColoredBox(color: Colors.black),
    );
    expect(_pixel(frame, 62, 50)[0], greaterThan(100));
    expect(_pixel(frame, 80, 35), [0, 0, 0, 255]);
    expect(_pixel(frame, 80, 50)[0], closeTo(128, 8));
  });

  testWidgets('star wipe reveals a pointed star instead of a circular iris', (
    tester,
  ) async {
    final frame = await _frame(tester, Effect.starWipeEffect, .4);
    expect(_pixel(frame, 80, 50), [0, 0, 255, 255]);
    expect(_pixel(frame, 80, 20), [0, 0, 255, 255]);
    expect(_pixel(frame, 60, 20), [255, 0, 0, 255]);
    expect(_pixel(frame, 80, 85), [255, 0, 0, 255]);
  });

  testWidgets(
    'film dissolve blends linear light and preserves exact endpoints',
    (tester) async {
      const black = ColoredBox(color: Colors.black);
      const white = ColoredBox(color: Colors.white);
      final film = await _frame(
        tester,
        Effect.filmDissolveEffect,
        .5,
        from: black,
        to: white,
      );
      final fade = await _frame(
        tester,
        Effect.fadeEffect,
        .5,
        from: black,
        to: white,
      );
      expect(_pixel(film, 80, 50)[0], closeTo(188, 2));
      expect(_pixel(fade, 80, 50)[0], closeTo(128, 1));
      const same = ColoredBox(color: Color(0xff777777));
      final identical = await _frame(
        tester,
        Effect.filmDissolveEffect,
        .5,
        from: same,
        to: same,
      );
      expect(_pixel(identical, 80, 50)[0], closeTo(119, 2));
    },
  );

  testWidgets('frame opens a central rectangle with a lit border', (
    tester,
  ) async {
    final frame = await _frame(tester, Effect.frameEffect, .5);
    expect(_pixel(frame, 80, 50), [0, 0, 255, 255]);
    expect(_pixel(frame, 5, 5), [255, 0, 0, 255]);
    final border = _pixel(frame, 38, 50);
    expect(border[1], greaterThan(50));
    expect(border[2], greaterThan(50));
  });

  testWidgets('louver turns staggered slats with old/new faces and dark gaps', (
    tester,
  ) async {
    final frame = await _frame(tester, Effect.louverEffect, .5);
    expect(_pixel(frame, 10, 50)[2], greaterThan(100));
    expect(_pixel(frame, 150, 50)[0], greaterThan(100));
    expect(_pixel(frame, 20, 50), [0, 0, 0, 255]);
    const size = Size(161, 103);
    for (final count in [1, 8, 13]) {
      for (final t in [0.0, 1.0]) {
        final endpoint = await pixels.capture(
          tester,
          (context) =>
              OpticalTransitionEffect(
                OpticalTransitionKind.louver,
                slatCount: count,
              ).createTransformWidget(
                context,
                EffectSlideInput(
                  view: const ColoredBox(color: Color(0xffff0000)),
                ),
                EffectSlideInput(
                  view: const ColoredBox(color: Color(0xff0000ff)),
                ),
                AlwaysStoppedAnimation(t),
                size.width,
                size.height,
              ),
          size: size,
        );
        expect(
          [
            for (var i = t == 0 ? 0 : 2; i < endpoint.length; i += 4)
              endpoint[i],
          ],
          everyElement(255),
          reason: 'All slats cover their endpoint at count=$count',
        );
      }
    }
  });

  testWidgets('louver edge-on slats expose only the opaque black backing', (
    tester,
  ) async {
    const from = RepaintBoundary(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.yellow, Colors.red]),
        ),
      ),
    );
    const to = RepaintBoundary(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.cyan, Colors.blue]),
        ),
      ),
    );
    const size = Size(160, 100);
    const stagger = .25;
    for (final axis in EffectAxis.values) {
      for (final count in [1, 8]) {
        final effect = Effect(
          EffectType.louver,
          options: LouverEffectOptions(axis: axis, slatCount: count),
        );
        for (var slat = 0; slat < count; slat++) {
          // At half of its own turn a slat has no visible face. Sampling on
          // either side of its centre also avoids depending on edge AA.
          final start = count == 1 ? 0.0 : stagger * slat / (count - 1);
          final edgeOn = start + (1 - stagger) / 2;
          for (final offset in [-.000001, 0.0, .000001]) {
            final frame = await _frame(
              tester,
              effect,
              edgeOn + offset,
              from: from,
              to: to,
              size: size,
            );
            for (final distance in [-2, 2]) {
              final x = axis == EffectAxis.vertical
                  ? (size.width * (slat + .5) / count).floor() + distance
                  : size.width ~/ 2;
              final y = axis == EffectAxis.horizontal
                  ? (size.height * (slat + .5) / count).floor() + distance
                  : size.height ~/ 2;
              expect(_pixel(frame, x, y), [
                0,
                0,
                0,
                255,
              ], reason: '$axis count=$count slat=$slat offset=$offset');
            }
          }
        }
      }
    }
    await tester.pumpWidget(const SizedBox());
    expect(tester.takeException(), isNull);
  });

  testWidgets('mirror temporarily reflects the right half onto the left', (
    tester,
  ) async {
    const source = Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(child: ColoredBox(color: Color(0xffff0000))),
        Expanded(child: ColoredBox(color: Color(0xff00ff00))),
      ],
    );
    final frame = await _frame(
      tester,
      Effect.mirrorEffect,
      .5,
      from: source,
      to: source,
    );
    expect(_pixel(frame, 20, 50), [0, 255, 0, 255]);
    expect(_pixel(frame, 140, 50), [0, 255, 0, 255]);
  });

  testWidgets('neon wipe has a narrow edge with cyan and pink light', (
    tester,
  ) async {
    const black = ColoredBox(color: Colors.black);
    final frame = await _frame(
      tester,
      (const Effect(
        EffectType.softWipe,
        options: SoftWipeEffectOptions(style: SoftWipeStyle.neon),
      )),
      .5,
      from: black,
      to: black,
    );
    expect(_pixel(frame, 77, 50)[1], greaterThan(_pixel(frame, 77, 50)[0]));
    expect(_pixel(frame, 82, 50)[0], greaterThan(_pixel(frame, 82, 50)[1]));
    expect(_pixel(frame, 5, 50), [0, 0, 0, 255]);
  });

  testWidgets('retained wipe replaces its feather when style and size change', (
    tester,
  ) async {
    final key = GlobalKey();
    for (final size in [const Size(160, 100), const Size(137, 89)]) {
      for (final style in [
        SoftWipeStyle.soft,
        SoftWipeStyle.neon,
        SoftWipeStyle.soft,
        SoftWipeStyle.neon,
      ]) {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child: RepaintBoundary(
                key: key,
                child: SizedBox.fromSize(
                  size: size,
                  child: Builder(
                    builder: (context) =>
                        SoftWipeEffect(style: style).createTransformWidget(
                          context,
                          EffectSlideInput(
                            view: const ColoredBox(color: Color(0xffff0000)),
                          ),
                          EffectSlideInput(
                            view: const ColoredBox(color: Color(0xff0000ff)),
                          ),
                          const AlwaysStoppedAnimation(.5),
                          size.width,
                          size.height,
                        ),
                  ),
                ),
              ),
            ),
          ),
        );
        final red = (await tester.runAsync(() async {
          final image =
              await (key.currentContext!.findRenderObject()!
                      as RenderRepaintBoundary)
                  .toImage();
          try {
            final data = (await image.toByteData(
              format: ui.ImageByteFormat.rawRgba,
            ))!;
            return data.getUint8(
              ((size.height ~/ 2) * size.width.toInt() +
                      (size.width * .44).floor()) *
                  4,
            );
          } finally {
            image.dispose();
          }
        }))!;
        expect(red, style == SoftWipeStyle.soft ? greaterThan(10) : 0);
      }
    }
    await tester.pumpWidget(const SizedBox());
    expect(tester.takeException(), isNull);
  });

  testWidgets('views stay mounted, update live, reverse and release once', (
    tester,
  ) async {
    for (final descriptor in _effects) {
      var fromMounts = 0, toMounts = 0, releases = 0;
      final color = _LiveColor();
      final capture = GlobalKey();
      final from = _LiveProbe(color, () => fromMounts++, () => releases++);
      final to = _LiveProbe(color, () => toMounts++, () => releases++);
      Future<void> pump(double t) => tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: RepaintBoundary(
              key: capture,
              child: SizedBox(
                width: 160,
                height: 100,
                child: Builder(
                  builder: (context) =>
                      descriptor.createEffect().createTransformWidget(
                        context,
                        EffectSlideInput(view: from),
                        EffectSlideInput(view: to),
                        AlwaysStoppedAnimation(t),
                        160,
                        100,
                      ),
                ),
              ),
            ),
          ),
        ),
      );
      final copies = <Effect, (int, int)>{
        Effect.foldMotionEffect: (2, 2),
        Effect.glowEffect: (2, 2),
        Effect.kaleidoscopeEffect: (7, 7),
        Effect.vhsDamageEffect: (4, 4),
        Effect.radialBlurEffect: (9, 9),
        Effect.phosphorEffect: (4, 1),
      };
      final expectedTo =
          copies[descriptor]?.$2 ??
          (descriptor == Effect.glassEffect || descriptor == Effect.louverEffect
              ? 8
              : descriptor == Effect.mirrorEffect
              ? 2
              : 1);
      final expectedFrom =
          copies[descriptor]?.$1 ??
          ((descriptor == Effect.sliceEffect ||
                  descriptor == Effect.glassEffect ||
                  descriptor == Effect.louverEffect)
              ? 8
              : descriptor == Effect.splitEffect ||
                    descriptor == Effect.mirrorEffect
              ? 2
              : 1);
      for (final t in [0.0, .01, .5, .99, 1.0, .5, 0.0]) {
        await pump(t);
        expect(fromMounts, expectedFrom, reason: '${descriptor.name} at $t');
        expect(toMounts, expectedTo);
        expect(releases, 0);
        color.value = color.value == const Color(0xffff0000)
            ? const Color(0xff00ff00)
            : const Color(0xffff0000);
        await tester.pump();
        if (t == 0 || t == 1) {
          final rgba = (await tester.runAsync(() async {
            final boundary =
                capture.currentContext!.findRenderObject()!
                    as RenderRepaintBoundary;
            final image = await boundary.toImage();
            try {
              return await image.toByteData(format: ui.ImageByteFormat.rawRgba);
            } finally {
              image.dispose();
            }
          }))!;
          expect(
            rgba.buffer.asUint8List().sublist(0, 4),
            color.value == const Color(0xffff0000)
                ? [255, 0, 0, 255]
                : [0, 255, 0, 255],
            reason: '${descriptor.name} must keep descendants live',
          );
        }
        expect(tester.takeException(), isNull);
      }
      await tester.pumpWidget(const SizedBox());
      expect(releases, expectedFrom + expectedTo);
      expect(color.isObserved, isFalse);
      color.dispose();
    }
  });

  testWidgets('one-strip slice and fractional strip boundaries have no gaps', (
    tester,
  ) async {
    const size = Size(161, 103);
    for (final count in [1, 8, 13]) {
      final frame = await pixels.capture(
        tester,
        (context) => SliceEffect(stripCount: count).createTransformWidget(
          context,
          EffectSlideInput(view: const ColoredBox(color: Color(0xffff0000))),
          EffectSlideInput(view: const ColoredBox(color: Color(0xff0000ff))),
          const AlwaysStoppedAnimation(0),
          size.width,
          size.height,
        ),
        size: size,
      );
      expect([
        for (var i = 0; i < frame.length; i += 4) frame[i],
      ], everyElement(255));
    }
  });

  testWidgets('glass panes cover fractional boundaries at both endpoints', (
    tester,
  ) async {
    const size = Size(161, 103);
    for (final count in [1, 8, 13]) {
      for (final t in [0.0, 1.0]) {
        final frame = await pixels.capture(
          tester,
          (context) => GlassEffect(paneCount: count).createTransformWidget(
            context,
            EffectSlideInput(view: const ColoredBox(color: Color(0xffff0000))),
            EffectSlideInput(view: const ColoredBox(color: Color(0xffff0000))),
            AlwaysStoppedAnimation(t),
            size.width,
            size.height,
          ),
          size: size,
        );
        expect([
          for (var i = 0; i < frame.length; i += 4) frame[i],
        ], everyElement(255));
      }
    }
  });
}

class _LiveProbe extends StatefulWidget {
  final ValueNotifier<Color> color;
  final VoidCallback mount, release;
  const _LiveProbe(this.color, this.mount, this.release);

  @override
  State<_LiveProbe> createState() => _LiveProbeState();
}

class _LiveColor extends ValueNotifier<Color> {
  _LiveColor() : super(const Color(0xffff0000));

  bool get isObserved => hasListeners;
}

class _LiveProbeState extends State<_LiveProbe> {
  @override
  void initState() {
    super.initState();
    widget.mount();
  }

  @override
  Widget build(BuildContext context) => RepaintBoundary(
    child: ValueListenableBuilder<Color>(
      valueListenable: widget.color,
      builder: (_, color, _) => ColoredBox(color: color),
    ),
  );

  @override
  void dispose() {
    widget.release();
    super.dispose();
  }
}
