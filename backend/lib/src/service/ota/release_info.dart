import 'package:pub_semver/pub_semver.dart';

class ReleaseInfo {
  final Version version;
  final String debUrl;

  ReleaseInfo({required this.version, required this.debUrl});

  @override
  String toString() => 'ReleaseInfo(version: $version, debUrl: $debUrl)';
}