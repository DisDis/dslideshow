import 'dart:io';

import 'package:path/path.dart' as p;

/// Tooling suites required for application checks and production packaging.
const releaseToolTestSuites = <String>[
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

/// Validates the complete release allowlist before test package jobs start.
List<String> requiredReleaseToolSuites(Directory repository) {
  for (final suite in releaseToolTestSuites) {
    final path = p.join(repository.path, 'tools', suite);
    if (FileSystemEntity.typeSync(path, followLinks: false) != FileSystemEntityType.file) {
      throw FileSystemException('Required release tooling suite is missing or is not a regular file', path);
    }
  }
  return releaseToolTestSuites;
}
