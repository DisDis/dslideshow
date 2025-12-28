// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_info_commands.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GetSystemInfoCommand _$GetSystemInfoCommandFromJson(
  Map<String, dynamic> json,
) => _GetSystemInfoCommand(
  id: (json['id'] as num).toInt(),
  type: json['type'] as String? ?? GetSystemInfoCommand.TYPE,
);

Map<String, dynamic> _$GetSystemInfoCommandToJson(
  _GetSystemInfoCommand instance,
) => <String, dynamic>{'id': instance.id, 'type': instance.type};

_GetSystemInfoCommandResult _$GetSystemInfoCommandResultFromJson(
  Map<String, dynamic> json,
) => _GetSystemInfoCommandResult(
  systemInfo: SystemInfo.fromJson(json['systemInfo'] as Map<String, dynamic>),
  id: (json['id'] as num).toInt(),
);

Map<String, dynamic> _$GetSystemInfoCommandResultToJson(
  _GetSystemInfoCommandResult instance,
) => <String, dynamic>{
  'systemInfo': instance.systemInfo.toJson(),
  'id': instance.id,
};
