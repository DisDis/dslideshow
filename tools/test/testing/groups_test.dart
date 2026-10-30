import 'dart:io';

import 'package:dslideshow_tools/src/repository.dart';
import 'package:dslideshow_tools/src/testing/groups.dart';
import 'package:dslideshow_tools/src/testing/selection.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  test('every current suite in all eight packages has exactly one primary contract', () {
    final root = findRepository();
    expect(testPackages, hasLength(8));
    for (final package in testPackages) {
      final inventory = allTestSuites(root, package);
      expect(inventory, isNotEmpty, reason: package);
      final grouped = [for (final group in TestGroup.values) ...testSuitesForGroup(root, package, group)];
      expect(grouped.length, inventory.length, reason: package);
      expect(grouped.toSet(), inventory.toSet(), reason: package);
      expect(testSuitesForGroup(root, package, TestGroup.unclassified), isEmpty, reason: package);
    }
  });
  test('effects selects rendering, common/backend models and config editor/preview contracts', () {
    final root = findRepository();
    expect(
      testSuitesForGroup(root, 'common', TestGroup.effects),
      containsAll(['test/effects_test.dart', 'test/effect_presets_test.dart']),
    );
    expect(
      testSuitesForGroup(root, 'backend', TestGroup.effects),
      containsAll(['test/effects_config_test.dart', 'test/photo_motion_config_test.dart']),
    );
    expect(
      testSuitesForGroup(root, 'dslideshow_flutter', TestGroup.effects),
      containsAll([
        'test/mosaic_optimization_test.dart',
        'test/effect_regression_test.dart',
        'test/scaling_sampling_test.dart',
        'test/photo_motion_renderer_test.dart',
      ]),
    );
    expect(
      testSuitesForGroup(root, 'config_app', TestGroup.effects),
      containsAll([
        'test/effects_editor_test.dart',
        'test/visual_editor_preview_test.dart',
        'test/premiere_transitions_preview_test.dart',
      ]),
    );
    expect(testSuitesForGroup(root, 'backend', TestGroup.effects), isNot(contains('test/gallery_catalog_test.dart')));
  });
  test('unknown files stay visible, support files and external symlinks do not become suites', () {
    final root = Directory.systemTemp.createTempSync('test-catalogue-');
    addTearDown(() => root.deleteSync(recursive: true));
    final tests = Directory(p.join(root.path, 'common/test'))..createSync(recursive: true);
    File(p.join(tests.path, 'new_contract_test.dart')).writeAsStringSync('// new contract');
    File(p.join(tests.path, 'support.dart')).writeAsStringSync('// not a suite');
    Link(p.join(tests.path, 'external_test.dart')).createSync('/missing/external_test.dart');
    expect(allTestSuites(root, 'common'), ['test/new_contract_test.dart']);
    expect(testSuitesForGroup(root, 'common', TestGroup.unclassified), ['test/new_contract_test.dart']);
    expect(testGroupForSuite(root, 'common', '../backend/test/effects_config_test.dart'), TestGroup.unclassified);
    expect(() => allTestSuites(root, 'unknown'), throwsArgumentError);
  });
  test('file URI and relative paths use the same catalogue key and canonical CLI names', () {
    final root = Directory('/tmp/catalogue with spaces');
    final absolute = File(p.join(root.path, 'common/test/effects_test.dart'));
    expect(normalizeTestSuite(root, 'common', absolute.uri.toString()), 'test/effects_test.dart');
    expect(normalizeTestSuite(root, 'common', './test/../test/effects_test.dart'), 'test/effects_test.dart');
    expect(testGroupForSuite(root, 'common', absolute.uri.toString()), TestGroup.effects);
    expect(normalizeTestSuite(root, 'common', 'https://secret.invalid/test/effects_test.dart'), isNull);
    expect(normalizeTestSuite(root, 'common', 'file://remote/tmp/effects_test.dart'), isNull);
    expect(normalizeTestSuite(root, 'common', '/outside/test/effects_test.dart'), isNull);
    for (final group in TestGroup.values) {
      expect(parseTestGroup(group.cliName), group);
    }
    expect(parseTestGroup('slideshowMedia'), isNull);
  });

  test('release tooling selection is explicit and excludes independent tool and benchmark suites', () {
    const expected = [
      'test/build/commands_test.dart',
      'test/build/console_test.dart',
      'test/build/grinder_entrypoint_test.dart',
      'test/build/supervisor_test.dart',
      'test/build/web_wrapper_test.dart',
      'test/system/linux_test.dart',
      'test/system/sensors_test.dart',
      'test/testing/groups_test.dart',
      'test/testing/profile_test.dart',
    ];
    final root = Directory.systemTemp.createTempSync('release-tooling-selection-');
    addTearDown(() => root.deleteSync(recursive: true));
    for (final suite in [
      ...expected,
      'test/build/benchmark_bundle_test.dart',
      'test/ambient/probe_test.dart',
      'test/coverage/coverage_test.dart',
      'test/benchmarks/native_pipeline/services_test.dart',
      'test/testing/cli_test.dart',
    ]) {
      final file = File(p.join(root.path, 'tools', suite));
      file.parent.createSync(recursive: true);
      file.writeAsStringSync('// suite catalogue fixture');
    }
    expect(requiredReleaseToolSuites(root), expected);
    expect(allTestSuites(root, 'tools'), hasLength(expected.length + 5));
  });

  test('required release tooling suites must exist as regular files', () {
    final root = Directory.systemTemp.createTempSync('missing-release-tooling-');
    addTearDown(() => root.deleteSync(recursive: true));
    for (final suite in releaseToolTestSuites) {
      final file = File(p.join(root.path, 'tools', suite));
      file.parent.createSync(recursive: true);
      file.writeAsStringSync('// suite catalogue fixture');
    }
    final required = File(p.join(root.path, 'tools', releaseToolTestSuites.last))..deleteSync();
    final failure = throwsA(isA<FileSystemException>().having((error) => error.path, 'path', required.path));
    expect(() => requiredReleaseToolSuites(root), failure);
    Directory(required.path).createSync();
    expect(() => requiredReleaseToolSuites(root), failure);
    Directory(required.path).deleteSync();
    Link(required.path).createSync(p.join(root.path, 'tools', releaseToolTestSuites.first));
    expect(() => requiredReleaseToolSuites(root), failure);
  });
}
