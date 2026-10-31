import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:pool/pool.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:yaml/yaml.dart';

import '../process/supervisor.dart';
import '../repository.dart';
import '../testing/groups.dart';
import '../testing/profile.dart';
import '../testing/selection.dart';

enum BuildBranch { analyze, tests, aot, web }

enum BuildTestReporter { expanded, compact }

enum _ReleasePhase { prepare, workers, package }

enum _TestScope { release, tools }

/// Coordinates one release attempt; source mutations finish before workers start.
class BuildPipeline {
  BuildPipeline({
    Directory? root,
    ProcessSupervisor? supervisor,
    this.jobs = 3,
    this.flutterTestConcurrency = 4,
    this.testReporter = BuildTestReporter.expanded,
    this.testReportDirectory,
    this.toolsTestReportDirectory,
    String? dartExecutable,
    this.flutterExecutable = 'flutter',
    this.versionTool,
  }) : root = root ?? findRepository(),
       supervisor = supervisor ?? ProcessSupervisor(),
       dartExecutable = dartExecutable ?? findDartExecutable(),
       _packageSlots = Pool(jobs) {
    if (jobs < 1) throw ArgumentError.value(jobs, 'jobs', 'Must be positive');
    if (flutterTestConcurrency < 1) {
      throw ArgumentError.value(flutterTestConcurrency, 'flutterTestConcurrency', 'Must be positive');
    }
  }

  static final _log = Logger('build');
  static const dartPackages = ['common', 'rpc_serializers_generator', 'backend', 'autover', 'autover/example', 'tools'];
  static const flutterPackages = ['i18n', 'system_metrics_widget', 'dslideshow_flutter', 'config_app', 'benchmarks'];
  final Directory root;
  final ProcessSupervisor supervisor;
  final int jobs;
  final int flutterTestConcurrency;
  final BuildTestReporter testReporter;
  final Directory? testReportDirectory;
  final Directory? toolsTestReportDirectory;
  final String dartExecutable;
  final String flutterExecutable;
  final String? versionTool;
  final Pool _packageSlots;
  Version? _preparedVersion;
  String? _preparedApplicationInfo;
  String? _preparedRuntimeHash;
  String get staging => p.join(root.path, 'deb_factory/dslideshow_arm64');

  Future<void> analyze() => _packages([
    for (final package in dartPackages) (package, dartExecutable, ['analyze', '--fatal-warnings']),
    for (final package in flutterPackages)
      (package, flutterExecutable, ['analyze', '--no-pub', '--fatal-warnings', '--no-fatal-infos']),
  ], BuildBranch.analyze);

  Future<void> tests({TestGroup? group}) => _tests(_TestScope.release, group: group);

  Future<void> toolsTests() => _tests(_TestScope.tools);

  Future<void> _tests(_TestScope scope, {TestGroup? group}) async {
    final directory = scope == _TestScope.release ? testReportDirectory : toolsTestReportDirectory;
    final commands = <(String, String, List<String>)>[];
    final selectedSuites = <String, List<String>>{};
    List<String>? releaseTools;
    if (scope == _TestScope.release) {
      try {
        releaseTools = requiredReleaseToolSuites(root);
      } on FileSystemException catch (error, stack) {
        _log.severe(
          'run=${supervisor.runId} action=tests scope=${scope.name} result=failed group=${group?.cliName ?? 'full'} '
          'reason=required-suite path=${error.path} elapsedMs=${supervisor.elapsedMilliseconds}',
          error,
          stack,
        );
        rethrow;
      }
    }
    for (final package in scope == _TestScope.release ? testPackages : const ['tools']) {
      final available = package == 'tools' && releaseTools != null ? releaseTools : allTestSuites(root, package);
      final suites = group == null
          ? available
          : available.where((suite) => testGroupForSuite(root, package, suite) == group).toList();
      if (group != null && suites.isEmpty) continue;
      selectedSuites[package] = suites;
      final passPaths = group != null || scope == _TestScope.release && package == 'tools';
      final flutter = flutterPackages.contains(package);
      commands.add((
        package,
        flutter ? flutterExecutable : dartExecutable,
        [
          'test',
          '--reporter=${testReporter.name}',
          if (flutter) '--no-pub',
          if (flutter) '--concurrency=$flutterTestConcurrency',
          if (package == 'backend') '--concurrency=1',
          if (directory != null) '--file-reporter=json:${p.join(directory.absolute.path, '$package.jsonl')}',
          if (passPaths) ...suites,
        ],
      ));
    }
    if (directory != null) {
      if (directory.existsSync() && directory.listSync(followLinks: false).isNotEmpty) {
        throw StateError('Test report directory must be empty; select a fresh directory');
      }
      await directory.create(recursive: true);
      await File(p.join(directory.path, 'scope.json')).writeAsString(
        '${const JsonEncoder.withIndent('  ').convert({'schema_version': 1, 'expected_packages': commands.map((command) => command.$1).toList(), 'expected_suites': selectedSuites})}\n',
      );
    }
    _log.info(
      'run=${supervisor.runId} action=tests scope=${scope.name} result=started group=${group?.cliName ?? 'full'} '
      'packages=${commands.length} jobs=$jobs flutterTestConcurrency=$flutterTestConcurrency '
      'elapsedMs=${supervisor.elapsedMilliseconds}',
    );
    await _packages(commands, BuildBranch.tests);
    _checkCancelled('tests');
    if (directory != null) {
      final profileStartedAt = supervisor.elapsedMilliseconds;
      _log.info(
        'run=${supervisor.runId} action=test-profile scope=${scope.name} result=started directory=${directory.absolute.path} '
        'elapsedMs=$profileStartedAt',
      );
      try {
        await writeTestProfile(
          root,
          directory,
          expectedPackages: commands.map((command) => command.$1).toList(),
          expectedSuites: selectedSuites,
        );
        _checkCancelled('test-profile');
      } on Object catch (error, stack) {
        final code = supervisor.cancellationCode;
        final cancelled = code == 130 || code == 143;
        final finishedAt = supervisor.elapsedMilliseconds;
        _log.log(
          cancelled ? Level.INFO : Level.SEVERE,
          'run=${supervisor.runId} action=test-profile scope=${scope.name} result=${cancelled ? 'cancelled' : 'failed'} '
          'reason=${error.runtimeType} directory=${directory.absolute.path} '
          'durationMs=${finishedAt - profileStartedAt} elapsedMs=$finishedAt',
          error,
          stack,
        );
        rethrow;
      }
      final finishedAt = supervisor.elapsedMilliseconds;
      _log.info(
        'run=${supervisor.runId} action=test-profile scope=${scope.name} result=passed directory=${directory.absolute.path} '
        'durationMs=${finishedAt - profileStartedAt} elapsedMs=$finishedAt',
      );
    }
    _log.info(
      'run=${supervisor.runId} action=tests scope=${scope.name} result=passed group=${group?.cliName ?? 'full'} '
      'packages=${commands.length} elapsedMs=${supervisor.elapsedMilliseconds}',
    );
  }

  Future<void> _packages(List<(String, String, List<String>)> commands, BuildBranch branch) async {
    final readyAt = supervisor.elapsedMilliseconds;
    for (final command in commands) {
      _log.info(
        'run=${supervisor.runId} branch=${branch.name} job=${branch.name}:${command.$1} '
        'action=queued elapsedMs=${supervisor.elapsedMilliseconds}',
      );
    }
    final pending = commands.iterator;
    Future<void> worker() async {
      while (pending.moveNext()) {
        final (package, executable, arguments) = pending.current;
        final label = '${branch.name}:$package';
        _checkCancelled(label);
        await _packageSlots.withResource(() async {
          _checkCancelled(label);
          final dequeuedAt = supervisor.elapsedMilliseconds;
          _log.info(
            'run=${supervisor.runId} branch=${branch.name} job=$label action=dequeued '
            'queueWaitMs=${dequeuedAt - readyAt} elapsedMs=$dequeuedAt',
          );
          await _command(executable, arguments, package, label);
        });
      }
    }

    await Future.wait([for (var workerIndex = 0; workerIndex < jobs; workerIndex++) worker()]);
  }

  void _checkCancelled(String label) {
    final code = supervisor.cancellationCode;
    if (code != null) throw ProcessJobFailure(label, code, reason: 'cancelled');
  }

  Future<void> aot() =>
      _command('flutterpi_tool', ['build', '--arch=arm64', '--cpu=pi4', '--release'], 'dslideshow_flutter', 'aot');

  Future<void> web() => _command(
    flutterExecutable,
    ['build', 'web', '--release', '--no-pub', '--no-web-resources-cdn', '--wasm'],
    'config_app',
    'web',
  );

  Future<void> _command(String executable, List<String> arguments, String package, String label) async {
    try {
      await supervisor.run(executable, arguments, workingDirectory: p.join(root.path, package), label: label);
    } on Object {
      await supervisor.cancel();
      rethrow;
    }
  }

  Version _version(String package) {
    final data = loadYaml(File(p.join(root.path, package, 'pubspec.yaml')).readAsStringSync()) as YamlMap;
    return Version.parse(data['version'] as String);
  }

  /// Keeps the established autover invocation and verifies its actual output.
  Future<void> prepare() async {
    final before = _version('dslideshow_flutter');
    if (_version('backend') != before) throw StateError('Frontend/backend versions differ');
    final runtime = File(p.join(root.path, 'deb_factory/source_arm64/flutter-pi/flutter-pi'));
    _preparedRuntimeHash = (await sha256.bind(runtime.openRead()).first).toString();
    final applicationTemplate = await File(p.join(root.path, 'common/lib/version.dart.template')).readAsString();
    final directory = Directory(staging);
    if (directory.existsSync()) await directory.delete(recursive: true);
    await directory.create(recursive: true);
    await supervisor.run('cp', [
      '-a',
      '${p.join(root.path, 'deb_factory/template_build_arm64')}/.',
      staging,
    ], label: 'staging');
    await supervisor.run(
      dartExecutable,
      [
        versionTool ?? p.join(root.path, 'autover/bin/main.dart'),
        '-c',
        'autover.yaml',
        '-v',
        'build',
        '--apply',
        'true',
      ],
      workingDirectory: p.join(root.path, 'dslideshow_flutter'),
      label: 'version',
    );
    final build = (int.tryParse(before.build.isEmpty ? '0' : '${before.build.first}') ?? 0) + 1;
    final expected = Version(before.major, before.minor, before.patch, build: '$build');
    final applicationInfo = applicationTemplate.replaceAll('_FRONT_', '$expected').replaceAll('_BACK_', '$expected');
    final versionFile = File(p.join(staging, 'opt/dslideshow/version'));
    if (_version('backend') != expected ||
        _version('dslideshow_flutter') != expected ||
        !versionFile.existsSync() ||
        versionFile.readAsStringSync().trim() != '$expected' ||
        File(p.join(root.path, 'common/lib/version.dart')).readAsStringSync() != applicationInfo) {
      throw StateError('Version generation did not produce the expected synchronized version');
    }
    _preparedVersion = expected;
    _preparedApplicationInfo = applicationInfo;
    _log.info(
      'run=${supervisor.runId} action=version result=passed version=$expected elapsedMs=${supervisor.elapsedMilliseconds}',
    );
  }

  /// Publishes a final filename only after packaging and metadata checks succeed.
  Future<File> package() async {
    final destination = p.join(staging, 'opt/dslideshow');
    final version = _preparedVersion;
    if (version == null ||
        _version('dslideshow_flutter') != version ||
        _version('backend') != version ||
        File(p.join(destination, 'version')).readAsStringSync().trim() != '$version' ||
        File(p.join(root.path, 'common/lib/version.dart')).readAsStringSync() != _preparedApplicationInfo) {
      throw StateError('Release metadata changed during the build');
    }
    final aotPath = p.join(root.path, 'dslideshow_flutter/build/flutter-pi/pi4-64');
    final webPath = p.join(root.path, 'config_app/build/web');
    final app = File(p.join(aotPath, 'app.so'));
    if (!app.existsSync() || app.lengthSync() == 0 || !File(p.join(webPath, 'index.html')).existsSync()) {
      throw StateError('Successful workers did not produce their application assets');
    }
    await supervisor.run('cp', ['-a', '$aotPath/.', destination], label: 'copy:aot');
    await supervisor.run('cp', [
      '-a',
      p.join(root.path, 'deb_factory/source_arm64/flutter-pi/flutter-pi'),
      p.join(destination, 'flutter-pi'),
    ], label: 'copy:runtime');
    final packagedRuntime = File(p.join(destination, 'flutter-pi'));
    if ((await sha256.bind(packagedRuntime.openRead()).first).toString() != _preparedRuntimeHash) {
      throw StateError('Native runtime changed during the build');
    }
    await supervisor.run('cp', ['-a', webPath, destination], label: 'copy:web');
    final template = File(p.join(destination, 'version.template'));
    if (template.existsSync()) await template.delete();
    final files = await Directory(p.join(staging, 'opt'))
        .list(recursive: true, followLinks: false)
        .where((entity) => entity is File)
        .cast<File>()
        .toList();
    files.sort((a, b) => a.path.compareTo(b.path));
    final checksums = File(p.join(staging, 'DEBIAN/md5sums')).openWrite();
    try {
      for (final file in files) {
        final digest = await md5.bind(file.openRead()).first;
        checksums.writeln('$digest  ${p.posix.joinAll(p.split(p.relative(file.path, from: staging)))}');
      }
    } finally {
      await checksums.close();
    }
    final output = File(p.join(root.path, 'deb_factory/dslideshow-$version-arm64-pi4.deb'));
    if (output.existsSync()) throw StateError('An artifact for this version already exists');
    final partial = File('${output.path}.${supervisor.runId}.partial');
    try {
      await supervisor.run('dpkg-deb', [
        '-Zxz',
        '--build',
        '--root-owner-group',
        staging,
        partial.path,
      ], label: 'package');
      final metadataDirectory = await Directory.systemTemp.createTemp('dslideshow-deb-metadata-');
      try {
        final metadata = File(p.join(metadataDirectory.path, 'control'));
        final sink = metadata.openWrite();
        try {
          await supervisor.run('dpkg-deb', ['-f', partial.path], label: 'verify:deb', stdoutSink: sink);
        } finally {
          await sink.close();
        }
        if (await metadata.length() > 1024 * 1024) throw StateError('Unexpected DEB control size');
        final fields = <String, String>{};
        for (final line in await metadata.readAsLines()) {
          final colon = line.indexOf(':');
          if (colon > 0 && !line.startsWith(' ')) fields[line.substring(0, colon)] = line.substring(colon + 1).trim();
        }
        if (fields['Package'] != 'dslideshow' || fields['Version'] != '$version' || fields['Architecture'] != 'arm64') {
          throw StateError('DEB metadata differs from the release inputs');
        }
      } finally {
        await metadataDirectory.delete(recursive: true);
      }
      if (supervisor.cancellationCode != null) throw ProcessJobFailure('package', supervisor.cancellationCode!);
      // Both names are on the same filesystem. Hard-link publication refuses
      // an existing destination atomically, unlike rename() on Linux.
      final publication = await Process.run('ln', ['--', partial.path, output.path]);
      if (publication.exitCode != 0) throw StateError('Cannot publish DEB without replacing an existing artifact');
      if (supervisor.cancellationCode != null) {
        await output.delete();
        throw ProcessJobFailure('package', supervisor.cancellationCode!);
      }
      _log.info(
        'run=${supervisor.runId} action=package result=passed version=$version elapsedMs=${supervisor.elapsedMilliseconds}',
      );
      return output;
    } finally {
      if (partial.existsSync()) await partial.delete();
    }
  }

  /// Executes independent branches and never packages failed or cancelled work.
  Future<File> release({Map<BuildBranch, Future<void> Function()>? branches}) async {
    var phase = _ReleasePhase.prepare;
    final clock = Stopwatch()..start();
    final lockFile = File(p.join(root.path, 'tools/.dart_tool/release.lock'));
    await lockFile.parent.create(recursive: true);
    final lock = await lockFile.open(mode: FileMode.append);
    var locked = false;
    File? published;
    try {
      await lock.lock(FileLock.exclusive);
      locked = true;
      await _phase(phase, prepare);
      phase = _ReleasePhase.workers;
      final work =
          branches ??
          {BuildBranch.analyze: analyze, BuildBranch.tests: tests, BuildBranch.aot: aot, BuildBranch.web: web};
      if (work.length != BuildBranch.values.length || !BuildBranch.values.every(work.containsKey)) {
        throw ArgumentError('A release requires all four branches');
      }
      await _phase(phase, () => Future.wait([for (final branch in BuildBranch.values) _branch(branch, work[branch]!)]));
      phase = _ReleasePhase.package;
      final artifact = await _phase(phase, package);
      published = artifact;
      return artifact;
    } on Object catch (error, stack) {
      final code = supervisor.cancellationCode;
      final cancelled = code == 130 || code == 143;
      _log.log(
        cancelled ? Level.INFO : Level.SEVERE,
        'run=${supervisor.runId} action=release phase=${phase.name} result=${cancelled ? 'cancelled' : 'failed'} '
        'reason=${error.runtimeType} releaseDurationMs=${clock.elapsedMilliseconds} elapsedMs=${supervisor.elapsedMilliseconds}',
        error,
        stack,
      );
      try {
        await supervisor.cancel();
      } on Object catch (cleanupError, stack) {
        _log.severe(
          'run=${supervisor.runId} action=release-cleanup phase=cancel result=failed '
          'reason=${cleanupError.runtimeType} elapsedMs=${supervisor.elapsedMilliseconds}',
          cleanupError,
          stack,
        );
      }
      rethrow;
    } finally {
      try {
        try {
          await supervisor.close();
        } finally {
          // Staging remains exclusively owned until every worker is stopped.
          try {
            if (locked) await lock.unlock();
          } finally {
            await lock.close();
          }
        }
        // No await may separate this last cancellation check from success.
        if (published != null) _checkCancelled('release');
      } on Object catch (cleanupError, stack) {
        if (published != null) {
          if (published.existsSync()) published.deleteSync();
          rethrow;
        }
        // A failing release already has an exception in flight. Keep its cause.
        _log.severe(
          'run=${supervisor.runId} action=release-cleanup phase=close result=failed '
          'reason=${cleanupError.runtimeType} elapsedMs=${supervisor.elapsedMilliseconds}',
          cleanupError,
          stack,
        );
      }
    }
  }

  Future<T> _phase<T>(_ReleasePhase phase, Future<T> Function() work) async {
    final startedAt = supervisor.elapsedMilliseconds;
    _log.info('run=${supervisor.runId} action=release phase=${phase.name} result=started elapsedMs=$startedAt');
    final result = await work();
    final finishedAt = supervisor.elapsedMilliseconds;
    _log.info(
      'run=${supervisor.runId} action=release phase=${phase.name} result=passed '
      'durationMs=${finishedAt - startedAt} elapsedMs=$finishedAt',
    );
    return result;
  }

  Future<void> _branch(BuildBranch branch, Future<void> Function() run) async {
    _log.info('run=${supervisor.runId} branch=${branch.name} action=start elapsedMs=${supervisor.elapsedMilliseconds}');
    try {
      await run();
      _log.info(
        'run=${supervisor.runId} branch=${branch.name} result=passed elapsedMs=${supervisor.elapsedMilliseconds}',
      );
    } on Object {
      await supervisor.cancel();
      rethrow;
    }
  }

  /// Closes the shared package queue after all requested tasks complete.
  Future<void> close() async {
    await _packageSlots.close();
    await supervisor.close();
  }
}
