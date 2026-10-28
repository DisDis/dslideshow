#!/usr/bin/env python3
"""Correlate diagnostic native calls, FrameTiming windows and private V3D/DRM traces.

Usage: analyze.py COLLECTION_OR_ATTEMPT OUTPUT --native calls.bin --trace-dir TRACE
This is diagnostic instrumentation, never an optimization FPS acceptance report.
"""
import argparse
from collections import Counter, defaultdict
from enum import Enum, IntEnum
import hashlib
import json
import math
from pathlib import Path
import re
import struct


_HEADER = struct.Struct('<8s8I6Q2I32s')
_RECORD = struct.Struct('<IHH5QIiq6QI12s')
_TRACE_LINE = re.compile(r'(?P<time>\d+\.\d+):\s+(?P<event>(?:\w+:)?\w+):\s*(?P<data>.*)$')
_FIELD = re.compile(r'([A-Za-z_]\w*)=([^\s,]+)')
_CLOCK = re.compile(r'\[([^\]]+)\]')
_CL_TYPE = re.compile(r'(?:^|,\s*)(RCL|BCL)(?=\s*(?:,|$))')
_SHA256 = re.compile(r'[0-9a-f]{64}')
_NATIVE_ERROR = re.compile(r'\b(?:ERROR|FATAL|SIGSEGV|SIGABRT|segmentation fault|core dumped)\b', re.IGNORECASE)


class Phase(str, Enum):
    MEASURED = 'measured'
    WARMUP = 'warmup'


class NativeClosure(str, Enum):
    NORMAL = 'normal_destructor'
    EXTERNAL = 'external_finalization'
    UNVERIFIED = 'unverified'


class Function(IntEnum):
    EGL_SWAP = 1
    EGL_MAKE_CURRENT = 2
    GBM_LOCK = 3
    GBM_RELEASE = 4
    DRM_ATOMIC = 5
    DRM_PAGE_FLIP = 6
    EGL_CREATE_WINDOW = 7


_FUNCTION_NAMES = {
    Function.EGL_SWAP: 'eglSwapBuffers', Function.EGL_MAKE_CURRENT: 'eglMakeCurrent',
    Function.GBM_LOCK: 'gbm_surface_lock_front_buffer',
    Function.GBM_RELEASE: 'gbm_surface_release_buffer',
    Function.DRM_ATOMIC: 'drmModeAtomicCommit', Function.DRM_PAGE_FLIP: 'drmModePageFlip',
    Function.EGL_CREATE_WINDOW: 'eglCreateWindowSurface',
}


def _integer(value, positive=False):
    return isinstance(value, int) and not isinstance(value, bool) and value >= (1 if positive else 0)


def _mapping(value):
    return value if isinstance(value, dict) else {}


def _sha256(path):
    """Hash immutable input, rejecting replacement/modification during the read."""
    before = path.stat()
    digest = hashlib.sha256()
    with path.open('rb') as source:
        for block in iter(lambda: source.read(1024*1024), b''):
            digest.update(block)
    after = path.stat()
    fields = ('st_dev','st_ino','st_size','st_mtime_ns','st_ctime_ns')
    if any(getattr(before,key) != getattr(after,key) for key in fields):
        raise ValueError(f'{path}: input changed while hashing')
    return digest.hexdigest(), after.st_size


def _pairs(pairs):
    result = {}
    for key, value in pairs:
        if key in result:
            raise ValueError(f'duplicate JSON key {key}')
        result[key] = value
    return result


def _constant(value):
    raise ValueError(f'non-standard JSON constant {value}')


def _float(value):
    number = float(value)
    if not math.isfinite(number):
        raise ValueError('non-finite JSON number')
    return number


def _decode(text):
    return json.loads(text, object_pairs_hook=_pairs, parse_constant=_constant, parse_float=_float)


def read_json(path, diagnostics):
    try:
        result = _decode(path.read_text(encoding='utf-8'))
        if not isinstance(result, dict):
            raise ValueError('expected JSON object')
        return result
    except (OSError, ValueError, UnicodeError, RecursionError) as error:
        diagnostics.append(f'{path}: {error}')
        return {}


def read_jsonl(path, diagnostics):
    result = []
    try:
        with path.open('rb') as source:
            for number, line in enumerate(source, 1):
                if not line.strip():
                    continue
                try:
                    value = _decode(line.decode('utf-8'))
                    if not isinstance(value, dict):
                        raise ValueError('expected JSON object')
                    result.append(value)
                except (ValueError, UnicodeError, RecursionError) as error:
                    diagnostics.append(f'{path}:{number}: {error}')
    except OSError as error:
        diagnostics.append(f'{path}: {error}')
    return result


def distribution(values):
    values = sorted(values)
    def percentile(fraction):
        if not values:
            return None
        index = (len(values)-1)*fraction
        lo, hi = math.floor(index), math.ceil(index)
        return values[lo] + (values[hi]-values[lo])*(index-lo)
    return dict(count=len(values), p50=percentile(.5), p95=percentile(.95),
                p99=percentile(.99), max=values[-1] if values else None)


def union_ns(intervals, start=None, end=None):
    """Union wall intervals after clipping, without double-counting overlap."""
    clipped = sorted((max(a, start) if start is not None else a,
                      min(b, end) if end is not None else b) for a, b in intervals)
    total, previous = 0, None
    for a, b in clipped:
        if b <= a:
            continue
        if previous is None or a > previous[1]:
            if previous is not None:
                total += previous[1]-previous[0]
            previous = (a, b)
        else:
            previous = (previous[0], max(previous[1], b))
    return total + (previous[1]-previous[0] if previous is not None else 0)


def read_native(path):
    diagnostics, warnings, calls = [], [], []
    header = {}
    try:
        with path.open('rb') as source:
            raw = source.read(_HEADER.size)
            if len(raw) != _HEADER.size:
                raise ValueError('truncated native header')
            values = _HEADER.unpack(raw)
            (magic, version, endian, header_size, record_size, capacity, pid, flags,
             init_errno, reserved, committed, dropped, started, realtime, closed,
             lifecycle, clock_errors, _) = values
            header = dict(version=version, endian=endian, header_size=header_size,
                          record_size=record_size, capacity=capacity, pid=pid, flags=flags,
                          init_errno=init_errno, reserved_count=reserved, committed_count=committed,
                          dropped_count=dropped, start_monotonic_ns=started,
                          start_realtime_ns=realtime, closed_monotonic_ns=closed,
                          lifecycle=lifecycle, clock_errors=clock_errors)
            if (magic != b'NPIPV001' or version != 1 or endian != 0x01020304
                    or header_size != _HEADER.size or record_size != _RECORD.size
                    or not capacity or not pid or not started):
                raise ValueError('unsupported/invalid native binary header')
            if path.stat().st_size != header_size+capacity*record_size:
                diagnostics.append('native file length differs from preallocated header capacity')
            if init_errno or clock_errors:
                diagnostics.append(f'native initialization/clock errors: errno={init_errno}, clock_errors={clock_errors}')
            if flags != 3:
                diagnostics.append('native v1 capture flags do not identify instrumented mmap timings')
            if dropped or reserved > capacity:
                diagnostics.append(f'native capture overflow: dropped={dropped}, reserved={reserved}, capacity={capacity}')
            if lifecycle not in (1, 2) or (closed and closed < started):
                diagnostics.append('invalid native lifecycle timestamps')
            if lifecycle == 2 and not closed:
                diagnostics.append('normal native destructor has no closing timestamp')
            if lifecycle != 2 or not closed:
                warnings.append('native capture has no normal-destructor closure; committed records remain observable')
            observed_committed, pending = 0, 0
            for index in range(min(reserved, capacity)):
                raw = source.read(record_size)
                if len(raw) != record_size:
                    diagnostics.append(f'native record {index+1}: truncated')
                    break
                v = _RECORD.unpack(raw)
                if v[0] == 0:
                    pending += 1
                    continue
                if v[0] != 1:
                    diagnostics.append(f'native record {index+1}: unknown commit state {v[0]}')
                    continue
                observed_committed += 1
                try:
                    function = Function(v[1])
                except ValueError:
                    diagnostics.append(f'native record {index+1}: unknown function {v[1]}')
                    continue
                _, _, depth, sequence, start, end, cpu_start, cpu_end, tid, result_errno, result, *tail = v
                if (sequence != index+1 or not tid or start < started or end < start
                        or cpu_end < cpu_start or cpu_end-cpu_start > end-start+1000
                        or (closed and end > closed)):
                    diagnostics.append(f'native record {index+1}: invalid sequence/clock/thread fields')
                    continue
                failed = (result == 0 if function in (Function.EGL_SWAP, Function.EGL_MAKE_CURRENT,
                                                      Function.GBM_LOCK, Function.EGL_CREATE_WINDOW)
                          else result != 0 if function in (Function.DRM_ATOMIC, Function.DRM_PAGE_FLIP) else False)
                calls.append(dict(function=_FUNCTION_NAMES[function], function_id=int(function),
                                  sequence=sequence, depth=depth, start_ns=start, end_ns=end,
                                  cpu_start_ns=cpu_start, cpu_end_ns=cpu_end, tid=tid,
                                  result=result, result_errno=result_errno, entry_errno=tail[6],
                                  args=[f'0x{arg:016x}' for arg in tail[:6]], failed=failed))
            header.update(observed_committed=observed_committed, pending_count=pending)
            if pending or observed_committed != committed or committed > reserved:
                diagnostics.append(f'native uncommitted/counter mismatch: pending={pending}, header={committed}, observed={observed_committed}')
            if not calls:
                diagnostics.append('native capture contains no valid committed calls')
    except (OSError, ValueError, struct.error) as error:
        diagnostics.append(f'{path}: {error}')
    closed = bool(header.get('lifecycle') == 2 and header.get('closed_monotonic_ns'))
    return dict(path=str(path), header=header, calls=calls, diagnostics=diagnostics,
                warnings=warnings, complete=bool(header) and not diagnostics and closed,
                closure=NativeClosure.NORMAL.value if closed else NativeClosure.UNVERIFIED.value,
                effective_end_ns=header.get('closed_monotonic_ns') if closed else None,
                clock='CLOCK_MONOTONIC', cpu_clock='CLOCK_THREAD_CPUTIME_ID')


def _int_field(fields, name):
    value = fields.get(name)
    if value is None:
        return None
    try:
        return int(value, 16 if value.lower().startswith('0x') else 10)
    except ValueError:
        return None


def read_trace(directory):
    diagnostics = []
    provenance = read_json(directory/'trace-provenance.json', diagnostics)
    stats = read_json(directory/'trace-stats.json', diagnostics)
    clock = provenance.get('trace_clock', '')
    clocks = _CLOCK.findall(clock) if isinstance(clock, str) else []
    if not (clock == 'mono' or clocks == ['mono']):
        diagnostics.append('trace clock is not verified mono')
    started = _mapping(provenance.get('started')).get('monotonic_ns')
    stopped = _mapping(provenance.get('stopped')).get('monotonic_ns')
    if not _integer(started, True) or not _integer(stopped, True) or stopped <= started:
        diagnostics.append('trace monotonic recording span missing/invalid')
    if provenance.get('schema_version') != 1 or provenance.get('status') not in ('stopped', 'closed'):
        diagnostics.append('trace provenance is not a completed v1 capture')
    if provenance.get('error') or provenance.get('cleanup_errors'):
        diagnostics.append('trace capture/cleanup reports errors')
    if provenance.get('missing_required'):
        diagnostics.append(f'trace missing required events: {provenance["missing_required"]}')
    if (stats.get('schema_version') != 1 or stats.get('stats_complete') is not True
            or stats.get('loss_detected') is not False or stats.get('missing_cpus')):
        diagnostics.append('trace loss statistics are missing, incomplete or report loss')
    per_cpu = stats.get('per_cpu')
    if not isinstance(per_cpu, dict) or not per_cpu:
        diagnostics.append('trace per-CPU loss counters are absent')
    else:
        for cpu, record in per_cpu.items():
            counters = record.get('counters') if isinstance(record, dict) else None
            if (not isinstance(counters, dict) or any(not _integer(counters.get(key))
                    or counters[key] != 0 for key in ('overrun','commit_overrun','dropped_events'))):
                diagnostics.append(f'trace loss counters incomplete/nonzero: {cpu}')
    initial_cpus = provenance.get('initial_cpus')
    if (not isinstance(initial_cpus,list) or not initial_cpus
            or not all(isinstance(cpu,str) for cpu in initial_cpus)
            or len(set(initial_cpus)) != len(initial_cpus)
            or set(initial_cpus) != set(_mapping(per_cpu))):
        diagnostics.append('trace statistics do not cover exactly the recorded initial CPUs')
    events = _mapping(provenance.get('events'))
    for event in ('v3d/v3d_rcl_irq', 'drm/drm_vblank_event_queued', 'drm/drm_vblank_event_delivered'):
        info = _mapping(events.get(event))
        if info.get('available') is not True or info.get('selected') is not True or not info.get('format'):
            diagnostics.append(f'RCL correlation event unavailable/unverified: {event}')
    if not any(_mapping(events.get(event)).get('available') is True
               and _mapping(events.get(event)).get('selected') is True
               and _mapping(events.get(event)).get('format')
               for event in ('v3d/v3d_submit_cl', 'v3d/v3d_submit_cl_ioctl')):
        diagnostics.append('RCL submission event unavailable/unverified')
    submit_event = ('v3d_submit_cl' if _mapping(events.get('v3d/v3d_submit_cl')).get('selected') is True
                    else 'v3d_submit_cl_ioctl')
    submits, irqs, drm = defaultdict(list), defaultdict(list), defaultdict(list)
    counts = Counter()
    try:
        with (directory/'trace.txt').open(encoding='utf-8') as source:
            for number, line in enumerate(source, 1):
                if not line.strip() or line.lstrip().startswith('#'):
                    continue
                match = _TRACE_LINE.search(line.rstrip())
                if not match:
                    diagnostics.append(f'trace.txt:{number}: unparsed event line')
                    continue
                name = match['event'].rsplit(':', 1)[-1]
                seconds, dot, fraction = match['time'].partition('.')
                timestamp = int(seconds)*1000000000 + int((fraction+'000000000')[:9])
                counts[name] += 1
                fields_list = _FIELD.findall(match['data'])
                fields = dict(fields_list)
                if len(fields) != len(fields_list):
                    diagnostics.append(f'trace.txt:{number}: duplicate event fields')
                    continue
                if _integer(started, True) and _integer(stopped, True) and not started <= timestamp <= stopped:
                    diagnostics.append(f'trace.txt:{number}: event outside recording clock span')
                if name in ('v3d_submit_cl', 'v3d_submit_cl_ioctl'):
                    if name != submit_event:
                        continue # Prefer scheduler CL events over an optional ioctl tracepoint.
                    bare_types = _CL_TYPE.findall(match['data'])
                    kind = fields.get('type') or (bare_types[0] if len(bare_types)==1 else None)
                    if fields.get('type') and bare_types and bare_types != [fields['type']]:
                        diagnostics.append(f'trace.txt:{number}: contradictory CL types')
                        continue
                    if kind not in ('RCL', 'BCL'):
                        diagnostics.append(f'trace.txt:{number}: CL submission has no explicit RCL/BCL type')
                        continue
                    dev, sequence = _int_field(fields, 'dev'), _int_field(fields, 'seqno')
                    if dev is None or sequence is None or dev < 0 or sequence < 0:
                        diagnostics.append(f'trace.txt:{number}: CL submission lacks dev/seqno')
                        continue
                    submits[(dev, sequence, kind)].append(timestamp)
                elif name in ('v3d_rcl_irq', 'v3d_bcl_irq'):
                    dev, sequence = _int_field(fields, 'dev'), _int_field(fields, 'seqno')
                    if dev is None or sequence is None or dev < 0 or sequence < 0:
                        diagnostics.append(f'trace.txt:{number}: CL IRQ lacks dev/seqno')
                        continue
                    irqs[(dev, sequence, 'RCL' if name == 'v3d_rcl_irq' else 'BCL')].append(timestamp)
                elif name in ('drm_vblank_event_delivered', 'drm_vblank_event_queued'):
                    devfile, crtc = fields.get('file'), _int_field(fields, 'crtc')
                    if devfile is None or crtc is None:
                        diagnostics.append(f'trace.txt:{number}: DRM event lacks file/CRTC')
                        continue
                    drm[(devfile, crtc, name)].append(timestamp)
    except (OSError, UnicodeError) as error:
        diagnostics.append(f'{directory}/trace.txt: {error}')
    jobs, unmatched = [], []
    for key in sorted(set(submits) | set(irqs)):
        if key[2] != 'RCL':
            continue
        starts, ends = submits[key], irqs[key]
        if len(starts) != 1 or len(ends) != 1 or ends[0] < starts[0]:
            unmatched.append(dict(dev=key[0], seqno=key[1], type=key[2], submits=starts, irqs=ends))
        else:
            jobs.append(dict(dev=key[0], seqno=key[1], type=key[2], start_ns=starts[0], end_ns=ends[0]))
    non_pairing_diagnostics = list(diagnostics)
    if unmatched:
        diagnostics.append(f'{len(unmatched)} unmatched/ambiguous/reversed RCL job identities')
    if not jobs:
        diagnostics.append('no paired RCL observations; GPU idle/zero coverage cannot be inferred')
    return dict(directory=str(directory), provenance=provenance, stats=stats, diagnostics=diagnostics,
                non_pairing_diagnostics=non_pairing_diagnostics,
                event_counts=dict(counts), jobs=sorted(jobs, key=lambda j:j['start_ns']),
                unmatched=unmatched, drm=drm, start_ns=started, end_ns=stopped,
                complete=not diagnostics, raw_complete=not diagnostics,
                selected_windows_complete=not diagnostics)


def scope_trace_to_windows(trace, windows):
    """Retain raw incompleteness while bounding one safe class of orphan IRQ.

    A single observed IRQ without a submit has a known completion instant. If
    that instant precedes *all* usable warmup and measured windows, its missing
    start cannot change any evaluated interval. An unclosed submit has no such
    bound. This does not identify which process submitted the orphan job.
    """
    known = bool(windows) and all(w['start_ns'] is not None and w['end_ns'] is not None
                                  and w['start_ns'] < w['end_ns'] for w in windows)
    earliest = min((w['start_ns'] for w in windows),default=None) if known else None
    unmatched, warnings = [], []
    for record in trace['unmatched']:
        bounded = (earliest is not None and not record['submits'] and len(record['irqs']) == 1
                   and record['irqs'][0] < earliest)
        item = dict(record, outside_all_windows=bounded)
        if bounded:
            item['scope_reason'] = 'single orphan IRQ completed strictly before every warmup/measured FrameTiming window'
            warnings.append(f'RCL dev={record["dev"]} seqno={record["seqno"]}: {item["scope_reason"]}; raw trace remains incomplete')
        else:
            item['scope_reason'] = 'orphan timing is not provably before every warmup/measured window'
        unmatched.append(item)
    complete = (bool(trace['jobs']) and not trace['non_pairing_diagnostics']
                and all(record['outside_all_windows'] for record in unmatched))
    return dict(trace, unmatched=unmatched, warnings=warnings,
                evaluation_scope=dict(kind='all_warmup_and_measured_frame_timing_windows',
                                      earliest_start_ns=earliest, window_count=len(windows)),
                selected_windows_complete=complete)


def _identity(row):
    try:
        phase = Phase(row.get('phase'))
    except (ValueError, TypeError):
        return None
    case, cycle, repeat = row.get('case_id'), row.get('cycle'), row.get('repeat')
    if (not isinstance(case, str) or not case or not _integer(cycle)
            or not isinstance(repeat, int) or isinstance(repeat, bool)
            or (phase == Phase.MEASURED and repeat < 0)
            or (phase == Phase.WARMUP and (cycle != 0 or repeat >= 0))):
        return None
    return case, phase, cycle, repeat


def read_windows(attempt):
    diagnostics, frames, runs = [], defaultdict(list), defaultdict(list)
    for row in read_jsonl(attempt/'frames.jsonl', diagnostics):
        key = _identity(row)
        if key is None:
            diagnostics.append('frames.jsonl: invalid case/phase/cycle/repeat identity')
            continue
        frames[key].append(row)
    for row in read_jsonl(attempt/'runs.jsonl', diagnostics):
        key = _identity(row)
        if key is None:
            diagnostics.append('runs.jsonl: invalid case/phase/cycle/repeat identity')
            continue
        runs[key].append(row)
    windows = []
    summary = read_json(attempt/'summary.json', diagnostics)
    if summary.get('status') != 'completed':
        diagnostics.append(f'benchmark summary is incomplete: {summary.get("status")}')
    metadata = _mapping(summary.get('metadata'))
    config = _mapping(metadata.get('config'))
    plan = metadata.get('plan')
    for source in (summary, metadata):
        for field in ('runtime_errors','cleanup_errors','failed_runs','error_events','unsupported_cases','error_counts'):
            if source.get(field):
                diagnostics.append(f'benchmark summary reports {field}: {source[field]}')
    repeats, warmups, cycles = config.get('repeats'), config.get('warmups'), metadata.get('cycles',1)
    if (not isinstance(plan,list) or not plan or not _integer(repeats,True)
            or not _integer(warmups) or not _integer(cycles,True)):
        diagnostics.append('expected plan/repetition counts absent; coverage cannot be established')
    elif len(plan)*(repeats*cycles+warmups) > 100000:
        diagnostics.append('declared repetition plan exceeds diagnostic safety limit')
    else:
        expected_all = set()
        for descriptor in plan:
            case = descriptor.get('id') if isinstance(descriptor,dict) else None
            if not isinstance(case,str) or not case:
                diagnostics.append('invalid planned case descriptor')
                continue
            expected = [(case,Phase.MEASURED,cycle,repeat) for cycle in range(cycles) for repeat in range(repeats)]
            expected += [(case,Phase.WARMUP,0,repeat) for repeat in range(-warmups,0)]
            expected_all.update(expected)
            for key in expected:
                if key not in runs:
                    runs[key] = []
        for key in (set(runs)|set(frames))-expected_all:
            diagnostics.append(f'unexpected run/frame identity: {key}')
    for key in sorted(set(runs) | set(frames)):
        case, phase, cycle, repeat = key
        raw, records, issues = frames[key], runs[key], []
        if len(records) != 1:
            issues.append(f'expected one run row, observed {len(records)}')
        run = records[0] if len(records) == 1 else {}
        if run.get('status') != 'passed' or run.get('error'):
            issues.append(f'run failed/has error: {run.get("error") or run.get("status")}')
        if not raw or run.get('frames') != len(raw):
            issues.append('raw/reported frame count missing or different')
        valid, seen = [], set()
        for frame in raw:
            vsync, total = frame.get('vsync_us'), frame.get('total_us')
            if (not _integer(vsync, True) or not _integer(total, True)
                    or vsync > ((1<<63)-1)//1000 or total > ((1<<63)-1)//1000
                    or not _integer(frame.get('build_us')) or not _integer(frame.get('raster_us'))
                    or max(frame.get('build_us',0),frame.get('raster_us',0)) > total
                    or vsync in seen):
                issues.append('invalid/duplicate frame timing')
                continue
            seen.add(vsync)
            valid.append(frame)
        start = min((f['vsync_us']*1000 for f in valid), default=None)
        end = max(((f['vsync_us']+f['total_us'])*1000 for f in valid), default=None)
        if start is None or end is None or end <= start:
            issues.append('no usable monotonic FrameTiming window')
        windows.append(dict(case_id=case, phase=phase.value, cycle=cycle, repeat=repeat,
                            start_ns=start, end_ns=end, run_status=run.get('status'),
                            run_error=run.get('error'), actual_ms=run.get('actual_ms'),
                            frame_count=len(raw), ui_ms=distribution(f['build_us']/1000 for f in valid),
                            raster_ms=distribution(f['raster_us']/1000 for f in valid),
                            _build_samples=[f['build_us']/1000 for f in valid],
                            _raster_samples=[f['raster_us']/1000 for f in valid],
                            issues=issues, complete=not issues))
    for previous, current in zip(sorted((w for w in windows if w['start_ns'] is not None), key=lambda w:w['start_ns']),
                                 sorted((w for w in windows if w['start_ns'] is not None), key=lambda w:w['start_ns'])[1:]):
        if current['start_ns'] < previous['end_ns']:
            diagnostics.append(f'FrameTiming windows overlap: {previous["case_id"]}/{previous["repeat"]} and {current["case_id"]}/{current["repeat"]}')
    return windows, diagnostics


def summarize_window(window, native, trace, scope_valid=True):
    result = dict(window)
    start, end = window['start_ns'], window['end_ns']
    if start is None or end is None or end <= start:
        return dict(result, native=None, gpu=None, drm=None, correlation_valid=False)
    issues = list(window['issues'])
    if not scope_valid:
        issues.append('collection-wide input diagnostics/errors prevent a complete correlation claim')
    header = native['header']
    native_end = native.get('effective_end_ns') or max((c['end_ns'] for c in native['calls']), default=0)
    if not (header.get('start_monotonic_ns', end+1) <= start < end <= native_end):
        issues.append('FrameTiming window is outside native monotonic capture span')
    if not (_integer(trace.get('start_ns'), True) and _integer(trace.get('end_ns'), True)
            and trace['start_ns'] <= start < end <= trace['end_ns']):
        issues.append('FrameTiming window is outside kernel mono recording span')
    calls = [c for c in native['calls'] if c['start_ns'] < end and c['end_ns'] > start]
    phases = {}
    for function in Function:
        selected = [c for c in calls if c['function_id'] == int(function)]
        full = [c for c in selected if start <= c['start_ns'] and c['end_ns'] <= end]
        phases[_FUNCTION_NAMES[function]] = dict(
            overlapping_calls=len(selected), fully_contained_calls=len(full),
            boundary_partial_calls=len(selected)-len(full),
            wall_ms=distribution((c['end_ns']-c['start_ns'])/1e6 for c in full),
            thread_cpu_ms=distribution((c['cpu_end_ns']-c['cpu_start_ns'])/1e6 for c in full),
            observed_clipped_wall_union_ms=union_ns([(c['start_ns'],c['end_ns']) for c in selected],start,end)/1e6,
            failed_calls=[c for c in selected if c['failed']])
    jobs = [j for j in trace['jobs'] if j['start_ns'] < end and j['end_ns'] > start]
    observed = union_ns([(j['start_ns'],j['end_ns']) for j in jobs],start,end)
    by_device = {}
    trusted = bool(window['complete'] and native['complete']
                   and trace['selected_windows_complete'] and not issues)
    for dev in sorted({j['dev'] for j in jobs}):
        value = union_ns([(j['start_ns'],j['end_ns']) for j in jobs if j['dev']==dev],start,end)
        by_device[str(dev)] = dict(observed_elapsed_union_ms=value/1e6,
                                  coverage_percent=100*value/(end-start) if trusted else None)
    gpu = dict(overlapping_rcl_jobs=len(jobs), boundary_partial_jobs=sum(not(start <= j['start_ns'] and j['end_ns'] <= end) for j in jobs),
               full_job_elapsed_ms=distribution((j['end_ns']-j['start_ns'])/1e6 for j in jobs
                                                if start <= j['start_ns'] and j['end_ns'] <= end),
               observed_elapsed_union_ms=observed/1e6 if trace['jobs'] else None,
               coverage_percent=100*observed/(end-start) if trusted else None,
               by_device=by_device, complete=trusted)
    drm = []
    for (devfile, crtc, event), times in sorted(trace['drm'].items()):
        selected = sorted(t for t in times if start <= t <= end)
        drm.append(dict(file=devfile, crtc=crtc, event=event, count=len(selected),
                        gaps_ms=distribution((b-a)/1e6 for a,b in zip(selected,selected[1:]))))
    result.update(window_ms=(end-start)/1e6, native=phases, gpu=gpu, drm=drm,
                  issues=issues, correlation_valid=trusted)
    return result


def summarize_cases(windows, native, trace):
    """Pool raw contained-call/frame samples, never averages of percentiles."""
    groups = defaultdict(list)
    for row in windows:
        groups[(row['case_id'],row['phase'])].append(row)
    result = []
    for (case,phase), rows in sorted(groups.items()):
        spans = [(r['start_ns'],r['end_ns']) for r in rows
                 if r['start_ns'] is not None and r['end_ns'] is not None]
        duration = sum(b-a for a,b in spans)
        trusted = all(r['correlation_valid'] for r in rows)
        calls = {}
        for function in Function:
            full = [c for c in native['calls'] if c['function_id']==int(function)
                    and any(a <= c['start_ns'] and c['end_ns'] <= b for a,b in spans)]
            full_sequences = {c['sequence'] for c in full}
            partial = [c for c in native['calls'] if c['function_id']==int(function)
                       and any(c['start_ns'] < b and c['end_ns'] > a for a,b in spans)
                       and c['sequence'] not in full_sequences]
            if full or partial:
                calls[_FUNCTION_NAMES[function]] = dict(
                    fully_contained_calls=len(full),boundary_partial_calls=len(partial),
                    wall_ms=distribution((c['end_ns']-c['start_ns'])/1e6 for c in full),
                    thread_cpu_ms=distribution((c['cpu_end_ns']-c['cpu_start_ns'])/1e6 for c in full),
                    observed_clipped_wall_union_ms=sum(union_ns([(c['start_ns'],c['end_ns'])
                        for c in native['calls'] if c['function_id']==int(function)],a,b) for a,b in spans)/1e6,
                    failed_calls=[c for c in full+partial if c['failed']])
        observed = sum(union_ns([(j['start_ns'],j['end_ns']) for j in trace['jobs']],a,b) for a,b in spans)
        drm = []
        for (devfile,crtc,event),times in sorted(trace['drm'].items()):
            intervals,count = [],0
            for a,b in spans:
                values=sorted(t for t in times if a <= t <= b)
                count += len(values)
                intervals.extend((y-x)/1e6 for x,y in zip(values,values[1:]))
            drm.append(dict(file=devfile,crtc=crtc,event=event,count=count,gaps_ms=distribution(intervals)))
        result.append(dict(case_id=case,phase=phase,runs=len(rows),window_ms=duration/1e6,
            correlation_complete=trusted,
            ui_ms=distribution(value for row in rows for value in row['_build_samples']),
            raster_ms=distribution(value for row in rows for value in row['_raster_samples']),
            native=calls,drm=drm,
            rcl_observed_elapsed_union_ms=observed/1e6 if trace['jobs'] else None,
            rcl_coverage_percent=100*observed/duration if trusted and duration else None))
    return result


def find_attempt(path):
    if (path/'runs.jsonl').exists():
        return path
    attempts = sorted(path.glob('opengl/attempt-*'))
    if len(attempts) != 1:
        raise ValueError(f'Use an explicit attempt directory: observed {len(attempts)} OpenGL attempts')
    return attempts[0]


def loaded_engine(attempt, native, diagnostics, expected=None):
    path = attempt/'native-pipeline-provenance.json'
    if not path.exists() and expected is None:
        return dict(status='unavailable', expected_sha256=None, validation_complete=False)
    value = read_json(path,diagnostics)
    engine = _mapping(value.get('engine'))
    sha = engine.get('sha256')
    captured = value.get('captured_monotonic_ns')
    closed = native['header'].get('closed_monotonic_ns')
    valid = not (not _integer(value.get('schema_version')) or value.get('schema_version') != 1
            or value.get('kind') != 'native_pipeline_loaded_engine' or value.get('status') != 'verified'
            or not _integer(value.get('pid'), True) or value.get('pid') != native['header'].get('pid')
            or not isinstance(engine.get('path'),str) or not Path(engine['path']).is_absolute()
            or not isinstance(sha,str) or _SHA256.fullmatch(sha) is None
            or not _integer(captured,True)
            or captured < native['header'].get('start_monotonic_ns',captured+1)
            or (closed and captured > closed)
            or value.get('timing_results_valid') is not False
            or (expected is not None and sha != expected))
    if not valid:
        diagnostics.append('loaded engine provenance PID/path/SHA/status does not match diagnostic input')
    return dict(value,expected_sha256=expected,validation_complete=valid)


def finalize_native(attempt, native, engine, diagnostics, expected_engine):
    """Accept Dart's destructor-bypassing exit only with separately bound proof.

    The analyzer is offline: process_absent records the collector's remote /proc
    observation. It never checks an unrelated PID on the analysis computer.
    """
    if native['closure'] == NativeClosure.NORMAL.value:
        return
    path = attempt/'native-pipeline-finalization.json'
    issues = []
    value = read_json(path, issues)
    capture = _mapping(value.get('native_capture'))
    launcher = _mapping(value.get('launcher_status'))
    validated = value.get('validated_at_monotonic_ns')
    last_end = max((call['end_ns'] for call in native['calls']), default=0)
    header = native['header']
    if (header.get('lifecycle') != 1 or header.get('closed_monotonic_ns') != 0
            or not _integer(value.get('schema_version')) or value.get('schema_version') != 1
            or value.get('kind') != 'native_pipeline_external_finalization'
            or value.get('status') != 'verified'
            or value.get('pid') != header.get('pid')
            or value.get('process_absent') is not True or value.get('hash_stable') is not True
            or value.get('timing_results_valid') is not False
            or not _integer(validated, True) or validated < max(last_end,header.get('start_monotonic_ns',0))):
        issues.append('external finalization lifecycle/PID/absence/stability/monotonic fields are invalid')
    if (expected_engine is None or engine.get('validation_complete') is not True
            or engine.get('expected_sha256') != expected_engine
            or not _integer(value.get('process_start_ticks'),True)
            or value.get('process_start_ticks') != engine.get('process_start_ticks')
            or (_integer(validated,True) and validated < engine.get('captured_monotonic_ns',validated+1))):
        issues.append('external finalization requires matched expected engine SHA and process identity')
    try:
        digest,size = _sha256(Path(native['path']))
        if capture.get('sha256') != digest or capture.get('size_bytes') != size:
            issues.append('external finalization native capture SHA/size mismatch')
        digest,_ = _sha256(attempt/'native-pipeline-provenance.json')
        if value.get('engine_provenance_sha256') != digest:
            issues.append('external finalization engine provenance SHA mismatch')
        digest,_ = _sha256(attempt/'launcher-status.json')
        status = read_json(attempt/'launcher-status.json',issues)
        if (launcher.get('file') != 'launcher-status.json' or launcher.get('sha256') != digest
                or not _integer(launcher.get('exit_code')) or launcher.get('exit_code') != 0
                or not _integer(status.get('exit_code')) or status.get('exit_code') != 0):
            issues.append('external finalization launcher SHA/file/exit status mismatch')
    except (OSError,ValueError) as error:
        issues.append(f'external finalization input: {error}')
    native['external_finalization'] = dict(value,validation_complete=not issues,
                                         diagnostics=issues)
    if issues:
        diagnostics.extend(issues)
        return
    native['closure'] = NativeClosure.EXTERNAL.value
    native['effective_end_ns'] = validated
    native['complete'] = bool(header) and not native['diagnostics']
    native['warnings'].append('Closure verified by external post-exit attestation; raw lifecycle=1/closed=0 remains unchanged, no C destructor was observed')


def analyze(collection, native_path, trace_directory, include_warmup=False, expected_engine=None):
    attempt = find_attempt(Path(collection))
    native, trace = read_native(Path(native_path)), read_trace(Path(trace_directory))
    windows, diagnostics = read_windows(attempt)
    trace = scope_trace_to_windows(trace,windows)
    engine = loaded_engine(attempt,native,diagnostics,expected_engine)
    finalize_native(attempt,native,engine,diagnostics,expected_engine)
    errors = read_jsonl(attempt/'errors.jsonl', diagnostics)
    errors.extend(dict(kind='native_call', call=call) for call in native['calls'] if call['failed'])
    errors.extend(dict(kind='run_data',case_id=w['case_id'],phase=w['phase'],
                       cycle=w['cycle'],repeat=w['repeat'],issues=w['issues'])
                  for w in windows if w['issues'])
    try:
        for number, line in enumerate((attempt/'native.log').read_text(encoding='utf-8', errors='replace').splitlines(), 1):
            if not line.startswith('BENCHMARK') and _NATIVE_ERROR.search(line):
                errors.append(dict(kind='native_log', line=number, error=line))
    except OSError as error:
        diagnostics.append(f'native.log unavailable: {error}')
    selected = [summarize_window(w,native,trace,scope_valid=not diagnostics and not errors) for w in windows
                if include_warmup or w['phase'] == Phase.MEASURED.value]
    summaries = summarize_cases(selected,native,trace)
    omitted = [dict(case_id=w['case_id'],cycle=w['cycle'],repeat=w['repeat'],
                    run_status=w['run_status'],issues=w['issues'])
               for w in windows if not include_warmup and w['phase']==Phase.WARMUP.value]
    for row in selected:
        row.pop('_build_samples',None)
        row.pop('_raster_samples',None)
    serial_trace = {k:v for k,v in trace.items() if k != 'drm'}
    serial_trace['drm_streams'] = [dict(file=k[0],crtc=k[1],event=k[2],timestamps_ns=sorted(v)) for k,v in trace['drm'].items()]
    return dict(schema_version=1, diagnostic_only=True, performance_acceptance='not_assessed',
                correlation_scope='selected_frame_timing_windows',
                raw_kernel_trace_complete=trace['raw_complete'],
                attempt=str(attempt), native_capture=native, kernel_trace=serial_trace,
                loaded_engine=engine,
                diagnostics=diagnostics, errors=errors,
                omitted_warmup_windows=len(omitted), omitted_warmups=omitted,
                cases=selected, case_summaries=summaries,
                correlation_complete=bool(selected) and not diagnostics and not errors
                and all(w['correlation_valid'] for w in selected),
                notes=[
                    'Windows are conservative FrameTiming-derived [first vsync, max(vsync+total)] in monotonic ns, not exact GPU/frame markers.',
                    'Native wall/thread CPU percentiles use fully contained calls; boundary partial wall intervals are clipped, and their CPU time is never proportionally invented.',
                    'Native function intervals can nest or overlap: do not sum function wall times or subtract CPU time as a complete wait attribution.',
                    'RCL submit-to-IRQ elapsed includes queueing and IRQ delivery delay; its union coverage is not exclusive GPU shader time or hardware utilization.',
                    'Kernel jobs are device-wide observations overlapping case windows; no per-frame or process ownership is inferred.',
                    'A single orphan IRQ completed strictly before every warmup/measured window may be bounded outside evaluation; its raw record/diagnostic and raw trace incompleteness remain preserved.',
                    'Observed unions remain explicit lower-bound observations when trace records are missing; coverage claims require complete correlated data.',
                    'DRM completion gaps measure completion cadence only. Pending page flips are not raster time, shader time, optical latency or unique visible frames.',
                    'Warmups are excluded by default. Missing/failed runs and capture errors are retained; this instrumented run cannot replace an uninstrumented A/B.',
                ])


def render(result):
    lines = ['# Native pipeline diagnostic', '',
             f'Selected-window correlation complete: {result["correlation_complete"]}. Raw kernel trace complete: {result["raw_kernel_trace_complete"]}. Performance acceptance: not assessed.', '',
             *[f'- {note}' for note in result['notes']], '',
             '| Case / phase | Window ms | UI / raster p95 ms | RCL union ms / coverage % | Complete |',
             '| --- | ---: | --- | --- | --- |']
    def fmt(value):
        return '—' if value is None else f'{value:.3f}'
    for row in result['case_summaries']:
        label = f'{row["case_id"]} / {row["phase"]}'.replace('|','\\|')
        lines.append(f'| {label} | {fmt(row.get("window_ms"))} | {fmt(row["ui_ms"]["p95"])} / {fmt(row["raster_ms"]["p95"])} | '
                     f'{fmt(row.get("rcl_observed_elapsed_union_ms"))} / {fmt(row.get("rcl_coverage_percent"))} | {row["correlation_complete"]} |')
    lines += ['', '| Case / phase | Native call | Wall p95 ms | Thread CPU p95 ms | Full / partial calls |',
              '| --- | --- | ---: | ---: | --- |']
    for row in result['case_summaries']:
        label = f'{row["case_id"]} / {row["phase"]}'.replace('|','\\|')
        for name, values in (row.get('native') or {}).items():
            lines.append(f'| {label} | {name} | {fmt(values["wall_ms"]["p95"])} | '
                         f'{fmt(values["thread_cpu_ms"]["p95"])} | {values["fully_contained_calls"]} / {values["boundary_partial_calls"]} |')
    lines += ['', '| Case / phase | DRM event / file / CRTC | Count | Gap p95 ms |',
              '| --- | --- | ---: | ---: |']
    for row in result['case_summaries']:
        label = f'{row["case_id"]} / {row["phase"]}'.replace('|','\\|')
        for stream in row.get('drm') or []:
            lines.append(f'| {label} | {stream["event"]} / {stream["file"]} / {stream["crtc"]} | '
                         f'{stream["count"]} | {fmt(stream["gaps_ms"]["p95"])} |')
    lines.append('')
    for source in (result, result['native_capture'], result['kernel_trace']):
        lines.extend(f'- Diagnostic: {message}' for message in source.get('diagnostics', []))
        lines.extend(f'- Warning: {message}' for message in source.get('warnings', []))
    for row in result['cases']:
        lines.extend(f'- {row["case_id"]}/{row["phase"]}/{row["repeat"]}: {issue}' for issue in row['issues'])
    lines.extend(f'- Error: {json.dumps(error,ensure_ascii=False)}' for error in result['errors'])
    return '\n'.join(lines)+'\n'


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('collection',type=Path)
    parser.add_argument('output',type=Path)
    parser.add_argument('--native',type=Path,required=True)
    parser.add_argument('--trace-dir',type=Path,required=True)
    parser.add_argument('--include-warmup',action='store_true')
    parser.add_argument('--engine-sha256',help='Expected actually loaded engine SHA-256; requires captured provenance')
    args = parser.parse_args(argv)
    try:
        if args.engine_sha256 is not None and _SHA256.fullmatch(args.engine_sha256) is None:
            raise ValueError('--engine-sha256 must be 64 lowercase hexadecimal characters')
        result = analyze(args.collection,args.native,args.trace_dir,args.include_warmup,args.engine_sha256)
    except ValueError as error:
        parser.error(str(error))
    args.output.mkdir(parents=True,exist_ok=True)
    (args.output/'analysis.json').write_text(json.dumps(result,indent=2,allow_nan=False)+'\n')
    (args.output/'report.md').write_text(render(result))
    print(json.dumps(dict(cases=len(result['cases']),correlation_complete=result['correlation_complete'],
                          diagnostic_only=True,output=str(args.output))))
    return 0 if result['correlation_complete'] else 2


if __name__ == '__main__':
    raise SystemExit(main())
