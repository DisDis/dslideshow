import 'dart:async';
import 'dart:io' as io;
import 'package:dslideshow_backend/src/service/hardware/src/hardware_service_config.dart';
import 'package:logging/logging.dart';
import 'package:linux_dpms/linux_dpms.dart';

class ScreenService {
  static final Logger _log = new Logger('ScreenService');
  static final DpmsLinux dpmsLinux = DpmsLinux();
  final HardwareConfig _config;

  // Property?
  bool isScreenOffLock = false;

  final _stateChangePreparation = new StreamController<bool>.broadcast();

  final Duration _preparationOffTime = const Duration(milliseconds: 2000);
  Stream<bool> get onStateChangePreparation => _stateChangePreparation.stream;

  ScreenService(this._config);
  Timer? _timerScreenOff;
  bool get isScreenOn => _screenOn;
  bool _screenOn = true;

  void screenOn() async {
    _log.info('screenOn');
    if (isScreenOffLock) {
      _log.info('"screenOn" is canceled because the screen is lock');
      return;
    }
    if (_timerScreenOff != null) {
      _timerScreenOff!.cancel();
      _timerScreenOff = null;
    }
    try {
      if (!_screenOn) {
        io.Process.run(_config.screenPowerOnScript, [], runInShell: true);
        if (dpmsLinux.isAvailable()) {
          dpmsLinux.setPowerState(DpmsPowerState.on);
        }
        _screenOn = true;
        _stateChangePreparation.add(true);
      } else {
        _log.info('"screenOn" is skipped because the screen was turned on');
      }
    } catch (e, s) {
      _log.severe('screenOn', e, s);
    }
  }

  void scheduleScreenOff() {
    _log.info('scheduleScreenOff');
    if (_timerScreenOff != null) {
      _timerScreenOff!.cancel();
      _timerScreenOff = null;
    }
    _timerScreenOff = new Timer(new Duration(seconds: _config.screenPowerOnTimerSec), () {
      _timerScreenOff = null;
      screenOff();
    });
  }

  void screenOff() async {
    _log.info('screenOff');
    if (_timerScreenOff != null) {
      _timerScreenOff!.cancel();
      _timerScreenOff = null;
    }
    try {
      _stateChangePreparation.add(false);
      await Future<void>.delayed(_preparationOffTime);
      io.Process.run(_config.screenPowerOffScript, [], runInShell: true);
      if (dpmsLinux.isAvailable()) {
        dpmsLinux.setPowerState(DpmsPowerState.off);
      }
      _screenOn = false;
    } catch (e, s) {
      _log.severe('screenOff', e, s);
    }
  }
}
