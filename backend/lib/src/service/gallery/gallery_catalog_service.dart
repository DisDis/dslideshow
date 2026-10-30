// Asynchronous filesystem work keeps HTTP and RPC event loops responsive.
// ignore_for_file: avoid_slow_async_io
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dslideshow_common/file_settings.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;

import 'gallery_files.dart';
import 'thumbnail_policy.dart';

class GalleryCatalogFailure implements Exception {
  final GalleryErrorCode code;
  const GalleryCatalogFailure(this.code);
}

class GallerySource {
  final GalleryEntry entry;
  final String absolutePath;
  final String fingerprint;
  const GallerySource(this.entry, this.absolutePath, this.fingerprint);
}

class _CatalogDigest implements Sink<Digest> {
  late Digest value;

  @override
  void add(Digest data) => value = data;

  @override
  void close() {}
}

/// Owns the in-memory index in the web isolate; scans are serialized.
class GalleryCatalogService {
  static final _log = Logger('GalleryCatalogService');
  static final _epochPattern = RegExp(r'^[a-f0-9]{32}$');
  final Directory originals;
  final Directory stateDirectory;
  final Duration scanMaxAge;
  final int maxPendingOperations;
  final GalleryThumbnailPolicy thumbnailPolicy;
  final List<GalleryCapability> additionalCapabilities;
  int _pendingOperations = 0;
  String? _epoch;
  final Set<String> _completedOperations = {};
  GalleryCatalog? _catalog;
  Map<String, GallerySource> _entriesById = {};
  DateTime? _lastScan;
  Future<void> _operations = Future.value();
  StreamSubscription<FileSystemEvent>? _watch;
  bool _dirty = true;
  bool _closed = false;
  int _events = 0;

  GalleryCatalogService({
    required this.originals,
    required this.stateDirectory,
    this.scanMaxAge = const Duration(seconds: 30),
    this.maxPendingOperations = 64,
    GalleryThumbnailPolicy? thumbnailPolicy,
    this.additionalCapabilities = const [],
  }) : thumbnailPolicy = thumbnailPolicy ?? const ThumbnailPolicy().catalogPolicy {
    if (maxPendingOperations < 1) throw ArgumentError.value(maxPendingOperations);
  }

  void markDirty() {
    if (_closed) return;
    _dirty = true;
    _events++;
    _log.fine('Gallery catalog marked dirty');
  }

  Future<T> _enqueue<T>(Future<T> Function() work) {
    if (_closed) return Future.error(const GalleryCatalogFailure(GalleryErrorCode.unavailable));
    if (_pendingOperations >= maxPendingOperations) {
      return Future.error(const GalleryCatalogFailure(GalleryErrorCode.busy));
    }
    _pendingOperations++;
    final future = _operations
        .then((_) {
          if (_closed) throw const GalleryCatalogFailure(GalleryErrorCode.unavailable);
          return work();
        })
        .whenComplete(() {
          _pendingOperations--;
        });
    _operations = future.then<void>((_) {}, onError: (Object _, StackTrace __) {});
    return future;
  }

  Future<GalleryCatalog> catalog() => _enqueue(() async {
    await _initialize();
    if (_catalog == null || _dirty || DateTime.now().difference(_lastScan!) >= scanMaxAge) {
      await _scan();
    }
    return _catalog!;
  });

  Future<GalleryCatalog> refresh(GalleryRefreshRequest request) => _enqueue(() async {
    await _initialize();
    if (request.operationId.isEmpty || request.operationId.length > 100) {
      throw const GalleryCatalogFailure(GalleryErrorCode.invalidRequest);
    }
    if (_completedOperations.contains(request.operationId)) {
      if (_catalog == null) await _scan();
      return _catalog!;
    }
    await _scan(forceInvalidate: request.mode == GalleryRefreshMode.forceInvalidate);
    _completedOperations.add(request.operationId);
    if (_completedOperations.length > 64) {
      _completedOperations.remove(_completedOperations.first);
    }
    return _catalog!;
  });

  Future<GallerySource> resolve(String mediaId, {String? revision}) => _enqueue(() async {
    await _initialize();
    if (_catalog == null) await _scan();
    var source = _entriesById[mediaId];
    if (source == null || source.entry.kind == GalleryEntryKind.directory) {
      throw const GalleryCatalogFailure(GalleryErrorCode.notFound);
    }
    final fingerprint = await _fingerprint(source.entry.path);
    if (fingerprint == null) {
      markDirty();
      throw const GalleryCatalogFailure(GalleryErrorCode.notFound);
    }
    if (fingerprint != source.fingerprint) {
      await _scan();
      source = _entriesById[mediaId];
      if (source == null) throw const GalleryCatalogFailure(GalleryErrorCode.notFound);
    }
    if (revision != null && revision != source.entry.sourceRevision) {
      throw const GalleryCatalogFailure(GalleryErrorCode.revisionMismatch);
    }
    return source;
  });

  Future<GallerySource> resolvePath(String relativePath, {required String revision}) async {
    await catalog();
    return resolve(_mediaId(relativePath), revision: revision);
  }

  Future<bool> isCurrent(GallerySource source) async {
    try {
      final current = await resolve(source.entry.mediaId, revision: source.entry.sourceRevision);
      return current.fingerprint == source.fingerprint;
    } on GalleryCatalogFailure catch (error) {
      if (error.code == GalleryErrorCode.notFound || error.code == GalleryErrorCode.revisionMismatch) return false;
      rethrow;
    }
  }

  Future<void> _initialize() async {
    if (_epoch != null) return;
    _epoch = await _loadEpoch();
    if (await originals.exists()) {
      try {
        _watch = originals.watch().listen(
          (_) {
            markDirty();
          },
          onError: (Object error, StackTrace stack) {
            _log.warning(() => 'Gallery file watcher failed originals=${jsonEncode(originals.path)}', error, stack);
            markDirty();
          },
        );
      } on FileSystemException catch (error, stack) {
        _log.warning(
          () =>
              'Gallery file watcher unavailable; using scans '
              'originals=${jsonEncode(originals.path)}',
          error,
          stack,
        );
      }
    }
  }

  Future<String> _loadEpoch() async {
    final file = File(path.join(stateDirectory.path, 'catalog.epoch'));
    try {
      final input = await file.open();
      try {
        final value = utf8.decode(await input.read(33));
        if (value.length != 32 || !_epochPattern.hasMatch(value)) {
          throw const FormatException('Invalid gallery epoch');
        }
        return value;
      } finally {
        await input.close();
      }
    } on FileSystemException catch (error) {
      if (error.osError?.errorCode != 2) {
        _log.warning(
          'Gallery invalidation state read failed '
          'type=${error.runtimeType} osCode=${error.osError?.errorCode}',
        );
        rethrow;
      }
    } on FormatException {
      _log.warning('Gallery invalidation state invalid; creating a new epoch');
    }
    final epoch = galleryToken();
    await _persistEpoch(epoch);
    return epoch;
  }

  Future<String?> _fingerprint(String relativePath) async {
    final file = File(path.join(originals.absolute.path, relativePath));
    final stat = await file.stat();
    if (stat.type == FileSystemEntityType.notFound) return null;
    return '${stat.type}:${stat.size}:${stat.modified.microsecondsSinceEpoch}:${stat.changed.microsecondsSinceEpoch}';
  }

  static String _mediaId(String relativePath) => sha256.convert(utf8.encode(relativePath)).toString();

  static String _sourceRevision(String epoch, String fingerprint) =>
      sha256.convert(utf8.encode('$epoch:$fingerprint')).toString();

  static String _snapshotRevision(String epoch, List<GallerySource> sources) {
    final result = _CatalogDigest();
    final input = sha256.startChunkedConversion(result);
    input.add(utf8.encode(epoch));
    for (final source in sources) {
      input.add(utf8.encode(jsonEncode([source.entry.path, source.fingerprint])));
    }
    input.close();
    return result.value.toString();
  }

  Future<void> _scan({bool forceInvalidate = false}) async {
    _log.fine(
      () =>
          'Gallery scan started originals=${jsonEncode(originals.path)} '
          'forceInvalidate=$forceInvalidate',
    );
    final eventAtStart = _events;
    final epoch = forceInvalidate ? galleryToken() : _epoch!;
    final sources = <GallerySource>[];
    if (await originals.exists()) {
      await for (final entity in originals.list(recursive: true)) {
        if (_closed) throw const GalleryCatalogFailure(GalleryErrorCode.unavailable);
        if (isGalleryStagingPath(entity.path)) continue;
        final relative = path.relative(entity.path, from: originals.absolute.path);
        final fingerprint = await _fingerprint(relative);
        if (fingerprint == null) continue;
        final extension = path.extension(relative).toLowerCase();
        final kind = entity is Directory
            ? GalleryEntryKind.directory
            : extension == '.gif'
            ? GalleryEntryKind.animatedImage
            : FileSettings.isImage(extension)
            ? GalleryEntryKind.image
            : FileSettings.isVideo(extension)
            ? GalleryEntryKind.video
            : GalleryEntryKind.unsupported;
        final entry = GalleryEntry(
          mediaId: _mediaId(relative),
          path: relative,
          name: path.basename(relative),
          kind: kind,
          sourceRevision: kind == GalleryEntryKind.directory ? null : _sourceRevision(epoch, fingerprint),
          thumbnailSupported:
              kind == GalleryEntryKind.image ||
              kind == GalleryEntryKind.animatedImage ||
              kind == GalleryEntryKind.video,
        );
        sources.add(GallerySource(entry, entity.absolute.path, fingerprint));
      }
    }
    sources.sort((a, b) => a.entry.path.compareTo(b.entry.path));
    if (_closed) throw const GalleryCatalogFailure(GalleryErrorCode.unavailable);
    if (forceInvalidate) {
      await _persistEpoch(epoch);
      _epoch = epoch;
    }
    if (_closed) throw const GalleryCatalogFailure(GalleryErrorCode.unavailable);
    final revision = _snapshotRevision(epoch, sources);
    final changed = _catalog?.catalogRevision != revision;
    _catalog = GalleryCatalog(
      catalogRevision: revision,
      capabilities: [
        GalleryCapability.thumbnails,
        GalleryCapability.revisionedOriginals,
        GalleryCapability.refresh,
        ...additionalCapabilities,
      ],
      thumbnailPolicy: thumbnailPolicy,
      entries: [for (final source in sources) source.entry],
    );
    _lastScan = DateTime.now();
    _entriesById = {for (final source in sources) source.entry.mediaId: source};
    _dirty = _events != eventAtStart;
    _log.fine(
      () =>
          'Gallery scan completed entries=${sources.length} '
          'revision=$revision changed=$changed '
          ' dirty=$_dirty',
    );
  }

  Future<void> _persistEpoch(String epoch) async {
    final temporary = File(path.join(stateDirectory.path, 'catalog-${galleryToken()}.tmp'));
    try {
      await stateDirectory.create(recursive: true);
      await temporary.writeAsString(epoch, flush: true);
      await temporary.rename(path.join(stateDirectory.path, 'catalog.epoch'));
      _log.fine('Gallery invalidation state persisted');
    } on Object catch (error) {
      _log.warning(
        'Gallery invalidation state write failed type=${error.runtimeType} '
        'osCode=${error is FileSystemException ? error.osError?.errorCode : null} ',
      );
      rethrow;
    } finally {
      if (await temporary.exists()) await temporary.delete();
    }
  }

  Future<void> close() async {
    _closed = true;
    await _watch?.cancel();
    await _operations;
  }
}
