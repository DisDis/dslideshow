// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'night_mode_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AmbientLightConfig _$AmbientLightConfigFromJson(Map<String, dynamic> json) =>
    _AmbientLightConfig(
      enabled: json['enabled'] as bool? ?? false,
      topic: json['topic'] as String? ?? '',
      valueField: json['valueField'] as String? ?? 'illuminance',
      availabilityTopic: json['availabilityTopic'] as String? ?? '',
      darkBelowLux: (json['darkBelowLux'] as num?)?.toInt() ?? 5,
      lightAboveLux: (json['lightAboveLux'] as num?)?.toInt() ?? 10,
      maxAgeSec: (json['maxAgeSec'] as num?)?.toInt() ?? 1800,
    );

Map<String, dynamic> _$AmbientLightConfigToJson(_AmbientLightConfig instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'topic': instance.topic,
      'valueField': instance.valueField,
      'availabilityTopic': instance.availabilityTopic,
      'darkBelowLux': instance.darkBelowLux,
      'lightAboveLux': instance.lightAboveLux,
      'maxAgeSec': instance.maxAgeSec,
    };

_NightModeConfig _$NightModeConfigFromJson(Map<String, dynamic> json) =>
    _NightModeConfig(
      enabled: json['enabled'] as bool? ?? false,
      mode:
          $enumDecodeNullable(_$NightModeEnumMap, json['mode']) ??
          NightMode.scheduleOnly,
      startMinute: json['start'] == null ? 1380 : _startFromJson(json['start']),
      endMinute: json['end'] == null ? 480 : _endFromJson(json['end']),
      ambientLight: json['ambientLight'] == null
          ? const AmbientLightConfig()
          : AmbientLightConfig.fromJson(
              json['ambientLight'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$NightModeConfigToJson(_NightModeConfig instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'mode': _$NightModeEnumMap[instance.mode]!,
      'start': NightModeConfig.formatTime(instance.startMinute),
      'end': NightModeConfig.formatTime(instance.endMinute),
      'ambientLight': instance.ambientLight.toJson(),
    };

const _$NightModeEnumMap = {
  NightMode.scheduleOnly: 'scheduleOnly',
  NightMode.scheduleOrDarkness: 'scheduleOrDarkness',
  NightMode.scheduleAndDarkness: 'scheduleAndDarkness',
};
