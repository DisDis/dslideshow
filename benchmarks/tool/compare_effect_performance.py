#!/usr/bin/env python3
"""Compare raw photo-effect collections without hiding incomplete repetitions.

Usage: compare_effect_performance.py baseline_collection candidate_collection outputdir
"""
import argparse
from collections import defaultdict
import json
import math
from pathlib import Path
import re
from statistics import median


_NATIVE_ERROR = re.compile(
    r'\[(?:ERROR|FATAL)[:\]]|(?:^|\s)(?:ERROR|FATAL):|'
    r'\b(?:SIGSEGV|SIGABRT|segmentation fault|core dumped)\b', re.IGNORECASE)
_DISPLAY_FIELDS = ('physical_width', 'physical_height', 'logical_width',
                   'logical_height', 'pixel_ratio')
_HARDWARE_TEXT_FIELDS = ('model', 'kernel', 'os')
_HARDWARE_INTEGER_FIELDS = ('processors', 'clock_ticks_per_second')


def _number(value, positive=False):
    try:
        return (isinstance(value, (int, float)) and not isinstance(value, bool)
                and math.isfinite(value) and (value > 0 if positive else value >= 0))
    except OverflowError:
        return False


def _integer(value, positive=False):
    return isinstance(value, int) and not isinstance(value, bool) and value >= (1 if positive else 0)


def _finite_float(value):
    number = float(value)
    if not math.isfinite(number):
        raise ValueError('non-finite JSON number')
    return number


def _constant(value):
    raise ValueError(f'non-standard JSON constant {value}')


def _object(pairs):
    result = {}
    for key, value in pairs:
        if key in result:
            raise ValueError(f'duplicate JSON key {key}')
        result[key] = value
    return result


def _decode(text):
    return json.loads(text, parse_float=_finite_float, parse_constant=_constant,
                      object_pairs_hook=_object)


def read_json(path, diagnostics, required=True):
    try:
        value = _decode(path.read_text(encoding='utf-8'))
        if not isinstance(value, dict):
            raise ValueError('expected a JSON object')
        return value
    except (OSError, ValueError, UnicodeError, RecursionError) as error:
        if required or path.exists():
            diagnostics.append(f'{path}: {error}')
        return {}


def read_jsonl(path, diagnostics):
    """Keep valid records after a corrupt line and identify every discarded line."""
    rows = []
    try:
        with path.open('rb') as stream:
            for line_number, line in enumerate(stream, 1):
                if not line.strip():
                    continue
                try:
                    row = _decode(line.decode('utf-8'))
                    if not isinstance(row, dict):
                        raise ValueError('expected a JSON object')
                    rows.append(row)
                except (ValueError, UnicodeError, RecursionError) as error:
                    diagnostics.append(f'{path}:{line_number}: invalid JSONL: {error}')
    except OSError as error:
        diagnostics.append(f'{path}: {error}')
    return rows


def _canonical(value):
    return json.dumps(value, sort_keys=True, separators=(',', ':'), allow_nan=False)


def distribution(values):
    """Pool individual frame times, using the benchmark's linear percentiles."""
    ordered = sorted(values)

    def percentile(fraction):
        if not ordered:
            return None
        index = (len(ordered) - 1) * fraction
        low, high = math.floor(index), math.ceil(index)
        return ordered[low] + (ordered[high] - ordered[low]) * (index - low)

    return dict(count=len(ordered), p50=percentile(.5), p95=percentile(.95),
                p99=percentile(.99), max=ordered[-1] if ordered else None)


def _conditions(metadata, launch, renderer):
    display = metadata.get('display')
    display = display if isinstance(display, dict) else {}
    build = metadata.get('build')
    build = build if isinstance(build, dict) else {}
    flutter = build.get('flutter')
    modes = dict(runtime=metadata.get('build_mode'), artifact=build.get('mode'))
    hardware = metadata.get('hardware')
    hardware = hardware if isinstance(hardware, dict) else {}
    identity = {key: hardware.get(key) for key in (*_HARDWARE_TEXT_FIELDS, *_HARDWARE_INTEGER_FIELDS)}
    identity.update(build_cpu=build.get('cpu'), cpu_governors=hardware.get('cpu_governors'))
    governors = identity['cpu_governors']
    valid_hardware = (
        isinstance(identity['build_cpu'], str) and bool(identity['build_cpu'])
        and all(isinstance(identity[key], str) and bool(identity[key]) for key in _HARDWARE_TEXT_FIELDS)
        and all(_integer(identity[key], positive=True) for key in _HARDWARE_INTEGER_FIELDS)
        and isinstance(governors, dict) and bool(governors)
        and all(isinstance(key, str) and bool(key) and isinstance(value, str) and bool(value)
                for key, value in governors.items()))
    media = metadata.get('media')
    valid_media = isinstance(media, list) and bool(media)
    identities = []
    if valid_media:
        for item in media:
            if not isinstance(item, dict):
                valid_media = False
                continue
            identities.append({key: item.get(key) for key in ('name', 'sha256', 'width', 'height')})
        valid_media = valid_media and all(
            isinstance(item['name'], str) and bool(item['name'])
            and isinstance(item['sha256'], str) and bool(item['sha256'])
            and _number(item['width'], positive=True) and _number(item['height'], positive=True)
            for item in identities)
        valid_media = valid_media and len({item['name'] for item in identities}) == len(identities)
    config = metadata.get('config')
    sha = launch.get('flutter_pi_sha256')
    return {
        'requested_renderer': (metadata.get('requested_renderer') == renderer,
                               metadata.get('requested_renderer')),
        'target_display_matches': (metadata.get('target_display_matches') is True,
                                   metadata.get('target_display_matches')),
        'config': (isinstance(config, dict) and bool(config), config),
        'display': (all(_number(display.get(key), positive=True) for key in _DISPLAY_FIELDS),
                    {key: display.get(key) for key in _DISPLAY_FIELDS}),
        'refresh_hz': (_number(display.get('refresh_hz'), positive=True), display.get('refresh_hz')),
        'release_mode': (all(mode == 'release' for mode in modes.values()), modes),
        'hardware_identity': (bool(valid_hardware), identity),
        'flutter_sdk_engine': (isinstance(flutter, dict) and all(
            isinstance(flutter.get(key), str) and bool(flutter[key])
            for key in ('frameworkVersion', 'frameworkRevision', 'engineRevision', 'dartSdkVersion')), flutter),
        'media': (valid_media, sorted(identities, key=lambda item: str(item['name']))),
        'flutter_pi_sha256': (isinstance(sha, str) and bool(sha), sha),
    }


def compare_conditions(a, b, scope):
    checks = []
    for key in a:
        valid_a, value_a = a[key]
        valid_b, value_b = b[key]
        equal = (abs(value_a - value_b) <= .01 + 1e-12 if key == 'refresh_hz'
                 and valid_a and valid_b else _canonical(value_a) == _canonical(value_b))
        checks.append(dict(scope=scope, condition=key, passed=bool(valid_a and valid_b and equal),
                           baseline=value_a, candidate=value_b,
                           reason=None if valid_a and valid_b and equal else
                           'missing/invalid condition' if not valid_a or not valid_b else 'condition differs'))
    return checks


def _warmup_repeat(repeat, warmups):
    return (isinstance(repeat, int) and not isinstance(repeat, bool)
            and _integer(warmups) and -warmups <= repeat < 0)


def _identity(row, warmups):
    case_id, cycle, repeat = row.get('case_id'), row.get('cycle'), row.get('repeat')
    # BenchmarkRunner emits -warmups..-1 in cycle zero, then measured 0..N-1.
    valid_repeat = (cycle == 0 and _warmup_repeat(repeat, warmups)
                    if row.get('phase') == 'warmup' else _integer(repeat))
    if isinstance(case_id, str) and case_id and _integer(cycle) and valid_repeat:
        return case_id, cycle, repeat
    return None


def _stage_case(stage, warmups):
    if not isinstance(stage, str):
        return None
    phase, separator, rest = stage.partition(':')
    if not separator or phase not in ('prepare', 'warmup', 'measured', 'capture', 'cleanup'):
        return None
    if phase in ('warmup', 'measured'):
        case_id, separator, repeat = rest.rpartition(':')
        if not separator or not case_id:
            return None
        if phase == 'measured':
            return case_id if repeat.isdecimal() else None
        if repeat.startswith('-') and repeat[1:].isdecimal():
            try:
                return case_id if _warmup_repeat(-int(repeat[1:]), warmups) else None
            except ValueError:
                return None
        return None
    return rest


def _memory(samples):
    rss, available, spans = [], [], []
    by_attempt = defaultdict(list)
    for attempt, row in samples:
        by_attempt[attempt]
        if _number(row.get('rss_bytes')):
            rss.append(row['rss_bytes'])
        if _number(row.get('available_memory_bytes')):
            available.append(row['available_memory_bytes'])
        if _number(row.get('swap_free_bytes')):
            by_attempt[attempt].append(row['swap_free_bytes'])
    for attempt, values in by_attempt.items():
        spans.append(dict(attempt=attempt, samples=len(values), first_free_bytes=values[0] if values else None,
                          last_free_bytes=values[-1] if values else None,
                          free_delta_bytes=values[-1] - values[0] if len(values) >= 2 else None))
    complete_delta = bool(spans) and all(span['free_delta_bytes'] is not None for span in spans)
    return dict(samples=len(samples), rss_peak_sampled_bytes=max(rss) if rss else None,
                available_memory_min_bytes=min(available) if available else None,
                swap_free_delta_bytes=sum(span['free_delta_bytes'] for span in spans) if complete_delta else None,
                swap_spans=spans,
                scope='All case-tagged prepare/warmup/measured/capture/cleanup telemetry; '
                      'RSS is sampled process memory. MemAvailable/SwapFree are system-wide, not GPU memory. '
                      'SwapFree delta is last minus first per process attempt, not swap I/O or causal attribution.')


def load_collection(collection, renderer='opengl'):
    root = Path(collection).resolve()
    directory = root / renderer
    diagnostics, errors, attempts, checks = [], [], [], []
    descriptors, samples, frames, telemetry = {}, defaultdict(list), defaultdict(list), defaultdict(list)
    warmup_samples, warmup_frames = defaultdict(list), defaultdict(list)
    planned_ids = set()
    state = read_json(directory / 'renderer-status.json', diagnostics, required=False)
    attempt_paths = sorted(path for path in directory.glob('attempt-*') if path.is_dir())
    if not attempt_paths and directory.is_dir():
        attempt_paths = [directory]
    if not attempt_paths:
        diagnostics.append(f'{directory}: no renderer attempts found')

    def register(descriptor, source, planned=False):
        if not isinstance(descriptor, dict) or not isinstance(descriptor.get('id'), str) or not descriptor['id']:
            diagnostics.append(f'{source}: invalid case descriptor')
            return
        case_id = descriptor['id']
        if planned:
            planned_ids.add(case_id)
        if case_id in descriptors and _canonical(descriptors[case_id]) != _canonical(descriptor):
            diagnostics.append(f'{source}: inconsistent descriptor for {case_id}')
        else:
            descriptors[case_id] = descriptor

    def array(value, source):
        if value is None:
            return []
        if not isinstance(value, list):
            diagnostics.append(f'{source}: expected a JSON array')
            return []
        return value

    for descriptor in array(state.get('plan'), 'renderer-status plan'):
        register(descriptor, 'renderer-status plan', planned=True)
    reference_conditions = None
    for path in attempt_paths:
        name = path.name
        summary = read_json(path / 'summary.json', diagnostics)
        metadata = summary.get('metadata') or {}
        if not isinstance(metadata, dict):
            diagnostics.append(f'{path}/summary.json: invalid metadata')
            metadata = {}
        launch = read_json(path / 'launch.json', diagnostics)
        status = read_json(path / 'launcher-status.json', diagnostics)
        condition = _conditions(metadata, launch, renderer)
        config = metadata.get('config')
        config = config if isinstance(config, dict) else {}
        warmups = config.get('warmups')
        if not _integer(warmups):
            diagnostics.append(f'{name}: missing/invalid expected warmups')
        checks.extend(compare_conditions(reference_conditions or condition, condition, f'{root.name}/{name}'))
        reference_conditions = reference_conditions or condition
        attempts.append(dict(path=str(path), metadata=metadata, launch=launch,
                             status=summary.get('status'), launcher_status=status))
        for descriptor in array(metadata.get('plan'), f'{name} metadata plan'):
            register(descriptor, f'{name} metadata plan', planned=True)
        if summary.get('status') != 'completed':
            errors.append(dict(attempt=name, kind='collection_status', status=summary.get('status')))
        if status.get('exit_code') != 0:
            errors.append(dict(attempt=name, kind='launcher_exit', exit_code=status.get('exit_code')))
        for key in ('runtime_errors', 'cleanup_errors'):
            if metadata.get(key) not in (None, 0):
                errors.append(dict(attempt=name, kind=key, count=metadata[key]))
        for key in ('error_events', 'failed_runs', 'unsupported_cases'):
            if summary.get(key) not in (None, 0):
                errors.append(dict(attempt=name, kind=key, count=summary[key]))
        if summary.get('error_counts'):
            errors.append(dict(attempt=name, kind='error_counts', counts=summary['error_counts']))
        for event in read_jsonl(path / 'errors.jsonl', diagnostics):
            errors.append(dict(event, attempt=name))
        warmup_keys = set()
        for row in read_jsonl(path / 'runs.jsonl', diagnostics):
            if row.get('phase') != 'measured' and (
                    row.get('phase') != 'warmup' or row.get('status') != 'passed' or row.get('error')):
                errors.append(dict(attempt=name, kind='non_measured_run', run=row))
            key = _identity(row, warmups)
            if key is None:
                diagnostics.append(f'{name}/runs.jsonl: invalid case/cycle/repeat identity')
                continue
            if row.get('case'):
                register(row['case'], f'{name} run {key}')
            if row.get('phase') == 'measured':
                samples[key[0]].append((name, row))
            elif row.get('phase') == 'warmup':
                warmup_samples[key[0]].append((name, row))
                if key in warmup_keys:
                    diagnostics.append(f'{name}/runs.jsonl: duplicate warmup identity {key}')
                warmup_keys.add(key)
        for row in read_jsonl(path / 'frames.jsonl', diagnostics):
            if row.get('phase') == 'measured':
                key = _identity(row, warmups)
                if key is None:
                    diagnostics.append(f'{name}/frames.jsonl: invalid case/cycle/repeat identity')
                else:
                    frames[(name, *key)].append(row)
            elif row.get('phase') == 'warmup':
                key = _identity(row, warmups)
                if key is None:
                    diagnostics.append(f'{name}/frames.jsonl: invalid warmup case/cycle/repeat identity')
                else:
                    warmup_frames[(name, *key)].append(row)
            else:
                diagnostics.append(f'{name}/frames.jsonl: unknown frame phase {row.get("phase")}')
        for row in read_jsonl(path / 'telemetry.jsonl', diagnostics):
            case_id = _stage_case(row.get('stage'), warmups)
            if case_id:
                telemetry[case_id].append((name, row))
        native = path / 'native.log'
        try:
            for number, line in enumerate(native.read_text(encoding='utf-8', errors='replace').splitlines(), 1):
                if not line.startswith('BENCHMARK') and _NATIVE_ERROR.search(line):
                    errors.append(dict(attempt=name, kind='native_log', line=number, error=line))
        except OSError as error:
            diagnostics.append(f'{native}: required native log unavailable: {error}')
    for attempt in array(state.get('attempts'), 'renderer-status attempts'):
        if not isinstance(attempt, dict):
            diagnostics.append('renderer-status attempts: invalid attempt object')
            continue
        if attempt.get('native_failure'):
            errors.append(dict(kind='native_failure', **attempt))
    metadata = attempts[0]['metadata'] if attempts else {}
    plan_ids = planned_ids
    if not plan_ids:
        diagnostics.append('missing/empty expected case plan; observed runs cannot establish coverage')
    for key in set(samples) - plan_ids:
        diagnostics.append(f'measured case {key} has no plan descriptor')
    for key in set(warmup_samples) - plan_ids:
        diagnostics.append(f'warmup case {key} has no plan descriptor')
    case_ids = (plan_ids | set(samples) | set(warmup_samples)
                | {key[1] for key in frames} | {key[1] for key in warmup_frames})
    config = metadata.get('config')
    config = config if isinstance(config, dict) else {}
    repeats, cycles = config.get('repeats'), metadata.get('cycles', 1)
    if not _integer(repeats, positive=True) or not _integer(cycles, positive=True):
        diagnostics.append('missing/invalid expected repeats or cycles')
        expected = None
    else:
        expected = {(cycle, repeat) for cycle in range(cycles) for repeat in range(repeats)}
    warmups = config.get('warmups')
    expected_warmups = {(0, repeat) for repeat in range(-warmups, 0)} if _integer(warmups) else None
    cases = {}
    for case_id in sorted(case_ids):
        runs = samples[case_id]
        issues, passed, fps, builds, rasters, run_records = [], [], [], [], [], []
        identities = defaultdict(list)
        pooled_keys = set()
        warmup_runs = warmup_samples[case_id]
        warmup_identities = defaultdict(list)
        warmup_records = []
        for attempt, run in warmup_runs:
            warmup_identities[(run['cycle'], run['repeat'])].append(run)
            key = (attempt, case_id, run['cycle'], run['repeat'])
            raw = warmup_frames.get(key, [])
            warmup_records.append(dict(attempt=attempt, cycle=run['cycle'], repeat=run['repeat'],
                                       status=run.get('status'), error=run.get('error'),
                                       reported_frames=run.get('frames'), raw_frames=len(raw)))
            if run.get('status') != 'passed' or run.get('error'):
                issues.append(f'{attempt} warmup={run["repeat"]}: {run.get("error") or run.get("status")}')
            if not _integer(run.get('frames'), positive=True) or run['frames'] != len(raw):
                issues.append(f'{attempt} warmup={run["repeat"]}: raw/reported warmup frame count differs or is missing')
        missing_warmups = sorted(expected_warmups - warmup_identities.keys()) if expected_warmups is not None else None
        duplicate_warmups = [list(key) for key, values in warmup_identities.items() if len(values) != 1]
        if missing_warmups:
            issues.append(f'missing warmup repetitions: {missing_warmups}')
        if duplicate_warmups:
            issues.append(f'duplicate warmup repetitions: {duplicate_warmups}')
        known_warmup_keys = {(attempt, case_id, run['cycle'], run['repeat']) for attempt, run in warmup_runs}
        orphan_warmup_frames = sum(len(value) for key, value in warmup_frames.items()
                                  if key[1] == case_id and key not in known_warmup_keys)
        if orphan_warmup_frames:
            issues.append(f'{orphan_warmup_frames} raw frames have no warmup run')
        for attempt, run in runs:
            identities[(run['cycle'], run['repeat'])].append(run)
            key = (attempt, case_id, run['cycle'], run['repeat'])
            raw = frames.get(key, [])
            record = dict(attempt=attempt, cycle=run['cycle'], repeat=run['repeat'],
                          status=run.get('status'), sampled_fps=run.get('sampled_fps'),
                          reported_frames=run.get('frames'), raw_frames=len(raw), error=run.get('error'))
            run_records.append(record)
            if run.get('status') != 'passed':
                issues.append(f'{attempt} cycle={run["cycle"]} repeat={run["repeat"]}: {run.get("error") or run.get("status")}')
                continue
            if run.get('error'):
                issues.append(f'{attempt} repeat={run["repeat"]}: passed run contains error: {run["error"]}')
            passed.append(run)
            if _number(run.get('sampled_fps'), positive=True):
                fps.append(run['sampled_fps'])
            else:
                issues.append(f'{attempt} repeat={run["repeat"]}: invalid/missing FPS')
            if not _integer(run.get('frames'), positive=True) or run['frames'] != len(raw):
                issues.append(f'{attempt} repeat={run["repeat"]}: raw/reported frame count differs or is missing')
            if key in pooled_keys:
                continue
            pooled_keys.add(key)
            vsyncs = set()
            for frame in raw:
                vsync = frame.get('vsync_us')
                if not _integer(vsync) or vsync in vsyncs:
                    issues.append(f'{attempt} repeat={run["repeat"]}: invalid/duplicate frame timestamp')
                if _integer(vsync):
                    vsyncs.add(vsync)
                if _number(frame.get('build_us')) and _number(frame.get('raster_us')):
                    builds.append(frame['build_us'] / 1000)
                    rasters.append(frame['raster_us'] / 1000)
                else:
                    issues.append(f'{attempt} repeat={run["repeat"]}: invalid frame timing')
        missing = sorted(expected - identities.keys()) if expected is not None else None
        extra = sorted(identities.keys() - expected) if expected is not None else []
        duplicates = [list(key) for key, values in identities.items() if len(values) != 1]
        if missing:
            issues.append(f'missing measured repetitions: {missing}')
        if extra:
            issues.append(f'unexpected measured repetitions: {extra}')
        if duplicates:
            issues.append(f'duplicate measured repetitions: {duplicates}')
        known_keys = {(attempt, case_id, run['cycle'], run['repeat']) for attempt, run in runs}
        orphan_frames = sum(len(value) for key, value in frames.items() if key[1] == case_id and key not in known_keys)
        if orphan_frames:
            issues.append(f'{orphan_frames} raw frames have no measured run')
        cases[case_id] = dict(descriptor=descriptors.get(case_id), expected_runs=len(expected) if expected is not None else None,
                              observed_runs=len(runs), passed_runs=len(passed), failed_runs=len(runs) - len(passed),
                              expected_warmup_runs=len(expected_warmups) if expected_warmups is not None else None,
                              observed_warmup_runs=len(warmup_runs),
                              passed_warmup_runs=sum(run.get('status') == 'passed' and not run.get('error')
                                                     for _, run in warmup_runs),
                              missing_warmup_repetitions=missing_warmups,
                              duplicate_warmup_repetitions=duplicate_warmups, warmups=warmup_records,
                              missing_repetitions=missing, duplicate_repetitions=duplicates,
                              runs=run_records, fps_median=median(fps) if fps else None,
                              ui_ms=distribution(builds), raster_ms=distribution(rasters),
                              memory=_memory(telemetry[case_id]), issues=issues,
                              complete=expected is not None and expected_warmups is not None and bool(runs) and not issues)
    return dict(collection=str(root), renderer=renderer, metadata=metadata, attempts=attempts,
                renderer_state=state, diagnostics=diagnostics, errors=errors,
                conditions=checks, cases=cases), reference_conditions


def compare(baseline_collection, candidate_collection, renderer='opengl'):
    baseline, baseline_conditions = load_collection(baseline_collection, renderer)
    candidate, candidate_conditions = load_collection(candidate_collection, renderer)
    checks = baseline['conditions'] + candidate['conditions']
    if baseline_conditions and candidate_conditions:
        checks += compare_conditions(baseline_conditions, candidate_conditions, 'baseline vs candidate')
    conditions_match = bool(checks) and bool(baseline_conditions) and bool(candidate_conditions) and all(check['passed'] for check in checks)
    rows = []
    for case_id in sorted(set(baseline['cases']) | set(candidate['cases'])):
        a, b = baseline['cases'].get(case_id), candidate['cases'].get(case_id)
        same_descriptor = bool(a and b and a['descriptor'] and b['descriptor']) and _canonical(a['descriptor']) == _canonical(b['descriptor'])
        comparison_issues = []
        if not a or not b:
            comparison_issues.append('case is missing from one collection')
        if not same_descriptor:
            comparison_issues.append('case descriptors differ or are missing')
        if a and b and a['expected_runs'] != b['expected_runs']:
            comparison_issues.append('expected repetition/cycle counts differ')
        valid = bool(conditions_match and same_descriptor and a['complete'] and b['complete']
                     and a['expected_runs'] == b['expected_runs']
                     and not baseline['diagnostics'] and not candidate['diagnostics']
                     and not baseline['errors'] and not candidate['errors'])
        changes = {}
        if valid:
            changes['fps_percent'] = (b['fps_median'] / a['fps_median'] - 1) * 100
            for metric in ('ui_ms', 'raster_ms'):
                changes[metric] = {key: b[metric][key] - a[metric][key]
                                   for key in ('p50', 'p95', 'p99', 'max')}
        rows.append(dict(id=case_id, baseline=a, candidate=b, descriptors_match=bool(same_descriptor),
                         comparison_issues=comparison_issues, comparison_eligible=valid, changes=changes))
    return dict(schema_version=1, renderer=renderer, baseline=baseline, candidate=candidate,
                conditions=checks, performance_comparable=conditions_match, cases=rows,
                comparison_ready=bool(rows) and all(row['comparison_eligible'] for row in rows),
                acceptance='not_assessed',
                notes=['FPS is the median of passed measured repetitions, not display scanout.',
                       'UI/raster distributions pool raw frames from passed measured runs; failed and missing runs stay explicit.',
                       'Warmups use negative repeat IDs -config.warmups..-1 in cycle zero; their frames are excluded '
                       'from measured FPS/tails, while their case-tagged telemetry remains in memory samples.',
                       'Every expected warmup must be present once with matching reported/raw frame counts; '
                       'missing, duplicate, failed and orphan warmup data prevent comparison eligibility.',
                       'Hardware identity compares build CPU, model, kernel, OS, processor count, clock ticks and governor policies; '
                       'dynamic clock/temperature/throttle readings are retained separately. This metadata has no board serial.',
                       'comparison_ready checks report consistency only; manual validation of the benchmark harness '
                       'and intended live-view multiplicity is required before accepting performance results.',
                       'Historical timings from the shared-GlobalKey harness are invalid for repeated media views '
                       'and cannot support acceptance, even when stored conditions match.',
                       'A clean performance comparison does not establish visual quality or hardware acceptance.'])


def _format(value):
    return '—' if value is None else f'{value:.2f}'


def render(result):
    lines = ['# Effect performance comparison', '',
             f'Renderer: `{result["renderer"]}`. Conditions match: {result["performance_comparable"]}. '
             f'All measurements comparable: {result["comparison_ready"]}. Acceptance: not assessed.', '',
             *result['notes'], '',
             '| Case | Passed / expected B → C | FPS median B → C | FPS change, % | Raster pooled p95 B → C, ms | Eligible |',
             '| --- | --- | --- | --- | --- | --- |']
    for row in result['cases']:
        a, b = row['baseline'] or {}, row['candidate'] or {}
        label = row['id'].replace('|', '\\|').replace('\n', ' ')
        counts = f'{a.get("passed_runs", "—")}/{a.get("expected_runs", "—")} → {b.get("passed_runs", "—")}/{b.get("expected_runs", "—")}'
        fps = f'{_format(a.get("fps_median"))} → {_format(b.get("fps_median"))}'
        raster = f'{_format(a.get("raster_ms", {}).get("p95"))} → {_format(b.get("raster_ms", {}).get("p95"))}'
        change = _format(row['changes'].get('fps_percent'))
        lines.append(f'| {label} | {counts} | {fps} | {change} | {raster} | {row["comparison_eligible"]} |')
    lines += ['', 'Pooled frame distributions (p50 / p95 / p99 / max, ms):', '',
              '| Case | UI baseline | UI candidate | Raster baseline | Raster candidate |',
              '| --- | --- | --- | --- | --- |']
    for row in result['cases']:
        label = row['id'].replace('|', '\\|').replace('\n', ' ')
        cells = []
        for metric in ('ui_ms', 'raster_ms'):
            for side in ('baseline', 'candidate'):
                times = (row[side] or {}).get(metric, {})
                cells.append(' / '.join(_format(times.get(key)) for key in ('p50', 'p95', 'p99', 'max')))
        lines.append(f'| {label} | ' + ' | '.join(cells) + ' |')
    lines += ['', '| Case | Sampled process RSS peak B → C, MiB | System MemAvailable min B → C, MiB | System SwapFree delta B → C, MiB |',
              '| --- | --- | --- | --- |']
    for row in result['cases']:
        label = row['id'].replace('|', '\\|').replace('\n', ' ')
        cells = []
        for metric in ('rss_peak_sampled_bytes', 'available_memory_min_bytes', 'swap_free_delta_bytes'):
            values = [(row[side] or {}).get('memory', {}).get(metric) for side in ('baseline', 'candidate')]
            cells.append(' → '.join(_format(value / 1048576 if value is not None else None) for value in values))
        lines.append(f'| {label} | ' + ' | '.join(cells) + ' |')
    lines += ['', 'Detailed pooled p50/p95/p99/max, per-run status, plan/descriptors, telemetry and provenance '
              'are saved in [comparison.json](comparison.json). Missing values remain null/—.', '',
              'Memory reports sampled process RSS and system MemAvailable/SwapFree across all case-tagged phases. '
              'These are not GPU memory measurements; RSS/HWM and SwapFree do not prove a leak or swap I/O.', '']
    failures = [check for check in result['conditions'] if not check['passed']]
    for check in failures:
        lines.append(f'- Condition {check["scope"]} / {check["condition"]}: {check["reason"]}')
    for side in ('baseline', 'candidate'):
        report = result[side]
        lines += [f'- {side}: {report["collection"]}']
        lines += [f'  - {text}' for text in report['diagnostics']]
        lines += [f'  - Error: {json.dumps(error, ensure_ascii=False)}' for error in report['errors']]
        for row in result['cases']:
            case = row[side]
            if case is None:
                lines.append(f'  - Missing case: {row["id"]}')
            else:
                lines += [f'  - {row["id"]}: {issue}' for issue in case['issues']]
    for row in result['cases']:
        lines += [f'- {row["id"]}: {issue}' for issue in row['comparison_issues']]
    return '\n'.join(lines) + '\n'


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('baseline_collection', type=Path)
    parser.add_argument('candidate_collection', type=Path)
    parser.add_argument('outputdir', type=Path)
    parser.add_argument('--renderer', choices=('opengl', 'vulkan'), default='opengl')
    args = parser.parse_args(argv)
    result = compare(args.baseline_collection, args.candidate_collection, args.renderer)
    args.outputdir.mkdir(parents=True, exist_ok=True)
    (args.outputdir / 'comparison.json').write_text(json.dumps(result, indent=2, allow_nan=False) + '\n', encoding='utf-8')
    (args.outputdir / 'report.md').write_text(render(result), encoding='utf-8')
    print(json.dumps(dict(cases=len(result['cases']), comparison_ready=result['comparison_ready'],
                          performance_comparable=result['performance_comparable'], output=str(args.outputdir))))
    return 0 if result['comparison_ready'] else 2


if __name__ == '__main__':
    raise SystemExit(main())
