import 'dart:convert';

import 'package:dslideshow_common/gallery.dart';
import 'package:test/test.dart';

void main() {
  test('catalog roundtrip preserves source identity and thumbnail policy', () {
    const catalog = GalleryCatalog(
      catalogRevision: 'snapshot',
      capabilities: [GalleryCapability.thumbnails],
      thumbnailPolicy: GalleryThumbnailPolicy(
        version: 1,
        revision: 'render-settings',
        sizes: [GalleryThumbnailSize.small],
      ),
      entries: [
        GalleryEntry(
          mediaId: 'id',
          path: 'album/a"b.jpg',
          name: 'a"b.jpg',
          kind: GalleryEntryKind.image,
          sourceRevision: 'revision',
          thumbnailSupported: true,
        ),
      ],
    );
    final restored = GalleryCatalog.fromJson(
      jsonDecode(jsonEncode(catalog.toJson())) as Map<String, dynamic>,
    );
    expect(restored.toJson(), catalog.toJson());
    expect(restored.toJson(), isNot(contains('serverId')));
    expect(() => restored.entries.clear(), throwsUnsupportedError);
    expect(restored.thumbnailPolicy!.sizes.single.pixels, 256);
    expect(restored.thumbnailPolicy!.revision, 'render-settings');
    expect(restored.thumbnailPolicy!.identity, '1-render-settings');
  });
  test(
    'unknown future enums remain explicit rather than becoming supported',
    () {
      final entry = GalleryEntry.fromJson({
        'mediaId': 'id',
        'path': 'x',
        'name': 'x',
        'kind': 'future',
        'sourceRevision': null,
      });
      expect(entry.kind, GalleryEntryKind.unknown);
      expect(entry.thumbnailSupported, false);
      final policy = GalleryThumbnailPolicy.fromJson({
        'version': 1,
        'sizes': [8192],
      });
      expect(policy.sizes, [GalleryThumbnailSize.unknown]);
      expect(policy.revision, '');
      expect(policy.identity, '1');
    },
  );
  test(
    'unknown refresh mode is rejected instead of invalidating a catalog',
    () {
      expect(
        () => GalleryRefreshRequest.fromJson({
          'operationId': 'id',
          'mode': 'typo',
        }),
        throwsArgumentError,
      );
      expect(
        GalleryRefreshRequest.fromJson({'operationId': 'id', 'mode': 'scan'})
            .mode,
        GalleryRefreshMode.scan,
      );
    },
  );
}
