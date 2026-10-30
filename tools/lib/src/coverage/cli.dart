import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;

import '../process/supervisor.dart';
import '../repository.dart';
import 'coverage.dart';

final _log = Logger('coverage');

List<String> _normalizeListOptions(List<String> args) {
  final normalized = <String>[];
  for (var i = 0; i < args.length; i++) {
    final value = args[i];
    if (value == '--packages' || value == '--tests') {
      var count = 0;
      while (i + 1 < args.length && !args[i + 1].startsWith('--')) {
        normalized.add('$value=${args[++i]}');
        count++;
      }
      if (count == 0) throw FormatException('$value requires at least one value');
    } else {
      normalized.add(value);
    }
  }
  return normalized;
}

ArgParser coverageParser() {
  final parser = ArgParser()..addFlag('help', abbr: 'h', negatable: false);
  parser.addCommand(
    'collect',
    ArgParser()
      ..addOption('root')
      ..addOption('out')
      ..addMultiOption('packages', allowed: coveragePackages.keys.toList(), defaultsTo: coveragePackages.keys.toList())
      ..addMultiOption('tests')
      ..addFlag('analyze', negatable: false)
      ..addFlag('help', abbr: 'h', negatable: false),
  );
  parser.addCommand(
    'summarize',
    ArgParser()
      ..addOption('root')
      ..addFlag('help', abbr: 'h', negatable: false),
  );
  parser.addCommand('compare', ArgParser()..addFlag('help', abbr: 'h', negatable: false));
  parser.addCommand(
    'merge',
    ArgParser()
      ..addOption('out')
      ..addOption('root')
      ..addFlag('help', abbr: 'h', negatable: false),
  );
  return parser;
}

Future<Map<String, dynamic>> _execute(
  ProcessSupervisor supervisor,
  List<String> command,
  Directory cwd,
  File file,
  Map<String, String> environment,
) async {
  final clock = Stopwatch()..start();
  final sink = file.openWrite();
  var result = 1;
  try {
    result = await supervisor.run(
      command.first,
      command.skip(1).toList(),
      label: 'coverage-${p.basename(cwd.path)}',
      workingDirectory: cwd.path,
      environment: environment,
      includeParentEnvironment: false,
      stdoutSink: sink,
      stderrSink: sink,
      streamOutput: false,
    );
  } on ProcessJobFailure catch (error) {
    if (supervisor.cancellationCode != null) rethrow;
    result = error.exitCode;
    // A failing suite is recorded, then the remaining suites still collect data.
  } finally {
    await sink.flush();
    await sink.close();
  }
  return {
    'command': command,
    'cwd': cwd.path,
    'exit_code': result,
    'seconds': double.parse((clock.elapsedMicroseconds / 1000000).toStringAsFixed(3)),
    'log': file.path,
  };
}

String _tool(String name) {
  for (final directory in (Platform.environment['PATH'] ?? '').split(p.separator == r'\' ? ';' : ':')) {
    final file = File(p.join(directory, name));
    if (file.existsSync()) return file.absolute.path;
  }
  throw StateError('$name must already be on PATH');
}

Future<int> collectCoverage(ArgResults args, {ProcessSupervisor? processSupervisor, StringSink? output}) async {
  final out = output ?? stdout;
  final root = Directory(Directory(args.option('root') ?? findRepository().path).resolveSymbolicLinksSync());
  final packages = args.multiOption('packages');
  final tests = args.multiOption('tests').isEmpty ? ['test'] : args.multiOption('tests');
  if (args.multiOption('tests').isNotEmpty && packages.length != 1) {
    throw const FormatException('--tests requires exactly one --packages entry');
  }
  for (final package in packages) {
    for (final test in tests) {
      final base = p.join(root.path, package, 'test');
      final target = p.normalize(p.absolute(p.join(root.path, package, test)));
      if ((!p.equals(base, target) && !p.isWithin(base, target)) ||
          !FileSystemEntity.isFileSync(target) && !Directory(target).existsSync()) {
        throw FormatException('Only existing test/ paths are accepted: $test');
      }
      final resolved = FileSystemEntity.isFileSync(target)
          ? File(target).resolveSymbolicLinksSync()
          : Directory(target).resolveSymbolicLinksSync();
      final allowed = Directory(base).resolveSymbolicLinksSync();
      if (!p.equals(allowed, resolved) && !p.isWithin(allowed, resolved)) {
        throw const FormatException('test path escapes test/ through a symlink');
      }
    }
  }
  requirePackageConfigs(root, packages);
  final run = Directory(
    args.option('out') ??
        p.join(root.path, '.local/test-coverage', DateTime.now().toUtc().toIso8601String().replaceAll(':', '')),
  ).absolute;
  if (run.existsSync()) throw FileSystemException('Run already exists', run.path);
  run.createSync(recursive: true);
  final (sources, excluded) = inventory(root);
  final manifest = <String, dynamic>{
    'schema_version': 1,
    'started_utc': DateTime.now().toUtc().toIso8601String(),
    'root': root.path,
    'packages': packages,
    'tests': tests,
    'snapshot': sourceSnapshot(root),
    'results': <String, dynamic>{},
    'status': 'running',
    'inventory': sources,
    'excluded_generated': excluded,
    'test_index': testIndex(root),
    'collector_sha256': coverageImplementationSha256(),
  };
  final environment = Map<String, String>.from(Platform.environment)
    ..remove('DSLIDESHOW_EMBEDDED')
    ..addAll({
      'FLUTTER_SUPPRESS_ANALYTICS': 'true',
      'DART_SUPPRESS_ANALYTICS': 'true',
      'FLUTTER_SKIP_UPDATE_CHECK': 'true',
    });
  manifest['environment'] = {'DSLIDESHOW_EMBEDDED': 'unset', 'platform': Platform.operatingSystem};
  final dart = _tool('dart'), flutter = _tool('flutter');
  for (final (key, command) in [
    ('commit', ['git', 'rev-parse', 'HEAD']),
    ('git_status', ['git', 'status', '--short']),
    ('sdk', [dart, '--version']),
  ]) {
    final result = await Process.run(
      command.first,
      command.skip(1).toList(),
      workingDirectory: root.path,
      environment: environment,
      includeParentEnvironment: false,
    );
    if (result.exitCode != 0) throw StateError('Cannot read $key provenance (exit ${result.exitCode})');
    manifest[key] = '${result.stdout}${result.stderr}'.trim();
  }
  final supervisor = processSupervisor ?? ProcessSupervisor();
  final signals = <StreamSubscription<ProcessSignal>>[];
  var failed = false;
  try {
    signals.add(ProcessSignal.sigint.watch().listen((_) => unawaited(supervisor.cancel(130))));
    if (!Platform.isWindows) {
      signals.add(ProcessSignal.sigterm.watch().listen((_) => unawaited(supervisor.cancel(143))));
    }
    writeCoverageJson(File(p.join(run.path, 'manifest.json')), manifest);
    _log.info('Coverage started packages=${packages.length}');
    for (final package in packages) {
      final cwd = Directory(p.join(root.path, package));
      final output = Directory(p.join(run.path, package))..createSync();
      final result = <String, dynamic>{};
      manifest['results'][package] = result;
      if (args.flag('analyze')) {
        result['analysis'] = await _execute(
          supervisor,
          package == 'backend' ? [dart, 'analyze'] : [flutter, 'analyze', '--no-pub'],
          cwd,
          File(p.join(output.path, 'analysis.log')),
          environment,
        );
      }
      final command = package == 'backend'
          ? [
              dart,
              'run',
              'coverage:test_with_coverage',
              '--function-coverage',
              '--branch-coverage',
              '--out',
              output.path,
              ...coveragePackages.values.map((name) => '--scope-output=$name'),
              '--',
              '--concurrency=1',
              '--reporter=json',
              ...tests,
            ]
          : [
              flutter,
              'test',
              '--no-pub',
              '--coverage',
              '--branch-coverage',
              '--coverage-path',
              p.join(output.path, 'lcov.info'),
              r'--coverage-package=^(dslideshow_backend|config_app|dslideshow_flutter)$',
              '--reporter=json',
              ...tests,
            ];
      result['tests'] = await _execute(supervisor, command, cwd, File(p.join(output.path, 'tests.jsonl')), environment);
      final lcov = File(p.join(output.path, 'lcov.info'));
      result['coverage_present'] = {'exit_code': lcov.existsSync() && lcov.lengthSync() > 0 ? 0 : 1};
      writeCoverageJson(File(p.join(run.path, 'manifest.json')), manifest);
    }
    manifest['status'] = 'finished';
  } catch (error) {
    failed = true;
    manifest['status'] = supervisor.cancellationCode == null ? 'failed' : 'interrupted';
    manifest['error_type'] = error.runtimeType.toString();
    _log.warning('Coverage ${manifest['status']} type=${error.runtimeType}');
  } finally {
    for (final signal in signals) {
      await signal.cancel();
    }
    await supervisor.close();
    manifest['finished_utc'] = DateTime.now().toUtc().toIso8601String();
    writeCoverageJson(File(p.join(run.path, 'manifest.json')), manifest);
    summarize(run, root);
    out.writeln('Report: ${run.path}');
    _log.info('Coverage finished status=${manifest['status']} packages=${(manifest['results'] as Map).length}');
  }
  if (supervisor.cancellationCode != null) return supervisor.cancellationCode!;
  return failed ||
          (manifest['results'] as Map).values.any(
            (result) => (result as Map).values.any((step) => (step as Map)['exit_code'] != 0),
          )
      ? 1
      : 0;
}

Future<int> runCoverage(List<String> arguments, {StringSink? output, StringSink? errors}) async {
  final out = output ?? stdout;
  final err = errors ?? stderr;
  final parser = coverageParser();
  try {
    final parsed = parser.parse(_normalizeListOptions(arguments));
    final args = parsed.command;
    if (parsed.flag('help') || args?.flag('help') == true) {
      out.writeln(
        'Usage: dslideshow_tools coverage <collect|summarize|compare|merge> [options]\n${args == null ? parser.usage : parser.commands[args.name]!.usage}',
      );
      return 0;
    }
    if (args == null) throw const FormatException('A coverage command is required');
    final rootPath = args.name == 'compare' ? findRepository().path : args.option('root') ?? findRepository().path;
    final root = Directory(Directory(rootPath).resolveSymbolicLinksSync());
    switch (args.name) {
      case 'collect':
        return await collectCoverage(args, output: out);
      case 'summarize':
        if (args.rest.length != 1) throw const FormatException('summarize requires one run directory');
        summarize(Directory(args.rest.single).absolute, root);
        return 0;
      case 'merge':
        if (args.rest.isEmpty || args.option('out') == null) {
          throw const FormatException('merge requires input runs and --out');
        }
        final summary = mergeRuns(
          args.rest.map((path) => Directory(path).absolute).toList(),
          Directory(args.option('out')!).absolute,
          root,
        );
        return summary['checks_passed'] == true ? 0 : 1;
      case 'compare':
        if (args.rest.isEmpty) throw const FormatException('compare requires run directories');
        final groups = <String, CoverageRecords>{}, snapshots = <String>{};
        for (final path in args.rest) {
          final manifest = jsonDecode(File(p.join(path, 'manifest.json')).readAsStringSync()) as Map<String, dynamic>;
          final summary = jsonDecode(File(p.join(path, 'summary.json')).readAsStringSync()) as Map<String, dynamic>;
          if ((summary['source_changed'] as List).isNotEmpty || summary['checks_passed'] != true) {
            throw FormatException('Run has changed inputs or incomplete/failed checks: $path');
          }
          snapshots.add(manifest['snapshot']['sha256'] as String);
          groups[path] = readLcov(File(p.join(path, 'union.lcov.info')), Directory(manifest['root'] as String), '');
        }
        if (snapshots.length != 1) {
          throw const FormatException('Cannot compare overlap across different source snapshots');
        }
        out.writeln(const JsonEncoder.withIndent('  ').convert(overlap(groups)));
        return 0;
    }
    throw const FormatException('Unknown coverage command');
  } on FormatException catch (error) {
    err.writeln('${error.message}\n${parser.usage}');
    return 64;
  } on ArgumentError catch (error) {
    err.writeln('${error.message}\n${parser.usage}');
    return 64;
  } on FileSystemException catch (error) {
    err.writeln('Coverage filesystem error: ${error.message}');
    return 1;
  } on StateError catch (error) {
    err.writeln('Coverage: ${error.message}');
    return 1;
  }
}
