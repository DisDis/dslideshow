import 'package:dslideshow_common/gallery.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gallery_config.g.dart';

@JsonSerializable(explicitToJson: true)
class GalleryConfig {
  @JsonKey(fromJson: _streams)
  final int maxConcurrentMediaStreams;
  @JsonKey(fromJson: _thumbnail)
  final GalleryThumbnailConfig thumbnail;

  const GalleryConfig({
    this.maxConcurrentMediaStreams = 12,
    this.thumbnail = const GalleryThumbnailConfig(),
  });

  static int _streams(dynamic value) => _integer(value, 12, max: 128);
  static GalleryThumbnailConfig _thumbnail(dynamic value) =>
      GalleryThumbnailConfig.fromJson(
        value is Map<String, dynamic> ? value : {},
      );

  factory GalleryConfig.fromJson(Map<String, dynamic> json) =>
      _$GalleryConfigFromJson(json);
  Map<String, dynamic> toJson() => _$GalleryConfigToJson(this);
}

@JsonSerializable()
class GalleryThumbnailConfig {
  static final _backgroundColorPattern = RegExp(r'^#[a-fA-F0-9]{6}$');
  static const defaultSizes = [
    GalleryThumbnailSize.small,
    GalleryThumbnailSize.medium,
    GalleryThumbnailSize.large,
  ];
  static const defaultJpegQuality = 60;
  static const defaultBackgroundColor = 0xff202020;
  static const defaultFrameSelectionFrames = 30;

  @JsonKey(fromJson: _sizes, toJson: _sizeNames)
  final List<GalleryThumbnailSize> sizes;
  @JsonKey(fromJson: _quality)
  final int jpegQuality;
  @JsonKey(fromJson: _color, toJson: _colorText)
  final int backgroundColor;
  @JsonKey(fromJson: _frames)
  final int frameSelectionFrames;
  @JsonKey(fromJson: _workers)
  final int maxWorkers;
  @JsonKey(fromJson: _queued)
  final int maxQueued;
  @JsonKey(fromJson: _waiters)
  final int maxWaiters;
  @JsonKey(fromJson: _cacheBytes)
  final int cacheMaxBytes;
  @JsonKey(fromJson: _cacheEntries)
  final int cacheMaxEntries;
  @JsonKey(fromJson: _timeout)
  final int timeoutSeconds;

  const GalleryThumbnailConfig({
    this.sizes = GalleryThumbnailConfig.defaultSizes,
    this.jpegQuality = GalleryThumbnailConfig.defaultJpegQuality,
    this.backgroundColor = GalleryThumbnailConfig.defaultBackgroundColor,
    this.frameSelectionFrames =
        GalleryThumbnailConfig.defaultFrameSelectionFrames,
    this.maxWorkers = 4,
    this.maxQueued = 8,
    this.maxWaiters = 32,
    this.cacheMaxBytes = 512 * 1024 * 1024,
    this.cacheMaxEntries = 2048,
    this.timeoutSeconds = 20,
  });

  // Names belong to the config boundary. The existing catalog wire format
  // continues using the enum's numeric @JsonValue values.
  static List<GalleryThumbnailSize> _sizes(dynamic value) {
    if (value is! List) return defaultSizes;
    final names = GalleryThumbnailSize.values.asNameMap();
    final result = <GalleryThumbnailSize>{};
    for (final name in value) {
      final size = name is String ? names[name] : null;
      if (size != null && size != GalleryThumbnailSize.unknown)
        result.add(size);
    }
    return result.isEmpty
        ? defaultSizes
        : (result.toList()..sort((a, b) => a.pixels.compareTo(b.pixels)));
  }

  static List<String> _sizeNames(List<GalleryThumbnailSize> sizes) =>
      sizes.map((size) => size.name).toList();
  static int _quality(dynamic value) =>
      _integer(value, defaultJpegQuality, max: 100);
  static int _frames(dynamic value) =>
      _integer(value, defaultFrameSelectionFrames, min: 2, max: 120);
  static int _workers(dynamic value) => _integer(value, 4, max: 32);
  static int _queued(dynamic value) => _integer(value, 8, min: 0, max: 1024);
  static int _waiters(dynamic value) => _integer(value, 32, max: 4096);
  static int _cacheBytes(dynamic value) =>
      _integer(value, 512 * 1024 * 1024, max: 1024 * 1024 * 1024 * 1024);
  static int _cacheEntries(dynamic value) =>
      _integer(value, 2048, max: 1000000);
  static int _timeout(dynamic value) => _integer(value, 20, max: 600);
  static int _color(dynamic value) =>
      value is String && _backgroundColorPattern.hasMatch(value)
      ? 0xff000000 | int.parse(value.substring(1), radix: 16)
      : defaultBackgroundColor;
  static String _colorText(int value) =>
      '#${(value & 0xffffff).toRadixString(16).padLeft(6, '0')}';

  factory GalleryThumbnailConfig.fromJson(Map<String, dynamic> json) =>
      _$GalleryThumbnailConfigFromJson(json);
  Map<String, dynamic> toJson() => _$GalleryThumbnailConfigToJson(this);
}

int _integer(dynamic value, int fallback, {int min = 1, required int max}) =>
    value is int && value >= min && value <= max ? value : fallback;
