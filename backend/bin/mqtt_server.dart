// ignore_for_file: unused_import, unused_element

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
import 'package:dslideshow_backend/src/service/hardware/src/gpio_service_impl.dart';
import 'package:dslideshow_backend/src/service/hardware/src/screen_service.dart';
import 'package:dslideshow_backend/src/service/mqtt/mqtt_service.dart';
import 'package:dslideshow_backend/src/service/storage/disk/disk_storage.dart';
import 'package:dslideshow_backend/src/service/storage/googlephoto/gphoto_storage.dart';
import 'package:dslideshow_backend/src/service/storage/storage.dart';
import 'package:dslideshow_backend/src/service/system_info/system_info_service.dart';
import 'package:dslideshow_common/rpc.dart';
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
    injector.registerLazySingleton<GPIOService>(() {
      final _config = injector.get<AppConfig>();
      return new GPIOServiceImpl(_config.hardware);
    });
    injector.registerLazySingleton<ApplicationStateService>(() {
      return ApplicationStateService(screenService: injector(), gpioService: injector());
    });
    injector.registerLazySingleton<MqttService>(() {
      final _config = injector.get<AppConfig>();
      return MqttService(_config.mqtt, applicationStateService: injector());
    });

    var config = injector.get<AppConfig>();
    config.mqtt.clientId = "CONSOLE_CLIENT_ID";
    config.mqtt.deviceName = "CONSOLE_PHOTOFRAME";
    config.mqtt.discovery_prefix = "homeassistant";
    config.mqtt.enabled = true;
    config.mqtt.keepAlivePeriod = 60;
    Logger.root.level = config.log.levelMain;

    final mqtt = injector.get<MqttService>();
    await mqtt.onMenu.first;
  } catch (e, s) {
    _log.severe('Fatal error: $e, $s', e, s);
    exit(1);
  }
}
