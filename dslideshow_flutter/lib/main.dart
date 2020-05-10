import 'dart:async';

import 'package:dslideshow_common/rpc.dart';
import 'package:dslideshow_flutter/src/app_reducer.dart';
import 'package:dslideshow_flutter/src/data_model/global_state.dart';
import 'package:dslideshow_flutter/environment.dart' as environment;
import 'package:dslideshow_flutter/src/page/config/config_page.dart';
import 'package:dslideshow_flutter/src/page/slideshow/slideshow_page.dart';
import 'package:dslideshow_flutter/src/page/welcome_page.dart';
import 'package:dslideshow_common/log.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'dart:io';

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_common/injector/di.dart' as di;
import 'package:dslideshow_backend/injector_module.dart';
import 'package:dslideshow_backend/hw_frame.dart' as hw_frame;
import 'package:isolate/isolate.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:dslideshow_backend/serializers.dart';
import 'dart:isolate' as isol;


final Logger _log = new Logger('main');
//https://pub.dev/packages/flutter_redux
void main() async {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  SystemChrome.setEnabledSystemUIOverlays([]);
  initLog('flutter');
  _log.info("Run");
  try {
    RemoteService _backendService;
    var localPath = await environment.getApplicationDocumentsDirectory();
    _log.info("Config path: '${localPath}'");
    var injector = new di.ModuleInjector([getInjectorModule(),
    new di.Module()
      ..bind(AppConfig, toFactory: () => new AppConfig(localPath.path))
      ..bind(FrontendService, toFactory: (AppConfig _config) => new FrontendService(_config, _backendService), inject: <dynamic>[AppConfig])
    ]);
    _log.info("externalStorage: '${environment.externalStorage.path}'");
    var config = injector.get(AppConfig) as AppConfig;
    Logger.root.level = config.log.levelMain;
    IsolateRunner _backendServiceIsolate = await IsolateRunner.spawn();
    final currentIsoRunner = await _createCurrentIsolateRunner();
    await _backendServiceIsolate.run(hw_frame.main, <IsolateRunner>[currentIsoRunner]);
    _backendService = new RemoteService(_backendServiceIsolate, serializers);
    final _frontendService = injector.get(FrontendService) as FrontendService;
    initRpc(_frontendService, serializers);
    _runFlutter(_frontendService);
    new Timer(new Duration(seconds: 5),(){
      _frontendService.testEcho('Front -> Back');
    });
    // await Future.wait<dynamic>([_hw_FrameService.onExit]);
  } catch (e, s) {
    _log.fine('Fatal error: $e, $s');
    exit(1);
  }
}

Future<IsolateRunner> _createCurrentIsolateRunner() async{
  var remote = new IsolateRunnerRemote();
  return new IsolateRunner(isol.Isolate.current, remote.commandPort);
}

void _runFlutter(FrontendService frontendService) {
  final store = new Store<GlobalState>(appReducer,
      initialState: GlobalState.initial(),
      middleware: [
//        SearchMiddleware(GithubApi()),
        // EpicMiddleware<SearchState>(SearchEpic(GithubApi())),
      ]);

  runApp(FlutterReduxApp(store: store));
}

class FlutterReduxApp extends StatelessWidget {
  final Store<GlobalState> store;

  FlutterReduxApp({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // The StoreProvider should wrap your MaterialApp or WidgetsApp. This will
    // ensure all routes have access to the store.
    return new StoreProvider<GlobalState>(
      // Pass the store to the StoreProvider. Any ancestor `StoreConnector`
      // Widgets will find and use this value as the `Store`.
        store: store,
        child: MaterialApp(
          localizationsDelegates: [
            // ... app-specific localization delegate[s] here
//    GlobalMaterialLocalizations.delegate,
//    GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en'), // English
            // ... other locales the app supports
          ],
          home: WelcomePage(),
          routes: <String, WidgetBuilder>{
            '/welcome': (BuildContext context) => WelcomePage(),
            '/slideshow': (BuildContext context) => SlideShowPage(),
            '/config': (BuildContext context) => ConfigPage(),
          },
        ));
  }
}
