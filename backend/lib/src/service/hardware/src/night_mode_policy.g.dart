// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'night_mode_policy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NightModeState _$NightModeStateFromJson(Map<String, dynamic> json) =>
    _NightModeState(
      enabled: json['enabled'] as bool? ?? false,
      mode:
          $enumDecodeNullable(_$NightModeEnumMap, json['mode']) ??
          NightMode.scheduleOnly,
      inSchedule: json['inSchedule'] as bool? ?? false,
      automaticWakeBlocked: json['automaticWakeBlocked'] as bool? ?? false,
      reason:
          $enumDecodeNullable(_$AutomaticSleepReasonEnumMap, json['reason']) ??
          AutomaticSleepReason.none,
      lightStatus:
          $enumDecodeNullable(
            _$AmbientLightStatusEnumMap,
            json['lightStatus'],
          ) ??
          AmbientLightStatus.disabled,
      illuminance: (json['illuminance'] as num?)?.toInt(),
      lightReceivedAt: json['lightReceivedAt'] == null
          ? null
          : DateTime.parse(json['lightReceivedAt'] as String),
      nextBoundary: json['nextBoundary'] == null
          ? null
          : DateTime.parse(json['nextBoundary'] as String),
    );

Map<String, dynamic> _$NightModeStateToJson(_NightModeState instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'mode': _$NightModeEnumMap[instance.mode]!,
      'inSchedule': instance.inSchedule,
      'automaticWakeBlocked': instance.automaticWakeBlocked,
      'reason': _$AutomaticSleepReasonEnumMap[instance.reason]!,
      'lightStatus': _$AmbientLightStatusEnumMap[instance.lightStatus]!,
      'illuminance': instance.illuminance,
      'lightReceivedAt': instance.lightReceivedAt?.toIso8601String(),
      'nextBoundary': instance.nextBoundary?.toIso8601String(),
    };

const _$NightModeEnumMap = {
  NightMode.scheduleOnly: 'scheduleOnly',
  NightMode.scheduleOrDarkness: 'scheduleOrDarkness',
  NightMode.scheduleAndDarkness: 'scheduleAndDarkness',
};

const _$AutomaticSleepReasonEnumMap = {
  AutomaticSleepReason.none: 'none',
  AutomaticSleepReason.schedule: 'schedule',
  AutomaticSleepReason.darkness: 'darkness',
  AutomaticSleepReason.scheduleAndDarkness: 'scheduleAndDarkness',
  AutomaticSleepReason.lightUnavailable: 'lightUnavailable',
};

const _$AmbientLightStatusEnumMap = {
  AmbientLightStatus.disabled: 'disabled',
  AmbientLightStatus.unavailable: 'unavailable',
  AmbientLightStatus.unknown: 'unknown',
  AmbientLightStatus.stale: 'stale',
  AmbientLightStatus.dark: 'dark',
  AmbientLightStatus.light: 'light',
};
