import 'dart:async';
import 'dart:io';

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/src/service/googlephoto/googlephoto.dart';
import 'package:dslideshow_common/injector/di.dart';
import 'package:logging/logging.dart';
import 'package:dslideshow_backend/injector_module.dart';
import 'package:dslideshow_common/log.dart';
import 'package:dslideshow_backend/hw_frame.dart' as hw_frame;
//import 'package:crazy_pigs_backend/universe_service/universe.dart' as universe;
//import 'package:crazy_pigs_backend/result_service/result_service.dart' as result_service;
import 'package:isolate/isolate.dart';

Logger _log = new Logger('main');

void main(List<String> args) async {
  initLog("main");
  _log.info("Run");
  try {
//    var injector = new ModuleInjector([getInjectorModule()]);
    var injector = new ModuleInjector([getInjectorModule(),
      new Module()..bind(GooglePhotoService, toFactory: (AppConfig _config) => new GooglePhotoService(_config), inject: <dynamic>[AppConfig])
//        ..bind(HardwareService, toFactory: (AppConfig _config) => new HardwareService(_config, _remoteFrontendService), inject: <dynamic>[AppConfig])
    ]);
    var config = injector.get(AppConfig) as AppConfig;
    Logger.root.level = config.log.levelMain;

    final _gphoto = injector.get(GooglePhotoService) as GooglePhotoService;
     _gphoto.run();

//    IsolateRunner _hw_FrameService = await IsolateRunner.spawn();
//    await _hw_FrameService.run(hw_frame.main,<dynamic>[]);


//    IsolateRunner _rService = await IsolateRunner.spawn();
//    await _rService.run(result_service.main,<dynamic>[]);
//    IsolateRunner _server = await IsolateRunner.spawn();
//    await _server.run(server.main,<dynamic>[]);
//    _server.run(server.setServicesIsolate, [_simulatorService, _rService]);
//    _simulatorService.run(universe.setServicesIsolate, [_rService]);
//         _service.run(service.executeCommand,"run proccess");


//    await Future.wait<dynamic>([_hw_FrameService.onExit]);
  } catch(e, s){
    _log.fine('Fatal error: $e, $s');
    exit(1);
  }
}