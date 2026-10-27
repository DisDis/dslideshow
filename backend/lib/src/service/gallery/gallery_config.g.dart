// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gallery_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GalleryConfig _$GalleryConfigFromJson(Map<String, dynamic> json) =>
    GalleryConfig(
      maxConcurrentMediaStreams: json['maxConcurrentMediaStreams'] == null
          ? 12
          : GalleryConfig._streams(json['maxConcurrentMediaStreams']),
      thumbnail: json['thumbnail'] == null
          ? const GalleryThumbnailConfig()
          : GalleryConfig._thumbnail(json['thumbnail']),
    );

Map<String, dynamic> _$GalleryConfigToJson(GalleryConfig instance) =>
    <String, dynamic>{
      'maxConcurrentMediaStreams': instance.maxConcurrentMediaStreams,
      'thumbnail': instance.thumbnail.toJson(),
    };

GalleryThumbnailConfig _$GalleryThumbnailConfigFromJson(
  Map<String, dynamic> json,
) => GalleryThumbnailConfig(
  sizes: json['sizes'] == null
      ? GalleryThumbnailConfig.defaultSizes
      : GalleryThumbnailConfig._sizes(json['sizes']),
  jpegQuality: json['jpegQuality'] == null
      ? GalleryThumbnailConfig.defaultJpegQuality
      : GalleryThumbnailConfig._quality(json['jpegQuality']),
  backgroundColor: json['backgroundColor'] == null
      ? GalleryThumbnailConfig.defaultBackgroundColor
      : GalleryThumbnailConfig._color(json['backgroundColor']),
  frameSelectionFrames: json['frameSelectionFrames'] == null
      ? GalleryThumbnailConfig.defaultFrameSelectionFrames
      : GalleryThumbnailConfig._frames(json['frameSelectionFrames']),
  maxWorkers: json['maxWorkers'] == null
      ? 4
      : GalleryThumbnailConfig._workers(json['maxWorkers']),
  maxQueued: json['maxQueued'] == null
      ? 8
      : GalleryThumbnailConfig._queued(json['maxQueued']),
  maxWaiters: json['maxWaiters'] == null
      ? 32
      : GalleryThumbnailConfig._waiters(json['maxWaiters']),
  cacheMaxBytes: json['cacheMaxBytes'] == null
      ? 512 * 1024 * 1024
      : GalleryThumbnailConfig._cacheBytes(json['cacheMaxBytes']),
  cacheMaxEntries: json['cacheMaxEntries'] == null
      ? 2048
      : GalleryThumbnailConfig._cacheEntries(json['cacheMaxEntries']),
  timeoutSeconds: json['timeoutSeconds'] == null
      ? 20
      : GalleryThumbnailConfig._timeout(json['timeoutSeconds']),
);

Map<String, dynamic> _$GalleryThumbnailConfigToJson(
  GalleryThumbnailConfig instance,
) => <String, dynamic>{
  'sizes': GalleryThumbnailConfig._sizeNames(instance.sizes),
  'jpegQuality': instance.jpegQuality,
  'backgroundColor': GalleryThumbnailConfig._colorText(
    instance.backgroundColor,
  ),
  'frameSelectionFrames': instance.frameSelectionFrames,
  'maxWorkers': instance.maxWorkers,
  'maxQueued': instance.maxQueued,
  'maxWaiters': instance.maxWaiters,
  'cacheMaxBytes': instance.cacheMaxBytes,
  'cacheMaxEntries': instance.cacheMaxEntries,
  'timeoutSeconds': instance.timeoutSeconds,
};
