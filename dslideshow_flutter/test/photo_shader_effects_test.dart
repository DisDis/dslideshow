import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dslideshow_flutter/effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

const _size = Size(160, 100);

enum _PhotoShaderKind { glass, filmDissolve }

Future<ui.Image> _photo({
  required bool incoming,
  bool transparent = false,
}) async {
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  final gradient = ui.Gradient.linear(
    Offset.zero,
    incoming ? Offset(0, _size.height) : Offset(_size.width, 0),
    incoming
        ? [const Color(0xff001030), const Color(0xff80f0e0)]
        : [const Color(0xff200000), const Color(0xffffa080)],
  );
  if (transparent) {
    canvas.saveLayer(null, Paint()..color = const Color(0x80ffffff));
  }
  canvas.drawRect(Offset.zero & _size, Paint()..shader = gradient);
  if (transparent) canvas.restore();
  final picture = recorder.endRecording();
  try {
    return await picture.toImage(_size.width.toInt(), _size.height.toInt());
  } finally {
    picture.dispose();
    gradient.dispose();
  }
}

Future<ui.Image> _solid(Color color) async {
  final recorder = ui.PictureRecorder();
  Canvas(recorder).drawColor(color, BlendMode.src);
  final picture = recorder.endRecording();
  try {
    return await picture.toImage(_size.width.toInt(), _size.height.toInt());
  } finally {
    picture.dispose();
  }
}

Widget _scene(
  MediaSliderItemEffect effect,
  GlobalKey key,
  double progress,
  ui.Image from,
  ui.Image to, {
  Matrix4? fromCamera,
  Widget? current,
  Widget? next,
}) => Directionality(
  textDirection: TextDirection.ltr,
  child: Center(
    child: RepaintBoundary(
      key: key,
      child: SizedBox.fromSize(
        size: _size,
        child: ColoredBox(
          color: Colors.black,
          child: Builder(
            builder: (context) => effect.createTransformWidget(
              context,
              current ??
                  ClipRect(
                    child: Transform(
                      alignment: Alignment.center,
                      transform: fromCamera ?? Matrix4.identity(),
                      child: RawImage(
                        image: from,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),
              next ?? RawImage(image: to, filterQuality: FilterQuality.high),
              AlwaysStoppedAnimation(progress),
              _size.width,
              _size.height,
            ),
          ),
        ),
      ),
    ),
  ),
);

Future<Uint8List> _pixels(WidgetTester tester, GlobalKey key) async =>
    (await tester.runAsync(() async {
      final boundary =
          key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
      final image = await boundary.toImage();
      try {
        final data = (await image.toByteData(
          format: ui.ImageByteFormat.rawRgba,
        ))!;
        return Uint8List.fromList(
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
        );
      } finally {
        image.dispose();
      }
    }))!;

({int max, double mean, int x, int y, List<int> expected, List<int> actual})
_difference(List<int> a, List<int> b, {bool Function(int x, int y)? include}) {
  var maximum = 0, total = 0, worst = 0, count = 0;
  expect(a.length, b.length);
  for (var index = 0; index < a.length; index++) {
    final pixel = index ~/ 4;
    if (include != null &&
        !include(pixel % _size.width.toInt(), pixel ~/ _size.width.toInt())) {
      continue;
    }
    final delta = (a[index] - b[index]).abs();
    if (delta > maximum) {
      maximum = delta;
      worst = index;
    }
    total += delta;
    count++;
  }
  final first = worst ~/ 4 * 4;
  expect(count, greaterThan(0));
  return (
    max: maximum,
    mean: total / count,
    x: worst ~/ 4 % _size.width.toInt(),
    y: worst ~/ 4 ~/ _size.width.toInt(),
    expected: a.sublist(first, first + 4),
    actual: b.sublist(first, first + 4),
  );
}

bool _glassInterior(GlassEffectOptions options, int x, int y) {
  if (x < 2 || y < 2 || x >= _size.width - 2 || y >= _size.height - 2) {
    return false;
  }
  final coordinate = options.axis == EffectAxis.horizontal ? y + .5 : x + .5;
  final extent = options.axis == EffectAxis.horizontal
      ? _size.height
      : _size.width;
  final band = coordinate * options.paneCount / extent;
  // Separate ClipRect/gradient surfaces and a fused shader can differ in the
  // one device pixel touching a fractional shared seam. Keep interior geometry
  // strict and report those seam pixels through the full-frame bound as well.
  return (band - band.round()).abs() * extent / options.paneCount > 1.5;
}

void _expectGlassPixels(
  List<int> expected,
  List<int> actual,
  GlassEffectOptions options,
  String reason,
) {
  final all = _difference(expected, actual);
  final interior = _difference(
    expected,
    actual,
    include: (x, y) => _glassInterior(options, x, y),
  );
  expect(
    interior.max,
    lessThanOrEqualTo(5),
    reason: '$reason interior $interior',
  );
  expect(interior.mean, lessThan(1), reason: '$reason interior $interior');
  // This is a local smooth-photo regression guard, not a pixel-equivalence or
  // hardware acceptance threshold. Glint discontinuities dominate seam maxima.
  expect(all.max, lessThanOrEqualTo(64), reason: '$reason full $all');
  expect(all.mean, lessThan(2), reason: '$reason full $all');
}

void main() {
  test(
    'normal factories preserve Glass axes and only optimize linear-light Fade',
    () {
      for (final axis in EffectAxis.values) {
        final options = GlassEffectOptions(
          axis: axis,
          paneCount: 3,
          refractionStrength: 2,
          glintStrength: 1.4,
          durationMs: 1800,
        );
        final descriptor = Effect(EffectType.glass, options: options);
        final effect = descriptor.createEffect();
        expect(effect, isA<PhotoGlassEffect>());
        expect((effect as PhotoGlassEffect).options, same(options));
        for (final from in TransitionMedia.values) {
          for (final to in TransitionMedia.values) {
            expect(descriptor.supportsMedia(from, to), isTrue);
          }
        }
      }
      for (final style in FadeStyle.values) {
        final options = FadeEffectOptions(
          style: style,
          blendCurve: BlendCurve.easeIn,
          durationMs: 1800,
        );
        final effect = Effect(EffectType.fade, options: options).createEffect();
        if (style == FadeStyle.linearLight) {
          expect(effect, isA<PhotoFilmDissolveEffect>());
          expect((effect as PhotoFilmDissolveEffect).options, same(options));
        } else {
          expect(effect, isNot(isA<PhotoFilmDissolveEffect>()));
        }
      }
      expect(
        Effect.filmDissolveEffect.createEffect(),
        isA<PhotoFilmDissolveEffect>(),
      );
    },
  );

  testWidgets(
    'unbound live inputs update in both effects without photo shaders',
    (tester) async {
      final from = (await tester.runAsync(() => _solid(Colors.red)))!;
      final to = (await tester.runAsync(() => _solid(Colors.blue)))!;
      final color = ValueNotifier<Color>(const Color(0xffff0000));
      final live = ValueListenableBuilder<Color>(
        valueListenable: color,
        builder: (context, value, child) => ColoredBox(color: value),
      );
      var shaderCreations = 0;
      ui.FragmentShader factory(ui.FragmentProgram program) {
        shaderCreations++;
        return program.fragmentShader();
      }

      try {
        for (final effect in [
          PhotoGlassEffect(
            options: const GlassEffectOptions(
              axis: EffectAxis.horizontal,
              glintStrength: 0,
            ),
            shaderFactory: factory,
          ),
          PhotoFilmDissolveEffect(shaderFactory: factory),
        ]) {
          await tester.runAsync(effect.prepare);
          color.value = const Color(0xffff0000);
          final key = GlobalKey();
          await tester.pumpWidget(
            _scene(effect, key, .5, from, to, current: live, next: live),
          );
          final before = await _pixels(tester, key);
          color.value = const Color(0xff00ff00);
          await tester.pump();
          final after = await _pixels(tester, key);
          final center = (50 * 160 + 80) * 4;
          expect(before.sublist(center, center + 4), [255, 0, 0, 255]);
          expect(after.sublist(center, center + 4), [0, 255, 0, 255]);
          expect(shaderCreations, 0);
          await tester.pumpWidget(const SizedBox());
        }
        expect(from.debugDisposed, isFalse);
        expect(to.debugDisposed, isFalse);
      } finally {
        await tester.pumpWidget(const SizedBox());
        color.dispose();
        from.dispose();
        to.dispose();
      }
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'Glass keeps both axes, pane geometry, overscan and glints on smooth photos',
    (tester) async {
      final from = (await tester.runAsync(() => _photo(incoming: false)))!;
      final to = (await tester.runAsync(
        () => _photo(incoming: true, transparent: true),
      ))!;
      try {
        for (final axis in EffectAxis.values) {
          for (final panes in [1, 3, 8]) {
            for (final strength in [0.0, 1.0, 2.0]) {
              final options = GlassEffectOptions(
                axis: axis,
                paneCount: panes,
                refractionStrength: strength,
                glintStrength: 1.4,
              );
              final original = Effect(
                EffectType.glass,
                options: options,
              ).createEffect();
              final candidate = PhotoGlassEffect(options: options)
                ..bindPhotos(from, to);
              await tester.runAsync(candidate.prepare);
              for (final phase in [0.0, .2, .5, .8, 1.0]) {
                final key = GlobalKey();
                await tester.pumpWidget(_scene(original, key, phase, from, to));
                final expected = await _pixels(tester, key);
                await tester.pumpWidget(
                  _scene(candidate, key, phase, from, to),
                );
                final actual = await _pixels(tester, key);
                _expectGlassPixels(
                  expected,
                  actual,
                  options,
                  '$axis/$panes/$strength/$phase',
                );
                if (phase == 0 || phase == 1) expect(actual, expected);
              }
            }
          }
        }
      } finally {
        await tester.pumpWidget(const SizedBox.shrink());
        from.dispose();
        to.dispose();
      }
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'FilmDissolve uses linear light, every blend curve and black alpha backing',
    (tester) async {
      final from = (await tester.runAsync(
        () => _photo(incoming: false, transparent: true),
      ))!;
      final to = (await tester.runAsync(() => _photo(incoming: true)))!;
      final black = (await tester.runAsync(() => _solid(Colors.black)))!;
      final white = (await tester.runAsync(() => _solid(Colors.white)))!;
      try {
        for (final curve in BlendCurve.values) {
          final options = FadeEffectOptions(
            style: FadeStyle.linearLight,
            blendCurve: curve,
          );
          final original = Effect(
            EffectType.fade,
            options: options,
          ).createEffect();
          final candidate = PhotoFilmDissolveEffect(options: options)
            ..bindPhotos(from, to);
          await tester.runAsync(candidate.prepare);
          for (final phase in [0.0, .2, .5, .8, 1.0]) {
            final key = GlobalKey();
            await tester.pumpWidget(_scene(original, key, phase, from, to));
            final expected = await _pixels(tester, key);
            await tester.pumpWidget(_scene(candidate, key, phase, from, to));
            final actual = await _pixels(tester, key);
            final delta = _difference(expected, actual);
            // Original filter layers quantize linear values before the final
            // transfer function; the one-pass candidate retains float precision.
            expect(
              delta.max,
              lessThanOrEqualTo(14),
              reason: '$curve/$phase $delta',
            );
            expect(delta.mean, lessThan(1), reason: '$curve/$phase $delta');
            if (phase == 0 || phase == 1) expect(actual, expected);
          }
        }
        final candidate = PhotoFilmDissolveEffect()..bindPhotos(black, white);
        await tester.runAsync(candidate.prepare);
        final key = GlobalKey();
        await tester.pumpWidget(_scene(candidate, key, .5, black, white));
        final actual = await _pixels(tester, key);
        expect(actual.take(4), orderedEquals([188, 188, 188, 255]));
      } finally {
        await tester.pumpWidget(const SizedBox.shrink());
        from.dispose();
        to.dispose();
        black.dispose();
        white.dispose();
      }
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'borrowed bitmaps rebind, shaders reuse and detach disposes only render resources',
    (tester) async {
      final from = (await tester.runAsync(() => _photo(incoming: false)))!;
      final to = (await tester.runAsync(() => _photo(incoming: true)))!;
      try {
        for (final kind in _PhotoShaderKind.values) {
          final shaders = <ui.FragmentShader>[];
          ui.FragmentShader factory(ui.FragmentProgram program) {
            final shader = program.fragmentShader();
            shaders.add(shader);
            return shader;
          }

          final candidate = switch (kind) {
            _PhotoShaderKind.glass => PhotoGlassEffect(shaderFactory: factory),
            _PhotoShaderKind.filmDissolve => PhotoFilmDissolveEffect(
              shaderFactory: factory,
            ),
          };
          if (candidate is PhotoGlassEffect) candidate.bindPhotos(from, to);
          if (candidate is PhotoFilmDissolveEffect) {
            candidate.bindPhotos(from, to);
          }
          await tester.runAsync(candidate.prepare);
          final key = GlobalKey();
          await tester.pumpWidget(_scene(candidate, key, .3, from, to));
          final before = await _pixels(tester, key);
          await tester.pumpWidget(_scene(candidate, key, .6, from, to));
          expect(await _pixels(tester, key), isNot(orderedEquals(before)));
          if (candidate is PhotoGlassEffect) candidate.bindPhotos(to, from);
          if (candidate is PhotoFilmDissolveEffect) {
            candidate.bindPhotos(to, from);
          }
          await tester.pumpWidget(_scene(candidate, key, .3, to, from));
          expect(await _pixels(tester, key), isNot(orderedEquals(before)));
          expect(shaders, hasLength(1));
          await tester.pumpWidget(const SizedBox.shrink());
          expect(shaders.single.debugDisposed, isTrue);
          expect(from.debugDisposed, isFalse);
          expect(to.debugDisposed, isFalse);
          await tester.pumpWidget(_scene(candidate, GlobalKey(), .3, to, from));
          expect(shaders, hasLength(2));
          await tester.pumpWidget(const SizedBox.shrink());
          expect(shaders.every((shader) => shader.debugDisposed), isTrue);
        }
      } finally {
        await tester.pumpWidget(const SizedBox.shrink());
        from.dispose();
        to.dispose();
      }
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'outgoing camera is copied, unsupported matrices fail and endpoints stay live',
    (tester) async {
      final from = (await tester.runAsync(() => _photo(incoming: false)))!;
      final to = (await tester.runAsync(() => _photo(incoming: true)))!;
      final camera = Matrix4.identity()
        ..translateByDouble(-5, 3, 0, 1)
        ..scaleByDouble(1.12, 1.12, 1, 1);
      final expectedCamera = Matrix4.copy(camera);
      final glass = PhotoGlassEffect(
        options: const GlassEffectOptions(axis: EffectAxis.horizontal),
      );
      final film = PhotoFilmDissolveEffect();
      glass.bindPhotos(from, to, fromCamera: camera);
      film.bindPhotos(from, to, fromCamera: camera);
      camera.storage[12] = 999;
      try {
        for (final candidate in [glass, film]) {
          await tester.runAsync(candidate.prepare);
          final original =
              (candidate == glass
                      ? const Effect(
                          EffectType.glass,
                          options: GlassEffectOptions(
                            axis: EffectAxis.horizontal,
                          ),
                        )
                      : const Effect(
                          EffectType.fade,
                          options: FadeEffectOptions(
                            style: FadeStyle.linearLight,
                          ),
                        ))
                  .createEffect();
          for (final phase in [.2, .5, .8]) {
            final key = GlobalKey();
            await tester.pumpWidget(
              _scene(
                original,
                key,
                phase,
                from,
                to,
                fromCamera: expectedCamera,
              ),
            );
            final expected = await _pixels(tester, key);
            await tester.pumpWidget(
              _scene(
                candidate,
                key,
                phase,
                from,
                to,
                fromCamera: expectedCamera,
              ),
            );
            final actual = await _pixels(tester, key);
            if (candidate is PhotoGlassEffect) {
              _expectGlassPixels(
                expected,
                actual,
                candidate.options,
                'camera/$phase',
              );
            } else {
              final delta = _difference(expected, actual);
              expect(
                delta.max,
                lessThanOrEqualTo(14),
                reason: 'camera/$phase $delta',
              );
              expect(delta.mean, lessThan(1), reason: 'camera/$phase $delta');
            }
          }
          for (final invalid in [
            Matrix4.rotationZ(.1),
            Matrix4.diagonal3Values(1.2, 1.1, 1),
            Matrix4.zero(),
          ]) {
            expect(
              () => candidate.bindPhotos(from, to, fromCamera: invalid),
              throwsArgumentError,
            );
          }
          final color = ValueNotifier(Colors.red);
          final current = ValueListenableBuilder<Color>(
            valueListenable: color,
            builder: (_, value, _) => ColoredBox(color: value),
          );
          final key = GlobalKey();
          await tester.pumpWidget(
            _scene(candidate, key, 0, from, to, current: current),
          );
          final before = await _pixels(tester, key);
          color.value = Colors.blue;
          await tester.pump();
          expect(await _pixels(tester, key), isNot(orderedEquals(before)));
          await tester.pumpWidget(const SizedBox.shrink());
          color.dispose();
        }
      } finally {
        await tester.pumpWidget(const SizedBox.shrink());
        from.dispose();
        to.dispose();
      }
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'bound photo phases require prepare and unbound phases remain live',
    (tester) async {
      final from = (await tester.runAsync(() => _solid(Colors.red)))!;
      final to = (await tester.runAsync(() => _solid(Colors.blue)))!;
      try {
        for (final candidate in [
          PhotoGlassEffect(),
          PhotoFilmDissolveEffect(),
        ]) {
          await tester.pumpWidget(_scene(candidate, GlobalKey(), .5, from, to));
          expect(tester.takeException(), isNull);
          candidate.bindPhotos(from, to);
          await tester.pumpWidget(_scene(candidate, GlobalKey(), .5, from, to));
          expect(tester.takeException(), isA<StateError>());
          await tester.runAsync(candidate.prepare);
          await tester.pumpWidget(_scene(candidate, GlobalKey(), .5, from, to));
          expect(tester.takeException(), isNull);
        }
      } finally {
        await tester.pumpWidget(const SizedBox.shrink());
        from.dispose();
        to.dispose();
      }
    },
  );
}
