import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:path/path.dart' as p;

import 'json_io.dart';

String digest(File file) => sha256.convert(file.readAsBytesSync()).toString();

String sourceFingerprint(Directory root) {
  final bytes = BytesBuilder(copy: false);
  for (final relative in [
    'benchmarks/lib',
    'benchmarks/shaders',
    'dslideshow_flutter/lib',
    'backend/lib',
    'common/lib',
    'tools/lib',
    'tools/bin',
    'tools/tool',
  ]) {
    for (final file in filesBelow(Directory(p.join(root.path, relative)))) {
      bytes.add(utf8.encode(p.relative(file.path, from: root.path)));
      bytes.add(file.readAsBytesSync());
    }
  }
  final inputs = <File>[];
  for (final relative in [
    'benchmarks/pubspec.lock',
    'benchmarks/pubspec.yaml',
    'benchmarks/assets/media/manifest.json',
    'dslideshow_flutter/pubspec.yaml',
    'tools/pubspec.yaml',
    'tools/pubspec.lock',
  ]) {
    final file = File(p.join(root.path, relative));
    if (file.existsSync()) inputs.add(file);
  }
  for (final relative in ['benchmarks/tool', 'benchmarks', 'benchmarks/config']) {
    final dir = Directory(p.join(root.path, relative));
    if (!dir.existsSync()) continue;
    final suffix = relative == 'benchmarks'
        ? '.sh'
        : relative == 'benchmarks/config'
        ? '.json'
        : '.dart';
    inputs.addAll(
      dir.listSync().whereType<File>().where((f) => p.extension(f.path) == suffix).toList()
        ..sort((a, b) => a.path.compareTo(b.path)),
    );
  }
  for (final file in inputs) {
    bytes.add(file.readAsBytesSync());
  }
  final helper = File(p.join(root.path, 'benchmarks/build/benchmark-tools-arm64/tools/dslideshow_tools'));
  if (helper.existsSync()) {
    bytes.add(utf8.encode('benchmark-tools-linux-arm64'));
    bytes.add(utf8.encode(digest(helper)));
  }
  return sha256.convert(bytes.takeBytes()).toString();
}

Future<void> writeBuildInfo(Directory root, String cpu, String mode, {String flutter = 'flutter'}) async {
  Future<String> output(String executable, List<String> args) async {
    final result = await Process.run(executable, args, workingDirectory: root.path);
    if (result.exitCode != 0) {
      throw ProcessException(executable, args, 'Build provenance command failed', result.exitCode);
    }
    return result.stdout.toString().trim();
  }

  final value = {
    'application': 'benchmarks',
    'built_utc': DateTime.now().toUtc().toIso8601String(),
    'cpu': cpu,
    'mode': mode,
    'source_sha256': sourceFingerprint(root),
    'git_commit': await output('git', ['rev-parse', 'HEAD']),
    'git_status': await output('git', ['status', '--porcelain', '--untracked-files=normal']),
    'flutter': decodeStrictJson(await output(flutter, ['--version', '--machine'])),
    'tooling': {
      'implementation': 'dart-v1',
      'target': 'linux-arm64',
      'executable_sha256':
          File(p.join(root.path, 'benchmarks/build/benchmark-tools-arm64/tools/dslideshow_tools')).existsSync()
          ? digest(File(p.join(root.path, 'benchmarks/build/benchmark-tools-arm64/tools/dslideshow_tools')))
          : null,
    },
  };
  writeJson(File(p.join(root.path, 'benchmarks/assets/build-info.json')), value);
}

void prepareOutput(Directory directory) {
  directory.createSync(recursive: true);
  if (directory.listSync().isNotEmpty) throw StateError('Refusing nonempty benchmark output');
}

void writeLaunch(
  File destination,
  File runtime,
  Directory bundle, {
  String renderer = 'opengl',
  List<String> arguments = const [],
  bool compact = false,
}) {
  final app = File(p.join(bundle.path, 'app.so'));
  final value = compact
      ? {
          'runtime': runtime.path,
          'runtime_sha256': digest(runtime),
          'app_so_sha256': digest(app),
          'renderer': renderer,
          'videomode': '2560x1600',
          'attempts': 1,
        }
      : <String, dynamic>{
          'flutter_pi': runtime.path,
          'flutter_pi_sha256': digest(runtime),
          'app_sha256': digest(app),
          'bundle': bundle.path,
          'renderer': renderer,
          'argv': arguments,
          'utc': DateTime.now().toUtc().toIso8601String(),
        };
  writeJson(destination, value);
}
