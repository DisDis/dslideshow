import 'dart:io';
import 'dart:isolate';

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/injector_module.dart';
import 'package:dslideshow_backend/serializers.dart';
import 'package:dslideshow_backend/src/web_server/web_server.dart';
import 'package:dslideshow_backend/src/web_server/web_service.dart';
import 'package:dslideshow_common/log.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:logging/logging.dart';
import 'package:get_it/get_it.dart';

final Logger _log = new Logger('main');
late WebServer _webServer;
void serviceMain(SendPort remoteIsolateSendPort) async {
  initLog("web");
  _log.info("Run. Spawned isolate started.");
  try {
    final _remoteBackendService = new RemoteServiceImpl(serializers: serializers);
    _remoteBackendService.connect(remoteIsolateSendPort);

    // Use this static instance
    final injector = GetIt.instance;
    getInjectorModule();
    injector.registerLazySingleton<WebService>(() {
      final _config = injector.get<AppConfig>();
      return new WebService(_config, _config.webServer, _remoteBackendService);
    });
    injector.registerLazySingleton<WebServer>(() {
      final _config = injector.get<AppConfig>();
      return new WebServer(_config.webServer, _remoteBackendService, injector.get<WebService>());
    });
    final config = injector.get<AppConfig>();
    Logger.root.level = config.log.levelWeb;
    _webServer = injector.get<WebServer>();
    await initRpc(_webServer, serializers, _remoteBackendService.service);
  } catch (e, s) {
    _log.severe('Fatal error: $e, $s', e, s);
    _log.info("Spawned isolate finished with error.");
    // exit(1);
    Isolate.exit();
  }
  _log.info("Spawned isolate finished.");
  Isolate.exit();
}
