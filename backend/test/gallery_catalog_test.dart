// Real files exercise stat revisions and the fixed-size persisted epoch.
// ignore_for_file: avoid_slow_async_io
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dslideshow_backend/src/service/gallery/gallery_catalog_service.dart';
import 'package:dslideshow_backend/src/service/gallery/gallery_media_publisher.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';

import 'helpers/capture_logs.dart';

void main() {
  late Directory root;
  late Directory media;
  late Directory metadata;
  late GalleryCatalogService service;
  setUp(() async {
    root = await Directory.systemTemp.createTemp('gallery-catalog-test-');
    media = await Directory('${root.path}/media').create();
    metadata = Directory('${root.path}/gallery');
    service = GalleryCatalogService(originals: media, stateDirectory: metadata);
  });
  tearDown(() async {
    await service.close();
    await root.delete(recursive: true);
  });
  Future<void> write(String name, String value) => File('${media.path}/$name').writeAsString(value).then((_) {});
  test('typed catalog escapes names, retains directories and excludes only reserved staging', () async {
    await Directory('${media.path}/album').create();
    await write('album/a"b.jpg', 'photo');
    await write('movie.mp4', 'video');
    await write('.upload-${'a' * 32}.part', 'partial');
    await write('ordinary.part', 'user');
    final catalog = await service.catalog();
    final decoded = GalleryCatalog.fromJson(jsonDecode(jsonEncode(catalog.toJson())) as Map<String, dynamic>);
    expect(decoded.entries.map((e) => e.path), ['album', 'album/a"b.jpg', 'movie.mp4', 'ordinary.part']);
    expect(decoded.entries.first.kind, GalleryEntryKind.directory);
    expect(decoded.entries[1].thumbnailSupported, true);
    expect(decoded.entries[2].thumbnailSupported, true);
  });
  test('path IDs and stat revisions survive restart and forced invalidation persists', () async {
    await write('one.jpg', 'source');
    final firstSnapshot = await service.catalog();
    final first = firstSnapshot.entries.single;
    expect(first.mediaId, '703239fa3dea919c8ec4be274679b0c1466a9d1c12327b0804a4d14716394f01');
    final scanned = await service.refresh(
      const GalleryRefreshRequest(operationId: 'scan', mode: GalleryRefreshMode.scan),
    );
    expect(scanned.entries.single.sourceRevision, first.sourceRevision);
    await service.close();
    service = GalleryCatalogService(originals: media, stateDirectory: metadata);
    final restarted = await service.catalog();
    expect(restarted.entries.single.mediaId, first.mediaId);
    expect(restarted.entries.single.sourceRevision, first.sourceRevision);
    expect(restarted.catalogRevision, firstSnapshot.catalogRevision);
    final forced = await service.refresh(
      const GalleryRefreshRequest(operationId: 'force', mode: GalleryRefreshMode.forceInvalidate),
    );
    expect(forced.entries.single.mediaId, first.mediaId);
    expect(forced.entries.single.sourceRevision, isNot(first.sourceRevision));
    expect(
      (await service.refresh(
        const GalleryRefreshRequest(operationId: 'force', mode: GalleryRefreshMode.forceInvalidate),
      )).catalogRevision,
      forced.catalogRevision,
    );
    await service.close();
    service = GalleryCatalogService(originals: media, stateDirectory: metadata);
    final afterForceRestart = await service.catalog();
    expect(afterForceRestart.catalogRevision, forced.catalogRevision);
    expect(afterForceRestart.entries.single.sourceRevision, forced.entries.single.sourceRevision);
    final newForce = await service.refresh(
      const GalleryRefreshRequest(operationId: 'force', mode: GalleryRefreshMode.forceInvalidate),
    );
    expect(
      newForce.entries.single.sourceRevision,
      isNot(forced.entries.single.sourceRevision),
      reason: 'Completed refresh IDs are remembered only in memory',
    );
  });
  test('path identity survives replacement and recreation but changes with the path', () async {
    await write('one.jpg', 'first');
    final first = (await service.catalog()).entries.single;
    await write('one.jpg', 'a different replacement');
    final replaced = (await service.refresh(
      const GalleryRefreshRequest(operationId: 'replace', mode: GalleryRefreshMode.scan),
    )).entries.single;
    expect(replaced.mediaId, first.mediaId);
    expect(replaced.sourceRevision, isNot(first.sourceRevision));
    await File('${media.path}/one.jpg').delete();
    expect(
      (await service.refresh(const GalleryRefreshRequest(operationId: 'remove', mode: GalleryRefreshMode.scan)))
          .entries,
      isEmpty,
    );
    await write('one.jpg', 'recreated with different bytes again');
    final recreated = (await service.refresh(
      const GalleryRefreshRequest(operationId: 'recreate', mode: GalleryRefreshMode.scan),
    )).entries.single;
    expect(recreated.mediaId, first.mediaId);
    expect(recreated.sourceRevision, isNot(replaced.sourceRevision));
    await File('${media.path}/one.jpg').rename('${media.path}/renamed.jpg');
    final renamed = (await service.refresh(
      const GalleryRefreshRequest(operationId: 'rename', mode: GalleryRefreshMode.scan),
    )).entries.single;
    expect(renamed.mediaId, '36010001ecafccc1c9c2323838db7ac436faa337900b15a5c5a473277d03acf7');
    await expectLater(
      service.resolve(first.mediaId),
      throwsA(isA<GalleryCatalogFailure>().having((error) => error.code, 'code', GalleryErrorCode.notFound)),
    );
  });

  test('adding files and rescanning never expands or rewrites persisted state', () async {
    await service.catalog();
    final epoch = File('${metadata.path}/catalog.epoch');
    final bytes = await epoch.readAsBytes();
    final before = await epoch.stat();
    expect(bytes, hasLength(32));
    await Directory('${media.path}/album').create();
    await write('one.jpg', 'one');
    await write('album/two.jpg', 'two');
    final added = await service.refresh(
      const GalleryRefreshRequest(operationId: 'added', mode: GalleryRefreshMode.scan),
    );
    expect(added.entries.map((entry) => entry.path), ['album', 'album/two.jpg', 'one.jpg']);
    final unchanged = await service.refresh(
      const GalleryRefreshRequest(operationId: 'unchanged', mode: GalleryRefreshMode.scan),
    );
    expect(unchanged.catalogRevision, added.catalogRevision);
    expect(await epoch.readAsBytes(), bytes);
    final after = await epoch.stat();
    expect(after.modified, before.modified);
    expect(after.changed, before.changed);
    expect(await metadata.list().map((entry) => path.basename(entry.path)).toList(), ['catalog.epoch']);
  });

  test(
    'failed forced invalidation preserves the live index and cleans its temporary file',
    () => captureLogs((records) async {
      await write('one.jpg', 'retained original');
      final before = await service.catalog();
      final epoch = File('${metadata.path}/catalog.epoch');
      final saved = await epoch.readAsString();
      await epoch.delete();
      await Directory(epoch.path).create();
      const request = GalleryRefreshRequest(operationId: 'force-failure', mode: GalleryRefreshMode.forceInvalidate);
      await expectLater(service.refresh(request), throwsA(isA<FileSystemException>()));
      expect((await service.catalog()).catalogRevision, before.catalogRevision);
      expect(await File('${media.path}/one.jpg').readAsString(), 'retained original');
      expect(await metadata.list().map((entry) => path.basename(entry.path)).toList(), ['catalog.epoch']);
      final warning = records.singleWhere(
        (record) => record.message.startsWith('Gallery invalidation state write failed'),
      );
      expect(warning.level, Level.WARNING);
      expect(warning.message, isNot(contains(root.path)));
      expect(warning.error, isA<FileSystemException>());
      expect(warning.stackTrace.toString(), contains('gallery_catalog_service.dart'));
      await Directory(epoch.path).delete();
      await epoch.writeAsString(saved);
      final retried = await service.refresh(request);
      expect(retried.entries.single.sourceRevision, isNot(before.entries.single.sourceRevision));
    }),
  );

  test('publisher waits for stream completion and replaces a ready source atomically', () async {
    await write('one.jpg', 'old');
    final old = (await service.catalog()).entries.single;
    final subscribed = Completer<void>();
    final bytes = StreamController<List<int>>(onListen: subscribed.complete);
    final publishing = GalleryMediaPublisher(originals: media).publish(bytes.stream, 'one.jpg');
    await subscribed.future;
    bytes.add(utf8.encode('new'));
    expect(await File('${media.path}/one.jpg').readAsString(), 'old');
    expect((await service.resolve(old.mediaId, revision: old.sourceRevision)).entry.sourceRevision, old.sourceRevision);
    await bytes.close();
    await publishing;
    expect(await File('${media.path}/one.jpg').readAsString(), 'new');
    final next = await service.refresh(const GalleryRefreshRequest(operationId: 'scan', mode: GalleryRefreshMode.scan));
    expect(next.entries.single.mediaId, old.mediaId);
    expect(next.entries.single.sourceRevision, isNot(old.sourceRevision));
    await expectLater(
      service.resolve(old.mediaId, revision: old.sourceRevision),
      throwsA(isA<GalleryCatalogFailure>().having((e) => e.code, 'code', GalleryErrorCode.revisionMismatch)),
    );
    expect((await media.list().toList()).length, 1);
    expect(await metadata.list().map((entry) => path.basename(entry.path)).toList(), ['catalog.epoch']);
  });
  test('markDirty preserves unchanged revisions and creates no notification files', () async {
    await write('one.jpg', 'old');
    final before = await service.catalog();
    service.markDirty();
    service.markDirty();
    final after = await service.catalog();
    expect(after.catalogRevision, before.catalogRevision);
    expect(after.entries.single.mediaId, before.entries.single.mediaId);
    expect(after.entries.single.sourceRevision, before.entries.single.sourceRevision);
    expect(await metadata.list().map((entry) => path.basename(entry.path)).toList(), ['catalog.epoch']);
  });
  test(
    'invalid small state keeps path identity and changes cached source revisions',
    () => captureLogs((records) async {
      await write('one.jpg', 'old');
      final before = await service.catalog();
      await service.close();
      await File('${metadata.path}/catalog.epoch').writeAsString('broken');
      service = GalleryCatalogService(originals: media, stateDirectory: metadata);
      final after = await service.catalog();
      expect(after.entries.single.mediaId, before.entries.single.mediaId);
      expect(after.entries.single.sourceRevision, isNot(before.entries.single.sourceRevision));
      final warning = records.singleWhere((record) => record.message.startsWith('Gallery invalidation state invalid'));
      expect(warning.level, Level.WARNING);
      expect(warning.message, isNot(contains(root.path)));
      expect(warning.error, isNull);
      expect((await File('${metadata.path}/catalog.epoch').readAsBytes()).length, 32);
    }),
  );
}
