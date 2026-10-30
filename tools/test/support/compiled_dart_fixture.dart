import 'dart:io';

import 'package:cli_util/cli_util.dart' as cli;
import 'package:dslideshow_tools/src/process/supervisor.dart';
import 'package:path/path.dart' as p;

/// Compiles the actual entrypoint once for reuse within one test file.
/// The caller owns [destination] and must register cleanup before awaiting this.
/// Compilation has a 50-second deadline, leaving time for owned child cleanup
/// inside a 60-second setUpAll timeout. Compiler output is drained, never echoed.
Future<File> compileDartFixture(File source, Directory destination, {File? packageConfig}) async {
  final entrypoint = source.absolute;
  final packages = (packageConfig ?? File('.dart_tool/package_config.json')).absolute;
  if (!entrypoint.existsSync() || !packages.existsSync()) {
    throw ArgumentError('Dart fixture source and package configuration must exist');
  }
  final directory = destination.absolute;
  await directory.create(recursive: true);
  final output = File(p.join(directory.path, '${p.basenameWithoutExtension(entrypoint.path)}.dill'));
  if (output.existsSync()) throw StateError('Refusing to replace an existing compiled Dart fixture');
  final dart = cli.dartExecutable;
  if (dart == null) throw StateError('Dart fixture compilation requires the active SDK');
  final owner = ProcessSupervisor(terminationGrace: const Duration(milliseconds: 250));
  String? failure;
  try {
    await owner.run(
      dart,
      [
        '--suppress-analytics',
        'compile',
        'kernel',
        '--packages=${packages.path}',
        '--output=${output.path}',
        entrypoint.path,
      ],
      label: 'fixture-compile',
      streamOutput: false,
      timeout: const Duration(seconds: 50),
    );
    if (!output.existsSync() || output.lengthSync() == 0) failure = 'missing kernel output';
  } on ProcessJobFailure catch (error) {
    failure = 'reason=${error.reason} code=${error.exitCode}';
  } on Object catch (error) {
    failure = 'reason=${error.runtimeType}';
  } finally {
    try {
      await owner.close();
    } on Object catch (error) {
      failure = 'cleanup=${error.runtimeType}';
    }
  }
  if (failure != null) {
    try {
      if (output.existsSync()) await output.delete();
    } on FileSystemException {
      throw StateError('Dart fixture compilation failed; partial kernel cleanup failed');
    }
    throw StateError('Dart fixture compilation failed: $failure');
  }
  return output;
}
