import 'dart:async';

import 'package:config_app/features/config/presentation/pages/welcome_editor_page.dart';
import 'package:config_app/features/config/presentation/pages/slideshow_editor_page.dart';
import 'package:config_app/features/config/presentation/pages/special_screen_editor_page.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/clock_screen_widget.dart';
import 'package:dslideshow_flutter/effect.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/video_widget.dart';
import 'package:config_app/features/config/presentation/wigdgets/preview_editor_layout.dart';
import 'package:config_app/features/config/presentation/wigdgets/slideshow_preview.dart';
import 'package:config_app/features/config/presentation/wigdgets/special_screen_preview.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dio/dio.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/sessions/special_screen_session.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/special_screen_renderers.dart';
import 'package:dslideshow_flutter/features/welcome/presrntation/widgets/animated_logo.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _app(Widget child, {Locale locale = const Locale('en')}) => MaterialApp(
  locale: locale,
  supportedLocales: AppLocalizations.supportedLocales,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  theme: ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.teal,
      brightness: Brightness.dark,
    ),
  ),
  home: child,
);

void main() {
  testWidgets(
    'welcome replay restarts completed, forward and reverse animations',
    (tester) async {
      await tester.pumpWidget(
        _app(
          WelcomeEditorPage(
            config: WelcomeConfig(text: 'Welcome', size: 100, delayMs: 100),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final replay = find.byKey(const ValueKey('welcome-replay'));
      await tester.ensureVisible(replay);
      await tester.pumpAndSettle();
      double opacity() => tester
          .widget<Opacity>(
            find.descendant(
              of: find.byType(AnimatedLogo),
              matching: find.byType(Opacity),
            ),
          )
          .opacity;
      expect(opacity(), 1);
      await tester.tap(replay);
      expect(tester.takeException(), isNull);
      await tester.pump();
      expect(opacity(), 0);
      await tester.pump(const Duration(milliseconds: 50));
      expect(opacity(), greaterThan(0));
      expect(opacity(), lessThan(1));
      await tester.tap(replay);
      expect(tester.takeException(), isNull);
      await tester.pump();
      expect(opacity(), 0);
      await tester.pump(const Duration(milliseconds: 101));
      // reverse() starts a new ticker from the completed status callback.
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));
      expect(opacity(), greaterThan(0));
      expect(opacity(), lessThan(1));
      await tester.tap(replay);
      expect(tester.takeException(), isNull);
      await tester.pump();
      expect(opacity(), 0);
      await tester.pumpAndSettle();
      expect(opacity(), 1);
      await tester.pumpWidget(const SizedBox());
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'Russian welcome decimal keyboard updates preview and rejects mixed separators and fractional integers',
    (tester) async {
      final config = WelcomeConfig(text: 'Привет', size: 100, delayMs: 800);
      await tester.pumpWidget(
        _app(WelcomeEditorPage(config: config), locale: const Locale('ru')),
      );
      await tester.pump();
      final size = find.byKey(const ValueKey('welcome-size'));
      await tester.ensureVisible(size);
      await tester.enterText(size, '96,5');
      await tester.pump();
      expect(config.size, 96.5);
      expect(tester.widget<AnimatedLogo>(find.byType(AnimatedLogo)).size, 96.5);
      expect(find.byKey(const ValueKey('preview-last-valid')), findsNothing);
      for (final input in ['96,5.2', 'NaN', '0,0', '1600,1']) {
        await tester.enterText(size, input);
        await tester.pump();
        expect(config.size, 96.5);
        expect(
          tester.widget<AnimatedLogo>(find.byType(AnimatedLogo)).size,
          96.5,
        );
        expect(
          find.byKey(const ValueKey('preview-last-valid')),
          findsOneWidget,
        );
      }
      await tester.enterText(size, '98.25');
      await tester.pump();
      expect(config.size, 98.25);
      expect(
        tester.widget<AnimatedLogo>(find.byType(AnimatedLogo)).size,
        98.25,
      );
      final delay = find.byKey(const ValueKey('welcome-delay'));
      await tester.ensureVisible(delay);
      await tester.enterText(delay, '1200,0');
      await tester.pump();
      expect(config.delayMs, 800);
      expect(find.byKey(const ValueKey('preview-last-valid')), findsOneWidget);
      await tester.enterText(delay, '1200');
      await tester.pump();
      expect(config.delayMs, 1200);
      expect(find.byKey(const ValueKey('preview-last-valid')), findsNothing);
      await tester.pumpWidget(const SizedBox());
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'Russian clock style accepts comma and point decimals and keeps last valid preview',
    (tester) async {
      final config = SpecialScreenConfig(
        id: 'clock',
        type: SpecialScreenType.clock,
      );
      await tester.pumpWidget(
        _app(
          SpecialScreenEditorPage(config: config),
          locale: const Locale('ru'),
        ),
      );
      await tester.pumpAndSettle();
      final context = tester.element(find.byType(SpecialScreenEditorPage));
      final l = AppLocalizations.of(context);
      final size = find.widgetWithText(TextFormField, l.special_time_size);
      await tester.ensureVisible(size);
      Future<void> refresh() async {
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 450));
        await tester.pump();
      }

      double previewSize() =>
          (tester
                      .widget<ClockScreenWidget>(find.byType(ClockScreenWidget))
                      .session
                      .config
                      .options
                  as ClockScreenOptions)
              .timeFontSizePercent;
      await tester.enterText(size, '11,5');
      await refresh();
      expect(previewSize(), 11.5);
      expect(find.byKey(const ValueKey('preview-last-valid')), findsNothing);
      await tester.enterText(size, '11,5.2');
      await refresh();
      expect(previewSize(), 11.5);
      expect(find.byKey(const ValueKey('preview-last-valid')), findsOneWidget);
      await tester.enterText(size, '12.25');
      await refresh();
      expect(previewSize(), 12.25);
      expect(find.byKey(const ValueKey('preview-last-valid')), findsNothing);
      // This editor still owns an isolated local draft until Done.
      expect(
        (config.options as ClockScreenOptions).timeFontSizePercent,
        isNot(12.25),
      );
      await tester.pumpWidget(const SizedBox());
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('Russian slideshow slider values use decimal comma', (
    tester,
  ) async {
    final config = SlideShowConfig.fromJson({
      'photoMotion': {'mode': 'kenBurns', 'maxZoom': 1.06},
      'backgroundOpacity': .75,
    });
    await tester.pumpWidget(
      _app(SlideshowEditorPage(config: config), locale: const Locale('ru')),
    );
    await tester.tap(find.byKey(const ValueKey('preview-toggle')));
    await tester.pumpAndSettle();
    final zoom = find.byKey(const ValueKey('photo-motion-zoom'));
    final opacity = find.byKey(const ValueKey('slideshow-background-opacity'));
    expect(tester.widget<Slider>(zoom).label, '1,06');
    expect(tester.widget<Slider>(opacity).label, '0,75');
    expect(find.text('×1,06'), findsOneWidget);
    tester.widget<Slider>(zoom).onChanged!(1.12);
    tester.widget<Slider>(opacity).onChanged!(.5);
    await tester.pump();
    expect(tester.widget<Slider>(zoom).label, '1,12');
    expect(tester.widget<Slider>(opacity).label, '0,50');
    expect(config.photoMotion.maxZoom, 1.12);
    expect(config.backgroundOpacity, .5);
    await tester.pumpWidget(const SizedBox());
    expect(tester.takeException(), isNull);
  });
  testWidgets(
    'conditional slideshow controls preserve incomplete background color input',
    (tester) async {
      final config = SlideShowConfig.fromJson({});
      final checks = <ValueGetter<bool>>{};
      await tester.pumpWidget(
        _app(
          SlideshowEditorPage(
            config: config,
            registerDraft: (check) {
              checks.add(check);
              return () => checks.remove(check);
            },
          ),
        ),
      );
      await tester.tap(find.byKey(const ValueKey('preview-toggle')));
      await tester.pumpAndSettle();
      final color = find.byKey(const ValueKey('slideshow-background-color'));
      await tester.ensureVisible(color);
      await tester.enterText(color, 'bad');
      await tester.pump();
      final state = tester.state<FormFieldState<String>>(color);
      final mode = tester.widget<DropdownButtonFormField<PhotoMotionMode>>(
        find.byKey(const ValueKey('photo-motion-mode')),
      );
      mode.onChanged!(PhotoMotionMode.kenBurns);
      await tester.pump();
      expect(tester.state<FormFieldState<String>>(color), same(state));
      expect(state.value, 'bad');
      mode.onChanged!(PhotoMotionMode.off);
      await tester.pump();
      expect(tester.state<FormFieldState<String>>(color), same(state));
      expect(state.value, 'bad');
      expect(checks.single(), isTrue);
      await tester.pumpWidget(const SizedBox());
      expect(checks, isEmpty);
      expect(tester.takeException(), isNull);
    },
  );

  for (final completeTransition in [false, true]) {
    testWidgets(
      'lifecycle sends pause intent without another frame to ${completeTransition ? 'current' : 'pending'} video',
      (tester) async {
        final pendingImage = _PendingProvider();
        final session = _FakeVideoSession();
        final key = GlobalKey<SlideshowPreviewState>();
        addTearDown(
          () => tester.binding.handleAppLifecycleStateChanged(
            AppLifecycleState.resumed,
          ),
        );
        await tester.pumpWidget(
          _app(
            Scaffold(
              body: SingleChildScrollView(
                child: SlideshowPreview(
                  key: key,
                  config: SlideShowConfig.fromJson({
                    'transitionTimeMs': 100,
                    'displayTimeMs': 60000,
                  }),
                  images: [pendingImage],
                  videoFactory: (_) => session,
                ),
              ),
            ),
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
        expect(session.playing, contains(true));
        if (completeTransition) {
          for (var i = 0; i < 15; i++) {
            await tester.pump(const Duration(milliseconds: 16));
          }
        }
        session.playing.clear();
        tester.binding.handleAppLifecycleStateChanged(
          AppLifecycleState.inactive,
        );
        tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.hidden);
        // There is intentionally no pump/frame between suspension and assertion.
        expect(session.playing, contains(false));
        tester.binding.handleAppLifecycleStateChanged(
          AppLifecycleState.inactive,
        );
        tester.binding.handleAppLifecycleStateChanged(
          AppLifecycleState.resumed,
        );
        await tester.pumpWidget(const SizedBox());
        expect(session.disposed, isTrue);
        expect(tester.takeException(), isNull);
      },
    );
  }
  testWidgets(
    'collapsing preview aborts its HTTP request and ignores a late response',
    (tester) async {
      final adapter = _PendingAdapter();
      final dio = Dio()..httpClientAdapter = adapter;
      await tester.pumpWidget(
        _app(
          Scaffold(
            body: PreviewEditorLayout(
              editor: const Text('Editor'),
              previewBuilder: (_) => SlideshowPreview(
                config: SlideShowConfig.fromJson({}),
                mediaClient: dio,
              ),
            ),
          ),
        ),
      );
      for (var i = 0; i < 10 && adapter.requests == 0; i++) {
        await tester.pump(const Duration(milliseconds: 1));
      }
      expect(adapter.requests, 1);
      await tester.tap(find.byKey(const ValueKey('preview-toggle')));
      await tester.pump();
      expect(adapter.cancelled, isTrue);
      expect(adapter.closed, isTrue);
      adapter.response.complete(
        ResponseBody.fromString('late invalid image', 200),
      );
      await tester.pump();
      expect(find.byType(SlideshowPreview), findsNothing);
      expect(find.byKey(const ValueKey('preview-error')), findsNothing);
      await tester.pumpWidget(const SizedBox());
      expect(tester.takeException(), isNull);
    },
  );
  testWidgets(
    'welcome preview reflects draft text and size, keeps invalid last-valid input across layout changes',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(1200, 900));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final checks = <ValueGetter<bool>>{};
      final config = WelcomeConfig(text: 'Welcome', size: 300, delayMs: 800);
      await tester.pumpWidget(
        _app(
          WelcomeEditorPage(
            config: config,
            registerDraft: (check) {
              checks.add(check);
              return () => checks.remove(check);
            },
          ),
          locale: const Locale('ru'),
        ),
      );
      await tester.pump();
      expect(find.byKey(const ValueKey('editor-wide-layout')), findsOneWidget);
      final text = find.byKey(const ValueKey('welcome-text'));
      await tester.enterText(text, 'Привет, дом!');
      await tester.pump();
      expect(config.text, 'Привет, дом!');
      expect(
        tester.widget<AnimatedLogo>(find.byType(AnimatedLogo)).text,
        'Привет, дом!',
      );
      final size = find.byKey(const ValueKey('welcome-size'));
      await tester.enterText(size, '240');
      await tester.pump();
      expect(tester.widget<AnimatedLogo>(find.byType(AnimatedLogo)).size, 240);
      await tester.enterText(size, 'NaN');
      await tester.pump();
      expect(config.size, 240);
      expect(checks.single(), isTrue);
      expect(find.byKey(const ValueKey('preview-last-valid')), findsOneWidget);
      await tester.binding.setSurfaceSize(const Size(430, 900));
      await tester.pump();
      expect(
        find.byKey(const ValueKey('editor-compact-layout')),
        findsOneWidget,
      );
      expect(tester.widget<TextFormField>(size).controller, isNull);
      expect(find.text('NaN'), findsOneWidget);
      expect(checks.single(), isTrue);
      final viewport = tester.widget<DevicePreviewViewport>(
        find.byType(DevicePreviewViewport),
      );
      expect(viewport.aspectRatio, 16 / 10);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
      expect(checks, isEmpty);
    },
  );

  testWidgets(
    'collapsed and lifecycle-hidden preview releases pending image listener and timer',
    (tester) async {
      final provider = _PendingProvider();
      await tester.pumpWidget(
        _app(
          Scaffold(
            body: PreviewEditorLayout(
              editor: const Text('Editor'),
              previewBuilder: (_) => SlideshowPreview(
                config: SlideShowConfig.fromJson({}),
                images: [provider],
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(provider.completers, hasLength(1));
      expect(provider.completers.single.listeners, isNotEmpty);
      await tester.tap(find.byKey(const ValueKey('preview-toggle')));
      await tester.pump();
      expect(find.byType(SlideshowPreview), findsNothing);
      expect(provider.completers.single.listeners, isEmpty);
      await tester.pump(const Duration(seconds: 35));
      expect(provider.completers, hasLength(1));
      await tester.tap(find.byKey(const ValueKey('preview-toggle')));
      await tester.pump();
      await tester.pump();
      expect(provider.completers, hasLength(2));
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.hidden);
      await tester.pump();
      expect(find.byType(SlideshowPreview), findsNothing);
      expect(provider.completers.last.listeners, isEmpty);
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pump();
      await tester.pump();
      expect(provider.completers, hasLength(3));
      await tester.pumpWidget(const SizedBox());
      await tester.pump(const Duration(seconds: 35));
      expect(provider.completers.every((c) => c.listeners.isEmpty), isTrue);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'preview image errors are localized and do not retry automatically',
    (tester) async {
      final provider = _PendingProvider();
      await tester.pumpWidget(
        _app(
          Scaffold(
            body: SingleChildScrollView(
              child: SlideshowPreview(
                config: SlideShowConfig.fromJson({}),
                images: [provider],
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      provider.completers.single.reportError(
        context: ErrorDescription('Preview test'),
        exception: StateError('secret-url'),
      );
      await tester.pump();
      expect(find.byKey(const ValueKey('preview-error')), findsOneWidget);
      expect(find.textContaining('secret-url'), findsNothing);
      await tester.pump(const Duration(seconds: 35));
      expect(provider.completers, hasLength(1));
      await tester.pumpWidget(const SizedBox());
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'special preview disposes hidden sessions and ignores late preparation',
    (tester) async {
      final sessions = <_PendingSession>[];
      final config = SpecialScreenConfig(
        id: 'clock',
        type: SpecialScreenType.clock,
      );
      final renderer = SpecialScreenRenderer((config, _) {
        final session = _PendingSession(config);
        sessions.add(session);
        return session;
      }, (_) => const SizedBox(key: ValueKey('prepared-special')));
      Widget app(bool enabled) => _app(
        Scaffold(
          body: TickerMode(
            enabled: enabled,
            child: SpecialScreenPreview(config: config, renderer: renderer),
          ),
        ),
      );
      await tester.pumpWidget(app(true));
      expect(sessions, hasLength(1));
      await tester.pumpWidget(app(false));
      expect(sessions.single.closed, isTrue);
      sessions.single.preparation.complete(true);
      await tester.pump();
      expect(find.byKey(const ValueKey('prepared-special')), findsNothing);
      await tester.pumpWidget(app(true));
      expect(sessions, hasLength(2));
      sessions.last.preparation.complete(true);
      await tester.pump();
      expect(sessions.last.active, isTrue);
      expect(find.byKey(const ValueKey('prepared-special')), findsOneWidget);
      await tester.pumpWidget(const SizedBox());
      expect(sessions.every((s) => s.closed), isTrue);
      expect(tester.takeException(), isNull);
    },
  );
}

class _PendingSession extends SpecialScreenSession {
  final preparation = Completer<bool>();
  _PendingSession(super.config);
  @override
  Future<bool> prepare() => preparation.future;
}

class _PendingProvider extends ImageProvider<int> {
  final completers = <_TrackedCompleter>[];
  @override
  Future<int> obtainKey(ImageConfiguration configuration) =>
      SynchronousFuture(identityHashCode(this));
  @override
  void resolveStreamForKey(
    ImageConfiguration configuration,
    ImageStream stream,
    int key,
    ImageErrorListener handleError,
  ) {
    final completer = _TrackedCompleter();
    completers.add(completer);
    stream.setCompleter(completer);
  }
}

class _TrackedCompleter extends ImageStreamCompleter {
  final listeners = <ImageStreamListener>{};
  @override
  void addListener(ImageStreamListener listener) {
    listeners.add(listener);
    super.addListener(listener);
  }

  @override
  void removeListener(ImageStreamListener listener) {
    listeners.remove(listener);
    super.removeListener(listener);
  }
}

class _PendingAdapter implements HttpClientAdapter {
  final response = Completer<ResponseBody>();
  int requests = 0;
  bool cancelled = false;
  bool closed = false;
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) {
    requests++;
    cancelFuture?.then((_) => cancelled = true);
    return response.future;
  }

  @override
  void close({bool force = false}) {
    closed = true;
  }
}

class _FakeVideoSession implements VideoSession {
  final playing = <bool>[];
  bool disposed = false;
  @override
  final controller = null;
  @override
  Future<void> prepare() async {}
  @override
  Future<void> setPlaying(bool value) async {
    playing.add(value);
  }

  @override
  Future<void> dispose() async {
    disposed = true;
  }
}
