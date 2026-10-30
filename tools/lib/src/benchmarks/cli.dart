import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as p;
import 'package:logging/logging.dart';

import '../repository.dart';
import 'camera.dart';
import 'backend_local.dart';
import 'comparison.dart';
import 'json_io.dart';
import 'native_cache.dart';
import 'media.dart';
import 'gallery_http.dart';
import 'provenance.dart';
import 'reports.dart';
import 'screening.dart';

enum _BenchmarkCommand {
  buildInfo,
  collectReports,
  resumePlan,
  comparePerformance,
  screenEffects,
  cameraHttp,
  cameraSocket,
  backendLocal,
  backendConfirm,
  backendTrace,
  galleryHttp,
  nativeCache,
  generateMedia,
  prepareOutput,
  launch,
  launchArgv,
  status,
  jsonField,
}

_BenchmarkCommand? _parseCommand(String? value) => switch (value) {
  'build-info' => _BenchmarkCommand.buildInfo,
  'collect-reports' => _BenchmarkCommand.collectReports,
  'resume-plan' => _BenchmarkCommand.resumePlan,
  'compare-effect-performance' => _BenchmarkCommand.comparePerformance,
  'screen-effects' => _BenchmarkCommand.screenEffects,
  'camera-http-probe' => _BenchmarkCommand.cameraHttp,
  'camera-socket-probe' => _BenchmarkCommand.cameraSocket,
  'backend-local' => _BenchmarkCommand.backendLocal,
  'backend-local-confirm' => _BenchmarkCommand.backendConfirm,
  'backend-local-trace' => _BenchmarkCommand.backendTrace,
  'gallery-http' => _BenchmarkCommand.galleryHttp,
  'gallery-native-cache-probe' => _BenchmarkCommand.nativeCache,
  'generate-media' => _BenchmarkCommand.generateMedia,
  'prepare-output' => _BenchmarkCommand.prepareOutput,
  'launch' => _BenchmarkCommand.launch,
  'launch-argv' => _BenchmarkCommand.launchArgv,
  'status' => _BenchmarkCommand.status,
  'json-field' => _BenchmarkCommand.jsonField,
  _ => null,
};

final _benchmarkLog = Logger('benchmark');
Future<int> runBenchmark(List<String> arguments) async {
  final command =
          _parseCommand(arguments.firstOrNull)?.name ??
          (arguments.isEmpty || arguments.first == '--help' ? 'help' : 'unknown'),
      runId = DateTime.now().microsecondsSinceEpoch.toString(),
      clock = Stopwatch()..start();
  _benchmarkLog.info('run=$runId command=$command action=start');
  try {
    final code = await _runBenchmark(arguments);
    _benchmarkLog.log(
      code == 0 || code == 130 || code == 143 ? Level.INFO : Level.WARNING,
      'run=$runId command=$command action=finish result=${code == 0
          ? 'passed'
          : code == 130 || code == 143
          ? 'cancelled'
          : 'failed'} code=$code durationMs=${clock.elapsedMilliseconds}',
    );
    return code;
  } on Object catch (error) {
    _benchmarkLog.warning(
      'run=$runId command=$command action=finish result=failed reason=${error.runtimeType} durationMs=${clock.elapsedMilliseconds}',
    );
    rethrow;
  }
}

Future<int> _runBenchmark(List<String> arguments) async {
  if (arguments.isEmpty || arguments.first == '--help') {
    stdout.writeln(
      'benchmark <build-info|collect-reports|resume-plan|compare-effect-performance|screen-effects|camera-http-probe|camera-socket-probe|gallery-http|gallery-native-cache-probe|backend-local|backend-local-confirm|backend-local-trace|generate-media|prepare-output|launch|launch-argv|status|json-field> [arguments]',
    );
    return 0;
  }
  final command = _parseCommand(arguments.first), args = arguments.skip(1).toList();
  switch (command) {
    case _BenchmarkCommand.backendLocal:
      return runBackendLocal(args);
    case _BenchmarkCommand.backendConfirm:
      return runBackendConfirm(args);
    case _BenchmarkCommand.backendTrace:
      return runBackendTrace(args);
    case _BenchmarkCommand.galleryHttp:
      return runGalleryHttp(args);
    case _BenchmarkCommand.nativeCache:
      return runNativeCache(args);
    case _BenchmarkCommand.generateMedia:
      final parsed = (ArgParser()..addOption('output')).parse(args);
      final output = Directory(parsed.option('output') ?? p.join(findRepository().path, 'benchmarks/assets/media'));
      stdout.writeln(canonical(await generateMedia(output)));
      return 0;
    case _BenchmarkCommand.buildInfo:
      if (args.length != 2 || !['pi4', 'pi5'].contains(args[0]) || !['release', 'profile'].contains(args[1])) {
        throw ArgumentError('build-info pi4|pi5 release|profile');
      }
      await writeBuildInfo(findRepository(), args[0], args[1]);
      return 0;
    case _BenchmarkCommand.collectReports:
      final parser = ArgParser()..addFlag('fail-on-errors', negatable: false);
      final parsed = parser.parse(args);
      if (parsed.rest.length != 1) throw ArgumentError('collect-reports DIRECTORY [--fail-on-errors]');
      final accepted = writeCollection(Directory(parsed.rest.single));
      return parsed.flag('fail-on-errors') && !accepted ? 2 : 0;
    case _BenchmarkCommand.resumePlan:
      if (args.length != 3) throw ArgumentError('resume-plan RENDERER ATTEMPT EXIT_CODE');
      stdout.writeln(checkpoint(Directory(args[0]), Directory(args[1]), int.parse(args[2])) ? 'resume' : 'done');
      return 0;
    case _BenchmarkCommand.comparePerformance:
      final parser = ArgParser()..addOption('renderer', allowed: ['opengl', 'vulkan'], defaultsTo: 'opengl');
      final parsed = parser.parse(args);
      if (parsed.rest.length != 3) throw ArgumentError('compare-effect-performance BASELINE CANDIDATE OUTPUT');
      final result = comparePerformance(parsed.rest[0], parsed.rest[1], renderer: parsed.option('renderer')!);
      final output = Directory(parsed.rest[2])..createSync(recursive: true);
      writeJson(File(p.join(output.path, 'comparison.json')), result);
      File(p.join(output.path, 'report.md')).writeAsStringSync(renderComparison(result));
      stdout.writeln(
        canonical({
          'cases': asList(result['cases']).length,
          'comparison_ready': result['comparison_ready'],
          'performance_comparable': result['performance_comparable'],
          'output': output.path,
        }),
      );
      return result['comparison_ready'] == true ? 0 : 2;
    case _BenchmarkCommand.screenEffects:
      final parser = ArgParser()..addOption('threshold', defaultsTo: '25');
      final parsed = parser.parse(args);
      if (parsed.rest.length != 3) throw ArgumentError('screen-effects COLLECTION CATALOG OUTPUT [--threshold FPS]');
      final samples = <Map<String, dynamic>>[], diagnostics = <String>[];
      for (final file in filesBelow(Directory(parsed.rest[0]), name: 'runs.jsonl')) {
        samples.addAll(readJsonLines(file, diagnostics));
      }
      if (diagnostics.isNotEmpty) throw FormatException('Invalid screening JSONL: ${diagnostics.join('; ')}');
      final (rows, focused) = screenEffects(
        readJson(File(parsed.rest[1]), []),
        samples,
        threshold: num.parse(parsed.option('threshold')!),
      );
      final output = Directory(parsed.rest[2])..createSync(recursive: true);
      writeJson(File(p.join(output.path, 'screening-results.json')), rows);
      writeJson(File(p.join(output.path, 'focused.json')), focused);
      final lines = ['| Preset / family default | FPS | Raster p95, ms | Follow up |', '| --- | ---: | ---: | --- |'];
      for (final row in rows) {
        final label = asList(row['presets']).isEmpty ? row['effect'].toString() : asList(row['presets']).join(', ');
        lines.add(
          '| $label | ${row['fps'] is num ? (row['fps'] as num).toStringAsFixed(2) : 'missing'} | ${row['raster_p95_ms'] is num ? (row['raster_p95_ms'] as num).toStringAsFixed(2) : 'missing'} | ${asList(row['reasons']).join('; ')} |',
        );
      }
      File(p.join(output.path, 'screening-results.md')).writeAsStringSync('${lines.join('\n')}\n');
      stdout.writeln(
        canonical({
          'cases': rows.length,
          'selected': rows.where((e) => e['selected'] == true).length,
          'output': output.path,
        }),
      );
      return 0;
    case _BenchmarkCommand.cameraHttp:
      if (args.isEmpty || args.length > 2) throw ArgumentError('camera-http-probe HOST:PORT [SECONDS=120]');
      stdout.writeln(
        canonical(
          await cameraHttpProbe(args[0], duration: Duration(seconds: args.length == 2 ? int.parse(args[1]) : 120)),
        ),
      );
      return 0;
    case _BenchmarkCommand.cameraSocket:
      if (args.length < 2 || args.length > 3) throw ArgumentError('camera-socket-probe CONFIG PID [SECONDS=240]');
      await cameraSocketProbe(
        File(args[0]),
        int.parse(args[1]),
        durationSeconds: args.length == 3 ? int.parse(args[2]) : 240,
      );
      return 0;
    case _BenchmarkCommand.prepareOutput:
      if (args.length != 1) throw ArgumentError('prepare-output DIRECTORY');
      prepareOutput(Directory(args[0]));
      return 0;
    case _BenchmarkCommand.launch:
      final parsed = (ArgParser()..addFlag('compact', negatable: false)).parse(args);
      if (parsed.rest.length != 3) throw ArgumentError('launch OUTPUT RUNTIME BUNDLE [--compact]');
      writeLaunch(
        File(parsed.rest[0]),
        File(parsed.rest[1]),
        Directory(parsed.rest[2]),
        compact: parsed.flag('compact'),
      );
      return 0;
    case _BenchmarkCommand.launchArgv:
      if (args.length < 3) throw ArgumentError('launch-argv OUTPUT RENDERER EXECUTABLE [ARGV]');
      writeJson(File(args[0]), {
        'renderer': args[1],
        'argv': args.skip(2).toList(),
        'utc': DateTime.now().toUtc().toIso8601String(),
        'flutter_pi_sha256': digest(File(args[2])),
      });
      return 0;
    case _BenchmarkCommand.status:
      if (args.length != 2) throw ArgumentError('status OUTPUT EXIT_CODE');
      writeJson(File(args[0]), {
        'exit_code': int.parse(args[1]),
        'finished_utc': DateTime.now().toUtc().toIso8601String(),
      });
      return 0;
    case _BenchmarkCommand.jsonField:
      if (args.length != 3) throw ArgumentError('json-field INPUT KEY DEFAULT');
      stdout.writeln(readJson(File(args[0]), [])[args[1]] ?? args[2]);
      return 0;
    case null:
      throw ArgumentError('Unknown benchmark command');
  }
}
