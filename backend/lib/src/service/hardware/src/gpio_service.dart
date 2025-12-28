import 'dart:async';

import 'package:dslideshow_backend/command.dart';


abstract class GPIOService {
  Stream<ButtonEvent> get onButtonEvent;

  Stream<bool> get onMotion;
  Future init();
  Future release();
  set powerLED(bool? value);
}

class ButtonEvent{
  final ButtonType button;
  final ButtonEventType event;
  final int durationMs;
  ButtonEvent({required this.button, required this.event, required this.durationMs});
}
