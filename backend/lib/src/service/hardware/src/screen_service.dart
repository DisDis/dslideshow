import 'dart:io' as io;
import 'package:dslideshow_backend/src/service/hardware/src/hardware_service_config.dart';

class ScreenService{
  final HardwareConfig _config;

  ScreenService(this._config);

  void screenOn(){
    io.Process.run(_config.screenPowerOnScript, []);
  }

  void screenOff(){
    io.Process.run(_config.screenPowerOffScript, []);
  }

}