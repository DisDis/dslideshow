import 'dart:io';
import 'dart:math' as math;

import 'package:path/path.dart' as p;

import 'json_io.dart';

final _nativeError = RegExp(
  r'\[(?:ERROR|FATAL)[:\]]|(?:^|\s)(?:ERROR|FATAL):|\b(?:SIGSEGV|SIGABRT|segmentation fault|core dumped)\b',
  caseSensitive: false,
);
final _decimal = RegExp(r'^[0-9]+$');
const _displayFields = ['physical_width', 'physical_height', 'logical_width', 'logical_height', 'pixel_ratio'];
const _hardwareText = ['model', 'kernel', 'os'];
const _hardwareInt = ['processors', 'clock_ticks_per_second'];

Map<String, dynamic> distribution(Iterable<num> values) {
  final ordered = values.toList()..sort();
  num? percentile(double fraction) {
    if (ordered.isEmpty) return null;
    final index = (ordered.length - 1) * fraction;
    return ordered[index.floor()] + (ordered[index.ceil()] - ordered[index.floor()]) * (index - index.floor());
  }

  return {
    'count': ordered.length,
    'p50': percentile(.5),
    'p95': percentile(.95),
    'p99': percentile(.99),
    'max': ordered.isEmpty ? null : ordered.last,
  };
}

Map<String, (bool, dynamic)> conditions(Map<String, dynamic> metadata, Map<String, dynamic> launch, String renderer) {
  final display = asMap(metadata['display']), build = asMap(metadata['build']), hardware = asMap(metadata['hardware']);
  final flutter = asMap(build['flutter']);
  final modes = {'runtime': metadata['build_mode'], 'artifact': build['mode']};
  final identity = <String, dynamic>{
    for (final key in [..._hardwareText, ..._hardwareInt]) key: hardware[key],
    'build_cpu': build['cpu'],
    'cpu_governors': hardware['cpu_governors'],
  };
  bool text(dynamic value) => value is String && value.isNotEmpty;
  final governors = asMap(identity['cpu_governors']);
  final validHardware =
      text(identity['build_cpu']) &&
      _hardwareText.every((key) => text(identity[key])) &&
      _hardwareInt.every((key) => integer(identity[key], positive: true)) &&
      governors.isNotEmpty &&
      governors.entries.every((e) => text(e.key) && text(e.value));
  final media = asList(metadata['media']);
  var validMedia = media.isNotEmpty;
  final identities = <Map<String, dynamic>>[];
  for (final value in media) {
    if (value is! Map) {
      validMedia = false;
      continue;
    }
    final item = {
      for (final key in ['name', 'sha256', 'width', 'height']) key: value[key],
    };
    identities.add(item);
    validMedia =
        validMedia &&
        text(item['name']) &&
        text(item['sha256']) &&
        numeric(item['width'], positive: true) &&
        numeric(item['height'], positive: true);
  }
  validMedia = validMedia && identities.map((e) => e['name']).toSet().length == identities.length;
  identities.sort((a, b) => a['name'].toString().compareTo(b['name'].toString()));
  return {
    'requested_renderer': (metadata['requested_renderer'] == renderer, metadata['requested_renderer']),
    'target_display_matches': (metadata['target_display_matches'] == true, metadata['target_display_matches']),
    'config': (metadata['config'] is Map && asMap(metadata['config']).isNotEmpty, metadata['config']),
    'display': (
      _displayFields.every((key) => numeric(display[key], positive: true)),
      {for (final key in _displayFields) key: display[key]},
    ),
    'refresh_hz': (numeric(display['refresh_hz'], positive: true), display['refresh_hz']),
    'release_mode': (modes.values.every((e) => e == 'release'), modes),
    'hardware_identity': (validHardware, identity),
    'flutter_sdk_engine': (
      metadata['build'] is Map &&
          [
            'frameworkVersion',
            'frameworkRevision',
            'engineRevision',
            'dartSdkVersion',
          ].every((key) => text(flutter[key])),
      build['flutter'],
    ),
    'media': (validMedia, identities),
    'flutter_pi_sha256': (text(launch['flutter_pi_sha256']), launch['flutter_pi_sha256']),
  };
}

List<Map<String, dynamic>> compareConditions(
  Map<String, (bool, dynamic)> a,
  Map<String, (bool, dynamic)> b,
  String scope,
) => [
  for (final key in a.keys)
    (() {
      final (validA, valueA) = a[key]!;
      final (validB, valueB) = b[key]!;
      final equal = key == 'refresh_hz' && validA && validB
          ? ((valueA as num) - (valueB as num)).abs() <= .01 + 1e-12
          : canonical(valueA) == canonical(valueB);
      final passed = validA && validB && equal;
      return <String, dynamic>{
        'scope': scope,
        'condition': key,
        'passed': passed,
        'baseline': valueA,
        'candidate': valueB,
        'reason': passed
            ? null
            : !validA || !validB
            ? 'missing/invalid condition'
            : 'condition differs',
      };
    })(),
];

bool _warmup(dynamic repeat, dynamic warmups) =>
    repeat is int && integer(warmups) && repeat >= -(warmups as int) && repeat < 0;
(String, int, int)? _identity(Map<String, dynamic> row, dynamic warmups) {
  final caseId = row['case_id'], cycle = row['cycle'], repeat = row['repeat'];
  final valid = row['phase'] == 'warmup' ? cycle == 0 && _warmup(repeat, warmups) : integer(repeat);
  return caseId is String && caseId.isNotEmpty && integer(cycle) && valid
      ? (caseId, cycle as int, repeat as int)
      : null;
}

String? _stageCase(dynamic stage, dynamic warmups) {
  if (stage is! String) return null;
  final first = stage.indexOf(':');
  if (first < 0) return null;
  final phase = stage.substring(0, first), rest = stage.substring(first + 1);
  if (!['prepare', 'warmup', 'measured', 'capture', 'cleanup'].contains(phase)) return null;
  if (phase != 'warmup' && phase != 'measured') return rest;
  final last = rest.lastIndexOf(':');
  if (last <= 0) return null;
  final repeat = rest.substring(last + 1);
  if (phase == 'measured') return _decimal.hasMatch(repeat) ? rest.substring(0, last) : null;
  return repeat.startsWith('-') && _decimal.hasMatch(repeat.substring(1)) && _warmup(int.tryParse(repeat), warmups)
      ? rest.substring(0, last)
      : null;
}

Map<String, dynamic> _memory(List<(String, Map<String, dynamic>)> samples) {
  final rss = <num>[], available = <num>[];
  final byAttempt = <String, List<num>>{};
  for (final (attempt, row) in samples) {
    byAttempt.putIfAbsent(attempt, () => []);
    if (numeric(row['rss_bytes'])) rss.add(row['rss_bytes'] as num);
    if (numeric(row['available_memory_bytes'])) available.add(row['available_memory_bytes'] as num);
    if (numeric(row['swap_free_bytes'])) byAttempt[attempt]!.add(row['swap_free_bytes'] as num);
  }
  final spans = <Map<String, dynamic>>[
    for (final entry in byAttempt.entries)
      {
        'attempt': entry.key,
        'samples': entry.value.length,
        'first_free_bytes': entry.value.firstOrNull,
        'last_free_bytes': entry.value.lastOrNull,
        'free_delta_bytes': entry.value.length >= 2 ? entry.value.last - entry.value.first : null,
      },
  ];
  return {
    'samples': samples.length,
    'rss_peak_sampled_bytes': rss.isEmpty ? null : rss.reduce(math.max),
    'available_memory_min_bytes': available.isEmpty ? null : available.reduce(math.min),
    'swap_free_delta_bytes': spans.isNotEmpty && spans.every((e) => e['free_delta_bytes'] != null)
        ? spans.fold<num>(0, (sum, e) => sum + (e['free_delta_bytes'] as num))
        : null,
    'swap_spans': spans,
    'scope': 'All case-tagged prepare/warmup/measured/capture/cleanup telemetry; RSS is sampled process memory. MemAvailable/SwapFree are system-wide, not GPU memory. SwapFree delta is last minus first per process attempt, not swap I/O or causal attribution.',
  };
}

(Map<String, dynamic>, Map<String, (bool, dynamic)>?) loadCollection(String collection, {String renderer = 'opengl'}) {
  final root = Directory(collection).absolute;
  final directory = Directory(p.join(root.path, renderer));
  final diagnostics = <String>[],
      errors = <Map<String, dynamic>>[],
      attempts = <Map<String, dynamic>>[],
      checks = <Map<String, dynamic>>[];
  final descriptors = <String, Map<String, dynamic>>{}, planned = <String>{};
  final samples = <String, List<(String, Map<String, dynamic>)>>{},
      warmupSamples = <String, List<(String, Map<String, dynamic>)>>{},
      telemetry = <String, List<(String, Map<String, dynamic>)>>{};
  final frames = <(String, String, int, int), List<Map<String, dynamic>>>{},
      warmupFrames = <(String, String, int, int), List<Map<String, dynamic>>>{};
  final state = readJson(File(p.join(directory.path, 'renderer-status.json')), diagnostics, required: false);
  var paths = directory.existsSync()
      ? directory.listSync().whereType<Directory>().where((d) => p.basename(d.path).startsWith('attempt-')).toList()
      : <Directory>[];
  paths.sort((a, b) => a.path.compareTo(b.path));
  if (paths.isEmpty && directory.existsSync()) paths = [directory];
  if (paths.isEmpty) diagnostics.add('${directory.path}: no renderer attempts found');
  List<dynamic> array(dynamic value, String source) {
    if (value == null) return [];
    if (value is! List) {
      diagnostics.add('$source: expected a JSON array');
      return [];
    }
    return value;
  }

  void register(dynamic descriptor, String source, {bool isPlanned = false}) {
    final row = asMap(descriptor), id = row['id'];
    if (descriptor is! Map || id is! String || id.isEmpty) {
      diagnostics.add('$source: invalid case descriptor');
      return;
    }
    if (isPlanned) planned.add(id);
    if (descriptors.containsKey(id) && canonical(descriptors[id]) != canonical(row)) {
      diagnostics.add('$source: inconsistent descriptor for $id');
    } else {
      descriptors[id] = row;
    }
  }

  for (final row in array(state['plan'], 'renderer-status plan')) {
    register(row, 'renderer-status plan', isPlanned: true);
  }
  Map<String, (bool, dynamic)>? reference;
  for (final path in paths) {
    final name = p.basename(path.path);
    final summary = readJson(File(p.join(path.path, 'summary.json')), diagnostics);
    var metadata = asMap(summary['metadata']);
    if (truth(summary['metadata']) && summary['metadata'] is! Map) {
      diagnostics.add('${path.path}/summary.json: invalid metadata');
    }
    final launch = readJson(File(p.join(path.path, 'launch.json')), diagnostics),
        status = readJson(File(p.join(path.path, 'launcher-status.json')), diagnostics);
    final condition = conditions(metadata, launch, renderer);
    final warmups = asMap(metadata['config'])['warmups'];
    if (!integer(warmups)) diagnostics.add('$name: missing/invalid expected warmups');
    checks.addAll(compareConditions(reference ?? condition, condition, name));
    reference ??= condition;
    attempts.add({
      'path': name,
      'metadata': metadata,
      'launch': launch,
      'status': summary['status'],
      'launcher_status': status,
    });
    for (final descriptor in array(metadata['plan'], '$name metadata plan')) {
      register(descriptor, '$name metadata plan', isPlanned: true);
    }
    if (summary['status'] != 'completed') {
      errors.add({'attempt': name, 'kind': 'collection_status', 'status': summary['status']});
    }
    if (status['exit_code'] != 0) {
      errors.add({'attempt': name, 'kind': 'launcher_exit', 'exit_code': status['exit_code']});
    }
    for (final key in ['runtime_errors', 'cleanup_errors']) {
      if (metadata[key] != null && metadata[key] != 0) {
        errors.add({'attempt': name, 'kind': key, 'count': metadata[key]});
      }
    }
    for (final key in ['error_events', 'failed_runs', 'unsupported_cases']) {
      if (summary[key] != null && summary[key] != 0) errors.add({'attempt': name, 'kind': key, 'count': summary[key]});
    }
    if (truth(summary['error_counts'])) {
      errors.add({'attempt': name, 'kind': 'error_counts', 'counts': summary['error_counts']});
    }
    for (final event in readJsonLines(File(p.join(path.path, 'errors.jsonl')), diagnostics)) {
      errors.add({...event, 'attempt': name});
    }
    final warmupKeys = <(String, int, int)>{};
    for (final row in readJsonLines(File(p.join(path.path, 'runs.jsonl')), diagnostics)) {
      if (row['phase'] != 'measured' &&
          (row['phase'] != 'warmup' || row['status'] != 'passed' || truth(row['error']))) {
        errors.add({'attempt': name, 'kind': 'non_measured_run', 'run': row});
      }
      final key = _identity(row, warmups);
      if (key == null) {
        diagnostics.add('$name/runs.jsonl: invalid case/cycle/repeat identity');
        continue;
      }
      if (truth(row['case'])) register(row['case'], '$name run $key');
      if (row['phase'] == 'measured') (samples[key.$1] ??= []).add((name, row));
      if (row['phase'] == 'warmup') {
        (warmupSamples[key.$1] ??= []).add((name, row));
        if (!warmupKeys.add(key)) diagnostics.add('$name/runs.jsonl: duplicate warmup identity $key');
      }
    }
    for (final row in readJsonLines(File(p.join(path.path, 'frames.jsonl')), diagnostics)) {
      final phase = row['phase'], key = _identity(row, warmups);
      if (phase != 'measured' && phase != 'warmup') {
        diagnostics.add('$name/frames.jsonl: unknown frame phase $phase');
        continue;
      }
      if (key == null) {
        diagnostics.add('$name/frames.jsonl: invalid case/cycle/repeat identity');
        continue;
      }
      final map = phase == 'measured' ? frames : warmupFrames;
      (map[(name, key.$1, key.$2, key.$3)] ??= []).add(row);
    }
    for (final row in readJsonLines(File(p.join(path.path, 'telemetry.jsonl')), diagnostics)) {
      final id = _stageCase(row['stage'], warmups);
      if (id != null) (telemetry[id] ??= []).add((name, row));
    }
    final native = File(p.join(path.path, 'native.log'));
    try {
      var number = 0;
      for (final line in native.readAsLinesSync()) {
        number++;
        if (!line.startsWith('BENCHMARK') && _nativeError.hasMatch(line)) {
          errors.add({'attempt': name, 'kind': 'native_log', 'line': number, 'error': line});
        }
      }
    } on FileSystemException {
      diagnostics.add('${native.path}: required native log unavailable');
    }
  }
  for (final attempt in array(state['attempts'], 'renderer-status attempts')) {
    if (attempt is! Map) {
      diagnostics.add('renderer-status attempts: invalid attempt object');
      continue;
    }
    if (truth(attempt['native_failure'])) errors.add({'kind': 'native_failure', ...asMap(attempt)});
  }
  final metadata = attempts.isEmpty ? <String, dynamic>{} : asMap(attempts.first['metadata']);
  if (planned.isEmpty) diagnostics.add('missing/empty expected case plan; observed runs cannot establish coverage');
  for (final id in samples.keys.toSet().difference(planned)) {
    diagnostics.add('measured case $id has no plan descriptor');
  }
  for (final id in warmupSamples.keys.toSet().difference(planned)) {
    diagnostics.add('warmup case $id has no plan descriptor');
  }
  final ids = <String>{
    ...planned,
    ...samples.keys,
    ...warmupSamples.keys,
    ...frames.keys.map((e) => e.$2),
    ...warmupFrames.keys.map((e) => e.$2),
  }.toList()..sort();
  final config = asMap(metadata['config']),
      repeats = config['repeats'],
      cycles = metadata['cycles'] ?? 1,
      warmups = config['warmups'];
  Set<(int, int)>? expected;
  if (!integer(repeats, positive: true) || !integer(cycles, positive: true)) {
    diagnostics.add('missing/invalid expected repeats or cycles');
  } else {
    expected = {
      for (var cycle = 0; cycle < (cycles as int); cycle++)
        for (var repeat = 0; repeat < (repeats as int); repeat++) (cycle, repeat),
    };
  }
  final expectedWarmups = integer(warmups)
      ? {for (var repeat = -(warmups as int); repeat < 0; repeat++) (0, repeat)}
      : null;
  final cases = <String, dynamic>{};
  for (final id in ids) {
    final runs = samples[id] ?? [], warms = warmupSamples[id] ?? [];
    final issues = <String>[],
        fps = <num>[],
        builds = <num>[],
        rasters = <num>[],
        records = <Map<String, dynamic>>[],
        warmRecords = <Map<String, dynamic>>[];
    final identities = <(int, int), int>{},
        warmIdentities = <(int, int), int>{},
        pooled = <(String, String, int, int)>{};
    var passed = 0;
    for (final (attempt, run) in warms) {
      final pair = (run['cycle'] as int, run['repeat'] as int),
          key = (attempt, id, run['cycle'] as int, run['repeat'] as int);
      warmIdentities.update(pair, (v) => v + 1, ifAbsent: () => 1);
      final raw = warmupFrames[key] ?? [];
      warmRecords.add({
        'attempt': attempt,
        'cycle': pair.$1,
        'repeat': pair.$2,
        'status': run['status'],
        'error': run['error'],
        'reported_frames': run['frames'],
        'raw_frames': raw.length,
      });
      if (run['status'] != 'passed' || truth(run['error'])) issues.add('$attempt warmup: failed/error');
      if (!integer(run['frames'], positive: true) || run['frames'] != raw.length) {
        issues.add('$attempt warmup: raw/reported warmup frame count differs or is missing');
      }
    }
    List<List<int>>? missing(Set<(int, int)>? expected, Map<(int, int), int> observed) {
      if (expected == null) return null;
      final rows = expected.difference(observed.keys.toSet()).toList()
        ..sort((a, b) => a.$1 != b.$1 ? a.$1.compareTo(b.$1) : a.$2.compareTo(b.$2));
      return [
        for (final e in rows) [e.$1, e.$2],
      ];
    }

    List<List<int>> duplicate(Map<(int, int), int> map) => [
      for (final entry in map.entries)
        if (entry.value != 1) [entry.key.$1, entry.key.$2],
    ];
    final missingWarm = missing(expectedWarmups, warmIdentities), duplicateWarm = duplicate(warmIdentities);
    if (missingWarm != null && missingWarm.isNotEmpty) issues.add('missing warmup repetitions: $missingWarm');
    if (duplicateWarm.isNotEmpty) issues.add('duplicate warmup repetitions: $duplicateWarm');
    final knownWarm = {for (final (attempt, row) in warms) (attempt, id, row['cycle'] as int, row['repeat'] as int)};
    final orphanWarm = warmupFrames.entries
        .where((e) => e.key.$2 == id && !knownWarm.contains(e.key))
        .fold<int>(0, (n, e) => n + e.value.length);
    if (orphanWarm > 0) issues.add('$orphanWarm raw frames have no warmup run');
    for (final (attempt, run) in runs) {
      final pair = (run['cycle'] as int, run['repeat'] as int),
          key = (attempt, id, run['cycle'] as int, run['repeat'] as int);
      identities.update(pair, (v) => v + 1, ifAbsent: () => 1);
      final raw = frames[key] ?? [];
      records.add({
        'attempt': attempt,
        'cycle': pair.$1,
        'repeat': pair.$2,
        'status': run['status'],
        'sampled_fps': run['sampled_fps'],
        'reported_frames': run['frames'],
        'raw_frames': raw.length,
        'error': run['error'],
      });
      if (run['status'] != 'passed') {
        issues.add('$attempt measured run failed');
        continue;
      }
      if (truth(run['error'])) issues.add('$attempt passed run contains error');
      passed++;
      if (numeric(run['sampled_fps'], positive: true)) {
        fps.add(run['sampled_fps'] as num);
      } else {
        issues.add('$attempt invalid/missing FPS');
      }
      if (!integer(run['frames'], positive: true) || run['frames'] != raw.length) {
        issues.add('$attempt raw/reported frame count differs or is missing');
      }
      if (!pooled.add(key)) continue;
      final vsyncs = <int>{};
      for (final frame in raw) {
        final vsync = frame['vsync_us'];
        if (!integer(vsync) || vsyncs.contains(vsync)) issues.add('$attempt invalid/duplicate frame timestamp');
        if (integer(vsync)) vsyncs.add(vsync as int);
        if (numeric(frame['build_us']) && numeric(frame['raster_us'])) {
          builds.add((frame['build_us'] as num) / 1000);
          rasters.add((frame['raster_us'] as num) / 1000);
        } else {
          issues.add('$attempt invalid frame timing');
        }
      }
    }
    final missed = missing(expected, identities), duplicates = duplicate(identities);
    final extra = expected == null ? <(int, int)>[] : identities.keys.toSet().difference(expected).toList();
    if (missed != null && missed.isNotEmpty) issues.add('missing measured repetitions: $missed');
    if (extra.isNotEmpty) issues.add('unexpected measured repetitions: $extra');
    if (duplicates.isNotEmpty) issues.add('duplicate measured repetitions: $duplicates');
    final known = {for (final (attempt, row) in runs) (attempt, id, row['cycle'] as int, row['repeat'] as int)};
    final orphan = frames.entries
        .where((e) => e.key.$2 == id && !known.contains(e.key))
        .fold<int>(0, (n, e) => n + e.value.length);
    if (orphan > 0) issues.add('$orphan raw frames have no measured run');
    fps.sort();
    final median = fps.isEmpty
        ? null
        : fps.length.isOdd
        ? fps[fps.length ~/ 2]
        : (fps[fps.length ~/ 2 - 1] + fps[fps.length ~/ 2]) / 2;
    cases[id] = {
      'descriptor': descriptors[id],
      'expected_runs': expected?.length,
      'observed_runs': runs.length,
      'passed_runs': passed,
      'failed_runs': runs.length - passed,
      'expected_warmup_runs': expectedWarmups?.length,
      'observed_warmup_runs': warms.length,
      'passed_warmup_runs': warms.where((e) => e.$2['status'] == 'passed' && !truth(e.$2['error'])).length,
      'missing_warmup_repetitions': missingWarm,
      'duplicate_warmup_repetitions': duplicateWarm,
      'warmups': warmRecords,
      'missing_repetitions': missed,
      'duplicate_repetitions': duplicates,
      'runs': records,
      'fps_median': median,
      'ui_ms': distribution(builds),
      'raster_ms': distribution(rasters),
      'memory': _memory(telemetry[id] ?? []),
      'issues': issues,
      'complete': expected != null && expectedWarmups != null && runs.isNotEmpty && issues.isEmpty,
    };
  }
  return (
    {
      'collection': root.path,
      'renderer': renderer,
      'metadata': metadata,
      'attempts': attempts,
      'renderer_state': state,
      'diagnostics': diagnostics,
      'errors': errors,
      'conditions': checks,
      'cases': cases,
    },
    reference,
  );
}

Map<String, dynamic> comparePerformance(String baselinePath, String candidatePath, {String renderer = 'opengl'}) {
  final (baseline, aConditions) = loadCollection(baselinePath, renderer: renderer);
  final (candidate, bConditions) = loadCollection(candidatePath, renderer: renderer);
  final checks = [...asList(baseline['conditions']), ...asList(candidate['conditions'])];
  if (aConditions != null && bConditions != null) {
    checks.addAll(compareConditions(aConditions, bConditions, 'baseline vs candidate'));
  }
  final matching =
      checks.isNotEmpty && aConditions != null && bConditions != null && checks.every((e) => e['passed'] == true);
  final aCases = asMap(baseline['cases']), bCases = asMap(candidate['cases']);
  final ids = {...aCases.keys, ...bCases.keys}.toList()..sort();
  final rows = <Map<String, dynamic>>[];
  for (final id in ids) {
    final a = asMap(aCases[id]), b = asMap(bCases[id]);
    final same =
        a.isNotEmpty &&
        b.isNotEmpty &&
        truth(a['descriptor']) &&
        truth(b['descriptor']) &&
        canonical(a['descriptor']) == canonical(b['descriptor']);
    final issues = <String>[];
    if (a.isEmpty || b.isEmpty) issues.add('case is missing from one collection');
    if (!same) issues.add('case descriptors differ or are missing');
    if (a.isNotEmpty && b.isNotEmpty && a['expected_runs'] != b['expected_runs']) {
      issues.add('expected repetition/cycle counts differ');
    }
    final valid =
        matching &&
        same &&
        a['complete'] == true &&
        b['complete'] == true &&
        a['expected_runs'] == b['expected_runs'] &&
        asList(baseline['diagnostics']).isEmpty &&
        asList(candidate['diagnostics']).isEmpty &&
        asList(baseline['errors']).isEmpty &&
        asList(candidate['errors']).isEmpty;
    final changes = <String, dynamic>{};
    if (valid) {
      changes['fps_percent'] = ((b['fps_median'] as num) / (a['fps_median'] as num) - 1) * 100;
      for (final metric in ['ui_ms', 'raster_ms']) {
        changes[metric] = {
          for (final key in ['p50', 'p95', 'p99', 'max']) key: (b[metric][key] as num) - (a[metric][key] as num),
        };
      }
    }
    rows.add({
      'id': id,
      'baseline': aCases[id],
      'candidate': bCases[id],
      'descriptors_match': same,
      'comparison_issues': issues,
      'comparison_eligible': valid,
      'changes': changes,
    });
  }
  return {
    'schema_version': 1,
    'renderer': renderer,
    'baseline': baseline,
    'candidate': candidate,
    'conditions': checks,
    'performance_comparable': matching,
    'cases': rows,
    'comparison_ready': rows.isNotEmpty && rows.every((e) => e['comparison_eligible'] == true),
    'acceptance': 'not_assessed',
    'notes': [
      "FPS is the median of passed measured repetitions, not display scanout.",
      "UI/raster distributions pool raw frames from passed measured runs; failed and missing runs stay explicit.",
      "Warmups use negative repeat IDs -config.warmups..-1 in cycle zero; their frames are excluded from measured FPS/tails, while their case-tagged telemetry remains in memory samples.",
      "Every expected warmup must be present once with matching reported/raw frame counts; missing, duplicate, failed and orphan warmup data prevent comparison eligibility.",
      "Hardware identity compares build CPU, model, kernel, OS, processor count, clock ticks and governor policies; dynamic clock/temperature/throttle readings are retained separately. This metadata has no board serial.",
      "comparison_ready checks report consistency only; manual validation of the benchmark harness and intended live-view multiplicity is required before accepting performance results.",
      "Historical timings from the shared-GlobalKey harness are invalid for repeated media views and cannot support acceptance, even when stored conditions match.",
      "A clean performance comparison does not establish visual quality or hardware acceptance.",
    ],
  };
}

String renderComparison(Map<String, dynamic> result) {
  String number(dynamic value) => value is num ? value.toStringAsFixed(2) : '—';
  final lines = <String>[
    '# Effect performance comparison',
    '',
    'Renderer: ${result['renderer']}. Conditions match: ${result['performance_comparable']}. All measurements comparable: ${result['comparison_ready']}. Acceptance: not assessed.',
    '',
    ...asList(result['notes']).cast<String>(),
    '',
    '| Case | Passed / expected B → C | FPS median B → C | FPS change, % | Raster pooled p95 B → C, ms | Eligible |',
    '| --- | --- | --- | --- | --- | --- |',
  ];
  for (final row in asList(result['cases'])) {
    final a = asMap(row['baseline']), b = asMap(row['candidate']);
    final label = row['id'].toString().replaceAll('|', r'\|').replaceAll('\n', ' ');
    lines.add(
      '| $label | ${a['passed_runs']}/${a['expected_runs']} → ${b['passed_runs']}/${b['expected_runs']} | ${number(a['fps_median'])} → ${number(b['fps_median'])} | ${number(row['changes']['fps_percent'])} | ${number(asMap(a['raster_ms'])['p95'])} → ${number(asMap(b['raster_ms'])['p95'])} | ${row['comparison_eligible']} |',
    );
  }
  lines.addAll([
    '',
    'Pooled frame distributions (p50 / p95 / p99 / max, ms):',
    '',
    '| Case | UI baseline | UI candidate | Raster baseline | Raster candidate |',
    '| --- | --- | --- | --- | --- |',
  ]);
  for (final row in asList(result['cases'])) {
    final label = row['id'].toString().replaceAll('|', r'\|').replaceAll('\n', ' '), cells = <String>[];
    for (final metric in ['ui_ms', 'raster_ms']) {
      for (final side in ['baseline', 'candidate']) {
        final values = asMap(asMap(row[side])[metric]);
        cells.add(['p50', 'p95', 'p99', 'max'].map((key) => number(values[key])).join(' / '));
      }
    }
    lines.add('| $label | ${cells.join(' | ')} |');
  }
  lines.addAll([
    '',
    '| Case | Sampled process RSS peak B → C, MiB | System MemAvailable min B → C, MiB | System SwapFree delta B → C, MiB |',
    '| --- | --- | --- | --- |',
  ]);
  for (final row in asList(result['cases'])) {
    final label = row['id'].toString().replaceAll('|', r'\|').replaceAll('\n', ' '), cells = <String>[];
    for (final metric in ['rss_peak_sampled_bytes', 'available_memory_min_bytes', 'swap_free_delta_bytes']) {
      cells.add(
        ['baseline', 'candidate']
            .map((side) {
              final value = asMap(asMap(row[side])['memory'])[metric];
              return number(value is num ? value / 1048576 : null);
            })
            .join(' → '),
      );
    }
    lines.add('| $label | ${cells.join(' | ')} |');
  }
  for (final check in asList(result['conditions'])) {
    if (check['passed'] != true) lines.add('- Condition ${check['scope']} / ${check['condition']}: ${check['reason']}');
  }
  lines.addAll([
    '',
    'Detailed distributions, errors, missing/duplicate runs, telemetry and provenance are in [comparison.json](comparison.json). Missing values remain null/—.',
  ]);
  for (final side in ['baseline', 'candidate']) {
    final report = asMap(result[side]);
    lines.add('- $side: ${report['collection']}');
    for (final value in asList(report['diagnostics'])) {
      lines.add('  - $value');
    }
    for (final value in asList(report['errors'])) {
      lines.add('  - Error: ${canonical(value)}');
    }
    for (final entry in asMap(report['cases']).entries) {
      for (final issue in asList(entry.value['issues'])) {
        lines.add('  - ${entry.key}: $issue');
      }
    }
  }
  return '${lines.join('\n')}\n';
}
