import 'dart:async';

import 'package:dslideshow_backend/src/service/hardware/hardware.dart';
import 'package:dslideshow_backend/src/service/hardware/src/gpio_service.dart';

GPIOService getGPIOService(HardwareConfig config) => GPIOServiceImpl();

class GPIOServiceImpl extends GPIOService {
  final StreamController<bool> _fake = StreamController<bool>();

  @override
  Stream<bool> get onScreenToggle => _fake.stream;

  @override
  Future init() async {}

  @override
  Stream<bool> get onBack => _fake.stream;

  @override
  Stream<bool> get onMenu => _fake.stream;

  @override
  Stream<bool> get onMotion => _fake.stream;

  @override
  Stream<bool> get onPause => _fake.stream;
  @override
  Future release() async {}

  @override
  set powerLED(bool? value) {}
}
