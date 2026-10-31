import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:dslideshow_backend/environment.dart';
import 'package:dslideshow_backend/src/service/gallery/gallery_files.dart';
import 'package:dslideshow_backend/src/service/storage/disk/disk_storage_config.dart';
import 'package:dslideshow_backend/src/service/storage/mediaitem.dart';
import 'package:dslideshow_backend/src/service/storage/storage.dart';
import 'package:dslideshow_backend/src/service/storage/storage_type.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;

class DiskMediaItem extends MediaItem {
  DiskMediaItem(String? id, Uri? uri) : super(id, uri);
}

class DiskStorage extends Storage {
  static const String CACHE_FOLDER_NAME = 'images';
  static final Logger _log = Logger('DiskStorage');
  static const String name = 'DiskStorage';
  static const _batchSize = 256;
  static final _uploadTemporaryName = RegExp(r'^\.upload-[0-9a-f]{32}\.part$');

  final Directory _folder;

  /// The mirrored root for media excluded from playback and cloud reimport.
  final Directory hidden;
  final Random _rnd;
  Directory get folder => _folder;

  /// Creates storage without scanning or creating filesystem entries.
  ///
  /// [hidden] overrides the default `hidden` child of [galleryStateDirectory]
  /// for the configured [folder]. The default retains the configured root's
  /// alias and normalizes its absolute path without resolving symbolic links.
  DiskStorage(DiskStorageConfig config, {Directory? folder, Directory? hidden, Random? random})
    : this._(folder ?? Directory(path.join(externalStorage.path, CACHE_FOLDER_NAME)), hidden: hidden, random: random);

  DiskStorage._(Directory folder, {Directory? hidden, Random? random})
    : _folder = folder,
      hidden = hidden ?? Directory(path.join(galleryStateDirectory(Directory(folder.path)).path, 'hidden')),
      _rnd = random ?? Random();

  /// Checks for a regular file at [relativePath] in [folder] or [hidden].
  ///
  /// Follows symbolic links and returns `false` for missing or non-file paths
  /// without creating directories. Throws [FormatException] for unsafe
  /// relative paths.
  Future<bool> mediaExists(String relativePath) async {
    if (relativePath.isEmpty ||
        path.isAbsolute(relativePath) ||
        path.posix.isAbsolute(relativePath) ||
        relativePath.contains('\\') ||
        relativePath.contains('\u0000')) {
      throw const FormatException('Invalid relative media path');
    }
    final segments = path.posix.split(relativePath);
    if (segments.any((segment) => segment.isEmpty || segment == '.' || segment == '..') ||
        path.posix.joinAll(segments) != relativePath) {
      throw const FormatException('Invalid relative media path');
    }
    // Metadata lookups must not block the hardware isolate.
    // ignore: avoid_slow_async_io
    if (await File(path.join(folder.path, relativePath)).exists()) return true;
    // ignore: avoid_slow_async_io
    return File(path.join(hidden.path, relativePath)).exists();
  }

  MediaItem? _current;
  MediaItem? _next;

  @override
  Future<MediaItem?> getCurrent() async => _current;

  @override
  Future<MediaItem?> getNext() async => _next;

  @override
  DateTime get lastSync => DateTime.now();

  // The selected tail stays in the list, so beginning another cycle requires
  // only resetting the cursor. Each draw is one lazy Fisher-Yates step.
  List<Uri> _items = <Uri>[];
  Set<Uri> _index = <Uri>{};
  int _remaining = 0;
  final Set<Uri> _seen = <Uri>{};

  bool _scanAttempted = false;
  bool _hasPublishedIndex = false;
  bool _dirty = false;
  int _generation = 0;
  Future<void>? _scanFuture;
  StreamIterator<FileSystemEntity>? _scanIterator;
  Future<void> _nextOperations = Future.value();
  Future<void>? _initFuture;
  Future<void>? _releaseFuture;
  bool _released = false;

  Future<Uri?> _getRandomItem() async {
    var refreshed = false;
    if (!_scanAttempted) {
      await _rebuild();
      refreshed = true;
    }
    var skipped = 0;
    while (!_released) {
      while (_remaining > 0) {
        final selected = _rnd.nextInt(_remaining);
        final uri = _items[selected];
        _remaining--;
        _items[selected] = _items[_remaining];
        _items[_remaining] = uri;
        // A rebuilt list includes the whole new index. Entries already issued
        // in this cycle (including the reserved next item) remain ineligible.
        if (_seen.add(uri)) return uri;
        if (++skipped % _batchSize == 0) {
          await Future<void>.delayed(Duration.zero);
          if (_released) return null;
        }
      }
      if (!refreshed) {
        // Linux's directory watcher is not recursive. A complete traversal at
        // cycle boundaries also discovers changes in nested directories.
        await _rebuild();
        refreshed = true;
        continue;
      }
      if (_items.isEmpty) return null;
      _seen.clear();
      _remaining = _items.length;
    }
    return null;
  }

  Future<void> _rebuild() {
    if (_released) return Future.value();
    return _scanFuture ??= _scan().whenComplete(() => _scanFuture = null);
  }

  Future<void> _scan() async {
    if (type == StorageType.local) updateStatus(StorageStatusEnum.download);
    _scanAttempted = true;
    // Coalesce events during a scan into one following attempt. Continuous
    // changes must not keep a waiting next() blocked indefinitely.
    for (var attempt = 0; attempt < 2 && !_released; attempt++) {
      final generation = _generation;
      final items = <Uri>[];
      final index = <Uri>{};
      var unchanged = true;
      try {
        final iterator = StreamIterator(_folder.list(recursive: true));
        _scanIterator = iterator;
        var finished = false;
        try {
          var count = 0;
          while (true) {
            bool hasNext;
            try {
              hasNext = await iterator.moveNext();
            } catch (_) {
              // StreamIterator cancels its subscription on a stream error.
              finished = true;
              rethrow;
            }
            if (!hasNext) {
              finished = true;
              break;
            }
            if (_released) return;
            final entity = iterator.current;
            // Directory.list already identifies files, including followed
            // working symlinks. Do not stat every entity a second time.
            if (entity is File && !_isUploadTemporary(entity.path)) {
              final uri = entity.uri;
              if (index.add(uri)) {
                items.add(uri);
                if (!_index.contains(uri)) unchanged = false;
              }
            }
            if (++count % _batchSize == 0) {
              await Future<void>.delayed(Duration.zero);
            }
          }
        } finally {
          if (identical(_scanIterator, iterator)) _scanIterator = null;
          // Completed iterators already released their subscription; release()
          // owns cancellation when shutdown interrupted the traversal.
          if (!finished && !_released) await iterator.cancel();
        }
      } catch (error, stack) {
        if (_released) return;
        if (type == StorageType.local) updateStatus(StorageStatusEnum.off);
        _log.warning('Could not build file cache; keeping previous index', error, stack);
        _dirty = true;
        _scheduleRefresh();
        if (!_hasPublishedIndex) Error.throwWithStackTrace(error, stack);
        return;
      }
      if (_released) return;
      if (generation != _generation) continue;
      // Publish only a complete, current scan. Selection can advance while the
      // scan awaits I/O; _seen is checked when drawing, not captured here.
      if (!unchanged || index.length != _index.length) {
        _items = items;
        _index = index;
        _remaining = items.length;
      }
      _hasPublishedIndex = true;
      _dirty = false;
      _timerFolderUpdate?.cancel();
      _timerFolderUpdate = null;
      _startWatching();
      _log.fine('File cache has ${index.length} file(s)');
      if (type == StorageType.local) updateStatus(StorageStatusEnum.done);
      return;
    }
    if (!_released) {
      _dirty = true;
      _scheduleRefresh();
      if (type == StorageType.local) updateStatus(StorageStatusEnum.done);
    }
  }

  static bool _isUploadTemporary(String filename) => _uploadTemporaryName.hasMatch(path.basename(filename));

  static final _nullMediaItem = DiskMediaItem(null, null);

  @override
  Future<MediaItem?> next() {
    final operation = _nextOperations.then((_) async {
      if (_released) return _nullMediaItem;
      final nextUri = await _getRandomItem();
      if (_released) return _nullMediaItem;
      final item = nextUri == null ? _nullMediaItem : DiskMediaItem(nextUri.path, nextUri);
      // No await between these assignments: readers see the previous pair
      // throughout preparation, and the new pair after it completes.
      _current = _next;
      _next = item;
      return item;
    });
    _nextOperations = operation.then<void>((_) {}, onError: (Object _, StackTrace __) {});
    return operation;
  }

  @override
  Future<Null> sync() async {
    await _rebuild();
    return null;
  }

  @override
  final StorageType type = StorageType.local;

  StreamSubscription<FileSystemEvent>? _watchSubscription;
  Timer? _timerFolderUpdate;

  @override
  Future<void> init() => _initFuture ??= _init();

  Future<void> _init() async {
    if (_released) return;
    _startWatching();
    await next();
    await next();
  }

  void _startWatching() {
    if (_released || _watchSubscription != null) return;
    try {
      _watchSubscription = _folder.watch().listen(
        _onFolderUpdated,
        onError: (Object error, StackTrace stack) {
          if (_released) return;
          _log.warning('Storage folder watcher failed', error, stack);
          _markDirty();
        },
        onDone: () {
          _watchSubscription = null;
          if (!_released) _markDirty();
        },
      );
    } catch (error, stack) {
      _log.fine('Could not watch storage folder', error, stack);
    }
  }

  void _onFolderUpdated(FileSystemEvent event) {
    if (!event.isDirectory && _isUploadTemporary(event.path)) {
      // A move from .part into its final name publishes a ready file. A move
      // with an unknown destination must be treated conservatively as well.
      if (event is! FileSystemMoveEvent || (event.destination != null && _isUploadTemporary(event.destination!))) {
        return;
      }
    }
    _markDirty();
  }

  void _markDirty() {
    if (_released) return;
    _generation++;
    _dirty = true;
    _scheduleRefresh();
  }

  void _scheduleRefresh() {
    if (_released || _timerFolderUpdate != null) return;
    _timerFolderUpdate = Timer(const Duration(minutes: 1), () {
      _timerFolderUpdate = null;
      if (!_released && _dirty) {
        // Initial failures are reported to waiting callers by _rebuild; a
        // background retry has no caller and its already logged error is owned.
        unawaited(_rebuild().catchError((Object _, StackTrace __) {}));
      }
    });
  }

  @override
  Future<void> release() => _releaseFuture ??= _release();

  Future<void> _release() async {
    _released = true;
    _generation++;
    _timerFolderUpdate?.cancel();
    _timerFolderUpdate = null;
    await Future.wait([
      if (_watchSubscription != null) _watchSubscription!.cancel(),
      if (_scanIterator != null) _scanIterator!.cancel(),
    ]);
    _watchSubscription = null;
    await _scanFuture;
    await _nextOperations;
    _items = <Uri>[];
    _index = <Uri>{};
    _remaining = 0;
    _seen.clear();
    closeStatusNotifications();
  }
}
