import 'dart:async';
import 'dart:io';
import 'dart:isolate' as isol;

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/hw_frame.dart' as hw_frame;
import 'package:dslideshow_backend/serializers.dart';
import 'src/injector.dart';
import 'package:dslideshow_common/log.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:dslideshow_flutter/environment.dart' as environment;
import 'package:dslideshow_flutter/src/page/config/config_page.dart';
import 'package:dslideshow_flutter/src/page/slideshow/slideshow_page.dart';
import 'package:dslideshow_flutter/src/page/welcome_page.dart';
import 'package:dslideshow_flutter/src/redux/app_reducer.dart';
import 'package:dslideshow_flutter/src/redux/state/global_state.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:isolate/isolate.dart';
import 'package:logging/logging.dart';
import 'package:redux/redux.dart';
import 'package:omxplayer_video_player/omxplayer_video_player.dart';

void main() async {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  initLog('flutter');
  _log.info("Run, isLinuxEmbedded: ${environment.isLinuxEmbedded}");

  WidgetsFlutterBinding.ensureInitialized();
  if (!environment.isLinuxEmbedded) {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
  } else {
    if (OmxplayerVideoPlayer.isPlatformSidePresent()) {
      OmxplayerVideoPlayer.useAsImplementation();
    }
  }

  try {
    RemoteService? _backendService;
    await environment.checkPermissionReadExternalStorage();
    var localPath = await environment.getApplicationDocumentsDirectory();

    _log.info("Config path: '${localPath}'");

    final store = Store<GlobalState>(appReducer,
        initialState: GlobalState.initial(), middleware: []);

    injector.registerSingleton<AppConfig>(AppConfig(localPath.path));
    injector.registerSingleton<AppStorage>(AppStorage(localPath.path));
    injector.registerLazySingleton<FrontendService>(() {
      final _config = injector.get<AppConfig>();
      return FrontendService(_config, _backendService, store);
    });

    _log.info("externalStorage: '${environment.externalStorage.path}'");

    var config = injector.get<AppConfig>();
    Logger.root.level = config.log.levelMain;

    IsolateRunner _backendServiceIsolate = await IsolateRunner.spawn();
    final currentIsoRunner = await _createCurrentIsolateRunner();
    await _backendServiceIsolate
        .run(hw_frame.main, <IsolateRunner>[currentIsoRunner]);
    _backendService = RemoteService(_backendServiceIsolate, serializers);

    final _frontendService = injector.get<FrontendService>();
    initRpc(_frontendService, serializers);

    _runFlutter(_frontendService, store);
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

void _runFlutter(FrontendService frontendService, Store<GlobalState> store) {
  runApp(FlutterReduxApp(store: store));
}

class FlutterReduxApp extends StatelessWidget {
  final Store<GlobalState>? store;

  FlutterReduxApp({Key? key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<GlobalState>(
        store: store!,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(backgroundColor: Colors.black),
          localizationsDelegates: [],
          supportedLocales: [
            const Locale('en'), // English
            // ... other locales the app supports
          ],
          home: //SlideShowPage(),
              WelcomePage(),
          routes: <String, WidgetBuilder>{
            '/welcome': (BuildContext context) => WelcomePage(),
            '/slideshow': (BuildContext context) => SlideShowPage(),
            '/config': (BuildContext context) => ConfigPage(),
          },
        ));
  }
}
