import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:dslideshow_backend/serializers.dart';
import 'package:dslideshow_backend/src/service/hardware/hardware.dart';
import 'package:dslideshow_backend/src/service/hardware/src/screen_service.dart';
import 'package:dslideshow_backend/src/service/mqtt/mqtt_service.dart';
import 'package:dslideshow_backend/src/service/storage/disk/disk_storage.dart';
import 'package:dslideshow_backend/src/service/storage/googlephoto/gphoto_storage.dart';
import 'package:dslideshow_backend/src/service/storage/storage.dart';
import 'package:dslideshow_backend/src/service/system_info/system_info_service.dart';
import 'package:dslideshow_backend/src/service/wifi/wifi_service.dart';
import 'package:get_it/get_it.dart';
import 'package:dslideshow_backend/injector_module.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:isolate/isolate.dart';
import 'package:logging/logging.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_common/log.dart';

import 'src/service/hardware/src/gpio_service.dart';
import 'src/service/hardware/src/gpio_service_instance_stub.dart'
    if (dart.library.io) 'package:dslideshow_backend/src/service/hardware/src/gpio_service_instance_hw.dart'
    if (dart.library.js) 'package:dslideshow_backend/src/service/hardware/src/gpio_service_instance_web.dart';
import 'web_server.dart' as web_server;

final Logger _log = new Logger('main');
late HardwareService _service;

void main(List<dynamic> args) async {
  initLog("hw_frame");
  _log.info("Run");
  try {
    IsolateRunner remoteIsolateService = args[0] as IsolateRunner;
    final RemoteService _remoteFrontendService = new RemoteService(remoteIsolateService, serializers);

    IsolateRunner _webServer = await IsolateRunner.spawn();
    final currentIsoRunner = await _createCurrentIsolateRunner();
    _webServer.run(web_server.main, <IsolateRunner>[currentIsoRunner]);
    final _remoteWebServer = new RemoteService(_webServer, serializers);

    // Use this static instance
    final injector = GetIt.instance;
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
    injector.registerLazySingleton<GPIOService>(() {
      final _config = injector.get<AppConfig>();
      return getGPIOService(_config.hardware);
    });
    injector.registerLazySingleton<ScreenService>(() {
      final _config = injector.get<AppConfig>();
      return new ScreenService(_config.hardware);
    });
    injector.registerLazySingleton<WiFiService>(() {
      final _config = injector.get<AppConfig>();
      return new WiFiService(_config.wifi);
    });
    injector.registerLazySingleton<MqttService>(() {
      final _config = injector.get<AppConfig>();
      return new MqttService(_config.mqtt);
    });
    injector.registerLazySingleton<SystemInfoService>(() {
      final _config = injector.get<AppConfig>();
      return new SystemInfoService(_config.hardware);
    });
    injector.registerLazySingleton<HardwareService>(() {
      final _config = injector.get<AppConfig>();
      return new HardwareService(
          _config,
          _remoteFrontendService,
          injector.get<Storage>(),
          injector.get<GPIOService>(),
          injector.get<ScreenService>(),
          injector.get<SystemInfoService>(),
          _remoteWebServer,
          injector.get<MqttService>(),
          injector.get<WiFiService>());
    });
    var config = injector.get<AppConfig>();
    Logger.root.level = config.log.levelHwFrame;

    _service = injector.get<HardwareService>();
    initRpc(_service, serializers);
  } catch (e, s) {
    _log.fine('Fatal error: $e, $s');
    exit(1);
  }
}

Future<IsolateRunner> _createCurrentIsolateRunner() async {
  var remote = IsolateRunnerRemote();
  return IsolateRunner(Isolate.current, remote.commandPort);
}
