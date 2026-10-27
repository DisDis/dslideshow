import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/src/service/gallery/thumbnail_service.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:test/test.dart';

void main() {
  test(
    'gallery defaults preserve worker/cache limits and vanish from storage',
    () {
      final config = AppConfig.fromJson({});
      final thumbnail = config.gallery.thumbnail;
      expect(config.gallery.maxConcurrentMediaStreams, 12);
      expect(thumbnail.maxWorkers, 4);
      expect(thumbnail.maxQueued, 8);
      expect(thumbnail.maxWaiters, 32);
      expect(thumbnail.jpegQuality, 60);
      expect(thumbnail.frameSelectionFrames, 30);
      expect(thumbnail.sizes, GalleryThumbnailConfig.defaultSizes);
      expect(thumbnail.cacheMaxBytes, 512 * 1024 * 1024);
      expect(thumbnail.cacheMaxEntries, 2048);
      expect(config.toStorageJson(), isNot(contains('gallery')));
    },
  );

  test(
    'enum names and settings survive generated JSON and compact AppConfig',
    () {
      final config = AppConfig.fromJson({
        'gallery': {
          'maxConcurrentMediaStreams': 3,
          'thumbnail': {
            'sizes': ['large', 'small', 'small', 'future', 'unknown', 256],
            'jpegQuality': 45,
            'backgroundColor': '#abcdef',
            'frameSelectionFrames': 9,
            'maxWorkers': 2,
            'maxQueued': 0,
            'maxWaiters': 8,
            'cacheMaxBytes': 1024 * 1024,
            'cacheMaxEntries': 5,
            'timeoutSeconds': 7,
          },
        },
      });
      final thumbnail = config.gallery.thumbnail;
      expect(thumbnail.sizes, [
        GalleryThumbnailSize.small,
        GalleryThumbnailSize.large,
      ]);
      expect(thumbnail.toJson()['sizes'], ['small', 'large']);
      expect(thumbnail.backgroundColor, 0xffabcdef);
      final restored = AppConfig.fromJson(config.toStorageJson());
      expect(restored.gallery.toJson(), config.gallery.toJson());
      final policy = ThumbnailPolicy.fromConfig(thumbnail);
      expect(policy.maxWorkers, 2);
      expect(policy.maxQueued, 0);
      expect(policy.maxWaiters, 8);
      expect(policy.maxCacheBytes, 1024 * 1024);
      expect(policy.maxCacheObjects, 5);
      expect(policy.maxOutputBytes, 1024 * 1024);
      expect(policy.workerTimeout, const Duration(seconds: 7));
      expect(policy.catalogPolicy.sizes, thumbnail.sizes);
      final identity = policy.catalogPolicy.identity;
      thumbnail.sizes.clear();
      expect(policy.catalogPolicy.sizes, [
        GalleryThumbnailSize.small,
        GalleryThumbnailSize.large,
      ]);
      expect(policy.catalogPolicy.identity, identity);
    },
  );

  test(
    'missing, malformed and unknown values have explicit default behavior',
    () {
      for (final value in [null, 'wrong', <String, dynamic>{}]) {
        expect(
          AppConfig.fromJson({'gallery': value}).gallery.toJson(),
          const GalleryConfig().toJson(),
        );
      }
      final value = GalleryThumbnailConfig.fromJson({
        'sizes': ['unknown', 'future'],
        'jpegQuality': 101,
        'backgroundColor': 'red',
        'frameSelectionFrames': 1,
        'maxWorkers': -1,
        'maxQueued': -1,
        'maxWaiters': '32',
        'cacheMaxBytes': 0,
        'cacheMaxEntries': -1,
        'timeoutSeconds': double.infinity,
      });
      expect(value.toJson(), const GalleryThumbnailConfig().toJson());
    },
  );

  test(
    'render revision covers output settings but excludes execution budgets',
    () {
      const base = ThumbnailPolicy();
      expect(
        base.renderRevision,
        const ThumbnailPolicy(maxWorkers: 8, maxQueued: 0).renderRevision,
      );
      for (final policy in [
        const ThumbnailPolicy(jpegQuality: 20),
        const ThumbnailPolicy(backgroundColor: 0xffffffff),
        const ThumbnailPolicy(frameSelectionFrames: 10),
        const ThumbnailPolicy(sizes: [GalleryThumbnailSize.small]),
      ]) {
        expect(policy.renderRevision, isNot(base.renderRevision));
        expect(
          policy.catalogPolicy.identity,
          isNot(base.catalogPolicy.identity),
        );
      }
    },
  );
}
