// Exercise mirrored hidden files on the real filesystem.
// ignore_for_file: avoid_slow_async_io
import 'dart:io';

import 'package:dslideshow_backend/src/service/gallery/gallery_catalog_service.dart';
import 'package:dslideshow_backend/src/service/gallery/gallery_file_operations.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';

import 'helpers/capture_logs.dart';
import 'support/no_watch_directory.dart';

void main() {
  late Directory root, originals;
  late GalleryCatalogService catalog;
  late GalleryFileOperations operations;
  var serial = 0;

  setUp(() async {
    root = await Directory.systemTemp.createTemp('gallery-hidden-');
    originals = await Directory(path.join(root.path, 'images')).create();
    catalog = GalleryCatalogService(
      originals: NoWatchDirectory(originals),
      stateDirectory: Directory('${originals.path}.gallery'),
    );
    operations = GalleryFileOperations(catalog: catalog);
  });
  tearDown(() async {
    await operations.close();
    await catalog.close();
    await root.delete(recursive: true);
  });

  Future<GalleryEntry> write(String relative, [String contents = 'original']) async {
    final file = File(path.join(originals.path, relative));
    await file.parent.create(recursive: true);
    await file.writeAsString(contents);
    return (await catalog.refresh(
      GalleryRefreshRequest(operationId: 'fixture-${serial++}', mode: GalleryRefreshMode.scan),
    )).entries.singleWhere((entry) => entry.path == relative);
  }

  GalleryMediaRef originalRef(GalleryEntry entry) =>
      GalleryMediaRef(section: entry.section, mediaId: entry.mediaId, sourceRevision: entry.sourceRevision);
  GalleryMediaRef hiddenRef(GalleryEntry entry) =>
      GalleryMediaRef(mediaId: entry.mediaId, sourceRevision: entry.sourceRevision, section: entry.section);
  Future<GalleryOperationResult> mutate(GalleryMutation action, List<GalleryMediaRef> items) =>
      operations.mutate(GalleryOperationRequest(operationId: 'operation-${serial++}', action: action, items: items));
  Future<GalleryEntry> hide(GalleryEntry entry) async {
    final result = await mutate(GalleryMutation.hide, [originalRef(entry)]);
    expect(result.items.single.state, GalleryItemOperationState.succeeded);
    return (await operations.mediaCatalog(GalleryMediaSection.hidden)).entries
        .singleWhere((item) => item.path == entry.path);
  }

  test('hide mirrors account paths, survives restart and unhide restores original bytes', () async {
    const relative = 'yandex.drive.42/Фотокамера/2026/фото.jpg';
    final entry = await write(relative);
    final hidden = await hide(entry);
    expect(hidden.path, relative);
    expect(hidden.mediaId, startsWith('hidden-'));
    expect(await File(path.join(originals.path, relative)).exists(), isFalse);
    expect((await catalog.catalog()).entries.where((entry) => entry.kind != GalleryEntryKind.directory), isEmpty);
    await operations.close();
    operations = GalleryFileOperations(catalog: catalog);
    expect((await operations.mediaCatalog(GalleryMediaSection.hidden)).entries.single, hidden);
    final file = await operations.mediaFile(
      GalleryMediaRef(
        section: GalleryMediaSection.hidden,
        mediaId: hidden.mediaId,
        sourceRevision: hidden.sourceRevision,
      ),
    );
    expect(await file.readAsString(), 'original');
    final restored = await mutate(GalleryMutation.unhide, [hiddenRef(hidden)]);
    expect(restored.items.single.restoredPath, relative);
    expect(await File(path.join(originals.path, relative)).readAsString(), 'original');
    expect((await operations.mediaCatalog(GalleryMediaSection.hidden)).entries, isEmpty);
    expect((await operations.mediaCatalog(GalleryMediaSection.trash)).entries, isEmpty);
  });

  test('hidden to trash removes the import block and trash restore returns to visible media', () async {
    final entry = await write('family/photo.jpg');
    final hidden = await hide(entry);
    final moved = await mutate(GalleryMutation.trash, [hiddenRef(hidden)]);
    expect(moved.items.single.state, GalleryItemOperationState.succeeded);
    expect((await operations.mediaCatalog(GalleryMediaSection.hidden)).entries, isEmpty);
    final trash = (await operations.mediaCatalog(GalleryMediaSection.trash)).entries.single;
    await File(path.join(originals.path, entry.path)).writeAsString('download');
    expect(await File(path.join(originals.path, entry.path)).readAsString(), 'download');
    final restored = await mutate(GalleryMutation.restore, [
      GalleryMediaRef(section: trash.section, mediaId: trash.mediaId, sourceRevision: trash.sourceRevision),
    ]);
    expect(restored.items.single.restoredPath, 'family/photo (restored 1).jpg');
    expect(await File(path.join(originals.path, restored.items.single.restoredPath!)).readAsString(), 'original');
    expect((await operations.mediaCatalog(GalleryMediaSection.hidden)).entries, isEmpty);
  });

  test('hide conflicts and stale unhide preserve both filesystem versions', () async {
    final entry = await write('photo.jpg');
    await operations.hiddenDirectory.create(recursive: true);
    final occupying = await File(path.join(operations.hiddenDirectory.path, entry.path))
        .writeAsString('hidden version');
    final conflict = await mutate(GalleryMutation.hide, [originalRef(entry)]);
    expect(conflict.items.single.error, GalleryErrorCode.conflict);
    expect(await File(path.join(originals.path, entry.path)).readAsString(), 'original');
    final hidden = (await operations.mediaCatalog(GalleryMediaSection.hidden)).entries.single;
    await occupying.writeAsString('replacement hidden version');
    final stale = await mutate(GalleryMutation.unhide, [hiddenRef(hidden)]);
    expect(stale.items.single.error, GalleryErrorCode.revisionMismatch);
    expect(await occupying.readAsString(), 'replacement hidden version');
  });

  test('hide logs bounded operation outcomes without paths or per-file INFO', () async {
    final entry = await write('private/family-secret.jpg');
    await captureLogs((records) async {
      await hide(entry);
      final info = records
          .where((record) => record.loggerName == 'GalleryFileOperations' && record.level == Level.INFO)
          .toList();
      expect(info.where((record) => record.message.contains('action=hide')), hasLength(2));
      expect(info.last.message, contains('succeeded=1 failed=0'));
      expect(info.map((record) => record.message).join('\n'), isNot(contains('family-secret')));
      expect(info.map((record) => record.message).join('\n'), isNot(contains(root.path)));
    });
  });
}
