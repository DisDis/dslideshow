import 'dart:async';

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/features/header/presentation/widgets/buttons_hint/buttons_hint_bloc.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_bloc.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_event.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_slide.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_state.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/status/slideshow_status_bloc.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/pages/slideshow_page.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/sessions/special_screen_session.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/sessions/cameras_screen_session.dart';
import 'package:dslideshow_flutter/src/service/camera_snapshot_client.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/special_screen_renderers.dart';
import 'package:dslideshow_flutter/src/injector.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'support/slideshow_frontend.dart';

class DeferredScreen extends SpecialScreenSession {
  final int cameraIndex;
  final readiness = Completer<bool>();
  DeferredScreen(super.config, this.cameraIndex);
  @override
  // Model a request whose result can still arrive after its owner cancels it.
  Future<bool> prepare() => readiness.future;
}

class ScreenFixture {
  final SpecialScreenSession Function(SpecialScreenConfig, int)? createSession;
  ScreenFixture({this.createSession});
  final createdSessions = <SpecialScreenSession>[];
  final frontend = TestFrontend();
  final sessions = <DeferredScreen>[];
  final hints = HiddenHints();
  final config = AppConfig.fromJson({
    'slideshow': {
      'effects': {
        'defaultDurationMs': 100,
        'items': {
          'fade': {'enabled': true},
        },
      },
      'displayTimeMs': 100,
      'specialScreens': [
        {
          'id': 'cameras',
          'type': 'cameras',
          'enabled': true,
          'displayTimeMs': 100,
          'schedule': {'count': 1},
          'options': {
            'mode': 'sequence',
            'refreshIntervalMs': 100,
            'cameras': [
              {'id': 'one', 'url': 'http://camera/one'},
              {'id': 'two', 'url': 'http://camera/two'},
            ],
          },
        },
      ],
    },
  });
  late final status = SlideshowStatusBloc(
    frontendService: frontend,
    config: config.slideshow,
  );
  late final bloc = SlideshowBloc(
    frontendService: frontend,
    config: config.slideshow,
    statusBloc: status,
  );
  late final SpecialScreenRenderer original;
  bool _disposed = false;
  Future<void> dispose(WidgetTester tester) async {
    if (_disposed) return;
    _disposed = true;
    await tester.pumpWidget(const SizedBox());
    await tester.runAsync(bloc.close);
    await tester.runAsync(status.close);
    await tester.runAsync(frontend.close);
    await tester.runAsync(hints.close);
    await injector.reset();
    SpecialScreenRenderers.definitions[SpecialScreenType.cameras] = original;
  }

  Future<void> mount(WidgetTester tester) async {
    original = SpecialScreenRenderers.definitions[SpecialScreenType.cameras]!;
    SpecialScreenRenderers.definitions[SpecialScreenType
        .cameras] = SpecialScreenRenderer((config, index) {
      final session =
          createSession?.call(config, index) ?? DeferredScreen(config, index);
      createdSessions.add(session);
      if (session is DeferredScreen) sessions.add(session);
      return session;
    }, (_) => const ColoredBox(color: Colors.blue));
    injector.registerSingleton<AppConfig>(config);
    injector.registerSingleton<FrontendService>(frontend);
    addTearDown(() => dispose(tester));
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
    await until(tester, () => createdSessions.isNotEmpty);
  }

  Future<void> until(WidgetTester tester, bool Function() condition) async {
    for (var i = 0; i < 120 && !condition(); i++) {
      await tester.pump(const Duration(milliseconds: 16));
    }
    expect(
      condition(),
      true,
      reason:
          'phase=${bloc.state.phase}, current=${bloc.state.currentSlide}, '
          'next=${bloc.state.nextSlide}, loads=${frontend.loads}, '
          'sessions=${createdSessions.length}',
    );
  }
}

void main() {
  testWidgets(
    'late cancelled camera preparation cannot replace the wake retry',
    (tester) async {
      final f = ScreenFixture();
      await f.mount(tester);
      final cancelled = f.sessions.single;
      f.frontend.screens.add(false);
      await tester.pump();
      f.frontend.screens.add(true);
      await tester.pump();
      final retry = f.sessions.last;
      expect(retry, isNot(same(cancelled)));
      expect(cancelled.closed, true);
      cancelled.readiness.complete(true);
      await tester.pump();
      expect(f.bloc.state.phase, SlideshowPhase.precaching);
      expect(f.bloc.state.currentSlide, isA<MediaSlide>());
      expect(retry.closed, false);
      expect(f.frontend.loads, 1);
      retry.readiness.complete(true);
      await f.until(tester, () => f.bloc.state.currentSlide is SpecialSlide);
      expect((f.bloc.state.currentSlide as SpecialSlide).cameraIndex, 0);
      expect(retry.active, true);
      expect(tester.takeException(), isNull);
      await f.dispose(tester);
    },
  );

  for (final fails in [false, true]) {
    testWidgets(
      'page close releases pending camera before late ${fails ? "failure" : "success"}',
      (tester) async {
        final f = ScreenFixture();
        await f.mount(tester);
        final pending = f.sessions.single;
        final state = f.bloc.state;
        await tester.pumpWidget(const SizedBox());
        expect(pending.closed, true);
        if (fails) {
          pending.readiness.completeError(StateError('late camera response'));
        } else {
          pending.readiness.complete(true);
        }
        await tester.pump();
        expect(f.bloc.state, same(state));
        expect(f.frontend.loads, 1);
        expect(tester.takeException(), isNull);
        await f.dispose(tester);
      },
    );
  }

  for (final fails in [false, true]) {
    testWidgets(
      'renderer skips ${fails ? "throwing" : "unavailable"} camera without blocking media order',
      (tester) async {
        final f = ScreenFixture();
        await f.mount(tester);
        final unavailable = f.sessions.single;
        if (fails) {
          unavailable.readiness.completeError(StateError('camera unavailable'));
        } else {
          unavailable.readiness.complete(false);
        }
        await f.until(
          tester,
          () =>
              f.frontend.loads == 2 &&
              f.bloc.state.phase == SlideshowPhase.display,
        );
        expect(unavailable.closed, true);
        expect(f.bloc.state.currentSlide, isA<MediaSlide>());
        expect(f.sessions, hasLength(1));
        expect(tester.takeException(), isNull);
        await f.dispose(tester);
      },
    );
  }

  testWidgets(
    'paused live cameras refresh until sleep and resume while still paused',
    (tester) async {
      var requests = 0;
      late CamerasScreenSession camera;
      final f = ScreenFixture(
        createSession: (config, index) {
          camera = CamerasScreenSession(
            config,
            cameraIndex: index,
            client: CameraSnapshotClient(
              createClient: () => MockClient((_) async {
                requests++;
                return http.Response('offline', 503);
              }),
            ),
          );
          return camera;
        },
      );
      await f.mount(tester);
      await f.until(tester, () => f.bloc.state.currentSlide is SpecialSlide);
      f.bloc.add(const SlideshowTogglePauseEvent(true));
      await tester.pump();
      final initialRequests = requests;
      await tester.pump(const Duration(milliseconds: 100));
      expect(requests, greaterThan(initialRequests));
      expect(camera.active, true);
      expect(f.frontend.loads, 1);
      f.frontend.screens.add(false);
      await tester.pump();
      final beforeSleep = requests;
      await tester.pump(const Duration(seconds: 1));
      expect(requests, beforeSleep);
      expect(camera.active, false);
      f.frontend.screens.add(true);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      expect(requests, greaterThan(beforeSleep));
      expect(camera.active, true);
      expect(f.bloc.state.isPaused, true);
      expect(f.frontend.loads, 1);
      await f.dispose(tester);
      expect(camera.closed, true);
      final afterClose = requests;
      await tester.pump(const Duration(seconds: 1));
      expect(requests, afterClose);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('sleep during preparation retries the same camera turn on wake', (
    tester,
  ) async {
    final f = ScreenFixture();
    await f.mount(tester);
    expect(f.bloc.state.phase, SlideshowPhase.precaching);
    expect(f.sessions.single.cameraIndex, 0);
    f.frontend.screens.add(false);
    await tester.pump();
    expect(f.sessions.first.closed, true);
    expect(f.bloc.state.phase, SlideshowPhase.precaching);
    f.frontend.screens.add(true);
    await tester.pump();
    expect(f.sessions, hasLength(2));
    expect(f.sessions.last.cameraIndex, 0);
    f.sessions.last.readiness.complete(true);
    await tester.pump();
    await f.until(tester, () => f.bloc.state.currentSlide is SpecialSlide);
    expect(f.frontend.loads, 1);
    await f.dispose(tester);
  });
  testWidgets(
    'pause and sleep freeze transitions without consuming camera turns',
    (tester) async {
      final f = ScreenFixture();
      await f.mount(tester);
      f.sessions.last.readiness.complete(true);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 16));
      expect(f.bloc.state.phase, SlideshowPhase.transition);
      f.bloc.add(const SlideshowTogglePauseEvent(true));
      await tester.pump();
      for (var i = 0; i < 40; i++) {
        await tester.pump(const Duration(milliseconds: 16));
      }
      expect(f.bloc.state.currentSlide, isA<MediaSlide>());
      f.bloc.add(const SlideshowTogglePauseEvent(false));
      await tester.pump();
      await f.until(tester, () => f.bloc.state.currentSlide is SpecialSlide);
      await f.until(tester, () => f.sessions.length == 2);
      expect(f.sessions.last.cameraIndex, 1);
      f.sessions.last.readiness.complete(true);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 16));
      f.frontend.screens.add(false);
      await tester.pump();
      for (var i = 0; i < 40; i++) {
        await tester.pump(const Duration(milliseconds: 16));
      }
      expect(f.bloc.state.currentSlide, isA<MediaSlide>());
      f.frontend.screens.add(true);
      await tester.pump();
      await f.until(tester, () => f.bloc.state.currentSlide is SpecialSlide);
      expect((f.bloc.state.currentSlide as SpecialSlide).cameraIndex, 1);
      await f.dispose(tester);
    },
  );
}
