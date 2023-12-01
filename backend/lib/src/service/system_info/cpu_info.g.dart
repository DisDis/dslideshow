// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cpu_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CpuInfoImpl _$$CpuInfoImplFromJson(Map<String, dynamic> json) =>
    _$CpuInfoImpl(
      cores: json['cores'] as int,
      hardware: json['hardware'] as String,
      model: json['model'] as String,
      revision: json['revision'] as String,
    );

Map<String, dynamic> _$$CpuInfoImplToJson(_$CpuInfoImpl instance) =>
    <String, dynamic>{
      'cores': instance.cores,
      'hardware': instance.hardware,
      'model': instance.model,
      'revision': instance.revision,
    };
