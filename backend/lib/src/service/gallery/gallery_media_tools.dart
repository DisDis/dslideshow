// File IO remains asynchronous; external codecs run in bounded child processes.
// ignore_for_file: avoid_slow_async_io
import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;

import 'gallery_catalog_service.dart';
import 'gallery_file_operations.dart';
import 'gallery_files.dart';
import 'gallery_metadata_reader.dart';
import 'gallery_png_rotation.dart';
import 'gallery_tool_runner.dart';

/// Reads details only on demand and edits originals through the shared mutation
/// lock. An injected runner/operations owner is closed by its caller.
class GalleryMediaTools {
  static final _log = Logger('GalleryMediaTools');
  static const _maxCachedMetadata = 128;
  static const _maxConcurrentMetadata = 4;
  static const _maxSourceBytes = 200 * 1024 * 1024;
  static const _maxSourcePixels = 64 * 1024 * 1024;
  final GalleryCatalogService catalog;
  final GalleryToolRunner _runner;
  final GalleryFileOperations _operations;
  final bool _ownsRunner;
  final bool _ownsOperations;
  final bool _ownsMetadataReader;
  late final GalleryMetadataReader _metadataReader;
  final GalleryPngRotation _pngRotation = GalleryPngRotation(
    maxSourceBytes: _maxSourceBytes,
    maxSourcePixels: _maxSourcePixels,
  );
  final LinkedHashMap<String, GalleryMetadata> _cache = LinkedHashMap();
  final Map<String, Future<GalleryMetadata>> _metadataReads = {};
  final Set<Future<void>> _active = {};
  final Completer<void> _cancellation = Completer<void>();
  int _activeMetadataReads = 0;
  bool _closed = false;
  Future<void>? _closing;

  GalleryMediaTools({
    required this.catalog,
    GalleryToolRunner? runner,
    GalleryFileOperations? operations,
    GalleryMetadataReader? metadataReader,
  }) : _runner = runner ?? ProcessGalleryToolRunner(),
       _ownsRunner = runner == null,
       _operations = operations ?? GalleryFileOperations(catalog: catalog),
       _ownsOperations = operations == null,
       _ownsMetadataReader = metadataReader == null {
    _metadataReader =
        metadataReader ??
        GalleryMetadataReader(runner: _runner, cancellation: _cancellation.future, checkActive: _checkActive);
  }

  void _checkActive() {
    if (_closed) {
      throw const GalleryCatalogFailure(GalleryErrorCode.unavailable);
    }
  }

  Future<T> _track<T>(Future<T> Function() work) async {
    _checkActive();
    final done = Completer<void>();
    _active.add(done.future);
    try {
      return await work();
    } on FileSystemException catch (error) {
      throw GalleryCatalogFailure(
        error.osError?.errorCode == 13 ? GalleryErrorCode.forbidden : GalleryErrorCode.unavailable,
      );
    } finally {
      _active.remove(done.future);
      done.complete();
    }
  }

  Future<GalleryMetadata> metadata(String id, {required String revision}) {
    _checkActive();
    if (id.isEmpty || revision.isEmpty) {
      return Future.error(const GalleryCatalogFailure(GalleryErrorCode.invalidRequest));
    }
    final key = '$id:$revision';
    final pending = _metadataReads[key];
    if (pending != null) {
      _log.fine(() => 'Metadata shared media=${_logId(id)} active=${_metadataReads.length}');
      return pending;
    }
    if (_metadataReads.length >= _maxConcurrentMetadata) {
      return Future.error(const GalleryCatalogFailure(GalleryErrorCode.busy));
    }
    final read = _track(() async {
      final source = await _resolve(id, revision);
      _log.fine(
        () =>
            'Metadata started media=${_logId(id)} reader=${source.entry.kind == GalleryEntryKind.video ? 'ffprobe' : 'dartExif'} active=${_metadataReads.length} maxConcurrent=$_maxConcurrentMetadata cached=${_cache.length} maxCached=$_maxCachedMetadata',
      );
      final cached = _cache.remove(key);
      if (cached != null) {
        _log.fine(() => 'Metadata cache hit media=${_logId(id)}');
        _cache[key] = cached;
        return cached;
      }
      final details = await _read(source);
      await _ensureCurrent(source);
      _checkActive();
      _cache[key] = details;
      while (_cache.length > _maxCachedMetadata) {
        _cache.remove(_cache.keys.first);
      }
      return details;
    });
    _metadataReads[key] = read;
    read.then<void>(
      (_) {
        _metadataReads.remove(key);
        _log.fine(
          () =>
              'Metadata finished media=${_logId(id)} '
              ' cached=${_cache.length}',
        );
      },
      onError: (Object error) {
        _metadataReads.remove(key);
        final code = error is GalleryCatalogFailure ? error.code : GalleryErrorCode.processingFailed;
        _log.log(
          code == GalleryErrorCode.cancelled ? Level.FINE : Level.WARNING,
          () => 'Metadata failed media=${_logId(id)} code=${code.name} ',
        );
      },
    );
    return read;
  }

  Future<GallerySource> _resolve(String id, String revision) async {
    final source = await catalog.resolve(id, revision: revision);
    final originalRoot = await catalog.originals.resolveSymbolicLinks();
    final file = File(source.absolutePath);
    final type = await FileSystemEntity.type(file.path, followLinks: false);
    if (type != FileSystemEntityType.file) {
      throw const GalleryCatalogFailure(GalleryErrorCode.forbidden);
    }
    final resolved = await file.resolveSymbolicLinks();
    if (!path.isWithin(originalRoot, resolved) || resolved != path.join(originalRoot, source.entry.path)) {
      throw const GalleryCatalogFailure(GalleryErrorCode.forbidden);
    }
    return source;
  }

  Future<void> _ensureCurrent(GallerySource source) async {
    if (!await catalog.isCurrent(source)) {
      throw const GalleryCatalogFailure(GalleryErrorCode.revisionMismatch);
    }
  }

  /// The trash owner validates the entry/revision and confinement before and
  /// after this call; no original catalogue identity is assigned to this file.
  Future<GalleryMetadata> trashMetadata(GalleryTrashEntry entry, File file) => _track(
    () => _read(
      GallerySource(
        GalleryEntry(
          mediaId: entry.trashId,
          path: entry.originalPath,
          name: entry.name,
          kind: entry.kind,
          sourceRevision: entry.sourceRevision,
        ),
        file.path,
        entry.sourceRevision,
      ),
    ),
  );

  Future<GalleryMetadata> _read(GallerySource source, {String? input}) async {
    if (_activeMetadataReads >= _maxConcurrentMetadata) {
      throw const GalleryCatalogFailure(GalleryErrorCode.busy);
    }
    _activeMetadataReads++;
    try {
      return await _metadataReader.read(source, input: input);
    } finally {
      _activeMetadataReads--;
    }
  }

  Future<GalleryMetadata> rotate(GalleryRotateRequest request) async {
    _log.info(
      () =>
          'Rotation started direction=${request.rotation.name} metadataPolicy=jpegCopyPngNormalize '
          'maxSourceBytes=$_maxSourceBytes maxSourcePixels=$_maxSourcePixels',
    );
    try {
      final result = await _rotate(request);
      _log.info(
        () =>
            'Rotation finished direction=${request.rotation.name} '
            'format=${_ImageFormat.parse(result.format).name}',
      );
      return result;
    } on Object catch (error) {
      final code = error is GalleryCatalogFailure ? error.code : GalleryErrorCode.processingFailed;
      _log.log(
        code == GalleryErrorCode.cancelled ? Level.INFO : Level.WARNING,
        () =>
            'Rotation failed direction=${request.rotation.name} '
            'code=${code.name}',
      );
      rethrow;
    }
  }

  Future<GalleryMetadata> _rotate(GalleryRotateRequest request) => _track(
    () => _operations.withMediaLock(() async {
      _checkActive();
      if (request.operationId.isEmpty ||
          request.operationId.length > 100 ||
          request.mediaId.isEmpty ||
          request.sourceRevision.isEmpty) {
        throw const GalleryCatalogFailure(GalleryErrorCode.invalidRequest);
      }
      final source = await _resolve(request.mediaId, request.sourceRevision);
      if (source.entry.kind != GalleryEntryKind.image) {
        throw const GalleryCatalogFailure(GalleryErrorCode.unsupported);
      }
      final beforeStat = await File(source.absolutePath).stat();
      final before = await _read(source);
      final format = _ImageFormat.parse(before.format);
      final originalExif = format == _ImageFormat.jpeg
          ? await _metadataReader.exifDigest(File(source.absolutePath))
          : null;
      if (format == _ImageFormat.other || before.width == null || before.height == null) {
        throw const GalleryCatalogFailure(GalleryErrorCode.unsupported);
      }
      if (before.sizeBytes > _maxSourceBytes ||
          before.width! <= 0 ||
          before.height! <= 0 ||
          before.width! > _maxSourcePixels ~/ before.height!) {
        throw const GalleryCatalogFailure(GalleryErrorCode.unsupported);
      }
      final orientation = _ExifOrientation.parse(before.orientation);
      _log.info(
        () =>
            'Rotation codec selected '
            'tool=${format == _ImageFormat.jpeg ? 'jpegtran' : 'dartImage'} '
            'format=${format.name}',
      );
      final transform = orientation.retainedMetadataRotation(request.rotation);
      final swapsAxes = format == _ImageFormat.jpeg || !orientation.swapsAxes;
      final width = swapsAxes ? before.height! : before.width!;
      final height = swapsAxes ? before.width! : before.height!;
      // This reserved staging pattern is already excluded from every original
      // scan; using the source directory also guarantees same-volume rename.
      final staged = File(path.join(path.dirname(source.absolutePath), '.upload-${galleryToken()}.part'));
      try {
        await staged.create();
        // Apply source permissions while the staging file is still empty;
        // codecs truncate it in place and metadata rewriting is checked below.
        await _command('chmod', ['--reference=${source.absolutePath}', '--', staged.path]);
        final originalProfile = await _metadataReader.profileDigest(File(source.absolutePath));
        switch (format) {
          case _ImageFormat.jpeg:
            await _command('jpegtran', [
              '-copy',
              'all',
              '-perfect',
              ...transform.jpegArguments,
              '-outfile',
              staged.path,
              source.absolutePath,
            ], failure: GalleryErrorCode.unsupported);
          case _ImageFormat.png:
            await _pngRotation.rotate(
              source: File(source.absolutePath),
              staged: staged,
              rotation: request.rotation,
              cancellation: _cancellation.future,
            );
            _checkActive();
          case _ImageFormat.other:
            throw const GalleryCatalogFailure(GalleryErrorCode.unsupported);
        }
        if (!await staged.exists() || await staged.length() == 0 || await staged.length() > _maxSourceBytes) {
          throw const GalleryCatalogFailure(GalleryErrorCode.processingFailed);
        }
        final after = await _read(source, input: staged.path);
        if (format == _ImageFormat.jpeg && await _metadataReader.exifDigest(staged) != originalExif) {
          _log.warning('Rotation EXIF changed format=jpeg');
        }
        if (_ImageFormat.parse(after.format) != format ||
            after.width != width ||
            after.height != height ||
            (format == _ImageFormat.png
                ? after.orientation != 1
                : _ExifOrientation.parse(after.orientation) != orientation) ||
            after.bitDepth != before.bitDepth ||
            after.hasAlpha != before.hasAlpha ||
            (format == _ImageFormat.png && !_preservedMetadata(before, after)) ||
            await _metadataReader.profileDigest(staged) != originalProfile) {
          throw const GalleryCatalogFailure(GalleryErrorCode.processingFailed);
        }
        if (((await staged.stat()).mode & 0xfff) != (beforeStat.mode & 0xfff)) {
          await _command('chmod', ['--reference=${source.absolutePath}', '--', staged.path]);
        }
        _checkActive();
        await _ensureCurrent(source);
        final currentStat = await File(source.absolutePath).stat();
        if (!_sameStat(beforeStat, currentStat)) {
          throw const GalleryCatalogFailure(GalleryErrorCode.revisionMismatch);
        }
        _checkActive();
        // Publish the complete file; the old original stays ready until rename.
        await staged.rename(source.absolutePath);
        catalog.markDirty();
        final updated = await catalog.resolve(request.mediaId);
        final details = after.copyWith(
          sourceRevision: updated.entry.sourceRevision!,
          fileModified: (await File(source.absolutePath).stat()).modified.toUtc(),
        );
        _cache.removeWhere((_, value) => value.mediaId == request.mediaId);
        return details;
      } finally {
        if (await staged.exists()) await staged.delete();
      }
    }),
  );

  static String _logId(String value) => 'id-${sha256.convert(utf8.encode(value)).toString().substring(0, 12)}';

  static bool _sameStat(FileStat left, FileStat right) =>
      left.type == right.type &&
      left.size == right.size &&
      left.modified == right.modified &&
      left.changed == right.changed;

  static bool _preservedMetadata(GalleryMetadata left, GalleryMetadata right) =>
      left.dateTaken == right.dateTaken &&
      left.camera == right.camera &&
      left.lens == right.lens &&
      left.iso == right.iso &&
      left.exposure == right.exposure &&
      left.aperture == right.aperture &&
      left.focalLength == right.focalLength &&
      left.latitude == right.latitude &&
      left.longitude == right.longitude &&
      left.colorProfile == right.colorProfile;

  Future<GalleryToolResult> _command(
    String executable,
    List<String> arguments, {
    GalleryErrorCode failure = GalleryErrorCode.processingFailed,
  }) async {
    _checkActive();
    final result = await _runner.run(
      executable,
      arguments,
      cancellation: _cancellation.future,
      timeout: const Duration(seconds: 60),
      maxOutputBytes: 1024 * 1024,
    );
    if (result.exitCode != 0) throw GalleryCatalogFailure(failure);
    return result;
  }

  Future<void> close() => _closing ??= _close();

  Future<void> _close() async {
    _closed = true;
    _log.fine(() => 'Media tools closing active=${_active.length} cached=${_cache.length}');
    _cancellation.complete();
    await _pngRotation.close();
    if (_ownsMetadataReader) await _metadataReader.close();
    if (_ownsRunner) await _runner.close();
    await Future.wait(_active.toList());
    if (_ownsOperations) await _operations.close();
    _cache.clear();
    _log.fine('Media tools closed');
  }
}

enum _ImageFormat {
  jpeg,
  png,
  other;

  static _ImageFormat parse(String? value) => switch (value?.toUpperCase()) {
    'JPEG' => jpeg,
    'PNG' => png,
    _ => other,
  };
}

/// Raw EXIF values are converted once at the command boundary.
enum _ExifOrientation {
  normal,
  mirrorHorizontal,
  rotate180,
  mirrorVertical,
  transpose,
  rotate90,
  transverse,
  rotate270;

  static _ExifOrientation parse(int? value) {
    if (value == null) return normal;
    if (value < 1 || value > 8) {
      throw const GalleryCatalogFailure(GalleryErrorCode.unsupported);
    }
    return values[value - 1];
  }

  bool get mirrored => switch (this) {
    mirrorHorizontal || mirrorVertical || transpose || transverse => true,
    _ => false,
  };

  bool get swapsAxes => switch (this) {
    transpose || rotate90 || transverse || rotate270 => true,
    _ => false,
  };

  _PhysicalTransform retainedMetadataRotation(GalleryRotation direction) {
    final clockwise = direction == GalleryRotation.right;
    return clockwise != mirrored ? _PhysicalTransform.rotate90 : _PhysicalTransform.rotate270;
  }
}

enum _PhysicalTransform {
  rotate90,
  rotate270;

  List<String> get jpegArguments => switch (this) {
    rotate90 => const ['-rotate', '90'],
    rotate270 => const ['-rotate', '270'],
  };
}
