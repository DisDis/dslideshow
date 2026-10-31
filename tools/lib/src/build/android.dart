import 'dart:async';
import 'dart:io';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:pub_semver/pub_semver.dart';
import 'package:yaml/yaml.dart';

import '../process/supervisor.dart';
import '../repository.dart';

final _log = Logger('AndroidBuild');

Future<File> buildAndroidApk(
  Directory repository, {
  required Future<int> Function(List<String> arguments, String workingDirectory) runFlutter,
}) async {
  _log.info('action=start versionSource=backend');
  try {
    final pubspec = loadYaml(await File(p.join(repository.path, 'backend/pubspec.yaml')).readAsString());
    if (pubspec is! YamlMap || pubspec['version'] is! String) {
      throw const FormatException('backend/pubspec.yaml must contain a version');
    }
    final version = Version.parse(pubspec['version'] as String);
    final buildNumber = version.build.length == 1 ? int.tryParse(version.build.single.toString()) : null;
    if (buildNumber == null || buildNumber < 1 || buildNumber > 2100000000) {
      throw const FormatException('Backend version must include an Android build number: major.minor.patch+N');
    }
    final app = p.join(repository.path, 'config_app');
    final appPubspec = File(p.join(app, 'pubspec.yaml'));
    final appSource = await appPubspec.readAsString();
    final appYaml = loadYaml(appSource);
    final versionNode = appYaml is YamlMap ? appYaml.nodes['version'] : null;
    if (versionNode is! YamlScalar || versionNode.value is! String) {
      throw const FormatException('config_app/pubspec.yaml must contain a version');
    }
    if (versionNode.value != version.toString()) {
      await appPubspec.writeAsString(
        appSource.replaceRange(versionNode.span.start.offset, versionNode.span.end.offset, version.toString()),
      );
    }
    _log.info('action=version package=config_app version=$version');
    _log.info('action=build version=$version');
    final code = await runFlutter(['build', 'apk', '--release'], app);
    if (code != 0) throw ProcessJobFailure('android', code);
    final source = File(p.join(app, 'build/app/outputs/flutter-apk/app-release.apk'));
    final output = await source.copy(p.join(source.parent.path, 'config_app_$version.apk'));
    _log.info('action=finish result=passed version=$version artifact=${p.basename(output.path)}');
    return output;
  } on ProcessJobFailure catch (error, stack) {
    if (error.code == 130 || error.code == 143) {
      _log.info('action=finish result=cancelled code=${error.code}', error, stack);
    } else {
      _log.severe('action=finish result=failed code=${error.code}', error, stack);
    }
    rethrow;
  } on Object catch (error, stack) {
    _log.severe('action=finish result=failed type=${error.runtimeType}', error, stack);
    rethrow;
  }
}

Future<int> runAndroidBuild(List<String> arguments) async {
  final parser = ArgParser()..addFlag('help', abbr: 'h', negatable: false);
  final usage = 'Usage: dslideshow_tools build-android [options]\n${parser.usage}';
  final ArgResults parsed;
  try {
    parsed = parser.parse(arguments);
  } on FormatException catch (error) {
    throw UsageException(error.message, usage);
  }
  if (parsed.flag('help')) {
    stdout.writeln(usage);
    return 0;
  }
  if (parsed.rest.isNotEmpty) throw UsageException('Unexpected arguments', usage);
  final root = findRepository();
  final supervisor = ProcessSupervisor();
  final signals = <StreamSubscription<ProcessSignal>>[
    ProcessSignal.sigint.watch().listen((_) => unawaited(supervisor.cancel(130))),
    if (!Platform.isWindows) ProcessSignal.sigterm.watch().listen((_) => unawaited(supervisor.cancel(143))),
  ];
  try {
    final output = await buildAndroidApk(
      root,
      runFlutter: (arguments, workingDirectory) =>
          supervisor.run('flutter', arguments, workingDirectory: workingDirectory, label: 'android'),
    );
    stdout.writeln('APK: ${output.path}');
    return 0;
  } on ProcessJobFailure catch (error) {
    return error.code;
  } finally {
    for (final signal in signals) {
      await signal.cancel();
    }
    await supervisor.close();
  }
}
