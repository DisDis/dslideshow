import 'dart:convert';

import 'package:config_app/features/gallery/presentation/bloc/gallery_duplicates_bloc.dart';
import 'package:config_app/features/gallery/presentation/pages/gallery_duplicates_page.dart';
import 'package:config_app/src/gallery/gallery_image_widget.dart';
import 'package:config_app/features/gallery/presentation/widgets/gallery_confirmation_file.dart';
import 'package:config_app/features/gallery/presentation/widgets/gallery_actions.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'gallery_image_loader_test.dart' show ControlledClient;
import 'support/gallery_management_harness.dart';

void main() {
  testWidgets(
    'delete confirmation wraps full filenames in distinct blocks on EN 320px with enlarged text',
    (tester) async {
      tester.view.physicalSize = const Size(320, 720);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      const names = [
        '52738815683237679255273881568323767925 (Copy 2).jpg',
        '52738815683237679255273881568323767925_dub.jpg',
      ];
      bool? confirmed;
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.dark(),
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: TextScaler.linear(1.5)),
            child: child!,
          ),
          home: Scaffold(
            body: Builder(
              builder: (context) => TextButton(
                key: const ValueKey('open-confirmation'),
                onPressed: () async {
                  confirmed = await confirmGalleryPurge(
                    context,
                    2,
                    280000,
                    names: names,
                  );
                },
                child: const Text('Delete permanently'),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.byKey(const ValueKey('open-confirmation')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 250));
      final dialog = find.byType(AlertDialog);
      for (final name in names) {
        final text = find.descendant(of: dialog, matching: find.text(name));
        expect(text, findsOneWidget);
        expect(
          tester.renderObject<RenderParagraph>(text).didExceedMaxLines,
          isFalse,
        );
        expect(
          tester.getRect(text).left,
          greaterThanOrEqualTo(tester.getRect(dialog).left),
        );
        expect(
          tester.getRect(text).right,
          lessThanOrEqualTo(tester.getRect(dialog).right),
        );
      }
      await tester.tap(
        find.descendant(
          of: dialog,
          matching: find.widgetWithText(TextButton, 'Cancel'),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 250));
      expect(confirmed, isFalse);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox.shrink());
    },
  );

  testWidgets(
    'duplicate review summarizes selection and requires confirmation and retains the visible list behind the dialog',
    (tester) async {
      tester.view.physicalSize = const Size(1280, 1000);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final catalog = ManagedCatalogRepository([
        for (var index = 0; index < 20; index++) managedPhoto('$index'),
      ]);
      final job = GalleryDuplicateJob(
        jobId: 'job',
        status: GalleryDuplicateStatus.completed,
        modes: [GalleryDuplicateMode.exact],
        groups: [
          GalleryDuplicateGroup(
            groupId: 'group',
            mode: GalleryDuplicateMode.exact,
            items: [
              for (var index = 0; index < 20; index++)
                GalleryDuplicateMember(
                  mediaId: '$index',
                  sourceRevision: '1',
                  path: 'album/$index.jpg',
                  name: '$index.jpg',
                  sizeBytes: 1024,
                ),
            ],
          ),
        ],
      );
      final images = ControlledClient();
      final operations = <GalleryOperationRequest>[];
      final session = managedSession(
        catalog,
        MockClient((request) async {
          if (request.url.pathSegments.last == 'operations') {
            final command = GalleryOperationRequest.fromJson(
              jsonDecode(request.body) as Map<String, dynamic>,
            );
            operations.add(command);
            return http.Response(
              jsonEncode(
                GalleryOperationResult(
                  operationId: command.operationId,
                  items: [
                    for (final item in command.items)
                      GalleryOperationItemResult(
                        mediaId: item.mediaId,
                        state: GalleryItemOperationState.succeeded,
                        trashId: 'trash-${item.mediaId}',
                      ),
                  ],
                ).toJson(),
              ),
              200,
            );
          }
          if (request.url.pathSegments.contains('metadata')) {
            return http.Response(
              jsonEncode(photoMetadata(request.url.pathSegments[4]).toJson()),
              200,
            );
          }
          return duplicateResponse(request, job);
        }),
        images,
      );
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: GalleryDuplicatesPage(
              session: session,
              catalog: catalog.items,
              onRefresh: () async {},
            ),
          ),
        ),
      );
      await tester.pump();
      await tester.pump();
      expect(images.requests, isNotEmpty);
      expect(find.text('Files 1–10 of 20'), findsOneWidget);
      final bloc = tester
          .element(find.byType(GalleryImage).first)
          .read<GalleryDuplicatesBloc>();
      expect(bloc.state.visibleMembers, hasLength(10));
      await tester.tap(find.byTooltip('Next page'));
      await tester.pump();
      expect(bloc.state.visibleMembers.first.mediaId, '10');
      expect(find.text('Files 11–20 of 20'), findsOneWidget);
      await tester.tap(find.byTooltip('Previous page'));
      await tester.pump();
      final imageKeys = tester
          .widgetList<GalleryImage>(find.byType(GalleryImage))
          .map((widget) => widget.request.key)
          .toList();
      final requestCount = images.requests.length;
      final activeCount = session.loader.activeCount;
      final activeRequests = images.requests
          .where((request) => !request.aborted && !request.done)
          .toList();
      for (var index = 2; index <= 12; index++) {
        bloc.add(
          GalleryDuplicatesEvent.decide(
            'group',
            '$index',
            GalleryDuplicateDecision.trash,
          ),
        );
      }
      await tester.pump();
      expect(bloc.state.decisions, hasLength(11));
      final review = find.widgetWithText(FilledButton, 'Move to trash');
      await tester.ensureVisible(review);
      await tester.tap(review);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 250));
      final dialog = find.byType(AlertDialog);
      expect(operations, isEmpty);
      expect(dialog, findsOneWidget);
      expect(
        find.descendant(of: dialog, matching: find.text('11 selected')),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: dialog,
          matching: find.text('Additional files to move to Trash: 1.'),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(of: dialog, matching: find.text('2.jpg')),
        findsOneWidget,
      );
      expect(
        find.descendant(of: dialog, matching: find.text('11.jpg')),
        findsOneWidget,
      );
      expect(
        find.descendant(of: dialog, matching: find.text('12.jpg')),
        findsNothing,
      );
      expect(
        find.descendant(of: dialog, matching: find.text('album/2.jpg')),
        findsNothing,
      );
      final firstFile = find.descendant(
        of: dialog,
        matching: find.byWidgetPredicate(
          (w) => w is GalleryConfirmationFile && w.name == '2.jpg',
        ),
      );
      final secondFile = find.descendant(
        of: dialog,
        matching: find.byWidgetPredicate(
          (w) => w is GalleryConfirmationFile && w.name == '3.jpg',
        ),
      );
      expect(
        find.descendant(of: firstFile, matching: find.text('1')),
        findsOneWidget,
      );
      expect(
        find.descendant(of: secondFile, matching: find.text('2')),
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
      expect(session.loader.activeCount, activeCount);
      expect(images.requests, hasLength(requestCount));
      expect(activeRequests.every((request) => !request.aborted), isTrue);
      expect(
        tester
            .widgetList<GalleryImage>(find.byType(GalleryImage))
            .map((widget) => widget.request.key)
            .toSet(),
        containsAll(imageKeys),
      );
      await tester.tap(find.widgetWithText(TextButton, 'Cancel'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 250));
      expect(images.requests, hasLength(requestCount));
      expect(session.loader.activeCount, activeCount);
      expect(operations, isEmpty);
      await tester.tap(review);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 250));
      await tester.tap(
        find.descendant(
          of: find.byType(AlertDialog),
          matching: find.widgetWithText(FilledButton, 'Move to trash'),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 250));
      expect(
        operations.single.items,
        hasLength(11),
        reason: 'Limiting the preview must not truncate the chosen operation',
      );
      expect(operations.single.items.map((item) => item.mediaId).toSet(), {
        for (var index = 2; index <= 12; index++) '$index',
      });
      expect(operations.single.duplicateJobId, 'job');
      await tester.pumpWidget(const SizedBox());
      await tester.pump();
      await tester.runAsync(session.close);
      expect(tester.takeException(), isNull);
    },
  );
}
