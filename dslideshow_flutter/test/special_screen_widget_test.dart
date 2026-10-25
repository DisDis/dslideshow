import 'dart:async';
import 'dart:convert';

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/sessions/cameras_screen_session.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/sessions/clock_screen_session.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/cameras_screen_widget.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/clock_screen_widget.dart';
import 'package:dslideshow_flutter/src/service/camera_snapshot_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

final png = base64Decode(
  'iVBORw0KGgoAAAANSUhEUgAAAAIAAAACCAYAAABytg0kAAAAEUlEQVR4nGP4z8DwH4QZYAwAR8oH+WdZbrcAAAAASUVORK5CYII=',
);

void main() {
  test(
    'disposing camera preparation cancels work and discards a late response',
    () async {
      final response = Completer<http.StreamedResponse>();
      var responseCancelled = false;
      final body = StreamController<List<int>>(
        onCancel: () {
          responseCancelled = true;
        },
      );
      final session = CamerasScreenSession(
        SpecialScreenConfig(
          id: 'camera',
          type: SpecialScreenType.cameras,
          options: CamerasScreenOptions(
            cameras: [CameraConfig(id: 'a', url: 'http://camera/a')],
          ),
        ),
        client: CameraSnapshotClient(
          createClient: () => MockClient.streaming((_, _) => response.future),
        ),
      );
      var notifications = 0;
      session.addListener(() {
        notifications++;
      });
      final preparation = session.prepare();
      await Future<void>.delayed(Duration.zero);
      session.dispose();
      expect(await preparation, false);
      response.complete(http.StreamedResponse(body.stream, 200));
      await Future<void>.delayed(Duration.zero);
      expect(responseCancelled, true);
      expect(session.images, isEmpty);
      expect(session.active, false);
      expect(notifications, 0);
      session.dispose();
      await body.close();
    },
  );

  testWidgets('repeated activation does not postpone camera refresh', (
    tester,
  ) async {
    var requests = 0;
    final session = CamerasScreenSession(
      SpecialScreenConfig(
        id: 'camera',
        type: SpecialScreenType.cameras,
        options: CamerasScreenOptions(
          refreshIntervalMs: 100,
          cameras: [CameraConfig(id: 'a', url: 'http://camera/a')],
        ),
      ),
      client: CameraSnapshotClient(
        createClient: () => MockClient((_) async {
          requests++;
          return http.Response.bytes(png, 200);
        }),
      ),
    );
    addTearDown(session.dispose);
    expect(await tester.runAsync(session.prepare), true);
    session.setActive(true);
    await tester.pump(const Duration(milliseconds: 50));
    session.setActive(true);
    await tester.pump(const Duration(milliseconds: 50));
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 20)),
    );
    expect(requests, 2);
    session.dispose();
  });
  testWidgets(
    'clock updates at midnight, formats 12 hours and stops when hidden',
    (tester) async {
      var now = DateTime(2026, 10, 25, 23, 59, 59);
      final options = ClockScreenOptions(timeFormat: ClockTimeFormat.h12);
      final session = ClockScreenSession(
        SpecialScreenConfig(
          id: 'clock',
          type: SpecialScreenType.clock,
          options: options,
        ),
        now: () => now,
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: ClockScreenWidget(session: session)),
        ),
      );
      session.setActive(true);
      await tester.pump();
      expect(find.text('11:59 PM'), findsOneWidget);
      now = DateTime(2026, 10, 26);
      await tester.pump(const Duration(seconds: 1));
      expect(find.text('12:00 AM'), findsOneWidget);
      expect(find.text('26.10.2026'), findsOneWidget);
      session.setActive(false);
      await tester.pump();
      now = DateTime(2026, 10, 26, 12);
      await tester.pump(const Duration(minutes: 1));
      expect(find.text('12:00 AM'), findsOneWidget);
      session.setActive(true);
      await tester.pump();
      expect(find.text('12:00 PM'), findsOneWidget);
      await tester.pumpWidget(const SizedBox());
      session.dispose();
      await tester.pump(const Duration(minutes: 1));
      expect(tester.takeException(), isNull);
    },
  );
  testWidgets(
    'camera sequence skips unavailable sources, refreshes and suspends',
    (tester) async {
      final urls = <String>[];
      final options = CamerasScreenOptions(
        mode: CameraDisplayMode.sequence,
        refreshIntervalMs: 100,
        cameras: [
          CameraConfig(id: 'bad', url: 'http://camera/bad'),
          CameraConfig(id: 'good', name: 'Door', url: 'http://camera/good'),
        ],
      );
      final session = CamerasScreenSession(
        SpecialScreenConfig(
          id: 'cam',
          type: SpecialScreenType.cameras,
          options: options,
        ),
        client: CameraSnapshotClient(
          createClient: () => MockClient((request) async {
            urls.add(request.url.path);
            return request.url.path == '/bad'
                ? http.Response('offline', 503)
                : http.Response.bytes(png, 200);
          }),
        ),
      );
      final ready = await tester.runAsync(session.prepare);
      expect(ready, true);
      expect(session.cameraIndex, 1);
      expect(urls, ['/bad', '/good']);
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: CamerasScreenWidget(session: session)),
        ),
      );
      session.setActive(true);
      await tester.pump(const Duration(milliseconds: 100));
      await tester.runAsync(() async {
        await Future<void>.delayed(const Duration(milliseconds: 20));
      });
      expect(urls, ['/bad', '/good', '/good']);
      expect(find.text('Door'), findsOneWidget);
      session.setActive(false);
      await tester.pump(const Duration(seconds: 10));
      expect(urls, hasLength(3));
      await tester.pumpWidget(const SizedBox());
      session.dispose();
      await tester.pump();
      expect(tester.takeException(), isNull);
    },
  );
  testWidgets('grid keeps a working camera visible beside a failed one', (
    tester,
  ) async {
    final session = CamerasScreenSession(
      SpecialScreenConfig(
        id: 'cam',
        type: SpecialScreenType.cameras,
        options: CamerasScreenOptions(
          cameras: [
            CameraConfig(id: 'a', name: 'A', url: 'http://camera/a'),
            CameraConfig(id: 'b', name: 'B', url: 'http://camera/b'),
          ],
        ),
      ),
      client: CameraSnapshotClient(
        createClient: () => MockClient(
          (request) async => request.url.path == '/a'
              ? http.Response.bytes(png, 200)
              : http.Response('offline', 503),
        ),
      ),
    );
    expect(await tester.runAsync(session.prepare), true);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: CamerasScreenWidget(session: session)),
      ),
    );
    await tester.pump();
    expect(find.byType(Image), findsOneWidget);
    expect(find.byIcon(Icons.videocam_off), findsOneWidget);
    expect(find.text('A'), findsOneWidget);
    expect(find.text('B'), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
    session.dispose();
  });
}
