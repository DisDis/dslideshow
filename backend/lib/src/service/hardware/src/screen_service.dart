import 'dart:async';
import 'dart:io' as io;
import 'package:dslideshow_backend/src/service/hardware/src/hardware_service_config.dart';
import 'package:logging/logging.dart';

class ScreenService{
  static final Logger _log = new Logger('ScreenService');
  final HardwareConfig _config;

  ScreenService(this._config);
  Timer _timerScreenOff;

  void screenOn() async{
    _log.info('screenOn');
    if (_timerScreenOff != null){
      _timerScreenOff.cancel();
      _timerScreenOff = null;
    }
    try {
      io.Process.run(_config.screenPowerOnScript, [], runInShell: true);
    } catch(e, s){
      _log.severe('screenOn', e, s);
    }
  }

  void scheduleScreenOff(){
    _log.info('scheduleScreenOff');
    if (_timerScreenOff != null){
      _timerScreenOff.cancel();
      _timerScreenOff = null;
    }
    _timerScreenOff = new Timer(new Duration(seconds: _config.screenPowerOnTimerSec),(){
      _timerScreenOff = null;
      screenOff();
    });
  }
  void screenOff() async {
    _log.info('screenOff');
    if (_timerScreenOff != null){
      _timerScreenOff.cancel();
      _timerScreenOff = null;
    }
    try {
      io.Process.run(_config.screenPowerOffScript, [], runInShell: true);
    } catch (e, s) {
      _log.severe('screenOff', e, s);
    }
  }

}