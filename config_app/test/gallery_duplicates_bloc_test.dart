import 'dart:async';
import 'dart:convert';

import 'package:config_app/features/gallery/presentation/bloc/gallery_duplicates_bloc.dart';
import 'package:config_app/features/gallery/domain/gallery_item.dart';
import 'package:config_app/features/gallery/presentation/bloc/gallery_comparison_metadata_bloc.dart';
import 'package:config_app/src/gallery/gallery_management_repository.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'gallery_image_loader_test.dart' show ControlledClient;
import 'support/gallery_management_harness.dart';

const _members = [
  GalleryDuplicateMember(
    mediaId: 'a',
    sourceRevision: '1',
    path: 'a.jpg',
    name: 'a.jpg',
    sizeBytes: 100,
  ),
  GalleryDuplicateMember(
    mediaId: 'b',
    sourceRevision: '1',
    path: 'b.jpg',
    name: 'b.jpg',
    sizeBytes: 100,
  ),
  GalleryDuplicateMember(
    mediaId: 'c',
    sourceRevision: '1',
    path: 'c.jpg',
    name: 'c.jpg',
    sizeBytes: 100,
  ),
];
const _job = GalleryDuplicateJob(
  jobId: 'job',
  status: GalleryDuplicateStatus.completed,
  groups: [
    GalleryDuplicateGroup(
      groupId: 'group',
      mode: GalleryDuplicateMode.exact,
      items: _members,
    ),
  ],
);

Future<void> _until(
  GalleryDuplicatesBloc bloc,
  bool Function(GalleryDuplicatesState) ready,
) async {
  if (ready(bloc.state)) return;
  await bloc.stream.firstWhere(ready).timeout(const Duration(seconds: 2));
}

GalleryManagementRepository _repository(http.Client client) =>
    GalleryManagementRepository(
      baseUri: Uri.parse('http://frame.local'),
      code: 'code',
      client: client,
    );

void main() {
  test('server advances past resolved groups; member pages contain at most ten and preserve choices', () async {
    final members = List.generate(
      12,
      (index) => GalleryDuplicateMember(
        mediaId: 'p$index',
        sourceRevision: '1',
        path: 'p$index.jpg',
        name: 'p$index.jpg',
        sizeBytes: 100,
      ),
    );
    final group = GalleryDuplicateGroup(
      groupId: 'many',
      mode: GalleryDuplicateMode.exact,
      items: members,
    );
    final job = _job.copyWith(groups: [_job.groups.first, group]);
    final requests = <int>[];
    final repository = _repository(
      MockClient((request) async {
        if (!request.url.pathSegments.contains('groups')) {
          return duplicateResponse(request, job);
        }
        final index = int.parse(request.url.pathSegments.last);
        requests.add(index);
        return http.Response(
          jsonEncode(
            GalleryDuplicateGroupPage(
              jobId: job.jobId,
              index: index < 2 ? 1 : 2,
              group: index < 2 ? group : null,
            ).toJson(),
          ),
          200,
        );
      }),
    );
    final bloc = GalleryDuplicatesBloc(
      repository: repository,
      catalog: List.generate(12, (index) => managedPhoto('p$index')),
      onRefresh: () async {},
    );
    addTearDown(() async {
      await bloc.close();
      repository.close();
    });
    await _until(
      bloc,
      (state) => state.group?.groupId == 'many' && !state.groupLoading,
    );
    expect(bloc.state.groupIndex, 1);
    expect(
      bloc.state.visibleMembers.map((item) => item.mediaId),
      List.generate(10, (index) => 'p$index'),
    );
    bloc.add(
      const GalleryDuplicatesEvent.decide(
        'many',
        'p1',
        GalleryDuplicateDecision.trash,
      ),
    );
    await _until(bloc, (state) => state.decisions.containsKey('p1'));
    bloc.add(const GalleryDuplicatesEvent.members(10));
    await _until(bloc, (state) => state.memberOffset == 10);
    expect(bloc.state.visibleMembers.map((item) => item.mediaId), [
      'p10',
      'p11',
    ]);
    expect(bloc.state.decisions['p1'], GalleryDuplicateDecision.trash);
    bloc.add(const GalleryDuplicatesEvent.skip());
    await _until(bloc, (state) => state.group == null && !state.groupLoading);
    expect(bloc.state.groupIndex, 2);
    expect(requests, [0, 2]);
    bloc.add(const GalleryDuplicatesEvent.review());
    await _until(
      bloc,
      (state) => state.effect?.notice == GalleryDuplicatesNotice.review,
    );
    expect(bloc.state.effect!.members.single.mediaId, 'p1');
    bloc.add(const GalleryDuplicatesEvent.skip());
    await _until(bloc, (state) => state.group != null && !state.groupLoading);
    expect(bloc.state.groupIndex, 1);
    expect(bloc.state.memberOffset, 0);
  });

  test('50001 media snapshot keeps decisions and stale/keeper checks correct at the end of the catalog', () async {
    final catalog = List.generate(50001, (index) => managedPhoto('p$index'));
    final members = [
      for (final item in catalog.skip(49998))
        GalleryDuplicateMember(
          mediaId: item.mediaId,
          sourceRevision: item.revision,
          path: item.title,
          name: item.title,
          sizeBytes: 100,
        ),
    ];
    final job = _job.copyWith(
      groups: [
        GalleryDuplicateGroup(
          groupId: 'large',
          mode: GalleryDuplicateMode.exact,
          items: members,
        ),
      ],
    );
    final snapshots = StreamController<List<GalleryItem>>();
    final repository = _repository(
      MockClient((request) async => duplicateResponse(request, job)),
    );
    final bloc = GalleryDuplicatesBloc(
      repository: repository,
      catalog: catalog,
      catalogUpdates: snapshots.stream,
      onRefresh: () async {},
    );
    addTearDown(() async {
      await bloc.close();
      await snapshots.close();
      repository.close();
    });
    await _until(bloc, (state) => !state.loading);
    expect(bloc.state.catalogById.length, 50001);
    final snapshot = bloc.state.catalogSnapshot;
    for (final member in members.skip(1)) {
      bloc.add(
        GalleryDuplicatesEvent.decide(
          'large',
          member.mediaId,
          GalleryDuplicateDecision.trash,
        ),
      );
      await _until(
        bloc,
        (state) => state.decisions.containsKey(member.mediaId),
      );
    }
    expect(
      identical(bloc.state.catalogSnapshot, snapshot),
      true,
      reason: 'Decisions must reuse the indexed catalog instead of rebuilding 50001 entries',
    );
    final next = [...catalog];
    next[50000] = managedPhoto('p50000', revision: '2');
    snapshots.add(next);
    await _until(bloc, (state) => state.catalogById['p50000']?.revision == '2');
    expect(bloc.state.decisions, {'p49999': GalleryDuplicateDecision.trash});
    expect(bloc.state.current(members.last), false);
    expect(bloc.state.item(members.first), same(catalog[49998]));
    bloc.add(
      const GalleryDuplicatesEvent.decide(
        'large',
        'p49998',
        GalleryDuplicateDecision.trash,
      ),
    );
    await _until(
      bloc,
      (state) => state.effect?.notice == GalleryDuplicatesNotice.keepOne,
    );
    expect(bloc.state.decisions.containsKey('p49998'), false);
  });

  test('duplicate decisions keep one file and invalidate only changed revisions with one refresh', () async {
    final snapshots = StreamController<List<GalleryItem>>();
    final refresh = Completer<void>();
    var refreshes = 0;
    final repository = _repository(
      MockClient((request) async => duplicateResponse(request, _job)),
    );
    final bloc = GalleryDuplicatesBloc(
      repository: repository,
      catalog: [managedPhoto('a'), managedPhoto('b'), managedPhoto('c')],
      catalogUpdates: snapshots.stream,
      onRefresh: () {
        refreshes++;
        return refresh.future;
      },
    );
    addTearDown(() async {
      refresh.complete();
      await bloc.close();
      await snapshots.close();
      repository.close();
    });
    await _until(bloc, (state) => !state.loading);
    bloc.add(
      const GalleryDuplicatesEvent.decide(
        'group',
        'b',
        GalleryDuplicateDecision.trash,
      ),
    );
    await _until(
      bloc,
      (state) => state.decisions['b'] == GalleryDuplicateDecision.trash,
    );
    bloc.add(
      const GalleryDuplicatesEvent.decide(
        'group',
        'c',
        GalleryDuplicateDecision.trash,
      ),
    );
    await _until(
      bloc,
      (state) => state.decisions['c'] == GalleryDuplicateDecision.trash,
    );
    bloc.add(
      const GalleryDuplicatesEvent.decide(
        'group',
        'a',
        GalleryDuplicateDecision.trash,
      ),
    );
    await _until(
      bloc,
      (state) => state.effect?.notice == GalleryDuplicatesNotice.keepOne,
    );
    expect(bloc.state.decisions.containsKey('a'), false);
    bloc.add(GalleryDuplicatesEvent.invalidate(_members[1]));
    bloc.add(GalleryDuplicatesEvent.invalidate(_members[2]));
    await _until(bloc, (state) => state.invalidated.length == 2);
    expect(refreshes, 1);
    expect(bloc.state.decisions, isEmpty);
    snapshots.add([
      managedPhoto('a', revision: '2'),
      managedPhoto('b'),
      managedPhoto('c'),
    ]);
    await _until(bloc, (state) => state.catalog.first.revision == '2');
    expect(bloc.state.current(_members.first), false);
  });

  test('an unknown mutation refreshes the catalog; a new intent keeps only failed decisions', () async {
    final calls = <GalleryOperationRequest>[];
    var refreshes = 0;
    final repository = _repository(
      MockClient((request) async {
        if (request.method == 'GET') {
          return duplicateResponse(request, _job);
        }
        final mutation = GalleryOperationRequest.fromJson(
          jsonDecode(request.body) as Map<String, dynamic>,
        );
        calls.add(mutation);
        if (calls.length == 1) throw http.ClientException('Response lost');
        return http.Response(
          jsonEncode(
            GalleryOperationResult(
              operationId: mutation.operationId,
              items: const [
                GalleryOperationItemResult(
                  mediaId: 'b',
                  state: GalleryItemOperationState.succeeded,
                  trashId: 'trash-b',
                ),
                GalleryOperationItemResult(
                  mediaId: 'c',
                  state: GalleryItemOperationState.failed,
                  error: GalleryErrorCode.forbidden,
                ),
              ],
            ).toJson(),
          ),
          200,
        );
      }),
    );
    final bloc = GalleryDuplicatesBloc(
      repository: repository,
      catalog: [managedPhoto('a'), managedPhoto('b'), managedPhoto('c')],
      onRefresh: () async => refreshes++,
    );
    addTearDown(() async {
      await bloc.close();
      repository.close();
    });
    await _until(bloc, (state) => !state.loading);
    for (final id in ['b', 'c']) {
      bloc.add(
        GalleryDuplicatesEvent.decide(
          'group',
          id,
          GalleryDuplicateDecision.trash,
        ),
      );
      await _until(
        bloc,
        (state) => state.decisions[id] == GalleryDuplicateDecision.trash,
      );
    }
    bloc.add(const GalleryDuplicatesEvent.review());
    await _until(
      bloc,
      (state) => state.effect?.notice == GalleryDuplicatesNotice.review,
    );
    final reviewed = bloc.state.effect!;
    bloc.add(GalleryDuplicatesEvent.apply(reviewed.jobId!, reviewed.members));
    await _until(
      bloc,
      (state) =>
          state.effect?.notice == GalleryDuplicatesNotice.actionFailed &&
          !state.busy,
    );
    expect(refreshes, 1);
    bloc.add(GalleryDuplicatesEvent.apply(reviewed.jobId!, reviewed.members));
    await _until(
      bloc,
      (state) =>
          state.effect?.notice == GalleryDuplicatesNotice.completed &&
          !state.busy,
    );
    expect(calls.map((request) => request.operationId).toSet(), hasLength(2));
    expect(refreshes, 2);
    expect(bloc.state.decisions, {'c': GalleryDuplicateDecision.trash});
    expect(
      bloc.state.effect!.result!.items.last.error,
      GalleryErrorCode.forbidden,
    );
  });

  test('close does not wait for an external refresh callback', () async {
    final entered = Completer<void>(), release = Completer<void>();
    final repository = _repository(
      MockClient((request) async => duplicateResponse(request, _job)),
    );
    final bloc = GalleryDuplicatesBloc(
      repository: repository,
      catalog: [managedPhoto('a'), managedPhoto('b'), managedPhoto('c')],
      onRefresh: () {
        entered.complete();
        return release.future;
      },
    );
    addTearDown(repository.close);
    await _until(bloc, (state) => !state.loading);
    bloc.add(GalleryDuplicatesEvent.invalidate(_members.first));
    await entered.future;
    await bloc.close().timeout(const Duration(seconds: 2));
    expect(bloc.isClosed, true);
    release.complete();
  });

  testWidgets('poll timer drives actual status and stops after close', (
    tester,
  ) async {
    var gets = 0;
    final repository = _repository(
      MockClient((_) async {
        gets++;
        return http.Response(
          jsonEncode(
            _job
                .copyWith(
                  status: GalleryDuplicateStatus.running,
                  startedAt: DateTime(2026),
                )
                .toJson(),
          ),
          200,
        );
      }),
    );
    final bloc = GalleryDuplicatesBloc(
      repository: repository,
      catalog: [],
      onRefresh: () async {},
      now: () => DateTime(2026, 1, 1, 0, 0, 5),
    );
    await tester.pump();
    expect(gets, 1);
    await tester.pump(const Duration(seconds: 1));
    expect(bloc.state.elapsedSeconds, 5);
    await tester.pump(const Duration(seconds: 1));
    expect(gets, 2);
    await tester.runAsync(
      () => bloc.close().timeout(const Duration(seconds: 2)),
    );
    await tester.pump(const Duration(seconds: 4));
    expect(gets, 2);
    repository.close();
  });

  testWidgets(
    'metadata owner cancels its request and ignores late completion on close',
    (tester) async {
      final transport = ControlledClient();
      final repository = _repository(transport);
      final bloc = GalleryComparisonMetadataBloc(
        repository: repository,
        item: managedPhoto('a'),
      );
      await tester.pump();
      expect(transport.requests.length, 1);
      await tester.runAsync(
        () => bloc.close().timeout(const Duration(seconds: 2)),
      );
      expect(transport.requests.single.aborted, true);
      expect(bloc.state.metadata, null);
      repository.close();
    },
  );

  test(
    'metadata 409 is a typed mismatch effect; no source data is accepted',
    () async {
      final repository = _repository(
        MockClient(
          (_) async => http.Response(
            jsonEncode(
              const GalleryErrorResponse(GalleryErrorCode.revisionMismatch)
                  .toJson(),
            ),
            409,
          ),
        ),
      );
      final bloc = GalleryComparisonMetadataBloc(
        repository: repository,
        item: managedPhoto('a'),
      );
      addTearDown(() async {
        await bloc.close();
        repository.close();
      });
      await bloc.stream
          .firstWhere((state) => state.revisionMismatch == 1)
          .timeout(const Duration(seconds: 2));
      expect(bloc.state.failed, true);
      expect(bloc.state.metadata, null);
    },
  );
}
