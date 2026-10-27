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
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/special_screen_renderers.dart';
import 'package:dslideshow_flutter/src/injector.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'screen_transition_test.dart' show TestFrontend, HiddenHints;

class DeferredScreen extends SpecialScreenSession {
  final int cameraIndex;
  final readiness = Completer<bool>();
  DeferredScreen(super.config, this.cameraIndex);
  @override
  Future<bool> prepare() => readiness.future;
  @override
  void dispose() {
    if (!readiness.isCompleted) readiness.complete(false);
    super.dispose();
  }
}

class ScreenFixture {
  final frontend = TestFrontend();
  final sessions = <DeferredScreen>[];
  final hints = HiddenHints();
  final config = AppConfig.fromJson({
    'slideshow': {
      'effects': {
        'defaultDurationMs': 100,
        'items': [
          {'type': 'fade', 'enabled': true},
        ],
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
    SpecialScreenRenderers.definitions[SpecialScreenType.cameras] =
        SpecialScreenRenderer((config, index) {
          final session = DeferredScreen(config, index);
          sessions.add(session);
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
    await until(tester, () => sessions.isNotEmpty);
  }

  Future<void> until(WidgetTester tester, bool Function() condition) async {
    for (var i = 0; i < 120 && !condition(); i++) {
      await tester.pump(const Duration(milliseconds: 16));
    }
    expect(condition(), true);
  }
}

void main() {
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
