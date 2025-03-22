// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screen_commands.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ScreenTurnCommand _$ScreenTurnCommandFromJson(Map<String, dynamic> json) =>
    _ScreenTurnCommand(
      enabled: json['enabled'] as bool,
      id: (json['id'] as num).toInt(),
      type: json['type'] as String? ?? ScreenTurnCommand.TYPE,
    );

Map<String, dynamic> _$ScreenTurnCommandToJson(_ScreenTurnCommand instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'id': instance.id,
      'type': instance.type,
    };

_ScreenLockCommand _$ScreenLockCommandFromJson(Map<String, dynamic> json) =>
    _ScreenLockCommand(
      isLock: json['isLock'] as bool,
      id: (json['id'] as num).toInt(),
      type: json['type'] as String? ?? ScreenLockCommand.TYPE,
    );

Map<String, dynamic> _$ScreenLockCommandToJson(_ScreenLockCommand instance) =>
    <String, dynamic>{
      'isLock': instance.isLock,
      'id': instance.id,
      'type': instance.type,
    };
