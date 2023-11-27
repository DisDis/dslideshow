import 'dart:io';
import 'dart:isolate';

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/injector_module.dart';
import 'package:dslideshow_backend/serializers.dart';
import 'package:dslideshow_backend/src/web_server/web_server.dart';
import 'package:dslideshow_backend/src/web_server/web_service.dart';
import 'package:dslideshow_common/log.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:logging/logging.dart';
import 'package:get_it/get_it.dart';

final Logger _log = new Logger('main');
late WebServer _webServer;
void serviceMain(SendPort remoteIsolateSendPort) async {
  initLog("web");
  _log.info("Run. Spawned isolate started.");
  try {
    final _serviceIso = Service(sendPort: remoteIsolateSendPort);
    final RemoteService _remoteBackendService = new RemoteService(_serviceIso, serializers);

    // Use this static instance
    final injector = GetIt.instance;
    getInjectorModule();
    injector.registerLazySingleton<WebService>(() {
      final _config = injector.get<AppConfig>();
      return new WebService(_config, _config.webServer, _remoteBackendService);
    });
    injector.registerLazySingleton<WebServer>(() {
      final _config = injector.get<AppConfig>();
      return new WebServer(_config.webServer, _remoteBackendService, injector.get<WebService>());
    });
    final config = injector.get<AppConfig>();
    Logger.root.level = config.log.levelWeb;
    _webServer = injector.get<WebServer>();
    initRpc(_webServer, serializers, _serviceIso);
  } catch (e, s) {
    _log.fine('Fatal error: $e, $s');
    _log.info("Spawned isolate finished with error.");
    // exit(1);
    Isolate.exit();
  }
  _log.info("Spawned isolate finished.");
  Isolate.exit();
}
//  _log.info("Run");
//  try {
//    var injector = new ModuleInjector([getInjectorModule()]);
//    var config = injector.get(AppConfig) as AppConfig;
//    Logger.root.level = config.log.levelServer;
//    _server = injector.get(WebServer) as WebServer;
//    initRpc(_server);
//  } catch(e, s){
//    _log.fine('Fatal error: $e, $s');
//    exit(1);
//  }
//}
//
//
//void setServicesIsolate(List<IsolateRunner> isolates){
//  IsolateRunner simulatorIsolate = isolates[0];
////  IsolateRunner resultIsolate = isolates[1];
//  _server.setService(new RemoteService(simulatorIsolate));
////  _server.setService(new RemoteService(isolate));
