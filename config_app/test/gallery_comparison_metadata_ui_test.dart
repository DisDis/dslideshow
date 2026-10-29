import 'dart:async';
import 'dart:convert';

import 'package:config_app/features/gallery/presentation/pages/gallery_duplicates_page.dart';
import 'package:config_app/features/gallery/presentation/widgets/gallery_comparison_details.dart';
import 'package:config_app/features/theme/presentation/theme.dart';
import 'package:config_app/src/gallery/gallery_session.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'gallery_image_loader_test.dart' show ControlledClient;
import 'support/gallery_management_harness.dart';

const _job = GalleryDuplicateJob(
  jobId: 'comparison-job',
  status: GalleryDuplicateStatus.completed,
  modes: [GalleryDuplicateMode.exact, GalleryDuplicateMode.similar],
  groups: [
    GalleryDuplicateGroup(
      groupId: 'exact',
      mode: GalleryDuplicateMode.exact,
      items: [
        GalleryDuplicateMember(
          mediaId: 'a',
          sourceRevision: '1',
          path: 'a.jpg',
          name: 'a.jpg',
          sizeBytes: 1024,
        ),
        GalleryDuplicateMember(
          mediaId: 'b',
          sourceRevision: '1',
          path: 'b.jpg',
          name: 'b.jpg',
          sizeBytes: 1024,
        ),
        GalleryDuplicateMember(
          mediaId: 'c',
          sourceRevision: '1',
          path: 'c.jpg',
          name: 'c.jpg',
          sizeBytes: 1024,
        ),
      ],
    ),
    GalleryDuplicateGroup(
      groupId: 'similar',
      mode: GalleryDuplicateMode.similar,
      items: [
        GalleryDuplicateMember(
          mediaId: 'a',
          sourceRevision: '1',
          path: 'a.jpg',
          name: 'a.jpg',
          sizeBytes: 1024,
          width: 8000,
          height: 6000,
        ),
        GalleryDuplicateMember(
          mediaId: 'c',
          sourceRevision: '1',
          path: 'c.jpg',
          name: 'c.jpg',
          sizeBytes: 1024,
          width: 2000,
          height: 1000,
        ),
      ],
    ),
  ],
);

Widget _app(GallerySession session, ManagedCatalogRepository catalog) =>
    MaterialApp(
      theme: createLightTheme(),
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
    );

Future<void> _finish(WidgetTester tester, GallerySession session) async {
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pump();
  await tester.runAsync(session.close);
  expect(tester.takeException(), isNull);
}

void main() {
  testWidgets(
    'initial list loads every visible member and revisiting uses cached metadata',
    (tester) async {
      tester.view.physicalSize = const Size(1200, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final catalog = ManagedCatalogRepository([
        managedPhoto('a'),
        managedPhoto('b'),
        managedPhoto('c'),
      ]);
      final reads = <String>[];
      final session = managedSession(
        catalog,
        MockClient((request) async {
          if (request.url.pathSegments.contains('metadata')) {
            final id = request.url.pathSegments[4];
            reads.add(id);
            final data = photoMetadata(id).copyWith(
              width: id == 'c' ? 1250 : 6000,
              height: id == 'c' ? 625 : 4000,
            );
            return http.Response(jsonEncode(data.toJson()), 200);
          }
          return duplicateResponse(request, _job);
        }),
        ControlledClient(),
      );
      await tester.pumpWidget(_app(session, catalog));
      await tester.pump();
      await tester.pump();
      expect(reads.toSet(), {'a', 'b', 'c'});
      expect(find.text('6000 × 4000 · 1024 B'), findsNWidgets(2));
      expect(find.text('8000 × 6000 · 1024 B'), findsNothing);
      expect(find.text('1250 × 625 · 1024 B'), findsOneWidget);
      await tester.scrollUntilVisible(
        find.text('Skip group'),
        200,
        scrollable: find.byType(Scrollable).first,
        maxScrolls: 8,
      );
      await tester.tap(find.text('Skip group'));
      await tester.pump();
      await tester.pump();
      expect(reads, ['a', 'b', 'c']);
      expect(find.text('6000 × 4000 · 1024 B'), findsOneWidget);
      expect(find.text('1250 × 625 · 1024 B'), findsOneWidget);
      await tester.scrollUntilVisible(
        find.text('Skip group'),
        200,
        scrollable: find.byType(Scrollable).first,
        maxScrolls: 8,
      );
      await tester.tap(find.text('Skip group'));
      await tester.pump();
      await tester.pump();
      expect(
        find.text('All current groups have been reviewed.'),
        findsOneWidget,
      );
      await tester.tap(find.text('Review again'));
      await tester.pump();
      await tester.pump();
      expect(find.text('6000 × 4000 · 1024 B'), findsNWidgets(2));
      expect(reads, ['a', 'b', 'c']);
      await _finish(tester, session);
    },
  );

  testWidgets(
    'failed exact metadata is explained even when similar group supplies dimensions; retry targets details',
    (tester) async {
      tester.view.physicalSize = const Size(1200, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final catalog = ManagedCatalogRepository([
        managedPhoto('a'),
        managedPhoto('b'),
        managedPhoto('c'),
      ]);
      final reads = <String>[];
      final retry = Completer<http.Response>();
      final images = ControlledClient();
      final session = managedSession(
        catalog,
        MockClient((request) async {
          if (request.url.pathSegments.contains('metadata')) {
            final id = request.url.pathSegments[4];
            reads.add(id);
            if (id == 'c' && reads.where((read) => read == 'c').length == 3) {
              return retry.future;
            }
            return http.Response(
              jsonEncode(
                const GalleryErrorResponse(GalleryErrorCode.unavailable)
                    .toJson(),
              ),
              503,
            );
          }
          return duplicateResponse(request, _job);
        }),
        images,
      );
      await tester.pumpWidget(_app(session, catalog));
      await tester.pump();
      await tester.pump();
      expect(find.text('— × — · 1024 B'), findsNWidgets(3));
      expect(find.text('Could not load file details'), findsNWidgets(3));
      expect(find.text('The service is unavailable'), findsNWidgets(3));
      expect(find.textContaining('ExifTool'), findsNothing);
      expect(
        find.widgetWithText(TextButton, 'Retry details'),
        findsNWidgets(3),
      );
      for (final image in images.requests.toList()) {
        image.respond(status: 500);
        image.complete(const []);
      }
      await tester.pump();
      await tester.pump();
      expect(find.widgetWithText(TextButton, 'Reload image'), findsNWidgets(3));
      expect(
        find.widgetWithText(TextButton, 'Retry details'),
        findsNWidgets(3),
      );
      await tester.scrollUntilVisible(
        find.text('Skip group'),
        200,
        scrollable: find.byType(Scrollable).first,
        maxScrolls: 8,
      );
      await tester.tap(find.text('Skip group'));
      await tester.pump();
      await tester.pump();
      expect(find.text('8000 × 6000 · 1024 B'), findsOneWidget);
      expect(find.text('2000 × 1000 · 1024 B'), findsOneWidget);
      expect(find.text('Could not load file details'), findsNWidgets(2));
      final candidate = find.byWidgetPredicate(
        (widget) =>
            widget is GalleryComparisonDetails && widget.member.mediaId == 'c',
      );
      final imageReadsBeforeRetry = images.requests.length;
      await tester.ensureVisible(
        find.descendant(
          of: candidate,
          matching: find.widgetWithText(TextButton, 'Retry details'),
        ),
      );
      await tester.tap(
        find.descendant(
          of: candidate,
          matching: find.widgetWithText(TextButton, 'Retry details'),
        ),
      );
      await tester.pump();
      expect(find.text('Loading details…'), findsOneWidget);
      expect(reads.where((id) => id == 'c'), hasLength(3));
      expect(images.requests.length, imageReadsBeforeRetry);
      retry.complete(
        http.Response(
          jsonEncode(
            photoMetadata('c').copyWith(width: 1250, height: 625).toJson(),
          ),
          200,
        ),
      );
      await tester.pump();
      await tester.pump();
      expect(find.text('1250 × 625 · 1024 B'), findsOneWidget);
      expect(find.text('Loading details…'), findsNothing);
      expect(find.text('Could not load file details'), findsOneWidget);
      expect(find.textContaining('ExifTool'), findsNothing);
      await _finish(tester, session);
    },
  );

  testWidgets(
    'typed timeout and malformed details have specific safe messages',
    (tester) async {
      final catalog = ManagedCatalogRepository([managedPhoto('a')]);
      var reads = 0;
      const privateResponse = 'private/photo.jpg access-secret {invalid JSON';
      final session = managedSession(
        catalog,
        MockClient((_) async {
          if (++reads == 1) {
            return http.Response(
              jsonEncode(
                const GalleryErrorResponse(GalleryErrorCode.timeout).toJson(),
              ),
              504,
            );
          }
          return http.Response(privateResponse, 200);
        }),
        ControlledClient(),
      );
      await tester.pumpWidget(
        MaterialApp(
          theme: createLightTheme(),
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: GalleryComparisonDetails(
              member: _job.groups.first.items.first,
              item: catalog.items.single,
              repository: session.management,
              onRevisionMismatch: () =>
                  fail('A timeout is not a revision mismatch'),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(
        find.text('The server took too long to load the details. Try again.'),
        findsOneWidget,
      );
      expect(find.textContaining('ExifTool'), findsNothing);
      await tester.tap(find.widgetWithText(TextButton, 'Retry details'));
      await tester.pump();
      await tester.pump();
      expect(reads, 2);
      expect(find.text('Could not read the file details.'), findsOneWidget);
      expect(find.textContaining('private/photo.jpg'), findsNothing);
      expect(find.textContaining('access-secret'), findsNothing);
      expect(find.textContaining('ExifTool'), findsNothing);
      await _finish(tester, session);
    },
  );
}
