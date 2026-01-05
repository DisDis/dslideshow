import 'dart:isolate';

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/injector_module.dart';
import 'package:dslideshow_backend/serializers.dart';
import 'package:dslideshow_backend/src/service/ota/ota_service.dart';
import 'package:dslideshow_common/log.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';

final _log = Logger('main');
late OTAService _service;
void serviceMain(Map<String, dynamic> handshakeMessage) async {
  initLog("ota");
  _log.info("Run. Spawned isolate started.");
  try {
    final _remoteFrontendService = RemoteServiceImpl(serializers: serializers);
    _remoteFrontendService.connect(HandshakeMessage.fromMap(handshakeMessage));

    // Use this static instance
    final injector = GetIt.instance;
    getInjectorModule();
    final AppConfig config = injector();
    Logger.root.level = config.log.levelOTA;

    injector.registerLazySingleton<OTAService>(() {
      return OTAService(config:injector(), frontendService: _remoteFrontendService );
    });

    _service = injector.get<OTAService>();
    await _remoteFrontendService.service.processing(_service, serializers);
  } catch (e, s) {
    _log.severe('Fatal error: $e, $s', e, s);
    _log.info("Spawned isolate finished with error.");
    // exit(1);
    Isolate.exit();
  }
  _log.info("Spawned isolate finished.");
  Isolate.exit();
}
