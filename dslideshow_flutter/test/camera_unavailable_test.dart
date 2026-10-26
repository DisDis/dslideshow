import 'dart:async';
import 'dart:convert';

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/sessions/cameras_screen_session.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/cameras_screen_widget.dart';
import 'package:dslideshow_flutter/src/service/camera_snapshot_client.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

final _png = base64Decode(
  'iVBORw0KGgoAAAANSUhEUgAAAAIAAAACCAYAAABytg0kAAAAEUlEQVR4nGP4z8DwH4QZYAwAR8oH+WdZbrcAAAAASUVORK5CYII=',
);

SpecialScreenConfig _screen(CamerasScreenOptions options) =>
    SpecialScreenConfig(
      id: 'cameras',
      type: SpecialScreenType.cameras,
      options: options,
    );

Widget _app(
  CamerasScreenSession session, {
  Locale locale = const Locale('en'),
}) => MaterialApp(
  locale: locale,
  supportedLocales: AppLocalizations.supportedLocales,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  home: Scaffold(body: CamerasScreenWidget(session: session)),
);

void main() {
  test('default camera client uses the configured request timeout', () {
    final session = CamerasScreenSession(
      _screen(CamerasScreenOptions(requestTimeoutMs: 1250)),
    );
    addTearDown(session.dispose);
    expect(session.client.timeout, const Duration(milliseconds: 1250));
  });

  for (final mode in CameraDisplayMode.values) {
    testWidgets('$mode presents unavailable cameras after failed preparation', (
      tester,
    ) async {
      final requested = <String>[];
      final session = CamerasScreenSession(
        _screen(
          CamerasScreenOptions(
            mode: mode,
            cameras: [
              CameraConfig(id: 'a', name: 'Door', url: 'http://camera/a'),
              CameraConfig(id: 'b', name: 'Yard', url: 'http://camera/b'),
            ],
          ),
        ),
        cameraIndex: 1,
        client: CameraSnapshotClient(
          createClient: () => MockClient((request) async {
            requested.add(request.url.path);
            return http.Response('offline', 503);
          }),
        ),
      );
      addTearDown(session.dispose);
      expect(await session.prepare(), true);
      expect(session.images, isEmpty);
      expect(session.failed, {0, 1});
      if (mode == CameraDisplayMode.sequence) {
        expect(requested, ['/b', '/a']);
        expect(session.cameraIndex, 1);
      } else {
        expect(requested, ['/a', '/b']);
      }
      await tester.pumpWidget(_app(session, locale: const Locale('ru')));
      await tester.pumpAndSettle();
      final count = mode == CameraDisplayMode.grid ? 2 : 1;
      expect(find.text('Нет изображения'), findsNWidgets(count));
      expect(find.byIcon(Icons.videocam_off), findsNWidgets(count));
      expect(find.byType(Image), findsNothing);
      expect(find.text('Yard'), findsOneWidget);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
    });
  }

  testWidgets(
    'failed refresh removes a stale image and a later refresh recovers',
    (tester) async {
      var available = true;
      var requests = 0;
      final session = CamerasScreenSession(
        _screen(
          CamerasScreenOptions(
            refreshIntervalMs: 100,
            cameras: [CameraConfig(id: 'a', url: 'http://camera/a')],
          ),
        ),
        client: CameraSnapshotClient(
          createClient: () => MockClient((_) async {
            requests++;
            return available
                ? http.Response.bytes(_png, 200)
                : http.Response('offline', 503);
          }),
        ),
      );
      addTearDown(session.dispose);
      expect(await tester.runAsync(session.prepare), true);
      await tester.pumpWidget(_app(session));
      await tester.pump();
      expect(find.byType(Image), findsOneWidget);
      final oldImage = MemoryImage(session.images[0]!);
      session.setActive(true);
      available = false;
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pump();
      expect(requests, 2);
      expect(session.images, isEmpty);
      expect(session.failed, {0});
      expect(find.byType(Image), findsNothing);
      expect(find.text('No image'), findsOneWidget);
      expect(PaintingBinding.instance.imageCache.containsKey(oldImage), false);

      available = true;
      await tester.pump(const Duration(milliseconds: 100));
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 20)),
      );
      await tester.pump();
      await tester.pump();
      expect(requests, 3);
      expect(session.images, hasLength(1));
      expect(session.failed, isEmpty);
      expect(find.byType(Image), findsOneWidget);
      expect(find.text('No image'), findsNothing);
      session.setActive(false);
      await tester.pumpWidget(const SizedBox());
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('an undecodable snapshot shows the unavailable state', (
    tester,
  ) async {
    final session = CamerasScreenSession(
      _screen(
        CamerasScreenOptions(
          cameras: [CameraConfig(id: 'a', url: 'http://camera/a')],
        ),
      ),
      client: CameraSnapshotClient(
        createClient: () => MockClient(
          (_) async => http.Response.bytes(_png.sublist(0, 8), 200),
        ),
      ),
    );
    addTearDown(session.dispose);
    expect(await tester.runAsync(session.prepare), true);
    expect(session.images, isEmpty);
    expect(session.failed, {0});
    await tester.pumpWidget(_app(session));
    await tester.pumpAndSettle();
    expect(find.text('No image'), findsOneWidget);
    expect(find.byType(Image), findsNothing);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets(
    'empty screens and narrow camera tiles keep a readable placeholder',
    (tester) async {
      final empty = CamerasScreenSession(_screen(CamerasScreenOptions()));
      addTearDown(empty.dispose);
      expect(await empty.prepare(), false);
      await tester.pumpWidget(_app(empty));
      await tester.pumpAndSettle();
      expect(find.text('No image'), findsOneWidget);
      final session = CamerasScreenSession(
        _screen(
          CamerasScreenOptions(
            columns: 16,
            cameras: List.generate(
              16,
              (index) => CameraConfig(
                id: '$index',
                name: 'Camera $index',
                url: 'http://camera/$index',
              ),
            ),
          ),
        ),
      );
      addTearDown(session.dispose);
      await tester.pumpWidget(_app(session, locale: const Locale('ru')));
      await tester.pumpAndSettle();
      expect(find.text('Нет изображения'), findsNWidgets(16));
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
    },
  );

  test('cancelled preparation remains unavailable to the slideshow', () async {
    final response = Completer<http.StreamedResponse>();
    final session = CamerasScreenSession(
      _screen(
        CamerasScreenOptions(
          cameras: [CameraConfig(id: 'a', url: 'http://camera/a')],
        ),
      ),
      client: CameraSnapshotClient(
        createClient: () => MockClient.streaming((_, _) => response.future),
      ),
    );
    addTearDown(session.dispose);
    final prepared = session.prepare();
    session.setActive(false);
    expect(await prepared, false);
    response.complete(http.StreamedResponse(Stream.value(_png), 200));
    await Future<void>.delayed(Duration.zero);
    expect(session.images, isEmpty);
    expect(session.failed, isEmpty);
    session.dispose();
    expect(await session.prepare(), false);
  });
}
