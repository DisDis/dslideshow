import 'package:json_annotation/json_annotation.dart';

part 'gallery_catalog.g.dart';

enum GalleryEntryKind {
  image,
  animatedImage,
  video,
  directory,
  unsupported,
  unknown,
}

enum GalleryCapability { thumbnails, revisionedOriginals, refresh, unknown }

enum GalleryThumbnailSize {
  @JsonValue(256)
  small(256),
  @JsonValue(512)
  medium(512),
  @JsonValue(1024)
  large(1024),
  @JsonValue(0)
  unknown(0);

  final int pixels;
  const GalleryThumbnailSize(this.pixels);
}

enum GalleryRefreshMode { scan, forceInvalidate }

enum GalleryErrorCode {
  invalidRequest,
  forbidden,
  notFound,
  revisionMismatch,
  unsupported,
  busy,
  unavailable,
  unknown,
}

@JsonSerializable()
class GalleryThumbnailPolicy {
  final int version;
  @JsonKey(unknownEnumValue: GalleryThumbnailSize.unknown)
  final List<GalleryThumbnailSize> sizes;

  const GalleryThumbnailPolicy({required this.version, required this.sizes});

  factory GalleryThumbnailPolicy.fromJson(Map<String, dynamic> json) =>
      _$GalleryThumbnailPolicyFromJson(json);
  Map<String, dynamic> toJson() => _$GalleryThumbnailPolicyToJson(this);
}

@JsonSerializable()
class GalleryEntry {
  final String mediaId;
  final String path;
  final String name;
  @JsonKey(unknownEnumValue: GalleryEntryKind.unknown)
  final GalleryEntryKind kind;
  final String? sourceRevision;
  @JsonKey(defaultValue: false)
  final bool thumbnailSupported;

  const GalleryEntry({
    required this.mediaId,
    required this.path,
    required this.name,
    required this.kind,
    required this.sourceRevision,
    this.thumbnailSupported = false,
  });

  factory GalleryEntry.fromJson(Map<String, dynamic> json) =>
      _$GalleryEntryFromJson(json);
  Map<String, dynamic> toJson() => _$GalleryEntryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GalleryCatalog {
  static const supportedSchemaVersion = 2;
  @JsonKey(defaultValue: supportedSchemaVersion)
  final int schemaVersion;
  final String serverId;
  final String catalogRevision;
  @JsonKey(unknownEnumValue: GalleryCapability.unknown)
  final List<GalleryCapability> capabilities;
  final GalleryThumbnailPolicy? thumbnailPolicy;
  final List<GalleryEntry> entries;

  const GalleryCatalog({
    this.schemaVersion = supportedSchemaVersion,
    required this.serverId,
    required this.catalogRevision,
    required this.capabilities,
    required this.thumbnailPolicy,
    required this.entries,
  });

  factory GalleryCatalog.fromJson(Map<String, dynamic> json) =>
      _$GalleryCatalogFromJson(json);
  Map<String, dynamic> toJson() => _$GalleryCatalogToJson(this);
}

@JsonSerializable()
class GalleryRefreshRequest {
  final String operationId;
  final GalleryRefreshMode mode;

  const GalleryRefreshRequest({required this.operationId, required this.mode});

  factory GalleryRefreshRequest.fromJson(Map<String, dynamic> json) =>
      _$GalleryRefreshRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GalleryRefreshRequestToJson(this);
}

@JsonSerializable()
class GalleryErrorResponse {
  @JsonKey(unknownEnumValue: GalleryErrorCode.unknown)
  final GalleryErrorCode code;

  const GalleryErrorResponse(this.code);

  factory GalleryErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$GalleryErrorResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GalleryErrorResponseToJson(this);
}
