import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/features/config/data/config_access_repository.dart';
import 'package:dslideshow_flutter/features/config/presentation/bloc/config_bloc.dart';
import 'package:dslideshow_flutter/features/config/presentation/pages/config_page.dart';
import 'package:dslideshow_flutter/features/config/presentation/widgets/config_view.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/status/slideshow_status_bloc.dart';
import 'package:dslideshow_flutter/src/injector.dart';
import 'package:dslideshow_flutter/src/route_bloc.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'config_frontend.dart';

class ConfigHarness {
  final frontend = ConfigTestFrontend();
  final routes = RouteBloc();
  final boundaryKey = GlobalKey();
  late ConfigBloc bloc;
  late ConfigAccessRepository repository;
  late SlideshowStatusBloc status;

  Future<void> mount(
    WidgetTester tester, {
    Size size = const Size(2560, 1600),
    double textScale = 1,
    bool alwaysEnabled = false,
    AppConfig? configuration,
  }) async {
    final config = configuration ?? AppConfig.fromJson({});
    status = SlideshowStatusBloc(
      frontendService: frontend,
      config: config.slideshow,
    );
    repository = ConfigAccessRepository(
      frontend: frontend,
      port: 8080,
      alwaysEnabled: alwaysEnabled,
    );
    injector.pushNewScope(
      init: (scope) {
        scope.registerSingleton<FrontendService>(frontend);
        scope.registerSingleton<AppConfig>(config);
      },
    );
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = size;
    addTearDown(() => dispose(tester));
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<RouteBloc>.value(value: routes),
          BlocProvider<SlideshowStatusBloc>.value(value: status),
        ],
        child: MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: ThemeData(
            fontFamily: 'Roboto',
            colorScheme: const ColorScheme.dark(surface: Colors.black),
          ),
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: TextScaler.linear(textScale)),
            child: child!,
          ),
          home: RepaintBoundary(
            key: boundaryKey,
            child: ConfigPage(repository: repository),
          ),
        ),
      ),
    );
    bloc = tester.element(find.byType(ConfigView)).read<ConfigBloc>();
    await tester.pump();
  }

  bool _disposed = false;
  Future<void> dispose(WidgetTester tester) async {
    if (_disposed) return;
    _disposed = true;
    frontend.finishPending();
    frontend.holdStop = false;
    await closeConfigBloc(tester, bloc);
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.runAsync(() async {
      await status.close();
      await routes.close();
      await frontend.close();
      await injector.popScope();
    });
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  }
}

void configWidgetTest(
  String name,
  Future<void> Function(WidgetTester tester, ConfigHarness harness) body,
) {
  testWidgets(name, (tester) async {
    final harness = ConfigHarness();
    try {
      await body(tester, harness);
    } finally {
      await harness.dispose(tester);
    }
  });
}

// Bloc controller completion needs the real event loop. Start close there,
// before provider disposal; business timers remain under WidgetTester control.
Future<void> closeConfigBloc(WidgetTester tester, ConfigBloc bloc) async {
  await tester.runAsync(() => bloc.close().timeout(const Duration(seconds: 2)));
}
