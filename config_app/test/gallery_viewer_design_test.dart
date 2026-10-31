import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:config_app/features/gallery/domain/gallery_item.dart';
import 'package:config_app/features/gallery/presentation/pages/single_item_viewer_page.dart';
import 'package:config_app/features/theme/presentation/theme.dart';
import 'package:config_app/src/gallery/gallery_session.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'gallery_image_loader_test.dart' show ControlledClient;
import 'support/gallery_management_harness.dart';

const _painting = ValueKey('viewer-test-painting');
final _bluePng = base64Decode(
  'iVBORw0KGgoAAAANSUhEUgAAAAgAAAAICAIAAABLbSncAAAAEElEQVR4nGNgYPiPAw0pCQCpcD/BFMrqcwAAAABJRU5ErkJggg==',
);

Widget _app(Widget child, ThemeData theme, {double textScale = 1}) => MaterialApp(
  theme: theme,
  locale: const Locale('en'),
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  builder: (context, content) => MediaQuery(
    data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(textScale)),
    child: content!,
  ),
  home: RepaintBoundary(key: _painting, child: child),
);

Future<void> _decode(WidgetTester tester, ControlledClient images) async {
  await tester.pump();
  images.requests.single.respond();
  images.requests.single.complete(_bluePng);
  final deadline = Stopwatch()..start();
  while (find.byType(RawImage).evaluate().isEmpty && deadline.elapsed < const Duration(seconds: 2)) {
    await tester.runAsync(() => Future<void>(() {}));
    await tester.pump();
  }
  expect(
    find.byType(RawImage),
    findsOneWidget,
    reason: 'The actual original must decode before checking the viewer paint',
  );
}

Future<(ByteData, int)> _capture(WidgetTester tester) async {
  final boundary = tester.renderObject<RenderRepaintBoundary>(find.byKey(_painting));
  return (await tester.runAsync(() async {
    final image = await boundary.toImage(pixelRatio: 1);
    try {
      return ((await image.toByteData(format: ui.ImageByteFormat.rawRgba))!, image.width);
    } finally {
      image.dispose();
    }
  }))!;
}

Color _pixel((ByteData, int) pixels, Offset point) {
  final (bytes, width) = pixels;
  final offset = (point.dy.floor() * width + point.dx.floor()) * 4;
  return Color.fromARGB(
    bytes.getUint8(offset + 3),
    bytes.getUint8(offset),
    bytes.getUint8(offset + 1),
    bytes.getUint8(offset + 2),
  );
}

Future<void> _finish(WidgetTester tester, GallerySession session) async {
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pump();
  await tester.runAsync(session.close);
  PaintingBinding.instance.imageCache.clear();
  PaintingBinding.instance.imageCache.clearLiveImages();
  expect(tester.takeException(), isNull);
}

void main() {
  testWidgets('wide viewer paints the app toolbar and metadata card without replacing the original', (tester) async {
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final theme = createLightTheme();
    final catalog = ManagedCatalogRepository([managedPhoto('a')]);
    final metadata = Completer<http.Response>();
    var requests = 0;
    final images = ControlledClient();
    final session = managedSession(
      catalog,
      MockClient((_) {
        requests++;
        return metadata.future;
      }),
      images,
    );
    await tester.pumpWidget(
      _app(
        SingleItemViewerPage(item: catalog.items.single, session: session, capabilities: catalog.capabilities),
        theme,
      ),
    );
    await _decode(tester, images);
    final original = tester.widget<RawImage>(find.byType(RawImage)).image;
    expect(requests, 0);
    final toolbar = tester.widget<AppBar>(find.byKey(const ValueKey('viewer-toolbar')));
    expect((toolbar.title! as Text).data, 'a.jpg');
    await tester.tap(find.byTooltip('File information'));
    await tester.pump();
    expect(requests, 1);
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
    expect(find.byTooltip('Back').hitTestable(), findsOneWidget);
    expect(find.byTooltip('Rotate right 90°').hitTestable(), findsOneWidget);
    final card = tester.getRect(find.byKey(const ValueKey('viewer-metadata-card')));
    expect(card.width, 360);
    expect(card.right, 1184);
    expect(card.top, kToolbarHeight + 16);
    final loadingPaint = await _capture(tester);
    expect(_pixel(loadingPaint, const Offset(600, 4)), theme.colorScheme.surface);
    expect(_pixel(loadingPaint, Offset(card.right - 24, card.top + 16)), theme.colorScheme.surfaceContainerLow);
    expect(_pixel(loadingPaint, const Offset(4, 200)), theme.colorScheme.surfaceContainerLowest);
    metadata.complete(http.Response(jsonEncode(photoMetadata('a').toJson()), 200));
    await tester.pump();
    await tester.pump();
    expect(find.byType(LinearProgressIndicator), findsNothing);
    expect(find.text('Test camera'), findsOneWidget);
    expect(tester.widget<Text>(find.text('Camera')).style?.color, theme.colorScheme.onSurfaceVariant);
    expect(tester.widget<RawImage>(find.byType(RawImage)).image, same(original));
    final readyPaint = await _capture(tester);
    expect(
      _pixel(readyPaint, tester.getCenter(find.byType(RawImage))),
      const Color(0xFF0000FF),
      reason: 'The actual original remains painted beside the metadata card',
    );
    await tester.tap(find.byTooltip('File information'));
    await tester.pump();
    expect(find.byKey(const ValueKey('viewer-metadata-card')), findsNothing);
    await tester.tapAt(tester.getCenter(find.byType(RawImage)));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.byTooltip('Back').hitTestable(), findsNothing);
    final hiddenPaint = await _capture(tester);
    expect(_pixel(hiddenPaint, const Offset(600, 4)), theme.colorScheme.surfaceContainerLowest);
    expect(tester.widget<RawImage>(find.byType(RawImage)).image, same(original));
    expect(images.requests, hasLength(1));
    await _finish(tester, session);
  });

  testWidgets('compact dark viewer keeps themed error, retry, busy and missing states accessible', (tester) async {
    tester.view.physicalSize = const Size(320, 720);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final theme = createDarkTheme();
    final catalog = ManagedCatalogRepository([managedPhoto('a')]);
    final updates = StreamController<GalleryItem?>();
    final rotation = Completer<http.Response>();
    var metadataReads = 0;
    final images = ControlledClient();
    final session = managedSession(
      catalog,
      MockClient((request) async {
        if (request.url.pathSegments.last == 'rotate') return rotation.future;
        if (++metadataReads == 1) {
          return http.Response(jsonEncode(const GalleryErrorResponse(GalleryErrorCode.unavailable).toJson()), 503);
        }
        return http.Response(jsonEncode(photoMetadata('a').toJson()), 200);
      }),
      images,
    );
    await tester.pumpWidget(
      _app(
        SingleItemViewerPage(
          item: catalog.items.single,
          session: session,
          capabilities: catalog.capabilities,
          itemUpdates: updates.stream,
        ),
        theme,
        textScale: 1.5,
      ),
    );
    await _decode(tester, images);
    await tester.tap(find.byTooltip('File information'));
    await tester.pump();
    await tester.pump();
    expect(find.text('Could not load file details'), findsOneWidget);
    final card = tester.getRect(find.byKey(const ValueKey('viewer-metadata-card')));
    expect(card.left, 16);
    expect(card.right, 304);
    expect(card.bottom, 704);
    expect(card.top, greaterThan(kToolbarHeight));
    final errorPaint = await _capture(tester);
    expect(_pixel(errorPaint, const Offset(150, 4)), theme.colorScheme.surface);
    expect(_pixel(errorPaint, Offset(card.right - 24, card.top + 16)), theme.colorScheme.surfaceContainerLow);
    await tester.tap(find.widgetWithText(TextButton, 'Retry'));
    await tester.pump();
    await tester.pump();
    expect(metadataReads, 2);
    expect(find.text('Could not load file details'), findsNothing);
    expect(find.text('Test camera'), findsOneWidget);
    await tester.tap(find.byTooltip('Rotate left 90°'));
    await tester.pump();
    expect(tester.widget<IconButton>(find.widgetWithIcon(IconButton, Icons.rotate_left)).onPressed, isNull);
    expect(tester.widget<IconButton>(find.widgetWithIcon(IconButton, Icons.delete_outline)).onPressed, isNull);
    expect(tester.widget<IconButton>(find.widgetWithIcon(IconButton, Icons.arrow_back)).onPressed, isNull);
    expect(find.byTooltip('File information').hitTestable(), findsOneWidget);
    expect(find.byKey(const ValueKey('viewer-metadata-card')), findsOneWidget);
    expect(tester.takeException(), isNull);
    rotation.complete(http.Response(jsonEncode(photoMetadata('a', revision: '2').toJson()), 200));
    await tester.pump();
    await tester.pump();
    updates.add(null);
    await tester.pump();
    expect(find.text('File unavailable'), findsOneWidget);
    expect(find.byIcon(Icons.hide_image_outlined), findsOneWidget);
    expect(find.byTooltip('Back').hitTestable(), findsOneWidget);
    expect(find.byTooltip('Rotate left 90°'), findsNothing);
    final missingPaint = await _capture(tester);
    expect(_pixel(missingPaint, const Offset(4, 200)), theme.colorScheme.surfaceContainerLowest);
    await _finish(tester, session);
    await tester.runAsync(updates.close);
  });

  testWidgets('purge confirmation keeps the decoded original behind the modal through its transition', (tester) async {
    final catalog = ManagedCatalogRepository([]);
    final images = ControlledClient();
    var mutations = 0;
    final session = managedSession(
      catalog,
      MockClient((_) async {
        mutations++;
        return http.Response('{}', 200);
      }),
      images,
    );
    final entry = GalleryEntry(
      section: GalleryMediaSection.trash,
      mediaId: 'trash-a',
      name: 'a.jpg',
      path: 'a.jpg',
      kind: GalleryEntryKind.image,
      sourceRevision: '1',
      fileChanged: DateTime(2026),
      sizeBytes: 1024,
    );
    await tester.pumpWidget(
      _app(
        SingleItemViewerPage(
          item: session.management.mediaItem(entry, 'test'),
          session: session,
          capabilities: catalog.capabilities,
          entry: entry,
        ),
        createLightTheme(),
      ),
    );
    await _decode(tester, images);
    final original = tester.widget<RawImage>(find.byType(RawImage)).image;
    await tester.tap(find.byTooltip('Delete permanently'));
    await tester.pump();
    expect(find.byType(AlertDialog), findsOneWidget);
    for (var elapsed = 0; elapsed <= 240; elapsed += 16) {
      expect(
        find.byType(RawImage),
        findsOneWidget,
        reason: 'The purge dialog must not suspend the original at ${elapsed}ms',
      );
      expect(tester.widget<RawImage>(find.byType(RawImage)).image, same(original));
      expect(find.byType(CircularProgressIndicator), findsNothing);
      await tester.pump(const Duration(milliseconds: 16));
    }
    await tester.tap(find.widgetWithText(TextButton, 'Cancel'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 240));
    expect(find.byType(AlertDialog), findsNothing);
    expect(tester.widget<RawImage>(find.byType(RawImage)).image, same(original));
    final afterDialog = await _capture(tester);
    expect(_pixel(afterDialog, tester.getCenter(find.byType(RawImage))), const Color(0xFF0000FF));
    expect(images.requests, hasLength(1));
    expect(mutations, 0);
    await _finish(tester, session);
  });
}
