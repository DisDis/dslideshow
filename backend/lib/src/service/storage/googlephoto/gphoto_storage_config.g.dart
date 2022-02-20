// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gphoto_storage_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GPhotoStorageConfig _$GPhotoStorageConfigFromJson(Map<String, dynamic> json) =>
    GPhotoStorageConfig(
      albumNames: (json['albumNames'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          ['SlideShow'],
      clientId: json['clientId'] == null
          ? 'clientId'
          : GPhotoClientIdConfig.fromJson(
              json['clientId'] as Map<String, dynamic>),
      imageHeight: json['imageHeight'] as int? ?? 1600,
      imageWidth: json['imageWidth'] as int? ?? 2560,
      refreshToken: json['refreshToken'] as String? ?? '',
      syncPeriod: GPhotoStorageConfig._parseDuration(json['syncPeriod']),
    );

Map<String, dynamic> _$GPhotoStorageConfigToJson(
        GPhotoStorageConfig instance) =>
    <String, dynamic>{
      'imageWidth': instance.imageWidth,
      'imageHeight': instance.imageHeight,
      'syncPeriod': GPhotoStorageConfig._durationToJson(instance.syncPeriod),
      'albumNames': instance.albumNames,
      'clientId': instance.clientId,
      'refreshToken': instance.refreshToken,
    };

GPhotoClientIdConfig _$GPhotoClientIdConfigFromJson(
        Map<String, dynamic> json) =>
    GPhotoClientIdConfig(
      identifier: json['identifier'] as String? ?? 'identifier',
      secret: json['secret'] as String? ?? 'secret',
    );

Map<String, dynamic> _$GPhotoClientIdConfigToJson(
        GPhotoClientIdConfig instance) =>
    <String, dynamic>{
      'identifier': instance.identifier,
      'secret': instance.secret,
    };
