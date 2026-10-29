// ignore_for_file: depend_on_referenced_packages, implementation_imports

/// Exercises the real OTA page without connecting to an installer or backend.
library;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/features/ota/presentation/pages/ota_page.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/status/slideshow_status_bloc.dart';
import 'package:dslideshow_flutter/src/injector.dart';
import 'package:dslideshow_flutter/src/route_bloc.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xterm/xterm.dart';

import 'src/metrics.dart';
import 'src/telemetry.dart';

enum OtaScenario {
  ready,
  uploading,
  installing,
  stream,
  burst,
  history,
  resume,
  failure,
  success,
  cleanup,
}

/// Only the external RPC dependency is replaced. No installer is present.
class OtaHarnessFrontend implements FrontendService {
  final info = StreamController<OTAInfo>.broadcast();
  final output = StreamController<String>.broadcast();
  final ready = StreamController<bool>.broadcast();
  final buttons = StreamController<ButtonEvent>.broadcast();
  final actions = StreamController<ActionWithParam>.broadcast();
  @override
  Stream<OTAInfo> get onOTAInfo => info.stream;
  @override
  Stream<String> get onOTAOutput => output.stream;
  @override
  Stream<bool> get onOTAReady => ready.stream;
  @override
  Stream<ButtonEvent> get onButtonEvent => buttons.stream;
  @override
  Stream<ActionWithParam> get onAction => actions.stream;
  @override
  Future<OTAInfo> getOTAInfo() async => otaInfo(OTAStatus.ready);
  @override
  Future<SystemInfo> getSystemInfo() async => SystemInfo.fromJson({
    'cpuInfo': {
      'cores': 4,
      'hardware': 'benchmark',
      'model': 'benchmark',
      'revision': 'fixture',
    },
    'networkInfo': {
      'lastUpdate': 0,
      'hasInternet': true,
      'interfaces': [
        {
          'name': 'wlan0',
          'status': 'running',
          'ip4': '192.168.50.143',
          'ip6': '',
        },
      ],
    },
    'osInfo': {'name': 'benchmark', 'osType': 'linux'},
    'updateInfo': {
      'cpuLoad1': 0.0,
      'cpuLoad5': 0.0,
      'cpuLoad15': 0.0,
      'diskAvailable': 0,
      'diskUsed': 0,
      'diskUsedPercent': 0,
      'lastUpdate': 0,
      'memTotal': 0,
      'memUsed': 0,
      'sensors': [],
      'swapTotal': 0,
      'swapUsed': 0,
      'uptime': '0',
    },
  });

  Future<void> close() async {
    await Future.wait([
      info.close(),
      output.close(),
      ready.close(),
      buttons.close(),
      actions.close(),
    ]);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

OTAInfo otaInfo(OTAStatus status, {double percent = 100}) => OTAInfo(
  uploadingPercent: percent,
  status: status,
  code: '835719',
  errorText: status == OTAStatus.issue
      ? 'Package verification failed. The existing firmware is unchanged.'
      : '',
  exitCode: status == OTAStatus.issue ? 1 : 0,
);

String otaLogLines(int start, int count) => List.generate(count, (i) {
  final n = start + i;
  return '[${n.toString().padLeft(5, '0')}] Verifying firmware payload /opt/dslideshow/package/assets/application-data-$n.bin: OK\n';
}).join();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final h = OtaHarness(
    Directory(Platform.environment['BENCHMARK_OUTPUT'] ?? 'reports/ota-$pid'),
  );
  await h.initialize();
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    h.error(details.exception, details.stack ?? StackTrace.current);
  };
  ui.PlatformDispatcher.instance.onError = (error, stack) {
    h.error(error, stack);
    return true;
  };
  runApp(OtaHarnessApp(harness: h));
  WidgetsBinding.instance.addPostFrameCallback((_) => unawaited(h.execute()));
}

class OtaHarness {
  final Directory output;
  final rootKey = GlobalKey();
  final mounted = ValueNotifier(true);
  final marker = ValueNotifier(0);
  final frontend = OtaHarnessFrontend();
  final route = RouteBloc();
  late final SlideshowStatusBloc status;
  late final LinuxTelemetry telemetry;
  late final IOSink events;
  late final IOSink samples;
  final captures = Platform.environment['OTA_CAPTURE'] == 'true';
  final frames = <FrameSample>[];
  final rows = <Map<String, Object?>>[];
  final errors = <String>[];
  OtaScenario stage = OtaScenario.ready;
  int? frameStart;
  int? frameEnd;
  int? lastFrame;
  final timingBatches = StreamController<void>.broadcast();

  OtaHarness(this.output);

  Future<void> initialize() async {
    await output.create(recursive: true);
    events = File('${output.path}/events.jsonl').openWrite();
    samples = File('${output.path}/telemetry.jsonl').openWrite();
    status = SlideshowStatusBloc(
      frontendService: frontend,
      config: SlideShowConfig.fromJson({}),
    );
    injector.registerSingleton<FrontendService>(frontend);
    injector.registerSingleton<RouteBloc>(route);
    telemetry = LinuxTelemetry(
      stage: () => stage.name,
      onSample: (row) => samples.writeln(jsonEncode(row)),
      onError: error,
    );
    final hardware = await telemetry.initialize();
    telemetry.start(250);
    SchedulerBinding.instance.addTimingsCallback(timings);
    await File('${output.path}/metadata.json').writeAsString(
      jsonEncode({
        'harness': 'production_ota_v1',
        'capture_run': captures,
        'release': kReleaseMode,
        'renderer': 'opengl',
        'size': [2560, 1600],
        'locale': 'en',
        'build': jsonDecode(
          await rootBundle.loadString('assets/build-info.json'),
        ),
        'hardware': hardware,
        'real_installation': false,
      }),
    );
  }

  void event(Map<String, Object?> row) {
    final value = {'stage': stage.name, ...row};
    events.writeln(jsonEncode(value));
    stdout.writeln('OTA_EVENT ${jsonEncode(value)}');
  }

  void error(Object error, StackTrace stack) {
    errors.add('$error');
    event({'error': '$error', 'stack': '$stack'});
  }

  void timings(List<ui.FrameTiming> values) {
    for (final frame in values) {
      final timestamp = frame.timestampInMicroseconds(ui.FramePhase.vsyncStart);
      lastFrame = timestamp;
      if (frameStart != null &&
          timestamp > frameStart! &&
          (frameEnd == null || timestamp <= frameEnd!)) {
        frames.add(
          FrameSample(
            timestamp,
            frame.buildDuration.inMicroseconds,
            frame.rasterDuration.inMicroseconds,
            frame.totalSpan.inMicroseconds,
          ),
        );
      }
    }
    timingBatches.add(null);
  }

  Iterable<Element> descendants(Element parent) sync* {
    final children = <Element>[];
    parent.visitChildren(children.add);
    for (final child in children) {
      yield child;
      yield* descendants(child);
    }
  }

  Iterable<Element> elements() =>
      descendants(rootKey.currentContext! as Element);

  Element get terminalElement =>
      elements().singleWhere((element) => element.widget is TerminalView);

  TerminalView get terminal => terminalElement.widget as TerminalView;
  ScrollableState get scrollable =>
      descendants(terminalElement)
          .whereType<StatefulElement>()
          .map((e) => e.state)
          .whereType<ScrollableState>()
          .firstWhere((s) => s.position.axis == Axis.vertical);

  Future<void> until(bool Function() condition, String description) async {
    final clock = Stopwatch()..start();
    while (!condition()) {
      if (clock.elapsed > const Duration(seconds: 5)) {
        throw TimeoutException(description);
      }
      SchedulerBinding.instance.scheduleFrame();
      await WidgetsBinding.instance.endOfFrame;
    }
  }

  Future<void> paint() async {
    SchedulerBinding.instance.scheduleFrame();
    await WidgetsBinding.instance.endOfFrame;
  }

  Future<void> capture() async {
    if (!captures) return;
    final boundary =
        rootKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 1);
    try {
      final data = await image.toByteData(format: ui.ImageByteFormat.png);
      await File('${output.path}/${stage.name}.png')
          .writeAsBytes(data!.buffer.asUint8List());
    } finally {
      image.dispose();
    }
  }

  Future<void> phase(
    OtaScenario next,
    Future<void> Function() operation,
  ) async {
    stage = next;
    event({'operation': 'start'});
    await operation();
    await paint();
    await telemetry.sample();
    await capture();
    if (elements().any((e) => e.widget is TerminalView)) {
      final rect =
          (elements()
                      .firstWhere((e) => e.widget is TerminalView)
                      .findRenderObject()
                  as RenderBox)
              .size;
      event({
        'terminal_width': rect.width,
        'terminal_height': rect.height,
        'font_size': terminal.textStyle.fontSize,
        'scroll_pixels': scrollable.position.pixels,
        'scroll_max': scrollable.position.maxScrollExtent,
      });
    }
  }

  Future<void> execute() async {
    try {
      await phase(
        OtaScenario.ready,
        () => until(
          () => elements().any(
            (e) => e.widget is Text && (e.widget as Text).data == '835719',
          ),
          'ready access code',
        ),
      );
      await phase(OtaScenario.uploading, () async {
        frontend.info.add(otaInfo(OTAStatus.uploading, percent: 42));
        await paint();
      });
      await phase(OtaScenario.installing, () async {
        frontend.info.add(otaInfo(OTAStatus.instaling));
        await until(
          () => elements().any((e) => e.widget is TerminalView),
          'install terminal',
        );
      });
      await phase(OtaScenario.stream, () async {
        frames.clear();
        frameStart = SchedulerBinding
            .instance
            .currentSystemFrameTimeStamp
            .inMicroseconds;
        frameEnd = null;
        final clock = Stopwatch()..start();
        final completion = Completer<void>();
        var count = 0;
        final timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
          frontend.output.add(otaLogLines(count * 3, 3));
          if (++count == 100) {
            timer.cancel();
            completion.complete();
          }
        });
        try {
          await completion.future.timeout(const Duration(seconds: 10));
        } finally {
          timer.cancel();
        }
        await paint();
        frameEnd = SchedulerBinding
            .instance
            .currentSystemFrameTimeStamp
            .inMicroseconds;
        await paint();
        marker.value++;
        await paint();
        marker.value++;
        await paint();
        if (lastFrame == null || lastFrame! <= frameEnd!) {
          await timingBatches.stream
              .firstWhere((_) => lastFrame != null && lastFrame! > frameEnd!)
              .timeout(const Duration(seconds: 3));
        }
        rows.add({
          'scenario': stage.name,
          'wall_ms': clock.elapsedMilliseconds,
          ...frameMetrics(
            frames,
            ui.PlatformDispatcher.instance.views.first.display.refreshRate,
          ),
          'frame_samples': frames.map((f) => f.toJson()).toList(),
        });
        frameStart = null;
      });
      await phase(OtaScenario.burst, () async {
        frontend.output.add(otaLogLines(300, 200));
        await paint();
      });
      await phase(OtaScenario.history, () async {
        final position = scrollable.position;
        final target = (position.maxScrollExtent - 400).clamp(
          0.0,
          position.maxScrollExtent,
        );
        position.drag(DragStartDetails(), () {})
          ..update(
            DragUpdateDetails(
              globalPosition: Offset.zero,
              delta: const Offset(0, 400),
              primaryDelta: 400,
            ),
          )
          ..end(DragEndDetails(primaryVelocity: 0));
        await until(
          () => !position.isScrollingNotifier.value,
          'history gesture',
        );
        final before = position.pixels;
        if (position.extentAfter < 100) {
          throw StateError('History gesture did not leave the terminal tail');
        }
        frontend.output.add(otaLogLines(500, 50));
        await paint();
        event({
          'history_before': before,
          'history_after': position.pixels,
          'requested_history_target': target,
          'history_preserved': (before - position.pixels).abs() < 1,
        });
        if ((before - position.pixels).abs() >= 1) {
          throw StateError(
            'New output displaced the terminal history viewport',
          );
        }
      });
      await phase(OtaScenario.resume, () async {
        final buttons = elements()
            .map((e) => e.widget)
            .whereType<ButtonStyleButton>()
            .where((b) => b.onPressed != null)
            .toList();
        if (buttons.isNotEmpty) {
          buttons.last.onPressed!();
        } else {
          scrollable.position.jumpTo(scrollable.position.maxScrollExtent);
        }
        await until(
          () => !scrollable.position.isScrollingNotifier.value,
          'resume settle',
        );
        frontend.output.add(otaLogLines(550, 25));
        await paint();
        event({
          'at_latest': scrollable.position.extentAfter < 1,
          'resume_button_present': buttons.isNotEmpty,
        });
        if (scrollable.position.extentAfter >= 1) {
          throw StateError('Terminal did not follow new output after resume');
        }
      });
      await phase(OtaScenario.failure, () async {
        frontend.info.add(otaInfo(OTAStatus.issue));
        await paint();
      });
      await phase(OtaScenario.success, () async {
        frontend.info.add(otaInfo(OTAStatus.finished));
        await paint();
      });
      await phase(OtaScenario.cleanup, () async {
        mounted.value = false;
        await paint();
        await status.close();
        await route.close();
        await frontend.close();
        await injector.reset();
      });
    } catch (e, stack) {
      error(e, stack);
    }
    await telemetry.stop();
    SchedulerBinding.instance.removeTimingsCallback(timings);
    await File('${output.path}/ota-report.json').writeAsString(
      const JsonEncoder.withIndent('  ').convert({
        'successful': errors.isEmpty,
        'errors': errors,
        'runs': rows,
        'capture_run': captures,
      }),
    );
    await events.close();
    await samples.close();
    await timingBatches.close();
    exit(errors.isEmpty ? 0 : 2);
  }
}

class OtaHarnessApp extends StatelessWidget {
  final OtaHarness harness;
  const OtaHarnessApp({super.key, required this.harness});
  @override
  Widget build(BuildContext context) => MaterialApp(
    locale: const Locale('en'),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: const ColorScheme.dark(surface: Colors.black),
    ),
    home: RepaintBoundary(
      key: harness.rootKey,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ValueListenableBuilder<bool>(
            valueListenable: harness.mounted,
            builder: (_, visible, _) => visible
                ? BlocProvider.value(value: harness.status, child: OTAPage())
                : const SizedBox.expand(),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: ValueListenableBuilder<int>(
              valueListenable: harness.marker,
              builder: (_, marker, _) => ColoredBox(
                color: marker.isEven
                    ? const Color(0xff000000)
                    : const Color(0xff010101),
                child: const SizedBox(width: 1, height: 1),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
