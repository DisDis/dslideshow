import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dslideshow_flutter/effect.dart';
import 'package:dslideshow_flutter/src/effect/effect_geometry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/pixel_capture.dart';

const _size = Size(160, 100);

enum _SamplingEffect { radial, glass, film, vhs }

MediaSliderItemEffect _effect(
  _SamplingEffect kind, {
  ui.FragmentShader Function(ui.FragmentProgram)? shaderFactory,
}) => switch (kind) {
  _SamplingEffect.radial => RadialBlurEffect(shaderFactory: shaderFactory),
  _SamplingEffect.glass => PhotoGlassEffect(
    options: const GlassEffectOptions(glintStrength: 0),
    shaderFactory: shaderFactory,
  ),
  _SamplingEffect.film => PhotoFilmDissolveEffect(shaderFactory: shaderFactory),
  _SamplingEffect.vhs => PhotoVhsDamageEffect(),
};

ui.Image _photo(bool incoming) {
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  final gradient = ui.Gradient.linear(
    Offset.zero,
    const Offset(160, 100),
    incoming ? [Colors.blue, Colors.green] : [Colors.orange, Colors.purple],
  );
  canvas.drawRect(Offset.zero & _size, Paint()..shader = gradient);
  canvas.drawRect(
    const Rect.fromLTWH(15, 20, 40, 12),
    Paint()..color = incoming ? Colors.yellow : Colors.white,
  );
  final picture = recorder.endRecording();
  try {
    return picture.toImageSync(160, 100);
  } finally {
    picture.dispose();
    gradient.dispose();
  }
}

EffectSlideInput _input(
  ui.Image image, {
  PhotoCamera camera = const PhotoCamera(),
}) => EffectSlideInput(
  view: ClipRect(
    child: Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..translateByDouble(camera.dx, camera.dy, 0, 1)
        ..scaleByDouble(camera.scale, camera.scale, 1, 1),
      child: RawImage(image: image, filterQuality: FilterQuality.high),
    ),
  ),
  photo: PreparedPhoto(bitmap: image, camera: camera),
);

Future<Uint8List> _frame(
  WidgetTester tester,
  MediaSliderItemEffect effect,
  EffectSlideInput current,
  EffectSlideInput next, {
  double progress = .37,
}) => capture(
  tester,
  (context) => effect.createTransformWidget(
    context,
    current,
    next,
    AlwaysStoppedAnimation(progress),
    _size.width,
    _size.height,
  ),
);

void main() {
  test(
    'photo camera freezes supported geometry and rejects unsupported matrices',
    () {
      final matrix = Matrix4.identity()
        ..translateByDouble(-5, 3, 0, 1)
        ..scaleByDouble(1.12, 1.12, 1, 1);
      final camera = PhotoCamera.fromMatrix(matrix);
      matrix.storage[0] = 9;
      matrix.storage[12] = 999;
      expect(camera, const PhotoCamera(scale: 1.12, dx: -5, dy: 3));
      expect(camera.isIdentity, false);
      expect(PhotoCamera.fromMatrix(null).isIdentity, true);
      expect(PhotoCamera.fromMatrix(Matrix4.identity()), const PhotoCamera());
      final invalid = [
        Matrix4.rotationZ(.1),
        Matrix4.diagonal3Values(1.2, 1.1, 1),
        Matrix4.diagonal3Values(-1, -1, 1),
        Matrix4.zero(),
        Matrix4.identity()..storage[4] = .1,
        Matrix4.identity()..storage[3] = .01,
        Matrix4.identity()..storage[12] = double.nan,
        Matrix4.identity()..storage[13] = double.infinity,
        Matrix4.identity()..storage[0] = double.infinity,
        Matrix4.identity()..storage[10] = double.nan,
      ];
      for (final matrix in invalid) {
        expect(() => PhotoCamera.fromMatrix(matrix), throwsArgumentError);
      }
    },
  );

  test('a changed live view explicitly drops photo sampling coordinates', () {
    final image = _photo(false);
    try {
      final original = _input(image, camera: const PhotoCamera(scale: 1.12));
      final changed = original.liveView(const ColoredBox(color: Colors.red));
      expect(changed.photo, isNull);
      expect(original.photo!.bitmap, same(image));
      expect(original.photo!.camera.scale, 1.12);
      final water = WaterRefractionEffect();
      final still = _input(image);
      expect(water.supportsInputs(original, still), true);
      expect(water.supportsInputs(changed, still), false);
      expect(water.supportsInputs(still, changed), false);
      expect(water.supportsInputs(still, original), false);
      expect(water.supportsInputs(changed, changed), false);
      expect(image.debugDisposed, false);
    } finally {
      image.dispose();
    }
  });

  for (final kind in _SamplingEffect.values) {
    testWidgets(
      '$kind reuses one effect across photo, live and new photo inputs',
      (tester) async {
        final from = _photo(false), to = _photo(true);
        final color = ValueNotifier(Colors.red);
        final shaders = <ui.FragmentShader>[];
        final effect = _effect(
          kind,
          shaderFactory: (program) {
            final shader = program.fragmentShader();
            shaders.add(shader);
            return shader;
          },
        );
        final a = _input(from), b = _input(to);
        final live = EffectSlideInput(
          view: ValueListenableBuilder<Color>(
            valueListenable: color,
            builder: (_, value, _) => ColoredBox(color: value),
          ),
        );
        try {
          await tester.runAsync(effect.prepare);
          final initial = await _frame(tester, effect, a, b);
          final red = await _frame(tester, effect, live, live);
          expect(red, await _frame(tester, _effect(kind), live, live));
          color.value = Colors.green;
          final green = await _frame(tester, effect, live, live);
          expect(green, isNot(orderedEquals(red)));
          expect(green, await _frame(tester, _effect(kind), live, live));
          if (kind != _SamplingEffect.vhs) {
            expect(shaders, hasLength(1));
            expect(shaders.single.debugDisposed, true);
            final moving = _input(to, camera: const PhotoCamera(scale: 1.1));
            final actual = await _frame(tester, effect, a, moving);
            final expected = await _frame(
              tester,
              effect,
              a.liveView(a.view),
              moving.liveView(moving.view),
            );
            expect(
              actual,
              expected,
              reason: 'An incoming moving camera keeps the live composition',
            );
            expect(shaders, hasLength(1));
          }
          final reversed = await _frame(tester, effect, b, a);
          final reference = _effect(kind);
          await tester.runAsync(reference.prepare);
          expect(reversed, await _frame(tester, reference, b, a));
          expect(reversed, isNot(orderedEquals(initial)));
          if (kind != _SamplingEffect.vhs) expect(shaders, hasLength(2));
          await tester.pumpWidget(const SizedBox());
          expect(shaders.every((shader) => shader.debugDisposed), true);
          expect(from.debugDisposed, false);
          expect(to.debugDisposed, false);
        } finally {
          await tester.pumpWidget(const SizedBox());
          color.dispose();
          from.dispose();
          to.dispose();
        }
        expect(tester.takeException(), isNull);
      },
    );
  }

  testWidgets(
    'geometry wrappers keep transformed photo views live and oriented',
    (tester) async {
      final from = _photo(false), to = _photo(true);
      final current = _input(from), next = _input(to);
      final wrappers =
          <String, MediaSliderItemEffect Function(MediaSliderItemEffect)>{
            'rotate': (inner) => DirectedEffect(inner, EffectDirection.up),
            'reflect direction': (inner) =>
                DirectedEffect(inner, EffectDirection.right),
            'reflect axis': (inner) =>
                ReflectedEffect(inner, flipX: false, flipY: true),
          };
      try {
        for (final entry in wrappers.entries) {
          expect(
            entry.value(WaterRefractionEffect()).supportsInputs(current, next),
            false,
            reason: entry.key,
          );
          var shaders = 0;
          final effect = entry.value(
            PhotoFilmDissolveEffect(
              shaderFactory: (program) {
                shaders++;
                return program.fragmentShader();
              },
            ),
          );
          final reference = entry.value(PhotoFilmDissolveEffect());
          await tester.runAsync(effect.prepare);
          final actual = await _frame(tester, effect, current, next);
          final expected = await _frame(
            tester,
            reference,
            current.liveView(current.view),
            next.liveView(next.view),
          );
          expect(actual, expected, reason: entry.key);
          expect(
            shaders,
            0,
            reason: '${entry.key} must invalidate photo coordinates',
          );
        }
        for (final identity in [
          DirectedEffect(WaterRefractionEffect(), EffectDirection.left),
          ReflectedEffect(WaterRefractionEffect(), flipX: false, flipY: false),
        ]) {
          expect(identity.supportsInputs(current, next), true);
        }
      } finally {
        await tester.pumpWidget(const SizedBox());
        from.dispose();
        to.dispose();
      }
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'reverse swaps photo metadata and camera capability with its view',
    (tester) async {
      final from = _photo(false), to = _photo(true);
      final current = _input(
        from,
        camera: const PhotoCamera(scale: 1.12, dx: -5),
      );
      final next = _input(to);
      try {
        final water = WaterRefractionEffect();
        expect(water.supportsInputs(current, next), true);
        expect(ReversedMaskEffect(water).supportsInputs(current, next), false);
        final inner = PhotoFilmDissolveEffect();
        final reversed = ReversedMaskEffect(inner);
        await tester.runAsync(reversed.prepare);
        final actual = await _frame(
          tester,
          reversed,
          current,
          next,
          progress: .3,
        );
        final expected = await _frame(
          tester,
          inner,
          next,
          current,
          progress: .7,
        );
        expect(actual, expected);
        expect(from.debugDisposed, false);
        expect(to.debugDisposed, false);
      } finally {
        await tester.pumpWidget(const SizedBox());
        from.dispose();
        to.dispose();
      }
      expect(tester.takeException(), isNull);
    },
  );
}
