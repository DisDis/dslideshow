// Exercise mirrored trash and filesystem truth on real temporary user files.
// ignore_for_file: avoid_slow_async_io
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dslideshow_backend/src/service/gallery/gallery_catalog_service.dart';
import 'package:dslideshow_backend/src/service/gallery/gallery_file_operations.dart';
import 'package:dslideshow_backend/src/service/gallery/gallery_media_publisher.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';

import 'helpers/capture_logs.dart';
import 'support/no_watch_directory.dart';

void main() {
  late Directory root, originals, trash;
  late GalleryCatalogService catalog;
  late GalleryFileOperations operations;

  setUp(() async {
    root = await Directory.systemTemp.createTemp('gallery-file-operations-');
    originals = await Directory(path.join(root.path, 'images')).create();
    catalog = GalleryCatalogService(
      originals: NoWatchDirectory(originals),
      stateDirectory: Directory('${originals.path}.gallery'),
    );
    operations = GalleryFileOperations(catalog: catalog);
    trash = Directory(path.join(catalog.stateDirectory.path, 'trash'));
  });
  tearDown(() async {
    await operations.close();
    await catalog.close();
    await root.delete(recursive: true);
  });

  Future<GalleryEntry> photo(String name, String bytes) async {
    final file = File(path.join(originals.path, name));
    await file.parent.create(recursive: true);
    await file.writeAsString(bytes);
    return (await catalog.refresh(
      GalleryRefreshRequest(operationId: 'scan-$name-${bytes.length}', mode: GalleryRefreshMode.scan),
    )).entries.firstWhere((entry) => entry.path == name);
  }

  GalleryMediaRef ref(GalleryEntry entry) =>
      GalleryMediaRef(section: entry.section, mediaId: entry.mediaId, sourceRevision: entry.sourceRevision);
  GalleryMediaRef trashRef(GalleryEntry entry) =>
      GalleryMediaRef(section: entry.section, mediaId: entry.mediaId, sourceRevision: entry.sourceRevision);
  GalleryOperationRequest request(String id, GalleryMutation action, List<GalleryMediaRef> items) =>
      GalleryOperationRequest(operationId: id, action: action, items: items);
  Future<void> restart() async {
    await operations.close();
    operations = GalleryFileOperations(catalog: catalog);
  }

  Future<GalleryEntry> movePhoto(GalleryEntry entry, String id) async {
    final result = await operations.mutate(request(id, GalleryMutation.trash, [ref(entry)]));
    expect(result.items.single.state, GalleryItemOperationState.succeeded);
    return (await operations.mediaCatalog(GalleryMediaSection.trash)).entries
        .singleWhere((value) => value.path == entry.path);
  }

  Matcher failure(GalleryErrorCode code) =>
      throwsA(isA<GalleryCatalogFailure>().having((error) => error.code, 'code', code));
  Future<Set<String>> trashFiles() async => {
    await for (final entity in trash.list(recursive: true, followLinks: false))
      if (entity is File) path.relative(entity.path, from: trash.path),
  };
  Future<void> chmod(Directory directory, String mode) async {
    final result = await Process.run('chmod', [mode, directory.path]);
    expect(result.exitCode, 0, reason: 'The temporary permission fixture requires chmod');
  }

  test('trash mirrors nested relative paths, preserves bytes and creates no manifest or receipts', () async {
    final a = await photo('альбом/folder/a photo.jpg', 'original photo');
    final b = await photo('video/b.mp4', 'original movie');
    final moved = await operations.mutate(request('move-batch', GalleryMutation.trash, [ref(a), ref(b)]));
    expect(moved.operationId, 'move-batch');
    expect(moved.items.map((item) => item.state), everyElement(GalleryItemOperationState.succeeded));
    expect(await File(path.join(originals.path, a.path)).exists(), isFalse);
    expect(await File(path.join(originals.path, b.path)).exists(), isFalse);
    expect(await trashFiles(), {a.path, b.path});
    expect(await File(path.join(trash.path, a.path)).readAsString(), 'original photo');
    final entries = (await operations.mediaCatalog(GalleryMediaSection.trash)).entries;
    final aTrash = entries.singleWhere((entry) => entry.path == a.path);
    expect(aTrash.name, a.name);
    expect(aTrash.sizeBytes, 14);
    final resolved = await operations.mediaFile(
      GalleryMediaRef(
        section: GalleryMediaSection.trash,
        mediaId: aTrash.mediaId,
        sourceRevision: aTrash.sourceRevision,
      ),
    );
    expect(resolved.absolute.path, path.join(trash.absolute.path, a.path));
    expect(path.isWithin(catalog.stateDirectory.path, resolved.path), isTrue);
    expect(path.isWithin(originals.path, resolved.path), isFalse);
    expect((await catalog.catalog()).entries.any((entry) => entry.path == a.path), isFalse);
    expect(await File(path.join(trash.path, 'manifest.json')).exists(), isFalse);
    expect(await Directory(path.join(trash.path, 'files')).exists(), isFalse);
    await expectLater(
      operations.mediaFile(
        GalleryMediaRef(section: GalleryMediaSection.trash, mediaId: aTrash.mediaId, sourceRevision: 'old'),
      ),
      failure(GalleryErrorCode.revisionMismatch),
    );
  });

  test('nested restore recreates parents and purge removes the mirrored file only', () async {
    final first = await movePhoto(await photo('album/sub/photo.jpg', 'retained'), 'move');
    await Directory(path.join(originals.path, 'album')).delete(recursive: true);
    final restored = await operations.mutate(request('restore', GalleryMutation.restore, [trashRef(first)]));
    expect(restored.items.single.state, GalleryItemOperationState.succeeded);
    expect(restored.items.single.restoredPath, 'album/sub/photo.jpg');
    expect(await File(path.join(originals.path, 'album/sub/photo.jpg')).readAsString(), 'retained');
    expect((await operations.mediaCatalog(GalleryMediaSection.trash)).entries, isEmpty);
    final current = (await catalog.catalog()).entries.singleWhere((entry) => entry.path == 'album/sub/photo.jpg');
    final second = await movePhoto(current, 'move-again');
    final unrelated = await File(path.join(trash.path, 'album/sub/keep.txt')).writeAsString('external');
    final purged = await operations.mutate(request('purge', GalleryMutation.purge, [trashRef(second)]));
    expect(purged.items.single.state, GalleryItemOperationState.succeeded);
    expect(await File(path.join(trash.path, second.path)).exists(), isFalse);
    expect(await unrelated.readAsString(), 'external');
    expect(await File(path.join(trash.path, 'manifest.json')).exists(), isFalse);
  });

  test('an existing same-path trash file preserves both versions', () async {
    final first = await movePhoto(await photo('album/photo.jpg', 'saved original'), 'first');
    final replacement = await photo('album/photo.jpg', 'new user file');
    final result = await operations.mutate(request('collision', GalleryMutation.trash, [ref(replacement)]));
    expect(result.items.single.state, GalleryItemOperationState.failed);
    expect(result.items.single.error, GalleryErrorCode.conflict);
    expect(await File(path.join(originals.path, replacement.path)).readAsString(), 'new user file');
    expect(await File(path.join(trash.path, first.path)).readAsString(), 'saved original');
    expect((await operations.mediaCatalog(GalleryMediaSection.trash)).entries.single.mediaId, first.mediaId);
  });

  test('an existing trash directory is a conflict and keeps its contents', () async {
    final original = await photo('альбом/a photo.jpg', 'retained original');
    final occupied = await Directory(path.join(trash.path, original.path)).create(recursive: true);
    final retained = await File(path.join(occupied.path, 'keep.txt')).writeAsString('retained directory contents');
    final result = await operations.mutate(request('directory-collision', GalleryMutation.trash, [ref(original)]));
    expect(result.items.single.state, GalleryItemOperationState.failed);
    expect(result.items.single.error, GalleryErrorCode.conflict);
    expect(await File(path.join(originals.path, original.path)).readAsString(), 'retained original');
    expect(await occupied.exists(), isTrue);
    expect(await retained.readAsString(), 'retained directory contents');
    expect((await operations.mediaCatalog(GalleryMediaSection.trash)).entries, isEmpty);
  });

  test('restore chooses a safe name and preserves conflicting files and directories', () async {
    final saved = await movePhoto(await photo('album/a.jpg', 'saved original'), 'move');
    await File(path.join(originals.path, 'album/a.jpg')).writeAsString('new user file');
    await Directory(path.join(originals.path, 'album/a (restored 1).jpg')).create();
    final result = await operations.mutate(request('restore', GalleryMutation.restore, [trashRef(saved)]));
    expect(result.items.single.state, GalleryItemOperationState.succeeded);
    expect(result.items.single.restoredPath, 'album/a (restored 2).jpg');
    expect(await File(path.join(originals.path, 'album/a.jpg')).readAsString(), 'new user file');
    expect(await File(path.join(originals.path, 'album/a (restored 2).jpg')).readAsString(), 'saved original');
    expect((await operations.mediaCatalog(GalleryMediaSection.trash)).entries, isEmpty);
  });

  test('restart derives trash from disk and repeated operation IDs never replay old successes', () async {
    final source = await photo('one.png', 'png bytes');
    final move = request('same-id', GalleryMutation.trash, [ref(source)]);
    expect((await operations.mutate(move)).items.single.state, GalleryItemOperationState.succeeded);
    await restart();
    final replay = await operations.mutate(move);
    expect(replay.operationId, move.operationId);
    expect(replay.items.single.state, GalleryItemOperationState.failed);
    expect(replay.items.single.error, GalleryErrorCode.notFound);
    final entry = (await operations.mediaCatalog(GalleryMediaSection.trash)).entries.single;
    final purge = request('same-id', GalleryMutation.purge, [trashRef(entry)]);
    expect((await operations.mutate(purge)).items.single.state, GalleryItemOperationState.succeeded);
    await restart();
    final absent = await operations.mutate(purge);
    expect(absent.items.single.state, GalleryItemOperationState.failed);
    expect(absent.items.single.error, GalleryErrorCode.notFound);
    expect(await trashFiles(), isEmpty);
    expect(await File(path.join(trash.path, 'manifest.json')).exists(), isFalse);
  });

  test('external trash additions and changes are discovered by explicit scans with fresh stat identities', () async {
    final file = File(path.join(trash.path, 'manual/photo.jpg'));
    await file.parent.create(recursive: true);
    await file.writeAsString('old bytes');
    final old = (await operations.mediaCatalog(GalleryMediaSection.trash)).entries.single;
    expect(old.path, 'manual/photo.jpg');
    await file.writeAsString('replacement bytes');
    await expectLater(
      operations.mediaFile(
        GalleryMediaRef(section: GalleryMediaSection.trash, mediaId: old.mediaId, sourceRevision: old.sourceRevision),
      ),
      failure(GalleryErrorCode.revisionMismatch),
    );
    final refreshed = (await operations.mediaCatalog(GalleryMediaSection.trash)).entries.single;
    expect(refreshed.mediaId, isNot(old.mediaId));
    expect(refreshed.sourceRevision, isNot(old.sourceRevision));
    expect(refreshed.sizeBytes, 17);
    final staleUndo = await operations.mutate(request('old-undo', GalleryMutation.restore, [trashRef(old)]));
    expect(staleUndo.items.single.state, GalleryItemOperationState.failed);
    expect(staleUndo.items.single.error, GalleryErrorCode.notFound);
    expect(await file.readAsString(), 'replacement bytes');
    await file.delete();
    expect((await operations.mediaCatalog(GalleryMediaSection.trash)).entries, isEmpty);
  });

  test('reusing a restored path gives a new trash ID so old Undo cannot restore its replacement', () async {
    final first = await movePhoto(await photo('album/photo.jpg', 'first'), 'first');
    await operations.mutate(request('restore-first', GalleryMutation.restore, [trashRef(first)]));
    final newer = await photo('album/photo.jpg', 'different replacement');
    final second = await movePhoto(newer, 'second');
    expect(second.path, first.path);
    expect(second.mediaId, isNot(first.mediaId));
    expect(second.sourceRevision, isNot(first.sourceRevision));
    final oldUndo = await operations.mutate(request('old-undo', GalleryMutation.restore, [trashRef(first)]));
    expect(oldUndo.items.single.state, GalleryItemOperationState.failed);
    expect(oldUndo.items.single.error, GalleryErrorCode.notFound);
    expect(await File(path.join(trash.path, second.path)).readAsString(), 'different replacement');
    expect(await File(path.join(originals.path, second.path)).exists(), isFalse);
  });

  test('stale and missing refs fail in request order while valid selected media move', () async {
    final stale = await photo('stale.jpg', 'old');
    final good = await photo('good.jpg', 'good');
    await GalleryMediaPublisher(originals: originals).publish(Stream.value(utf8.encode('newer source')), 'stale.jpg');
    final result = await operations.mutate(
      request('partial', GalleryMutation.trash, [
        ref(stale),
        const GalleryMediaRef(section: GalleryMediaSection.published, mediaId: 'missing', sourceRevision: 'x'),
        ref(good),
      ]),
    );
    expect(result.items.map((item) => item.mediaId), [stale.mediaId, 'missing', good.mediaId]);
    expect(result.items.map((item) => item.state), [
      GalleryItemOperationState.failed,
      GalleryItemOperationState.failed,
      GalleryItemOperationState.succeeded,
    ]);
    expect(result.items[0].error, GalleryErrorCode.revisionMismatch);
    expect(result.items[1].error, GalleryErrorCode.notFound);
    expect(await File(path.join(originals.path, 'stale.jpg')).readAsString(), 'newer source');
    expect((await operations.mediaCatalog(GalleryMediaSection.trash)).entries.single.path, good.path);
  });

  test('a failed rename retains its source and later selected files still move', () async {
    final blocked = await photo('blocked/a.jpg', 'must remain');
    final good = await photo('good.jpg', 'can move');
    final destination = await Directory(path.join(trash.path, 'blocked')).create(recursive: true);
    await chmod(destination, '500');
    try {
      final result = await operations.mutate(
        request('partial-rename', GalleryMutation.trash, [ref(blocked), ref(good)]),
      );
      expect(result.items.map((item) => item.state), [
        GalleryItemOperationState.failed,
        GalleryItemOperationState.succeeded,
      ]);
      expect(result.items.first.error, GalleryErrorCode.forbidden);
      expect(await File(path.join(originals.path, blocked.path)).readAsString(), 'must remain');
      expect(await File(path.join(trash.path, blocked.path)).exists(), isFalse);
      expect(await File(path.join(trash.path, good.path)).readAsString(), 'can move');
    } finally {
      await chmod(destination, '700');
    }
  }, skip: !Platform.isLinux || Platform.environment['USER'] == 'root');

  test('directory and child symlink media cannot mutate another tree', () async {
    await photo('album/one.jpg', 'one');
    final outside = await File(path.join(root.path, 'outside.jpg')).writeAsString('outside');
    final link = Link(path.join(originals.path, 'linked.jpg'));
    await link.create(outside.path);
    final entries = (await catalog.refresh(
      const GalleryRefreshRequest(operationId: 'links', mode: GalleryRefreshMode.scan),
    )).entries;
    final targets = entries.where((entry) => entry.path == 'album' || entry.path == 'linked.jpg');
    final result = await operations.mutate(
      request('bad-targets', GalleryMutation.trash, [
        for (final entry in targets)
          GalleryMediaRef(
            section: entry.section,
            mediaId: entry.mediaId,
            sourceRevision: entry.sourceRevision.isEmpty ? 'directory' : entry.sourceRevision,
          ),
      ]),
    );
    expect(result.items.map((item) => item.state), everyElement(GalleryItemOperationState.failed));
    expect(await outside.readAsString(), 'outside');
    expect(await File(path.join(originals.path, 'album/one.jpg')).readAsString(), 'one');
    expect(await link.exists(), isTrue);
  });

  test('cached previews and partial purge reject a substituted symlink while later files still delete', () async {
    final first = await movePhoto(await photo('album/first.jpg', 'first'), 'move-first');
    final entry = await movePhoto(await photo('album/a.jpg', 'saved'), 'move');
    final last = await movePhoto(await photo('album/last.jpg', 'last'), 'move-last');
    final source = File(path.join(trash.path, entry.path));
    final outside = await File(path.join(root.path, 'outside.jpg')).writeAsString('outside');
    await source.delete();
    final replacement = await Link(source.path).create(outside.path);
    await expectLater(
      operations.mediaFile(
        GalleryMediaRef(
          section: GalleryMediaSection.trash,
          mediaId: entry.mediaId,
          sourceRevision: entry.sourceRevision,
        ),
      ),
      failure(GalleryErrorCode.invalidRequest),
    );
    final purged = await operations.mutate(
      request('purge-link', GalleryMutation.purge, [trashRef(first), trashRef(entry), trashRef(last)]),
    );
    expect(purged.items.map((value) => value.mediaId), [first.mediaId, entry.mediaId, last.mediaId]);
    expect(purged.items.map((value) => value.state), [
      GalleryItemOperationState.succeeded,
      GalleryItemOperationState.failed,
      GalleryItemOperationState.succeeded,
    ]);
    expect(purged.items[1].error, GalleryErrorCode.invalidRequest);
    expect(await File(path.join(trash.path, first.path)).exists(), isFalse);
    expect(await File(path.join(trash.path, last.path)).exists(), isFalse);
    expect(await outside.readAsString(), 'outside');
    expect(await replacement.exists(), isTrue);
  });

  test('purge removes trash bytes without rescanning or publishing the originals catalogue', () async {
    final saved = await movePhoto(await photo('album/remove.jpg', 'removed bytes'), 'move-before-purge');
    await photo('keep.jpg', 'retained original');
    final epoch = File(path.join(catalog.stateDirectory.path, 'catalog.epoch'));
    final epochBefore = await epoch.readAsBytes();
    final result = await captureLogs((records) async {
      final result = await operations.mutate(request('purge-only', GalleryMutation.purge, [trashRef(saved)]));
      expect(
        records.where(
          (record) => record.loggerName == 'GalleryCatalogService' && record.message.startsWith('Gallery scan '),
        ),
        isEmpty,
        reason: 'Removing trash must not rescan the original library',
      );
      return result;
    });
    expect(result.items.single.state, GalleryItemOperationState.succeeded);
    expect(await File(path.join(trash.path, saved.path)).exists(), isFalse);
    expect(await File(path.join(originals.path, 'keep.jpg')).readAsString(), 'retained original');
    expect(await epoch.readAsBytes(), epochBefore);
    expect((await operations.mediaCatalog(GalleryMediaSection.trash)).entries, isEmpty);
  });

  test(
    'restore marks the catalog dirty and serves the new snapshot without metadata notifications',
    () => captureLogs((records) async {
      final saved = await movePhoto(await photo('album/photo.jpg', 'retained original'), 'move');
      records.clear();
      final result = await operations.mutate(
        request('restore-with-memory-invalidation', GalleryMutation.restore, [trashRef(saved)]),
      );
      expect(result.items.single.state, GalleryItemOperationState.succeeded);
      expect(result.items.single.restoredPath, saved.path);
      final entry = (await catalog.catalog()).entries.singleWhere((entry) => entry.path == saved.path);
      final source = await catalog.resolve(entry.mediaId, revision: entry.sourceRevision);
      expect(await File(source.absolutePath).readAsString(), 'retained original');
      expect(await File(path.join(trash.path, saved.path)).exists(), isFalse);
      final hints = records.where((record) => record.message == 'Gallery catalog marked dirty');
      expect(hints, isNotEmpty);
      expect(hints.every((record) => record.level == Level.FINE && record.error == null), isTrue);
      expect(
        await catalog.stateDirectory
            .list()
            .where((entry) => entry is File)
            .map((entry) => path.basename(entry.path))
            .toList(),
        ['catalog.epoch'],
      );
    }),
  );

  test(
    'trash refresh updates only the in-memory catalog and leaves the epoch untouched',
    () => captureLogs((records) async {
      final source = await photo('photo.jpg', 'retained original');
      final epoch = File(path.join(catalog.stateDirectory.path, 'catalog.epoch'));
      final bytesBefore = await epoch.readAsBytes();
      final statBefore = await epoch.stat();
      records.clear();
      final result = await operations.mutate(request('trash-with-memory-index', GalleryMutation.trash, [ref(source)]));
      expect(result.items.single.state, GalleryItemOperationState.succeeded);
      expect(await File(path.join(originals.path, source.path)).exists(), isFalse);
      expect(await File(path.join(trash.path, source.path)).readAsString(), 'retained original');
      expect(await epoch.readAsBytes(), bytesBefore);
      final statAfter = await epoch.stat();
      expect(statAfter.modified, statBefore.modified);
      expect(statAfter.changed, statBefore.changed);
      expect(records.where((record) => record.message.startsWith('Gallery invalidation state persisted')), isEmpty);
      expect(await File(path.join(catalog.stateDirectory.path, 'catalog.json')).exists(), isFalse);
      expect(await trashFiles(), {'photo.jpg'});
    }),
  );

  test('duplicate refs, item limits and pending queues are bounded while close drains accepted work', () async {
    final original = await photo('one.jpg', 'one');
    await expectLater(
      operations.mutate(request('duplicate', GalleryMutation.trash, [ref(original), ref(original)])),
      failure(GalleryErrorCode.invalidRequest),
    );
    await operations.close();
    operations = GalleryFileOperations(catalog: catalog, maxPendingOperations: 1, maxItemsPerOperation: 1);
    await expectLater(
      operations.mutate(
        request('too-many', GalleryMutation.trash, [
          ref(original),
          const GalleryMediaRef(section: GalleryMediaSection.published, mediaId: 'other', sourceRevision: '1'),
        ]),
      ),
      failure(GalleryErrorCode.invalidRequest),
    );
    final entered = Completer<void>(), release = Completer<void>();
    final held = operations.withMediaLock(() async {
      entered.complete();
      await release.future;
    });
    await entered.future;
    await expectLater(operations.mediaCatalog(GalleryMediaSection.trash), failure(GalleryErrorCode.busy));
    var closed = false;
    final closing = operations.close().then((_) => closed = true);
    await expectLater(operations.mediaCatalog(GalleryMediaSection.trash), failure(GalleryErrorCode.unavailable));
    expect(closed, isFalse);
    release.complete();
    await held;
    await closing;
    expect(closed, isTrue);
    expect(await File(path.join(originals.path, original.path)).readAsString(), 'one');
  });

  test('catalog entry and JSON budgets reject a full scan without truncating or removing files', () async {
    await Directory(path.join(trash.path, 'album')).create(recursive: true);
    await File(path.join(trash.path, 'album/a.jpg')).writeAsString('a');
    await File(path.join(trash.path, 'album/b.jpg')).writeAsString('b');
    for (final limitByEntries in [true, false]) {
      await operations.close();
      operations = GalleryFileOperations(
        catalog: catalog,
        maxCatalogEntries: limitByEntries ? 1 : 100,
        maxCatalogBytes: limitByEntries ? 64 * 1024 : 100,
      );
      await expectLater(
        operations.mediaCatalog(GalleryMediaSection.trash),
        failure(GalleryErrorCode.outputLimitExceeded),
      );
      expect(await trashFiles(), {'album/a.jpg', 'album/b.jpg'});
      expect(await File(path.join(trash.path, 'album/a.jpg')).readAsString(), 'a');
      expect(await File(path.join(trash.path, 'album/b.jpg')).readAsString(), 'b');
    }
    await operations.close();
    await File(path.join(trash.path, 'album/b.jpg')).delete();
    final incoming = await photo('incoming.jpg', 'original retained');
    operations = GalleryFileOperations(catalog: catalog, maxCatalogEntries: 1);
    final rejected = await operations.mutate(request('admission-limit', GalleryMutation.trash, [ref(incoming)]));
    expect(rejected.items.single.state, GalleryItemOperationState.failed);
    expect(rejected.items.single.error, GalleryErrorCode.outputLimitExceeded);
    expect(await File(path.join(originals.path, incoming.path)).readAsString(), 'original retained');
    expect(await trashFiles(), {'album/a.jpg'});
  });

  test(
    'warm direct metadata and original lookups validate one file without rescanning the trash',
    () => captureLogs((records) async {
      await Directory(path.join(trash.path, 'album')).create(recursive: true);
      await File(path.join(trash.path, 'album/a.jpg')).writeAsString('a');
      await File(path.join(trash.path, 'album/b.jpg')).writeAsString('b');
      final entry = (await operations.mediaCatalog(GalleryMediaSection.trash)).entries.first;
      final scansBefore = records
          .where(
            (record) =>
                record.loggerName == 'GalleryFileOperations' &&
                record.message.startsWith('Gallery trash catalog scanned'),
          )
          .length;
      expect(scansBefore, 1);
      expect(
        (await operations.resolveMedia(
          GalleryMediaRef(
            section: GalleryMediaSection.trash,
            mediaId: entry.mediaId,
            sourceRevision: entry.sourceRevision,
          ),
        )).entry,
        entry,
      );
      expect(
        await (await operations.mediaFile(
          GalleryMediaRef(
            section: GalleryMediaSection.trash,
            mediaId: entry.mediaId,
            sourceRevision: entry.sourceRevision,
          ),
        )).readAsString(),
        entry.name == 'a.jpg' ? 'a' : 'b',
      );
      expect(
        records
            .where(
              (record) =>
                  record.loggerName == 'GalleryFileOperations' &&
                  record.message.startsWith('Gallery trash catalog scanned'),
            )
            .length,
        scansBefore,
      );
      expect(
        records.where((record) => record.loggerName == 'GalleryFileOperations' && record.level == Level.INFO),
        isEmpty,
      );
      await operations.mediaCatalog(GalleryMediaSection.trash);
      expect(
        records
            .where(
              (record) =>
                  record.loggerName == 'GalleryFileOperations' &&
                  record.message.startsWith('Gallery trash catalog scanned'),
            )
            .length,
        2,
      );
    }),
  );

  test('reusing a command ID still checks the current filesystem revision', () async {
    final original = await photo('one.jpg', 'one');
    final move = request('same-id', GalleryMutation.trash, [ref(original)]);
    expect((await operations.mutate(move)).items.single.state, GalleryItemOperationState.succeeded);
    final repeated = await operations.mutate(move);
    expect(repeated.items.single.error, GalleryErrorCode.notFound);
    expect(await File(path.join(trash.path, original.path)).readAsString(), 'one');
  });

  test('cross-device rename fails without copying or removing the original', () async {
    final alternate = await Directory('/dev/shm').createTemp('gallery-trash-cross-device-');
    addTearDown(() => alternate.delete(recursive: true));
    final original = await photo('one.jpg', 'retained');
    await operations.close();
    operations = GalleryFileOperations(catalog: catalog, trashDirectory: Directory(path.join(alternate.path, 'trash')));
    final result = await operations.mutate(request('cross-device', GalleryMutation.trash, [ref(original)]));
    expect(result.items.single.state, GalleryItemOperationState.failed);
    expect(result.items.single.error, GalleryErrorCode.unsupported);
    expect(await File(path.join(originals.path, original.path)).readAsString(), 'retained');
    expect((await operations.mediaCatalog(GalleryMediaSection.trash)).entries, isEmpty);
    expect(
      await Directory(path.join(alternate.path, 'trash')).list(recursive: true).where((entry) => entry is File).isEmpty,
      isTrue,
    );
  }, skip: !Platform.isLinux || !Directory('/dev/shm').existsSync());

  test('a mirrored hex-named directory survives restart and restores its nested photo', () async {
    const folder = '01234567890123456789012345678901';
    final relative = path.join('files', folder, 'photo.jpg');
    final mirrored = File(path.join(trash.path, relative));
    await mirrored.parent.create(recursive: true);
    await mirrored.writeAsString('ordinary nested photo');
    final first = (await operations.mediaCatalog(GalleryMediaSection.trash)).entries.single;
    expect(first.path, relative);
    await restart();
    final entry = (await operations.mediaCatalog(GalleryMediaSection.trash)).entries.single;
    expect(entry, first);
    expect(
      await (await operations.mediaFile(
        GalleryMediaRef(
          section: GalleryMediaSection.trash,
          mediaId: entry.mediaId,
          sourceRevision: entry.sourceRevision,
        ),
      )).readAsString(),
      'ordinary nested photo',
    );
    final restored = await operations.mutate(request('restore-hex-folder', GalleryMutation.restore, [trashRef(entry)]));
    expect(restored.items.single.state, GalleryItemOperationState.succeeded);
    expect(restored.items.single.restoredPath, relative);
    expect(await File(path.join(originals.path, relative)).readAsString(), 'ordinary nested photo');
    expect(await mirrored.exists(), isFalse);
    expect(await mirrored.parent.exists(), isTrue);
    expect((await operations.mediaCatalog(GalleryMediaSection.trash)).entries, isEmpty);
    expect(await File(path.join(trash.path, 'manifest.json')).exists(), isFalse);
    expect(await trashFiles(), isEmpty);
  });

  test('trash rejects original and service directories except its dedicated state folder', () {
    for (final directory in [
      Directory(path.join(originals.path, 'trash')),
      catalog.stateDirectory,
      Directory(path.join(catalog.stateDirectory.path, 'thumbnails')),
      Directory(path.join(catalog.stateDirectory.path, 'duplicates')),
    ]) {
      expect(() => GalleryFileOperations(catalog: catalog, trashDirectory: directory), throwsArgumentError);
    }
  });

  test('trash root symlinks and substitutions are rechecked after initialization', () async {
    final original = await photo('one.jpg', 'retained');
    await operations.mediaCatalog(GalleryMediaSection.trash);
    final outside = await Directory(path.join(root.path, 'outside')).create();
    await trash.delete();
    final replacement = await Link(trash.path).create(outside.path);
    final rejected = await operations.mutate(request('changed-root', GalleryMutation.trash, [ref(original)]));
    expect(rejected.items.single.state, GalleryItemOperationState.failed);
    expect(rejected.items.single.error, GalleryErrorCode.invalidRequest);
    expect(await outside.list().isEmpty, isTrue);
    expect(await File(path.join(originals.path, original.path)).readAsString(), 'retained');
    await replacement.delete();
  });

  test(
    'configured two-hop root aliases support mirrored trash restore and purge without following child links',
    () async {
      await originals.delete();
      final actual = await Directory(path.join(root.path, 'real-media')).create();
      await Link(path.join(root.path, 'media-link')).create('real-media');
      await Link(originals.path).create('media-link');
      final file = await File(path.join(actual.path, 'photo.jpg')).writeAsString('original bytes');
      final entry = (await catalog.catalog()).entries.single;
      await operations.mutate(request('alias-trash', GalleryMutation.trash, [ref(entry)]));
      final saved = (await operations.mediaCatalog(GalleryMediaSection.trash)).entries.single;
      expect(
        (await operations.mediaFile(
          GalleryMediaRef(
            section: GalleryMediaSection.trash,
            mediaId: saved.mediaId,
            sourceRevision: saved.sourceRevision,
          ),
        )).path,
        path.join(trash.path, 'photo.jpg'),
      );
      await operations.mutate(request('alias-restore', GalleryMutation.restore, [trashRef(saved)]));
      expect(await file.readAsString(), 'original bytes');
      final current = (await catalog.catalog()).entries.single;
      final second = await movePhoto(current, 'alias-trash-again');
      expect(
        (await operations.mutate(request('alias-purge', GalleryMutation.purge, [trashRef(second)]))).items.single.state,
        GalleryItemOperationState.succeeded,
      );
      expect((await operations.mediaCatalog(GalleryMediaSection.trash)).entries, isEmpty);
      expect(await Directory(path.join('${actual.path}.gallery', 'trash')).exists(), isFalse);
      final outside = await File(path.join(root.path, 'PRIVATE_OUTSIDE.jpg')).writeAsString('outside');
      final child = await Link(path.join(actual.path, 'PRIVATE_CHILD.jpg')).create(outside.path);
      final linked = (await catalog.refresh(
        const GalleryRefreshRequest(operationId: 'child-link', mode: GalleryRefreshMode.scan),
      )).entries.single;
      final rejected = await operations.mutate(request('child-rejected', GalleryMutation.trash, [ref(linked)]));
      expect(rejected.items.single.state, GalleryItemOperationState.failed);
      expect(rejected.items.single.error, GalleryErrorCode.invalidRequest);
      expect(await outside.readAsString(), 'outside');
      expect(await child.exists(), isTrue);
    },
  );

  test('configured originals alias cannot be rebound to another tree while the owner is alive', () async {
    await originals.delete();
    final first = await Directory(path.join(root.path, 'first-root')).create();
    final second = await Directory(path.join(root.path, 'second-root')).create();
    final a = await File(path.join(first.path, 'same.jpg')).writeAsString('first bytes');
    final b = await File(path.join(second.path, 'same.jpg')).writeAsString('second bytes');
    final alias = await Link(originals.path).create(first.path);
    await operations.mediaCatalog(GalleryMediaSection.trash);
    await alias.delete();
    await alias.create(second.path);
    final entry = (await catalog.refresh(
      const GalleryRefreshRequest(operationId: 'rebound-root', mode: GalleryRefreshMode.scan),
    )).entries.single;
    await captureLogs((records) async {
      await expectLater(
        operations.mutate(request('rebound', GalleryMutation.trash, [ref(entry)])),
        failure(GalleryErrorCode.revisionMismatch),
      );
      expect(
        records
            .where((record) => record.loggerName == 'GalleryFileOperations')
            .any((record) => record.message.contains('rootChanged')),
        isTrue,
      );
    });
    expect(await a.readAsString(), 'first bytes');
    expect(await b.readAsString(), 'second bytes');
  });

  test('canonical aliases cannot place trash physically inside the originals tree', () async {
    await originals.delete();
    final actual = await Directory(path.join(root.path, 'real-media')).create();
    await Link(originals.path).create(actual.path);
    final file = await File(path.join(actual.path, 'photo.jpg')).writeAsString('original bytes');
    final entry = (await catalog.catalog()).entries.single;
    await operations.close();
    operations = GalleryFileOperations(catalog: catalog, trashDirectory: Directory(path.join(actual.path, 'trash')));
    await captureLogs((records) async {
      await expectLater(
        operations.mutate(request('overlap', GalleryMutation.trash, [ref(entry)])),
        failure(GalleryErrorCode.invalidRequest),
      );
      expect(
        records
            .where((record) => record.loggerName == 'GalleryFileOperations')
            .any((record) => record.message.contains('reason=rootOverlap')),
        isTrue,
      );
    });
    expect(await file.readAsString(), 'original bytes');
  });

  test(
    'mutation logs summarize success failure and cancellation without private media or command data',
    () => captureLogs((records) async {
      final original = await photo('PRIVATE_EXIF_GPS_NAME.jpg', 'PRIVATE_PIXEL_DATA');
      await operations.mutate(
        request('log-partial', GalleryMutation.trash, [
          ref(original),
          const GalleryMediaRef(
            section: GalleryMediaSection.published,
            mediaId: 'PRIVATE_MISSING.jpg',
            sourceRevision: 'PRIVATE_REVISION',
          ),
        ]),
      );
      final entry = (await operations.mediaCatalog(GalleryMediaSection.trash)).entries.single;
      const unsafeId = 'http://frame/cache/AUTH_SECRET/PRIVATE_FILE.jpg';
      await operations.mutate(request(unsafeId, GalleryMutation.restore, [trashRef(entry)]));
      final current = (await catalog.catalog()).entries.single;
      final saved = await movePhoto(current, 'move-again');
      final purge = request('purge-summary', GalleryMutation.purge, [trashRef(saved)]);
      await operations.mutate(purge);
      expect((await operations.mutate(purge)).items.single.error, GalleryErrorCode.notFound);
      final cancelledSource = await photo('PRIVATE_CANCELLED.jpg', 'retained');
      await operations.close();
      await expectLater(
        operations.mutate(request('cancelled-private-id', GalleryMutation.trash, [ref(cancelledSource)])),
        failure(GalleryErrorCode.unavailable),
      );
      expect(await File(path.join(originals.path, cancelledSource.path)).readAsString(), 'retained');
      final diagnostics = records.where((record) => record.loggerName == 'GalleryFileOperations').toList();
      final partial = diagnostics.singleWhere(
        (record) =>
            record.message.startsWith('Gallery mutation completed') &&
            record.message.contains('action=trash requested=2 succeeded=1 failed=1'),
      );
      expect(partial.level, Level.WARNING);
      expect(partial.message, contains('action=trash requested=2 succeeded=1 failed=1'));
      expect(partial.message, contains('codes=notFound:1'));
      expect(partial.message, isNot(contains('elapsedMs=')));
      expect(
        diagnostics.any(
          (record) =>
              record.level == Level.INFO &&
              record.message.startsWith('Gallery mutation completed') &&
              record.message.contains('action=restore'),
        ),
        isTrue,
      );
      final cancelled = diagnostics.singleWhere((record) => record.message.startsWith('Gallery mutation cancelled'));
      expect(cancelled.level, Level.FINE);
      expect(cancelled.message, contains('action=trash'));
      expect(diagnostics.every((record) => !record.message.contains('operationId=')), isTrue);
      for (final record in diagnostics) {
        if (record.error != null) expect(record.stackTrace, isNotNull);
        for (final secret in [
          'PRIVATE_',
          'AUTH_SECRET',
          'http://',
          root.path,
          unsafeId,
          'cancelled-private-id',
          'log-partial',
        ]) {
          expect(record.message, isNot(contains(secret)));
        }
      }
    }),
  );

  test(
    'an accepted filesystem failure remains a warning while close drains it',
    () => captureLogs((records) async {
      final source = await photo('PRIVATE_DRAINING.jpg', 'retained');
      await operations.close();
      final blocked = await File(path.join(root.path, 'blocked')).writeAsString('not a directory');
      operations = GalleryFileOperations(catalog: catalog, trashDirectory: Directory(path.join(blocked.path, 'trash')));
      final gate = Completer<void>();
      final preceding = operations.withMediaLock(() => gate.future);
      final pending = operations.mutate(request('draining-error', GalleryMutation.trash, [ref(source)]));
      final closing = operations.close();
      gate.complete();
      await preceding;
      final failed = (await pending).items.single;
      expect(failed.state, GalleryItemOperationState.failed);
      expect(failed.error, GalleryErrorCode.unavailable);
      await closing;
      final diagnostic = records.singleWhere(
        (record) =>
            record.loggerName == 'GalleryFileOperations' && record.message.startsWith('Gallery mutation completed'),
      );
      expect(diagnostic.level, Level.WARNING);
      expect(diagnostic.message, contains('succeeded=0 failed=1 codes=unavailable:1'));
      expect(diagnostic.message, isNot(contains('PRIVATE_')));
      expect(diagnostic.error, isNull);
      expect(diagnostic.stackTrace, isNull);
      expect(
        records.any(
          (record) =>
              record.level == Level.FINE &&
              record.message.startsWith('Gallery mutation item failed') &&
              record.message.contains('type=FileSystemException'),
        ),
        isTrue,
      );
      expect(await File(path.join(originals.path, source.path)).readAsString(), 'retained');
    }),
  );
}
