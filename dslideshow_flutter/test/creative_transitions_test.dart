import 'dart:math' as math;
import 'dart:typed_data';

import 'package:dslideshow_flutter/effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'zoom_blur_effect_test.dart' as pixels;

const _black = ColoredBox(color: Colors.black);
const _red = ColoredBox(color: Color(0xffff0000));
const _blue = ColoredBox(color: Color(0xff0000ff));

List<int> _pixel(Uint8List frame, int x, int y, {int width = 160}) =>
    frame.sublist((y * width + x) * 4, (y * width + x) * 4 + 4);

Future<Uint8List> _frame(
  WidgetTester tester,
  Effect effect,
  double t, {
  Widget from = _red,
  Widget to = _blue,
  Size size = const Size(160, 100),
}) => pixels.capture(
  tester,
  (context) => effect.createEffect().createTransformWidget(
    context,
    EffectSlideInput(view: from),
    EffectSlideInput(view: to),
    AlwaysStoppedAnimation(t),
    size.width,
    size.height,
  ),
  size: size,
);

int _count(Uint8List frame, bool Function(List<int>) predicate) {
  var count = 0;
  for (var i = 0; i < frame.length; i += 4) {
    if (predicate(frame.sublist(i, i + 4))) count++;
  }
  return count;
}

double _markerX(Uint8List frame) {
  var sum = 0.0, weight = 0.0;
  for (var x = 0; x < 160; x++) {
    final value = _pixel(frame, x, 50)[0].toDouble();
    sum += x * value;
    weight += value;
  }
  expect(weight, greaterThan(0));
  return sum / weight;
}

void main() {
  testWidgets('burn reveals progressively with an irregular glowing front', (
    tester,
  ) async {
    final early = await _frame(tester, Effect.burnAlphaEffect, .25);
    final middle = await _frame(tester, Effect.burnAlphaEffect, .5);
    final late = await _frame(tester, Effect.burnAlphaEffect, .75);
    bool blue(List<int> p) => p[2] > 250 && p[0] < 5;
    expect(_count(early, blue), lessThan(_count(late, blue)));
    expect(_pixel(middle, 10, 50), [0, 0, 255, 255]);
    expect(_pixel(middle, 150, 50), [255, 0, 0, 255]);
    final fronts = <int>{};
    for (var y = 5; y < 95; y += 3) {
      fronts.add(
        [for (var x = 0; x < 160; x++) x]
            .lastWhere((x) => blue(_pixel(middle, x, y))),
      );
    }
    expect(fronts.length, greaterThan(8));
    expect(_count(middle, (p) => p[0] > 150 && p[1] > 100), greaterThan(100));
  });

  testWidgets('fold contracts paper halves then unfolds the incoming faces', (
    tester,
  ) async {
    final outgoing = await _frame(tester, Effect.foldMotionEffect, .4);
    final incoming = await _frame(tester, Effect.foldMotionEffect, .6);
    expect(_pixel(outgoing, 5, 5), [0, 0, 0, 255]);
    expect(_pixel(incoming, 5, 5), [0, 0, 0, 255]);
    expect(_pixel(outgoing, 60, 50)[0], greaterThan(100));
    expect(_pixel(outgoing, 60, 50)[2], 0);
    expect(_pixel(incoming, 60, 50)[2], greaterThan(100));
    expect(_pixel(incoming, 60, 50)[0], 0);
    final edge = await _frame(tester, Effect.foldMotionEffect, .5);
    expect(_count(edge, (p) => p[0] == 0 && p[2] == 0), greaterThan(15000));
  });

  testWidgets('glow brightens highlights and spreads a soft halo', (
    tester,
  ) async {
    const gray = ColoredBox(color: Color(0xff404040));
    final grayFrame = await _frame(
      tester,
      Effect.glowEffect,
      .5,
      from: gray,
      to: gray,
    );
    expect(_pixel(grayFrame, 80, 50)[0], greaterThan(100));
    const highlight = Center(
      child: SizedBox(
        width: 40,
        height: 20,
        child: ColoredBox(color: Colors.white),
      ),
    );
    final halo = await _frame(
      tester,
      Effect.glowEffect,
      .5,
      from: highlight,
      to: highlight,
    );
    expect(_pixel(halo, 55, 50)[0], greaterThan(10));
    expect(_pixel(halo, 5, 5)[0], 0);
    expect(_pixel(halo, 80, 50)[0], greaterThan(240));
  });

  testWidgets(
    'kaleidoscope repeats alternating mirrored sectors around center',
    (tester) async {
      const source = Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: _red),
          Expanded(child: ColoredBox(color: Color(0xff00ff00))),
        ],
      );
      final frame = await _frame(
        tester,
        Effect.kaleidoscopeEffect,
        .5,
        from: source,
        to: source,
        size: const Size(160, 160),
      );
      for (var i = 0; i < 6; i++) {
        final angle = (30 + i * 60) * math.pi / 180;
        final p = _pixel(
          frame,
          (80 + 45 * math.cos(angle)).round(),
          (80 + 45 * math.sin(angle)).round(),
        );
        expect(p[i.isEven ? 1 : 0], greaterThan(240), reason: 'Sector $i');
        expect(p[i.isEven ? 0 : 1], lessThan(10));
      }
    },
  );

  testWidgets('TV power closes to a luminous line then opens the new picture', (
    tester,
  ) async {
    final middle = await _frame(tester, Effect.tvPowerEffect, .5);
    expect(_pixel(middle, 80, 50)[0], greaterThan(180));
    expect(_pixel(middle, 80, 50)[1], greaterThan(180));
    expect(_pixel(middle, 10, 10), [0, 0, 0, 255]);
    final early = await _frame(tester, Effect.tvPowerEffect, .35);
    final late = await _frame(tester, Effect.tvPowerEffect, .65);
    expect(_pixel(early, 80, 48)[0], greaterThan(_pixel(early, 80, 48)[2]));
    expect(_pixel(late, 80, 48)[2], greaterThan(_pixel(late, 80, 48)[0]));
  });

  testWidgets('spring reverses direction as incoming detail overshoots', (
    tester,
  ) async {
    const marker = Center(
      child: SizedBox(
        width: 4,
        height: 60,
        child: ColoredBox(color: Colors.white),
      ),
    );
    final undershoot = await _frame(
      tester,
      Effect.springMotionEffect,
      .4,
      from: _black,
      to: marker,
    );
    final overshoot = await _frame(
      tester,
      Effect.springMotionEffect,
      .2,
      from: _black,
      to: marker,
    );
    expect(_markerX(undershoot), greaterThan(85));
    expect(_markerX(overshoot), lessThan(70));
  });

  testWidgets('shape dissolve grows many separate reveals rather than a wipe', (
    tester,
  ) async {
    final early = await _frame(tester, Effect.shapeDissolveEffect, .2);
    final middle = await _frame(tester, Effect.shapeDissolveEffect, .4);
    final late = await _frame(tester, Effect.shapeDissolveEffect, .7);
    bool blue(List<int> p) => p[2] > 250 && p[0] < 5;
    expect(_count(early, blue), lessThan(_count(late, blue)));
    expect(_count(middle, blue), greaterThan(1000));
    expect(_count(middle, (p) => p[0] > 250), greaterThan(1000));
    var edges = 0;
    for (var x = 1; x < 160; x++) {
      if (blue(_pixel(middle, x, 50)) != blue(_pixel(middle, x - 1, 50))) {
        edges++;
      }
    }
    expect(edges, greaterThan(6));
  });

  testWidgets(
    'VHS has chromatic displacement, scan lines and repeatable noise',
    (tester) async {
      const bar = Center(
        child: SizedBox(
          width: 4,
          height: double.infinity,
          child: ColoredBox(color: Colors.white),
        ),
      );
      final frame = await _frame(
        tester,
        Effect.vhsDamageEffect,
        .5,
        from: bar,
        to: bar,
      );
      final fringe = _pixel(frame, 85, 15);
      expect(fringe[0], greaterThan(fringe[2]));
      expect(fringe[0], greaterThan(20));
      const gray = ColoredBox(color: Color(0xff888888));
      final tape = await _frame(
        tester,
        Effect.vhsDamageEffect,
        .5,
        from: gray,
        to: gray,
      );
      final values = [for (var y = 5; y < 95; y++) _pixel(tape, 10, y)[0]];
      expect(
        values.reduce(math.max) - values.reduce(math.min),
        greaterThan(20),
      );
      expect(
        await _frame(tester, Effect.vhsDamageEffect, .5, from: gray, to: gray),
        tape,
      );
    },
  );

  testWidgets(
    'radial blur spreads distant details along arcs more than center',
    (tester) async {
      const bar = Center(
        child: SizedBox(
          width: 4,
          height: double.infinity,
          child: ColoredBox(color: Colors.white),
        ),
      );
      final frame = await _frame(
        tester,
        Effect.radialBlurEffect,
        .5,
        from: bar,
        to: bar,
      );
      int widthAt(int y) =>
          [for (var x = 0; x < 160; x++) _pixel(frame, x, y)[0]]
              .where((r) => r > 6)
              .length;
      expect(widthAt(10), greaterThan(widthAt(50) + 5));
      expect(_pixel(frame, 72, 10)[0], inExclusiveRange(0, 240));
    },
  );

  testWidgets('phosphor drifts and leaves a fading cyan-green light trail', (
    tester,
  ) async {
    const bar = Center(
      child: SizedBox(
        width: 4,
        height: double.infinity,
        child: ColoredBox(color: Colors.white),
      ),
    );
    final frame = await _frame(
      tester,
      Effect.phosphorEffect,
      .5,
      from: bar,
      to: _black,
    );
    expect(_markerX(frame), lessThan(65));
    final trail = _pixel(frame, 69, 50);
    expect(trail[1], greaterThan(trail[0]));
    expect(trail[1], greaterThan(5));
    final late = await _frame(
      tester,
      Effect.phosphorEffect,
      .85,
      from: bar,
      to: _black,
    );
    final brightness = _count(late, (p) => p[1] > 5);
    expect(brightness, lessThan(_count(frame, (p) => p[1] > 5)));
  });
}
