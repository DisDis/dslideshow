#!/usr/bin/env python3
"""Attest an exited diagnostic process without modifying its raw mmap capture."""
import argparse
import hashlib
import json
from pathlib import Path
import re
import struct
import time

from capture_process import write_exclusive

_HEADER = struct.Struct('<8s8I6Q2I32s')
_RECORD = struct.Struct('<IHH5QIiq6QI12s')
_SHA256 = re.compile(r'[0-9a-f]{64}')


def _snapshot(path):
    before = path.stat()
    data = path.read_bytes()
    after = path.stat()
    signature = lambda value: (value.st_dev, value.st_ino, value.st_size,
                               value.st_mtime_ns, value.st_ctime_ns)
    if signature(before) != signature(after):
        raise ValueError(f'File changed while reading: {path}')
    return data, signature(after)


def _assert_absent(process):
    try:
        process.stat()
    except FileNotFoundError:
        return
    raise ValueError('Native process PID still exists; refusing finalization')


def verify(attempt, proc_root=Path('/proc')):
    native = attempt / 'native-pipeline.bin'
    raw, native_identity = _snapshot(native)
    if len(raw) < _HEADER.size:
        raise ValueError('Truncated native header')
    h = _HEADER.unpack_from(raw)
    magic, version, endian, hs, rs, capacity, pid, flags, error = h[:9]
    reserved, committed, dropped, started, _realtime, closed, lifecycle, clock_errors = h[9:17]
    if (magic != b'NPIPV001' or version != 1 or endian != 0x01020304 or
            hs != 128 or rs != 128 or not pid or flags != 3 or error):
        raise ValueError('Invalid native capture header')
    if (not reserved or reserved != committed or reserved > capacity or dropped or
            clock_errors or lifecycle not in (1, 2) or len(raw) != hs + capacity * rs):
        raise ValueError('Incomplete or invalid native capture')
    _assert_absent(proc_root / str(pid))
    last_end = started
    for index in range(reserved):
        record = _RECORD.unpack_from(raw, hs + index * rs)
        complete, _function, _depth, sequence, start, end, cpu_start, cpu_end = record[:8]
        if (complete != 1 or sequence != index + 1 or start < started or
                end < start or cpu_end < cpu_start):
            raise ValueError('Incomplete or invalid native record')
        last_end = max(last_end, end)
    launch_path = attempt / 'launcher-status.json'
    launch_bytes, launch_identity = _snapshot(launch_path)
    launch = json.loads(launch_bytes)
    if type(launch.get('exit_code')) is not int or launch['exit_code'] != 0:
        raise ValueError('Launcher does not confirm a successful process exit')
    proof_path = attempt / 'native-pipeline-provenance.json'
    proof_bytes, proof_identity = _snapshot(proof_path)
    proof = json.loads(proof_bytes)
    engine = proof.get('engine', {})
    if (proof.get('schema_version') != 1 or proof.get('kind') != 'native_pipeline_loaded_engine' or
            proof.get('status') != 'verified' or proof.get('pid') != pid or
            type(proof.get('process_start_ticks')) is not int or proof['process_start_ticks'] <= 0 or
            not isinstance(engine, dict) or not isinstance(engine.get('path'), str) or
            not Path(engine['path']).is_absolute() or
            not isinstance(engine.get('sha256'), str) or not _SHA256.fullmatch(engine['sha256']) or
            proof.get('timing_results_valid') is not False or
            type(proof.get('captured_monotonic_ns')) is not int or
            proof['captured_monotonic_ns'] < started):
        raise ValueError('Loaded-engine proof does not identify this process')
    for path, identity, original in [(native, native_identity, raw),
                                     (launch_path, launch_identity, launch_bytes),
                                     (proof_path, proof_identity, proof_bytes)]:
        data, current = _snapshot(path)
        if current != identity or data != original:
            raise ValueError(f'File changed during finalization: {path}')
    _assert_absent(proc_root / str(pid))
    validated = time.monotonic_ns()
    if validated < max(last_end, closed, proof['captured_monotonic_ns']):
        raise ValueError('Capture belongs to a different or invalid monotonic clock')
    return {
        'schema_version': 1, 'kind': 'native_pipeline_external_finalization',
        'status': 'verified', 'pid': pid,
        'process_start_ticks': proof['process_start_ticks'],
        'native_capture': {'sha256': hashlib.sha256(raw).hexdigest(), 'size_bytes': len(raw)},
        'launcher_status': {'file': 'launcher-status.json',
                            'sha256': hashlib.sha256(launch_bytes).hexdigest(), 'exit_code': 0},
        'engine_provenance_sha256': hashlib.sha256(proof_bytes).hexdigest(),
        'process_absent': True, 'hash_stable': True,
        'validated_at_monotonic_ns': validated,
        'raw_lifecycle': lifecycle, 'raw_closed_monotonic_ns': closed,
        'reserved_count': reserved, 'committed_count': committed,
        'timing_results_valid': False,
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('attempt', type=Path)
    args = parser.parse_args()
    result = verify(args.attempt)
    write_exclusive(args.attempt / 'native-pipeline-finalization.json', result)
    print(json.dumps({'pid': result['pid'], 'status': result['status'],
                      'raw_lifecycle': result['raw_lifecycle']}))


if __name__ == '__main__':
    main()
