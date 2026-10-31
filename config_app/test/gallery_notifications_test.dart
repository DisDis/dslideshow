import 'dart:convert';

import 'package:config_app/features/gallery/presentation/widgets/gallery_actions.dart';
import 'package:config_app/src/gallery/gallery_management_repository.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

Widget _app(GalleryManagementRepository repository, Future<void> Function() refresh, {double textScale = 1}) =>
    MaterialApp(
      builder: (context, content) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(textScale)),
        child: content!,
      ),
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Builder(
        builder: (context) => Scaffold(
          body: TextButton(
            onPressed: () => showGalleryUndo(context, repository, ['trash-a'], refresh),
            child: const Text('Notify'),
          ),
        ),
      ),
    );

Future<void> _show(WidgetTester tester) async {
  await tester.tap(find.text('Notify'));
  await tester.pump();
  await _waitSnackVisible(tester);
}

Future<void> _waitSnackVisible(WidgetTester tester) async {
  final snack = find.byType(SnackBar);
  for (
    var elapsed = Duration.zero;
    tester.widget<SnackBar>(snack).animation?.status != AnimationStatus.completed &&
        elapsed < const Duration(seconds: 1);
    elapsed += const Duration(milliseconds: 16)
  ) {
    await tester.pump(const Duration(milliseconds: 16));
  }
  expect(tester.widget<SnackBar>(snack).animation!.status, AnimationStatus.completed);
  await tester.pump();
}

void main() {
  testWidgets('trash notification can close manually and expires without restoring media', (tester) async {
    tester.view.physicalSize = const Size(320, 720);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    var requests = 0;
    final repository = GalleryManagementRepository(
      baseUri: Uri.parse('http://frame.local'),
      code: 'code',
      client: MockClient((_) async {
        requests++;
        return http.Response('{}', 200);
      }),
    );
    addTearDown(repository.close);
    await tester.pumpWidget(_app(repository, () async {}, textScale: 1.5));
    await _show(tester);
    expect(find.text('Undo'), findsOneWidget);
    final close = find.descendant(of: find.byType(SnackBar), matching: find.byIcon(Icons.close));
    expect(close, findsOneWidget);
    await tester.tap(close);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.byType(SnackBar), findsNothing);
    expect(requests, 0, reason: 'Dismissing a notice must not restore files');
    await _show(tester);
    await tester.pump(const Duration(seconds: 7));
    expect(find.text('Undo'), findsOneWidget);
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.byType(SnackBar), findsNothing, reason: 'An action must not make the notification permanent');
    expect(requests, 0);
    await tester.pumpWidget(const SizedBox());
    await tester.pump();
    expect(tester.takeException(), isNull);
  });

  testWidgets('Undo still restores and its result notification has a close control', (tester) async {
    final actions = <GalleryMutation>[];
    var refreshes = 0;
    var available = true;
    final repository = GalleryManagementRepository(
      baseUri: Uri.parse('http://frame.local'),
      code: 'code',
      client: MockClient((request) async {
        if (request.method == 'GET') {
          return http.Response(
            jsonEncode(
              GalleryCatalog(
                section: GalleryMediaSection.trash,
                entries: [
                  if (available)
                    GalleryEntry(
                      section: GalleryMediaSection.trash,
                      mediaId: 'trash-a',
                      name: 'a.jpg',
                      path: 'a.jpg',
                      kind: GalleryEntryKind.image,
                      sourceRevision: 'revision',
                      fileChanged: DateTime.utc(2026, 10, 29),
                      sizeBytes: 10,
                    ),
                ],
              ).toJson(),
            ),
            200,
          );
        }
        final operation = GalleryOperationRequest.fromJson(jsonDecode(request.body) as Map<String, dynamic>);
        actions.add(operation.action);
        available = false;
        return http.Response(
          jsonEncode(
            GalleryOperationResult(
              operationId: operation.operationId,
              items: [
                const GalleryOperationItemResult(
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
    );
    addTearDown(repository.close);
    await tester.pumpWidget(
      _app(repository, () async {
        refreshes++;
      }),
    );
    await _show(tester);
    await tester.tap(find.text('Undo'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pump();
    expect(actions, [GalleryMutation.restore]);
    expect(refreshes, 1);
    expect(find.text('Files restored'), findsOneWidget);
    expect(find.descendant(of: find.byType(SnackBar), matching: find.byIcon(Icons.close)), findsOneWidget);
    // A repeated Undo is based on current trash, not an old server receipt.
    await _waitSnackVisible(tester);
    await tester.tap(find.descendant(of: find.byType(SnackBar), matching: find.byIcon(Icons.close)));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await _show(tester);
    await tester.tap(find.text('Undo'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pump();
    expect(actions, [GalleryMutation.restore]);
    expect(refreshes, 2);
    final l = AppLocalizations.of(tester.element(find.byType(Scaffold)));
    expect(find.text(l.gallery_undo_changed), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
    await tester.pump();
    expect(tester.takeException(), isNull);
  });
}
