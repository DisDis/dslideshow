// Small real files exercise the shared cloud publisher without RPC or hardware.
// ignore_for_file: avoid_slow_async_io
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dslideshow_backend/src/command/drive_command.dart';
import 'package:dslideshow_backend/src/command/empty_result.dart';
import 'package:dslideshow_backend/src/service/gallery/gallery_catalog_service.dart';
import 'package:dslideshow_backend/src/service/gallery/gallery_files.dart';
import 'package:dslideshow_backend/src/service/storage/cloud_storage.dart';
import 'package:dslideshow_backend/src/service/storage/cloud_storage_transfer.dart';
import 'package:dslideshow_backend/src/service/storage/disk/disk_storage_config.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';

import 'helpers/capture_logs.dart';
import 'support/no_watch_directory.dart';

class _CloudStorage extends CloudStorage {
  _CloudStorage(Directory folder) : super(DiskStorageConfig(), folder: folder);

  @override
  Future<RpcResult> executeDriveCommand(DriveCommand command) async => EmptyResult(id: command.id);
}

void main() {
  late Directory root, originals;
  late _CloudStorage storage;
  final ownedStorages = <_CloudStorage>[];

  setUp(() async {
    root = await Directory.systemTemp.createTemp('cloud-publication-');
    originals = await Directory(path.join(root.path, 'images')).create();
    storage = _CloudStorage(originals);
    ownedStorages.add(storage);
  });
  tearDown(() async {
    for (final owned in ownedStorages) {
      await owned.release();
    }
    ownedStorages.clear();
    await root.delete(recursive: true);
  });

  Future<List<FileSystemEntity>> stagingFiles() =>
      originals.list(recursive: true, followLinks: false).where((entity) => isGalleryStagingPath(entity.path)).toList();

  Matcher failure(DriveFailure code) => isA<CloudStorageException>().having((error) => error.code, 'code', code);

  test('partial bytes remain staged until a complete nested download passes size and hash checks', () async {
    final bytes = utf8.encode('complete family photo');
    final entered = Completer<void>();
    final resume = Completer<void>();
    Stream<List<int>> body() async* {
      yield bytes.sublist(0, 5);
      entered.complete();
      await resume.future;
      yield bytes.sublist(5);
    }

    const relative = 'yandex.drive.123/Camera/nested/photo.jpg';
    final target = File(path.join(originals.path, relative));
    final publishing = storage.publishDownloadedMedia(
      body(),
      relative,
      expectedBytes: bytes.length,
      contentLength: bytes.length,
      expectedMd5: md5.convert(bytes).toString().toUpperCase(),
      expectedSha256: sha256.convert(bytes).toString(),
    );
    await entered.future;
    try {
      expect(await target.exists(), isFalse);
      expect(await stagingFiles(), hasLength(1));
    } finally {
      resume.complete();
    }
    expect(await publishing, isTrue);
    expect(await target.readAsBytes(), bytes);
    expect(await stagingFiles(), isEmpty);
  });

  test('size, MD5 and SHA256 mismatches remove staging and leave no published original', () async {
    const bytes = [1, 2, 3];
    Future<void> rejects(String name, {int? size, String? md5Value, String? shaValue}) async {
      await expectLater(
        storage.publishDownloadedMedia(
          Stream.value(bytes),
          name,
          expectedBytes: size,
          expectedMd5: md5Value,
          expectedSha256: shaValue,
        ),
        throwsA(failure(DriveFailure.checksum)),
      );
      expect(await File(path.join(originals.path, name)).exists(), isFalse);
      expect(await stagingFiles(), isEmpty);
    }

    await rejects('size.jpg', size: bytes.length + 1);
    await rejects('md5.jpg', md5Value: '0' * 32);
    await rejects('sha256.jpg', shaValue: '0' * 64);
  });

  test('existing library and hidden files are preserved without reading the supplied body', () async {
    var bodyReads = 0;
    Stream<List<int>> body() async* {
      bodyReads++;
      yield [1, 2, 3];
    }

    for (final directory in [originals, storage.hidden]) {
      await directory.create(recursive: true);
      final name = directory == originals ? 'visible.jpg' : 'hidden.jpg';
      final existing = await File(path.join(directory.path, name)).writeAsString('existing');
      expect(await storage.publishDownloadedMedia(body(), name), isFalse);
      expect(await existing.readAsString(), 'existing');
    }
    expect(bodyReads, 0);
    expect(await stagingFiles(), isEmpty);
  });

  test('a file created in either root while the body is received is preserved at final publication', () async {
    for (final directory in [originals, storage.hidden]) {
      final entered = Completer<void>();
      final resume = Completer<void>();
      Stream<List<int>> body() async* {
        yield [1];
        entered.complete();
        await resume.future;
        yield [2];
      }

      final relative = directory == originals ? 'late-visible.jpg' : 'late-hidden.jpg';
      final publishing = storage.publishDownloadedMedia(body(), relative);
      await entered.future;
      final existing = File(path.join(directory.path, relative));
      try {
        await existing.parent.create(recursive: true);
        await existing.writeAsString('arrived while downloading');
      } finally {
        resume.complete();
      }
      expect(await publishing, isFalse);
      expect(await existing.readAsString(), 'arrived while downloading');
      expect(await stagingFiles(), isEmpty);
    }
  });

  test('transport failures are redacted and clean partial staging without publication', () async {
    Stream<List<int>> body() async* {
      yield [1, 2];
      throw const HttpException('https://signed.example/photo?token=private-network-token');
    }

    await captureLogs((records) async {
      await expectLater(storage.publishDownloadedMedia(body(), 'network.jpg'), throwsA(failure(DriveFailure.network)));
      expect(await File(path.join(originals.path, 'network.jpg')).exists(), isFalse);
      expect(await stagingFiles(), isEmpty);
      expect(records.any((record) => record.message.contains('failed reason=network')), isTrue);
      expect(
        records.map((record) => '${record.message} ${record.error ?? ''} ${record.stackTrace ?? ''}').join('\n'),
        isNot(contains('private-network-token')),
      );
      expect(records.where((record) => record.loggerName == 'CloudStorage' && record.level >= Level.INFO), isEmpty);
    });
  });

  test('an accepted body finishes verification and publication after storage release', () async {
    final entered = Completer<void>();
    final resume = Completer<void>();
    final closed = Completer<void>();
    Stream<List<int>> body() async* {
      try {
        yield [1, 2];
        entered.complete();
        await resume.future;
        yield [3];
      } finally {
        closed.complete();
      }
    }

    await captureLogs((records) async {
      final publishing = storage.publishDownloadedMedia(body(), 'completed.jpg', expectedBytes: 3);
      await entered.future;
      try {
        expect(await stagingFiles(), hasLength(1));
        ownedStorages.remove(storage);
        await storage.release();
        expect(await File(path.join(originals.path, 'completed.jpg')).exists(), isFalse);
      } finally {
        resume.complete();
      }
      expect(await publishing, isTrue);
      await closed.future;
      expect(await File(path.join(originals.path, 'completed.jpg')).readAsBytes(), [1, 2, 3]);
      expect(await stagingFiles(), isEmpty);
      expect(records.any((record) => record.message == 'Media publication completed'), isTrue);
      expect(records.where((record) => record.level >= Level.WARNING), isEmpty);
    });
  });

  test('publication follows a symlink directory in the configured target path', () async {
    final actual = await Directory(path.join(root.path, 'linked-target')).create();
    await Link(path.join(originals.path, 'album')).create(actual.path);
    expect(await storage.publishDownloadedMedia(Stream.value(utf8.encode('linked photo')), 'album/photo.jpg'), isTrue);
    expect(await File(path.join(actual.path, 'photo.jpg')).readAsString(), 'linked photo');
    expect(await stagingFiles(), isEmpty);
    expect((await actual.list().toList()).map((entity) => path.basename(entity.path)), ['photo.jpg']);
  });

  test('publication leaves a gallery snapshot unchanged until its owner explicitly refreshes', () async {
    final catalog = GalleryCatalogService(
      originals: NoWatchDirectory(originals),
      stateDirectory: Directory('${originals.path}.gallery'),
      scanMaxAge: const Duration(days: 1),
    );
    addTearDown(catalog.close);
    final before = await catalog.catalog();
    expect(before.entries, isEmpty);
    expect(await storage.publishDownloadedMedia(Stream.value([1, 2, 3]), 'new/photo.jpg'), isTrue);
    expect(await catalog.catalog(), same(before));
    final refreshed = await catalog.refresh(
      const GalleryRefreshRequest(operationId: 'manual-after-download', mode: GalleryRefreshMode.scan),
    );
    expect(refreshed.entries.where((entry) => entry.kind != GalleryEntryKind.directory).single.path, 'new/photo.jpg');
  });
}
