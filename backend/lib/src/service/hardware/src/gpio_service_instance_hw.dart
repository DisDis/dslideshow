import 'package:dslideshow_backend/src/service/hardware/hardware.dart';
import 'package:dslideshow_backend/src/service/hardware/src/gpio_service.dart';
import 'package:dslideshow_backend/src/service/hardware/src/gpio_service_impl.dart';

GPIOService getGPIOService(HardwareConfig config) => GPIOServiceImpl(config);
