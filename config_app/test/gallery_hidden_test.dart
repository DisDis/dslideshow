import 'dart:convert';

import 'package:config_app/features/gallery/presentation/bloc/gallery_bloc.dart';
import 'package:config_app/features/gallery/presentation/bloc/gallery_management_bloc.dart';
import 'package:config_app/features/gallery/presentation/bloc/gallery_undo_bloc.dart';
import 'package:config_app/features/gallery/presentation/bloc/gallery_viewer_bloc.dart';
import 'package:config_app/features/gallery/presentation/pages/single_item_viewer_page.dart';
import 'package:config_app/features/gallery/presentation/widgets/gallery_widget.dart';
import 'package:config_app/features/gallery/presentation/widgets/image_grid_item.dart';
import 'package:config_app/src/gallery/gallery_management_repository.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:logging/logging.dart';

import 'gallery_image_loader_test.dart' show ControlledClient;
import 'support/gallery_confirmation.dart';
import 'support/gallery_management_harness.dart';

class _HiddenCatalog extends ManagedCatalogRepository {
  _HiddenCatalog(super.items);
  @override
  Set<GalleryCapability> get capabilities => {...super.capabilities, GalleryCapability.hidden};
}

final _entry = GalleryEntry(
  section: GalleryMediaSection.hidden,
  mediaId: 'hidden-photo',
  name: 'photo.jpg',
  path: 'yandex.drive.123/Camera/photo.jpg',
  kind: GalleryEntryKind.image,
  sourceRevision: 'hidden-revision',
  fileChanged: DateTime.utc(2026, 10, 31),
  sizeBytes: 1024,
);

http.Response _response(Map<String, dynamic> data) => http.Response(jsonEncode(data), 200);

void main() {
  test('closing a hidden catalog request cancels the transport and logs cancellation without a failure', () async {
    final records = <LogRecord>[];
    final previousLevel = Logger.root.level;
    Logger.root.level = Level.ALL;
    final subscription = Logger.root.onRecord.listen(records.add);
    final catalog = _HiddenCatalog([]);
    final client = ControlledClient();
    final session = managedSession(catalog, client, ControlledClient());
    final library = GalleryBloc(
      initialState: const LoadedGalleryState(items: []),
      client: GalleryTestClient(),
      session: session,
    );
    final management = GalleryManagementBloc(catalogBloc: library);
    try {
      final loading = management.stream.firstWhere((state) => state.isHidden && state.hiddenLoading);
      management.add(const GalleryManagementEvent.sectionChanged(GallerySection.hidden));
      await loading;
      expect(client.requests.single.request.url.pathSegments.skip(3), ['hidden', 'catalog']);
    } finally {
      await management.close();
      await library.close();
      await session.close();
      await subscription.cancel();
      Logger.root.level = previousLevel;
    }
    expect(client.requests.single.aborted, isTrue);
    expect(
      records.any((record) => record.level == Level.FINE && record.message == 'event=hiddenLoadCancelled'),
      isTrue,
    );
    expect(records.where((record) => record.level >= Level.WARNING), isEmpty);
  });

  test('hidden catalog retains the active snapshot during library refresh and unhides its own section', () async {
    final requests = <GalleryOperationRequest>[];
    final records = <LogRecord>[];
    final previousLevel = Logger.root.level;
    Logger.root.level = Level.ALL;
    final subscription = Logger.root.onRecord.listen(records.add);
    final catalog = _HiddenCatalog([managedPhoto('library')]);
    var hidden = [_entry];
    final session = managedSession(
      catalog,
      MockClient((request) async {
        if (request.method == 'GET') {
          return _response(GalleryCatalog(section: GalleryMediaSection.hidden, entries: hidden).toJson());
        }
        final operation = GalleryOperationRequest.fromJson(jsonDecode(request.body) as Map<String, dynamic>);
        requests.add(operation);
        hidden = [];
        return _response(
          GalleryOperationResult(
            operationId: operation.operationId,
            items: [
              GalleryOperationItemResult(
                mediaId: _entry.mediaId,
                section: GalleryMediaSection.hidden,
                state: GalleryItemOperationState.succeeded,
                restoredPath: _entry.path,
              ),
            ],
          ).toJson(),
        );
      }),
      ControlledClient(),
    );
    final library = GalleryBloc(
      initialState: LoadedGalleryState(items: catalog.items),
      client: GalleryTestClient(),
      session: session,
    );
    final management = GalleryManagementBloc(catalogBloc: library);
    addTearDown(() async {
      await management.close();
      await library.close();
      await session.close();
      await subscription.cancel();
      Logger.root.level = previousLevel;
    });
    final loaded = management.stream.firstWhere(
      (state) => state.isHidden && state.hidden != null && !state.hiddenLoading,
    );
    management.add(const GalleryManagementEvent.sectionChanged(GallerySection.hidden));
    final state = await loaded;
    expect(state.items.single.uri.pathSegments, containsAllInOrder(['hidden', 'original', _entry.mediaId]));
    expect(management.currentDuplicateItems.map((item) => item.mediaId), ['library', _entry.mediaId]);
    await management.refresh();
    expect(management.state.items.single.mediaId, _entry.mediaId);
    final selected = management.stream.firstWhere((state) => state.selectedIds.isNotEmpty);
    management.add(GalleryManagementEvent.selectionToggled(state.items.single.selectionIdentity));
    await selected;
    final unhidden = management.stream.firstWhere(
      (state) => !state.busy && state.notice == GalleryManagementNotice.unhidden,
    );
    management.add(const GalleryManagementEvent.mutationRequested(GalleryMutation.unhide));
    await unhidden;
    expect(requests.single.action, GalleryMutation.unhide);
    expect(requests.single.items.single.section, GalleryMediaSection.hidden);
    expect(management.state.items, isEmpty);
    expect(records.any((record) => record.message.contains('event=hiddenLoadCompleted entries=1')), isTrue);
    expect(
      records.any((record) => record.message.contains('action=unhide') && record.message.contains('succeeded=1')),
      isTrue,
    );
  });

  test('hidden selection confirms trash against the hidden snapshot rather than the visible library', () async {
    final operations = <GalleryOperationRequest>[];
    final catalog = _HiddenCatalog([managedPhoto('visible-other-photo')]);
    var hidden = [_entry];
    final session = managedSession(
      catalog,
      MockClient((request) async {
        if (request.method == 'GET') {
          return _response(GalleryCatalog(section: GalleryMediaSection.hidden, entries: hidden).toJson());
        }
        final operation = GalleryOperationRequest.fromJson(jsonDecode(request.body) as Map<String, dynamic>);
        operations.add(operation);
        hidden = [];
        return _response(
          GalleryOperationResult(
            operationId: operation.operationId,
            items: [
              GalleryOperationItemResult(
                mediaId: _entry.mediaId,
                section: GalleryMediaSection.hidden,
                state: GalleryItemOperationState.succeeded,
                destination: GalleryMediaRef(
                  mediaId: 'trash-photo',
                  sourceRevision: "destination-revision",
                  section: GalleryMediaSection.trash,
                ),
              ),
            ],
          ).toJson(),
        );
      }),
      ControlledClient(),
    );
    final library = GalleryBloc(
      initialState: LoadedGalleryState(items: catalog.items),
      client: GalleryTestClient(),
      session: session,
    );
    final management = GalleryManagementBloc(catalogBloc: library);
    addTearDown(() async {
      await management.close();
      await library.close();
      await session.close();
    });
    final loaded = management.stream.firstWhere(
      (state) => state.isHidden && state.hidden != null && !state.hiddenLoading,
    );
    management.add(const GalleryManagementEvent.sectionChanged(GallerySection.hidden));
    await loaded;
    final selected = management.stream.firstWhere((state) => state.selectedIds.isNotEmpty);
    management.add(GalleryManagementEvent.selectionToggled(management.state.items.single.selectionIdentity));
    await selected;
    final completed = management.stream
        .firstWhere((state) => !state.busy && state.notice == GalleryManagementNotice.trashed)
        .timeout(const Duration(seconds: 2));
    management.add(const GalleryManagementEvent.mutationRequested(GalleryMutation.trash));
    await confirmManagementMutation(management, GalleryMutation.trash);
    await completed;
    expect(operations.single.action, GalleryMutation.trash);
    expect(operations.single.items.single.mediaId, _entry.mediaId);
    expect(operations.single.items.single.section, GalleryMediaSection.hidden);
    expect(management.state.items, isEmpty);
    expect(management.currentLibraryItems.single.mediaId, 'visible-other-photo');
    expect(management.state.undoMediaIds, ['trash-photo']);
  });

  test('hide confirmation preserves refs and Undo reads hidden rather than trash', () async {
    final operations = <GalleryOperationRequest>[];
    final endpoints = <String>[];
    final catalog = _HiddenCatalog([managedPhoto('photo')]);
    final session = managedSession(
      catalog,
      MockClient((request) async {
        endpoints.add(
          request.url.pathSegments.contains('catalog') ? request.url.pathSegments[3] : request.url.pathSegments.last,
        );
        if (request.method == 'GET') {
          return _response(GalleryCatalog(section: GalleryMediaSection.hidden, entries: [_entry]).toJson());
        }
        final operation = GalleryOperationRequest.fromJson(jsonDecode(request.body) as Map<String, dynamic>);
        operations.add(operation);
        catalog.items = [];
        return _response(
          GalleryOperationResult(
            operationId: operation.operationId,
            items: [
              GalleryOperationItemResult(
                mediaId: operation.items.single.mediaId,
                state: GalleryItemOperationState.succeeded,
                section: operation.items.single.section,
                destination: operation.action == GalleryMutation.hide ? _entry.ref : null,
              ),
            ],
          ).toJson(),
        );
      }),
      ControlledClient(),
    );
    final library = GalleryBloc(
      initialState: LoadedGalleryState(items: catalog.items),
      client: GalleryTestClient(),
      session: session,
    );
    final management = GalleryManagementBloc(catalogBloc: library);
    final undo = GalleryUndoBloc(
      repository: session.management,
      mediaIds: [_entry.mediaId],
      section: GalleryMediaSection.hidden,
    );
    addTearDown(() async {
      await undo.close();
      await management.close();
      await library.close();
      await session.close();
    });
    final selected = management.stream.firstWhere((state) => state.selectedIds.isNotEmpty);
    management.add(GalleryManagementEvent.selectionToggled(management.state.items.single.selectionIdentity));
    await selected;
    final finished = management.stream.firstWhere(
      (state) => !state.busy && state.notice == GalleryManagementNotice.hidden,
    );
    management.add(const GalleryManagementEvent.mutationRequested(GalleryMutation.hide));
    await confirmManagementMutation(management, GalleryMutation.hide);
    expect((await finished).undoMediaIds, [_entry.mediaId]);
    await undo.restore();
    expect(operations.map((operation) => operation.action), [GalleryMutation.hide, GalleryMutation.unhide]);
    expect(operations.last.items.single.section, GalleryMediaSection.hidden);
    expect(endpoints, contains('hidden'));
    expect(endpoints, isNot(contains('trash')));
  });

  test('hidden viewer uses hidden metadata and can return to show or trash, without rotation', () async {
    final paths = <List<String>>[];
    final repository = GalleryManagementRepository(
      baseUri: Uri.parse('http://frame.local'),
      code: 'code',
      client: MockClient((request) async {
        paths.add(request.url.pathSegments);
        return _response(
          photoMetadata(
            _entry.mediaId,
            revision: _entry.sourceRevision,
          ).copyWith(section: GalleryMediaSection.hidden).toJson(),
        );
      }),
    );
    final viewer = GalleryViewerBloc(
      configuration: GalleryViewerConfiguration(
        item: repository.mediaItem(_entry, 'test'),
        management: repository,
        entry: _entry,
        capabilities: const {
          GalleryCapability.metadata,
          GalleryCapability.rotation,
          GalleryCapability.mutations,
          GalleryCapability.hidden,
        },
      ),
    );
    addTearDown(() async {
      await viewer.close();
      repository.close();
    });
    expect(viewer.state.trash, isFalse);
    expect(viewer.state.hidden, isTrue);
    expect(viewer.state.canRotate, isFalse);
    expect(viewer.state.canMutate(GalleryMutation.unhide), isTrue);
    expect(viewer.state.canMutate(GalleryMutation.trash), isTrue);
    expect(viewer.state.canMutate(GalleryMutation.purge), isFalse);
    final ready = viewer.stream.firstWhere((state) => state.metadata != null);
    viewer.add(const GalleryViewerEvent.infoToggled());
    await ready;
    expect(paths.single, containsAllInOrder(['hidden', 'metadata', _entry.mediaId]));
  });

  testWidgets('hidden metadata mismatch refreshes its snapshot and disables the obsolete viewer identity', (
    tester,
  ) async {
    final catalog = _HiddenCatalog([managedPhoto('visible-photo')]);
    var hidden = [_entry];
    var metadataRequests = 0;
    final replacement = _entry.copyWith(mediaId: 'hidden-new-identity', sourceRevision: 'new-hidden-revision');
    final session = managedSession(
      catalog,
      MockClient((request) async {
        if (request.url.pathSegments.contains('metadata')) {
          metadataRequests++;
          hidden = [replacement];
          return http.Response(jsonEncode(const GalleryErrorResponse(GalleryErrorCode.revisionMismatch).toJson()), 409);
        }
        return _response(GalleryCatalog(section: GalleryMediaSection.hidden, entries: hidden).toJson());
      }),
      ControlledClient(),
    );
    final library = GalleryBloc(
      initialState: LoadedGalleryState(items: catalog.items),
      client: GalleryTestClient(),
      session: session,
    );
    final management = GalleryManagementBloc(catalogBloc: library);
    addTearDown(() async {
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
      await tester.runAsync(management.close);
      await tester.runAsync(library.close);
      await tester.runAsync(session.close);
    });
    final loaded = management.stream.firstWhere(
      (state) => state.isHidden && state.hidden != null && !state.hiddenLoading,
    );
    management.add(const GalleryManagementEvent.sectionChanged(GallerySection.hidden));
    await tester.pump();
    await loaded;
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: SingleItemViewerPage(
          item: management.state.items.single,
          session: session,
          capabilities: management.state.capabilities,
          entry: _entry,
          currentItem: () => management.currentItem(_entry.mediaId, mediaSection: GalleryMediaSection.hidden),
          itemUpdates: management.itemUpdates(_entry.mediaId, mediaSection: GalleryMediaSection.hidden),
          onChanged: management.refresh,
        ),
      ),
    );
    await tester.pump();
    await tester.tap(find.byTooltip('File information'));
    var elapsed = Duration.zero;
    while (find.text('File unavailable').evaluate().isEmpty && elapsed < const Duration(seconds: 2)) {
      await tester.pump(const Duration(milliseconds: 16));
      elapsed += const Duration(milliseconds: 16);
    }
    expect(find.text('File unavailable'), findsOneWidget);
    expect(metadataRequests, 1);
    expect(management.currentItem(_entry.mediaId, mediaSection: GalleryMediaSection.hidden), isNull);
    expect(
      management.currentItem(replacement.mediaId, mediaSection: GalleryMediaSection.hidden)?.revision,
      replacement.sourceRevision,
    );
    expect(find.byTooltip('Return to slideshow'), findsNothing);
    expect(tester.widget<IconButton>(find.widgetWithIcon(IconButton, Icons.delete_outline)).onPressed, isNull);
    expect(tester.takeException(), isNull);
  });

  testWidgets('hidden section offers return and trash on a phone and refreshes after return', (tester) async {
    tester.view.physicalSize = const Size(320, 720);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final catalog = _HiddenCatalog([]);
    var hidden = [_entry];
    GalleryOperationRequest? mutation;
    final session = managedSession(
      catalog,
      MockClient((request) async {
        if (request.method == 'GET') {
          return _response(GalleryCatalog(section: GalleryMediaSection.hidden, entries: hidden).toJson());
        }
        mutation = GalleryOperationRequest.fromJson(jsonDecode(request.body) as Map<String, dynamic>);
        hidden = [];
        return _response(
          GalleryOperationResult(
            operationId: mutation!.operationId,
            items: [
              GalleryOperationItemResult(
                section: _entry.section,
                mediaId: _entry.mediaId,
                state: GalleryItemOperationState.succeeded,
              ),
            ],
          ).toJson(),
        );
      }),
      ControlledClient(),
    );
    final library = GalleryBloc(
      initialState: const LoadedGalleryState(items: []),
      client: GalleryTestClient(),
      session: session,
    );
    addTearDown(() async {
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
      await tester.runAsync(library.close);
      await tester.runAsync(session.close);
    });
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: BlocProvider.value(value: library, child: const GalleryWidget()),
      ),
    );
    await tester.pump();
    await tester.tap(find.text('Hidden'));
    await tester.pump();
    await tester.pump();
    expect(find.byType(ImageGridItem), findsOneWidget);
    expect(find.text('Return to slideshow'), findsOneWidget);
    expect(find.text('Move to trash'), findsOneWidget);
    await tester.ensureVisible(find.byType(ImageGridItem));
    await tester.pump();
    await tester.longPress(find.byType(ImageGridItem));
    await tester.pump();
    await tester.tap(find.text('Return to slideshow'));
    await tester.pump();
    await tester.pump();
    expect(mutation?.action, GalleryMutation.unhide);
    expect(mutation?.items.single.section, GalleryMediaSection.hidden);
    expect(find.byType(ImageGridItem), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
