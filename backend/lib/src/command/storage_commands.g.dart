// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage_commands.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetMediaItemCommandImpl _$$GetMediaItemCommandImplFromJson(
        Map<String, dynamic> json) =>
    _$GetMediaItemCommandImpl(
      isCurrent: json['isCurrent'] as bool,
      id: json['id'] as int,
      type: json['type'] as String? ?? GetMediaItemCommand.TYPE,
    );

Map<String, dynamic> _$$GetMediaItemCommandImplToJson(
        _$GetMediaItemCommandImpl instance) =>
    <String, dynamic>{
      'isCurrent': instance.isCurrent,
      'id': instance.id,
      'type': instance.type,
    };

_$GetMediaItemCommandResultImpl _$$GetMediaItemCommandResultImplFromJson(
        Map<String, dynamic> json) =>
    _$GetMediaItemCommandResultImpl(
      mediaId: json['mediaId'] as String?,
      mediaUri: json['mediaUri'] == null
          ? null
          : Uri.parse(json['mediaUri'] as String),
      id: json['id'] as int,
    );

Map<String, dynamic> _$$GetMediaItemCommandResultImplToJson(
        _$GetMediaItemCommandResultImpl instance) =>
    <String, dynamic>{
      'mediaId': instance.mediaId,
      'mediaUri': instance.mediaUri?.toString(),
      'id': instance.id,
    };

_$StorageNextCommandImpl _$$StorageNextCommandImplFromJson(
        Map<String, dynamic> json) =>
    _$StorageNextCommandImpl(
      id: json['id'] as int,
      type: json['type'] as String? ?? StorageNextCommand.TYPE,
    );

Map<String, dynamic> _$$StorageNextCommandImplToJson(
        _$StorageNextCommandImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
    };
