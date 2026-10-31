import 'dart:async';
import 'dart:io';

import 'package:dslideshow_backend/app_storage.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/src/service/storage/cloud_storage_transfer.dart';
import 'package:dslideshow_backend/src/service/storage/yandex_drive/yandex_drive_storage.dart';
import 'package:dslideshow_backend/src/service/yandex_drive/yandex_drive_api.dart';
import 'package:dslideshow_backend/src/service/yandex_drive/yandex_drive_models.dart';
import 'package:dslideshow_backend/src/service/yandex_drive/yandex_drive_service.dart';
import 'package:fake_async/fake_async.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';

/// The scheduler tests replace filesystem enumeration, not the Storage logic.
class _EmptyDirectory implements Directory {
  _EmptyDirectory(this.path);
  @override
  final String path;
  final events = StreamController<FileSystemEvent>(sync: true, onCancel: () async {});
  @override
  Directory get absolute => this;
  @override
  Future<Directory> create({bool recursive = false}) async => this;
  @override
  Stream<FileSystemEntity> list({bool recursive = false, bool followLinks = true}) => const Stream.empty();
  @override
  Stream<FileSystemEvent> watch({int events = FileSystemEvent.all, bool recursive = false}) => this.events.stream;
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _ScheduledApi extends YandexDriveApi {
  int requests = 0;
  Future<YandexDriveResource> Function()? response;
  static const empty = YandexDriveResource(
    path: 'disk:/Camera',
    type: YandexDriveResourceType.dir,
    children: YandexDriveResourceList(),
  );
  @override
  Future<YandexDriveResource> resources(String token, String remotePath, int offset) {
    requests++;
    return response?.call() ?? Future.value(empty);
  }
}

class _ScheduledConnections implements YandexDriveService {
  _ScheduledConnections(this.api);
  @override
  final _ScheduledApi api;
  int closeCalls = 0;
  final connectedAccounts = <String>{'123'};
  @override
  bool isConnected(String accountId) => connectedAccounts.contains(accountId);
  @override
  Future<void> close({Future<void>? pendingTransfer}) async {
    closeCalls++;
    await pendingTransfer;
  }

  @override
  DriveState state({DriveRuntime runtime = const DriveRuntime()}) => DriveState(
    connections: [for (final account in connectedAccounts) DriveConnection(accountId: account, label: 'Family')],
    runtime: runtime,
  );

  @override
  void disconnect(String accountId) {
    connectedAccounts.remove(accountId);
  }

  @override
  Future<T> withAccess<T>(String accountId, Future<T> Function(String token) action) {
    return action('private-token');
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Fixture {
  _Fixture(this.root, this.clock, {DateTime? lastSync}) {
    appStorage = AppStorage(root.path);
    if (lastSync != null) appStorage.setValue('YandexDrive.lastSync', lastSync.toIso8601String());
    appStorage.save();
    directory = _EmptyDirectory(path.join(root.path, 'images'));
    connections = _ScheduledConnections(api);
    storage = YandexDriveStorage(
      const YandexDriveStorageConfig(
        accounts: [
          YandexDriveAccountConfig(accountId: '123', paths: ['disk:/Camera']),
        ],
      ),
      connections,
      appStorage,
      folder: directory,
      now: now,
    );
  }
  static final epoch = DateTime.utc(2026, 10, 31);
  final Directory root;
  final FakeAsync clock;
  late final AppStorage appStorage;
  final api = _ScheduledApi();
  late final _EmptyDirectory directory;
  late final _ScheduledConnections connections;
  late final YandexDriveStorage storage;
  DateTime now() => epoch.add(clock.elapsed);
  void initialize() {
    var ready = false;
    unawaited(storage.init().then((_) => ready = true));
    clock.flushMicrotasks();
    expect(ready, isTrue);
  }

  void release() {
    var done = false;
    unawaited(storage.release().then((_) => done = true));
    clock.flushMicrotasks();
    expect(done, isTrue);
    expect(connections.closeCalls, 1);
    unawaited(directory.events.close());
    clock.flushMicrotasks();
    expect(clock.pendingTimers, isEmpty);
  }
}

void main() {
  late Directory root;
  setUp(() => root = Directory.systemTemp.createTempSync('yandex-schedule-'));
  tearDown(() => root.deleteSync(recursive: true));

  test('next hourly pass is scheduled from completion rather than every second periodic tick', () {
    fakeAsync((clock) {
      final fixture = _Fixture(root, clock);
      final pending = Completer<YandexDriveResource>();
      fixture.api.response = () => pending.future;
      fixture.initialize();
      expect(fixture.api.requests, 1);
      clock.elapse(const Duration(minutes: 7));
      fixture.storage.syncNow();
      expect(fixture.api.requests, 1, reason: 'An active pass owns the operation, including manual requests');
      fixture.api.response = null;
      pending.complete(_ScheduledApi.empty);
      clock.flushMicrotasks();
      expect(fixture.storage.runtime.lastSync, _Fixture.epoch.add(const Duration(minutes: 7)));
      clock.elapse(const Duration(minutes: 59, seconds: 59));
      expect(fixture.api.requests, 1);
      clock.elapse(const Duration(seconds: 1));
      expect(fixture.api.requests, 2);
      fixture.release();
    });
  });

  test('restart schedules the remaining interval from saved successful completion', () {
    fakeAsync((clock) {
      final fixture = _Fixture(root, clock, lastSync: _Fixture.epoch.subtract(const Duration(minutes: 55)));
      fixture.initialize();
      expect(fixture.api.requests, 0);
      clock.elapse(const Duration(minutes: 4, seconds: 59));
      expect(fixture.api.requests, 0);
      clock.elapse(const Duration(seconds: 1));
      expect(fixture.api.requests, 1);
      expect(fixture.storage.runtime.lastSync, _Fixture.epoch.add(const Duration(minutes: 5)));
      fixture.release();
    });
  });

  test('manual pass resets the timer, pause suspends it, resume and release keep one schedule', () {
    fakeAsync((clock) {
      final fixture = _Fixture(root, clock, lastSync: _Fixture.epoch);
      fixture.initialize();
      clock.elapse(const Duration(minutes: 10));
      fixture.storage.syncNow();
      clock.flushMicrotasks();
      expect(fixture.api.requests, 1);
      clock.elapse(const Duration(minutes: 50));
      expect(fixture.api.requests, 1, reason: 'Manual completion replaces the previous startup deadline');
      clock.elapse(const Duration(minutes: 10));
      expect(fixture.api.requests, 2);
      fixture.storage.setPaused(true);
      clock.elapse(const Duration(hours: 2));
      expect(fixture.api.requests, 2);
      fixture.storage.setPaused(false);
      clock.flushMicrotasks();
      expect(fixture.api.requests, 3, reason: 'The saved successful interval is overdue after resuming');
      fixture.release();
      clock.elapse(const Duration(hours: 2));
      expect(fixture.api.requests, 3);
    });
  });

  test('future saved timestamp cannot postpone synchronization beyond one interval', () {
    fakeAsync((clock) {
      final fixture = _Fixture(root, clock, lastSync: _Fixture.epoch.add(const Duration(days: 1)));
      fixture.initialize();
      expect(fixture.api.requests, 0);
      clock.elapse(const Duration(minutes: 59, seconds: 59));
      expect(fixture.api.requests, 0);
      clock.elapse(const Duration(seconds: 1));
      expect(fixture.api.requests, 1);
      expect(fixture.storage.runtime.lastSync, _Fixture.epoch.add(const Duration(hours: 1)));
      fixture.release();
    });
  });

  test('pause and resume while metadata is pending continue the same pass without another request', () {
    fakeAsync((clock) {
      final fixture = _Fixture(root, clock);
      final pending = Completer<YandexDriveResource>();
      fixture.api.response = () => pending.future;
      fixture.initialize();
      expect(fixture.api.requests, 1);
      fixture.api.response = null;
      fixture.storage.setPaused(true);
      fixture.storage.setPaused(false);
      clock.flushMicrotasks();
      expect(fixture.api.requests, 1);
      expect(fixture.storage.runtime.running, isTrue);
      expect(fixture.storage.runtime.lastSync, isNull);
      pending.complete(_ScheduledApi.empty);
      clock.flushMicrotasks();
      expect(fixture.api.requests, 1);
      expect(fixture.storage.runtime.lastSync, _Fixture.epoch);
      clock.elapse(const Duration(hours: 1));
      expect(fixture.api.requests, 2);
      fixture.release();
    });
  });

  test('a failed pass waits one interval rather than retrying immediately with an old lastSync', () {
    fakeAsync((clock) {
      final fixture = _Fixture(root, clock);
      fixture.api.response = () => Future.error(const CloudStorageException(DriveFailure.network));
      fixture.initialize();
      expect(fixture.api.requests, 1);
      clock.elapse(const Duration(minutes: 59, seconds: 59));
      expect(fixture.api.requests, 1);
      clock.elapse(const Duration(seconds: 1));
      expect(fixture.api.requests, 2);
      fixture.release();
    });
  });

  test('disconnect finishes pending metadata and skips the disconnected account on later passes', () {
    fakeAsync((clock) {
      final fixture = _Fixture(root, clock);
      final pending = Completer<YandexDriveResource>();
      fixture.api.response = () => pending.future;
      fixture.initialize();
      fixture.api.response = null;
      fixture.connections.disconnect('123');
      clock.flushMicrotasks();
      expect(fixture.api.requests, 1);
      expect(fixture.storage.runtime.running, isTrue);
      pending.complete(_ScheduledApi.empty);
      clock.flushMicrotasks();
      expect(fixture.storage.runtime.running, isFalse);
      expect(fixture.storage.runtime.failed, 0);
      expect(fixture.storage.runtime.lastSync, isNull);
      clock.elapse(const Duration(minutes: 59, seconds: 59));
      expect(fixture.api.requests, 1);
      clock.elapse(const Duration(seconds: 1));
      expect(fixture.api.requests, 1);
      fixture.release();
    });
  });
}
