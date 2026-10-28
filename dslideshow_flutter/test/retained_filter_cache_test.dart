import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dslideshow_flutter/effect.dart';
import 'package:dslideshow_flutter/src/effect/creative_transition_effect.dart';
import 'package:dslideshow_flutter/src/effect/optical_transition_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

const _size = Size(160, 100);

Widget _scene(
  MediaSliderItemEffect effect,
  GlobalKey key,
  ValueNotifier<Color> from,
  ValueNotifier<Color> to,
  VoidCallback onBuild,
) => Directionality(
  textDirection: TextDirection.ltr,
  child: Center(
    child: RepaintBoundary(
      key: key,
      child: SizedBox.fromSize(
        size: _size,
        child: Builder(
          builder: (context) {
            onBuild();
            return effect.createTransformWidget(
              context,
              RepaintBoundary(child: CustomPaint(painter: _LiveColor(from))),
              RepaintBoundary(child: CustomPaint(painter: _LiveColor(to))),
              const AlwaysStoppedAnimation(.5),
              _size.width,
              _size.height,
            );
          },
        ),
      ),
    ),
  ),
);

Future<Uint8List> _capture(WidgetTester tester, GlobalKey key) async =>
    (await tester.runAsync(() async {
      final boundary =
          key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
      final image = await boundary.toImage();
      try {
        final data = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
        return Uint8List.fromList(data!.buffer.asUint8List());
      } finally {
        image.dispose();
      }
    }))!;

// Repaint without rebuilding the effect or the source widget. The source has
// its own boundary, like a prepared production slide nested inside a filter.
class _LiveColor extends CustomPainter {
  final ValueNotifier<Color> color;
  _LiveColor(this.color) : super(repaint: color);

  @override
  void paint(Canvas canvas, Size size) =>
      canvas.drawRect(Offset.zero & size, Paint()..color = color.value);

  @override
  bool shouldRepaint(_LiveColor oldDelegate) => color != oldDelegate.color;
}

class _ObservedColor extends ValueNotifier<Color> {
  _ObservedColor(super.value);

  bool get hasActiveListeners => hasListeners;
}

void main() {
  final effects = <String, MediaSliderItemEffect Function()>{
    'Phosphor': () => CreativeTransitionEffect(CreativeTransitionKind.phosphor),
    'FilmDissolve': () =>
        OpticalTransitionEffect(OpticalTransitionKind.filmDissolve),
  };
  for (final entry in effects.entries) {
    testWidgets('${entry.key} filters repaint live retained sources', (
      tester,
    ) async {
      final from = _ObservedColor(Colors.black);
      final to = _ObservedColor(Colors.black);
      try {
        final key = GlobalKey();
        var builds = 0;
        await tester.pumpWidget(
          _scene(entry.value(), key, from, to, () => builds++),
        );
        final retainedBoundary = key.currentContext!.findRenderObject();
        var previous = await _capture(tester, key);
        // Let the same retained layers be drawn repeatedly before changing
        // either source. Animation progress remains fixed throughout.
        for (var i = 0; i < 5; i++) {
          await tester.pump(const Duration(milliseconds: 16));
          expect(await _capture(tester, key), previous);
        }

        final updatedFrames = <(Uint8List, Color, Color)>[];
        for (final update in <VoidCallback>[
          () => from.value = Colors.white,
          () => to.value = const Color(0xff8040ff),
          () => from.value = const Color(0xff20a040),
        ]) {
          update();
          await tester.pump();
          final repainted = await _capture(tester, key);
          expect(repainted, isNot(orderedEquals(previous)));
          expect(builds, 1, reason: 'Only the source painter should repaint');
          expect(key.currentContext!.findRenderObject(), same(retainedBoundary));
          updatedFrames.add((repainted, from.value, to.value));
          previous = repainted;
          for (var i = 0; i < 5; i++) {
            await tester.pump(const Duration(milliseconds: 16));
            expect(await _capture(tester, key), repainted);
          }
        }

        // Newly mounted scenes observe the same source values without any
        // retained filter surfaces. Every pixel must agree with each update.
        await tester.pumpWidget(const SizedBox.shrink());
        for (final (repainted, fromColor, toColor) in updatedFrames) {
          from.value = fromColor;
          to.value = toColor;
          final freshKey = GlobalKey();
          await tester.pumpWidget(
            _scene(entry.value(), freshKey, from, to, () {}),
          );
          expect(repainted, await _capture(tester, freshKey));
        }
      } finally {
        await tester.pumpWidget(const SizedBox.shrink());
        expect(from.hasActiveListeners, isFalse);
        expect(to.hasActiveListeners, isFalse);
        from.dispose();
        to.dispose();
      }
      expect(tester.takeException(), isNull);
    });
  }
}
