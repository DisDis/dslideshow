import 'dart:async';
import 'dart:ui' as ui;

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/storage.dart';
import 'package:dslideshow_flutter/features/header/presentation/widgets/buttons_hint/buttons_hint_bloc.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_bloc.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_event.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_slide.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_state.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/status/slideshow_status_bloc.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/pages/slideshow_page.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/sessions/slide_session.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/sessions/slide_session_factory.dart';
import 'package:dslideshow_flutter/src/injector.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:dslideshow_flutter/src/service/screen_visibility_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/slideshow_frontend.dart';

class Fixture {
  final frontend = TestFrontend();
  final config = AppConfig.fromJson({
    'slideshow': {
      'effects': {
        'defaultDurationMs': 1000,
        'items': {
          'fade': {'enabled': true},
        },
      },
      'displayTimeMs': 5000,
      'fadeTimeMs': 2000,
    },
  });
  late final SlideshowStatusBloc status;
  late final SlideshowBloc slideshow;
  late final ScreenVisibilityCubit visibility;
  Fixture() {
    visibility = ScreenVisibilityCubit(frontend);
    status = SlideshowStatusBloc(frontendService: frontend, config: config.slideshow);
    slideshow = SlideshowBloc(frontendService: frontend, config: config.slideshow, statusBloc: status);
  }

  Widget page(
    HiddenHints hints, {
    GlobalKey? boundaryKey,
    SlideSessionFactory sessions = const SlideSessionFactory(),
  }) => MultiBlocProvider(
    providers: [
      BlocProvider<SlideshowBloc>.value(value: slideshow),
      BlocProvider<SlideshowStatusBloc>.value(value: status),
      BlocProvider<ButtonsHintBloc>.value(value: hints),
      BlocProvider<ScreenVisibilityCubit>.value(value: visibility),
    ],
    child: MaterialApp(
      home: RepaintBoundary(
        key: boundaryKey,
        child: ScreenVisibility(
          fadeDuration: Duration(milliseconds: config.slideshow.fadeTimeMs),
          child: SlideShowPage(sessionFactory: sessions),
        ),
      ),
    ),
  );

  Future<void> close() async {
    await visibility.close();
    await slideshow.close();
    await status.close();
    await frontend.close();
  }
}

class _WhiteSessionFactory extends SlideSessionFactory {
  const _WhiteSessionFactory();

  @override
  SlideSession create(
    SlideshowSlide slide, {
    required SlideShowConfig config,
    required Size size,
    required double pixelRatio,
    required TickerProvider vsync,
  }) => _WhiteSession();
}

class _WhiteSession extends SlideSession {
  @override
  Widget get view => const ColoredBox(color: Colors.white);

  @override
  Future<bool> prepareContents(BuildContext context) async => true;

  @override
  void setActivity({required SlideSessionRole role, required bool playing, required bool screenOn}) {}

  @override
  void disposeResources() {}
}

Animation<double> _screenOpacity(WidgetTester tester) =>
    tester.renderObject<RenderAnimatedOpacity>(find.byType(AnimatedOpacity)).opacity;

Future<int> _imageRedChannel(GlobalKey key) async {
  final boundary = key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
  final image = await boundary.toImage();
  try {
    final bytes = (await image.toByteData(format: ui.ImageByteFormat.rawRgba))!;
    final sample = ((image.height * 3 ~/ 4) * image.width + image.width ~/ 2) * 4;
    return bytes.getUint8(sample);
  } finally {
    image.dispose();
  }
}

void main() {
  for (final initiallyAsleep in [false, true]) {
    testWidgets('full wake fades from black${initiallyAsleep ? " when mounted asleep" : ""}', (tester) async {
      final f = Fixture();
      f.frontend.media = Completer<MediaItem>();
      if (initiallyAsleep) {
        f.frontend.isScreenVisible = false;
        f.frontend.screens.add(false);
        f.slideshow.add(const SlideshowScreenStatePreparationEvent(false));
        await tester.pump();
      }
      injector.registerSingleton<AppConfig>(f.config);
      injector.registerSingleton<FrontendService>(f.frontend);
      final hints = HiddenHints();
      await tester.pumpWidget(f.page(hints));
      await tester.pump();
      final animation = _screenOpacity(tester);
      if (initiallyAsleep) {
        expect(animation.value, 1);
      } else {
        expect(animation.value, 0);
        f.frontend.screens.add(false);
        await tester.pump();
        await tester.pump(const Duration(seconds: 2));
        expect(animation.value, 1);
      }

      f.frontend.screens.add(true);
      await tester.pump();
      expect(animation.value, 1);
      await tester.pump(const Duration(milliseconds: 1000));
      expect(animation.value, closeTo(0.5, 0.01));
      f.frontend.screens.add(true); // A duplicate must not restart the reveal.
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 1000));
      expect(animation.value, 0);
      expect(f.slideshow.state.isScreenLocked, isFalse);

      // A new sleep can also reverse an unfinished fade-in smoothly.
      f.frontend.screens.add(false);
      await tester.pump();
      await tester.pump(const Duration(seconds: 2));
      f.frontend.screens.add(true);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      final before = animation.value;
      f.frontend.screens.add(false);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 250));
      expect(animation.value, greaterThan(before));
      await tester.pump(const Duration(seconds: 2));
      expect(animation.value, 1);
      expect(f.slideshow.state.isScreenLocked, isTrue);

      await tester.pumpWidget(const SizedBox.shrink());
      f.frontend.media!.complete(MediaItem.empty);
      await tester.pump();
      await tester.runAsync(hints.close);
      await tester.runAsync(f.close);
      await injector.reset();
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('ON immediately reverses fade and stale work never overrides a later OFF', (tester) async {
    final f = Fixture();
    f.slideshow.add(const SlideshowTransitionCompleteEvent());
    await tester.pump();
    f.slideshow.add(const SlideshowScreenStatePreparationEvent(false));
    await tester.pump();
    expect(f.slideshow.state.isScreenLocked, isTrue);
    f.slideshow.add(const SlideshowScreenStatePreparationEvent(true));
    await tester.pump();
    expect(f.slideshow.state.isScreenLocked, isFalse);
    f.slideshow.add(const SlideshowScreenStatePreparationEvent(false));
    await tester.pump();
    await tester.pump(const Duration(seconds: 4));
    expect(f.slideshow.state.isScreenLocked, isTrue);
    expect(f.frontend.loads, 0);
    f.slideshow.add(const SlideshowScreenStatePreparationEvent(true));
    await tester.pump();
    expect(f.slideshow.state.isScreenLocked, isFalse);
    await tester.runAsync(f.close);
  });

  testWidgets('duplicate ON does not restart display deadline; pause survives wake', (tester) async {
    final f = Fixture();
    f.slideshow.add(const SlideshowInitEvent());
    await tester.pump();
    final initialLoads = f.frontend.loads;
    f.slideshow.add(const SlideshowTransitionCompleteEvent());
    await tester.pump();
    f.slideshow.add(const SlideshowScreenStatePreparationEvent(false));
    f.slideshow.add(const SlideshowScreenStatePreparationEvent(true));
    await tester.pump();
    await tester.pump(const Duration(seconds: 4));
    f.slideshow.add(const SlideshowScreenStatePreparationEvent(true));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    expect(f.frontend.loads, initialLoads + 1);
    f.slideshow.add(const SlideshowTogglePauseEvent(true));
    f.slideshow.add(const SlideshowScreenStatePreparationEvent(false));
    f.slideshow.add(const SlideshowScreenStatePreparationEvent(true));
    await tester.pump();
    await tester.pump(const Duration(seconds: 10));
    expect(f.slideshow.state.isPaused, isTrue);
    expect(f.slideshow.state.isScreenLocked, isFalse);
    expect(f.frontend.loads, initialLoads + 1);
    await tester.runAsync(f.close);
  });

  test('closing during media RPC does not wait for its obsolete response', () async {
    final f = Fixture();
    f.frontend.media = Completer<MediaItem>();
    f.slideshow.add(const SlideshowInitEvent());
    await Future<void>.delayed(Duration.zero);
    await f.slideshow.close();
    f.frontend.media!.complete(MediaItem.empty);
    await Future<void>.delayed(Duration.zero);
    expect(f.slideshow.isClosed, isTrue);
    await f.status.close();
    await f.visibility.close();
    await f.frontend.close();
  });

  test('closing during screen-turn RPC consumes a late failure', () async {
    final f = Fixture();
    f.frontend.turn = Completer<void>();
    f.status.add(const SlideshowScreenTurnEvent(false));
    await Future<void>.delayed(Duration.zero);
    expect(f.frontend.screenTurns, [false]);
    await f.status.close();
    f.frontend.turn!.completeError(StateError('late screen reply'));
    await Future<void>.delayed(Duration.zero);
    await f.slideshow.close();
    await f.visibility.close();
    await f.frontend.close();
  });

  test('closing during media RPC consumes its late failure', () async {
    final f = Fixture();
    f.frontend.media = Completer<MediaItem>();
    f.slideshow.add(const SlideshowInitEvent());
    await Future<void>.delayed(Duration.zero);
    await f.slideshow.close();
    f.frontend.media!.completeError(StateError('late media reply'));
    await Future<void>.delayed(Duration.zero);
    expect(f.slideshow.isClosed, isTrue);
    await f.status.close();
    await f.visibility.close();
    await f.frontend.close();
  });

  testWidgets('production screen wrapper reverses the black overlay from its current opacity', (tester) async {
    final f = Fixture();
    f.frontend.media = Completer<MediaItem>();
    injector.registerSingleton<AppConfig>(f.config);
    injector.registerSingleton<FrontendService>(f.frontend);
    final hints = HiddenHints();
    await tester.pumpWidget(f.page(hints));
    await tester.pump();
    f.frontend.screens.add(false);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    final animation = _screenOpacity(tester);
    final before = animation.value;
    expect(before, greaterThan(0));
    expect(before, lessThan(1));
    f.frontend.screens.add(true);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 250));
    expect(animation.value, lessThan(before));
    await tester.pump(const Duration(seconds: 2));
    expect(animation.value, 0);
    f.frontend.screens.add(false);
    await tester.pump();
    await tester.pump(const Duration(seconds: 4));
    expect(animation.value, 1);
    expect(f.slideshow.state.isScreenLocked, isTrue);
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.runAsync(hints.close);
    f.frontend.media!.complete(MediaItem.empty);
    await tester.pump();
    await tester.runAsync(f.close);
    await injector.reset();
    expect(tester.takeException(), isNull);
  });

  testWidgets('production slideshow fades media once and reverses without a brightness jump', (tester) async {
    tester.view.physicalSize = const Size(320, 160);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final f = Fixture();
    final hints = HiddenHints();
    final boundaryKey = GlobalKey();
    injector.registerSingleton<AppConfig>(f.config);
    injector.registerSingleton<FrontendService>(f.frontend);
    try {
      await tester.pumpWidget(f.page(hints, boundaryKey: boundaryKey, sessions: const _WhiteSessionFactory()));
      for (var frame = 0; frame < 160 && f.slideshow.state.phase != SlideshowPhase.display; frame++) {
        await tester.pump(const Duration(milliseconds: 10));
      }
      expect(f.slideshow.state.phase, SlideshowPhase.display);
      expect(await tester.runAsync(() => _imageRedChannel(boundaryKey)), 255);

      f.frontend.screens.add(false);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 1000));
      final halfDimmed = (await tester.runAsync(() => _imageRedChannel(boundaryKey)))!;
      expect(halfDimmed, closeTo(128, 2));

      f.frontend.screens.add(true);
      await tester.pump();
      expect(await tester.runAsync(() => _imageRedChannel(boundaryKey)), closeTo(halfDimmed, 1));
      await tester.pump(const Duration(milliseconds: 500));
      expect(await tester.runAsync(() => _imageRedChannel(boundaryKey)), greaterThan(halfDimmed));
      await tester.pump(const Duration(milliseconds: 1500));
      expect(await tester.runAsync(() => _imageRedChannel(boundaryKey)), 255);

      f.frontend.screens.add(false);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 2000));
      expect(await tester.runAsync(() => _imageRedChannel(boundaryKey)), 0);
      f.frontend.screens.add(true);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 1000));
      expect(await tester.runAsync(() => _imageRedChannel(boundaryKey)), closeTo(128, 2));
    } finally {
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.runAsync(hints.close);
      await tester.runAsync(f.close);
      await injector.reset();
    }
  });
}
