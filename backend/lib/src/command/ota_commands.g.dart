// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ota_commands.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OTAReadyCommand _$OTAReadyCommandFromJson(Map<String, dynamic> json) =>
    _OTAReadyCommand(
      ready: json['ready'] as bool,
      id: (json['id'] as num).toInt(),
      type: json['type'] as String? ?? OTAReadyCommand.TYPE,
    );

Map<String, dynamic> _$OTAReadyCommandToJson(_OTAReadyCommand instance) =>
    <String, dynamic>{
      'ready': instance.ready,
      'id': instance.id,
      'type': instance.type,
    };

_OTAGetInfoCommand _$OTAGetInfoCommandFromJson(Map<String, dynamic> json) =>
    _OTAGetInfoCommand(
      info: json['info'] == null
          ? null
          : OTAInfo.fromJson(json['info'] as Map<String, dynamic>),
      id: (json['id'] as num).toInt(),
      type: json['type'] as String? ?? OTAGetInfoCommand.TYPE,
    );

Map<String, dynamic> _$OTAGetInfoCommandToJson(_OTAGetInfoCommand instance) =>
    <String, dynamic>{
      'info': instance.info?.toJson(),
      'id': instance.id,
      'type': instance.type,
    };

_OTAGetInfoCommandResult _$OTAGetInfoCommandResultFromJson(
  Map<String, dynamic> json,
) => _OTAGetInfoCommandResult(
  info: OTAInfo.fromJson(json['info'] as Map<String, dynamic>),
  id: (json['id'] as num).toInt(),
);

Map<String, dynamic> _$OTAGetInfoCommandResultToJson(
  _OTAGetInfoCommandResult instance,
) => <String, dynamic>{'info': instance.info.toJson(), 'id': instance.id};

_OTAOutputCommand _$OTAOutputCommandFromJson(Map<String, dynamic> json) =>
    _OTAOutputCommand(
      id: (json['id'] as num).toInt(),
      output: json['output'] as String,
      type: json['type'] as String? ?? OTAOutputCommand.TYPE,
    );

Map<String, dynamic> _$OTAOutputCommandToJson(_OTAOutputCommand instance) =>
    <String, dynamic>{
      'id': instance.id,
      'output': instance.output,
      'type': instance.type,
    };

_OTAInfo _$OTAInfoFromJson(Map<String, dynamic> json) => _OTAInfo(
  status: $enumDecode(_$OTAStatusEnumMap, json['status']),
  uploadingPercent: (json['uploadingPercent'] as num).toDouble(),
  code: json['code'] as String,
  exitCode: (json['exitCode'] as num?)?.toInt(),
  errorText: json['errorText'] as String?,
);

Map<String, dynamic> _$OTAInfoToJson(_OTAInfo instance) => <String, dynamic>{
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
