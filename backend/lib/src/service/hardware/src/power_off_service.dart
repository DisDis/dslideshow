import 'dart:io' as io;

import 'package:logging/logging.dart';

import 'package:dslideshow_backend/src/service/hardware/hardware.dart';
import 'package:dslideshow_backend/src/service/hardware/src/hardware_service_config.dart';

class PowerOffService {
  static final Logger _log = new Logger('PoweOffService');
  final HardwareConfig _config;

  PowerOffService(this._config);

  void execute() async {
    _log.info('execute');
    try {
      io.Process.run(_config.powerOffScript, [], runInShell: true);
    } catch (e, s) {
      _log.severe('execute', e, s);
    }
  }

  void restartApp() async {
    _log.info('restartApp');
    try {
      io.Process.run(_config.restartAppScript, [], runInShell: true);
    } catch (e, s) {
      _log.severe('restartApp', e, s);
    }
  }
}
