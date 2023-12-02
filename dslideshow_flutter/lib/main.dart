import 'dart:io';

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/hw_frame.dart' as hw_frame;
import 'package:dslideshow_backend/ota.dart' as ota;
import 'package:dslideshow_backend/serializers.dart';
import 'package:dslideshow_common/version.dart';
import 'package:dslideshow_flutter/src/page/ota/ota_page.dart';
import 'package:dslideshow_flutter/src/page/slideshow/slideshow_bloc.dart';
import 'package:dslideshow_flutter/src/route_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterpi_gstreamer_video_player/flutterpi_gstreamer_video_player.dart';
import 'src/injector.dart';
import 'package:dslideshow_common/log.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:dslideshow_flutter/environment.dart' as environment;
import 'package:dslideshow_flutter/src/page/config/config_page.dart';
import 'package:dslideshow_flutter/src/page/slideshow/slideshow_page.dart';
import 'package:dslideshow_flutter/src/page/welcome_page.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';

void main() async {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
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

    var config = injector.get<AppConfig>();
    Logger.root.level = config.log.levelMain;

    backendService = RemoteServiceImpl(serializers: serializers);
    await backendService.spawn(hw_frame.serviceMain, debugName: "backend");
    otaService = RemoteServiceImpl(serializers: serializers);
    await otaService.spawn(ota.serviceMain, debugName: "ota");

    final frontendService = injector.get<FrontendService>();
    backendService.service.processing(frontendService, serializers);
    otaService.service.processing(frontendService, serializers);

    injector.registerLazySingleton<SlideshowBloc>(() {
      return SlideshowBloc(frontendService: frontendService);
    });

    frontendService.onOTAReady.listen((isReady) {
      final bloc = injector.get<RouteBloc>();
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
      BlocProvider<RouteBloc>(
        create: (context) => injector.get<RouteBloc>(),
      ),
      BlocProvider<SlideshowBloc>(
        create: (BuildContext context) => injector.get<SlideshowBloc>(),
      ),
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
      theme: ThemeData(colorScheme: const ColorScheme.dark(background: Colors.black)),
      localizationsDelegates: const [],
      supportedLocales: const [
        Locale('en'), // English
        // ... other locales the app supports
      ],
      home: BlocBuilder<RouteBloc, RouteState>(
        builder: (_, state) {
          switch (state.current) {
            case RoutePage.slideshow:
              return const SlideShowPage();
            case RoutePage.config:
              return const ConfigPage();
            case RoutePage.ota:
              return OTAPage();
            case RoutePage.welcome:
            default:
              return const WelcomePage();
          }
        },
      ),
    );
  }
}
