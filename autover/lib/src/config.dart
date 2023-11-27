import 'package:pub_semver/pub_semver.dart';

class AutoVerConfig {
  final Iterable<TargetConfig> targets;
  final Iterable<ProjectConfig> projects;

  AutoVerConfig(this.targets, this.projects);
}

class ProjectConfig {
  final String name;
  final String path;
  final String matchToken;
  Version version;
  ProjectConfig({required this.name, required this.path, required this.matchToken, required this.version});
}

class TargetConfig {
  final String filePath;

  TargetConfig(this.filePath);
}
