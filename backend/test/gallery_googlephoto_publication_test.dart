// Test asynchronous disk publication and cancellation without blocking the event loop.
// ignore_for_file: avoid_slow_async_io
import 'dart:async';
import 'dart:io';

import 'package:dslideshow_backend/app_storage.dart';
import 'package:dslideshow_backend/src/service/googlephoto/googlephoto.dart';
import 'package:dslideshow_backend/src/service/storage/googlephoto/gphoto_storage.dart';
import 'package:dslideshow_backend/src/service/storage/googlephoto/gphoto_storage_config.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:test/test.dart';

class _Storage implements AppStorage {
  final values = <String, Object?>{};
  @override
  T getValue<T>(String field, [T? defaultValue]) => defaultValue as T;
  @override
  void setValue<T>(String field, T value) {
    values[field] = value;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Photos implements GooglePhotoService {
  final String url;
  final bool empty;
  _Photos(this.url, {this.empty = false});
  @override
  Stream<AccessCredentials> get onUpdateCredentials => const Stream.empty();
  @override
  Future<Iterable<GooglePhotoItem>> getMediaItemInAlbum(
    String albumName,
    int width,
    int height,
  ) async => empty ? [] : [GooglePhotoItem('one', url, 'image/jpeg')];
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

enum _LocalScanStage { create, list }

class _BlockedDirectory implements Directory {
  final Directory delegate;
  final _LocalScanStage stage;
  final reached = Completer<void>();
  final resume = Completer<void>();
  _BlockedDirectory(this.delegate, this.stage);

  Future<void> _block() async {
    reached.complete();
    await resume.future;
  }

  @override
  String get path => delegate.path;
  @override
  Directory get absolute => this;
  @override
  Future<Directory> create({bool recursive = false}) async {
    await delegate.create(recursive: recursive);
    if (stage == _LocalScanStage.create) await _block();
    return this;
  }

  @override
  Stream<FileSystemEntity> list({
    bool recursive = false,
    bool followLinks = true,
  }) async* {
    if (stage == _LocalScanStage.list) await _block();
    yield* delegate.list(recursive: recursive, followLinks: followLinks);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late Directory root;
  late Directory media;
  late HttpServer server;
  late GPhotoStorage storage;
  setUp(() async {
    root = await Directory.systemTemp.createTemp('gallery-googlephoto-');
    media = await Directory('${root.path}/media').create();
    server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    storage = GPhotoStorage(
      GPhotoStorageConfig.fromJson({}),
      _Storage(),
      folder: media,
      googlePhotoService: _Photos('http://127.0.0.1:${server.port}/photo'),
    );
  });
  tearDown(() async {
    await storage.release();
    await server.close(force: true);
    await root.delete(recursive: true);
  });
  test(
    'sync completes only after body closes and atomic publication is ready',
    () async {
      final first = Completer<void>();
      final finish = Completer<void>();
      server.listen((request) async {
        request.response.contentLength = 6;
        request.response.add([1, 2, 3]);
        await request.response.flush();
        first.complete();
        await finish.future;
        request.response.add([4, 5, 6]);
        await request.response.close();
      });
      var ended = false;
      final listener = storage.onEndSync.listen((_) {
        ended = true;
      });
      addTearDown(listener.cancel);
      var completed = false;
      final syncing = storage.sync().then((_) {
        completed = true;
      });
      await first.future;
      await Future<void>.delayed(const Duration(milliseconds: 20));
      expect(completed, false);
      expect(ended, false);
      expect(await File('${media.path}/one_2560x1600.jpeg').exists(), false);
      finish.complete();
      await syncing;
      await Future<void>.delayed(Duration.zero);
      expect(ended, true);
      expect(await File('${media.path}/one_2560x1600.jpeg').readAsBytes(), [
        1,
        2,
        3,
        4,
        5,
        6,
      ]);
      expect((await media.list().toList()).length, 1);
    },
  );
  test('HTTP error resets sync state and permits a successful retry', () async {
    var requests = 0;
    server.listen((request) async {
      requests++;
      if (requests == 1) {
        request.response.statusCode = 500;
      } else {
        request.response.add([1, 2, 3]);
      }
      await request.response.close();
    });
    await expectLater(storage.sync(), throwsA(anything));
    await storage.sync();
    expect(requests, 2);
    expect(await File('${media.path}/one_2560x1600.jpeg').readAsBytes(), [
      1,
      2,
      3,
    ]);
  });
  test('release cancels an active body and cleans its staging file', () async {
    final first = Completer<void>();
    server.listen((request) async {
      request.response.contentLength = 1000;
      request.response.add([1, 2, 3]);
      await request.response.flush();
      first.complete();
      unawaited(request.response.done.catchError((Object _) {}));
    });
    final syncing = storage.sync().then<Object?>(
      (_) => null,
      onError: (Object error) => error,
    );
    await first.future;
    await storage.release().timeout(const Duration(seconds: 5));
    expect(await syncing, isNotNull);
    expect(await media.list().toList(), isEmpty);
  });
  for (final stage in _LocalScanStage.values) {
    test('release during local ${stage.name} prevents sync success', () async {
      await storage.release();
      final state = _Storage();
      final blocked = _BlockedDirectory(media, stage);
      storage = GPhotoStorage(
        GPhotoStorageConfig.fromJson({}),
        state,
        folder: blocked,
        googlePhotoService: _Photos('', empty: true),
      );
      final initialLastSync = storage.lastSync;
      var ended = false;
      final listener = storage.onEndSync.listen((_) => ended = true);
      addTearDown(listener.cancel);
      // Own errors immediately: the regression used to complete after release
      // with a StateError from adding to the closed notification controller.
      final syncing = storage.sync().then<Object?>(
        (_) => null,
        onError: (Object error) => error,
      );
      await blocked.reached.future;
      try {
        await storage.release().timeout(const Duration(seconds: 5));
      } finally {
        blocked.resume.complete();
      }
      expect(await syncing, isNull);
      expect(ended, false);
      expect(storage.lastSync, initialLastSync);
      expect(state.values, isEmpty);
    });
  }
}
