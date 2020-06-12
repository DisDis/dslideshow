import 'package:pub_semver/pub_semver.dart';

class AutoVerConfig{
  final Iterable<TargetConfig> targets;
  final Iterable<ProjectConfig> projects;

  AutoVerConfig(this.targets, this.projects);
}
class ProjectConfig{
  final String name;
  final String path;
  final String matchToken;
  Version version;
  ProjectConfig(this.name, this.path, this.matchToken);
}

class TargetConfig{
  final String filePath;

  TargetConfig(this.filePath);
}