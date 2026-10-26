import 'dart:async';
import 'dart:typed_data';

import 'package:config_app/src/gallery/media_image_loader.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

GalleryImageRequest request(String id) => GalleryImageRequest(
  key: GalleryImageKey(
    scope: 'test',
    mediaId: id,
    revision: '1',
    variant: GalleryImageVariant.thumbnail,
  ),
  uri: Uri.parse('http://localhost/$id'),
);

class ControlledClient extends http.BaseClient {
  final requests = <ControlledRequest>[];
  int active = 0;
  int peak = 0;
  bool closed = false;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    final pending = ControlledRequest(request, () => active--);
    requests.add(pending);
    active++;
    if (active > peak) peak = active;
    if (request case http.Abortable(:final abortTrigger?)) {
      unawaited(abortTrigger.then((_) => pending.abort()));
    }
    return pending.headers.future;
  }

  @override
  void close() {
    closed = true;
    for (final request in requests) {
      request.abort();
    }
  }
}

class ControlledRequest {
  ControlledRequest(this.request, this.onFinish) {
    body = StreamController<List<int>>(
      onCancel: () async {
        cancelStarted = true;
        await cancelGate?.future;
        finish();
      },
    );
    headers.future.ignore();
  }
  final http.BaseRequest request;
  final void Function() onFinish;
  final headers = Completer<http.StreamedResponse>();
  late final StreamController<List<int>> body;
  Completer<void>? cancelGate;
  bool aborted = false;
  bool cancelStarted = false;
  bool done = false;
  void respond({int status = 200}) {
    headers.complete(http.StreamedResponse(body.stream, status));
  }

  void finish() {
    if (done) return;
    done = true;
    onFinish();
  }

  void complete(List<int> bytes) {
    body.add(bytes);
    unawaited(body.close());
  }

  void abort() {
    if (aborted || done) return;
    aborted = true;
    if (!headers.isCompleted) {
      finish();
      headers.completeError(http.RequestAbortedException(request.url));
    } else {
      if (!body.isClosed) {
        body.addError(http.RequestAbortedException(request.url));
        unawaited(body.close());
      }
    }
  }
}

Future<void> flush() => Future<void>.delayed(Duration.zero);

class _FilePayloadCache implements GalleryEncodedCache {
  final images = <String, GalleryEncodedImage>{};

  @override
  Future<GalleryEncodedImage?> get(String key) async => images[key];

  @override
  Future<GalleryEncodedImage> write(String key, Stream<List<int>> body) async {
    var length = 0;
    await for (final chunk in body) {
      length += chunk.length;
    }
    return images[key] = GalleryEncodedImage.file('/encoded/$key', length);
  }

  @override
  Future<void> remove(String key) async => images.remove(key);

  @override
  Future<void> close() async => images.clear();
}

class _BeforeListenFailureCache implements GalleryEncodedCache {
  final cache = GalleryMemoryImageCache();
  var failWrites = true;

  @override
  Future<GalleryEncodedImage?> get(String key) => cache.get(key);

  @override
  Future<GalleryEncodedImage> write(String key, Stream<List<int>> body) async {
    if (failWrites) throw StateError('Cache staging could not be opened');
    return cache.write(key, body);
  }

  @override
  Future<void> remove(String key) => cache.remove(key);

  @override
  Future<void> close() => cache.close();
}

class _GatedFailureCache extends _BeforeListenFailureCache {
  final writeStarted = Completer<void>();
  final failedWrite = Completer<GalleryEncodedImage>();

  @override
  Future<GalleryEncodedImage> write(String key, Stream<List<int>> body) {
    if (!failWrites) return super.write(key, body);
    writeStarted.complete();
    return failedWrite.future;
  }
}

void main() {
  test('defaults accept the existing 200 MiB upload contract', () async {
    final loader = MediaImageLoader();
    expect(loader.maxBodyBytes, greaterThanOrEqualTo(200 << 20));
    expect(loader.maxInFlightBytes, greaterThanOrEqualTo(loader.maxBodyBytes));
    await loader.close();
  });

  test('cap includes delayed headers and complete streamed body', () async {
    final client = ControlledClient();
    final loader = MediaImageLoader(
      client: client,
      maxActive: 2,
      maxPrefetch: 0,
    );
    final leases = [for (var i = 0; i < 8; i++) loader.acquire(request('$i'))];
    await flush();
    expect(client.requests.length, 2);
    for (var i = 0; i < leases.length; i++) {
      final pending = client.requests[i];
      pending.respond();
      await flush();
      expect(loader.activeCount, lessThanOrEqualTo(2));
      if (i == 0) expect(client.requests.length, 2);
      pending.complete([i]);
      expect((await leases[i].result).bytes, [i]);
      await flush();
    }
    expect(client.peak, 2);
    expect(loader.pendingCount, 0);
    for (final lease in leases) {
      lease.dispose();
    }
    await loader.close();
  });

  test(
    'shared key survives one release; last consumer aborts before headers',
    () async {
      final client = ControlledClient();
      final loader = MediaImageLoader(client: client);
      final first = loader.acquire(request('same'));
      final second = loader.acquire(request('same'));
      await flush();
      first.dispose();
      await flush();
      expect(client.requests, hasLength(1));
      expect(client.requests.single.aborted, isFalse);
      second.dispose();
      await flush();
      expect(client.requests.single.aborted, isTrue);
      expect(loader.activeCount, 0);
      expect(loader.pendingCount, 0);
      await loader.close();
    },
  );

  test(
    'reacquire during body cancellation waits for actual source cleanup',
    () async {
      final client = ControlledClient();
      final loader = MediaImageLoader(
        client: client,
        maxActive: 1,
        maxPrefetch: 0,
      );
      final first = loader.acquire(request('same'));
      await flush();
      final pending = client.requests.single;
      pending.cancelGate = Completer<void>();
      pending.respond();
      await flush();
      first.dispose();
      final next = loader.acquire(request('same'));
      await flush();
      expect(loader.activeCount, 1);
      expect(client.requests, hasLength(1));
      pending.cancelGate!.complete();
      await flush();
      await flush();
      expect(client.requests, hasLength(2));
      client.requests.last.respond();
      client.requests.last.complete([7]);
      expect((await next.result).bytes, [7]);
      expect(client.peak, 1);
      next.dispose();
      await loader.close();
    },
  );

  test(
    'late reacquire during failed-write cleanup receives a fresh attempt',
    () async {
      final client = ControlledClient();
      final cache = _GatedFailureCache();
      final loader = MediaImageLoader(
        client: client,
        cache: cache,
        maxActive: 1,
        maxPrefetch: 0,
      );
      final first = loader.acquire(request('same'));
      await flush();
      final pending = client.requests.single;
      final gate = pending.cancelGate = Completer<void>();
      pending.respond();
      await cache.writeStarted.future;
      first.dispose();
      cache.failedWrite.completeError(StateError('staging failed'));
      await flush();
      expect(pending.aborted, isTrue);
      expect(pending.cancelStarted, isTrue);
      expect(pending.done, isFalse);
      // The writer has already failed and real cancellation is awaiting the
      // gate. Returning now must not attach to that attempt's stale error.
      final next = loader.acquire(request('same'));
      await flush();
      expect(loader.activeCount, 1);
      expect(client.requests, hasLength(1));
      cache.failWrites = false;
      gate.complete();
      await flush();
      expect(client.requests, hasLength(2));
      client.requests.last.respond();
      client.requests.last.complete([7]);
      expect((await next.result).bytes, [7]);
      expect(client.peak, 1);
      next.dispose();
      await loader.close();
      expect(loader.pendingCount, 0);
    },
  );

  test(
    'normal EOF keeps its slot until asynchronous source cleanup finishes',
    () async {
      final client = ControlledClient();
      final loader = MediaImageLoader(
        client: client,
        maxActive: 1,
        maxPrefetch: 0,
      );
      final first = loader.acquire(request('first'));
      final queued = loader.acquire(request('queued'));
      await flush();
      final pending = client.requests.single;
      final gate = pending.cancelGate = Completer<void>();
      pending.respond();
      pending.complete([1]);
      await flush();
      expect(pending.done, isFalse);
      expect(loader.activeCount, 1);
      expect(client.requests, hasLength(1));
      gate.complete();
      expect((await first.result).bytes, [1]);
      await flush();
      expect(pending.done, isTrue);
      expect(client.requests, hasLength(2));
      client.requests.last.respond();
      client.requests.last.complete([2]);
      expect((await queued.result).bytes, [2]);
      expect(client.peak, 1);
      first.dispose();
      queued.dispose();
      await loader.close();
    },
  );

  test(
    'a cache failure before body subscription aborts and waits for cleanup',
    () async {
      final client = ControlledClient();
      final cache = _BeforeListenFailureCache();
      final loader = MediaImageLoader(
        client: client,
        cache: cache,
        maxActive: 1,
        maxPrefetch: 0,
      );
      final failed = loader.acquire(request('failed'));
      final queued = loader.acquire(request('queued'));
      await flush();
      final pending = client.requests.single;
      final gate = pending.cancelGate = Completer<void>();
      pending.respond();
      await flush();
      expect(pending.aborted, isTrue);
      expect(pending.done, isFalse);
      expect(loader.activeCount, 1);
      expect(client.requests, hasLength(1));
      var failureDelivered = false;
      final failure = expectLater(failed.result, throwsStateError).then((_) {
        failureDelivered = true;
      });
      await flush();
      expect(failureDelivered, isFalse);
      cache.failWrites = false;
      gate.complete();
      await failure;
      await flush();
      expect(pending.done, isTrue);
      expect(client.requests, hasLength(2));
      expect(client.requests.last.request.url.path, '/queued');
      client.requests.last.respond();
      client.requests.last.complete([1, 2]);
      expect((await queued.result).bytes, [1, 2]);
      await flush();
      expect(client.requests, hasLength(2), reason: 'no automatic retry');
      expect(client.active, 0);
      expect(client.peak, 1);
      expect(loader.inFlightBytes, 0);
      expect(loader.pendingCount, 0);
      failed.dispose();
      queued.dispose();
      await loader.close();
      expect(loader.leasedEncodedBytes, 0);
    },
  );

  test(
    'cancelling prefetch retains its reservation until source cleanup finishes',
    () async {
      final client = ControlledClient();
      final loader = MediaImageLoader(
        client: client,
        maxActive: 4,
        maxPrefetch: 1,
      );
      final first = loader.acquire(
        request('prefetch-first'),
        priority: GalleryImagePriority.prefetch,
      );
      await flush();
      final pending = client.requests.single;
      final gate = pending.cancelGate = Completer<void>();
      pending.respond();
      await flush();
      first.dispose();
      final next = loader.acquire(
        request('prefetch-next'),
        priority: GalleryImagePriority.prefetch,
      );
      final visible = loader.acquire(request('visible'));
      await flush();
      expect(pending.cancelStarted, isTrue);
      expect(pending.done, isFalse);
      expect(client.requests, hasLength(2));
      expect(client.requests.last.request.url.path, '/visible');
      expect(loader.activeCount, 2);
      gate.complete();
      await flush();
      expect(pending.done, isTrue);
      expect(client.requests, hasLength(3));
      expect(client.requests.last.request.url.path, '/prefetch-next');
      client.requests[1].respond();
      client.requests[1].complete([1]);
      client.requests[2].respond();
      client.requests[2].complete([2]);
      await visible.result;
      await next.result;
      expect(client.peak, 2);
      visible.dispose();
      next.dispose();
      await loader.close();
    },
  );

  test(
    'fullscreen wins queue, prefetch leaves capacity and stale jobs disappear',
    () async {
      final client = ControlledClient();
      final loader = MediaImageLoader(
        client: client,
        maxActive: 2,
        maxPrefetch: 1,
      );
      final speculative = loader.acquire(
        request('prefetch'),
        priority: GalleryImagePriority.prefetch,
      );
      final obsolete = loader.acquire(
        request('obsolete'),
        priority: GalleryImagePriority.prefetch,
      );
      await flush();
      expect(client.requests, hasLength(1));
      obsolete.dispose();
      final visible = loader.acquire(request('visible'));
      final fullscreen = loader.acquire(
        request('fullscreen'),
        priority: GalleryImagePriority.fullscreen,
      );
      await flush();
      expect(client.requests[1].request.url.path, '/fullscreen');
      client.requests[1].respond();
      client.requests[1].complete([1]);
      await fullscreen.result;
      await flush();
      expect(client.requests.last.request.url.path, '/visible');
      speculative.dispose();
      visible.dispose();
      fullscreen.dispose();
      await loader.close();
      expect(loader.pendingCount, 0);
    },
  );

  test(
    'encoded hit avoids transport, revision changes miss and LRU evicts',
    () async {
      final client = ControlledClient();
      final cache = GalleryMemoryImageCache(maxBytes: 2, maxObjects: 2);
      final loader = MediaImageLoader(client: client, cache: cache);
      Future<void> load(String id) async {
        final lease = loader.acquire(request(id));
        await flush();
        client.requests.last.respond();
        client.requests.last.complete([1, 2]);
        await lease.result;
        lease.dispose();
        await flush();
      }

      await load('a');
      final hit = loader.acquire(request('a'));
      expect((await hit.result).byteLength, 2);
      hit.dispose();
      expect(client.requests, hasLength(1));
      await load('b');
      expect(await cache.get(request('a').key.storageKey), isNull);
      await loader.close();
    },
  );

  test(
    'body failure frees capacity and an oversized response is not cached',
    () async {
      final client = ControlledClient();
      final cache = GalleryMemoryImageCache();
      final loader = MediaImageLoader(
        client: client,
        cache: cache,
        maxActive: 1,
        maxPrefetch: 0,
        maxBodyBytes: 2,
        maxInFlightBytes: 4,
      );
      final oversized = loader.acquire(request('large'));
      await flush();
      client.requests.single.respond();
      client.requests.single.complete(Uint8List(3));
      await expectLater(
        oversized.result,
        throwsA(isA<GalleryImageBudgetException>()),
      );
      await flush();
      expect(loader.activeCount, 0);
      expect(await cache.get(request('large').key.storageKey), isNull);
      oversized.dispose();
      await loader.close();
    },
  );

  test(
    'closing a scope releases ready leases as well as pending operations',
    () async {
      final client = ControlledClient();
      final loader = MediaImageLoader(client: client);
      final lease = loader.acquire(request('ready'));
      await flush();
      client.requests.single.respond();
      client.requests.single.complete([1, 2, 3]);
      final image = await lease.result;
      expect(image.references, 1);
      expect(loader.leasedEncodedBytes, 3);
      await loader.close();
      expect(image.references, 0);
      expect(loader.leasedEncodedBytes, 0);
      lease.dispose();
    },
  );

  test('native file pins share the encoded budget with cache hits', () async {
    final client = ControlledClient();
    final cache = _FilePayloadCache();
    final loader = MediaImageLoader(
      client: client,
      cache: cache,
      maxBodyBytes: 6,
      maxInFlightBytes: 6,
    );
    final pins = <GalleryImageLease>[];
    for (final id in ['first', 'second']) {
      final lease = loader.acquire(request(id));
      pins.add(lease);
      await flush();
      client.requests.last.respond();
      client.requests.last.complete([1, 2, 3]);
      expect((await lease.result).bytes, isNull);
    }
    expect(loader.leasedEncodedBytes, 6);
    final key = request('cached').key.storageKey;
    cache.images[key] = GalleryEncodedImage.file('/encoded/cached', 1);
    final rejected = loader.acquire(request('cached'));
    await expectLater(
      rejected.result,
      throwsA(isA<GalleryImageBudgetException>()),
    );
    expect(client.requests, hasLength(2));
    expect(loader.leasedEncodedBytes, 6);
    rejected.dispose();
    pins.first.dispose();
    final accepted = loader.acquire(request('cached'));
    final image = await accepted.result;
    final duplicate = loader.acquire(request('cached'));
    expect(await duplicate.result, same(image));
    expect(loader.leasedEncodedBytes, 4);
    expect(image.references, 2);
    await loader.close();
    expect(image.references, 0);
    expect(loader.leasedEncodedBytes, 0);
  });

  test(
    'cache hit admission includes other bodies without counting self twice',
    () async {
      final client = ControlledClient();
      final cache = _FilePayloadCache();
      cache.images[request('cached').key.storageKey] = GalleryEncodedImage.file(
        '/encoded/cached',
        4,
      );
      final loader = MediaImageLoader(
        client: client,
        cache: cache,
        maxBodyBytes: 6,
        maxInFlightBytes: 6,
      );
      final transferring = loader.acquire(request('body'));
      await flush();
      final pending = client.requests.single;
      pending.respond();
      pending.body.add([1, 2, 3]);
      await flush();
      expect(loader.inFlightBytes, 3);
      final rejected = loader.acquire(request('cached'));
      await expectLater(
        rejected.result,
        throwsA(isA<GalleryImageBudgetException>()),
      );
      rejected.dispose();
      await pending.body.close();
      expect((await transferring.result).byteLength, 3);
      expect(loader.inFlightBytes, 0);
      expect(loader.leasedEncodedBytes, 3);
      transferring.dispose();
      final accepted = loader.acquire(request('cached'));
      expect((await accepted.result).byteLength, 4);
      expect(loader.leasedEncodedBytes, 4);
      expect(client.requests, hasLength(1));
      await loader.close();
    },
  );

  test(
    'timeout aborts transport and permits an explicit fresh retry',
    () async {
      final client = ControlledClient();
      final loader = MediaImageLoader(
        client: client,
        requestTimeout: const Duration(milliseconds: 10),
      );
      final lease = loader.acquire(request('timeout'));
      await expectLater(lease.result, throwsA(isA<TimeoutException>()));
      expect(client.requests.single.aborted, isTrue);
      expect(loader.activeCount, 0);
      final retry = loader.acquire(request('timeout'));
      await flush();
      client.requests.last.respond();
      client.requests.last.complete([1]);
      expect((await retry.result).bytes, [1]);
      lease.dispose();
      retry.dispose();
      await loader.close();
    },
  );
}
