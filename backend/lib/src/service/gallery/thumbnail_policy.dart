import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:dslideshow_common/gallery.dart';

import 'gallery_config.dart';
import 'thumbnail_worker.dart';

/// Conservative initial experiment parameters, not measured Pi capacity.
/// Count/pixel/byte limits bound accepted work, not the whole Dart VM RSS.
class ThumbnailPolicy {
  final List<GalleryThumbnailSize> sizes;
  final int jpegQuality;
  final int backgroundColor;
  final int frameSelectionFrames;
  final int maxWorkers;
  final int maxQueued;
  final int maxWaiters;
  final int maxCacheBytes;
  final int maxCacheObjects;
  final int maxNegativeEntries;
  final int maxSourceBytes;
  final int maxSourcePixels;
  final int maxOutputBytes;
  final int maxVariantSize;
  final Duration workerTimeout;
  final Duration waiterTimeout;
  final Duration negativeTtl;
  const ThumbnailPolicy({
    this.sizes = GalleryThumbnailConfig.defaultSizes,
    this.jpegQuality = GalleryThumbnailConfig.defaultJpegQuality,
    this.backgroundColor = GalleryThumbnailConfig.defaultBackgroundColor,
    this.frameSelectionFrames =
        GalleryThumbnailConfig.defaultFrameSelectionFrames,
    this.maxWorkers = 4,
    this.maxQueued = 8,
    this.maxWaiters = 32,
    this.maxCacheBytes = 512 * 1024 * 1024,
    this.maxCacheObjects = 2048,
    this.maxNegativeEntries = 64,
    this.maxSourceBytes = 200 * 1024 * 1024,
    this.maxSourcePixels = 64 * 1024 * 1024,
    this.maxOutputBytes = 8 * 1024 * 1024,
    this.maxVariantSize = 1024,
    this.workerTimeout = const Duration(seconds: 20),
    this.waiterTimeout = const Duration(seconds: 30),
    this.negativeTtl = const Duration(seconds: 3),
  });
  factory ThumbnailPolicy.fromConfig(GalleryThumbnailConfig config) =>
      ThumbnailPolicy(
        sizes: List.unmodifiable(config.sizes),
        jpegQuality: config.jpegQuality,
        backgroundColor: config.backgroundColor,
        frameSelectionFrames: config.frameSelectionFrames,
        maxWorkers: config.maxWorkers,
        maxQueued: config.maxQueued,
        maxWaiters: config.maxWaiters,
        maxCacheBytes: config.cacheMaxBytes,
        maxCacheObjects: config.cacheMaxEntries,
        maxOutputBytes: min(8 * 1024 * 1024, config.cacheMaxBytes),
        workerTimeout: Duration(seconds: config.timeoutSeconds),
        waiterTimeout: Duration(seconds: max(30, config.timeoutSeconds + 10)),
      );

  String get renderRevision => sha256
      .convert(
        utf8.encode(
          jsonEncode([
            thumbnailPolicyVersion,
            jpegQuality,
            backgroundColor,
            frameSelectionFrames,
            for (final size in sizes) size.pixels,
          ]),
        ),
      )
      .toString();

  GalleryThumbnailPolicy get catalogPolicy => GalleryThumbnailPolicy(
    version: thumbnailPolicyVersion,
    revision: renderRevision,
    sizes: sizes,
  );
}
