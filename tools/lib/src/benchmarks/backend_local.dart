import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:args/args.dart';
import 'package:crypto/crypto.dart';
import 'package:ffi/ffi.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;

import '../process/supervisor.dart';
import '../repository.dart';
import '../third_party/posix_clock.g.dart' as native;
import 'json_io.dart';
import 'provenance.dart' show digest;

final _space = RegExp(r'\s+');
final _traceHead = RegExp(r'^(\d+)\s+(.*)$');
final _traceResumed = RegExp(r'<\.\.\. (clone3?|fork|vfork) resumed>(.*)$');
final _traceInitial = RegExp(r'(clone3?|fork|vfork)\(');
final _traceResult = RegExp(r'=\s+(\d+)\s*$');
final _log = Logger('benchmark.backend');

enum BackendLayout { flat, nested }

enum BackendMode { aot, jit }

enum BackendScenario {
  storage('storage'),
  responsiveness('responsiveness'),
  metrics('metrics'),
  commandDiagnostic('metrics_command_diagnostic');

  const BackendScenario(this.wireName);
  final String wireName;
  static BackendScenario? fromRow(Map<String, dynamic> row) => switch (row['scenario']) {
    'storage' => storage,
    'responsiveness' => responsiveness,
    'metrics' => metrics,
    'metrics_command_diagnostic' => commandDiagnostic,
    _ => null,
  };
}

enum BackendVariant {
  baseline('baseline'),
  candidate('candidate'),
  candidateFinal('candidate-final'),
  candidateApproved('candidate-approved'),
  selftest('selftest');

  const BackendVariant(this.wireName);
  final String wireName;
  static BackendVariant parse(String value) => values.firstWhere(
    (variant) => variant.wireName == value,
    orElse: () => throw const FormatException('Unknown backend variant'),
  );
}

const _candidates = [BackendVariant.candidate, BackendVariant.candidateFinal, BackendVariant.candidateApproved];

Future<(String, String)> runBackendProcess(
  List<String> command, {
  Map<String, String>? environment,
  Duration timeout = const Duration(seconds: 120),
  ProcessSupervisor? supervisor,
}) async {
  if (command.isEmpty) throw ArgumentError('Empty command');
  final owner = supervisor ?? ProcessSupervisor(terminationGrace: const Duration(seconds: 2));
  final directory = Directory.systemTemp.createTempSync('backend-command-');
  final outputFile = File(p.join(directory.path, 'stdout')), errorFile = File(p.join(directory.path, 'stderr'));
  final output = outputFile.openWrite(), error = errorFile.openWrite();
  try {
    await owner.run(
      command.first,
      command.skip(1).toList(),
      label: 'backend-local',
      environment: environment,
      stdoutSink: output,
      stderrSink: error,
      streamOutput: false,
      timeout: timeout,
    );
    await output.flush();
    await error.flush();
    if (outputFile.lengthSync() > 32 * 1024 * 1024 || errorFile.lengthSync() > 32 * 1024 * 1024) {
      throw const FormatException('Backend command output exceeded 32 MiB per stream');
    }
    return (outputFile.readAsStringSync(), errorFile.readAsStringSync());
  } finally {
    if (supervisor == null) await owner.close();
    await output.close();
    await error.close();
    directory.deleteSync(recursive: true);
  }
}

Map<String, dynamic> backendFixture(Directory directory, int count, BackendLayout layout) {
  if (count < 1) throw ArgumentError('Positive fixture count required');
  final manifestFile = File(p.join(directory.path, 'manifest.json'));
  final expected = <String, dynamic>{'count': count, 'layout': layout.name, 'content': 'metadata-only-v1\n'};
  if (manifestFile.existsSync()) {
    final manifest = asMap(decodeStrictJson(manifestFile.readAsStringSync()));
    if (expected.entries.any((entry) => manifest[entry.key] != entry.value)) {
      throw const FormatException('Fixture manifest mismatch');
    }
    final images = Directory(p.join(directory.path, 'images'));
    if (FileSystemEntity.typeSync(images.path, followLinks: false) != FileSystemEntityType.directory) {
      throw const FormatException('Fixture images must be a real directory');
    }
    final files = filesBelow(images).where((file) => p.extension(file.path) == '.jpg').toList();
    final paths = <String>[];
    for (final file in files) {
      if (file.readAsStringSync() != expected['content']) throw const FormatException('Fixture content mismatch');
      paths.add(p.posix.joinAll(p.split(p.relative(file.path, from: directory.path))));
    }
    paths.sort();
    final hash = sha256.convert(utf8.encode(paths.map((path) => '$path\n').join())).toString();
    if (files.length != count || hash != manifest['paths_sha256']) {
      throw const FormatException('Fixture paths mismatch');
    }
    return manifest;
  }
  if (directory.existsSync() && directory.listSync().isNotEmpty) {
    throw const FormatException('Refusing to overwrite an incomplete fixture');
  }
  directory.createSync(recursive: true);
  final paths = <String>[];
  for (var index = 0; index < count; index++) {
    final folder = Directory(
      layout == BackendLayout.nested
          ? p.join(
              directory.path,
              'images',
              'group-${(index ~/ 1000).toString().padLeft(3, '0')}',
              'album-${(index ~/ 100).toString().padLeft(4, '0')}',
            )
          : p.join(directory.path, 'images'),
    )..createSync(recursive: true);
    final file = File(p.join(folder.path, 'photo-${index.toString().padLeft(6, '0')}.jpg'))
      ..writeAsStringSync(expected['content'] as String);
    paths.add(p.posix.joinAll(p.split(p.relative(file.path, from: directory.path))));
  }
  paths.sort();
  final manifest = <String, dynamic>{
    ...expected,
    'decoded': false,
    'file_bytes': utf8.encode(expected['content'] as String).length,
    'paths_sha256': sha256.convert(utf8.encode(paths.map((path) => '$path\n').join())).toString(),
  };
  writeJson(manifestFile, manifest);
  return manifest;
}

void _copyTree(Directory source, Directory destination) {
  destination.createSync(recursive: true);
  for (final entity in source.listSync(followLinks: false)) {
    final path = p.join(destination.path, p.basename(entity.path));
    if (entity is File) {
      entity.copySync(path);
    } else if (entity is Directory) {
      _copyTree(entity, Directory(path));
    } else {
      throw FileSystemException('Source snapshots must not contain symlinks', entity.path);
    }
  }
}

Future<(File, File, Map<String, dynamic>)> backendSnapshot(
  File packages,
  Directory destination, {
  File? harness,
  Directory? repository,
  ProcessSupervisor? supervisor,
}) async {
  final root = repository ?? findRepository();
  final config = asMap(decodeStrictJson(packages.readAsStringSync()));
  final sources = Directory(p.join(destination.path, 'sources'))..createSync();
  for (final raw in asList(config['packages'])) {
    final item = asMap(raw);
    final uri = packages.absolute.uri.resolve(item['rootUri'] as String);
    if (uri.scheme != 'file') throw const FormatException('Package roots must be file URIs');
    var source = Directory.fromUri(uri).absolute;
    if (['dslideshow_backend', 'dslideshow_common'].contains(item['name'])) {
      final target = Directory(p.join(sources.path, item['name'] == 'dslideshow_backend' ? 'backend' : 'common'))
        ..createSync();
      _copyTree(Directory(p.join(source.path, 'lib')), Directory(p.join(target.path, 'lib')));
      for (final name in ['pubspec.yaml', 'pubspec.lock']) {
        final file = File(p.join(source.path, name));
        if (file.existsSync()) file.copySync(p.join(target.path, name));
      }
      source = target;
    }
    raw['rootUri'] = source.uri.toString();
  }
  final frozenHarness = File(p.join(sources.path, 'backend_local.dart'));
  (harness ?? File(p.join(root.path, 'benchmarks/tool/backend_local.dart'))).copySync(frozenHarness.path);
  final tool = Directory(p.join(root.path, 'tools'));
  if (Directory(p.join(tool.path, 'lib')).existsSync()) {
    final target = Directory(p.join(sources.path, 'tooling'));
    _copyTree(Directory(p.join(tool.path, 'lib')), Directory(p.join(target.path, 'lib')));
    for (final name in ['pubspec.yaml', 'pubspec.lock', 'bin/dslideshow_tools.dart']) {
      final file = File(p.join(tool.path, name));
      if (file.existsSync()) {
        final copy = File(p.join(target.path, name));
        copy.parent.createSync(recursive: true);
        file.copySync(copy.path);
      }
    }
  }
  final hashes = {
    for (final file in filesBelow(sources))
      p.posix.joinAll(p.split(p.relative(file.path, from: sources.path))): digest(file),
  };
  final hashesFile = File(p.join(destination.path, 'source-hashes.json'));
  writeJson(hashesFile, hashes);
  final frozenPackages = File(p.join(destination.path, 'package_config.json'));
  writeJson(frozenPackages, config);
  final archive = File(p.join(destination.path, 'source.tar.gz'));
  await runBackendProcess([
    'tar',
    '-czf',
    archive.path,
    '-C',
    destination.path,
    'sources',
    'package_config.json',
  ], supervisor: supervisor);
  return (
    frozenPackages,
    frozenHarness,
    {
      'source_archive_sha256': digest(archive),
      'source_hashes_sha256': digest(hashesFile),
      'harness_sha256': digest(frozenHarness),
      'tooling': 'dart-v1',
      'tooling_sha256': sha256
          .convert(
            utf8.encode(canonical(Map.fromEntries(hashes.entries.where((entry) => entry.key.startsWith('tooling/'))))),
          )
          .toString(),
    },
  );
}

String _quote(String value) => "'${value.replaceAll("'", "'\\''")}'";
void _executable(File file, String source) {
  file.parent.createSync(recursive: true);
  file.writeAsStringSync(source);
  final result = Process.runSync('chmod', ['755', '--', file.path]);
  if (result.exitCode != 0) throw const FileSystemException('Cannot set executable permissions');
}

File sensorFixture(Directory directory) {
  final file = File(p.join(directory.path, 'sensors.sh'));
  _executable(
    file,
    '#!/bin/sh\n'
    'if [ -n "\${BENCHMARK_EXEC_LOG:-}" ]; then printf "%s\\n" sensorsScript >> "\$BENCHMARK_EXEC_LOG"; fi\n'
    "printf 'temp=42.0\\047C\\nfan=1200 RPM\\n'\n",
  );
  return file;
}

String? _which(String executable) {
  for (final directory in (Platform.environment['PATH'] ?? '').split(':')) {
    final file = File(p.join(directory, executable));
    if (file.existsSync()) return file.absolute.path;
  }
  return null;
}

void backendWrappers(Directory directory) {
  directory.createSync();
  for (final name in ['df', 'uptime', 'free', 'cat']) {
    final executable = _which(name);
    if (executable == null) throw FileSystemException('Missing executable', name);
    _executable(
      File(p.join(directory.path, name)),
      '#!/bin/sh\nprintf "%s\\n" ${_quote(name)} >> "\$BENCHMARK_EXEC_LOG"\nexec ${_quote(executable)} "\$@"\n',
    );
  }
}

num? backendPercentile(List<num> values, double fraction) {
  if (values.isEmpty) return null;
  final sorted = List<num>.of(values)..sort();
  return sorted[max(0, (fraction * sorted.length).ceil() - 1)];
}

Map<String, dynamic> backendDistribution(List<num> values) => {
  'n': values.length,
  'p50': backendPercentile(values, .5),
  'p95': backendPercentile(values, .95),
  'p99': backendPercentile(values, .99),
  'max': values.isEmpty ? null : values.reduce(max),
};

Map<String, dynamic> summarizeBackend(List<Map<String, dynamic>> rows) {
  final summary = <String, dynamic>{};
  final groups = <String, List<Map<String, dynamic>>>{};
  for (final row in rows.where((row) => BackendScenario.fromRow(row) == BackendScenario.storage)) {
    (groups['storage/${row['layout']}/${row['count']}'] ??= []).add(row);
  }
  for (final entry in groups.entries) {
    summary[entry.key] = {
      for (final name in ['index_first_selection_ms', 'remaining_selection_ms', 'whole_cycle_ms'])
        name: backendDistribution(entry.value.map((row) => row[name] as num).toList()),
      'hwm_bytes': backendDistribution(entry.value.map((row) => row['after']['hwm_bytes'] as num).toList()),
      'self_cpu_ms': backendDistribution(
        entry.value.map((row) => (row['after']['cpu_ms'] as num) - (row['before']['cpu_ms'] as num)).toList(),
      ),
    };
  }
  final responsive = <String, Map<String, dynamic>>{};
  for (final row in rows.where((row) => BackendScenario.fromRow(row) == BackendScenario.responsiveness)) {
    final values = responsive.putIfAbsent(
      'responsiveness/${row['layout']}/${row['count']}',
      () => {'rpc_ms': <num>[], 'scheduled_rpc_ms': <num>[], 'loop_ms': <num>[], 'dropped': 0, 'loop_skipped': 0},
    );
    for (final probe in asList(row['rpc_probes']).map(asMap).where((probe) => probe['status'] == 'ok')) {
      (values['rpc_ms'] as List<num>).add(probe['latency_ms'] as num);
      (values['scheduled_rpc_ms'] as List<num>).add(probe['scheduled_latency_ms'] as num);
    }
    for (final sample in asList(row['event_loop_samples']).map(asMap)) {
      (values['loop_ms'] as List<num>).add(sample['lag_ms'] as num);
      values['loop_skipped'] = (values['loop_skipped'] as int) + (sample['skipped_intervals'] as int);
    }
    values['dropped'] = (values['dropped'] as int) + (row['dropped_probe_intervals'] as int);
  }
  for (final entry in responsive.entries) {
    summary[entry.key] = {
      ...entry.value,
      for (final name in ['rpc_ms', 'scheduled_rpc_ms', 'loop_ms'])
        name: backendDistribution(entry.value[name] as List<num>),
    };
  }
  final metrics = <String, Map<String, List<num>>>{};
  for (final row in rows.where((row) => BackendScenario.fromRow(row) == BackendScenario.metrics)) {
    for (final metric in asList(row['rows']).map(asMap)) {
      final target = metrics.putIfAbsent(
        '${metric['phase']}/${metric['concurrency']}',
        () => {'elapsed_ms': [], 'self_cpu_ms': []},
      );
      target['elapsed_ms']!.add(metric['elapsed_ms'] as num);
      target['self_cpu_ms']!.add((metric['after']['cpu_ms'] as num) - (metric['before']['cpu_ms'] as num));
    }
  }
  if (metrics.isNotEmpty) {
    summary['metrics'] = {
      for (final entry in metrics.entries)
        entry.key: {for (final metric in entry.value.entries) metric.key: backendDistribution(metric.value)},
    };
  }
  for (final row in rows.where((row) => BackendScenario.fromRow(row) == BackendScenario.commandDiagnostic)) {
    final counts = <String, int>{};
    for (final name in asList(row['direct_command_invocations']).cast<String>()) {
      counts.update(name, (n) => n + 1, ifAbsent: () => 1);
    }
    summary['direct_commands'] = counts;
  }
  return summary;
}

List<Map<String, dynamic>> _readRows(File file) {
  final diagnostics = <String>[];
  final rows = readJsonLines(file, diagnostics);
  if (diagnostics.isNotEmpty) throw FormatException('Invalid raw backend records: ${diagnostics.join('; ')}');
  return rows;
}

Map<String, dynamic> _json(File file) {
  final value = decodeStrictJson(file.readAsStringSync());
  if (value is! Map<String, dynamic>) throw const FormatException('Expected JSON object');
  return value;
}

String _number(dynamic number) => number is num ? number.toStringAsFixed(3) : 'unknown';
void writeBackendReport(Directory root) {
  final variants = <String, dynamic>{}, provenance = <String, Map<String, dynamic>>{};
  for (final directory in root.listSync().whereType<Directory>().toList()..sort((a, b) => a.path.compareTo(b.path))) {
    final raw = File(p.join(directory.path, 'raw.jsonl'));
    if (!raw.existsSync()) continue;
    final name = p.basename(directory.path);
    variants[name] = summarizeBackend(_readRows(raw));
    provenance[name] = _json(File(p.join(directory.path, 'provenance.json')));
  }
  final compatible =
      provenance.values
          .map(
            (value) => canonical([
              value['harness_sha256'],
              value['mode'],
              value['dart_version'],
              value['tooling_sha256'] ?? value['tooling'] ?? 'python',
            ]),
          )
          .toSet()
          .length <=
      1;
  writeJson(File(p.join(root.path, 'comparison.json')), variants);
  final accepted = [
    BackendVariant.candidateApproved,
    BackendVariant.candidateFinal,
    BackendVariant.candidate,
  ].map((v) => v.wireName).where(variants.containsKey).firstOrNull;
  final visible = variants.entries.where((entry) => entry.key == 'baseline' || entry.key == accepted);
  final text = <String>[
    '# Local backend measurements',
    '',
    'Pure Dart Linux host measurements, no RaPi5/GPU/Flutter run. Metadata-only files are never decoded. Nearest-rank quantiles; small sample counts do not establish stable p99. Whole-process RSS/HWM includes both isolates. Raw cpu_ms and summary self_cpu_ms cover the Dart process utime/stime, excluding subprocess CPU.',
    '',
    'Harness/mode/SDK/tooling compatibility: ${compatible ? 'matched' : 'MISMATCH; do not compare variants'}.',
    '',
    '| Variant | Layout/count | Index + first, p50 ms | Remaining N-1, p50 ms | Whole cycle, p50 ms | Peak HWM bytes |',
    '|---|---|---:|---:|---:|---:|',
  ];
  for (final entry in visible) {
    for (final value in (entry.value as Map).entries.where((e) => (e.key as String).startsWith('storage/'))) {
      text.add(
        '| ${entry.key} | ${(value.key as String).substring(8)} | ${_number(value.value['index_first_selection_ms']['p50'])} | ${_number(value.value['remaining_selection_ms']['p50'])} | ${_number(value.value['whole_cycle_ms']['p50'])} | ${value.value['hwm_bytes']['max']} |',
      );
    }
  }
  text.addAll([
    '',
    '| Variant | Layout/count | RPC p95/max ms | Loop lag p95/max ms | Skipped probes / loop intervals |',
    '|---|---|---:|---:|---:|',
  ]);
  for (final entry in visible) {
    for (final value in (entry.value as Map).entries.where((e) => (e.key as String).startsWith('responsiveness/'))) {
      text.add(
        '| ${entry.key} | ${(value.key as String).substring(15)} | ${_number(value.value['rpc_ms']['p95'])} / ${_number(value.value['rpc_ms']['max'])} | ${_number(value.value['loop_ms']['p95'])} / ${_number(value.value['loop_ms']['max'])} | ${value.value['dropped']} / ${value.value['loop_skipped']} |',
      );
    }
  }
  text.addAll([
    '',
    'RPC samples include 60 ms before and after indexing. Saturated probes are explicitly skipped and counted; raw scheduled latencies and event-loop gaps remain in JSONL.',
    '',
    '| Variant | Metric phase/concurrency | p50 / max elapsed ms | Samples |',
    '|---|---|---:|---:|',
  ]);
  for (final entry in visible) {
    for (final value in asMap(entry.value['metrics']).entries) {
      final metric = value.value['elapsed_ms'];
      text.add(
        '| ${entry.key} | ${value.key} | ${_number(metric['p50'])} / ${_number(metric['max'])} | ${metric['n']} |',
      );
    }
    text.add(
      '\n${entry.key} separate diagnostic direct command invocations: `${canonical(entry.value['direct_commands'] ?? <String, int>{})}`.',
    );
  }
  text.addAll([
    '',
    'Exactly N selections exclude the boundary rescan. Index/cycle observations use fresh independent processes. Validation, decoding, fixture creation and RPC are outside selection timing. Metrics use real host /proc data and applicable commands, plus a constant sensor script. Expired refreshes use 1100 ms spacing; production normally requests once per minute. Forwarding wrappers run in a separate diagnostic pass and count only direct commands.',
    '',
    'Baseline then candidate order is not a randomized A/B trial. Host contention, filesystem cache and runtime conditions limit conclusions; these local measurements do not establish RaPi5 performance.',
  ]);
  final stem = [
    'confirm-approved',
    'confirm-final',
    'confirm',
  ].where((name) => File(p.join(root.path, '$name-summary.json')).existsSync()).firstOrNull;
  if (stem != null) {
    final confirm = _json(File(p.join(root.path, '$stem-summary.json'))),
        rows = _readRows(File(p.join(root.path, '$stem-raw.jsonl')));
    text.addAll([
      '',
      'ABBA confirmation reuses frozen AOT binaries: `$stem-raw.jsonl`, `$stem-summary.json`, `$stem-provenance.json`. Confirmation CPU is Linux getrusage(RUSAGE_CHILDREN) after reaping, including reaped descendants.',
      '',
      '| ABBA variant | Layout/count | Whole cycle range ms | Remaining N-1 range ms | Observations |',
      '|---|---|---:|---:|---:|',
    ]);
    for (final variant in confirm.keys) {
      for (final layout in BackendLayout.values) {
        final selected = rows
            .where(
              (r) =>
                  r['variant'] == variant &&
                  BackendScenario.fromRow(r) == BackendScenario.storage &&
                  r['layout'] == layout.name,
            )
            .toList();
        if (selected.isEmpty) continue;
        String range(String field) {
          final values = selected.map((r) => r[field] as num).toList();
          return '${_number(values.reduce(min))}–${_number(values.reduce(max))}';
        }

        text.add(
          '| $variant | ${layout.name}/50000 | ${range('whole_cycle_ms')} | ${range('remaining_selection_ms')} | ${selected.length} |',
        );
      }
    }
    text.addAll([
      '',
      '| ABBA variant | Entire metrics CPU incl. reaped children, range ms | Observations |',
      '|---|---:|---:|',
    ]);
    for (final variant in confirm.keys) {
      final selected = rows
          .where((r) => r['variant'] == variant && BackendScenario.fromRow(r) == BackendScenario.metrics)
          .toList();
      final values = selected.map((r) => r['process_and_reaped_children_cpu_ms'] as num).toList();
      text.add(
        '| $variant | ${values.isEmpty ? 'unknown' : '${_number(values.reduce(min))}–${_number(values.reduce(max))}'} | ${selected.length} |',
      );
    }
    text.addAll([
      '',
      '| ABBA variant | Individual expired refresh, range ms | Immediate cached call, range ms |',
      '|---|---:|---:|',
    ]);
    for (final variant in confirm.keys) {
      final metrics = rows
          .where((r) => r['variant'] == variant && BackendScenario.fromRow(r) == BackendScenario.metrics)
          .expand((row) => asList(row['rows']))
          .map(asMap);
      String range(String phase) {
        final values = metrics.where((m) => m['phase'] == phase).map((m) => m['elapsed_ms'] as num).toList();
        return values.isEmpty ? 'unknown' : '${_number(values.reduce(min))}–${_number(values.reduce(max))}';
      }

      text.add('| $variant | ${range('expired_refresh')} | ${range('immediate')} |');
    }
    text.add(
      '\nEntire metrics workload and individual refreshes measure different contracts. Read refresh ranges separately from cache-hit latency and aggregate CPU; no consistent speedup is inferred automatically.',
    );
  }
  final diagnostic = File(p.join(root.path, 'process-diagnostic.json'));
  if (diagnostic.existsSync()) {
    final value = _json(diagnostic);
    if (value.containsKey('unavailable') ||
        asMap(value['variants']).values.any((v) => asMap(v).containsKey('unavailable'))) {
      text.add(
        '\nAll-child-process tracing was unavailable; see process-diagnostic.json. Wrapper counts remain direct invocations and total child counts are unverified.',
      );
    }
  }
  final verification = File(p.join(root.path, 'final-source-verification.json'));
  if (verification.existsSync()) {
    final value = _json(verification);
    text.add(
      '\nFinal production-source verification: `${value['final_production_tree_sha256']}`; differences from ${value['measured_variant']}: `${value['differences']}`.',
    );
  }
  File(p.join(root.path, 'report.md')).writeAsStringSync('${text.join('\n')}\n');
}

Future<int> _operation(
  String action,
  ArgParser parser,
  List<String> arguments,
  Future<int> Function(ArgResults, ProcessSupervisor) work,
) async {
  parser.addFlag('help', abbr: 'h', negatable: false);
  final owner = ProcessSupervisor();
  final subscriptions = <StreamSubscription<ProcessSignal>>[];
  final clock = Stopwatch()..start();
  try {
    final args = parser.parse(arguments);
    if (args.flag('help')) {
      stdout.writeln('benchmark $action\n${parser.usage}');
      return 0;
    }
    if (args.rest.isNotEmpty) throw const FormatException('Unexpected positional arguments');
    subscriptions.add(ProcessSignal.sigint.watch().listen((_) => unawaited(owner.cancel(130))));
    if (!Platform.isWindows) {
      subscriptions.add(ProcessSignal.sigterm.watch().listen((_) => unawaited(owner.cancel(143))));
    }
    _log.info('operation=${owner.runId} action=$action result=started');
    final result = await work(args, owner);
    _log.info(
      'operation=${owner.runId} action=$action result=finished code=$result durationMs=${clock.elapsedMilliseconds}',
    );
    return result;
  } on FormatException catch (error) {
    stderr.writeln('${error.message}\n${parser.usage}');
    return 64;
  } on ProcessJobFailure catch (error, stack) {
    _log.warning(
      'operation=${owner.runId} action=$action result=${owner.cancellationCode == null ? 'failed' : 'cancelled'} code=${error.exitCode}',
      error,
      stack,
    );
    return error.exitCode;
  } on Exception catch (error, stack) {
    _log.warning('operation=${owner.runId} action=$action result=failed type=${error.runtimeType}', error, stack);
    stderr.writeln('Backend benchmark failed: ${error.runtimeType}');
    return 1;
  } finally {
    for (final subscription in subscriptions) {
      await subscription.cancel();
    }
    await owner.close();
  }
}

String _required(ArgResults args, String name) {
  final value = args.option(name);
  if (value == null || value.isEmpty) throw FormatException('--$name is required');
  return value;
}

Future<Map<String, String>> _baseEnvironment(ProcessSupervisor owner) async {
  final ticks = (await runBackendProcess(['getconf', 'CLK_TCK'], supervisor: owner)).$1.trim();
  if (int.tryParse(ticks) == null) throw const FormatException('Invalid CLK_TCK');
  return {...Platform.environment, 'BENCHMARK_CLK_TCK': ticks};
}

Map<String, dynamic> _lastRow(String output) {
  final value = decodeStrictJson(const LineSplitter().convert(output.trimRight()).last);
  if (value is! Map<String, dynamic> || value['status'] != 'ok') throw const FormatException('Backend scenario failed');
  return value;
}

Future<String> _disk(Directory directory, ProcessSupervisor owner) async {
  final text = (await runBackendProcess(['df', '-P', directory.path], supervisor: owner)).$1;
  final lines = const LineSplitter().convert(text);
  if (lines.length < 2) throw const FormatException('Invalid df output');
  return lines[1].trim().split(_space).first;
}

void _record(File file, Map<String, dynamic> row) =>
    file.writeAsStringSync('${encodeReportJson(row)}\n', mode: FileMode.append);

Future<int> runBackendLocal(List<String> arguments) => _operation(
  'backend-local',
  ArgParser()
    ..addOption('dart', defaultsTo: '/home/dis/bin/flutter/bin/cache/dart-sdk/bin/dart')
    ..addOption('packages')
    ..addOption('variant', allowed: BackendVariant.values.map((v) => v.wireName).toList())
    ..addOption('output')
    ..addOption('sizes', defaultsTo: '1,1000,10000,50000')
    ..addOption('layouts', defaultsTo: 'flat,nested')
    ..addOption('repeats', defaultsTo: '3')
    ..addOption('metrics-repeats', defaultsTo: '3')
    ..addOption('mode', allowed: BackendMode.values.map((mode) => mode.name).toList(), defaultsTo: BackendMode.aot.name)
    ..addOption('provenance')
    ..addOption('harness'),
  arguments,
  (args, owner) async {
    final sizes = _required(args, 'sizes').split(',').map(int.parse).toList();
    final layouts = _required(args, 'layouts')
        .split(',')
        .map(
          (name) => BackendLayout.values.firstWhere(
            (layout) => layout.name == name,
            orElse: () => throw const FormatException('Only flat,nested layouts are supported'),
          ),
        )
        .toList();
    final repeats = int.parse(_required(args, 'repeats')),
        metricsRepeats = int.parse(_required(args, 'metrics-repeats'));
    if (sizes.isEmpty || sizes.any((n) => n < 1) || repeats < 1 || metricsRepeats < 0) {
      throw const FormatException('Positive sizes/repeats required');
    }
    final root = Directory(_required(args, 'output')).absolute..createSync(recursive: true);
    final destination = Directory(p.join(root.path, _required(args, 'variant')));
    if (destination.existsSync()) throw const FileSystemException('Refusing to replace existing variant');
    destination.createSync();
    final (packages, harness, provenance) = await backendSnapshot(
      File(_required(args, 'packages')).absolute,
      destination,
      harness: args.option('harness') == null ? null : File(args.option('harness')!),
      supervisor: owner,
    );
    if (args.option('provenance') != null) provenance['original_snapshot'] = _json(File(args.option('provenance')!));
    final dart = args.option('dart')!, mode = BackendMode.values.byName(args.option('mode')!);
    provenance.addAll({
      'mode': mode.name,
      'host': {
        'system': Platform.operatingSystem,
        'release': Platform.operatingSystemVersion,
        'machine': Abi.current().toString(),
      },
      'dart_version': (await runBackendProcess([
        dart,
        '--suppress-analytics',
        '--version',
      ], supervisor: owner)).$1.trim(),
      'argv': {for (final name in args.options) name: args[name]},
      'started_utc': DateTime.now().toUtc().toIso8601String(),
    });
    List<String> command;
    if (mode == BackendMode.aot) {
      final binary = File(p.join(destination.path, 'backend-local'));
      final compile = [
        dart,
        '--suppress-analytics',
        'compile',
        'exe',
        '--packages=${packages.path}',
        harness.path,
        '-o',
        binary.path,
      ];
      final clock = Stopwatch()..start();
      final (out, error) = await runBackendProcess(compile, timeout: const Duration(seconds: 180), supervisor: owner);
      File(p.join(destination.path, 'compile.log')).writeAsStringSync(out + error);
      provenance.addAll({
        'compile_seconds': clock.elapsedMicroseconds / 1000000,
        'binary_sha256': digest(binary),
        'compile_argv': compile,
      });
      command = [binary.path];
    } else {
      command = [dart, '--packages=${packages.path}', harness.path];
    }
    writeJson(File(p.join(destination.path, 'provenance.json')), provenance);
    final environment = await _baseEnvironment(owner), raw = File(p.join(destination.path, 'raw.jsonl'));
    Future<Map<String, dynamic>> execute(
      String scenario,
      Directory directory, {
      Map<String, Object?> values = const {},
    }) async {
      final clock = Stopwatch()..start();
      final (out, error) = await runBackendProcess(
        [...command, '--scenario=$scenario', for (final entry in values.entries) '--${entry.key}=${entry.value}'],
        environment: {...environment, 'DSLIDESHOW_ROOT': directory.path},
        supervisor: owner,
      );
      return {
        ..._lastRow(out),
        'scenario': scenario,
        'process_wall_seconds': clock.elapsedMicroseconds / 1000000,
        'stderr': error,
      };
    }

    try {
      for (final layout in layouts) {
        for (final count in sizes) {
          final fixture = Directory(p.join(root.path, 'fixtures', '${layout.name}-$count'));
          final manifest = backendFixture(fixture, count, layout);
          for (var repeat = 0; repeat < repeats; repeat++) {
            for (final scenario in ['storage', 'responsiveness']) {
              stdout.writeln('${args.option('variant')} $scenario ${layout.name} $count repeat $repeat');
              _record(raw, {
                ...await execute(scenario, fixture, values: scenario == 'storage' ? {'count': count} : {}),
                'count': count,
                'layout': layout.name,
                'repeat': repeat,
                'fixture': manifest,
              });
            }
          }
        }
      }
      final sensor = sensorFixture(destination);
      environment.addAll({
        'BENCHMARK_SENSOR_SCRIPT': sensor.path,
        'BENCHMARK_DISK_SOURCE': await _disk(destination, owner),
      });
      _record(raw, await execute('metrics', destination, values: {'repeats': metricsRepeats, 'interval-ms': 1100}));
      final wrappers = Directory(p.join(destination.path, 'exec-wrappers'));
      backendWrappers(wrappers);
      final log = File(p.join(destination.path, 'direct-exec.log'));
      environment.addAll({'PATH': '${wrappers.path}:${environment['PATH']}', 'BENCHMARK_EXEC_LOG': log.path});
      final diagnostic = await execute('metrics', destination, values: {'repeats': 1, 'interval-ms': 1100});
      _record(raw, {
        ...diagnostic,
        'scenario': 'metrics_command_diagnostic',
        'direct_command_invocations': log.readAsLinesSync(),
      });
    } on Object catch (error) {
      writeJson(File(p.join(destination.path, 'failure.json')), {'error_type': error.runtimeType.toString()});
      rethrow;
    } finally {
      writeBackendReport(root);
    }
    stdout.writeln('Report: ${p.join(root.path, 'report.md')}');
    return 0;
  },
);

int reapedChildrenCpuMicroseconds() {
  if (!Platform.isLinux || sizeOf<IntPtr>() != 8) throw UnsupportedError('Backend confirmation requires Linux LP64');
  final value = calloc<native.rusage>();
  try {
    if (native.getrusage(-1, value) != 0) throw StateError('RUSAGE_CHILDREN unavailable');
    return (value.ref.ru_utime.tv_sec + value.ref.ru_stime.tv_sec) * 1000000 +
        value.ref.ru_utime.tv_usec +
        value.ref.ru_stime.tv_usec;
  } finally {
    calloc.free(value);
  }
}

Future<int> runBackendConfirm(List<String> arguments) => _operation(
  'backend-local-confirm',
  ArgParser()
    ..addOption('output')
    ..addOption('rounds', defaultsTo: '1')
    ..addOption(
      'candidate',
      allowed: _candidates.map((v) => v.wireName).toList(),
      defaultsTo: BackendVariant.candidate.wireName,
    )
    ..addFlag('metrics-only', negatable: false),
  arguments,
  (args, owner) async {
    final rounds = int.parse(args.option('rounds')!);
    if (rounds < 1) throw const FormatException('Positive --rounds required');
    final root = Directory(_required(args, 'output')).absolute;
    final chosen = BackendVariant.parse(args.option('candidate')!);
    final candidate = chosen.wireName;
    final stem = switch (chosen) {
      BackendVariant.candidateFinal => 'confirm-final',
      BackendVariant.candidateApproved => 'confirm-approved',
      _ => 'confirm',
    };
    final raw = File(p.join(root.path, '$stem-raw.jsonl'));
    if (raw.existsSync()) throw const FileSystemException('Confirmation output already exists');
    final provenance = {
      for (final name in ['baseline', candidate]) name: _json(File(p.join(root.path, name, 'provenance.json'))),
    };
    if (provenance.values.any((value) => value['mode'] != 'aot')) {
      throw const FormatException('Confirmation requires frozen AOT binaries');
    }
    if (provenance.values
            .map(
              (value) => canonical([
                value['harness_sha256'],
                value['dart_version'],
                value['tooling_sha256'] ?? value['tooling'] ?? 'python',
              ]),
            )
            .toSet()
            .length !=
        1) {
      throw const FormatException('Different harnesses, SDK or tooling; cannot compare');
    }
    final rows = <Map<String, dynamic>>[];
    Future<Map<String, dynamic>> execute(List<String> command, Map<String, String> env) async {
      final before = reapedChildrenCpuMicroseconds(), clock = Stopwatch()..start();
      final (out, error) = await runBackendProcess(command, environment: env, supervisor: owner);
      final after = reapedChildrenCpuMicroseconds();
      return {
        ..._lastRow(out),
        'process_wall_seconds': clock.elapsedMicroseconds / 1000000,
        'stderr': error,
        'process_and_reaped_children_cpu_ms': (after - before) / 1000,
      };
    }

    for (var round = 0; round < rounds; round++) {
      final order = ['baseline', candidate, candidate, 'baseline'];
      for (var index = 0; index < order.length; index++) {
        final variant = order[index],
            folder = Directory(p.join(root.path, variant)),
            binary = File(p.join(root.path, variant, 'backend-local'));
        if (digest(binary) != provenance[variant]!['binary_sha256']) {
          throw FormatException('Changed frozen binary: $variant');
        }
        final env = await _baseEnvironment(owner);
        if (!args.flag('metrics-only')) {
          for (final layout in BackendLayout.values) {
            final fixture = Directory(p.join(root.path, 'fixtures', '${layout.name}-50000'));
            backendFixture(fixture, 50000, layout);
            final row = {
              ...await execute(
                [binary.path, '--scenario=storage', '--count=50000'],
                {...env, 'DSLIDESHOW_ROOT': fixture.path},
              ),
              'variant': variant,
              'scenario': 'storage',
              'layout': layout.name,
              'round': round,
              'order': index,
            };
            rows.add(row);
            _record(raw, row);
          }
        }
        final row = {
          ...await execute(
            [binary.path, '--scenario=metrics', '--repeats=1', '--interval-ms=1100'],
            {
              ...env,
              'DSLIDESHOW_ROOT': root.path,
              'BENCHMARK_SENSOR_SCRIPT': p.join(folder.path, 'sensors.sh'),
              'BENCHMARK_DISK_SOURCE': await _disk(root, owner),
            },
          ),
          'variant': variant,
          'scenario': 'metrics',
          'round': round,
          'order': index,
        };
        rows.add(row);
        _record(raw, row);
      }
    }
    final summary = <String, dynamic>{};
    for (final variant in ['baseline', candidate]) {
      final selected = rows.where((r) => r['variant'] == variant).toList();
      summary[variant] = {
        ...summarizeBackend(selected),
        'metrics_process_and_reaped_children_cpu_ms': backendDistribution(
          selected
              .where((r) => BackendScenario.fromRow(r) == BackendScenario.metrics)
              .map((r) => r['process_and_reaped_children_cpu_ms'] as num)
              .toList(),
        ),
      };
    }
    writeJson(File(p.join(root.path, '$stem-summary.json')), summary);
    writeJson(File(p.join(root.path, '$stem-provenance.json')), {
      'argv': {for (final name in args.options) name: args[name]},
      'binaries': provenance,
      'order': 'ABBA',
      'cpu': 'Linux getrusage(RUSAGE_CHILDREN) deltas after reaping; includes reaped descendants',
    });
    return 0;
  },
);

List<int> backendProcessCreations(String text) {
  final pending = <(String, String), String>{}, children = <int>{};
  for (final line in const LineSplitter().convert(text)) {
    final match = _traceHead.firstMatch(line);
    if (match == null) continue;
    final tid = match[1]!;
    var event = match[2]!;
    final resumed = _traceResumed.firstMatch(event);
    if (resumed != null) event = (pending.remove((tid, resumed[1]!)) ?? '') + resumed[2]!;
    final initial = _traceInitial.matchAsPrefix(event);
    if (initial == null) continue;
    if (event.contains('<unfinished ...>')) {
      pending[(tid, initial[1]!)] = event.split('<unfinished ...>').first;
      continue;
    }
    final result = _traceResult.firstMatch(event);
    if (result != null && !event.contains('CLONE_THREAD')) children.add(int.parse(result[1]!));
  }
  return children.toList()..sort();
}

Future<int> runBackendTrace(
  List<String> arguments,
) => _operation('backend-local-trace', ArgParser()..addOption('output'), arguments, (args, owner) async {
  final root = Directory(_required(args, 'output')).absolute, file = File(p.join(root.path, 'process-diagnostic.json'));
  if (file.existsSync()) throw const FileSystemException('Diagnostic output already exists');
  final results = <String, dynamic>{
    'method': 'strace -f -e trace=process; successful non-thread process creation events, excluding the harness itself',
    'timing': 'diagnostic only; no elapsed-time comparison',
    'variants': <String, dynamic>{},
  };
  final executable = _which('strace');
  if (executable == null) {
    results['unavailable'] = 'strace is not installed; no installation attempted';
  } else {
    for (final variant in [BackendVariant.baseline, BackendVariant.candidate].map((v) => v.wireName)) {
      final folder = Directory(p.join(root.path, variant)), binary = File(p.join(root.path, variant, 'backend-local'));
      final provenance = _json(File(p.join(folder.path, 'provenance.json')));
      if (digest(binary) != provenance['binary_sha256']) throw FormatException('Changed frozen binary: $variant');
      final trace = File(p.join(folder.path, 'process-trace.log'));
      final command = [
        executable,
        '-f',
        '-e',
        'trace=process',
        '-o',
        trace.path,
        binary.path,
        '--scenario=metrics',
        '--repeats=0',
        '--interval-ms=1100',
      ];
      final env = {
        ...Platform.environment,
        'BENCHMARK_SENSOR_SCRIPT': p.join(folder.path, 'sensors.sh'),
        'BENCHMARK_DISK_SOURCE': await _disk(root, owner),
        'DSLIDESHOW_ROOT': root.path,
      };
      try {
        final (out, error) = await runBackendProcess(
          command,
          environment: env,
          timeout: const Duration(seconds: 30),
          supervisor: owner,
        );
        final children = backendProcessCreations(trace.readAsStringSync());
        results['variants'][variant] = {
          'child_process_count': children.length,
          'child_pids': children,
          'command': command,
          'stderr': error,
          'raw': _lastRow(out),
        };
      } on ProcessJobFailure catch (error) {
        if (owner.cancellationCode != null && owner.cancellationCode != 124) rethrow;
        results['variants'][variant] = {'unavailable': '${error.reason} code=${error.exitCode}', 'command': command};
      }
    }
  }
  writeJson(file, results);
  stdout.writeln(file.path);
  return 0;
});
