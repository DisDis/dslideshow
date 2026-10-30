import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/status/slideshow_status_bloc.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_bloc.dart';
import 'package:dslideshow_flutter/features/menu/presentation/bloc/main_menu_bloc.dart';
import 'package:dslideshow_flutter/features/header/presentation/widgets/buttons_hint/buttons_hint_bloc.dart';
import 'package:dslideshow_flutter/main.dart';
import 'package:dslideshow_flutter/src/injector.dart';
import 'package:dslideshow_flutter/src/route_bloc.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'ota_frontend.dart';

/// Mounts the actual application and OTA page, retaining Scaffold's ordinary
/// body constraints. An optional boundary captures what reaches the display.
Future<RouteBloc> mountFrameOtaApp(
  WidgetTester tester, {
  AppConfig? config,
  GlobalKey? boundaryKey,
  OtaTestFrontend? otaFrontend,
}) async {
  final appConfig = config ?? AppConfig.fromJson({});
  final frontend =
      otaFrontend ??
      (OtaTestFrontend()
        ..infoResult.complete(
          const OTAInfo(
            status: OTAStatus.ready,
            uploadingPercent: 0,
            code: '83472',
          ),
        )
        ..systemResult.complete(otaSystemInfo()));
  final routes = RouteBloc();
  final status = SlideshowStatusBloc(
    frontendService: frontend,
    config: appConfig.slideshow,
  );
  injector.pushNewScope(
    init: (scope) {
      scope.registerSingleton<AppConfig>(appConfig);
      scope.registerSingleton<FrontendService>(frontend);
      scope.registerSingleton<RouteBloc>(routes);
      scope.registerFactory<SlideshowBloc>(
        () => SlideshowBloc(
          frontendService: frontend,
          config: appConfig.slideshow,
          statusBloc: status,
        ),
      );
      scope.registerFactory<MainMenuBloc>(
        () => MainMenuBloc(
          routeBloc: routes,
          frontendService: frontend,
          slideshowStatusBloc: status,
          config: appConfig.slideshow.menu,
        ),
      );
      scope.registerFactory<ButtonsHintBloc>(
        () => ButtonsHintBloc(
          frontendService: frontend,
          statusBloc: status,
          appConfig: appConfig,
        ),
      );
    },
  );
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = const Size(2560, 1600);
  tester.platformDispatcher.localesTestValue = const [Locale('en')];
  addTearDown(() async {
    await tester.pumpWidget(const SizedBox.shrink());
    await status.close();
    await routes.close();
    await frontend.close();
    await injector.popScope();
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
    tester.platformDispatcher.clearLocalesTestValue();
  });
  routes.add(ChangePageEvent(RoutePage.ota));
  await routes.stream.firstWhere((state) => state.current == RoutePage.ota);
  const app = MainApp();
  await tester.pumpWidget(
    MultiBlocProvider(
      providers: [
        BlocProvider<RouteBloc>.value(value: routes),
        BlocProvider<SlideshowStatusBloc>.value(value: status),
      ],
      child: boundaryKey == null
          ? app
          : RepaintBoundary(key: boundaryKey, child: app),
    ),
  );
  await tester.pump();
  return routes;
}
