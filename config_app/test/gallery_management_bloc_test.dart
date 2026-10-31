import 'dart:async';
import 'dart:convert';

import 'package:config_app/features/gallery/domain/gallery_item.dart';
import 'package:config_app/features/gallery/presentation/bloc/gallery_bloc.dart';
import 'package:config_app/features/gallery/presentation/bloc/gallery_management_bloc.dart';
import 'package:config_app/src/gallery/gallery_repository.dart';
import 'package:config_app/src/gallery/gallery_management_repository.dart';
import 'package:config_app/src/gallery/gallery_session.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:logging/logging.dart';

import 'gallery_image_loader_test.dart' show ControlledClient;
import 'support/gallery_management_harness.dart';
import 'support/gallery_confirmation.dart';

class _ReadOnlyCatalog extends ManagedCatalogRepository {
  _ReadOnlyCatalog(super.items);
  @override
  Set<GalleryCapability> get capabilities => const {};
}

void main() {
  late ManagedCatalogRepository catalog;
  late GallerySession session;
  late GalleryBloc catalogBloc;
  late GalleryManagementBloc management;

  void initialize(
    http.Client client, {
    ManagedCatalogRepository? repository,
    GalleryManagementRepository? managementRepository,
  }) {
    catalog = repository ?? ManagedCatalogRepository([managedPhoto('a'), managedPhoto('b')]);
    session = managedSession(catalog, client, ControlledClient());
    catalogBloc = GalleryBloc(
      initialState: LoadedGalleryState(items: catalog.items),
      client: GalleryTestClient(),
      session: session,
    );
    management = GalleryManagementBloc(catalogBloc: catalogBloc, repository: managementRepository);
    if (managementRepository != null) addTearDown(managementRepository.close);
    addTearDown(() async {
      await management.close();
      await catalogBloc.close();
      await session.close();
    });
  }

  Future<GalleryManagementState> waitFor(bool Function(GalleryManagementState) predicate) {
    if (predicate(management.state)) return Future.value(management.state);
    return management.stream.firstWhere(predicate);
  }

  Future<void> select(List<String> ids) async {
    for (final id in ids) {
      final item = management.state.items.firstWhere((item) => item.mediaId == id);
      management.add(GalleryManagementEvent.selectionToggled(item.selectionIdentity));
    }
    await waitFor((state) => state.selectedIds.length == ids.length);
  }

  http.Response response(Object data) =>
      http.Response(jsonEncode(data), 200, headers: {'content-type': 'application/json'});

  test('selection ignores directories and section changes clear selection while loading trash', () async {
    final trash = GalleryEntry(
      section: GalleryMediaSection.trash,
      mediaId: 'trash-a',
      name: 'a.jpg',
      path: 'album/a.jpg',
      kind: GalleryEntryKind.image,
      sourceRevision: 'trash-revision',
      fileChanged: DateTime.utc(2026),
      sizeBytes: 1024,
    );
    initialize(
      MockClient(
        (request) async => response(GalleryCatalog(section: GalleryMediaSection.trash, entries: [trash]).toJson()),
      ),
      repository: ManagedCatalogRepository([
        GalleryItem(
          uri: Uri.parse('http://frame.local/folder'),
          title: 'folder',
          mediaId: 'directory',
          kind: GalleryEntryKind.directory,
        ),
        managedPhoto('a'),
      ]),
    );
    management.add(GalleryManagementEvent.selectionToggled(management.state.items.first.selectionIdentity));
    await select(['a']);
    expect(management.state.selectedIds, {managedPhoto('a').selectionIdentity});
    management.add(const GalleryManagementEvent.sectionChanged(GallerySection.trash));
    final loaded = await waitFor((state) => state.isTrash && !state.trashLoading && state.trash != null);
    expect(loaded.selectedIds, isEmpty);
    expect(loaded.items.single.mediaId, 'trash-a');
    expect(loaded.items.single.uri.pathSegments, [
      'cache',
      'code',
      'v2',
      'trash',
      'original',
      'trash-a',
      'trash-revision',
    ]);
    expect(loaded.selectedMediaBytes, 0);
    await select(['trash-a']);
    expect(management.state.selectedMediaBytes, 1024);
    management.add(const GalleryManagementEvent.sectionChanged(GallerySection.published));
    await waitFor((state) => state.section == GallerySection.published);
    expect(management.state.selectedIds, isEmpty);
    expect(management.state.items.map((item) => item.mediaId), ['directory', 'a']);
  });

  test('partial mutation keeps only failed refs selected and emits Undo once across refresh', () async {
    final requests = <GalleryOperationRequest>[];
    initialize(
      MockClient((request) async {
        final command = GalleryOperationRequest.fromJson(jsonDecode(request.body) as Map<String, dynamic>);
        requests.add(command);
        catalog.items = [managedPhoto('b')];
        return response(
          GalleryOperationResult(
            operationId: command.operationId,
            items: const [
              GalleryOperationItemResult(
                section: GalleryMediaSection.published,
                mediaId: 'a',
                state: GalleryItemOperationState.succeeded,
                destination: GalleryMediaRef(
                  mediaId: 'trash-a',
                  sourceRevision: "destination-revision",
                  section: GalleryMediaSection.trash,
                ),
              ),
              GalleryOperationItemResult(
                section: GalleryMediaSection.published,
                mediaId: 'b',
                state: GalleryItemOperationState.failed,
                error: GalleryErrorCode.forbidden,
              ),
            ],
          ).toJson(),
        );
      }),
    );
    await select(['a', 'b']);
    management.add(const GalleryManagementEvent.mutationRequested(GalleryMutation.trash));
    await confirmManagementMutation(management, GalleryMutation.trash);
    final completed = await waitFor((state) => !state.busy && state.lastResult != null);
    expect(requests.single.items.map((item) => item.mediaId), ['a', 'b']);
    expect(completed.selectedIds, {managedPhoto('b').selectionIdentity});
    expect(completed.failures.single.error, GalleryErrorCode.forbidden);
    expect(completed.undoMediaIds, ['trash-a']);
    expect(completed.notice, GalleryManagementNotice.trashed);
    expect(completed.pendingOperation, isNull);
    final serial = completed.noticeSerial;
    await management.refresh();
    expect(management.state.noticeSerial, serial);
    expect(management.state.items.single.mediaId, 'b');
  });

  test('an unknown transport result refreshes the catalog and the next action uses a fresh snapshot', () async {
    final requests = <GalleryOperationRequest>[];
    final failedRefresh = Completer<GalleryCatalogResult>();
    initialize(
      MockClient((request) async {
        final command = GalleryOperationRequest.fromJson(jsonDecode(request.body) as Map<String, dynamic>);
        requests.add(command);
        if (requests.length == 1) {
          catalog.items = [managedPhoto('b')];
          catalog.refreshGate = failedRefresh;
          throw http.ClientException('Disconnected after mutation');
        }
        catalog.items = [];
        return response(
          GalleryOperationResult(
            operationId: command.operationId,
            items: const [
              GalleryOperationItemResult(
                section: GalleryMediaSection.published,
                mediaId: 'b',
                state: GalleryItemOperationState.succeeded,
                destination: GalleryMediaRef(
                  mediaId: 'trash-b',
                  sourceRevision: "destination-revision",
                  section: GalleryMediaSection.trash,
                ),
              ),
            ],
          ).toJson(),
        );
      }),
    );
    await select(['a']);
    final refreshing = catalogBloc.stream.firstWhere((state) => state is LoadedGalleryState && state.refreshing);
    management.add(const GalleryManagementEvent.mutationRequested(GalleryMutation.trash));
    await confirmManagementMutation(management, GalleryMutation.trash);
    await refreshing;
    failedRefresh.completeError(http.ClientException('Catalog offline'));
    final failed = await waitFor((state) => !state.busy && state.notice == GalleryManagementNotice.unknownOutcome);
    expect(failed.pendingOperation, isNull);
    expect(failed.operationPlan, isNull);
    expect(failed.needsMutationRefresh, isTrue);
    management.add(const GalleryManagementEvent.mutationRequested(GalleryMutation.trash));
    management.add(const GalleryManagementEvent.selectionCleared());
    await waitFor((state) => state.selectedIds.isEmpty);
    expect(management.state.confirmation, isNull);
    expect(requests, hasLength(1));
    catalog.refreshGate = null;
    await management.refresh();
    expect(management.state.needsMutationRefresh, isFalse);
    expect(management.state.items.map((item) => item.mediaId), ['b']);
    await select(['b']);
    management.add(const GalleryManagementEvent.mutationRequested(GalleryMutation.trash));
    await confirmManagementMutation(management, GalleryMutation.trash);
    await waitFor((state) => !state.busy && state.lastResult != null);
    expect(requests, hasLength(2));
    expect(requests[1].operationId, isNot(requests[0].operationId));
    expect(requests[1].items.single.mediaId, 'b');
  });

  test('confirmed per-file failures clear the old intent so a later retry gets a new ID', () async {
    final requests = <GalleryOperationRequest>[];
    initialize(
      MockClient((request) async {
        final command = GalleryOperationRequest.fromJson(jsonDecode(request.body) as Map<String, dynamic>);
        requests.add(command);
        return response(
          GalleryOperationResult(
            operationId: command.operationId,
            items: const [
              GalleryOperationItemResult(
                section: GalleryMediaSection.published,
                mediaId: 'a',
                state: GalleryItemOperationState.failed,
                error: GalleryErrorCode.forbidden,
              ),
            ],
          ).toJson(),
        );
      }),
    );
    await select(['a']);
    management.add(const GalleryManagementEvent.mutationRequested(GalleryMutation.trash));
    await confirmManagementMutation(management, GalleryMutation.trash);
    await waitFor((state) => !state.busy && state.noticeSerial == 1);
    expect(management.state.pendingOperation, isNull);
    management.add(const GalleryManagementEvent.mutationRequested(GalleryMutation.trash));
    await confirmManagementMutation(management, GalleryMutation.trash);
    await waitFor((state) => !state.busy && state.noticeSerial == 2);
    expect(requests[1].operationId, isNot(requests[0].operationId));
    expect(management.state.selectedIds, {managedPhoto('a').selectionIdentity});
  });

  test('real mutation logs correlate partial results and retries without leaking private media or errors', () async {
    const auth = 'AUTH-SECRET-4321';
    const privatePath = 'private-photo.jpg';
    const rawExif = 'GPS-EXIF-SECRET';
    const uri = 'https://frame.local/cache/$auth/get/$privatePath';
    final records = <LogRecord>[];
    final oldLevel = Logger.root.level;
    Logger.root.level = Level.ALL;
    final subscription = Logger.root.onRecord.listen(records.add);
    addTearDown(() async {
      await subscription.cancel();
      Logger.root.level = oldLevel;
    });
    final requests = <GalleryOperationRequest>[];
    final client = MockClient((request) async {
      if (request.method == 'GET') {
        return response(photoMetadata('a').copyWith(path: privatePath, camera: rawExif, latitude: 12.3456).toJson());
      }
      final command = GalleryOperationRequest.fromJson(jsonDecode(request.body) as Map<String, dynamic>);
      requests.add(command);
      if (requests.length == 2) {
        throw http.ClientException('$uri $rawExif', request.url);
      }
      catalog.items = requests.length == 1 ? [managedPhoto('b')] : [];
      return response(
        GalleryOperationResult(
          operationId: command.operationId,
          items: [
            if (requests.length == 1)
              const GalleryOperationItemResult(
                section: GalleryMediaSection.published,
                mediaId: 'a',
                state: GalleryItemOperationState.succeeded,
                destination: GalleryMediaRef(
                  mediaId: 'trash-a',
                  sourceRevision: "destination-revision",
                  section: GalleryMediaSection.trash,
                ),
              ),
            GalleryOperationItemResult(
              section: GalleryMediaSection.published,
              mediaId: 'b',
              state: requests.length == 1 ? GalleryItemOperationState.failed : GalleryItemOperationState.succeeded,
              error: requests.length == 1 ? GalleryErrorCode.forbidden : null,
              destination: requests.length == 1
                  ? null
                  : GalleryMediaRef(
                      mediaId: 'trash-b',
                      sourceRevision: "destination-revision",
                      section: GalleryMediaSection.trash,
                    ),
            ),
          ],
        ).toJson(),
      );
    });
    final repository = GalleryManagementRepository(
      baseUri: Uri.parse('https://frame.local'),
      code: auth,
      client: client,
    );
    initialize(MockClient((_) async => response({})), managementRepository: repository);
    await repository.metadata(managedPhoto('a'));
    await repository.metadata(managedPhoto('a'));
    await select(['a', 'b']);
    for (var serial = 1; serial <= 3; serial++) {
      management.add(const GalleryManagementEvent.mutationRequested(GalleryMutation.trash));
      await confirmManagementMutation(management, GalleryMutation.trash);
      await waitFor((state) => !state.busy && state.noticeSerial == serial);
    }
    expect(requests[2].operationId, isNot(requests[1].operationId));
    final logs = records.where((record) => record.loggerName.startsWith('Gallery')).toList();
    final messages = logs.map((record) => record.message).join('\n');
    final managementLogs = logs.where((record) => record.loggerName == 'GalleryManagementBloc').toList();
    for (final event in ['mutationStarted', 'mutationPartial', 'mutationFailed', 'mutationCompleted']) {
      expect(managementLogs.any((record) => record.message.contains('event=$event ')), isTrue, reason: event);
    }
    final partial = managementLogs.singleWhere((record) => record.message.contains('event=mutationPartial '));
    expect(partial.level, Level.WARNING);
    expect(partial.message, contains('items=2 succeeded=1 failed=1'));
    expect(partial.message, contains('codes=forbidden'));
    final completed = managementLogs.singleWhere((record) => record.message.contains('event=mutationCompleted '));
    expect(completed.level, Level.INFO);
    expect(completed.message, contains('items=1 succeeded=1 failed=0'));
    expect(messages, isNot(contains('retry=true')));
    expect(messages, isNot(contains('elapsedMs=')));
    expect(messages, isNot(contains('operationId=')));
    for (final request in requests) {
      expect(messages, isNot(contains(request.operationId)));
    }
    expect(
      logs.any((record) => record.level == Level.FINE && record.message.contains('event=metadataCacheHit ')),
      isTrue,
    );
    for (final secret in [auth, privatePath, rawExif, uri, '12.3456', 'a.jpg', 'b.jpg']) {
      expect(messages, isNot(contains(secret)), reason: 'Sensitive values must not be logged: $secret');
    }
    expect(logs.every((record) => record.error == null && record.stackTrace == null), isTrue);
  });

  test('close cancels an in-flight mutation without closing shared Undo transport', () async {
    final client = ControlledClient();
    initialize(client);
    await select(['a']);
    management.add(const GalleryManagementEvent.mutationRequested(GalleryMutation.trash));
    await confirmManagementMutation(management, GalleryMutation.trash);
    await waitFor((state) => state.busy);
    expect(client.requests, hasLength(1));
    await management.close();
    expect(client.requests.first.aborted, isTrue);
    expect(client.closed, isFalse);
    final trash = session.management.catalog(GalleryMediaSection.trash);
    expect(client.requests, hasLength(2));
    client.requests.last.respond();
    client.requests.last.complete(utf8.encode("{\"entries\":[],\"section\":\"trash\"}"));
    expect((await trash).entries, isEmpty);
    await management.refresh();
    expect(management.isClosed, isTrue);
  });

  test('close releases pending refresh completion and ignores later catalog delivery', () async {
    initialize(MockClient((_) async => response({'section': 'published', 'entries': []})));
    final gate = catalog.refreshGate = Completer<GalleryCatalogResult>();
    final refreshing = catalogBloc.stream.firstWhere((state) => state is LoadedGalleryState && state.refreshing);
    final refresh = management.refresh();
    await refreshing;
    await management.close();
    await refresh;
    gate.complete(GalleryCatalogResult([managedPhoto('new')], GalleryProtocol.versioned, 'new'));
    await catalogBloc.stream.firstWhere((state) => state is LoadedGalleryState && !state.refreshing);
    expect(management.state.items.map((item) => item.mediaId), ['a', 'b']);
  });

  test('read-only backend capabilities refuse mutation commands', () async {
    var calls = 0;
    initialize(
      MockClient((_) async {
        calls++;
        return response({});
      }),
      repository: _ReadOnlyCatalog([managedPhoto('a')]),
    );
    await select(['a']);
    management.add(const GalleryManagementEvent.mutationRequested(GalleryMutation.trash));
    await management.refresh();
    expect(calls, 0);
    expect(management.state.pendingOperation, isNull);
    expect(management.state.confirmation, isNull);
    expect(management.state.selectedIds, {managedPhoto('a').selectionIdentity});
  });
  test(
    '50001 media keep one indexed snapshot across selection and preserve valid refs through partial trash',
    () async {
      final originals = List.generate(50001, (index) => managedPhoto('media-$index'));
      final first = originals.first;
      final last = originals.last;
      initialize(
        MockClient((request) async {
          final command = GalleryOperationRequest.fromJson(jsonDecode(request.body) as Map<String, dynamic>);
          expect(command.items.map((item) => item.mediaId).toSet(), {first.mediaId, last.mediaId});
          catalog.items = catalog.items.where((item) => item.mediaId != first.mediaId).toList();
          return response(
            GalleryOperationResult(
              operationId: command.operationId,
              items: [
                GalleryOperationItemResult(
                  section: first.section,
                  mediaId: first.mediaId,
                  state: GalleryItemOperationState.succeeded,
                  destination: GalleryMediaRef(
                    mediaId: 'trash-first',
                    sourceRevision: "destination-revision",
                    section: GalleryMediaSection.trash,
                  ),
                ),
                GalleryOperationItemResult(
                  section: last.section,
                  mediaId: last.mediaId,
                  state: GalleryItemOperationState.failed,
                  error: GalleryErrorCode.forbidden,
                ),
              ],
            ).toJson(),
          );
        }),
        repository: ManagedCatalogRepository(originals),
      );
      final originalSnapshot = management.state.snapshot;
      management.add(GalleryManagementEvent.selectionToggled(first.selectionIdentity));
      management.add(GalleryManagementEvent.selectionToggled(last.selectionIdentity));
      await waitFor((state) => state.selectedIds.length == 2);
      expect(
        management.state.snapshot,
        same(originalSnapshot),
        reason: 'Selection must reuse the existing index, not copy or compare 50001 items',
      );
      expect(management.state.selectedItems.map((item) => item.mediaId).toSet(), {first.mediaId, last.mediaId});
      expect(management.currentItem(last.mediaId), same(last));

      catalog.items = List.of(originals);
      catalog.items[25000] = managedPhoto('media-25000', revision: '2');
      final lastUpdate = management.itemUpdates(last.mediaId).first;
      await management.refresh();
      expect(await lastUpdate, same(last));
      expect(management.state.items, hasLength(50001));
      expect(management.state.selectedIds, {first.selectionIdentity, last.selectionIdentity});
      expect(management.currentItem('media-25000')!.revision, '2');
      expect(management.state.snapshot, isNot(same(originalSnapshot)));

      management.add(const GalleryManagementEvent.mutationRequested(GalleryMutation.trash));
      await confirmManagementMutation(management, GalleryMutation.trash);
      final result = await waitFor((state) => !state.busy && state.lastResult != null);
      expect(result.items, hasLength(50000));
      expect(result.selectedItems.single.mediaId, last.mediaId);
      expect(result.failures.single.mediaId, last.mediaId);
      expect(result.undoMediaIds, ['trash-first']);
      expect(management.currentItem(first.mediaId), isNull);

      catalog.items = [
        for (final item in catalog.items)
          if (item.mediaId == last.mediaId) managedPhoto(last.mediaId, revision: '3') else item,
      ];
      await management.refresh();
      expect(
        management.state.selectedIds,
        isEmpty,
        reason: 'An unchanged large catalog cannot preserve a selected stale revision',
      );
      expect(management.currentItem(last.mediaId)!.revision, '3');
    },
  );
}
