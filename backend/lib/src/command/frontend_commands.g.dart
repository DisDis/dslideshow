// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'frontend_commands.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpdateFrontendStateCommand _$UpdateFrontendStateCommandFromJson(
  Map<String, dynamic> json,
) => _UpdateFrontendStateCommand(
  type: json['type'] as String? ?? UpdateFrontendStateCommand.TYPE,
  id: (json['id'] as num).toInt(),
  isPaused: json['isPaused'] as bool?,
  isMenu: json['isMenu'] as bool?,
);

Map<String, dynamic> _$UpdateFrontendStateCommandToJson(
  _UpdateFrontendStateCommand instance,
) => <String, dynamic>{
  'type': instance.type,
  'id': instance.id,
  'isPaused': instance.isPaused,
  'isMenu': instance.isMenu,
};
