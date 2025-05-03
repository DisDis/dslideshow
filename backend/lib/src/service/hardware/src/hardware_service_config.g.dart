// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hardware_service_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HardwareConfig _$HardwareConfigFromJson(Map<String, dynamic> json) =>
    HardwareConfig(
      screenPowerOnTimerSec:
          (json['screenPowerOnTimerSec'] as num?)?.toInt() ?? 120,
      screenPowerOnScript:
          json['screenPowerOnScript'] as String? ?? './scripts/screenOn.sh',
      screenPowerOffScript:
          json['screenPowerOffScript'] as String? ?? './scripts/screenOff.sh',
      pinPeopleSensor: (json['pinPeopleSensor'] as num?)?.toInt() ?? 12,
      pinButton0: (json['pinButton0'] as num?)?.toInt() ?? 23,
      pinButton1: (json['pinButton1'] as num?)?.toInt() ?? 22,
      pinButton2: (json['pinButton2'] as num?)?.toInt() ?? 27,
      pinButton3: (json['pinButton3'] as num?)?.toInt() ?? 17,
      pinPowerLED: (json['pinPowerLED'] as num?)?.toInt() ?? 25,
      smoothingGPIOMs: (json['smoothingGPIOMs'] as num?)?.toInt() ?? 100,
      systemDiskDev: json['systemDiskDev'] as String? ?? '/dev/root',
      systemIfConfigScript:
          json['systemIfConfigScript'] as String? ?? 'ifconfig',
      sensorsScript:
          json['sensorsScript'] as String? ?? './scripts/sensorsScript.sh',
      powerOffScript:
          json['powerOffScript'] as String? ?? './scripts/powerOff.sh',
      restartAppScript:
          json['restartAppScript'] as String? ?? './scripts/restarApp.sh',
    );

Map<String, dynamic> _$HardwareConfigToJson(HardwareConfig instance) =>
    <String, dynamic>{
      'smoothingGPIOMs': instance.smoothingGPIOMs,
      'pinButton0': instance.pinButton0,
      'pinButton1': instance.pinButton1,
      'pinButton2': instance.pinButton2,
      'pinButton3': instance.pinButton3,
      'pinPeopleSensor': instance.pinPeopleSensor,
      'pinPowerLED': instance.pinPowerLED,
      'systemDiskDev': instance.systemDiskDev,
      'systemIfConfigScript': instance.systemIfConfigScript,
      'sensorsScript': instance.sensorsScript,
      'screenPowerOffScript': instance.screenPowerOffScript,
      'powerOffScript': instance.powerOffScript,
      'restartAppScript': instance.restartAppScript,
      'screenPowerOnScript': instance.screenPowerOnScript,
      'screenPowerOnTimerSec': instance.screenPowerOnTimerSec,
    };
