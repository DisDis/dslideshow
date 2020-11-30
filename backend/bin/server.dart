import 'dart:async';
import 'dart:io';

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/src/service/googlephoto/googlephoto.dart';
import 'package:dslideshow_backend/src/service/hardware/hardware.dart';
import 'package:dslideshow_backend/src/service/hardware/src/gpio_service.dart';
import 'package:dslideshow_backend/src/service/hardware/src/screen_service.dart';
import 'package:dslideshow_backend/src/service/storage/disk/disk_storage.dart';
import 'package:dslideshow_backend/src/service/storage/googlephoto/gphoto_storage.dart';
import 'package:dslideshow_backend/src/service/storage/storage.dart';
import 'package:dslideshow_backend/src/service/system_info/system_info_service.dart';
import 'package:dslideshow_common/injector/di.dart';
import 'package:logging/logging.dart';
import 'package:dslideshow_backend/injector_module.dart';
import 'package:dslideshow_common/log.dart';
import 'package:dslideshow_backend/hw_frame.dart' as hw_frame;
//import 'package:crazy_pigs_backend/universe_service/universe.dart' as universe;
//import 'package:crazy_pigs_backend/result_service/result_service.dart' as result_service;
import 'package:isolate/isolate.dart';

Logger _log = new Logger('main');

ModuleInjector injector;

void main(List<String> args) async {
  initLog("main");
  _log.info("Run");
  try {
    injector = new ModuleInjector([getInjectorModule(),
      new Module()
//        ..bind(Storage, toFactory: (AppConfig _config) => new DiskStorage(_config.storageSection[DiskStorage.name] as Map<String, dynamic>), inject: <dynamic>[AppConfig])
//         ..bind(Storage, toFactory: (AppConfig _config, AppStorage appStorage) => new GPhotoStorage(_config.storageSection[GPhotoStorage.name] as Map<String, dynamic>, appStorage), inject: <dynamic>[AppConfig, AppStorage])
        ..bind(GPIOService, toFactory: (AppConfig _config) => new GPIOServiceImpl(_config.hardware), inject: <dynamic>[AppConfig])
//        ..bind(ScreenService, toFactory: (AppConfig _config) => new ScreenService(_config.hardware), inject: <dynamic>[AppConfig])
//        ..bind(HardwareService, toFactory: (AppConfig _config, Storage _storage, GPIOService _gPIOService, ScreenService _screenService) => new HardwareService(_config, _remoteFrontendService, _storage, _gPIOService, _screenService), inject: <dynamic>[AppConfig, Storage, GPIOService, ScreenService])
//         ..bind(SystemInfoService, toFactory: (AppConfig _config)=>new SystemInfoService(_config.hardware), inject: <dynamic>[AppConfig])
    ]);
    var config = injector.get(AppConfig) as AppConfig;
    Logger.root.level = config.log.levelMain;

    //await _testSystemInfo();
    await _testGPIO();
//    await _gphotoStorage.init();

//    final _gphoto = injector.get(GooglePhotoService) as GooglePhotoService;
//     _gphoto.run();

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

void _testGPIO() async{
  final _service = injector.get(GPIOService) as GPIOService;
  await _service.init();
}

void _testSystemInfo() async{
  final _systemInfoService = injector.get(SystemInfoService) as SystemInfoService;
  _log.info(await _systemInfoService.getNetworkInterfaces());
  _log.info('hasInternet: ${await _systemInfoService.hasInternet()}');
  _log.info(await _systemInfoService.getFullInfo());
}

void testGPhoto() async{
  final _gphotoStorage = injector.get(Storage) as GPhotoStorage;
  var mediaList = await _gphotoStorage.googlePhotoService.getMediaItemInAlbum('TEST_slide', 100, 100);
  mediaList.forEach((googleItem) {
    _log.info('  downloading "${googleItem.id}": type=${googleItem.mimeType} url=${googleItem.url}');
  });
}