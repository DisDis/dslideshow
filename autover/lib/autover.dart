import 'dart:io';

import 'package:args/args.dart';
import 'package:autover/src/config.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:pub_semver/pub_semver.dart';
import 'package:yaml/yaml.dart';

class AutoVer {
  static final Logger _log = Logger('AutoVer');

  final _parser = ArgParser();
  late ArgResults _argResults;
  late AutoVerConfig _config;
  AutoVer(List<String> args) {
    _log.info('execute');
    _configureArgParser();
    _argResults = _parser.parse(args);
    if (args.isEmpty) {
      _showHelp();
      return;
    }
    _config = _parseYamlConfig(loadYamlDocument(File(_argResults['config'] as String).readAsStringSync()));
    _showConfig();
    if (_argResults['increase-version'] != 'none') {
      _increaseVersion();
    }
    if (_argResults['apply'] == 'true') {
      _applyVersions();
    }
  }

  void _showHelp() {
    _log.info(_parser.usage);
  }

  AutoVerConfig _parseYamlConfig(YamlDocument yaml) {
    _log.info('_parseYamlConfig');
    final autover = yaml.contents.value['autover'] as YamlMap;
    final targets = (autover['targets'] as YamlList).map((dynamic element) => TargetConfig(element as String)).toList();
    final projects = <ProjectConfig>[];
    (autover['projects'] as YamlMap).cast<String, YamlMap>().forEach((key, value) {
      final projectPath = value['path'] as String;
      final projectYaml = loadYamlDocument(File(path.join(projectPath, 'pubspec.yaml')).readAsStringSync());
      final projectVersion = Version.parse(projectYaml.contents.value['version'] as String);
      projects.add(ProjectConfig(name: key, path: projectPath, matchToken: value['match_token'] as String, version: projectVersion));
    });
    return AutoVerConfig(targets, projects);
  }

  void _showConfig() {
    final sb = StringBuffer();
    sb.writeln('');
    sb.writeln('---=== Config ===---');
    sb.writeln('Projects:');
    _config.projects.forEach((element) {
      sb.writeln('   "${element.name}"');
      sb.writeln('       |Token: "${element.matchToken}"');
      sb.writeln('       |Path: "${element.path}"');
      sb.writeln('       |Version: "${element.version}"');
    });
    sb.writeln('Targets:');
    _config.targets.forEach((element) {
      sb.writeln('   "${element.filePath}"');
    });
    sb.writeln('----------------------');

    _log.info(sb.toString());
  }

  void _configureArgParser() {
    _parser.addOption('config', abbr: 'c', help: 'config.yaml', defaultsTo: 'autover.yaml');
    _parser.addMultiOption('project', splitCommas: true, defaultsTo: ['ALL'], abbr: 'p', allowedHelp: {'ALL': 'All projects'});

    _parser.addSeparator('Actions with version');
    _parser.addOption('increase-version', abbr: 'v', allowed: ['major', 'minor', 'patch', 'build', 'none'], defaultsTo: 'none');
    _parser.addOption('apply', defaultsTo: 'false');
  }

  void _increaseVersion() {
    final targetProjectRes = _argResults['project'] as Iterable<String>;
    final projects = <ProjectConfig>{};
    targetProjectRes.forEach((element) {
      if (element == 'ALL') {
        projects.addAll(_config.projects);
        return;
      }
      projects.add(_config.projects.firstWhere((item) => item.name == element));
    });
    _log.info('Increase version for: ');
    projects.forEach((element) {
      final newVersion = _modifyVerions(element.version, _argResults['increase-version'] as String);
      _log.info(' "${element.name}" ${element.version} -> $newVersion');
      var content = File(path.join(element.path, 'pubspec.yaml')).readAsStringSync();
      content = content.replaceFirst(element.version.toString(), newVersion.toString());
      element.version = newVersion;
      File(path.join(element.path, 'pubspec.yaml')).writeAsStringSync(content);
    });
  }

  Version _modifyVerions(Version current, String type) {
    switch (type) {
      case 'major':
        return current.nextMajor;
      case 'minor':
        return current.nextMinor;
      case 'patch':
        return current.nextPatch;
      case 'build':
        var buildNumber = int.tryParse(current.build.isEmpty ? '0' : current.build.first.toString()) ?? 0;
        buildNumber++;
        return Version(current.major, current.minor, current.patch, build: buildNumber.toString());
      default:
        break;
    }
    return current;
  }

  void _applyVersions() {
    _config.targets.forEach((item) {
      final outputFileName = path.withoutExtension(item.filePath);
      var content = File(item.filePath).readAsStringSync();
      _config.projects.forEach((project) {
        content = content.replaceAll(project.matchToken, project.version.toString());
      });
      File(outputFileName).writeAsStringSync(content);
      _log.info('Generate: "$outputFileName"');
    });
  }
}
