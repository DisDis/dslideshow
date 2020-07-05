import 'dart:async';
import 'dart:io';
import 'dart:isolate' as isol;

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/hw_frame.dart' as hw_frame;
import 'package:dslideshow_backend/injector_module.dart';
import 'package:dslideshow_backend/serializers.dart' as backend;
import 'package:dslideshow_common/injector/di.dart' as di;
import 'package:dslideshow_common/log.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isolate/isolate.dart';
import 'package:logging/logging.dart';
import 'package:system_metrics_widget/environment.dart' as environment;
import 'package:system_metrics_widget/src/service/frontend.dart';
import 'package:system_metrics_widget/src/widgets/system_metrics.dart';

import 'src/injector.dart';

void main() async {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  initLog('flutter');
  _log.info("Run, isLinuxEmbedded: ${environment.isLinuxEmbedded}");

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIOverlays([]);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
  ]);

  try {
    RemoteService _backendService;
    await environment.checkPermissionReadExternalStorage();
    var localPath = await environment.getApplicationDocumentsDirectory();

    _log.info("Config path: '$localPath'");

    injector = di.ModuleInjector([
      getInjectorModule(),
      di.Module()
        ..bind(AppConfig, toFactory: () => AppConfig(localPath.path))
        ..bind(AppStorage, toFactory: () => AppStorage(localPath.path))
        ..bind(FrontendService,
            toFactory: (AppConfig _config) => FrontendService(
                  _config,
                  _backendService,
                ),
            inject: <dynamic>[AppConfig])
    ]);

    _log.info("externalStorage: '${environment.externalStorage.path}'");

    var config = injector.get(AppConfig) as AppConfig;
    Logger.root.level = config.log.levelMain;

    IsolateRunner _backendServiceIsolate = await IsolateRunner.spawn();
    final currentIsoRunner = await _createCurrentIsolateRunner();
    await _backendServiceIsolate.run(hw_frame.main, <IsolateRunner>[currentIsoRunner]);
    _backendService = RemoteService(_backendServiceIsolate, backend.serializers);

    final _frontendService = injector.get(FrontendService) as FrontendService;
    initRpc(_frontendService, backend.serializers);

    _runFlutter(_frontendService);
  } catch (e, s) {
    _log.fine('Fatal error: $e, $s');
    exit(1);
  }
}

final Logger _log = Logger('main');

Future<IsolateRunner> _createCurrentIsolateRunner() async {
  var remote = IsolateRunnerRemote();
  return IsolateRunner(isol.Isolate.current, remote.commandPort);
}

Future<void> _runFlutter(FrontendService frontendService) async {
  final SystemInfo systemInfo = await frontendService.getSystemInfo();

  runApp(DemoApp(systemInfo));
}

class DemoApp extends StatelessWidget {
  final SystemInfo systemInfo;

  DemoApp(this.systemInfo);

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.white,
          textTheme: GoogleFonts.robotoTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: SystemInfoMetrics(
          model: systemInfo,
        ),
      );
}
