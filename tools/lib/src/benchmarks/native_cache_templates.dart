// Frozen probe bodies retained from the former Python harness.
const nativeCacheWarm = r'''
import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import __CACHE_URI__;

Future<Map<String, String>> metadata(Directory root) async => {
  for (final item in await root.list().toList())
    if (item is File && item.path.endsWith('.json'))
      item.path: await item.readAsString(),
};

void main() {
  test('63 actual native warm hits', () async {
    final results = <Map<String, Object?>>[];
    final payload = base64Decode('iVBORw0KGgoAAAANSUhEUgAAAAgAAAAICAIAAABLbSncAAAAEElEQVR4nGNgYPiPAw0pCQCpcD/BFMrqcwAAAABJRU5ErkJggg==');
    for (var trial = 0; trial < 5; trial++) {
      final root = await Directory.systemTemp.createTemp('gallery-native-warm-');
      final cache = GalleryNativeImageCache(directory: root);
      try {
        for (var index = 0; index < 63; index++) {
          final image = await cache.write('scope:$index:revision1:256', Stream.value(payload));
          expect(image.filePath, isNotNull);
        }
        final before = await metadata(root);
        final hits = <double>[];
        final total = Stopwatch()..start();
        for (var index = 0; index < 63; index++) {
          final watch = Stopwatch()..start();
          final image = await cache.get('scope:$index:revision1:256');
          expect(image, isNotNull);
          image!.retain();
          expect(image.byteLength, payload.length);
          image.release();
          hits.add(watch.elapsedMicroseconds / 1000);
        }
        total.stop();
        final after = await metadata(root);
        final close = Stopwatch()..start();
        await cache.close();
        close.stop();
        final persisted = await metadata(root);
        results.add({
          'trial': trial, 'hits': 63, 'hit_ms': hits,
          'total_hit_ms': total.elapsedMicroseconds / 1000,
          'close_ms': close.elapsedMicroseconds / 1000,
          'metadata_changed_on_hits': before.keys.where((key) => before[key] != after[key]).length,
          'metadata_changed_by_close': before.keys.where((key) => before[key] != persisted[key]).length,
        });
      } finally {
        await cache.close();
        await root.delete(recursive: true);
      }
    }
    await File(__OUTPUT__).writeAsString(jsonEncode(results));
  }, timeout: const Timeout(Duration(minutes: 3)));
}
''';
const nativeCacheCold = r'''
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'package:flutter_test/flutter_test.dart';
import __CACHE_URI__;

void main() {
  test('63 actual native cold writes', () async {
    final results = <Map<String, Object?>>[];
    final payload = await File(__PAYLOAD__).readAsBytes();
    for (var trial = 0; trial < 5; trial++) {
      final root = await Directory(__PARENT__).createTemp('gallery-cold-probe-');
      final cache = GalleryNativeImageCache(directory: root);
      final paths = <String>[];
      final release = <void Function()>[];
      try {
        var next = 0;
        final writes = <double>[];
        final total = Stopwatch()..start();
        await Future.wait(List.generate(__CONCURRENCY__, (_) async {
          while (next < 63) {
            final index = next++;
            final watch = Stopwatch()..start();
            final image = await cache.write(
              'scope:$index:revision1:256',
              Stream.fromIterable([
                for (var offset = 0; offset < payload.length; offset += 8192)
                  payload.sublist(offset, math.min(offset + 8192, payload.length)),
              ]),
            );
            image.retain();
            release.add(image.release);
            writes.add(watch.elapsedMicroseconds / 1000);
            expect(image.filePath, isNotNull);
            expect(image.byteLength, payload.length);
            paths.add(image.filePath!);
          }
        }));
        total.stop();
        // Published files must already be complete and readable, not just
        // eventual metadata promises. Validation is outside measured writes.
        for (final path in paths) {
          expect(await File(path).readAsBytes(), payload);
        }
        expect((await root.list().toList()).where((f) => f.path.endsWith('.part')), isEmpty);
        for (final unpin in release) { unpin(); }
        release.clear();
        final close = Stopwatch()..start();
        await cache.close();
        close.stop();
        final reopened = GalleryNativeImageCache(directory: root);
        try {
          for (var index = 0; index < 63; index++) {
            final image = await reopened.get('scope:$index:revision1:256');
            expect(image, isNotNull);
            expect(await File(image!.filePath!).readAsBytes(), payload);
          }
        } finally { await reopened.close(); }
        results.add({
          'trial': trial, 'writes': 63, 'write_ms': writes,
          'concurrency': __CONCURRENCY__, 'payload_bytes': payload.length,
          'fixture_directory': root.path,
          'total_write_ms': total.elapsedMicroseconds / 1000,
          'close_ms': close.elapsedMicroseconds / 1000,
          'complete_immediate_payloads_verified': paths.length,
          'reopened_hits_verified': 63,
        });
      } finally {
        for (final unpin in release) { unpin(); }
        await cache.close();
        await root.delete(recursive: true);
      }
    }
    await File(__OUTPUT__).writeAsString(jsonEncode(results));
  }, timeout: const Timeout(Duration(minutes: 3)));
}
''';
