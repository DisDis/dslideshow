// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GalleryCatalogState _$GalleryCatalogStateFromJson(Map<String, dynamic> json) =>
    GalleryCatalogState(
      serverId: json['serverId'] as String,
      epoch: json['epoch'] as String,
      revision: json['revision'] as String,
      records: (json['records'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
          k,
          GallerySourceRecord.fromJson(e as Map<String, dynamic>),
        ),
      ),
      completedOperations:
          (json['completedOperations'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$GalleryCatalogStateToJson(
  GalleryCatalogState instance,
) => <String, dynamic>{
  'serverId': instance.serverId,
  'epoch': instance.epoch,
  'revision': instance.revision,
  'records': instance.records.map((k, e) => MapEntry(k, e.toJson())),
  'completedOperations': instance.completedOperations,
};

GallerySourceRecord _$GallerySourceRecordFromJson(Map<String, dynamic> json) =>
    GallerySourceRecord(
      id: json['id'] as String,
      generation: json['generation'] as String,
      fingerprint: json['fingerprint'] as String,
      directory: json['directory'] as bool,
    );

Map<String, dynamic> _$GallerySourceRecordToJson(
  GallerySourceRecord instance,
) => <String, dynamic>{
  'id': instance.id,
  'generation': instance.generation,
  'fingerprint': instance.fingerprint,
  'directory': instance.directory,
};

GalleryPublicationRecord _$GalleryPublicationRecordFromJson(
  Map<String, dynamic> json,
) => GalleryPublicationRecord(
  token: json['token'] as String,
  dirty: json['dirty'] as bool,
  ownerPid: (json['ownerPid'] as num).toInt(),
  ownerStart: json['ownerStart'] as String? ?? '',
);

Map<String, dynamic> _$GalleryPublicationRecordToJson(
  GalleryPublicationRecord instance,
) => <String, dynamic>{
  'token': instance.token,
  'dirty': instance.dirty,
  'ownerPid': instance.ownerPid,
  'ownerStart': instance.ownerStart,
};
