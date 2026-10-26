import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:config_app/src/gallery/gallery_encoded_cache_io.dart';
import 'package:config_app/src/gallery/gallery_image_widget.dart';
import 'package:config_app/src/gallery/gallery_payload_provider.dart';
import 'package:config_app/src/gallery/media_image_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

Stream<List<int>> body(String text) => Stream.value(utf8.encode(text));

Future<void> eventually(Future<bool> Function() condition) async {
  final deadline = DateTime.now().add(const Duration(seconds: 3));
  while (!await condition()) {
    if (DateTime.now().isAfter(deadline)) {
      fail('Asynchronous cache cleanup did not finish');
    }
    await Future<void>.delayed(const Duration(milliseconds: 5));
  }
}

void main() {
  late Directory root;
  final caches = <GalleryDiskImageCache>[];
  final pins = <GalleryEncodedImage>[];

  GalleryDiskImageCache cache({int bytes = 128, int objects = 4}) {
    final value = GalleryDiskImageCache(
      directory: root,
      maxBytes: bytes,
      maxObjects: objects,
    );
    caches.add(value);
    return value;
  }

  GalleryEncodedImage pin(GalleryEncodedImage image) {
    image.retain();
    pins.add(image);
    return image;
  }

  setUp(() async {
    root = await Directory.systemTemp.createTemp('gallery-encoded-test-');
  });

  Future<void> cleanup() async {
    for (final image in pins) {
      image.release();
    }
    pins.clear();
    for (final value in caches) {
      await value.close();
    }
    caches.clear();
    await Future<void>.delayed(const Duration(milliseconds: 20));
    await root.delete(recursive: true);
  }

  tearDown(cleanup);

  test(
    'publishes only complete bodies and persists no raw auth identity',
    () async {
      final value = cache();
      const key = 'http://server:8080/code=54321/private-photo/revision1';
      final controller = StreamController<List<int>>();
      final writing = value.write(key, controller.stream);
      controller.add([1, 2]);
      await eventually(
        () async => (await root.list().toList()).any(
          (file) => file.path.endsWith('.part'),
        ),
      );
      expect(await value.get(key), isNull);
      controller.add([3, 4]);
      await controller.close();
      final image = pin(await writing);
      expect(image.bytes, isNull);
      expect(image.byteLength, 4);
      expect(await File(image.filePath!).readAsBytes(), [1, 2, 3, 4]);
      expect((await value.get(key))!.filePath, image.filePath);
      final files = await root.list().toList();
      expect(files.where((file) => file.path.endsWith('.part')), isEmpty);
      final metadata = await File(
        files.singleWhere((file) => file.path.endsWith('.json')).path,
      ).readAsString();
      expect(metadata, isNot(contains('54321')));
      expect(metadata, isNot(contains('private-photo')));
      expect(metadata, isNot(contains('http://')));
    },
  );

  test(
    'a failed/cancelled body removes staging and never creates a hit',
    () async {
      final value = cache();
      final controller = StreamController<List<int>>();
      final writing = value.write('cancelled', controller.stream);
      final failure = expectLater(writing, throwsA(isA<StateError>()));
      controller.add([1, 2]);
      controller.addError(StateError('transport aborted'));
      await controller.close();
      await failure;
      expect(await value.get('cancelled'), isNull);
      expect(await root.list().toList(), isEmpty);
    },
  );

  test(
    'close cancels an idle incoming body and removes its temporary file',
    () async {
      final value = cache();
      var cancelled = false;
      final controller = StreamController<List<int>>(
        onCancel: () {
          cancelled = true;
        },
      );
      final writing = value.write('pending', controller.stream);
      final failure = expectLater(writing, throwsA(isA<StateError>()));
      controller.add([5]);
      await eventually(() async => (await root.list().toList()).isNotEmpty);
      await value.close();
      await failure;
      expect(cancelled, isTrue);
      expect(await root.list().toList(), isEmpty);
      await controller.close();
      expect(() => value.write('late', body('late')), throwsStateError);
    },
  );

  test('object/byte LRU survives reopening and get changes recency', () async {
    final first = cache(bytes: 10, objects: 2);
    await first.write('a', body('aaaa'));
    await first.write('b', body('bbbb'));
    await first.get('a');
    await first.close();
    final reopened = cache(bytes: 10, objects: 2);
    await reopened.write('c', body('cccc'));
    expect(await reopened.get('b'), isNull);
    expect(await reopened.get('a'), isNotNull);
    expect(await reopened.get('c'), isNotNull);
    expect(reopened.cachedObjects, 2);
    expect(reopened.cachedBytes, 8);
    await eventually(
      () async =>
          (await root.list().toList())
              .where((file) => file.path.endsWith('.body'))
              .length ==
          2,
    );
  });

  test(
    'warm hits leave durable metadata unchanged until graceful close',
    () async {
      final value = cache();
      await value.write('warm', body('complete'));
      final metadata = File(
        (await root.list().toList())
            .singleWhere((file) => file.path.endsWith('.json'))
            .path,
      );
      final before = await metadata.readAsString();
      final modified = await metadata.lastModified();
      for (var index = 0; index < 63; index++) {
        final image = await value.get('warm');
        expect(await File(image!.filePath!).readAsString(), 'complete');
      }
      await Future<void>.delayed(const Duration(milliseconds: 20));
      expect(await metadata.readAsString(), before);
      expect(await metadata.lastModified(), modified);
      expect(
        (await root.list().toList()).where(
          (file) => file.path.endsWith('.part'),
        ),
        isEmpty,
      );
      await value.close();
      final persisted =
          jsonDecode(await metadata.readAsString()) as Map<String, dynamic>;
      final original = jsonDecode(before) as Map<String, dynamic>;
      expect(persisted['accessed'], greaterThan(original['accessed'] as int));
      expect(persisted['file'], original['file']);
      expect(persisted['identity'], original['identity']);
    },
  );

  test(
    'in-memory hits protect LRU order and removed touches never resurrect',
    () async {
      final value = cache(objects: 2);
      await value.write('a', body('a'));
      await value.write('b', body('b'));
      await value.get('a');
      await value.write('c', body('c'));
      expect(await value.get('b'), isNull);
      expect(await value.get('a'), isNotNull);
      await value.remove('a');
      await value.close();
      final reopened = cache(objects: 2);
      expect(await reopened.get('a'), isNull);
      expect(await reopened.get('b'), isNull);
      expect(await reopened.get('c'), isNotNull);
    },
  );

  test(
    'warm hits and ownership cleanup work with read-only metadata directory',
    () async {
      final value = GalleryNativeImageCache(directory: root);
      addTearDown(value.close);
      final image = await value.write('warm', body('complete'));
      final metadata = File(
        (await root.list().toList())
            .singleWhere((file) => file.path.endsWith('.json'))
            .path,
      );
      final before = await metadata.readAsString();
      expect((await Process.run('chmod', ['500', root.path])).exitCode, 0);
      addTearDown(() async {
        await Process.run('chmod', ['700', root.path]);
      });
      for (var index = 0; index < 3; index++) {
        expect((await value.get('warm'))!.filePath, image.filePath);
      }
      await value.close().timeout(const Duration(seconds: 3));
      expect(await metadata.readAsString(), before);
      await Process.run('chmod', ['700', root.path]);
      final reopened = GalleryNativeImageCache(directory: root);
      addTearDown(reopened.close);
      expect(
        (await reopened.write('new', body('disk'))).filePath,
        isNotNull,
        reason: 'advisory recency failure must not retain the directory lock',
      );
      expect(await File(image.filePath!).readAsString(), 'complete');
    },
    skip: Platform.isLinux
        ? false
        : 'POSIX read-only metadata regression is Linux-only',
  );

  test(
    'eviction/replacement keep retained payloads until their last release',
    () async {
      final value = cache(bytes: 5, objects: 1);
      final first = pin(await value.write('same', body('old')));
      final replacement = pin(await value.write('same', body('new')));
      expect(first.filePath, isNot(replacement.filePath));
      expect(await File(first.filePath!).readAsString(), 'old');
      expect((await value.get('same'))!.filePath, replacement.filePath);
      first.release();
      pins.remove(first);
      await eventually(() async => !await File(first.filePath!).exists());
      expect(await File(replacement.filePath!).readAsString(), 'new');
      await value.remove('same');
      expect(await value.get('same'), isNull);
      expect(await File(replacement.filePath!).exists(), isTrue);
      replacement.release();
      pins.remove(replacement);
      await eventually(() async => !await File(replacement.filePath!).exists());
    },
  );

  test(
    'concurrent publication cannot delete an image before consumer retain',
    () async {
      final value = cache(objects: 1);
      final firstWrite = value.write('a', body('first'));
      final secondWrite = value.write('b', body('second'));
      final first = pin(await firstWrite);
      await secondWrite;
      // File I/O may publish either concurrent write first. Retire 'a'
      // explicitly so cleanup assertions do not assume a publication order.
      await value.remove('a');
      await Future<void>.delayed(const Duration(milliseconds: 20));
      expect(await File(first.filePath!).readAsString(), 'first');
      first.release();
      pins.remove(first);
      await eventually(() async => !await File(first.filePath!).exists());
    },
  );

  test(
    'oversized payloads remain valid for handoff and are not indexed',
    () async {
      final value = cache(bytes: 2);
      final image = pin(await value.write('large', body('oversized')));
      expect(await value.get('large'), isNull);
      expect(value.cachedObjects, 0);
      await Future<void>.delayed(const Duration(milliseconds: 20));
      expect(await File(image.filePath!).readAsString(), 'oversized');
      image.release();
      pins.remove(image);
      await eventually(() async => !await File(image.filePath!).exists());
    },
  );

  test(
    'unclaimed oversized/cancelled handoffs do not accumulate files',
    () async {
      final value = cache(bytes: 0, objects: 0);
      for (var index = 0; index < 15; index++) {
        await value.write('cancelled-$index', body('unclaimed'));
      }
      await eventually(() async => (await root.list().toList()).isEmpty);
      expect(value.cachedBytes, 0);
    },
  );

  test(
    'close preserves pinned transient files until decoder release',
    () async {
      final value = cache(bytes: 0);
      final image = pin(await value.write('large', body('decoder')));
      await value.close();
      expect(await File(image.filePath!).readAsString(), 'decoder');
      image.release();
      pins.remove(image);
      await eventually(() async => !await File(image.filePath!).exists());
    },
  );

  test(
    'reopening with a smaller budget preserves an old decoder pin',
    () async {
      final first = cache();
      final image = pin(
        await first.write('old-decoder', body('still decoding')),
      );
      await first.close();
      final second = cache(bytes: 0, objects: 0);
      expect(await second.get('old-decoder'), isNull);
      await second.close();
      expect(await File(image.filePath!).readAsString(), 'still decoding');
      image.release();
      pins.remove(image);
      await eventually(() async => !await File(image.filePath!).exists());
    },
  );

  test('startup drops partial/orphaned/corrupt entries and tolerates missing payload', () async {
    final first = cache();
    final image = await first.write('valid', body('body'));
    await first.close();
    await File(image.filePath!).delete();
    await File('${root.path}/interrupted.part').writeAsString('partial');
    await File('${root.path}/orphan.body').writeAsString('orphan');
    await File('${root.path}/bad.json').writeAsString('{broken');
    final reopened = cache();
    expect(await reopened.get('valid'), isNull);
    expect(await root.list().toList(), isEmpty);
  });

  test(
    'a metadata identity mismatch is a miss, never another scope image',
    () async {
      final first = cache();
      await first.write('scope-A', body('a'));
      await first.close();
      final metadata = File(
        (await root.list().toList())
            .singleWhere((file) => file.path.endsWith('.json'))
            .path,
      );
      final record =
          jsonDecode(await metadata.readAsString()) as Map<String, dynamic>;
      record['identity'] = List.filled(64, '0').join();
      await metadata.writeAsString(jsonEncode(record));
      final reopened = cache();
      expect(await reopened.get('scope-A'), isNull);
      expect(await reopened.get('scope-B'), isNull);
    },
  );

  test(
    'native ownership survives overlapping handles and pinned close',
    () async {
      final first = GalleryNativeImageCache(directory: root);
      final image = await first.write('persisted', body('disk'));
      image.retain();
      final second = GalleryNativeImageCache(
        directory: root,
        memoryMaxBytes: 4,
        memoryMaxObjects: 1,
      );
      addTearDown(() async {
        while (image.references > 0) {
          image.release();
        }
        await second.close();
        await first.close();
      });
      final fallback = await second.write('fallback', body('ram'));
      expect(fallback.filePath, isNull);
      expect(fallback.bytes, utf8.encode('ram'));
      expect(await File(image.filePath!).readAsString(), 'disk');
      var closed = false;
      final closing = first.close().then((_) {
        closed = true;
      });
      await Future<void>.delayed(const Duration(milliseconds: 10));
      expect(
        closed,
        isFalse,
        reason: 'directory lock must outlive the last decoder pin',
      );
      image.release();
      await closing.timeout(const Duration(seconds: 3));
      final reopened = GalleryNativeImageCache(directory: root);
      addTearDown(reopened.close);
      expect((await reopened.get('persisted'))!.filePath, image.filePath);
    },
  );

  test(
    'another process lock causes a bounded memory fallback without disk cleanup',
    () async {
      const lockScript = r'''
import fcntl,sys
with open(sys.argv[1], 'a+b') as handle:
    fcntl.lockf(handle, fcntl.LOCK_EX | fcntl.LOCK_NB)
    print('locked', flush=True)
    sys.stdin.readline()
''';
      final process = await Process.start('python3', [
        '-u',
        '-c',
        lockScript,
        '${root.path}/.owner.lock',
      ]);
      unawaited(process.stderr.drain<void>());
      var stopped = false;
      Future<void> stop() async {
        if (stopped) return;
        stopped = true;
        process.stdin.writeln('stop');
        await process.stdin.flush();
        await process.stdin.close();
        expect(await process.exitCode.timeout(const Duration(seconds: 5)), 0);
      }

      addTearDown(stop);
      expect(
        await process.stdout
            .transform(utf8.decoder)
            .transform(const LineSplitter())
            .first
            .timeout(const Duration(seconds: 5)),
        'locked',
      );
      final staged = File('${root.path}/foreign.part');
      await staged.writeAsString('owned by another process');
      final fallback = GalleryNativeImageCache(
        directory: root,
        memoryMaxBytes: 4,
        memoryMaxObjects: 1,
      );
      addTearDown(fallback.close);
      expect((await fallback.write('a', body('aa'))).filePath, isNull);
      await fallback.write('b', body('bb'));
      expect(await fallback.get('a'), isNull);
      expect((await fallback.get('b'))!.bytes, utf8.encode('bb'));
      expect(await staged.readAsString(), 'owned by another process');
      expect(
        (await root.list().toList()).where(
          (file) => file.path.endsWith('.json'),
        ),
        isEmpty,
      );
      await fallback.close();
      await stop();
      final owner = GalleryNativeImageCache(directory: root);
      addTearDown(owner.close);
      expect(
        (await owner.write('disk-again', body('complete'))).filePath,
        isNotNull,
      );
      expect(
        await staged.exists(),
        isFalse,
        reason: 'startup cleanup runs only after acquiring ownership',
      );
    },
    skip: Platform.isLinux
        ? false
        : 'POSIX fcntl interoperability regression is Linux-only',
  );

  test(
    'worker isolate cannot open or clean the root isolate disk cache',
    () async {
      final owner = GalleryNativeImageCache(directory: root);
      addTearDown(owner.close);
      final persisted = await owner.write('root', body('disk'));
      final sentinel = File('${root.path}/worker-must-not-clean.part');
      await sentinel.writeAsString('root-owned');
      final directory = root.path;
      final result = await Isolate.run(() async {
        final worker = GalleryNativeImageCache(
          directory: Directory(directory),
          memoryMaxBytes: 4,
          memoryMaxObjects: 1,
        );
        try {
          final image = await worker.write('worker', body('ram'));
          await worker.write('next', body('xx'));
          return [image.filePath == null, await worker.get('worker') == null];
        } finally {
          await worker.close();
        }
      });
      expect(result, [true, true]);
      expect(await sentinel.readAsString(), 'root-owned');
      expect(await File(persisted.filePath!).readAsString(), 'disk');
    },
  );

  test('failed disk initialization falls back and releases ownership after cleanup', () async {
    final seed = cache();
    final persisted = await seed.write('persisted', body('disk'));
    await seed.close();
    await File('${root.path}/.owner.lock').writeAsString('');
    final chmod = await Process.run('chmod', ['500', root.path]);
    expect(chmod.exitCode, 0);
    addTearDown(() async {
      await Process.run('chmod', ['700', root.path]);
    });
    final fallback = GalleryNativeImageCache(
      directory: root,
      maxBytes: 0,
      maxObjects: 0,
    );
    addTearDown(fallback.close);
    expect((await fallback.write('fallback', body('ram'))).filePath, isNull);
    // A failed initializer has no later sweep left that can race a new owner.
    await Process.run('chmod', ['700', root.path]);
    final recovered = GalleryNativeImageCache(directory: root);
    addTearDown(recovered.close);
    expect((await recovered.get('persisted'))!.filePath, persisted.filePath);
    await Future<void>.delayed(const Duration(milliseconds: 20));
    expect(await File(persisted.filePath!).readAsString(), 'disk');
    expect(
      (await recovered.write('new', body('complete'))).filePath,
      isNotNull,
    );
  }, skip: Platform.isLinux ? false : 'POSIX permission failure is Linux-only');

  test('native file cache feeds a live decoded frame without a decoded cache entry', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final png = base64Decode(
      'iVBORw0KGgoAAAANSUhEUgAAAAgAAAAICAIAAABLbSncAAAAEElEQVR4nGNgYPiPAw0pCQCpcD/BFMrqcwAAAABJRU5ErkJggg==',
    );
    final encoded = cache(bytes: 0, objects: 0);
    var transfers = 0;
    final loader = MediaImageLoader(
      cache: encoded,
      client: MockClient((request) async {
        transfers++;
        return http.Response.bytes(
          png,
          200,
          headers: {'content-type': 'image/png'},
        );
      }),
    );
    final pool = GalleryDecodePool(maxActive: 1);
    final imageCache = PaintingBinding.instance.imageCache;
    final previousBudget = imageCache.maximumSizeBytes;
    imageCache.maximumSizeBytes = 0;
    addTearDown(() {
      imageCache.maximumSizeBytes = previousBudget;
      imageCache.clear();
      imageCache.clearLiveImages();
    });
    const key = GalleryImageKey(
      scope: 'native-integration',
      mediaId: 'photo',
      revision: '1',
      variant: GalleryImageVariant.original,
    );
    final lease = loader.acquire(
      GalleryImageRequest(key: key, uri: Uri.parse('http://local-test/photo')),
    );
    final payload = await lease.result;
    final provider = galleryPayloadProvider(payload);
    expect(provider, isA<FileImage>());
    final releaseDecode = loader.retainForDecode(payload);
    late GalleryDecodedImage decoded;
    try {
      decoded = await pool
          .prepare(provider, () => true)
          .timeout(const Duration(seconds: 5));
    } finally {
      releaseDecode();
    }
    expect((decoded.frame!.image.width, decoded.frame!.image.height), (8, 8));
    final displayed = RawImage(image: decoded.frame!.image);
    expect(displayed.image, same(decoded.frame!.image));
    expect(encoded.cachedObjects, 0);
    expect(
      (await root.list().toList()).where((file) => file.path.endsWith('.body')),
      hasLength(1),
      reason: 'active source is pinned despite the zero evictable disk budget',
    );
    lease.dispose();
    await loader.close();
    expect(transfers, 1);
    expect(loader.leasedEncodedBytes, 0);
    expect(await root.list().toList(), isEmpty);
    // The decoded native frame no longer depends on the retired encoded file.
    expect((displayed.image!.width, displayed.image!.height), (8, 8));
    decoded.dispose();
    pool.close();
  });
}
