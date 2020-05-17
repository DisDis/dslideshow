import 'dart:async';


import 'package:logging/logging.dart';


abstract class GPIOService{
  Stream<bool> get onMotion;
  Stream<bool> get onPause;
  Stream<bool> get onMenu;
  Stream<bool> get onScreenToggle;
  Future init();
  Future release();
  set powerLED(bool value);
}

