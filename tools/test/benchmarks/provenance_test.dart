import 'dart:io';

import 'package:dslideshow_tools/src/benchmarks/provenance.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  test('fingerprint tracks source names/shaders/tools and ignores build output', () {
    final root = Directory.systemTemp.createTempSync('fingerprint-');
    addTearDown(() => root.deleteSync(recursive: true));
    File write(String name, String value) {
      final f = File(p.join(root.path, name));
      f.parent.createSync(recursive: true);
      f.writeAsStringSync(value);
      return f;
    }

    final shader = write('benchmarks/shaders/radial.frag', 'source');
    write('benchmarks/lib/main.dart', 'main');
    write('tools/lib/probe.dart', 'tool');
    final baseline = sourceFingerprint(root);
    shader.writeAsStringSync('changed');
    expect(sourceFingerprint(root), isNot(baseline));
    shader.writeAsStringSync('source');
    expect(sourceFingerprint(root), baseline);
    write('benchmarks/assets/build-info.json', 'generated');
    write('benchmarks/build/app.so', 'generated');
    expect(sourceFingerprint(root), baseline);
    shader.renameSync(p.join(shader.parent.path, 'renamed.frag'));
    expect(sourceFingerprint(root), isNot(baseline));
  });
  test('nonempty launch output is never reused', () {
    final root = Directory.systemTemp.createTempSync('output-');
    addTearDown(() => root.deleteSync(recursive: true));
    File(p.join(root.path, 'evidence')).writeAsStringSync('preserve');
    expect(() => prepareOutput(root), throwsStateError);
  });
  test('adding/restoring shader inputs and checkout creation order are deterministic', () {
    final first = Directory.systemTemp.createTempSync('fingerprint-first-'),
        second = Directory.systemTemp.createTempSync('fingerprint-second-');
    addTearDown(() => first.deleteSync(recursive: true));
    addTearDown(() => second.deleteSync(recursive: true));
    final inputs = {
      'benchmarks/lib/main.dart': 'main',
      'benchmarks/shaders/radial.frag': 'shader',
      'backend/lib/backend.dart': 'backend',
      'common/lib/common.dart': 'common',
      'tools/lib/tool.dart': 'tool',
      'benchmarks/config/example.json': '{}',
    };
    void fill(Directory root, Iterable<MapEntry<String, String>> entries) {
      for (final entry in entries) {
        final file = File(p.join(root.path, entry.key));
        file.parent.createSync(recursive: true);
        file.writeAsStringSync(entry.value);
      }
    }

    fill(first, inputs.entries);
    fill(second, inputs.entries.toList().reversed);
    final original = sourceFingerprint(first);
    expect(sourceFingerprint(second), original);
    final extra = File(p.join(first.path, 'benchmarks/shaders/nested/other.frag'));
    extra.parent.createSync(recursive: true);
    extra.writeAsStringSync('new');
    expect(sourceFingerprint(first), isNot(original));
    extra.deleteSync();
    expect(sourceFingerprint(first), original);
    for (final name in [
      'benchmarks/.dart_tool/flutter_build/assets/shaders/radial.frag',
      'benchmarks/build/unit_test_assets/shaders/radial.frag',
      'dslideshow_flutter/build/app.so',
    ]) {
      final file = File(p.join(first.path, name));
      file.parent.createSync(recursive: true);
      file.writeAsStringSync('generated');
      expect(sourceFingerprint(first), original);
    }
  });
}
