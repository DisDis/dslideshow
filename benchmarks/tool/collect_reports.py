#!/usr/bin/env python3
"""Collect OpenGL/Vulkan results, including native crashes and partial Dart reports."""
import argparse
import html
import json
from pathlib import Path


def read_json(file):
    try:
        return json.loads(file.read_text())
    except (OSError, ValueError):
        return None


def aggregate_renderer(directory, renderer):
    attempts = sorted(p for p in directory.glob('attempt-*') if p.is_dir())
    if not attempts:
        return None
    state = read_json(directory / 'renderer-status.json') or {}
    rows, metadata, warnings, probes = {}, {}, [], {}
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
        last_status = read_json(attempt / 'launcher-status.json') or {}
        last_summary = summary
        launch = launch or read_json(attempt / 'launch.json') or {}
        links.append(attempt.name)
    failures = [a for a in state.get('attempts', []) if a.get('native_failure')]
    descriptors = {r['id']:r for r in state.get('plan', [])}
    for attempt in failures:
        key = attempt.get('last_case_id')
        if key:
            row = rows.setdefault(key, {**descriptors.get(key, {}), 'id':key,
                'runs':0, 'passed':0, 'failed':0, 'frames':0})
            row['native_failures'] = row.get('native_failures', 0) + 1
            row['runs'] = row.get('runs', 0) + 1
            row['failed'] = row.get('failed', 0) + 1
            row.setdefault('errors', []).append(f'Native exit {attempt["exit_code"]}, {attempt["path"]}')
    metadata['video_texture_probes'] = probes
    expected = len(descriptors) or last_summary.get('expected_cases')
    covered = state.get('all_cases_attempted', False) or (
        not descriptors and last_summary.get('observed_cases') == expected
        and last_summary.get('status') in ('completed', 'completed_with_failures'))
    return dict(renderer=renderer, exit_code=last_status.get('exit_code'),
        status='completed_with_native_failures' if covered and failures else last_summary.get('status', 'no_dart_report'),
        metadata=metadata, failed_runs=sum(r.get('failed', 0) for r in rows.values()),
        observed_cases=len(rows) if descriptors else last_summary.get('observed_cases'),
        expected_cases=expected, warnings=warnings, launch=launch, cases=list(rows.values()),
        attempts=links, native_crashes=len(failures), all_cases_attempted=covered,
        complete=covered and not failures and last_summary.get('status') in ('completed', 'completed_with_failures'))


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
            f'все случаи попытаны: {report.get("all_cases_attempted", report["complete"])}.</p>'
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
    return '''<!doctype html><html lang="ru"><meta charset="utf-8"><title>OpenGL / Vulkan</title>
<style>body{font:15px system-ui;margin:24px;background:#101922;color:#e5edf5}a{color:#9bceff}
table{border-collapse:collapse;font-size:12px}td,th{padding:7px;border:1px solid #455365}pre{white-space:pre-wrap}</style>
<h1>DSlideShow: OpenGL / Vulkan</h1><p>Видео: инициализация, ошибки и движение позиции проверяются автоматически.
captured_motion означает, что в отдельном захвате композиции найдены движущиеся пиксели видеотекстуры.
Чёрный/статический/недоступный захват даёт неопределённый результат, поскольку embedder может не поддерживать захват Texture.
Физический scanout дисплея захватом не подтверждается. Если native.log сообщает ошибку импорта текстуры, считайте видеопуть неработоспособным.
При аварии процесса подробный HTML может отсутствовать; передайте весь архив с checkpoint и логом.</p>''' + ''.join(sections) + (
        f'<p>Окружение для сравнения производительности совпадает: {result["performance_comparable"]}.</p>'
        '<div style="overflow:auto"><table><tr><th>Случай</th><th>GL ошибки</th><th>VK ошибки</th>'
        '<th>GL raster p95 mean</th><th>VK raster p95 mean</th><th>VK/GL raster</th><th>GL stretch</th><th>VK stretch</th></tr>'
        + ''.join(table) + '</table></div><h2>Проверка окружения</h2><pre>'
        + html.escape(json.dumps(result['comparability'], indent=2)) + '</pre></html>')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("directory", type=Path)
    args = parser.parse_args()
    result = collect(args.directory)
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


if __name__ == "__main__":
    main()
