import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'telemetry.dart';

Future<void> atomicJson(File file, Object data) async {
  final temporary = File('${file.path}.tmp');
  await temporary.writeAsString(
    const JsonEncoder.withIndent('  ').convert(data),
    flush: true,
  );
  await temporary.rename(file.path);
}

String csvCell(Object? value) =>
    '"${(value ?? '').toString().replaceAll('"', '""')}"';
String html(Object? value) =>
    const HtmlEscape().convert((value ?? '—').toString());

class CaseAggregate {
  final Map<String, Object?> descriptor;
  int runs = 0, passed = 0, failed = 0, frames = 0;
  int wallSamples = 0, stretchSamples = 0;
  double wallSum = 0, stretchSum = 0;
  double? maxStep;
  double? rasterP95Sum, rasterP95Worst, intervalWorst;
  int rasterSamples = 0;
  int? peakRss;
  final List<String> errors = [];
  CaseAggregate(this.descriptor);

  void add(Map<String, Object?> row) {
    runs++;
    row['status'] == 'passed' ? passed++ : failed++;
    frames += row['frames'] as int? ?? 0;
    if (row['actual_ms'] case final num value) {
      wallSum += value;
      wallSamples++;
    }
    if (row['duration_stretch'] case final num value) {
      stretchSum += value;
      stretchSamples++;
    }
    if (row['max_progress_step'] case final num value) {
      maxStep = math.max(maxStep ?? value.toDouble(), value.toDouble());
    }
    final raster = row['raster_ms'] as Map?;
    final p95 = (raster?['p95'] as num?)?.toDouble();
    if (p95 != null) {
      rasterP95Sum = (rasterP95Sum ?? 0) + p95;
      rasterSamples++;
      rasterP95Worst = math.max(rasterP95Worst ?? p95, p95);
    }
    final interval = ((row['vsync_interval_ms'] as Map?)?['max'] as num?)
        ?.toDouble();
    if (interval != null) {
      intervalWorst = math.max(intervalWorst ?? interval, interval);
    }
    final rss = row['rss_bytes'] as int?;
    if (rss != null) peakRss = math.max(peakRss ?? rss, rss);
    if (row['error'] != null && errors.length < 10) {
      errors.add(row['error'].toString());
    }
  }

  Map<String, Object?> toJson() => {
    ...descriptor,
    'runs': runs,
    'passed': passed,
    'failed': failed,
    'frames': frames,
    'actual_mean_ms': wallSamples == 0 ? null : wallSum / wallSamples,
    'stretch_mean': stretchSamples == 0 ? null : stretchSum / stretchSamples,
    'max_progress_step': maxStep,
    'raster_p95_mean_ms': rasterP95Sum == null
        ? null
        : rasterP95Sum! / rasterSamples,
    'raster_p95_worst_ms': rasterP95Worst,
    'interval_worst_ms': intervalWorst,
    'rss_peak_sampled_bytes': peakRss,
    'errors': errors,
  };
}

class ReportStore {
  final Directory directory;
  late final IOSink _runs, _frames, _telemetry, _errors;
  final Map<String, CaseAggregate> cases = {};
  final Map<String, Object?> metadata = {};
  final List<String> warnings = [];
  final Map<String, int> errorCounts = {};
  final Map<String, Map<String, int>> caseErrorCounts = {};
  Future<void> _writes = Future.value();
  AsyncError? _writeError;
  bool _closed = false;
  int warmups = 0;
  ReportStore(this.directory);

  Future<void> open() async {
    await directory.create(recursive: true);
    // Refuse mixing a new run with an existing report.
    if (await File('${directory.path}/runs.jsonl').exists()) {
      throw StateError(
        'Report directory already contains a run: ${directory.path}',
      );
    }
    _runs = File('${directory.path}/runs.jsonl').openWrite();
    _frames = File('${directory.path}/frames.jsonl').openWrite();
    _telemetry = File('${directory.path}/telemetry.jsonl').openWrite();
    _errors = File('${directory.path}/errors.jsonl').openWrite();
  }

  // IOSink cannot accept writes while flush is bound to its stream. Timer
  // samples and error callbacks therefore share the same queue as flush.
  void _enqueue(FutureOr<void> Function() write) {
    if (_closed) return;
    _writes = _writes.then((_) async {
      try {
        await write();
      } catch (error, stack) {
        _writeError ??= AsyncError(error, stack);
      }
    });
  }

  void telemetry(Map<String, Object?> row) {
    final line = jsonEncode(row);
    _enqueue(() => _telemetry.writeln(line));
  }

  void error(
    Object error,
    StackTrace stack, {
    String? caseId,
    String? stage,
    String kind = 'case',
  }) {
    errorCounts.update(kind, (n) => n + 1, ifAbsent: () => 1);
    if (caseId != null) {
      (caseErrorCounts[caseId] ??= {}).update(
        kind,
        (n) => n + 1,
        ifAbsent: () => 1,
      );
    }
    final line = jsonEncode({
      'utc': DateTime.now().toUtc().toIso8601String(),
      'case_id': caseId,
      'stage': stage,
      'kind': kind,
      'error': '$error',
      'stack': '$stack',
    });
    _enqueue(() => _errors.writeln(line));
  }

  void record(
    Map<String, Object?> row,
    Iterable<Map<String, Object?>> frameRows,
  ) {
    final line = jsonEncode(row);
    final frames = frameRows.map(jsonEncode).toList();
    _enqueue(() {
      _runs.writeln(line);
      for (final frame in frames) {
        _frames.writeln(frame);
      }
    });
    if (row['status'] == 'unsupported') {
      cases.putIfAbsent(
        row['case_id']! as String,
        () => CaseAggregate((row['case']! as Map).cast<String, Object?>()),
      );
      return;
    }
    if (row['phase'] == 'warmup') {
      warmups++;
      return;
    }
    final id = row['case_id']! as String;
    cases
        .putIfAbsent(
          id,
          () => CaseAggregate((row['case']! as Map).cast<String, Object?>()),
        )
        .add(row);
    stdout.writeln(
      'BENCHMARK ${jsonEncode({'case_id': id, 'status': row['status'], 'repeat': row['repeat'], 'actual_ms': row['actual_ms'], 'frames': row['frames']})}',
    );
  }

  Future<void> flush() async {
    _enqueue(() async {
      await Future.wait([
        _runs.flush(),
        _frames.flush(),
        _telemetry.flush(),
        _errors.flush(),
      ]);
    });
    await _writes;
    final failure = _writeError;
    if (failure != null) {
      Error.throwWithStackTrace(failure.error, failure.stackTrace);
    }
  }

  Future<Map<String, Object?>> checkpoint(
    String status,
    LinuxTelemetry telemetry, {
    int? expectedCases,
    bool finalReport = false,
  }) async {
    await flush();
    final unsupported =
        (metadata['unsupported_case_ids'] as List?)?.cast<String>().toSet() ??
        <String>{};
    final rows = cases.entries
        .map(
          (entry) => {
            ...entry.value.toJson(),
            if (unsupported.contains(entry.key)) 'status': 'unsupported',
            'error_counts': caseErrorCounts[entry.key] ?? <String, int>{},
            'has_errors':
                entry.value.failed > 0 ||
                (caseErrorCounts[entry.key]?.isNotEmpty ?? false),
          },
        )
        .toList();
    final failed = cases.values.fold(0, (n, c) => n + c.failed);
    final summary = <String, Object?>{
      'schema_version': 2,
      'status': status,
      'updated_utc': DateTime.now().toUtc().toIso8601String(),
      'metadata': metadata,
      'warnings': warnings,
      'expected_cases': expectedCases,
      'observed_cases': cases.length,
      'measured_runs': cases.values.fold<int>(0, (n, c) => n + c.runs),
      'failed_runs': failed,
      'error_counts': Map.of(errorCounts),
      'error_events': errorCounts.values.fold<int>(0, (a, b) => a + b),
      'unsupported_cases': unsupported.length,
      'warmup_runs': warmups,
      'telemetry_samples': telemetry.samples,
      'rss_peak_sampled_bytes': telemetry.peakRss,
      'cpu_temperature_peak_c': telemetry.peakTemperature,
      'cases': rows,
    };
    await atomicJson(File('${directory.path}/summary.json'), summary);
    if (finalReport) await _render(summary, rows, telemetry.plotSamples);
    return summary;
  }

  Future<void> _render(
    Map<String, Object?> summary,
    List<Map<String, Object?>> rows,
    List<Map<String, Object?>> telemetry,
  ) async {
    const columns = [
      'id',
      'effect',
      'media',
      'grid',
      'backend',
      'status',
      'error_counts',
      'runs',
      'passed',
      'failed',
      'frames',
      'actual_mean_ms',
      'stretch_mean',
      'max_progress_step',
      'raster_p95_mean_ms',
      'raster_p95_worst_ms',
      'interval_worst_ms',
      'rss_peak_sampled_bytes',
    ];
    final csv = StringBuffer()..writeln(columns.map(csvCell).join(','));
    final table = StringBuffer();
    for (final row in rows) {
      csv.writeln(columns.map((c) => csvCell(row[c])).join(','));
      table.write(
        '<tr>${['id', 'status', 'error_counts', 'runs', 'failed', 'frames', 'actual_mean_ms', 'stretch_mean', 'raster_p95_mean_ms', 'raster_p95_worst_ms', 'interval_worst_ms', 'rss_peak_sampled_bytes'].map((c) => '<td>${html(row[c] is double ? (row[c] as double).toStringAsFixed(3) : row[c])}</td>').join()}</tr>',
      );
    }
    await File('${directory.path}/summary.csv').writeAsString(csv.toString());
    final notes = '''FixedAnimationController сохранён. Увеличение времени перехода допустимо: stretch = фактическое / заданное время.
Плавность прогресса и интервалы кадров анализируются отдельно. Сетка мозаики не уменьшается.
FPS и пропущенные vsync — оценка по представленным Flutter кадрам, не счётчик дисплея или декодера.
При несовпадении интервалов timestamp с периодом дисплея estimated_missed_vsyncs=null.
unsupported — пропуск до подготовки медиа; runtime/cleanup/capture/telemetry ошибки считаются отдельно от failed_runs.
Raster p95 mean/worst — среднее/максимум p95 отдельных прогонов, не общий p95 всех кадров.
Подготовка фото использует полные оригиналы; размеры исходников и реального экрана записаны в metadata.
null/— означает отсутствие метрики. HWM в runs — максимум RSS процесса с запуска, не максимум отдельного теста.
Скриншоты и пробы видео снимаются отдельно от измерений. captured_motion подтверждает движение текстуры в захвате; чёрный/недоступный захват остаётся неопределённым.
Телеметрия опрашивается периодически; короткие пики могут отсутствовать в графике, ОС HWM остаётся в сырых данных.
''';
    final overview =
        'Статус: ${summary['status']}. Тестов: ${rows.length}/${summary['expected_cases']}. '
        'Измерений: ${summary['measured_runs']}. Ошибок прогонов: ${summary['failed_runs']}. '
        'Событий ошибок: ${summary['error_events']}; типы: ${summary['error_counts']}. '
        'Неподдерживаемых: ${summary['unsupported_cases']}.';
    await File('${directory.path}/report.md').writeAsString(
      '# DSlideShow — RaPi benchmark\n\n$overview\n\n'
      '${warnings.map((w) => '- $w').join('\n')}\n\n$notes\n'
      'Откройте report.html для таблицы и графиков. summary.csv — сравнение случаев; '
      'runs.jsonl — каждый прогон и подготовка; frames.jsonl — каждый кадр; '
      'telemetry.jsonl — CPU/RSS/температура/частоты; errors.jsonl — ошибки.\n',
    );
    await File('${directory.path}/report.html').writeAsString(
      '''<!doctype html><html lang="ru"><meta charset="utf-8">
<title>DSlideShow benchmark</title><style>body{font:15px system-ui;margin:24px;background:#101922;color:#e5edf5}
table{border-collapse:collapse;font-size:12px}td,th{border:1px solid #455365;padding:7px;text-align:right}td:first-child{text-align:left}
th{position:sticky;top:0;background:#243447}pre{white-space:pre-wrap}svg{background:#1c2b3b;max-width:100%;height:auto}a{color:#9bceff}</style>
<h1>DSlideShow — автоматический benchmark</h1><p>${html(overview)}</p>
<ul>${warnings.map((w) => '<li>${html(w)}</li>').join()}</ul>
<h2>RSS, MiB</h2>${_chart(telemetry, 'rss_bytes', 1 / 1048576)}
<h2>Температура CPU, °C</h2>${_chart(telemetry, 'cpu_temperature_c', 1)}
<h2>CPU процесса, % (может превышать 100 на нескольких ядрах)</h2>${_chart(telemetry, 'process_cpu_percent', 1)}
<h2>Измерения</h2><p>Все времена — ms. RSS — bytes. Таблица прокручивается по горизонтали.</p><div style="overflow:auto"><table><thead><tr>
${['Случай', 'Статус', 'События ошибок', 'Прогоны', 'Ошибки', 'Кадры', 'Время mean', 'Stretch mean', 'Raster p95 mean', 'Raster p95 worst', 'Интервал max', 'RSS sample max'].map((v) => '<th>$v</th>').join()}
</tr></thead><tbody>$table</tbody></table></div><h2>Методика</h2><pre>${html(notes)}</pre>
<h2>Окружение и входные данные</h2><pre>${html(const JsonEncoder.withIndent('  ').convert(metadata))}</pre></html>''',
    );
  }

  String _chart(List<Map<String, Object?>> samples, String key, double scale) {
    final points = samples.where((r) => r[key] is num).toList();
    if (points.isEmpty) return '<p>Данные недоступны</p>';
    final maxX = (points.last['elapsed_ms']! as num).toDouble();
    final maxY = points
        .map((r) => (r[key]! as num).toDouble() * scale)
        .reduce(math.max);
    final coordinates = points
        .map(
          (r) =>
              '${(30 + (r['elapsed_ms']! as num) / math.max(1, maxX) * 930).toStringAsFixed(1)},'
              '${(180 - (r[key]! as num) * scale / math.max(1, maxY) * 150).toStringAsFixed(1)}',
        )
        .join(' ');
    return '<svg viewBox="0 0 1000 215" role="img" aria-label="${html(key)}"><polyline points="$coordinates" fill="none" stroke="#72d7d0" stroke-width="2"/>'
        '<text x="10" y="20" fill="white">max ${maxY.toStringAsFixed(1)}</text><text x="30" y="205" fill="white">0</text>'
        '<text x="800" y="205" fill="white">${(maxX / 60000).toStringAsFixed(1)} min</text></svg>';
  }

  Future<void> close() async {
    await flush();
    _closed = true;
    await _writes;
    await Future.wait([
      _runs.close(),
      _frames.close(),
      _telemetry.close(),
      _errors.close(),
    ]);
  }
}
