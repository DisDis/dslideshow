import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;

import '../json_io.dart' show decodeStrictJson, asList;
import 'analyze.dart';
import 'capture_process.dart';
import 'clock.dart';
import 'finalize_capture.dart';
import 'posix.dart';
import 'trace_instance.dart';

final _log = Logger('native_pipeline');
final _sha = RegExp(r'^[0-9a-f]{64}$');

enum NativeAction {
  capture('capture'),
  finalize('finalize'),
  trace('trace'),
  analyze('analyze'),
  inputs('inputs'),
  previous('previous'),
  finalizeNew('finalize-new'),
  eglProvenance('egl-provenance'),
  clock('clock');

  const NativeAction(this.wire);
  final String wire;
}

enum NativeMode { control, diagnostic }

List<String> _captures(String experiment) {
  final reports = Directory(p.join(experiment, 'reports'));
  if (!reports.existsSync()) return [];
  return reports
      .listSync(recursive: true, followLinks: false)
      .whereType<File>()
      .where(
        (file) =>
            p.basename(file.path) == 'native-pipeline.bin' &&
            p.basename(p.dirname(file.path)).startsWith('attempt-') &&
            p.basename(p.dirname(p.dirname(file.path))) == 'opengl',
      )
      .map((file) => file.resolveSymbolicLinksSync())
      .toList()
    ..sort();
}

Future<int> runNativePipeline(List<String> args) async {
  if (args.isEmpty || args.first == '--help') {
    stdout.writeln(
      'Usage: dslideshow_tools native capture|finalize|trace|analyze|inputs|previous|finalize-new|egl-provenance ...',
    );
    return 0;
  }
  final selected = NativeAction.values.where((value) => value.wire == args.first);
  if (selected.isEmpty) {
    stderr.writeln('Unknown native command; use --help');
    return 64;
  }
  final action = selected.single, timer = Stopwatch()..start();
  final operation = '$pid:${DateTime.now().microsecondsSinceEpoch}';
  _log.info('operation=$operation action=${action.wire} result=started');
  try {
    final status = await _run(action, args.sublist(1));
    _log.info(
      'operation=$operation action=${action.wire} result=${status == 0 ? 'passed' : 'incomplete'} exitCode=$status durationMs=${timer.elapsedMilliseconds}',
    );
    return status;
  } on Object catch (error, stack) {
    _log.warning(
      'operation=$operation action=${action.wire} result=failed errorType=${error.runtimeType} durationMs=${timer.elapsedMilliseconds}',
      error,
      stack,
    );
    stderr.writeln(
      'native ${action.wire}: ${error is ArgumentError || error is FormatException || error is StateError ? error : error.runtimeType}',
    );
    return error is ArgumentError || error is FormatException ? 64 : 1;
  }
}

Future<int> _run(NativeAction action, List<String> args) async {
  switch (action) {
    case NativeAction.capture:
      final parsed = (ArgParser()..addOption('timeout', defaultsTo: '30')).parse(args);
      if (parsed.rest.length != 4) throw ArgumentError('capture PID ENGINE SHA256 OUTPUT [--timeout SECONDS]');
      final processId = int.parse(parsed.rest[0]), timeout = double.parse(parsed.option('timeout')!);
      if (processId <= 0 || timeout <= 0 || !timeout.isFinite) throw ArgumentError('PID and timeout must be positive');
      final deadline = Stopwatch()..start();
      try {
        while (true) {
          try {
            writeExclusive(parsed.rest[3], captureProcess(processId, parsed.rest[1], parsed.rest[2]));
            return 0;
          } on EngineNotMapped {
            if (deadline.elapsedMicroseconds >= timeout * 1e6) {
              throw TimeoutException('Mapped engine did not appear before deadline');
            }
          }
          await Future<void>.delayed(const Duration(milliseconds: 100));
        }
      } on Object catch (error) {
        writeExclusive(parsed.rest[3], {
          'schema_version': 1,
          'status': 'error',
          'pid': processId,
          'error': '$error',
          'timing_results_valid': false,
        });
        return 1;
      }
    case NativeAction.finalize:
      if (args.length != 1) throw ArgumentError('finalize ATTEMPT');
      final result = verifyCapture(args.single);
      writeExclusive(p.join(args.single, 'native-pipeline-finalization.json'), result);
      stdout.writeln(
        jsonEncode({'pid': result['pid'], 'status': result['status'], 'raw_lifecycle': result['raw_lifecycle']}),
      );
      return 0;
    case NativeAction.trace:
      final parsed =
          (ArgParser()
                ..addOption('tracefs', defaultsTo: '/sys/kernel/tracing')
                ..addOption('buffer-size-kb', defaultsTo: '8192'))
              .parse(args);
      if (parsed.rest.length != 3) throw ArgumentError('trace init|start|stop|close NAME OUTPUT');
      final traceAction = TraceAction.values.byName(parsed.rest[0]);
      final subscriptions = <StreamSubscription<ProcessSignal>>[];
      ProcessSignal? cancelled;
      for (final signal in [ProcessSignal.sigint, ProcessSignal.sigterm]) {
        subscriptions.add(signal.watch().listen((value) => cancelled = value));
      }
      try {
        await TraceSession(
          tracefs: parsed.option('tracefs')!,
          bufferSizeKb: int.parse(parsed.option('buffer-size-kb')!),
        ).run(
          traceAction,
          parsed.rest[1],
          parsed.rest[2],
          checkCancelled: () {
            if (cancelled != null) throw StateError('Interrupted by ${cancelled!.name}');
          },
        );
        return cancelled == null ? 0 : 128 + cancelled!.signalNumber;
      } finally {
        for (final subscription in subscriptions) {
          await subscription.cancel();
        }
      }
    case NativeAction.analyze:
      final parsed =
          (ArgParser()
                ..addOption('native', mandatory: true)
                ..addOption('trace-dir', mandatory: true)
                ..addFlag('include-warmup', negatable: false)
                ..addOption('engine-sha256'))
              .parse(args);
      if (parsed.rest.length != 2) throw ArgumentError('analyze COLLECTION OUTPUT --native FILE --trace-dir DIRECTORY');
      final expected = parsed.option('engine-sha256');
      if (expected != null && !_sha.hasMatch(expected)) {
        throw ArgumentError('--engine-sha256 must be 64 lowercase hexadecimal characters');
      }
      final result = analyzePipeline(
        parsed.rest[0],
        parsed.option('native')!,
        parsed.option('trace-dir')!,
        includeWarmup: parsed.flag('include-warmup'),
        expectedEngine: expected,
      );
      Directory(parsed.rest[1]).createSync(recursive: true);
      writeJson(p.join(parsed.rest[1], 'analysis.json'), result);
      File(p.join(parsed.rest[1], 'report.md')).writeAsStringSync(renderPipeline(result));
      stdout.writeln(
        jsonEncode({
          'cases': (result['cases'] as List<dynamic>).length,
          'correlation_complete': result['correlation_complete'],
          'diagnostic_only': true,
          'output': parsed.rest[1],
        }),
      );
      return result['correlation_complete'] == true ? 0 : 2;
    case NativeAction.inputs:
      if (args.length != 7) throw ArgumentError('inputs OUTPUT MODE RUNTIME BUNDLE CONFIG TOOLS BENCHMARK_ROOT');
      final [output, rawMode, runtime, bundle, config, tools, benchmark] = args;
      final mode = NativeMode.values.byName(rawMode);
      final paths = [
        runtime,
        p.join(bundle, 'app.so'),
        p.join(bundle, 'libflutter_engine.so'),
        config,
        p.join(benchmark, 'run-managed.sh'),
        p.join(benchmark, 'run.sh'),
      ];
      if (mode == NativeMode.diagnostic) {
        paths.addAll(
          Directory(tools)
              .listSync()
              .whereType<File>()
              .where((file) => ['.dart', '.sh', '.so', '.c'].contains(p.extension(file.path)))
              .map((file) => file.path),
        );
      }
      if (!Platform.script.path.endsWith('.dart')) {
        paths.add(File.fromUri(Platform.script).path);
      }
      final hashes = {for (final path in paths) path: hashFile(path)};
      if (hashes[runtime] != Platform.environment['BENCH_NATIVE_PIPELINE_RUNTIME_SHA256']) {
        throw StateError('Actual runtime differs from pinned runtime');
      }
      if (hashes[p.join(bundle, 'libflutter_engine.so')] !=
          Platform.environment['BENCH_NATIVE_PIPELINE_ENGINE_SHA256']) {
        throw StateError('Actual engine differs from pinned engine');
      }
      writeExclusive(output, {
        'schema_version': 1,
        'mode': mode.name,
        'timing_results_valid': mode == NativeMode.control,
        'sha256': hashes,
      });
      return 0;
    case NativeAction.previous:
      if (args.length != 2) throw ArgumentError('previous EXPERIMENT OUTPUT');
      writeExclusive(args[1], _captures(args[0]));
      return 0;
    case NativeAction.finalizeNew:
      if (args.length != 2) throw ArgumentError('finalize-new EXPERIMENT PREVIOUS');
      final old = asList(decodeStrictJson(File(args[1]).readAsStringSync())).cast<String>().toSet();
      final captures = _captures(args[0]).where((path) => !old.contains(path)).toList();
      if (captures.length != 1) {
        throw StateError(
          'Expected exactly one new native capture, got ${captures.length}; preserve all attempts for diagnosis',
        );
      }
      final attempt = p.dirname(captures.single);
      writeExclusive(p.join(attempt, 'native-pipeline-finalization.json'), verifyCapture(attempt));
      return 0;
    case NativeAction.eglProvenance:
      if (args.length < 4) throw ArgumentError('egl-provenance OUTPUT RUNTIME INTERPOSER WRAPPER [ARGV...]');
      final value = <String, dynamic>{
        'schema_version': 1,
        'kind': 'egl_backbuffer_capture',
        'utc': DateTime.now().toUtc().toIso8601String(),
        'argv': args.sublist(4),
        'capture_directory': Platform.environment['BENCHMARK_EGL_CAPTURE_DIR'],
        'inherited_ld_preload': Platform.environment['LD_PRELOAD'],
        'effective_ld_library_path': Platform.environment['LD_LIBRARY_PATH'],
        'source': 'real EGL FBO0 backbuffer before swap; physical scanout unverified',
        'timing_results_valid': false,
      };
      for (final (i, name) in ['real_runtime', 'interposer', 'wrapper'].indexed) {
        value[name] = {'path': args[i + 1], 'sha256': hashFile(args[i + 1])};
      }
      writeJson(args[0], value);
      return 0;
    case NativeAction.clock:
      stdout.writeln(monotonicNanoseconds());
      return 0;
  }
}
