// Provider commands use real private storage with external network responses replaced.
// ignore_for_file: avoid_slow_async_io
import 'dart:async';
import 'dart:io';

import 'package:dslideshow_backend/app_storage.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/src/service/storage/cloud_storage_transfer.dart';
import 'package:dslideshow_backend/config.dart' as storage_config show StorageType;
import 'package:dslideshow_backend/src/service/storage/yandex_drive/yandex_drive_storage.dart';
import 'package:dslideshow_backend/src/service/yandex_drive/yandex_drive_api.dart';
import 'package:dslideshow_backend/src/service/yandex_drive/yandex_drive_models.dart';
import 'package:dslideshow_backend/src/service/yandex_drive/yandex_drive_service.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';

import 'support/no_watch_directory.dart';

class _ProviderApi extends YandexDriveApi {
  int closeCalls = 0;
  int resourceCalls = 0;
  int tokenCalls = 0;
  Completer<YandexDriveDeviceResponse>? pendingDevice;
  static final device = YandexDriveDeviceResponse(
    deviceCode: 'private-device',
    userCode: 'private-user-code',
    verificationUrl: Uri(scheme: 'https', host: 'oauth.yandex.ru', path: '/device'),
    interval: 5,
    expiresIn: 60,
  );

  @override
  Future<YandexDriveDeviceResponse> startDevice(String clientId) => pendingDevice?.future ?? Future.value(device);

  @override
  Future<YandexDriveTokenResponse> token(Map<String, String> form) async {
    tokenCalls++;
    return const YandexDriveTokenResponse(error: 'authorization_pending');
  }

  @override
  Future<YandexDriveResource> resources(String token, String remotePath, int offset) async {
    resourceCalls++;
    return const YandexDriveResource(
      path: 'disk:/',
      type: YandexDriveResourceType.dir,
      children: YandexDriveResourceList(
        items: [YandexDriveResource(name: 'Camera', path: 'disk:/Camera', type: YandexDriveResourceType.dir)],
        total: 1,
        limit: 100,
      ),
    );
  }

  @override
  void close() {
    closeCalls++;
    super.close();
  }
}

class _UnavailableDirectory implements Directory {
  @override
  final String path = '/unavailable-provider-images';
  @override
  Directory get absolute => this;
  @override
  Future<Directory> create({bool recursive = false}) async => throw const FileSystemException('Unavailable');
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late Directory root, originals;
  late AppStorage appStorage;
  late _ProviderApi api;
  late YandexDriveService connections;

  setUp(() async {
    root = await Directory.systemTemp.createTemp('yandex-provider-');
    originals = Directory(path.join(root.path, 'images'));
    appStorage = AppStorage(root.path);
    appStorage.setValue('YandexDrive.clientId', 'family-app');
    appStorage.setValue('YandexDrive.accounts', {
      '123': {
        'accountId': '123',
        'label': 'Family',
        'accessToken': 'private-access',
        'refreshToken': 'private-refresh',
        'expiresAt': '2099-01-01T00:00:00Z',
      },
    });
    appStorage.save();
    api = _ProviderApi();
    connections = YandexDriveService(appStorage, api: api);
  });
  tearDown(() async {
    appStorage.save();
    await root.delete(recursive: true);
  });

  YandexDriveStorage create({Directory? directory}) => YandexDriveStorage(
    const YandexDriveStorageConfig(),
    connections,
    appStorage,
    folder: directory ?? NoWatchDirectory(originals),
  );

  test('inactive provider configures and authorizes accounts without starting playback or synchronization', () async {
    final storage = create();
    addTearDown(storage.release);
    final configured = await storage.executeDriveCommand(
      const DriveCommand(
        provider: storage_config.StorageType.YandexDriveStorage,
        id: 1,
        action: DriveAction.configureApplication,
        clientId: 'family-app',
        clientSecret: 'private-secret',
      ),
    );
    expect(configured.error, isNull);
    expect(configured.state.runtime.active, isFalse);
    expect(configured.state.clientSecretConfigured, isTrue);
    final start = await storage.executeDriveCommand(
      const DriveCommand(
        provider: storage_config.StorageType.YandexDriveStorage,
        id: 2,
        action: DriveAction.startAuthorization,
      ),
    );
    expect(start.id, 2);
    expect(start.authorization?.userCode, 'private-user-code');
    final status = await storage.executeDriveCommand(
      DriveCommand(
        provider: storage_config.StorageType.YandexDriveStorage,
        id: 3,
        action: DriveAction.authorization,
        sessionId: start.authorization!.sessionId,
      ),
    );
    expect(status.authorization?.status, DriveAuthorizationStatus.pending);
    final cancelled = await storage.executeDriveCommand(
      DriveCommand(
        provider: storage_config.StorageType.YandexDriveStorage,
        id: 4,
        action: DriveAction.cancelAuthorization,
        sessionId: start.authorization!.sessionId,
      ),
    );
    expect(cancelled.authorization?.status, DriveAuthorizationStatus.cancelled);
    expect(await originals.exists(), isFalse);
    expect(api.resourceCalls, 0);
    expect(api.tokenCalls, 0);
    expect(storage.runtime.running, isFalse);
  });

  test('inactive provider lists sources and disconnects any family account', () async {
    final storage = create();
    addTearDown(storage.release);
    final folders = await storage.executeDriveCommand(
      const DriveCommand(
        provider: storage_config.StorageType.YandexDriveStorage,
        id: 11,
        action: DriveAction.folders,
        accountId: '123',
      ),
    );
    expect(folders.error, isNull);
    expect(folders.folderPage?.folders.single.path, 'disk:/Camera');
    expect(folders.state.runtime.active, isFalse);
    final disconnected = await storage.executeDriveCommand(
      const DriveCommand(
        provider: storage_config.StorageType.YandexDriveStorage,
        id: 12,
        action: DriveAction.disconnectAccount,
        accountId: '123',
      ),
    );
    expect(disconnected.error, isNull);
    expect(disconnected.state.connections, isEmpty);
    expect(await originals.exists(), isFalse);
    expect(api.resourceCalls, 1);
  });

  test('inactive controls and invalid commands return typed errors with safe provider diagnostics', () async {
    final storage = create();
    addTearDown(storage.release);
    final logs = <LogRecord>[];
    final subscription = Logger.root.onRecord.listen(logs.add);
    addTearDown(subscription.cancel);
    for (final command in [
      const DriveCommand(provider: storage_config.StorageType.YandexDriveStorage, id: 21, action: DriveAction.syncNow),
      const DriveCommand(
        provider: storage_config.StorageType.YandexDriveStorage,
        id: 22,
        action: DriveAction.setPaused,
        paused: true,
      ),
    ]) {
      final result = await storage.executeDriveCommand(command);
      expect(result.id, command.id);
      expect(result.error, DriveFailure.notActive);
      expect(result.state.runtime.active, isFalse);
    }
    await expectLater(
      storage.sync(),
      throwsA(isA<CloudStorageException>().having((error) => error.code, 'code', DriveFailure.notActive)),
    );
    final invalid = await storage.executeDriveCommand(
      const DriveCommand(provider: storage_config.StorageType.GPhotoStorage, id: 314, action: DriveAction.state),
    );
    expect(invalid.id, 314);
    expect(invalid.error, DriveFailure.invalidRequest);
    final failed = await storage.executeDriveCommand(
      const DriveCommand(
        provider: storage_config.StorageType.YandexDriveStorage,
        id: 23,
        action: DriveAction.configureApplication,
        clientId: 'invalid private-secret',
      ),
    );
    expect(failed.error, DriveFailure.invalidRequest);
    final diagnostics = logs.where((record) => record.loggerName == 'YandexDriveStorage').toList();
    expect(diagnostics.where((record) => record.message.contains('reason=notActive')).length, 2);
    expect(diagnostics.any((record) => record.message.contains('reason=invalidRequest')), isTrue);
    expect(diagnostics.map((record) => record.message).join(' '), isNot(contains('private-')));
    expect(await originals.exists(), isFalse);
  });

  test('successful initialization activates controls and preserves paused and busy results', () async {
    final storage = create();
    addTearDown(storage.release);
    await storage.init();
    await storage.sync();
    final paused = await storage.executeDriveCommand(
      const DriveCommand(
        provider: storage_config.StorageType.YandexDriveStorage,
        id: 31,
        action: DriveAction.setPaused,
        paused: true,
      ),
    );
    expect(paused.error, isNull);
    expect(paused.state.runtime.active, isTrue);
    expect(paused.state.runtime.paused, isTrue);
    final busy = await storage.executeDriveCommand(
      const DriveCommand(provider: storage_config.StorageType.YandexDriveStorage, id: 32, action: DriveAction.syncNow),
    );
    expect(busy.error, DriveFailure.busy);
    final resumed = await storage.executeDriveCommand(
      const DriveCommand(
        provider: storage_config.StorageType.YandexDriveStorage,
        id: 33,
        action: DriveAction.setPaused,
        paused: false,
      ),
    );
    expect(resumed.error, isNull);
    expect(resumed.state.runtime.paused, isFalse);
    final sync = await storage.executeDriveCommand(
      const DriveCommand(provider: storage_config.StorageType.YandexDriveStorage, id: 34, action: DriveAction.syncNow),
    );
    expect(sync.error, isNull);
    await storage.sync();
    expect(api.resourceCalls, 0, reason: 'No folders were selected for synchronization');
  });

  test('initialization failure leaves synchronization controls inactive', () async {
    final storage = create(directory: _UnavailableDirectory());
    addTearDown(storage.release);
    await expectLater(storage.init(), throwsA(isA<FileSystemException>()));
    final result = await storage.executeDriveCommand(
      const DriveCommand(provider: storage_config.StorageType.YandexDriveStorage, id: 41, action: DriveAction.syncNow),
    );
    expect(result.error, DriveFailure.notActive);
    expect(result.state.runtime.active, isFalse);
  });

  test('release before initialization waits for the OAuth response and ignores its late result', () async {
    final storage = create();
    api.pendingDevice = Completer<YandexDriveDeviceResponse>();
    final pending = storage.executeDriveCommand(
      const DriveCommand(
        provider: storage_config.StorageType.YandexDriveStorage,
        id: 51,
        action: DriveAction.startAuthorization,
      ),
    );
    var released = false;
    final releasing = storage.release().then((_) => released = true);
    await Future<void>.delayed(Duration.zero);
    expect(released, isFalse);
    expect(api.closeCalls, 0);
    expect(api.pendingDevice!.isCompleted, isFalse);
    api.pendingDevice!.complete(_ProviderApi.device);
    final authorization = (await pending).authorization;
    await releasing;
    expect(released, isTrue);
    expect(api.closeCalls, 1);
    expect(authorization?.status, DriveAuthorizationStatus.cancelled);
    expect(authorization?.userCode, isNull);
    final result = await storage.executeDriveCommand(
      const DriveCommand(provider: storage_config.StorageType.YandexDriveStorage, id: 52, action: DriveAction.state),
    );
    expect(result.error, DriveFailure.notActive);
    expect(result.state.runtime.active, isFalse);
    expect(result.state.connections.single.accountId, '123');
    expect(api.tokenCalls, 0);
    expect(await originals.exists(), isFalse);
  });
}
