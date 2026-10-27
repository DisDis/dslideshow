// Metadata/cache operations must yield rather than block the HTTP isolate.
// ignore_for_file: avoid_slow_async_io
import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;

import 'thumbnail_worker.dart';
import 'thumbnail_policy.dart';
export 'thumbnail_policy.dart';
import 'ffmpeg_thumbnail_worker.dart';
export 'ffmpeg_thumbnail_worker.dart';
export 'thumbnail_worker.dart';

class ThumbnailSource {
  final String mediaId;
  final String revision;
  final String path;
  final String fingerprintToken;
  const ThumbnailSource({
    required this.mediaId,
    required this.revision,
    required this.path,
    required this.fingerprintToken,
  });
}

class ThumbnailVariantSpec {
  final String bucketId;
  final String policyRevision;
  final int size;
  const ThumbnailVariantSpec({
    required this.bucketId,
    required this.size,
    this.policyRevision = '',
  });
}

class ThumbnailArtifact {
  final String path;
  final int length;
  final String etag;
  final String mimeType;
  const ThumbnailArtifact({
    required this.path,
    required this.length,
    required this.etag,
    required this.mimeType,
  });
}

/// Pins the artifact against eviction until the response body finishes/cancels.
class ThumbnailLease {
  final ThumbnailArtifact artifact;
  final Future<void> Function() _release;
  Future<void>? _released;
  ThumbnailLease._(this.artifact, this._release);
  Future<void> release() => _released ??= _release();
}

typedef ThumbnailSourceValidator = Future<bool> Function(
  ThumbnailSource source,
);

class ThumbnailService {
  static final _log = Logger('ThumbnailService');
  final Directory cacheDirectory;
  final ThumbnailPolicy policy;
  final ThumbnailWorker _worker;
  final ThumbnailSourceValidator _isCurrent;
  final Duration Function()? _elapsedOverride;
  final Stopwatch _clock = Stopwatch()..start();
  final Map<String, _CacheEntry> _entries = {};
  final Map<String, _Job> _jobs = {};
  final Queue<_Job> _queue = Queue();
  final LinkedHashMap<String, _NegativeEntry> _negative = LinkedHashMap();
  final Set<Future<void>> _running = {};
  Future<void> _cacheTail = Future.value();
  Future<void>? _initialization;
  Future<void>? _closing;
  bool _closed = false;
  int _active = 0;
  int _waiters = 0;
  int _usedBytes = 0;
  int _sequence = 0;
  static final _name = RegExp(r'^([a-f0-9]{64})-([a-f0-9]{32})\.jpg$');
  static final _legacyName = RegExp(r'^[a-f0-9]{64}-[a-f0-9]{64}\.(jpg|png)$');
  static final _temporaryName = RegExp(r'^\.thumb-[a-f0-9]{32}\.part$');
  static final _random = Random.secure();

  ThumbnailService({
    required this.cacheDirectory,
    required ThumbnailSourceValidator isCurrent,
    Directory? originalsDirectory,
    this.policy = const ThumbnailPolicy(),
    ThumbnailWorker worker = const FfmpegThumbnailWorker(),
    Duration Function()? elapsed,
  }) : _worker = worker,
       _isCurrent = isCurrent,
       _elapsedOverride = elapsed {
    final positive = [
      policy.maxWorkers,
      policy.maxWaiters,
      policy.maxCacheBytes,
      policy.maxCacheObjects,
      policy.maxNegativeEntries,
      policy.maxSourceBytes,
      policy.maxSourcePixels,
      policy.maxOutputBytes,
      policy.maxVariantSize,
    ];
    if (positive.any((value) => value <= 0) ||
        policy.sizes.isEmpty ||
        policy.sizes.contains(GalleryThumbnailSize.unknown) ||
        policy.jpegQuality < 1 ||
        policy.jpegQuality > 100 ||
        policy.frameSelectionFrames < 2 ||
        policy.frameSelectionFrames > 120 ||
        policy.backgroundColor < 0xff000000 ||
        policy.backgroundColor > 0xffffffff ||
        policy.maxQueued < 0 ||
        policy.maxOutputBytes > policy.maxCacheBytes ||
        policy.workerTimeout <= Duration.zero ||
        policy.waiterTimeout <= Duration.zero ||
        policy.negativeTtl < Duration.zero) {
      throw ArgumentError('Invalid thumbnail resource policy');
    }
    if (originalsDirectory != null) {
      final original = path.normalize(originalsDirectory.absolute.path);
      final cache = path.normalize(cacheDirectory.absolute.path);
      if (cache == original || path.isWithin(original, cache)) {
        throw ArgumentError('Thumbnail cache must be outside originals');
      }
    }
  }

  Duration get _elapsed => _elapsedOverride?.call() ?? _clock.elapsed;

  Future<void> initialize() => _initialization ??=
      _cacheOperation(() async {
        _checkOpen();
        await cacheDirectory.create(recursive: true);
        await for (final entity in cacheDirectory.list(followLinks: false)) {
          _checkOpen();
          if (entity is! File) continue;
          final filename = path.basename(entity.path);
          if (_temporaryName.hasMatch(filename) ||
              _legacyName.hasMatch(filename)) {
            await _delete(entity);
            continue;
          }
          if (!_name.hasMatch(filename)) continue;
          final file = entity;
          _checkOpen();
          final match = _name.firstMatch(path.basename(file.path))!;
          try {
            final stat = await file.stat();
            if (stat.size > policy.maxOutputBytes ||
                (await md5.bind(file.openRead()).first).toString() !=
                    match[2]) {
              await _delete(file);
              continue;
            }
            final entry = _CacheEntry(
              match[1]!,
              ThumbnailArtifact(
                path: file.path,
                length: stat.size,
                etag: '"${match[2]}"',
                mimeType: 'image/jpeg',
              ),
              stat.modified,
            );
            final previous = _entries[entry.key];
            if (previous != null) {
              if (previous.modified.isAfter(stat.modified)) {
                await _delete(file);
                continue;
              }
              _entries.remove(entry.key);
              _usedBytes -= previous.artifact.length;
              await _delete(File(previous.artifact.path));
            }
            entry.lastUsed = stat.modified.microsecondsSinceEpoch;
            _sequence = max(_sequence, entry.lastUsed);
            _entries[entry.key] = entry;
            _usedBytes += entry.artifact.length;
            // Enumeration itself does not accumulate an unbounded candidate list.
            await _trim();
          } on FileSystemException {
            await _delete(file);
          }
        }
        _log.info(
          () =>
              'Thumbnail cache ready directory=${jsonEncode(cacheDirectory.path)} '
              'entries=${_entries.length} bytes=$_usedBytes '
              'maxBytes=${policy.maxCacheBytes} maxEntries=${policy.maxCacheObjects}',
        );
      }).catchError((Object error, StackTrace stack) {
        _log.log(
          error is ThumbnailFailure ? Level.FINE : Level.WARNING,
          () =>
              'Thumbnail cache initialization failed directory=${jsonEncode(cacheDirectory.path)}',
          error,
          stack,
        );
        Error.throwWithStackTrace(error, stack);
      });

  Future<ThumbnailLease> acquire(
    ThumbnailSource source,
    ThumbnailVariantSpec variant, {
    ThumbnailCancellationToken? cancellation,
    bool retry = false,
  }) async {
    _checkOpen();
    if (_waiters >= policy.maxWaiters) {
      throw const ThumbnailFailure(ThumbnailFailureKind.queueFull);
    }
    if (variant.size <= 0 || variant.size > policy.maxVariantSize) {
      throw ArgumentError('Invalid thumbnail variant');
    }
    _waiters++;
    final token = ThumbnailCancellationToken();
    final timedOut = Completer<ThumbnailFailure>();
    final remove = cancellation?.listen(() {
      if (!timedOut.isCompleted) {
        timedOut.complete(
          const ThumbnailFailure(ThumbnailFailureKind.cancelled),
        );
      }
      token.cancel();
    });
    final timer = Timer(policy.waiterTimeout, () {
      if (!timedOut.isCompleted) {
        timedOut.complete(const ThumbnailFailure(ThumbnailFailureKind.timeout));
      }
      token.cancel();
    });
    final operation = _acquire(source, variant, token, retry).whenComplete(() {
      _waiters--;
    });
    try {
      return await Future.any([
        operation,
        timedOut.future.then<ThumbnailLease>((failure) => throw failure),
      ]);
    } finally {
      timer.cancel();
      remove?.call();
    }
  }

  Future<ThumbnailLease> _acquire(
    ThumbnailSource source,
    ThumbnailVariantSpec variant,
    ThumbnailCancellationToken token,
    bool retry,
  ) async {
    await initialize();
    _checkOpen();
    _checkCancelled(token);
    if (!await _isCurrent(source)) {
      throw const ThumbnailFailure(ThumbnailFailureKind.staleSource);
    }
    _checkOpen();
    _checkCancelled(token);
    final key = sha256
        .convert(
          utf8.encode(
            jsonEncode([
              source.mediaId,
              source.revision,
              source.fingerprintToken,
              variant.bucketId,
              thumbnailPolicyVersion,
              policy.renderRevision,
              variant.policyRevision,
              variant.size,
            ]),
          ),
        )
        .toString();
    final cached = await _cacheOperation(() async {
      final entry = _entries[key];
      if (entry == null) return null;
      final stat = await File(entry.artifact.path).stat();
      if (stat.type != FileSystemEntityType.file ||
          stat.size != entry.artifact.length ||
          stat.modified != entry.modified) {
        _entries.remove(key);
        _usedBytes -= entry.artifact.length;
        await _delete(File(entry.artifact.path));
        return null;
      }
      return _lease(entry);
    });
    if (cached != null) {
      _log.finer(
        () =>
            'Thumbnail cache hit mediaId=${source.mediaId} '
            'revision=${source.revision} size=${variant.size} key=$key',
      );
      try {
        _checkOpen();
        _checkCancelled(token);
        if (!await _isCurrent(source)) {
          throw const ThumbnailFailure(ThumbnailFailureKind.staleSource);
        }
        _checkOpen();
        _checkCancelled(token);
        return cached;
      } catch (_) {
        await cached.release();
        rethrow;
      }
    }
    _checkOpen();
    _checkCancelled(token);
    if (retry) _negative.remove(key);
    final negative = _negative[key];
    if (negative != null) {
      if (negative.expires > _elapsed) {
        _log.fine(
          () =>
              'Thumbnail negative cache hit mediaId=${source.mediaId} '
              'size=${variant.size} reason=${negative.failure.kind.name}',
        );
        throw negative.failure;
      }
      _negative.remove(key);
    }
    var job = _jobs[key];
    if (job != null && job.cancellation.isCancelled) {
      // A terminating worker still owns its slot/key. Do not overlap a retry.
      throw const ThumbnailFailure(ThumbnailFailureKind.queueFull);
    }
    if (job == null) {
      if (_jobs.length >= policy.maxWorkers + policy.maxQueued) {
        throw const ThumbnailFailure(ThumbnailFailureKind.queueFull);
      }
      job = _Job(key, source, variant);
      _jobs[key] = job;
      _queue.add(job);
      _log.fine(
        () =>
            'Thumbnail queued mediaId=${source.mediaId} '
            'revision=${source.revision} size=${variant.size} '
            'active=$_active queued=${_queue.length} waiters=$_waiters',
      );
    } else {
      _log.finer(
        () =>
            'Thumbnail joined existing job mediaId=${source.mediaId} '
            'size=${variant.size}',
      );
    }
    final waiter = _Waiter();
    job.waiters.add(waiter);
    final pendingJob = job;
    final remove = token.listen(() {
      if (pendingJob.waiters.remove(waiter)) {
        if (!waiter.result.isCompleted) {
          waiter.result.completeError(
            const ThumbnailFailure(ThumbnailFailureKind.cancelled),
          );
        }
        if (pendingJob.waiters.isEmpty) {
          pendingJob.cancellation.cancel();
          if (_queue.remove(pendingJob)) _jobs.remove(key);
        }
      }
    });
    _pump();
    try {
      return await waiter.result.future;
    } finally {
      remove();
    }
  }

  ThumbnailLease _lease(_CacheEntry entry) {
    entry.pins++;
    entry.lastUsed = ++_sequence;
    return ThumbnailLease._(entry.artifact, () async {
      entry.pins--;
      await _cacheOperation(_trim);
    });
  }

  void _pump() {
    while (!_closed && _active < policy.maxWorkers && _queue.isNotEmpty) {
      final job = _queue.removeFirst();
      if (job.waiters.isEmpty) continue;
      _active++;
      late Future<void> running;
      running = _run(job).whenComplete(() {
        _active--;
        _jobs.remove(job.key);
        _running.remove(running);
        _pump();
      });
      _running.add(running);
    }
  }

  Future<void> _run(_Job job) async {
    final clock = Stopwatch()..start();
    _log.fine(
      () =>
          'Thumbnail generation started mediaId=${job.source.mediaId} '
          'revision=${job.source.revision} size=${job.variant.size} '
          'source=${jsonEncode(job.source.path)} active=$_active queued=${_queue.length}',
    );
    try {
      if (!await _isCurrent(job.source)) {
        throw const ThumbnailFailure(ThumbnailFailureKind.staleSource);
      }
      _checkOpen();
      _checkCancelled(job.cancellation);
      final result = await _worker.run(
        ThumbnailWorkRequest(
          path: job.source.path,
          size: job.variant.size,
          jpegQuality: policy.jpegQuality,
          backgroundColor: policy.backgroundColor,
          frameSelectionFrames: policy.frameSelectionFrames,
          maxSourceBytes: policy.maxSourceBytes,
          maxSourcePixels: policy.maxSourcePixels,
          maxOutputBytes: policy.maxOutputBytes,
        ),
        timeout: policy.workerTimeout,
        cancellation: job.cancellation,
      );
      _checkOpen();
      _checkCancelled(job.cancellation);
      if (!await _isCurrent(job.source)) {
        throw const ThumbnailFailure(ThumbnailFailureKind.staleSource);
      }
      final bytes = result.bytes;
      if (bytes.isEmpty ||
          bytes.length > policy.maxOutputBytes ||
          bytes.length > policy.maxCacheBytes) {
        throw const ThumbnailFailure(ThumbnailFailureKind.sourceTooLarge);
      }
      await _cacheOperation(() async {
        _checkOpen();
        _checkCancelled(job.cancellation);
        // Reserve before writing: pinned responses cannot push cache over budget.
        await _trim(incomingBytes: bytes.length, incomingObjects: 1);
        if (_usedBytes + bytes.length > policy.maxCacheBytes ||
            _entries.length + 1 > policy.maxCacheObjects) {
          throw const ThumbnailFailure(ThumbnailFailureKind.queueFull);
        }
        final nonce = List.generate(
          16,
          (_) => _random.nextInt(256).toRadixString(16).padLeft(2, '0'),
        ).join();
        final temporary = File(
          path.join(cacheDirectory.path, '.thumb-$nonce.part'),
        );
        const extension = 'jpg';
        final destination = File(
          path.join(
            cacheDirectory.path,
            '${job.key}-${result.digest}.$extension',
          ),
        );
        var renamed = false;
        var committed = false;
        try {
          await temporary.create(exclusive: true);
          await temporary.writeAsBytes(bytes, flush: true);
          _checkOpen();
          _checkCancelled(job.cancellation);
          if (!await _isCurrent(job.source)) {
            throw const ThumbnailFailure(ThumbnailFailureKind.staleSource);
          }
          await temporary.rename(destination.path);
          renamed = true;
          if (_closed ||
              job.cancellation.isCancelled ||
              !await _isCurrent(job.source)) {
            await _delete(destination);
            _checkOpen();
            _checkCancelled(job.cancellation);
            throw const ThumbnailFailure(ThumbnailFailureKind.staleSource);
          }
          final stat = await destination.stat();
          final entry = _CacheEntry(
            job.key,
            ThumbnailArtifact(
              path: destination.path,
              length: bytes.length,
              etag: '"${result.digest}"',
              mimeType: 'image/jpeg',
            ),
            stat.modified,
          );
          _entries[job.key] = entry;
          _usedBytes += bytes.length;
          committed = true;
          for (final waiter in job.waiters) {
            if (!waiter.result.isCompleted)
              waiter.result.complete(_lease(entry));
          }
          job.waiters.clear();
        } finally {
          if (!renamed) await _delete(temporary);
          if (renamed && !committed) await _delete(destination);
        }
      });
      _log.fine(
        () =>
            'Thumbnail ready mediaId=${job.source.mediaId} '
            'size=${job.variant.size} bytes=${bytes.length} '
            'elapsedMs=${clock.elapsedMilliseconds}',
      );
    } catch (error, stack) {
      final failure = error is ThumbnailFailure
          ? error
          : error is FileSystemException &&
                [28, 122].contains(error.osError?.errorCode)
          ? const ThumbnailFailure(ThumbnailFailureKind.diskFull)
          : const ThumbnailFailure(ThumbnailFailureKind.decodeFailed);
      _log.log(
        switch (failure.kind) {
          ThumbnailFailureKind.cancelled ||
          ThumbnailFailureKind.closed ||
          ThumbnailFailureKind.staleSource ||
          ThumbnailFailureKind.queueFull => Level.FINE,
          _ => Level.WARNING,
        },
        () =>
            'Thumbnail generation failed mediaId=${job.source.mediaId} '
            'revision=${job.source.revision} size=${job.variant.size} '
            'source=${jsonEncode(job.source.path)} reason=${failure.kind.name} '
            'elapsedMs=${clock.elapsedMilliseconds}',
        error is ThumbnailFailure ? null : error,
        error is ThumbnailFailure ? null : stack,
      );
      if ([
        ThumbnailFailureKind.decodeFailed,
        ThumbnailFailureKind.unavailable,
        ThumbnailFailureKind.unsupported,
        ThumbnailFailureKind.sourceTooLarge,
      ].contains(failure.kind)) {
        _negative.remove(job.key);
        _negative[job.key] = _NegativeEntry(
          failure,
          _elapsed + policy.negativeTtl,
        );
        while (_negative.length > policy.maxNegativeEntries) {
          _negative.remove(_negative.keys.first);
        }
      }
      for (final waiter in job.waiters) {
        if (!waiter.result.isCompleted) waiter.result.completeError(failure);
      }
      job.waiters.clear();
    }
  }

  Future<void> _trim({int incomingBytes = 0, int incomingObjects = 0}) async {
    final unused = _entries.values.where((entry) => entry.pins == 0).toList()
      ..sort((a, b) => a.lastUsed.compareTo(b.lastUsed));
    for (final entry in unused) {
      if (_usedBytes + incomingBytes <= policy.maxCacheBytes &&
          _entries.length + incomingObjects <= policy.maxCacheObjects)
        break;
      await _delete(File(entry.artifact.path));
      _entries.remove(entry.key);
      _usedBytes -= entry.artifact.length;
    }
  }

  Future<T> _cacheOperation<T>(Future<T> Function() action) {
    final operation = _cacheTail.then((_) => action());
    _cacheTail = operation.then<void>(
      (_) {},
      onError: (Object _, StackTrace __) {},
    );
    return operation;
  }

  static Future<void> _delete(File file) async {
    try {
      await file.delete();
    } on FileSystemException catch (error) {
      if (error.osError?.errorCode != 2) rethrow;
    }
  }

  void _checkOpen() {
    if (_closed) throw const ThumbnailFailure(ThumbnailFailureKind.closed);
  }

  static void _checkCancelled(ThumbnailCancellationToken token) {
    if (token.isCancelled) {
      throw const ThumbnailFailure(ThumbnailFailureKind.cancelled);
    }
  }

  Future<void> close() => _closing ??= _close();

  Future<void> _close() async {
    _closed = true;
    for (final job in _jobs.values.toList()) {
      job.cancellation.cancel();
      for (final waiter in job.waiters) {
        if (!waiter.result.isCompleted) {
          waiter.result.completeError(
            const ThumbnailFailure(ThumbnailFailureKind.closed),
          );
        }
      }
      job.waiters.clear();
    }
    _queue.clear();
    await Future.wait(_running.toList());
    await _cacheTail;
    _jobs.clear();
    _negative.clear();
  }
}

class _CacheEntry {
  final String key;
  final ThumbnailArtifact artifact;
  final DateTime modified;
  int lastUsed = 0;
  int pins = 0;
  _CacheEntry(this.key, this.artifact, this.modified);
}

class _Job {
  final String key;
  final ThumbnailSource source;
  final ThumbnailVariantSpec variant;
  final Set<_Waiter> waiters = {};
  final ThumbnailCancellationToken cancellation = ThumbnailCancellationToken();
  _Job(this.key, this.source, this.variant);
}

class _Waiter {
  final Completer<ThumbnailLease> result = Completer();
}

class _NegativeEntry {
  final ThumbnailFailure failure;
  final Duration expires;
  _NegativeEntry(this.failure, this.expires);
}
