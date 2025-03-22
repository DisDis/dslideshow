// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'echo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EchoCommand _$EchoCommandFromJson(Map<String, dynamic> json) => _EchoCommand(
      id: (json['id'] as num).toInt(),
      text: json['text'] as String?,
      type: json['type'] as String? ?? EchoCommand.TYPE,
    );

Map<String, dynamic> _$EchoCommandToJson(_EchoCommand instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'type': instance.type,
    };

_EchoCommandResult _$EchoCommandResultFromJson(Map<String, dynamic> json) =>
    _EchoCommandResult(
      id: (json['id'] as num).toInt(),
      resultText: json['resultText'] as String?,
    );

Map<String, dynamic> _$EchoCommandResultToJson(_EchoCommandResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'resultText': instance.resultText,
    };
