import 'dart:async';

import 'package:dslideshow_backend/config.dart' show AppConfig;
import 'package:dslideshow_backend/src/command/drive_command.dart';
import 'package:dslideshow_backend/src/command/empty_result.dart';
import 'package:dslideshow_backend/src/service/storage/cloud_storage.dart';
import 'package:dslideshow_backend/src/service/storage/storage.dart';
import 'package:dslideshow_backend/src/service/storage/storage_provider_registry.dart';
import 'package:dslideshow_backend/src/service/storage/storage_type.dart' as media;
import 'package:dslideshow_backend/src/service/storage/storages_config.dart' as config;
import 'package:dslideshow_common/rpc.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

import 'support/storage_provider_registry_fixture.dart';

class _Storage implements Storage {
  int initializations = 0;
  int releases = 0;
  Object? initializationError;
  Object? releaseError;

  @override
  Future<void> init() async {
    initializations++;
    if (initializationError case final error?) throw error;
  }

  @override
  Future<void> release() async {
    releases++;
    if (releaseError case final error?) throw error;
  }

  @override
  media.StorageType get type => media.StorageType.local;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _CloudStorage extends _Storage implements CloudStorage {
  final commands = <DriveCommand>[];
  Object? commandError;

  @override
  Future<RpcResult> executeDriveCommand(DriveCommand command) async {
    commands.add(command);
    if (commandError case final error?) throw error;
    return EmptyResult(id: command.id);
  }
}

const _command = DriveCommand(
  provider: config.StorageType.YandexDriveStorage,
  id: 17,
  action: DriveAction.configureApplication,
  clientSecret: 'private-client-secret',
);

void main() {
  test('GetIt factories stay fresh while the registry caches providers and leaves its container intact', () async {
    final locator = GetIt.instance;
    locator.pushNewScope();
    addTearDown(() => locator.popScope());
    final application = AppConfig.fromJson({
      'storages': {'selected': config.StorageType.DiskStorage.name, 'storages': <String, dynamic>{}},
    });
    locator.registerSingleton<AppConfig>(application);
    final created = <_Storage>[];
    locator.registerFactoryParam<Storage, config.StorageType, void>((type, _) {
      expect(type, config.StorageType.DiskStorage);
      final storage = _Storage();
      created.add(storage);
      return storage;
    });
    final firstExternal = locator.get<Storage>(param1: config.StorageType.DiskStorage);
    final secondExternal = locator.get<Storage>(param1: config.StorageType.DiskStorage);
    expect(firstExternal, isNot(same(secondExternal)));
    final registry = StorageProviderRegistry();
    final owned = registry.selected;
    expect(registry.provider(config.StorageType.DiskStorage), same(owned));
    expect(created, hasLength(3));
    application.storages.selected = config.StorageType.YandexDriveStorage;
    expect(registry.selectedType, config.StorageType.DiskStorage);
    await registry.init();
    await registry.release();
    expect(created.map((storage) => storage.initializations), [0, 0, 1]);
    expect(created.map((storage) => storage.releases), [0, 0, 1]);
    expect(locator<AppConfig>(), same(application));
    final afterRelease = locator.get<Storage>(param1: config.StorageType.DiskStorage);
    expect(afterRelease, isNot(same(owned)));
    expect(created, hasLength(4));
  });

  test('providers are created lazily once and only the selected storage is initialized', () async {
    final disk = _Storage();
    final google = _CloudStorage();
    final yandex = _CloudStorage();
    var diskCreated = 0;
    var googleCreated = 0;
    var yandexCreated = 0;
    final registry = createStorageProviderRegistry(
      selectedType: config.StorageType.DiskStorage,
      factories: {
        config.StorageType.DiskStorage: () {
          diskCreated++;
          return disk;
        },
        config.StorageType.GPhotoStorage: () {
          googleCreated++;
          return google;
        },
        config.StorageType.YandexDriveStorage: () {
          yandexCreated++;
          return yandex;
        },
      },
    );
    expect([diskCreated, googleCreated, yandexCreated], [0, 0, 0]);
    await registry.init();
    expect(registry.selected, same(disk));
    expect(registry.provider(config.StorageType.DiskStorage), same(disk));
    expect([diskCreated, googleCreated, yandexCreated], [1, 0, 0]);
    expect([disk.initializations, google.initializations, yandex.initializations], [1, 0, 0]);
    expect(registry.provider(config.StorageType.GPhotoStorage), same(google));
    expect(registry.provider(config.StorageType.GPhotoStorage), same(google));
    expect([diskCreated, googleCreated, yandexCreated], [1, 1, 0]);
    await registry.release();
    expect([disk.releases, google.releases, yandex.releases], [1, 1, 0]);
  });

  test('authorization commands route to an inactive provider without initializing its synchronization', () async {
    final disk = _Storage();
    final yandex = _CloudStorage();
    final registry = createStorageProviderRegistry(
      selectedType: config.StorageType.DiskStorage,
      factories: {config.StorageType.DiskStorage: () => disk, config.StorageType.YandexDriveStorage: () => yandex},
    );
    expect(await registry.executeDriveCommand(_command), const EmptyResult(id: 17));
    expect(yandex.commands, [_command]);
    expect(disk.initializations, 0);
    expect(yandex.initializations, 0);
    await registry.init();
    expect(disk.initializations, 1);
    expect(yandex.initializations, 0);
    expect(registry.selected, same(disk));
    expect(registry.provider(config.StorageType.YandexDriveStorage), same(yandex));
    await registry.release();
    expect(disk.releases, 1);
    expect(yandex.releases, 1);
  });

  test('selected cloud storage is the same initialized instance that receives drive commands', () async {
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
    await registry.init();
    await registry.executeDriveCommand(_command);
    expect(registry.selected, same(cloud));
    expect(cloud.initializations, 1);
    expect(created, 1);
    await registry.release();
    expect(cloud.releases, 1);
  });

  test('shutdown releases all created storage instances once even if factories share an instance', () async {
    final cloud = _CloudStorage();
    final registry = createStorageProviderRegistry(
      selectedType: config.StorageType.GPhotoStorage,
      factories: {config.StorageType.GPhotoStorage: () => cloud, config.StorageType.YandexDriveStorage: () => cloud},
    );
    await registry.init();
    await registry.executeDriveCommand(_command);
    await registry.release();
    expect(cloud.initializations, 1);
    expect(cloud.commands, [_command]);
    expect(cloud.releases, 1);
  });

  test('an unused registry releases without constructing the selected or inactive providers', () async {
    var created = 0;
    final registry = createStorageProviderRegistry(
      selectedType: config.StorageType.DiskStorage,
      factories: {
        config.StorageType.DiskStorage: () {
          created++;
          return _Storage();
        },
      },
    );
    await registry.release();
    expect(created, 0);
  });

  test('unsupported and missing providers return safe errors without initializing storage', () async {
    final previousLevel = Logger.root.level;
    Logger.root.level = Level.ALL;
    final records = <LogRecord>[];
    final subscription = Logger.root.onRecord.listen((record) {
      if (record.loggerName == 'StorageProviderRegistry') records.add(record);
    });
    final disk = _Storage();
    try {
      for (final present in [true, false]) {
        final registry = createStorageProviderRegistry(
          selectedType: config.StorageType.DiskStorage,
          factories: {if (present) config.StorageType.YandexDriveStorage: () => disk},
        );
        final result = await registry.executeDriveCommand(_command);
        expect(result, isA<ErrorResult>().having((value) => value.id, 'id', 17));
        expect(disk.initializations, 0);
        await registry.release();
      }
      expect(disk.releases, 1);
      expect(records.where((record) => record.message.contains('event=driveCommandRejected')), hasLength(1));
      expect(records.where((record) => record.message.contains('event=driveCommandFailed')), hasLength(1));
      expect(records.where((record) => record.message.contains('event=initializationStarted')), isEmpty);
      expect(records.map((record) => record.message).join('\n'), isNot(contains('private-client-secret')));
      expect(records.where((record) => record.error != null), isNotEmpty);
      expect(
        records
            .where((record) => record.error != null)
            .every((record) => record.stackTrace != null && record.stackTrace.toString().isNotEmpty),
        isTrue,
      );
      expect(records.length, lessThan(16));
    } finally {
      await subscription.cancel();
      Logger.root.level = previousLevel;
    }
  });

  test('factory and cloud command failures preserve diagnostics and return domain errors', () async {
    final previousDebugOutput = GetIt.noDebugOutput;
    addTearDown(() => expect(GetIt.noDebugOutput, previousDebugOutput));
    final records = <LogRecord>[];
    final console = <String>[];
    final subscription = Logger.root.onRecord.listen(records.add);
    final cloud = _CloudStorage()..commandError = StateError('private-command-url');
    try {
      await runZoned(() async {
        for (final failFactory in [true, false]) {
          final registry = createStorageProviderRegistry(
            selectedType: config.StorageType.DiskStorage,
            factories: {
              config.StorageType.YandexDriveStorage: () {
                if (failFactory) throw StateError('private-factory-url');
                return cloud;
              },
            },
          );
          final result = await registry.executeDriveCommand(_command);
          expect(result, isA<ErrorResult>().having((value) => value.error, 'error', 'Drive provider command failed'));
          await registry.release();
        }
      }, zoneSpecification: ZoneSpecification(print: (_, _, _, line) => console.add(line)));
      expect(
        console,
        isEmpty,
        reason: 'Expected factory failures use safe registry diagnostics without raw GetIt output',
      );
      expect(cloud.releases, 1);
      expect(records.where((record) => record.message.contains('event=driveCommandFailed')), hasLength(2));
      expect(
        records.map((record) => '${record.message} ${record.error ?? ''} ${record.stackTrace ?? ''}').join('\n'),
        contains('private-'),
      );
    } finally {
      await subscription.cancel();
    }
  });

  test('initialization failures propagate with their original diagnostics', () async {
    final records = <LogRecord>[];
    final subscription = Logger.root.onRecord.listen(records.add);
    final failure = StateError('private-initialization-url');
    final storage = _Storage()..initializationError = failure;
    final registry = createStorageProviderRegistry(
      selectedType: config.StorageType.DiskStorage,
      factories: {config.StorageType.DiskStorage: () => storage},
    );
    try {
      await expectLater(registry.init(), throwsA(same(failure)));
      expect(records.any((record) => record.message.contains('event=initializationFailed')), isTrue);
      expect(records.map((record) => '${record.message} ${record.error ?? ''}').join('\n'), contains('private-'));
    } finally {
      await registry.release();
      await subscription.cancel();
    }
    expect(storage.releases, 1);
  });

  test('shutdown continues after a release failure and reports counts and original error', () async {
    final records = <LogRecord>[];
    final subscription = Logger.root.onRecord.listen(records.add);
    final failure = StateError('private-release-url');
    final disk = _Storage()..releaseError = failure;
    final cloud = _CloudStorage();
    final registry = createStorageProviderRegistry(
      selectedType: config.StorageType.DiskStorage,
      factories: {config.StorageType.DiskStorage: () => disk, config.StorageType.YandexDriveStorage: () => cloud},
    );
    await registry.init();
    await registry.executeDriveCommand(_command);
    try {
      await expectLater(registry.release(), throwsA(same(failure)));
      expect([disk.releases, cloud.releases], [1, 1]);
      expect(
        records.any((record) => record.message == 'event=providerReleaseFailed provider=DiskStorage type=StateError'),
        isTrue,
      );
      expect(
        records.any((record) => record.message == 'event=releaseCompleted providers=2 released=1 failed=1'),
        isTrue,
      );
      expect(records.map((record) => '${record.message} ${record.error ?? ''}').join('\n'), contains('private-'));
    } finally {
      await subscription.cancel();
    }
  });
}
