import 'dart:convert';

import 'package:config_app/src/gallery/gallery_image_widget.dart';
import 'package:config_app/src/gallery/media_image_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'gallery_image_loader_test.dart' show ControlledClient, request;

void main() {
  final png = base64Decode(
    'iVBORw0KGgoAAAANSUhEUgAAAAgAAAAICAIAAABLbSncAAAAEElEQVR4nGNgYPiPAw0pCQCpcD/BFMrqcwAAAABJRU5ErkJggg==',
  );

  for (final headersReceived in [false, true]) {
    testWidgets(
      'real ImageCache does not retain HTTP after last widget lease; headers=$headersReceived',
      (tester) async {
        final client = ControlledClient();
        final loader = MediaImageLoader(client: client);
        final pool = GalleryDecodePool();
        final imageCache = PaintingBinding.instance.imageCache;
        imageCache.clear();
        imageCache.clearLiveImages();
        Widget image() => MaterialApp(
          home: GalleryImage(
            loader: loader,
            decodePool: pool,
            request: request('photo'),
            errorBuilder: (_, retry) => const Text('failed'),
          ),
        );
        await tester.pumpWidget(image());
        await tester.pump();
        expect(client.requests, hasLength(1));
        if (headersReceived) {
          client.requests.single.respond();
          client.requests.single.body.add([1, 2]);
          await tester.pump();
        }
        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump();
        expect(client.requests.single.aborted, isTrue);
        expect(loader.activeCount, 0);
        expect(loader.pendingCount, 0);
        expect(imageCache.pendingImageCount, 0);
        // Returning creates one fresh request rather than receiving a poisoned
        // pending completer from Flutter's actual cache.
        await tester.pumpWidget(image());
        await tester.pump();
        expect(client.requests, hasLength(2));
        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump();
        pool.close();
        await loader.close();
        expect(tester.takeException(), isNull);
      },
    );
  }

  testWidgets(
    'malformed encoded hit is invalidated and explicit retry fetches a valid image',
    (tester) async {
      final client = ControlledClient();
      final cache = GalleryMemoryImageCache();
      final imageRequest = request('corrupt');
      await cache.write(
        imageRequest.key.storageKey,
        Stream.value(List.filled(png.length, 0)),
      );
      final loader = MediaImageLoader(client: client, cache: cache);
      final pool = GalleryDecodePool();
      final imageCache = PaintingBinding.instance.imageCache;
      imageCache.clear();
      imageCache.clearLiveImages();
      await tester.pumpWidget(
        MaterialApp(
          home: GalleryImage(
            loader: loader,
            decodePool: pool,
            request: imageRequest,
            errorBuilder: (_, retry) =>
                TextButton(onPressed: retry, child: const Text('Retry image')),
          ),
        ),
      );
      for (
        var i = 0;
        i < 20 && find.text('Retry image').evaluate().isEmpty;
        i++
      ) {
        await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 20)),
        );
        await tester.pump();
      }
      expect(find.text('Retry image'), findsOneWidget);
      expect(client.requests, isEmpty, reason: 'the initial source was a hit');
      expect(await cache.get(imageRequest.key.storageKey), isNull);
      await tester.tap(find.text('Retry image'));
      await tester.pump();
      expect(client.requests, hasLength(1));
      client.requests.single.respond();
      client.requests.single.complete(png);
      for (var i = 0; i < 20 && find.byType(RawImage).evaluate().isEmpty; i++) {
        await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 20)),
        );
        await tester.pump();
      }
      expect(find.byType(RawImage), findsOneWidget);
      expect(find.text('Retry image'), findsNothing);
      expect(client.requests, hasLength(1));
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
      pool.close();
      await loader.close();
      expect(loader.leasedEncodedBytes, 0);
      imageCache.clear();
      imageCache.clearLiveImages();
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'decoded local payload is reused after rebuild and closing releases source leases',
    (tester) async {
      final client = ControlledClient();
      final loader = MediaImageLoader(client: client);
      final pool = GalleryDecodePool();
      final imageCache = PaintingBinding.instance.imageCache;
      final previousBudget = imageCache.maximumSizeBytes;
      imageCache.maximumSizeBytes = 0;
      addTearDown(() => imageCache.maximumSizeBytes = previousBudget);
      Widget image() => MaterialApp(
        home: GalleryImage(
          loader: loader,
          decodePool: pool,
          request: request('cached'),
          errorBuilder: (_, retry) => const Text('failed'),
        ),
      );
      await tester.pumpWidget(image());
      await tester.pump();
      client.requests.single.respond();
      client.requests.single.complete(png);
      await tester.pump();
      for (var i = 0; i < 10 && find.byType(RawImage).evaluate().isEmpty; i++) {
        await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 20)),
        );
        await tester.pump();
      }
      expect(find.byType(RawImage), findsOneWidget);
      // Even when Flutter cannot retain this decoded original, the live stream
      // is handed directly to RawImage instead of resolving a second provider.
      expect(imageCache.currentSize, 0);
      expect(find.text('failed'), findsNothing);
      await tester.pumpWidget(image());
      await tester.pump();
      expect(client.requests, hasLength(1));
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
      expect(loader.leasedEncodedBytes, 0);
      pool.close();
      await loader.close();
      PaintingBinding.instance.imageCache.clear();
      PaintingBinding.instance.imageCache.clearLiveImages();
      expect(tester.takeException(), isNull);
    },
  );
}
