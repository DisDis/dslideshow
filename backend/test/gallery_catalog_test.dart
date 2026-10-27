import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dslideshow_backend/src/service/gallery/gallery_catalog_service.dart';
import 'package:dslideshow_backend/src/service/gallery/gallery_publication.dart';
import 'package:dslideshow_backend/src/service/gallery/gallery_media_publisher.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:test/test.dart';

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
  Future<void> write(String name, String value) =>
      File('${media.path}/$name').writeAsString(value).then((_) {});
  test('typed catalog escapes names, retains directories and excludes only reserved staging', () async {
    await Directory('${media.path}/album').create();
    await write('album/a"b.jpg', 'photo');
    await write('movie.mp4', 'video');
    await write('.upload-${'a' * 32}.part', 'partial');
    await write('ordinary.part', 'user');
    final catalog = await service.catalog();
    final decoded = GalleryCatalog.fromJson(
      jsonDecode(jsonEncode(catalog.toJson())) as Map<String, dynamic>,
    );
    expect(decoded.entries.map((e) => e.path), [
      'album',
      'album/a"b.jpg',
      'movie.mp4',
      'ordinary.part',
    ]);
    expect(decoded.entries.first.kind, GalleryEntryKind.directory);
    expect(decoded.entries[1].thumbnailSupported, true);
    expect(decoded.entries[2].thumbnailSupported, true);
  });
  test('scan/restart preserve identity; force operation is idempotent and changes generations', () async {
    await write('one.jpg', 'source');
    final first = (await service.catalog()).entries.single;
    final scanned = await service.refresh(
      const GalleryRefreshRequest(
        operationId: 'scan',
        mode: GalleryRefreshMode.scan,
      ),
    );
    expect(scanned.entries.single.sourceRevision, first.sourceRevision);
    await service.close();
    service = GalleryCatalogService(originals: media, stateDirectory: metadata);
    expect((await service.catalog()).entries.single.mediaId, first.mediaId);
    final forced = await service.refresh(
      const GalleryRefreshRequest(
        operationId: 'force',
        mode: GalleryRefreshMode.forceInvalidate,
      ),
    );
    expect(forced.entries.single.mediaId, first.mediaId);
    expect(forced.entries.single.sourceRevision, isNot(first.sourceRevision));
    expect(
      (await service.refresh(
        const GalleryRefreshRequest(
          operationId: 'force',
          mode: GalleryRefreshMode.forceInvalidate,
        ),
      )).catalogRevision,
      forced.catalogRevision,
    );
  });
  test('publisher waits for stream completion and replaces a ready source atomically', () async {
    await write('one.jpg', 'old');
    final old = (await service.catalog()).entries.single;
    final bytes = StreamController<List<int>>();
    final publishing = GalleryMediaPublisher(
      originals: media,
      stateDirectory: metadata,
    ).publish(bytes.stream, 'one.jpg');
    bytes.add(utf8.encode('new'));
    await Future<void>.delayed(Duration.zero);
    expect(await File('${media.path}/one.jpg').readAsString(), 'old');
    await bytes.close();
    await publishing;
    expect(await File('${media.path}/one.jpg').readAsString(), 'new');
    final next = await service.refresh(
      const GalleryRefreshRequest(
        operationId: 'scan',
        mode: GalleryRefreshMode.scan,
      ),
    );
    expect(next.entries.single.mediaId, old.mediaId);
    expect(next.entries.single.sourceRevision, isNot(old.sourceRevision));
    await expectLater(
      service.resolve(old.mediaId, revision: old.sourceRevision),
      throwsA(
        isA<GalleryCatalogFailure>().having(
          (e) => e.code,
          'code',
          GalleryErrorCode.revisionMismatch,
        ),
      ),
    );
    expect((await media.list().toList()).length, 1);
  });
  test(
    'overlapping publications cannot clear each others pending state',
    () async {
      await write('one.jpg', 'old');
      final entry = (await service.catalog()).entries.single;
      final a = await GalleryPublication.begin(metadata, 'one.jpg');
      final b = await GalleryPublication.begin(metadata, 'one.jpg');
      await a.finish();
      await expectLater(
        service.resolve(entry.mediaId),
        throwsA(
          isA<GalleryCatalogFailure>().having(
            (e) => e.code,
            'code',
            GalleryErrorCode.unavailable,
          ),
        ),
      );
      await b.finish();
      expect(
        (await service.resolve(entry.mediaId)).entry.sourceRevision,
        isNot(entry.sourceRevision),
      );
    },
  );
  test(
    'corrupt metadata gets a fresh namespace instead of stale cache identities',
    () async {
      await write('one.jpg', 'old');
      final before = await service.catalog();
      await service.close();
      await File('${metadata.path}/catalog.json').writeAsString('broken');
      service = GalleryCatalogService(
        originals: media,
        stateDirectory: metadata,
      );
      final after = await service.catalog();
      expect(after.serverId, isNot(before.serverId));
      expect(
        after.entries.single.sourceRevision,
        isNot(before.entries.single.sourceRevision),
      );
    },
  );
}
