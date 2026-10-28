import 'dart:io';
import 'dart:ui' as ui;

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/storage.dart';
import 'package:dslideshow_flutter/effect.dart';
import 'package:dslideshow_flutter/features/header/presentation/widgets/buttons_hint/buttons_hint_bloc.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_bloc.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_event.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_state.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/status/slideshow_status_bloc.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/pages/slideshow_page.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/image_widget.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/photo_motion.dart';
import 'package:dslideshow_flutter/src/injector.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/slideshow_frontend.dart';

class PhotoFrontend extends TestFrontend {
  final Directory folder;
  PhotoFrontend(this.folder);
  @override
  Future<MediaItem> getStorageCurrentItem() async => MediaItem(
    'photo-$loads',
    File('${folder.path}/${loads.isEven ? 'b' : 'a'}.png').uri,
  );
}

void main() {
  for (final descriptor in [
    Effect.waterRefractionEffect,
    Effect.radialBlurEffect,
    Effect.glassEffect,
    const Effect(
      EffectType.glass,
      options: GlassEffectOptions(axis: EffectAxis.horizontal),
    ),
    Effect.filmDissolveEffect.canonical,
  ]) {
    final type = descriptor.type;
    for (final mode in PhotoMotionMode.values) {
      testWidgets(
        'real renderer owns pixels through ${descriptor.name}/${descriptor.options.toJson()}, motion $mode',
        (tester) async {
          tester.view.devicePixelRatio = 1.25;
          tester.view.physicalSize = const Size(1000, 640);
          addTearDown(tester.view.resetDevicePixelRatio);
          addTearDown(tester.view.resetPhysicalSize);
          final folder = (await tester.runAsync(
            () => Directory.systemTemp.createTemp('photo-renderer-'),
          ))!;
          await tester.runAsync(() async {
            for (final name in ['a', 'b']) {
              final recorder = ui.PictureRecorder();
              Canvas(recorder).drawColor(
                name == 'a' ? Colors.orange : Colors.blue,
                BlendMode.src,
              );
              final picture = recorder.endRecording(),
                  image = await picture.toImage(160, 100);
              final bytes = await image.toByteData(
                format: ui.ImageByteFormat.png,
              );
              await File('${folder.path}/$name.png')
                  .writeAsBytes(bytes!.buffer.asUint8List());
              image.dispose();
              picture.dispose();
            }
          });
          final frontend = PhotoFrontend(folder), hints = HiddenHints();
          final config = AppConfig.fromJson({
            'slideshow': {
              'effects': {
                'defaultDurationMs': 100,
                'items': {type.name: descriptor.toConfig().toJson()},
              },
              'displayTimeMs': 100000,
              'photoMotion': {'mode': mode.name},
            },
          });
          final status = SlideshowStatusBloc(
            frontendService: frontend,
            config: config.slideshow,
          );
          final bloc = SlideshowBloc(
            frontendService: frontend,
            config: config.slideshow,
            statusBloc: status,
          );
          injector.registerSingleton<AppConfig>(config);
          injector.registerSingleton<FrontendService>(frontend);
          bool cleaned = false;
          Future<void> cleanup() async {
            if (cleaned) return;
            cleaned = true;
            await tester.pumpWidget(const SizedBox());
            await tester.runAsync(bloc.close);
            await tester.runAsync(status.close);
            await tester.runAsync(frontend.close);
            await tester.runAsync(hints.close);
            await injector.reset();
            await tester.runAsync(() => folder.delete(recursive: true));
          }

          addTearDown(cleanup);
          Future<void> until(bool Function() predicate) async {
            for (var i = 0; i < 300 && !predicate(); i++) {
              await tester.runAsync(
                () => Future<void>.delayed(const Duration(milliseconds: 10)),
              );
              await tester.pump(const Duration(milliseconds: 16));
            }
            expect(
              predicate(),
              true,
              reason:
                  'phase=${bloc.state.phase}, paused=${bloc.state.isPaused}, loads=${frontend.loads}',
            );
          }

          await tester.pumpWidget(
            MultiBlocProvider(
              providers: [
                BlocProvider<SlideshowBloc>.value(value: bloc),
                BlocProvider<SlideshowStatusBloc>.value(value: status),
                BlocProvider<ButtonsHintBloc>.value(value: hints),
              ],
              child: const MaterialApp(home: SlideShowPage()),
            ),
          );
          await until(() => bloc.state.phase == SlideshowPhase.display);
          expect(
            bloc.state.effect.type,
            type == EffectType.waterRefraction ? EffectType.fade : type,
          );
          expect(bloc.state.effect.options.durationMs, 100);
          final first = tester.widget<ImageWidget>(find.byType(ImageWidget));
          expect(first.preparedBitmap, isNotNull);
          final firstPixels = first.preparedBitmap!;
          Animation<double>? photoClock;
          if (mode == PhotoMotionMode.kenBurns) {
            expect(
              first.preparedBitmap!.width,
              (tester.view.physicalSize.width *
                      PhotoMotionPath.preparationScale)
                  .round(),
            );
            for (var i = 0; i < 20; i++) {
              await tester.pump(const Duration(milliseconds: 16));
            }
            final pose = tester
                .widget<PhotoMotionFrame>(find.byType(PhotoMotionFrame))
                .progress;
            find
                .byType(PhotoMotionFrame)
                .evaluate()
                .single
                .visitAncestorElements((ancestor) {
                  if (ancestor.widget case AnimatedBuilder(
                    animation: final Animation<double> animation,
                  )) {
                    photoClock = animation;
                    return false;
                  }
                  return true;
                });
            expect(photoClock, isNotNull);
            expect(pose, greaterThan(0));
            bloc.add(const SlideshowTogglePauseEvent(true));
            await tester.pump();
            await tester.pump(const Duration(seconds: 1));
            expect(
              tester
                  .widget<PhotoMotionFrame>(find.byType(PhotoMotionFrame))
                  .progress,
              pose,
            );
            bloc.add(const SlideshowTogglePauseEvent(false));
            await tester.pump();
          } else {
            expect(find.byType(PhotoMotionFrame), findsNothing);
          }
          bloc.add(const SlideshowLoadNextEvent());
          await tester.pump();
          await until(() => bloc.state.phase == SlideshowPhase.transition);
          expect(bloc.state.effect.type, type);
          expect(bloc.state.effect.options.durationMs, 100);
          final frozenCameraProgress = photoClock?.value;
          final frozen =
              mode == PhotoMotionMode.kenBurns &&
                  type == EffectType.waterRefraction
              ? tester
                    .widgetList<PhotoMotionFrame>(find.byType(PhotoMotionFrame))
                    .map((frame) => frame.progress)
                    .toList()
              : null;
          await tester.pump(const Duration(milliseconds: 16));
          await tester.pump(const Duration(milliseconds: 16));
          expect(photoClock?.value, frozenCameraProgress);
          expect(firstPixels.debugDisposed, isFalse);
          if (type != EffectType.waterRefraction) {
            expect(
              find.byType(ImageWidget),
              findsNothing,
              reason:
                  'A static pair renders from its borrowed full-size pixels',
            );
          }
          if (frozen != null) {
            expect(
              tester
                  .widgetList<PhotoMotionFrame>(find.byType(PhotoMotionFrame))
                  .map((frame) => frame.progress)
                  .toList(),
              frozen,
            );
          }
          await until(() => bloc.state.phase == SlideshowPhase.display);
          expect(
            first.preparedBitmap,
            isNull,
            reason: 'Old bitmap released after transition views detach',
          );
          expect(firstPixels.debugDisposed, isTrue);
          expect(
            firstPixels.debugGetOpenHandleStackTraces(),
            isEmpty,
            reason:
                'Detached outgoing photo releases every borrowed image handle',
          );
          expect(tester.takeException(), isNull);
          final currentPixels = tester
              .widget<ImageWidget>(find.byType(ImageWidget))
              .preparedBitmap!;
          // Close inside the test body so fake display timers are cancelled before invariant checks.
          await cleanup();
          expect(currentPixels.debugDisposed, isTrue);
          expect(
            currentPixels.debugGetOpenHandleStackTraces(),
            isEmpty,
            reason: 'Page removal releases every borrowed current photo handle',
          );
        },
      );
    }
  }
}
