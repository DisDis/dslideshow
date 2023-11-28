import 'dart:io';
import 'dart:isolate';

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/injector_module.dart';
import 'package:dslideshow_backend/serializers.dart';
import 'package:dslideshow_backend/src/service/ota/ota_service.dart';
import 'package:dslideshow_common/log.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';

final Logger _log = new Logger('main');
late OTAService _service;
void serviceMain(SendPort remoteIsolateSendPort) async {
  initLog("ota");
  _log.info("Run. Spawned isolate started.");
  try {
    final _remoteFrontendService = RemoteServiceImpl(serializers: serializers);
    _remoteFrontendService.connect(remoteIsolateSendPort);

    // Use this static instance
    final injector = GetIt.instance;
    getInjectorModule();

    injector.registerLazySingleton<OTAService>(() {
      final _config = injector.get<AppConfig>();
      return new OTAService(_config, _remoteFrontendService);
    });
    var config = injector.get<AppConfig>();
    Logger.root.level = config.log.levelOTA;

    _service = injector.get<OTAService>();
    await initRpc(_service, serializers, _remoteFrontendService.service);
  } catch (e, s) {
    _log.severe('Fatal error: $e, $s', e, s);
    _log.info("Spawned isolate finished with error.");
    // exit(1);
    Isolate.exit();
  }
  _log.info("Spawned isolate finished.");
  Isolate.exit();
}
