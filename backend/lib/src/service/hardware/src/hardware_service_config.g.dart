// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hardware_service_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HardwareConfig _$HardwareConfigFromJson(Map<String, dynamic> json) =>
    HardwareConfig(
      screenPowerOnTimerSec: json['screenPowerOnTimerSec'] as int? ?? 120,
      screenPowerOnScript:
          json['screenPowerOnScript'] as String? ?? './scripts/screenOn.sh',
      screenPowerOffScript:
          json['screenPowerOffScript'] as String? ?? './scripts/screenOff.sh',
      pinBackButton: json['pinBackButton'] as int? ?? 23,
      pinPIRSensor: json['pinPIRSensor'] as int? ?? 15,
      pinMenuButton: json['pinMenuButton'] as int? ?? 27,
      pinPauseButton: json['pinPauseButton'] as int? ?? 17,
      pinPowerLED: json['pinPowerLED'] as int? ?? 14,
      pinScreenToggleButton: json['pinScreenToggleButton'] as int? ?? 22,
      smoothingGPIOMs: json['smoothingGPIOMs'] as int? ?? 100,
      systemDiskDev: json['systemDiskDev'] as String? ?? '/dev/root',
      systemIfConfigScript:
          json['systemIfConfigScript'] as String? ?? 'ifconfig',
    );

Map<String, dynamic> _$HardwareConfigToJson(HardwareConfig instance) =>
    <String, dynamic>{
      'smoothingGPIOMs': instance.smoothingGPIOMs,
      'pinPauseButton': instance.pinPauseButton,
      'pinMenuButton': instance.pinMenuButton,
      'pinBackButton': instance.pinBackButton,
      'pinScreenToggleButton': instance.pinScreenToggleButton,
      'pinPIRSensor': instance.pinPIRSensor,
      'pinPowerLED': instance.pinPowerLED,
      'systemDiskDev': instance.systemDiskDev,
      'systemIfConfigScript': instance.systemIfConfigScript,
      'screenPowerOffScript': instance.screenPowerOffScript,
      'screenPowerOnScript': instance.screenPowerOnScript,
      'screenPowerOnTimerSec': instance.screenPowerOnTimerSec,
    };
