import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:dslideshow_backend/serializers.dart';
import 'package:dslideshow_backend/src/service/hardware/hardware.dart';
import 'package:dslideshow_backend/src/service/hardware/src/screen_service.dart';
import 'package:dslideshow_backend/src/service/storage/disk/disk_storage.dart';
import 'package:dslideshow_backend/src/service/storage/googlephoto/gphoto_storage.dart';
import 'package:dslideshow_backend/src/service/storage/storage.dart';
import 'package:dslideshow_backend/src/service/system_info/system_info_service.dart';
import 'package:dslideshow_common/injector/di.dart';
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

    var injector = new ModuleInjector([getInjectorModule(),
     new Module()
       ..bind(Storage, toFactory: (AppConfig _config) => new DiskStorage(_config.storageSection[DiskStorage.name] as Map<String, dynamic>), inject: <dynamic>[AppConfig])
//         ..bind(Storage, toFactory: (AppConfig _config, AppStorage appStorage) => new GPhotoStorage(_config.storageSection[GPhotoStorage.name] as Map<String, dynamic>, appStorage), inject: <dynamic>[AppConfig, AppStorage])
        ..bind(GPIOService, toFactory: (AppConfig _config) => new GPIOServiceImpl(_config.hardware), inject: <dynamic>[AppConfig])
       ..bind(ScreenService, toFactory: (AppConfig _config) => new ScreenService(_config.hardware), inject: <dynamic>[AppConfig])
        ..bind(SystemInfoService, toFactory: (AppConfig _config)=>new SystemInfoService(_config.hardware), inject: <dynamic>[AppConfig])
      ..bind(HardwareService, toFactory: (AppConfig _config, Storage _storage, GPIOService _gPIOService, ScreenService _screenService, SystemInfoService _systemInfoService) => new HardwareService(_config, _remoteFrontendService, _storage, _gPIOService, _screenService, _systemInfoService, _remoteWebServer),
          inject: <dynamic>[AppConfig, Storage, GPIOService, ScreenService, SystemInfoService])
    ]);
    var config = injector.get(AppConfig) as AppConfig;
    Logger.root.level = config.log.levelHwFrame;

    _service = injector.get(HardwareService) as HardwareService;
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