import 'dart:isolate';

import 'package:dslideshow_backend/app_storage.dart';
import 'package:dslideshow_backend/serializers.dart';
import 'package:dslideshow_backend/src/service/hardware/hardware.dart';

import 'package:dslideshow_backend/src/service/mqtt/mqtt_service.dart';
import 'package:dslideshow_backend/src/service/storage/disk/disk_storage.dart';
import 'package:dslideshow_backend/src/service/storage/googlephoto/gphoto_storage.dart';
import 'package:dslideshow_backend/src/service/storage/storage.dart';
import 'package:dslideshow_backend/src/service/storage/storage_provider_registry.dart';
import 'package:dslideshow_backend/src/service/storage/yandex_drive/yandex_drive_storage.dart';
import 'package:dslideshow_backend/src/service/yandex_drive/yandex_drive_service.dart';
import 'package:dslideshow_backend/src/service/system_info/system_info_service.dart';
import 'package:dslideshow_backend/src/service/wifi/wifi_service.dart';
import 'package:get_it/get_it.dart';
import 'package:dslideshow_backend/injector_module.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:logging/logging.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_common/log.dart';

import 'src/service/hardware/src/gpio_service.dart';
import 'src/service/hardware/src/frame_state_reader.dart';
import 'src/service/hardware/src/gpio_service_instance_stub.dart'
    if (dart.library.io) 'package:dslideshow_backend/src/service/hardware/src/gpio_service_instance_hw.dart'
    if (dart.library.js) 'package:dslideshow_backend/src/service/hardware/src/gpio_service_instance_web.dart';
import 'web_server.dart' as web_server;

final Logger _log = new Logger('main');

void serviceMain(Map<String, dynamic> handshakeMessage) async {
  initLog("hw_frame");
  _log.info("Run. Spawned isolate started.");
  HardwareService? service;
  try {
    final rpcTelemetry = RpcTelemetry(RpcNode.backend, collectionTimeout: const Duration(seconds: 3));
    final _remoteFrontendService = RemoteServiceImpl(
      serializers: serializers,
      telemetry: rpcTelemetry,
      peer: RpcNode.frontend,
      collectPeerTelemetry: true,
    );
    _remoteFrontendService.connect(HandshakeMessage.fromMap(handshakeMessage));

    final _remoteWebServer = RemoteServiceImpl(
      serializers: serializers,
      telemetry: rpcTelemetry,
      peer: RpcNode.web,
      collectPeerTelemetry: true,
    );
    await _remoteWebServer.spawn(web_server.serviceMain, debugName: "webServer");

    // Use this static instance
    final injector = GetIt.instance;
    getInjectorModule();
    final appStorage = injector.get<AppStorage>();
    final config = injector.get<AppConfig>();
    injector.registerFactoryParam<Storage, StorageType, void>((type, _) {
      return switch (type) {
        StorageType.DiskStorage => DiskStorage(config.storages.getOrCreateEmpty(StorageType.DiskStorage)),
        StorageType.GPhotoStorage => GPhotoStorage(
          config.storages.getOrCreateEmpty(StorageType.GPhotoStorage),
          appStorage,
        ),
        StorageType.YandexDriveStorage => YandexDriveStorage(
          config.storages.getOrCreateEmpty(StorageType.YandexDriveStorage),
          YandexDriveService(appStorage),
          appStorage,
        ),
      };
    });
    final storageProviders = StorageProviderRegistry();
    injector.registerSingleton<StorageProviderRegistry>(storageProviders);

    injector.registerLazySingleton<PowerOffService>(() {
      final _config = injector.get<AppConfig>();
      return PowerOffService(_config.hardware);
    });
    injector.registerLazySingleton<GPIOService>(() {
      final _config = injector.get<AppConfig>();
      return getGPIOService(_config.hardware);
    });
    injector.registerLazySingleton<ScreenService>(() {
      final _config = injector.get<AppConfig>();
      return ScreenService(_config.hardware, preparationOffTime: Duration(milliseconds: _config.slideshow.fadeTimeMs));
    });
    injector.registerLazySingleton<WiFiService>(() {
      final _config = injector.get<AppConfig>();
      return WiFiService(_config.wifi);
    });
    injector.registerLazySingleton<MqttService>(() {
      final _config = injector.get<AppConfig>();
      return MqttService(_config.mqtt, applicationStateService: injector());
    });
    injector.registerLazySingleton<SystemInfoService>(() {
      final _config = injector.get<AppConfig>();
      return SystemInfoService(_config.hardware);
    });
    injector.registerLazySingleton<ApplicationStateService>(() {
      return ApplicationStateService(
        screenService: injector(),
        gpioService: injector(),
        storage: storageProviders.selected,
      );
    });

    injector.registerSingleton<FrameStateReader>(
      FrameStateReader(
        frontendService: _remoteFrontendService,
        screenService: injector(),
        applicationStateService: injector(),
      ),
    );

    injector.registerLazySingleton<HardwareService>(() {
      return HardwareService(
        frontendService: _remoteFrontendService,
        storageProviders: storageProviders,
        gpioService: injector(),
        screenService: injector(),
        systemInfoService: injector(),
        webServer: _remoteWebServer,
        mqttService: injector(),
        wifiService: injector(),
        powerOffService: injector(),
        applicationStateService: injector(),
        frameStateReader: injector(),
      );
    });
    Logger.root.level = config.log.levelHwFrame;

    service = injector.get<HardwareService>();

    await Future.wait([
      _remoteWebServer.service.processing(service, serializers),
      _remoteFrontendService.service.processing(service, serializers),
    ]);
  } catch (e, s) {
    _log.severe('Fatal error: $e, $s', e, s);
    _log.info("Spawned isolate finished with error.");
  } finally {
    await service?.dispose();
  }
  _log.info("Spawned isolate finished.");
  Isolate.exit();
}
