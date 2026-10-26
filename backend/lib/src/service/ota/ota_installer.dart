import 'dart:async';
import 'dart:convert';
import 'dart:io';

/// The privileged operations are replaceable so upload tests cannot install a
/// package or restart the service.
abstract interface class FirmwareInstaller {
  Future<int> install(File package, {required void Function(String) onOutput});

  Future<void> restart();
}

class ProcessFirmwareInstaller implements FirmwareInstaller {
  const ProcessFirmwareInstaller();

  @override
  Future<int> install(
    File package, {
    required void Function(String) onOutput,
  }) async {
    final process = await Process.start(
      'sudo',
      ['apt-get', '-f', '-y', 'install', package.path],
      environment: {'LC_ALL': 'C', 'TERM': 'xterm-256color', 'COLUMNS': '120'},
    );
    // Observe both output futures immediately, including decoding failures, and
    // keep ownership of the operation until the process has exited.
    final completed = await Future.wait<Object>([
      process.exitCode,
      Future.wait<void>([
        process.stdout.transform(utf8.decoder).forEach(onOutput),
        process.stderr.transform(utf8.decoder).forEach(onOutput),
      ]),
    ]);
    return completed.first as int;
  }

  @override
  Future<void> restart() async {
    final result = await Process.run('sudo', [
      'service',
      'dslideshow',
      'restart',
    ]);
    if (result.exitCode != 0) {
      throw ProcessException(
        'sudo',
        ['service', 'dslideshow', 'restart'],
        'Service restart failed',
        result.exitCode,
      );
    }
  }
}
