#!/usr/bin/env python3
"""Run identical native-cache warm hits via Flutter test against frozen sources.

No frame/network/GPU access. Metadata cadence is measured locally, not Pi UX.
"""
import argparse
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
import '__CACHE_URI__';

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
    await File('__OUTPUT__').writeAsString(jsonEncode(results));
  });
}
'''


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--snapshot', type=Path, required=True)
    parser.add_argument('--freeze-current', action='store_true')
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
    output = snapshot / 'warm-63.json'
    harness = snapshot / 'native_warm_probe_test.dart'
    if output.exists() or harness.exists():
        raise RuntimeError('Refusing to overwrite an existing probe run')
    source = snapshot / 'config_app/lib/src/gallery/gallery_encoded_cache_io.dart'
    harness.write_text(HARNESS.replace('__CACHE_URI__', source.as_uri()).replace('__OUTPUT__', str(output)))
    command = [str(FLUTTER / 'dart-sdk/bin/dart'), str(FLUTTER / 'flutter_tools.snapshot'),
               'test', '--no-pub', str(harness)]
    environment = os.environ | {'DASH__SUPPRESS_ANALYTICS': 'true'}
    result = subprocess.run(command, cwd=ROOT / 'config_app', env=environment,
                            text=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, timeout=180)
    (snapshot / 'probe.log').write_text(result.stdout)
    (snapshot / 'probe-provenance.json').write_text(json.dumps({
        'command': command, 'returncode': result.returncode,
        'harness_sha256': hashlib.sha256(harness.read_bytes()).hexdigest(),
        'template_sha256': hashlib.sha256(HARNESS.encode()).hexdigest(),
        'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        'scope': 'Flutter VM test, 5 fresh directories, 63 valid PNGs then 63 sequential metadata hits; no image decoding, Pi or network',
    }, indent=2) + '\n')
    if result.returncode:
        print(result.stdout)
        raise SystemExit(result.returncode)
    print(output)


if __name__ == '__main__':
    main()
