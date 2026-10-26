// Tests exercise the asynchronous filesystem interface used by the service.
// ignore_for_file: avoid_slow_async_io
import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:dslideshow_backend/src/service/gallery/thumbnail_service.dart';
import 'package:image/image.dart' as image;
import 'package:test/test.dart';

class ControlledWorker implements ThumbnailWorker {
  final List<Completer<ThumbnailWorkerResult>> requests = [];
  final List<ThumbnailCancellationToken> cancellations = [];
  Completer<void> _changed = Completer();
  int active = 0;
  int peak = 0;

  Future<void> waitForCalls(int count) async {
    while (requests.length < count) {
      await _changed.future.timeout(const Duration(seconds: 5));
    }
  }

  @override
  Future<ThumbnailWorkerResult> run(
    ThumbnailWorkRequest request, {
    required Duration timeout,
    required ThumbnailCancellationToken cancellation,
  }) async {
    final completer = Completer<ThumbnailWorkerResult>();
    requests.add(completer);
    cancellations.add(cancellation);
    active++;
    if (active > peak) peak = active;
    final changed = _changed;
    _changed = Completer();
    changed.complete();
    final remove = cancellation.listen(() {
      if (!completer.isCompleted) {
        completer.completeError(
          const ThumbnailFailure(ThumbnailFailureKind.cancelled),
        );
      }
    });
    try {
      return await completer.future;
    } finally {
      remove();
      active--;
    }
  }

  void complete(int index, [List<int> bytes = const [1, 2, 3, 4]]) {
    requests[index].complete(
      ThumbnailWorkerResult(
        data: TransferableTypedData.fromList([Uint8List.fromList(bytes)]),
        format: ThumbnailFormat.jpeg,
        digest: sha256.convert(bytes).toString(),
        width: 1,
        height: 1,
        jpegScale: 1,
        elapsedMicroseconds: 1,
      ),
    );
  }
}

Matcher failure(ThumbnailFailureKind kind) => throwsA(
  isA<ThumbnailFailure>().having((value) => value.kind, 'kind', kind),
);

void main() {
  late Directory root;
  late Directory cache;
  late ControlledWorker worker;
  final services = <ThumbnailService>[];
  final variant = ThumbnailVariantSpec(bucketId: 'small', size: 256);
  ThumbnailSource source([String id = 'one', String revision = 'v1']) =>
      ThumbnailSource(
        mediaId: id,
        revision: revision,
        path: '${root.path}/$id.jpg',
        fingerprintToken: revision,
      );
  ThumbnailService create({
    ThumbnailPolicy policy = const ThumbnailPolicy(),
    ThumbnailSourceValidator? isCurrent,
    Duration Function()? elapsed,
  }) {
    final service = ThumbnailService(
      cacheDirectory: cache,
      originalsDirectory: Directory('${root.path}/images'),
      isCurrent: isCurrent ?? (_) async => true,
      worker: worker,
      policy: policy,
      elapsed: elapsed,
    );
    services.add(service);
    return service;
  }

  setUp(() async {
    root = await Directory.systemTemp.createTemp('thumbnail-test-');
    cache = Directory('${root.path}/thumbnails');
    worker = ControlledWorker();
  });
  tearDown(() async {
    for (final service in services) {
      await service.close();
    }
    services.clear();
    await root.delete(recursive: true);
  });

  test(
    'cold result is atomic, has content ETag, warm hit does not decode',
    () async {
      final service = create();
      final first = service.acquire(source(), variant);
      await worker.waitForCalls(1);
      expect(await cache.list().toList(), isEmpty);
      worker.complete(0);
      final lease = await first;
      expect(await File(lease.artifact.path).readAsBytes(), [1, 2, 3, 4]);
      expect(lease.artifact.etag, '"${sha256.convert([1, 2, 3, 4])}"');
      expect(lease.artifact.mimeType, 'image/jpeg');
      final second = await service.acquire(source(), variant);
      expect(second.artifact.path, lease.artifact.path);
      expect(worker.requests.length, 1);
      expect(
        (await cache.list().toList()).any(
          (file) => file.path.endsWith('.part'),
        ),
        isFalse,
      );
      await lease.release();
      await lease.release();
      await second.release();
    },
  );

  test('single flight preserves the other waiter when one cancels', () async {
    final service = create();
    final token = ThumbnailCancellationToken();
    final first = service.acquire(source(), variant, cancellation: token);
    final rejected = expectLater(
      first,
      failure(ThumbnailFailureKind.cancelled),
    );
    final second = service.acquire(source(), variant);
    await worker.waitForCalls(1);
    token.cancel();
    await rejected;
    expect(worker.cancellations.single.isCancelled, isFalse);
    worker.complete(0);
    final lease = await second;
    expect(worker.requests.length, 1);
    await lease.release();
  });

  test(
    'queue and global waiters are bounded, one worker stays active',
    () async {
      final service = create(policy: const ThumbnailPolicy(maxQueued: 1));
      final first = service.acquire(source('a'), variant);
      await worker.waitForCalls(1);
      final second = service.acquire(source('b'), variant);
      await Future<void>.delayed(Duration.zero);
      // A distinct third request cannot create unbounded queued work.
      await expectLater(
        service.acquire(source('c'), variant),
        failure(ThumbnailFailureKind.queueFull),
      );
      worker.complete(0);
      final firstLease = await first;
      await worker.waitForCalls(2);
      worker.complete(1);
      final secondLease = await second;
      expect(worker.peak, 1);
      await firstLease.release();
      await secondLease.release();
    },
  );

  test(
    'last cancellation removes queued work and permits future acquire',
    () async {
      final service = create();
      final first = service.acquire(source('a'), variant);
      await worker.waitForCalls(1);
      final token = ThumbnailCancellationToken();
      final second = service.acquire(source('b'), variant, cancellation: token);
      final rejected = expectLater(
        second,
        failure(ThumbnailFailureKind.cancelled),
      );
      token.cancel();
      await rejected;
      worker.complete(0);
      final lease = await first;
      await lease.release();
      final retry = service.acquire(source('b'), variant);
      await worker.waitForCalls(2);
      worker.complete(1);
      await (await retry).release();
      expect(worker.requests.length, 2);
    },
  );

  test('waiter deadline cancels active work and clears queued jobs', () async {
    final service = create(
      policy: const ThumbnailPolicy(waiterTimeout: Duration(milliseconds: 40)),
    );
    final first = service.acquire(source('a'), variant);
    final firstError = expectLater(
      first,
      failure(ThumbnailFailureKind.timeout),
    );
    await worker.waitForCalls(1);
    await firstError;
    await service.close();
    expect(worker.active, 0);
    expect(await cache.list().toList(), isEmpty);
  });

  test(
    'changed revision during decode does not publish, hit rechecks source',
    () async {
      var current = true;
      final service = create(isCurrent: (_) async => current);
      final first = service.acquire(source(), variant);
      final rejected = expectLater(
        first,
        failure(ThumbnailFailureKind.staleSource),
      );
      await worker.waitForCalls(1);
      current = false;
      worker.complete(0);
      await rejected;
      expect(await cache.list().toList(), isEmpty);
      current = true;
      final second = service.acquire(source('one', 'v2'), variant);
      await worker.waitForCalls(2);
      worker.complete(1);
      await (await second).release();
      current = false;
      await expectLater(
        service.acquire(source('one', 'v2'), variant),
        failure(ThumbnailFailureKind.staleSource),
      );
      expect(worker.requests.length, 2);
    },
  );

  test('negative cache expires, explicit retry bypasses it', () async {
    var elapsed = Duration.zero;
    final service = create(elapsed: () => elapsed);
    final first = service.acquire(source(), variant);
    final rejected = expectLater(
      first,
      failure(ThumbnailFailureKind.decodeFailed),
    );
    await worker.waitForCalls(1);
    worker.requests[0].completeError(
      const ThumbnailFailure(ThumbnailFailureKind.decodeFailed),
    );
    await rejected;
    await expectLater(
      service.acquire(source(), variant),
      failure(ThumbnailFailureKind.decodeFailed),
    );
    expect(worker.requests.length, 1);
    final retry = service.acquire(source(), variant, retry: true);
    await worker.waitForCalls(2);
    worker.requests[1].completeError(
      const ThumbnailFailure(ThumbnailFailureKind.decodeFailed),
    );
    await expectLater(retry, failure(ThumbnailFailureKind.decodeFailed));
    elapsed = const Duration(seconds: 4);
    final expired = service.acquire(source(), variant);
    await worker.waitForCalls(3);
    worker.complete(2);
    await (await expired).release();
  });

  test('LRU honours byte/object budget and pins active responses', () async {
    final service = create(
      policy: const ThumbnailPolicy(
        maxCacheBytes: 8,
        maxOutputBytes: 8,
        maxCacheObjects: 1,
      ),
    );
    final first = service.acquire(source('a'), variant);
    await worker.waitForCalls(1);
    worker.complete(0);
    final lease = await first;
    final second = service.acquire(source('b'), variant);
    final rejected = expectLater(
      second,
      failure(ThumbnailFailureKind.queueFull),
    );
    await worker.waitForCalls(2);
    worker.complete(1);
    await rejected;
    expect(await File(lease.artifact.path).exists(), isTrue);
    await lease.release();
    final retry = service.acquire(source('b'), variant);
    await worker.waitForCalls(3);
    worker.complete(2);
    final newLease = await retry;
    expect(await File(lease.artifact.path).exists(), isFalse);
    expect(await cache.list().length, 1);
    await newLease.release();
  });

  test(
    'restart checks hashes and removes only own stale partial files',
    () async {
      final service = create();
      final pending = service.acquire(source(), variant);
      await worker.waitForCalls(1);
      worker.complete(0);
      final lease = await pending;
      final artifact = lease.artifact;
      await lease.release();
      await service.close();
      final temporary = File('${cache.path}/.thumb-${'a' * 32}.part');
      final foreign = File('${cache.path}/keep.txt');
      await temporary.writeAsString('unfinished');
      await foreign.writeAsString('keep');
      final warm = create();
      final reused = await warm.acquire(source(), variant);
      expect(worker.requests.length, 1);
      await reused.release();
      expect(await temporary.exists(), isFalse);
      expect(await foreign.exists(), isTrue);
      await warm.close();
      await File(artifact.path).writeAsBytes([8, 8, 8, 8]);
      final restarted = create();
      final regenerated = restarted.acquire(source(), variant);
      await worker.waitForCalls(2);
      worker.complete(1);
      await (await regenerated).release();
    },
  );

  test(
    'close cancels running and queued work and forbids late publish',
    () async {
      final service = create();
      final first = service.acquire(source('a'), variant);
      final firstError = expectLater(
        first,
        failure(ThumbnailFailureKind.closed),
      );
      await worker.waitForCalls(1);
      final second = service.acquire(source('b'), variant);
      final secondError = expectLater(
        second,
        failure(ThumbnailFailureKind.closed),
      );
      await service.close();
      await firstError;
      await secondError;
      expect(worker.active, 0);
      expect(await cache.list().toList(), isEmpty);
      await expectLater(
        service.acquire(source(), variant),
        failure(ThumbnailFailureKind.closed),
      );
    },
  );

  test('cache cannot be configured inside originals', () {
    expect(
      () => ThumbnailService(
        cacheDirectory: Directory('${root.path}/images/thumbs'),
        originalsDirectory: Directory('${root.path}/images'),
        isCurrent: (_) async => true,
      ),
      throwsArgumentError,
    );
  });

  test(
    'pending validations are bounded and cancellation does not publish late',
    () async {
      final validation = Completer<bool>();
      final service = create(
        policy: const ThumbnailPolicy(maxWaiters: 1),
        isCurrent: (_) => validation.future,
      );
      final token = ThumbnailCancellationToken();
      final pending = service.acquire(source(), variant, cancellation: token);
      final cancelled = expectLater(
        pending,
        failure(ThumbnailFailureKind.cancelled),
      );
      await expectLater(
        service.acquire(source('other'), variant),
        failure(ThumbnailFailureKind.queueFull),
      );
      token.cancel();
      await cancelled;
      await expectLater(
        service.acquire(source('other'), variant),
        failure(ThumbnailFailureKind.queueFull),
      );
      validation.complete(true);
      await Future<void>.delayed(Duration.zero);
      expect(worker.requests, isEmpty);
      await service.close();
    },
  );

  test(
    'a cache filesystem failure is reported and never alters a source',
    () async {
      final file = File(cache.path);
      await file.writeAsString('occupied');
      final service = create();
      await expectLater(
        service.acquire(source(), variant),
        throwsA(isA<FileSystemException>()),
      );
      expect(await file.readAsString(), 'occupied');
      expect(worker.requests, isEmpty);
    },
  );

  test(
    'real decoder enforces source byte and pixel limits before output',
    () async {
      final input = File('${root.path}/limits.png');
      await input.writeAsBytes(
        image.encodePng(image.Image(width: 16, height: 16)),
      );
      for (final policy in [
        const ThumbnailPolicy(maxSourceBytes: 8),
        const ThumbnailPolicy(maxSourcePixels: 128),
      ]) {
        final real = ThumbnailService(
          cacheDirectory: cache,
          isCurrent: (_) async => true,
          policy: policy,
        );
        services.add(real);
        await expectLater(
          real.acquire(
            ThumbnailSource(
              mediaId: 'limited',
              revision: '1',
              path: input.path,
              fingerprintToken: '1',
            ),
            variant,
          ),
          failure(ThumbnailFailureKind.sourceTooLarge),
        );
        await real.close();
        expect(await cache.list().toList(), isEmpty);
      }
    },
  );

  test(
    'disk-full failure is typed and releases the job for a later retry',
    () async {
      final service = create();
      final pending = service.acquire(source(), variant);
      final rejected = expectLater(
        pending,
        failure(ThumbnailFailureKind.diskFull),
      );
      await worker.waitForCalls(1);
      worker.requests[0].completeError(
        const FileSystemException('no space', '', OSError('no space', 28)),
      );
      await rejected;
      final retry = service.acquire(source(), variant);
      await worker.waitForCalls(2);
      worker.complete(1);
      await (await retry).release();
    },
  );

  test('real GIF derivative contains only its first frame', () async {
    final first = image.Image(width: 8, height: 8);
    image.fill(first, color: image.ColorRgb8(255, 0, 0));
    final second = image.Image(width: 8, height: 8);
    image.fill(second, color: image.ColorRgb8(0, 0, 255));
    first.addFrame(second);
    final gif = File('${root.path}/animation.gif');
    await gif.writeAsBytes(image.encodeGif(first));
    final real = ThumbnailService(
      cacheDirectory: cache,
      isCurrent: (_) async => true,
    );
    services.add(real);
    final lease = await real.acquire(
      ThumbnailSource(
        mediaId: 'animation',
        revision: '1',
        path: gif.path,
        fingerprintToken: '1',
      ),
      variant,
    );
    final decoded = image.decodeImage(
      await File(lease.artifact.path).readAsBytes(),
    )!;
    expect(decoded.numFrames, 1);
    expect(decoded.getPixel(3, 3).r, greaterThan(230));
    expect(decoded.getPixel(3, 3).b, lessThan(20));
    await lease.release();
  });

  test(
    'real decoder preserves alpha and EXIF orientation without upscaling',
    () async {
      final pixels = image.Image(width: 4, height: 2, numChannels: 4);
      for (final pixel in pixels) {
        pixel.setRgba(
          pixel.x < 2 ? 255 : 0,
          0,
          pixel.x < 2 ? 0 : 255,
          pixel.y == 0 ? 0 : 128,
        );
      }
      final png = File('${root.path}/alpha.png');
      await png.writeAsBytes(image.encodePng(pixels));
      final real = ThumbnailService(
        cacheDirectory: cache,
        isCurrent: (_) async => true,
      );
      services.add(real);
      final lease = await real.acquire(
        ThumbnailSource(
          mediaId: 'alpha',
          revision: '1',
          path: png.path,
          fingerprintToken: '1',
        ),
        variant,
      );
      final decoded = image.decodePng(
        await File(lease.artifact.path).readAsBytes(),
      )!;
      expect(decoded.width, 2);
      expect(decoded.height, 2);
      expect(decoded.hasAlpha, isTrue);
      expect(decoded.getPixel(0, 0).a, 0);
      expect(lease.artifact.mimeType, 'image/png');
      await lease.release();
      // Orientation 6 rotates a 4x2 image clockwise before center cover.
      final jpeg = image.Image(width: 4, height: 2);
      for (final pixel in jpeg) {
        pixel.setRgb(pixel.x < 2 ? 255 : 0, 0, pixel.x < 2 ? 0 : 255);
      }
      jpeg.exif.imageIfd.orientation = 6;
      final jpg = File('${root.path}/orientation.jpg');
      await jpg.writeAsBytes(image.encodeJpg(jpeg));
      final oriented = await real.acquire(
        ThumbnailSource(
          mediaId: 'exif',
          revision: '1',
          path: jpg.path,
          fingerprintToken: '1',
        ),
        variant,
      );
      final result = image.decodeJpg(
        await File(oriented.artifact.path).readAsBytes(),
      )!;
      expect(result.getPixel(0, 0).r, greaterThan(result.getPixel(0, 0).b));
      expect(result.getPixel(0, 1).b, greaterThan(result.getPixel(0, 1).r));
      expect(result.exif.imageIfd.hasOrientation, isFalse);
      await oriented.release();
    },
  );

  test(
    'real worker timeout terminates CPU work before releasing the call',
    () async {
      final large = image.Image(width: 1024, height: 1024);
      final file = File('${root.path}/large.png');
      await file.writeAsBytes(image.encodePng(large));
      final real = ThumbnailService(
        cacheDirectory: cache,
        isCurrent: (_) async => true,
        policy: const ThumbnailPolicy(workerTimeout: Duration(microseconds: 1)),
      );
      services.add(real);
      await expectLater(
        real.acquire(
          ThumbnailSource(
            mediaId: 'large',
            revision: '1',
            path: file.path,
            fingerprintToken: '1',
          ),
          variant,
        ),
        failure(ThumbnailFailureKind.timeout),
      );
      await real.close();
      expect(await cache.list().toList(), isEmpty);
      final descriptors = Directory('/proc/self/fd').listSync().where((entry) {
        try {
          return Link(entry.path).targetSync() == file.path;
        } on FileSystemException {
          return false;
        }
      });
      expect(descriptors, isEmpty);
    },
  );
}
