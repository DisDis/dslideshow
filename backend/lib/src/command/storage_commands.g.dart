// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage_commands.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GetMediaItemCommand _$GetMediaItemCommandFromJson(Map<String, dynamic> json) =>
    _GetMediaItemCommand(
      isCurrent: json['isCurrent'] as bool,
      id: (json['id'] as num).toInt(),
      type: json['type'] as String? ?? GetMediaItemCommand.TYPE,
    );

Map<String, dynamic> _$GetMediaItemCommandToJson(
        _GetMediaItemCommand instance) =>
    <String, dynamic>{
      'isCurrent': instance.isCurrent,
      'id': instance.id,
      'type': instance.type,
    };

_GetMediaItemCommandResult _$GetMediaItemCommandResultFromJson(
        Map<String, dynamic> json) =>
    _GetMediaItemCommandResult(
      mediaId: json['mediaId'] as String?,
      mediaUri: json['mediaUri'] == null
          ? null
          : Uri.parse(json['mediaUri'] as String),
      id: (json['id'] as num).toInt(),
    );

Map<String, dynamic> _$GetMediaItemCommandResultToJson(
        _GetMediaItemCommandResult instance) =>
    <String, dynamic>{
      'mediaId': instance.mediaId,
      'mediaUri': instance.mediaUri?.toString(),
      'id': instance.id,
    };

_StorageNextCommand _$StorageNextCommandFromJson(Map<String, dynamic> json) =>
    _StorageNextCommand(
      id: (json['id'] as num).toInt(),
      type: json['type'] as String? ?? StorageNextCommand.TYPE,
    );

Map<String, dynamic> _$StorageNextCommandToJson(_StorageNextCommand instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
    };
