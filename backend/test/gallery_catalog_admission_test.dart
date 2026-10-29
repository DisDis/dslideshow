import 'dart:async';
import 'dart:io';

import 'package:dslideshow_backend/src/service/gallery/gallery_catalog_service.dart';
import 'package:dslideshow_backend/src/service/gallery/gallery_media_publisher.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:test/test.dart';

import 'support/no_watch_directory.dart';

class _BlockedDirectory extends NoWatchDirectory {
  final Completer<void> scanStarted = Completer();
  final Completer<void> scanGate = Completer();
  Future<void> Function()? afterTraversal;
  int traversals = 0;
  _BlockedDirectory(super.directory);

  @override
  Stream<FileSystemEntity> list({
    bool recursive = false,
    bool followLinks = true,
  }) async* {
    traversals++;
    if (!scanStarted.isCompleted) scanStarted.complete();
    await scanGate.future;
    yield* delegate.list(recursive: recursive, followLinks: followLinks);
    await afterTraversal?.call();
  }
}

Matcher errorCode(GalleryErrorCode code) => throwsA(
  isA<GalleryCatalogFailure>().having((value) => value.code, 'code', code),
);

void main() {
  late Directory root;
  late _BlockedDirectory originals;
  late GalleryCatalogService catalog;
  setUp(() async {
    root = await Directory.systemTemp.createTemp('catalog-admission-');
    final media = await Directory('${root.path}/media').create();
    await File('${media.path}/one.jpg').writeAsString('photo');
    originals = _BlockedDirectory(media);
    catalog = GalleryCatalogService(
      originals: originals,
      stateDirectory: Directory('${root.path}/metadata'),
      maxPendingOperations: 2,
    );
  });
  tearDown(() async {
    if (!originals.scanGate.isCompleted) originals.scanGate.complete();
    await catalog.close();
    await root.delete(recursive: true);
  });

  test(
    'running plus queued catalog work is bounded before scan finishes',
    () async {
      final first = catalog.catalog();
      await originals.scanStarted.future;
      final second = catalog.catalog();
      await expectLater(catalog.catalog(), errorCode(GalleryErrorCode.busy));
      final rejected = List.generate(
        1000,
        (_) => expectLater(
          catalog.resolve('unresolved'),
          errorCode(GalleryErrorCode.busy),
        ),
      );
      await Future.wait(rejected);
      // No rejected request is deferred behind the unopened scan gate.
      expect(originals.scanGate.isCompleted, isFalse);
      expect(originals.traversals, 1);
      originals.scanGate.complete();
      final firstSnapshot = await first;
      final secondSnapshot = await second;
      expect(firstSnapshot.entries.single.path, 'one.jpg');
      expect(secondSnapshot.catalogRevision, firstSnapshot.catalogRevision);
      expect(originals.traversals, 1);
      // Admission is reusable after the running/queued pair has completed.
      final source = await catalog.resolve(
        firstSnapshot.entries.single.mediaId,
      );
      expect(source.entry.mediaId, firstSnapshot.entries.single.mediaId);
    },
  );

  test(
    'markDirty discovers completed nested changes without watcher events',
    () async {
      await Directory('${originals.path}/album').create();
      await File('${originals.path}/album/existing.jpg')
          .writeAsBytes([1, 2, 3]);
      originals.scanGate.complete();
      final before = await catalog.catalog();
      final old = before.entries.firstWhere(
        (entry) => entry.path == 'album/existing.jpg',
      );
      final publisher = GalleryMediaPublisher(originals: originals.delegate);
      await publisher.publish(Stream.value([4, 5, 6]), 'album/existing.jpg');
      await publisher.publish(Stream.value([7, 8, 9]), 'album/new.jpg');
      catalog.markDirty();
      final after = await catalog.catalog();
      final replaced = after.entries.firstWhere(
        (entry) => entry.path == old.path,
      );
      expect(after.catalogRevision, isNot(before.catalogRevision));
      expect(replaced.mediaId, old.mediaId);
      expect(replaced.sourceRevision, isNot(old.sourceRevision));
      expect(
        after.entries.map((entry) => entry.path),
        contains('album/new.jpg'),
      );
      expect(
        after.entries
            .firstWhere((entry) => entry.path == 'one.jpg')
            .sourceRevision,
        before.entries
            .firstWhere((entry) => entry.path == 'one.jpg')
            .sourceRevision,
        reason: 'A dirty hint must not invalidate unchanged thumbnails',
      );
    },
  );

  test('markDirty during a scan is retained for the next snapshot', () async {
    originals.scanGate.complete();
    originals.afterTraversal = () async {
      originals.afterTraversal = null;
      await File('${originals.path}/late.jpg')
          .writeAsString('complete new media');
      catalog.markDirty();
    };
    final during = await catalog.catalog();
    expect(during.entries.map((entry) => entry.path), ['one.jpg']);
    final after = await catalog.catalog();
    expect(after.entries.map((entry) => entry.path), ['late.jpg', 'one.jpg']);
    expect(after.catalogRevision, isNot(during.catalogRevision));
  });

  test('periodic stat scans discover external changes without markDirty or watcher', () async {
    await catalog.close();
    catalog = GalleryCatalogService(
      originals: originals,
      stateDirectory: Directory('${root.path}/metadata'),
      scanMaxAge: Duration.zero,
    );
    originals.scanGate.complete();
    final before = (await catalog.catalog()).entries.single;
    final staged = await File('${root.path}/complete.tmp')
        .writeAsString('external replacement without a notification');
    await staged.rename('${originals.path}/one.jpg');
    final after = (await catalog.catalog()).entries.single;
    expect(after.mediaId, before.mediaId);
    expect(after.sourceRevision, isNot(before.sourceRevision));
    expect(
      await File((await catalog.resolve(after.mediaId)).absolutePath)
          .readAsString(),
      'external replacement without a notification',
    );
  });

  test(
    'close rejects admitted queued work without running another scan',
    () async {
      final first = catalog.catalog();
      final firstError = expectLater(
        first,
        errorCode(GalleryErrorCode.unavailable),
      );
      await originals.scanStarted.future;
      final queued = catalog.catalog();
      final queuedError = expectLater(
        queued,
        errorCode(GalleryErrorCode.unavailable),
      );
      final closing = catalog.close();
      originals.scanGate.complete();
      await firstError;
      await queuedError;
      await closing;
      expect(originals.traversals, 1);
      await expectLater(
        catalog.catalog(),
        errorCode(GalleryErrorCode.unavailable),
      );
    },
  );
}
