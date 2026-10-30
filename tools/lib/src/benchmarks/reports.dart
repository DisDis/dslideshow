import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:path/path.dart' as p;

import 'json_io.dart';
import 'visual_template.dart';

final _lineNumber = RegExp(r':([0-9]+):');
final _caseMarker = RegExp(r'^BENCHMARK_CASE (.+?) cycle=');
final _html = HtmlEscape(HtmlEscapeMode.attribute);
String html(dynamic text) => _html.convert(text.toString());
Map<String, dynamic> _read(String path) => readJson(File(path), [], required: false);

Map<String, dynamic> aggregateSamples(Map<String, dynamic> descriptor, List<Map<String, dynamic>> samples) {
  final row = <String, dynamic>{
    ...descriptor,
    'runs': samples.length,
    'passed': samples.where((s) => s['status'] == 'passed').length,
    'failed': samples.where((s) => s['status'] != 'passed').length,
    'frames': samples.fold<num>(0, (n, s) => n + (s['frames'] is num ? s['frames'] as num : 0)),
    'errors': samples.where((s) => truth(s['error'])).map((s) => s['error']).take(10).toList(),
  };
  num? mean(Iterable<dynamic> raw) {
    final values = raw.whereType<num>().toList();
    return values.isEmpty ? null : values.reduce((a, b) => a + b) / values.length;
  }

  num? peak(Iterable<dynamic> raw) {
    final values = raw.whereType<num>().toList();
    return values.isEmpty ? null : values.reduce(math.max);
  }

  row['actual_mean_ms'] = mean(samples.map((s) => s['actual_ms']));
  row['stretch_mean'] = mean(samples.map((s) => s['duration_stretch']));
  row['max_progress_step'] = peak(samples.map((s) => s['max_progress_step']));
  row['rss_peak_sampled_bytes'] = peak(samples.map((s) => s['rss_bytes']));
  row['raster_p95_mean_ms'] = mean(samples.map((s) => asMap(s['raster_ms'])['p95']));
  row['raster_p95_worst_ms'] = peak(samples.map((s) => asMap(s['raster_ms'])['p95']));
  row['interval_worst_ms'] = peak(samples.map((s) => asMap(s['vsync_interval_ms'])['max']));
  return row;
}

Map<String, dynamic>? aggregateRenderer(Directory directory, String renderer) {
  if (!directory.existsSync()) return null;
  final attempts =
      directory.listSync().whereType<Directory>().where((d) => p.basename(d.path).startsWith('attempt-')).toList()
        ..sort((a, b) => a.path.compareTo(b.path));
  if (attempts.isEmpty) return null;
  final state = _read(p.join(directory.path, 'renderer-status.json'));
  final rows = <String, Map<String, dynamic>>{},
      raw = <String, List<Map<String, dynamic>>>{},
      rawDescriptors = <String, Map<String, dynamic>>{},
      probes = <String, dynamic>{},
      errors = <String, int>{},
      caseErrors = <String, Map<String, int>>{},
      audits = <String, String>{};
  var metadata = <String, dynamic>{},
      lastSummary = <String, dynamic>{},
      lastStatus = <String, dynamic>{},
      launch = <String, dynamic>{};
  final warnings = <String>[], unsupported = <String>{}, links = <String>[];
  var rawAvailable = false;
  for (final attempt in attempts) {
    final name = p.basename(attempt.path),
        summary = _read(p.join(attempt.path, 'summary.json')),
        meta = asMap(_read(p.join(attempt.path, 'summary.json'))['metadata']);
    if (metadata.isEmpty && meta.isNotEmpty) metadata = Map.of(meta);
    for (final entry in asMap(meta['video_texture_probes']).entries) {
      final evidence = asMap(entry.value);
      probes[entry.key] = {
        ...evidence,
        'attempt': name,
        'captures': asList(evidence['captures']).map((e) => p.posix.join(name, e.toString())).toList(),
      };
    }
    warnings.addAll(asList(summary['warnings']).map((e) => e.toString()));
    for (final value in asList(summary['cases'])) {
      final row = asMap(value);
      if (row['id'] is String) rows[row['id'] as String] = row;
    }
    final runs = File(p.join(attempt.path, 'runs.jsonl'));
    rawAvailable = rawAvailable || runs.existsSync();
    for (final sample in _readLines(runs, warnings)) {
      final key = sample['case_id'];
      if (key is! String || key.isEmpty) continue;
      rawDescriptors[key] = truth(sample['case']) ? asMap(sample['case']) : {'id': key};
      if (sample['status'] == 'unsupported') {
        unsupported.add(key);
      } else if (sample['phase'] == 'measured') {
        (raw[key] ??= []).add(sample);
      }
    }
    unsupported.addAll(asList(meta['unsupported_case_ids']).cast<String>());
    for (final file in filesBelow(
      Directory(p.join(attempt.path, 'audit')),
    ).where((f) => p.extension(f.path) == '.json')) {
      final audit = _read(file.path), id = asMap(_read(file.path)['case'])['id'];
      if (id is String) audits[id] = (audit['status'] ?? 'unverified_capture').toString();
    }
    for (final event in _readLines(File(p.join(attempt.path, 'errors.jsonl')), warnings)) {
      final kind = (event['kind'] ?? (event['error'].toString().contains('StreamSink') ? 'telemetry' : 'runtime'))
          .toString();
      errors.update(kind, (v) => v + 1, ifAbsent: () => 1);
      var key = event['case_id'];
      final known = <String>{
        ...rows.keys,
        ...rawDescriptors.keys,
        ...asList(meta['plan']).map((e) => e['id'] as String),
      };
      if (!known.contains(key) && key != null) {
        key = known.where((id) => (':$key:').contains(':$id:')).firstOrNull;
      }
      if (key is String) {
        final counts = caseErrors[key] ??= {};
        counts.update(kind, (v) => v + 1, ifAbsent: () => 1);
      }
    }
    lastStatus = _read(p.join(attempt.path, 'launcher-status.json'));
    lastSummary = summary;
    if (launch.isEmpty) launch = _read(p.join(attempt.path, 'launch.json'));
    links.add(name);
  }
  final failures = asList(state['attempts']).where((a) => truth(a['native_failure'])).toList();
  final descriptors = <String, Map<String, dynamic>>{
    for (final d in asList(state['plan'])) d['id'] as String: asMap(d),
  };
  for (final entry in raw.entries) {
    rows[entry.key] = aggregateSamples(descriptors[entry.key] ?? rawDescriptors[entry.key]!, entry.value);
  }
  for (final key in unsupported) {
    rows[key] = {
      ...?descriptors[key],
      ...?rawDescriptors[key],
      'id': key,
      'status': 'unsupported',
      'runs': 0,
      'passed': 0,
      'failed': 0,
      'frames': 0,
      'errors': <dynamic>[],
    };
  }
  for (final attempt in failures) {
    final key = attempt['last_case_id'];
    if (key is! String) continue;
    final row = rows[key] ??= {...?descriptors[key], 'id': key, 'runs': 0, 'passed': 0, 'failed': 0, 'frames': 0};
    for (final field in ['native_failures', 'runs', 'failed']) {
      row[field] = (row[field] as num? ?? 0) + 1;
    }
    (row['errors'] ??= <dynamic>[]).add('Native exit ${attempt['exit_code']}, ${attempt['path']}');
  }
  for (final entry in rows.entries) {
    entry.value['error_counts'] = caseErrors[entry.key] ?? <String, int>{};
    entry.value['has_errors'] =
        (entry.value['failed'] as num? ?? 0) > 0 || (caseErrors[entry.key]?.isNotEmpty ?? false);
  }
  metadata['video_texture_probes'] = probes;
  if (warnings.isNotEmpty) errors['report_data'] = warnings.where((e) => e.contains('invalid/truncated JSONL')).length;
  errors.removeWhere((key, value) => value == 0);
  final expected = descriptors.isNotEmpty ? descriptors.length : lastSummary['expected_cases'];
  final covered =
      truth(state['all_cases_accounted_for'] ?? state['all_cases_attempted']) ||
      (descriptors.isEmpty &&
          lastSummary['observed_cases'] == expected &&
          ['completed', 'completed_with_failures'].contains(lastSummary['status']));
  var status = covered && failures.isNotEmpty
      ? 'completed_with_native_failures'
      : (lastSummary['status'] ?? 'no_dart_report');
  if (covered && errors.isNotEmpty && failures.isEmpty) status = 'completed_with_failures';
  final complete =
      covered && failures.isEmpty && ['completed', 'completed_with_failures'].contains(lastSummary['status']);
  final visualRequired = truth(asMap(metadata['config'])['visual_audit']);
  final visualCounts = <String, int>{};
  for (final status in audits.values) {
    visualCounts.update(status, (v) => v + 1, ifAbsent: () => 1);
  }
  String? visual;
  if (visualRequired) {
    visual = visualCounts.containsKey('failed')
        ? 'failed'
        : audits.length == rows.length - unsupported.length &&
              audits.values.every((e) => ['passed', 'static_reference'].contains(e))
        ? 'passed'
        : 'unverified_capture';
    if (complete && status == 'completed' && visual != 'passed') status = 'completed_with_unverified_visuals';
  }
  return {
    'renderer': renderer,
    'exit_code': lastStatus['exit_code'],
    'status': status,
    'metadata': metadata,
    'failed_runs': rows.values.fold<num>(0, (n, e) => n + (e['failed'] as num? ?? 0)),
    'observed_cases': descriptors.isNotEmpty ? rows.length : lastSummary['observed_cases'],
    'expected_cases': expected,
    'warnings': warnings,
    'launch': launch,
    'cases': rows.values.toList(),
    'attempts': links,
    'native_crashes': failures.length,
    'all_cases_attempted': covered && unsupported.isEmpty,
    'all_cases_accounted_for': covered,
    'all_supported_cases_attempted': covered,
    'unsupported_cases': unsupported.length,
    'supported_cases': expected is num ? expected - unsupported.length : null,
    'attempted_cases': rows.length - unsupported.length,
    'error_counts': errors,
    'error_events': errors.values.fold<int>(0, (n, e) => n + e),
    'measured_runs': rawAvailable ? raw.values.fold<int>(0, (n, e) => n + e.length) : null,
    'visual_verification': visual,
    'visual_audit_counts': visualCounts,
    'complete': complete,
    'successful':
        complete &&
        errors.isEmpty &&
        !rows.values.any((e) => truth(e['failed'])) &&
        (!visualRequired || visual == 'passed'),
  };
}

Map<String, dynamic> collectReports(Directory root) {
  final reports = <String, dynamic>{};
  for (final renderer in ['opengl', 'vulkan']) {
    final dir = Directory(p.join(root.path, renderer));
    if (!dir.existsSync()) continue;
    final aggregate = aggregateRenderer(dir, renderer);
    if (aggregate != null) {
      reports[renderer] = aggregate;
      continue;
    }
    final summary = _read(p.join(dir.path, 'summary.json')),
        launch = _read(p.join(dir.path, 'launch.json')),
        status = _read(p.join(dir.path, 'launcher-status.json'));
    reports[renderer] = {
      'renderer': renderer,
      'exit_code': status['exit_code'],
      'status': summary['status'] ?? 'no_dart_report',
      'metadata': summary['metadata'] ?? <String, dynamic>{},
      'failed_runs': summary['failed_runs'],
      'observed_cases': summary['observed_cases'],
      'expected_cases': summary['expected_cases'],
      'warnings': summary['warnings'] ?? <dynamic>[],
      'launch': launch,
      'cases': summary['cases'] ?? <dynamic>[],
      'complete':
          [0, 2].contains(status['exit_code']) &&
          ['completed', 'completed_with_failures'].contains(summary['status']) &&
          integer(summary['expected_cases'], positive: true) &&
          summary['observed_cases'] == summary['expected_cases'],
    };
  }
  final checks = <String, bool>{}, comparison = <Map<String, dynamic>>[];
  if (reports.containsKey('opengl') && reports.containsKey('vulkan')) {
    final gl = reports['opengl'], vk = reports['vulkan'];
    for (final key in ['display', 'config', 'media', 'build']) {
      final a = asMap(gl['metadata'])[key], b = asMap(vk['metadata'])[key];
      checks[key] = a != null && b != null && canonical(a) == canonical(b);
    }
    checks['flutter_pi'] =
        truth(gl['launch']['flutter_pi_sha256']) &&
        gl['launch']['flutter_pi_sha256'] == vk['launch']['flutter_pi_sha256'];
    final byId = {for (final row in asList(vk['cases'])) row['id']: row};
    for (final a in asList(gl['cases'])) {
      final b = byId[a['id']];
      if (b == null) continue;
      final ra = a['raster_p95_mean_ms'], rb = b['raster_p95_mean_ms'];
      comparison.add({
        'id': a['id'],
        'opengl_failed': a['failed'],
        'vulkan_failed': b['failed'],
        'opengl_raster_p95_mean_ms': ra,
        'vulkan_raster_p95_mean_ms': rb,
        'vulkan_over_opengl_raster_ratio': numeric(ra, positive: true) && numeric(rb)
            ? (rb as num) / (ra as num)
            : null,
        'opengl_stretch': a['stretch_mean'],
        'vulkan_stretch': b['stretch_mean'],
      });
    }
  }
  return {
    'schema_version': 1,
    'renderers': reports,
    'comparability': checks,
    'performance_comparable': checks.isNotEmpty && checks.values.every((e) => e),
    'comparison': comparison,
  };
}

bool checkpoint(Directory renderer, Directory attempt, int exitCode) {
  final summary = _read(p.join(attempt.path, 'summary.json')),
      metadata = asMap(_read(p.join(attempt.path, 'summary.json'))['metadata']);
  final state = _read(p.join(renderer.path, 'renderer-status.json'));
  state.putIfAbsent('attempts', () => <dynamic>[]);
  state.putIfAbsent('skipped_case_ids', () => <dynamic>[]);
  final plan = truth(metadata['plan']) ? asList(metadata['plan']) : asList(state['plan']),
      ids = asList(truth(metadata['plan']) ? metadata['plan'] : state['plan']).map((e) => e['id'] as String).toList();
  final skipped = asList(state['skipped_case_ids']).cast<String>().toSet(),
      unsupported = asList(metadata['unsupported_case_ids']).cast<String>().toSet();
  skipped.addAll(unsupported);
  final remaining = ids.where((e) => !skipped.contains(e)).toList();
  String? last;
  final native = File(p.join(attempt.path, 'native.log'));
  if (native.existsSync()) {
    for (final line in native.readAsLinesSync()) {
      final match = _caseMarker.firstMatch(line);
      if (match != null) last = match.group(1);
    }
  }
  last = _read(p.join(attempt.path, 'active-case.json'))['id'] as String? ?? last;
  final complete = ['completed', 'completed_with_failures'].contains(summary['status']),
      failure = ![0, 2, 130].contains(exitCode);
  if (complete) {
    skipped.addAll(asList(metadata['executed_case_ids'] ?? remaining).cast<String>());
  } else if (remaining.contains(last)) {
    skipped.addAll(remaining.take(remaining.indexOf(last!) + 1));
  }
  final progressed = skipped.length > asList(state['skipped_case_ids']).length,
      covered = ids.isNotEmpty && skipped.length == ids.length;
  state.addAll({
    'plan': plan,
    'skipped_case_ids': ids.where(skipped.contains).toList(),
    'unsupported_case_ids': ids.where(unsupported.contains).toList(),
    'all_cases_accounted_for': covered,
    'all_supported_cases_attempted': covered,
    'all_cases_attempted': covered && unsupported.isEmpty,
  });
  asList(state['attempts']).add({
    'path': p.basename(attempt.path),
    'exit_code': exitCode,
    'last_case_id': last,
    'native_failure': failure,
    'completed': complete,
    'last_video_operation': File(p.join(attempt.path, 'active-operation.json')).existsSync()
        ? _read(p.join(attempt.path, 'active-operation.json'))
        : null,
    'resume_progress': progressed,
  });
  writeJson(File(p.join(renderer.path, 'renderer-status.json')), state);
  writeJson(File(p.join(renderer.path, 'skip.json')), state['skipped_case_ids']);
  return failure && progressed && skipped.length < ids.length;
}

String renderReports(Map<String, dynamic> result) {
  final out = StringBuffer(
    '<!doctype html><html lang="ru"><meta charset="utf-8"><title>OpenGL / Vulkan</title><h1>DSlideShow: OpenGL / Vulkan</h1><p>Captured composition does not confirm physical scanout or hardware acceptance.</p>',
  );
  for (final entry in asMap(result['renderers']).entries) {
    final report = asMap(entry.value);
    out.write(
      '<h2>${html(entry.key)}</h2><p>status: ${html(report['status'])}; complete: ${html(report['complete'])}; successful: ${html(report['successful'] ?? false)}</p><pre>${html(const JsonEncoder.withIndent('  ').convert(report))}</pre>',
    );
  }
  out.write('<table>');
  for (final row in asList(result['comparison'])) {
    out.write('<tr>');
    for (final value in asMap(row).values) {
      out.write('<td>${html(value ?? '—')}</td>');
    }
    out.write('</tr>');
  }
  out.write('</table><h2>Conditions</h2><pre>${html(jsonEncode(result['comparability']))}</pre></html>');
  return out.toString();
}

int writeVisualReport(Directory root) {
  final audits = filesBelow(root)
      .where((file) => p.basename(file.parent.path) == 'audit' && p.extension(file.path) == '.json')
      .toList();
  final parts = <String>[];
  var count = 0;
  for (final file in audits) {
    final audit = _read(file.path);
    if (audit.isEmpty) continue;
    count++;
    final frames = asList(audit['files'])
        .where((e) => p.basename(e.toString()).contains('--p'))
        .map((e) => p.relative(p.join(file.parent.parent.path, e.toString()), from: root.path))
        .toList();
    if (frames.isEmpty) continue;
    final label = '${html(audit['renderer'])} · ${html(asMap(audit['case'])['id'])}';
    final thumbnails = [
      for (final i in [0, 5, 10, 15, 20])
        if (i < frames.length)
          '<img loading="lazy" src="${html(frames[i])}" alt="progress ${(i / 20).toStringAsFixed(2)}">',
    ].join();
    parts.add(
      '<article><h2>$label</h2><p>${html(audit['status'])} · distinct=${html(audit['distinct_frames'])}/21 · ${html(audit['issues'] ?? <dynamic>[])}</p><div class="strip">$thumbnails</div><details><summary>21 кадр: воспроизведение / просмотр</summary><div class="player" data-frames="${html(jsonEncode(frames))}"><img src="${html(frames.first)}" alt="control frame"><p><button>▶</button> <input type="range" min="0" max="${frames.length - 1}" value="0"><output>0%</output></p></div></details></article>',
    );
  }
  if (count > 0) {
    File(p.join(root.path, 'visual-report.html')).writeAsStringSync(visualHeader + parts.join() + visualFooter);
  }
  return count;
}

bool writeCollection(Directory root) {
  final result = collectReports(root);
  result['visual_audits'] = writeVisualReport(root);
  for (final entry in asMap(result['renderers']).entries) {
    final report = asMap(entry.value);
    if (report.containsKey('attempts')) {
      writeJson(File(p.join(root.path, entry.key, 'summary.json')), report);
      File(p.join(root.path, entry.key, 'report.html')).writeAsStringSync(
        '<!doctype html><meta charset="utf-8"><pre>${html(const JsonEncoder.withIndent('  ').convert(report))}</pre>',
      );
    }
  }
  writeJson(File(p.join(root.path, 'collection-summary.json')), result);
  File(p.join(root.path, 'report.html')).writeAsStringSync(renderReports(result));
  File(p.join(root.path, 'README.txt')).writeAsStringSync(
    'Откройте report.html. Передайте весь .tar.gz, включая native.log каждого renderer.\nНеполные данные и ошибки требуют проверки исходных логов.\n',
  );
  final reports = asMap(result['renderers']);
  return reports.isNotEmpty && reports.values.every((r) => (r['successful'] ?? r['complete']) == true);
}

List<Map<String, dynamic>> _readLines(File file, List<String> diagnostics) {
  final local = <String>[];
  final rows = readJsonLines(file, local, required: false);
  for (final text in local) {
    final number = _lineNumber.allMatches(text).lastOrNull?.group(1) ?? '?';
    diagnostics.add(
      '${p.posix.join(p.basename(file.parent.path), p.basename(file.path))}:$number: invalid/truncated JSONL',
    );
  }
  return rows;
}
