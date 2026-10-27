import 'dart:async';

import 'package:config_app/features/gallery/presentation/widgets/video_grid_item.dart';
import 'package:config_app/features/gallery/presentation/widgets/video_unavailable.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:video_player/video_player.dart';

enum _Failure { none, initialize, looping, play, pause, dispose }

class _Controller extends VideoPlayerController {
  _Controller({this.failure = _Failure.none, this.initializeGate})
    : super.networkUrl(Uri.parse('https://frame.local/video.mp4'));

  _Failure failure;
  final Completer<void>? initializeGate;
  int initializeCalls = 0;
  int loopingCalls = 0;
  int playCalls = 0;
  int pauseCalls = 0;
  int disposeCalls = 0;
  bool disposed = false;

  @override
  Future<void> initialize() async {
    initializeCalls++;
    await initializeGate?.future;
    if (failure == _Failure.initialize) throw StateError('private media URL');
    if (!disposed) {
      value = value.copyWith(
        duration: const Duration(seconds: 10),
        size: const Size(320, 180),
        isInitialized: true,
      );
    }
  }

  @override
  Future<void> setLooping(bool looping) async {
    loopingCalls++;
    if (failure == _Failure.looping) throw StateError('private media URL');
  }

  @override
  Future<void> play() async {
    playCalls++;
    if (failure == _Failure.play) throw StateError('private media URL');
    value = value.copyWith(isPlaying: true);
  }

  @override
  Future<void> pause() async {
    pauseCalls++;
    if (failure == _Failure.pause) throw StateError('private media URL');
    value = value.copyWith(isPlaying: false);
  }

  @override
  Future<void> dispose() async {
    disposeCalls++;
    disposed = true;
    await super.dispose();
    if (failure == _Failure.dispose) throw StateError('private media URL');
  }
}

Widget _app({
  required VideoPlayerController Function(Uri) factory,
  String url = 'https://frame.local/video.mp4',
  Duration initializationTimeout = const Duration(seconds: 15),
  Widget? poster,
}) => MaterialApp(
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: Scaffold(
    body: Center(
      child: SizedBox(
        width: 240,
        height: 240,
        child: VideoGridItem(
          url: url,
          title: 'Sample video',
          controllerFactory: factory,
          initializationTimeout: initializationTimeout,
          poster: poster,
        ),
      ),
    ),
  ),
);

AppLocalizations _strings(WidgetTester tester) =>
    AppLocalizations.of(tester.element(find.byType(VideoGridItem)));

void _videoTest(
  String description,
  WidgetTesterCallback callback, {
  TargetPlatform platform = TargetPlatform.android,
}) => testWidgets(
  description,
  callback,
  variant: TargetPlatformVariant.only(platform),
);

void main() {
  _videoTest('poster is visible before loading the original video', (
    tester,
  ) async {
    var calls = 0;
    final controller = _Controller();
    await tester.pumpWidget(
      _app(
        poster: const Text('JPEG poster'),
        factory: (uri) {
          expect(uri, Uri.parse('https://frame.local/video.mp4'));
          calls++;
          return controller;
        },
      ),
    );
    expect(find.text('JPEG poster'), findsOneWidget);
    expect(calls, 0);
    await tester.tap(find.byTooltip(_strings(tester).video_load));
    await tester.pumpAndSettle();
    expect(calls, 1);
    expect(find.byType(VideoPlayer), findsOneWidget);
    expect(find.text('JPEG poster'), findsNothing);
    await tester.pumpWidget(const SizedBox());
    await tester.pump();
    expect(controller.disposeCalls, 1);
  });

  _videoTest('unsupported playback still displays its JPEG poster', (
    tester,
  ) async {
    await tester.pumpWidget(
      _app(
        poster: const Text('JPEG poster'),
        factory: (_) => throw StateError('must remain lazy'),
      ),
    );
    expect(find.text('JPEG poster'), findsOneWidget);
    expect(find.byType(VideoPlayer), findsNothing);
    expect(find.byType(IconButton), findsNothing);
  }, platform: TargetPlatform.linux);

  _videoTest('unsupported Linux does not construct or initialize a player', (
    tester,
  ) async {
    var factoryCalls = 0;
    await tester.pumpWidget(
      _app(
        factory: (_) {
          factoryCalls++;
          return _Controller();
        },
      ),
    );
    await tester.pumpAndSettle();
    expect(factoryCalls, 0);
    expect(find.byType(VideoUnavailable), findsOneWidget);
    expect(find.byType(VideoPlayer), findsNothing);
    expect(find.byType(IconButton), findsNothing);
    expect(
      find.text(_strings(tester).video_platform_unavailable),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  }, platform: TargetPlatform.linux);

  _videoTest('load is lazy, single flight, and playback can pause and resume', (
    tester,
  ) async {
    final gate = Completer<void>();
    final controller = _Controller(initializeGate: gate);
    var factoryCalls = 0;
    VideoPlayerController factory(Uri uri) {
      factoryCalls++;
      return controller;
    }

    await tester.pumpWidget(_app(factory: factory));
    expect(factoryCalls, 0);
    final load = find.byTooltip(_strings(tester).video_load);
    await tester.tap(load);
    // A second gesture before the rebuild still cannot create another player.
    await tester.tap(load);
    await tester.pump();
    expect(factoryCalls, 1);
    expect(controller.initializeCalls, 1);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    gate.complete();
    await tester.pumpAndSettle();
    expect(controller.loopingCalls, 1);
    expect(controller.playCalls, 1);
    expect(find.byType(VideoPlayer), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('video-grid-toggle')));
    await tester.pumpAndSettle();
    expect(controller.pauseCalls, 1);
    await tester.tap(find.byTooltip(_strings(tester).preview_resume));
    await tester.pumpAndSettle();
    expect(controller.playCalls, 2);
    await tester.pumpWidget(const SizedBox());
    await tester.pump();
    expect(controller.disposeCalls, 1);
    expect(tester.takeException(), isNull);
  });

  for (final failure in [
    _Failure.initialize,
    _Failure.looping,
    _Failure.play,
  ]) {
    _videoTest(
      '${failure.name} failure shows a safe message and releases player',
      (tester) async {
        final controller = _Controller(failure: failure);
        await tester.pumpWidget(_app(factory: (_) => controller));
        await tester.tap(find.byTooltip(_strings(tester).video_load));
        await tester.pumpAndSettle();
        expect(find.text(_strings(tester).video_load_failed), findsOneWidget);
        expect(find.textContaining('private media URL'), findsNothing);
        expect(find.byType(VideoPlayer), findsNothing);
        expect(controller.disposeCalls, 1);
        expect(tester.takeException(), isNull);
      },
    );
  }

  _videoTest('pause failures are caught and release the playing controller', (
    tester,
  ) async {
    final controller = _Controller(failure: _Failure.pause);
    await tester.pumpWidget(_app(factory: (_) => controller));
    await tester.tap(find.byTooltip(_strings(tester).video_load));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('video-grid-toggle')));
    await tester.pumpAndSettle();
    expect(find.text(_strings(tester).video_load_failed), findsOneWidget);
    expect(controller.disposeCalls, 1);
    expect(tester.takeException(), isNull);
  });

  _videoTest('initialization times out and cannot start after a late success', (
    tester,
  ) async {
    final gate = Completer<void>();
    final controller = _Controller(initializeGate: gate);
    await tester.pumpWidget(
      _app(
        factory: (_) => controller,
        initializationTimeout: const Duration(seconds: 1),
      ),
    );
    await tester.tap(find.byTooltip(_strings(tester).video_load));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.text(_strings(tester).video_load_failed), findsOneWidget);
    expect(controller.disposeCalls, 1);
    gate.complete();
    await tester.pumpAndSettle();
    expect(controller.playCalls, 0);
    expect(controller.loopingCalls, 0);
    expect(tester.takeException(), isNull);
  });

  _videoTest('URL replacement cannot play a late previous initialization', (
    tester,
  ) async {
    final gate = Completer<void>();
    final oldController = _Controller(initializeGate: gate);
    final newController = _Controller();
    VideoPlayerController factory(Uri uri) =>
        uri.path.endsWith('other.mp4') ? newController : oldController;
    await tester.pumpWidget(_app(factory: factory));
    await tester.tap(find.byTooltip(_strings(tester).video_load));
    await tester.pump();
    await tester.pumpWidget(
      _app(factory: factory, url: 'https://frame.local/other.mp4'),
    );
    expect(oldController.disposeCalls, 1);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    gate.complete();
    await tester.pumpAndSettle();
    expect(oldController.loopingCalls, 0);
    expect(oldController.playCalls, 0);
    await tester.tap(find.byTooltip(_strings(tester).video_load));
    await tester.pumpAndSettle();
    expect(newController.playCalls, 1);
    expect(find.byType(VideoPlayer), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
    await tester.pump();
    expect(newController.disposeCalls, 1);
    expect(tester.takeException(), isNull);
  });

  _videoTest('unmount handles late initialization and disposal errors', (
    tester,
  ) async {
    final gate = Completer<void>();
    final controller = _Controller(
      initializeGate: gate,
      failure: _Failure.dispose,
    );
    await tester.pumpWidget(_app(factory: (_) => controller));
    await tester.tap(find.byTooltip(_strings(tester).video_load));
    await tester.pump();
    await tester.pumpWidget(const SizedBox());
    gate.complete();
    await tester.pumpAndSettle();
    expect(controller.disposeCalls, 1);
    expect(controller.loopingCalls, 0);
    expect(controller.playCalls, 0);
    expect(tester.takeException(), isNull);
  });

  _videoTest('asynchronous player error switches to the localized fallback', (
    tester,
  ) async {
    final controller = _Controller();
    await tester.pumpWidget(_app(factory: (_) => controller));
    await tester.tap(find.byTooltip(_strings(tester).video_load));
    await tester.pumpAndSettle();
    controller.value = controller.value.copyWith(
      errorDescription: 'private media URL',
    );
    await tester.pumpAndSettle();
    expect(find.text(_strings(tester).video_load_failed), findsOneWidget);
    expect(controller.disposeCalls, 1);
    expect(tester.takeException(), isNull);
  });
}
