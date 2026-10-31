import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:dslideshow_backend/app_storage.dart';
import 'package:dslideshow_backend/src/service/storage/disk/disk_storage.dart';
import 'package:dslideshow_backend/src/service/storage/disk/disk_storage_config.dart';
import 'package:dslideshow_backend/src/service/storage/googlephoto/gphoto_storage.dart';
import 'package:dslideshow_backend/src/service/storage/googlephoto/gphoto_storage_config.dart';
import 'package:dslideshow_common/storage_status.dart';
import 'package:fake_async/fake_async.dart';
import 'package:test/test.dart';

class FirstRandom implements Random {
  @override
  int nextInt(int max) => 0;
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class MemoryAppStorage implements AppStorage {
  int writes = 0;

  @override
  T getValue<T>(String field, [T? defaultValue]) => defaultValue as T;

  @override
  void setValue<T>(String key, T value) {
    writes++;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class ControlledGPhotoStorage extends GPhotoStorage {
  ControlledGPhotoStorage(TestDirectory folder)
    : super(
        GPhotoStorageConfig.fromJson({}),
        MemoryAppStorage(),
        folder: folder,
      );

  int syncCalls = 0;
  Future<Null> Function()? onSync;

  @override
  Future<Null> sync() {
    syncCalls++;
    return onSync?.call() ?? Future<Null>.value(null);
  }
}

class TestDirectory implements Directory {
  TestDirectory(Iterable<String> names) {
    setNames(names);
    events = StreamController<FileSystemEvent>(
      sync: true,
      onCancel: () async {
        watchCancellations++;
      },
    );
  }
  @override
  final String path = '/media';
  late final StreamController<FileSystemEvent> events;
  List<FileSystemEntity> entries = [];
  Stream<FileSystemEntity> Function()? listing;
  int listCalls = 0;
  int watchCalls = 0;
  int watchCancellations = 0;

  void setNames(Iterable<String> names) {
    entries = names.map((name) => File('$path/$name')).toList();
  }

  @override
  Stream<FileSystemEntity> list({
    bool recursive = false,
    bool followLinks = true,
  }) {
    expect(recursive, isTrue);
    expect(followLinks, isTrue);
    listCalls++;
    return listing?.call() ?? Stream.fromIterable(List.of(entries));
  }

  @override
  Stream<FileSystemEvent> watch({
    int events = FileSystemEvent.all,
    bool recursive = false,
  }) {
    watchCalls++;
    expect(recursive, isFalse);
    return this.events.stream;
  }

  void changed([String name = 'ready.jpg']) =>
      events.add(FileSystemModifyEvent('$path/$name', false, true));

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

DiskStorage createStorage(TestDirectory directory, {Random? random}) =>
    DiskStorage(
      DiskStorageConfig(),
      folder: directory,
      random: random ?? FirstRandom(),
    );

String? itemName(Uri? uri) => uri?.pathSegments.last;

void fakeStorageTest(
  String name,
  Iterable<String> initial,
  void Function(FakeAsync time, TestDirectory folder, DiskStorage storage) body,
) {
  test(name, () {
    fakeAsync((time) {
      final folder = TestDirectory(initial);
      final storage = createStorage(folder);
      var initialized = false;
      storage.init().then((_) => initialized = true);
      time.flushMicrotasks();
      expect(initialized, isTrue);
      try {
        body(time, folder, storage);
      } finally {
        var released = false;
        storage.release().then((_) => released = true);
        time.flushMicrotasks();
        expect(released, isTrue);
        folder.events.close();
        time.flushMicrotasks();
      }
    });
  });
}

void main() {
  test('local storage reports scan, access failure and recovery through its shared status', () async {
    final folder = TestDirectory(['photo.jpg']);
    final storage = createStorage(folder);
    final states = <StorageStatusEnum>[];
    final subscription = storage.onStatusChanged.listen(states.add);
    addTearDown(() async {
      await subscription.cancel();
      await storage.release();
      await folder.events.close();
    });
    expect(storage.status, StorageStatusEnum.done);
    await storage.sync();
    await Future<void>.delayed(Duration.zero);
    expect(states, [StorageStatusEnum.download, StorageStatusEnum.done]);
    folder.listing = () => Stream.error(FileSystemException('private-path'));
    await storage.sync();
    await Future<void>.delayed(Duration.zero);
    expect(storage.status, StorageStatusEnum.off);
    folder.listing = null;
    await storage.sync();
    await Future<void>.delayed(Duration.zero);
    expect(states, [
      StorageStatusEnum.download,
      StorageStatusEnum.done,
      StorageStatusEnum.download,
      StorageStatusEnum.off,
      StorageStatusEnum.download,
      StorageStatusEnum.done,
    ]);
  });

  test('each unchanged cycle visits every URI exactly once', () async {
    final names = List.generate(40, (i) => '$i.jpg');
    final directory = TestDirectory(names);
    final storage = createStorage(directory, random: Random(128));
    addTearDown(() async {
      await storage.release();
      await directory.events.close();
    });
    final orders = <List<String?>>[];
    for (var cycle = 0; cycle < 3; cycle++) {
      final order = <String?>[];
      for (var i = 0; i < names.length; i++) {
        order.add(itemName((await storage.next())?.uri));
      }
      expect(order.toSet(), names.toSet());
      expect(order.length, order.toSet().length);
      orders.add(order);
    }
    expect(orders[0], isNot(orders[1]));
    expect(directory.listCalls, 3);
  });

  test(
    'init reserves current and next; one file repeats across cycles',
    () async {
      final directory = TestDirectory(['only.jpg']);
      final storage = createStorage(directory);
      addTearDown(() async {
        await storage.release();
        await directory.events.close();
      });
      await storage.init();
      expect((await storage.getCurrent())?.uri, File('/media/only.jpg').uri);
      expect((await storage.getNext())?.uri, File('/media/only.jpg').uri);
      for (var i = 0; i < 3; i++) {
        expect((await storage.next())?.uri, File('/media/only.jpg').uri);
        expect(await storage.getCurrent(), await storage.getNext());
      }
    },
  );

  test('empty and non-file entries produce the existing empty item', () async {
    final directory = TestDirectory([])
      ..entries = [Directory('/media/nested'), Link('/media/broken')];
    final storage = createStorage(directory);
    addTearDown(() async {
      await storage.release();
      await directory.events.close();
    });
    await storage.init();
    expect((await storage.getCurrent())?.id, isNull);
    expect((await storage.getNext())?.uri, isNull);
    expect((await storage.next())?.uri, isNull);
  });

  test(
    'only reserved upload temporary names are excluded, without stat',
    () async {
      const temporary = '.upload-0123456789abcdef0123456789abcdef.part';
      final directory = TestDirectory([
        'photo.jpg',
        'nested/clip.mp4',
        temporary,
        'user.part',
      ]);
      final storage = createStorage(directory);
      addTearDown(() async {
        await storage.release();
        await directory.events.close();
      });
      final uris = <Uri?>[];
      for (var i = 0; i < 3; i++) {
        uris.add((await storage.next())?.uri);
      }
      expect(uris.toSet(), {
        File('/media/photo.jpg').uri,
        File('/media/nested/clip.mp4').uri,
        File('/media/user.part').uri,
      });
    },
  );

  test(
    'real recursive listing preserves nested files and working symlinks',
    () async {
      final root = await Directory.systemTemp.createTemp('disk-storage-');
      final rootPath = root.path;
      final nested = await Directory('$rootPath/nested').create();
      final nestedPath = nested.path;
      final file = await File('$nestedPath/photo.jpg')
          .writeAsString('original');
      final link = await Link('$rootPath/alias.jpg').create(file.path);
      final storage = DiskStorage(
        DiskStorageConfig(),
        folder: root,
        random: Random(4),
      );
      addTearDown(() async {
        await storage.release();
        await root.delete(recursive: true);
      });
      final first = (await storage.next())?.uri;
      final second = (await storage.next())?.uri;
      expect({first, second}, {file.uri, link.uri});
    },
  );

  fakeStorageTest(
    'unchanged refresh preserves the remaining order and pair',
    ['a.jpg', 'b.jpg', 'c.jpg', 'd.jpg'],
    (time, folder, storage) {
      folder.setNames(['d.jpg', 'c.jpg', 'b.jpg', 'a.jpg']);
      folder.changed();
      time.elapse(const Duration(minutes: 1));
      time.flushMicrotasks();
      expect(folder.listCalls, 2);
      storage.getCurrent().then((item) => expect(itemName(item?.uri), 'a.jpg'));
      storage.getNext().then((item) => expect(itemName(item?.uri), 'd.jpg'));
      final remaining = <String?>[];
      storage.next().then((item) => remaining.add(itemName(item?.uri)));
      storage.next().then((item) => remaining.add(itemName(item?.uri)));
      time.flushMicrotasks();
      expect(remaining, ['c.jpg', 'b.jpg']);
    },
  );

  fakeStorageTest(
    'refresh removes deleted URI and adds new URI without repeats',
    ['a.jpg', 'b.jpg', 'c.jpg', 'd.jpg'],
    (time, folder, storage) {
      folder.setNames(['a.jpg', 'c.jpg', 'd.jpg', 'new.jpg']);
      folder.changed();
      time.elapse(const Duration(minutes: 1));
      time.flushMicrotasks();
      storage.getCurrent().then((item) => expect(itemName(item?.uri), 'a.jpg'));
      storage.getNext().then((item) => expect(itemName(item?.uri), 'd.jpg'));
      final remaining = <String?>[];
      storage.next().then((item) => remaining.add(itemName(item?.uri)));
      storage.next().then((item) => remaining.add(itemName(item?.uri)));
      time.flushMicrotasks();
      expect(remaining.toSet(), {'new.jpg', 'c.jpg'});
      expect(remaining.length, remaining.toSet().length);
    },
  );

  fakeStorageTest(
    'scan publishes whole result and honors selections during scan',
    ['a.jpg', 'b.jpg', 'c.jpg', 'd.jpg'],
    (time, folder, storage) {
      final scan = StreamController<FileSystemEntity>();
      folder.listing = () => scan.stream;
      folder.changed();
      time.elapse(const Duration(minutes: 1));
      scan.add(File('/media/new.jpg'));
      time.flushMicrotasks();
      storage.getCurrent().then((item) => expect(itemName(item?.uri), 'a.jpg'));
      storage.getNext().then((item) => expect(itemName(item?.uri), 'd.jpg'));
      storage.next().then((item) => expect(itemName(item?.uri), 'c.jpg'));
      time.flushMicrotasks();
      for (final name in ['a.jpg', 'b.jpg', 'c.jpg', 'd.jpg']) {
        scan.add(File('/media/$name'));
      }
      scan.close();
      time.flushMicrotasks();
      folder.listing = null;
      final remaining = <String?>[];
      storage.next().then((item) => remaining.add(itemName(item?.uri)));
      storage.next().then((item) => remaining.add(itemName(item?.uri)));
      time.flushMicrotasks();
      expect(remaining.toSet(), {'b.jpg', 'new.jpg'});
    },
  );

  fakeStorageTest(
    'changes during scan discard stale result and coalesce retry',
    ['a.jpg', 'b.jpg', 'c.jpg', 'd.jpg'],
    (time, folder, storage) {
      final scan = StreamController<FileSystemEntity>();
      folder.listing = () => scan.stream;
      folder.changed();
      time.elapse(const Duration(minutes: 1));
      expect(folder.listCalls, 2);
      scan.add(File('/media/stale.jpg'));
      time.flushMicrotasks();
      folder.setNames(['a.jpg', 'b.jpg', 'c.jpg', 'd.jpg', 'fresh.jpg']);
      folder.listing = null;
      folder.changed('fresh.jpg');
      folder.changed('other.jpg');
      scan.close();
      time.flushMicrotasks();
      expect(folder.listCalls, 3);
      final remaining = <String?>[];
      for (var i = 0; i < 3; i++) {
        storage.next().then((item) => remaining.add(itemName(item?.uri)));
      }
      time.flushMicrotasks();
      expect(remaining.toSet(), {'b.jpg', 'c.jpg', 'fresh.jpg'});
    },
  );

  fakeStorageTest(
    'temporary write storms do not invalidate a scan',
    ['a.jpg', 'b.jpg', 'c.jpg', 'd.jpg'],
    (time, folder, storage) {
      const temporary = '.upload-0123456789abcdef0123456789abcdef.part';
      folder.setNames([
        'a.jpg',
        'b.jpg',
        'c.jpg',
        'd.jpg',
        'new.jpg',
        temporary,
      ]);
      folder.listing = () => Stream.fromIterable(folder.entries).map((entity) {
        folder.changed(temporary);
        return entity;
      });
      folder.changed();
      time.elapse(const Duration(minutes: 1));
      time.flushMicrotasks();
      expect(folder.listCalls, 2);
      storage.next().then((item) => expect(itemName(item?.uri), 'new.jpg'));
      time.flushMicrotasks();
      time.elapse(const Duration(minutes: 2));
      expect(folder.listCalls, 2);
    },
  );

  fakeStorageTest(
    'rename from temporary to ready file invalidates index',
    ['a.jpg', 'b.jpg', 'c.jpg', 'd.jpg'],
    (time, folder, storage) {
      const temporary = '/media/.upload-0123456789abcdef0123456789abcdef.part';
      folder.setNames(['a.jpg', 'b.jpg', 'c.jpg', 'd.jpg', 'ready.jpg']);
      folder.events.add(
        FileSystemMoveEvent(temporary, false, '/media/ready.jpg'),
      );
      time.elapse(const Duration(minutes: 1));
      time.flushMicrotasks();
      expect(folder.listCalls, 2);
      storage.next().then((item) => expect(itemName(item?.uri), 'ready.jpg'));
      time.flushMicrotasks();
    },
  );

  fakeStorageTest(
    'continuous changes do not block next indefinitely',
    ['only.jpg'],
    (time, folder, storage) {
      final before = folder.listCalls;
      folder.listing = () =>
          Stream.fromIterable([File('/media/stale.jpg')]).map((entity) {
            folder.changed();
            return entity;
          });
      var completed = false;
      storage.next().then((item) {
        expect(itemName(item?.uri), 'only.jpg');
        completed = true;
      });
      time.flushMicrotasks();
      expect(completed, isTrue);
      expect(folder.listCalls, before + 2);
      expect(time.pendingTimers.length, 1);
    },
  );

  fakeStorageTest(
    'error discards partial scan and preserves last good cycle',
    ['a.jpg', 'b.jpg', 'c.jpg', 'd.jpg'],
    (time, folder, storage) {
      final scan = StreamController<FileSystemEntity>();
      folder.listing = () => scan.stream;
      folder.changed();
      time.elapse(const Duration(minutes: 1));
      scan.add(File('/media/partial.jpg'));
      scan.addError(const FileSystemException('unreadable subdirectory'));
      scan.close();
      time.flushMicrotasks();
      final remaining = <String?>[];
      storage.next().then((item) => remaining.add(itemName(item?.uri)));
      storage.next().then((item) => remaining.add(itemName(item?.uri)));
      time.flushMicrotasks();
      expect(remaining, ['c.jpg', 'b.jpg']);
    },
  );

  test(
    'first scan error reaches caller and subsequent scan can recover',
    () async {
      final folder = TestDirectory(['recovered.jpg']);
      final storage = createStorage(folder);
      addTearDown(() async {
        await storage.release();
        await folder.events.close();
      });
      folder.listing = () => Stream.error(const FileSystemException('denied'));
      await expectLater(storage.next(), throwsA(isA<FileSystemException>()));
      expect(await storage.getCurrent(), isNull);
      expect(await storage.getNext(), isNull);
      folder.listing = null;
      expect(itemName((await storage.next())?.uri), 'recovered.jpg');
    },
  );

  test(
    'a successfully published empty index remains usable after scan error',
    () async {
      final folder = TestDirectory([]);
      final storage = createStorage(folder);
      addTearDown(() async {
        await storage.release();
        await folder.events.close();
      });
      expect((await storage.next())?.uri, isNull);
      folder.listing = () => Stream.error(const FileSystemException('denied'));
      expect((await storage.next())?.uri, isNull);
    },
  );

  test('background retries own initial scan errors', () {
    fakeAsync((time) {
      final folder = TestDirectory([])
        ..listing = () => Stream.error(const FileSystemException('denied'));
      final storage = createStorage(folder);
      var failures = 0;
      storage.next().then<void>(
        (_) => fail('Expected initial scan error'),
        onError: (Object error, StackTrace stack) {
          expect(error, isA<FileSystemException>());
          failures++;
        },
      );
      time.flushMicrotasks();
      expect(failures, 1);
      time.elapse(const Duration(minutes: 1));
      time.flushMicrotasks();
      expect(folder.listCalls, 2);
      storage.release();
      time.flushMicrotasks();
      folder.events.close();
      time.flushMicrotasks();
      expect(time.pendingTimers, isEmpty);
    });
  });

  fakeStorageTest(
    'cycle boundary discovers nested changes without watcher events',
    ['nested/a.jpg', 'nested/b.jpg'],
    (time, folder, storage) {
      folder.setNames(['nested/a.jpg', 'nested/b.jpg', 'nested/new.jpg']);
      storage.next().then((item) => expect(itemName(item?.uri), 'new.jpg'));
      time.flushMicrotasks();
      expect(folder.listCalls, 2);
    },
  );

  test(
    'release during initial scan cancels initialization without publication',
    () {
      fakeAsync((time) {
        final scan = StreamController<FileSystemEntity>(onCancel: () async {});
        final folder = TestDirectory([])..listing = () => scan.stream;
        final storage = createStorage(folder);
        var initialized = false;
        storage.init().then((_) => initialized = true);
        time.flushMicrotasks();
        scan.add(File('/media/late.jpg'));
        time.flushMicrotasks();
        var released = false;
        storage.release().then((_) => released = true);
        time.flushMicrotasks();
        expect(released, isTrue);
        expect(initialized, isTrue);
        expect(scan.hasListener, isFalse);
        storage.getCurrent().then((item) => expect(item, isNull));
        storage.getNext().then((item) => expect(item, isNull));
        time.flushMicrotasks();
        scan.close();
        folder.events.close();
        time.flushMicrotasks();
      });
    },
  );

  fakeStorageTest(
    'watcher errors are owned and a later scan recovers',
    ['a.jpg', 'b.jpg', 'c.jpg', 'd.jpg'],
    (time, folder, storage) {
      folder.events.addError(const FileSystemException('watcher overflow'));
      folder.setNames(['a.jpg', 'b.jpg', 'c.jpg', 'd.jpg', 'new.jpg']);
      time.elapse(const Duration(minutes: 1));
      time.flushMicrotasks();
      expect(folder.listCalls, 2);
      storage.next().then((item) => expect(itemName(item?.uri), 'new.jpg'));
      time.flushMicrotasks();
    },
  );

  fakeStorageTest(
    'concurrent next calls keep old pair until scan is ready',
    ['a.jpg', 'b.jpg'],
    (time, folder, storage) {
      final scan = StreamController<FileSystemEntity>();
      folder.listing = () {
        folder.listing = null;
        return scan.stream;
      };
      final issued = <String?>[];
      storage.next().then((item) => issued.add(itemName(item?.uri)));
      storage.next().then((item) => issued.add(itemName(item?.uri)));
      time.flushMicrotasks();
      expect(folder.listCalls, 2);
      storage.getCurrent().then((item) => expect(itemName(item?.uri), 'a.jpg'));
      storage.getNext().then((item) => expect(itemName(item?.uri), 'b.jpg'));
      time.flushMicrotasks();
      expect(issued, isEmpty);
      for (final name in ['a.jpg', 'b.jpg', 'c.jpg', 'd.jpg']) {
        scan.add(File('/media/$name'));
      }
      folder.setNames(['a.jpg', 'b.jpg', 'c.jpg', 'd.jpg']);
      scan.close();
      time.flushMicrotasks();
      expect(issued, ['d.jpg', 'c.jpg']);
      storage.getCurrent().then((item) => expect(itemName(item?.uri), 'd.jpg'));
      storage.getNext().then((item) => expect(itemName(item?.uri), 'c.jpg'));
      time.flushMicrotasks();
      expect(folder.listCalls, 2);
    },
  );

  fakeStorageTest(
    'release cancels pending scan, queued next and timer',
    ['a.jpg', 'b.jpg'],
    (time, folder, storage) {
      var scanCancelled = 0;
      final scan = StreamController<FileSystemEntity>(
        onCancel: () async {
          scanCancelled++;
        },
      );
      folder.listing = () => scan.stream;
      var completed = 0;
      storage.next().then((item) {
        expect(item?.uri, isNull);
        completed++;
      });
      storage.next().then((item) {
        expect(item?.uri, isNull);
        completed++;
      });
      time.flushMicrotasks();
      scan.add(File('/media/late.jpg'));
      folder.changed();
      time.flushMicrotasks();
      final firstRelease = storage.release();
      expect(identical(firstRelease, storage.release()), isTrue);
      var released = false;
      firstRelease.then((_) => released = true);
      time.flushMicrotasks();
      expect(released, isTrue);
      expect(completed, 2);
      expect(scanCancelled, 1);
      expect(folder.watchCancellations, 1);
      scan.add(File('/media/even-later.jpg'));
      scan.close();
      time.flushMicrotasks();
      storage.getCurrent().then((item) => expect(itemName(item?.uri), 'a.jpg'));
      storage.getNext().then((item) => expect(itemName(item?.uri), 'b.jpg'));
      time.flushMicrotasks();
      final calls = folder.listCalls;
      time.elapse(const Duration(minutes: 2));
      expect(folder.listCalls, calls);
      expect(time.pendingTimers, isEmpty);
    },
  );

  test('scan yields to event loop after bounded number of all entities', () {
    fakeAsync((time) {
      final folder = TestDirectory([])
        ..entries = [
          for (var i = 0; i < 600; i++) Directory('/media/folder-$i'),
          File('/media/photo.jpg'),
        ];
      final storage = createStorage(folder);
      var completed = false;
      storage.next().then((_) => completed = true);
      time.flushMicrotasks();
      expect(completed, isFalse);
      var observedBeforeCompletion = false;
      Timer.run(() => observedBeforeCompletion = !completed);
      time.elapse(Duration.zero);
      expect(observedBeforeCompletion, isTrue);
      expect(completed, isTrue);
      storage.release();
      time.flushMicrotasks();
      folder.events.close();
      time.flushMicrotasks();
      expect(time.pendingTimers, isEmpty);
    });
  });

  test('a paused notification consumer does not block release', () async {
    final folder = TestDirectory(['photo.jpg']);
    final storage = createStorage(folder);
    final subscription = storage.onStatusChanged.listen((_) {})..pause();
    await storage.next();
    await storage.release();
    expect(folder.watchCancellations, 1);
    await subscription.cancel();
    await folder.events.close();
  });

  test(
    'GPhoto release during initialization does not create a late sync timer',
    () {
      fakeAsync((time) {
        final scan = StreamController<FileSystemEntity>(onCancel: () async {});
        final folder = TestDirectory([])..listing = () => scan.stream;
        final storage = ControlledGPhotoStorage(folder);
        var initialized = false;
        storage.init().then((_) => initialized = true);
        time.flushMicrotasks();
        expect(initialized, isFalse);
        expect(storage.syncCalls, 1);
        var released = false;
        storage.release().then((_) => released = true);
        time.flushMicrotasks();
        expect(released, isTrue);
        expect(initialized, isTrue);
        expect(scan.hasListener, isFalse);
        expect(time.pendingTimers, isEmpty);
        time.elapse(const Duration(hours: 2));
        expect(storage.syncCalls, 1);
        scan.close();
        folder.events.close();
        time.flushMicrotasks();
      });
    },
  );

  test('GPhoto owns errors from its initial background sync', () {
    fakeAsync((time) {
      final folder = TestDirectory([]);
      final storage = ControlledGPhotoStorage(folder)
        ..onSync = () =>
            Future<Null>.error(StateError('Controlled sync failure'));
      var initialized = false;
      storage.init().then((_) => initialized = true);
      time.flushMicrotasks();
      expect(initialized, isTrue);
      expect(storage.syncCalls, 1);
      storage.release();
      time.flushMicrotasks();
      expect(time.pendingTimers, isEmpty);
      folder.events.close();
      time.flushMicrotasks();
    });
  });

  test('GPhoto init and sync do no work after release', () {
    fakeAsync((time) {
      final folder = TestDirectory([]);
      final appStorage = MemoryAppStorage();
      // An empty album list makes the regression safe even before the guard:
      // the old sync would write lastSync, but would not perform HTTP requests.
      final config = GPhotoStorageConfig.fromJson({'albumNames': <String>[]});
      final storage = GPhotoStorage(config, appStorage, folder: folder);
      storage.release();
      time.flushMicrotasks();
      var initialized = false;
      var synced = false;
      storage.init().then((_) => initialized = true);
      storage.sync().then((_) => synced = true);
      time.flushMicrotasks();
      expect(initialized, isTrue);
      expect(synced, isTrue);
      expect(folder.listCalls, 0);
      expect(folder.watchCalls, 0);
      expect(appStorage.writes, 0);
      expect(time.pendingTimers, isEmpty);
      folder.events.close();
      time.flushMicrotasks();
    });
  });
}
