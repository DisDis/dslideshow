import 'dart:async';
import 'dart:io';
import 'dart:isolate' as isol;

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/hw_frame.dart' as hw_frame;
import 'package:dslideshow_backend/ota.dart' as ota;
import 'package:dslideshow_backend/serializers.dart';
import 'package:dslideshow_flutter/src/page/ota/ota_page.dart';
import 'package:dslideshow_flutter/src/page/slideshow/slideshow_bloc.dart';
import 'package:dslideshow_flutter/src/route_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  _log.info("Run, isLinuxEmbedded: ${Platform.environment['DSLIDESHOW_EMBEDDED']}->${environment.isLinuxEmbedded}");

  WidgetsFlutterBinding.ensureInitialized();
  if (!environment.isLinuxEmbedded) {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
  }
  try {
    RemoteService? _backendService;
    RemoteService? _oTAService;

    await environment.checkPermissionReadExternalStorage();
    var localPath = await environment.getApplicationDocumentsDirectory();

    _log.info("Config path: '$localPath'");

    injector.registerSingleton<RouteBloc>(RouteBloc());
    injector.registerSingleton<AppConfig>(AppConfig.fromFile(localPath.path));
    injector.registerSingleton<AppStorage>(AppStorage(localPath.path));
    injector.registerLazySingleton<FrontendService>(() {
      final _config = injector.get<AppConfig>();
      return FrontendService(_config, _backendService!, _oTAService!);
    });

    _log.info("externalStorage: '${environment.externalStorage.path}'");

    var config = injector.get<AppConfig>();
    Logger.root.level = config.log.levelMain;

    final currentIsoRunner = await _createCurrentIsolateRunner();

    IsolateRunner _backendServiceIsolate = await IsolateRunner.spawn();
    await _backendServiceIsolate.run(hw_frame.main, <IsolateRunner>[currentIsoRunner]);
    _backendService = RemoteService(_backendServiceIsolate, serializers);

    IsolateRunner _oTAServiceIsolate = await IsolateRunner.spawn();
    await _oTAServiceIsolate.run(ota.main, <IsolateRunner>[currentIsoRunner]);
    _oTAService = RemoteService(_oTAServiceIsolate, serializers);

    final _frontendService = injector.get<FrontendService>();
    initRpc(_frontendService, serializers);

    injector.registerLazySingleton<SlideshowBloc>(() {
      return SlideshowBloc(frontendService: _frontendService);
    });

    _frontendService.onOTAReady.listen((isReady) {
      final bloc = injector.get<RouteBloc>();
      if (isReady) {
        bloc.add(ChangePageEvent(RoutePage.ota));
      } else {
        bloc.add(ChangePageEvent(RoutePage.welcome));
      }
    });

    _runFlutter(_frontendService);
  } catch (e, s) {
    _log.fine('Fatal error: $e, $s');
    exit(1);
  }
}

final Logger _log = Logger('main');

Future<IsolateRunner> _createCurrentIsolateRunner() async {
  var remote = IsolateRunnerRemote();
  return IsolateRunner(isol.Isolate.current, remote.commandPort);
}

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
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(backgroundColor: Colors.black),
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
