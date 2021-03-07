//export 'src/server.dart';

//export 'src/web_server.dart';
//export 'src/web_config.dart';
//
//import 'dart:io';
//
//import 'package:crazy_pigs_common/injector/di.dart';
//import 'package:crazy_pigs_backend/injector_module.dart';
//import 'package:crazy_pigs_backend/rpc/remote_service.dart';
//import 'package:crazy_pigs_backend/web_server/src/web_server.dart';
//import 'package:isolate/isolate.dart';
//import 'package:logging/logging.dart';
//import 'package:crazy_pigs_backend/config.dart';
//import 'package:crazy_pigs_common/log.dart';
//import 'package:crazy_pigs_backend/rpc/init_rpc.dart';
//
import 'dart:io';

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/injector_module.dart';
import 'package:dslideshow_backend/serializers.dart';
import 'package:dslideshow_backend/src/web_server/web_server.dart';
import 'package:dslideshow_backend/src/web_server/web_service.dart';
import 'package:dslideshow_common/log.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:isolate/isolate.dart';
import 'package:logging/logging.dart';
import 'package:get_it/get_it.dart';

final Logger _log = new Logger('main');
late WebServer _webServer;
void main(List<dynamic> args) async{
  initLog("web");
  _log.info("Run");
  try {
    IsolateRunner remoteBackEndService = args[0] as IsolateRunner;
    final RemoteService _remoteBackendService = new RemoteService(remoteBackEndService, serializers);

    // Use this static instance
    final injector = GetIt.instance;
    getInjectorModule();
    injector.registerLazySingleton<WebService>((){
      final _config = injector.get<AppConfig>();
      return new WebService(_config.webServer);
    });
    injector.registerLazySingleton<WebServer>((){
      final _config = injector.get<AppConfig>();
      return new WebServer(_config.webServer, _remoteBackendService, injector.get<WebService>());
    });
    final config = injector.get<AppConfig>();
    Logger.root.level = config.log.levelWeb;
    _webServer = injector.get<WebServer>();
    initRpc(_webServer, serializers);

  } catch(e, s){
    _log.fine('Fatal error: $e, $s');
    exit(1);
  }
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
