import 'dart:io';

import 'package:dslideshow_backend/app_storage.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/hw_frame.dart' as hw_frame;
import 'package:dslideshow_backend/ota.dart' as ota;
import 'package:dslideshow_backend/serializers.dart';
import 'package:dslideshow_common/version.dart';
import 'package:dslideshow_flutter/features/header/presentation/widgets/buttons_hint/buttons_hint_bloc.dart';
import 'package:dslideshow_flutter/features/menu/presentation/bloc/main_menu_bloc.dart';
import 'package:dslideshow_flutter/features/ota/presentation/pages/ota_page.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_bloc.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/status/slideshow_status_bloc.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/pages/slideshow_page.dart';
import 'package:dslideshow_flutter/features/welcome/presrntation/pages/welcome_page.dart';
import 'package:dslideshow_flutter/src/route_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterpi_gstreamer_video_player/flutterpi_gstreamer_video_player.dart';
import 'src/injector.dart';
import 'package:dslideshow_common/log.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:dslideshow_flutter/environment.dart' as environment;
import 'package:dslideshow_flutter/features/config/presentation/pages/config_page.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';

void main() async {
  if (kDebugMode) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
  initLog('flutter');
  _log.info(
      "Run f:${ApplicationInfo.frontendVersion}, b:${ApplicationInfo.backendVersion}, isLinuxEmbedded: ${Platform.environment['DSLIDESHOW_EMBEDDED']}->${environment.isLinuxEmbedded}");

  WidgetsFlutterBinding.ensureInitialized();
  if (!environment.isLinuxEmbedded) {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
  }
  try {
    late RemoteServiceImpl backendService;
    late RemoteServiceImpl otaService;

    await environment.checkPermissionReadExternalStorage();
    var localPath = await environment.getApplicationDocumentsDirectory();

    _log.info("Config path: '$localPath'");

    injector.registerSingleton<RouteBloc>(RouteBloc());
    injector.registerSingleton<AppConfig>(AppConfig.fromFile(localPath.path));
    injector.registerSingleton<AppStorage>(AppStorage(localPath.path));
    injector.registerLazySingleton<FrontendService>(() {
      return FrontendService(injector(), backendService, otaService);
    });

    _log.info("externalStorage: '${environment.externalStorage.path}'");

    final AppConfig config = injector();
    Logger.root.level = config.log.levelMain;

    otaService = RemoteServiceImpl(serializers: serializers);
    await otaService.spawn(ota.serviceMain, debugName: "ota");

    backendService = RemoteServiceImpl(serializers: serializers);
    await backendService.spawn(hw_frame.serviceMain, debugName: "backend");

    final FrontendService frontendService = injector();
    backendService.service.processing(frontendService, serializers);
    otaService.service.processing(frontendService, serializers);

    injector.registerLazySingleton<SlideshowStatusBloc>(() {
      return SlideshowStatusBloc(frontendService: frontendService, config: config.slideshow);
    });

    injector.registerFactory<SlideshowBloc>(() {
      return SlideshowBloc(frontendService: frontendService, config: config.slideshow, statusBloc: injector());
    });

    injector.registerFactory<ButtonsHintBloc>(() {
      return ButtonsHintBloc(frontendService: frontendService)..add(ButtonsHintEvent.show(isShow: true));
    });
    injector.registerFactory<MainMenuBloc>(() {
      return MainMenuBloc(frontendService: frontendService, routeBloc: injector(), slideshowStatusBloc: injector());
    });

    frontendService.onOTAReady.listen((isReady) {
      final RouteBloc bloc = injector();
      if (isReady) {
        bloc.add(ChangePageEvent(RoutePage.ota));
      } else {
        bloc.add(ChangePageEvent(RoutePage.welcome));
      }
    });

    if (environment.isLinuxEmbedded) {
      try {
        _log.info("FlutterpiVideoPlayer initing");
        FlutterpiVideoPlayer.registerWith();
      } catch (e, s) {
        _log.severe('FlutterpiVideoPlayer: $e, $s', e, s);
      }
    }

    _runFlutter(frontendService);
  } catch (e, s) {
    _log.severe('Fatal error: $e, $s', e, s);
    exit(1);
  }
}

final Logger _log = Logger('main');

void _runFlutter(FrontendService frontendService) {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<RouteBloc>.value(value: injector()),
      BlocProvider<SlideshowStatusBloc>.value(value: injector()),
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: const ColorScheme.dark(surface: Colors.black)),
      localizationsDelegates: const [],
      supportedLocales: const [
        Locale('en'), // English
        // ... other locales the app supports
      ],
      home: BlocBuilder<RouteBloc, RouteState>(
        builder: (_, state) {
          switch (state.current) {
            case RoutePage.slideshow:
              return MultiBlocProvider(
                providers: [
                  BlocProvider<SlideshowBloc>(
                    lazy: false,
                    create: (context) => injector<SlideshowBloc>(),
                  ),
                  BlocProvider<MainMenuBloc>(
                    lazy: false,
                    create: (context) => injector<MainMenuBloc>(),
                  )
                ],
                child: const SlideShowPage(),
              );
            case RoutePage.config:
              return BlocProvider<ButtonsHintBloc>(
                create: (context) => injector<ButtonsHintBloc>(),
                child: const ConfigPage(),
              );
            case RoutePage.ota:
              return OTAPage();
            case RoutePage.welcome:
              return const WelcomePage();
          }
        },
      ),
    );
  }
}
