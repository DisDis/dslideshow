// ignore_for_file: unused_import

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/serializers.dart';
import 'package:dslideshow_backend/src/command/web_server_commands.dart';
import 'package:dslideshow_backend/src/command/wifi_commands.dart';
import 'package:dslideshow_backend/src/service/googlephoto/googlephoto.dart';
import 'package:dslideshow_backend/src/service/hardware/hardware.dart';
import 'package:dslideshow_backend/src/service/hardware/src/gpio_service.dart';
import 'package:dslideshow_backend/src/service/hardware/src/screen_service.dart';
import 'package:dslideshow_backend/src/service/mqtt/mqtt_service.dart';
import 'package:dslideshow_backend/src/service/storage/disk/disk_storage.dart';
import 'package:dslideshow_backend/src/service/storage/googlephoto/gphoto_storage.dart';
import 'package:dslideshow_backend/src/service/storage/storage.dart';
import 'package:dslideshow_backend/src/service/system_info/system_info_service.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';
import 'package:dslideshow_backend/injector_module.dart';
import 'package:dslideshow_common/log.dart';
import 'package:dslideshow_backend/hw_frame.dart' as hw_frame;

Logger _log = new Logger('main');
final injector = GetIt.instance;

void main(List<String> args) async {
  initLog("main");
  _log.info("Run");
  try {
    getInjectorModule();

    injector.registerLazySingleton<Storage>(() {
      final _config = injector.get<AppConfig>();
      switch (_config.storages.selected) {
        case StorageType.GPhotoStorage:
          final appStorage = injector.get<AppStorage>();
          return new GPhotoStorage(_config.storages.getOrCreateEmpty(StorageType.GPhotoStorage), appStorage);

        case StorageType.DiskStorage:
        default:
          return new DiskStorage(_config.storages.getOrCreateEmpty(StorageType.DiskStorage));
      }
    });
//        ..bind(Storage, toFactory: (AppConfig _config) => new DiskStorage(_config.storageSection[DiskStorage.name] as Map<String, dynamic>), inject: <dynamic>[AppConfig])
//         ..bind(Storage, toFactory: (AppConfig _config, AppStorage appStorage) => new GPhotoStorage(_config.storageSection[GPhotoStorage.name] as Map<String, dynamic>, appStorage), inject: <dynamic>[AppConfig, AppStorage])
//        ..bind(ScreenService, toFactory: (AppConfig _config) => new ScreenService(_config.hardware), inject: <dynamic>[AppConfig])
//        ..bind(HardwareService, toFactory: (AppConfig _config, Storage _storage, GPIOService _gPIOService, ScreenService _screenService) => new HardwareService(_config, _remoteFrontendService, _storage, _gPIOService, _screenService), inject: <dynamic>[AppConfig, Storage, GPIOService, ScreenService])
//         ..bind(SystemInfoService, toFactory: (AppConfig _config)=>new SystemInfoService(_config.hardware), inject: <dynamic>[AppConfig])
    var config = injector.get<AppConfig>();
    Logger.root.level = config.log.levelMain;

    // final GPhotoStorage _gphotoStorage = injector.get<Storage>() as GPhotoStorage;
    // await _gphotoStorage.init();

    // final _gphoto = injector.get(GooglePhotoService) as GooglePhotoService;
    // _gphoto.run();

    final _gphotoStorage = injector.get<Storage>() as GPhotoStorage;
    var mediaList = await _gphotoStorage.googlePhotoService!.getMediaItemInAlbum('TEST_slide', 100, 100);
    mediaList.forEach((googleItem) {
      _log.info('  downloading "${googleItem.id}": type=${googleItem.mimeType} url=${googleItem.url}');
    });
  } catch (e, s) {
    _log.severe('Fatal error: $e, $s', e, s);
    exit(1);
  }
}

void testGPhoto() async {}
