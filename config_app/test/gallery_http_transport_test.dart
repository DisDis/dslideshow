import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:config_app/src/gallery/media_image_loader.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/io_client.dart';

class _RealHttpOverrides extends HttpOverrides {}

class _UnwritableCache implements GalleryEncodedCache {
  var writes = 0;
  var closed = false;

  @override
  Future<GalleryEncodedImage?> get(String key) async => null;

  @override
  Future<GalleryEncodedImage> write(String key, Stream<List<int>> body) async {
    writes++;
    throw const FileSystemException(
      'Unable to open cache staging file',
      '',
      OSError('No space left on device', 28),
    );
  }

  @override
  Future<void> remove(String key) async {}

  @override
  Future<void> close() async => closed = true;
}

void main() {
  test(
    'real IO response is aborted when cache staging fails before reading body',
    () async {
      await HttpOverrides.runWithHttpOverrides(() async {
        final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
        final cancelled = Completer<void>();
        var requestCount = 0;
        var generatedBytes = 0;
        Timer? producer;
        server.listen((request) async {
          requestCount++;
          request.response.headers.contentType = ContentType.binary;
          request.response.contentLength = 16 << 20;
          late StreamController<List<int>> source;
          source = StreamController<List<int>>(
            onListen: () {
              producer = Timer.periodic(const Duration(milliseconds: 5), (_) {
                generatedBytes += 16384;
                source.add(Uint8List(16384));
              });
            },
            onCancel: () {
              producer?.cancel();
              if (!cancelled.isCompleted) cancelled.complete();
            },
          );
          try {
            await request.response.addStream(source.stream);
            await request.response.close();
          } catch (_) {
            // The disconnected body is the externally observed cancellation.
          }
        });
        final cache = _UnwritableCache();
        final loader = MediaImageLoader(
          client: IOClient(HttpClient()),
          cache: cache,
          maxActive: 1,
          maxPrefetch: 0,
        );
        final lease = loader.acquire(
          GalleryImageRequest(
            key: const GalleryImageKey(
              scope: 'io',
              mediaId: 'uncached',
              revision: '1',
              variant: GalleryImageVariant.original,
            ),
            uri: Uri.parse('http://127.0.0.1:${server.port}/uncached'),
          ),
        );
        try {
          await expectLater(
            lease.result,
            throwsA(
              isA<FileSystemException>().having(
                (error) => error.osError?.errorCode,
                'disk error',
                28,
              ),
            ),
          );
          // Keep the failed consumer alive: cancellation must come from the
          // failure path, not from widget disposal or loader.close().
          await cancelled.future.timeout(const Duration(seconds: 5));
          await Future<void>.delayed(const Duration(milliseconds: 30));
          expect(requestCount, 1, reason: 'a cache error must not auto-retry');
          expect(cache.writes, 1);
          expect(generatedBytes, lessThan(16 << 20));
          expect(loader.activeCount, 0);
          expect(loader.pendingCount, 0);
          expect(loader.inFlightBytes, 0);
          expect(loader.leasedEncodedBytes, 0);
        } finally {
          lease.dispose();
          producer?.cancel();
          await loader.close();
          await server.close(force: true);
        }
        expect(cache.closed, isTrue);
      }, _RealHttpOverrides());
    },
  );

  test(
    'real IO abort cancels loopback response body and releases transport slot',
    () async {
      await HttpOverrides.runWithHttpOverrides(() async {
        final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
        final cancelled = Completer<void>();
        var generatedBytes = 0;
        Timer? producer;
        server.listen((request) async {
          request.response.headers.contentType = ContentType.binary;
          request.response.contentLength = 16 << 20;
          late StreamController<List<int>> source;
          source = StreamController<List<int>>(
            onListen: () {
              producer = Timer.periodic(const Duration(milliseconds: 5), (_) {
                generatedBytes += 16384;
                source.add(Uint8List(16384));
              });
            },
            onCancel: () async {
              producer?.cancel();
              if (!cancelled.isCompleted) cancelled.complete();
            },
          );
          try {
            await request.response.addStream(source.stream);
            await request.response.close();
          } catch (_) {
            // A disconnected client is the observed behavior under test.
          }
        });
        final loader = MediaImageLoader(
          client: IOClient(HttpClient()),
          maxActive: 1,
          maxPrefetch: 0,
        );
        final lease = loader.acquire(
          GalleryImageRequest(
            key: const GalleryImageKey(
              scope: 'io',
              mediaId: 'photo',
              revision: '1',
              variant: GalleryImageVariant.original,
            ),
            uri: Uri.parse('http://127.0.0.1:${server.port}/photo'),
          ),
        );
        try {
          final deadline = DateTime.now().add(const Duration(seconds: 5));
          while (loader.inFlightBytes == 0 &&
              DateTime.now().isBefore(deadline)) {
            await Future<void>.delayed(const Duration(milliseconds: 10));
          }
          expect(loader.inFlightBytes, greaterThan(0));
          lease.dispose();
          await cancelled.future.timeout(const Duration(seconds: 5));
          await loader.close();
          expect(generatedBytes, lessThan(16 << 20));
          expect(loader.activeCount, 0);
          expect(loader.pendingCount, 0);
        } finally {
          lease.dispose();
          producer?.cancel();
          await loader.close();
          await server.close(force: true);
        }
      }, _RealHttpOverrides());
    },
  );
}
