// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screen_commands.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScreenTurnCommandImpl _$$ScreenTurnCommandImplFromJson(
        Map<String, dynamic> json) =>
    _$ScreenTurnCommandImpl(
      enabled: json['enabled'] as bool,
      id: json['id'] as int,
      type: json['type'] as String? ?? ScreenTurnCommand.TYPE,
    );

Map<String, dynamic> _$$ScreenTurnCommandImplToJson(
        _$ScreenTurnCommandImpl instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'id': instance.id,
      'type': instance.type,
    };

_$ScreenLockCommandImpl _$$ScreenLockCommandImplFromJson(
        Map<String, dynamic> json) =>
    _$ScreenLockCommandImpl(
      isLock: json['isLock'] as bool,
      id: json['id'] as int,
      type: json['type'] as String? ?? ScreenLockCommand.TYPE,
    );

Map<String, dynamic> _$$ScreenLockCommandImplToJson(
        _$ScreenLockCommandImpl instance) =>
    <String, dynamic>{
      'isLock': instance.isLock,
      'id': instance.id,
      'type': instance.type,
    };
