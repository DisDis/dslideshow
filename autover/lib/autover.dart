import 'dart:io';
import 'dart:math';

import 'package:autover/src/config.dart';
import 'package:logging/logging.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:yaml/yaml.dart';
import 'package:args/args.dart';
import 'package:path/path.dart' as path;

class AutoVer {
  static final Logger _log = new Logger('AutoVer');

  final _parser = ArgParser();
  ArgResults _argResults;
  AutoVerConfig _config;
  void execute(List<String> args) async{
    _log.info('execute');
    _configureArgParser();
    _argResults = _parser.parse(args);
    if (args.isEmpty){
      _showHelp();
      return;
    }
    _config = await _parseYamlConfig(loadYamlDocument(new File(_argResults['config']).readAsStringSync()));
    _showConfig();
    if (_argResults['increase-version']!= 'none'){
      _increaseVersion();
    }
    if (_argResults['apply'] == 'true'){
      _applyVersions();
    }
  }

  void _showHelp() {
    _log.info(_parser.usage);
  }

  Future<AutoVerConfig> _parseYamlConfig(YamlDocument yaml) async{
    _log.info('_parseYamlConfig');
    final autover = yaml.contents.value['autover'];
    final List<TargetConfig> targets = (autover['targets'] as YamlList).map((element) => new TargetConfig(element)).toList();
    final List<ProjectConfig> projects = <ProjectConfig>[];
    (autover['projects'] as YamlMap).forEach((key,v) {
      final value = v as YamlMap;
      final projectPath = value["path"] as String;
      final projectYaml = loadYamlDocument(new File(path.join(projectPath,'pubspec.yaml')).readAsStringSync());
      final Version projectVersion = new Version.parse(projectYaml.contents.value['version']);
      projects.add(new ProjectConfig(key, projectPath ,value["match_token"] as String )..version = projectVersion);
    });
    return new AutoVerConfig(targets, projects);
  }

  void _showConfig() {
    StringBuffer sb = new StringBuffer();
    sb.writeln('');
    sb.writeln('---=== Config ===---');
    sb.writeln('Projects:');
    _config.projects.forEach((element) {
      sb.writeln('   "${element.name}"');
      sb.writeln('       |Token: "${element.match_token}"');
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
    _parser.addOption('config',
      abbr: 'c',
      help: 'config.yaml',

    );
    _parser.addMultiOption('project',
      splitCommas: true,
      defaultsTo: ['ALL'],
      abbr: 'p',
      allowedHelp: {'ALL': 'All projects'}
    );

    _parser.addSeparator('Actions with version');
    _parser.addOption('increase-version',
      abbr: 'v',
      allowed: ['major', 'minor', 'patch', 'build' ,'none'],
      defaultsTo: 'none'
    );
    _parser.addOption('apply',
    defaultsTo: 'false');
  }

  void _increaseVersion() {
    final targetProjectRes = _argResults['project'] as Iterable<String>;
    final Set<ProjectConfig> projects = new Set<ProjectConfig>();
    targetProjectRes.forEach((element) {
      if (element == 'ALL'){
        projects.addAll(_config.projects);
        return;
      }
      projects.add(_config.projects.firstWhere((item) => item.name == element));
    });
    _log.info('Increase version for: ');
    projects.forEach((element) {
      final newVersion = _modifyVerions(element.version,_argResults['increase-version']);
      _log.info(' "${element.name}" ${element.version} -> ${newVersion}');
      var content = new File(path.join(element.path,'pubspec.yaml')).readAsStringSync();
      content = content.replaceFirst(element.version.toString(), newVersion.toString());
      element.version = newVersion;
      new File(path.join(element.path,'pubspec.yaml')).writeAsStringSync(content);
    });
  }

  Version _modifyVerions(Version current, String type){
    Version result = current;
    switch (type){
      case 'major':
        result = current.nextMajor;
        break;
      case 'minor':
        result = current.nextMinor;
        break;
      case 'patch':
        result = current.nextPatch;
        break;
      case 'build':
        int buildNumber = int.tryParse( (current.build == null || current.build.isEmpty) ? '0': current.build[0].toString())?? 0;
        buildNumber++;
        result = new Version(current.major, current.minor, current.patch,build: buildNumber.toString());
        break;
      default:
        break;
    }
    return result;
  }

  void _applyVersions() {
    _config.targets.forEach((item) {
      final outputFileName = path.withoutExtension(item.filePath);
      var content = new File(item.filePath).readAsStringSync();
      _config.projects.forEach((project) {
        content = content.replaceAll(project.match_token, project.version.toString());
      });
      new File(outputFileName).writeAsStringSync(content);
      _log.info('Generate: "${outputFileName}"');
    });
  }

}

enum VersionChangeType{
  major,
  minor,
  path,
  build,
  none
}