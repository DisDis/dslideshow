// Actual publication and mirrored hidden state use a small real filesystem.
// ignore_for_file: avoid_slow_async_io
import 'dart:async';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dslideshow_backend/app_storage.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/src/service/storage/cloud_storage_transfer.dart';
import 'package:dslideshow_backend/src/service/gallery/gallery_catalog_service.dart';
import 'package:dslideshow_backend/src/service/gallery/gallery_file_operations.dart';
import 'package:dslideshow_backend/src/service/storage/yandex_drive/yandex_drive_storage.dart';
import 'package:dslideshow_backend/src/service/yandex_drive/yandex_drive_api.dart';
import 'package:dslideshow_backend/src/service/yandex_drive/yandex_drive_models.dart';
import 'package:dslideshow_backend/src/service/yandex_drive/yandex_drive_service.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:dslideshow_common/storage_status.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';

import 'support/no_watch_directory.dart';

enum _StopImport { pause, disconnect, release }

class _FilesApi extends YandexDriveApi {
  final files = <String, List<int>>{
    'disk:/Camera/a.jpg': [1, 2, 3],
    'disk:/Camera/2026/b.mp4': [4, 5, 6],
    'disk:/Trip/a.jpg': [1, 2, 3],
  };
  final resourceCalls = <String>[];
  final resourceRequests = <(String, int)>[];
  final downloads = <String>[];
  int closeCalls = 0;
  Completer<YandexDriveDeviceResponse>? authorizationResponse;
  bool badChecksum = false;
  bool firstAccountFails = false;
  Future<YandexDriveResource> Function(String token, String remotePath, int offset)? resourceResponse;
  int tokenCalls = 0;
  Future<YandexDriveTokenResponse> Function()? tokenResponse;
  Stream<List<int>> Function()? downloadBody;

  @override
  Future<YandexDriveDeviceResponse> startDevice(String clientId) => authorizationResponse!.future;

  @override
  Future<YandexDriveResource> resources(String token, String remotePath, int offset) async {
    resourceCalls.add(remotePath);
    resourceRequests.add((remotePath, offset));
    if (resourceResponse case final response?) return response(token, remotePath, offset);
    if (firstAccountFails && token == 'token-123') throw const CloudStorageException(DriveFailure.authorizationDenied);
    final childPaths = files.keys.where((item) => path.posix.dirname(item) == remotePath).toList();
    final childDirectories = files.keys
        .where((item) => item.startsWith('$remotePath/'))
        .map((item) => path.posix.dirname(item))
        .where((item) => item != remotePath && path.posix.dirname(item) == remotePath)
        .toSet();
    final items = [
      for (final directory in childDirectories)
        YandexDriveResource(path: directory, name: path.posix.basename(directory), type: YandexDriveResourceType.dir),
      for (final item in childPaths)
        YandexDriveResource(
          path: item,
          name: path.posix.basename(item),
          type: YandexDriveResourceType.file,
          size: files[item]!.length,
          md5: badChecksum ? '00000000000000000000000000000000' : md5.convert(files[item]!).toString(),
        ),
    ];
    return YandexDriveResource(
      path: remotePath,
      type: YandexDriveResourceType.dir,
      children: YandexDriveResourceList(items: items, total: items.length, limit: 100),
    );
  }

  @override
  Future<YandexDriveTokenResponse> token(Map<String, String> form) async {
    tokenCalls++;
    if (tokenResponse case final response?) return response();
    return const YandexDriveTokenResponse(accessToken: 'refreshed-token', expiresIn: 3600);
  }

  @override
  Future<YandexDriveDownload> download(String token, String remotePath) async {
    downloads.add(remotePath);
    return YandexDriveDownload(
      http.StreamedResponse(
        downloadBody?.call() ?? Stream.value(files[remotePath]!),
        200,
        contentLength: files[remotePath]!.length,
      ),
      MockClient((_) async => http.Response('', 500)),
    );
  }

  @override
  void close() {
    closeCalls++;
    super.close();
  }
}

void main() {
  late Directory root, originals;
  late AppStorage appStorage;
  late GalleryCatalogService catalog;
  late GalleryFileOperations operations;
  late YandexDriveService connections;
  late _FilesApi api;
  YandexDriveStorage? storage;
  var serial = 0;

  setUp(() async {
    root = await Directory.systemTemp.createTemp('yandex-storage-');
    originals = await Directory(path.join(root.path, 'images')).create();
    appStorage = AppStorage(root.path);
    appStorage.setValue('YandexDrive.clientId', 'application');
    appStorage.setValue('YandexDrive.accounts', {
      for (final id in ['123', '456'])
        id: {
          'accountId': id,
          'label': 'Family $id',
          'accessToken': 'token-$id',
          'refreshToken': 'refresh-$id',
          'expiresAt': DateTime.now().toUtc().add(const Duration(days: 1)).toIso8601String(),
        },
    });
    appStorage.save();
    catalog = GalleryCatalogService(
      originals: NoWatchDirectory(originals),
      stateDirectory: Directory('${originals.path}.gallery'),
    );
    operations = GalleryFileOperations(catalog: catalog);
    api = _FilesApi();
    connections = YandexDriveService(appStorage, api: api);
    storage = null;
  });
  tearDown(() async {
    if (storage != null) {
      await storage!.release();
    }
    await operations.close();
    await catalog.close();
    appStorage.save();
    await root.delete(recursive: true);
  });

  Future<YandexDriveStorage> create({List<YandexDriveAccountConfig>? accounts}) async {
    final result = storage = YandexDriveStorage(
      YandexDriveStorageConfig(
        accounts:
            accounts ??
            [
              const YandexDriveAccountConfig(accountId: '123', paths: ['disk:/Camera', 'disk:/Camera/2026']),
              const YandexDriveAccountConfig(accountId: '456', paths: ['disk:/Trip']),
            ],
      ),
      connections,
      appStorage,
      folder: NoWatchDirectory(originals),
      hidden: operations.directory(GalleryMediaSection.hidden),
    );
    await result.init();
    return result;
  }

  Future<List<GalleryEntry>> refresh() async =>
      (await catalog.refresh(GalleryRefreshRequest(operationId: 'refresh-${serial++}', mode: GalleryRefreshMode.scan)))
          .entries;

  test('multiple accounts keep full paths, overlapping roots scan once and existing files are skipped', () async {
    final current = await create();
    await current.sync();
    expect(current.runtime.downloaded, 3);
    expect(current.runtime.totalItems, 4);
    expect(current.runtime.processedItems, 4);
    expect(current.runtime.progress, 1);
    expect(current.status, StorageStatusEnum.done);
    expect(api.resourceCalls.where((value) => value == 'disk:/Camera/2026').length, 1);
    expect(await File(path.join(originals.path, 'yandex.drive.123/Camera/2026/b.mp4')).readAsBytes(), [4, 5, 6]);
    expect(await File(path.join(originals.path, 'yandex.drive.456/Trip/a.jpg')).readAsBytes(), [1, 2, 3]);
    expect(current.runtime.lastSync, isNotNull);
    await current.sync();
    expect(api.downloads.length, 3);
    expect(current.runtime.skipped, 3);
    expect(current.runtime.failed, 0);
    expect(current.runtime.totalItems, 4);
    expect(current.runtime.processedItems, 4);
  });

  test('folder totals expand the estimate once per folder without a counting pass or duplicate page totals', () async {
    api.files
      ..clear()
      ..addAll({
        'disk:/Camera/a.jpg': [1],
        'disk:/Camera/Nested/b.jpg': [2],
        'disk:/Camera/Nested/c.jpg': [3],
        'disk:/Camera/Nested/d.jpg': [4],
      });
    final existing = File(path.join(originals.path, 'yandex.drive.123/Camera/a.jpg'));
    await existing.parent.create(recursive: true);
    await existing.writeAsBytes([1]);
    final rootEntered = Completer<void>();
    final rootPage = Completer<YandexDriveResource>();
    final nestedEntered = Completer<void>();
    final nestedPage = Completer<YandexDriveResource>();
    YandexDriveResource file(String remote) =>
        YandexDriveResource(path: remote, type: YandexDriveResourceType.file, size: 1);
    api.resourceResponse = (token, remote, offset) async {
      if (remote == 'disk:/Camera' && offset == 0) {
        rootEntered.complete();
        return rootPage.future;
      }
      if (remote == 'disk:/Camera/Nested') {
        nestedEntered.complete();
        return nestedPage.future;
      }
      expect((remote, offset), ('disk:/Camera', 2));
      return YandexDriveResource(
        path: remote,
        type: YandexDriveResourceType.dir,
        children: YandexDriveResourceList(items: [file('disk:/Camera/a.jpg')], total: 3, offset: 2),
      );
    };
    final bodyStarted = Completer<void>();
    final body = StreamController<List<int>>(onListen: bodyStarted.complete);
    api.downloadBody = () => body.stream;
    final current = await create(
      accounts: [
        const YandexDriveAccountConfig(accountId: '123', paths: ['disk:/Camera', 'disk:/Camera/Nested']),
      ],
    );
    final syncing = current.sync();
    await rootEntered.future;
    expect(current.status, StorageStatusEnum.download);
    expect(current.runtime.totalItems, isNull);
    expect(current.runtime.progress, isNull);
    rootPage.complete(
      YandexDriveResource(
        path: 'disk:/Camera',
        type: YandexDriveResourceType.dir,
        children: YandexDriveResourceList(
          items: [
            file('disk:/Camera/readme.txt'),
            const YandexDriveResource(path: 'disk:/Camera/Nested', type: YandexDriveResourceType.dir),
          ],
          total: 3,
        ),
      ),
    );
    await nestedEntered.future;
    expect(current.runtime.totalItems, 3);
    expect(current.runtime.processedItems, 2, reason: 'The skipped text file and the directory are processed items');
    expect(current.runtime.progress, closeTo(2 / 3, 0.0001));
    nestedPage.complete(
      YandexDriveResource(
        path: 'disk:/Camera/Nested',
        type: YandexDriveResourceType.dir,
        children: YandexDriveResourceList(
          items: [
            file('disk:/Camera/Nested/b.jpg'),
            file('disk:/Camera/Nested/c.jpg'),
            file('disk:/Camera/Nested/d.jpg'),
          ],
          total: 3,
        ),
      ),
    );
    await bodyStarted.future;
    expect(current.runtime.totalItems, 6);
    expect(current.runtime.processedItems, 2);
    expect(current.runtime.progress, closeTo(1 / 3, 0.0001));
    api.downloadBody = null;
    body.add([2]);
    await body.close();
    await syncing;
    expect(current.runtime.totalItems, 6);
    expect(current.runtime.processedItems, 6);
    expect(current.runtime.progress, 1);
    expect(current.runtime.downloaded, 3);
    expect(current.runtime.skipped, 2);
    expect(current.runtime.failed, 0);
    expect(api.resourceRequests, [('disk:/Camera', 0), ('disk:/Camera/Nested', 0), ('disk:/Camera', 2)]);
  });

  test('first pass skips existing library and hidden files before requesting any downloads', () async {
    final existing = {
      File(path.join(originals.path, 'yandex.drive.123/Camera/a.jpg')): [9, 8, 7],
      File(path.join(operations.directory(GalleryMediaSection.hidden).path, 'yandex.drive.123/Camera/2026/b.mp4')): [
        6,
        5,
        4,
      ],
      File(path.join(operations.directory(GalleryMediaSection.hidden).path, 'yandex.drive.456/Trip/a.jpg')): [3, 2, 1],
    };
    for (final entry in existing.entries) {
      await entry.key.parent.create(recursive: true);
      await entry.key.writeAsBytes(entry.value);
    }
    final current = await create();
    await current.sync();
    expect(api.downloads, isEmpty, reason: 'Existing paths are checked before requesting download URLs or bodies');
    expect(current.runtime.skipped, 3);
    expect(current.runtime.failed, 0);
    for (final entry in existing.entries) {
      expect(await entry.key.readAsBytes(), entry.value);
    }
  });

  test('initialization creates a missing images directory before starting selected storage', () async {
    await originals.delete(recursive: true);
    final current = await create();
    await current.sync();
    expect(current.runtime.downloaded, 3);
    expect(await File(path.join(originals.path, 'yandex.drive.123/Camera/a.jpg')).readAsBytes(), [1, 2, 3]);
  });

  test('initialization failure logs the original filesystem error and preserves its stack', () async {
    await originals.delete(recursive: true);
    await File(originals.path).writeAsString('conflicting file');
    final records = <LogRecord>[];
    final logs = Logger.root.onRecord.where((record) => record.loggerName == 'YandexDriveStorage').listen(records.add);
    addTearDown(logs.cancel);
    try {
      await create();
      fail('A regular file cannot be used as the images directory');
    } on FileSystemException catch (error, stack) {
      final diagnostic = records.singleWhere((record) => record.message.startsWith('Storage initialization failed'));
      expect(diagnostic.error, same(error));
      expect(diagnostic.error.toString(), contains(originals.path));
      expect(diagnostic.stackTrace.toString(), stack.toString());
      expect(diagnostic.stackTrace.toString(), contains('yandex_drive_storage.dart'));
      expect(storage!.status, StorageStatusEnum.off);
    }
  });

  test('hidden path suppresses download and moving it to trash permits import again', () async {
    final current = await create(
      accounts: [
        const YandexDriveAccountConfig(accountId: '123', paths: ['disk:/Camera']),
      ],
    );
    await current.sync();
    final selected = (await refresh()).firstWhere((entry) => entry.path.endsWith('/a.jpg'));
    await operations.mutate(
      GalleryOperationRequest(
        operationId: 'hide',
        action: GalleryMutation.hide,
        items: [
          GalleryMediaRef(
            section: selected.section,
            mediaId: selected.mediaId,
            sourceRevision: selected.sourceRevision,
          ),
        ],
      ),
    );
    await current.sync();
    expect(api.downloads.length, 2);
    final hidden = (await operations.mediaCatalog(GalleryMediaSection.hidden)).entries.single;
    await operations.mutate(
      GalleryOperationRequest(
        operationId: 'trash',
        action: GalleryMutation.trash,
        items: [
          GalleryMediaRef(mediaId: hidden.mediaId, sourceRevision: hidden.sourceRevision, section: hidden.section),
        ],
      ),
    );
    await current.sync();
    expect(api.downloads.length, 3);
    expect(await File(path.join(originals.path, selected.path)).exists(), isTrue);
  });

  test('checksum mismatch never publishes and cleans closed staging files', () async {
    api.badChecksum = true;
    final current = await create();
    await current.sync();
    expect(current.runtime.downloaded, 0);
    expect(current.runtime.failed, 3);
    expect(current.runtime.processedItems, 4);
    expect(current.runtime.totalItems, 4);
    expect(current.runtime.progress, 1);
    expect(current.runtime.error, DriveFailure.checksum);
    expect(current.status, StorageStatusEnum.off);
    expect(await originals.list(recursive: true).where((entry) => entry is File).toList(), isEmpty);
  });

  test('an account failure does not stop another account and summary logs stay bounded', () async {
    api.firstAccountFails = true;
    final logs = <LogRecord>[];
    final subscription = Logger.root.onRecord.listen(logs.add);
    final current = await create();
    await current.sync();
    expect(current.runtime.failed, 1);
    expect(current.runtime.downloaded, 1);
    expect(await File(path.join(originals.path, 'yandex.drive.456/Trip/a.jpg')).exists(), isTrue);
    expect(logs.where((entry) => entry.loggerName == 'YandexDriveStorage' && entry.level == Level.INFO).length, 2);
    expect(
      logs.any((entry) => entry.loggerName == 'YandexDriveStorage' && entry.message.contains('downloaded=1')),
      isTrue,
    );
    expect(logs.map((entry) => entry.message).join(' '), isNot(contains('token-')));
    await subscription.cancel();
  });

  for (final stop in _StopImport.values) {
    test('$stop waits for pending metadata and starts no file or next page after its response', () async {
      final entered = Completer<void>();
      final response = Completer<YandexDriveResource>();
      api.resourceResponse = (token, remotePath, offset) {
        entered.complete();
        return response.future;
      };
      final logs = <LogRecord>[];
      final subscription = Logger.root.onRecord.listen(logs.add);
      addTearDown(subscription.cancel);
      final current = await create();
      var finished = false;
      final syncing = current.sync().then((_) => finished = true);
      await entered.future;
      Future<void>? releasing;
      var released = false;
      switch (stop) {
        case _StopImport.pause:
          current.setPaused(true);
        case _StopImport.disconnect:
          connections.disconnect('123');
        case _StopImport.release:
          releasing = current.release().then((_) => released = true);
          storage = null;
      }
      await Future<void>.delayed(Duration.zero);
      expect(finished, isFalse);
      expect(current.runtime.running, isTrue);
      expect(released, isFalse);
      expect(api.closeCalls, 0);
      response.complete(
        const YandexDriveResource(
          path: 'disk:/Camera',
          type: YandexDriveResourceType.dir,
          children: YandexDriveResourceList(
            items: [YandexDriveResource(path: 'disk:/Camera/a.jpg', type: YandexDriveResourceType.file, size: 3)],
            total: 2,
            limit: 1,
          ),
        ),
      );
      await syncing;
      await releasing;
      expect(api.resourceRequests, [('disk:/Camera', 0)]);
      expect(api.downloads, isEmpty);
      expect(api.tokenCalls, 0);
      expect(current.runtime.running, isFalse);
      expect(current.runtime.failed, 0);
      expect(current.runtime.downloaded, 0);
      expect(current.runtime.lastSync, isNull);
      expect(logs.where((entry) => entry.loggerName == 'YandexDriveStorage' && entry.level >= Level.WARNING), isEmpty);
      expect(logs.any((entry) => entry.message.contains('Synchronization stopped downloaded=0')), isTrue);
      if (stop == _StopImport.release) {
        expect(released, isTrue);
        expect(api.closeCalls, 1);
      }
    });
  }

  test('a metadata 401 after pause does not refresh credentials or start a download', () async {
    final entered = Completer<void>();
    final response = Completer<YandexDriveResource>();
    api.resourceResponse = (token, remotePath, offset) {
      entered.complete();
      return response.future;
    };
    final logs = <LogRecord>[];
    final subscription = Logger.root.onRecord.listen(logs.add);
    addTearDown(subscription.cancel);
    final current = await create();
    final syncing = current.sync();
    await entered.future;
    current.setPaused(true);
    response.completeError(const CloudStorageException(DriveFailure.authorizationRequired));
    await syncing;
    expect(api.tokenCalls, 0);
    expect(api.resourceRequests, [('disk:/Camera', 0)]);
    expect(api.downloads, isEmpty);
    expect(current.runtime.failed, 0);
    expect(current.runtime.error, isNull);
    expect(current.runtime.lastSync, isNull);
    expect(logs.where((entry) => entry.level >= Level.WARNING), isEmpty);
  });

  test('pause waits for an active token refresh but does not repeat metadata after its response', () async {
    final refreshing = Completer<void>();
    final refreshed = Completer<YandexDriveTokenResponse>();
    api.resourceResponse = (token, remotePath, offset) async {
      throw const CloudStorageException(DriveFailure.authorizationRequired);
    };
    api.tokenResponse = () {
      refreshing.complete();
      return refreshed.future;
    };
    final current = await create();
    var finished = false;
    final syncing = current.sync().then((_) => finished = true);
    await refreshing.future;
    current.setPaused(true);
    await Future<void>.delayed(Duration.zero);
    expect(finished, isFalse);
    refreshed.complete(const YandexDriveTokenResponse(accessToken: 'new-access', expiresIn: 3600));
    await syncing;
    expect(api.tokenCalls, 1);
    expect(api.resourceRequests, [('disk:/Camera', 0)]);
    expect(api.downloads, isEmpty);
    expect(current.runtime.failed, 0);
    expect(current.runtime.error, isNull);
    expect(current.runtime.lastSync, isNull);
  });

  test('pause and resume while a file is pending continue the same pass after completing it', () async {
    api.files
      ..clear()
      ..addAll({
        'disk:/Camera/a.jpg': [1, 2, 3],
        'disk:/Camera/b.jpg': [4, 5, 6],
        'disk:/Trip/c.jpg': [7, 8, 9],
      });
    final started = Completer<void>();
    final body = StreamController<List<int>>(onListen: started.complete);
    api.downloadBody = () => body.stream;
    final current = await create();
    final syncing = current.sync();
    await started.future;
    current.setPaused(true);
    current.setPaused(false);
    await Future<void>.delayed(Duration.zero);
    expect(api.downloads, ['disk:/Camera/a.jpg']);
    expect(api.resourceRequests, [('disk:/Camera', 0)]);
    expect(current.runtime.running, isTrue);
    api.downloadBody = null;
    body.add([1, 2, 3]);
    await body.close();
    await syncing;
    expect(api.downloads, ['disk:/Camera/a.jpg', 'disk:/Camera/b.jpg', 'disk:/Trip/c.jpg']);
    expect(api.resourceRequests, [('disk:/Camera', 0), ('disk:/Trip', 0)]);
    expect(current.runtime.failed, 0);
    expect(current.runtime.downloaded, 3);
    expect(current.runtime.lastSync, isNotNull);
  });

  for (final stop in _StopImport.values) {
    test('$stop finishes the active file and stops before another file or account', () async {
      api.files
        ..clear()
        ..addAll({
          'disk:/Camera/a.jpg': [1, 2, 3],
          'disk:/Camera/b.jpg': [4, 5, 6],
          'disk:/Trip/c.jpg': [7, 8, 9],
        });
      final logs = <LogRecord>[];
      final subscription = Logger.root.onRecord.listen(logs.add);
      addTearDown(subscription.cancel);
      final bodyStarted = Completer<void>();
      final body = StreamController<List<int>>(onListen: () => bodyStarted.complete());
      api.downloadBody = () => body.stream;
      final current = await create();
      var finished = false;
      final sync = current.sync()..then((_) => finished = true);
      await bodyStarted.future;
      body.add([1]);
      await Future<void>.delayed(Duration.zero);
      Future<void>? release;
      var released = false;
      Future<DriveAuthorization>? authorization;
      switch (stop) {
        case _StopImport.pause:
          current.setPaused(true);
        case _StopImport.disconnect:
          connections.disconnect('123');
        case _StopImport.release:
          api.authorizationResponse = Completer<YandexDriveDeviceResponse>();
          authorization = connections.startAuthorization();
          release = current.release().then((_) => released = true);
          storage = null;
      }
      await Future<void>.delayed(Duration.zero);
      expect(finished, isFalse);
      expect(api.closeCalls, 0);
      expect(await File(path.join(originals.path, 'yandex.drive.123/Camera/a.jpg')).exists(), isFalse);
      if (stop == _StopImport.release) {
        expect(released, isFalse);
        expect(api.authorizationResponse!.isCompleted, isFalse);
        final rejected = await current.executeDriveCommand(
          const DriveCommand(provider: StorageType.YandexDriveStorage, id: 99, action: DriveAction.startAuthorization),
        );
        expect(rejected.error, DriveFailure.notActive);
      }
      body.add([2, 3]);
      await body.close();
      await sync;
      if (stop == _StopImport.release) {
        expect(released, isFalse);
        expect(api.closeCalls, 0, reason: 'The media body is complete but an accepted OAuth response is still pending');
        api.authorizationResponse!.complete(
          YandexDriveDeviceResponse.fromJson({
            'device_code': 'private-device',
            'user_code': 'private-code',
            'verification_url': 'https://oauth.yandex.ru/device',
            'interval': 5,
            'expires_in': 60,
          }),
        );
        expect((await authorization)!.status, DriveAuthorizationStatus.cancelled);
        expect(api.tokenCalls, 0);
      }
      await release;
      expect(current.runtime.failed, 0);
      expect(current.runtime.running, isFalse);
      expect(current.runtime.downloaded, 1);
      expect(current.runtime.lastSync, isNull);
      expect(api.downloads, ['disk:/Camera/a.jpg']);
      expect(await File(path.join(originals.path, 'yandex.drive.123/Camera/a.jpg')).readAsBytes(), [1, 2, 3]);
      expect(
        logs.where((record) => record.loggerName == 'YandexDriveStorage' && record.level >= Level.WARNING),
        isEmpty,
      );
      expect(logs.any((record) => record.message.contains('Synchronization stopped downloaded=1')), isTrue);
      if (stop == _StopImport.release) {
        expect(released, isTrue);
        expect(api.closeCalls, 1);
      } else if (stop == _StopImport.pause) {
        api.downloadBody = null;
        current.setPaused(false);
        await current.sync();
        expect(current.runtime.downloaded, 2);
        expect(current.runtime.skipped, 1);
      }
    });
  }
}
