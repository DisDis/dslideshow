import 'dart:async';
import 'dart:convert';

import 'package:config_app/features/gallery/presentation/bloc/gallery_bloc.dart';
import 'package:config_app/features/gallery/presentation/bloc/gallery_management_bloc.dart';
import 'package:config_app/features/gallery/presentation/bloc/gallery_mutation_confirmation.dart';
import 'package:config_app/features/gallery/presentation/widgets/gallery_widget.dart';
import 'package:config_app/features/theme/presentation/theme.dart';
import 'package:config_app/src/gallery/gallery_management_repository.dart';
import 'package:config_app/src/gallery/gallery_session.dart';
import 'package:config_app/src/gallery/media_image_loader.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'gallery_image_loader_test.dart' show ControlledClient;
import 'support/gallery_management_harness.dart';

/// Only the external catalog read is replaced. Mutations pass through the real
/// repository JSON transport, while the real Bloc owns batching and retry.
class _TrashRepository extends GalleryManagementRepository {
  _TrashRepository(this.entries, http.Client client)
    : super(
        baseUri: Uri.parse('http://frame.local'),
        code: 'code',
        client: client,
      );

  List<GalleryTrashEntry> entries;
  Completer<GalleryTrashCatalog>? loadGate;
  int reads = 0;

  @override
  Future<GalleryTrashCatalog> trash({Future<void>? cancel}) {
    reads++;
    return loadGate?.future ??
        Future.value(GalleryTrashCatalog(entries: List.of(entries)));
  }
}

class _Fixture {
  _Fixture._(this.repository, this.session, this.catalog);

  factory _Fixture(
    List<GalleryTrashEntry> entries, {
    FutureOr<http.Response> Function(http.Request)? onRequest,
  }) {
    final repository = _TrashRepository(
      entries,
      MockClient((request) async {
        if (onRequest == null) throw StateError('Unexpected mutation');
        return onRequest(request);
      }),
    );
    final catalogRepository = ManagedCatalogRepository([
      managedPhoto('library'),
    ]);
    final session = GallerySession(
      repository: catalogRepository,
      management: repository,
      loader: MediaImageLoader(client: ControlledClient()),
    );
    return _Fixture._(
      repository,
      session,
      GalleryBloc(
        initialState: LoadedGalleryState(items: catalogRepository.items),
        client: GalleryTestClient(),
        session: session,
      ),
    );
  }

  final _TrashRepository repository;
  final GallerySession session;
  final GalleryBloc catalog;
  GalleryManagementBloc? _management;
  GalleryManagementBloc get bloc =>
      _management ??= GalleryManagementBloc(catalogBloc: catalog);

  Future<void> close() async {
    await _management?.close();
    await catalog.close();
    await session.close();
  }
}

GalleryTrashEntry _entry(int index, {String? id}) => GalleryTrashEntry(
  trashId: id ?? 'trash-$index',
  name: 'original-$index.jpg',
  originalPath: 'album/original-$index.jpg',
  kind: GalleryEntryKind.image,
  sourceRevision: 'revision-$index',
  trashedAt: DateTime.utc(2026),
  sizeBytes: index + 1,
);

Future<GalleryManagementState> _wait(
  GalleryManagementBloc bloc,
  bool Function(GalleryManagementState) predicate,
) => predicate(bloc.state)
    ? Future.value(bloc.state)
    : bloc.stream
          .firstWhere(predicate)
          .timeout(
            const Duration(seconds: 5),
            onTimeout: () => throw TestFailure(
              'Unexpected gallery state: section=${bloc.state.section.name}, '
              'items=${bloc.state.items.length}, selected=${bloc.state.selectedIds.length}, '
              'busy=${bloc.state.busy}, loading=${bloc.state.trashLoading}, '
              'confirmation=${bloc.state.confirmation != null}, '
              'processed=${bloc.state.processedItems}, '
              'notice=${bloc.state.notice.name}, error=${bloc.state.error?.name}',
            ),
          );

Future<void> _openTrash(GalleryManagementBloc bloc) async {
  bloc.add(const GalleryManagementEvent.sectionChanged(GallerySection.trash));
  await _wait(
    bloc,
    (state) => state.isTrash && state.trash != null && !state.trashLoading,
  );
}

Future<GalleryMutationConfirmation> _clear(GalleryManagementBloc bloc) async {
  bloc.add(const GalleryManagementEvent.clearTrashRequested());
  return (await _wait(
    bloc,
    (state) => state.confirmation != null,
  )).confirmation!;
}

Future<void> _decide(
  GalleryManagementBloc bloc,
  GalleryMutationConfirmation confirmation,
  bool confirmed,
) async {
  bloc.add(
    GalleryManagementEvent.mutationDecision(
      confirmationId: confirmation.token,
      confirmed: confirmed,
    ),
  );
  await _wait(bloc, (state) => state.confirmation == null);
}

http.Response _result(GalleryOperationRequest request, {String? failed}) =>
    http.Response(
      jsonEncode(
        GalleryOperationResult(
          operationId: request.operationId,
          items: [
            for (final ref in request.items)
              GalleryOperationItemResult(
                mediaId: ref.mediaId,
                state: ref.mediaId == failed
                    ? GalleryItemOperationState.failed
                    : GalleryItemOperationState.succeeded,
                error: ref.mediaId == failed
                    ? GalleryErrorCode.forbidden
                    : null,
              ),
          ],
        ).toJson(),
      ),
      200,
      headers: {'content-type': 'application/json; charset=utf-8'},
    );

Widget _app(_Fixture fixture, {double textScale = 1}) => MaterialApp(
  theme: createLightTheme(),
  locale: const Locale('en'),
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  builder: (context, child) => MediaQuery(
    data: MediaQuery.of(context)
        .copyWith(textScaler: TextScaler.linear(textScale)),
    child: child!,
  ),
  home: BlocProvider.value(
    value: fixture.catalog,
    child: const GalleryWidget(),
  ),
);

Future<void> _pumpUntil(WidgetTester tester, bool Function() ready) async {
  var elapsed = Duration.zero;
  while (!ready() && elapsed < const Duration(seconds: 2)) {
    await tester.pump(const Duration(milliseconds: 16));
    elapsed += const Duration(milliseconds: 16);
  }
  expect(ready(), isTrue, reason: 'Gallery did not reach the expected state');
  await tester.pump();
}

void main() {
  test('Select all reuses the indexed trash snapshot and restore limits each batch to 50 refs', () async {
    final requests = <GalleryOperationRequest>[];
    late _Fixture fixture;
    fixture = _Fixture(
      List.generate(51, _entry),
      onRequest: (raw) {
        final request = GalleryOperationRequest.fromJson(
          jsonDecode(raw.body) as Map<String, dynamic>,
        );
        requests.add(request);
        final removed = request.items.map((ref) => ref.mediaId).toSet();
        fixture.repository.entries = fixture.repository.entries
            .where((entry) => !removed.contains(entry.trashId))
            .toList();
        return _result(request);
      },
    );
    addTearDown(fixture.close);
    final bloc = fixture.bloc;
    final librarySnapshot = bloc.state.snapshot;
    bloc.add(const GalleryManagementEvent.trashSelectionAllRequested());
    bloc.add(const GalleryManagementEvent.selectionCleared());
    await _openTrash(bloc);
    expect(librarySnapshot.items.single.mediaId, 'library');
    expect(bloc.state.selectedIds, isEmpty);
    final snapshot = bloc.state.snapshot;
    bloc.add(const GalleryManagementEvent.trashSelectionAllRequested());
    final selected = await _wait(
      bloc,
      (state) => state.selectedIds.length == 51,
    );
    expect(identical(selected.snapshot, snapshot), isTrue);
    expect(
      selected.selectedIds,
      containsAll([
        snapshot.items.first.selectionIdentity,
        snapshot.items.last.selectionIdentity,
      ]),
    );
    expect(selected.selectedTrashBytes, 51 * 52 ~/ 2);
    bloc.add(const GalleryManagementEvent.selectionCleared());
    final cleared = await _wait(bloc, (state) => state.selectedIds.isEmpty);
    expect(identical(cleared.snapshot, snapshot), isTrue);
    expect(fixture.repository.reads, 1);
    expect(requests, isEmpty);
    final restoring = fixture.repository.entries;
    bloc.add(const GalleryManagementEvent.trashSelectionAllRequested());
    await _wait(bloc, (state) => state.selectedIds.length == 51);
    bloc.add(
      const GalleryManagementEvent.mutationRequested(GalleryMutation.restore),
    );
    final done = await _wait(
      bloc,
      (state) => !state.busy && state.processedItems == 51,
    );
    expect(requests.length, greaterThan(1));
    for (final request in requests) {
      expect(request.action, GalleryMutation.restore);
      expect(request.items.length, inInclusiveRange(1, 50));
    }
    expect(
      {for (final request in requests) ...request.items},
      {
        for (final entry in restoring)
          GalleryMediaRef(
            mediaId: entry.trashId,
            sourceRevision: entry.sourceRevision,
          ),
      },
    );
    expect(done.succeededItems, 51);
    expect(done.notice, GalleryManagementNotice.restored);
  });

  test('Clear trash confirms the full frozen snapshot and batches UTF-8 JSON with partial results', () async {
    final longId = List.filled(33000, '猫').join();
    final originals = [
      for (var index = 0; index < 1001; index++)
        _entry(index, id: index < 3 ? '$index-$longId' : null),
    ];
    final failedId = originals.last.trashId;
    final requests = <GalleryOperationRequest>[];
    late _Fixture fixture;
    fixture = _Fixture(
      originals,
      onRequest: (raw) {
        expect(utf8.encode(raw.body).length, lessThanOrEqualTo(256 * 1024));
        final request = GalleryOperationRequest.fromJson(
          jsonDecode(raw.body) as Map<String, dynamic>,
        );
        expect(request.action, GalleryMutation.purge);
        expect(request.items.length, inInclusiveRange(1, 1000));
        requests.add(request);
        final removed = request.items.map((ref) => ref.mediaId).toSet()
          ..remove(failedId);
        fixture.repository.entries = fixture.repository.entries
            .where((entry) => !removed.contains(entry.trashId))
            .toList();
        return _result(request, failed: failedId);
      },
    );
    addTearDown(fixture.close);
    final bloc = fixture.bloc;
    await _openTrash(bloc);
    // Clear trash also works with no current selection.
    final first = await _clear(bloc);
    expect(first.scope, GalleryMutationScope.allTrash);
    expect(first.items, hasLength(1001));
    expect(first.names, originals.take(10).map((entry) => entry.name));
    expect(first.sizeBytes, 1001 * 1002 ~/ 2);
    await _decide(bloc, first, false);
    expect(requests, isEmpty);
    final confirmation = await _clear(bloc);
    final added = _entry(99999);
    fixture.repository.entries = [...originals, added];
    bloc.add(const GalleryManagementEvent.trashRequested());
    await _wait(
      bloc,
      (state) => state.items.length == 1002 && !state.trashLoading,
    );
    await _decide(bloc, confirmation, true);
    final done = await _wait(
      bloc,
      (state) => !state.busy && state.lastResult?.items.length == 1001,
    );
    expect(requests.length, greaterThan(1));
    final sent = [for (final request in requests) ...request.items];
    expect(sent.toSet(), {
      for (final entry in originals)
        GalleryMediaRef(
          mediaId: entry.trashId,
          sourceRevision: entry.sourceRevision,
        ),
    });
    expect(sent, hasLength(1001));
    expect(done.processedItems, 1001);
    expect(done.succeededItems, 1000);
    expect(done.failures.single.mediaId, failedId);
    expect(done.notice, GalleryManagementNotice.partialFailure);
    expect(done.selectedIds, {
      done.snapshot.byMediaId[failedId]!.selectionIdentity,
    });
    expect(fixture.repository.entries.map((entry) => entry.trashId).toSet(), {
      failedId,
      added.trashId,
    });
  });

  test('an unknown batch stops the tail, refreshes current trash and requires a new confirmation', () async {
    final originals = List.generate(2001, _entry);
    final added = _entry(99999);
    final requests = <GalleryOperationRequest>[];
    final failedId = originals.first.trashId;
    late _Fixture fixture;
    fixture = _Fixture(
      originals,
      onRequest: (raw) {
        final request = GalleryOperationRequest.fromJson(
          jsonDecode(raw.body) as Map<String, dynamic>,
        );
        requests.add(request);
        final failure = requests.length == 1 ? failedId : null;
        final removed = request.items
            .where((ref) => ref.mediaId != failure)
            .map((ref) => ref.mediaId)
            .toSet();
        fixture.repository.entries = fixture.repository.entries
            .where((entry) => !removed.contains(entry.trashId))
            .toList();
        if (requests.length == 2) {
          // Files moved while the response was lost; there is no server receipt.
          fixture.repository.entries.add(added);
          throw http.ClientException('Response lost');
        }
        return _result(request, failed: failure);
      },
    );
    addTearDown(fixture.close);
    final bloc = fixture.bloc;
    await _openTrash(bloc);
    await _decide(bloc, await _clear(bloc), true);
    final interrupted = await _wait(
      bloc,
      (state) =>
          !state.busy && state.notice == GalleryManagementNotice.unknownOutcome,
    );
    expect(requests, hasLength(2), reason: 'The unsubmitted tail must stop');
    expect(interrupted.pendingOperation, isNull);
    expect(interrupted.operationPlan, isNull);
    expect(interrupted.completedBatches, 1);
    expect(interrupted.processedItems, 1000);
    expect(interrupted.succeededItems, 999);
    expect(interrupted.failures.single.mediaId, failedId);
    expect(interrupted.lastResult!.items, hasLength(1000));
    expect(
      fixture.repository.reads,
      2,
      reason: 'Always reload after unknown transport outcomes',
    );
    final remainingIds = {failedId, originals.last.trashId, added.trashId};
    expect(interrupted.items.map((item) => item.mediaId).toSet(), remainingIds);

    // A later action starts from the new visible snapshot, including arrivals.
    var confirmation = await _clear(bloc);
    expect(confirmation.items.map((ref) => ref.mediaId).toSet(), remainingIds);
    await _decide(bloc, confirmation, false);
    expect(requests, hasLength(2));
    bloc.add(
      const GalleryManagementEvent.sectionChanged(GallerySection.library),
    );
    await _wait(bloc, (state) => !state.isTrash);
    await _openTrash(bloc);
    confirmation = await _clear(bloc);
    await _decide(bloc, confirmation, true);
    final done = await _wait(
      bloc,
      (state) => !state.busy && state.notice == GalleryManagementNotice.purged,
    );
    expect(requests, hasLength(3));
    expect(requests.last.items.map((ref) => ref.mediaId).toSet(), remainingIds);
    expect(
      requests.take(2).map((request) => request.operationId),
      isNot(contains(requests.last.operationId)),
    );
    expect(done.processedItems, 3);
    expect(done.succeededItems, 3);
    expect(done.failures, isEmpty);
    expect(fixture.repository.entries, isEmpty);
  });

  testWidgets(
    'trash-only bulk controls distinguish selection from Empty trash and disable while loading or empty',
    (tester) async {
      var posts = 0;
      final fixture = _Fixture(
        List.generate(3, _entry),
        onRequest: (_) {
          posts++;
          throw StateError('Cancelled confirmation must not send a mutation');
        },
      );
      addTearDown(fixture.close);
      final gate = Completer<GalleryTrashCatalog>();
      fixture.repository.loadGate = gate;
      await tester.pumpWidget(_app(fixture));
      final all = find.byKey(const ValueKey('gallery-select-all-trash'));
      final empty = find.byKey(const ValueKey('gallery-clear-trash'));
      expect(all, findsNothing);
      expect(empty, findsNothing);
      expect(find.text('Move to trash'), findsOneWidget);
      await tester.tap(find.text('Trash'));
      await tester.pump();
      final bloc = tester
          .element(find.byKey(const ValueKey('gallery-selection-bar')))
          .read<GalleryManagementBloc>();
      expect(tester.widget<TextButton>(all).onPressed, isNull);
      expect(tester.widget<TextButton>(empty).onPressed, isNull);
      fixture.repository.loadGate = null;
      gate.complete(GalleryTrashCatalog(entries: fixture.repository.entries));
      await _pumpUntil(
        tester,
        () => bloc.state.trash != null && !bloc.state.trashLoading,
      );
      expect(tester.widget<TextButton>(all).onPressed, isNotNull);
      expect(tester.widget<TextButton>(empty).onPressed, isNotNull);
      expect(find.text('Select all'), findsOneWidget);
      expect(find.text('Empty trash'), findsOneWidget);
      expect(find.text('Move to trash'), findsNothing);
      await tester.tap(all);
      await _pumpUntil(tester, () => bloc.state.selectedIds.length == 3);
      expect(tester.widget<TextButton>(all).onPressed, isNull);
      expect(find.text('3 selected'), findsOneWidget);
      await tester.tap(find.byTooltip('Clear selection'));
      await _pumpUntil(tester, () => bloc.state.selectedIds.isEmpty);
      expect(posts, 0);
      // This full-trash intent deliberately has no prerequisite selection.
      await tester.tap(empty);
      await tester.pump();
      final dialog = find.byType(AlertDialog);
      expect(dialog, findsOneWidget);
      expect(bloc.state.confirmation!.scope, GalleryMutationScope.allTrash);
      expect(bloc.state.confirmation!.items, hasLength(3));
      expect(
        find.text(
          'Files to delete: 3. Expected space freed: < 0.01 MB. They cannot be restored through the photo frame.',
        ),
        findsOneWidget,
      );
      await tester.tap(
        find.descendant(
          of: dialog,
          matching: find.widgetWithText(TextButton, 'Cancel'),
        ),
      );
      await _pumpUntil(
        tester,
        () => dialog.evaluate().isEmpty && bloc.state.confirmation == null,
      );
      expect(posts, 0);
      fixture.repository.entries = [];
      bloc.add(const GalleryManagementEvent.trashRequested());
      await _pumpUntil(
        tester,
        () => bloc.state.items.isEmpty && !bloc.state.trashLoading,
      );
      expect(tester.widget<TextButton>(all).onPressed, isNull);
      expect(tester.widget<TextButton>(empty).onPressed, isNull);
      await tester.tap(find.text('Media library'));
      await _pumpUntil(tester, () => !bloc.state.isTrash);
      expect(all, findsNothing);
      expect(empty, findsNothing);
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    '320px trash progress at text scale 1.5 keeps the grid fixed and bulk controls disabled',
    (tester) async {
      tester.view
        ..physicalSize = const Size(320, 1000)
        ..devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final gate = Completer<http.Response>();
      GalleryOperationRequest? pending;
      var posts = 0;
      late _Fixture fixture;
      fixture = _Fixture(
        List.generate(1001, _entry),
        onRequest: (raw) {
          final request = GalleryOperationRequest.fromJson(
            jsonDecode(raw.body) as Map<String, dynamic>,
          );
          posts++;
          final removed = request.items.map((ref) => ref.mediaId).toSet();
          fixture.repository.entries = fixture.repository.entries
              .where((entry) => !removed.contains(entry.trashId))
              .toList();
          if (posts == 1) return _result(request);
          pending = request;
          return gate.future;
        },
      );
      addTearDown(fixture.close);
      await tester.pumpWidget(_app(fixture, textScale: 1.5));
      await tester.tap(find.text('Trash'));
      await tester.pump();
      final bloc = tester
          .element(find.byKey(const ValueKey('gallery-selection-bar')))
          .read<GalleryManagementBloc>();
      await _pumpUntil(
        tester,
        () => bloc.state.trash != null && !bloc.state.trashLoading,
      );
      final viewport = find.byKey(const PageStorageKey('gallery-trash'));
      final before = tester.getTopLeft(viewport);
      await tester.tap(find.byKey(const ValueKey('gallery-clear-trash')));
      await tester.pump();
      final dialog = find.byType(AlertDialog);
      expect(dialog, findsOneWidget);
      await tester.tap(
        find.descendant(
          of: dialog,
          matching: find.widgetWithText(FilledButton, 'Delete permanently'),
        ),
      );
      await _pumpUntil(
        tester,
        () =>
            dialog.evaluate().isEmpty &&
            bloc.state.busy &&
            bloc.state.processedItems == 1000 &&
            pending != null,
      );
      expect(find.text('Processed 1000 of 1001'), findsOneWidget);
      final label = tester.getRect(find.text('Processed 1000 of 1001'));
      expect(label.left, greaterThanOrEqualTo(0));
      expect(label.right, lessThanOrEqualTo(320));
      expect(label.top, greaterThanOrEqualTo(0));
      expect(label.bottom, lessThan(before.dy));
      expect(tester.getTopLeft(viewport), before);
      for (final key in ['gallery-select-all-trash', 'gallery-clear-trash']) {
        expect(
          tester.widget<TextButton>(find.byKey(ValueKey(key))).onPressed,
          isNull,
        );
      }
      expect(
        tester
            .widget<ChoiceChip>(
              find.widgetWithText(ChoiceChip, 'Media library'),
            )
            .onSelected,
        isNull,
      );
      expect(tester.takeException(), isNull);
      gate.complete(_result(pending!));
      await _pumpUntil(
        tester,
        () =>
            !bloc.state.busy &&
            bloc.state.operationPlan == null &&
            bloc.state.processedItems == 1001,
      );
      expect(bloc.state.succeededItems, 1001);
      expect(tester.getTopLeft(viewport), before);
      expect(find.text('Processed 1000 of 1001'), findsNothing);
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
      expect(tester.takeException(), isNull);
    },
  );
}
