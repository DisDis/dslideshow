import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:crypto/crypto.dart';
import 'package:path/path.dart' as p;

const coveragePackages = {
  'backend': 'dslideshow_backend',
  'config_app': 'config_app',
  'dslideshow_flutter': 'dslideshow_flutter',
};
const _generated = ['.g.dart', '.freezed.dart'];
final _imports = RegExp(r'''(?:import|export)\s+['"]([^'"]+)['"]''');
final _testFlags = {
  'real_delay': RegExp(r'Future(?:<[^>]+>)?\.delayed\s*\(|\bsleep\s*\('),
  'pump_and_settle': RegExp(r'\bpumpAndSettle\s*\('),
  'widget_count': RegExp(r'\bfindsNWidgets\s*\('),
  'skip': RegExp(r'\bskip\s*:'),
};
typedef CoverageRecord = Map<String, Map<String, int>>;
typedef CoverageRecords = Map<String, CoverageRecord>;

void writeCoverageJson(File file, Object? value) {
  file.parent.createSync(recursive: true);
  file.writeAsStringSync('${const JsonEncoder.withIndent('  ').convert(value)}\n');
}

/// Identifies the running collector and reporter, including shared CLI services.
String coverageImplementationSha256({Directory? sourcePackage, File? compiledExecutable}) {
  if (compiledExecutable != null || const bool.fromEnvironment('dart.vm.product')) {
    return sha256.convert((compiledExecutable ?? File.fromUri(Platform.script)).readAsBytesSync()).toString();
  }
  final sourceUri = Isolate.resolvePackageUriSync(Uri.parse('package:dslideshow_tools/src/coverage/coverage.dart'));
  if (sourcePackage == null && sourceUri == null) throw StateError('Cannot locate coverage implementation inputs');
  final directory = sourcePackage ?? File.fromUri(sourceUri!).parent.parent.parent.parent;
  final inputs = <String, String>{};
  for (final name in ['lib', 'bin']) {
    for (final file in _files(Directory(p.join(directory.path, name)))) {
      if (p.extension(file.path) == '.dart') {
        inputs[_relative(file.path, directory)] = sha256.convert(file.readAsBytesSync()).toString();
      }
    }
  }
  for (final name in ['pubspec.yaml', 'pubspec.lock']) {
    final file = File(p.join(directory.path, name));
    inputs[name] = sha256.convert(file.readAsBytesSync()).toString();
  }
  final names = inputs.keys.toList()..sort();
  return sha256.convert(utf8.encode(jsonEncode({for (final name in names) name: inputs[name]}))).toString();
}

List<File> _files(Directory directory) => !directory.existsSync()
    ? []
    : (directory.listSync(recursive: true, followLinks: false).whereType<File>().toList()
        ..sort((a, b) => a.path.compareTo(b.path)));

String _relative(String path, Directory root) => p.posix.joinAll(p.split(p.relative(path, from: root.path)));

String _pythonString(String value) {
  final json = jsonEncode(value);
  return String.fromCharCodes(
    json.codeUnits.expand((unit) => unit > 127 ? '\\u${unit.toRadixString(16).padLeft(4, '0')}'.codeUnits : [unit]),
  );
}

Map<String, dynamic> sourceSnapshot(Directory root) {
  final files = <String, String>{};
  for (final package in [...coveragePackages.keys, 'common', 'i18n', 'system_metrics_widget']) {
    final base = p.join(root.path, package);
    for (final directory in ['lib', 'bin', 'test', 'integration_test', 'assets']) {
      for (final file in _files(Directory(p.join(base, directory)))) {
        files[_relative(file.path, root)] = sha256.convert(file.readAsBytesSync()).toString();
      }
    }
    for (final name in ['pubspec.yaml', 'pubspec.lock', 'analysis_options.yaml']) {
      final file = File(p.join(base, name));
      if (file.existsSync()) files[_relative(file.path, root)] = sha256.convert(file.readAsBytesSync()).toString();
    }
  }
  final names = files.keys.toList()..sort();
  final ordered = {for (final name in names) name: files[name]!};
  // Keep the pre-migration snapshot identity (Python json.dumps(sort_keys=True)).
  final canonical = '{${names.map((name) => '${_pythonString(name)}: ${_pythonString(files[name]!)}').join(', ')}}';
  return {'sha256': sha256.convert(utf8.encode(canonical)).toString(), 'files': ordered};
}

(Map<String, dynamic>, List<String>) inventory(Directory root) {
  final sources = <String, dynamic>{};
  final excluded = <String>[];
  for (final package in coveragePackages.keys) {
    for (final directory in ['lib', 'bin']) {
      for (final file in _files(Directory(p.join(root.path, package, directory)))) {
        if (p.extension(file.path) != '.dart') continue;
        final name = p.basename(file.path);
        final text = file.readAsStringSync();
        final key = _relative(file.path, root);
        if (_generated.any(name.endsWith) ||
            text.substring(0, text.length.clamp(0, 500)).contains('GENERATED CODE') ||
            name == 'generated_plugin_registrant.dart') {
          excluded.add(key);
        } else {
          sources[key] = {'package': package, 'source_lines': const LineSplitter().convert(text).length};
        }
      }
    }
  }
  return (sources, excluded);
}

String? resolveSource(String value, Directory root, String package) {
  if (value.startsWith('package:')) {
    final uri = Uri.parse(value);
    final segments = uri.pathSegments;
    if (segments.isEmpty) return null;
    final matches = coveragePackages.entries.where((entry) => entry.value == segments.first);
    return matches.isEmpty ? null : p.posix.join(matches.first.key, 'lib', p.posix.joinAll(segments.skip(1)));
  }
  var path = value.startsWith('file:') ? p.fromUri(Uri.parse(value)) : value;
  if (!p.isAbsolute(path)) path = p.join(root.path, package, path);
  path = p.normalize(p.absolute(path));
  final base = p.normalize(root.absolute.path);
  return p.isWithin(base, path) ? _relative(path, root) : null;
}

CoverageRecord emptyRecord() => {'lines': {}, 'branches': {}, 'functions': {}};

CoverageRecords readLcov(File file, Directory root, String package) {
  final records = <String, CoverageRecord>{};
  CoverageRecord? current;
  var functions = <String, String>{};
  for (final raw in file.readAsLinesSync()) {
    if (raw.startsWith('SF:')) {
      final name = resolveSource(raw.substring(3), root, package);
      current = name == null ? null : records.putIfAbsent(name, emptyRecord);
      functions = {};
    } else if (raw == 'end_of_record') {
      current = null;
    } else if (current != null) {
      if (raw.startsWith('DA:')) {
        final fields = raw.substring(3).split(',');
        final key = int.parse(fields[0]).toString();
        current['lines']!.update(key, (n) => n + int.parse(fields[1]), ifAbsent: () => int.parse(fields[1]));
      } else if (raw.startsWith('BRDA:')) {
        final fields = raw.substring(5).split(',');
        if (fields.length != 4) throw const FormatException('Invalid BRDA record');
        final key = fields.take(3).join(',');
        final count = fields[3] == '-' ? 0 : int.parse(fields[3]);
        current['branches']!.update(key, (n) => n + count, ifAbsent: () => count);
      } else if (raw.startsWith('FN:')) {
        final declaration = raw.substring(3);
        final comma = declaration.indexOf(',');
        if (comma < 0) throw const FormatException('Invalid FN record');
        functions[declaration.substring(comma + 1)] = declaration;
        current['functions']!.putIfAbsent(declaration, () => 0);
      } else if (raw.startsWith('FNDA:')) {
        final declaration = raw.substring(5);
        final comma = declaration.indexOf(',');
        final name = declaration.substring(comma + 1);
        final key = functions[name];
        if (key == null) throw FormatException('FNDA has no FN declaration: $name');
        final count = int.parse(declaration.substring(0, comma));
        current['functions']!.update(key, (n) => n + count, ifAbsent: () => count);
      }
    }
  }
  return records;
}

CoverageRecords mergeRecords(Iterable<CoverageRecords> groups) {
  final merged = <String, CoverageRecord>{};
  for (final records in groups) {
    for (final entry in records.entries) {
      final target = merged.putIfAbsent(entry.key, emptyRecord);
      for (final kind in target.keys) {
        for (final value in entry.value[kind]!.entries) {
          target[kind]!.update(value.key, (n) => n + value.value, ifAbsent: () => value.value);
        }
      }
    }
  }
  return merged;
}

Map<String, int> metrics(CoverageRecord record) => {
  for (final kind in ['lines', 'branches', 'functions']) ...{
    '${kind}_found': record[kind]!.length,
    '${kind}_hit': record[kind]!.values.where((n) => n > 0).length,
  },
};

Map<String, dynamic> totals(CoverageRecords records) {
  final result = <String, dynamic>{
    for (final kind in ['lines', 'branches', 'functions']) ...{'${kind}_found': 0, '${kind}_hit': 0},
  };
  for (final record in records.values) {
    for (final entry in metrics(record).entries) {
      result[entry.key] = (result[entry.key] as int) + entry.value;
    }
  }
  for (final (plural, singular) in [('lines', 'line'), ('branches', 'branch'), ('functions', 'function')]) {
    result['${singular}_percent'] = result['${plural}_found'] == 0
        ? null
        : double.parse(
            (100 * (result['${plural}_hit'] as int) / (result['${plural}_found'] as int)).toStringAsFixed(2),
          );
  }
  return result;
}

void writeLcov(File file, CoverageRecords records) {
  final text = StringBuffer();
  final names = records.keys.toList()..sort();
  for (final name in names) {
    final record = records[name]!;
    text.writeln('SF:$name');
    final functions = record['functions']!.keys.toList()..sort();
    for (final key in functions) {
      text.writeln('FN:$key');
    }
    for (final key in functions) {
      text.writeln('FNDA:${record['functions']![key]},${key.substring(key.indexOf(',') + 1)}');
    }
    final lines = record['lines']!.keys.toList()..sort((a, b) => int.parse(a).compareTo(int.parse(b)));
    for (final key in lines) {
      text.writeln('DA:$key,${record['lines']![key]}');
    }
    final branches = record['branches']!.keys.toList()..sort();
    for (final key in branches) {
      text.writeln('BRDA:$key,${record['branches']![key]}');
    }
    final m = metrics(record);
    for (final (label, key) in [
      ('FNF', 'functions_found'),
      ('FNH', 'functions_hit'),
      ('LF', 'lines_found'),
      ('LH', 'lines_hit'),
      ('BRF', 'branches_found'),
      ('BRH', 'branches_hit'),
    ]) {
      text.writeln('$label:${m[key]}');
    }
    text.writeln('end_of_record');
  }
  file.writeAsStringSync(text.isEmpty ? '\n' : text.toString());
}

List<Map<String, dynamic>> testIndex(Directory root) {
  final result = <Map<String, dynamic>>[];
  for (final package in coveragePackages.keys) {
    for (final file in _files(Directory(p.join(root.path, package, 'test')))) {
      if (!p.basename(file.path).endsWith('_test.dart')) continue;
      final source = file.readAsStringSync();
      result.add({
        'path': _relative(file.path, root),
        'lines': const LineSplitter().convert(source).length,
        'imports': _imports.allMatches(source).map((match) => match.group(1)).toList(),
        'review_hints': {
          for (final entry in _testFlags.entries)
            if (entry.value.hasMatch(source)) entry.key: entry.value.allMatches(source).length,
        },
      });
    }
  }
  return result;
}

Set<(String, String)> _hitSet(CoverageRecords records) => {
  for (final entry in records.entries)
    for (final line in entry.value['lines']!.entries)
      if (line.value > 0) (entry.key, line.key),
};

List<Map<String, dynamic>> overlap(Map<String, CoverageRecords> groups) {
  final names = groups.keys.toList();
  return [
    for (var i = 0; i < names.length; i++)
      for (var j = i + 1; j < names.length; j++)
        _overlap(names[i], names[j], _hitSet(groups[names[i]]!), _hitSet(groups[names[j]]!)),
  ];
}

Map<String, dynamic> _overlap(String left, String right, Set<(String, String)> a, Set<(String, String)> b) => {
  'left': left,
  'right': right,
  'shared_hit_lines': a.intersection(b).length,
  'left_only': a.difference(b).length,
  'right_only': b.difference(a).length,
  'jaccard_percent': a.union(b).isEmpty
      ? null
      : double.parse((100 * a.intersection(b).length / a.union(b).length).toStringAsFixed(2)),
};

Map<String, dynamic> testResults(File file) {
  final started = <Object?, Map<String, dynamic>>{};
  final done = <Object?, Map<String, dynamic>>{};
  final suites = <Object?, Object?>{};
  final starts = <Object?, num?>{};
  for (final line in file.existsSync() ? file.readAsLinesSync() : <String>[]) {
    dynamic event;
    try {
      event = jsonDecode(line);
    } on FormatException {
      continue;
    }
    if (event is! Map<String, dynamic>) continue;
    switch (event['type']) {
      case 'testStart':
        final test = event['test'] as Map<String, dynamic>;
        started[test['id']] = test;
        starts[test['id']] = event['time'] as num?;
      case 'suite':
        suites[event['suite']['id']] = event['suite']['path'];
      case 'testDone':
        done[event['testID']] = event;
    }
  }
  final counts = {
    for (final name in ['passed', 'failed', 'skipped', 'hidden', 'unfinished']) name: 0,
  };
  final failures = <Map<String, dynamic>>[], timings = <Map<String, dynamic>>[];
  for (final entry in started.entries) {
    final event = done[entry.key], test = entry.value;
    final status = event == null
        ? 'unfinished'
        : event['hidden'] == true
        ? 'hidden'
        : event['skipped'] == true
        ? 'skipped'
        : event['result'] == 'success'
        ? 'passed'
        : 'failed';
    counts[status] = counts[status]! + 1;
    if (status == 'failed') failures.add({'name': test['name'], 'suite': suites[test['suiteID']]});
    if (event != null && event['hidden'] != true && starts[entry.key] != null && event['time'] != null) {
      timings.add({
        'name': test['name'],
        'suite': suites[test['suiteID']],
        'milliseconds': (event['time'] as num) - starts[entry.key]!,
      });
    }
  }
  timings.sort((a, b) => (b['milliseconds'] as num).compareTo(a['milliseconds'] as num));
  return {...counts, 'failures': failures, 'slowest_instrumented_tests': timings.take(10).toList()};
}

String _csv(Object? value) => '"${value.toString().replaceAll('"', '""')}"';

Map<String, dynamic> summarize(Directory run, Directory root) {
  final manifest = jsonDecode(File(p.join(run.path, 'manifest.json')).readAsStringSync()) as Map<String, dynamic>;
  final (currentInventory, currentExcluded) = inventory(root);
  final sources = (manifest['inventory'] as Map<String, dynamic>?) ?? currentInventory;
  final excluded = manifest['excluded_generated'] ?? currentExcluded;
  final groups = <String, CoverageRecords>{};
  for (final package in (manifest['packages'] as List).cast<String>()) {
    final file = File(p.join(run.path, package, 'lcov.info'));
    if (file.existsSync()) {
      groups[package] = Map.fromEntries(readLcov(file, root, package).entries.where((e) => sources.containsKey(e.key)));
    }
  }
  final merged = mergeRecords(groups.values);
  final files = <Map<String, dynamic>>[];
  for (final entry in sources.entries) {
    final record = merged[entry.key] ?? emptyRecord();
    final lines = record['lines']!.keys.map(int.parse).toList()..sort();
    files.add({
      'path': entry.key,
      ...(entry.value as Map<String, dynamic>),
      ...metrics(record),
      'status': record['lines']!.isEmpty ? 'not_measured' : 'measured',
      'uncovered_lines': lines.where((line) => record['lines']!['$line'] == 0).toList(),
      'hit_by': [
        for (final group in groups.entries)
          if (group.value[entry.key]?['lines']?.values.any((n) => n > 0) ?? false) group.key,
      ],
    });
  }
  final current = sourceSnapshot(root)['files'] as Map<String, dynamic>;
  final saved = manifest['snapshot']['files'] as Map<String, dynamic>;
  final changed = {...saved.keys, ...current.keys}.where((key) => saved[key] != current[key]).toList()..sort();
  final complete = manifest['status'] == 'finished' && groups.length == (manifest['packages'] as List).length;
  final results = (manifest['results'] as Map<String, dynamic>?) ?? {};
  final passed =
      complete &&
      changed.isEmpty &&
      results.values.every((result) => (result as Map).values.every((step) => (step as Map)['exit_code'] == 0));
  final summary = <String, dynamic>{
    'schema_version': 1,
    'reporter_sha256': coverageImplementationSha256(),
    'manifest': 'manifest.json',
    'run_status': manifest['status'],
    'checks_passed': passed,
    'source_changed': changed,
    'excluded_generated': excluded,
    'files': files,
    'packages': <String, dynamic>{},
    'suite_matrix': <String, dynamic>{},
    'suite_overlap': overlap(groups),
    'tests': {
      for (final package in (manifest['packages'] as List).cast<String>())
        package: testResults(File(p.join(run.path, package, 'tests.jsonl'))),
    },
    'limits': [
      'Percentages describe only executable lines reported by the VM, not every source file.',
      'Missing files have unknown executable-line denominators; see not_measured.',
      'Line hits and overlap do not measure assertion quality or prove redundancy.',
      'No browser, device, native integration or shader coverage is claimed.',
      'Flutter LCOV is original collector output; Flutter does not retain raw coverage JSON here.',
    ],
  };
  for (final package in coveragePackages.keys) {
    bool belongs(String name) => sources[name]['package'] == package;
    final own = Map<String, CoverageRecord>.fromEntries((groups[package] ?? {}).entries.where((e) => belongs(e.key)));
    final union = Map<String, CoverageRecord>.fromEntries(merged.entries.where((e) => belongs(e.key)));
    summary['packages'][package] = {
      'own_suite': totals(own),
      'all_suites': totals(union),
      'source_files': sources.values.where((info) => info['package'] == package).length,
      'not_measured': files
          .where((f) => f['package'] == package && f['status'] == 'not_measured')
          .map((f) => f['path'])
          .toList(),
    };
  }
  for (final group in groups.entries) {
    summary['suite_matrix'][group.key] = {
      for (final package in coveragePackages.keys)
        package: totals(Map.fromEntries(group.value.entries.where((e) => sources[e.key]['package'] == package))),
    };
  }
  writeCoverageJson(File(p.join(run.path, 'summary.json')), summary);
  writeCoverageJson(File(p.join(run.path, 'test-index.json')), manifest['test_index'] ?? testIndex(root));
  writeLcov(File(p.join(run.path, 'union.lcov.info')), merged);
  const fields = [
    'path',
    'status',
    'source_lines',
    'lines_found',
    'lines_hit',
    'branches_found',
    'branches_hit',
    'functions_found',
    'functions_hit',
    'uncovered_lines',
    'hit_by',
  ];
  final csv = StringBuffer('${fields.join(',')}\r\n');
  for (final f in files) {
    csv.writeln(fields.map((field) => _csv(f[field] is List ? (f[field] as List).join(' ') : f[field])).join(','));
  }
  File(p.join(run.path, 'files.csv')).writeAsStringSync(csv.toString());
  const escape = HtmlEscape();
  final rows = files
      .map(
        (f) =>
            '<tr><td>${escape.convert(f['path'] as String)}</td><td>${f['status']}</td><td>${f['lines_hit']}/${f['lines_found']}</td><td>${f['branches_hit']}/${f['branches_found']}</td><td>${(f['uncovered_lines'] as List).join(', ')}</td></tr>',
      )
      .join();
  File(p.join(run.path, 'index.html')).writeAsStringSync(
    '<!doctype html><meta charset=utf-8><title>Local VM coverage</title>'
    '<style>body{font:14px sans-serif;margin:24px}table{border-collapse:collapse}td,th{border:1px solid #ccc;padding:8px;vertical-align:top}td:last-child{max-width:500px;overflow-wrap:anywhere}</style>'
    '<h1>Local VM coverage</h1><p>Measured executable lines only. Missing files are listed separately. Line hits do not prove assertions. See summary.json and manifest.json for provenance and limits.</p>'
    '${changed.isNotEmpty ? '<p>WARNING: source inputs changed; do not treat this run as a consistent baseline.</p>' : ''}'
    '${!passed ? '<p>WARNING: this run is incomplete or has failed checks. See manifest.json.</p>' : ''}'
    '<table><tr><th>Source</th><th>Status</th><th>Lines</th><th>Branches</th><th>Uncovered lines</th></tr>$rows</table>',
  );
  return summary;
}

void requirePackageConfigs(Directory root, List<String> packages) {
  for (final package in packages) {
    final file = File(p.join(root.path, package, '.dart_tool/package_config.json'));
    final config = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
    if (package == 'backend') {
      final entries = (config['packages'] as List).where((entry) => entry['name'] == 'coverage');
      if (entries.isEmpty) {
        throw StateError('coverage must already be resolved in backend; no dependency installation is performed');
      }
      final uri = file.uri.resolve('${entries.first['rootUri'].toString().replaceFirst(_trailingSlashes, '')}/');
      if (!File.fromUri(uri.resolve('bin/test_with_coverage.dart')).existsSync()) {
        throw StateError('resolved coverage package is unavailable; prepare dependencies separately');
      }
    }
  }
}

final _trailingSlashes = RegExp(r'/+$');

void copyCoverageDirectory(Directory source, Directory target) {
  target.createSync(recursive: true);
  for (final entity in source.listSync(followLinks: false)) {
    final path = p.join(target.path, p.basename(entity.path));
    if (entity is Directory) copyCoverageDirectory(entity, Directory(path));
    if (entity is File) entity.copySync(path);
    if (entity is Link) throw FileSystemException('Coverage inputs must not contain symlinks', entity.path);
  }
}

Map<String, dynamic> mergeRuns(List<Directory> runs, Directory output, Directory root) {
  final manifests = runs
      .map((run) => jsonDecode(File(p.join(run.path, 'manifest.json')).readAsStringSync()) as Map<String, dynamic>)
      .toList();
  if (manifests.map((m) => m['snapshot']['sha256']).toSet().length != 1) {
    throw ArgumentError('Cannot merge different source snapshots');
  }
  if (manifests.any((m) => m['status'] != 'finished')) throw ArgumentError('Cannot merge incomplete runs');
  if (manifests.any((m) => jsonEncode(m['tests'] ?? ['test']) != '["test"]')) {
    throw ArgumentError('merge accepts full-suite reruns only; use compare for selected tests');
  }
  if (runs.any(
    (run) => p.equals(run.absolute.path, output.absolute.path) || p.isWithin(run.absolute.path, output.absolute.path),
  )) {
    throw ArgumentError('Output must be outside every input run');
  }
  if (output.existsSync()) throw FileSystemException('Output already exists', output.path);
  output.createSync(recursive: true);
  final manifest = <String, dynamic>{
    ...manifests.last,
    'packages': <String>[],
    'results': <String, dynamic>{},
    'input_runs': runs.map((run) => run.absolute.path).toList(),
  };
  for (var i = 0; i < runs.length; i++) {
    for (final package in (manifests[i]['packages'] as List).cast<String>()) {
      final target = Directory(p.join(output.path, package));
      if (target.existsSync()) target.deleteSync(recursive: true);
      copyCoverageDirectory(Directory(p.join(runs[i].path, package)), target);
      if (!(manifest['packages'] as List).contains(package)) (manifest['packages'] as List).add(package);
      manifest['results'][package] = manifests[i]['results'][package];
    }
  }
  if (!manifest.containsKey('inventory')) {
    final (sources, excluded) = inventory(root);
    manifest['inventory'] = sources;
    manifest['excluded_generated'] = excluded;
    manifest['test_index'] = testIndex(root);
  }
  writeCoverageJson(File(p.join(output.path, 'manifest.json')), manifest);
  return summarize(output, root);
}
