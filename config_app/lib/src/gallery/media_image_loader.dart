import 'dart:async';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

enum GalleryImagePriority { fullscreen, visible, prefetch }

enum GalleryImageVariant { original, thumbnail }

enum GalleryImageTaskPhase { queued, fetching, cancelling, ready, failed }

/// Identity deliberately excludes widget identity and the transport URL.
final class GalleryImageKey {
  const GalleryImageKey({
    required this.scope,
    required this.mediaId,
    required this.revision,
    required this.variant,
    this.policy = 0,
    this.bucket = 0,
  });

  final String scope;
  final String mediaId;
  final String revision;
  final GalleryImageVariant variant;
  final int policy;
  final int bucket;

  String get storageKey =>
      '${scope.length}:$scope${mediaId.length}:$mediaId'
      '${revision.length}:$revision:${variant.name}:$policy:$bucket';

  @override
  bool operator ==(Object other) =>
      other is GalleryImageKey && storageKey == other.storageKey;

  @override
  int get hashCode => storageKey.hashCode;
}

final class GalleryImageRequest {
  const GalleryImageRequest({required this.key, required this.uri});
  final GalleryImageKey key;
  final Uri uri;
}

final class GalleryImageCancelled implements Exception {
  const GalleryImageCancelled();
}

final class GalleryImageHttpException implements Exception {
  const GalleryImageHttpException(this.statusCode, {this.retryAfter});
  final int statusCode;
  final Duration? retryAfter;
}

final class GalleryImageBudgetException implements Exception {
  const GalleryImageBudgetException();
}

/// Encoded data remains valid for its leases even after LRU eviction.
final class GalleryEncodedImage {
  GalleryEncodedImage.bytes(Uint8List data)
    : bytes = data,
      filePath = null,
      byteLength = data.length;

  GalleryEncodedImage.file(this.filePath, this.byteLength) : bytes = null;

  final Uint8List? bytes;
  final String? filePath;
  final int byteLength;
  int references = 0;
  void Function()? onUnused;

  void retain() => references++;
  void release() {
    if (references > 0 && --references == 0) onUnused?.call();
  }
}

abstract interface class GalleryEncodedCache {
  Future<GalleryEncodedImage?> get(String key);
  Future<GalleryEncodedImage> write(String key, Stream<List<int>> body);
  Future<void> remove(String key);
  Future<void> close();
}

/// Web and test cache. Active leases are outside the evictable cache budget.
final class GalleryMemoryImageCache implements GalleryEncodedCache {
  GalleryMemoryImageCache({this.maxBytes = 24 << 20, this.maxObjects = 128});
  final int maxBytes;
  final int maxObjects;
  final _entries = <String, GalleryEncodedImage>{};
  int _bytes = 0;

  @override
  Future<GalleryEncodedImage?> get(String key) async {
    final value = _entries.remove(key);
    if (value != null) _entries[key] = value;
    return value;
  }

  @override
  Future<GalleryEncodedImage> write(String key, Stream<List<int>> body) async {
    final buffer = BytesBuilder(copy: false);
    await for (final chunk in body) {
      buffer.add(chunk);
    }
    final value = GalleryEncodedImage.bytes(buffer.takeBytes());
    if (value.byteLength <= maxBytes && maxObjects > 0) {
      await remove(key);
      _entries[key] = value;
      _bytes += value.byteLength;
      while (_bytes > maxBytes || _entries.length > maxObjects) {
        await remove(_entries.keys.first);
      }
    }
    return value;
  }

  @override
  Future<void> remove(String key) async {
    final old = _entries.remove(key);
    if (old != null) _bytes -= old.byteLength;
  }

  @override
  Future<void> close() async {
    _entries.clear();
    _bytes = 0;
  }
}

/// A lease is an explicit viewport/fullscreen consumer, never an ImageCache
/// listener. Disposing the last lease cancels the actual request.
final class GalleryImageLease {
  GalleryImageLease._(this._loader, this._job, this._id) {
    _result.future.ignore();
  }

  final MediaImageLoader _loader;
  _ImageJob _job;
  final int _id;
  final _result = Completer<GalleryEncodedImage>();
  GalleryEncodedImage? _image;
  bool _released = false;
  bool _waitForNextAttempt = false;
  Future<GalleryEncodedImage> get result => _result.future;

  void updatePriority(GalleryImagePriority priority, {int distance = 0}) {
    if (_released) return;
    _job.consumers[_id] = (priority: priority, distance: distance);
    _loader._schedule();
  }

  void dispose() {
    if (_released) return;
    _released = true;
    _loader._leases.remove(this);
    final image = _image;
    _image = null;
    if (image != null) {
      _loader._releasePayload(image);
      image.release();
    }
    if (!_result.isCompleted) {
      _result.completeError(const GalleryImageCancelled());
    }
    _loader._release(_job, _id);
  }

  void _complete(GalleryEncodedImage image) {
    if (_released || _result.isCompleted) return;
    _loader._retainPayload(image);
    image.retain();
    _image = image;
    _result.complete(image);
  }

  void _fail(Object error, StackTrace stack) {
    if (!_released && !_result.isCompleted) _result.completeError(error, stack);
  }
}

final class _ImageJob {
  _ImageJob(this.request, this.sequence);
  final GalleryImageRequest request;
  final int sequence;
  final consumers = <int, ({GalleryImagePriority priority, int distance})>{};
  final leases = <int, GalleryImageLease>{};
  final abort = Completer<void>();
  final finished = Completer<void>();
  GalleryImageTaskPhase phase = GalleryImageTaskPhase.queued;
  bool timedOut = false;

  GalleryImagePriority get priority => consumers.values.fold(
    GalleryImagePriority.prefetch,
    (best, value) => value.priority.index < best.index ? value.priority : best,
  );

  int get distance => consumers.values
      .where((value) => value.priority == priority)
      .fold(
        1 << 30,
        (best, value) => value.distance < best ? value.distance : best,
      );
}

/// Shared bounded transport for thumbnails and fullscreen originals.
/// Limits include cache reads and cancelling operations, through complete body
/// consumption. This conservative accounting cannot exceed the network cap.
final class MediaImageLoader {
  MediaImageLoader({
    http.Client? client,
    GalleryEncodedCache? cache,
    this.maxActive = 4,
    this.maxPrefetch = 1,
    this.maxBodyBytes = 200 << 20,
    this.maxInFlightBytes = 256 << 20,
    this.requestTimeout = const Duration(seconds: 30),
  }) : _client = client ?? http.Client(),
       _cache = cache ?? GalleryMemoryImageCache() {
    if (maxActive < 1 ||
        maxPrefetch < 0 ||
        maxPrefetch >= maxActive ||
        maxBodyBytes < 1 ||
        maxInFlightBytes < maxBodyBytes ||
        requestTimeout <= Duration.zero) {
      throw ArgumentError('Invalid gallery image loading policy');
    }
  }

  final http.Client _client;
  final GalleryEncodedCache _cache;
  final int maxActive;
  final int maxPrefetch;
  final int maxBodyBytes;
  final int maxInFlightBytes;
  final Duration requestTimeout;
  final _jobs = <GalleryImageKey, _ImageJob>{};
  final _leases = <GalleryImageLease>{};
  final _operations = <Future<void>>{};
  int _nextId = 0;
  int _active = 0;
  int _inFlightBytes = 0;
  final _payloadLeases = <GalleryEncodedImage, int>{};
  int _leasedBytes = 0;
  bool _scheduled = false;
  bool _closed = false;
  Future<void>? _closing;

  int get activeCount => _active;
  bool get isClosed => _closed;
  int get queuedCount => _jobs.values
      .where((job) => job.phase == GalleryImageTaskPhase.queued)
      .length;
  int get pendingCount => _jobs.length;
  int get inFlightBytes => _inFlightBytes;
  int get leasedEncodedBytes => _leasedBytes;

  GalleryImageLease acquire(
    GalleryImageRequest request, {
    GalleryImagePriority priority = GalleryImagePriority.visible,
    int distance = 0,
  }) {
    if (_closed) throw StateError('Image loader is closed');
    final job = _jobs.putIfAbsent(
      request.key,
      () => _ImageJob(request, _nextId),
    );
    final id = _nextId++;
    final lease = GalleryImageLease._(this, job, id);
    _leases.add(lease);
    lease._waitForNextAttempt = job.phase == GalleryImageTaskPhase.cancelling;
    job.consumers[id] = (priority: priority, distance: distance);
    job.leases[id] = lease;
    _schedule();
    return lease;
  }

  void _release(_ImageJob job, int id) {
    job.consumers.remove(id);
    job.leases.remove(id);
    if (job.consumers.isNotEmpty || job.finished.isCompleted) return;
    if (job.phase == GalleryImageTaskPhase.queued) {
      _jobs.remove(job.request.key);
      job.finished.complete();
    } else if (job.phase == GalleryImageTaskPhase.fetching) {
      job.phase = GalleryImageTaskPhase.cancelling;
      if (!job.abort.isCompleted) job.abort.complete();
    }
    _schedule();
  }

  void _schedule() {
    if (_scheduled || _closed) return;
    _scheduled = true;
    scheduleMicrotask(() {
      _scheduled = false;
      if (_closed) return;
      final queue =
          _jobs.values
              .where(
                (job) =>
                    job.phase == GalleryImageTaskPhase.queued &&
                    job.consumers.isNotEmpty,
              )
              .toList()
            ..sort((a, b) {
              final priority = a.priority.index.compareTo(b.priority.index);
              if (priority != 0) return priority;
              final distance = a.distance.compareTo(b.distance);
              return distance != 0
                  ? distance
                  : a.sequence.compareTo(b.sequence);
            });
      var prefetch = _jobs.values
          .where(
            (job) =>
                job.phase == GalleryImageTaskPhase.fetching &&
                job.priority == GalleryImagePriority.prefetch,
          )
          .length;
      for (final job in queue) {
        if (_active >= maxActive) break;
        if (job.priority == GalleryImagePriority.prefetch &&
            prefetch >= maxPrefetch) {
          continue;
        }
        if (job.priority == GalleryImagePriority.prefetch) prefetch++;
        job.phase = GalleryImageTaskPhase.fetching;
        _active++;
        final operation = _run(job);
        _operations.add(operation);
        unawaited(operation.whenComplete(() => _operations.remove(operation)));
      }
    });
  }

  Future<void> _run(_ImageJob job) async {
    final timer = Timer(requestTimeout, () {
      job.timedOut = true;
      if (!job.abort.isCompleted) job.abort.complete();
    });
    var receivedBytes = 0;
    try {
      var image = await _cache.get(job.request.key.storageKey);
      if (job.abort.isCompleted || _closed) throw const GalleryImageCancelled();
      if (image == null) {
        final response = await _client.send(
          http.AbortableRequest(
            'GET',
            job.request.uri,
            abortTrigger: job.abort.future,
          ),
        );
        if (response.statusCode != 200) {
          await response.stream.listen((_) {}).cancel();
          throw GalleryImageHttpException(
            response.statusCode,
            retryAfter: _retryAfter(response.headers['retry-after']),
          );
        }
        if ((response.contentLength ?? 0) > maxBodyBytes) {
          if (!job.abort.isCompleted) job.abort.complete();
          await response.stream.listen((_) {}).cancel();
          throw const GalleryImageBudgetException();
        }
        Stream<List<int>> boundedBody() async* {
          await for (final chunk in response.stream) {
            if (job.abort.isCompleted || _closed) {
              throw const GalleryImageCancelled();
            }
            receivedBytes += chunk.length;
            _inFlightBytes += chunk.length;
            if (receivedBytes > maxBodyBytes ||
                _inFlightBytes + _leasedBytes > maxInFlightBytes) {
              if (!job.abort.isCompleted) job.abort.complete();
              throw const GalleryImageBudgetException();
            }
            yield chunk;
          }
        }

        image = await _cache.write(job.request.key.storageKey, boundedBody());
      }
      if (job.abort.isCompleted || _closed) throw const GalleryImageCancelled();
      // Completed bodies move from in-flight ownership to an encoded source
      // lease. Cache hits must also fit alongside all other active bodies and
      // pins, including native files excluded from the evictable disk LRU.
      final additionalBytes = _payloadLeases.containsKey(image)
          ? 0
          : image.byteLength;
      if (_inFlightBytes - receivedBytes + _leasedBytes + additionalBytes >
          maxInFlightBytes) {
        throw const GalleryImageBudgetException();
      }
      job.phase = GalleryImageTaskPhase.ready;
      for (final lease in job.leases.values.toList()) {
        lease._complete(image);
      }
    } catch (error, stack) {
      job.phase = GalleryImageTaskPhase.failed;
      final failure = job.timedOut
          ? TimeoutException('Image request timed out')
          : error;
      for (final lease in job.leases.values.toList()) {
        if (!lease._waitForNextAttempt || job.timedOut || _closed) {
          lease._fail(failure, stack);
        }
      }
    } finally {
      timer.cancel();
      _inFlightBytes -= receivedBytes;
      _active--;
      // A consumer may return while the previous transport is cancelling. It
      // waits for this operation, then receives a fresh attempt of the same key.
      if (!_closed &&
          job.abort.isCompleted &&
          job.consumers.isNotEmpty &&
          !job.timedOut) {
        final replacement = _ImageJob(job.request, job.sequence);
        for (final lease in job.leases.values) {
          if (!lease._result.isCompleted) {
            // Leases acquired during cancellation are handed over below.
            replacement.consumers[lease._id] = job.consumers[lease._id]!;
            replacement.leases[lease._id] = lease;
            lease._job = replacement;
            lease._waitForNextAttempt = false;
          }
        }
        if (replacement.consumers.isNotEmpty) {
          _jobs[job.request.key] = replacement;
        } else {
          _jobs.remove(job.request.key);
        }
      } else {
        _jobs.remove(job.request.key);
      }
      job.finished.complete();
      _schedule();
    }
  }

  Future<void> invalidate(GalleryImageKey key) => _cache.remove(key.storageKey);

  /// Decoder ownership is separate from a viewport lease, but its compressed
  /// source still contributes to the encoded budget until the engine finishes.
  void Function() retainForDecode(GalleryEncodedImage image) {
    _retainPayload(image);
    image.retain();
    var released = false;
    return () {
      if (released) return;
      released = true;
      _releasePayload(image);
      image.release();
    };
  }

  void _retainPayload(GalleryEncodedImage image) {
    final previous = _payloadLeases[image] ?? 0;
    if (previous == 0) _leasedBytes += image.byteLength;
    _payloadLeases[image] = previous + 1;
  }

  void _releasePayload(GalleryEncodedImage image) {
    final previous = _payloadLeases[image] ?? 0;
    if (previous <= 1) {
      _payloadLeases.remove(image);
      if (previous == 1) {
        _leasedBytes -= image.byteLength;
      }
    } else {
      _payloadLeases[image] = previous - 1;
    }
  }

  Future<void> close() => _closing ??= _close();
  Future<void> _close() async {
    _closed = true;
    for (final lease in _leases.toList()) {
      lease.dispose();
    }
    _client.close();
    await Future.wait(_operations.toList());
    _jobs.clear();
    await _cache.close();
  }

  static Duration? _retryAfter(String? value) {
    final seconds = int.tryParse(value ?? '');
    return seconds == null ? null : Duration(seconds: seconds.clamp(0, 3600));
  }
}
