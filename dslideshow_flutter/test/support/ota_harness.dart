import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/features/ota/presentation/bloc/ota_bloc.dart';
import 'package:dslideshow_flutter/features/ota/presentation/bloc/ota_event.dart';
import 'package:dslideshow_flutter/features/ota/presentation/bloc/ota_terminal_session.dart';
import 'package:dslideshow_flutter/features/ota/presentation/widgets/ota_view.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/status/slideshow_status_bloc.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:dslideshow_flutter/src/route_bloc.dart';
import 'package:dslideshow_flutter/src/injector.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'ota_frontend.dart';

class OtaHarness {
  final frontend = OtaTestFrontend();
  final routes = RouteBloc();
  final session = OtaTerminalSession();
  late final status = SlideshowStatusBloc(
    frontendService: frontend,
    config: AppConfig.fromJson({}).slideshow,
  );
  late final bloc = OtaBloc(
    frontendService: frontend,
    backend: session.backend,
    routeBloc: routes,
  );

  Future<void> mount(
    WidgetTester tester, {
    Size size = const Size(2560, 1600),
    Widget? child,
  }) async {
    // The desktop debug overlay uses the same application dependencies as the
    // page. Keep ordinary `flutter test` usable as well as the embedded run.
    injector.pushNewScope(
      init: (scope) {
        scope.registerSingleton<FrontendService>(frontend);
        scope.registerSingleton<AppConfig>(AppConfig.fromJson({}));
      },
    );
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = size;
    addTearDown(() async {
      await tester.pumpWidget(const SizedBox.shrink());
      await bloc.close();
      await status.close();
      await routes.close();
      await frontend.close();
      session.dispose();
      await injector.popScope();
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<OtaBloc>.value(value: bloc),
          BlocProvider<SlideshowStatusBloc>.value(value: status),
          BlocProvider<RouteBloc>.value(value: routes),
        ],
        child: MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(body: child ?? OTAView(session: session)),
        ),
      ),
    );
  }

  Future<void> initialize(WidgetTester tester) async {
    bloc.add(const OtaEvent.initialization());
    await tester.pump();
    expect(frontend.infoRequested.isCompleted, isTrue);
    expect(frontend.systemRequested.isCompleted, isTrue);
  }

  Future<void> completeInfo(WidgetTester tester, OTAInfo info) async {
    frontend.infoResult.complete(info);
    await tester.pump();
  }

  Future<void> completeNetwork(WidgetTester tester) async {
    frontend.systemResult.complete(otaSystemInfo());
    await tester.pump();
  }

  Future<void> update(WidgetTester tester, OTAInfo info) async {
    frontend.infoEvents.add(info);
    await tester.pump();
  }
}
