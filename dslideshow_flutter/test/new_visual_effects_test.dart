import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/effect.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/photo_motion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

class MotionHost extends StatefulWidget {
  const MotionHost({super.key});
  @override
  State<MotionHost> createState() => MotionHostState();
}

class MotionHostState extends State<MotionHost> with TickerProviderStateMixin {
  late final session = PhotoMotionSession(
    vsync: this,
    duration: const Duration(seconds: 1),
    config: PhotoMotionConfig(),
    seed: 4,
  );
  bool reparent = false;
  @override
  Widget build(BuildContext context) {
    final view = session.view(const ColoredBox(color: Colors.orange));
    return SizedBox(
      width: 160,
      height: 100,
      child: reparent ? Stack(children: [Positioned.fill(child: view)]) : view,
    );
  }

  void move() => setState(() => reparent = true);
  @override
  void dispose() {
    session.dispose();
    super.dispose();
  }
}

void main() {
  test(
    'camera covers the viewport for every direction and zoom without reset',
    () {
      const size = Size(2560, 1600);
      for (final seed in List.generate(12, (i) => i)) {
        for (final zoom in [1.0, 1.06, 1.15]) {
          final path = PhotoMotionPath(seed: seed, maxZoom: zoom);
          expect(path.transform(size, 0), Matrix4.identity());
          for (var i = 0; i <= 100; i++) {
            final matrix = path.transform(size, i / 100);
            final sx = matrix.storage[0],
                tx = matrix.storage[12],
                ty = matrix.storage[13];
            expect(size.width / 2 * (1 - sx) + tx, lessThanOrEqualTo(0.00001));
            expect(
              size.width / 2 * (1 + sx) + tx,
              greaterThanOrEqualTo(size.width - .00001),
            );
            expect(size.height / 2 * (1 - sx) + ty, lessThanOrEqualTo(0.00001));
            expect(
              size.height / 2 * (1 + sx) + ty,
              greaterThanOrEqualTo(size.height - .00001),
            );
          }
        }
      }
      expect(
        PhotoMotionPath.seedFor('photo-A'),
        PhotoMotionPath.seedFor('photo-A'),
      );
      expect(
        PhotoMotionPath.seedFor('photo-A'),
        isNot(PhotoMotionPath.seedFor('photo-B')),
      );
    },
  );
  testWidgets(
    'motion freezes on pause/sleep, resumes smoothly and survives reparenting',
    (tester) async {
      final key = GlobalKey<MotionHostState>();
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: MotionHost(key: key),
        ),
      );
      final session = key.currentState!.session;
      session.setPlaying(true);
      for (var i = 0; i < 20; i++) {
        await tester.pump(const Duration(milliseconds: 16));
      }
      expect(session.progress, greaterThan(0));
      final beforePause = session.progress;
      session.setPlaying(false);
      await tester.pump(const Duration(seconds: 2));
      expect(session.progress, beforePause);
      key.currentState!.move();
      await tester.pump();
      expect(session.progress, beforePause);
      session.setPlaying(true);
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      expect(session.progress - beforePause, lessThanOrEqualTo(.010001));
      expect(session.progress, greaterThan(beforePause));
      await tester.pumpWidget(const SizedBox());
      expect(tester.takeException(), isNull);
    },
  );
  test(
    'water only accepts two static photos; masks accept every media pair',
    () {
      for (final a in TransitionMedia.values) {
        for (final b in TransitionMedia.values) {
          expect(
            Effect.waterRefractionEffect.supportsMedia(a, b),
            a == TransitionMedia.photo && b == TransitionMedia.photo,
          );
          expect(Effect.rippleRevealEffect.supportsMedia(a, b), isTrue);
          expect(Effect.noiseDissolveEffect.supportsMedia(a, b), isTrue);
        }
      }
    },
  );
  testWidgets(
    'reveals preserve endpoints, evolve, seed deterministically and actually refract pixels',
    (tester) async {
      Future<ui.Image> photo(bool other) async {
        final recorder = ui.PictureRecorder();
        final canvas = Canvas(recorder);
        canvas.drawColor(other ? Colors.green : Colors.orange, BlendMode.src);
        for (var x = 0; x < 160; x += 4) {
          canvas.drawRect(
            Rect.fromLTWH(x.toDouble(), 0, 2, 100),
            Paint()..color = other ? Colors.blue : Colors.purple,
          );
        }
        final picture = recorder.endRecording();
        final result = (await tester.runAsync(
          () => picture.toImage(160, 100),
        ))!;
        picture.dispose();
        return result;
      }

      final a = await photo(false), b = await photo(true);
      addTearDown(a.dispose);
      addTearDown(b.dispose);
      final source = RawImage(
        image: a,
        fit: BoxFit.fill,
        filterQuality: FilterQuality.high,
      );
      final target = RawImage(
        image: b,
        fit: BoxFit.fill,
        filterQuality: FilterQuality.high,
      );
      Future<Uint8List> capture(MediaSliderItemEffect? effect, double t) async {
        final key = GlobalKey();
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child: SizedBox(
                width: 160,
                height: 100,
                child: RepaintBoundary(
                  key: key,
                  child: Builder(
                    builder: (context) =>
                        effect?.createTransformWidget(
                          context,
                          RepaintBoundary(child: source),
                          RepaintBoundary(child: target),
                          AlwaysStoppedAnimation(t),
                          160,
                          100,
                        ) ??
                        (t == 0 ? source : target),
                  ),
                ),
              ),
            ),
          ),
        );
        return (await tester.runAsync(() async {
          final image =
              await (key.currentContext!.findRenderObject()!
                      as RenderRepaintBoundary)
                  .toImage();
          final bytes = await image.toByteData(
            format: ui.ImageByteFormat.rawRgba,
          );
          final result = Uint8List.fromList(bytes!.buffer.asUint8List());
          image.dispose();
          return result;
        }))!;
      }

      final from = await capture(null, 0), to = await capture(null, 1);
      final noise = Effect.noiseDissolveEffect.createEffect(seed: 42);
      final sameNoise = Effect.noiseDissolveEffect.createEffect(seed: 42);
      final otherNoise = Effect.noiseDissolveEffect.createEffect(seed: 77);
      final ripple = Effect.rippleRevealEffect.createEffect();
      final base = ProceduralRevealEffect(
        ProceduralRevealKind.waterBase,
        seed: 0,
      );
      final water = WaterRefractionEffect()..bindPhotos(a, b);
      for (final effect in [
        noise,
        sameNoise,
        otherNoise,
        ripple,
        base,
        water,
      ]) {
        await tester.runAsync(effect.prepare);
      }
      for (final effect in [noise, ripple, water]) {
        expect(await capture(effect, 0), from);
        expect(await capture(effect, 1), to);
        final hashes = <String>{};
        for (final t in [.2, .35, .5, .65, .8]) {
          hashes.add((await capture(effect, t)).toString());
        }
        expect(hashes.length, 5);
      }
      final noisePixels = await capture(noise, .5);
      expect(await capture(sameNoise, .5), noisePixels);
      expect(await capture(otherNoise, .5), isNot(noisePixels));
      final unwarped = await capture(base, .5),
          warped = await capture(water, .5);
      var changed = 0, outsideChanged = 0;
      for (var y = 0; y < 100; y++) {
        for (var x = 0; x < 160; x++) {
          final offset = (y * 160 + x) * 4;
          final delta = (warped[offset] - unwarped[offset]).abs();
          if (delta > 5) changed++;
          if (x < 5 && y < 5 && delta > 0) outsideChanged++;
        }
      }
      expect(changed, greaterThan(100));
      expect(
        outsideChanged,
        0,
        reason: 'Refraction is localized at the wave front',
      );
      // Dispose render shaders before their borrowed inputs.
      await tester.pumpWidget(const SizedBox());
      expect(tester.takeException(), isNull);
    },
  );
}
