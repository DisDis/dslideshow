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
import 'package:injector/injector.dart';
import 'package:dslideshow_backend/injector_module.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:isolate/isolate.dart';
import 'package:logging/logging.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_common/log.dart';
import 'package:dslideshow_backend/environment.dart' as environment;
import 'src/service/hardware/src/gpio_service.dart';
import 'web_server.dart' as web_server;

final Logger _log = new Logger('main');
HardwareService _service;

void main(List<dynamic> args) async{
  initLog("hw_frame");
  _log.info("Run");
  try {
    IsolateRunner remoteIsolateService = args[0] as IsolateRunner;
    final RemoteService _remoteFrontendService = new RemoteService(remoteIsolateService, serializers);

    IsolateRunner _webServer = await IsolateRunner.spawn();
    final currentIsoRunner = await _createCurrentIsolateRunner();
    _webServer.run(web_server.main,<IsolateRunner>[currentIsoRunner]);
    final  _remoteWebServer = new RemoteService(_webServer, serializers);

    // Use this static instance
    final injector = Injector.appInstance;
    getInjectorModule();
    injector.registerSingleton<Storage>((){
      final _config = injector.get<AppConfig>();
      return new DiskStorage(_config.storageSection[DiskStorage.name] as Map<String, dynamic>);
      //return new GPhotoStorage(_config.storageSection[GPhotoStorage.name] as Map<String, dynamic>, appStorage);
    });
    injector.registerSingleton<GPIOService>((){
      final _config = injector.get<AppConfig>();
      return new GPIOServiceImpl(_config.hardware);
    });
    injector.registerSingleton<ScreenService>((){
      final _config = injector.get<AppConfig>();
      return new ScreenService(_config.hardware);
    });
    injector.registerSingleton<MqttService>((){
      final _config = injector.get<AppConfig>();
      return new MqttService(_config.mqtt);
    });
    injector.registerSingleton<SystemInfoService>((){
      final _config = injector.get<AppConfig>();
      return new SystemInfoService(_config.hardware);
    });
    injector.registerSingleton<HardwareService>((){
      final _config = injector.get<AppConfig>();
      return new HardwareService(_config, _remoteFrontendService, injector.get<Storage>(),
          injector.get<GPIOService>(),  injector.get<ScreenService>(), injector.get<SystemInfoService>(), _remoteWebServer, injector.get<MqttService>());
    });
    var config = injector.get<AppConfig>();
    Logger.root.level = config.log.levelHwFrame;

    _service = injector.get<HardwareService>();
    initRpc(_service, serializers);
  } catch(e, s){
    _log.fine('Fatal error: $e, $s');
    exit(1);
  }
}

Future<IsolateRunner> _createCurrentIsolateRunner() async {
  var remote = IsolateRunnerRemote();
  return IsolateRunner(Isolate.current, remote.commandPort);
}