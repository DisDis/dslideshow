import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dslideshow_tools/src/coverage/coverage.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  late Directory root;
  setUp(() {
    root = Directory.systemTemp.createTempSync('coverage-provenance-');
  });
  tearDown(() => root.deleteSync(recursive: true));

  test('source fingerprint includes collector, reporter, shared services, entrypoint and resolved dependencies', () {
    for (final name in [
      'bin/dslideshow_tools.dart',
      'lib/src/coverage/cli.dart',
      'lib/src/coverage/coverage.dart',
      'lib/src/process/supervisor.dart',
      'pubspec.yaml',
      'pubspec.lock',
    ]) {
      final file = File(p.join(root.path, name));
      file.parent.createSync(recursive: true);
      file.writeAsStringSync('original $name');
    }
    final original = coverageImplementationSha256(sourcePackage: root);
    expect(coverageImplementationSha256(sourcePackage: root), original);
    for (final name in [
      'bin/dslideshow_tools.dart',
      'lib/src/coverage/cli.dart',
      'lib/src/coverage/coverage.dart',
      'lib/src/process/supervisor.dart',
      'pubspec.yaml',
      'pubspec.lock',
    ]) {
      final file = File(p.join(root.path, name));
      file.writeAsStringSync('changed $name');
      expect(coverageImplementationSha256(sourcePackage: root), isNot(original), reason: name);
      file.writeAsStringSync('original $name');
    }
    final added = File(p.join(root.path, 'lib/src/coverage/new_service.dart'))..writeAsStringSync('// new service');
    expect(coverageImplementationSha256(sourcePackage: root), isNot(original));
    added.deleteSync();
    expect(coverageImplementationSha256(sourcePackage: root), original);
  });

  test('AOT fingerprint hashes actual executable without requiring a source checkout', () {
    final executable = File(p.join(root.path, 'dslideshow_tools'))..writeAsBytesSync([1, 2, 3]);
    expect(coverageImplementationSha256(compiledExecutable: executable), sha256.convert([1, 2, 3]).toString());
    executable.writeAsBytesSync([1, 2, 4]);
    expect(coverageImplementationSha256(compiledExecutable: executable), sha256.convert([1, 2, 4]).toString());
  });
}
