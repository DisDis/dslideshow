// Test the application HTTP handler with real files and an external-tool boundary.
// ignore_for_file: avoid_slow_async_io
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/src/service/fake/fake_remote_service.dart';
import 'package:dslideshow_backend/src/service/gallery/gallery_catalog_service.dart';
import 'package:dslideshow_backend/src/service/gallery/gallery_tool_runner.dart';
import 'package:dslideshow_backend/src/web_server/web_service.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:image/image.dart' as image;
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';

import 'support/gallery_tool_stub.dart';
import 'helpers/capture_logs.dart';

class _UnusedRemote implements RemoteService {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late Directory root;
  late Directory originals;
  late WebService service;
  late GalleryToolStub runner;
  late GalleryToolCallback tool;
  var writeSerial = 0;
  const ok = GalleryToolResult(exitCode: 0, stdout: '', stderr: '');

  setUp(() async {
    root = await Directory.systemTemp.createTemp('gallery-management-http-');
    originals = await Directory(path.join(root.path, 'images')).create();
    await Directory(path.join(root.path, 'web')).create();
    tool = (executable, arguments, cancellation, environment) async {
      fail('Unexpected external tool call: $executable');
    };
    runner = GalleryToolStub(
      (executable, arguments, cancellation, environment) =>
          tool(executable, arguments, cancellation, environment),
    );
    final current = Directory.current;
    try {
      Directory.current = root;
      final config = AppConfig.fromJson({});
      service = WebService(
        config,
        config.webServer,
        _UnusedRemote(),
        cacheDirectory: originals,
        galleryDirectory: Directory('${originals.path}.gallery'),
        galleryToolRunner: runner,
        startServer: false,
      );
    } finally {
      Directory.current = current;
    }
  });
  tearDown(() async {
    await service.close();
    await runner.close();
    await root.delete(recursive: true);
  });

  Future<Response> send(
    String tail, {
    String method = 'GET',
    String? body,
    String? code,
    Map<String, String> headers = const {},
  }) async => service.handler(
    Request(
      method,
      Uri.parse('http://localhost/cache/${code ?? service.code}/$tail'),
      body: body,
      headers: headers,
    ),
  );
  Future<Response> post(String tail, Map<String, dynamic> json) => send(
    tail,
    method: 'POST',
    body: jsonEncode(json),
    headers: {'content-type': 'application/json'},
  );
  Future<Map<String, dynamic>> decode(Response response) async =>
      jsonDecode(await response.readAsString()) as Map<String, dynamic>;
  Future<GalleryCatalog> catalog() async {
    final response = await send('v2/catalog');
    expect(response.statusCode, 200);
    return GalleryCatalog.fromJson(await decode(response));
  }

  Future<GalleryTrashCatalog> trash() async {
    final response = await send('v2/trash');
    expect(response.statusCode, 200);
    return GalleryTrashCatalog.fromJson(await decode(response));
  }

  Future<GalleryEntry> write(String name, List<int> bytes) async {
    final file = File(path.join(originals.path, name));
    await file.parent.create(recursive: true);
    await file.writeAsBytes(bytes);
    final refreshed = await post(
      'v2/catalog/refresh',
      GalleryRefreshRequest(
        operationId: 'fixture-write-${++writeSerial}',
        mode: GalleryRefreshMode.scan,
      ).toJson(),
    );
    expect(refreshed.statusCode, 200);
    await refreshed.read().drain<void>();
    return (await catalog()).entries.firstWhere((e) => e.path == name);
  }

  GalleryMediaRef ref(GalleryEntry entry) => GalleryMediaRef(
    mediaId: entry.mediaId,
    sourceRevision: entry.sourceRevision ?? 'directory',
  );
  GalleryMediaRef trashRef(GalleryTrashEntry entry) => GalleryMediaRef(
    mediaId: entry.trashId,
    sourceRevision: entry.sourceRevision,
  );
  Future<GalleryOperationResult> mutate(
    String id,
    GalleryMutation action,
    List<GalleryMediaRef> items,
  ) async {
    final response = await post(
      'v2/operations',
      GalleryOperationRequest(
        operationId: id,
        action: action,
        items: items,
      ).toJson(),
    );
    expect(response.statusCode, 200);
    return GalleryOperationResult.fromJson(await decode(response));
  }

  test(
    'management endpoints reject unauthorized requests before tools or files',
    () async {
      final routes = <(String, String)>[
        ('GET', 'v2/metadata/photo/revision'),
        ('POST', 'v2/rotate'),
        ('GET', 'v2/trash'),
        ('GET', 'v2/trash/original/photo/revision'),
        ('GET', 'v2/trash/metadata/photo/revision'),
        ('POST', 'v2/operations'),
        ('GET', 'v2/duplicates'),
        ('GET', 'v2/duplicates/scan/groups/0'),
        ('POST', 'v2/duplicates'),
        ('POST', 'v2/duplicates/scan/stop'),
      ];
      for (final (method, route) in routes) {
        final response = await send(
          route,
          method: method,
          code: 'wrong',
          body: method == 'POST' ? '{}' : null,
        );
        expect(response.statusCode, 403, reason: '$method $route');
        expect(
          GalleryErrorResponse.fromJson(await decode(response)).code,
          GalleryErrorCode.forbidden,
        );
        expect(response.headers['cache-control'], 'no-store');
      }
      expect(runner.calls, isEmpty);
      expect(
        await Directory(path.join('${originals.path}.gallery', 'trash'))
            .exists(),
        false,
      );
    },
  );

  test('catalog advertises management and metadata returns the source-version contract', () async {
    final pixels = image.Image(width: 32, height: 16);
    pixels.exif.imageIfd
      ..orientation = 1
      ..['Make'] = 'Example'
      ..['Model'] = 'Camera';
    pixels.exif.exifIfd['DateTimeOriginal'] = '2026:07:12 10:11:12';
    final bytes = image.encodeJpg(pixels);
    final entry = await write('album/фото.jpg', bytes);
    final snapshot = await catalog();
    expect(
      snapshot.capabilities,
      containsAll([
        GalleryCapability.thumbnails,
        GalleryCapability.revisionedOriginals,
        GalleryCapability.metadata,
        GalleryCapability.mutations,
        GalleryCapability.rotation,
        GalleryCapability.trash,
        GalleryCapability.duplicates,
      ]),
    );
    final response = await send(
      'v2/metadata/${entry.mediaId}/${entry.sourceRevision}',
    );
    expect(response.statusCode, 200);
    expect(response.headers['cache-control'], 'no-store');
    final data = GalleryMetadata.fromJson(await decode(response));
    expect(data.mediaId, entry.mediaId);
    expect(data.sourceRevision, entry.sourceRevision);
    expect(data.path, 'album/фото.jpg');
    expect(data.sizeBytes, bytes.length);
    expect(data.width, 32);
    expect(data.camera, 'Example Camera');
    expect(data.dateTaken, '2026:07:12 10:11:12');
    expect(data.longitude, isNull);
    final stale = await send('v2/metadata/${entry.mediaId}/old');
    expect(stale.statusCode, 409);
    expect(
      GalleryErrorResponse.fromJson(await decode(stale)).code,
      GalleryErrorCode.revisionMismatch,
    );
  });

  test('HTTP trash previews retain bytes and restore/purge preserve conflicting files', () async {
    final bytes = image.encodeJpg(image.Image(width: 32, height: 16));
    final entry = await write('album/фото "one".jpg', bytes);
    final moved = await mutate('move', GalleryMutation.trash, [ref(entry)]);
    expect(moved.items.single.state, GalleryItemOperationState.succeeded);
    final trashed = (await trash()).entries.single;
    expect(trashed.originalPath, entry.path);
    expect(trashed.sizeBytes, bytes.length);
    expect(
      await File(
        path.join(path.join('${originals.path}.gallery', 'trash'), entry.path),
      ).readAsBytes(),
      bytes,
    );
    expect(
      await File(
        path.join(
          path.join('${originals.path}.gallery', 'trash'),
          'manifest.json',
        ),
      ).exists(),
      isFalse,
    );
    final preview = await send(
      'v2/trash/original/${trashed.trashId}/${trashed.sourceRevision}',
    );
    expect(preview.statusCode, 200);
    expect(preview.headers['content-type'], startsWith('image/jpeg'));
    expect(await preview.read().expand((part) => part).toList(), bytes);
    final range = await send(
      'v2/trash/original/${trashed.trashId}/${trashed.sourceRevision}',
      headers: {'range': 'bytes=1-3'},
    );
    expect(range.statusCode, 206);
    expect(
      await range.read().expand((part) => part).toList(),
      bytes.sublist(1, 4),
    );
    final stale = await send('v2/trash/original/${trashed.trashId}/old');
    expect(stale.statusCode, 409);
    await stale.read().drain<void>();
    final info = await send(
      'v2/trash/metadata/${trashed.trashId}/${trashed.sourceRevision}',
    );
    expect(info.statusCode, 200);
    expect(
      GalleryMetadata.fromJson(await decode(info)).mediaId,
      trashed.trashId,
    );

    final conflict = File(path.join(originals.path, entry.path));
    await conflict.writeAsString('another user file');
    final restored = await mutate('restore', GalleryMutation.restore, [
      trashRef(trashed),
    ]);
    expect(restored.items.single.state, GalleryItemOperationState.succeeded);
    final restoredPath = restored.items.single.restoredPath!;
    expect(restoredPath, isNot(entry.path));
    expect(await conflict.readAsString(), 'another user file');
    expect(
      await File(path.join(originals.path, restoredPath)).readAsBytes(),
      bytes,
    );
    expect((await trash()).entries, isEmpty);
    final next = (await catalog()).entries.firstWhere(
      (e) => e.path == restoredPath,
    );
    await mutate('move-again', GalleryMutation.trash, [ref(next)]);
    final again = (await trash()).entries.single;
    final purged = await mutate('purge', GalleryMutation.purge, [
      trashRef(again),
    ]);
    expect(purged.items.single.state, GalleryItemOperationState.succeeded);
    final repeated = await mutate('purge', GalleryMutation.purge, [
      trashRef(again),
    ]);
    expect(repeated.items.single.state, GalleryItemOperationState.failed);
    expect(repeated.items.single.error, GalleryErrorCode.notFound);
    expect((await trash()).entries, isEmpty);
    final gone = await send(
      'v2/trash/original/${again.trashId}/${again.sourceRevision}',
    );
    expect(gone.statusCode, 404);
    await gone.read().drain<void>();
    expect(await conflict.readAsString(), 'another user file');
  });

  test(
    'bad versions, directory IDs and path-like IDs cannot delete files',
    () async {
      final photo = await write('album/a.jpg', [1, 2, 3]);
      final directory = (await catalog()).entries.singleWhere(
        (e) => e.kind == GalleryEntryKind.directory,
      );
      final outside = await File(path.join(root.path, 'outside.jpg'))
          .writeAsString('outside');
      final result = await mutate('invalid-targets', GalleryMutation.trash, [
        ref(directory),
        GalleryMediaRef(mediaId: photo.mediaId, sourceRevision: 'old'),
        const GalleryMediaRef(
          mediaId: '../outside.jpg',
          sourceRevision: 'revision',
        ),
      ]);
      expect(
        result.items.map((e) => e.state),
        everyElement(GalleryItemOperationState.failed),
      );
      expect(result.items[1].error, GalleryErrorCode.revisionMismatch);
      expect(await File(path.join(originals.path, photo.path)).readAsBytes(), [
        1,
        2,
        3,
      ]);
      expect(await outside.readAsString(), 'outside');
      expect((await trash()).entries, isEmpty);
      final rotate = await post(
        'v2/rotate',
        GalleryRotateRequest(
          operationId: 'rotate-stale',
          mediaId: photo.mediaId,
          sourceRevision: 'old',
          rotation: GalleryRotation.right,
        ).toJson(),
      );
      expect(rotate.statusCode, 409);
      await rotate.read().drain<void>();
    },
  );

  test('search runs outside HTTP/catalog work and stop waits for cancellation cleanup', () async {
    await write('a.jpg', [1, 2, 3, 4]);
    await write('b.jpg', [1, 2, 3, 4]);
    final entered = Completer<void>();
    var cleaned = false;
    tool = (executable, args, cancellation, environment) async {
      expect(executable, 'czkawka_cli');
      if (args.length == 1 && args.single == '--version') {
        return ok.copyWith(stdout: 'czkawka_cli 12.0.2');
      }
      entered.complete();
      await cancellation!;
      cleaned = true;
      return ok;
    };
    final start = await post('v2/duplicates', {
      'operationId': 'scan',
      'modes': ['exact'],
    });
    expect(start.statusCode, 200);
    final running = GalleryDuplicateJob.fromJson(await decode(start));
    expect(running.status, GalleryDuplicateStatus.running);
    expect(running.jobId, 'scan');
    expect(running.startedAt, isNotNull);
    await entered.future.timeout(const Duration(seconds: 3));
    final responsive = await catalog().timeout(const Duration(seconds: 3));
    expect(responsive.entries.map((e) => e.name), ['a.jpg', 'b.jpg']);
    final state = await send('v2/duplicates');
    expect(
      GalleryDuplicateJob.fromJson(await decode(state)).status,
      GalleryDuplicateStatus.running,
    );
    final repeated = await post('v2/duplicates', {
      'operationId': 'scan',
      'modes': ['exact'],
    });
    expect(repeated.statusCode, 200);
    await repeated.read().drain<void>();
    expect(
      runner.calls.where((args) => !args.contains('--version')),
      hasLength(1),
    );
    final busy = await post('v2/duplicates', {
      'operationId': 'another',
      'modes': ['exact'],
    });
    expect(busy.statusCode, 429);
    await busy.read().drain<void>();
    final stopped = await post('v2/duplicates/scan/stop', {});
    expect(stopped.statusCode, 200);
    expect(cleaned, true);
    expect(
      GalleryDuplicateJob.fromJson(await decode(stopped)).status,
      GalleryDuplicateStatus.cancelled,
    );
    final finalState = await send('v2/duplicates');
    expect(
      GalleryDuplicateJob.fromJson(await decode(finalState)).status,
      GalleryDuplicateStatus.cancelled,
    );
    expect(
      await Directory('${originals.path}.gallery/duplicates')
          .list()
          .any((e) => e is Directory),
      false,
    );
  });

  test(
    'malformed, oversized and unknown requests return typed client errors',
    () async {
      for (final body in [
        '{bad',
        '[]',
        ' ' * (256 * 1024 + 1),
        '{"operationId":"op","action":"future","items":[]}',
        '{"operationId":"op","action":"trash","items":[]}',
        '{"operationId":"op","action":"trash","items":[{"mediaId":"id"}]}',
      ]) {
        final response = await send(
          'v2/operations',
          method: 'POST',
          body: body,
        );
        expect(response.statusCode, 400);
        expect(
          GalleryErrorResponse.fromJson(await decode(response)).code,
          GalleryErrorCode.invalidRequest,
        );
      }
      for (final json in [
        <String, dynamic>{'operationId': 'scan', 'modes': []},
        <String, dynamic>{
          'operationId': 'scan',
          'modes': ['futureMode'],
        },
      ]) {
        final response = await post('v2/duplicates', json);
        expect(response.statusCode, 400);
        await response.read().drain<void>();
      }
      expect(runner.calls, isEmpty);
    },
  );

  test(
    'dedup provenance reaches the mutation guard and protects the final copy',
    () async {
      final first = await write('a.jpg', [1, 2, 3, 4]);
      final second = await write('b.jpg', [1, 2, 3, 4]);
      tool = (executable, arguments, cancellation, environment) async {
        if (arguments.length == 1 && arguments.single == '--version') {
          return ok.copyWith(stdout: 'czkawka_cli 12.0.2');
        }
        final output =
            arguments[arguments.indexOf('--compact-file-to-save') + 1];
        await File(output).writeAsString(
          jsonEncode({
            '4': [
              [
                {
                  'path': path.join(originals.absolute.path, first.path),
                  'size': 4,
                },
                {
                  'path': path.join(originals.absolute.path, second.path),
                  'size': 4,
                },
              ],
            ],
          }),
        );
        return ok;
      };
      final started = await post('v2/duplicates', {
        'operationId': 'review',
        'modes': ['exact'],
      });
      expect(started.statusCode, 200);
      await started.read().drain<void>();
      final clock = Stopwatch()..start();
      GalleryDuplicateJob job;
      while (true) {
        final response = await send('v2/duplicates')
            .timeout(const Duration(seconds: 3));
        job = GalleryDuplicateJob.fromJson(await decode(response));
        if (job.status != GalleryDuplicateStatus.running &&
            job.status != GalleryDuplicateStatus.stopping)
          break;
        if (clock.elapsed > const Duration(seconds: 5)) {
          fail('Search did not complete: ${job.toJson()}');
        }
        await Future<void>(() {});
      }
      expect(job.status, GalleryDuplicateStatus.completed);
      expect(job.groups.single.items, hasLength(2));
      final groupResponse = await send('v2/duplicates/review/groups/0');
      expect(groupResponse.statusCode, 200);
      final group = GalleryDuplicateGroupPage.fromJson(
        await decode(groupResponse),
      );
      expect(group.group!.items, job.groups.single.items);
      final invalidIndex = await send(
        'v2/duplicates/review/groups/not-an-index',
      );
      expect(invalidIndex.statusCode, 400);
      await invalidIndex.read().drain<void>();
      Future<Response> guarded(String id, List<GalleryMediaRef> items) => post(
        'v2/operations',
        GalleryOperationRequest(
          operationId: id,
          action: GalleryMutation.trash,
          items: items,
          duplicateJobId: 'review',
        ).toJson(),
      );
      final all = await guarded('delete-all', [ref(first), ref(second)]);
      expect(all.statusCode, 409);
      expect(
        GalleryErrorResponse.fromJson(await decode(all)).code,
        GalleryErrorCode.conflict,
      );
      expect((await trash()).entries, isEmpty);
      final selected = await guarded('delete-one', [ref(first)]);
      expect(selected.statusCode, 200);
      expect(
        GalleryOperationResult.fromJson(await decode(selected))
            .items
            .single
            .state,
        GalleryItemOperationState.succeeded,
      );
      final reviewedResponse = await send('v2/duplicates/review/groups/0');
      final reviewed = GalleryDuplicateGroupPage.fromJson(
        await decode(reviewedResponse),
      );
      expect(reviewed.index, 1);
      expect(reviewed.group, isNull);
      final last = await guarded('delete-last', [ref(second)]);
      expect(last.statusCode, 409);
      expect(
        GalleryErrorResponse.fromJson(await decode(last)).code,
        GalleryErrorCode.conflict,
      );
      expect(await File(path.join(originals.path, second.path)).readAsBytes(), [
        1,
        2,
        3,
        4,
      ]);
      expect((await trash()).entries.single.originalPath, first.path);
    },
  );

  test('trash preview resolves only its own entry and still rejects a symlink target', () async {
    final first = await write('a.jpg', [1, 2, 3]);
    final second = await write('b.jpg', [4, 5, 6]);
    await mutate('move-pair', GalleryMutation.trash, [ref(first), ref(second)]);
    final entries = (await trash()).entries;
    final wanted = entries.singleWhere(
      (entry) => entry.originalPath == first.path,
    );
    final damaged = entries.singleWhere(
      (entry) => entry.originalPath == second.path,
    );
    final damagedFile = File(
      path.join(
        path.join('${originals.path}.gallery', 'trash'),
        damaged.originalPath,
      ),
    );
    final saved = await damagedFile.rename(
      path.join(root.path, 'saved-original.jpg'),
    );
    final outside = await File(path.join(root.path, 'outside.jpg'))
        .writeAsString('outside original');
    await Link(damagedFile.path).create(outside.path);
    final preview = await send(
      'v2/trash/original/${wanted.trashId}/${wanted.sourceRevision}',
    );
    expect(preview.statusCode, 200);
    expect(await preview.read().expand((chunk) => chunk).toList(), [1, 2, 3]);
    final metadata = await send(
      'v2/trash/metadata/${wanted.trashId}/${wanted.sourceRevision}',
    );
    expect(metadata.statusCode, 200);
    expect(
      GalleryMetadata.fromJson(await decode(metadata)).mediaId,
      wanted.trashId,
    );
    final forbidden = await send(
      'v2/trash/original/${damaged.trashId}/${damaged.sourceRevision}',
    );
    expect(forbidden.statusCode, 400);
    expect(
      GalleryErrorResponse.fromJson(await decode(forbidden)).code,
      GalleryErrorCode.invalidRequest,
    );
    expect(await outside.readAsString(), 'outside original');
    expect(await saved.readAsBytes(), [4, 5, 6]);
  });

  test(
    'route failures log typed HTTP context and keep exception payloads private',
    () => captureLogs((records) async {
      final entry = await write('PRIVATE_EXIF_GPS_NAME.mp4', [1, 2, 3]);
      final unauthorized = await send(
        'v2/metadata/${entry.mediaId}/${entry.sourceRevision}',
        code: 'AUTH_SECRET',
      );
      expect(unauthorized.statusCode, 403);
      await unauthorized.read().drain<void>();
      tool = (executable, _, _, _) async {
        expect(executable, 'ffprobe');
        throw FileSystemException(
          'AUTH_SECRET http://frame/PRIVATE_EXIF GPS=55.123,37.456 stderr secret',
          path.join(root.path, entry.path),
        );
      };
      final failed = await send(
        'v2/metadata/${entry.mediaId}/${entry.sourceRevision}',
      );
      expect(failed.statusCode, 503);
      await failed.read().drain<void>();
      tool = (_, _, _, _) async =>
          throw const GalleryCatalogFailure(GalleryErrorCode.cancelled);
      final cancelled = await send(
        'v2/metadata/${entry.mediaId}/${entry.sourceRevision}',
      );
      expect(cancelled.statusCode, 409);
      await cancelled.read().drain<void>();
      final malformed = await send(
        'v2/operations',
        method: 'POST',
        body: '{"AUTH_SECRET":PRIVATE_EXIF_GPS}',
      );
      expect(malformed.statusCode, 400);
      await malformed.read().drain<void>();
      final diagnostics = records
          .where((record) => record.loggerName == 'GalleryManagementRoutes')
          .toList();
      expect(
        diagnostics.any(
          (record) =>
              record.level == Level.WARNING &&
              record.message.contains('route=metadata') &&
              record.message.contains('httpStatus=503 code=unavailable'),
        ),
        true,
      );
      final cancellation = diagnostics.singleWhere(
        (record) => record.message.contains('code=cancelled'),
      );
      expect(cancellation.level, Level.FINE);
      expect(cancellation.message, contains('httpStatus=409'));
      expect(
        diagnostics.any(
          (record) => record.message.contains('httpStatus=403 code=forbidden'),
        ),
        true,
      );
      expect(
        diagnostics.any(
          (record) =>
              record.message.contains('route=mutation') &&
              record.message.contains('httpStatus=400 code=invalidRequest'),
        ),
        true,
      );
      for (final record in diagnostics) {
        expect(record.error, isNull);
        expect(record.stackTrace, isNull);
        expect(
          int.tryParse(record.message.split('elapsedMs=').last),
          isNotNull,
        );
        for (final secret in [
          'AUTH_SECRET',
          'PRIVATE_EXIF',
          'GPS=',
          'stderr secret',
          root.path,
          'http://',
          service.code,
        ]) {
          expect(record.message, isNot(contains(secret)));
        }
      }
    }),
  );

  test('standalone WebService with relative two-hop images alias can trash preview and restore', () async {
    await service.close();
    await originals.delete();
    final actual = await Directory(path.join(root.path, 'real-media')).create();
    await Link(path.join(root.path, 'media-link')).create('real-media');
    await Link(originals.path).create('media-link');
    final source = await File(path.join(actual.path, 'photo.jpg'))
        .writeAsBytes([1, 2, 3, 4]);
    final previousCwd = Directory.current;
    try {
      Directory.current = root;
      final config = AppConfig.fromJson({});
      service = WebService(
        config,
        config.webServer,
        FakeRemoteService(name: 'gallery-alias-test'),
        cacheDirectory: Directory('images'),
        galleryToolRunner: runner,
        startServer: false,
      );
      final entry = (await catalog()).entries.single;
      final moved = await mutate(
        'relative-alias-trash',
        GalleryMutation.trash,
        [ref(entry)],
      );
      expect(moved.items.single.state, GalleryItemOperationState.succeeded);
      expect(await source.exists(), false);
      final trashed = (await trash()).entries.single;
      final preview = await send(
        'v2/trash/original/${trashed.trashId}/${trashed.sourceRevision}',
      );
      expect(preview.statusCode, 200);
      expect(await preview.read().expand((chunk) => chunk).toList(), [
        1,
        2,
        3,
        4,
      ]);
      expect(
        await File(
          path.join(
            path.join('${originals.path}.gallery', 'trash'),
            trashed.originalPath,
          ),
        ).exists(),
        true,
      );
      final restored = await mutate(
        'relative-alias-restore',
        GalleryMutation.restore,
        [trashRef(trashed)],
      );
      expect(restored.items.single.state, GalleryItemOperationState.succeeded);
      expect(await source.readAsBytes(), [1, 2, 3, 4]);
      expect((await trash()).entries, isEmpty);
      expect(await Link(originals.path).exists(), true);
      expect(
        await Directory(path.join('${actual.path}.gallery', 'trash')).exists(),
        false,
      );
    } finally {
      await service.close();
      Directory.current = previousCwd;
    }
  });
}
