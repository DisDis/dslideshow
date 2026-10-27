import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_bloc.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_event.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_slide.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_state.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/status/slideshow_status_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dslideshow_flutter/features/header/presentation/widgets/buttons_hint/buttons_hint_bloc.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/pages/slideshow_page.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/clock_screen_widget.dart';
import 'package:dslideshow_flutter/src/injector.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';

import 'screen_transition_test.dart' show TestFrontend, HiddenHints;

void main() {
  testWidgets(
    'stale screen callbacks cannot skip a pending screen or make it ready during sleep',
    (tester) async {
      final frontend = TestFrontend();
      final config = SlideShowConfig.fromJson({
        'displayTimeMs': 100,
        'specialScreens': [
          {
            'id': 'clock',
            'type': 'clock',
            'enabled': true,
            'schedule': {'count': 1},
          },
        ],
      });
      final status = SlideshowStatusBloc(
        frontendService: frontend,
        config: config,
      );
      final bloc = SlideshowBloc(
        frontendService: frontend,
        config: config,
        statusBloc: status,
      );
      addTearDown(() async {
        await bloc.close();
        await status.close();
        await frontend.close();
      });
      bloc.add(const SlideshowInitEvent());
      await tester.pump();
      bloc.add(const SlideshowImageReadyEvent());
      await tester.pump();
      bloc.add(const SlideshowTransitionCompleteEvent());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      final pending = bloc.state.nextSlide;
      bloc.add(const SlideshowSpecialUnavailableEvent('obsolete'));
      await tester.pump();
      expect(bloc.state.nextSlide, same(pending));
      expect(bloc.state.phase, SlideshowPhase.precaching);
      bloc.add(const SlideshowScreenStatePreparationEvent(false));
      await tester.pump();
      bloc.add(const SlideshowSpecialUnavailableEvent('clock'));
      await tester.pump();
      expect(bloc.state.nextSlide, same(pending));
      expect(bloc.state.phase, SlideshowPhase.precaching);
      bloc.add(const SlideshowImageReadyEvent());
      await tester.pump();
      expect(bloc.state.phase, SlideshowPhase.precaching);
      bloc.add(const SlideshowScreenStatePreparationEvent(true));
      await tester.pump();
      bloc.add(const SlideshowImageReadyEvent());
      await tester.pump();
      expect(bloc.state.phase, SlideshowPhase.transition);
    },
  );

  testWidgets('prepared special screen waits for pause to end', (tester) async {
    final frontend = TestFrontend();
    final config = SlideShowConfig.fromJson({
      'displayTimeMs': 100,
      'specialScreens': [
        {
          'id': 'clock',
          'type': 'clock',
          'enabled': true,
          'schedule': {'count': 1},
        },
      ],
    });
    final status = SlideshowStatusBloc(
      frontendService: frontend,
      config: config,
    );
    final bloc = SlideshowBloc(
      frontendService: frontend,
      config: config,
      statusBloc: status,
    );
    addTearDown(() async {
      await bloc.close();
      await status.close();
      await frontend.close();
    });
    bloc.add(const SlideshowInitEvent());
    await tester.pump();
    bloc.add(const SlideshowImageReadyEvent());
    await tester.pump();
    bloc.add(const SlideshowTransitionCompleteEvent());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(bloc.state.nextSlide, isA<SpecialSlide>());
    bloc.add(const SlideshowTogglePauseEvent(true));
    await tester.pump();
    bloc.add(const SlideshowImageReadyEvent());
    await tester.pump();
    expect(bloc.state.phase, isNot(SlideshowPhase.transition));
    expect(bloc.state.currentSlide, isA<MediaSlide>());
    bloc.add(const SlideshowTogglePauseEvent(false));
    await tester.pump();
    expect(bloc.state.phase, SlideshowPhase.transition);
  });
  testWidgets(
    'renderer transitions to a clock and closes its session on removal',
    (tester) async {
      final frontend = TestFrontend();
      final config = AppConfig.fromJson({
        'slideshow': {
          'effects': {
            'defaultDurationMs': 20,
            'items': {
              'fade': {'enabled': true},
            },
          },
          'displayTimeMs': 100,
          'specialScreens': [
            {
              'id': 'clock',
              'type': 'clock',
              'enabled': true,
              'schedule': {'count': 1},
              'displayTimeMs': 1000,
            },
          ],
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
      final hints = HiddenHints();
      injector.registerSingleton<AppConfig>(config);
      injector.registerSingleton<FrontendService>(frontend);
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
      for (var i = 0; i < 30 && bloc.state.currentSlide is! SpecialSlide; i++) {
        await tester.pump(const Duration(milliseconds: 16));
      }
      await tester.pump();
      expect(bloc.state.currentSlide, isA<SpecialSlide>());
      expect(find.byType(ClockScreenWidget), findsOneWidget);
      final session = tester
          .widget<ClockScreenWidget>(find.byType(ClockScreenWidget))
          .session;
      expect(session.active, true);
      frontend.screens.add(false);
      await tester.pump();
      expect(session.active, false);
      frontend.screens.add(true);
      await tester.pump();
      expect(session.active, true);
      await tester.pumpWidget(const SizedBox());
      expect(session.closed, true);
      await tester.runAsync(bloc.close);
      await tester.runAsync(status.close);
      await tester.runAsync(hints.close);
      await tester.runAsync(frontend.close);
      await injector.reset();
      expect(tester.takeException(), isNull);
    },
  );
  testWidgets(
    'clock insertion preserves media order, uses its duration and respects pause',
    (tester) async {
      final frontend = TestFrontend();
      final config = SlideShowConfig.fromJson({
        'effects': {
          'defaultDurationMs': 1000,
          'items': {
            'fade': {'enabled': true},
          },
        },
        'displayTimeMs': 100,
        'specialScreens': [
          {
            'id': 'clock',
            'type': 'clock',
            'enabled': true,
            'schedule': {'count': 1},
            'displayTimeMs': 300,
          },
        ],
      });
      final status = SlideshowStatusBloc(
        frontendService: frontend,
        config: config,
      );
      final bloc = SlideshowBloc(
        frontendService: frontend,
        config: config,
        statusBloc: status,
      );
      Future<void> display() async {
        bloc.add(const SlideshowImageReadyEvent());
        await tester.pump();
        bloc.add(const SlideshowTransitionCompleteEvent());
        await tester.pump();
      }

      bloc.add(const SlideshowInitEvent());
      await tester.pump();
      expect(bloc.state.nextSlide, isA<MediaSlide>());
      await display();
      expect(frontend.loads, 1);
      await tester.pump(const Duration(milliseconds: 100));
      expect(bloc.state.nextSlide, isA<SpecialSlide>());
      expect(frontend.loads, 1);
      await display();
      bloc.add(const SlideshowTogglePauseEvent(true));
      await tester.pump();
      await tester.pump(const Duration(seconds: 2));
      expect(bloc.state.currentSlide, isA<SpecialSlide>());
      expect(frontend.loads, 1);
      bloc.add(const SlideshowTogglePauseEvent(false));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 299));
      expect(frontend.loads, 1);
      await tester.pump(const Duration(milliseconds: 1));
      expect(frontend.loads, 2);
      expect(bloc.state.nextSlide, isA<MediaSlide>());
      await tester.runAsync(bloc.close);
      await tester.runAsync(status.close);
      await tester.runAsync(frontend.close);
    },
  );
  testWidgets('failed special screen continues to the next media item', (
    tester,
  ) async {
    final frontend = TestFrontend();
    final config = SlideShowConfig.fromJson({
      'displayTimeMs': 100,
      'specialScreens': [
        {
          'id': 'clock',
          'type': 'clock',
          'enabled': true,
          'schedule': {'count': 1},
        },
      ],
    });
    final status = SlideshowStatusBloc(
      frontendService: frontend,
      config: config,
    );
    final bloc = SlideshowBloc(
      frontendService: frontend,
      config: config,
      statusBloc: status,
    );
    bloc.add(const SlideshowInitEvent());
    await tester.pump();
    bloc.add(const SlideshowImageReadyEvent());
    await tester.pump();
    bloc.add(const SlideshowTransitionCompleteEvent());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(bloc.state.nextSlide, isA<SpecialSlide>());
    bloc.add(const SlideshowSpecialUnavailableEvent('clock'));
    await tester.pump();
    expect(frontend.loads, 2);
    expect(bloc.state.nextSlide, isA<MediaSlide>());
    await tester.runAsync(bloc.close);
    await tester.runAsync(status.close);
    await tester.runAsync(frontend.close);
  });
}
