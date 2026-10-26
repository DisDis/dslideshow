import 'dart:async';

import 'package:config_app/features/gallery/presentation/pages/single_item_viewer_page.dart';
import 'package:config_app/features/gallery/presentation/widgets/gallery_widget.dart';
import 'package:config_app/features/gallery/presentation/widgets/metadata_panel.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:video_player_platform_interface/video_player_platform_interface.dart';

class _PortraitVideoPlatform extends VideoPlayerPlatform {
  final _streams = <int, StreamController<VideoEvent>>{};
  final seeks = <Duration>[];
  int _nextId = 1;
  int pauses = 0;
  int disposals = 0;
  Duration _position = Duration.zero;

  @override
  Future<void> init() async {}

  @override
  Future<int?> createWithOptions(VideoCreationOptions options) async {
    final id = _nextId++;
    // Complete cancellation in the widget test's zone. The stream's default
    // shared completed future can otherwise leave dispose pending in FakeAsync.
    final events = _streams[id] = StreamController<VideoEvent>(
      onCancel: () async {},
    );
    events.add(
      VideoEvent(
        eventType: VideoEventType.initialized,
        duration: const Duration(seconds: 10),
        size: const Size(180, 320),
      ),
    );
    return id;
  }

  @override
  Stream<VideoEvent> videoEventsFor(int playerId) => _streams[playerId]!.stream;

  @override
  Future<void> dispose(int playerId) async {
    disposals++;
    await _streams.remove(playerId)?.close();
  }

  @override
  Future<void> play(int playerId) async {}

  @override
  Future<void> pause(int playerId) async => pauses++;

  @override
  Future<void> setLooping(int playerId, bool looping) async {}

  @override
  Future<void> setVolume(int playerId, double volume) async {}

  @override
  Future<void> setPlaybackSpeed(int playerId, double speed) async {}

  @override
  Future<void> seekTo(int playerId, Duration position) async {
    seeks.add(position);
    _position = position;
  }

  @override
  Future<Duration> getPosition(int playerId) async => _position;

  @override
  Widget buildViewWithOptions(VideoViewOptions options) =>
      const SizedBox.expand(
        key: ValueKey('portrait-video-output'),
        child: ColoredBox(color: Colors.black),
      );
}

void main() {
  testWidgets(
    'hidden portrait-video overlays allow pointer access to pause and seek',
    (tester) async {
      tester.view.physicalSize = const Size(400, 720);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final previous = VideoPlayerPlatform.instance;
      final platform = _PortraitVideoPlatform();
      VideoPlayerPlatform.instance = platform;
      addTearDown(() => VideoPlayerPlatform.instance = previous);
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SingleItemViewerPage(
            item: GalleryItem(
              uri: Uri.parse('https://frame.local/portrait.mp4'),
              title: 'Portrait video',
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final toggle = find.byKey(const ValueKey('single-video-toggle'));
      final seek = find.byKey(const ValueKey('single-video-seek'));
      final video = find.byKey(const ValueKey('portrait-video-output'));
      expect(video, findsOneWidget);
      expect(
        tester
            .getRect(find.byType(MetadataPanel))
            .contains(tester.getCenter(toggle)),
        isTrue,
      );
      expect(toggle.hitTestable(), findsNothing);

      // A content tap hides the header and metadata without changing playback.
      final contentPoint = tester.getTopLeft(video) + const Offset(60, 180);
      await tester.tapAt(contentPoint);
      await tester.pumpAndSettle();
      expect(toggle.hitTestable(), findsOneWidget);
      expect(seek.hitTestable(), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back).hitTestable(), findsNothing);
      expect(
        Focus.of(tester.element(find.byIcon(Icons.arrow_back))).canRequestFocus,
        isFalse,
      );
      final pausesBefore = platform.pauses;
      await tester.tap(toggle);
      await tester.pumpAndSettle();
      expect(platform.pauses, pausesBefore + 1);
      await tester.drag(seek, const Offset(80, 0));
      await tester.pumpAndSettle();
      expect(platform.seeks, hasLength(1));
      expect(platform.seeks.single, greaterThan(Duration.zero));

      // Bringing the overlays back restores their normal pointer behavior.
      await tester.tapAt(contentPoint);
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.arrow_back).hitTestable(), findsOneWidget);
      expect(
        Focus.of(tester.element(find.byIcon(Icons.arrow_back))).canRequestFocus,
        isTrue,
      );
      expect(toggle.hitTestable(), findsNothing);
      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
      expect(platform.disposals, 1);
      expect(tester.takeException(), isNull);
    },
    variant: TargetPlatformVariant.only(TargetPlatform.android),
  );
}
