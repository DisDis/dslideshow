// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ota_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OTAConfig _$OTAConfigFromJson(Map<String, dynamic> json) => OTAConfig(
  autoUpdateEnabled: json['autoUpdateEnabled'] as bool? ?? true,
  alwaysEnabled: json['alwaysEnabled'] as bool? ?? true,
);

Map<String, dynamic> _$OTAConfigToJson(OTAConfig instance) => <String, dynamic>{
  'alwaysEnabled': instance.alwaysEnabled,
  'autoUpdateEnabled': instance.autoUpdateEnabled,
};
