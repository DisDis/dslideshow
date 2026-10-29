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

GalleryEntry _$GalleryEntryFromJson(Map<String, dynamic> json) => GalleryEntry(
  mediaId: json['mediaId'] as String,
  path: json['path'] as String,
  name: json['name'] as String,
  kind: $enumDecode(
    _$GalleryEntryKindEnumMap,
    json['kind'],
    unknownValue: GalleryEntryKind.unknown,
  ),
  sourceRevision: json['sourceRevision'] as String?,
  thumbnailSupported: json['thumbnailSupported'] as bool? ?? false,
);

Map<String, dynamic> _$GalleryEntryToJson(GalleryEntry instance) =>
    <String, dynamic>{
      'mediaId': instance.mediaId,
      'path': instance.path,
      'name': instance.name,
      'kind': _$GalleryEntryKindEnumMap[instance.kind]!,
      'sourceRevision': instance.sourceRevision,
      'thumbnailSupported': instance.thumbnailSupported,
    };

const _$GalleryEntryKindEnumMap = {
  GalleryEntryKind.image: 'image',
  GalleryEntryKind.animatedImage: 'animatedImage',
  GalleryEntryKind.video: 'video',
  GalleryEntryKind.directory: 'directory',
  GalleryEntryKind.unsupported: 'unsupported',
  GalleryEntryKind.unknown: 'unknown',
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

_GalleryCatalog _$GalleryCatalogFromJson(Map<String, dynamic> json) =>
    _GalleryCatalog(
      schemaVersion:
          (json['schemaVersion'] as num?)?.toInt() ??
          GalleryCatalog.supportedSchemaVersion,
      catalogRevision: json['catalogRevision'] as String,
      capabilities: (json['capabilities'] as List<dynamic>)
          .map(
            (e) => $enumDecode(
              _$GalleryCapabilityEnumMap,
              e,
              unknownValue: GalleryCapability.unknown,
            ),
          )
          .toList(),
      thumbnailPolicy: json['thumbnailPolicy'] == null
          ? null
          : GalleryThumbnailPolicy.fromJson(
              json['thumbnailPolicy'] as Map<String, dynamic>,
            ),
      entries: (json['entries'] as List<dynamic>)
          .map((e) => GalleryEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GalleryCatalogToJson(_GalleryCatalog instance) =>
    <String, dynamic>{
      'schemaVersion': instance.schemaVersion,
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
  GalleryCapability.duplicates: 'duplicates',
  GalleryCapability.unknown: 'unknown',
};
