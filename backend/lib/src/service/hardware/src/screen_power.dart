import 'dart:io';

import 'package:dpms/dpms.dart';
import 'package:logging/logging.dart';

import 'hardware_service_config.dart';

abstract interface class ScreenPower {
  Future<void> setPower(bool enabled);
}

/// Keeps legacy scripts working while using DPMS when the embedder provides it.
class SystemScreenPower implements ScreenPower {
  static final _log = Logger('SystemScreenPower');
  final HardwareConfig config;
  final Future<ProcessResult> Function(String script) _runScript;
  final Dpms? Function() _getDpms;

  SystemScreenPower(
    this.config, {
    Future<ProcessResult> Function(String script)? runScript,
    Dpms? Function()? getDpms,
  }) : _runScript = runScript ?? _run,
       _getDpms = getDpms ?? (() => Dpms.instance);

  static Future<ProcessResult> _run(String script) =>
      Process.run(script, const [], runInShell: true);

  @override
  Future<void> setPower(bool enabled) async {
    final script = enabled
        ? config.screenPowerOnScript
        : config.screenPowerOffScript;
    Object? scriptError;
    StackTrace? scriptStack;
    try {
      final result = await _runScript(script);
      if (result.exitCode != 0) {
        throw ProcessException(
          script,
          const [],
          '${result.stderr}',
          result.exitCode,
        );
      }
    } catch (error, stack) {
      scriptError = error;
      scriptStack = stack;
    }

    final dpms = _getDpms();
    if (dpms != null) {
      // tvservice may be unavailable on modern KMS systems. Still try DPMS;
      // a failing DPMS request must not be reported as a confirmed modeset.
      if (scriptError != null) {
        _log.warning(
          'Legacy screen script failed; trying DPMS',
          scriptError,
          scriptStack,
        );
      }
      dpms.setMode(enabled ? PowerMode.on : PowerMode.off);
    } else if (scriptError != null) {
      Error.throwWithStackTrace(scriptError, scriptStack!);
    }
  }
}
