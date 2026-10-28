import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dslideshow_flutter/effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

const _size = Size(160, 100);
const _fromKey = ValueKey('from-view');
const _toKey = ValueKey('to-view');

Widget _viewport(Widget child, {Key? captureKey}) => Directionality(
  textDirection: TextDirection.ltr,
  child: Center(
    child: RepaintBoundary(
      key: captureKey,
      child: SizedBox.fromSize(
        size: _size,
        child: ColoredBox(
          color: Colors.black,
          child: ClipRect(child: child),
        ),
      ),
    ),
  ),
);

Widget _scene(
  MediaSliderItemEffect effect,
  double progress,
  Widget from,
  Widget to, {
  Key? captureKey,
}) => _viewport(
  Builder(
    builder: (context) => effect.createTransformWidget(
      context,
      from,
      to,
      AlwaysStoppedAnimation(progress),
      _size.width,
      _size.height,
    ),
  ),
  captureKey: captureKey,
);

Future<Uint8List> _capture(WidgetTester tester, GlobalKey key) async =>
    (await tester.runAsync(() async {
      final boundary =
          key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
      final image = await boundary.toImage();
      try {
        final data = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
        return Uint8List.fromList(
          data!.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
        );
      } finally {
        image.dispose();
      }
    }))!;

ui.Image _pattern(bool alternate) {
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  for (var y = 0; y < 100; y += 4) {
    for (var x = 0; x < 160; x += 4) {
      canvas.drawRect(
        Rect.fromLTWH(x.toDouble(), y.toDouble(), 4, 4),
        Paint()
          ..color = Color.fromARGB(
            255,
            (x * 3 + (alternate ? 80 : 0)) % 256,
            (y * 5 + (alternate ? 120 : 0)) % 256,
            (x * 7 + y * 2) % 256,
          ),
      );
    }
  }
  final picture = recorder.endRecording();
  try {
    return picture.toImageSync(160, 100);
  } finally {
    picture.dispose();
  }
}

void main() {
  testWidgets(
    'public factories use retained high scaling only for Stretch and CrossZoom',
    (tester) async {
      for (final (configuration, quality) in [
        (Effect.stretchEffect, FilterQuality.high),
        (
          const Effect(
            EffectType.stretch,
            options: StretchEffectOptions(
              axis: EffectAxis.vertical,
              maxScale: 4,
            ),
          ),
          FilterQuality.high,
        ),
        (Effect.crossZoomEffect, FilterQuality.high),
        (
          const Effect(
            EffectType.zoomOver,
            options: ZoomOverEffectOptions(
              mode: ZoomMode.cross,
              origin: EffectOrigin.bottomRight,
              blurFraction: .02,
            ),
          ),
          FilterQuality.high,
        ),
        (Effect.zoomOverEffect, null),
        (
          const Effect(
            EffectType.zoomOver,
            options: ZoomOverEffectOptions(
              origin: EffectOrigin.topLeft,
              blurFraction: .02,
            ),
          ),
          null,
        ),
      ]) {
        final source = Transform.rotate(
          angle: .03,
          filterQuality: FilterQuality.low,
          child: const SizedBox.expand(),
        );
        final target = Transform.rotate(
          angle: -.03,
          filterQuality: FilterQuality.low,
          child: const SizedBox.expand(),
        );
        await tester.pumpWidget(
          _scene(configuration.createEffect(), .5, source, target),
        );
        final transforms = tester
            .widgetList<Transform>(find.byType(Transform))
            .toList();
        expect(transforms, hasLength(4));
        expect(
          transforms
              .where(
                (widget) =>
                    !identical(widget, source) && !identical(widget, target),
              )
              .map((widget) => widget.filterQuality),
          everyElement(quality),
        );
        expect(tester.widget(find.byWidget(source)), same(source));
        expect(tester.widget(find.byWidget(target)), same(target));
        expect(source.filterQuality, FilterQuality.low);
        expect(target.filterQuality, FilterQuality.low);
        expect(tester.takeException(), isNull);
      }
    },
  );

  testWidgets(
    'configured scale, axis, corner origin, opacity and blur remain effective',
    (tester) async {
      for (final (configuration, sourceBounds, targetBounds, blur) in [
        (
          Effect.stretchEffect,
          const Rect.fromLTRB(-82.7, 0, 242.7, 100),
          const Rect.fromLTRB(-77.3, 0, 237.3, 100),
          null,
        ),
        (
          const Effect(
            EffectType.stretch,
            options: StretchEffectOptions(
              axis: EffectAxis.vertical,
              maxScale: 4,
            ),
          ),
          const Rect.fromLTRB(0, -77.53125, 160, 177.53125),
          const Rect.fromLTRB(0, -72.46875, 160, 172.46875),
          null,
        ),
        (
          const Effect(
            EffectType.zoomOver,
            options: ZoomOverEffectOptions(
              mode: ZoomMode.cross,
              startScale: 2,
              outgoingScale: 1.4,
              origin: EffectOrigin.bottomRight,
              blurFraction: .02,
            ),
          ),
          const Rect.fromLTRB(-33.08, -20.675, 160, 100),
          const Rect.fromLTRB(-77.3, -48.3125, 160, 100),
          ui.ImageFilter.blur(sigmaX: 2, sigmaY: 2, tileMode: TileMode.clamp),
        ),
      ]) {
        await tester.pumpWidget(
          _scene(
            configuration.createEffect(),
            .5,
            const SizedBox.expand(key: _fromKey),
            const SizedBox.expand(key: _toKey),
          ),
        );
        final viewport = tester.renderObject<RenderRepaintBoundary>(
          find.byType(RepaintBoundary).first,
        );
        Rect bounds(Key key) {
          final box = tester.renderObject<RenderBox>(find.byKey(key));
          return MatrixUtils.transformRect(
            box.getTransformTo(viewport),
            Offset.zero & box.size,
          );
        }

        void expectBounds(Rect actual, Rect expected) {
          expect(actual.left, closeTo(expected.left, 1e-10));
          expect(actual.top, closeTo(expected.top, 1e-10));
          expect(actual.right, closeTo(expected.right, 1e-10));
          expect(actual.bottom, closeTo(expected.bottom, 1e-10));
        }

        expectBounds(bounds(_fromKey), sourceBounds);
        expectBounds(bounds(_toKey), targetBounds);
        // Cubic(0.645, 0.045, 0.355, 1) reaches 0.516875 at t=0.5.
        expect(
          tester.widget<Opacity>(find.byType(Opacity)).opacity,
          closeTo(.516875, 1e-10),
        );
        if (blur == null) {
          expect(find.byType(ImageFiltered), findsNothing);
        } else {
          final filter = tester.widget<ImageFiltered>(
            find.byType(ImageFiltered),
          );
          expect(filter.enabled, isTrue);
          expect(filter.imageFilter, blur);
        }
      }
    },
  );

  for (final configuration in [
    Effect.stretchEffect,
    Effect.crossZoomEffect,
    Effect.zoomOverEffect,
  ]) {
    testWidgets(
      '${configuration.name} keeps exact opaque endpoints and borrows image handles',
      (tester) async {
        final from = _pattern(false), to = _pattern(true);
        final key = GlobalKey();
        Widget photo(ui.Image image, Key key) => RepaintBoundary(
          child: RawImage(
            key: key,
            image: image,
            filterQuality: FilterQuality.high,
          ),
        );
        final source = photo(from, _fromKey), target = photo(to, _toKey);
        final effect = configuration.createEffect();
        try {
          final expected = <Uint8List>[];
          for (final image in [from, to]) {
            await tester.pumpWidget(
              _viewport(
                RawImage(image: image, filterQuality: FilterQuality.high),
                captureKey: key,
              ),
            );
            expected.add(await _capture(tester, key));
          }
          RenderObject? retainedSource, retainedTarget;
          for (final progress in [0.0, .13, .5, .87, 1.0, .5]) {
            await tester.pumpWidget(
              _scene(effect, progress, source, target, captureKey: key),
            );
            expect(
              tester.widget<RawImage>(find.byKey(_fromKey)).image,
              same(from),
            );
            expect(tester.widget<RawImage>(find.byKey(_toKey)).image, same(to));
            final sourceRender = tester.renderObject(find.byKey(_fromKey));
            final targetRender = tester.renderObject(find.byKey(_toKey));
            retainedSource ??= sourceRender;
            retainedTarget ??= targetRender;
            expect(sourceRender, same(retainedSource));
            expect(targetRender, same(retainedTarget));
            expect(from.debugDisposed, isFalse);
            expect(to.debugDisposed, isFalse);
            if (progress == 0 || progress == 1) {
              expect(await _capture(tester, key), expected[progress.toInt()]);
            }
          }
          await tester.pumpWidget(const SizedBox());
          expect(retainedSource!.attached, isFalse);
          expect(retainedTarget!.attached, isFalse);
          expect(from.debugDisposed, isFalse);
          expect(to.debugDisposed, isFalse);
        } finally {
          await tester.pumpWidget(const SizedBox());
          from.dispose();
          to.dispose();
        }
        expect(tester.takeException(), isNull);
      },
    );
  }
}
