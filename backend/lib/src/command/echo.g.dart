// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'echo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EchoCommandImpl _$$EchoCommandImplFromJson(Map<String, dynamic> json) =>
    _$EchoCommandImpl(
      id: json['id'] as int,
      text: json['text'] as String?,
      type: json['type'] as String? ?? EchoCommand.TYPE,
    );

Map<String, dynamic> _$$EchoCommandImplToJson(_$EchoCommandImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'type': instance.type,
    };

_$EchoCommandResultImpl _$$EchoCommandResultImplFromJson(
        Map<String, dynamic> json) =>
    _$EchoCommandResultImpl(
      id: json['id'] as int,
      resultText: json['resultText'] as String?,
    );

Map<String, dynamic> _$$EchoCommandResultImplToJson(
        _$EchoCommandResultImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'resultText': instance.resultText,
    };
