// Asynchronous filesystem work keeps HTTP and RPC event loops responsive.
// ignore_for_file: avoid_slow_async_io
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:dslideshow_common/file_settings.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:path/path.dart' as path;

import 'catalog_state.dart';
import 'gallery_publication.dart';

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

/// Owns metadata in the web isolate; all writes/scans are serialized.
class GalleryCatalogService {
  final Directory originals;
  final Directory stateDirectory;
  final Duration scanMaxAge;
  final int maxPendingOperations;
  int _pendingOperations = 0;
  GalleryCatalogState? _state;
  GalleryCatalog? _catalog;
  Map<String, GalleryEntry> _entriesById = {};
  DateTime? _lastScan;
  Future<void> _operations = Future.value();
  StreamSubscription<FileSystemEvent>? _watch;
  bool _dirty = true;
  bool _closed = false;
  int _events = 0;
  String _publicationVersion = '';

  GalleryCatalogService({
    required this.originals,
    required this.stateDirectory,
    this.scanMaxAge = const Duration(seconds: 30),
    this.maxPendingOperations = 64,
  }) {
    if (maxPendingOperations < 1)
      throw ArgumentError.value(maxPendingOperations);
  }

  static const thumbnailPolicy = GalleryThumbnailPolicy(
    version: 1,
    sizes: [
      GalleryThumbnailSize.small,
      GalleryThumbnailSize.medium,
      GalleryThumbnailSize.large,
    ],
  );

  Future<T> _enqueue<T>(Future<T> Function() work) {
    if (_closed)
      return Future.error(
        const GalleryCatalogFailure(GalleryErrorCode.unavailable),
      );
    if (_pendingOperations >= maxPendingOperations) {
      return Future.error(const GalleryCatalogFailure(GalleryErrorCode.busy));
    }
    _pendingOperations++;
    final future = _operations
        .then((_) {
          if (_closed)
            throw const GalleryCatalogFailure(GalleryErrorCode.unavailable);
          return work();
        })
        .whenComplete(() {
          _pendingOperations--;
        });
    _operations = future.then<void>(
      (_) {},
      onError: (Object _, StackTrace __) {},
    );
    return future;
  }

  Future<GalleryCatalog> catalog() => _enqueue(() async {
    await _initialize();
    final publicationVersion = await GalleryPublication.version(stateDirectory);
    if (_catalog == null ||
        _dirty ||
        publicationVersion != _publicationVersion ||
        DateTime.now().difference(_lastScan!) >= scanMaxAge) {
      await _scan();
    }
    return _catalog!;
  });

  Future<GalleryCatalog> refresh(GalleryRefreshRequest request) =>
      _enqueue(() async {
        await _initialize();
        if (request.operationId.isEmpty || request.operationId.length > 100) {
          throw const GalleryCatalogFailure(GalleryErrorCode.invalidRequest);
        }
        if (_state!.completedOperations.contains(request.operationId)) {
          if (_catalog == null) await _scan();
          return _catalog!;
        }
        await _scan(
          forceInvalidate: request.mode == GalleryRefreshMode.forceInvalidate,
          operationId: request.operationId,
        );
        return _catalog!;
      });

  Future<GallerySource> resolve(String mediaId, {String? revision}) => _enqueue(
    () async {
      await _initialize();
      if (_catalog == null) await _scan();
      GalleryEntry? entry = _entriesById[mediaId];
      if (entry == null || entry.kind == GalleryEntryKind.directory) {
        throw const GalleryCatalogFailure(GalleryErrorCode.notFound);
      }
      final fingerprint = await _fingerprint(entry.path);
      if (fingerprint == null) {
        _dirty = true;
        throw const GalleryCatalogFailure(GalleryErrorCode.notFound);
      }
      final record = _state!.records[entry.path]!;
      if (fingerprint != record.fingerprint) {
        await _scan();
        final current = _state!.records[entry.path];
        if (current == null)
          throw const GalleryCatalogFailure(GalleryErrorCode.notFound);
        if (revision != null)
          throw const GalleryCatalogFailure(GalleryErrorCode.revisionMismatch);
        entry = _entriesById[current.id]!;
      }
      if (revision != null && revision != entry.sourceRevision) {
        throw const GalleryCatalogFailure(GalleryErrorCode.revisionMismatch);
      }
      return GallerySource(
        entry,
        path.join(originals.absolute.path, entry.path),
        _state!.records[entry.path]!.fingerprint,
      );
    },
  );

  Future<GallerySource> resolvePath(
    String relativePath, {
    required String revision,
  }) async {
    await catalog();
    final record = _state!.records[relativePath];
    if (record != null) return resolve(record.id, revision: revision);
    throw const GalleryCatalogFailure(GalleryErrorCode.notFound);
  }

  Future<bool> isCurrent(GallerySource source) async {
    try {
      final current = await resolve(
        source.entry.mediaId,
        revision: source.entry.sourceRevision,
      );
      return current.fingerprint == source.fingerprint;
    } on GalleryCatalogFailure catch (error) {
      if (error.code == GalleryErrorCode.notFound ||
          error.code == GalleryErrorCode.revisionMismatch)
        return false;
      rethrow;
    }
  }

  Future<void> _initialize() async {
    if (_state != null) return;
    try {
      _state = GalleryCatalogState.fromJson(
        jsonDecode(
          await File(path.join(stateDirectory.path, 'catalog.json'))
              .readAsString(),
        ) as Map<String, dynamic>,
      );
    } on Object {
      // Missing/corrupt metadata gets a new namespace; no old cache keys survive.
      _state = GalleryCatalogState(
        serverId: galleryToken(),
        epoch: galleryToken(),
        revision: galleryToken(),
        records: {},
      );
    }
    if (await originals.exists()) {
      try {
        _watch = originals.watch().listen(
          (_) {
            _dirty = true;
            _events++;
          },
          onError: (Object _) {
            _dirty = true;
            _events++;
          },
        );
      } on FileSystemException {
        /* explicit scan remains available */
      }
    }
  }

  Future<String?> _fingerprint(String relativePath) async {
    final file = File(path.join(originals.absolute.path, relativePath));
    final stat = await file.stat();
    if (stat.type == FileSystemEntityType.notFound) return null;
    final marker = GalleryPublication.markerFor(stateDirectory, relativePath);
    GalleryPublicationRecord? publication;
    try {
      publication = await GalleryPublication.current(marker);
    } on GalleryPublicationBusy {
      throw const GalleryCatalogFailure(GalleryErrorCode.unavailable);
    }
    return '${stat.type}:${stat.size}:${stat.modified.microsecondsSinceEpoch}:${stat.changed.microsecondsSinceEpoch}:${publication?.token ?? ''}';
  }

  Future<void> _scan({
    bool forceInvalidate = false,
    String? operationId,
  }) async {
    final eventAtStart = _events;
    final publicationAtStart = await GalleryPublication.version(stateDirectory);
    var sawPublication = false;
    final previous = _state!;
    final records = <String, GallerySourceRecord>{};
    if (await originals.exists()) {
      await for (final entity in originals.list(recursive: true)) {
        if (_closed)
          throw const GalleryCatalogFailure(GalleryErrorCode.unavailable);
        if (isGalleryStagingPath(entity.path)) continue;
        final relative = path.relative(
          entity.path,
          from: originals.absolute.path,
        );
        String? fingerprint;
        try {
          fingerprint = await _fingerprint(relative);
        } on GalleryCatalogFailure {
          sawPublication = true;
          // Preserve logical identity while an existing path is being published.
          // resolve/cache validation still rejects the active dirty source.
          final previousRecord = previous.records[relative];
          if (previousRecord != null) records[relative] = previousRecord;
          continue;
        }
        if (fingerprint == null) continue;
        final directory = entity is Directory;
        final old = previous.records[relative];
        records[relative] = GallerySourceRecord(
          id: old?.id ?? galleryToken(),
          generation: old != null && old.fingerprint == fingerprint
              ? old.generation
              : galleryToken(),
          fingerprint: fingerprint,
          directory: directory,
        );
      }
    }
    final changed =
        forceInvalidate ||
        records.length != previous.records.length ||
        records.entries.any(
          (item) =>
              previous.records[item.key]?.fingerprint != item.value.fingerprint,
        );
    final completed = [
      ...previous.completedOperations,
      if (operationId != null) operationId,
    ];
    final next = GalleryCatalogState(
      serverId: previous.serverId,
      epoch: forceInvalidate ? galleryToken() : previous.epoch,
      revision: changed ? galleryToken() : previous.revision,
      records: records,
      completedOperations: completed.length > 64
          ? completed.sublist(completed.length - 64)
          : completed,
    );
    await _persist(next);
    if (_closed)
      throw const GalleryCatalogFailure(GalleryErrorCode.unavailable);
    _state = next;
    final paths = records.keys.toList()..sort();
    _catalog = GalleryCatalog(
      serverId: next.serverId,
      catalogRevision: next.revision,
      capabilities: const [
        GalleryCapability.thumbnails,
        GalleryCapability.revisionedOriginals,
        GalleryCapability.refresh,
      ],
      thumbnailPolicy: thumbnailPolicy,
      entries: List.unmodifiable(
        paths.map((relative) {
          final record = records[relative]!;
          final extension = path.extension(relative).toLowerCase();
          final kind = record.directory
              ? GalleryEntryKind.directory
              : extension == '.gif'
              ? GalleryEntryKind.animatedImage
              : FileSettings.isImage(extension)
              ? GalleryEntryKind.image
              : FileSettings.isVideo(extension)
              ? GalleryEntryKind.video
              : GalleryEntryKind.unsupported;
          return GalleryEntry(
            mediaId: record.id,
            path: relative,
            name: path.basename(relative),
            kind: kind,
            sourceRevision: record.directory
                ? null
                : '${next.epoch}-${record.generation}',
            thumbnailSupported:
                kind == GalleryEntryKind.image ||
                kind == GalleryEntryKind.animatedImage,
          );
        }),
      ),
    );
    _lastScan = DateTime.now();
    _entriesById = {
      for (final entry in _catalog!.entries) entry.mediaId: entry,
    };
    _publicationVersion = await GalleryPublication.version(stateDirectory);
    _dirty =
        _events != eventAtStart ||
        sawPublication ||
        _publicationVersion != publicationAtStart;
  }

  Future<void> _persist(GalleryCatalogState state) async {
    await stateDirectory.create(recursive: true);
    final temporary = File(
      path.join(stateDirectory.path, 'catalog-${galleryToken()}.tmp'),
    );
    try {
      final encoded = await Isolate.run(() => jsonEncode(state.toJson()));
      await temporary.writeAsString(encoded, flush: true);
      await temporary.rename(path.join(stateDirectory.path, 'catalog.json'));
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
