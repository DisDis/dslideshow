import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dslideshow_common/gallery.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import 'gallery_catalog_service.dart';

part 'gallery_tool_runner.freezed.dart';

enum _ToolLaunchReason { missingExecutable, permissionDenied, invalidExecutable, other }

@freezed
abstract class GalleryToolResult with _$GalleryToolResult {
  const factory GalleryToolResult({required int exitCode, required String stdout, required String stderr}) =
      _GalleryToolResult;
}

/// A command boundary: implementations must finish process and pipe cleanup
/// before completing either successfully or with an error.
abstract interface class GalleryToolRunner {
  Future<GalleryToolResult> run(
    String executable,
    List<String> arguments, {
    Duration? timeout,
    Future<void>? cancellation,
    Map<String, String>? environment,
    bool discardStdout = false,
    int maxOutputBytes = 4 * 1024 * 1024,
  });

  Future<void> close();
}

typedef GalleryProcessStarter = Future<Process> Function(
  String executable,
  List<String> arguments, {
  Map<String, String>? environment,
});

/// Starts executables directly and owns every child. Retained stdout/stderr
/// share one byte limit. Discarded stdout is drained without consuming memory
/// or that limit; stderr remains bounded even for very verbose CLIs.
class ProcessGalleryToolRunner implements GalleryToolRunner {
  static final _log = Logger('ProcessGalleryToolRunner');
  final GalleryProcessStarter _start;
  final Duration killGrace;
  final Duration pipeCleanupTimeout;
  final Set<_GalleryCommand> _active = {};
  bool _closed = false;
  Future<void>? _closing;

  ProcessGalleryToolRunner({
    GalleryProcessStarter? startProcess,
    this.killGrace = const Duration(milliseconds: 200),
    this.pipeCleanupTimeout = const Duration(seconds: 2),
  }) : _start = startProcess ?? _startProcess;

  static Future<Process> _startProcess(String executable, List<String> args, {Map<String, String>? environment}) =>
      Process.start(executable, args, runInShell: false, environment: environment);

  @override
  Future<GalleryToolResult> run(
    String executable,
    List<String> arguments, {
    Duration? timeout,
    Future<void>? cancellation,
    Map<String, String>? environment,
    bool discardStdout = false,
    int maxOutputBytes = 4 * 1024 * 1024,
  }) async {
    if (_closed) {
      throw const GalleryCatalogFailure(GalleryErrorCode.unavailable);
    }
    if (maxOutputBytes < 1 || (timeout != null && timeout <= Duration.zero)) {
      throw const GalleryCatalogFailure(GalleryErrorCode.invalidRequest);
    }
    final command = _GalleryCommand(_start, killGrace, pipeCleanupTimeout, maxOutputBytes, _toolName(executable));
    _active.add(command);
    _log.fine(
      () =>
          'Tool started tool=${command.tool} active=${_active.length} '
          'timeoutMs=${(timeout ?? const Duration(seconds: 60)).inMilliseconds} '
          'maxOutputBytes=$maxOutputBytes discardStdout=$discardStdout',
    );
    try {
      final result = await command.run(
        executable,
        List.unmodifiable(arguments),
        timeout ?? const Duration(seconds: 60),
        cancellation,
        environment == null ? null : Map.unmodifiable(environment),
        discardStdout,
      );
      _log.fine(
        () =>
            'Tool finished tool=${command.tool} exit=${result.exitCode} '
            'outputBytes=${command._collectedBytes}',
      );
      return result;
    } on GalleryCatalogFailure catch (error, stack) {
      _log.log(
        error.code == GalleryErrorCode.cancelled ? Level.FINE : Level.WARNING,
        () =>
            'Tool failed tool=${command.tool} code=${error.code.name} '
            'outputBytes=${command._collectedBytes}',
        error,
        stack,
      );
      rethrow;
    } on Object {
      _log.warning(
        () =>
            'Tool failed tool=${command.tool} '
            'code=${GalleryErrorCode.processingFailed.name}',
      );
      rethrow;
    } finally {
      _active.remove(command);
      command.finished.complete();
    }
  }

  // Never log an executable path or arbitrary user-controlled basename.
  static String _toolName(String executable) => switch (executable.split('/').last) {
    'czkawka_cli' => 'czkawka_cli',
    'ffprobe' => 'ffprobe',
    'jpegtran' => 'jpegtran',
    'ffmpeg' => 'ffmpeg',
    'chmod' => 'chmod',
    _ => 'external',
  };

  @override
  Future<void> close() => _closing ??= _close();

  Future<void> _close() async {
    _closed = true;
    final commands = _active.toList();
    _log.fine(() => 'Tool runner closing active=${commands.length}');
    for (final command in commands) {
      command.stop(GalleryErrorCode.cancelled);
    }
    await Future.wait(commands.map((command) => command.finished.future));
    _log.fine('Tool runner closed active=0');
  }
}

class _CancellationListener {
  _GalleryCommand? command;
  _CancellationListener(this.command);

  void cancel() => command?.stop(GalleryErrorCode.cancelled);
}

class _GalleryCommand {
  final String tool;
  final GalleryProcessStarter start;
  final Duration killGrace;
  final Duration pipeCleanupTimeout;
  final int maxOutputBytes;
  final Completer<void> finished = Completer<void>();
  Process? _process;
  GalleryErrorCode? _failure;
  Timer? _killTimer;
  bool _exited = false;
  int _collectedBytes = 0;

  _GalleryCommand(this.start, this.killGrace, this.pipeCleanupTimeout, this.maxOutputBytes, this.tool);

  void stop(GalleryErrorCode reason) {
    _failure ??= reason;
    final process = _process;
    if (process == null || _exited || _killTimer != null) return;
    process.kill(ProcessSignal.sigterm);
    ProcessGalleryToolRunner._log.fine(
      () =>
          'Tool stopping tool=$tool '
          'pid=${process.pid} code=${_failure!.name} signal=TERM',
    );
    _killTimer = Timer(killGrace, () {
      if (!_exited) {
        ProcessGalleryToolRunner._log.fine(
          () =>
              'Tool stopping tool=$tool '
              'pid=${process.pid} code=${_failure!.name} signal=KILL',
        );
        process.kill(ProcessSignal.sigkill);
      }
    });
  }

  void _check() {
    if (_failure != null) throw GalleryCatalogFailure(_failure!);
  }

  Future<GalleryToolResult> run(
    String executable,
    List<String> arguments,
    Duration timeout,
    Future<void>? cancellation,
    Map<String, String>? environment,
    bool discardStdout,
  ) async {
    final timer = Timer(timeout, () => stop(GalleryErrorCode.timeout));
    final listener = _CancellationListener(this);
    cancellation?.then<void>((_) => listener.cancel(), onError: (Object _) => listener.cancel());
    _CommandOutput? output;
    _CommandOutput? errors;
    Future<void>? stdinClosed;
    try {
      // In particular, already-completed cancellation must be observed before
      // starting the process, and cancellation during Process.start is sticky.
      await Future<void>.value();
      _check();
      try {
        _process = await start(executable, arguments, environment: environment);
      } on ProcessException catch (error, stack) {
        final reason = switch (error.errorCode) {
          2 => _ToolLaunchReason.missingExecutable,
          13 => _ToolLaunchReason.permissionDenied,
          8 => _ToolLaunchReason.invalidExecutable,
          _ => _ToolLaunchReason.other,
        };
        ProcessGalleryToolRunner._log.log(
          _failure == GalleryErrorCode.cancelled ? Level.FINE : Level.WARNING,
          () => 'Tool launch failed tool=$tool reason=${reason.name} osError=${error.errorCode}',
          error,
          stack,
        );
        _failure ??= GalleryErrorCode.unavailable;
        _check();
      }
      final process = _process!;
      ProcessGalleryToolRunner._log.fine(() => 'Tool process ready tool=$tool pid=${process.pid}');
      output = _collect(process.stdout, discard: discardStdout);
      errors = _collect(process.stderr);
      process.stdin.done.ignore();
      stdinClosed = process.stdin.close().then<void>((_) {}, onError: (Object _) {});
      if (_failure != null) stop(_failure!);
      final exitCode = await process.exitCode;
      _exited = true;
      _killTimer?.cancel();
      await _finishPipes(output, errors, stdinClosed);
      _check();
      return GalleryToolResult(
        exitCode: exitCode,
        stdout: utf8.decode(output.bytes.takeBytes(), allowMalformed: true),
        stderr: utf8.decode(errors.bytes.takeBytes(), allowMalformed: true),
      );
    } on GalleryCatalogFailure {
      rethrow;
    } on Object {
      stop(GalleryErrorCode.processingFailed);
      _check();
      rethrow;
    } finally {
      timer.cancel();
      listener.command = null;
      final process = _process;
      if (process != null) {
        if (!_exited) {
          stop(_failure ?? GalleryErrorCode.processingFailed);
          await process.exitCode;
          _exited = true;
        }
        _killTimer?.cancel();
        if (output != null && errors != null && stdinClosed != null) {
          await _finishPipes(output, errors, stdinClosed);
        }
      }
    }
  }

  _CommandOutput _collect(Stream<List<int>> stream, {bool discard = false}) {
    final output = _CommandOutput();
    output.subscription = stream.listen(
      (chunk) {
        if (discard) return;
        final remaining = maxOutputBytes - _collectedBytes;
        if (remaining > 0) {
          final count = chunk.length < remaining ? chunk.length : remaining;
          output.bytes.add(chunk.sublist(0, count));
          _collectedBytes += count;
        }
        if (chunk.length > remaining) {
          stop(GalleryErrorCode.outputLimitExceeded);
        }
      },
      onError: (Object _) {
        stop(GalleryErrorCode.processingFailed);
        if (!output.done.isCompleted) output.done.complete();
      },
      onDone: () {
        if (!output.done.isCompleted) output.done.complete();
      },
    );
    return output;
  }

  Future<void> _finishPipes(_CommandOutput output, _CommandOutput errors, Future<void> stdinClosed) async {
    try {
      await Future.wait([output.done.future, errors.done.future, stdinClosed]).timeout(pipeCleanupTimeout);
    } on TimeoutException {
      _failure ??= GalleryErrorCode.timeout;
      await Future.wait([output.subscription.cancel(), errors.subscription.cancel()]);
      if (!output.done.isCompleted) output.done.complete();
      if (!errors.done.isCompleted) errors.done.complete();
    }
  }
}

class _CommandOutput {
  final BytesBuilder bytes = BytesBuilder(copy: false);
  final Completer<void> done = Completer<void>();
  late final StreamSubscription<List<int>> subscription;
}
