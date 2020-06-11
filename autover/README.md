# autover

Auto version increment.

## Getting Started

* Create yaml config file.
```yaml
autover:
  projects:
      backend:
          path: '../backend'
          match_token: '_BACK_'
      frontend:
          path: '../dslideshow_flutter'
          match_token: '_FRONT_'
  targets: ["../common/lib/version.dart.template"]
```
* Create 'version.dart.template' file
```dart
class ApplicationInfo{
  final String frontendVersion = '_FRONT_';
  final String backendVersion = '_BACK_';
}
```
* Run 'dart bin/main.dart -c autover.yaml -v build --apply true'
* Profit (generated 'version.dart' )
```dart
class ApplicationInfo{
  final String frontendVersion = '1.0.0+2';
  final String backendVersion = '1.0.2+1';
}
```

## Features
* Change pubspec.yaml
* Support for changes 'major', 'minor', 'patch', 'build'
* Generate files with version 
