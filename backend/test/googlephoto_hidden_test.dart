// Small real files prove the existing Google downloader respects hidden paths.
// ignore_for_file: avoid_slow_async_io
import 'dart:async';
import 'dart:io';

import 'package:dslideshow_backend/app_storage.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart' as config show StorageType;
import 'package:dslideshow_backend/src/service/googlephoto/googlephoto.dart';
import 'package:dslideshow_backend/src/service/storage/googlephoto/gphoto_storage.dart';
import 'package:dslideshow_backend/src/service/storage/googlephoto/gphoto_storage_config.dart';
import 'package:dslideshow_backend/src/service/storage/storage_type.dart' as media;
import 'package:dslideshow_common/rpc.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';

import 'support/no_watch_directory.dart';

class _Photos implements GooglePhotoService {
  _Photos({this.fail = false});
  final bool fail;
  @override
  Stream<AccessCredentials> get onUpdateCredentials => const Stream.empty();
  @override
  Future<Iterable<GooglePhotoItem>> getMediaItemInAlbum(String albumName, int width, int height) async {
    if (fail) throw const HttpException('https://signed.example/private-download-token');
    return [GooglePhotoItem('one', 'https://should-not-be-downloaded.invalid/private', 'image/jpeg')];
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  test('Google is a remote cloud storage and explicitly rejects unsupported account commands', () async {
    final root = await Directory.systemTemp.createTemp('google-drive-unsupported-');
    final appStorage = AppStorage(root.path);
    final logs = <LogRecord>[];
    final subscription = Logger.root.onRecord.listen(logs.add);
    final storage = GPhotoStorage(
      GPhotoStorageConfig.fromJson({}),
      appStorage,
      folder: Directory(path.join(root.path, 'images')),
      googlePhotoService: _Photos(),
    );
    try {
      expect(storage.type, media.StorageType.remote);
      final result = await storage.executeDriveCommand(
        const DriveCommand(
          id: 41,
          provider: config.StorageType.GPhotoStorage,
          action: DriveAction.configureApplication,
          clientSecret: 'private-google-secret',
        ),
      );
      expect(result, isA<ErrorResult>().having((value) => value.id, 'id', 41));
      expect((result as ErrorResult).error, 'Google Photos does not support cloud account commands');
      final diagnostic = logs.where((entry) => entry.loggerName == 'GPhotoStorage').toList();
      expect(diagnostic.single.message, contains('action=configureApplication reason=unsupported'));
      expect(diagnostic.single.level, Level.WARNING);
      expect(
        diagnostic.map((entry) => '${entry.message} ${entry.error ?? ''}').join(' '),
        isNot(contains('private-google-secret')),
      );
      expect(await root.list().toList(), isEmpty);
    } finally {
      await storage.release();
      await subscription.cancel();
      appStorage.save();
      await root.delete(recursive: true);
    }
  });

  test('Google uses the custom hidden root inherited from DiskStorage', () async {
    final root = await Directory.systemTemp.createTemp('google-custom-hidden-');
    final originals = await Directory(path.join(root.path, 'images')).create();
    final hidden = await Directory(path.join(root.path, 'custom-state', 'hidden')).create(recursive: true);
    final hiddenFile = await File(path.join(hidden.path, 'one_2560x1600.jpeg')).writeAsString('hidden');
    final appStorage = AppStorage(root.path);
    final storage = GPhotoStorage(
      GPhotoStorageConfig.fromJson({}),
      appStorage,
      folder: originals,
      hidden: hidden,
      googlePhotoService: _Photos(),
    );
    try {
      expect(storage.hidden, same(hidden));
      await storage.sync();
      expect(await originals.list().toList(), isEmpty);
      expect(await hiddenFile.readAsString(), 'hidden');
      expect(await Directory('${originals.path}.gallery').exists(), isFalse);
    } finally {
      await storage.release();
      appStorage.save();
      await root.delete(recursive: true);
    }
  });

  test('hidden generated filename is not downloaded again by Google', () async {
    final root = await Directory.systemTemp.createTemp('google-hidden-');
    final originals = await Directory(path.join(root.path, 'images')).create();
    final hidden = await Directory('${originals.path}.gallery/hidden').create(recursive: true);
    await File(path.join(hidden.path, 'one_2560x1600.jpeg')).writeAsString('hidden');
    final appStorage = AppStorage(root.path);
    final storage = GPhotoStorage(
      GPhotoStorageConfig.fromJson({}),
      appStorage,
      folder: originals,
      googlePhotoService: _Photos(),
    );
    try {
      await storage.sync();
      expect(await originals.list().toList(), isEmpty);
      expect(await File(path.join(hidden.path, 'one_2560x1600.jpeg')).readAsString(), 'hidden');
    } finally {
      await storage.release();
      appStorage.save();
      await root.delete(recursive: true);
    }
  });

  test('background Google failure logs type without a signed media URL', () async {
    final root = await Directory.systemTemp.createTemp('google-safe-log-');
    final originals = await Directory(path.join(root.path, 'images')).create();
    final appStorage = AppStorage(root.path);
    final logs = <LogRecord>[];
    final failure = Completer<void>();
    final subscription = Logger.root.onRecord.listen((entry) {
      logs.add(entry);
      if (entry.loggerName == 'GPhotoStorage' && entry.message.startsWith('Background synchronization failed')) {
        failure.complete();
      }
    });
    final storage = GPhotoStorage(
      GPhotoStorageConfig.fromJson({}),
      appStorage,
      folder: NoWatchDirectory(originals),
      googlePhotoService: _Photos(fail: true),
    );
    try {
      await storage.init();
      await failure.future.timeout(const Duration(seconds: 5));
      expect(logs.any((entry) => entry.message.contains('type=HttpException')), isTrue);
      expect(
        logs.map((entry) => '${entry.message} ${entry.error ?? ''}').join(' '),
        isNot(contains('private-download-token')),
      );
    } finally {
      await storage.release();
      await subscription.cancel();
      appStorage.save();
      await root.delete(recursive: true);
    }
  });
}
