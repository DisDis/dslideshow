export 'src/server.dart';

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
//final Logger _log = new Logger('main');
//WebServer _server;
//void main(void _){
//  initLog("web");
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
//}