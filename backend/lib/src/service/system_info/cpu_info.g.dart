// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cpu_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CpuInfo _$CpuInfoFromJson(Map<String, dynamic> json) => _CpuInfo(
  cores: (json['cores'] as num).toInt(),
  hardware: json['hardware'] as String,
  model: json['model'] as String,
  revision: json['revision'] as String,
);

Map<String, dynamic> _$CpuInfoToJson(_CpuInfo instance) => <String, dynamic>{
  'cores': instance.cores,
  'hardware': instance.hardware,
  'model': instance.model,
  'revision': instance.revision,
};
