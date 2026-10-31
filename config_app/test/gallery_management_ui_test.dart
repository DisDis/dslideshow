import 'dart:async';
import 'dart:convert';

import 'package:config_app/features/gallery/presentation/bloc/gallery_bloc.dart';
import 'package:config_app/features/gallery/presentation/widgets/gallery_widget.dart';
import 'package:config_app/features/gallery/presentation/widgets/image_grid_item.dart';
import 'package:config_app/features/gallery/presentation/pages/single_item_viewer_page.dart';
import 'package:config_app/features/gallery/presentation/pages/gallery_duplicates_page.dart';
import 'package:config_app/src/gallery/gallery_session.dart';
import 'package:config_app/src/gallery/gallery_repository.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'gallery_image_loader_test.dart' show ControlledClient;
import 'support/gallery_management_harness.dart';
import 'support/gallery_confirmation.dart';

Widget app(Widget child, {double? textScale}) => MaterialApp(
  locale: const Locale('en'),
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  builder: textScale == null
      ? null
      : (context, content) => MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(textScale)),
          child: content!,
        ),
  home: child,
);
Future<void> finish(WidgetTester tester, GallerySession session) async {
  await tester.pumpWidget(const SizedBox());
  await tester.pump();
  await tester.runAsync(session.close);
}

void main() {
  testWidgets('selection toolbar only offers trash and clear; metadata stays in viewer', (tester) async {
    tester.view.physicalSize = const Size(320, 720);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final catalog = ManagedCatalogRepository([managedPhoto('a'), managedPhoto('b')]);
    final transport = MockClient((_) async => http.Response('{}', 200));
    final session = managedSession(catalog, transport, ControlledClient());
    final bloc = GalleryBloc(
      initialState: LoadedGalleryState(items: catalog.items),
      client: GalleryTestClient(),
      session: session,
    );
    await tester.pumpWidget(app(BlocProvider.value(value: bloc, child: const GalleryWidget()), textScale: 1.5));
    await tester.pump();
    final trash = find.ancestor(of: find.text('Move to trash'), matching: find.bySubtype<TextButton>());
    final clear = find.widgetWithIcon(IconButton, Icons.close);
    final bar = find.byKey(const ValueKey('gallery-selection-bar'));
    final firstTile = find.byType(ImageGridItem).first;
    final barBounds = tester.getRect(bar);
    final tileBounds = tester.getRect(firstTile);
    expect(find.text('Move to trash'), findsOneWidget);
    expect(find.text('0 selected'), findsOneWidget);
    expect(tester.widget<TextButton>(trash).onPressed, isNull);
    expect(tester.widget<IconButton>(clear).onPressed, isNull);
    expect(find.text('Test camera'), findsNothing);
    await tester.longPress(find.byType(ImageGridItem).first);
    await tester.pump();
    expect(find.text('Move to trash'), findsOneWidget);
    expect(tester.widget<TextButton>(trash).onPressed, isNotNull);
    expect(tester.widget<IconButton>(clear).onPressed, isNotNull);
    expect(tester.getRect(bar), barBounds);
    expect(tester.getRect(firstTile), tileBounds);
    expect(find.byTooltip('Rotate left 90°'), findsNothing);
    expect(find.byTooltip('Media info'), findsNothing);
    await tester.tap(find.byIcon(Icons.close));
    await tester.pump();
    expect(find.text('Move to trash'), findsOneWidget);
    expect(find.text('0 selected'), findsOneWidget);
    expect(tester.widget<TextButton>(trash).onPressed, isNull);
    expect(tester.widget<IconButton>(clear).onPressed, isNull);
    expect(tester.getRect(bar), barBounds);
    expect(tester.getRect(firstTile), tileBounds);
    await finish(tester, session);
    await tester.runAsync(bloc.close);
    expect(tester.takeException(), isNull);
  });

  testWidgets('metadata is lazy and info does not hide viewer controls; rotation refreshes revision', (tester) async {
    final requests = <http.Request>[];
    final catalog = ManagedCatalogRepository([managedPhoto('a')]);
    final session = managedSession(
      catalog,
      MockClient((request) async {
        requests.add(request);
        final rotate = request.url.pathSegments.last == 'rotate';
        return http.Response(jsonEncode(photoMetadata('a', revision: rotate ? '2' : '1').toJson()), 200);
      }),
      ControlledClient(),
    );
    await tester.pumpWidget(
      app(SingleItemViewerPage(item: managedPhoto('a'), session: session, capabilities: catalog.capabilities)),
    );
    await tester.pump();
    expect(requests, isEmpty);
    await tester.tap(find.byIcon(Icons.info_outline));
    await tester.pump();
    await tester.pump();
    expect(requests.single.url.pathSegments, contains('metadata'));
    expect(find.text('Test camera'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back).hitTestable(), findsOneWidget);
    await tester.tap(find.byTooltip('Rotate right 90°'));
    await tester.pump();
    await tester.pump();
    expect(requests.length, 2);
    expect(jsonDecode(requests.last.body)['sourceRevision'], '1');
    expect(find.text('6000 × 4000'), findsOneWidget);
    await finish(tester, session);
    expect(tester.takeException(), isNull);
  });

  testWidgets('closing viewer cancels in-flight lazy metadata without updating another file', (tester) async {
    final client = ControlledClient();
    final catalog = ManagedCatalogRepository([managedPhoto('a')]);
    final session = managedSession(catalog, client, ControlledClient());
    await tester.pumpWidget(
      app(SingleItemViewerPage(item: managedPhoto('a'), session: session, capabilities: catalog.capabilities)),
    );
    await tester.tap(find.byIcon(Icons.info_outline));
    await tester.pump();
    expect(client.requests, hasLength(1));
    await tester.pumpWidget(const SizedBox());
    await tester.pump();
    expect(client.requests.single.aborted, isTrue);
    await tester.runAsync(session.close);
    expect(tester.takeException(), isNull);
  });

  testWidgets('duplicate search uses indeterminate elapsed wait, stops and disposes polling', (tester) async {
    var status = GalleryDuplicateStatus.idle;
    final requests = <http.Request>[];
    final catalog = ManagedCatalogRepository([managedPhoto('a'), managedPhoto('b')]);
    final session = managedSession(
      catalog,
      MockClient((request) async {
        requests.add(request);
        if (request.method == 'POST') {
          status = request.url.pathSegments.last == 'stop'
              ? GalleryDuplicateStatus.cancelled
              : GalleryDuplicateStatus.running;
        }
        return http.Response(
          jsonEncode(
            GalleryDuplicateJob(
              jobId: 'job',
              status: status,
              startedAt: DateTime.now(),
              modes: const [GalleryDuplicateMode.exact],
              groups: const [],
            ).toJson(),
          ),
          200,
        );
      }),
      ControlledClient(),
    );
    await tester.pumpWidget(
      app(
        Scaffold(
          body: GalleryDuplicatesPage(session: session, catalog: catalog.items, onRefresh: () async {}),
        ),
      ),
    );
    await tester.pump();
    await tester.pump();
    await tester.tap(find.text('New search'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 250));
    await tester.tap(
      find.descendant(of: find.byType(AlertDialog), matching: find.widgetWithText(FilledButton, 'Start search')),
    );
    await tester.pump();
    await tester.pump();
    expect(find.text('Searching…'), findsWidgets);
    expect(find.textContaining('Elapsed:'), findsOneWidget);
    expect(find.byType(LinearProgressIndicator), findsNothing);
    expect(requests.where((r) => r.method == 'POST'), hasLength(1));
    await tester.tap(find.text('Stop'));
    await tester.pump();
    await tester.pump();
    expect(find.text('Search stopped'), findsOneWidget);
    final before = requests.length;
    await finish(tester, session);
    await tester.pump(const Duration(seconds: 5));
    expect(requests.length, before);
    expect(tester.takeException(), isNull);
  });
  testWidgets('partial trash keeps failed selection and Undo restores successful files', (tester) async {
    final catalog = ManagedCatalogRepository([managedPhoto('a'), managedPhoto('b')]);
    final operations = <GalleryOperationRequest>[];
    final trash = GalleryEntry(
      section: GalleryMediaSection.trash,
      mediaId: 'trash-a',
      name: 'a.jpg',
      path: 'a.jpg',
      kind: GalleryEntryKind.image,
      sourceRevision: '1',
      fileChanged: DateTime(2026),
      sizeBytes: 1024,
    );
    final session = managedSession(
      catalog,
      MockClient((request) async {
        if (request.method == 'GET') {
          return http.Response(
            jsonEncode(GalleryCatalog(section: GalleryMediaSection.trash, entries: [trash]).toJson()),
            200,
          );
        }
        final data = GalleryOperationRequest.fromJson(jsonDecode(request.body) as Map<String, dynamic>);
        operations.add(data);
        if (data.action == GalleryMutation.trash) {
          catalog.items = [managedPhoto('b')];
          return http.Response(
            jsonEncode(
              GalleryOperationResult(
                operationId: data.operationId,
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
            ),
            200,
          );
        }
        catalog.items = [managedPhoto('a'), managedPhoto('b')];
        return http.Response(
          jsonEncode(
            GalleryOperationResult(
              operationId: data.operationId,
              items: const [
                GalleryOperationItemResult(
                  section: GalleryMediaSection.trash,
                  mediaId: 'trash-a',
                  state: GalleryItemOperationState.succeeded,
                  restoredPath: 'a.jpg',
                ),
              ],
            ).toJson(),
          ),
          200,
        );
      }),
      ControlledClient(),
    );
    final bloc = GalleryBloc(
      initialState: LoadedGalleryState(items: catalog.items),
      client: GalleryTestClient(),
      session: session,
    );
    await tester.pumpWidget(app(BlocProvider.value(value: bloc, child: const GalleryWidget())));
    await tester.pump();
    await tester.longPress(find.byType(ImageGridItem).first);
    await tester.pump();
    await tester.tap(find.byType(ImageGridItem).last);
    await tester.pump();
    await tester.tap(find.text('Move to trash'));
    await confirmTrashDialog(tester);
    await tester.pump();
    await tester.pump();
    expect(find.text('Some files could not be processed.'), findsOneWidget);
    expect(find.byType(ImageGridItem), findsOneWidget);
    expect(operations.single.items.map((item) => item.mediaId), ['a', 'b']);
    expect(find.text('Undo'), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 250));
    await tester.tap(find.text('Undo'));
    await tester.pump();
    await tester.pump();
    expect(operations.last.action, GalleryMutation.restore);
    expect(operations.last.items.single.mediaId, 'trash-a');
    expect(find.byType(ImageGridItem), findsNWidgets(2));
    await finish(tester, session);
    await tester.runAsync(bloc.close);
    expect(tester.takeException(), isNull);
  });

  testWidgets('trash viewer confirms permanent deletion and Cancel keeps the file', (tester) async {
    final catalog = ManagedCatalogRepository([]);
    final trash = GalleryEntry(
      section: GalleryMediaSection.trash,
      mediaId: 'trash-a',
      name: 'a.jpg',
      path: 'folder/a.jpg',
      kind: GalleryEntryKind.image,
      sourceRevision: '1',
      fileChanged: DateTime(2026),
      sizeBytes: 1024,
    );
    final operations = <GalleryOperationRequest>[];
    final session = managedSession(
      catalog,
      MockClient((request) async {
        final data = GalleryOperationRequest.fromJson(jsonDecode(request.body) as Map<String, dynamic>);
        operations.add(data);
        return http.Response(
          jsonEncode(
            GalleryOperationResult(
              operationId: data.operationId,
              items: const [
                GalleryOperationItemResult(
                  section: GalleryMediaSection.trash,
                  mediaId: 'trash-a',
                  state: GalleryItemOperationState.succeeded,
                ),
              ],
            ).toJson(),
          ),
          200,
        );
      }),
      ControlledClient(),
    );
    await tester.pumpWidget(
      app(
        Scaffold(
          body: Builder(
            builder: (context) => TextButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => SingleItemViewerPage(
                    item: session.management.mediaItem(trash, 'test'),
                    session: session,
                    entry: trash,
                    capabilities: catalog.capabilities,
                  ),
                ),
              ),
              child: const Text('Open'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Open'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));
    expect(find.byTooltip('Rotate right 90°'), findsNothing);
    await tester.tap(find.byTooltip('Delete permanently'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.textContaining('< 0.01 MB'), findsOneWidget);
    expect(find.byTooltip('Exact size: 1024 bytes'), findsOneWidget);
    expect(operations, isEmpty);
    await tester.tap(find.text('Cancel'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.byTooltip('Delete permanently'), findsOneWidget);
    expect(operations, isEmpty);
    await tester.tap(find.byTooltip('Delete permanently'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    await tester.tap(find.widgetWithText(FilledButton, 'Delete permanently'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));
    expect(operations.single.action, GalleryMutation.purge);
    expect(operations.single.items.single.mediaId, 'trash-a');
    expect(find.text('Open'), findsOneWidget);
    await finish(tester, session);
    expect(tester.takeException(), isNull);
  });

  testWidgets('comparison protects last keeper and clears selection after source revision changes', (tester) async {
    final catalog = ManagedCatalogRepository([managedPhoto('a'), managedPhoto('b')]);
    const job = GalleryDuplicateJob(
      jobId: 'job',
      status: GalleryDuplicateStatus.completed,
      modes: [GalleryDuplicateMode.exact],
      groups: [
        GalleryDuplicateGroup(
          groupId: 'exact-1',
          mode: GalleryDuplicateMode.exact,
          items: [
            GalleryDuplicateMember(
              section: GalleryMediaSection.published,
              mediaId: 'a',
              sourceRevision: '1',
              path: 'folder/a.jpg',
              name: 'a.jpg',
              sizeBytes: 1024,
            ),
            GalleryDuplicateMember(
              section: GalleryMediaSection.published,
              mediaId: 'b',
              sourceRevision: '1',
              path: 'folder/b.jpg',
              name: 'b.jpg',
              sizeBytes: 1024,
            ),
          ],
        ),
      ],
    );
    final session = managedSession(
      catalog,
      MockClient((request) async => duplicateResponse(request, job)),
      ControlledClient(),
    );
    var current = List<GalleryItem>.of(catalog.items);
    final updates = StreamController<List<GalleryItem>>.broadcast();
    addTearDown(updates.close);
    Widget screen() => app(
      Scaffold(
        body: GalleryDuplicatesPage(
          session: session,
          catalog: current,
          catalogUpdates: updates.stream,
          currentCatalog: () => current,
          onRefresh: () async {},
        ),
      ),
    );
    await tester.pumpWidget(screen());
    await tester.pump();
    await tester.pump();
    final b = find.ancestor(of: find.text('b.jpg'), matching: find.byType(Card));
    final a = find.ancestor(of: find.text('a.jpg'), matching: find.byType(Card));
    await tester.scrollUntilVisible(
      find.descendant(of: b, matching: find.byType(CheckboxListTile)),
      300,
      scrollable: find.byType(Scrollable).first,
      maxScrolls: 10,
    );
    await tester.pump();
    await tester.tap(find.descendant(of: b, matching: find.byType(CheckboxListTile)));
    await tester.pump();
    await tester.scrollUntilVisible(
      find.descendant(of: a, matching: find.byType(CheckboxListTile)),
      -300,
      scrollable: find.byType(Scrollable).first,
      maxScrolls: 10,
    );
    await tester.pump();
    await tester.tap(find.descendant(of: a, matching: find.byType(CheckboxListTile)));
    await tester.pump();
    expect(find.text('Keep at least one current file in each group.'), findsOneWidget);
    current = [managedPhoto('a'), managedPhoto('b', revision: '2')];
    updates.add(current);
    await tester.pump();
    await tester.scrollUntilVisible(find.text('b.jpg'), 150, scrollable: find.byType(Scrollable).first, maxScrolls: 10);
    expect(find.textContaining('A file has changed'), findsWidgets);
    final reviewButton = find.widgetWithText(FilledButton, 'Move to trash');
    await tester.scrollUntilVisible(reviewButton, -150, scrollable: find.byType(Scrollable).first, maxScrolls: 10);
    final review = tester.widget<FilledButton>(reviewButton);
    expect(review.onPressed, isNull);
    await finish(tester, session);
    expect(tester.takeException(), isNull);
  });
  testWidgets('confirmed rotation survives old refreshing snapshot and failed production catalog refresh', (
    tester,
  ) async {
    final catalog = ManagedCatalogRepository([managedPhoto('a')]);
    catalog.refreshGate = Completer<GalleryCatalogResult>();
    final images = ControlledClient();
    final session = managedSession(
      catalog,
      MockClient((request) async {
        final rotating = request.url.pathSegments.last == 'rotate';
        final metadata = photoMetadata('a', revision: rotating ? '2' : '1');
        return http.Response(
          jsonEncode((rotating ? metadata.copyWith(width: 4000, height: 6000) : metadata).toJson()),
          200,
        );
      }),
      images,
    );
    final bloc = GalleryBloc(
      initialState: LoadedGalleryState(items: catalog.items),
      client: GalleryTestClient(),
      session: session,
    );
    await tester.pumpWidget(
      app(
        SingleItemViewerPage(
          item: catalog.items.single,
          session: session,
          capabilities: catalog.capabilities,
          onChanged: bloc.refresh,
          itemUpdates: bloc.stream
              .where((state) => state is LoadedGalleryState)
              .map((state) => (state as LoadedGalleryState).items.single),
          currentItem: () => (bloc.state as LoadedGalleryState).items.single,
        ),
      ),
    );
    await tester.pump();
    await tester.tap(find.byIcon(Icons.info_outline));
    await tester.pump();
    await tester.pump();
    await tester.tap(find.byTooltip('Rotate right 90°'));
    await tester.pump();
    await tester.pump();
    expect((bloc.state as LoadedGalleryState).refreshing, isTrue);
    expect(images.requests.last.request.url.pathSegments.last, '2');
    expect(find.text('4000 × 6000'), findsOneWidget);
    catalog.refreshGate!.completeError(StateError('Refresh failed'));
    await tester.pump();
    await tester.pump();
    expect((bloc.state as LoadedGalleryState).refreshFailed, isTrue);
    expect(images.requests.last.request.url.pathSegments.last, '2');
    expect(find.text('4000 × 6000'), findsOneWidget);
    await finish(tester, session);
    await tester.runAsync(bloc.close);
    expect(tester.takeException(), isNull);
  });

  testWidgets('comparison 409 coalesces catalog recovery and disables stale decisions', (tester) async {
    final catalog = ManagedCatalogRepository([managedPhoto('a'), managedPhoto('b')]);
    const job = GalleryDuplicateJob(
      jobId: 'job',
      status: GalleryDuplicateStatus.completed,
      modes: [GalleryDuplicateMode.exact],
      groups: [
        GalleryDuplicateGroup(
          groupId: 'g',
          mode: GalleryDuplicateMode.exact,
          items: [
            GalleryDuplicateMember(
              section: GalleryMediaSection.published,
              mediaId: 'a',
              sourceRevision: '1',
              path: 'a.jpg',
              name: 'a.jpg',
              sizeBytes: 1024,
            ),
            GalleryDuplicateMember(
              section: GalleryMediaSection.published,
              mediaId: 'b',
              sourceRevision: '1',
              path: 'b.jpg',
              name: 'b.jpg',
              sizeBytes: 1024,
            ),
          ],
        ),
      ],
    );
    final images = ControlledClient();
    final session = managedSession(
      catalog,
      MockClient((request) async {
        if (request.url.pathSegments.contains('metadata')) {
          return http.Response(jsonEncode(photoMetadata(request.url.pathSegments[5]).toJson()), 200);
        }
        return duplicateResponse(request, job);
      }),
      images,
    );
    final recovery = Completer<void>();
    var refreshes = 0;
    var current = List<GalleryItem>.of(catalog.items);
    final updates = StreamController<List<GalleryItem>>.broadcast();
    addTearDown(updates.close);
    await tester.pumpWidget(
      app(
        Scaffold(
          body: GalleryDuplicatesPage(
            session: session,
            catalog: current,
            catalogUpdates: updates.stream,
            currentCatalog: () => current,
            onRefresh: () async {
              refreshes++;
              await recovery.future;
              current = [managedPhoto('a', revision: '2'), managedPhoto('b', revision: '2')];
              updates.add(current);
            },
          ),
        ),
      ),
    );
    await tester.pump();
    await tester.pump();
    expect(images.requests, hasLength(2));
    for (final pending in images.requests.toList()) {
      pending.respond(status: 409);
      pending.complete(const []);
    }
    await tester.pump();
    await tester.pump();
    expect(refreshes, 1);
    expect(find.textContaining('A file has changed'), findsWidgets);
    final buttons = tester.widgetList<CheckboxListTile>(find.byType(CheckboxListTile));
    expect(buttons.every((button) => button.onChanged == null), isTrue);
    recovery.complete();
    await tester.pump();
    await tester.pump();
    expect(images.requests, hasLength(2), reason: 'Old revision must not be retried');
    await finish(tester, session);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Undo restores after the gallery screen has been disposed', (tester) async {
    final catalog = ManagedCatalogRepository([managedPhoto('a')]);
    final operations = <GalleryMutation>[];
    final entry = GalleryEntry(
      section: GalleryMediaSection.trash,
      mediaId: 'trash-a',
      name: 'a.jpg',
      path: 'a.jpg',
      kind: GalleryEntryKind.image,
      sourceRevision: 'trash-rev',
      fileChanged: DateTime(2026),
      sizeBytes: 1024,
    );
    final session = managedSession(
      catalog,
      MockClient((request) async {
        if (request.method == 'GET') {
          return http.Response(
            jsonEncode(GalleryCatalog(section: GalleryMediaSection.trash, entries: [entry]).toJson()),
            200,
          );
        }
        final command = GalleryOperationRequest.fromJson(jsonDecode(request.body) as Map<String, dynamic>);
        operations.add(command.action);
        catalog.items = command.action == GalleryMutation.trash ? [] : [managedPhoto('a', revision: 'restored')];
        return http.Response(
          jsonEncode(
            GalleryOperationResult(
              operationId: command.operationId,
              items: [
                GalleryOperationItemResult(
                  mediaId: command.items.single.mediaId,
                  state: GalleryItemOperationState.succeeded,
                  section: command.items.single.section,
                  destination: command.action == GalleryMutation.trash
                      ? GalleryMediaRef(
                          mediaId: 'trash-a',
                          sourceRevision: "destination-revision",
                          section: GalleryMediaSection.trash,
                        )
                      : null,
                ),
              ],
            ).toJson(),
          ),
          200,
        );
      }),
      ControlledClient(),
    );
    final bloc = GalleryBloc(
      initialState: LoadedGalleryState(items: catalog.items),
      client: GalleryTestClient(),
      session: session,
    );
    await tester.pumpWidget(app(BlocProvider.value(value: bloc, child: const GalleryWidget())));
    await tester.pump();
    await tester.longPress(find.byType(ImageGridItem));
    await tester.pump();
    await tester.tap(find.text('Move to trash'));
    await confirmTrashDialog(tester);
    await tester.pump();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 250));
    await tester.pumpWidget(app(const Scaffold(body: Text('Away'))));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 250));
    await tester.tap(find.text('Undo'));
    await tester.pump();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    expect(operations, [GalleryMutation.trash, GalleryMutation.restore]);
    expect(find.text('Files restored'), findsOneWidget);
    expect(find.text('Could not complete the operation. Retry the same action.'), findsNothing);
    await finish(tester, session);
    await tester.runAsync(bloc.close);
    expect(tester.takeException(), isNull);
  });

  testWidgets('comparison requests brief metadata for the displayed list and labels date source', (tester) async {
    tester.view.physicalSize = const Size(1200, 1200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final catalog = ManagedCatalogRepository([managedPhoto('a'), managedPhoto('b'), managedPhoto('c')]);
    const job = GalleryDuplicateJob(
      jobId: 'job',
      status: GalleryDuplicateStatus.completed,
      modes: [GalleryDuplicateMode.exact],
      groups: [
        GalleryDuplicateGroup(
          groupId: 'g',
          mode: GalleryDuplicateMode.exact,
          items: [
            GalleryDuplicateMember(
              section: GalleryMediaSection.published,
              mediaId: 'a',
              sourceRevision: '1',
              path: 'a.jpg',
              name: 'a.jpg',
              sizeBytes: 1024,
            ),
            GalleryDuplicateMember(
              section: GalleryMediaSection.published,
              mediaId: 'b',
              sourceRevision: '1',
              path: 'b.jpg',
              name: 'b.jpg',
              sizeBytes: 1024,
            ),
            GalleryDuplicateMember(
              section: GalleryMediaSection.published,
              mediaId: 'c',
              sourceRevision: '1',
              path: 'c.jpg',
              name: 'c.jpg',
              sizeBytes: 1024,
            ),
          ],
        ),
      ],
    );
    final pending = <String, Completer<http.Response>>{};
    final session = managedSession(
      catalog,
      MockClient((request) async {
        if (request.url.pathSegments.contains('metadata')) {
          final id = request.url.pathSegments[5];
          final response = Completer<http.Response>();
          pending[id] = response;
          return response.future;
        }
        return duplicateResponse(request, job);
      }),
      ControlledClient(),
    );
    await tester.pumpWidget(
      app(
        Scaffold(
          body: GalleryDuplicatesPage(session: session, catalog: catalog.items, onRefresh: () async {}),
        ),
      ),
    );
    await tester.pump();
    await tester.pump();
    expect(pending.keys.toSet(), {'a', 'b', 'c'});
    pending['a']!.complete(
      http.Response(jsonEncode(photoMetadata('a').copyWith(dateTaken: '2026:07:18 09:42:00').toJson()), 200),
    );
    pending['b']!.complete(
      http.Response(jsonEncode(photoMetadata('b').copyWith(fileModified: DateTime.utc(2026, 7, 18)).toJson()), 200),
    );
    await tester.pump();
    await tester.pump();
    pending['c']!.complete(http.Response(jsonEncode(photoMetadata('c').toJson()), 200));
    await tester.pump();
    await tester.pump();
    expect(find.text('6000 × 4000'), findsNWidgets(3));
    expect(find.text('< 0.01 MB'), findsNWidgets(3));
    expect(find.byTooltip('Exact size: 1024 bytes'), findsNWidgets(3));
    expect(find.text('Date taken: 2026:07:18 09:42:00'), findsOneWidget);
    expect(find.textContaining('File modified:'), findsOneWidget);
    expect(pending, hasLength(3), reason: 'Only the currently displayed list requests file details');
    expect(find.text('Test camera'), findsNothing, reason: 'Full EXIF belongs to the single-media viewer');
    await finish(tester, session);
    expect(tester.takeException(), isNull);
  });
}
