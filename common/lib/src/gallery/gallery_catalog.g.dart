// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gallery_catalog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GalleryThumbnailPolicy _$GalleryThumbnailPolicyFromJson(
  Map<String, dynamic> json,
) => GalleryThumbnailPolicy(
  version: (json['version'] as num).toInt(),
  sizes: (json['sizes'] as List<dynamic>)
      .map(
        (e) => $enumDecode(
          _$GalleryThumbnailSizeEnumMap,
          e,
          unknownValue: GalleryThumbnailSize.unknown,
        ),
      )
      .toList(),
  revision: json['revision'] as String? ?? '',
);

Map<String, dynamic> _$GalleryThumbnailPolicyToJson(
  GalleryThumbnailPolicy instance,
) => <String, dynamic>{
  'version': instance.version,
  'revision': instance.revision,
  'sizes': instance.sizes
      .map((e) => _$GalleryThumbnailSizeEnumMap[e]!)
      .toList(),
};

const _$GalleryThumbnailSizeEnumMap = {
  GalleryThumbnailSize.small: 256,
  GalleryThumbnailSize.medium: 512,
  GalleryThumbnailSize.large: 1024,
  GalleryThumbnailSize.unknown: 0,
};

GalleryRefreshRequest _$GalleryRefreshRequestFromJson(
  Map<String, dynamic> json,
) => GalleryRefreshRequest(
  operationId: json['operationId'] as String,
  mode: $enumDecode(_$GalleryRefreshModeEnumMap, json['mode']),
);

Map<String, dynamic> _$GalleryRefreshRequestToJson(
  GalleryRefreshRequest instance,
) => <String, dynamic>{
  'operationId': instance.operationId,
  'mode': _$GalleryRefreshModeEnumMap[instance.mode]!,
};

const _$GalleryRefreshModeEnumMap = {
  GalleryRefreshMode.scan: 'scan',
  GalleryRefreshMode.forceInvalidate: 'forceInvalidate',
};

GalleryErrorResponse _$GalleryErrorResponseFromJson(
  Map<String, dynamic> json,
) => GalleryErrorResponse(
  $enumDecode(
    _$GalleryErrorCodeEnumMap,
    json['code'],
    unknownValue: GalleryErrorCode.unknown,
  ),
);

Map<String, dynamic> _$GalleryErrorResponseToJson(
  GalleryErrorResponse instance,
) => <String, dynamic>{'code': _$GalleryErrorCodeEnumMap[instance.code]!};

const _$GalleryErrorCodeEnumMap = {
  GalleryErrorCode.invalidRequest: 'invalidRequest',
  GalleryErrorCode.forbidden: 'forbidden',
  GalleryErrorCode.notFound: 'notFound',
  GalleryErrorCode.revisionMismatch: 'revisionMismatch',
  GalleryErrorCode.unsupported: 'unsupported',
  GalleryErrorCode.busy: 'busy',
  GalleryErrorCode.unavailable: 'unavailable',
  GalleryErrorCode.cancelled: 'cancelled',
  GalleryErrorCode.timeout: 'timeout',
  GalleryErrorCode.outputLimitExceeded: 'outputLimitExceeded',
  GalleryErrorCode.processingFailed: 'processingFailed',
  GalleryErrorCode.conflict: 'conflict',
  GalleryErrorCode.unknown: 'unknown',
};

_GalleryMediaRef _$GalleryMediaRefFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['section'],
    disallowNullValues: const ['section'],
  );
  return _GalleryMediaRef(
    mediaId: json['mediaId'] as String,
    sourceRevision: json['sourceRevision'] as String,
    section: $enumDecode(_$GalleryMediaSectionEnumMap, json['section']),
  );
}

Map<String, dynamic> _$GalleryMediaRefToJson(_GalleryMediaRef instance) =>
    <String, dynamic>{
      'mediaId': instance.mediaId,
      'sourceRevision': instance.sourceRevision,
      'section': _$GalleryMediaSectionEnumMap[instance.section]!,
    };

const _$GalleryMediaSectionEnumMap = {
  GalleryMediaSection.published: 'published',
  GalleryMediaSection.hidden: 'hidden',
  GalleryMediaSection.trash: 'trash',
};

_GalleryEntry _$GalleryEntryFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['section'],
    disallowNullValues: const ['section'],
  );
  return _GalleryEntry(
    mediaId: json['mediaId'] as String,
    path: json['path'] as String,
    name: json['name'] as String,
    kind: $enumDecode(
      _$GalleryEntryKindEnumMap,
      json['kind'],
      unknownValue: GalleryEntryKind.unknown,
    ),
    sourceRevision: json['sourceRevision'] as String? ?? '',
    section: $enumDecode(_$GalleryMediaSectionEnumMap, json['section']),
    thumbnailSupported: json['thumbnailSupported'] as bool? ?? false,
    sizeBytes: (json['sizeBytes'] as num?)?.toInt(),
    fileChanged: json['fileChanged'] == null
        ? null
        : DateTime.parse(json['fileChanged'] as String),
  );
}

Map<String, dynamic> _$GalleryEntryToJson(_GalleryEntry instance) =>
    <String, dynamic>{
      'mediaId': instance.mediaId,
      'path': instance.path,
      'name': instance.name,
      'kind': _$GalleryEntryKindEnumMap[instance.kind]!,
      'sourceRevision': instance.sourceRevision,
      'section': _$GalleryMediaSectionEnumMap[instance.section]!,
      'thumbnailSupported': instance.thumbnailSupported,
      'sizeBytes': ?instance.sizeBytes,
      'fileChanged': ?instance.fileChanged?.toIso8601String(),
    };

const _$GalleryEntryKindEnumMap = {
  GalleryEntryKind.image: 'image',
  GalleryEntryKind.animatedImage: 'animatedImage',
  GalleryEntryKind.video: 'video',
  GalleryEntryKind.directory: 'directory',
  GalleryEntryKind.unsupported: 'unsupported',
  GalleryEntryKind.unknown: 'unknown',
};

_GalleryCatalog _$GalleryCatalogFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['section'],
    disallowNullValues: const ['section'],
  );
  return _GalleryCatalog(
    schemaVersion:
        (json['schemaVersion'] as num?)?.toInt() ??
        GalleryCatalog.supportedSchemaVersion,
    section: $enumDecode(_$GalleryMediaSectionEnumMap, json['section']),
    catalogRevision: json['catalogRevision'] as String? ?? '',
    capabilities:
        (json['capabilities'] as List<dynamic>?)
            ?.map(
              (e) => $enumDecode(
                _$GalleryCapabilityEnumMap,
                e,
                unknownValue: GalleryCapability.unknown,
              ),
            )
            .toList() ??
        const [],
    thumbnailPolicy: json['thumbnailPolicy'] == null
        ? null
        : GalleryThumbnailPolicy.fromJson(
            json['thumbnailPolicy'] as Map<String, dynamic>,
          ),
    entries: (json['entries'] as List<dynamic>)
        .map((e) => GalleryEntry.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$GalleryCatalogToJson(_GalleryCatalog instance) =>
    <String, dynamic>{
      'schemaVersion': instance.schemaVersion,
      'section': _$GalleryMediaSectionEnumMap[instance.section]!,
      'catalogRevision': instance.catalogRevision,
      'capabilities': instance.capabilities
          .map((e) => _$GalleryCapabilityEnumMap[e]!)
          .toList(),
      'thumbnailPolicy': instance.thumbnailPolicy?.toJson(),
      'entries': instance.entries.map((e) => e.toJson()).toList(),
    };

const _$GalleryCapabilityEnumMap = {
  GalleryCapability.thumbnails: 'thumbnails',
  GalleryCapability.revisionedOriginals: 'revisionedOriginals',
  GalleryCapability.refresh: 'refresh',
  GalleryCapability.metadata: 'metadata',
  GalleryCapability.mutations: 'mutations',
  GalleryCapability.rotation: 'rotation',
  GalleryCapability.trash: 'trash',
  GalleryCapability.hidden: 'hidden',
  GalleryCapability.duplicates: 'duplicates',
  GalleryCapability.unknown: 'unknown',
};
