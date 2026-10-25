#!/usr/bin/env python3
"""Collect OpenGL/Vulkan results, including native crashes and partial Dart reports."""
import argparse
import html
import json
from collections import Counter, defaultdict
from pathlib import Path
from visual_report import write_visual_report


def read_json(file):
    try:
        return json.loads(file.read_text())
    except (OSError, ValueError):
        return None


def read_jsonl(file, diagnostics):
    if not file.exists():
        return []
    rows = []
    with file.open(errors='replace') as stream:
        for number, line in enumerate(stream, 1):
            try:
                rows.append(json.loads(line))
            except ValueError:
                diagnostics.append(f'{file.parent.name}/{file.name}:{number}: invalid/truncated JSONL')
    return rows


def aggregate_samples(descriptor, samples):
    row = dict(descriptor, runs=len(samples), passed=sum(s.get('status') == 'passed' for s in samples),
               failed=sum(s.get('status') != 'passed' for s in samples),
               frames=sum(s.get('frames', 0) for s in samples), errors=[])
    for source, target in [('actual_ms', 'actual_mean_ms'), ('duration_stretch', 'stretch_mean')]:
        values = [s[source] for s in samples if isinstance(s.get(source), (int, float))]
        row[target] = sum(values)/len(values) if values else None
    for source, target in [('max_progress_step','max_progress_step'), ('rss_bytes','rss_peak_sampled_bytes')]:
        values = [s[source] for s in samples if isinstance(s.get(source), (int,float))]
        row[target] = max(values) if values else None
    p95 = [s['raster_ms']['p95'] for s in samples if isinstance((s.get('raster_ms') or {}).get('p95'), (int,float))]
    row['raster_p95_mean_ms'] = sum(p95)/len(p95) if p95 else None
    row['raster_p95_worst_ms'] = max(p95) if p95 else None
    intervals = [s['vsync_interval_ms']['max'] for s in samples if isinstance((s.get('vsync_interval_ms') or {}).get('max'), (int,float))]
    row['interval_worst_ms'] = max(intervals) if intervals else None
    row['errors'] = [s['error'] for s in samples if s.get('error')][:10]
    return row


def aggregate_renderer(directory, renderer):
    attempts = sorted(p for p in directory.glob('attempt-*') if p.is_dir())
    if not attempts:
        return None
    state = read_json(directory / 'renderer-status.json') or {}
    rows, metadata, warnings, probes = {}, {}, [], {}
    raw_samples, raw_descriptors = defaultdict(list), {}
    error_counts, case_errors = Counter(), defaultdict(Counter)
    unsupported = set()
    raw_available = False
    visual_audits = {}
    links = []
    last_summary, last_status, launch = {}, {}, {}
    for attempt in attempts:
        summary = read_json(attempt / 'summary.json') or {}
        meta = summary.get('metadata', {})
        if not metadata and meta:
            metadata = dict(meta)
        for name, evidence in (meta.get('video_texture_probes') or {}).items():
            probes[name] = {**evidence, 'attempt':attempt.name,
                'captures':[f'{attempt.name}/{p}' for p in evidence.get('captures', [])]}
        warnings.extend(summary.get('warnings', []))
        for row in summary.get('cases', []):
            rows[row['id']] = dict(row)
        raw_available = raw_available or (attempt / 'runs.jsonl').exists()
        for sample in read_jsonl(attempt / 'runs.jsonl', warnings):
            key = sample.get('case_id')
            if not key:
                continue
            raw_descriptors[key] = sample.get('case') or dict(id=key)
            if sample.get('status') == 'unsupported':
                unsupported.add(key)
            elif sample.get('phase') == 'measured':
                raw_samples[key].append(sample)
        unsupported.update(meta.get('unsupported_case_ids', []))
        for file in (attempt / 'audit').glob('*.json'):
            audit = read_json(file)
            if audit and audit.get('case', {}).get('id'):
                visual_audits[audit['case']['id']] = audit.get('status', 'unverified_capture')
        for event in read_jsonl(attempt / 'errors.jsonl', warnings):
            kind = event.get('kind') or ('telemetry' if 'StreamSink' in event.get('error','') else 'runtime')
            error_counts[kind] += 1
            key = event.get('case_id')
            known_ids = set(rows) | set(raw_descriptors) | {r['id'] for r in meta.get('plan', [])}
            # Older reports used the entire stage as case_id.
            if key not in known_ids and key is not None:
                key = next((name for name in known_ids if f':{name}:' in f'{key}:'), None)
            if key:
                case_errors[key][kind] += 1
        last_status = read_json(attempt / 'launcher-status.json') or {}
        last_summary = summary
        launch = launch or read_json(attempt / 'launch.json') or {}
        links.append(attempt.name)
    failures = [a for a in state.get('attempts', []) if a.get('native_failure')]
    descriptors = {r['id']:r for r in state.get('plan', [])}
    for key, samples in raw_samples.items():
        rows[key] = aggregate_samples(descriptors.get(key) or raw_descriptors[key], samples)
    for key in unsupported:
        rows[key] = dict(descriptors.get(key) or raw_descriptors.get(key) or dict(id=key),
                         status='unsupported', runs=0, passed=0, failed=0, frames=0, errors=[])
    for attempt in failures:
        key = attempt.get('last_case_id')
        if key:
            row = rows.setdefault(key, {**descriptors.get(key, {}), 'id':key,
                'runs':0, 'passed':0, 'failed':0, 'frames':0})
            row['native_failures'] = row.get('native_failures', 0) + 1
            row['runs'] = row.get('runs', 0) + 1
            row['failed'] = row.get('failed', 0) + 1
            row.setdefault('errors', []).append(f'Native exit {attempt["exit_code"]}, {attempt["path"]}')
    for key, row in rows.items():
        row['error_counts'] = dict(case_errors[key])
        row['has_errors'] = row.get('failed',0) > 0 or bool(case_errors[key])
    metadata['video_texture_probes'] = probes
    data_errors = sum('invalid/truncated JSONL' in warning for warning in warnings)
    if data_errors:
        error_counts['report_data'] += data_errors
    expected = len(descriptors) or last_summary.get('expected_cases')
    covered = state.get('all_cases_accounted_for', state.get('all_cases_attempted', False)) or (
        not descriptors and last_summary.get('observed_cases') == expected
        and last_summary.get('status') in ('completed', 'completed_with_failures'))
    status = 'completed_with_native_failures' if covered and failures else last_summary.get('status', 'no_dart_report')
    if covered and error_counts and not failures:
        status = 'completed_with_failures'
    complete = covered and not failures and last_summary.get('status') in ('completed', 'completed_with_failures')
    visual_required = bool(metadata.get('config', {}).get('visual_audit'))
    visual_counts = dict(Counter(visual_audits.values()))
    visual_status = None
    if visual_required:
        visual_status = ('failed' if visual_counts.get('failed') else 'passed'
            if len(visual_audits) == len(rows)-len(unsupported)
            and all(s in ('passed', 'static_reference') for s in visual_audits.values())
            else 'unverified_capture')
        if complete and status == 'completed' and visual_status != 'passed':
            status = 'completed_with_unverified_visuals'
    return dict(renderer=renderer, exit_code=last_status.get('exit_code'),
        status=status,
        metadata=metadata, failed_runs=sum(r.get('failed', 0) for r in rows.values()),
        observed_cases=len(rows) if descriptors else last_summary.get('observed_cases'),
        expected_cases=expected, warnings=warnings, launch=launch, cases=list(rows.values()),
        attempts=links, native_crashes=len(failures), all_cases_attempted=covered and not unsupported,
        all_cases_accounted_for=covered, all_supported_cases_attempted=covered,
        unsupported_cases=len(unsupported), supported_cases=(expected-len(unsupported)) if expected else None,
        attempted_cases=len(rows)-len(unsupported), error_counts=dict(error_counts),
        error_events=sum(error_counts.values()), measured_runs=sum(len(s) for s in raw_samples.values()) if raw_available else None,
        visual_verification=visual_status, visual_audit_counts=visual_counts,
        complete=complete, successful=complete and not error_counts and not any(r.get('failed') for r in rows.values())
            and (not visual_required or visual_status == 'passed'))


def collect(root):
    reports = {}
    for renderer in ("opengl", "vulkan"):
        directory = root / renderer
        if not directory.exists():
            continue
        aggregate = aggregate_renderer(directory, renderer)
        if aggregate is not None:
            reports[renderer] = aggregate
            continue
        summary = read_json(directory / "summary.json") or {}
        launch = read_json(directory / "launch.json") or {}
        status = read_json(directory / "launcher-status.json") or {}
        reports[renderer] = dict(
            renderer=renderer, exit_code=status.get("exit_code"),
            status=summary.get("status", "no_dart_report"),
            metadata=summary.get("metadata", {}),
            failed_runs=summary.get("failed_runs"),
            observed_cases=summary.get("observed_cases"),
            expected_cases=summary.get("expected_cases"),
            warnings=summary.get("warnings", []), launch=launch,
            cases=summary.get("cases", []),
            complete=status.get("exit_code") in (0, 2)
            and summary.get("status") in ("completed", "completed_with_failures")
            and isinstance(summary.get("expected_cases"), int) and summary["expected_cases"] > 0
            and summary.get("observed_cases") == summary.get("expected_cases"),
        )
    comparison = []
    gl, vk = reports.get("opengl"), reports.get("vulkan")
    comparability = {}
    if gl and vk:
        for key in ("display", "config", "media", "build"):
            a, b = gl["metadata"].get(key), vk["metadata"].get(key)
            comparability[key] = a is not None and b is not None and a == b
        comparability["flutter_pi"] = bool(gl["launch"].get("flutter_pi_sha256")) and (
            gl["launch"].get("flutter_pi_sha256") == vk["launch"].get("flutter_pi_sha256"))
        by_id = {row["id"]: row for row in vk["cases"]}
        for a in gl["cases"]:
            b = by_id.get(a["id"])
            if b is None:
                continue
            raster_a, raster_b = a.get("raster_p95_mean_ms"), b.get("raster_p95_mean_ms")
            comparison.append(dict(id=a["id"], opengl_failed=a.get("failed"),
                vulkan_failed=b.get("failed"), opengl_raster_p95_mean_ms=raster_a,
                vulkan_raster_p95_mean_ms=raster_b,
                vulkan_over_opengl_raster_ratio=(raster_b / raster_a
                    if isinstance(raster_a, (float, int)) and raster_a > 0
                    and isinstance(raster_b, (float, int)) else None),
                opengl_stretch=a.get("stretch_mean"), vulkan_stretch=b.get("stretch_mean")))
    return dict(schema_version=1, renderers=reports, comparability=comparability,
                performance_comparable=bool(comparability) and all(comparability.values()),
                comparison=comparison)


def render(result):
    sections = []
    for renderer, report in result["renderers"].items():
        first_attempt = report.get('attempts', [None])[0]
        log_prefix = f'{renderer}/{first_attempt}' if first_attempt else renderer
        probes = report['metadata'].get('video_texture_probes') or {}
        evidence = ''.join('<li>' + html.escape(name) + ': ' + html.escape(str(probe.get('status')))
            + '</li>' for name, probe in probes.items())
        sections.append(f'<h2>{renderer}</h2><p>Процесс: {report["exit_code"]}; '
            f'статус: {html.escape(report["status"])}; полный прогон: {report["complete"]}; '
            f'случаи: {report["observed_cases"]}/{report["expected_cases"]}; '
            f'ошибки: {report["failed_runs"]}; нативных падений: {report.get("native_crashes", 0)}; '
            f'неподдерживаемых: {report.get("unsupported_cases", 0)}; '
            f'события ошибок: {html.escape(str(report.get("error_counts", {})))}; '
            f'все поддерживаемые случаи попытаны: {report.get("all_supported_cases_attempted", report["complete"])}; '
            f'успешная приёмка: {report.get("successful", False)}.</p>'
            f'<p>Визуальная проверка: {html.escape(str(report.get("visual_verification")))}; '
            f'{html.escape(str(report.get("visual_audit_counts", {})))}.</p>'
            f'<p><a href="{renderer}/report.html">Подробный отчёт</a> · '
            f'<a href="{renderer}/summary.json">Checkpoint JSON</a> · '
            f'<a href="{log_prefix}/native.log">Нативный лог</a> · '
            f'<a href="{log_prefix}/errors.jsonl">Ошибки Dart</a></p><ul>{evidence}</ul>'
            + ''.join(f'<p>{attempt}: <a href="{renderer}/{attempt}/native.log">native.log</a> · '
                f'<a href="{renderer}/{attempt}/report.html">отчёт</a> · '
                f'<a href="{renderer}/{attempt}/summary.json">checkpoint</a></p>'
                for attempt in report.get('attempts', [])))
    table = []
    for row in result["comparison"]:
        table.append('<tr>' + ''.join(f'<td>{html.escape(str(v)) if v is not None else "—"}</td>'
            for v in row.values()) + '</tr>')
    visual_link = '<p><a href="visual-report.html">Визуальная проверка эффектов: 21 кадр</a></p>' if result.get('visual_audits') else ''
    return '''<!doctype html><html lang="ru"><meta charset="utf-8"><title>OpenGL / Vulkan</title>
<style>body{font:15px system-ui;margin:24px;background:#101922;color:#e5edf5}a{color:#9bceff}
table{border-collapse:collapse;font-size:12px}td,th{padding:7px;border:1px solid #455365}pre{white-space:pre-wrap}</style>
<h1>DSlideShow: OpenGL / Vulkan</h1><p>Видео: инициализация, ошибки и движение позиции проверяются автоматически.
captured_motion означает, что в отдельном захвате композиции найдены движущиеся пиксели видеотекстуры.
Чёрный/статический/недоступный захват даёт неопределённый результат, поскольку embedder может не поддерживать захват Texture.
Физический scanout дисплея захватом не подтверждается. Если native.log сообщает ошибку импорта текстуры, считайте видеопуть неработоспособным.
При аварии процесса подробный HTML может отсутствовать; передайте весь архив с checkpoint и логом.</p>''' + visual_link + ''.join(sections) + (
        f'<p>Окружение для сравнения производительности совпадает: {result["performance_comparable"]}.</p>'
        '<div style="overflow:auto"><table><tr><th>Случай</th><th>GL ошибки</th><th>VK ошибки</th>'
        '<th>GL raster p95 mean</th><th>VK raster p95 mean</th><th>VK/GL raster</th><th>GL stretch</th><th>VK stretch</th></tr>'
        + ''.join(table) + '</table></div><h2>Проверка окружения</h2><pre>'
        + html.escape(json.dumps(result['comparability'], indent=2)) + '</pre></html>')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("directory", type=Path)
    parser.add_argument('--fail-on-errors', action='store_true', help='Exit 2 when collection acceptance is unsuccessful')
    args = parser.parse_args()
    result = collect(args.directory)
    result['visual_audits'] = write_visual_report(args.directory)
    for renderer, report in result['renderers'].items():
        if 'attempts' not in report:
            continue
        target = args.directory / renderer
        (target / 'summary.json').write_text(json.dumps(report, indent=2))
        (target / 'report.html').write_text('<!doctype html><meta charset="utf-8"><title>'
            + renderer + '</title><h1>' + renderer + '</h1><pre>'
            + html.escape(json.dumps(report, ensure_ascii=False, indent=2)) + '</pre>')
    (args.directory / "collection-summary.json").write_text(json.dumps(result, indent=2))
    (args.directory / "report.html").write_text(render(result))
    (args.directory / "README.txt").write_text(
        "Откройте report.html. Передайте весь .tar.gz, включая native.log каждого renderer.\n"
        "Ненулевой exit_code и complete=false требуют проверки лога.\n"
        "FixedAnimationController сохранён; замедление анимации допустимо.\n")
    if args.fail_on_errors and (not result['renderers'] or any(
            not report.get('successful', report.get('complete', False)) for report in result['renderers'].values())):
        raise SystemExit(2)


if __name__ == "__main__":
    main()
