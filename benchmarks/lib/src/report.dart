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

  void telemetry(Map<String, Object?> row) =>
      _telemetry.writeln(jsonEncode(row));
  void error(Object error, StackTrace stack, {String? caseId}) {
    _errors.writeln(
      jsonEncode({
        'utc': DateTime.now().toUtc().toIso8601String(),
        'case_id': caseId,
        'error': '$error',
        'stack': '$stack',
      }),
    );
  }

  void record(
    Map<String, Object?> row,
    Iterable<Map<String, Object?>> frameRows,
  ) {
    _runs.writeln(jsonEncode(row));
    for (final frame in frameRows) {
      _frames.writeln(jsonEncode(frame));
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
    await Future.wait([
      _runs.flush(),
      _frames.flush(),
      _telemetry.flush(),
      _errors.flush(),
    ]);
  }

  Future<Map<String, Object?>> checkpoint(
    String status,
    LinuxTelemetry telemetry, {
    int? expectedCases,
    bool finalReport = false,
  }) async {
    await flush();
    final rows = cases.values.map((v) => v.toJson()).toList();
    final failed = cases.values.fold(0, (n, c) => n + c.failed);
    final summary = <String, Object?>{
      'schema_version': 1,
      'status': status,
      'updated_utc': DateTime.now().toUtc().toIso8601String(),
      'metadata': metadata,
      'warnings': warnings,
      'expected_cases': expectedCases,
      'observed_cases': cases.length,
      'measured_runs': cases.values.fold<int>(0, (n, c) => n + c.runs),
      'failed_runs': failed,
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
        '<tr>${['id', 'runs', 'failed', 'frames', 'actual_mean_ms', 'stretch_mean', 'raster_p95_mean_ms', 'raster_p95_worst_ms', 'interval_worst_ms', 'rss_peak_sampled_bytes'].map((c) => '<td>${html(row[c] is double ? (row[c] as double).toStringAsFixed(3) : row[c])}</td>').join()}</tr>',
      );
    }
    await File('${directory.path}/summary.csv').writeAsString(csv.toString());
    final notes = '''FixedAnimationController сохранён. Увеличение времени перехода допустимо: stretch = фактическое / заданное время.
Плавность прогресса и интервалы кадров анализируются отдельно. Сетка мозаики не уменьшается.
FPS и пропущенные vsync — оценка по представленным Flutter кадрам, не счётчик дисплея или декодера.
Raster p95 mean/worst — среднее/максимум p95 отдельных прогонов, не общий p95 всех кадров.
Подготовка фото использует полные оригиналы; размеры исходников и реального экрана записаны в metadata.
null/— означает отсутствие метрики. HWM в runs — максимум RSS процесса с запуска, не максимум отдельного теста.
Скриншоты и пробы видео снимаются отдельно от измерений. captured_motion подтверждает движение текстуры в захвате; чёрный/недоступный захват остаётся неопределённым.
Телеметрия опрашивается периодически; короткие пики могут отсутствовать в графике, ОС HWM остаётся в сырых данных.
''';
    final overview =
        'Статус: ${summary['status']}. Тестов: ${rows.length}/${summary['expected_cases']}. '
        'Измерений: ${summary['measured_runs']}. Ошибок: ${summary['failed_runs']}.';
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
${['Случай', 'Прогоны', 'Ошибки', 'Кадры', 'Время mean', 'Stretch mean', 'Raster p95 mean', 'Raster p95 worst', 'Интервал max', 'RSS sample max'].map((v) => '<th>$v</th>').join()}
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
    await Future.wait([
      _runs.close(),
      _frames.close(),
      _telemetry.close(),
      _errors.close(),
    ]);
  }
}
