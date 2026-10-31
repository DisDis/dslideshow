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

enum _GalleryAuxiliaryPhase { catalogRefreshFailed, mirrorIndexUpdateFailed }

/// Diagnostic classification only; messages never carry a filesystem path.
class _GalleryFileFailure extends GalleryCatalogFailure {
  const _GalleryFileFailure(super.code, this.reason);
  final _GalleryPathRejection reason;
}

class _GalleryMirrorIndex {
  final Directory directory;
  final GalleryMediaSection section;
  Map<String, GalleryEntry>? entriesById;
  Map<String, GalleryEntry> entriesByPath = {};
  int catalogBytes = 0;

  _GalleryMirrorIndex(this.directory, this.section);
}

/// Serializes media mutations and owns the in-memory indices of mirrored sections.
/// No request receipts, manifest, or per-file sidecars are stored beside media.
class GalleryFileOperations {
  static final _log = Logger('GalleryFileOperations');
  final GalleryCatalogService catalog;
  final Map<GalleryMediaSection, _GalleryMirrorIndex> _indexes;
  final int maxPendingOperations;
  final int maxItemsPerOperation;
  final int maxCatalogEntries;
  final int maxCatalogBytes;
  Future<void> _tail = Future.value();
  Future<void>? _closing;
  String? _canonicalOriginalRoot;
  int _pending = 0;
  bool _closed = false;

  GalleryFileOperations({
    required this.catalog,
    Directory? trashDirectory,
    Directory? hiddenDirectory,
    this.maxPendingOperations = 32,
    this.maxItemsPerOperation = 1000,
    this.maxCatalogEntries = 100000,
    this.maxCatalogBytes = 64 * 1024 * 1024,
  }) : _indexes = {
         GalleryMediaSection.trash: _GalleryMirrorIndex(
           trashDirectory ?? Directory(path.join(catalog.stateDirectory.absolute.path, GalleryMediaSection.trash.name)),
           GalleryMediaSection.trash,
         ),
         GalleryMediaSection.hidden: _GalleryMirrorIndex(
           hiddenDirectory ??
               Directory(path.join(catalog.stateDirectory.absolute.path, GalleryMediaSection.hidden.name)),
           GalleryMediaSection.hidden,
         ),
       } {
    if (maxPendingOperations < 1 || maxItemsPerOperation < 1 || maxCatalogEntries < 1 || maxCatalogBytes < 1) {
      throw ArgumentError('Invalid gallery operation limits');
    }
    final state = path.normalize(catalog.stateDirectory.absolute.path);
    final roots = [for (final section in GalleryMediaSection.values) path.normalize(directory(section).absolute.path)];
    for (var first = 0; first < roots.length; first++) {
      for (var second = first + 1; second < roots.length; second++) {
        if (_overlaps(roots[first], roots[second])) {
          throw ArgumentError('Managed section directories must not overlap');
        }
      }
    }
    for (final index in _indexes.values) {
      if (_conflictsWithState(state, path.normalize(index.directory.absolute.path), index.section)) {
        throw ArgumentError('Managed section directories must be outside other gallery state');
      }
    }
  }

  Directory directory(GalleryMediaSection section) =>
      section == GalleryMediaSection.published ? catalog.originals : _index(section).directory;

  Future<T> withMediaLock<T>(Future<T> Function() work) {
    if (_closed) {
      return Future.error(const GalleryCatalogFailure(GalleryErrorCode.unavailable));
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
  Future<GalleryCatalog> mediaCatalog(GalleryMediaSection section) {
    if (section == GalleryMediaSection.published) return catalog.catalog();
    return withMediaLock(() async {
      final index = _index(section);
      if (index.entriesById == null) {
        await _initialize(section);
      } else {
        await _scanMirror(index);
      }
      final entries = index.entriesById!.values.toList()
        ..sort(
          section == GalleryMediaSection.trash
              ? (a, b) => b.fileChanged!.compareTo(a.fileChanged!)
              : (a, b) => a.path.compareTo(b.path),
        );
      return GalleryCatalog(
        section: section,
        catalogRevision: sha256
            .convert(utf8.encode(jsonEncode([for (final entry in entries) entry.ref.toJson()])))
            .toString(),
        capabilities: catalog.capabilities,
        thumbnailPolicy: catalog.thumbnailPolicy,
        entries: entries,
      );
    });
  }

  Future<GalleryCatalog> refreshMediaCatalog(GalleryMediaSection section, GalleryRefreshRequest request) {
    if (section == GalleryMediaSection.published) return catalog.refresh(request);
    if (request.mode != GalleryRefreshMode.scan) {
      return Future.error(const GalleryCatalogFailure(GalleryErrorCode.unsupported));
    }
    return mediaCatalog(section);
  }

  /// Resolves one indexed reference and verifies its current file and revision.
  Future<GallerySource> resolveMedia(GalleryMediaRef ref) => withMediaLock(() async {
    try {
      return await _resolveMedia(ref);
    } on _GalleryFileFailure catch (error) {
      if (ref.section == GalleryMediaSection.published && error.reason == _GalleryPathRejection.symlinkSegment) {
        throw const GalleryCatalogFailure(GalleryErrorCode.forbidden);
      }
      rethrow;
    }
  });

  Future<GallerySource> _resolveMedia(GalleryMediaRef ref) async {
    if (ref.mediaId.isEmpty || ref.sourceRevision.isEmpty) {
      throw const GalleryCatalogFailure(GalleryErrorCode.invalidRequest);
    }
    if (ref.section == GalleryMediaSection.published) {
      final source = await catalog.resolve(ref.mediaId, revision: ref.sourceRevision);
      if (source.entry.kind == GalleryEntryKind.directory) {
        throw const GalleryCatalogFailure(GalleryErrorCode.unsupported);
      }
      final file = await _file(ref.section, source.entry.path);
      return GallerySource(source.entry, file.path, source.fingerprint);
    }
    final entry = await _currentEntry(ref);
    final file = await _file(ref.section, entry.path);
    return GallerySource(entry, file.path, entry.sourceRevision);
  }

  Future<File> mediaFile(GalleryMediaRef ref) async => (await resolveMedia(ref)).file;

  Future<bool> isCurrent(GallerySource source) async {
    try {
      await resolveMedia(source.entry.ref);
      return true;
    } on GalleryCatalogFailure {
      return false;
    }
  }

  _GalleryMirrorIndex _index(GalleryMediaSection section) =>
      _indexes[section] ?? (throw const GalleryCatalogFailure(GalleryErrorCode.invalidRequest));

  Future<GalleryOperationResult> mutate(GalleryOperationRequest request) async {
    final closedAtStart = _closed;
    final reasons = <_GalleryPathRejection, int>{};
    _log.log(
      _closed ? Level.FINE : Level.INFO,
      'Gallery mutation started '
      'action=${request.action.name} requested=${request.items.length} pending=$_pending',
    );
    try {
      final result = await withMediaLock(() async {
        _validateRequest(request);
        if (await catalog.originals.exists()) await _originalRootPath();
        // Every command checks the current filesystem revisions independently of duplicate searches.
        final results = <GalleryOperationItemResult>[];
        for (var index = 0; index < request.items.length; index++) {
          final item = request.items[index];
          var rejection = _GalleryPathRejection.none;
          GalleryOperationItemResult itemResult;
          try {
            final allowed = switch (request.action) {
              GalleryMutation.trash => item.section != GalleryMediaSection.trash,
              GalleryMutation.hide => item.section == GalleryMediaSection.published,
              GalleryMutation.unhide => item.section == GalleryMediaSection.hidden,
              GalleryMutation.restore || GalleryMutation.purge => item.section == GalleryMediaSection.trash,
            };
            if (!allowed) throw const GalleryCatalogFailure(GalleryErrorCode.invalidRequest);
            itemResult = switch (request.action) {
              GalleryMutation.trash => await _move(item, GalleryMediaSection.trash, request.action),
              GalleryMutation.restore ||
              GalleryMutation.unhide => await _move(item, GalleryMediaSection.published, request.action),
              GalleryMutation.purge => await _purge(item),
              GalleryMutation.hide => await _move(item, GalleryMediaSection.hidden, request.action),
            };
          } on Object catch (error) {
            rejection = _rejection(error);
            if (rejection != _GalleryPathRejection.none) {
              reasons.update(rejection, (count) => count + 1, ifAbsent: () => 1);
            }
            itemResult = GalleryOperationItemResult(
              mediaId: item.mediaId,
              section: item.section,
              state: GalleryItemOperationState.failed,
              error: _errorCode(error),
            );
            _log.fine(
              'Gallery mutation item failed action=${request.action.name} section=${item.section.name} '
              'code=${itemResult.error!.name} type=${error.runtimeType} reason=${rejection.name}',
            );
          }
          results.add(itemResult);
          _log.fine(
            'Gallery mutation item completed '
            'action=${request.action.name} itemIndex=$index state=${itemResult.state.name} '
            'code=${itemResult.error?.name ?? 'none'} reason=${rejection.name} ',
          );
        }
        if (request.action != GalleryMutation.purge) {
          try {
            await _refresh();
          } on Object catch (error) {
            _auxiliaryFailure(_GalleryAuxiliaryPhase.catalogRefreshFailed, request.action, error);
          }
        }
        return GalleryOperationResult(operationId: request.operationId, items: results);
      });
      final codes = <GalleryErrorCode, int>{};
      for (final item in result.items) {
        if (item.state == GalleryItemOperationState.failed) {
          codes.update(item.error ?? GalleryErrorCode.unknown, (count) => count + 1, ifAbsent: () => 1);
        }
      }
      final failed = codes.values.fold(0, (total, count) => total + count);
      _log.log(
        failed == 0
            ? Level.INFO
            : codes.keys.every((code) => code == GalleryErrorCode.cancelled)
            ? Level.FINE
            : Level.WARNING,
        'Gallery mutation completed action=${request.action.name} '
        'requested=${request.items.length} succeeded=${result.items.length - failed} '
        'failed=$failed codes=${codes.entries.map((e) => '${e.key.name}:${e.value}').join(',')} '
        'reasons=${reasons.entries.map((e) => '${e.key.name}:${e.value}').join(',')}',
      );
      return result;
    } on Object catch (error) {
      final code = _errorCode(error);
      final expectedStop =
          code == GalleryErrorCode.cancelled || (closedAtStart && code == GalleryErrorCode.unavailable);
      _log.log(
        expectedStop ? Level.FINE : Level.WARNING,
        'Gallery mutation ${expectedStop ? 'cancelled' : 'failed'} '
        'action=${request.action.name} requested=${request.items.length} '
        'code=${code.name} type=${error.runtimeType} reason=${_rejection(error).name} ',
      );
      rethrow;
    }
  }

  void _validateRequest(GalleryOperationRequest request) {
    if (request.operationId.isEmpty ||
        request.operationId.length > 100 ||
        request.items.isEmpty ||
        request.items.length > maxItemsPerOperation ||
        request.items.map((item) => (item.section, item.mediaId)).toSet().length != request.items.length ||
        request.items.any((item) => item.mediaId.isEmpty || item.sourceRevision.isEmpty)) {
      throw const _GalleryFileFailure(GalleryErrorCode.invalidRequest, _GalleryPathRejection.invalidCommand);
    }
  }

  Future<void> _initialize(GalleryMediaSection section) async {
    final index = _index(section);
    if (index.entriesById != null) return;
    await _assertNoLinks(index.directory.absolute.path, allowMissing: true);
    await index.directory.create(recursive: true);
    await _assertNoLinks(index.directory.absolute.path);
    if (await catalog.stateDirectory.exists() &&
        _conflictsWithState(
          path.normalize(await catalog.stateDirectory.resolveSymbolicLinks()),
          path.normalize(await index.directory.resolveSymbolicLinks()),
          section,
        )) {
      throw const _GalleryFileFailure(GalleryErrorCode.invalidRequest, _GalleryPathRejection.rootOverlap);
    }
    if (await catalog.originals.exists()) await _originalRootPath();
    await _scanMirror(index);
  }

  Future<void> _scanMirror(_GalleryMirrorIndex index) async {
    await _assertNoLinks(index.directory.absolute.path);
    final byId = <String, GalleryEntry>{};
    final byPath = <String, GalleryEntry>{};
    var bytes = _emptyCatalogBytes(index);
    if (bytes > maxCatalogBytes) {
      throw const GalleryCatalogFailure(GalleryErrorCode.outputLimitExceeded);
    }
    await for (final entity in index.directory.list(recursive: true, followLinks: false)) {
      if (entity is! File || !FileSettings.isSupportFile(path.extension(entity.path))) continue;
      final relative = path.relative(entity.absolute.path, from: index.directory.absolute.path);
      try {
        final file = await _file(index.section, relative);
        final entry = mirrorEntry(index.section, relative, await file.stat());
        bytes += _entryBytes(entry) + (byId.isEmpty ? 0 : 1);
        if (byId.length >= maxCatalogEntries || bytes > maxCatalogBytes) {
          throw const GalleryCatalogFailure(GalleryErrorCode.outputLimitExceeded);
        }
        byId[entry.mediaId] = entry;
        byPath[relative] = entry;
      } on FileSystemException catch (error) {
        if (error.osError?.errorCode != 2) rethrow;
      } on GalleryCatalogFailure catch (error) {
        if (error.code != GalleryErrorCode.notFound) rethrow;
      }
    }
    index.entriesById = byId;
    index.entriesByPath = byPath;
    index.catalogBytes = bytes;
    _log.fine('Gallery ${index.section.name} catalog scanned entries=${byId.length} ');
  }

  Future<GalleryEntry> _currentEntry(GalleryMediaRef ref) async {
    await _initialize(ref.section);
    final index = _index(ref.section);
    final entry = index.entriesById![ref.mediaId];
    if (entry == null) throw const GalleryCatalogFailure(GalleryErrorCode.notFound);
    if (entry.sourceRevision != ref.sourceRevision) {
      throw const GalleryCatalogFailure(GalleryErrorCode.revisionMismatch);
    }
    final file = await _file(ref.section, entry.path);
    if (_revision(await file.stat()) != ref.sourceRevision) {
      throw const GalleryCatalogFailure(GalleryErrorCode.revisionMismatch);
    }
    return entry;
  }

  Future<GalleryOperationItemResult> _move(
    GalleryMediaRef item,
    GalleryMediaSection targetSection,
    GalleryMutation action,
  ) async {
    final source = await _resolveMedia(item);
    if (!FileSettings.isSupportFile(path.extension(source.entry.path))) {
      throw const GalleryCatalogFailure(GalleryErrorCode.unsupported);
    }
    if (targetSection != GalleryMediaSection.published) await _initialize(targetSection);
    final before = await source.file.stat();
    final maxAttempts = targetSection == GalleryMediaSection.published ? 1000 : 0;
    for (var attempt = 0; attempt <= maxAttempts; attempt++) {
      final relative = attempt == 0 ? source.entry.path : _restoredName(source.entry.path, attempt);
      final target = await _file(targetSection, relative, allowMissing: true, allowDirectory: true);
      if (await FileSystemEntity.type(target.path, followLinks: false) != FileSystemEntityType.notFound) {
        if (targetSection != GalleryMediaSection.published) {
          throw const GalleryCatalogFailure(GalleryErrorCode.conflict);
        }
        continue;
      }
      if (targetSection != GalleryMediaSection.published) {
        _admit(mirrorEntry(targetSection, relative, before));
      }
      await _ensureParent(target, await _rootPath(targetSection));
      await _resolveMedia(item);
      await _file(targetSection, relative, allowMissing: true, allowDirectory: true);
      _assertStat(source.file, before);
      if (await FileSystemEntity.type(target.path, followLinks: false) != FileSystemEntityType.notFound) {
        if (targetSection != GalleryMediaSection.published) {
          throw const GalleryCatalogFailure(GalleryErrorCode.conflict);
        }
        continue;
      }
      await source.file.rename(target.path);
      catalog.markDirty();
      _removeEntry(source.entry);
      GalleryEntry? destination;
      if (targetSection != GalleryMediaSection.published) {
        try {
          destination = mirrorEntry(targetSection, relative, await target.stat());
          _putEntry(destination);
        } on Object catch (error) {
          // The move committed; a catalog scan can discover its new identity.
          // Do not claim failure or build an Undo reference from the old stat.
          _auxiliaryFailure(_GalleryAuxiliaryPhase.mirrorIndexUpdateFailed, action, error);
        }
      }
      return GalleryOperationItemResult(
        mediaId: item.mediaId,
        section: item.section,
        state: GalleryItemOperationState.succeeded,
        destination: destination?.ref,
        restoredPath: targetSection == GalleryMediaSection.published ? relative : null,
      );
    }
    throw const GalleryCatalogFailure(GalleryErrorCode.busy);
  }

  Future<GalleryOperationItemResult> _purge(GalleryMediaRef item) async {
    final source = await _resolveMedia(item);
    await _resolveMedia(item);
    await source.file.delete();
    _removeEntry(source.entry);
    return GalleryOperationItemResult(
      mediaId: item.mediaId,
      section: item.section,
      state: GalleryItemOperationState.succeeded,
    );
  }

  static void _auxiliaryFailure(_GalleryAuxiliaryPhase phase, GalleryMutation action, Object error) {
    _log.warning(
      'Gallery mutation auxiliary update failed '
      'action=${action.name} phase=${phase.name} code=${_errorCode(error).name} '
      'type=${error.runtimeType}',
    );
  }

  void _admit(GalleryEntry entry) {
    final index = _index(entry.section);
    final old = index.entriesByPath[entry.path];
    final count = index.entriesById!.length + (old == null ? 1 : 0);
    final bytes = index.catalogBytes + _entryBytes(entry) - (old == null ? 0 : _entryBytes(old)) + 128;
    if (count > maxCatalogEntries || bytes > maxCatalogBytes) {
      throw const GalleryCatalogFailure(GalleryErrorCode.outputLimitExceeded);
    }
  }

  void _putEntry(GalleryEntry entry) {
    final index = _index(entry.section);
    final old = index.entriesByPath[entry.path];
    if (old != null) _removeEntry(old);
    if (index.entriesById!.isNotEmpty) index.catalogBytes++;
    index.catalogBytes += _entryBytes(entry);
    index.entriesById![entry.mediaId] = entry;
    index.entriesByPath[entry.path] = entry;
  }

  void _removeEntry(GalleryEntry entry) {
    if (entry.section == GalleryMediaSection.published) return;
    final index = _index(entry.section);
    if (index.entriesById!.remove(entry.mediaId) == null) return;
    index.entriesByPath.remove(entry.path);
    index.catalogBytes -= _entryBytes(entry) + (index.entriesById!.isEmpty ? 0 : 1);
  }

  int _emptyCatalogBytes(_GalleryMirrorIndex index) =>
      utf8
          .encode(
            jsonEncode(
              GalleryCatalog(
                section: index.section,
                capabilities: catalog.capabilities,
                thumbnailPolicy: catalog.thumbnailPolicy,
                entries: const [],
              ).toJson(),
            ),
          )
          .length +
      128;
  static int _entryBytes(GalleryEntry entry) => utf8.encode(jsonEncode(entry.toJson())).length;
  static String _revision(FileStat stat) => sha256
      .convert(
        utf8.encode('${stat.size}:${stat.modified.microsecondsSinceEpoch}:${stat.changed.microsecondsSinceEpoch}'),
      )
      .toString();
  static GalleryEntry mirrorEntry(GalleryMediaSection section, String relative, FileStat stat) {
    final prefix = switch (section) {
      GalleryMediaSection.hidden => 'hidden-',
      GalleryMediaSection.trash => '',
      GalleryMediaSection.published => throw const GalleryCatalogFailure(GalleryErrorCode.invalidRequest),
    };
    if (stat.type != FileSystemEntityType.file) {
      throw const GalleryCatalogFailure(GalleryErrorCode.notFound);
    }
    final revision = _revision(stat);
    final extension = path.extension(relative).toLowerCase();
    return GalleryEntry(
      section: section,
      mediaId: '$prefix${sha256.convert(utf8.encode(jsonEncode([relative, revision])))}',
      name: path.basename(relative),
      path: relative,
      kind: extension == '.gif'
          ? GalleryEntryKind.animatedImage
          : FileSettings.isVideo(extension)
          ? GalleryEntryKind.video
          : GalleryEntryKind.image,
      sourceRevision: revision,
      thumbnailSupported: true,
      fileChanged: stat.changed.toUtc(),
      sizeBytes: stat.size,
    );
  }

  Future<File> _file(
    GalleryMediaSection section,
    String relative, {
    bool allowMissing = false,
    bool allowDirectory = false,
  }) async {
    return _checkedFile(await _rootPath(section), relative, allowMissing: allowMissing, allowDirectory: allowDirectory);
  }

  Future<String> _rootPath(GalleryMediaSection section) async =>
      section == GalleryMediaSection.published ? await _originalRootPath() : directory(section).absolute.path;

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
      throw const _GalleryFileFailure(GalleryErrorCode.invalidRequest, _GalleryPathRejection.invalidRelativePath);
    }
    final file = File(path.join(root, relative));
    if (!path.isWithin(root, file.path)) {
      throw const _GalleryFileFailure(GalleryErrorCode.invalidRequest, _GalleryPathRejection.invalidRelativePath);
    }
    await _assertNoLinks(file.path, allowMissing: allowMissing);
    final type = await FileSystemEntity.type(file.path, followLinks: false);
    if (allowMissing && type == FileSystemEntityType.notFound) return file;
    if (allowDirectory && type == FileSystemEntityType.directory) return file;
    if (type != FileSystemEntityType.file) {
      throw GalleryCatalogFailure(
        type == FileSystemEntityType.directory ? GalleryErrorCode.unsupported : GalleryErrorCode.notFound,
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
        throw const _GalleryFileFailure(GalleryErrorCode.invalidRequest, _GalleryPathRejection.wrongEntryType);
      }
      await _assertNoLinks(current);
    }
  }

  static void _assertStat(File file, FileStat before) {
    final now = file.statSync();
    if (FileSystemEntity.typeSync(file.path, followLinks: false) != FileSystemEntityType.file ||
        now.type != FileSystemEntityType.file ||
        now.size != before.size ||
        now.modified != before.modified ||
        now.changed != before.changed) {
      throw const GalleryCatalogFailure(GalleryErrorCode.revisionMismatch);
    }
  }

  Future<String> _originalRootPath() async {
    final resolved = path.normalize(await catalog.originals.resolveSymbolicLinks());
    final pinned = _canonicalOriginalRoot;
    if (pinned != null && pinned != resolved) {
      throw const _GalleryFileFailure(GalleryErrorCode.revisionMismatch, _GalleryPathRejection.rootChanged);
    }
    if (pinned == null) {
      await _assertNoLinks(resolved);
      if (await FileSystemEntity.type(resolved, followLinks: false) != FileSystemEntityType.directory) {
        throw const _GalleryFileFailure(GalleryErrorCode.unsupported, _GalleryPathRejection.wrongEntryType);
      }
      for (final index in _indexes.values) {
        final directory = index.directory;
        final mirror = path.normalize(
          await directory.exists() ? await directory.resolveSymbolicLinks() : directory.absolute.path,
        );
        if (_overlaps(mirror, resolved)) {
          throw const _GalleryFileFailure(GalleryErrorCode.invalidRequest, _GalleryPathRejection.rootOverlap);
        }
      }
      _canonicalOriginalRoot = resolved;
      _log.fine(
        'Gallery original root bound '
        'aliased=${path.normalize(catalog.originals.absolute.path) != resolved}',
      );
    }
    return resolved;
  }

  static bool _overlaps(String a, String b) => a == b || path.isWithin(a, b) || path.isWithin(b, a);

  static bool _conflictsWithState(String state, String mirror, GalleryMediaSection section) =>
      _overlaps(state, mirror) && mirror != path.join(state, section.name);

  static Future<void> _assertNoLinks(String absolute, {bool allowMissing = false}) async {
    var current = path.rootPrefix(absolute);
    for (final part in path.split(absolute).skip(1)) {
      current = path.join(current, part);
      final type = await FileSystemEntity.type(current, followLinks: false);
      if (type == FileSystemEntityType.link) {
        throw const _GalleryFileFailure(GalleryErrorCode.invalidRequest, _GalleryPathRejection.symlinkSegment);
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

  Future<void> _refresh() => catalog
      .refresh(GalleryRefreshRequest(operationId: 'files-${galleryToken()}', mode: GalleryRefreshMode.scan))
      .then((_) {});

  Future<void> close() => _closing ??= () async {
    final pendingAtClose = _pending;
    _closed = true;
    await _tail;
    _log.info('Gallery file operations closed pendingAtClose=$pendingAtClose ');
  }();
}
