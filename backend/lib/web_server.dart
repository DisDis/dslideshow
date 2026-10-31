import 'dart:isolate';

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/injector_module.dart';
import 'package:dslideshow_backend/discovery.dart';
import 'package:dslideshow_backend/serializers.dart';
import 'package:dslideshow_backend/src/web_server/web_server.dart';
import 'package:dslideshow_backend/src/web_server/web_service.dart';
import 'package:dslideshow_common/log.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:logging/logging.dart';
import 'package:get_it/get_it.dart';

final Logger _log = new Logger('main');
late WebServer _webServer;
void serviceMain(Map<String, dynamic> handshakeMessage) async {
  initLog("web");
  _log.info("Run. Spawned isolate started.");
  WebService? webService;
  try {
    final _remoteBackendService = new RemoteServiceImpl(
      serializers: serializers,
      telemetry: RpcTelemetry(RpcNode.web),
      peer: RpcNode.backend,
    );
    // Use this static instance
    final injector = GetIt.instance;
    getInjectorModule();
    final config = injector.get<AppConfig>();
    Logger.root.level = config.log.levelWeb;
    _log.info('Web logging configured level=${Logger.root.level.name}');
    final framePublisher = AvahiFramePublisher();
    injector.registerSingleton<FramePublisher>(framePublisher);
    webService = WebService(config, config.webServer, _remoteBackendService, framePublisher: framePublisher);
    injector.registerSingleton<WebService>(webService);
    _webServer = WebServer(config.webServer, _remoteBackendService, webService);
    injector.registerSingleton<WebServer>(_webServer);
    _remoteBackendService.connect(HandshakeMessage.fromMap(handshakeMessage));
    await _remoteBackendService.service.processing(_webServer, serializers);
  } catch (error, stack) {
    _log.severe('Web startup failed type=${error.runtimeType}', error, stack);
    _log.info("Spawned isolate finished with error.", error, stack);
  } finally {
    await webService?.close();
  }
  _log.info("Spawned isolate finished.");
  Isolate.exit();
}
