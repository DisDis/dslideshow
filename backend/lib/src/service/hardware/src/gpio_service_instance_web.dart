import 'dart:async';

import 'package:dslideshow_backend/src/service/hardware/hardware.dart';
import 'package:dslideshow_backend/src/service/hardware/src/gpio_service.dart';

GPIOService getGPIOService(HardwareConfig config) => GPIOServiceImpl();

class GPIOServiceImpl extends GPIOService {
  final StreamController<bool> _fake = StreamController.broadcast();
  final StreamController<ButtonEvent> _fake1 = StreamController.broadcast();

  @override
  Future init() async {}

  @override
  Stream<bool> get onMotion => _fake.stream;

  @override
  Future release() async {}

  @override
  set powerLED(bool? value) {}

  @override
  Stream<ButtonEvent> get onButtonEvent => _fake1.stream;
 
}
