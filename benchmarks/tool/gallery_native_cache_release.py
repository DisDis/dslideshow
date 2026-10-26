#!/usr/bin/env python3
"""Build/run frozen native cache variants in real Linux Flutter release mode."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import shutil
import statistics
import subprocess

ROOT = Path(__file__).resolve().parents[2]
REPORT = ROOT / 'benchmarks/reports/gallery-native-cache-cold-2026-10-26'
TEMPLATE = Path(__file__).with_suffix('.dart.template')
FLUTTER = Path('/home/dis/bin/flutter/bin/flutter')
OUTPUT = REPORT / 'linux-release'
VARIANTS = ('baseline', 'production')


def digest(file):
    return hashlib.sha256(file.read_bytes()).hexdigest()


def save(file, value):
    file.write_text(json.dumps(value, indent=2) + '\n')


def host():
    governors = {}
    for file in Path('/sys/devices/system/cpu').glob('cpu*/cpufreq/scaling_governor'):
        governors[str(file)] = file.read_text().strip()
    return {
        'uname': list(platform.uname()),
        'os_release': Path('/etc/os-release').read_text(),
        'logical_processors': os.cpu_count(),
        'affinity': sorted(os.sched_getaffinity(0)),
        'cpu_governors': governors,
    }


def sources(variant):
    return {
        str(file.relative_to(ROOT)): digest(file)
        for file in sorted((REPORT / variant / 'config_app/lib/src/gallery').glob('*.dart'))
    }


def execute(command, logfile, *, environment=None, timeout=1200):
    with logfile.open('w') as log:
        completed = subprocess.run(
            command, cwd=ROOT / 'config_app', env=environment,
            stdout=log, stderr=subprocess.STDOUT, timeout=timeout,
        )
    if completed.returncode:
        raise RuntimeError(f'Command failed ({completed.returncode}): {logfile}')


def harness():
    text = TEMPLATE.read_text()
    for variant in VARIANTS:
        source = (REPORT / variant / 'config_app/lib/src/gallery/gallery_encoded_cache_io.dart')
        if not source.is_file():
            raise RuntimeError(f'Required frozen snapshot is missing: {source}')
        literal = json.dumps(source.as_uri()).replace('$', r'\$')
        text = text.replace(f'__{variant.upper()}_CACHE_IMPORT__', literal)
    OUTPUT.mkdir(parents=True, exist_ok=True)
    generated = OUTPUT / 'gallery_native_cache_release.dart'
    if generated.exists() and generated.read_text() != text:
        raise RuntimeError('Generated harness already exists with different content')
    generated.write_text(text)
    return generated


def build(variant, target):
    destination = OUTPUT / variant
    destination.mkdir(parents=True, exist_ok=False)
    before = sources(variant)
    command = [
        str(FLUTTER), '--suppress-analytics', '--no-version-check',
        'build', 'linux', '--release', '--no-pub', '--target', str(target),
        f'--dart-define=GALLERY_CACHE_VARIANT={variant}',
    ]
    print(f'Building frozen {variant}', flush=True)
    execute(command, destination / 'build.log')
    if sources(variant) != before:
        raise RuntimeError('Frozen source changed during build')
    shutil.copytree(ROOT / 'config_app/build/linux/x64/release/bundle', destination / 'bundle')
    shutil.copy2(target, destination / target.name)
    manifest = {
        str(file.relative_to(destination / 'bundle')): digest(file)
        for file in sorted((destination / 'bundle').rglob('*')) if file.is_file()
    }
    save(destination / 'bundle-manifest.json', manifest)
    save(destination / 'build-provenance.json', {
        'variant': variant, 'command': command, 'cwd': str(ROOT / 'config_app'),
        'mode': 'release', 'source_hashes': before,
        'harness_sha256': digest(target), 'template_sha256': digest(TEMPLATE),
        'bundle_manifest_sha256': digest(destination / 'bundle-manifest.json'),
        'flutter_revision': subprocess.check_output(
            ['git', '-C', str(FLUTTER.parents[1]), 'rev-parse', 'HEAD'], text=True,
        ).strip(),
        'pubspec_sha256': digest(ROOT / 'config_app/pubspec.yaml'),
        'lock_sha256': digest(ROOT / 'config_app/pubspec.lock'),
        'package_config_sha256': digest(ROOT / 'config_app/.dart_tool/package_config.json'),
        'host': host(),
    })
    print(f'Bundle preserved: {destination / "bundle"}', flush=True)


def run(variant, label):
    destination = OUTPUT / variant
    run_directory = destination / 'runs' / label
    run_directory.mkdir(parents=True, exist_ok=False)
    payload = REPORT / 'baseline/payload.jpg'
    command = [
        'xvfb-run', '-a', str(destination / 'bundle/config_app'),
        str(payload), str(run_directory / 'results.json'),
    ]
    environment = dict(os.environ, LIBGL_ALWAYS_SOFTWARE='1', GDK_BACKEND='x11')
    print(f'Running frozen {variant}', flush=True)
    before = host()
    execute(command, run_directory / 'run.log', environment=environment, timeout=300)
    result = json.loads((run_directory / 'results.json').read_text())
    if result['build_mode'] != 'release' or len(result['trials']) != 5:
        raise RuntimeError('Not the requested five-trial release run')
    for trial in result['trials']:
        if (trial['writes'], trial['concurrency'],
                trial['complete_immediate_payloads_verified'],
                trial['reopened_hits_verified']) != (63, 4, 63, 63):
            raise RuntimeError('Incomplete trial or payload validation')
    save(run_directory / 'run-provenance.json', {
        'command': command, 'cwd': str(ROOT / 'config_app'),
        'environment_overrides': {'LIBGL_ALWAYS_SOFTWARE': '1', 'GDK_BACKEND': 'x11'},
        'payload_sha256': digest(payload), 'payload_bytes': payload.stat().st_size,
        'filesystem_device_id': os.stat(result['fixture_parent']).st_dev,
        'host_before': before, 'host_after': host(),
        'scope': 'Real Linux Flutter release; Xvfb software rendering; disk cache '
            'operations only; no HTTP, image decode, capture, active app or Pi',
    })
    totals = [trial['total_write_ms'] for trial in result['trials']]
    save(run_directory / 'summary.json', {
        'variant': variant, 'build_mode': 'release', 'trials': 5,
        'batch_writes': 63, 'concurrency': 4,
        'total_write_ms': totals, 'median_total_write_ms': statistics.median(totals),
        'minimum_total_write_ms': min(totals), 'maximum_total_write_ms': max(totals),
        'all_immediate_and_reopened_bytes_exact': True,
    })
    print(f'{variant}: median {statistics.median(totals):.3f} ms', flush=True)


def main():
    global OUTPUT
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--phase', choices=('build', 'run', 'all'), default='all')
    parser.add_argument('--variant', choices=VARIANTS, action='append')
    parser.add_argument('--run-name', default='confirmed')
    parser.add_argument('--output', type=Path, default=OUTPUT)
    args = parser.parse_args()
    if (not args.run_name or args.run_name in ('.', '..') or
            Path(args.run_name).name != args.run_name or '\\' in args.run_name):
        parser.error('--run-name must be one directory name')
    if shutil.which('xvfb-run') is None:
        raise RuntimeError('xvfb-run is not installed; no fallback is attempted')
    OUTPUT = args.output.resolve()
    variants = args.variant or VARIANTS
    if args.phase in ('build', 'all'):
        target = harness()
        for variant in variants:
            build(variant, target)
    if args.phase in ('run', 'all'):
        for variant in variants:
            run(variant, args.run_name)


if __name__ == '__main__':
    main()
