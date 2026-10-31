import 'package:freezed_annotation/freezed_annotation.dart';

part 'gallery_catalog.freezed.dart';
part 'gallery_catalog.g.dart';

enum GalleryMediaSection { published, hidden, trash }

@freezed
abstract class GalleryMediaRef with _$GalleryMediaRef {
  const factory GalleryMediaRef({
    required String mediaId,
    required String sourceRevision,
    @JsonKey(required: true, disallowNullValue: true) required GalleryMediaSection section,
  }) = _GalleryMediaRef;

  factory GalleryMediaRef.fromJson(Map<String, dynamic> json) => _$GalleryMediaRefFromJson(json);
}

enum GalleryEntryKind { image, animatedImage, video, directory, unsupported, unknown }

enum GalleryCapability {
  thumbnails,
  revisionedOriginals,
  refresh,
  metadata,
  mutations,
  rotation,
  trash,
  hidden,
  duplicates,
  unknown,
}

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
  cancelled,
  timeout,
  outputLimitExceeded,
  processingFailed,
  conflict,
  unknown,
}

@JsonSerializable()
class GalleryThumbnailPolicy {
  final int version;
  @JsonKey(defaultValue: '')
  final String revision;
  @JsonKey(unknownEnumValue: GalleryThumbnailSize.unknown)
  final List<GalleryThumbnailSize> sizes;

  const GalleryThumbnailPolicy({required this.version, required this.sizes, this.revision = ''});

  @JsonKey(includeFromJson: false, includeToJson: false)
  String get identity => revision.isEmpty ? '$version' : '$version-$revision';

  factory GalleryThumbnailPolicy.fromJson(Map<String, dynamic> json) => _$GalleryThumbnailPolicyFromJson(json);
  Map<String, dynamic> toJson() => _$GalleryThumbnailPolicyToJson(this);
}

@freezed
abstract class GalleryEntry with _$GalleryEntry {
  const GalleryEntry._();

  const factory GalleryEntry({
    required String mediaId,
    required String path,
    required String name,
    @JsonKey(unknownEnumValue: GalleryEntryKind.unknown) required GalleryEntryKind kind,
    @Default('') String sourceRevision,
    @JsonKey(required: true, disallowNullValue: true) required GalleryMediaSection section,
    @Default(false) bool thumbnailSupported,
    @JsonKey(includeIfNull: false) int? sizeBytes,
    @JsonKey(includeIfNull: false) DateTime? fileChanged,
  }) = _GalleryEntry;

  factory GalleryEntry.fromJson(Map<String, dynamic> json) => _$GalleryEntryFromJson(json);

  GalleryMediaRef get ref => GalleryMediaRef(mediaId: mediaId, sourceRevision: sourceRevision, section: section);
}

@freezed
abstract class GalleryCatalog with _$GalleryCatalog {
  const GalleryCatalog._();

  static const supportedSchemaVersion = 2;

  // Freezed forwards this factory annotation to its generated class.
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory GalleryCatalog({
    @Default(GalleryCatalog.supportedSchemaVersion) int schemaVersion,
    @JsonKey(required: true, disallowNullValue: true) required GalleryMediaSection section,
    @Default('') String catalogRevision,
    @JsonKey(unknownEnumValue: GalleryCapability.unknown) @Default([]) List<GalleryCapability> capabilities,
    GalleryThumbnailPolicy? thumbnailPolicy,
    required List<GalleryEntry> entries,
  }) = _GalleryCatalog;

  factory GalleryCatalog.fromJson(Map<String, dynamic> json) => _$GalleryCatalogFromJson(json);
}

@JsonSerializable()
class GalleryRefreshRequest {
  final String operationId;
  final GalleryRefreshMode mode;

  const GalleryRefreshRequest({required this.operationId, required this.mode});

  factory GalleryRefreshRequest.fromJson(Map<String, dynamic> json) => _$GalleryRefreshRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GalleryRefreshRequestToJson(this);
}

@JsonSerializable()
class GalleryErrorResponse {
  @JsonKey(unknownEnumValue: GalleryErrorCode.unknown)
  final GalleryErrorCode code;

  const GalleryErrorResponse(this.code);

  factory GalleryErrorResponse.fromJson(Map<String, dynamic> json) => _$GalleryErrorResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GalleryErrorResponseToJson(this);
}
