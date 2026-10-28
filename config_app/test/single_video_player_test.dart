import 'dart:async';

import 'package:config_app/features/gallery/presentation/widgets/single_video_player.dart';
import 'package:config_app/features/gallery/presentation/widgets/video_unavailable.dart';
import 'package:config_app/src/video_playback_support.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:video_player/video_player.dart';

import 'support/controlled_video_controller.dart';

Widget _app({
  required VideoPlayerController Function(Uri) factory,
  Uri? uri,
  VoidCallback? onContentTap,
  Duration initializationTimeout = const Duration(seconds: 15),
  Locale locale = const Locale('en'),
}) => MaterialApp(
  locale: locale,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: Scaffold(
    body: Center(
      child: SizedBox(
        width: 480,
        height: 320,
        child: SingleVideoPlayer(
          uri: uri ?? Uri.parse('https://frame.local/video.mp4'),
          onContentTap: onContentTap ?? () {},
          controllerFactory: factory,
          initializationTimeout: initializationTimeout,
        ),
      ),
    ),
  ),
);

AppLocalizations _strings(WidgetTester tester) =>
    AppLocalizations.of(tester.element(find.byType(SingleVideoPlayer)));

void _videoTest(
  String description,
  WidgetTesterCallback callback, {
  TargetPlatform platform = TargetPlatform.android,
  bool skip = false,
}) => testWidgets(
  description,
  callback,
  variant: TargetPlatformVariant.only(platform),
  skip: skip,
);

void main() {
  test(
    'web video stays supported on a Linux host without a native backend',
    () {
      expect(
        configAppVideoSupportedOn(isWeb: true, platform: TargetPlatform.linux),
        isTrue,
      );
    },
  );

  _videoTest(
    'unavailable native Linux backend never creates a single-video controller',
    (tester) async {
      var factoryCalls = 0;
      await tester.pumpWidget(
        _app(
          factory: (_) {
            factoryCalls++;
            return ControlledVideoController();
          },
          locale: const Locale('en'),
        ),
      );
      await tester.pumpAndSettle();
      expect(factoryCalls, 0);
      expect(find.byType(VideoUnavailable), findsOneWidget);
      expect(find.byType(VideoPlayer), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(
        find.text(_strings(tester).video_platform_unavailable),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    },
    platform: TargetPlatform.linux,
    skip: kIsWeb,
  );

  _videoTest(
    'single video initializes, loops, plays, pauses and exposes content tap',
    (tester) async {
      final pause = Completer<void>();
      final controller = ControlledVideoController(pauseGate: pause);
      var contentTaps = 0;
      await tester.pumpWidget(
        _app(factory: (_) => controller, onContentTap: () => contentTaps++),
      );
      await tester.pumpAndSettle();
      expect(controller.initializeCalls, 1);
      expect(controller.loopingCalls, 1);
      expect(controller.playCalls, 1);
      expect(find.byType(VideoPlayer), findsOneWidget);
      final toggle = find.byKey(const ValueKey('single-video-toggle'));
      expect(
        tester.widget<IconButton>(toggle).tooltip,
        _strings(tester).preview_pause,
      );
      // The fake has no native texture to hit-test, so invoke the content
      // gesture callback while exercising real button gestures below.
      tester
          .widget<GestureDetector>(
            find.byWidgetPredicate(
              (widget) =>
                  widget is GestureDetector && widget.child is VideoPlayer,
            ),
          )
          .onTap!();
      expect(contentTaps, 1);
      await tester.tap(toggle);
      // Two gestures before rebuilding still issue just one pending operation.
      await tester.tap(toggle);
      await tester.pump();
      expect(controller.pauseCalls, 1);
      expect(tester.widget<IconButton>(toggle).onPressed, isNull);
      pause.complete();
      await tester.pumpAndSettle();
      expect(
        tester.widget<IconButton>(toggle).tooltip,
        _strings(tester).preview_resume,
      );
      await tester.tap(toggle);
      await tester.pumpAndSettle();
      expect(controller.playCalls, 2);
      await tester.pumpWidget(const SizedBox());
      await tester.pump();
      expect(controller.disposeCalls, 1);
      expect(tester.takeException(), isNull);
    },
  );

  for (final failure in [
    VideoControllerFailure.initialize,
    VideoControllerFailure.looping,
    VideoControllerFailure.play,
  ]) {
    _videoTest(
      '${failure.name} failure is localized and releases the controller',
      (tester) async {
        final controller = ControlledVideoController(failure: failure);
        await tester.pumpWidget(
          _app(factory: (_) => controller, locale: const Locale('en')),
        );
        await tester.pumpAndSettle();
        expect(find.text(_strings(tester).video_load_failed), findsOneWidget);
        expect(find.textContaining('private media URL'), findsNothing);
        expect(find.byType(VideoPlayer), findsNothing);
        expect(controller.disposeCalls, 1);
        expect(tester.takeException(), isNull);
      },
    );
  }

  _videoTest(
    'pause failure leaves a localized fallback without uncaught errors',
    (tester) async {
      final controller = ControlledVideoController(
        failure: VideoControllerFailure.pause,
      );
      await tester.pumpWidget(_app(factory: (_) => controller));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('single-video-toggle')));
      await tester.pumpAndSettle();
      expect(find.text(_strings(tester).video_load_failed), findsOneWidget);
      expect(find.byType(VideoPlayer), findsNothing);
      expect(controller.disposeCalls, 1);
      expect(tester.takeException(), isNull);
    },
  );

  _videoTest(
    'unmount disposes a pending controller once and cannot play a late result',
    (tester) async {
      final gate = Completer<void>();
      final controller = ControlledVideoController(
        initializeGate: gate,
        failure: VideoControllerFailure.dispose,
      );
      await tester.pumpWidget(_app(factory: (_) => controller));
      await tester.pump();
      expect(controller.initializeCalls, 1);
      await tester.pumpWidget(const SizedBox());
      await tester.pump();
      expect(controller.disposeCalls, 1);
      gate.complete();
      await tester.pumpAndSettle();
      expect(controller.disposeCalls, 1);
      expect(controller.loopingCalls, 0);
      expect(controller.playCalls, 0);
      expect(tester.takeException(), isNull);
    },
  );

  _videoTest(
    'changing URI releases old loading video and ignores its late completion',
    (tester) async {
      final gate = Completer<void>();
      final oldController = ControlledVideoController(initializeGate: gate);
      final newController = ControlledVideoController();
      VideoPlayerController factory(Uri uri) =>
          uri.path.endsWith('other.mp4') ? newController : oldController;
      await tester.pumpWidget(_app(factory: factory));
      await tester.pump();
      await tester.pumpWidget(
        _app(factory: factory, uri: Uri.parse('https://frame.local/other.mp4')),
      );
      await tester.pumpAndSettle();
      expect(oldController.disposeCalls, 1);
      expect(newController.playCalls, 1);
      expect(find.byType(VideoPlayer), findsOneWidget);
      gate.complete();
      await tester.pumpAndSettle();
      expect(oldController.loopingCalls, 0);
      expect(oldController.playCalls, 0);
      expect(newController.playCalls, 1);
      await tester.pumpWidget(const SizedBox());
      await tester.pump();
      expect(newController.disposeCalls, 1);
      expect(tester.takeException(), isNull);
    },
  );

  _videoTest(
    'initialization timeout releases the controller and cannot play later',
    (tester) async {
      final gate = Completer<void>();
      final controller = ControlledVideoController(initializeGate: gate);
      await tester.pumpWidget(
        _app(
          factory: (_) => controller,
          initializationTimeout: const Duration(milliseconds: 100),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpAndSettle();
      expect(find.text(_strings(tester).video_load_failed), findsOneWidget);
      expect(controller.disposeCalls, 1);
      gate.complete();
      await tester.pumpAndSettle();
      expect(controller.loopingCalls, 0);
      expect(controller.playCalls, 0);
      expect(tester.takeException(), isNull);
    },
  );

  _videoTest('listener error defers disposal and handles a cleanup failure', (
    tester,
  ) async {
    final controller = ControlledVideoController(
      failure: VideoControllerFailure.dispose,
    );
    await tester.pumpWidget(_app(factory: (_) => controller));
    await tester.pumpAndSettle();
    controller.value = controller.value.copyWith(
      errorDescription: 'private media URL',
    );
    expect(controller.disposeCalls, 0);
    await tester.pumpAndSettle();
    expect(find.text(_strings(tester).video_load_failed), findsOneWidget);
    expect(find.textContaining('private media URL'), findsNothing);
    expect(controller.disposeCalls, 1);
    expect(tester.takeException(), isNull);
  });

  _videoTest(
    'retry creates a fresh controller after an initialization failure',
    (tester) async {
      final failed = ControlledVideoController(
        failure: VideoControllerFailure.initialize,
      );
      final ready = ControlledVideoController();
      var factoryCalls = 0;
      await tester.pumpWidget(
        _app(factory: (_) => factoryCalls++ == 0 ? failed : ready),
      );
      await tester.pumpAndSettle();
      expect(failed.disposeCalls, 1);
      await tester.tap(find.text(_strings(tester).retry_button));
      await tester.pumpAndSettle();
      expect(factoryCalls, 2);
      expect(ready.playCalls, 1);
      expect(find.byType(VideoPlayer), findsOneWidget);
      await tester.pumpWidget(const SizedBox());
      await tester.pump();
      expect(ready.disposeCalls, 1);
      expect(tester.takeException(), isNull);
    },
  );

  _videoTest('seek slider commits once and keeps playback active', (
    tester,
  ) async {
    final seek = Completer<void>();
    final controller = ControlledVideoController(seekGate: seek);
    await tester.pumpWidget(_app(factory: (_) => controller));
    await tester.pumpAndSettle();
    final slider = find.byKey(const ValueKey('single-video-seek'));
    expect(tester.widget<Slider>(slider).value, 0);
    // A real pointer drag exercises the end-of-gesture commit rather than
    // issuing an asynchronous seek for every intermediate position.
    await tester.drag(slider, const Offset(100, 0));
    await tester.pump();
    expect(controller.seeks, hasLength(1));
    expect(controller.seeks.single, greaterThan(Duration.zero));
    expect(
      controller.seeks.single,
      lessThanOrEqualTo(const Duration(seconds: 10)),
    );
    expect(tester.widget<Slider>(slider).onChanged, isNull);
    expect(controller.value.isPlaying, isTrue);
    seek.complete();
    await tester.pumpAndSettle();
    expect(
      tester.widget<Slider>(slider).value,
      controller.seeks.single.inMilliseconds,
    );
    expect(tester.widget<Slider>(slider).onChanged, isNotNull);
    expect(controller.playCalls, 1);
    expect(controller.pauseCalls, 0);
    await tester.pumpWidget(const SizedBox());
    await tester.pump();
    expect(tester.takeException(), isNull);
  });

  _videoTest(
    'seek failure shows a localized fallback without an uncaught future',
    (tester) async {
      final controller = ControlledVideoController(
        failure: VideoControllerFailure.seek,
      );
      await tester.pumpWidget(_app(factory: (_) => controller));
      await tester.pumpAndSettle();
      await tester.drag(
        find.byKey(const ValueKey('single-video-seek')),
        const Offset(100, 0),
      );
      await tester.pumpAndSettle();
      expect(find.text(_strings(tester).video_load_failed), findsOneWidget);
      expect(controller.disposeCalls, 1);
      expect(tester.takeException(), isNull);
    },
  );

  _videoTest(
    'URI replacement ignores a late failed seek from the previous video',
    (tester) async {
      final gate = Completer<void>();
      final oldController = ControlledVideoController(seekGate: gate);
      final newController = ControlledVideoController();
      VideoPlayerController factory(Uri uri) =>
          uri.path.endsWith('other.mp4') ? newController : oldController;
      await tester.pumpWidget(_app(factory: factory));
      await tester.pumpAndSettle();
      await tester.drag(
        find.byKey(const ValueKey('single-video-seek')),
        const Offset(100, 0),
      );
      await tester.pump();
      expect(oldController.seeks, hasLength(1));
      await tester.pumpWidget(
        _app(factory: factory, uri: Uri.parse('https://frame.local/other.mp4')),
      );
      await tester.pumpAndSettle();
      expect(oldController.disposeCalls, 1);
      gate.completeError(StateError('private media URL'));
      await tester.pumpAndSettle();
      expect(find.text(_strings(tester).video_load_failed), findsNothing);
      expect(newController.playCalls, 1);
      expect(
        tester
            .widget<Slider>(find.byKey(const ValueKey('single-video-seek')))
            .onChanged,
        isNotNull,
      );
      await tester.pumpWidget(const SizedBox());
      await tester.pump();
      expect(tester.takeException(), isNull);
    },
  );

  _videoTest('unmount during seek ignores late completion and disposes once', (
    tester,
  ) async {
    final gate = Completer<void>();
    final controller = ControlledVideoController(seekGate: gate);
    await tester.pumpWidget(_app(factory: (_) => controller));
    await tester.pumpAndSettle();
    await tester.drag(
      find.byKey(const ValueKey('single-video-seek')),
      const Offset(100, 0),
    );
    await tester.pump();
    await tester.pumpWidget(const SizedBox());
    await tester.pump();
    expect(controller.disposeCalls, 1);
    gate.complete();
    await tester.pumpAndSettle();
    expect(controller.disposeCalls, 1);
    expect(controller.playCalls, 1);
    expect(tester.takeException(), isNull);
  });
}
