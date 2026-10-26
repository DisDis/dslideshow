import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:crypto/crypto.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import 'media_image_loader.dart';

GalleryNativeImageCache? _sharedCache;

GalleryEncodedCache createCache() =>
    _SessionCache(_sharedCache ??= GalleryNativeImageCache());

/// Handles isolate the close of an old server/auth session from a new session.
/// The root UI isolate's shared store keeps its directory ownership lock open.
final class _SessionCache implements GalleryEncodedCache {
  _SessionCache(this._cache);
  final GalleryEncodedCache _cache;
  bool _closed = false;

  void _checkOpen() {
    if (_closed) throw StateError('Gallery cache session is closed');
  }

  @override
  Future<GalleryEncodedImage?> get(String key) {
    _checkOpen();
    return _cache.get(key);
  }

  @override
  Future<GalleryEncodedImage> write(String key, Stream<List<int>> body) {
    _checkOpen();
    return _cache.write(key, body);
  }

  @override
  Future<void> remove(String key) {
    _checkOpen();
    return _cache.remove(key);
  }

  @override
  Future<void> close() async {
    _closed = true;
    // The loader drains its own transports before closing this handle. Keeping
    // the shared store open also protects decodes belonging to overlapping
    // sessions. Standalone injected caches have a full close implementation.
  }
}

/// Exclusive disk ownership is established before startup cleanup. Another
/// process falls back to bounded memory without touching the disk owner's data.
/// Worker isolates use memory, since POSIX file locks are process-scoped.
final class GalleryNativeImageCache implements GalleryEncodedCache {
  GalleryNativeImageCache({
    Directory? directory,
    this.maxBytes = 128 << 20,
    this.maxObjects = 512,
    this.memoryMaxBytes = 24 << 20,
    this.memoryMaxObjects = 128,
  }) : _requestedDirectory = directory {
    if ([
      maxBytes,
      maxObjects,
      memoryMaxBytes,
      memoryMaxObjects,
    ].any((value) => value < 0)) {
      throw ArgumentError('Gallery cache budgets must not be negative');
    }
    _ready = _choose();
    _ready.ignore();
  }

  // Retain the owner until cleanup succeeds, including a failed close. Releasing
  // ownership after a cleanup error would permit a new owner to delete live data.
  static final _claimed = <String, GalleryNativeImageCache>{};
  final Directory? _requestedDirectory;
  final int maxBytes;
  final int maxObjects;
  final int memoryMaxBytes;
  final int memoryMaxObjects;
  late final Future<GalleryEncodedCache> _ready;
  RandomAccessFile? _lock;
  String? _claimedPath;
  bool _closed = false;
  Future<void>? _closing;

  GalleryMemoryImageCache _memory() => GalleryMemoryImageCache(
    maxBytes: memoryMaxBytes,
    maxObjects: memoryMaxObjects,
  );

  Future<GalleryEncodedCache> _choose() async {
    // A per-isolate registry can protect POSIX process locks only when disk
    // ownership is restricted to this one isolate. Do not even open a descriptor
    // in workers: closing it could silently release the root isolate's lock.
    if (ui.RootIsolateToken.instance == null) return _memory();
    GalleryDiskImageCache? disk;
    try {
      final directory =
          _requestedDirectory ??
          Directory(
            path.join(
              (await getApplicationCacheDirectory()).path,
              'gallery-encoded-v1',
            ),
          );
      await directory.create(recursive: true);
      final canonical = await directory.resolveSymbolicLinks();
      // POSIX locks belong to a process. Do not open another descriptor:
      // closing it would release this process's existing lock for that file.
      if (_claimed.containsKey(canonical)) return _memory();
      _claimed[canonical] = this;
      _claimedPath = canonical;
      try {
        _lock = await File(path.join(canonical, '.owner.lock'))
            .open(mode: FileMode.append);
        await _lock!.lock(FileLock.exclusive);
      } on FileSystemException {
        await _releaseLock();
        return _memory();
      }
      disk = GalleryDiskImageCache(
        directory: Directory(canonical),
        maxBytes: maxBytes,
        maxObjects: maxObjects,
      );
      await disk._ready;
      return disk;
    } on Object catch (error, stack) {
      // Startup may already have queued an eviction sweep. Drain and detach the
      // failed instance before another owner is allowed to clean this directory.
      await disk?._abortInitialization();
      await _releaseLock();
      GalleryDiskImageCache._log.warning(
        'Native gallery cache unavailable; using bounded memory',
        error,
        stack,
      );
      return _memory();
    }
  }

  void _checkOpen() {
    if (_closed) throw StateError('Native gallery cache is closed');
  }

  @override
  Future<GalleryEncodedImage?> get(String key) async {
    _checkOpen();
    final cache = await _ready;
    _checkOpen();
    return cache.get(key);
  }

  @override
  Future<GalleryEncodedImage> write(String key, Stream<List<int>> body) async {
    _checkOpen();
    final cache = await _ready;
    _checkOpen();
    return cache.write(key, body);
  }

  @override
  Future<void> remove(String key) async {
    _checkOpen();
    final cache = await _ready;
    _checkOpen();
    await cache.remove(key);
  }

  Future<void> _releaseLock() async {
    final lock = _lock;
    // Keep the strong claim if closing the descriptor fails: opening another
    // descriptor in this process could otherwise break its still-live lock.
    await lock?.close();
    _lock = null;
    final claimed = _claimedPath;
    _claimedPath = null;
    if (claimed != null) _claimed.remove(claimed);
  }

  @override
  Future<void> close() => _closing ??= _close();
  Future<void> _close() async {
    _closed = true;
    final cache = await _ready;
    // Deliberately retain ownership if cleanup fails. The registry keeps this
    // descriptor alive; unlocking here would make outstanding files unsafe.
    await cache.close();
    if (cache is GalleryDiskImageCache) await cache.whenReleased;
    await _releaseLock();
  }
}

final class _DiskEntry {
  _DiskEntry(this.id, this.identity, this.image, this.accessed);
  final String id;
  final String identity;
  final GalleryEncodedImage image;
  int accessed;
}

/// Encoded-byte LRU, independent from Flutter's decoded ImageCache.
///
/// An explicitly injected directory must be caller-exclusive. Use
/// [GalleryNativeImageCache] when ownership is not already guaranteed.
/// Only complete bodies are published. Evicted files remain usable while any
/// image/decoder lease retains their payload. Those active leases and incoming
/// bodies are additionally limited by MediaImageLoader's transfer budgets.
/// Access recency changes in memory; close coalesces surviving touched entries
/// into atomic metadata updates. After a crash, persisted LRU is approximate.
final class GalleryDiskImageCache implements GalleryEncodedCache {
  GalleryDiskImageCache({
    required Directory directory,
    this.maxBytes = 128 << 20,
    this.maxObjects = 512,
  }) : _requestedDirectory = directory {
    if (maxBytes < 0 || maxObjects < 0) {
      throw ArgumentError('Gallery cache budgets must not be negative');
    }
    _ready = _initialize();
    _ready.ignore();
  }

  static final _log = Logger('GalleryEncodedCache');
  static const _uuid = Uuid();
  static final _digestPattern = RegExp(r'^[a-f0-9]{64}$');
  static final _payloadPattern = RegExp(r'^[a-f0-9-]{36}\.body$');
  // A standalone cache may be reopened after close while a decoder still pins
  // a payload. The default factory shares one store across overlapping sessions.
  static final _closedPins = <String, Set<GalleryEncodedImage>>{};
  static final _sweepWaiters = <GalleryDiskImageCache>{};

  final Directory _requestedDirectory;
  final int maxBytes;
  final int maxObjects;
  final _entries = <String, _DiskEntry>{};
  final _accessedEntries = <String>{};
  final _retired = <GalleryEncodedImage>{};
  final _handoffs = <GalleryEncodedImage>{};
  final _handoffTimers = <GalleryEncodedImage, Timer>{};
  final _writes = <Future<GalleryEncodedImage>>{};
  final _sources = <StreamIterator<List<int>>>{};
  final _closedCachedPins = <GalleryEncodedImage>{};
  final _released = Completer<void>();
  late final Future<void> _ready;
  late Directory _directory;
  Future<void> _mutations = Future<void>.value();
  Future<void>? _closing;
  int _bytes = 0;
  bool _closed = false;
  bool _shutdownComplete = false;
  Timer? _sweepTimer;

  int get cachedBytes => _bytes;
  int get cachedObjects => _entries.length;
  Future<void> get whenReleased => _released.future;

  String _id(String key) => sha256.convert(utf8.encode(key)).toString();
  String _identity(String key) =>
      sha256.convert(utf8.encode('gallery-cache-v1\u0000$key')).toString();

  File _metadata(String id) => File(path.join(_directory.path, '$id.json'));

  void _checkOpen() {
    if (_closed) throw StateError('Gallery disk cache is closed');
  }

  Future<T> _exclusive<T>(Future<T> Function() work) {
    final operation = _mutations.then((_) => work());
    _mutations = operation.then<void>(
      (_) {},
      onError: (Object _, StackTrace _) {},
    );
    return operation;
  }

  Future<void> _initialize() async {
    _directory = _requestedDirectory;
    await _directory.create(recursive: true);
    final records = <_DiskEntry>[];
    final keep = <String>{};
    final files = await _directory.list(followLinks: false).toList();
    for (final entity in files) {
      if (entity is! File || !entity.path.endsWith('.json')) continue;
      try {
        final id = path.basenameWithoutExtension(entity.path);
        final record =
            jsonDecode(await entity.readAsString()) as Map<String, dynamic>;
        final identity = record['identity'];
        final filename = record['file'];
        final length = record['bytes'];
        final accessed = record['accessed'];
        if (!_digestPattern.hasMatch(id) ||
            record['schema'] != 1 ||
            identity is! String ||
            !_digestPattern.hasMatch(identity) ||
            filename is! String ||
            !_payloadPattern.hasMatch(filename) ||
            length is! int ||
            length < 0 ||
            accessed is! int) {
          throw const FormatException('Invalid gallery cache metadata');
        }
        final file = File(path.join(_directory.path, filename));
        if (await FileSystemEntity.type(file.path, followLinks: false) !=
                FileSystemEntityType.file ||
            await file.length() != length) {
          throw const FormatException('Incomplete gallery cache payload');
        }
        records.add(
          _DiskEntry(
            id,
            identity,
            GalleryEncodedImage.file(file.path, length),
            accessed,
          ),
        );
        keep.add(file.path);
        keep.add(entity.path);
      } on Object {
        // Invalid/incomplete metadata is a miss. Owned remnants are removed in
        // the second pass, never exposed as an image to the decoder.
      }
    }
    records.sort((a, b) => a.accessed.compareTo(b.accessed));
    for (final entry in records) {
      _entries[entry.id] = entry;
      _bytes += entry.image.byteLength;
    }
    for (final entity in files) {
      final name = path.basename(entity.path);
      final owned =
          name.endsWith('.part') ||
          name.endsWith('.body') ||
          name.endsWith('.json');
      if (owned &&
          !keep.contains(entity.path) &&
          !_hasClosedPins(entity.path)) {
        if (entity is File || entity is Link) await entity.delete();
      }
    }
    await _trim();
    await _sweep();
  }

  // No public operation/payload can escape before the native wrapper awaits
  // _ready. Failed startup only needs to stop its own deferred cleanup; the next
  // owner can recover the remaining complete/orphan files under its own lock.
  Future<void> _abortInitialization() async {
    _closed = true;
    _sweepTimer?.cancel();
    _sweepTimer = null;
    for (final timer in _handoffTimers.values) {
      timer.cancel();
    }
    _handoffTimers.clear();
    await _mutations;
    for (final image in _retired) {
      image.onUnused = null;
    }
    _retired.clear();
    _entries.clear();
    _handoffs.clear();
    _bytes = 0;
    _sweepWaiters.remove(this);
    _shutdownComplete = true;
    _checkReleased();
  }

  GalleryEncodedImage _handoff(GalleryEncodedImage image) {
    _handoffs.add(image);
    // Futures complete before this next event-loop turn, giving get/write's
    // consumer time to retain the exact payload before an eviction deletes it.
    _handoffTimers.remove(image)?.cancel();
    _handoffTimers[image] = Timer(Duration.zero, () {
      _handoffTimers.remove(image);
      _handoffs.remove(image);
      _scheduleSweep();
    });
    return image;
  }

  Future<void> _writeMetadata(_DiskEntry entry, {bool flush = true}) async {
    final staging = File(path.join(_directory.path, '${_uuid.v4()}.part'));
    try {
      await staging.writeAsString(
        jsonEncode({
          'schema': 1,
          'identity': entry.identity,
          'file': path.basename(entry.image.filePath!),
          'bytes': entry.image.byteLength,
          'accessed': entry.accessed,
        }),
        flush: flush,
      );
      await staging.rename(_metadata(entry.id).path);
    } finally {
      await _delete(staging);
    }
  }

  @override
  Future<GalleryEncodedImage?> get(String key) async {
    _checkOpen();
    await _ready;
    return _exclusive(() async {
      _checkOpen();
      final id = _id(key);
      final entry = _entries[id];
      if (entry == null || entry.identity != _identity(key)) return null;
      final file = File(entry.image.filePath!);
      final stat = await file.stat();
      if (stat.type != FileSystemEntityType.file ||
          stat.size != entry.image.byteLength) {
        await _removeEntry(id);
        return null;
      }
      _entries.remove(id);
      _entries[id] = entry;
      entry.accessed = DateTime.now().microsecondsSinceEpoch;
      // A warm hit must not wait for a durable write (or queue one ahead of the
      // next hit). Publication metadata is already complete; only LRU recency
      // changed. Multiple hits of the same live entry coalesce until close.
      _accessedEntries.add(id);
      return _handoff(entry.image);
    });
  }

  @override
  Future<GalleryEncodedImage> write(String key, Stream<List<int>> body) {
    _checkOpen();
    final operation = _write(key, body);
    _writes.add(operation);
    unawaited(
      operation.then<void>(
        (_) => _writes.remove(operation),
        onError: (Object _, StackTrace _) => _writes.remove(operation),
      ),
    );
    return operation;
  }

  Future<GalleryEncodedImage> _write(String key, Stream<List<int>> body) async {
    await _ready;
    _checkOpen();
    final filename = '${_uuid.v4()}.body';
    final staging = File(path.join(_directory.path, '$filename.part'));
    final destination = File(path.join(_directory.path, filename));
    final source = StreamIterator(body);
    _sources.add(source);
    RandomAccessFile? output;
    GalleryEncodedImage? created;
    var length = 0;
    var published = false;
    try {
      output = await staging.open(mode: FileMode.writeOnly);
      while (await source.moveNext()) {
        _checkOpen();
        final chunk = source.current;
        await output.writeFrom(chunk);
        length += chunk.length;
      }
      _checkOpen();
      await output.flush();
      await output.close();
      output = null;
      return await _exclusive(() async {
        _checkOpen();
        await staging.rename(destination.path);
        final image = GalleryEncodedImage.file(destination.path, length);
        created = image;
        final id = _id(key);
        final entry = _DiskEntry(
          id,
          _identity(key),
          image,
          DateTime.now().microsecondsSinceEpoch,
        );
        if (length <= maxBytes && maxObjects > 0) {
          await _writeMetadata(entry);
          final previous = _entries.remove(id);
          if (previous != null) {
            _bytes -= previous.image.byteLength;
            _retire(previous.image);
          }
          _entries[id] = entry;
          _accessedEntries.remove(id);
          _bytes += length;
          _handoffs.add(image);
          await _trim();
        } else {
          await _removeEntry(id);
          _handoffs.add(image);
          _retire(image);
        }
        published = true;
        return image;
      });
    } finally {
      try {
        try {
          await source.cancel();
        } finally {
          try {
            await output?.close();
          } finally {
            await _delete(staging);
            if (!published) await _delete(destination);
          }
        }
      } finally {
        _sources.remove(source);
        final image = created;
        if (image != null) {
          if (published) {
            _handoff(image);
          } else {
            _handoffs.remove(image);
            _retired.remove(image);
          }
        }
      }
    }
  }

  Future<void> _removeEntry(String id) async {
    final previous = _entries.remove(id);
    if (previous == null) return;
    _accessedEntries.remove(id);
    _bytes -= previous.image.byteLength;
    await _delete(_metadata(id));
    _retire(previous.image);
  }

  Future<void> _trim() async {
    while (_bytes > maxBytes || _entries.length > maxObjects) {
      await _removeEntry(_entries.keys.first);
    }
  }

  void _retire(GalleryEncodedImage image) {
    _retired.add(image);
    image.onUnused = _scheduleSweep;
    _scheduleSweep();
  }

  void _scheduleSweep() {
    if (_sweepTimer != null) return;
    _sweepTimer = Timer(Duration.zero, () async {
      _sweepTimer = null;
      try {
        await _exclusive(_sweep);
      } on Object catch (error, stack) {
        _log.warning('Unable to clean gallery encoded cache', error, stack);
      }
    });
  }

  Future<void> _sweep() async {
    for (final image in _retired.toList()) {
      if (image.references != 0 ||
          _handoffs.contains(image) ||
          _hasClosedPins(image.filePath!)) {
        continue;
      }
      await _delete(File(image.filePath!));
      image.onUnused = null;
      _retired.remove(image);
    }
    if (_retired.isEmpty) {
      _sweepWaiters.remove(this);
    } else {
      _sweepWaiters.add(this);
    }
    _checkReleased();
  }

  void _checkReleased() {
    if (_shutdownComplete &&
        _retired.isEmpty &&
        _closedCachedPins.isEmpty &&
        !_released.isCompleted) {
      _released.complete();
    }
  }

  static Future<void> _delete(File file) async {
    try {
      await file.delete();
    } on FileSystemException catch (error) {
      if (error.osError?.errorCode != 2) rethrow;
    }
  }

  static bool _hasClosedPins(String file) =>
      _closedPins[file]?.any((image) => image.references > 0) ?? false;

  @override
  Future<void> remove(String key) async {
    _checkOpen();
    await _ready;
    await _exclusive(() async {
      _checkOpen();
      final id = _id(key);
      if (_entries[id]?.identity == _identity(key)) await _removeEntry(id);
      await _sweep();
    });
  }

  @override
  Future<void> close() => _closing ??= _close();

  Future<void> _close() async {
    _closed = true;
    await _ready;
    await Future.wait(_sources.toList().map((source) => source.cancel()));
    await Future.wait(
      _writes.toList().map(
        (future) =>
            future.then<void>((_) {}, onError: (Object _, StackTrace _) {}),
      ),
    );
    await _exclusive(() async {
      _sweepTimer?.cancel();
      _sweepTimer = null;
      for (final timer in _handoffTimers.values) {
        timer.cancel();
      }
      _handoffTimers.clear();
      _handoffs.clear();
      for (final id in _accessedEntries) {
        final entry = _entries[id];
        if (entry == null) continue;
        try {
          // Recency is advisory, so close must not fsync once per touched file.
          // Publication still uses the durable default above.
          await _writeMetadata(entry, flush: false);
        } on FileSystemException catch (error, stack) {
          // Touch persistence is advisory. A read-only/full disk must not turn
          // a valid warm hit into an error or prevent resource/lock cleanup.
          _log.warning('Unable to persist gallery cache recency', error, stack);
        }
      }
      _accessedEntries.clear();
      for (final entry in _entries.values) {
        final image = entry.image;
        if (image.references > 0) {
          _closedCachedPins.add(image);
          final pins = _closedPins.putIfAbsent(image.filePath!, () => {});
          pins.add(image);
          image.onUnused = () {
            _closedCachedPins.remove(image);
            pins.remove(image);
            if (pins.isEmpty) _closedPins.remove(image.filePath);
            for (final cache in _sweepWaiters.toList()) {
              cache._scheduleSweep();
            }
            _checkReleased();
          };
        }
      }
      _entries.clear();
      _bytes = 0;
      await _sweep();
      _shutdownComplete = true;
      _checkReleased();
    });
  }
}
