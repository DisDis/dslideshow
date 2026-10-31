import 'dart:async';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart' as config;
import 'package:dslideshow_backend/serializers.dart';
import 'package:dslideshow_backend/src/service/storage/cloud_storage.dart';
import 'package:dslideshow_backend/src/service/storage/mediaitem.dart';
import 'package:dslideshow_backend/src/service/storage/storage.dart';
import 'package:dslideshow_backend/src/service/storage/storage_type.dart' as media;
import 'package:dslideshow_common/rpc.dart';
import 'package:fake_async/fake_async.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

import 'support/hardware_fixture.dart';
import 'support/storage_provider_registry_fixture.dart';

class _PlaybackStorage extends Storage {
  _PlaybackStorage(String name) : current = MediaItem(name, Uri.file('/images/$name.jpg'));

  final MediaItem current;
  int initializations = 0;
  int releases = 0;
  int advances = 0;
  Completer<void>? releaseGate;

  @override
  Future<void> init() async => initializations++;

  @override
  Future<MediaItem?> getCurrent() async => current;

  @override
  Future<MediaItem?> getNext() async => current;

  @override
  Future<MediaItem?> next() async {
    advances++;
    return current;
  }

  @override
  Future<void> release() async {
    releases++;
    await releaseGate?.future;
    closeStatusNotifications();
  }

  @override
  media.StorageType get type => media.StorageType.local;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _CloudStorage extends _PlaybackStorage implements CloudStorage {
  _CloudStorage() : super('cloud');

  final commands = <DriveCommand>[];

  @override
  Future<RpcResult> executeDriveCommand(DriveCommand command) async {
    commands.add(command);
    return DriveResult(
      id: command.id,
      state: const DriveState(
        connections: [DriveConnection(accountId: 'family', label: 'Family')],
      ),
    );
  }
}

void main() {
  test('selected storage status transitions reach frontend RPC while inactive providers remain silent', () {
    final records = <LogRecord>[];
    final previousLevel = Logger.root.level;
    Logger.root.level = Level.ALL;
    final logs = Logger.root.onRecord.listen(records.add);
    addTearDown(() async {
      await logs.cancel();
      Logger.root.level = previousLevel;
    });
    fakeAsync((time) {
      final disk = _PlaybackStorage('disk')..updateStatus(StorageStatusEnum.off);
      final cloud = _CloudStorage();
      final registry = createStorageProviderRegistry(
        selectedType: config.StorageType.DiskStorage,
        factories: {config.StorageType.DiskStorage: () => disk, config.StorageType.YandexDriveStorage: () => cloud},
      );
      final fixture = HardwareFixture(storageProviders: registry);
      time.flushMicrotasks();
      expect(fixture.application.state.storageStatus, StorageStatusEnum.off);
      disk.updateStatus(StorageStatusEnum.download);
      disk.updateStatus(StorageStatusEnum.download);
      disk.updateStatus(StorageStatusEnum.off);
      disk.updateStatus(StorageStatusEnum.done);
      registry.provider(config.StorageType.YandexDriveStorage);
      cloud.updateStatus(StorageStatusEnum.off);
      time.flushMicrotasks();
      expect(fixture.remote.commands.whereType<StorageStatusCommand>().map((command) => command.status), [
        StorageStatusEnum.off,
        StorageStatusEnum.download,
        StorageStatusEnum.off,
        StorageStatusEnum.done,
      ]);
      expect(fixture.application.state.storageStatus, StorageStatusEnum.done);
      fixture.dispose(time);
    });
    expect(
      records.any(
        (record) =>
            record.loggerName == 'Storage' && record.level == Level.INFO && record.message.contains('status=download'),
      ),
      isTrue,
    );
    expect(
      records.any(
        (record) =>
            record.loggerName == 'HardwareService' &&
            record.level == Level.FINE &&
            record.message == 'Storage status delivered status=off',
      ),
      isTrue,
    );
    expect(records.every((record) => record.error == null && record.stackTrace == null), isTrue);
  });

  test('generic drive web wire routes to an inactive provider while playback stays on selected storage', () async {
    final disk = _PlaybackStorage('disk');
    final cloud = _CloudStorage();
    var cloudCreated = 0;
    final registry = createStorageProviderRegistry(
      selectedType: config.StorageType.DiskStorage,
      factories: {
        config.StorageType.DiskStorage: () => disk,
        config.StorageType.YandexDriveStorage: () {
          cloudCreated++;
          return cloud;
        },
      },
    );
    final fixture = HardwareFixture(storageProviders: registry);
    addTearDown(fixture.close);
    await fixture.hardware.executeCommand(const AreYouReadyCommand(id: 1));
    expect(cloudCreated, 0);

    // The wire explicitly addresses the provider through the common command.
    final envelope = WSSendRpcCommand(
      id: 91,
      commandData: [
        'DriveCommand',
        {'id': 71, 'provider': 'YandexDriveStorage', 'action': 'state', 'type': 'drive'},
      ],
    );
    final decodedEnvelope = serializers.deserialize(serializers.serialize(envelope)!) as WSSendRpcCommand;
    final command = serializers.deserialize(decodedEnvelope.commandData) as DriveCommand;
    expect(command.provider, config.StorageType.YandexDriveStorage);
    expect(command.toJson(), {
      'id': 71,
      'provider': 'YandexDriveStorage',
      'action': 'state',
      'clientId': null,
      'clientSecret': null,
      'sessionId': null,
      'accountId': null,
      'path': null,
      'offset': 0,
      'paused': null,
      'type': 'drive',
    });

    final reply = await fixture.hardware.executeCommand(command);
    final response = WSRpcResult.byCommand(reply, decodedEnvelope);
    final decodedResponse = serializers.deserialize(serializers.serialize(response)!) as WSRpcResult;
    final result = serializers.deserialize(decodedResponse.resultData) as DriveResult;
    expect(decodedResponse.id, 91);
    expect(result.id, 71);
    expect(result.state.connections.single.accountId, 'family');
    expect(cloudCreated, 1);
    expect(cloud.commands, [command]);
    expect([disk.initializations, cloud.initializations], [1, 0]);

    for (final current in [true, false]) {
      final mediaResult = await fixture.hardware.executeCommand(
        GetMediaItemCommand(id: 8, isCurrent: current),
      ) as GetMediaItemCommandResult;
      expect(mediaResult.mediaId, disk.current.id);
      expect(mediaResult.mediaUri, disk.current.uri);
    }
    await fixture.hardware.executeCommand(const StorageNextCommand(id: 9));
    expect([disk.advances, cloud.advances], [1, 0]);
    await fixture.close();
    expect([disk.releases, cloud.releases], [1, 1]);
  });

  test('selected cloud playback and drive commands share the initialized provider', () async {
    final cloud = _CloudStorage();
    var created = 0;
    final registry = createStorageProviderRegistry(
      selectedType: config.StorageType.YandexDriveStorage,
      factories: {
        config.StorageType.YandexDriveStorage: () {
          created++;
          return cloud;
        },
      },
    );
    final fixture = HardwareFixture(storageProviders: registry);
    addTearDown(fixture.close);
    await fixture.hardware.executeCommand(const AreYouReadyCommand(id: 1));
    final reply = await fixture.hardware.executeCommand(
      const DriveCommand(provider: config.StorageType.YandexDriveStorage, id: 2, action: DriveAction.state),
    );
    expect(reply, isA<DriveResult>().having((value) => value.id, 'id', 2));
    final item = await fixture.hardware.executeCommand(
      const GetMediaItemCommand(id: 3, isCurrent: true),
    ) as GetMediaItemCommandResult;
    expect(item.mediaId, cloud.current.id);
    expect([created, cloud.initializations], [1, 1]);
    await fixture.close();
    expect(cloud.releases, 1);
  });

  test('hardware shutdown awaits release of a lazily created inactive cloud provider', () async {
    final disk = _PlaybackStorage('disk');
    final cloud = _CloudStorage()..releaseGate = Completer<void>();
    final registry = createStorageProviderRegistry(
      selectedType: config.StorageType.DiskStorage,
      factories: {config.StorageType.DiskStorage: () => disk, config.StorageType.YandexDriveStorage: () => cloud},
    );
    final fixture = HardwareFixture(storageProviders: registry);
    addTearDown(() async {
      if (!cloud.releaseGate!.isCompleted) cloud.releaseGate!.complete();
      await fixture.close();
    });
    await fixture.hardware.executeCommand(
      const DriveCommand(provider: config.StorageType.YandexDriveStorage, id: 2, action: DriveAction.state),
    );
    var closed = false;
    final closing = fixture.close().then((_) => closed = true);
    await Future<void>.delayed(Duration.zero);
    expect(cloud.releases, 1);
    expect(cloud.initializations, 0);
    expect(closed, isFalse);
    cloud.releaseGate!.complete();
    await closing;
    expect([disk.releases, cloud.releases], [1, 1]);
  });

  test('commands after hardware shutdown do not create an inactive provider', () async {
    final disk = _PlaybackStorage('disk');
    var cloudCreated = 0;
    final registry = createStorageProviderRegistry(
      selectedType: config.StorageType.DiskStorage,
      factories: {
        config.StorageType.DiskStorage: () => disk,
        config.StorageType.YandexDriveStorage: () {
          cloudCreated++;
          return _CloudStorage();
        },
      },
    );
    final fixture = HardwareFixture(storageProviders: registry);
    addTearDown(fixture.close);
    await fixture.hardware.executeCommand(const AreYouReadyCommand(id: 1));
    await fixture.close();
    final reply = await fixture.hardware.executeCommand(
      const DriveCommand(provider: config.StorageType.YandexDriveStorage, id: 22, action: DriveAction.state),
    );
    expect(reply, isA<ErrorResult>().having((value) => value.id, 'id', 22));
    expect(cloudCreated, 0);
    expect(disk.releases, 1);
  });
}
