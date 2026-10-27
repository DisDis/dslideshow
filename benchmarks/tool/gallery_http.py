#!/usr/bin/env python3
"""Repeatable, local HTTP A/B against frozen production WebService sources.

Never connects to a frame or starts hardware services. All sockets are loopback;
fixtures and candidate thumbnail caches live below a new temporary directory.
"""
import argparse
from concurrent.futures import ThreadPoolExecutor
import hashlib
import http.client
import json
import math
import os
from pathlib import Path
import selectors
import shutil
import subprocess
import tarfile
import tempfile
import threading
import time
from urllib.parse import quote, unquote, urljoin, urlparse

ROOT = Path(__file__).resolve().parents[2]
TOOL = Path(__file__).resolve().parent
DEFAULT_DART = Path('/home/dis/bin/flutter/bin/cache/dart-sdk/bin/dart')


def digest(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def distribution(values):
    values = sorted(values)
    def quantile(fraction):
        return values[max(0, math.ceil(len(values) * fraction) - 1)] if values else None
    return {'n': len(values), 'p50': quantile(.5), 'p95': quantile(.95),
            'p99': quantile(.99), 'max': max(values) if values else None}


def snapshot_current(packages, destination):
    """Freeze current sources (including authorized uncommitted changes)."""
    destination = Path(destination)
    destination.mkdir(exist_ok=False)
    sources = destination / 'sources'
    sources.mkdir()
    packages = Path(packages).resolve()
    config = json.loads(packages.read_text())
    for item in config['packages']:
        source = Path(unquote(urlparse(urljoin(packages.as_uri(), item['rootUri'])).path))
        if item['name'] in ('dslideshow_backend', 'dslideshow_common'):
            target = sources / ('backend' if item['name'] == 'dslideshow_backend' else 'common')
            shutil.copytree(source / 'lib', target / 'lib')
            for name in ('pubspec.yaml', 'pubspec.lock'):
                if (source / name).exists():
                    shutil.copy2(source / name, target / name)
            source = target
        item['rootUri'] = source.as_uri() + '/'
    frozen = destination / 'backend-packages.json'
    frozen.write_text(json.dumps(config, indent=2) + '\n')
    hashes = {str(p.relative_to(sources)): digest(p) for p in sorted(sources.rglob('*')) if p.is_file()}
    (destination / 'source-manifest.json').write_text(json.dumps(hashes, indent=2) + '\n')
    with tarfile.open(destination / 'source.tar.gz', 'w:gz') as archive:
        archive.add(sources, arcname='sources')
    (destination / 'provenance.json').write_text(json.dumps({
        'revision': subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip(),
        'git_status': subprocess.check_output(['git', 'status', '--short'], cwd=ROOT, text=True),
        'source_archive_sha256': digest(destination / 'source.tar.gz'),
        'scope': 'backend/common current source snapshot; dependencies remain in existing pub cache',
    }, indent=2) + '\n')
    return frozen


def verify_snapshot(variant):
    manifest = json.loads((variant / 'source-manifest.json').read_text())
    actual = {str(path.relative_to(variant / 'sources'))
              for path in (variant / 'sources').rglob('*') if path.is_file()}
    if actual != set(manifest):
        raise ValueError('Frozen source file set changed')
    for name, expected in manifest.items():
        if digest(variant / 'sources' / name) != expected:
            raise ValueError(f'Frozen source changed: {name}')


def compile_server(dart, variant, harness):
    verify_snapshot(variant)
    execution = variant / 'execution'
    execution.mkdir(exist_ok=False)
    frozen_harness = execution / 'gallery_http_server.dart'
    shutil.copy2(harness, frozen_harness)
    shutil.copy2(__file__, execution / 'gallery_http.py')
    binary = execution / 'gallery-http-server'
    command = [str(dart), 'compile', 'exe', f'--packages={variant / "backend-packages.json"}',
               str(frozen_harness), '-o', str(binary)]
    environment = os.environ | {'DASH__SUPPRESS_ANALYTICS': 'true'}
    result = subprocess.run(command, capture_output=True, text=True, timeout=120, env=environment)
    (execution / 'compile.log').write_text(result.stdout + result.stderr)
    if result.returncode:
        raise RuntimeError(f'AOT compilation failed: {execution / "compile.log"}')
    (execution / 'build.json').write_text(json.dumps({
        'command': command, 'binary_sha256': digest(binary),
        'harness_sha256': digest(frozen_harness), 'runner_sha256': digest(execution / 'gallery_http.py'),
        'dart': subprocess.check_output([str(dart), '--version'], text=True, env=environment).strip(),
        'mode': 'local Linux AOT release; not Flutter UI or Pi',
    }, indent=2) + '\n')
    return binary


def prepare_fixture(directory, count, media_files):
    directory.mkdir(exist_ok=False)
    (directory / 'web').mkdir()
    media = directory / 'media'
    media.mkdir()
    hashes = {}
    for source in media_files:
        target = media / source.name
        shutil.copyfile(source, target)
        hashes[target.name] = {'sha256': digest(target), 'bytes': target.stat().st_size}
    for index in range(count):
        # Metadata-only entries are never selected for a decode/thumbnail request.
        (media / f'empty-{index:06d}.jpg').touch()
    return {'metadata_only_jpgs': count, 'real_media': hashes,
            'filesystem_cache': 'warm after creation/copy; OS cache is never dropped'}


def start_server(binary, fixture, log):
    stderr = log.open('w')
    process = subprocess.Popen([str(binary), str(fixture)], stdout=subprocess.PIPE,
                               stderr=stderr, text=True)
    process._gallery_stderr = stderr
    selector = selectors.DefaultSelector()
    selector.register(process.stdout, selectors.EVENT_READ)
    try:
        if not selector.select(15):
            raise RuntimeError('Loopback server did not become ready within 15 seconds')
        line = process.stdout.readline()
        ready = json.loads(line)
        if ready.get('kind') != 'ready':
            raise RuntimeError(f'Unexpected server output: {line}')
        return process, ready
    except BaseException:
        process.kill()
        process.wait(timeout=5)
        stderr.close()
        raise
    finally:
        selector.close()


def request(port, path, *, delay_ms=0, cancel_after=None, headers=None, capture_body=False):
    begin = time.monotonic()
    connection = http.client.HTTPConnection('127.0.0.1', port, timeout=15)
    body = bytearray()
    body_bytes = 0
    status = None
    first_byte_ms = None
    response_headers = {}
    error = None
    cancelled = False
    try:
        connection.request('GET', path, headers=headers or {})
        response = connection.getresponse()
        first_byte_ms = (time.monotonic() - begin) * 1000
        status = response.status
        response_headers = dict(response.getheaders())
        while True:
            chunk = response.read(65536)
            if not chunk:
                break
            body_bytes += len(chunk)
            if capture_body:
                body.extend(chunk)
            if cancel_after is not None and body_bytes >= cancel_after:
                cancelled = True
                break
            if delay_ms:
                time.sleep(delay_ms / 1000)
        expected = response.getheader('Content-Length')
        if not cancelled and status not in (204, 304) and expected is not None and body_bytes != int(expected):
            raise http.client.IncompleteRead(b'', int(expected) - body_bytes)
    except Exception as exception:
        error = f'{type(exception).__name__}: {exception}'
    finally:
        connection.close()
    return {'path': path, 'status': status, 'body_bytes': body_bytes,
            'first_byte_ms': first_byte_ms, 'elapsed_ms': (time.monotonic() - begin) * 1000,
            'cancelled': cancelled, 'error': error, 'headers': response_headers}, bytes(body)


def process_sample(pid, seen=None):
    """Sample simultaneous RSS (shared pages can be counted more than once).

    Children can belong to any Dart IO thread. Include reaped child CPU from
    /proc/stat so short ffprobe/ffmpeg processes are not lost between samples.
    """
    seen = set() if seen is None else seen
    if pid in seen:
        return None
    seen.add(pid)
    try:
        status = {}
        for line in Path(f'/proc/{pid}/status').read_text().splitlines():
            key, _, value = line.partition(':')
            if key in ('VmRSS', 'VmHWM', 'Threads'):
                status[key] = int(value.strip().split()[0])
        fields = Path(f'/proc/{pid}/stat').read_text().split(') ', 1)[1].split()
        status['cpu_ms'] = (int(fields[11]) + int(fields[12])) * 1000 / os.sysconf('SC_CLK_TCK')
        status['fd'] = len(list(Path(f'/proc/{pid}/fd').iterdir()))
        status['monotonic_s'] = time.monotonic()
        status['pid'] = pid
        children = set()
        for task in Path(f'/proc/{pid}/task').glob('*/children'):
            try:
                children.update(map(int, task.read_text().split()))
            except OSError:
                pass  # An IO thread may exit during enumeration.
        status['children'] = [child for child in (process_sample(child_pid, seen)
                              for child_pid in sorted(children)) if child is not None]
        descendants = status['children']
        status['tree_rss_kib'] = status.get('VmRSS', 0) + sum(child['tree_rss_kib'] for child in descendants)
        status['tree_fd'] = status['fd'] + sum(child['tree_fd'] for child in descendants)
        status['tree_threads'] = status['Threads'] + sum(child['tree_threads'] for child in descendants)
        status['tree_processes'] = 1 + sum(child['tree_processes'] for child in descendants)
        status['tree_cpu_ms'] = (status['cpu_ms'] + (int(fields[13]) + int(fields[14])) * 1000 / os.sysconf('SC_CLK_TCK')
                                 + sum(child['tree_cpu_ms'] for child in descendants))
        return status
    except (OSError, ValueError):
        return None


def stats(port):
    result, body = request(port, '/__probe/stats', capture_body=True)
    if result['status'] != 200 or result['error']:
        raise RuntimeError(f'Stats request failed: {result}')
    return json.loads(body)


def settle(port):
    deadline = time.monotonic() + 5
    while True:
        value = stats(port)
        if value['active_bodies'] == 0 and value['active_handlers'] == 0:
            return value
        if time.monotonic() >= deadline:
            raise RuntimeError(f'Resources remained active after 5 seconds: {value}')
        time.sleep(.01)


def run_group(port, pid, name, paths, concurrency, delay_ms=0, cancel_after=None):
    settle(port)
    reset, _ = request(port, '/__probe/reset')
    if reset['status'] != 200:
        raise RuntimeError(f'Reset failed: {reset}')
    stop = threading.Event()
    info = []
    samples = []
    def monitor():
        while not stop.is_set():
            observed, _ = request(port, '/info')
            info.append(observed)
            samples.append(process_sample(pid))
            stop.wait(.01)
    thread = threading.Thread(target=monitor, daemon=True)
    thread.start()
    before = process_sample(pid)
    begin = time.monotonic()
    try:
        with ThreadPoolExecutor(max_workers=concurrency) as pool:
            responses = list(pool.map(lambda path: request(port, path, delay_ms=delay_ms,
                                                          cancel_after=cancel_after)[0], paths))
        elapsed = time.monotonic() - begin
        observed = settle(port)
    finally:
        stop.set()
        thread.join(timeout=20)
        if thread.is_alive():
            raise RuntimeError('Info monitor did not stop')
    after = process_sample(pid)
    samples = [sample for sample in samples if sample is not None]
    valid = [result for result in responses if result['error'] is None and result['status'] in (200, 206, 304)]
    return {'name': name, 'concurrency_requested': concurrency, 'delay_per_64k_ms': delay_ms,
            'elapsed_s': elapsed, 'requests_per_s': len(responses) / elapsed,
            'client_body_bytes': sum(item['body_bytes'] for item in responses),
            'successful_responses': len(valid), 'errors': len(responses) - len(valid),
            'client_cancellations': sum(item['cancelled'] for item in responses),
            'latency_ms': distribution([item['elapsed_ms'] for item in valid]),
            'info_latency_ms': distribution([item['elapsed_ms'] for item in info if item['status'] == 200]),
            'info_errors': sum(item['error'] is not None or item['status'] != 200 for item in info),
            'cpu_ms': after['cpu_ms'] - before['cpu_ms'] if before and after else None,
            'tree_cpu_ms': after['tree_cpu_ms'] - before['tree_cpu_ms'] if before and after else None,
            'max_sampled_tree_rss_kib': max((sample['tree_rss_kib'] for sample in samples), default=None),
            'max_sampled_tree_fd': max((sample['tree_fd'] for sample in samples), default=None),
            'max_sampled_tree_threads': max((sample['tree_threads'] for sample in samples), default=None),
            'max_sampled_tree_processes': max((sample['tree_processes'] for sample in samples), default=None),
            'child_processes_after': after['tree_processes'] - 1 if after else None,
            'max_rss_kib': max((sample['VmRSS'] for sample in samples), default=None),
            'max_fd': max((sample['fd'] for sample in samples), default=None),
            'fd_before': before['fd'] if before else None, 'fd_after': after['fd'] if after else None,
            'max_threads': max((sample['Threads'] for sample in samples), default=None),
            'server': observed, 'responses': responses, 'info_responses': info, 'process_samples': samples}


def run_trial(binary, result_dir, count, media_files, concurrency_values, requests, bucket=256, cold_concurrency=1):
    result_dir.mkdir(exist_ok=False)
    with tempfile.TemporaryDirectory(prefix='gallery-http-') as temporary:
        fixture = Path(temporary) / 'fixture'
        fixture_manifest = prepare_fixture(fixture, count, media_files)
        process, ready = start_server(binary, fixture, result_dir / 'server.stderr.log')
        port, code = ready['port'], ready['code']
        try:
            original_paths = [f'/cache/{code}/get/{quote(source.name)}' for source in media_files]
            list_group = run_group(port, ready['pid'], 'legacy-list', [f'/cache/{code}/list'] * 3, 1)
            listing_result, listing_body = request(port, f'/cache/{code}/list', capture_body=True)
            listing = json.loads(listing_body)['items']
            if listing_result['status'] != 200 or len(listing) != count + len(media_files) or len(set(listing)) != len(listing):
                raise RuntimeError(f'Incomplete or duplicate legacy list: {listing_result}')
            catalog_result, catalog_body = request(port, f'/cache/{code}/v2/catalog', capture_body=True)
            thumbnails = []
            if catalog_result['status'] == 200:
                catalog = json.loads(catalog_body)
                entries = {entry['path']: entry for entry in catalog['entries']}
                thumbnail_policy = catalog['thumbnailPolicy']
                policy_id = str(thumbnail_policy['version'])
                if thumbnail_policy.get('revision'):
                    policy_id += '-' + thumbnail_policy['revision']
                for source in media_files:
                    entry = entries[source.name]
                    if not entry.get('thumbnailSupported'):
                        raise RuntimeError(f'Real JPEG lacks thumbnail support: {entry}')
                    thumbnails.append(f'/cache/{code}/v2/thumbnail/{quote(entry["mediaId"])}/'
                                      f'{quote(entry["sourceRevision"])}/{policy_id}/{bucket}')
                original_paths = [f'/cache/{code}/get/{quote(source.name)}?rev={quote(entries[source.name]["sourceRevision"])}'
                                  for source in media_files]
            elif catalog_result['status'] != 404:
                raise RuntimeError(f'Catalog failed: {catalog_result}')
            groups = [list_group]
            # First tile pass measures backend derivative-cache cold state only;
            # original media and OS page cache were warmed during fixture setup.
            grid_paths = thumbnails or original_paths
            groups.append(run_group(port, ready['pid'], 'grid-backend-cache-cold', grid_paths, cold_concurrency))
            conditional_probe = []
            for path in grid_paths:
                first, _ = request(port, path)
                headers = {key.lower(): value for key, value in first['headers'].items()}
                conditional = ({'If-None-Match': headers['etag']} if 'etag' in headers else
                               {'If-Modified-Since': headers['last-modified']} if 'last-modified' in headers else {})
                repeated, _ = request(port, path, headers=conditional)
                conditional_probe.append({'first': first, 'conditional_headers': conditional, 'repeat': repeated})
            for concurrency in concurrency_values:
                selected = [grid_paths[index % len(grid_paths)] for index in range(requests)]
                groups.append(run_group(port, ready['pid'], f'grid-warm-c{concurrency}', selected, concurrency, 1))
                originals = [original_paths[index % len(original_paths)] for index in range(requests)]
                groups.append(run_group(port, ready['pid'], f'original-control-c{concurrency}', originals, concurrency, 1))
                expected_bytes = sum(media_files[index % len(media_files)].stat().st_size for index in range(requests))
                if groups[-1]['client_body_bytes'] != expected_bytes or groups[-1]['errors']:
                    raise RuntimeError('Original control failed byte-count integrity check')
            # Socket cancellation uses a fresh sparse file, never decoded. It is
            # created after list/catalog measurement so cardinality is unchanged.
            cancel_file = fixture / 'media/cancel.bin'
            with cancel_file.open('wb') as stream:
                stream.truncate(64 * 1024 * 1024)
            groups.append(run_group(port, ready['pid'], 'original-socket-cancel',
                                    [f'/cache/{code}/get/cancel.bin'] * 4, 2, cancel_after=65536))
            result = {'ready': ready, 'fixture': fixture_manifest,
                      'thumbnail_endpoint_available': bool(thumbnails), 'list_catalog': catalog_result,
                      'legacy_list_entries_verified': len(listing), 'conditional_probe': conditional_probe,
                      'groups': groups, 'limits': [
                          'loopback Linux host; not Wi-Fi, Pi, browser, Flutter smoothness or client memory',
                          'AOT server process with benchmark-only body observer; no hardware services',
                          '/info latency is HTTP/event-loop responsiveness, not real configuration RPC',
                          'small samples describe these observations; no stable p99 claim',
                          'no browser/client HTTP cache simulation; warm means backend derivatives only',
                      ]}
            (result_dir / 'raw.json').write_text(json.dumps(result, indent=2) + '\n')
            return result
        finally:
            try:
                request(port, '/__probe/stop')
                process.wait(timeout=5)
            except Exception:
                process.kill()
                process.wait(timeout=5)
            finally:
                process._gallery_stderr.close()
            if process.returncode != 0:
                raise RuntimeError(f'Server exit {process.returncode}; see {result_dir}')


def write_summary(destination, results):
    compact = []
    for trial, result in enumerate(results):
        for group in result['groups']:
            compact.append({'trial': trial, 'metadata_entries': result['fixture']['metadata_only_jpgs'],
                            **{key: value for key, value in group.items()
                               if key not in ('server', 'responses', 'info_responses', 'process_samples')},
                            'server_max_active_bodies': group['server']['max_bodies'],
                            'server_source_bytes': sum(item['source_bytes'] for item in group['server']['bodies']),
                            'server_source_cancellations': sum(item['source_cancelled'] for item in group['server']['bodies']),
                            'event_loop_lateness_ms': distribution(group['server']['event_loop_lateness_ms'])})
    (destination / 'summary.json').write_text(json.dumps(compact, indent=2) + '\n')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--variant', required=True)
    parser.add_argument('--freeze-current', action='store_true', help='Freeze current backend/common first')
    parser.add_argument('--reuse-binary', action='store_true', help='Repeat using the existing verified AOT binary')
    parser.add_argument('--dart', type=Path, default=DEFAULT_DART)
    parser.add_argument('--packages', type=Path, default=ROOT / 'backend/.dart_tool/package_config.json')
    parser.add_argument('--harness', type=Path, default=TOOL / 'gallery_http_server.dart')
    parser.add_argument('--sizes', default='1000,10000')
    parser.add_argument('--concurrency', default='1,4,10')
    parser.add_argument('--requests', type=int, default=12)
    parser.add_argument('--bucket', type=int, choices=(256, 512, 1024), default=256)
    parser.add_argument('--cold-concurrency', type=int, default=1)
    parser.add_argument('--repeats', type=int, default=3)
    parser.add_argument('--run-name', default='confirmed', help='New immutable measurement subdirectory')
    parser.add_argument('--media', type=Path, action='append')
    args = parser.parse_args()
    sizes = [int(value) for value in args.sizes.split(',')]
    concurrency = [int(value) for value in args.concurrency.split(',')]
    if min(sizes) < 0 or min(concurrency) < 1 or args.requests < 1 or args.repeats < 1 or args.cold_concurrency < 1:
        parser.error('Sizes must be nonnegative; other counts must be positive')
    variant = args.output.resolve() / args.variant
    if args.freeze_current:
        snapshot_current(args.packages, variant)
    if args.reuse_binary:
        verify_snapshot(variant)
        binary = variant / 'execution/gallery-http-server'
        build = json.loads((variant / 'execution/build.json').read_text())
        if digest(binary) != build['binary_sha256']:
            raise ValueError('Frozen AOT binary changed')
    else:
        binary = compile_server(args.dart, variant, args.harness)
    media_files = args.media or [ROOT / 'benchmarks/assets/media/photo_a.jpg',
                                ROOT / 'benchmarks/assets/media/photo_b.jpg',
                                ROOT / 'benchmarks/assets/media/photo_large.jpg']
    if len({file.name for file in media_files}) != len(media_files):
        parser.error('Media filenames must be unique')
    if not args.run_name or Path(args.run_name).name != args.run_name or args.run_name in ('.', '..'):
        parser.error('run-name must be one directory name')
    measured = variant / 'execution' / args.run_name
    measured.mkdir(exist_ok=False)
    shutil.copy2(__file__, measured / 'gallery_http.py')
    (measured / 'run.json').write_text(json.dumps({
        'runner_sha256': digest(__file__), 'binary_sha256': digest(binary),
        'sizes': sizes, 'concurrency': concurrency, 'requests': args.requests,
        'repeats': args.repeats, 'media': [str(file.resolve()) for file in media_files],
        'run_name': args.run_name,
        'bucket': args.bucket,
        'cold_concurrency': args.cold_concurrency,
    }, indent=2) + '\n')
    results = []
    for count in sizes:
        for repeat in range(args.repeats):
            trial = measured / f'n{count}-r{repeat}'
            result = run_trial(binary, trial, count, media_files, concurrency, args.requests, args.bucket, args.cold_concurrency)
            results.append(result)
            write_summary(measured, results)
            print(json.dumps({'trial': str(trial), 'thumbnail_endpoint_available': result['thumbnail_endpoint_available']}), flush=True)


if __name__ == '__main__':
    main()
