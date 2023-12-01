// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_info_commands.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetSystemInfoCommandImpl _$$GetSystemInfoCommandImplFromJson(
        Map<String, dynamic> json) =>
    _$GetSystemInfoCommandImpl(
      id: json['id'] as int,
      type: json['type'] as String? ?? GetSystemInfoCommand.TYPE,
    );

Map<String, dynamic> _$$GetSystemInfoCommandImplToJson(
        _$GetSystemInfoCommandImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
    };

_$GetSystemInfoCommandResultImpl _$$GetSystemInfoCommandResultImplFromJson(
        Map<String, dynamic> json) =>
    _$GetSystemInfoCommandResultImpl(
      systemInfo:
          SystemInfo.fromJson(json['systemInfo'] as Map<String, dynamic>),
      id: json['id'] as int,
    );

Map<String, dynamic> _$$GetSystemInfoCommandResultImplToJson(
        _$GetSystemInfoCommandResultImpl instance) =>
    <String, dynamic>{
      'systemInfo': instance.systemInfo.toJson(),
      'id': instance.id,
    };
