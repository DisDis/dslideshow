import 'dart:async';

abstract class GPIOService {
  //Pause
  Stream<bool> get onButton0;
  //Menu
  Stream<bool> get onButton1;
  //ScreenToggle
  Stream<bool> get onButton2;
  //Back
  Stream<bool> get onButton3;

  Stream<bool> get onMotion;
  Future init();
  Future release();
  set powerLED(bool? value);
}
