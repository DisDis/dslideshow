import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterpi_gstreamer_video_player/flutterpi_gstreamer_video_player.dart';
import 'package:path/path.dart' as path;

import 'src/config.dart';
import 'src/media.dart';
import 'src/report.dart';
import 'src/runner.dart';
import 'src/telemetry.dart';
import 'src/viewport.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final output = Directory(
    Platform.environment['BENCHMARK_OUTPUT'] ??
        'reports/${DateTime.now().toUtc().toIso8601String().replaceAll(':', '-')}-$pid',
  );
  ReportStore? store;
  try {
    store = ReportStore(output);
    await store.open();
    final config = await BenchmarkConfig.load(Platform.environment);
    var runtimeErrors = 0;
    var stage = 'preflight';
    void error(Object error, StackTrace stack) {
      runtimeErrors++;
      store!.error(error, stack, caseId: stage);
      stderr.writeln('BENCHMARK_ERROR $error\n$stack');
    }

    FlutterError.onError = (details) {
      FlutterError.presentError(details);
      error(details.exception, details.stack ?? StackTrace.current);
    };
    PlatformDispatcher.instance.onError = (exception, stack) {
      error(exception, stack);
      return true;
    };
    final telemetry = LinuxTelemetry(
      onSample: store.telemetry,
      stage: () => stage,
    );
    store.metadata.addAll({
      'started_utc': DateTime.now().toUtc().toIso8601String(),
      'config': config.toJson(),
      'requested_renderer':
          Platform.environment['BENCHMARK_RENDERER'] ?? 'unspecified',
      'build_mode': kReleaseMode
          ? 'release'
          : kProfileMode
          ? 'profile'
          : 'debug',
      'dart': Platform.version,
      'pid': pid,
      'executable': Platform.resolvedExecutable,
      'build': jsonDecode(
        await rootBundle.loadString('assets/build-info.json'),
      ),
      'hardware': await telemetry.initialize(),
    });
    if (!kReleaseMode) {
      store.warnings.add(
        'Запущена ${kProfileMode ? 'profile' : 'debug'} сборка; '
        'для итогового сравнения используйте release.',
      );
    }
    telemetry.start(config.telemetryMs);
    if (Platform.environment['DSLIDESHOW_EMBEDDED']?.toLowerCase() == 'true') {
      FlutterpiVideoPlayer.registerWith();
    }
    final catalog = await MediaCatalog.load(
      cache: Directory(path.join(output.parent.path, '.media-cache')),
      external: config.mediaDirectory,
    );
    store.metadata['media'] = catalog.entries;
    // Photos are inspected as encoded originals; no cacheWidth/targetWidth is used.
    for (final entry in catalog.entries.where((e) => e['kind'] == 'image')) {
      if ((entry['width']! as int) < config.expectedWidth ||
          (entry['height']! as int) < config.expectedHeight) {
        store.warnings.add('Исходник ${entry['name']} меньше целевого экрана.');
      }
    }
    final skipFile = Platform.environment['BENCHMARK_SKIP_FILE'];
    final skipCaseIds = skipFile == null
        ? <String>{}
        : (jsonDecode(await File(skipFile).readAsString()) as List)
              .cast<String>()
              .toSet();
    final runner = BenchmarkRunner(
      config,
      store,
      telemetry,
      runtimeErrorCount: () => runtimeErrors,
      skipCaseIds: skipCaseIds,
    );
    final stageTimer = Timer.periodic(
      const Duration(milliseconds: 100),
      (_) => stage = runner.stage,
    );
    final subscriptions = <StreamSubscription<ProcessSignal>>[];
    for (final signal in [ProcessSignal.sigint, ProcessSignal.sigterm]) {
      subscriptions.add(
        signal.watch().listen((_) {
          runner.cancelled = true;
        }),
      );
    }
    runApp(
      Directionality(
        textDirection: TextDirection.ltr,
        child: MediaQuery.fromView(
          view: PlatformDispatcher.instance.views.first,
          child: BenchmarkViewport(
            config: config,
            catalog: catalog,
            reportDirectory: output,
            onReady: (driver) async {
              var code = 2;
              try {
                code = await runner.execute(driver);
              } catch (exception, stack) {
                error(exception, stack);
                await telemetry.stop();
                await store!.checkpoint(
                  'fatal_error',
                  telemetry,
                  finalReport: true,
                );
              } finally {
                stageTimer.cancel();
                for (final subscription in subscriptions) {
                  await subscription.cancel();
                }
                await store!.close();
              }
              stdout.writeln(
                'BENCHMARK_FINISHED code=$code reports=${output.absolute.path}',
              );
              if (config.exitWhenDone) exit(code);
            },
          ),
        ),
      ),
    );
  } catch (error, stack) {
    await output.create(recursive: true);
    await File('${output.path}/bootstrap-error.json').writeAsString(
      jsonEncode({
        'error': '$error',
        'stack': '$stack',
        'utc': DateTime.now().toUtc().toIso8601String(),
      }),
      flush: true,
    );
    stderr.writeln('BENCHMARK_FATAL $error\n$stack');
    // The launcher also preserves this file when engine startup fails.
    exit(2);
  }
}
