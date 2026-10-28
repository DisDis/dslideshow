#!/usr/bin/env python3
"""Verify the actual mapped engine of one diagnostic flutter-pi process."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import time


class EngineNotMapped(RuntimeError):
    pass


def _identity(path):
    stat = path.stat()
    return (stat.st_dev, stat.st_ino, stat.st_size, stat.st_mtime_ns, stat.st_ctime_ns)


def _start_ticks(process):
    text = (process / 'stat').read_text()
    return int(text[text.rfind(')') + 2:].split()[19])


def capture(pid, engine, expected_sha, proc_root=Path('/proc')):
    engine = engine.resolve(strict=True)
    process = proc_root / str(pid)
    start_ticks = _start_ticks(process)
    maps = (process / 'maps').read_text()
    mappings = []
    for line in maps.splitlines():
        fields = line.split(maxsplit=5)
        if len(fields) != 6:
            continue
        mapped_path = fields[5]
        if Path(mapped_path.removesuffix(' (deleted)')).name != engine.name:
            continue
        if mapped_path.endswith(' (deleted)'):
            raise ValueError('Mapped engine was deleted')
        major, minor = (int(part, 16) for part in fields[3].split(':'))
        mappings.append((Path(mapped_path), major, minor, int(fields[4])))
    if not mappings:
        raise EngineNotMapped('Engine has not been mapped yet')
    before = _identity(engine)
    expected_mapping = (engine, os.major(before[0]), os.minor(before[0]), before[1])
    if any(mapping != expected_mapping for mapping in mappings):
        raise ValueError('Actual mapped engine path/device/inode differs from frozen engine')
    digest = hashlib.sha256(engine.read_bytes()).hexdigest()
    if digest != expected_sha:
        raise ValueError('Mapped engine SHA-256 differs from frozen engine')
    if _identity(engine) != before or _start_ticks(process) != start_ticks:
        raise ValueError('Engine or process changed during provenance capture')
    return {
        'schema_version': 1,
        'kind': 'native_pipeline_loaded_engine',
        'status': 'verified',
        'pid': pid,
        'process_start_ticks': start_ticks,
        'captured_monotonic_ns': time.monotonic_ns(),
        'engine': {'path': str(engine), 'sha256': digest, 'inode': before[1],
                   'device_major': expected_mapping[1], 'device_minor': expected_mapping[2]},
        'argv': (process / 'cmdline').read_bytes().decode().rstrip('\0').split('\0'),
        'maps': maps,
        'timing_results_valid': False,
    }


def write_exclusive(path, value):
    descriptor = os.open(path, os.O_WRONLY | os.O_CREAT | os.O_EXCL | os.O_NOFOLLOW, 0o600)
    with os.fdopen(descriptor, 'w') as stream:
        json.dump(value, stream, indent=2)
        stream.write('\n')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('pid', type=int)
    parser.add_argument('engine', type=Path)
    parser.add_argument('sha256')
    parser.add_argument('output', type=Path)
    parser.add_argument('--timeout', type=float, default=30)
    args = parser.parse_args()
    if args.pid <= 0 or args.timeout <= 0:
        parser.error('PID and timeout must be positive')
    deadline = time.monotonic() + args.timeout
    try:
        while True:
            try:
                result = capture(args.pid, args.engine, args.sha256)
                break
            except EngineNotMapped:
                if time.monotonic() >= deadline:
                    raise TimeoutError('Mapped engine did not appear before deadline')
                time.sleep(.1)
    except (OSError, ValueError, RuntimeError) as error:
        write_exclusive(args.output, {'schema_version': 1, 'status': 'error',
                                    'pid': args.pid, 'error': str(error),
                                    'timing_results_valid': False})
        return 1
    write_exclusive(args.output, result)
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
