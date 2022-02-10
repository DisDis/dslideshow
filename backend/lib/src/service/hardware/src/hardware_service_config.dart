import 'package:dslideshow_backend/config.dart';

class HardwareConfig extends BaseConfig {
  int? _smoothingGPIOMs;
  int get smoothingGPIOMs =>
      _smoothingGPIOMs ??= readInt("smoothingGPIOMs", 100);

  int? _pinPauseButton;
  int get pinPauseButton => _pinPauseButton ??= readInt("pinPauseButton", 17);

  int? _pinMenuButton;
  int get pinMenuButton => _pinMenuButton ??= readInt("pinMenuButton", 27);

  int? _pinBackButton;
  int get pinBackButton => _pinBackButton ??= readInt("pinBackButton", 23);

  int? _pinScreenToggleButton;
  int get pinScreenToggleButton =>
      _pinScreenToggleButton ??= readInt("pinScreenToggleButton", 22);

  int? _pinPIRSensor;
  int get pinPIRSensor => _pinPIRSensor ??= readInt("pinPIRSensor", 15);

  int? _pinPowerLED;
  int get pinPowerLED => _pinPowerLED ??= readInt("pinPowerLED", 14);

  String? _systemDiskDev;
  String get systemDiskDev =>
      (_systemDiskDev ??= readValue("systemDiskDev", '/dev/root'))!;

  String? _systemIfConfigScript;
  String get systemIfConfigScript => (_systemIfConfigScript ??=
      readValue("systemIfConfigScript", 'ifconfig'))!;

  String? _screenPowerOffScript;
  String get screenPowerOffScript => (_screenPowerOffScript ??=
      readValue("screenPowerOffScript", './screenOff.sh'))!;

  String? _screenPowerOnScript;
  String get screenPowerOnScript => (_screenPowerOnScript ??=
      readValue("screenPowerOnScript", './screenOn.sh'))!;

  int? _screenPowerOnTimerSec;
  int get screenPowerOnTimerSec =>
      _screenPowerOnTimerSec ??= readInt("screenPowerOnTimerSec", 120);

  HardwareConfig(Map<String, dynamic>? config) : super(config);
}
