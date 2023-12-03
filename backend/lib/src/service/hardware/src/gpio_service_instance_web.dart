import 'dart:async';

import 'package:dslideshow_backend/src/service/hardware/hardware.dart';
import 'package:dslideshow_backend/src/service/hardware/src/gpio_service.dart';

GPIOService getGPIOService(HardwareConfig config) => GPIOServiceImpl();

class GPIOServiceImpl extends GPIOService {
  final StreamController<bool> _fake = StreamController<bool>.broadcast();

  @override
  Future init() async {}

  @override
  Stream<bool> get onMotion => _fake.stream;

  @override
  Future release() async {}

  @override
  set powerLED(bool? value) {}

  @override
  Stream<bool> get onButton0 => _fake.stream;
  @override
  Stream<bool> get onButton1 => _fake.stream;
  @override
  Stream<bool> get onButton2 => _fake.stream;
  @override
  Stream<bool> get onButton3 => _fake.stream;
}
