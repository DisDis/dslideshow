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

_ScreenToggleCommand _$ScreenToggleCommandFromJson(Map<String, dynamic> json) =>
    _ScreenToggleCommand(
      id: (json['id'] as num).toInt(),
      type: json['type'] as String? ?? ScreenToggleCommand.TYPE,
    );

Map<String, dynamic> _$ScreenToggleCommandToJson(
  _ScreenToggleCommand instance,
) => <String, dynamic>{'id': instance.id, 'type': instance.type};
