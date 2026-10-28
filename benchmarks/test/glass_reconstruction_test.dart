import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:crypto/crypto.dart';
import 'package:dslideshow_flutter/effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

const _referenceAsset = 'shaders/glass_reconstruction_reference.frag';

Future<ui.Image> _photo(int width, int height, {required int seed}) async {
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  const colors = [
    Color(0xffff0000),
    Color(0xff0000ff),
    Color(0xffffffff),
    Color(0xff000000),
    Color(0x8000ff00),
    Color(0x00000000),
  ];
  final paint = Paint();
  for (var y = 0; y < height; y += 3) {
    for (var x = 0; x < width; x += 5) {
      paint.color = colors[(x ~/ 5 * 7 + y ~/ 3 * 11 + seed) % colors.length];
      canvas.drawRect(Rect.fromLTWH(x.toDouble(), y.toDouble(), 5, 3), paint);
    }
  }
  final picture = recorder.endRecording();
  try {
    return await picture.toImage(width, height);
  } finally {
    picture.dispose();
  }
}

Widget _scene(
  MediaSliderItemEffect effect,
  GlobalKey key,
  double t,
  ui.Image from,
  ui.Image to,
  Size size, {
  Matrix4? camera,
}) => Directionality(
  textDirection: TextDirection.ltr,
  child: Center(
    child: RepaintBoundary(
      key: key,
      child: SizedBox.fromSize(
        size: size,
        child: ColoredBox(
          color: Colors.black,
          child: Builder(
            builder: (context) => effect.createTransformWidget(
              context,
              ClipRect(
                child: Transform(
                  alignment: Alignment.center,
                  transform: camera ?? Matrix4.identity(),
                  child: RawImage(
                    image: from,
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
              RawImage(
                image: to,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
              ),
              AlwaysStoppedAnimation(t),
              size.width,
              size.height,
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

int _maximum(List<int> expected, List<int> actual) {
  expect(actual.length, expected.length);
  var maximum = 0;
  for (var index = 0; index < actual.length; index++) {
    final delta = (actual[index] - expected[index]).abs();
    if (delta > maximum) maximum = delta;
  }
  return maximum;
}

void main() {
  test(
    'the frozen reconstruction fixture remains distinct from production',
    () {
      final reference = File(_referenceAsset).readAsBytesSync();
      final production = File(
        '../dslideshow_flutter/lib/src/effect/shaders/photo_glass.frag',
      ).readAsBytesSync();
      expect(
        sha256.convert(reference).toString(),
        '5c3cec3c02c0a0b673dd5e4ce91755f84d02a8271e388a42d1aee9e85235e974',
      );
      expect(
      sha256.convert(production).toString(),
      isNot(sha256.convert(reference).toString()),
        reason: 'The strict pixel test must exercise the previous kernel',
      );
    },
  );

  testWidgets(
    'production Mitchell kernel matches the frozen shader on high contrast and alpha',
    (tester) async {
      final referenceProgram = (await tester.runAsync(
        () => ui.FragmentProgram.fromAsset(_referenceAsset),
      ))!;
      final from = (await tester.runAsync(() => _photo(160, 100, seed: 0)))!;
      final to = (await tester.runAsync(() => _photo(160, 100, seed: 3)))!;
      try {
        for (final size in [const Size(160, 100), const Size(100, 160)]) {
          for (final axis in EffectAxis.values) {
            for (final panes in [1, 3, 8, 17]) {
              final options = GlassEffectOptions(
                axis: axis,
                paneCount: panes,
                refractionStrength: 1.7,
                glintStrength: 1.4,
              );
              final reference = PhotoGlassEffect(
                options: options,
                shaderFactory: (_) => referenceProgram.fragmentShader(),
              )..bindPhotos(from, to);
              final candidate = PhotoGlassEffect(options: options)
                ..bindPhotos(from, to);
              await tester.runAsync(reference.prepare);
              await tester.runAsync(candidate.prepare);
              for (final phase in [0.0, .2, .5, .8, 1.0]) {
                final key = GlobalKey();
                await tester.pumpWidget(
                  _scene(reference, key, phase, from, to, size),
                );
                final expected = await _pixels(tester, key);
                await tester.pumpWidget(
                  _scene(candidate, key, phase, from, to, size),
                );
                final actual = await _pixels(tester, key);
                expect(
                  _maximum(expected, actual),
                  lessThanOrEqualTo(2),
                  reason: '$size/$axis/$panes/$phase',
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
    'different camera UVs and image sizes preserve independent sampling',
    (tester) async {
      final referenceProgram = (await tester.runAsync(
        () => ui.FragmentProgram.fromAsset(_referenceAsset),
      ))!;
      final from = (await tester.runAsync(() => _photo(160, 100, seed: 0)))!;
      final sameSize = (await tester.runAsync(
        () => _photo(160, 100, seed: 3),
      ))!;
      final differentSize = (await tester.runAsync(
        () => _photo(81, 127, seed: 2),
      ))!;
      try {
        for (final to in [sameSize, differentSize]) {
          for (final axis in EffectAxis.values) {
            for (final camera in [
              Matrix4.identity(),
              Matrix4.translationValues(.125, -.75, 0),
              Matrix4.identity()
                ..translateByDouble(-5, 3, 0, 1)
                ..scaleByDouble(1.12, 1.12, 1, 1),
            ]) {
              final options = GlassEffectOptions(
                axis: axis,
                paneCount: 3,
                refractionStrength: 2,
                glintStrength: .5,
              );
              final reference = PhotoGlassEffect(
                options: options,
                shaderFactory: (_) => referenceProgram.fragmentShader(),
              )..bindPhotos(from, to, fromCamera: camera);
              final candidate = PhotoGlassEffect(options: options)
                ..bindPhotos(from, to, fromCamera: camera);
              await tester.runAsync(reference.prepare);
              await tester.runAsync(candidate.prepare);
              for (final phase in [.1, .37, .8]) {
                final key = GlobalKey();
                await tester.pumpWidget(
                  _scene(
                    reference,
                    key,
                    phase,
                    from,
                    to,
                    const Size(160, 100),
                    camera: camera,
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
                    const Size(160, 100),
                    camera: camera,
                  ),
                );
                final actual = await _pixels(tester, key);
                expect(
                  _maximum(expected, actual),
                  lessThanOrEqualTo(2),
                  reason: '${to.width}x${to.height}/$axis/$camera/$phase',
                );
              }
            }
          }
        }
      } finally {
        await tester.pumpWidget(const SizedBox.shrink());
        from.dispose();
        sameSize.dispose();
        differentSize.dispose();
      }
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'production view reuses shader, rebinds borrowed photos and disposes only its resource',
    (tester) async {
      final from = (await tester.runAsync(() => _photo(160, 100, seed: 0)))!;
      final to = (await tester.runAsync(() => _photo(160, 100, seed: 3)))!;
      final shaders = <ui.FragmentShader>[];
      final candidate = PhotoGlassEffect(
        shaderFactory: (program) {
          final shader = program.fragmentShader();
          shaders.add(shader);
          return shader;
        },
      )..bindPhotos(from, to);
      try {
        await tester.runAsync(candidate.prepare);
        final key = GlobalKey();
        await tester.pumpWidget(
          _scene(candidate, key, .3, from, to, const Size(160, 100)),
        );
        final before = await _pixels(tester, key);
        candidate.bindPhotos(to, from);
        await tester.pumpWidget(
          _scene(candidate, key, .3, to, from, const Size(160, 100)),
        );
        expect(await _pixels(tester, key), isNot(orderedEquals(before)));
        expect(shaders, hasLength(1));
        await tester.pumpWidget(const SizedBox.shrink());
        expect(shaders.single.debugDisposed, isTrue);
        expect(from.debugDisposed, isFalse);
        expect(to.debugDisposed, isFalse);
        await tester.pumpWidget(
          _scene(candidate, GlobalKey(), .5, to, from, const Size(160, 100)),
        );
        expect(shaders, hasLength(2));
        await tester.pumpWidget(const SizedBox.shrink());
        expect(shaders.every((shader) => shader.debugDisposed), isTrue);
      } finally {
        await tester.pumpWidget(const SizedBox.shrink());
        from.dispose();
        to.dispose();
      }
      expect(tester.takeException(), isNull);
    },
  );
}
