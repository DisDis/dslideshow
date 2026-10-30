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
  initLog("web-local");
  _log.info("Run");
  try {
    getInjectorModule();
    final injector = GetIt.instance;
    injector.registerLazySingleton<WebService>(() {
      final _config = injector.get<AppConfig>();
      return new WebService(
        _config,
        _config.webServer,
        new FakeRemoteService(name: 'backend'),
      );
    });

    var config = injector.get<AppConfig>();
    Logger.root.level = config.log.levelWeb;
    _log.info('Web logging configured level=${Logger.root.level.name}');

    var service = injector.get<WebService>();
    new Timer(const Duration(seconds: 1), () {
      unawaited(
        service.setEnabled(true).catchError((Object error) {
          _log.warning('Web control failed type=${error.runtimeType}');
        }),
      );
    });
  } catch (error) {
    _log.severe('Web startup failed type=${error.runtimeType}');
    exit(1);
  }
  ProcessSignal.sigint.watch().listen((ProcessSignal signal) {
    print("exiting");
    exit(0);
  });
}
