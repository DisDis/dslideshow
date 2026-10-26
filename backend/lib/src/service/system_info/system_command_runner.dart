import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

/// The commands used for system information are non-interactive and owned by
/// the service. This interface also allows tests to supply command output.
abstract interface class SystemCommandRunner {
  Future<ProcessResult> run(
    String executable,
    List<String> arguments, {
    Map<String, String>? environment,
  });

  Future<void> close();
}

class SystemCommandOutputLimit implements Exception {
  final int maxBytes;

  const SystemCommandOutputLimit(this.maxBytes);

  @override
  String toString() => 'System command output exceeded $maxBytes bytes';
}

/// Bounds time and output, and waits for owned processes and pipes on close.
/// On Linux, setsid isolates the command's process group and execs the probe in
/// the same process. An absent setsid fails the command safely. The deadline is
/// enforced by the Dart event loop and terminates the whole owned group.
class BoundedSystemCommandRunner implements SystemCommandRunner {
  final Duration deadline;
  final Duration killGrace;
  final int maxOutputBytes;
  final Set<_Command> _commands = {};
  bool _closed = false;
  Future<void>? _closing;

  BoundedSystemCommandRunner({
    this.deadline = const Duration(seconds: 3),
    this.killGrace = const Duration(seconds: 1),
    this.maxOutputBytes = 64 * 1024,
  }) {
    if (deadline <= Duration.zero ||
        killGrace <= Duration.zero ||
        maxOutputBytes <= 0) {
      throw ArgumentError('Command limits must be positive');
    }
  }

  @override
  Future<ProcessResult> run(
    String executable,
    List<String> arguments, {
    Map<String, String>? environment,
  }) {
    if (_closed) return Future.error(StateError('Command runner is closed'));
    final command = _Command(killGrace, maxOutputBytes);
    _commands.add(command);
    command.done = _run(command, executable, arguments, environment);
    // close() observes this future too; attach its error handler immediately.
    command.settled = command.done.then<void>(
      (_) {},
      onError: (Object _, StackTrace __) {},
    );
    return command.done;
  }

  Future<ProcessResult> _run(
    _Command command,
    String executable,
    List<String> arguments,
    Map<String, String>? environment,
  ) async {
    Future<void>? stdoutDone;
    Future<void>? stderrDone;
    try {
      if (_closed) throw StateError('Command runner is closed');
      final process = await Process.start(
        Platform.isLinux ? 'setsid' : executable,
        Platform.isLinux ? ['--', executable, ...arguments] : arguments,
        environment: environment,
      );
      command.process = process;
      // A close that raced Process.start must still own and reap its result.
      if (_closed || command.failure != null) {
        command.stop(StateError('Command runner is closed'));
      }
      stdoutDone = command.collect(process.stdout, command.stdout);
      stderrDone = command.collect(process.stderr, command.stderr);
      command.deadline = Timer(deadline, () {
        command.stop(TimeoutException('System command timed out', deadline));
      });
      await process.stdin.close();
      final result = await Future.wait<dynamic>([
        process.exitCode,
        stdoutDone,
        stderrDone,
      ]);
      if (command.failure != null) {
        // Keep the KILL escalation even if the direct child exited on TERM.
        // A descendant can retain its group after closing inherited pipes.
        await command.termination;
        Error.throwWithStackTrace(command.failure!, command.failureStack!);
      }
      // Do not leave background children started by a completed probe behind.
      command.killGroup(ProcessSignal.sigkill);
      return ProcessResult(
        process.pid,
        result.first as int,
        utf8.decode(command.stdout.takeBytes(), allowMalformed: true),
        utf8.decode(command.stderr.takeBytes(), allowMalformed: true),
      );
    } catch (error, stack) {
      command.stop(error, stack);
      if (command.process != null) {
        await command.termination;
        await command.process!.exitCode;
        await Future.wait<void>([
          if (stdoutDone != null) stdoutDone,
          if (stderrDone != null) stderrDone,
        ]);
      }
      rethrow;
    } finally {
      command.deadline?.cancel();
      _commands.remove(command);
    }
  }

  @override
  Future<void> close() => _closing ??= _close();

  Future<void> _close() async {
    _closed = true;
    final commands = _commands.toList();
    for (final command in commands) {
      command.stop(StateError('Command runner is closed'));
    }
    await Future.wait(commands.map((command) => command.settled));
  }
}

class _Command {
  final Duration killGrace;
  final int maxOutputBytes;
  final BytesBuilder stdout = BytesBuilder(copy: false);
  final BytesBuilder stderr = BytesBuilder(copy: false);
  late final Future<ProcessResult> done;
  late final Future<void> settled;
  Process? process;
  Timer? deadline;
  Object? failure;
  StackTrace? failureStack;
  Future<void>? termination;
  int _bytes = 0;

  _Command(this.killGrace, this.maxOutputBytes);

  Future<void> collect(Stream<List<int>> stream, BytesBuilder output) async {
    try {
      await for (final bytes in stream) {
        final remaining = maxOutputBytes - _bytes;
        if (bytes.length > remaining) {
          if (remaining > 0) output.add(bytes.sublist(0, remaining));
          _bytes = maxOutputBytes;
          stop(SystemCommandOutputLimit(maxOutputBytes));
        } else {
          output.add(bytes);
          _bytes += bytes.length;
        }
      }
    } catch (error, stack) {
      stop(error, stack);
    }
  }

  void stop(Object error, [StackTrace? stack]) {
    failure ??= error;
    failureStack ??= stack ?? StackTrace.current;
    if (process == null || termination != null) return;
    killGroup(ProcessSignal.sigterm);
    termination = Future<void>.delayed(killGrace, () {
      killGroup(ProcessSignal.sigkill);
    });
  }

  void killGroup(ProcessSignal signal) {
    final child = process;
    if (child == null) return;
    if (Platform.isLinux) {
      // Negative pid signals the isolated POSIX process group, including the
      // shell script's children. Fall back for the race before setsid ran.
      if (!Process.killPid(-child.pid, signal)) child.kill(signal);
    } else {
      child.kill(signal);
    }
  }
}
