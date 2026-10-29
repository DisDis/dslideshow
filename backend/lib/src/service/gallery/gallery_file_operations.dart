// Filesystem work is asynchronous except for source revision stat checks.
// ignore_for_file: avoid_slow_async_io
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dslideshow_common/file_settings.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;

import 'gallery_catalog_service.dart';
import 'gallery_files.dart';

enum _GalleryPathRejection {
  none,
  invalidCommand,
  invalidRelativePath,
  symlinkSegment,
  rootChanged,
  rootOverlap,
  wrongEntryType,
}

enum _GalleryAuxiliaryPhase { catalogRefreshFailed, trashIndexUpdateFailed }

/// Diagnostic classification only; messages never carry a filesystem path.
class _GalleryFileFailure extends GalleryCatalogFailure {
  const _GalleryFileFailure(super.code, this.reason);
  final _GalleryPathRejection reason;
}

/// Serializes mutations and indexes a plain mirrored trash directory in memory.
/// No request receipts, manifest, or per-file sidecars are stored in the trash.
class GalleryFileOperations {
  static final _log = Logger('GalleryFileOperations');
  final GalleryCatalogService catalog;
  final Directory trashDirectory;
  final int maxPendingOperations;
  final int maxItemsPerOperation;
  final int maxCatalogEntries;
  final int maxCatalogBytes;
  final Future<void> Function(GalleryOperationRequest)? beforeMutation;
  Future<void> _tail = Future.value();
  Future<void>? _closing;
  Map<String, GalleryTrashEntry>? _entriesById;
  Map<String, GalleryTrashEntry> _entriesByPath = {};
  String? _canonicalOriginalRoot;
  int _pending = 0;
  int _catalogBytes = 0;
  bool _closed = false;

  GalleryFileOperations({
    required this.catalog,
    Directory? trashDirectory,
    this.maxPendingOperations = 32,
    this.maxItemsPerOperation = 1000,
    this.maxCatalogEntries = 100000,
    this.maxCatalogBytes = 64 * 1024 * 1024,
    this.beforeMutation,
  }) : trashDirectory =
           trashDirectory ??
           Directory(path.join(catalog.stateDirectory.absolute.path, 'trash')) {
    if (maxPendingOperations < 1 ||
        maxItemsPerOperation < 1 ||
        maxCatalogEntries < 1 ||
        maxCatalogBytes < 1) {
      throw ArgumentError('Invalid gallery operation limits');
    }
    final originals = path.normalize(catalog.originals.absolute.path);
    final trash = path.normalize(this.trashDirectory.absolute.path);
    final state = path.normalize(catalog.stateDirectory.absolute.path);
    if (_overlaps(originals, trash) || _conflictsWithState(state, trash)) {
      throw ArgumentError(
        'Trash must be outside originals and other gallery state',
      );
    }
  }

  Future<T> withMediaLock<T>(Future<T> Function() work) {
    if (_closed) {
      return Future.error(
        const GalleryCatalogFailure(GalleryErrorCode.unavailable),
      );
    }
    if (_pending >= maxPendingOperations) {
      return Future.error(const GalleryCatalogFailure(GalleryErrorCode.busy));
    }
    _pending++;
    final result = _tail.then((_) => work()).whenComplete(() => _pending--);
    _tail = result.then<void>((_) {}, onError: (Object _, StackTrace __) {});
    return result;
  }

  /// An explicit catalogue read discovers external additions/removals. A preview
  /// resolves its cached ID directly and checks only the referenced file.
  Future<GalleryTrashCatalog> trashCatalog() => withMediaLock(() async {
    if (_entriesById == null) {
      await _initialize();
    } else {
      await _scanTrash();
    }
    final entries = _entriesById!.values.toList()
      ..sort((a, b) => b.trashedAt.compareTo(a.trashedAt));
    return GalleryTrashCatalog(entries: entries);
  });

  Future<File> resolveTrash(String trashId, {required String revision}) =>
      withMediaLock(() async {
        await _initialize();
        final entry = await _currentEntry(trashId, revision);
        return _trashFile(entry.originalPath);
      });

  Future<GalleryTrashEntry> resolveTrashEntry(
    String trashId, {
    required String revision,
  }) => withMediaLock(() async {
    await _initialize();
    return _currentEntry(trashId, revision);
  });

  Future<GalleryOperationResult> mutate(GalleryOperationRequest request) async {
    final clock = Stopwatch()..start();
    final operationId = _safeOperationId(request.operationId);
    final closedAtStart = _closed;
    final reasons = <_GalleryPathRejection, int>{};
    _log.log(
      _closed ? Level.FINE : Level.INFO,
      'Gallery mutation started operationId=$operationId '
      'action=${request.action.name} requested=${request.items.length} pending=$_pending',
    );
    try {
      final result = await withMediaLock(() async {
        _validateRequest(request);
        await _initialize();
        if (await catalog.originals.exists()) await _originalRootPath();
        // Operation IDs identify this command only. There is no persisted replay
        // result: every new call must pass the current duplicate/version guard.
        await beforeMutation?.call(request);
        final results = <GalleryOperationItemResult>[];
        for (var index = 0; index < request.items.length; index++) {
          final item = request.items[index];
          final itemClock = Stopwatch()..start();
          var rejection = _GalleryPathRejection.none;
          GalleryOperationItemResult itemResult;
          try {
            itemResult = switch (request.action) {
              GalleryMutation.trash => await _trash(item, operationId),
              GalleryMutation.restore => await _restore(item),
              GalleryMutation.purge => await _purge(item),
            };
          } on Object catch (error) {
            rejection = _rejection(error);
            if (rejection != _GalleryPathRejection.none) {
              reasons.update(
                rejection,
                (count) => count + 1,
                ifAbsent: () => 1,
              );
            }
            itemResult = GalleryOperationItemResult(
              mediaId: item.mediaId,
              state: GalleryItemOperationState.failed,
              error: _errorCode(error),
            );
          }
          results.add(itemResult);
          _log.fine(
            'Gallery mutation item completed operationId=$operationId '
            'action=${request.action.name} itemIndex=$index state=${itemResult.state.name} '
            'code=${itemResult.error?.name ?? 'none'} reason=${rejection.name} '
            'elapsedMs=${itemClock.elapsedMilliseconds}',
          );
        }
        if (request.action != GalleryMutation.purge) {
          try {
            await _refresh();
          } on Object catch (error) {
            _auxiliaryFailure(
              _GalleryAuxiliaryPhase.catalogRefreshFailed,
              request.action,
              operationId,
              error,
            );
          }
        }
        return GalleryOperationResult(
          operationId: request.operationId,
          items: results,
        );
      });
      final codes = <GalleryErrorCode, int>{};
      for (final item in result.items) {
        if (item.state == GalleryItemOperationState.failed) {
          codes.update(
            item.error ?? GalleryErrorCode.unknown,
            (count) => count + 1,
            ifAbsent: () => 1,
          );
        }
      }
      final failed = codes.values.fold(0, (total, count) => total + count);
      _log.log(
        failed == 0
            ? Level.INFO
            : codes.keys.every((code) => code == GalleryErrorCode.cancelled)
            ? Level.FINE
            : Level.WARNING,
        'Gallery mutation completed operationId=$operationId action=${request.action.name} '
        'requested=${request.items.length} succeeded=${result.items.length - failed} '
        'failed=$failed codes=${codes.entries.map((e) => '${e.key.name}:${e.value}').join(',')} '
        'reasons=${reasons.entries.map((e) => '${e.key.name}:${e.value}').join(',')} '
        'elapsedMs=${clock.elapsedMilliseconds}',
      );
      return result;
    } on Object catch (error) {
      final code = _errorCode(error);
      final expectedStop =
          code == GalleryErrorCode.cancelled ||
          (closedAtStart && code == GalleryErrorCode.unavailable);
      _log.log(
        expectedStop ? Level.FINE : Level.WARNING,
        'Gallery mutation ${expectedStop ? 'cancelled' : 'failed'} '
        'operationId=$operationId action=${request.action.name} requested=${request.items.length} '
        'code=${code.name} type=${error.runtimeType} reason=${_rejection(error).name} '
        'elapsedMs=${clock.elapsedMilliseconds}',
      );
      rethrow;
    }
  }

  void _validateRequest(GalleryOperationRequest request) {
    if (request.operationId.isEmpty ||
        request.operationId.length > 100 ||
        request.items.isEmpty ||
        request.items.length > maxItemsPerOperation ||
        request.items.map((item) => item.mediaId).toSet().length !=
            request.items.length ||
        request.items.any(
          (item) => item.mediaId.isEmpty || item.sourceRevision.isEmpty,
        )) {
      throw const _GalleryFileFailure(
        GalleryErrorCode.invalidRequest,
        _GalleryPathRejection.invalidCommand,
      );
    }
  }

  Future<void> _initialize() async {
    if (_entriesById != null) return;
    await _assertNoLinks(trashDirectory.absolute.path, allowMissing: true);
    await trashDirectory.create(recursive: true);
    await _assertNoLinks(trashDirectory.absolute.path);
    if (await catalog.stateDirectory.exists() &&
        _conflictsWithState(
          path.normalize(await catalog.stateDirectory.resolveSymbolicLinks()),
          path.normalize(await trashDirectory.resolveSymbolicLinks()),
        )) {
      throw const _GalleryFileFailure(
        GalleryErrorCode.invalidRequest,
        _GalleryPathRejection.rootOverlap,
      );
    }
    if (await catalog.originals.exists()) await _originalRootPath();
    await _scanTrash();
  }

  Future<void> _scanTrash() async {
    final clock = Stopwatch()..start();
    await _assertNoLinks(trashDirectory.absolute.path);
    final byId = <String, GalleryTrashEntry>{};
    final byPath = <String, GalleryTrashEntry>{};
    var bytes = _emptyCatalogBytes();
    if (bytes > maxCatalogBytes) {
      throw const GalleryCatalogFailure(GalleryErrorCode.outputLimitExceeded);
    }
    await for (final entity in trashDirectory.list(
      recursive: true,
      followLinks: false,
    )) {
      if (entity is! File ||
          !FileSettings.isSupportFile(path.extension(entity.path)))
        continue;
      final relative = path.relative(
        entity.absolute.path,
        from: trashDirectory.absolute.path,
      );
      try {
        final file = await _trashFile(relative);
        final entry = _entry(relative, await file.stat());
        bytes += _entryBytes(entry) + (byId.isEmpty ? 0 : 1);
        if (byId.length >= maxCatalogEntries || bytes > maxCatalogBytes) {
          throw const GalleryCatalogFailure(
            GalleryErrorCode.outputLimitExceeded,
          );
        }
        byId[entry.trashId] = entry;
        byPath[relative] = entry;
      } on FileSystemException catch (error) {
        if (error.osError?.errorCode != 2) rethrow;
      } on GalleryCatalogFailure catch (error) {
        if (error.code != GalleryErrorCode.notFound) rethrow;
      }
    }
    _entriesById = byId;
    _entriesByPath = byPath;
    _catalogBytes = bytes;
    _log.fine(
      'Gallery trash catalog scanned entries=${byId.length} '
      'elapsedMs=${clock.elapsedMilliseconds}',
    );
  }

  Future<GalleryTrashEntry> _currentEntry(String id, String revision) async {
    final entry = _entriesById![id];
    if (entry == null)
      throw const GalleryCatalogFailure(GalleryErrorCode.notFound);
    if (entry.sourceRevision != revision) {
      throw const GalleryCatalogFailure(GalleryErrorCode.revisionMismatch);
    }
    final file = await _trashFile(entry.originalPath);
    if (_revision(await file.stat()) != revision) {
      throw const GalleryCatalogFailure(GalleryErrorCode.revisionMismatch);
    }
    return entry;
  }

  Future<GalleryOperationItemResult> _trash(
    GalleryMediaRef item,
    String operationId,
  ) async {
    final source = await catalog.resolve(
      item.mediaId,
      revision: item.sourceRevision,
    );
    if (source.entry.kind == GalleryEntryKind.directory ||
        !FileSettings.isSupportFile(path.extension(source.entry.path))) {
      throw const GalleryCatalogFailure(GalleryErrorCode.unsupported);
    }
    final original = await _originalFile(source.entry.path);
    final before = await original.stat();
    final destination = await _trashFile(source.entry.path, allowMissing: true);
    if (await FileSystemEntity.type(destination.path, followLinks: false) !=
        FileSystemEntityType.notFound) {
      throw const GalleryCatalogFailure(GalleryErrorCode.conflict);
    }
    _admit(_entry(source.entry.path, before));
    await _ensureParent(destination, trashDirectory.absolute.path);
    if (!await catalog.isCurrent(source)) {
      throw const GalleryCatalogFailure(GalleryErrorCode.revisionMismatch);
    }
    await _originalFile(source.entry.path);
    await _trashFile(source.entry.path, allowMissing: true);
    _assertStat(original, before);
    if (await FileSystemEntity.type(destination.path, followLinks: false) !=
        FileSystemEntityType.notFound) {
      throw const GalleryCatalogFailure(GalleryErrorCode.conflict);
    }
    await original.rename(destination.path);
    catalog.markDirty();
    GalleryTrashEntry? entry;
    try {
      entry = _entry(source.entry.path, await destination.stat());
      _putEntry(entry);
    } on Object catch (error) {
      // The atomic move committed. If its new stat cannot be observed, an
      // explicit trash refresh will discover the entry; do not claim failure
      // or manufacture a revision/Undo ID from its old filesystem metadata.
      _auxiliaryFailure(
        _GalleryAuxiliaryPhase.trashIndexUpdateFailed,
        GalleryMutation.trash,
        operationId,
        error,
      );
    }
    return GalleryOperationItemResult(
      mediaId: item.mediaId,
      state: GalleryItemOperationState.succeeded,
      trashId: entry?.trashId,
    );
  }

  Future<GalleryOperationItemResult> _restore(GalleryMediaRef item) async {
    final entry = await _currentEntry(item.mediaId, item.sourceRevision);
    final source = await _trashFile(entry.originalPath);
    var relative = entry.originalPath;
    for (var attempt = 0; attempt <= 1000; attempt++) {
      if (attempt > 0) relative = _restoredName(entry.originalPath, attempt);
      final target = await _originalFile(
        relative,
        allowMissing: true,
        allowDirectory: true,
      );
      if (await FileSystemEntity.type(target.path, followLinks: false) !=
          FileSystemEntityType.notFound)
        continue;
      await _ensureParent(target, await _originalRootPath());
      await _currentEntry(item.mediaId, item.sourceRevision);
      await _originalFile(relative, allowMissing: true, allowDirectory: true);
      if (await FileSystemEntity.type(target.path, followLinks: false) !=
          FileSystemEntityType.notFound) {
        continue;
      }
      await source.rename(target.path);
      catalog.markDirty();
      _removeEntry(entry);
      return GalleryOperationItemResult(
        mediaId: item.mediaId,
        state: GalleryItemOperationState.succeeded,
        restoredPath: relative,
      );
    }
    throw const GalleryCatalogFailure(GalleryErrorCode.busy);
  }

  Future<GalleryOperationItemResult> _purge(GalleryMediaRef item) async {
    final entry = await _currentEntry(item.mediaId, item.sourceRevision);
    final file = await _trashFile(entry.originalPath);
    await _currentEntry(item.mediaId, item.sourceRevision);
    await file.delete();
    _removeEntry(entry);
    return GalleryOperationItemResult(
      mediaId: item.mediaId,
      state: GalleryItemOperationState.succeeded,
    );
  }

  static void _auxiliaryFailure(
    _GalleryAuxiliaryPhase phase,
    GalleryMutation action,
    String operationId,
    Object error,
  ) {
    _log.warning(
      'Gallery mutation auxiliary update failed operationId=$operationId '
      'action=${action.name} phase=${phase.name} code=${_errorCode(error).name} '
      'type=${error.runtimeType}',
    );
  }

  void _admit(GalleryTrashEntry entry) {
    final old = _entriesByPath[entry.originalPath];
    final count = _entriesById!.length + (old == null ? 1 : 0);
    final bytes =
        _catalogBytes +
        _entryBytes(entry) -
        (old == null ? 0 : _entryBytes(old)) +
        128;
    if (count > maxCatalogEntries || bytes > maxCatalogBytes) {
      throw const GalleryCatalogFailure(GalleryErrorCode.outputLimitExceeded);
    }
  }

  void _putEntry(GalleryTrashEntry entry) {
    final old = _entriesByPath[entry.originalPath];
    if (old != null) _removeEntry(old);
    if (_entriesById!.isNotEmpty) _catalogBytes++;
    _catalogBytes += _entryBytes(entry);
    _entriesById![entry.trashId] = entry;
    _entriesByPath[entry.originalPath] = entry;
  }

  void _removeEntry(GalleryTrashEntry entry) {
    if (_entriesById!.remove(entry.trashId) == null) return;
    _entriesByPath.remove(entry.originalPath);
    _catalogBytes -= _entryBytes(entry) + (_entriesById!.isEmpty ? 0 : 1);
  }

  static int _emptyCatalogBytes() => utf8
      .encode(jsonEncode(const GalleryTrashCatalog(entries: []).toJson()))
      .length;
  static int _entryBytes(GalleryTrashEntry entry) =>
      utf8.encode(jsonEncode(entry.toJson())).length;
  static String _revision(FileStat stat) => sha256
      .convert(
        utf8.encode(
          '${stat.size}:${stat.modified.microsecondsSinceEpoch}:${stat.changed.microsecondsSinceEpoch}',
        ),
      )
      .toString();
  static GalleryTrashEntry _entry(String relative, FileStat stat) {
    if (stat.type != FileSystemEntityType.file) {
      throw const GalleryCatalogFailure(GalleryErrorCode.notFound);
    }
    final revision = _revision(stat);
    final extension = path.extension(relative).toLowerCase();
    return GalleryTrashEntry(
      trashId: sha256
          .convert(utf8.encode(jsonEncode([relative, revision])))
          .toString(),
      name: path.basename(relative),
      originalPath: relative,
      kind: extension == '.gif'
          ? GalleryEntryKind.animatedImage
          : FileSettings.isVideo(extension)
          ? GalleryEntryKind.video
          : GalleryEntryKind.image,
      sourceRevision: revision,
      trashedAt: stat.changed.toUtc(),
      sizeBytes: stat.size,
    );
  }

  Future<File> _trashFile(String relative, {bool allowMissing = false}) async {
    return _checkedFile(
      trashDirectory.absolute.path,
      relative,
      allowMissing: allowMissing,
      allowDirectory: allowMissing,
    );
  }

  Future<File> _originalFile(
    String relative, {
    bool allowMissing = false,
    bool allowDirectory = false,
  }) async {
    return _checkedFile(
      await _originalRootPath(),
      relative,
      allowMissing: allowMissing,
      allowDirectory: allowDirectory,
    );
  }

  static Future<File> _checkedFile(
    String root,
    String relative, {
    bool allowMissing = false,
    bool allowDirectory = false,
  }) async {
    if (relative.isEmpty ||
        path.isAbsolute(relative) ||
        path.split(relative).any((part) => part == '..' || part == '.') ||
        path.normalize(relative) != relative) {
      throw const _GalleryFileFailure(
        GalleryErrorCode.invalidRequest,
        _GalleryPathRejection.invalidRelativePath,
      );
    }
    final file = File(path.join(root, relative));
    if (!path.isWithin(root, file.path)) {
      throw const _GalleryFileFailure(
        GalleryErrorCode.invalidRequest,
        _GalleryPathRejection.invalidRelativePath,
      );
    }
    await _assertNoLinks(file.path, allowMissing: allowMissing);
    final type = await FileSystemEntity.type(file.path, followLinks: false);
    if (allowMissing && type == FileSystemEntityType.notFound) return file;
    if (allowDirectory && type == FileSystemEntityType.directory) return file;
    if (type != FileSystemEntityType.file) {
      throw GalleryCatalogFailure(
        type == FileSystemEntityType.directory
            ? GalleryErrorCode.unsupported
            : GalleryErrorCode.notFound,
      );
    }
    return file;
  }

  static Future<void> _ensureParent(File target, String root) async {
    await _assertNoLinks(root);
    var current = root;
    final relative = path.relative(target.parent.path, from: root);
    if (relative == '.') return;
    for (final part in path.split(relative)) {
      current = path.join(current, part);
      final type = await FileSystemEntity.type(current, followLinks: false);
      if (type == FileSystemEntityType.notFound) {
        await Directory(current).create();
      } else if (type != FileSystemEntityType.directory) {
        throw const _GalleryFileFailure(
          GalleryErrorCode.invalidRequest,
          _GalleryPathRejection.wrongEntryType,
        );
      }
      await _assertNoLinks(current);
    }
  }

  static void _assertStat(File file, FileStat before) {
    final now = file.statSync();
    if (FileSystemEntity.typeSync(file.path, followLinks: false) !=
            FileSystemEntityType.file ||
        now.type != FileSystemEntityType.file ||
        now.size != before.size ||
        now.modified != before.modified ||
        now.changed != before.changed) {
      throw const GalleryCatalogFailure(GalleryErrorCode.revisionMismatch);
    }
  }

  Future<String> _originalRootPath() async {
    final resolved = path.normalize(
      await catalog.originals.resolveSymbolicLinks(),
    );
    final pinned = _canonicalOriginalRoot;
    if (pinned != null && pinned != resolved) {
      throw const _GalleryFileFailure(
        GalleryErrorCode.revisionMismatch,
        _GalleryPathRejection.rootChanged,
      );
    }
    if (pinned == null) {
      await _assertNoLinks(resolved);
      if (await FileSystemEntity.type(resolved, followLinks: false) !=
          FileSystemEntityType.directory) {
        throw const _GalleryFileFailure(
          GalleryErrorCode.unsupported,
          _GalleryPathRejection.wrongEntryType,
        );
      }
      final trash = path.normalize(await trashDirectory.resolveSymbolicLinks());
      if (_overlaps(trash, resolved)) {
        throw const _GalleryFileFailure(
          GalleryErrorCode.invalidRequest,
          _GalleryPathRejection.rootOverlap,
        );
      }
      _canonicalOriginalRoot = resolved;
      _log.fine(
        'Gallery original root bound '
        'aliased=${path.normalize(catalog.originals.absolute.path) != resolved}',
      );
    }
    return resolved;
  }

  static bool _overlaps(String a, String b) =>
      a == b || path.isWithin(a, b) || path.isWithin(b, a);

  static bool _conflictsWithState(String state, String trash) =>
      _overlaps(state, trash) && trash != path.join(state, 'trash');

  static Future<void> _assertNoLinks(
    String absolute, {
    bool allowMissing = false,
  }) async {
    var current = path.rootPrefix(absolute);
    for (final part in path.split(absolute).skip(1)) {
      current = path.join(current, part);
      final type = await FileSystemEntity.type(current, followLinks: false);
      if (type == FileSystemEntityType.link) {
        throw const _GalleryFileFailure(
          GalleryErrorCode.invalidRequest,
          _GalleryPathRejection.symlinkSegment,
        );
      }
      if (type == FileSystemEntityType.notFound) {
        if (allowMissing) return;
        throw const GalleryCatalogFailure(GalleryErrorCode.notFound);
      }
    }
  }

  static String _restoredName(String original, int attempt) => path.normalize(
    path.join(
      path.dirname(original),
      '${path.basenameWithoutExtension(original)} (restored $attempt)${path.extension(original)}',
    ),
  );

  static GalleryErrorCode _errorCode(Object error) {
    if (error is GalleryCatalogFailure) return error.code;
    if (error is FileSystemException) {
      if (error.osError?.errorCode == 18) return GalleryErrorCode.unsupported;
      if (error.osError?.errorCode == 17) return GalleryErrorCode.conflict;
      if (error.osError?.errorCode == 13) return GalleryErrorCode.forbidden;
    }
    return GalleryErrorCode.unavailable;
  }

  static _GalleryPathRejection _rejection(Object error) =>
      error is _GalleryFileFailure ? error.reason : _GalleryPathRejection.none;
  static String _safeOperationId(String value) => value.isEmpty
      ? 'none'
      : 'id-${sha256.convert(utf8.encode(value)).toString().substring(0, 12)}';

  Future<void> _refresh() => catalog
      .refresh(
        GalleryRefreshRequest(
          operationId: 'files-${galleryToken()}',
          mode: GalleryRefreshMode.scan,
        ),
      )
      .then((_) {});

  Future<void> close() => _closing ??= () async {
    final clock = Stopwatch()..start();
    final pendingAtClose = _pending;
    _closed = true;
    await _tail;
    _log.info(
      'Gallery file operations closed pendingAtClose=$pendingAtClose '
      'elapsedMs=${clock.elapsedMilliseconds}',
    );
  }();
}
