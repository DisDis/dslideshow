import 'dart:async';
import 'dart:ui' as ui;

import 'package:config_app/features/config/presentation/wigdgets/slideshow_preview.dart';
import 'package:dio/dio.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/effect.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/fixed_animation_controller.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/video_widget.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:video_player/video_player.dart';

enum _VideoErrorPhase { preparing, transition, current, currentDuringNextLoad }

Widget _app(Widget child, Locale locale) => MaterialApp(
  locale: locale,
  supportedLocales: AppLocalizations.supportedLocales,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  home: Scaffold(body: SingleChildScrollView(child: child)),
);

void main() {
  const locale = Locale('en');
  testWidgets(
    'Linux preview disables video with a localized explanation and still shows photos (${locale.languageCode})',
    (tester) async {
      final recorder = ui.PictureRecorder();
      Canvas(recorder).drawColor(Colors.orange, BlendMode.src);
      final picture = recorder.endRecording();
      final bitmap = (await tester.runAsync(() => picture.toImage(2, 2)))!;
      final data = (await tester.runAsync(
        () => bitmap.toByteData(format: ui.ImageByteFormat.png),
      ))!;
      final image = MemoryImage(Uint8List.fromList(data.buffer.asUint8List()));
      bitmap.dispose();
      picture.dispose();
      final adapter = _NoRequestsAdapter();
      final client = Dio()..httpClientAdapter = adapter;
      final key = GlobalKey<SlideshowPreviewState>();
      await tester.pumpWidget(
        _app(
          SlideshowPreview(
            key: key,
            config: SlideShowConfig.fromJson({
              'effects': {'defaultDurationMs': 10},
              'displayTimeMs': 60000,
            }),
            images: [image],
            mediaClient: client,
          ),
          locale,
        ),
      );
      await tester.runAsync(() => precacheImage(image, key.currentContext!));
      final field = tester.widget<TextField>(
        find.byKey(const ValueKey('preview-video-url')),
      );
      expect(field.enabled, isFalse);
      final l = AppLocalizations.of(key.currentContext!);
      expect(find.text(l.video_platform_unavailable), findsOneWidget);
      expect(
        find.byKey(const ValueKey('preview-video-unavailable')),
        findsOneWidget,
      );

      // Simulate an old URL retained before the platform became unavailable.
      // A disabled field alone must not be the only protection for loading.
      field.controller!.text = 'https://camera.test/video.mp4';
      field.onSubmitted!(field.controller!.text);
      for (var i = 0; i < 10; i++) {
        await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 20)),
        );
        await tester.pump(const Duration(milliseconds: 20));
      }
      expect(find.byType(RawImage), findsWidgets);
      expect(find.byType(VideoWidget), findsNothing);
      expect(find.byKey(const ValueKey('preview-error')), findsNothing);
      expect(adapter.requests, isEmpty);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
      expect(adapter.closed, isTrue);
    },
    skip: kIsWeb,
    variant: TargetPlatformVariant.only(TargetPlatform.linux),
  );

  testWidgets('Linux preview accepts an explicitly injected video session', (
    tester,
  ) async {
    final session = _FakeVideoSession();
    final key = GlobalKey<SlideshowPreviewState>();
    final createdUris = <Uri>[];
    await tester.pumpWidget(
      _app(
        SlideshowPreview(
          key: key,
          config: SlideShowConfig.fromJson({
            'effects': {'defaultDurationMs': 10},
            'displayTimeMs': 60000,
          }),
          images: [_PendingProvider()],
          videoFactory: (uri) {
            createdUris.add(uri);
            return session;
          },
        ),
        const Locale('en'),
      ),
    );
    await tester.pump();
    expect(
      find.byKey(const ValueKey('preview-video-unavailable')),
      findsNothing,
    );
    final field = tester.widget<TextField>(
      find.byKey(const ValueKey('preview-video-url')),
    );
    expect(field.enabled, isTrue);
    await tester.enterText(
      find.byKey(const ValueKey('preview-video-url')),
      'https://camera.test/video.mp4',
    );
    key.currentState!.onChanged(Effect.fadeEffect);
    await tester.pump();
    await tester.pump();
    expect(createdUris, [Uri.parse('https://camera.test/video.mp4')]);
    expect(session.prepared, isTrue);
    expect(session.playing, contains(true));
    await tester.pumpWidget(const SizedBox());
    expect(session.disposed, isTrue);
    expect(tester.takeException(), isNull);
  }, variant: TargetPlatformVariant.only(TargetPlatform.linux));

  testWidgets(
    'video preparation timeout releases the session and ignores a late result',
    (tester) async {
      final preparation = Completer<void>();
      final session = _FakeVideoSession(preparation: preparation);
      final key = GlobalKey<SlideshowPreviewState>();
      await tester.pumpWidget(
        _app(
          SlideshowPreview(
            key: key,
            config: SlideShowConfig.fromJson({
              'effects': {'defaultDurationMs': 10},
              'displayTimeMs': 60000,
            }),
            images: [_PendingProvider()],
            videoFactory: (_) => session,
          ),
          const Locale('en'),
        ),
      );
      await tester.pump();
      await tester.enterText(
        find.byKey(const ValueKey('preview-video-url')),
        'https://camera.test/unresponsive.mp4',
      );
      key.currentState!.onChanged(Effect.fadeEffect);
      await tester.pump();
      expect(session.prepared, isTrue);
      expect(session.disposed, isFalse);
      await tester.pump(const Duration(seconds: 15));
      expect(find.byKey(const ValueKey('preview-error')), findsOneWidget);
      expect(session.disposed, isTrue);
      preparation.complete();
      await tester.pump();
      expect(session.playing, isEmpty);
      expect(find.byType(VideoWidget), findsNothing);
      await tester.pumpWidget(const SizedBox());
      expect(tester.takeException(), isNull);
    },
    variant: TargetPlatformVariant.only(TargetPlatform.linux),
  );

  for (final phase in _VideoErrorPhase.values) {
    testWidgets(
      'controller error during ${phase.name} stops preview and releases video',
      (tester) async {
        final preparation = Completer<void>();
        if (phase != _VideoErrorPhase.preparing) preparation.complete();
        final session = _ControlledVideoSession(preparation);
        final key = GlobalKey<SlideshowPreviewState>();
        var videoCreations = 0;
        await tester.pumpWidget(
          _app(
            SlideshowPreview(
              key: key,
              config: SlideShowConfig.fromJson({
                'effects': {'defaultDurationMs': 100},
                'displayTimeMs': 50,
              }),
              images: [_PendingProvider()],
              videoFactory: (_) {
                videoCreations++;
                return session;
              },
            ),
            const Locale('en'),
          ),
        );
        await tester.pump();
        await tester.enterText(
          find.byKey(const ValueKey('preview-video-url')),
          'https://camera.test/video.mp4',
        );
        key.currentState!.onChanged(Effect.fadeEffect);
        await tester.pump();
        await tester.pump();
        if (phase == _VideoErrorPhase.current ||
            phase == _VideoErrorPhase.currentDuringNextLoad) {
          final animation = tester
              .widgetList<AnimatedBuilder>(find.byType(AnimatedBuilder))
              .map((widget) => widget.animation)
              .whereType<FixedAnimationController>()
              .single;
          // FixedAnimationController deliberately advances by at most 10 ms
          // per frame. One long pump cannot complete a transition.
          for (
            var frame = 0;
            frame < 25 && animation.status != AnimationStatus.completed;
            frame++
          ) {
            await tester.pump(const Duration(milliseconds: 16));
          }
          expect(animation.status, AnimationStatus.completed);
          expect(session.disposeCalls, 0);
        }
        if (phase == _VideoErrorPhase.currentDuringNextLoad) {
          // Starting another preparation changes the generation but the
          // current decoder must remain observed until it is actually replaced.
          key.currentState!.onChanged(
            (const Effect(
              EffectType.revealMask,
              options: RevealMaskEffectOptions(direction: EffectDirection.left),
            )),
          );
          await tester.pump();
        }
        session.controller.value = session.controller.value.copyWith(
          errorDescription: 'private media URL',
        );
        await tester.pump();
        await tester.pump();
        expect(find.byKey(const ValueKey('preview-error')), findsOneWidget);
        expect(find.textContaining('private media URL'), findsNothing);
        expect(find.byType(VideoWidget), findsNothing);
        expect(session.disposeCalls, 1);
        expect(session.controller.listeners, isEmpty);
        if (phase == _VideoErrorPhase.preparing) preparation.complete();
        await tester.pump(const Duration(seconds: 1));
        expect(videoCreations, 1);
        expect(find.byType(LinearProgressIndicator), findsNothing);
        expect(find.byKey(const ValueKey('preview-error')), findsOneWidget);
        expect(session.disposeCalls, 1);
        await tester.pumpWidget(const SizedBox());
        expect(tester.takeException(), isNull);
      },
      variant: TargetPlatformVariant.only(TargetPlatform.linux),
    );
  }
}

class _NoRequestsAdapter implements HttpClientAdapter {
  final requests = <Uri>[];
  bool closed = false;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options.uri);
    throw StateError('Injected images should not request media');
  }

  @override
  void close({bool force = false}) => closed = true;
}

class _PendingProvider extends ImageProvider<int> {
  @override
  Future<int> obtainKey(ImageConfiguration configuration) =>
      SynchronousFuture(identityHashCode(this));

  @override
  void resolveStreamForKey(
    ImageConfiguration configuration,
    ImageStream stream,
    int key,
    ImageErrorListener handleError,
  ) => stream.setCompleter(_PendingImageCompleter());
}

class _PendingImageCompleter extends ImageStreamCompleter {}

class _FakeVideoSession implements VideoSession {
  _FakeVideoSession({this.preparation});

  final Completer<void>? preparation;
  bool prepared = false, disposed = false;
  final playing = <bool>[];

  @override
  final controller = null;

  @override
  Future<void> prepare() async {
    prepared = true;
    await preparation?.future;
  }

  @override
  Future<void> setPlaying(bool value) async {
    playing.add(value);
  }

  @override
  Future<void> dispose() async {
    disposed = true;
  }
}

class _ErrorController extends VideoPlayerController {
  _ErrorController()
    : super.networkUrl(Uri.parse('https://camera.test/video.mp4')) {
    value = value.copyWith(
      isInitialized: true,
      duration: const Duration(seconds: 10),
      size: const Size(320, 180),
    );
  }

  final listeners = <VoidCallback>{};

  @override
  void addListener(VoidCallback listener) {
    listeners.add(listener);
    super.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    listeners.remove(listener);
    super.removeListener(listener);
  }
}

class _ControlledVideoSession implements VideoSession {
  _ControlledVideoSession(this.preparation);

  final Completer<void> preparation;
  bool disposed = false;
  int disposeCalls = 0;

  @override
  final _ErrorController controller = _ErrorController();

  @override
  Future<void> prepare() => preparation.future;

  @override
  Future<void> setPlaying(bool value) async {
    if (!disposed) {
      controller.value = controller.value.copyWith(isPlaying: value);
    }
  }

  @override
  Future<void> dispose() async {
    if (disposed) return;
    disposed = true;
    disposeCalls++;
    await controller.dispose();
  }
}
