import 'dart:async';
import 'dart:io';

import 'package:dslideshow_backend/src/service/gallery/gallery_catalog_service.dart';
import 'package:dslideshow_backend/src/service/gallery/gallery_media_publisher.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:test/test.dart';

class _BlockedDirectory implements Directory {
  final Directory delegate;
  final Completer<void> scanStarted = Completer();
  final Completer<void> scanGate = Completer();
  int traversals = 0;
  _BlockedDirectory(this.delegate);
  @override
  String get path => delegate.path;
  @override
  Directory get absolute => delegate.absolute;
  @override
  Future<bool> exists() async => true;
  @override
  Stream<FileSystemEvent> watch({
    int events = FileSystemEvent.all,
    bool recursive = false,
  }) => const Stream.empty();
  @override
  Stream<FileSystemEntity> list({
    bool recursive = false,
    bool followLinks = true,
  }) async* {
    traversals++;
    if (!scanStarted.isCompleted) scanStarted.complete();
    await scanGate.future;
    yield* delegate.list(recursive: recursive, followLinks: followLinks);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
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

  test('completed nested publications invalidate a cached snapshot without watcher events', () async {
    await Directory('${originals.path}/album').create();
    await File('${originals.path}/album/existing.jpg').writeAsBytes([1, 2, 3]);
    originals.scanGate.complete();
    final before = await catalog.catalog();
    final old = before.entries.firstWhere(
      (entry) => entry.path == 'album/existing.jpg',
    );
    final publisher = GalleryMediaPublisher(
      originals: originals.delegate,
      stateDirectory: Directory('${root.path}/metadata'),
    );
    await publisher.publish(Stream.value([4, 5, 6]), 'album/existing.jpg');
    await publisher.publish(Stream.value([7, 8, 9]), 'album/new.jpg');
    final after = await catalog.catalog();
    final replaced = after.entries.firstWhere(
      (entry) => entry.path == old.path,
    );
    expect(after.catalogRevision, isNot(before.catalogRevision));
    expect(replaced.mediaId, old.mediaId);
    expect(replaced.sourceRevision, isNot(old.sourceRevision));
    expect(after.entries.map((entry) => entry.path), contains('album/new.jpg'));
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
