// Small real trees exercise path lookup without starting a directory watcher.
// ignore_for_file: avoid_slow_async_io
import 'dart:io';

import 'package:dslideshow_backend/src/service/storage/disk/disk_storage.dart';
import 'package:dslideshow_backend/src/service/storage/disk/disk_storage_config.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';

void main() {
  late Directory root;
  final storages = <DiskStorage>[];

  setUp(() async {
    root = await Directory.systemTemp.createTemp('disk-storage-hidden-');
  });
  tearDown(() async {
    for (final storage in storages) {
      await storage.release();
    }
    storages.clear();
    await root.delete(recursive: true);
  });

  DiskStorage createStorage({Directory? folder, Directory? hidden}) {
    final storage = DiskStorage(
      DiskStorageConfig(),
      folder: folder ?? Directory(path.join(root.path, 'images')),
      hidden: hidden,
    );
    storages.add(storage);
    return storage;
  }

  test('default hidden root is normalized and construction and missing lookup do not create directories', () async {
    final configured = Directory(path.join(root.path, 'unused', '..', 'images'));
    final storage = createStorage(folder: configured);
    expect(storage.folder, same(configured));
    expect(storage.hidden.path, path.join(root.path, 'images.gallery', 'hidden'));
    expect(await Directory(path.join(root.path, 'images')).exists(), isFalse);
    expect(await storage.hidden.exists(), isFalse);
    expect(await storage.mediaExists('photo.jpg'), isFalse);
    expect(await Directory(path.join(root.path, 'images')).exists(), isFalse);
    expect(await storage.hidden.exists(), isFalse);
    expect(await root.list().toList(), isEmpty);
  });

  test('explicit hidden directory is preserved without creating it', () async {
    final custom = Directory(path.join(root.path, 'custom-gallery', 'hidden'));
    final storage = createStorage(hidden: custom);
    expect(storage.hidden, same(custom));
    expect(await custom.exists(), isFalse);
    expect(await storage.mediaExists('missing.jpg'), isFalse);
    expect(await root.list().toList(), isEmpty);
  });

  test('default hidden remains beside the configured alias rather than its canonical target', () async {
    final actual = await Directory(path.join(root.path, 'actual-images')).create();
    final original = await File(path.join(actual.path, 'photo.jpg')).writeAsString('visible');
    final alias = await Link(path.join(root.path, 'configured-images')).create(actual.path);
    final storage = createStorage(folder: Directory(alias.path));
    expect(storage.hidden.path, path.join(root.path, 'configured-images.gallery', 'hidden'));
    expect(storage.hidden.path, isNot(path.join(root.path, 'actual-images.gallery', 'hidden')));
    expect(await storage.mediaExists(path.basename(original.path)), isTrue);
  });

  test('lookup checks originals and hidden while retaining full nested and account paths', () async {
    final storage = createStorage();
    await storage.folder.create();
    await storage.hidden.create(recursive: true);
    await File(path.join(storage.folder.path, 'visible.jpg')).writeAsString('visible');
    await File(path.join(storage.hidden.path, 'hidden.jpg')).writeAsString('hidden');
    final repeated = File(path.join(storage.hidden.path, 'yandex.drive.123', 'a.jpg', 'a.jpg'));
    await repeated.parent.create(recursive: true);
    await repeated.writeAsString('account photo');
    expect(await storage.mediaExists('visible.jpg'), isTrue);
    expect(await storage.mediaExists('hidden.jpg'), isTrue);
    expect(await storage.mediaExists('missing.jpg'), isFalse);
    expect(await storage.mediaExists('yandex.drive.123/a.jpg/a.jpg'), isTrue);
    expect(await storage.mediaExists('yandex.drive.456/a.jpg/a.jpg'), isFalse);
    expect(await storage.mediaExists('a.jpg'), isFalse);
  });

  test('unsafe or empty relative path segments are rejected without touching the filesystem', () async {
    final storage = createStorage();
    for (final value in [
      '',
      '.',
      '..',
      '/photo.jpg',
      r'folder\photo.jpg',
      'a\u0000b',
      'a/../b',
      'a/./b',
      'a//b',
      'a/',
    ]) {
      await expectLater(storage.mediaExists(value), throwsA(isA<FormatException>()), reason: 'path rejected');
    }
    expect(await root.list().toList(), isEmpty);
  });

  test('native absolute paths are rejected while POSIX colon filenames remain relative', () async {
    final storage = createStorage();
    const value = 'C:/photo.jpg';
    if (path.isAbsolute(value)) {
      await expectLater(storage.mediaExists(value), throwsA(isA<FormatException>()));
    } else {
      final file = File(path.join(storage.folder.path, value));
      await file.parent.create(recursive: true);
      await file.writeAsString('relative colon path');
      expect(await storage.mediaExists(value), isTrue);
    }
  });

  test('lookup follows file and parent links in both roots but skips broken and directory links', () async {
    final storage = createStorage();
    await storage.folder.create();
    await storage.hidden.create(recursive: true);
    final outside = await Directory(path.join(root.path, 'outside')).create();
    final file = await File(path.join(outside.path, 'photo.jpg')).writeAsString('outside');
    await Link(path.join(storage.folder.path, 'visible-link.jpg')).create(file.path);
    await Link(path.join(storage.hidden.path, 'hidden-link.jpg')).create(file.path);
    await Link(path.join(storage.folder.path, 'linked-parent')).create(outside.path);
    await Link(path.join(storage.hidden.path, 'hidden-parent')).create(outside.path);
    await Link(path.join(storage.hidden.path, 'broken-link.jpg')).create(path.join(outside.path, 'missing.jpg'));
    for (final value in ['visible-link.jpg', 'hidden-link.jpg', 'linked-parent/photo.jpg', 'hidden-parent/photo.jpg']) {
      expect(await storage.mediaExists(value), isTrue);
    }
    expect(await storage.mediaExists('broken-link.jpg'), isFalse);
    expect(await storage.mediaExists('linked-parent'), isFalse);
    expect(await file.readAsString(), 'outside');
  });

  test('lookup reports false for a directory as the final file and a file as its ancestor', () async {
    final storage = createStorage();
    await storage.folder.create();
    await Directory(path.join(storage.folder.path, 'directory.jpg')).create();
    await File(path.join(storage.folder.path, 'parent')).writeAsString('file');
    expect(await storage.mediaExists('directory.jpg'), isFalse);
    expect(await storage.mediaExists('parent/photo.jpg'), isFalse);
  });

  test('hidden media does not enter the originals playback index', () async {
    final storage = createStorage();
    await storage.folder.create();
    await storage.hidden.create(recursive: true);
    final visible = await File(path.join(storage.folder.path, 'visible.jpg')).writeAsString('visible');
    await File(path.join(storage.hidden.path, 'hidden.jpg')).writeAsString('hidden');
    expect((await storage.next())?.uri, visible.uri);
    expect((await storage.next())?.uri, visible.uri);
  });
}
