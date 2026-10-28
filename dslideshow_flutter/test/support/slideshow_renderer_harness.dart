import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/features/header/presentation/widgets/buttons_hint/buttons_hint_bloc.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_bloc.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/status/slideshow_status_bloc.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/pages/slideshow_page.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/sessions/slide_session_factory.dart';
import 'package:dslideshow_flutter/src/injector.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'slideshow_frontend.dart';

class SlideshowRendererHarness {
  final TestFrontend frontend;
  final AppConfig config;
  final SlideSessionFactory sessionFactory;
  final hints = HiddenHints();
  final visible = ValueNotifier(true);
  late final status = SlideshowStatusBloc(
    frontendService: frontend,
    config: config.slideshow,
  );
  late final bloc = SlideshowBloc(
    frontendService: frontend,
    config: config.slideshow,
    statusBloc: status,
  );
  bool _closed = false;

  SlideshowRendererHarness({
    required this.frontend,
    this.sessionFactory = const SlideSessionFactory(),
    AppConfig? config,
  }) : config =
           config ??
           AppConfig.fromJson({
             'slideshow': {
               'effects': {
                 'defaultDurationMs': 100,
                 'items': {
                   'fade': {'enabled': true},
                 },
               },
               'displayTimeMs': 100000,
             },
           });

  Future<void> mount(WidgetTester tester) async {
    injector.registerSingleton<AppConfig>(config);
    injector.registerSingleton<FrontendService>(frontend);
    addTearDown(() => close(tester));
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<SlideshowBloc>.value(value: bloc),
          BlocProvider<SlideshowStatusBloc>.value(value: status),
          BlocProvider<ButtonsHintBloc>.value(value: hints),
        ],
        child: MaterialApp(
          home: ValueListenableBuilder(
            valueListenable: visible,
            builder: (_, showPage, _) => showPage
                ? SlideShowPage(sessionFactory: sessionFactory)
                : const SizedBox(),
          ),
        ),
      ),
    );
  }

  Future<void> until(WidgetTester tester, bool Function() condition) async {
    for (var frames = 0; frames < 240 && !condition(); frames++) {
      // Yield a real event-loop turn for file/decode completion, without a
      // fixed I/O delay or advancing animation by more than one frame.
      await tester.runAsync(() => Future<void>(() {}));
      await tester.pump(const Duration(milliseconds: 16));
    }
    expect(
      condition(),
      true,
      reason:
          'phase=${bloc.state.phase}, current=${bloc.state.currentSlide}, '
          'next=${bloc.state.nextSlide}, loads=${frontend.loads}',
    );
  }

  Future<void> close(WidgetTester tester) async {
    if (_closed) return;
    _closed = true;
    await tester.pumpWidget(const SizedBox());
    await tester.runAsync(bloc.close);
    await tester.runAsync(status.close);
    await tester.runAsync(frontend.close);
    await tester.runAsync(hints.close);
    visible.dispose();
    await injector.reset();
  }
}
