import 'dart:async';
import 'dart:io';

import 'package:dslideshow_backend/serializers.dart';
import 'package:dslideshow_backend/src/service/hardware/hardware.dart';
import 'package:dslideshow_backend/src/service/storage/disk/disk_storage.dart';
import 'package:dslideshow_backend/src/service/storage/storage.dart';
import 'package:dslideshow_common/injector/di.dart';
import 'package:dslideshow_backend/injector_module.dart';
import 'package:dslideshow_common/rpc.dart';
//import 'package:crazy_pigs_backend/rpc/remote_service.dart';
//import 'package:crazy_pigs_backend/web_server/src/web_server.dart';
import 'package:isolate/isolate.dart';
import 'package:logging/logging.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_common/log.dart';
import 'package:dslideshow_common/log.dart';

import 'src/service/googlephoto/googlephoto.dart';
//import 'package:crazy_pigs_backend/rpc/init_rpc.dart';

final Logger _log = new Logger('main');
HardwareService _service;

void main(List<dynamic> args){
  initLog("hw_frame");
  _log.info("Run");
  try {
    IsolateRunner remoteIsolateService = args[0] as IsolateRunner;
    final  RemoteService _remoteFrontendService = new RemoteService(remoteIsolateService, serializers);
    var injector = new ModuleInjector([getInjectorModule(),
     new Module()..bind(GooglePhotoService, toFactory: (AppConfig _config) => new GooglePhotoService(_config), inject: <dynamic>[AppConfig])
       ..bind(Storage, toFactory: (AppConfig _config) => new DiskStorage(_config.storageSection['DiskStorage'] as Map<String, dynamic>), inject: <dynamic>[AppConfig])
      ..bind(HardwareService, toFactory: (AppConfig _config, Storage _storage) => new HardwareService(_config, _remoteFrontendService, _storage), inject: <dynamic>[AppConfig, Storage])
    ]);
    var config = injector.get(AppConfig) as AppConfig;
    Logger.root.level = config.log.levelHwFrame;
    _service = injector.get(HardwareService) as HardwareService;
    initRpc(_service, serializers);
//    final _gphoto = injector.get(GooglePhotoService) as GooglePhotoService;
    // _gphoto.run();
//    _server = injector.get(WebServer) as WebServer;
//    initRpc(_server);

    new Timer(new Duration(seconds: 5),(){
      _service.testEcho('Back -> Front');
    });
  } catch(e, s){
    _log.fine('Fatal error: $e, $s');
    exit(1);
  }
}