import 'dart:async';
import 'dart:convert';

import 'package:config_app/features/gallery/presentation/bloc/gallery_bloc.dart';
import 'package:config_app/features/gallery/presentation/bloc/gallery_management_bloc.dart';
import 'package:config_app/features/gallery/presentation/pages/single_item_viewer_page.dart';
import 'package:config_app/features/gallery/presentation/widgets/gallery_widget.dart';
import 'package:config_app/features/gallery/presentation/widgets/gallery_confirmation_file.dart';
import 'package:config_app/features/theme/presentation/theme.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'gallery_image_loader_test.dart' show ControlledClient;
import 'support/gallery_management_harness.dart';

Widget app(Widget child) => MaterialApp(
  theme: createLightTheme(),
  locale: const Locale('en'),
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: child,
);

http.Response response(Object data) => http.Response(jsonEncode(data), 200);

Future<void> decide(
  WidgetTester tester,
  String label, {
  bool confirm = true,
}) async {
  final dialog = find.byType(AlertDialog);
  expect(dialog, findsOneWidget);
  await tester.tap(
    find.descendant(
      of: dialog,
      matching: confirm
          ? find.widgetWithText(FilledButton, label)
          : find.widgetWithText(TextButton, 'Cancel'),
    ),
  );
  var elapsed = Duration.zero;
  while (dialog.evaluate().isNotEmpty && elapsed < const Duration(seconds: 2)) {
    await tester.pump(const Duration(milliseconds: 16));
    elapsed += const Duration(milliseconds: 16);
  }
  expect(dialog, findsNothing);
}

Future<void> finishRoute(
  WidgetTester tester,
  Animation<double> animation,
  AnimationStatus target,
) async {
  var elapsed = Duration.zero;
  while (animation.status != target && elapsed < const Duration(seconds: 2)) {
    await tester.pump(const Duration(milliseconds: 16));
    elapsed += const Duration(milliseconds: 16);
  }
  expect(animation.status, target);
  await tester.pump();
}

void main() {
  testWidgets(
    'bulk trash asks once with ten original names; Cancel sends nothing and Confirm sends exact refs',
    (tester) async {
      final catalog = ManagedCatalogRepository(
        List.generate(12, (index) => managedPhoto('photo-$index')),
      );
      final originals = List.of(catalog.items);
      final requests = <GalleryOperationRequest>[];
      final session = managedSession(
        catalog,
        MockClient((request) async {
          final operation = GalleryOperationRequest.fromJson(
            jsonDecode(request.body) as Map<String, dynamic>,
          );
          requests.add(operation);
          catalog.items = [];
          return response(
            GalleryOperationResult(
              operationId: operation.operationId,
              items: [
                for (final ref in operation.items)
                  GalleryOperationItemResult(
                    mediaId: ref.mediaId,
                    state: GalleryItemOperationState.succeeded,
                    trashId: 'trash-${ref.mediaId}',
                  ),
              ],
            ).toJson(),
          );
        }),
        ControlledClient(),
      );
      final catalogBloc = GalleryBloc(
        initialState: LoadedGalleryState(items: catalog.items),
        client: GalleryTestClient(),
        session: session,
      );
      addTearDown(() async {
        await catalogBloc.close();
        await session.close();
      });
      await tester.pumpWidget(
        app(
          BlocProvider.value(value: catalogBloc, child: const GalleryWidget()),
        ),
      );
      final management = tester
          .element(find.byKey(const ValueKey('gallery-selection-bar')))
          .read<GalleryManagementBloc>();
      for (final item in originals) {
        management.add(
          GalleryManagementEvent.selectionToggled(item.selectionIdentity),
        );
      }
      await tester.pump();
      await tester.tap(find.text('Move to trash'));
      await tester.pump();
      expect(requests, isEmpty);
      expect(find.text('Move to trash?'), findsOneWidget);
      expect(
        find.text('Files: 12. They can be restored from Trash.'),
        findsOneWidget,
      );
      expect(management.state.confirmation!.names, hasLength(10));
      expect(
        find.text('Additional files to move to Trash: 2.'),
        findsOneWidget,
      );
      final dialog = find.byType(AlertDialog);
      final firstFile = find.descendant(
        of: dialog,
        matching: find.byWidgetPredicate(
          (w) => w is GalleryConfirmationFile && w.name == 'photo-0.jpg',
        ),
      );
      final secondFile = find.descendant(
        of: dialog,
        matching: find.byWidgetPredicate(
          (w) => w is GalleryConfirmationFile && w.name == 'photo-1.jpg',
        ),
      );
      expect(
        find.descendant(of: firstFile, matching: find.text('1')),
        findsOneWidget,
      );
      expect(
        tester
            .getRect(
              find.descendant(of: firstFile, matching: find.byType(Container)),
            )
            .bottom,
        lessThan(
          tester
              .getRect(
                find.descendant(
                  of: secondFile,
                  matching: find.byType(Container),
                ),
              )
              .top,
        ),
      );
      for (var index = 0; index < 10; index++) {
        expect(
          find.descendant(of: dialog, matching: find.text('photo-$index.jpg')),
          findsOneWidget,
        );
      }
      expect(
        find.descendant(of: dialog, matching: find.text('photo-10.jpg')),
        findsNothing,
      );
      await decide(tester, '', confirm: false);
      expect(requests, isEmpty);
      expect(management.state.selectedIds, hasLength(12));
      await tester.tap(find.text('Move to trash'));
      await tester.pump();
      await decide(tester, 'Move to trash');
      expect(requests, hasLength(1));
      expect(requests.single.action, GalleryMutation.trash);
      expect(requests.single.items.toSet(), {
        for (final item in originals)
          GalleryMediaRef(mediaId: item.mediaId, sourceRevision: item.revision),
      });
      expect(find.text('Undo'), findsOneWidget);
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'bulk purge is irreversible and rejects a selection changed while its dialog is open',
    (tester) async {
      final catalog = ManagedCatalogRepository([]);
      var entries = List.generate(
        12,
        (index) => GalleryTrashEntry(
          trashId: 'trash-$index',
          name: 'original-$index.jpg',
          originalPath: 'album/original-$index.jpg',
          kind: GalleryEntryKind.image,
          sourceRevision: 'trash-revision-$index',
          trashedAt: DateTime.utc(2026),
          sizeBytes: 2500000,
        ),
      );
      final requests = <GalleryOperationRequest>[];
      final session = managedSession(
        catalog,
        MockClient((request) async {
          if (request.method == 'GET') {
            return response(GalleryTrashCatalog(entries: entries).toJson());
          }
          final operation = GalleryOperationRequest.fromJson(
            jsonDecode(request.body) as Map<String, dynamic>,
          );
          requests.add(operation);
          entries = [];
          return response(
            GalleryOperationResult(
              operationId: operation.operationId,
              items: [
                for (final ref in operation.items)
                  GalleryOperationItemResult(
                    mediaId: ref.mediaId,
                    state: GalleryItemOperationState.succeeded,
                  ),
              ],
            ).toJson(),
          );
        }),
        ControlledClient(),
      );
      final catalogBloc = GalleryBloc(
        initialState: const LoadedGalleryState(items: []),
        client: GalleryTestClient(),
        session: session,
      );
      addTearDown(() async {
        await catalogBloc.close();
        await session.close();
      });
      await tester.pumpWidget(
        app(
          BlocProvider.value(value: catalogBloc, child: const GalleryWidget()),
        ),
      );
      await tester.tap(find.text('Trash'));
      await tester.pump();
      await tester.pump();
      final management = tester
          .element(find.byKey(const ValueKey('gallery-selection-bar')))
          .read<GalleryManagementBloc>();
      final items = List.of(management.state.items);
      for (final item in items) {
        management.add(
          GalleryManagementEvent.selectionToggled(item.selectionIdentity),
        );
      }
      await tester.pump();
      await tester.tap(find.byTooltip('Delete permanently'));
      await tester.pump();
      expect(find.text('Delete permanently?'), findsOneWidget);
      expect(
        find.text(
          'Files to delete: 12. Expected space freed: 30.00 MB. They cannot be restored through the photo frame.',
        ),
        findsOneWidget,
      );
      expect(find.text('original-0.jpg'), findsOneWidget);
      expect(find.text('Additional files to delete: 2.'), findsOneWidget);
      expect(find.byTooltip('Exact size: 30000000 bytes'), findsOneWidget);
      final dialog = find.byType(AlertDialog);
      expect(
        find.descendant(
          of: dialog,
          matching: find.text('album/original-0.jpg'),
        ),
        findsNothing,
      );
      final firstFile = find.descendant(
        of: dialog,
        matching: find.byWidgetPredicate(
          (w) => w is GalleryConfirmationFile && w.name == 'original-0.jpg',
        ),
      );
      final secondFile = find.descendant(
        of: dialog,
        matching: find.byWidgetPredicate(
          (w) => w is GalleryConfirmationFile && w.name == 'original-1.jpg',
        ),
      );
      expect(
        find.descendant(of: firstFile, matching: find.text('1')),
        findsOneWidget,
      );
      expect(
        tester
            .getRect(
              find.descendant(of: firstFile, matching: find.byType(Container)),
            )
            .bottom,
        lessThan(
          tester
              .getRect(
                find.descendant(
                  of: secondFile,
                  matching: find.byType(Container),
                ),
              )
              .top,
        ),
      );
      for (var index = 0; index < 10; index++) {
        expect(
          find.descendant(
            of: dialog,
            matching: find.text('original-$index.jpg'),
          ),
          findsOneWidget,
        );
      }
      expect(
        find.descendant(of: dialog, matching: find.text('original-10.jpg')),
        findsNothing,
      );
      expect(
        find.descendant(of: dialog, matching: find.text('original-11.jpg')),
        findsNothing,
      );
      await decide(tester, '', confirm: false);
      expect(requests, isEmpty);
      await tester.tap(find.byTooltip('Delete permanently'));
      await tester.pump();
      management.add(const GalleryManagementEvent.selectionCleared());
      management.add(
        GalleryManagementEvent.selectionToggled(items.last.selectionIdentity),
      );
      await tester.pump();
      await decide(tester, 'Delete permanently');
      expect(requests, isEmpty);
      expect(
        find.text(
          'The selection or files changed. Review the selection and try again.',
        ),
        findsOneWidget,
      );
      await tester.tap(find.byTooltip('Delete permanently'));
      await tester.pump();
      await decide(tester, 'Delete permanently');
      expect(requests, hasLength(1));
      expect(requests.single.action, GalleryMutation.purge);
      expect(
        requests.single.items.single,
        GalleryMediaRef(
          mediaId: items.last.mediaId,
          sourceRevision: items.last.revision,
        ),
      );
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'viewer trash cancels and checks the latest source revision before sending its confirmed request',
    (tester) async {
      var current = managedPhoto('photo');
      final updates = StreamController<GalleryItem?>();
      final requests = <GalleryOperationRequest>[];
      final trashed = <String>[];
      final session = managedSession(
        ManagedCatalogRepository([current]),
        MockClient((request) async {
          final operation = GalleryOperationRequest.fromJson(
            jsonDecode(request.body) as Map<String, dynamic>,
          );
          requests.add(operation);
          return response(
            GalleryOperationResult(
              operationId: operation.operationId,
              items: const [
                GalleryOperationItemResult(
                  mediaId: 'photo',
                  state: GalleryItemOperationState.succeeded,
                  trashId: 'trash-photo',
                ),
              ],
            ).toJson(),
          );
        }),
        ControlledClient(),
      );
      addTearDown(() async {
        await updates.close();
        await session.close();
      });
      final route = MaterialPageRoute<void>(
        builder: (_) => SingleItemViewerPage(
          item: current,
          session: session,
          currentItem: () => current,
          itemUpdates: updates.stream,
          capabilities: const {GalleryCapability.mutations},
          onTrashed: trashed.addAll,
        ),
      );
      await tester.pumpWidget(
        app(
          Builder(
            builder: (context) => Scaffold(
              body: TextButton(
                onPressed: () => Navigator.of(context).push(route),
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Open'));
      await tester.pump();
      final animation = route.animation!;
      await finishRoute(tester, animation, AnimationStatus.completed);
      await tester.tap(find.byTooltip('Move to trash'));
      await tester.pump();
      expect(
        find.text('Files: 1. They can be restored from Trash.'),
        findsOneWidget,
      );
      await decide(tester, '', confirm: false);
      expect(requests, isEmpty);
      await tester.tap(find.byTooltip('Move to trash'));
      await tester.pump();
      current = managedPhoto('photo', revision: '2');
      await decide(tester, 'Move to trash');
      expect(
        requests,
        isEmpty,
        reason: 'currentItem can advance before its stream event is delivered',
      );
      expect(
        find.text(
          'The selection or files changed. Review the selection and try again.',
        ),
        findsOneWidget,
      );
      updates.add(current);
      await tester.pump();
      await tester.tap(find.byTooltip('Move to trash'));
      await tester.pump();
      await decide(tester, 'Move to trash');
      await finishRoute(tester, animation, AnimationStatus.dismissed);
      expect(requests, hasLength(1));
      expect(
        requests.single.items.single,
        const GalleryMediaRef(mediaId: 'photo', sourceRevision: '2'),
      );
      expect(trashed, ['trash-photo']);
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
      expect(tester.takeException(), isNull);
    },
  );

  test('main confirmation rejects a catalog revision changed before its delayed decision', () async {
    final catalog = ManagedCatalogRepository([managedPhoto('photo')]);
    var calls = 0;
    final session = managedSession(
      catalog,
      MockClient((_) async {
        calls++;
        return response({});
      }),
      ControlledClient(),
    );
    final catalogBloc = GalleryBloc(
      initialState: LoadedGalleryState(items: catalog.items),
      client: GalleryTestClient(),
      session: session,
    );
    final management = GalleryManagementBloc(catalogBloc: catalogBloc);
    addTearDown(() async {
      await management.close();
      await catalogBloc.close();
      await session.close();
    });
    management.add(
      GalleryManagementEvent.selectionToggled(
        catalog.items.single.selectionIdentity,
      ),
    );
    await management.stream.firstWhere((state) => state.selectedIds.isNotEmpty);
    management.add(
      const GalleryManagementEvent.mutationRequested(GalleryMutation.trash),
    );
    final prompt = await management.stream.firstWhere(
      (state) => state.confirmation != null,
    );
    catalog.items = [managedPhoto('photo', revision: '2')];
    await management.refresh();
    management.add(
      GalleryManagementEvent.mutationDecision(
        confirmationId: prompt.confirmation!.token,
        confirmed: true,
      ),
    );
    await management.stream.firstWhere(
      (state) => state.notice == GalleryManagementNotice.confirmationChanged,
    );
    expect(calls, 0);
    expect(management.state.confirmation, isNull);
  });
}
