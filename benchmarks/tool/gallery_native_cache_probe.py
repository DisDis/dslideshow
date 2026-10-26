#!/usr/bin/env python3
"""Run identical native-cache warm hits via Flutter test against frozen sources.

No frame/network/GPU access. Metadata cadence is measured locally, not Pi UX.
"""
import argparse
from datetime import datetime, timezone
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess

ROOT = Path(__file__).resolve().parents[2]
FLUTTER = Path('/home/dis/bin/flutter/bin/cache')

HARNESS = r'''
import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import __CACHE_URI__;

Future<Map<String, String>> metadata(Directory root) async => {
  for (final item in await root.list().toList())
    if (item is File && item.path.endsWith('.json'))
      item.path: await item.readAsString(),
};

void main() {
  test('63 actual native warm hits', () async {
    final results = <Map<String, Object?>>[];
    final payload = base64Decode('iVBORw0KGgoAAAANSUhEUgAAAAgAAAAICAIAAABLbSncAAAAEElEQVR4nGNgYPiPAw0pCQCpcD/BFMrqcwAAAABJRU5ErkJggg==');
    for (var trial = 0; trial < 5; trial++) {
      final root = await Directory.systemTemp.createTemp('gallery-native-warm-');
      final cache = GalleryNativeImageCache(directory: root);
      try {
        for (var index = 0; index < 63; index++) {
          final image = await cache.write('scope:$index:revision1:256', Stream.value(payload));
          expect(image.filePath, isNotNull);
        }
        final before = await metadata(root);
        final hits = <double>[];
        final total = Stopwatch()..start();
        for (var index = 0; index < 63; index++) {
          final watch = Stopwatch()..start();
          final image = await cache.get('scope:$index:revision1:256');
          expect(image, isNotNull);
          image!.retain();
          expect(image.byteLength, payload.length);
          image.release();
          hits.add(watch.elapsedMicroseconds / 1000);
        }
        total.stop();
        final after = await metadata(root);
        final close = Stopwatch()..start();
        await cache.close();
        close.stop();
        final persisted = await metadata(root);
        results.add({
          'trial': trial, 'hits': 63, 'hit_ms': hits,
          'total_hit_ms': total.elapsedMicroseconds / 1000,
          'close_ms': close.elapsedMicroseconds / 1000,
          'metadata_changed_on_hits': before.keys.where((key) => before[key] != after[key]).length,
          'metadata_changed_by_close': before.keys.where((key) => before[key] != persisted[key]).length,
        });
      } finally {
        await cache.close();
        await root.delete(recursive: true);
      }
    }
    await File(__OUTPUT__).writeAsString(jsonEncode(results));
  }, timeout: const Timeout(Duration(minutes: 3)));
}
'''

COLD_HARNESS = r'''
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'package:flutter_test/flutter_test.dart';
import __CACHE_URI__;

void main() {
  test('63 actual native cold writes', () async {
    final results = <Map<String, Object?>>[];
    final payload = await File(__PAYLOAD__).readAsBytes();
    for (var trial = 0; trial < 5; trial++) {
      final root = await Directory(__PARENT__).createTemp('gallery-cold-probe-');
      final cache = GalleryNativeImageCache(directory: root);
      final paths = <String>[];
      final release = <void Function()>[];
      try {
        var next = 0;
        final writes = <double>[];
        final total = Stopwatch()..start();
        await Future.wait(List.generate(__CONCURRENCY__, (_) async {
          while (next < 63) {
            final index = next++;
            final watch = Stopwatch()..start();
            final image = await cache.write(
              'scope:$index:revision1:256',
              Stream.fromIterable([
                for (var offset = 0; offset < payload.length; offset += 8192)
                  payload.sublist(offset, math.min(offset + 8192, payload.length)),
              ]),
            );
            image.retain();
            release.add(image.release);
            writes.add(watch.elapsedMicroseconds / 1000);
            expect(image.filePath, isNotNull);
            expect(image.byteLength, payload.length);
            paths.add(image.filePath!);
          }
        }));
        total.stop();
        // Published files must already be complete and readable, not just
        // eventual metadata promises. Validation is outside measured writes.
        for (final path in paths) {
          expect(await File(path).readAsBytes(), payload);
        }
        expect((await root.list().toList()).where((f) => f.path.endsWith('.part')), isEmpty);
        for (final unpin in release) { unpin(); }
        release.clear();
        final close = Stopwatch()..start();
        await cache.close();
        close.stop();
        final reopened = GalleryNativeImageCache(directory: root);
        try {
          for (var index = 0; index < 63; index++) {
            final image = await reopened.get('scope:$index:revision1:256');
            expect(image, isNotNull);
            expect(await File(image!.filePath!).readAsBytes(), payload);
          }
        } finally { await reopened.close(); }
        results.add({
          'trial': trial, 'writes': 63, 'write_ms': writes,
          'concurrency': __CONCURRENCY__, 'payload_bytes': payload.length,
          'fixture_directory': root.path,
          'total_write_ms': total.elapsedMicroseconds / 1000,
          'close_ms': close.elapsedMicroseconds / 1000,
          'complete_immediate_payloads_verified': paths.length,
          'reopened_hits_verified': 63,
        });
      } finally {
        for (final unpin in release) { unpin(); }
        await cache.close();
        await root.delete(recursive: true);
      }
    }
    await File(__OUTPUT__).writeAsString(jsonEncode(results));
  }, timeout: const Timeout(Duration(minutes: 3)));
}
'''


def dart_string(value):
    """A complete Dart literal, including quotes, without interpolation."""
    return json.dumps(str(value), ensure_ascii=True).replace('$', r'\$')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--snapshot', type=Path, required=True)
    parser.add_argument('--freeze-current', action='store_true')
    parser.add_argument('--scenario', choices=('warm', 'cold'), default='warm')
    parser.add_argument('--fixture-parent', type=Path)
    parser.add_argument('--payload', type=Path)
    parser.add_argument('--concurrency', type=int, default=4)
    parser.add_argument('--run-name')
    args = parser.parse_args()
    snapshot = args.snapshot.resolve()
    if args.freeze_current:
        snapshot.mkdir(parents=True, exist_ok=False)
        names = ('gallery_encoded_cache_io.dart', 'media_image_loader.dart')
        for name in names:
            destination = snapshot / 'config_app/lib/src/gallery' / name
            destination.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(ROOT / 'config_app/lib/src/gallery' / name, destination)
        hashes = {str(p.relative_to(snapshot)): hashlib.sha256(p.read_bytes()).hexdigest()
                  for p in snapshot.rglob('*.dart')}
        (snapshot / 'manifest.json').write_text(json.dumps(hashes, indent=2) + '\n')
    manifest = json.loads((snapshot / 'manifest.json').read_text())
    for name, expected in manifest.items():
        if hashlib.sha256((snapshot / name).read_bytes()).hexdigest() != expected:
            raise RuntimeError(f'Frozen source changed: {name}')
    execution = snapshot
    if args.run_name:
        if Path(args.run_name).name != args.run_name:
            parser.error('run-name must be a single directory name')
        execution = snapshot / 'runs' / args.run_name
        execution.mkdir(parents=True, exist_ok=False)
    output = execution / f'{args.scenario}-63.json'
    harness = execution / f'native_{args.scenario}_probe_test.dart'
    if output.exists() or harness.exists():
        raise RuntimeError('Refusing to overwrite an existing probe run')
    source = snapshot / 'config_app/lib/src/gallery/gallery_encoded_cache_io.dart'
    template = HARNESS if args.scenario == 'warm' else COLD_HARNESS
    code = template.replace('__CACHE_URI__', dart_string(source.as_uri())).replace('__OUTPUT__', dart_string(output))
    if args.scenario == 'cold':
        if not args.fixture_parent or not args.payload or args.concurrency < 1:
            parser.error('cold requires existing --fixture-parent, --payload and positive concurrency')
        parent = args.fixture_parent.resolve(strict=True)
        payload = execution / 'payload.jpg'
        shutil.copy2(args.payload, payload)
        code = (code.replace('__PARENT__', dart_string(parent)).replace('__PAYLOAD__', dart_string(payload))
                .replace('__CONCURRENCY__', str(args.concurrency)))
    harness.write_text(code)
    command = [str(FLUTTER / 'dart-sdk/bin/dart'), str(FLUTTER / 'flutter_tools.snapshot'),
               'test', '--no-pub', str(harness)]
    environment = os.environ | {'DASH__SUPPRESS_ANALYTICS': 'true'}
    runner_hash = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
    started = datetime.now(timezone.utc).isoformat()
    result = subprocess.run(command, cwd=ROOT / 'config_app', env=environment,
                            text=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, timeout=300)
    (execution / 'probe.log').write_text(result.stdout)
    (execution / 'probe-provenance.json').write_text(json.dumps({
        'command': command, 'returncode': result.returncode,
        'harness_sha256': hashlib.sha256(harness.read_bytes()).hexdigest(),
        'template_sha256': hashlib.sha256(template.encode()).hexdigest(),
        'runner_sha256': runner_hash,
        'started_utc': started, 'finished_utc': datetime.now(timezone.utc).isoformat(),
        'scenario': args.scenario,
        'scope': 'Flutter VM test, 5 fresh directories, 63 actual native operations; no image decoding, Pi or network',
        **({'fixture_parent': str(parent), 'filesystem_device_id': parent.stat().st_dev,
            'payload_sha256': hashlib.sha256(payload.read_bytes()).hexdigest(),
            'payload_bytes': payload.stat().st_size, 'concurrency': args.concurrency}
           if args.scenario == 'cold' else {}),
    }, indent=2) + '\n')
    if result.returncode:
        print(result.stdout)
        raise SystemExit(result.returncode)
    print(output)


if __name__ == '__main__':
    main()
