import 'dart:async';
import 'dart:io';

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/src/service/fake/fake_remote_service.dart';
import 'package:dslideshow_backend/src/service/ota/ota_service.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';
import 'package:dslideshow_backend/injector_module.dart';
import 'package:dslideshow_common/log.dart';

Logger _log = new Logger('main');
final injector = GetIt.instance;

void main(List<String> args) async {
  initLog("main");
  _log.info("Run");
  try {
    getInjectorModule();
    final injector = GetIt.instance;
    injector.registerLazySingleton<OTAService>(() {
      final _config = injector.get<AppConfig>();
      return new OTAService(_config, new FakeRemoteService());
    });
    //        ..bind(Storage, toFactory: (AppConfig _config) => new DiskStorage(_config.storageSection[DiskStorage.name] as Map<String, dynamic>), inject: <dynamic>[AppConfig])
    //         ..bind(Storage, toFactory: (AppConfig _config, AppStorage appStorage) => new GPhotoStorage(_config.storageSection[GPhotoStorage.name] as Map<String, dynamic>, appStorage), inject: <dynamic>[AppConfig, AppStorage])
    //        ..bind(ScreenService, toFactory: (AppConfig _config) => new ScreenService(_config.hardware), inject: <dynamic>[AppConfig])
    //        ..bind(HardwareService, toFactory: (AppConfig _config, Storage _storage, GPIOService _gPIOService, ScreenService _screenService) => new HardwareService(_config, _remoteFrontendService, _storage, _gPIOService, _screenService), inject: <dynamic>[AppConfig, Storage, GPIOService, ScreenService])
    //         ..bind(SystemInfoService, toFactory: (AppConfig _config)=>new SystemInfoService(_config.hardware), inject: <dynamic>[AppConfig])
    var config = injector.get<AppConfig>();
    Logger.root.level = config.log.levelMain;

    var otaService = injector.get<OTAService>();
    new Timer(const Duration(seconds: 1), () {
      otaService.enabled = true;
    });
  } catch (e, s) {
    _log.severe('Fatal error: $e, $s', e, s);
    exit(1);
  }
}
