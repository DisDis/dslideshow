import 'dart:async';
import 'dart:io';

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/src/web_server/web_service.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';
import 'package:dslideshow_backend/injector_module.dart';
import 'package:dslideshow_common/log.dart';
import 'package:dslideshow_backend/src/service/fake/fake_remote_service.dart';

Logger _log = new Logger('main');
final injector = GetIt.instance;

void main(List<String> args) async {
  initLog("main");
  _log.info("Run");
  try {
    getInjectorModule();
    final injector = GetIt.instance;
    injector.registerLazySingleton<WebService>(() {
      final _config = injector.get<AppConfig>();
      return new WebService(_config, _config.webServer, new FakeRemoteService(name: 'backend'));
    });

    var config = injector.get<AppConfig>();
    Logger.root.level = config.log.levelMain;

    var service = injector.get<WebService>();
    new Timer(const Duration(seconds: 1), () {
      service.enabled = true;
    });
  } catch (e, s) {
    _log.fine('Fatal error: $e, $s');
    exit(1);
  }
  ProcessSignal.sigint.watch().listen((ProcessSignal signal) {
    print("exiting");
    exit(0);
  });
}
