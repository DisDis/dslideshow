import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:config_app/features/gallery/presentation/bloc/gallery_duplicates_bloc.dart';
import 'package:config_app/features/gallery/presentation/pages/gallery_duplicates_page.dart';
import 'package:config_app/features/gallery/presentation/widgets/gallery_comparison_details.dart';
import 'package:config_app/features/gallery/presentation/widgets/gallery_file_path.dart';
import 'package:config_app/features/gallery/presentation/widgets/gallery_recommendation_badge.dart';
import 'package:config_app/features/theme/presentation/theme.dart';
import 'package:config_app/src/gallery/gallery_session.dart';
import 'package:config_app/src/gallery/gallery_image_widget.dart';
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
    GalleryDuplicateGroup(
      groupId: 'similar',
      mode: GalleryDuplicateMode.similar,
      items: [
        GalleryDuplicateMember(
          section: GalleryMediaSection.published,
          mediaId: 'a',
          sourceRevision: '1',
          path: 'a.jpg',
          name: 'a.jpg',
          sizeBytes: 1024,
          width: 8000,
          height: 6000,
        ),
        GalleryDuplicateMember(
          section: GalleryMediaSection.published,
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

const _captureKey = ValueKey('duplicate-card-paint');

Future<(ByteData, int, Offset)> _capture(WidgetTester tester) async {
  final finder = find.byKey(_captureKey);
  final boundary = tester.renderObject<RenderRepaintBoundary>(finder);
  final offset = tester.getTopLeft(finder);
  return (await tester.runAsync(() async {
    final image = await boundary.toImage(pixelRatio: 1);
    try {
      return ((await image.toByteData(format: ui.ImageByteFormat.rawRgba))!, image.width, offset);
    } finally {
      image.dispose();
    }
  }))!;
}

Color _pixel((ByteData, int, Offset) capture, Offset global) {
  final (bytes, width, origin) = capture;
  final local = global - origin;
  final offset = (local.dy.floor() * width + local.dx.floor()) * 4;
  return Color.fromARGB(
    bytes.getUint8(offset + 3),
    bytes.getUint8(offset),
    bytes.getUint8(offset + 1),
    bytes.getUint8(offset + 2),
  );
}

Widget _app(GallerySession session, ManagedCatalogRepository catalog, {ThemeData? theme, double textScale = 1}) =>
    MaterialApp(
      theme: theme ?? createLightTheme(),
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(textScale)),
        child: child!,
      ),
      home: Scaffold(
        body: RepaintBoundary(
          key: _captureKey,
          child: GalleryDuplicatesPage(session: session, catalog: catalog.items, onRefresh: () async {}),
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
    'equal resolutions highlight the first whole card; moving the recommendation preserves media and manual selection',
    (tester) async {
      tester.view.physicalSize = const Size(1200, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final members = [
        for (var i = 0; i < 2; i++)
          GalleryDuplicateMember(
            section: GalleryMediaSection.published,
            mediaId: 'p$i',
            sourceRevision: '1',
            name: 'p$i.jpg',
            path: 'album/p$i.jpg',
            sizeBytes: 1000000 + i * 1000000,
            width: 2000,
            height: 1000,
          ),
      ];
      final job = _job.copyWith(
        groups: [GalleryDuplicateGroup(groupId: 'equal', mode: GalleryDuplicateMode.similar, items: members)],
      );
      final catalog = ManagedCatalogRepository([for (final member in members) managedPhoto(member.mediaId)]);
      final laterDetails = Completer<http.Response>();
      final images = ControlledClient();
      final session = managedSession(
        catalog,
        MockClient((request) async {
          if (request.url.pathSegments.contains('metadata')) {
            final member = members.singleWhere((m) => m.mediaId == request.url.pathSegments[5]);
            if (member.mediaId == 'p1') return laterDetails.future;
            return http.Response(
              jsonEncode(
                photoMetadata(member.mediaId)
                    .copyWith(width: member.width, height: member.height, sizeBytes: member.sizeBytes)
                    .toJson(),
              ),
              200,
            );
          }
          return duplicateResponse(request, job);
        }),
        images,
      );
      await tester.pumpWidget(_app(session, catalog));
      await tester.pump();
      await tester.pump();
      expect(find.text('Recommended to keep'), findsOneWidget);
      expect(find.text('Same resolution'), findsNothing);
      expect(find.byTooltip('Same resolution'), findsOneWidget);
      for (var i = 0; i < 2; i++) {
        final details = find.byWidgetPredicate((w) => w is GalleryComparisonDetails && w.member.mediaId == 'p$i');
        final resolution = find.descendant(of: details, matching: find.text('2000 × 1000'));
        expect(tester.widget<Text>(resolution).style!.color, i == 0 ? Colors.green.shade800 : const Color(0xff795800));
      }
      expect(
        tester.element(find.byType(CheckboxListTile).first).read<GalleryDuplicatesBloc>().state.decisions,
        isEmpty,
      );
      Finder details(String id) =>
          find.byWidgetPredicate((w) => w is GalleryComparisonDetails && w.member.mediaId == id);
      final firstCard = find.ancestor(of: details('p0'), matching: find.byType(Card));
      final otherCard = find.ancestor(of: details('p1'), matching: find.byType(Card));
      final badge = find.byType(GalleryRecommendationBadge);
      expect(find.descendant(of: firstCard, matching: badge), findsOneWidget);
      expect(find.descendant(of: otherCard, matching: badge), findsNothing);
      expect(
        tester.getRect(badge).bottom,
        lessThan(tester.getRect(find.descendant(of: firstCard, matching: find.byType(GalleryImage))).top),
      );
      final painted = await _capture(tester);
      final firstRect = tester.getRect(firstCard), otherRect = tester.getRect(otherCard);
      expect(
        _pixel(painted, Offset(firstRect.left + 1, firstRect.center.dy)),
        Colors.green.shade800,
        reason: 'The recommended card must paint a visible green frame, not only green resolution text',
      );
      expect(_pixel(painted, Offset(otherRect.left + 1, otherRect.center.dy)), isNot(Colors.green.shade800));
      final originalStates = {
        for (final element in find.byType(GalleryImage).evaluate())
          (element.widget as GalleryImage).request.key: (element as StatefulElement).state,
      };
      final imageReads = images.requests.length;
      final bloc = tester.element(details('p0')).read<GalleryDuplicatesBloc>();
      bloc.add(const GalleryDuplicatesEvent.decide('equal', 'p0', GalleryDuplicateDecision.trash));
      await tester.pump();
      laterDetails.complete(
        http.Response(
          jsonEncode(
            photoMetadata('p1').copyWith(width: 3000, height: 1000, sizeBytes: members.last.sizeBytes).toJson(),
          ),
          200,
        ),
      );
      await tester.pump();
      await tester.pump();
      expect(find.descendant(of: firstCard, matching: badge), findsNothing);
      expect(find.descendant(of: otherCard, matching: badge), findsOneWidget);
      expect(bloc.state.decisions, {'p0': GalleryDuplicateDecision.trash});
      expect(images.requests, hasLength(imageReads));
      for (final element in find.byType(GalleryImage).evaluate()) {
        expect(
          (element as StatefulElement).state,
          same(originalStates[(element.widget as GalleryImage).request.key]),
          reason: 'Moving the badge must preserve the mounted original and its request',
        );
      }
      await _finish(tester, session);
    },
  );

  testWidgets(
    'resolution recommendation covers off-page members without reading their metadata or changing selection',
    (tester) async {
      tester.view.physicalSize = const Size(1200, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final members = [
        for (var i = 0; i < 12; i++)
          GalleryDuplicateMember(
            section: GalleryMediaSection.published,
            mediaId: 'p$i',
            sourceRevision: '1',
            name: 'p$i.jpg',
            path: 'Photos/Trips/2026/Summer/p$i.jpg',
            sizeBytes: 1024 + i * 100,
            width: i == 0
                ? 1000
                : i == 11
                ? 3000
                : 1500,
            height: 1000,
          ),
      ];
      final job = _job.copyWith(
        groups: [GalleryDuplicateGroup(groupId: 'paged', mode: GalleryDuplicateMode.similar, items: members)],
      );
      final catalog = ManagedCatalogRepository([for (final member in members) managedPhoto(member.mediaId)]);
      final reads = <String>[];
      final session = managedSession(
        catalog,
        MockClient((request) async {
          if (request.url.pathSegments.contains('metadata')) {
            final id = request.url.pathSegments[5];
            reads.add(id);
            final member = members.singleWhere((m) => m.mediaId == id);
            return http.Response(
              jsonEncode(
                photoMetadata(id)
                    .copyWith(width: member.width, height: member.height, sizeBytes: member.sizeBytes)
                    .toJson(),
              ),
              200,
            );
          }
          return duplicateResponse(request, job);
        }),
        ControlledClient(),
      );
      await tester.pumpWidget(_app(session, catalog));
      await tester.pump();
      await tester.pump();
      expect(reads, isNotEmpty);
      expect(reads.toSet().difference({for (var i = 0; i < 10; i++) 'p$i'}), isEmpty);
      expect(find.text('Recommended to keep'), findsNothing);
      expect(find.byTooltip('Minimum resolution'), findsOneWidget);
      expect(find.byTooltip('Below maximum'), findsWidgets);
      expect(find.text('Same resolution'), findsNothing);
      expect(find.text('Takes less space; not a quality rating'), findsOneWidget);
      final bloc = tester.element(find.byType(CheckboxListTile).first).read<GalleryDuplicatesBloc>();
      expect(bloc.state.decisions, isEmpty);
      final resolution = tester.widget<Text>(find.text('1000 × 1000'));
      expect(resolution.style!.color, createLightTheme().colorScheme.error);
      final location = tester.widget<GalleryFilePath>(find.byType(GalleryFilePath).first);
      expect(location.style, GalleryFilePathStyle.nearestFolder);
      await tester.ensureVisible(find.byTooltip('Next page'));
      await tester.pump();
      await tester.tap(find.byTooltip('Next page'));
      await tester.pump();
      await tester.pump();
      expect(reads.toSet(), containsAll(['p10', 'p11']));
      await tester.scrollUntilVisible(
        find.text('Recommended to keep'),
        300,
        scrollable: find.byType(Scrollable).first,
        maxScrolls: 25,
      );
      expect(find.text('Recommended to keep'), findsOneWidget);
      expect(find.byTooltip('Reason: highest resolution in the group'), findsOneWidget);
      expect(find.text('Maximum resolution'), findsNothing);
      expect(tester.widget<Text>(find.text('3000 × 1000')).style!.color, Colors.green.shade800);
      expect(bloc.state.decisions, isEmpty);
      await _finish(tester, session);
    },
  );

  testWidgets('duplicate paths and coloured assessments fit 320px with enlarged text in the dark theme', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final members = [
      for (var i = 0; i < 3; i++)
        GalleryDuplicateMember(
          section: GalleryMediaSection.published,
          mediaId: 'p$i',
          sourceRevision: '1',
          name: 'p$i.jpg',
          path: 'Archive/Photos from the long family trip/2026/Originals/p$i.jpg',
          sizeBytes: 1024,
          width: (i + 1) * 1000,
          height: 1000,
        ),
    ];
    final job = _job.copyWith(
      groups: [GalleryDuplicateGroup(groupId: 'narrow', mode: GalleryDuplicateMode.similar, items: members)],
    );
    final catalog = ManagedCatalogRepository([for (final member in members) managedPhoto(member.mediaId)]);
    final session = managedSession(
      catalog,
      MockClient((request) async {
        if (request.url.pathSegments.contains('metadata')) {
          final member = members.singleWhere((m) => m.mediaId == request.url.pathSegments[5]);
          return http.Response(
            jsonEncode(photoMetadata(member.mediaId).copyWith(width: member.width, height: member.height).toJson()),
            200,
          );
        }
        return duplicateResponse(request, job);
      }),
      ControlledClient(),
    );
    await tester.pumpWidget(_app(session, catalog, theme: createDarkTheme(), textScale: 1.5));
    await tester.pump();
    await tester.pump();
    await tester.scrollUntilVisible(
      find.text('2000 × 1000'),
      300,
      scrollable: find.byType(Scrollable).first,
      maxScrolls: 25,
    );
    expect(tester.widget<Text>(find.text('2000 × 1000')).style!.color, Colors.amber.shade300);
    await tester.scrollUntilVisible(
      find.text('Recommended to keep'),
      300,
      scrollable: find.byType(Scrollable).first,
      maxScrolls: 25,
    );
    expect(find.text('Recommended to keep'), findsOneWidget);
    expect(tester.widget<Text>(find.text('3000 × 1000')).style!.color, Colors.green.shade300);
    expect(find.text('Takes less space; not a quality rating'), findsNothing);
    final bestPath = find.byWidgetPredicate(
      (widget) => widget is GalleryFilePath && widget.relativePath == members.last.path,
    );
    final expand = find.descendant(of: bestPath, matching: find.text('Full path'));
    await tester.ensureVisible(expand);
    await tester.pump();
    await tester.tap(expand);
    await tester.pump();
    expect(
      find.widgetWithText(SelectableText, '/Archive/Photos from the long family trip/2026/Originals/p2.jpg'),
      findsOneWidget,
    );
    await _finish(tester, session);
  });

  testWidgets('initial list loads every visible member and revisiting uses cached metadata', (tester) async {
    tester.view.physicalSize = const Size(1200, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final catalog = ManagedCatalogRepository([managedPhoto('a'), managedPhoto('b'), managedPhoto('c')]);
    final reads = <String>[];
    final session = managedSession(
      catalog,
      MockClient((request) async {
        if (request.url.pathSegments.contains('metadata')) {
          final id = request.url.pathSegments[5];
          reads.add(id);
          final data = photoMetadata(id).copyWith(width: id == 'c' ? 1250 : 6000, height: id == 'c' ? 625 : 4000);
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
    expect(find.text('6000 × 4000'), findsNWidgets(2));
    expect(find.text('8000 × 6000'), findsNothing);
    expect(find.text('1250 × 625'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Next group'),
      200,
      scrollable: find.byType(Scrollable).first,
      maxScrolls: 8,
    );
    await tester.tap(find.text('Next group'));
    await tester.pump();
    await tester.pump();
    expect(reads, ['a', 'b', 'c']);
    expect(find.text('6000 × 4000'), findsOneWidget);
    expect(find.text('1250 × 625'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Next group'),
      200,
      scrollable: find.byType(Scrollable).first,
      maxScrolls: 8,
    );
    await tester.tap(find.text('Next group'));
    await tester.pump();
    await tester.pump();
    expect(find.text('All current groups have been reviewed.'), findsOneWidget);
    await tester.tap(find.text('Review again'));
    await tester.pump();
    await tester.pump();
    expect(find.text('6000 × 4000'), findsNWidgets(2));
    expect(reads, ['a', 'b', 'c']);
    await _finish(tester, session);
  });

  testWidgets('failed exact metadata is explained even when similar group supplies dimensions; retry targets details', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 1200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final catalog = ManagedCatalogRepository([managedPhoto('a'), managedPhoto('b'), managedPhoto('c')]);
    final reads = <String>[];
    final retry = Completer<http.Response>();
    final images = ControlledClient();
    final session = managedSession(
      catalog,
      MockClient((request) async {
        if (request.url.pathSegments.contains('metadata')) {
          final id = request.url.pathSegments[5];
          reads.add(id);
          if (id == 'c' && reads.where((read) => read == 'c').length == 3) {
            return retry.future;
          }
          return http.Response(jsonEncode(const GalleryErrorResponse(GalleryErrorCode.unavailable).toJson()), 503);
        }
        return duplicateResponse(request, _job);
      }),
      images,
    );
    await tester.pumpWidget(_app(session, catalog));
    await tester.pump();
    await tester.pump();
    expect(find.text('— × —'), findsNWidgets(3));
    expect(find.text('Could not load file details'), findsNWidgets(3));
    expect(find.text('The service is unavailable'), findsNWidgets(3));
    expect(find.textContaining('ExifTool'), findsNothing);
    expect(find.widgetWithText(TextButton, 'Retry details'), findsNWidgets(3));
    for (final image in images.requests.toList()) {
      image.respond(status: 500);
      image.complete(const []);
    }
    await tester.pump();
    await tester.pump();
    expect(find.widgetWithText(TextButton, 'Reload image'), findsNWidgets(3));
    expect(find.widgetWithText(TextButton, 'Retry details'), findsNWidgets(3));
    await tester.scrollUntilVisible(
      find.text('Next group'),
      200,
      scrollable: find.byType(Scrollable).first,
      maxScrolls: 8,
    );
    await tester.tap(find.text('Next group'));
    await tester.pump();
    await tester.pump();
    expect(find.text('8000 × 6000'), findsOneWidget);
    expect(find.text('2000 × 1000'), findsOneWidget);
    expect(find.text('Could not load file details'), findsNWidgets(2));
    final candidate = find.byWidgetPredicate(
      (widget) => widget is GalleryComparisonDetails && widget.member.mediaId == 'c',
    );
    final imageReadsBeforeRetry = images.requests.length;
    await tester.ensureVisible(
      find.descendant(of: candidate, matching: find.widgetWithText(TextButton, 'Retry details')),
    );
    await tester.pump();
    await tester.tap(find.descendant(of: candidate, matching: find.widgetWithText(TextButton, 'Retry details')));
    await tester.pump();
    expect(find.text('Loading details…'), findsOneWidget);
    expect(reads.where((id) => id == 'c'), hasLength(3));
    expect(images.requests.length, imageReadsBeforeRetry);
    retry.complete(http.Response(jsonEncode(photoMetadata('c').copyWith(width: 1250, height: 625).toJson()), 200));
    await tester.pump();
    await tester.pump();
    expect(find.text('1250 × 625'), findsOneWidget);
    expect(find.text('Loading details…'), findsNothing);
    expect(find.text('Could not load file details'), findsOneWidget);
    expect(find.textContaining('ExifTool'), findsNothing);
    await _finish(tester, session);
  });

  testWidgets('typed timeout and malformed details have specific safe messages', (tester) async {
    final catalog = ManagedCatalogRepository([managedPhoto('a')]);
    var reads = 0;
    const privateResponse = 'private/photo.jpg access-secret {invalid JSON';
    final session = managedSession(
      catalog,
      MockClient((_) async {
        if (++reads == 1) {
          return http.Response(jsonEncode(const GalleryErrorResponse(GalleryErrorCode.timeout).toJson()), 504);
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
            onRevisionMismatch: () => fail('A timeout is not a revision mismatch'),
          ),
        ),
      ),
    );
    await tester.pump();
    expect(find.text('The server took too long to load the details. Try again.'), findsOneWidget);
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
  });
}
