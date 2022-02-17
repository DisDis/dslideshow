import 'dart:io';

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/injector_module.dart';
import 'package:dslideshow_backend/serializers.dart';
import 'package:dslideshow_backend/src/service/ota/ota_service.dart';
import 'package:dslideshow_common/log.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:get_it/get_it.dart';
import 'package:isolate/isolate_runner.dart';
import 'package:logging/logging.dart';

final Logger _log = new Logger('main');
late OTAService _service;

void main(List<dynamic> args) async {
  initLog("ota");
  _log.info("Run");
  try {
    IsolateRunner remoteIsolateService = args[0] as IsolateRunner;
    final RemoteService _remoteFrontendService = new RemoteService(remoteIsolateService, serializers);

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
    initRpc(_service, serializers);
  } catch (e, s) {
    _log.fine('Fatal error: $e, $s');
    exit(1);
  }
}

// Future<IsolateRunner> _createCurrentIsolateRunner() async {
//   var remote = IsolateRunnerRemote();
//   return IsolateRunner(Isolate.current, remote.commandPort);
// }
