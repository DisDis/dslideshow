import 'dart:io';

import 'package:dslideshow_backend/injector_module.dart';
import 'package:dslideshow_common/log.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';
import 'package:dslideshow_backend/serializers.dart';
import 'package:dslideshow_backend/hw_frame.dart' as hw_frame;

Logger _log = new Logger('main');
final injector = GetIt.instance;

void main(List<String> args) async {
  initLog("main");
  _log.info("Run");
  try {
    getInjectorModule();

    final backendService = RemoteServiceImpl(serializers: serializers);
    await backendService.spawn(hw_frame.serviceMain);
  } catch (e, s) {
    _log.severe('Fatal error: $e, $s', e, s);
    exit(1);
  }
  ProcessSignal.sigint.watch().listen((ProcessSignal signal) {
    print("exiting");
    exit(0);
  });
}
