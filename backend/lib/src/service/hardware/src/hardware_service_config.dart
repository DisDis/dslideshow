import 'package:json_annotation/json_annotation.dart';

part 'hardware_service_config.g.dart';

@JsonSerializable()
class HardwareConfig {
  @JsonKey(defaultValue: 100)
  int smoothingGPIOMs;

  @JsonKey(defaultValue: 17)
  int pinButton0;
  @JsonKey(defaultValue: 27)
  int pinButton1;
  @JsonKey(defaultValue: 23)
  int pinButton3;
  @JsonKey(defaultValue: 22)
  int pinButton2;

  @JsonKey(defaultValue: 12)
  int pinPeopleSensor;

  @JsonKey(defaultValue: 25)
  int pinPowerLED;

  @JsonKey(defaultValue: '/dev/root')
  String systemDiskDev;

  @JsonKey(defaultValue: 'ifconfig')
  String systemIfConfigScript;

  @JsonKey(defaultValue: './scripts/sensorsScript.sh')
  String sensorsScript;

  @JsonKey(defaultValue: './scripts/screenOff.sh')
  String screenPowerOffScript;

  @JsonKey(defaultValue: './scripts/powerOff.sh')
  String powerOffScript;

  @JsonKey(defaultValue: './scripts/screenOn.sh')
  String screenPowerOnScript;

  @JsonKey(defaultValue: 120)
  int screenPowerOnTimerSec;
  HardwareConfig(
      {required this.screenPowerOnTimerSec,
      required this.screenPowerOnScript,
      required this.screenPowerOffScript,
      required this.pinPeopleSensor,
      required this.pinButton0,
      required this.pinButton1,
      required this.pinButton2,
      required this.pinButton3,
      required this.pinPowerLED,
      required this.smoothingGPIOMs,
      required this.systemDiskDev,
      required this.systemIfConfigScript,
      required this.sensorsScript,
      required this.powerOffScript});

  factory HardwareConfig.fromJson(Map<String, dynamic> json) => _$HardwareConfigFromJson(json);

  Map<String, dynamic> toJson() => _$HardwareConfigToJson(this);
}
