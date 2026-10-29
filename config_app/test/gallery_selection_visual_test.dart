import 'dart:convert';

import 'package:config_app/features/gallery/presentation/bloc/gallery_bloc.dart';
import 'package:config_app/features/gallery/presentation/bloc/gallery_management_bloc.dart';
import 'package:config_app/features/gallery/presentation/widgets/gallery_widget.dart';
import 'package:config_app/features/theme/presentation/theme.dart';
import 'package:config_app/src/gallery/gallery_image_widget.dart';
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

Future<({GalleryBloc bloc, ControlledClient images})> mountGallery(
  WidgetTester tester, {
  http.Client? operations,
}) async {
  final item = GalleryItem(
    uri: Uri.parse('http://frame.local/original.jpg'),
    title: 'Photo',
    mediaId: 'photo',
    revision: '1',
    kind: GalleryEntryKind.image,
    thumbnailBaseUri: Uri.parse('http://frame.local/thumbnail'),
    thumbnailPolicy: const GalleryThumbnailPolicy(
      version: 1,
      sizes: [GalleryThumbnailSize.small],
    ),
    thumbnailsEnabled: true,
  );
  final catalog = ManagedCatalogRepository([item]);
  final images = ControlledClient();
  final session = managedSession(
    catalog,
    operations ?? MockClient((_) async => http.Response('{"entries":[]}', 200)),
    images,
  );
  final bloc = GalleryBloc(
    initialState: LoadedGalleryState(items: catalog.items),
    client: GalleryTestClient(),
    session: session,
  );
  addTearDown(() async {
    await bloc.close();
    await session.close();
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();
  });
  await tester.pumpWidget(
    MaterialApp(
      theme: createLightTheme(),
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider.value(value: bloc, child: const GalleryWidget()),
    ),
  );
  await tester.pump();
  images.requests.single.respond();
  images.requests.single.complete(
    base64Decode(
      'iVBORw0KGgoAAAANSUhEUgAAAAgAAAAICAIAAABLbSncAAAAEElEQVR4nGNgYPiPAw0pCQCpcD/BFMrqcwAAAABJRU5ErkJggg==',
    ),
  );
  final rawImage = find.descendant(
    of: find.byKey(const ValueKey('photo')),
    matching: find.byType(RawImage),
  );
  final deadline = Stopwatch()..start();
  while (rawImage.evaluate().isEmpty &&
      deadline.elapsed < const Duration(seconds: 2)) {
    await tester.runAsync(() => Future<void>(() {}));
    await tester.pump();
  }
  expect(
    rawImage,
    findsOneWidget,
    reason: 'The real thumbnail decoder must be ready before selection',
  );
  return (bloc: bloc, images: images);
}

void main() {
  testWidgets(
    'selection and clearing retain the displayed thumbnail through every animation frame',
    (tester) async {
      final (:images, bloc: _) = await mountGallery(tester);
      final tile = find.byKey(const ValueKey('photo'));
      final rawImage = find.descendant(
        of: tile,
        matching: find.byType(RawImage),
      );
      final image = find.descendant(
        of: tile,
        matching: find.byType(GalleryImage),
      );
      final imageState = tester.state(image);
      final checkbox = find.descendant(
        of: tile,
        matching: find.byType(Checkbox),
      );
      final checkboxState = tester.state(checkbox);
      final frame = tester.widget<RawImage>(rawImage).image;
      final size = tester.getSize(rawImage);
      final imageBounds = tester.getRect(rawImage);
      final tileBounds = tester.getRect(tile);
      final bar = find.byKey(const ValueKey('gallery-selection-bar'));
      final barBounds = tester.getRect(bar);
      final decodeWidth = tester.widget<GalleryImage>(image).decodeWidth;
      final requestKey = tester.widget<GalleryImage>(image).request.key;
      for (final selected in [true, false]) {
        await tester.tap(
          find.descendant(of: tile, matching: find.byType(Checkbox)),
        );
        await tester.pump();
        expect(
          tester
              .widget<Checkbox>(
                find.descendant(of: tile, matching: find.byType(Checkbox)),
              )
              .value,
          selected,
        );
        for (var elapsed = 0; elapsed <= 240; elapsed += 16) {
          expect(
            rawImage,
            findsOneWidget,
            reason:
                'Selection must never replace a decoded frame with a loading indicator at ${elapsed}ms',
          );
          expect(tester.state(image), same(imageState));
          expect(tester.state(checkbox), same(checkboxState));
          expect(tester.widget<RawImage>(rawImage).image, same(frame));
          expect(tester.getSize(rawImage), size);
          expect(tester.getRect(rawImage), imageBounds);
          expect(tester.getRect(tile), tileBounds);
          expect(tester.getRect(bar), barBounds);
          expect(tester.widget<GalleryImage>(image).decodeWidth, decodeWidth);
          expect(tester.widget<GalleryImage>(image).request.key, requestKey);
          await tester.pump(const Duration(milliseconds: 16));
        }
      }
      expect(images.requests, hasLength(1));
      await tester.tap(find.text('Trash'));
      await tester.pump();
      await tester.pump();
      expect(find.text('0 selected'), findsOneWidget);
      for (final icon in [
        Icons.restore_from_trash,
        Icons.delete_forever,
        Icons.close,
      ]) {
        expect(
          tester
              .widget<IconButton>(find.widgetWithIcon(IconButton, icon))
              .onPressed,
          isNull,
        );
      }
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
      expect(tester.takeException(), isNull);
    },
  );
  testWidgets(
    'operation details keep decoded background media while opaque pages suspend it',
    (tester) async {
      final (:bloc, :images) = await mountGallery(
        tester,
        operations: MockClient((request) async {
          final command = GalleryOperationRequest.fromJson(
            jsonDecode(request.body) as Map<String, dynamic>,
          );
          return http.Response(
            jsonEncode(
              GalleryOperationResult(
                operationId: command.operationId,
                items: const [
                  GalleryOperationItemResult(
                    mediaId: 'photo',
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
      final tile = find.byKey(const ValueKey('photo'));
      final image = find.descendant(
        of: tile,
        matching: find.byType(GalleryImage),
      );
      final rawImage = find.descendant(
        of: tile,
        matching: find.byType(RawImage),
      );
      final frame = tester.widget<RawImage>(rawImage).image;
      final imageState = tester.state(image);
      await tester.tap(
        find.descendant(of: tile, matching: find.byType(Checkbox)),
      );
      await tester.pump();
      await tester.tap(find.text('Move to trash'));
      await confirmTrashDialog(tester);
      await tester.pump();
      await tester.pump();
      final management = tester.element(tile).read<GalleryManagementBloc>();
      expect(management.state.busy, isFalse);
      expect(management.state.failures.single.mediaId, 'photo');
      await tester.tap(find.text('Operation details'));
      await tester.pump();
      for (var frameIndex = 0; frameIndex < 20; frameIndex++) {
        expect(tester.widget<GalleryImage>(image).active, isTrue);
        expect(tester.state(image), same(imageState));
        expect(rawImage, findsOneWidget);
        expect(tester.widget<RawImage>(rawImage).image, same(frame));
        expect(images.requests, hasLength(1));
        await tester.pump(const Duration(milliseconds: 16));
      }
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Failed files: 1'), findsOneWidget);
      await tester.tap(find.text('Close'));
      await tester.pump();
      for (var frameIndex = 0; frameIndex < 20; frameIndex++) {
        expect(rawImage, findsOneWidget);
        expect(tester.widget<RawImage>(rawImage).image, same(frame));
        expect(images.requests, hasLength(1));
        await tester.pump(const Duration(milliseconds: 16));
      }
      final route = MaterialPageRoute<void>(
        builder: (_) => const Scaffold(body: Text('Other page')),
      );
      final navigator = tester.state<NavigatorState>(find.byType(Navigator));
      navigator.push(route);
      await tester.pump();
      final animation = route.animation!;
      var elapsed = Duration.zero;
      while (animation.status != AnimationStatus.completed &&
          elapsed < const Duration(seconds: 2)) {
        await tester.pump(const Duration(milliseconds: 16));
        elapsed += const Duration(milliseconds: 16);
      }
      await tester.pump();
      final hiddenImage = find.byType(GalleryImage, skipOffstage: false);
      expect(animation.status, AnimationStatus.completed);
      expect(TickerMode.valuesOf(tester.element(hiddenImage)).enabled, isFalse);
      expect(tester.widget<GalleryImage>(hiddenImage).active, isFalse);
      navigator.pop();
      await tester.pump();
      elapsed = Duration.zero;
      while (animation.status != AnimationStatus.dismissed &&
          elapsed < const Duration(seconds: 2)) {
        await tester.pump(const Duration(milliseconds: 16));
        elapsed += const Duration(milliseconds: 16);
      }
      expect(animation.status, AnimationStatus.dismissed);
      await tester.pump();
      expect(tester.widget<GalleryImage>(image).active, isTrue);
      expect(bloc.isClosed, isFalse);
      (bloc.repository as ManagedCatalogRepository).items = [];
      await management.refresh();
      await tester.pump();
      expect(management.state.items, isEmpty);
      await tester.tap(find.text('Operation details'));
      await tester.pump();
      expect(
        find.descendant(
          of: find.byType(AlertDialog),
          matching: find.text('Photo'),
        ),
        findsOneWidget,
        reason: 'A refresh that loses the original entry must retain its failure name',
      );
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'large failure details show ten names and total without building the rest',
    (tester) async {
      final failures = List.generate(
        50001,
        (index) => GalleryOperationItemResult(
          mediaId: 'failed-file-$index',
          state: GalleryItemOperationState.failed,
          error: GalleryErrorCode.forbidden,
        ),
      );
      await tester.pumpWidget(
        MaterialApp(
          theme: createLightTheme(),
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: GalleryFailureDetailsDialog(
              state: GalleryManagementState(failures: failures),
            ),
          ),
        ),
      );
      expect(find.text('Failed files: 50001'), findsOneWidget);
      expect(find.text('Showing the first 10 files.'), findsOneWidget);
      for (var index = 0; index < 10; index++) {
        expect(
          find.text('failed-file-$index', skipOffstage: false),
          findsOneWidget,
        );
      }
      expect(find.text('failed-file-10', skipOffstage: false), findsNothing);
      expect(find.text('failed-file-50000', skipOffstage: false), findsNothing);
      expect(tester.takeException(), isNull);
    },
  );
}
