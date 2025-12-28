// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ErrorResult _$ErrorResultFromJson(Map<String, dynamic> json) => _ErrorResult(
  error: json['error'] as String,
  id: (json['id'] as num).toInt(),
);

Map<String, dynamic> _$ErrorResultToJson(_ErrorResult instance) =>
    <String, dynamic>{'error': instance.error, 'id': instance.id};
