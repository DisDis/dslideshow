// ignore_for_file: depend_on_referenced_packages, implementation_imports

/// Hardware lifecycle benchmark for the actual production slideshow renderer.
/// All orchestration and instrumentation deliberately live in benchmarks/.
library;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/storage.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:dslideshow_flutter/features/header/presentation/widgets/buttons_hint/buttons_hint_bloc.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_bloc.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_event.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_slide.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_state.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/status/slideshow_status_bloc.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/pages/slideshow_page.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/cameras_screen_widget.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/clock_screen_widget.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/photo_motion.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/state_notify_widget.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/video_widget.dart';
import 'package:dslideshow_flutter/src/injector.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterpi_gstreamer_video_player/flutterpi_gstreamer_video_player.dart';
import 'package:logging/logging.dart';

import 'src/media.dart';
import 'src/metrics.dart';
import 'src/report.dart' show atomicJson;
import 'src/telemetry.dart';

enum RendererScenario {
  glassPhoto,
  glassMotion,
  radialPhoto,
  waterMotion,
  filmPhoto,
  vhsPhoto,
  accordionLive,
  specialScreens;

  EffectType get effect => switch (this) {
    glassPhoto || glassMotion => EffectType.glass,
    radialPhoto => EffectType.radialBlur,
    waterMotion => EffectType.waterRefraction,
    filmPhoto => EffectType.filmDissolve,
    vhsPhoto => EffectType.vhsDamage,
    accordionLive => EffectType.accordion,
    specialScreens => EffectType.fade,
  };

  PhotoMotionMode get motion => switch (this) {
    glassMotion || waterMotion => PhotoMotionMode.kenBurns,
    _ => PhotoMotionMode.off,
  };

  List<String> get files => this == accordionLive
      ? ['photo_a.jpg', 'animation.gif', 'video_a.mp4', 'photo_b.jpg']
      : ['photo_a.jpg', 'photo_b.jpg', 'photo_large.jpg'];
}

/// Replaces only backend RPC/media selection; production Bloc and sessions run.
class RendererFrontend implements FrontendService {
  final MediaCatalog catalog;
  final List<String> files;
  final void Function(Map<String, Object?>) event;
  final buttons = StreamController<ButtonEvent>.broadcast();
  final screens = StreamController<bool>.broadcast();
  final actions = StreamController<ActionWithParam>.broadcast();
  int index = -1;

  RendererFrontend(this.catalog, this.files, this.event);

  @override
  Stream<ButtonEvent> get onButtonEvent => buttons.stream;
  @override
  Stream<bool> get onScreenStateChangePreparation => screens.stream;
  @override
  Stream<ActionWithParam> get onAction => actions.stream;
  @override
  Future<void> updateFrontendState({bool? isPaused, bool? isMenu}) async {}
  @override
  Future<void> storageNext() async {
    index++;
  }

  @override
  Future<MediaItem> getStorageCurrentItem() async {
    final name = files[index % files.length];
    event({'operation': 'storage_current', 'name': name});
    return MediaItem('renderer-$index-$name', catalog.file(name).uri);
  }

  @override
  Future<RpcResult> changeScreenLock(bool value) async =>
      const EmptyResult(id: 1);
  @override
  Future<RpcResult> screenTurn(bool value) async {
    screens.add(value);
    return const EmptyResult(id: 1);
  }

  Future<void> close() async {
    await buttons.close();
    await screens.close();
    await actions.close();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.environment['DSLIDESHOW_EMBEDDED'] == 'true') {
    FlutterpiVideoPlayer.registerWith();
  }
  final output = Directory(
    Platform.environment['BENCHMARK_OUTPUT'] ?? 'reports/renderer-$pid',
  );
  await output.create(recursive: true);
  final harness = RendererHarness(output);
  Logger.root.level = Level.INFO;
  Logger.root.onRecord.listen((record) {
    harness.event({
      'operation': 'log',
      'logger': record.loggerName,
      'level': record.level.name,
      'message': record.message,
    });
    if (record.level >= Level.WARNING) {
      harness.error(
        '${record.loggerName}: ${record.message}: ${record.error ?? ''}',
        record.stackTrace ?? StackTrace.current,
      );
    }
  });
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    harness.error(details.exception, details.stack ?? StackTrace.current);
  };
  ui.PlatformDispatcher.instance.onError = (error, stack) {
    harness.error(error, stack);
    return true;
  };
  try {
    await harness.initialize();
    runApp(RendererBenchmarkApp(harness: harness));
  } catch (error, stack) {
    harness.error(error, stack);
    await harness.finish();
    exit(2);
  }
}

class RendererHarness {
  final Directory output;
  final clock = Stopwatch()..start();
  late final IOSink events;
  late final IOSink telemetryLog;
  late final LinuxTelemetry telemetry;
  late MediaCatalog catalog;
  HttpServer? camera;
  StreamSubscription<HttpRequest>? cameraRequests;
  String stage = 'bootstrap';
  int errorCount = 0;
  int cameraRequestCount = 0;
  bool cameraHold = false;
  final heldRequests = <HttpRequest>[];
  final runs = <Map<String, Object?>>[];
  final frames = <FrameSample>[];
  final metadata = <String, Object?>{};
  final captures = Platform.environment['RENDERER_CAPTURE'] == 'true';
  bool measuring = false;
  bool sinksReady = false;
  bool telemetryReady = false;
  bool finished = false;
  final telemetrySamples =
      StreamController<Map<String, Object?>>.broadcast();
  final timingBatches = StreamController<void>.broadcast();
  int? frameWindowStartUs;
  int? frameWindowEndUs;
  int? lastTimingTimestampUs;

  RendererHarness(this.output);

  void event(Map<String, Object?> row) {
    final line = jsonEncode({
      'elapsed_us': clock.elapsedMicroseconds,
      'stage': stage,
      ...row,
    });
    if (sinksReady) events.writeln(line);
    // This line survives native crashes even before report completion.
    stdout.writeln('RENDERER_EVENT $line');
  }

  void error(Object error, StackTrace stack) {
    errorCount++;
    stderr.writeln('RENDERER_ERROR $error\n$stack');
    event({'operation': 'error', 'error': '$error', 'stack': '$stack'});
  }

  void timings(List<ui.FrameTiming> values) {
    if (!measuring) return;
    for (final value in values) {
      final timestamp = value.timestampInMicroseconds(ui.FramePhase.vsyncStart);
      lastTimingTimestampUs = timestamp;
      if (frameWindowStartUs != null && timestamp <= frameWindowStartUs!) {
        continue;
      }
      if (frameWindowEndUs != null && timestamp > frameWindowEndUs!) continue;
      frames.add(
        FrameSample(
          timestamp,
          value.buildDuration.inMicroseconds,
          value.rasterDuration.inMicroseconds,
          value.totalSpan.inMicroseconds,
        ),
      );
    }
    timingBatches.add(null);
  }

  Future<void> initialize() async {
    events = File('${output.path}/events.jsonl').openWrite();
    telemetryLog = File('${output.path}/telemetry.jsonl').openWrite();
    sinksReady = true;
    telemetry = LinuxTelemetry(
      stage: () => stage,
      onSample: (row) {
        telemetryLog.writeln(jsonEncode(row));
        telemetrySamples.add(row);
      },
      onError: error,
    );
    telemetryReady = true;
    metadata.addAll({
      'harness': 'production_slideshow_renderer_v1',
      'started_utc': DateTime.now().toUtc().toIso8601String(),
      'release': kReleaseMode,
      'capture_run': captures,
      'renderer': Platform.environment['BENCHMARK_RENDERER'],
      'build': jsonDecode(
        await rootBundle.loadString('assets/build-info.json'),
      ),
      'hardware': await telemetry.initialize(),
      'expected_size': [2560, 1600],
      'transition_ms': 1000,
      'repetitions': 3,
      'warmup_transitions': 1,
      'video_to_video': false,
    });
    catalog = await MediaCatalog.load(
      cache: Directory('${output.parent.path}/.renderer-media-cache'),
    );
    metadata['media'] = catalog.entries;
    camera = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    final jpeg = await catalog.file('photo_a.jpg').readAsBytes();
    cameraRequests = camera!.listen((request) async {
      cameraRequestCount++;
      event({'operation': 'camera_request', 'held': cameraHold});
      if (cameraHold) {
        heldRequests.add(request);
        return;
      }
      request.response.headers.contentType = ContentType('image', 'jpeg');
      request.response.add(jpeg);
      try {
        await request.response.close();
      } catch (_) {
        // A deliberately cancelled request may have no remaining peer.
      }
    });
    WidgetsBinding.instance.addTimingsCallback(timings);
    telemetry.start(250);
    await atomicJson(File('${output.path}/metadata.json'), metadata);
  }

  Future<void> releaseHeldCameras() async {
    cameraHold = false;
    for (final request in heldRequests.toList()) {
      request.response.statusCode = HttpStatus.serviceUnavailable;
      try {
        await request.response.close();
      } catch (_) {}
    }
    heldRequests.clear();
  }

  Future<void> checkpoint() async {
    await atomicJson(File('${output.path}/renderer-report.json'), {
      'metadata': metadata,
      'runs': runs,
      'errors': errorCount,
      'active_stage': stage,
      'camera_requests': cameraRequestCount,
    });
    if (sinksReady) {
      await events.flush();
      await telemetryLog.flush();
    }
  }

  Future<void> drainTimings() async {
    bool hasFinalFrame() => frames.isNotEmpty &&
        (lastTimingTimestampUs ?? -1) >= frameWindowEndUs!;
    if (hasFinalFrame()) return;
    try {
      await timingBatches.stream.firstWhere((_) => hasFinalFrame())
          .timeout(const Duration(seconds: 2));
    } on TimeoutException {
      throw StateError(
        'Painted FrameTiming marker missing: end=$frameWindowEndUs, '
        'last=$lastTimingTimestampUs, accepted=${frames.length}',
      );
    }
  }

  Future<void> awaitResourceQuiescence() async {
    var stable = 0;
    Map<String, Object?>? previous;
    final completion = Completer<void>();
    final subscription = telemetrySamples.stream.listen((sample) {
      if (sample['open_fds'] == previous?['open_fds'] &&
          sample['threads'] == previous?['threads']) {
        stable++;
      } else {
        stable = 0;
      }
      previous = sample;
      if (stable >= 3 && !completion.isCompleted) completion.complete();
    });
    try {
      await completion.future.timeout(const Duration(seconds: 5));
      event({
        'operation': 'cleanup_quiescent',
        'criterion': '3 consecutive equal FD/thread samples at 250ms',
        'last_sample': previous,
      });
    } finally {
      await subscription.cancel();
    }
  }

  Future<void> finish() async {
    if (finished) return;
    finished = true;
    stage = 'finished';
    WidgetsBinding.instance.removeTimingsCallback(timings);
    if (telemetryReady) await telemetry.stop();
    await releaseHeldCameras();
    await cameraRequests?.cancel();
    await camera?.close(force: true);
    await checkpoint();
    await telemetrySamples.close();
    await timingBatches.close();
    if (sinksReady) {
      await events.close();
      await telemetryLog.close();
    }
    stdout.writeln(
      'RENDERER_FINISHED errors=$errorCount reports=${output.path}',
    );
  }
}

class RendererBenchmarkApp extends StatefulWidget {
  final RendererHarness harness;
  const RendererBenchmarkApp({super.key, required this.harness});
  @override
  State<RendererBenchmarkApp> createState() => _RendererBenchmarkAppState();
}

class _RendererBenchmarkAppState extends State<RendererBenchmarkApp> {
  RendererHarness get h => widget.harness;
  final captureKey = GlobalKey();
  Widget page = const SizedBox.expand();
  SlideshowBloc? bloc;
  SlideshowStatusBloc? status;
  ButtonsHintBloc? hints;
  RendererFrontend? frontend;
  StreamSubscription<SlideshowState>? subscription;
  int displayCount = 0;
  int transitionCount = 0;
  int phaseStartedUs = 0;
  SlideshowPhase? previousPhase;
  double preparationMs = 0;
  double transitionMs = 0;
  final phaseWaiters = <VoidCallback>[];
  int caseErrors = 0;
  int timingMarker = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => unawaited(execute()));
  }

  void check(bool value, String message) {
    if (!value) throw StateError('$message; state=${bloc?.state}');
  }

  Future<void> until(bool Function() predicate, String description) async {
    if (predicate()) return;
    final completion = Completer<void>();
    void changed() {
      if (predicate() && !completion.isCompleted) completion.complete();
    }

    phaseWaiters.add(changed);
    try {
      await completion.future.timeout(
        const Duration(seconds: 60),
        onTimeout: () => throw TimeoutException(
          '$description; stage=${h.stage}; state=${bloc?.state}',
        ),
      );
    } finally {
      phaseWaiters.remove(changed);
    }
  }

  void stateChanged(SlideshowState state) {
    final now = h.clock.elapsedMicroseconds;
    h.event({
      'operation': 'state',
      'phase': state.phase.name,
      'current': slideName(state.currentSlide),
      'next': slideName(state.nextSlide),
      'effect': state.effect.type.name,
      'paused': state.isPaused,
      'screen_locked': state.isScreenLocked,
    });
    if (state.phase != previousPhase) {
      final duration = (now - phaseStartedUs) / 1000;
      if (state.phase == SlideshowPhase.display) displayCount++;
      if (state.phase == SlideshowPhase.transition) {
        transitionCount++;
        preparationMs = duration;
      }
      if (state.phase == SlideshowPhase.display &&
          previousPhase == SlideshowPhase.transition) {
        transitionMs = duration;
      }
      h.event({
        'operation': 'phase_duration',
        'phase': previousPhase?.name,
        'ending_at': state.phase.name,
        'duration_ms': duration,
      });
      previousPhase = state.phase;
      phaseStartedUs = now;
    }
    for (final waiter in phaseWaiters.toList()) {
      waiter();
    }
  }

  String? slideName(SlideshowSlide? slide) => switch (slide) {
    MediaSlide(:final item) => item.uri?.pathSegments.last,
    SpecialSlide(:final config) => config.type.name,
    null => null,
  };

  Future<void> mount(RendererScenario scenario) async {
    displayCount = transitionCount = 0;
    previousPhase = null;
    phaseStartedUs = h.clock.elapsedMicroseconds;
    final config = AppConfig.fromJson({
      'slideshow': {
        'displayTimeMs': scenario.motion == PhotoMotionMode.kenBurns ? 6000 : 60000,
        'fadeTimeMs': 150,
        'effects': {
          'defaultDurationMs': 1000,
          'items': {
            scenario.effect.name: {'enabled': true},
          },
        },
        'photoMotion': {'mode': scenario.motion.name},
        if (scenario == RendererScenario.specialScreens)
          'specialScreens': [
            {
              'id': 'clock',
              'type': 'clock',
              'enabled': true,
              'displayTimeMs': 60000,
              'schedule': {'count': 1},
              'options': {'showSeconds': true},
            },
            {
              'id': 'cameras',
              'type': 'cameras',
              'enabled': true,
              'displayTimeMs': 60000,
              'schedule': {'count': 1},
              'options': {
                'refreshIntervalMs': 250,
                'requestTimeoutMs': 10000,
                'cameras': [
                  {
                    'id': 'local',
                    'url': 'http://127.0.0.1:${h.camera!.port}/snapshot.jpg',
                  },
                ],
              },
            },
          ],
      },
    });
    frontend = RendererFrontend(h.catalog, scenario.files, h.event);
    status = SlideshowStatusBloc(
      frontendService: frontend!,
      config: config.slideshow,
    );
    hints = ButtonsHintBloc(
      frontendService: frontend!,
      statusBloc: status!,
      appConfig: config,
    );
    bloc = SlideshowBloc(
      frontendService: frontend!,
      config: config.slideshow,
      statusBloc: status!,
    );
    injector.registerSingleton<AppConfig>(config);
    injector.registerSingleton<FrontendService>(frontend!);
    subscription = bloc!.stream.listen(stateChanged);
    setState(() {
      page = MultiBlocProvider(
        key: ValueKey(scenario),
        providers: [
          BlocProvider<SlideshowBloc>.value(value: bloc!),
          BlocProvider<SlideshowStatusBloc>.value(value: status!),
          BlocProvider<ButtonsHintBloc>.value(value: hints!),
        ],
        child: const SlideShowPage(),
      );
    });
    await until(
      () => bloc!.state.phase == SlideshowPhase.display,
      'first display',
    );
    await WidgetsBinding.instance.endOfFrame;
  }

  Future<void> unmount() async {
    h.measuring = false;
    setState(() => page = const SizedBox.expand());
    await WidgetsBinding.instance.endOfFrame;
    await subscription?.cancel();
    await bloc?.close();
    await status?.close();
    await hints?.close();
    await frontend?.close();
    await injector.reset();
    await WidgetsBinding.instance.endOfFrame;
    await h.awaitResourceQuiescence();
    await h.telemetry.sample();
    h.event({'operation': 'unmounted'});
  }

  Future<void> capture(String name) async {
    if (!h.captures) return;
    await WidgetsBinding.instance.endOfFrame;
    final boundary =
        captureKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 1);
    try {
      final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
      await File('${h.output.path}/$name.png').writeAsBytes(
        bytes!.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes),
      );
    } finally {
      image.dispose();
    }
  }

  Future<void> next() async {
    await motionReady();
    final old = transitionCount;
    bloc!.add(const SlideshowLoadNextEvent());
    await until(() => transitionCount > old, 'transition start');
    if (h.captures) {
      await Future<void>.delayed(const Duration(milliseconds: 450));
      await capture('${h.stage}-transition');
    }
    await until(
      () => bloc!.state.phase == SlideshowPhase.display,
      'next display',
    );
  }

  Future<void> controls() async {
    final current = bloc!.state.currentSlide;
    final video = widgets<VideoWidget>().firstOrNull?.session?.controller;
    final camera = widgets<CamerasScreenWidget>().firstOrNull?.session;
    final clock = widgets<ClockScreenWidget>().firstOrNull?.session;
    await status!.executeActionAndWait(SlideshowAction.pause, true);
    await until(() => bloc!.state.isPaused, 'pause');
    await WidgetsBinding.instance.endOfFrame;
    if (video != null) {
      await listenableUntil(video, () => !video.value.isPlaying, 'video pause');
    }
    final motion = widgets<PhotoMotionFrame>().firstOrNull?.progress;
    final cameraRequests = h.cameraRequestCount;
    await Future<void>.delayed(const Duration(milliseconds: 350));
    // Query the native position as controller polling stops while paused.
    final pausedPosition = await video?.position.timeout(const Duration(seconds: 3));
    if (video != null) {
      await Future<void>.delayed(const Duration(milliseconds: 600));
      final position = await video.position.timeout(const Duration(seconds: 3));
      check(position == pausedPosition, 'native video advanced while paused');
    }
    check(identical(current, bloc!.state.currentSlide), 'pause changed slide');
    check(
      motion == widgets<PhotoMotionFrame>().firstOrNull?.progress,
      'PhotoMotion advanced while paused',
    );
    if (camera != null) {
      check(camera.active, 'pause disabled cameras');
      await frameUntil(
        () => h.cameraRequestCount > cameraRequests,
        'camera refresh while paused',
      );
    }
    if (clock != null) {
      check(clock.active, 'pause disabled clock');
      final second = clock.now().second;
      await listenableUntil(
        clock, () => clock.now().second != second, 'clock tick while paused',
      );
    }
    await noticeSettled();
    await status!.executeActionAndWait(SlideshowAction.toggleScreen, true);
    await until(() => bloc!.state.isScreenLocked, 'sleep');
    await WidgetsBinding.instance.endOfFrame;
    final sleepingRequests = h.cameraRequestCount;
    if (camera != null) check(!camera.active, 'sleep left cameras active');
    if (clock != null) check(!clock.active, 'sleep left clock active');
    await Future<void>.delayed(const Duration(milliseconds: 350));
    check(identical(current, bloc!.state.currentSlide), 'sleep changed slide');
    if (camera != null) {
      check(h.cameraRequestCount == sleepingRequests, 'cameras refreshed in sleep');
    }
    if (video != null) {
      final position = await video.position.timeout(const Duration(seconds: 3));
      check(position == pausedPosition, 'native video advanced during sleep');
    }
    await status!.executeActionAndWait(SlideshowAction.toggleScreen, false);
    await until(() => !bloc!.state.isScreenLocked, 'wake');
    await WidgetsBinding.instance.endOfFrame;
    if (camera != null) {
      check(camera.active, 'wake left cameras inactive');
      await frameUntil(
        () => h.cameraRequestCount > sleepingRequests,
        'camera refresh after wake',
      );
    }
    if (clock != null) check(clock.active, 'wake left clock inactive');
    await status!.executeActionAndWait(SlideshowAction.pause, false);
    await until(() => !bloc!.state.isPaused, 'resume');
    if (video != null) {
      final position = video.value.position;
      await listenableUntil(
        video,
        () => video.value.isPlaying && video.value.position != position,
        'video progress after resume',
      );
    }
    if (motion != null && motion < 1) {
      await frameUntil(
        () => (widgets<PhotoMotionFrame>().firstOrNull?.progress ?? motion) > motion,
        'PhotoMotion progress after resume',
      );
    }
    await noticeSettled();
    h.event({'operation': 'pause_sleep_wake_passed'});
  }

  Future<void> noticeSettled() async {
    await WidgetsBinding.instance.endOfFrame;
    Animation<double>? animation;
    void findAnimation(Element element) {
      if (element.widget case AnimatedBuilder(animation: final Animation<double> value)) {
        animation = value;
      }
      element.visitChildren(findAnimation);
    }
    void findNotice(Element element) {
      if (element.widget is StateNotify) {
        element.visitChildren(findAnimation);
      } else {
        element.visitChildren(findNotice);
      }
    }
    captureKey.currentContext!.visitChildElements(findNotice);
    check(animation != null, 'StateNotify animation is not observable');
    await listenableUntil(
      animation!, () => animation!.status == AnimationStatus.dismissed,
      'state notification animation completion',
    );
  }

  List<T> widgets<T extends Widget>() {
    final result = <T>[];
    void visit(Element element) {
      if (element.widget case final T widget) result.add(widget);
      element.visitChildren(visit);
    }
    captureKey.currentContext!.visitChildElements(visit);
    return result;
  }

  Future<void> listenableUntil(
    Listenable listenable,
    bool Function() predicate,
    String description,
  ) async {
    if (predicate()) return;
    final completion = Completer<void>();
    void changed() {
      if (predicate() && !completion.isCompleted) completion.complete();
    }
    listenable.addListener(changed);
    try {
      await completion.future.timeout(
        const Duration(seconds: 5),
        onTimeout: () => throw TimeoutException(description),
      );
    } finally {
      listenable.removeListener(changed);
    }
  }

  Future<void> frameUntil(bool Function() predicate, String description) async {
    final deadline = h.clock.elapsed + const Duration(seconds: 5);
    while (!predicate() && h.clock.elapsed < deadline) {
      await WidgetsBinding.instance.endOfFrame;
    }
    check(predicate(), description);
  }

  Future<void> motionReady() async {
    final motion = widgets<PhotoMotionFrame>().firstOrNull;
    if (motion == null) return;
    await frameUntil(
      () => (widgets<PhotoMotionFrame>().firstOrNull?.progress ?? 0) >= .2,
      'outgoing camera did not reach nonzero motion progress',
    );
    h.event({
      'operation': 'outgoing_motion_pose',
      'progress': widgets<PhotoMotionFrame>().first.progress,
    });
  }

  Future<void> specials() async {
    await next(); // media -> clock
    check(slideName(bloc!.state.currentSlide) == 'clock', 'clock not shown');
    await controls();
    await capture('special-clock');
    await next(); // clock -> media
    h.cameraHold = true;
    bloc!.add(const SlideshowLoadNextEvent()); // media -> preparing camera
    await until(
      () =>
          bloc!.state.nextSlide is SpecialSlide &&
          bloc!.state.phase == SlideshowPhase.precaching,
      'camera preparation',
    );
    await untilCameraRequest();
    final requests = h.cameraRequestCount;
    await status!.executeActionAndWait(SlideshowAction.toggleScreen, true);
    await until(() => bloc!.state.isScreenLocked, 'sleep preparing camera');
    await h.releaseHeldCameras();
    await status!.executeActionAndWait(SlideshowAction.toggleScreen, false);
    await until(
      () => bloc!.state.phase == SlideshowPhase.display,
      'camera retry',
    );
    check(
      slideName(bloc!.state.currentSlide) == 'cameras',
      'camera retry skipped',
    );
    check(h.cameraRequestCount > requests, 'camera was not requested again');
    await controls();
    await capture('special-cameras');
    await next();
    h.event({'operation': 'camera_cancel_retry_passed'});
  }

  Future<void> untilCameraRequest() async {
    final deadline = h.clock.elapsed + const Duration(seconds: 10);
    while (h.heldRequests.isEmpty && h.clock.elapsed < deadline) {
      await WidgetsBinding.instance.endOfFrame;
    }
    check(h.heldRequests.isNotEmpty, 'camera request was never observed');
  }

  Future<void> execute() async {
    try {
      final view = ui.PlatformDispatcher.instance.views.first;
      check(view.physicalSize == const Size(2560, 1600), 'unexpected display');
      final requested = Platform.environment['RENDERER_SCENARIOS'];
      final selected = requested == null
          ? RendererScenario.values
          : requested
                .split(',')
                .map((name) => RendererScenario.values.byName(name));
      h.metadata['scenarios'] = selected.map((value) => value.name).toList();
      h.metadata['display'] = {
        'physical_width': view.physicalSize.width,
        'physical_height': view.physicalSize.height,
        'pixel_ratio': view.devicePixelRatio,
        'refresh_rate': view.display.refreshRate,
      };
      await h.checkpoint();
      for (final scenario in selected) {
        h.stage = '${scenario.name}-warmup';
        caseErrors = h.errorCount;
        await mount(scenario);
        if (scenario == RendererScenario.specialScreens) {
          await specials();
          h.runs.add({
            'scenario': scenario.name,
            'status': h.errorCount == caseErrors ? 'passed' : 'failed',
            'errors': h.errorCount - caseErrors,
          });
        } else {
          await next();
          final repetitions = scenario == RendererScenario.accordionLive
              ? 6
              : 3;
          for (var repeat = 0; repeat < repetitions; repeat++) {
            h.stage = '${scenario.name}-$repeat';
            await motionReady();
            h.frames.clear();
            h.frameWindowStartUs = SchedulerBinding
                .instance
                .currentSystemFrameTimeStamp
                .inMicroseconds;
            h.frameWindowEndUs = null;
            h.lastTimingTimestampUs = null;
            h.measuring = true;
            final started = h.clock.elapsedMicroseconds;
            final outgoing = slideName(bloc!.state.currentSlide);
            await next();
            final finished = h.clock.elapsedMicroseconds;
            h.frameWindowEndUs = SchedulerBinding
                .instance
                .currentSystemFrameTimeStamp
                .inMicroseconds;
            // Submit two tiny painted markers after the closed window. A
            // scheduler timestamp need not correspond to a submitted frame.
            // Wait for a later marker's batch, retaining only the closed window.
            await WidgetsBinding.instance.endOfFrame;
            setState(() => timingMarker++);
            await WidgetsBinding.instance.endOfFrame;
            setState(() => timingMarker++);
            await WidgetsBinding.instance.endOfFrame;
            await h.drainTimings();
            h.event({
              'operation': 'frame_window_drained',
              'start_exclusive_us': h.frameWindowStartUs,
              'end_inclusive_us': h.frameWindowEndUs,
              'observed_marker_us': h.lastTimingTimestampUs,
              'accepted_frames': h.frames.length,
            });
            h.measuring = false;
            final row = <String, Object?>{
              'scenario': scenario.name,
              'repeat': repeat,
              'outgoing': outgoing,
              'incoming': slideName(bloc!.state.currentSlide),
              'effect': bloc!.state.effect.type.name,
              'photo_motion': scenario.motion.name,
              'wall_ms': (finished - started) / 1000,
              'preparation_ms': preparationMs,
              'transition_ms': transitionMs,
              ...frameMetrics(h.frames, view.display.refreshRate),
              'frame_samples': h.frames.map((frame) => frame.toJson()).toList(),
              'errors': h.errorCount - caseErrors,
              'status': h.errorCount == caseErrors ? 'passed' : 'failed',
            };
            h.runs.add(row);
            h.event({'operation': 'measurement', ...row});
            await h.checkpoint();
            await capture('${h.stage}-display');
            if (repeat == 0) await controls();
          }
        }
        h.stage = '${scenario.name}-cleanup';
        await unmount();
        await h.checkpoint();
      }
    } catch (error, stack) {
      h.error(error, stack);
      try {
        await unmount();
      } catch (cleanupError, cleanupStack) {
        h.error(cleanupError, cleanupStack);
      }
    } finally {
      await h.finish();
      exit(h.errorCount == 0 ? 0 : 2);
    }
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
    locale: const Locale('en'),
    debugShowCheckedModeBanner: false,
    home: RepaintBoundary(
      key: captureKey,
      child: Stack(
        fit: StackFit.expand,
        children: [
          page,
          Positioned(
            right: 0,
            bottom: 0,
            child: ColoredBox(
              color: timingMarker.isEven ? const Color(0xff000000) : const Color(0xff010101),
              child: const SizedBox(width: 1, height: 1),
            ),
          ),
        ],
      ),
    ),
  );
}
