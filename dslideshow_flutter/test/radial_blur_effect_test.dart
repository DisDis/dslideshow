import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dslideshow_flutter/effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

const _size = Size(160, 100);

Future<ui.Image> _photo({required bool incoming}) async {
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  final gradient = ui.Gradient.linear(
    Offset.zero,
    incoming ? Offset(0, _size.height) : Offset(_size.width, 0),
    incoming
        ? [const Color(0xff001030), const Color(0xff80f0e0)]
        : [const Color(0xff200000), const Color(0xffffa080)],
  );
  canvas.drawRect(Offset.zero & _size, Paint()..shader = gradient);
  final picture = recorder.endRecording();
  try {
    return await picture.toImage(_size.width.toInt(), _size.height.toInt());
  } finally {
    picture.dispose();
    gradient.dispose();
  }
}

Widget _scene(
  MediaSliderItemEffect effect,
  GlobalKey key,
  double progress,
  ui.Image from,
  ui.Image to, {
  Matrix4? fromCamera,
  Widget? fromView,
  Widget? toView,
}) => Directionality(
  textDirection: TextDirection.ltr,
  child: Center(
    child: RepaintBoundary(
      key: key,
      child: SizedBox.fromSize(
        size: _size,
        child: Builder(
          builder: (context) => effect.createTransformWidget(
            context,
            fromView ??
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
            toView ?? RawImage(image: to, filterQuality: FilterQuality.high),
            AlwaysStoppedAnimation(progress),
            _size.width,
            _size.height,
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

void main() {
  test(
    'normal factory preserves Radial settings and all media capabilities',
    () {
      const options = RadialBlurEffectOptions(
        angleDegrees: 23,
        origin: EffectOrigin.topRight,
        durationMs: 1450,
      );
      const descriptor = Effect(EffectType.radialBlur, options: options);
      final effect = descriptor.createEffect();
      expect(effect, isA<RadialBlurEffect>());
      expect((effect as RadialBlurEffect).options, same(options));
      for (final from in TransitionMedia.values) {
        for (final to in TransitionMedia.values) {
          expect(descriptor.supportsMedia(from, to), isTrue);
        }
      }
    },
  );

  testWidgets('unbound GIF/video views keep updating without snapshots', (
    tester,
  ) async {
    final from = (await tester.runAsync(() => _photo(incoming: false)))!;
    final to = (await tester.runAsync(() => _photo(incoming: true)))!;
    final color = ValueNotifier<Color>(const Color(0xffff0000));
    var shaderCreations = 0;
    final effect = RadialBlurEffect(
      shaderFactory: (program) {
        shaderCreations++;
        return program.fragmentShader();
      },
    );
    final key = GlobalKey();
    final live = ValueListenableBuilder<Color>(
      valueListenable: color,
      builder: (context, value, child) => ColoredBox(color: value),
    );
    try {
      await tester.runAsync(effect.prepare);
      await tester.pumpWidget(
        _scene(effect, key, .5, from, to, fromView: live, toView: live),
      );
      expect(
        (await _pixels(
          tester,
          key,
        )).sublist((50 * 160 + 80) * 4, (50 * 160 + 80) * 4 + 4),
        [255, 0, 0, 255],
      );
      color.value = const Color(0xff00ff00);
      await tester.pump();
      expect(
        (await _pixels(
          tester,
          key,
        )).sublist((50 * 160 + 80) * 4, (50 * 160 + 80) * 4 + 4),
        [0, 255, 0, 255],
      );
      expect(shaderCreations, 0);
      expect(from.debugDisposed, isFalse);
      expect(to.debugDisposed, isFalse);
    } finally {
      await tester.pumpWidget(const SizedBox.shrink());
      color.dispose();
      from.dispose();
      to.dispose();
    }
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'full-resolution shader preserves smooth geometry and selected origins',
    (tester) async {
      final from = (await tester.runAsync(() => _photo(incoming: false)))!;
      final to = (await tester.runAsync(() => _photo(incoming: true)))!;
      try {
        for (final origin in EffectOrigin.values) {
          final options = RadialBlurEffectOptions(
            origin: origin,
            angleDegrees: 23,
          );
          final original = Effect(
            EffectType.radialBlur,
            options: options,
          ).createEffect();
          final effect = RadialBlurEffect(options: options)
            ..bindPhotos(from, to);
          await tester.runAsync(effect.prepare);
          for (final phase in [0.0, .2, .5, .8, 1.0]) {
            final key = GlobalKey();
            await tester.pumpWidget(_scene(original, key, phase, from, to));
            final expected = await _pixels(tester, key);
            await tester.pumpWidget(_scene(effect, key, phase, from, to));
            final actual = await _pixels(tester, key);
            expect(
              actual.length,
              _size.width.toInt() * _size.height.toInt() * 4,
            );
            var maximum = 0, sum = 0;
            for (var channel = 0; channel < actual.length; channel++) {
              final delta = (actual[channel] - expected[channel]).abs();
              sum += delta;
              if (delta > maximum) maximum = delta;
            }
            // Smooth gradients isolate geometry from the intentional bilinear
            // detail change. This is a local regression bound, not hardware or
            // arbitrary-photo visual acceptance of the effect.
            expect(maximum, lessThanOrEqualTo(6), reason: '$origin/$phase');
            expect(sum / actual.length, lessThan(3), reason: '$origin/$phase');
            if (phase == 0 || phase == 1) expect(actual, expected);
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
    'one shader is reused, samplers rebind, and detach releases only owned shaders',
    (tester) async {
      final from = (await tester.runAsync(() => _photo(incoming: false)))!;
      final to = (await tester.runAsync(() => _photo(incoming: true)))!;
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
          await tester.pumpWidget(_scene(effect, key, phase, from, to));
          expect(await _pixels(tester, key), hasLength(160 * 100 * 4));
        }
        expect(shaders, hasLength(1));
        expect(shaders.single.debugDisposed, isFalse);
        final before = await _pixels(tester, key);
        effect.bindPhotos(to, from);
        await tester.pumpWidget(_scene(effect, key, .6, to, from));
        expect(await _pixels(tester, key), isNot(orderedEquals(before)));
        expect(shaders, hasLength(1));

        await tester.pumpWidget(const SizedBox.shrink());
        expect(shaders.single.debugDisposed, isTrue);
        expect(from.debugDisposed, isFalse);
        expect(to.debugDisposed, isFalse);
        // Reusing an effect instance after its view detaches creates a fresh
        // shader rather than accessing the disposed renderer-owned object.
        await tester.pumpWidget(_scene(effect, GlobalKey(), .5, to, from));
        expect(shaders, hasLength(2));
        expect(shaders.last.debugDisposed, isFalse);
        await tester.pumpWidget(const SizedBox.shrink());
        expect(shaders.every((shader) => shader.debugDisposed), isTrue);
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

  testWidgets('outgoing camera is copied and inverted before photo sampling', (
    tester,
  ) async {
    final from = (await tester.runAsync(() => _photo(incoming: false)))!;
    final to = (await tester.runAsync(() => _photo(incoming: true)))!;
    final camera = Matrix4.identity()
      ..translateByDouble(-5, 3, 0, 1)
      ..scaleByDouble(1.12, 1.12, 1, 1);
    final expectedCamera = Matrix4.copy(camera);
    const options = RadialBlurEffectOptions(
      origin: EffectOrigin.bottomRight,
      angleDegrees: 23,
    );
    final original = Effect(
      EffectType.radialBlur,
      options: options,
    ).createEffect();
    final effect = RadialBlurEffect(options: options)
      ..bindPhotos(from, to, fromCamera: camera);
    camera.storage[12] =
        999; // Later caller mutations must not affect the view.
    try {
      await tester.runAsync(effect.prepare);
      for (final phase in [0.0, .2, .5, .8, 1.0]) {
        final key = GlobalKey();
        await tester.pumpWidget(
          _scene(original, key, phase, from, to, fromCamera: expectedCamera),
        );
        final expected = await _pixels(tester, key);
        await tester.pumpWidget(
          _scene(effect, key, phase, from, to, fromCamera: expectedCamera),
        );
        final actual = await _pixels(tester, key);
        var maximum = 0, sum = 0;
        for (var channel = 0; channel < actual.length; channel++) {
          final delta = (actual[channel] - expected[channel]).abs();
          sum += delta;
          if (delta > maximum) maximum = delta;
        }
        expect(maximum, lessThanOrEqualTo(6), reason: 'camera/$phase');
        expect(sum / actual.length, lessThan(3), reason: 'camera/$phase');
        if (phase == 0 || phase == 1) expect(actual, expected);
      }
      for (final invalid in [
        Matrix4.rotationZ(.1),
        Matrix4.diagonal3Values(1.2, 1.1, 1),
        Matrix4.zero(),
      ]) {
        expect(
          () => effect.bindPhotos(from, to, fromCamera: invalid),
          throwsArgumentError,
        );
      }
    } finally {
      await tester.pumpWidget(const SizedBox.shrink());
      from.dispose();
      to.dispose();
    }
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'bound photos require prepare, while live input needs no shader',
    (tester) async {
      final from = (await tester.runAsync(() => _photo(incoming: false)))!;
      final to = (await tester.runAsync(() => _photo(incoming: true)))!;
      try {
        final effect = RadialBlurEffect();
        await tester.pumpWidget(_scene(effect, GlobalKey(), .5, from, to));
        expect(tester.takeException(), isNull);
        effect.bindPhotos(from, to);
        await tester.pumpWidget(_scene(effect, GlobalKey(), .5, from, to));
        expect(tester.takeException(), isA<StateError>());
        await tester.runAsync(effect.prepare);
        await tester.pumpWidget(_scene(effect, GlobalKey(), .5, from, to));
        expect(tester.takeException(), isNull);
      } finally {
        await tester.pumpWidget(const SizedBox.shrink());
        from.dispose();
        to.dispose();
      }
    },
  );
}
