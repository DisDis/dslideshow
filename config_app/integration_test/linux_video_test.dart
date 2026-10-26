import 'dart:async';
import 'dart:io';

import 'package:config_app/features/gallery/presentation/widgets/single_video_player.dart';
import 'package:config_app/src/linux_video_player.dart';
import 'package:config_app/src/linux_video_session_native.dart';
import 'package:config_app/src/video_backend.dart';
import 'package:config_app/src/video_playback_support.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_platform_interface/video_player_platform_interface.dart';

const _fixture = String.fromEnvironment('VIDEO_SMOKE_FILE');

class _TrackedNativeSession extends NativeLinuxVideoSession {
  bool disposed = false;

  @override
  Future<void> dispose() async {
    await super.dispose();
    disposed = true;
  }
}

Future<void> _until(
  WidgetTester tester,
  FutureOr<bool> Function() condition,
  String reason,
) async {
  final deadline = DateTime.now().add(const Duration(seconds: 20));
  while (!await condition() && DateTime.now().isBefore(deadline)) {
    await tester.pump(const Duration(milliseconds: 100));
  }
  expect(await condition(), isTrue, reason: reason);
}

Future<HttpServer> _serve(File fixture) async {
  final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
  server.listen((request) async {
    final response = request.response;
    if (request.uri.path != '/video.mp4') {
      response.statusCode = HttpStatus.notFound;
      await response.close();
      return;
    }
    final length = await fixture.length();
    var start = 0;
    var end = length - 1;
    final range = request.headers.value(HttpHeaders.rangeHeader);
    if (range != null) {
      final match = RegExp(r'^bytes=(\d+)-(\d*)$').firstMatch(range);
      if (match == null) {
        response.statusCode = HttpStatus.requestedRangeNotSatisfiable;
        await response.close();
        return;
      }
      start = int.parse(match.group(1)!);
      if (match.group(2)!.isNotEmpty) end = int.parse(match.group(2)!);
      if (start >= length || end < start) {
        response.statusCode = HttpStatus.requestedRangeNotSatisfiable;
        await response.close();
        return;
      }
      end = end.clamp(start, length - 1);
      response.statusCode = HttpStatus.partialContent;
      response.headers.set(
        HttpHeaders.contentRangeHeader,
        'bytes $start-$end/$length',
      );
    }
    response.headers.contentType = ContentType('video', 'mp4');
    response.headers.set(HttpHeaders.acceptRangesHeader, 'bytes');
    response.contentLength = end - start + 1;
    if (request.method == 'HEAD') {
      await response.close();
    } else {
      try {
        await fixture.openRead(start, end + 1).pipe(response);
      } on IOException {
        // Seeking/closing a player can cancel its previous HTTP request.
        await response.close();
      }
    }
  });
  return server;
}

Widget _app(Uri uri, VideoPlayerController Function(Uri) create) => MaterialApp(
  locale: const Locale('en'),
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: Scaffold(
    body: Center(
      child: SingleVideoPlayer(
        key: ValueKey(uri),
        uri: uri,
        controllerFactory: create,
        onContentTap: () {},
      ),
    ),
  ),
);

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'Linux libmpv plays, pauses, seeks and releases failed and closed videos',
    (tester) async {
      initializeConfigAppVideoBackend();
      expect(supportsConfigAppVideo, isTrue);
      expect(VideoPlayerPlatform.instance, isA<ConfigAppLinuxVideoPlayer>());
      final sessions = <_TrackedNativeSession>[];
      final backend = ConfigAppLinuxVideoPlayer(
        sessionFactory: () {
          final session = _TrackedNativeSession();
          sessions.add(session);
          return session;
        },
      );
      VideoPlayerPlatform.instance = backend;
      addTearDown(backend.init);
      final fixture = File(_fixture);
      expect(await fixture.exists(), isTrue);
      final server = await _serve(fixture);
      addTearDown(() => server.close(force: true));
      final uri = Uri.parse('http://127.0.0.1:${server.port}/video.mp4');
      VideoPlayerController? controller;
      VideoPlayerController create(Uri uri) =>
          controller = VideoPlayerController.networkUrl(uri);
      await tester.pumpWidget(_app(uri, create));
      await _until(
        tester,
        () => controller?.value.isInitialized ?? false,
        'native video initialized',
      );
      expect(controller!.value.size.width, greaterThan(0));
      expect(controller!.value.size.height, greaterThan(0));
      expect(controller!.value.duration, greaterThan(Duration.zero));
      await _until(
        tester,
        () => controller!.value.position > const Duration(milliseconds: 500),
        'decoded video is playing',
      );
      expect(find.byType(Texture), findsWidgets);
      await tester.tap(find.byKey(const ValueKey('single-video-toggle')));
      await _until(
        tester,
        () =>
            !controller!.value.isPlaying &&
            tester
                    .widget<Slider>(
                      find.byKey(const ValueKey('single-video-seek')),
                    )
                    .onChangeEnd !=
                null,
        'pause reaches native player',
      );
      // Rebuild after pause completes so the next gesture uses the current,
      // enabled control rather than the callback from before the pause.
      await tester.pump();
      await _until(
        tester,
        () =>
            tester
                .widget<Slider>(find.byKey(const ValueKey('single-video-seek')))
                .onChangeEnd !=
            null,
        'seek is enabled after pause',
      );
      final seek = tester.widget<Slider>(
        find.byKey(const ValueKey('single-video-seek')),
      );
      seek.onChangeEnd!(seek.max * .6);
      await _until(
        tester,
        () async =>
            (await controller!.position)!.inMilliseconds >
            controller!.value.duration.inMilliseconds * .4,
        'native seek updates position',
      );
      await tester.pumpWidget(const SizedBox.shrink());
      await _until(
        tester,
        () =>
            backend.activePlayerCount == 0 &&
            sessions.every((session) => session.disposed),
        'closing releases native player',
      );

      await tester.pumpWidget(_app(uri.replace(path: '/missing.mp4'), create));
      await _until(
        tester,
        () => find.text('Could not load video.').evaluate().isNotEmpty,
        'HTTP error is visible without an unhandled exception',
      );
      await _until(
        tester,
        () =>
            backend.activePlayerCount == 0 &&
            sessions.every((session) => session.disposed),
        'failed startup releases native player',
      );
      expect(sessions, hasLength(2));
      await tester.pumpWidget(const SizedBox.shrink());
      expect(tester.takeException(), isNull);
    },
    variant: TargetPlatformVariant.only(TargetPlatform.linux),
    skip: !Platform.isLinux || _fixture.isEmpty,
    timeout: const Timeout(Duration(seconds: 90)),
  );
}
