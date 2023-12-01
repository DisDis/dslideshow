// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ota_commands.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OTAReadyCommandImpl _$$OTAReadyCommandImplFromJson(
        Map<String, dynamic> json) =>
    _$OTAReadyCommandImpl(
      ready: json['ready'] as bool,
      id: json['id'] as int,
      type: json['type'] as String? ?? OTAReadyCommand.TYPE,
    );

Map<String, dynamic> _$$OTAReadyCommandImplToJson(
        _$OTAReadyCommandImpl instance) =>
    <String, dynamic>{
      'ready': instance.ready,
      'id': instance.id,
      'type': instance.type,
    };

_$OTAGetInfoCommandImpl _$$OTAGetInfoCommandImplFromJson(
        Map<String, dynamic> json) =>
    _$OTAGetInfoCommandImpl(
      info: json['info'] == null
          ? null
          : OTAInfo.fromJson(json['info'] as Map<String, dynamic>),
      id: json['id'] as int,
      type: json['type'] as String? ?? OTAGetInfoCommand.TYPE,
    );

Map<String, dynamic> _$$OTAGetInfoCommandImplToJson(
        _$OTAGetInfoCommandImpl instance) =>
    <String, dynamic>{
      'info': instance.info?.toJson(),
      'id': instance.id,
      'type': instance.type,
    };

_$OTAGetInfoCommandResultImpl _$$OTAGetInfoCommandResultImplFromJson(
        Map<String, dynamic> json) =>
    _$OTAGetInfoCommandResultImpl(
      info: OTAInfo.fromJson(json['info'] as Map<String, dynamic>),
      id: json['id'] as int,
    );

Map<String, dynamic> _$$OTAGetInfoCommandResultImplToJson(
        _$OTAGetInfoCommandResultImpl instance) =>
    <String, dynamic>{
      'info': instance.info.toJson(),
      'id': instance.id,
    };

_$OTAOutputCommandImpl _$$OTAOutputCommandImplFromJson(
        Map<String, dynamic> json) =>
    _$OTAOutputCommandImpl(
      id: json['id'] as int,
      output: json['output'] as String,
      type: json['type'] as String? ?? OTAOutputCommand.TYPE,
    );

Map<String, dynamic> _$$OTAOutputCommandImplToJson(
        _$OTAOutputCommandImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'output': instance.output,
      'type': instance.type,
    };

_$OTAInfoImpl _$$OTAInfoImplFromJson(Map<String, dynamic> json) =>
    _$OTAInfoImpl(
      status: $enumDecode(_$OTAStatusEnumMap, json['status']),
      uploadingPercent: (json['uploadingPercent'] as num).toDouble(),
      code: json['code'] as String,
      exitCode: json['exitCode'] as int?,
      errorText: json['errorText'] as String?,
    );

Map<String, dynamic> _$$OTAInfoImplToJson(_$OTAInfoImpl instance) =>
    <String, dynamic>{
      'status': _$OTAStatusEnumMap[instance.status]!,
      'uploadingPercent': instance.uploadingPercent,
      'code': instance.code,
      'exitCode': instance.exitCode,
      'errorText': instance.errorText,
    };

const _$OTAStatusEnumMap = {
  OTAStatus.disabled: 'disabled',
  OTAStatus.ready: 'ready',
  OTAStatus.uploading: 'uploading',
  OTAStatus.instaling: 'instaling',
  OTAStatus.finished: 'finished',
  OTAStatus.issue: 'issue',
  OTAStatus.preReboot: 'preReboot',
};
