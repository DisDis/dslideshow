import 'dart:async';
import 'dart:io';

import 'package:dslideshow_backend/src/service/system_info/system_command_runner.dart';

/// Replaces only process execution; tests keep the working WiFiService.
class ControlledWiFiProcessRunner implements SystemCommandRunner {
  final calls =
      <
        ({
          String executable,
          List<String> arguments,
          Map<String, String>? environment,
        })
      >[];
  final pending = <Completer<ProcessResult>>[];
  bool closed = false;
  final closeStarted = Completer<void>();
  Completer<void>? cleanup;
  Future<void>? _closing;

  @override
  Future<ProcessResult> run(
    String executable,
    List<String> arguments, {
    Map<String, String>? environment,
  }) {
    if (closed)
      return Future.error(StateError('Controlled command runner closed'));
    calls.add((
      executable: executable,
      arguments: List.unmodifiable(arguments),
      environment: environment == null ? null : Map.unmodifiable(environment),
    ));
    final completion = Completer<ProcessResult>();
    pending.add(completion);
    return completion.future;
  }

  @override
  Future<void> close() => _closing ??= () async {
    closed = true;
    closeStarted.complete();
    await cleanup?.future;
    for (final completion in pending) {
      if (!completion.isCompleted)
        completion.completeError(
          StateError('Controlled command runner closed'),
        );
    }
  }();
}
