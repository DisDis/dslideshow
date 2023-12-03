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
      pinPIRSensor: json['pinPIRSensor'] as int? ?? 15,
      pinButton0: json['pinButton0'] as int? ?? 17,
      pinButton1: json['pinButton1'] as int? ?? 27,
      pinButton2: json['pinButton2'] as int? ?? 22,
      pinButton3: json['pinButton3'] as int? ?? 23,
      pinPowerLED: json['pinPowerLED'] as int? ?? 14,
      smoothingGPIOMs: json['smoothingGPIOMs'] as int? ?? 100,
      systemDiskDev: json['systemDiskDev'] as String? ?? '/dev/root',
      systemIfConfigScript:
          json['systemIfConfigScript'] as String? ?? 'ifconfig',
      sensorsScript:
          json['sensorsScript'] as String? ?? './scripts/sensorsScript.sh',
    );

Map<String, dynamic> _$HardwareConfigToJson(HardwareConfig instance) =>
    <String, dynamic>{
      'smoothingGPIOMs': instance.smoothingGPIOMs,
      'pinButton0': instance.pinButton0,
      'pinButton1': instance.pinButton1,
      'pinButton3': instance.pinButton3,
      'pinButton2': instance.pinButton2,
      'pinPIRSensor': instance.pinPIRSensor,
      'pinPowerLED': instance.pinPowerLED,
      'systemDiskDev': instance.systemDiskDev,
      'systemIfConfigScript': instance.systemIfConfigScript,
      'sensorsScript': instance.sensorsScript,
      'screenPowerOffScript': instance.screenPowerOffScript,
      'screenPowerOnScript': instance.screenPowerOnScript,
      'screenPowerOnTimerSec': instance.screenPowerOnTimerSec,
    };
