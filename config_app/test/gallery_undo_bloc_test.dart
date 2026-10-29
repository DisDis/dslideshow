import 'dart:async';
import 'dart:convert';

import 'package:config_app/features/gallery/presentation/bloc/gallery_undo_bloc.dart';
import 'package:config_app/src/gallery/gallery_management_repository.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

GalleryTrashEntry entry(String id) => GalleryTrashEntry(
  trashId: id,
  name: '$id.jpg',
  originalPath: '$id.jpg',
  kind: GalleryEntryKind.image,
  sourceRevision: 'revision-$id',
  trashedAt: DateTime.utc(2026, 10, 29),
  sizeBytes: 20,
);

http.Response restored(http.Request request) {
  final operation = GalleryOperationRequest.fromJson(
    jsonDecode(request.body) as Map<String, dynamic>,
  );
  return http.Response(
    jsonEncode(
      GalleryOperationResult(
        operationId: operation.operationId,
        items: operation.items
            .map(
              (item) => GalleryOperationItemResult(
                mediaId: item.mediaId,
                state: GalleryItemOperationState.succeeded,
                restoredPath: '${item.mediaId}.jpg',
              ),
            )
            .toList(),
      ).toJson(),
    ),
    200,
  );
}

void main() {
  test('undo reloads current entries after an unknown outcome and restores only the remaining IDs', () async {
    final requests = <http.Request>[];
    var attempts = 0;
    var entries = [entry('a'), entry('b')];
    final repository = GalleryManagementRepository(
      baseUri: Uri.parse('http://frame.local'),
      code: 'code',
      client: MockClient((request) async {
        requests.add(request);
        if (request.method == 'GET') {
          return http.Response(
            jsonEncode(GalleryTrashCatalog(entries: entries).toJson()),
            200,
          );
        }
        if (++attempts == 1) {
          entries = [entry('b')];
          throw http.ClientException('connection lost after restoring a');
        }
        return restored(request);
      }),
    );
    final bloc = GalleryUndoBloc(repository: repository, trashIds: ['a', 'b']);
    addTearDown(repository.close);
    addTearDown(bloc.close);

    await expectLater(bloc.restore(), throwsA(isA<http.ClientException>()));
    expect(bloc.state.phase, GalleryUndoPhase.failed);
    final result = await bloc.restore();
    expect(bloc.state.phase, GalleryUndoPhase.succeeded);
    expect(result.items.single.mediaId, 'b');
    expect(bloc.state.missingCount, 1);
    expect(requests.where((request) => request.method == 'GET'), hasLength(2));
    final posts = requests
        .where((request) => request.method == 'POST')
        .toList();
    final original = jsonDecode(posts[0].body) as Map<String, dynamic>;
    final body = jsonDecode(posts[1].body) as Map<String, dynamic>;
    expect(body['operationId'], isNot(original['operationId']));
    expect(body['items'], [
      {'mediaId': 'b', 'sourceRevision': 'revision-b'},
    ]);
    expect(body['action'], 'restore');
  });

  test('undo never posts an empty or replacement-path request after unknown files leave trash', () async {
    var reads = 0, posts = 0;
    final replacement = entry('replacement').copyWith(originalPath: 'a.jpg');
    final repository = GalleryManagementRepository(
      baseUri: Uri.parse('http://frame.local'),
      code: 'code',
      client: MockClient((request) async {
        if (request.method == 'GET') {
          return http.Response(
            jsonEncode(
              GalleryTrashCatalog(
                entries: ++reads == 1 ? [entry('a')] : [replacement],
              ).toJson(),
            ),
            200,
          );
        }
        posts++;
        throw http.ClientException('Unknown result');
      }),
    );
    final bloc = GalleryUndoBloc(repository: repository, trashIds: ['a']);
    addTearDown(repository.close);
    addTearDown(bloc.close);
    await expectLater(bloc.restore(), throwsA(isA<http.ClientException>()));
    final result = await bloc.restore();
    expect(reads, 2);
    expect(posts, 1);
    expect(result.items, isEmpty);
    expect(bloc.state.missingCount, 1);
    expect(bloc.state.phase, GalleryUndoPhase.succeeded);
  });

  test(
    'repeated undo shares pending work and close waits for its outcome',
    () async {
      final received = Completer<http.Request>();
      final response = Completer<http.Response>();
      final repository = GalleryManagementRepository(
        baseUri: Uri.parse('http://frame.local'),
        code: 'code',
        client: MockClient((request) async {
          if (request.method == 'GET') {
            return http.Response(
              jsonEncode(GalleryTrashCatalog(entries: [entry('a')]).toJson()),
              200,
            );
          }
          received.complete(request);
          return response.future;
        }),
      );
      final bloc = GalleryUndoBloc(repository: repository, trashIds: ['a']);
      addTearDown(repository.close);
      addTearDown(bloc.close);
      final operation = bloc.restore();
      expect(identical(operation, bloc.restore()), isTrue);
      final request = await received.future;
      var closed = false;
      final closing = bloc.close().then((_) => closed = true);
      expect(closed, isFalse);
      expect(bloc.state.phase, GalleryUndoPhase.restoring);
      response.complete(restored(request));
      expect(
        (await operation).items.single.state,
        GalleryItemOperationState.succeeded,
      );
      await closing;
      expect(closed, isTrue);
      expect(bloc.isClosed, isTrue);
      await expectLater(
        bloc.restore(),
        throwsA(
          isA<GalleryManagementException>().having(
            (error) => error.code,
            'code',
            GalleryErrorCode.cancelled,
          ),
        ),
      );
    },
  );
}
