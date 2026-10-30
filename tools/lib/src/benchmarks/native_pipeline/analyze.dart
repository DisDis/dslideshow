import 'dart:io';
import 'dart:math' as math;

import 'package:path/path.dart' as p;

import '../json_io.dart';
import 'binary.dart';
import 'posix.dart' show hashFile;

final _traceLine = RegExp(r'(\d+\.\d+):\s+((?:\w+:)?\w+):\s*(.*)$');
final _field = RegExp(r'([A-Za-z_]\w*)=([^\s,]+)');
final _clock = RegExp(r'\[([^\]]+)\]');
final _clType = RegExp(r'(?:^|,\s*)(RCL|BCL)(?=\s*(?:,|$))');
final _sha = RegExp(r'^[0-9a-f]{64}$');
final _nativeError = RegExp(
  r'\b(?:ERROR|FATAL|SIGSEGV|SIGABRT|segmentation fault|core dumped)\b',
  caseSensitive: false,
);

enum Phase { measured, warmup }

typedef JsonMap = Map<String, dynamic>;
typedef RunIdentity = (String, Phase, int, int);
typedef JobIdentity = (int, int, String);
typedef DrmIdentity = (String, int, String);

List<JsonMap> _rows(dynamic value) => asList(value).map(asMap).toList();
int _int(JsonMap value, String key, [int fallback = 0]) => value[key] is int ? value[key] as int : fallback;
List<(int, int)> _intervals(Iterable<JsonMap> values) => [
  for (final v in values) (_int(v, 'start_ns'), _int(v, 'end_ns')),
];

JsonMap distribution(Iterable<num> samples) {
  final values = samples.toList()..sort();
  num? percentile(double fraction) {
    if (values.isEmpty) return null;
    final index = (values.length - 1) * fraction, lo = index.floor(), hi = index.ceil();
    return values[lo] + (values[hi] - values[lo]) * (index - lo);
  }

  return {
    'count': values.length,
    'p50': percentile(.5),
    'p95': percentile(.95),
    'p99': percentile(.99),
    'max': values.isEmpty ? null : values.last,
  };
}

int unionNs(Iterable<(int, int)> intervals, {int? start, int? end}) {
  final clipped = [
    for (final (a, b) in intervals) (start == null ? a : math.max(a, start), end == null ? b : math.min(b, end)),
  ]..sort((a, b) => a.$1 != b.$1 ? a.$1.compareTo(b.$1) : a.$2.compareTo(b.$2));
  var total = 0;
  (int, int)? previous;
  for (final (a, b) in clipped) {
    if (b <= a) continue;
    if (previous == null || a > previous.$2) {
      if (previous != null) total += previous.$2 - previous.$1;
      previous = (a, b);
    } else {
      previous = (previous.$1, math.max(previous.$2, b));
    }
  }
  return total + (previous == null ? 0 : previous.$2 - previous.$1);
}

int? _intField(Map<String, String> fields, String name) {
  final value = fields[name];
  if (value == null) return null;
  return value.toLowerCase().startsWith('0x') ? int.tryParse(value.substring(2), radix: 16) : int.tryParse(value);
}

JsonMap readTrace(String directory) {
  final diagnostics = <String>[];
  final provenance = readJson(File(p.join(directory, 'trace-provenance.json')), diagnostics);
  final stats = readJson(File(p.join(directory, 'trace-stats.json')), diagnostics);
  final clock = provenance['trace_clock'];
  final clocks = clock is String ? _clock.allMatches(clock).map((m) => m[1]).toList() : <String?>[];
  if (clock != 'mono' && !(clocks.length == 1 && clocks.single == 'mono')) {
    diagnostics.add('trace clock is not verified mono');
  }
  final started = asMap(provenance['started'])['monotonic_ns'], stopped = asMap(provenance['stopped'])['monotonic_ns'];
  if (!integer(started, positive: true) || !integer(stopped, positive: true) || (stopped as int) <= (started as int)) {
    diagnostics.add('trace monotonic recording span missing/invalid');
  }
  if (provenance['schema_version'] != 1 || !['stopped', 'closed'].contains(provenance['status'])) {
    diagnostics.add('trace provenance is not a completed v1 capture');
  }
  if (truth(provenance['error']) || truth(provenance['cleanup_errors'])) {
    diagnostics.add('trace capture/cleanup reports errors');
  }
  if (truth(provenance['missing_required'])) {
    diagnostics.add('trace missing required events: ${provenance['missing_required']}');
  }
  if (stats['schema_version'] != 1 ||
      stats['stats_complete'] != true ||
      stats['loss_detected'] != false ||
      truth(stats['missing_cpus'])) {
    diagnostics.add('trace loss statistics are missing, incomplete or report loss');
  }
  final perCpu = asMap(stats['per_cpu']);
  if (perCpu.isEmpty) {
    diagnostics.add('trace per-CPU loss counters are absent');
  } else {
    for (final cpu in perCpu.entries) {
      final counters = asMap(asMap(cpu.value)['counters']);
      if (['overrun', 'commit_overrun', 'dropped_events'].any((key) => !integer(counters[key]) || counters[key] != 0)) {
        diagnostics.add('trace loss counters incomplete/nonzero: ${cpu.key}');
      }
    }
  }
  final initial = asList(provenance['initial_cpus']);
  if (initial.isEmpty ||
      initial.any((value) => value is! String) ||
      initial.toSet().length != initial.length ||
      initial.length != perCpu.length ||
      initial.any((value) => !perCpu.containsKey(value))) {
    diagnostics.add('trace statistics do not cover exactly the recorded initial CPUs');
  }
  final events = asMap(provenance['events']);
  for (final event in ['v3d/v3d_rcl_irq', 'drm/drm_vblank_event_queued', 'drm/drm_vblank_event_delivered']) {
    final info = asMap(events[event]);
    if (info['available'] != true || info['selected'] != true || !truth(info['format'])) {
      diagnostics.add('RCL correlation event unavailable/unverified: $event');
    }
  }
  if (!['v3d/v3d_submit_cl', 'v3d/v3d_submit_cl_ioctl'].any((event) {
    final info = asMap(events[event]);
    return info['available'] == true && info['selected'] == true && truth(info['format']);
  })) {
    diagnostics.add('RCL submission event unavailable/unverified');
  }
  final submitEvent = asMap(events['v3d/v3d_submit_cl'])['selected'] == true ? 'v3d_submit_cl' : 'v3d_submit_cl_ioctl';
  final submits = <JobIdentity, List<int>>{}, irqs = <JobIdentity, List<int>>{}, drm = <DrmIdentity, List<int>>{};
  final counts = <String, int>{};
  try {
    var number = 0;
    for (final line in File(p.join(directory, 'trace.txt')).readAsLinesSync()) {
      number++;
      if (line.trim().isEmpty || line.trimLeft().startsWith('#')) continue;
      final match = _traceLine.firstMatch(line.trimRight());
      if (match == null) {
        diagnostics.add('trace.txt:$number: unparsed event line');
        continue;
      }
      final name = match[2]!.split(':').last, data = match[3]!;
      final parts = match[1]!.split('.');
      final timestamp = int.parse(parts[0]) * 1000000000 + int.parse(parts[1].padRight(9, '0').substring(0, 9));
      counts.update(name, (value) => value + 1, ifAbsent: () => 1);
      final matches = _field.allMatches(data).toList(), fields = <String, String>{};
      for (final field in matches) {
        fields[field[1]!] = field[2]!;
      }
      if (fields.length != matches.length) {
        diagnostics.add('trace.txt:$number: duplicate event fields');
        continue;
      }
      if (integer(started, positive: true) &&
          integer(stopped, positive: true) &&
          (timestamp < (started as int) || timestamp > (stopped as int))) {
        diagnostics.add('trace.txt:$number: event outside recording clock span');
      }
      if (['v3d_submit_cl', 'v3d_submit_cl_ioctl'].contains(name)) {
        if (name != submitEvent) continue;
        final bare = _clType.allMatches(data).map((m) => m[1]!).toList();
        final kind = fields['type'] ?? (bare.length == 1 ? bare.single : null);
        if (fields.containsKey('type') && bare.isNotEmpty && (bare.length != 1 || bare.single != kind)) {
          diagnostics.add('trace.txt:$number: contradictory CL types');
          continue;
        }
        if (!['RCL', 'BCL'].contains(kind)) {
          diagnostics.add('trace.txt:$number: CL submission has no explicit RCL/BCL type');
          continue;
        }
        final dev = _intField(fields, 'dev'), sequence = _intField(fields, 'seqno');
        if (dev == null || sequence == null || dev < 0 || sequence < 0) {
          diagnostics.add('trace.txt:$number: CL submission lacks dev/seqno');
          continue;
        }
        submits.putIfAbsent((dev, sequence, kind!), () => []).add(timestamp);
      } else if (['v3d_rcl_irq', 'v3d_bcl_irq'].contains(name)) {
        final dev = _intField(fields, 'dev'), sequence = _intField(fields, 'seqno');
        if (dev == null || sequence == null || dev < 0 || sequence < 0) {
          diagnostics.add('trace.txt:$number: CL IRQ lacks dev/seqno');
          continue;
        }
        irqs.putIfAbsent((dev, sequence, name == 'v3d_rcl_irq' ? 'RCL' : 'BCL'), () => []).add(timestamp);
      } else if (['drm_vblank_event_delivered', 'drm_vblank_event_queued'].contains(name)) {
        final file = fields['file'], crtc = _intField(fields, 'crtc');
        if (file == null || crtc == null) {
          diagnostics.add('trace.txt:$number: DRM event lacks file/CRTC');
          continue;
        }
        drm.putIfAbsent((file, crtc, name), () => []).add(timestamp);
      }
    }
  } on Object catch (error) {
    diagnostics.add('$directory/trace.txt: $error');
  }
  final jobs = <JsonMap>[], unmatched = <JsonMap>[];
  final keys = {...submits.keys, ...irqs.keys}.toList()..sort((a, b) => a.toString().compareTo(b.toString()));
  for (final key in keys) {
    if (key.$3 != 'RCL') continue;
    final starts = submits[key] ?? [], ends = irqs[key] ?? [];
    if (starts.length != 1 || ends.length != 1 || ends.single < starts.single) {
      unmatched.add({'dev': key.$1, 'seqno': key.$2, 'type': key.$3, 'submits': starts, 'irqs': ends});
    } else {
      jobs.add({'dev': key.$1, 'seqno': key.$2, 'type': key.$3, 'start_ns': starts.single, 'end_ns': ends.single});
    }
  }
  final nonPairing = diagnostics.toList();
  if (unmatched.isNotEmpty) diagnostics.add('${unmatched.length} unmatched/ambiguous/reversed RCL job identities');
  if (jobs.isEmpty) diagnostics.add('no paired RCL observations; GPU idle/zero coverage cannot be inferred');
  jobs.sort((a, b) => _int(a, 'start_ns').compareTo(_int(b, 'start_ns')));
  return {
    'directory': directory,
    'provenance': provenance,
    'stats': stats,
    'diagnostics': diagnostics,
    'non_pairing_diagnostics': nonPairing,
    'event_counts': counts,
    'jobs': jobs,
    'unmatched': unmatched,
    'drm': drm,
    'start_ns': started,
    'end_ns': stopped,
    'complete': diagnostics.isEmpty,
    'raw_complete': diagnostics.isEmpty,
    'selected_windows_complete': diagnostics.isEmpty,
  };
}

JsonMap scopeTraceToWindows(JsonMap trace, List<JsonMap> windows) {
  final known =
      windows.isNotEmpty &&
      windows.every((w) => w['start_ns'] is int && w['end_ns'] is int && _int(w, 'start_ns') < _int(w, 'end_ns'));
  final earliest = known ? windows.map((w) => _int(w, 'start_ns')).reduce(math.min) : null;
  final unmatched = <JsonMap>[], warnings = <String>[];
  for (final row in _rows(trace['unmatched'])) {
    final submits = asList(row['submits']), irqs = asList(row['irqs']);
    final bounded = earliest != null && submits.isEmpty && irqs.length == 1 && (irqs.single as int) < earliest;
    final reason = bounded
        ? 'single orphan IRQ completed strictly before every warmup/measured FrameTiming window'
        : 'orphan timing is not provably before every warmup/measured window';
    unmatched.add({...row, 'outside_all_windows': bounded, 'scope_reason': reason});
    if (bounded) warnings.add('RCL dev=${row['dev']} seqno=${row['seqno']}: $reason; raw trace remains incomplete');
  }
  final complete =
      asList(trace['jobs']).isNotEmpty &&
      asList(trace['non_pairing_diagnostics']).isEmpty &&
      unmatched.every((record) => record['outside_all_windows'] == true);
  return {
    ...trace,
    'unmatched': unmatched,
    'warnings': warnings,
    'evaluation_scope': {
      'kind': 'all_warmup_and_measured_frame_timing_windows',
      'earliest_start_ns': earliest,
      'window_count': windows.length,
    },
    'selected_windows_complete': complete,
  };
}

RunIdentity? _identity(JsonMap row) {
  final phase = switch (row['phase']) {
    'measured' => Phase.measured,
    'warmup' => Phase.warmup,
    _ => null,
  };
  final name = row['case_id'], cycle = row['cycle'], repeat = row['repeat'];
  if (phase == null ||
      name is! String ||
      name.isEmpty ||
      !integer(cycle) ||
      repeat is! int ||
      (phase == Phase.measured && repeat < 0) ||
      (phase == Phase.warmup && (cycle != 0 || repeat >= 0))) {
    return null;
  }
  return (name, phase, cycle as int, repeat);
}

(List<JsonMap>, List<String>) readWindows(String attempt) {
  final diagnostics = <String>[], frames = <RunIdentity, List<JsonMap>>{}, runs = <RunIdentity, List<JsonMap>>{};
  for (final (file, target) in [('frames.jsonl', frames), ('runs.jsonl', runs)]) {
    for (final row in readJsonLines(File(p.join(attempt, file)), diagnostics)) {
      final key = _identity(row);
      if (key == null) {
        diagnostics.add('$file: invalid case/phase/cycle/repeat identity');
        continue;
      }
      target.putIfAbsent(key, () => []).add(row);
    }
  }
  final windows = <JsonMap>[];
  final summary = readJson(File(p.join(attempt, 'summary.json')), diagnostics), metadata = asMap(summary['metadata']);
  if (summary['status'] != 'completed') diagnostics.add('benchmark summary is incomplete: ${summary['status']}');
  final config = asMap(metadata['config']), plan = metadata['plan'];
  for (final source in [summary, metadata]) {
    for (final field in [
      'runtime_errors',
      'cleanup_errors',
      'failed_runs',
      'error_events',
      'unsupported_cases',
      'error_counts',
    ]) {
      if (truth(source[field])) diagnostics.add('benchmark summary reports $field: ${source[field]}');
    }
  }
  final repeats = config['repeats'], warmups = config['warmups'], cycles = metadata['cycles'] ?? 1;
  if (plan is! List ||
      plan.isEmpty ||
      !integer(repeats, positive: true) ||
      !integer(warmups) ||
      !integer(cycles, positive: true)) {
    diagnostics.add('expected plan/repetition counts absent; coverage cannot be established');
  } else if (plan.length * ((repeats as int) * (cycles as int) + (warmups as int)) > 100000) {
    diagnostics.add('declared repetition plan exceeds diagnostic safety limit');
  } else {
    final expected = <RunIdentity>{};
    for (final descriptor in plan) {
      final name = asMap(descriptor)['id'];
      if (name is! String || name.isEmpty) {
        diagnostics.add('invalid planned case descriptor');
        continue;
      }
      for (var cycle = 0; cycle < cycles; cycle++) {
        for (var repeat = 0; repeat < repeats; repeat++) {
          expected.add((name, Phase.measured, cycle, repeat));
        }
      }
      for (var repeat = -(warmups); repeat < 0; repeat++) {
        expected.add((name, Phase.warmup, 0, repeat));
      }
    }
    for (final key in expected) {
      runs.putIfAbsent(key, () => []);
    }
    for (final key in {...runs.keys, ...frames.keys}.difference(expected)) {
      diagnostics.add('unexpected run/frame identity: $key');
    }
  }
  final keys = {...runs.keys, ...frames.keys}.toList()..sort((a, b) => a.toString().compareTo(b.toString()));
  for (final key in keys) {
    final raw = frames[key] ?? [], records = runs[key] ?? [], issues = <String>[];
    if (records.length != 1) issues.add('expected one run row, observed ${records.length}');
    final run = records.length == 1 ? records.single : <String, dynamic>{};
    if (run['status'] != 'passed' || truth(run['error'])) {
      issues.add('run failed/has error: ${run['error'] ?? run['status']}');
    }
    if (raw.isEmpty || run['frames'] != raw.length) issues.add('raw/reported frame count missing or different');
    final valid = <JsonMap>[], seen = <int>{};
    for (final frame in raw) {
      final vsync = frame['vsync_us'], total = frame['total_us'];
      if (!integer(vsync, positive: true) ||
          !integer(total, positive: true) ||
          (vsync as int) > 9223372036854775 ||
          (total as int) > 9223372036854775 ||
          !integer(frame['build_us']) ||
          !integer(frame['raster_us']) ||
          _int(frame, 'build_us') > total ||
          _int(frame, 'raster_us') > total ||
          !seen.add(vsync)) {
        issues.add('invalid/duplicate frame timing');
        continue;
      }
      valid.add(frame);
    }
    final int? start = valid.isEmpty ? null : valid.map((f) => _int(f, 'vsync_us') * 1000).reduce(math.min);
    final int? end = valid.isEmpty
        ? null
        : valid.map((f) => (_int(f, 'vsync_us') + _int(f, 'total_us')) * 1000).reduce(math.max);
    if (start == null || end == null || end <= start) issues.add('no usable monotonic FrameTiming window');
    windows.add({
      'case_id': key.$1,
      'phase': key.$2.name,
      'cycle': key.$3,
      'repeat': key.$4,
      'start_ns': start,
      'end_ns': end,
      'run_status': run['status'],
      'run_error': run['error'],
      'actual_ms': run['actual_ms'],
      'frame_count': raw.length,
      'ui_ms': distribution(valid.map((f) => _int(f, 'build_us') / 1000)),
      'raster_ms': distribution(valid.map((f) => _int(f, 'raster_us') / 1000)),
      '_build_samples': valid.map((f) => _int(f, 'build_us') / 1000).toList(),
      '_raster_samples': valid.map((f) => _int(f, 'raster_us') / 1000).toList(),
      'issues': issues,
      'complete': issues.isEmpty,
    });
  }
  final sorted = windows.where((w) => w['start_ns'] is int).toList()
    ..sort((a, b) => _int(a, 'start_ns').compareTo(_int(b, 'start_ns')));
  for (var i = 1; i < sorted.length; i++) {
    if (_int(sorted[i], 'start_ns') < _int(sorted[i - 1], 'end_ns')) {
      diagnostics.add(
        'FrameTiming windows overlap: ${sorted[i - 1]['case_id']}/${sorted[i - 1]['repeat']} and ${sorted[i]['case_id']}/${sorted[i]['repeat']}',
      );
    }
  }
  return (windows, diagnostics);
}

JsonMap _callSummary(List<JsonMap> full, List<JsonMap> partial, List<(int, int)> spans) => {
  'fully_contained_calls': full.length,
  'boundary_partial_calls': partial.length,
  'wall_ms': distribution(full.map((c) => (_int(c, 'end_ns') - _int(c, 'start_ns')) / 1e6)),
  'thread_cpu_ms': distribution(full.map((c) => (_int(c, 'cpu_end_ns') - _int(c, 'cpu_start_ns')) / 1e6)),
  'observed_clipped_wall_union_ms':
      spans.fold<int>(
        0,
        (sum, span) => sum + unionNs(_intervals([...full, ...partial]), start: span.$1, end: span.$2),
      ) /
      1e6,
  'failed_calls': [...full, ...partial].where((c) => c['failed'] == true).toList(),
};

List<JsonMap> _drmSummary(JsonMap trace, List<(int, int)> spans) {
  final drm = trace['drm'] as Map<DrmIdentity, List<int>>;
  final result = <JsonMap>[];
  final keys = drm.keys.toList()..sort((a, b) => a.toString().compareTo(b.toString()));
  for (final key in keys) {
    final gaps = <num>[];
    var count = 0;
    for (final (a, b) in spans) {
      final times = drm[key]!.where((t) => t >= a && t <= b).toList()..sort();
      count += times.length;
      for (var i = 1; i < times.length; i++) {
        gaps.add((times[i] - times[i - 1]) / 1e6);
      }
    }
    result.add({'file': key.$1, 'crtc': key.$2, 'event': key.$3, 'count': count, 'gaps_ms': distribution(gaps)});
  }
  return result;
}

JsonMap summarizeWindow(JsonMap window, JsonMap native, JsonMap trace, {bool scopeValid = true}) {
  final result = {...window};
  final start = window['start_ns'], end = window['end_ns'];
  if (start is! int || end is! int || end <= start) {
    return {...result, 'native': null, 'gpu': null, 'drm': null, 'correlation_valid': false};
  }
  final issues = asList(window['issues']).cast<String>().toList();
  if (!scopeValid) issues.add('collection-wide input diagnostics/errors prevent a complete correlation claim');
  final header = asMap(native['header']), allCalls = _rows(native['calls']);
  final nativeEnd =
      native['effective_end_ns'] as int? ??
      (allCalls.isEmpty ? 0 : allCalls.map((c) => _int(c, 'end_ns')).reduce(math.max));
  if (_int(header, 'start_monotonic_ns', end + 1) > start || end > nativeEnd) {
    issues.add('FrameTiming window is outside native monotonic capture span');
  }
  if (!integer(trace['start_ns'], positive: true) ||
      !integer(trace['end_ns'], positive: true) ||
      _int(trace, 'start_ns') > start ||
      end > _int(trace, 'end_ns')) {
    issues.add('FrameTiming window is outside kernel mono recording span');
  }
  final calls = allCalls.where((c) => _int(c, 'start_ns') < end && _int(c, 'end_ns') > start).toList();
  final phases = <String, dynamic>{};
  for (final function in PipelineFunction.values) {
    final selected = calls.where((c) => c['function_id'] == function.id).toList();
    final full = selected.where((c) => _int(c, 'start_ns') >= start && _int(c, 'end_ns') <= end).toList();
    final partial = selected.where((c) => !full.contains(c)).toList();
    phases[function.label] = {
      ..._callSummary(full, partial, [(start, end)]),
      'overlapping_calls': selected.length,
    };
  }
  final allJobs = _rows(trace['jobs']),
      jobs = allJobs.where((j) => _int(j, 'start_ns') < end && _int(j, 'end_ns') > start).toList();
  final observed = unionNs(_intervals(jobs), start: start, end: end);
  final trusted =
      window['complete'] == true &&
      native['complete'] == true &&
      trace['selected_windows_complete'] == true &&
      issues.isEmpty;
  final byDevice = <String, dynamic>{};
  for (final device in jobs.map((j) => _int(j, 'dev')).toSet().toList()..sort()) {
    final value = unionNs(_intervals(jobs.where((j) => j['dev'] == device)), start: start, end: end);
    byDevice['$device'] = {
      'observed_elapsed_union_ms': value / 1e6,
      'coverage_percent': trusted ? 100 * value / (end - start) : null,
    };
  }
  result.addAll({
    'window_ms': (end - start) / 1e6,
    'native': phases,
    'gpu': {
      'overlapping_rcl_jobs': jobs.length,
      'boundary_partial_jobs': jobs.where((j) => !(_int(j, 'start_ns') >= start && _int(j, 'end_ns') <= end)).length,
      'full_job_elapsed_ms': distribution(
        jobs
            .where((j) => _int(j, 'start_ns') >= start && _int(j, 'end_ns') <= end)
            .map((j) => (_int(j, 'end_ns') - _int(j, 'start_ns')) / 1e6),
      ),
      'observed_elapsed_union_ms': allJobs.isEmpty ? null : observed / 1e6,
      'coverage_percent': trusted ? 100 * observed / (end - start) : null,
      'by_device': byDevice,
      'complete': trusted,
    },
    'drm': _drmSummary(trace, [(start, end)]),
    'issues': issues,
    'correlation_valid': trusted,
  });
  return result;
}

List<JsonMap> summarizeCases(List<JsonMap> windows, JsonMap native, JsonMap trace) {
  final groups = <(String, String), List<JsonMap>>{};
  for (final row in windows) {
    groups.putIfAbsent((row['case_id'] as String, row['phase'] as String), () => []).add(row);
  }
  final result = <JsonMap>[];
  for (final group in groups.entries) {
    final rows = group.value, spans = _intervals(group.value.where((r) => r['start_ns'] is int && r['end_ns'] is int));
    final duration = spans.fold<int>(0, (sum, span) => sum + span.$2 - span.$1);
    final trusted = rows.every((r) => r['correlation_valid'] == true), calls = <String, dynamic>{};
    for (final function in PipelineFunction.values) {
      final selected = _rows(native['calls']).where((c) => c['function_id'] == function.id).toList();
      final full = selected
          .where((c) => spans.any((s) => _int(c, 'start_ns') >= s.$1 && _int(c, 'end_ns') <= s.$2))
          .toList();
      final sequences = full.map((c) => c['sequence']).toSet();
      final partial = selected
          .where(
            (c) =>
                !sequences.contains(c['sequence']) &&
                spans.any((s) => _int(c, 'start_ns') < s.$2 && _int(c, 'end_ns') > s.$1),
          )
          .toList();
      if (full.isNotEmpty || partial.isNotEmpty) calls[function.label] = _callSummary(full, partial, spans);
    }
    final jobs = _rows(trace['jobs']);
    final observed = spans.fold<int>(0, (sum, span) => sum + unionNs(_intervals(jobs), start: span.$1, end: span.$2));
    result.add({
      'case_id': group.key.$1,
      'phase': group.key.$2,
      'runs': rows.length,
      'window_ms': duration / 1e6,
      'correlation_complete': trusted,
      'ui_ms': distribution(rows.expand((r) => asList(r['_build_samples']).cast<num>())),
      'raster_ms': distribution(rows.expand((r) => asList(r['_raster_samples']).cast<num>())),
      'native': calls,
      'drm': _drmSummary(trace, spans),
      'rcl_observed_elapsed_union_ms': jobs.isEmpty ? null : observed / 1e6,
      'rcl_coverage_percent': trusted && duration != 0 ? 100 * observed / duration : null,
    });
  }
  result.sort((a, b) => '${a['case_id']}/${a['phase']}'.compareTo('${b['case_id']}/${b['phase']}'));
  return result;
}

String findAttempt(String directory) {
  if (File(p.join(directory, 'runs.jsonl')).existsSync()) return directory;
  final parent = Directory(p.join(directory, 'opengl'));
  final attempts = parent.existsSync()
      ? parent.listSync().whereType<Directory>().where((dir) => p.basename(dir.path).startsWith('attempt-')).toList()
      : <Directory>[];
  if (attempts.length != 1) {
    throw ArgumentError('Use an explicit attempt directory: observed ${attempts.length} OpenGL attempts');
  }
  return attempts.single.path;
}

JsonMap loadedEngine(String attempt, JsonMap native, List<String> diagnostics, String? expected) {
  final file = File(p.join(attempt, 'native-pipeline-provenance.json'));
  if (!file.existsSync() && expected == null) {
    return {'status': 'unavailable', 'expected_sha256': null, 'validation_complete': false};
  }
  final value = readJson(file, diagnostics), engine = asMap(value['engine']), header = asMap(native['header']);
  final sha = engine['sha256'], captured = value['captured_monotonic_ns'], closed = header['closed_monotonic_ns'];
  final valid =
      integer(value['schema_version']) &&
      value['schema_version'] == 1 &&
      value['kind'] == 'native_pipeline_loaded_engine' &&
      value['status'] == 'verified' &&
      integer(value['pid'], positive: true) &&
      value['pid'] == header['pid'] &&
      engine['path'] is String &&
      p.isAbsolute(engine['path'] as String) &&
      sha is String &&
      _sha.hasMatch(sha) &&
      integer(captured, positive: true) &&
      (captured as int) >= _int(header, 'start_monotonic_ns', captured + 1) &&
      (!(closed is int && closed != 0) || captured <= closed) &&
      value['timing_results_valid'] == false &&
      (expected == null || sha == expected);
  if (!valid) diagnostics.add('loaded engine provenance PID/path/SHA/status does not match diagnostic input');
  return {...value, 'expected_sha256': expected, 'validation_complete': valid};
}

void finalizeNative(String attempt, JsonMap native, JsonMap engine, List<String> diagnostics, String? expectedEngine) {
  if (NativeClosure.parse(native['closure']) == NativeClosure.normalDestructor) return;
  final issues = <String>[], value = readJson(File(p.join(attempt, 'native-pipeline-finalization.json')), issues);
  final capture = asMap(value['native_capture']),
      launcher = asMap(value['launcher_status']),
      header = asMap(native['header']);
  final validated = value['validated_at_monotonic_ns'], calls = _rows(native['calls']);
  final lastEnd = calls.isEmpty ? 0 : calls.map((c) => _int(c, 'end_ns')).reduce(math.max);
  if (header['lifecycle'] != 1 ||
      header['closed_monotonic_ns'] != 0 ||
      !integer(value['schema_version']) ||
      value['schema_version'] != 1 ||
      value['kind'] != 'native_pipeline_external_finalization' ||
      value['status'] != 'verified' ||
      value['pid'] != header['pid'] ||
      value['process_absent'] != true ||
      value['hash_stable'] != true ||
      value['timing_results_valid'] != false ||
      !integer(validated, positive: true) ||
      (validated as int) < math.max(lastEnd, _int(header, 'start_monotonic_ns'))) {
    issues.add('external finalization lifecycle/PID/absence/stability/monotonic fields are invalid');
  }
  if (expectedEngine == null ||
      engine['validation_complete'] != true ||
      engine['expected_sha256'] != expectedEngine ||
      !integer(value['process_start_ticks'], positive: true) ||
      value['process_start_ticks'] != engine['process_start_ticks'] ||
      (integer(validated, positive: true) &&
          (validated as int) < _int(engine, 'captured_monotonic_ns', validated + 1))) {
    issues.add('external finalization requires matched expected engine SHA and process identity');
  }
  try {
    final path = native['path'] as String;
    if (capture['sha256'] != hashFile(path) || capture['size_bytes'] != File(path).lengthSync()) {
      issues.add('external finalization native capture SHA/size mismatch');
    }
    if (value['engine_provenance_sha256'] != hashFile(p.join(attempt, 'native-pipeline-provenance.json'))) {
      issues.add('external finalization engine provenance SHA mismatch');
    }
    final statusPath = p.join(attempt, 'launcher-status.json'),
        digest = hashFile(statusPath),
        status = readJson(File(statusPath), issues);
    if (launcher['file'] != 'launcher-status.json' ||
        launcher['sha256'] != digest ||
        !integer(launcher['exit_code']) ||
        launcher['exit_code'] != 0 ||
        !integer(status['exit_code']) ||
        status['exit_code'] != 0) {
      issues.add('external finalization launcher SHA/file/exit status mismatch');
    }
  } on Object catch (error) {
    issues.add('external finalization input: $error');
  }
  native['external_finalization'] = {...value, 'validation_complete': issues.isEmpty, 'diagnostics': issues};
  if (issues.isNotEmpty) {
    diagnostics.addAll(issues);
    return;
  }
  native['closure'] = NativeClosure.externalFinalization.wire;
  native['effective_end_ns'] = validated;
  native['complete'] = header.isNotEmpty && asList(native['diagnostics']).isEmpty;
  asList(native['warnings']).add(
    'Closure verified by external post-exit attestation; raw lifecycle=1/closed=0 remains unchanged, no C destructor was observed',
  );
}

JsonMap analyzePipeline(
  String collection,
  String nativePath,
  String traceDirectory, {
  bool includeWarmup = false,
  String? expectedEngine,
}) {
  final attempt = findAttempt(collection), native = readNative(nativePath);
  final (windows, diagnostics) = readWindows(attempt);
  final trace = scopeTraceToWindows(readTrace(traceDirectory), windows),
      engine = loadedEngine(attempt, native, diagnostics, expectedEngine);
  finalizeNative(attempt, native, engine, diagnostics, expectedEngine);
  final errors = readJsonLines(File(p.join(attempt, 'errors.jsonl')), diagnostics);
  for (final call in _rows(native['calls']).where((c) => c['failed'] == true)) {
    errors.add({'kind': 'native_call', 'call': call});
  }
  for (final w in windows.where((w) => asList(w['issues']).isNotEmpty)) {
    errors.add({
      'kind': 'run_data',
      'case_id': w['case_id'],
      'phase': w['phase'],
      'cycle': w['cycle'],
      'repeat': w['repeat'],
      'issues': w['issues'],
    });
  }
  try {
    var number = 0;
    for (final line in File(p.join(attempt, 'native.log')).readAsLinesSync()) {
      number++;
      if (!line.startsWith('BENCHMARK') && _nativeError.hasMatch(line)) {
        errors.add({'kind': 'native_log', 'line': number, 'error': line});
      }
    }
  } on Object catch (error) {
    diagnostics.add('native.log unavailable: $error');
  }
  final selected = windows
      .where((w) => includeWarmup || w['phase'] == Phase.measured.name)
      .map((w) => summarizeWindow(w, native, trace, scopeValid: diagnostics.isEmpty && errors.isEmpty))
      .toList();
  final summaries = summarizeCases(selected, native, trace);
  final omitted = [
    for (final w in windows)
      if (!includeWarmup && w['phase'] == Phase.warmup.name)
        {
          'case_id': w['case_id'],
          'cycle': w['cycle'],
          'repeat': w['repeat'],
          'run_status': w['run_status'],
          'issues': w['issues'],
        },
  ];
  for (final row in selected) {
    row.remove('_build_samples');
    row.remove('_raster_samples');
  }
  final serialTrace = {...trace}..remove('drm');
  serialTrace['drm_streams'] = [
    for (final entry in (trace['drm'] as Map<DrmIdentity, List<int>>).entries)
      {
        'file': entry.key.$1,
        'crtc': entry.key.$2,
        'event': entry.key.$3,
        'timestamps_ns': entry.value.toList()..sort(),
      },
  ];
  return {
    'schema_version': 1,
    'diagnostic_only': true,
    'performance_acceptance': 'not_assessed',
    'correlation_scope': 'selected_frame_timing_windows',
    'raw_kernel_trace_complete': trace['raw_complete'],
    'attempt': attempt,
    'native_capture': native,
    'kernel_trace': serialTrace,
    'loaded_engine': engine,
    'diagnostics': diagnostics,
    'errors': errors,
    'omitted_warmup_windows': omitted.length,
    'omitted_warmups': omitted,
    'cases': selected,
    'case_summaries': summaries,
    'correlation_complete':
        selected.isNotEmpty &&
        diagnostics.isEmpty &&
        errors.isEmpty &&
        selected.every((w) => w['correlation_valid'] == true),
    'notes': [
      'Windows are conservative FrameTiming-derived [first vsync, max(vsync+total)] in monotonic ns, not exact GPU/frame markers.',
      'Native wall/thread CPU percentiles use fully contained calls; boundary partial wall intervals are clipped, and their CPU time is never proportionally invented.',
      'Native function intervals can nest or overlap: do not sum function wall times or subtract CPU time as a complete wait attribution.',
      'RCL submit-to-IRQ elapsed includes queueing and IRQ delivery delay; its union coverage is not exclusive GPU shader time or hardware utilization.',
      'Kernel jobs are device-wide observations overlapping case windows; no per-frame or process ownership is inferred.',
      'A single orphan IRQ completed strictly before every warmup/measured window may be bounded outside evaluation; its raw record/diagnostic and raw trace incompleteness remain preserved.',
      'Observed unions remain explicit lower-bound observations when trace records are missing; coverage claims require complete correlated data.',
      'DRM completion gaps measure completion cadence only. Pending page flips are not raster time, shader time, optical latency or unique visible frames.',
      'Warmups are excluded by default. Missing/failed runs and capture errors are retained; this instrumented run cannot replace an uninstrumented A/B.',
    ],
  };
}

String renderPipeline(JsonMap result) {
  String fmt(dynamic value) => value is num ? value.toStringAsFixed(3) : '—';
  final lines = [
    '# Native pipeline diagnostic',
    '',
    'Selected-window correlation complete: ${result['correlation_complete']}. Raw kernel trace complete: ${result['raw_kernel_trace_complete']}. Performance acceptance: not assessed.',
    '',
    for (final note in asList(result['notes'])) '- $note',
    '',
    '| Case / phase | Window ms | UI / raster p95 ms | RCL union ms / coverage % | Complete |',
    '| --- | ---: | --- | --- | --- |',
  ];
  for (final row in _rows(result['case_summaries'])) {
    final label = '${row['case_id']} / ${row['phase']}'.replaceAll('|', r'\|');
    lines.add(
      '| $label | ${fmt(row['window_ms'])} | ${fmt(asMap(row['ui_ms'])['p95'])} / ${fmt(asMap(row['raster_ms'])['p95'])} | ${fmt(row['rcl_observed_elapsed_union_ms'])} / ${fmt(row['rcl_coverage_percent'])} | ${row['correlation_complete']} |',
    );
  }
  lines.addAll([
    '',
    '| Case / phase | Native call | Wall p95 ms | Thread CPU p95 ms | Full / partial calls |',
    '| --- | --- | ---: | ---: | --- |',
  ]);
  for (final row in _rows(result['case_summaries'])) {
    for (final entry in asMap(row['native']).entries) {
      final values = asMap(entry.value);
      lines.add(
        '| ${row['case_id']} / ${row['phase']} | ${entry.key} | ${fmt(asMap(values['wall_ms'])['p95'])} | ${fmt(asMap(values['thread_cpu_ms'])['p95'])} | ${values['fully_contained_calls']} / ${values['boundary_partial_calls']} |',
      );
    }
  }
  lines.addAll(['', '| Case / phase | DRM event / file / CRTC | Count | Gap p95 ms |', '| --- | --- | ---: | ---: |']);
  for (final row in _rows(result['case_summaries'])) {
    for (final stream in _rows(row['drm'])) {
      lines.add(
        '| ${row['case_id']} / ${row['phase']} | ${stream['event']} / ${stream['file']} / ${stream['crtc']} | ${stream['count']} | ${fmt(asMap(stream['gaps_ms'])['p95'])} |',
      );
    }
  }
  lines.add('');
  for (final source in [result, asMap(result['native_capture']), asMap(result['kernel_trace'])]) {
    lines.addAll([
      for (final message in asList(source['diagnostics'])) '- Diagnostic: $message',
      for (final message in asList(source['warnings'])) '- Warning: $message',
    ]);
  }
  for (final row in _rows(result['cases'])) {
    lines.addAll([
      for (final issue in asList(row['issues'])) '- ${row['case_id']}/${row['phase']}/${row['repeat']}: $issue',
    ]);
  }
  lines.addAll([for (final error in asList(result['errors'])) '- Error: ${encodeReportJson(error)}']);
  return '${lines.join('\n')}\n';
}
