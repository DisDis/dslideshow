import 'package:json_annotation/json_annotation.dart';

part 'hardware_service_config.g.dart';

@JsonSerializable()
class HardwareConfig {
  @JsonKey(defaultValue: 100)
  int smoothingGPIOMs;
  @JsonKey(defaultValue: 17)
  int pinPauseButton;
  @JsonKey(defaultValue: 27)
  int pinMenuButton;

  @JsonKey(defaultValue: 23)
  int pinBackButton;
  @JsonKey(defaultValue: 22)
  int pinScreenToggleButton;

  @JsonKey(defaultValue: 15)
  int pinPIRSensor;

  @JsonKey(defaultValue: 14)
  int pinPowerLED;

  @JsonKey(defaultValue: '/dev/root')
  String systemDiskDev;

  @JsonKey(defaultValue: 'ifconfig')
  String systemIfConfigScript;

  @JsonKey(defaultValue: './scripts/screenOff.sh')
  String screenPowerOffScript;

  @JsonKey(defaultValue: './scripts/screenOn.sh')
  String screenPowerOnScript;

  @JsonKey(defaultValue: 120)
  int screenPowerOnTimerSec;
  HardwareConfig(
      {required this.screenPowerOnTimerSec,
      required this.screenPowerOnScript,
      required this.screenPowerOffScript,
      required this.pinBackButton,
      required this.pinPIRSensor,
      required this.pinMenuButton,
      required this.pinPauseButton,
      required this.pinPowerLED,
      required this.pinScreenToggleButton,
      required this.smoothingGPIOMs,
      required this.systemDiskDev,
      required this.systemIfConfigScript});

  factory HardwareConfig.fromJson(Map<String, dynamic> json) => _$HardwareConfigFromJson(json);

  Map<String, dynamic> toJson() => _$HardwareConfigToJson(this);
}
