import 'dart:async';
import 'dart:convert';

import 'package:config_app/src/gallery/gallery_management_repository.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:logging/logging.dart';

import 'gallery_image_loader_test.dart' show ControlledClient;
import 'support/gallery_management_harness.dart';

void main() {
  testWidgets(
    'metadata limits active reads to four and cancels queued reads without starting HTTP',
    (tester) async {
      final client = ControlledClient();
      final repository = GalleryManagementRepository(
        baseUri: Uri.parse('http://frame.local'),
        code: 'code',
        client: client,
      );
      addTearDown(repository.close);
      final cancel = List.generate(7, (_) => Completer<void>());
      final results = [
        for (var i = 0; i < 7; i++)
          repository
              .metadata(managedPhoto('p$i'), cancel: cancel[i].future)
              .then<Object?>((_) => null, onError: (Object error) => error),
      ];
      expect(client.requests, hasLength(4));
      cancel[4].complete();
      await tester.pump();
      expect(
        await results[4],
        isA<GalleryManagementException>().having(
          (e) => e.code,
          'code',
          GalleryErrorCode.cancelled,
        ),
      );
      expect(client.requests, hasLength(4));
      client.requests.first.respond();
      client.requests.first.complete(
        utf8.encode(jsonEncode(photoMetadata('p0').toJson())),
      );
      await tester.pump();
      expect(await results[0], isNull);
      expect(client.requests, hasLength(5));
      expect(client.requests.last.request.url.pathSegments, contains('p5'));
      expect(client.active, 4);
      repository.close();
      await tester.pump();
      final settled = await Future.wait(results);
      expect(
        settled
            .skip(1)
            .every(
              (item) =>
                  item is http.RequestAbortedException ||
                  item is GalleryManagementException,
            ),
        isTrue,
      );
      expect(client.active, 0);
      expect(client.requests, hasLength(5));
    },
  );

  testWidgets(
    'diagnostics distinguish a request deadline from consumer cancellation',
    (tester) async {
      final records = <LogRecord>[];
      final previousLevel = Logger.root.level;
      Logger.root.level = Level.ALL;
      final subscription = Logger.root.onRecord.listen(records.add);
      final transport = ControlledClient();
      final repository = GalleryManagementRepository(
        baseUri: Uri.parse('http://frame.local'),
        code: 'PRIVATE-AUTH',
        client: transport,
        timeout: const Duration(seconds: 1),
      );
      addTearDown(() async {
        repository.close();
        await subscription.cancel();
        Logger.root.level = previousLevel;
      });
      final timedOut = expectLater(
        repository.metadata(managedPhoto('a')),
        throwsA(isA<http.RequestAbortedException>()),
      );
      await tester.pump(const Duration(seconds: 1));
      await timedOut;
      final cancel = Completer<void>();
      final cancelled = expectLater(
        repository.metadata(managedPhoto('b'), cancel: cancel.future),
        throwsA(isA<http.RequestAbortedException>()),
      );
      cancel.complete();
      await tester.pump();
      await cancelled;
      final diagnostics = records
          .where((record) => record.loggerName == 'GalleryManagementRepository')
          .toList();
      final timeout = diagnostics.singleWhere(
        (record) => record.message.contains('event=requestTimedOut '),
      );
      final cancellation = diagnostics.singleWhere(
        (record) => record.message.contains('event=requestCancelled '),
      );
      expect(timeout.level, Level.WARNING);
      expect(timeout.message, contains('code=timeout'));
      expect(cancellation.level, Level.FINE);
      expect(cancellation.message, contains('reason=consumer'));
      expect(transport.active, 0);
      expect(
        diagnostics.every(
          (record) => record.error == null && record.stackTrace == null,
        ),
        isTrue,
      );
      expect(
        diagnostics.map((record) => record.message).join('\n'),
        isNot(contains('PRIVATE-AUTH')),
      );

      final firstRecords = records.length;
      final response = Completer<http.Response>();
      final lateCancel = Completer<void>();
      final delayed = GalleryManagementRepository(
        baseUri: Uri.parse('http://frame.local'),
        code: 'PRIVATE-AUTH',
        client: MockClient((_) => response.future),
        timeout: const Duration(seconds: 1),
      );
      addTearDown(delayed.close);
      final lateResult = expectLater(
        delayed.metadata(managedPhoto('c'), cancel: lateCancel.future),
        throwsA(isA<GalleryManagementException>()),
      );
      lateCancel.complete();
      await tester.pump();
      // The transport deliberately ignores abort until after the deadline.
      await tester.pump(const Duration(seconds: 2));
      response.complete(
        http.Response(jsonEncode(photoMetadata('c').toJson()), 200),
      );
      await tester.pump();
      await lateResult;
      final lateLogs = records
          .skip(firstRecords)
          .where((record) => record.loggerName == 'GalleryManagementRepository')
          .toList();
      expect(
        lateLogs.any(
          (record) => record.message.contains('event=requestTimedOut '),
        ),
        isFalse,
      );
      final stopped = lateLogs.singleWhere(
        (record) => record.message.contains('event=requestCancelled '),
      );
      expect(stopped.level, Level.FINE);
      expect(stopped.message, contains('reason=consumer'));
    },
  );

  test('50001 trash entries use a separate bounded catalog budget', () async {
    final album = List.filled(20, 'family-album').join('/');
    final payload = GalleryTrashCatalog(
      entries: List.generate(
        50001,
        (index) => GalleryTrashEntry(
          trashId: 'trash-$index',
          name: 'photo-$index.jpg',
          originalPath: '$album/photo-$index.jpg',
          kind: GalleryEntryKind.image,
          sourceRevision: 'revision-$index',
          trashedAt: DateTime.utc(2026, 10, 29),
          sizeBytes: 1024,
        ),
      ),
    );
    final body = jsonEncode(payload.toJson());
    final repository = GalleryManagementRepository(
      baseUri: Uri.parse('http://frame.local'),
      code: 'code',
      client: MockClient((_) async => http.Response(body, 200)),
    );
    addTearDown(repository.close);
    final bytes = utf8.encode(body).length;
    expect(bytes, greaterThan(repository.maxJsonBytes));
    expect(bytes, lessThan(repository.maxTrashCatalogBytes));
    final result = await repository.trash();
    expect(result.entries, hasLength(50001));
    expect(result.entries.last.trashId, 'trash-50000');
    expect(result.entries.last.originalPath, '$album/photo-50000.jpg');
  });

  test(
    '50001 candidates in both duplicate modes fit the result budget',
    () async {
      final members = List.generate(
        50001,
        (index) => GalleryDuplicateMember(
          mediaId: 'media-$index',
          sourceRevision: 'revision-$index',
          path: '2026/10/family-albums/photo-$index.jpg',
          name: 'photo-$index.jpg',
          sizeBytes: 1024,
        ),
      );
      final job = GalleryDuplicateJob(
        jobId: 'large-completed-job',
        status: GalleryDuplicateStatus.completed,
        modes: GalleryDuplicateMode.values,
        groups: [
          for (final mode in GalleryDuplicateMode.values)
            GalleryDuplicateGroup(
              groupId: mode.name,
              mode: mode,
              items: members,
            ),
        ],
      );
      final body = jsonEncode(job.toJson());
      final repository = GalleryManagementRepository(
        baseUri: Uri.parse('http://frame.local'),
        code: 'code',
        client: MockClient((_) async => http.Response(body, 200)),
      );
      addTearDown(repository.close);
      final bytes = utf8.encode(body).length;
      expect(bytes, greaterThan(repository.maxJsonBytes));
      expect(bytes, lessThan(repository.maxDuplicateResultBytes));
      final result = await repository.duplicates();
      expect(result.groups, hasLength(2));
      expect(
        result.groups.every((group) => group.items.length == 50001),
        isTrue,
      );
      expect(result.groups.last.items.last.mediaId, 'media-50000');
    },
  );

  test('metadata URL encodes path segments and mutation preserves operation identity', () async {
    final requests = <http.Request>[];
    final repository = GalleryManagementRepository(
      baseUri: Uri.parse('http://frame.local'),
      code: 'секрет ?',
      client: MockClient((request) async {
        requests.add(request);
        if (request.method == 'GET') {
          return http.Response(jsonEncode(photoMetadata('a').toJson()), 200);
        }
        final data = jsonDecode(request.body) as Map<String, dynamic>;
        return http.Response(
          jsonEncode(
            GalleryOperationResult(
              operationId: data['operationId'] as String,
              items: const [
                GalleryOperationItemResult(
                  mediaId: 'a',
                  state: GalleryItemOperationState.succeeded,
                  trashId: 'trash-a',
                ),
              ],
            ).toJson(),
          ),
          200,
        );
      }),
    );
    addTearDown(repository.close);
    expect(
      (await repository.metadata(managedPhoto('a'))).camera,
      'Test camera',
    );
    expect(requests.first.url.pathSegments, [
      'cache',
      'секрет ?',
      'v2',
      'metadata',
      'a',
      '1',
    ]);
    const operation = GalleryOperationRequest(
      operationId: 'retry-id',
      action: GalleryMutation.trash,
      items: [GalleryMediaRef(mediaId: 'a', sourceRevision: '1')],
    );
    await repository.operate(operation);
    await repository.operate(operation);
    expect(requests[1].body, requests[2].body);
    expect(jsonDecode(requests.last.body)['items'], [
      {'mediaId': 'a', 'sourceRevision': '1'},
    ]);
  });

  test('simultaneous management requests have independent cancellation and close aborts work', () async {
    final client = ControlledClient();
    final repository = GalleryManagementRepository(
      baseUri: Uri.parse('http://frame.local'),
      code: 'code',
      client: client,
    );
    final cancel = Completer<void>();
    final details = repository.metadata(
      managedPhoto('a'),
      cancel: cancel.future,
    );
    final trash = repository.trash();
    final detailCheck = expectLater(
      details,
      throwsA(isA<http.RequestAbortedException>()),
    );
    final trashCheck = expectLater(
      trash,
      throwsA(isA<http.RequestAbortedException>()),
    );
    expect(client.requests.length, 2);
    cancel.complete();
    await detailCheck;
    expect(client.requests.first.aborted, isTrue);
    expect(client.requests.last.aborted, isFalse);
    repository.close();
    await trashCheck;
    expect(client.active, 0);
  });

  test(
    'closing a mutation owner aborts its wait without cancelling another owner',
    () async {
      final client = ControlledClient();
      final repository = GalleryManagementRepository(
        baseUri: Uri.parse('http://frame.local'),
        code: 'code',
        client: client,
      );
      addTearDown(repository.close);
      final cancel = Completer<void>();
      final mutation = repository.operate(
        const GalleryOperationRequest(
          operationId: 'same-intent-after-abort',
          action: GalleryMutation.trash,
          items: [GalleryMediaRef(mediaId: 'a', sourceRevision: '1')],
        ),
        cancel: cancel.future,
      );
      final metadata = repository.metadata(managedPhoto('b'));
      final mutationCheck = expectLater(
        mutation,
        throwsA(isA<http.RequestAbortedException>()),
      );
      final metadataCheck = expectLater(
        metadata,
        throwsA(isA<http.RequestAbortedException>()),
      );
      cancel.complete();
      await mutationCheck;
      expect(client.requests.first.aborted, isTrue);
      expect(client.requests.last.aborted, isFalse);
      repository.close();
      await metadataCheck;
      expect(client.active, 0);
    },
  );

  test(
    'large JSON and typed errors fail instead of returning empty results',
    () async {
      final oversized = GalleryManagementRepository(
        baseUri: Uri.parse('http://frame.local'),
        code: 'code',
        maxJsonBytes: 8,
        maxTrashCatalogBytes: 8,
        client: MockClient((_) async => http.Response('{"entries":[]}', 200)),
      );
      addTearDown(oversized.close);
      await expectLater(oversized.trash(), throwsFormatException);
      final unavailable = GalleryManagementRepository(
        baseUri: Uri.parse('http://frame.local'),
        code: 'code',
        client: MockClient(
          (_) async => http.Response('{"code":"unavailable"}', 503),
        ),
      );
      addTearDown(unavailable.close);
      await expectLater(
        unavailable.trash(),
        throwsA(
          isA<GalleryManagementException>().having(
            (e) => e.code,
            'code',
            GalleryErrorCode.unavailable,
          ),
        ),
      );
    },
  );
}
