import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;

import 'console.dart';

/// An external command failed, or its owning operation was cancelled.
class ProcessJobFailure implements Exception {
  const ProcessJobFailure(this.label, this.code, {this.reason = 'exit'});
  final String label;
  final int code;
  int get exitCode => code;
  final String reason;
  @override
  String toString() => 'Command $label failed: reason=$reason code=$code';
}

/// Owns Linux process groups, including descendants of an exited command.
class ProcessSupervisor {
  ProcessSupervisor({this.terminationGrace = const Duration(seconds: 5), String? runId, this.console})
    : runId = runId ?? '${pid}_${DateTime.now().microsecondsSinceEpoch}';

  static final _log = Logger('build');
  static final _whitespace = RegExp(r'\s+');
  static final _fdFlags = RegExp(r'^flags:\s+([0-7]+)$', multiLine: true);
  static const _readyMarker = 'DSLIDESHOW_PROCESS_READY\n';
  static const _launchHandshake =
      r'''printf '%s\n' DSLIDESHOW_PROCESS_READY; IFS= read -r _dslideshow_start || exit 125; exec "$@"''';
  final Duration terminationGrace;
  final BuildConsole? console;
  final String runId;
  final _clock = Stopwatch()..start();
  final _jobs = <_RunningJob>[];
  final _starting = <Future<Process>>{};
  int? _cancellationCode;
  Future<void>? _cancelling;
  int? get cancellationCode => _cancellationCode;
  int get elapsedMilliseconds => _clock.elapsedMilliseconds;

  /// Adopts a process launched with setsid; its caller owns both output streams.
  /// Register immediately after Process.start, before waiting for readiness.
  void adopt(Process process) {
    // setsid has not necessarily run when Process.start returns. Register first;
    // probing/rejecting its transient inherited PGID could leak a live child.
    _jobs.add(_RunningJob(process, _processIdentity(process.pid)?.start, <String>{}));
    if (_cancellationCode != null) {
      // A signal may have completed cancellation while the caller awaited spawn.
      // close() must also wait for this newly registered group's cleanup.
      _cancelling = (_cancelling ?? Future<void>.value()).then((_) => _stop());
    }
  }

  /// Runs literal arguments; output streams are consumed throughout execution.
  Future<int> run(
    String executable,
    List<String> arguments, {
    String label = 'job',
    String? workingDirectory,
    Map<String, String>? environment,
    bool includeParentEnvironment = true,
    IOSink? stdoutSink,
    IOSink? stderrSink,
    bool streamOutput = true,
    Duration? timeout,
  }) async {
    if (_cancellationCode != null) throw ProcessJobFailure(label, _cancellationCode!, reason: 'cancelled');
    final clock = Stopwatch()..start();
    _log.info('run=$runId elapsedMs=$elapsedMilliseconds job=$label action=start');
    final display = console;
    if (display != null) {
      await display.startJob(
        label,
        compact: streamOutput && stdoutSink == null && label.startsWith('tests:') && display.interactive,
      );
    }
    try {
      // Console registration may await a flush, so observe a signal before spawn.
      if (_cancellationCode != null) throw ProcessJobFailure(label, _cancellationCode!, reason: 'cancelled');
      // setsid execs the command in its own session. Its PID is also its PGID.
      final launch = Process.start(
        'setsid',
        ['--', '/bin/sh', '-c', _launchHandshake, 'dslideshow-worker', executable, ...arguments],
        workingDirectory: workingDirectory,
        environment: environment,
        includeParentEnvironment: includeParentEnvironment,
      );
      _starting.add(launch);
      late _RunningJob job;
      try {
        final process = await launch;
        job = _RunningJob(process, _processIdentity(process.pid)?.start, <String>{});
        _jobs.add(job);
      } on ProcessException catch (error) {
        _log.severe(
          'run=$runId elapsedMs=$elapsedMilliseconds job=$label action=finish result=failed reason=start '
          'osCode=${error.errorCode}',
        );
        throw ProcessJobFailure(label, 1, reason: 'start');
      } finally {
        _starting.remove(launch);
      }
      final ready = Completer<void>();
      final output = Future.wait([
        _copy(_commandOutput(job, ready), stdoutSink, stdout, label, streamOutput),
        _copy(job.process.stderr, stderrSink, stderr, label, streamOutput, isError: true),
      ]);
      // Observe pipe failures immediately, while retaining a single cleanup path.
      Object? pipeError;
      var pipesCompleted = false;
      final pipes = output.then<void>(
        (_) {
          pipesCompleted = true;
        },
        onError: (Object error, StackTrace stack) {
          pipeError = error;
          pipesCompleted = true;
          unawaited(cancel());
        },
      );
      final timer = timeout == null ? null : Timer(timeout, () => unawaited(cancel(124)));
      try {
        try {
          // Observe readiness errors even when cancellation wins the spawn race.
          await ready.future;
          if (_cancellationCode != null) {
            await _signal(job, ProcessSignal.sigterm);
          } else {
            // The fixed shell waits until these pipe identities are captured.
            // Only literal argv reaches exec; no command/data enters shell source.
            job.process.stdin.writeln('start');
            await job.process.stdin.flush();
            await job.process.stdin.close();
          }
        } on Object {
          await _stopJob(job);
          await pipes;
          throw ProcessJobFailure(label, _cancellationCode ?? 1, reason: 'start');
        }
        final result = await job.process.exitCode;
        job.exited = true;
        if (result != 0) {
          // A dead leader does not close inherited writers in its descendants.
          // Clean up this job before waiting for EOF, without poisoning the owner
          // used by standalone coverage to collect later failing/successful suites.
          _log.warning(
            'run=$runId elapsedMs=$elapsedMilliseconds job=$label action=cleanup reason=nonzero code=$result',
          );
          await _stopJob(job);
        } else if (!pipesCompleted && _capturePipeWriters(job)) {
          _log.warning('run=$runId elapsedMs=$elapsedMilliseconds job=$label action=cleanup reason=inherited-pipes');
          await _stopJob(job);
        }
        await pipes;
        final cancelled = _cancellationCode != null;
        final code = _cancellationCode ?? result;
        final outcome = cancelled
            ? 'cancelled'
            : result == 0 && pipeError == null
            ? 'passed'
            : 'failed';
        final message =
            'run=$runId elapsedMs=$elapsedMilliseconds job=$label action=finish result=$outcome code=$code '
            'durationMs=${clock.elapsedMilliseconds}';
        if (outcome == 'failed') {
          _log.severe(message);
        } else {
          _log.info(message);
        }
        if (code != 0 || pipeError != null) throw ProcessJobFailure(label, code == 0 ? 1 : code, reason: outcome);
        return result;
      } finally {
        timer?.cancel();
        try {
          await job.process.stdin.close();
        } on IOException {
          /* The killed child may have closed its read end. */
        }
        if (pipesCompleted) job.pipes.clear();
      }
    } finally {
      if (display != null) await display.finishJob(label);
    }
  }

  Stream<List<int>> _commandOutput(_RunningJob job, Completer<void> ready) async* {
    final input = StreamIterator<List<int>>(job.process.stdout);
    final marker = utf8.encode(_readyMarker);
    var offset = 0;
    List<int> tail = const [];
    try {
      while (offset < marker.length) {
        if (!await input.moveNext()) throw StateError('Worker closed before launch readiness');
        final chunk = input.current;
        var index = 0;
        while (index < chunk.length && offset < marker.length) {
          if (chunk[index++] != marker[offset++]) throw StateError('Invalid worker launch readiness');
        }
        if (index < chunk.length) tail = chunk.sublist(index);
      }
      // The wrapper has executed after stdio remapping and is blocked on stdin.
      // Looking up fd identity immediately at Process.start is too early.
      job.pipes.addAll(_processPipes(job.process.pid));
      if (job.pipes.length != 2) throw StateError('Cannot identify owned output pipes');
      ready.complete();
      if (tail.isNotEmpty) yield tail;
      while (await input.moveNext()) {
        yield input.current;
      }
    } on Object catch (error, stack) {
      if (!ready.isCompleted) ready.completeError(error, stack);
      rethrow;
    } finally {
      await input.cancel();
    }
  }

  Future<void> _copy(
    Stream<List<int>> source,
    IOSink? destination,
    IOSink fallback,
    String label,
    bool display, {
    bool isError = false,
  }) async {
    if (destination != null) {
      await for (final chunk in source) {
        destination.add(chunk);
        await destination.flush();
      }
    } else if (display) {
      final presentation = console;
      if (presentation != null) {
        await for (final chunk in source.transform(const Utf8Decoder(allowMalformed: true))) {
          if (chunk.isNotEmpty) await presentation.writeChunk(label, chunk, isError: isError);
        }
        return;
      }
      var lineStart = true;
      await for (final chunk in source.transform(const Utf8Decoder(allowMalformed: true))) {
        if (chunk.isEmpty) continue;
        if (lineStart) fallback.write('[$label] ');
        // Input is bounded by the pipe chunk, even for a command with no LF.
        final parts = chunk.split('\n');
        for (var index = 0; index < parts.length; index++) {
          fallback.write(parts[index]);
          if (index < parts.length - 1) {
            fallback.writeln();
            if (index < parts.length - 2 || parts.last.isNotEmpty) fallback.write('[$label] ');
          }
        }
        lineStart = chunk.endsWith('\n');
        await fallback.flush();
      }
    } else {
      await source.drain<void>();
    }
  }

  /// Stops every owned group, even if its direct child has already exited.
  Future<void> cancel([int code = 1]) {
    _cancellationCode ??= code;
    return _cancelling ??= _stop();
  }

  Future<void> _stop() async {
    // A signal can arrive between spawn and registration in the owned set.
    while (_starting.isNotEmpty) {
      await Future.wait(_starting.map((future) => future.then<void>((_) {}, onError: (Object _, StackTrace _) {})));
    }
    _log.info('run=$runId elapsedMs=$elapsedMilliseconds action=cancel jobs=${_jobs.length} code=$_cancellationCode');
    await Future.wait(List<_RunningJob>.of(_jobs).map(_stopJob));
  }

  Future<void> _stopJob(_RunningJob job) => job.stopping ??= _stopOwned([job]);

  Future<void> _stopOwned(List<_RunningJob> jobs) async {
    _captureDescendants(jobs);
    await Future.wait(jobs.map((job) => _signal(job, ProcessSignal.sigterm)));
    _signalEscapedDescendants(ProcessSignal.sigterm, jobs);
    // Poll only until all groups are gone, bounded by the TERM grace deadline.
    final deadline = Stopwatch()..start();
    while (deadline.elapsed < terminationGrace && await _anyGroupAlive(jobs)) {
      await Future<void>.delayed(const Duration(milliseconds: 20));
    }
    // Retain identities discovered before TERM even when their parent has exited.
    // A TERM handler may also spawn another owned child before it completes.
    _captureDescendants(jobs);
    _signalEscapedDescendants(ProcessSignal.sigkill, jobs);
    await Future.wait(jobs.map((job) => _signal(job, ProcessSignal.sigkill)));
    await Future.wait(jobs.map((job) => job.process.exitCode));
    // kill(2) acknowledges delivery, not process death. Reaped leaders may have
    // orphaned live grandchildren, so observe retained start identities as well.
    final killed = Stopwatch()..start();
    while (await _anyGroupAlive(jobs)) {
      if (killed.elapsed >= const Duration(seconds: 2)) {
        throw StateError('Owned descendants did not terminate after SIGKILL');
      }
      _signalEscapedDescendants(ProcessSignal.sigkill, jobs);
      await Future<void>.delayed(const Duration(milliseconds: 5));
    }
  }

  Future<bool> _anyGroupAlive([Iterable<_RunningJob>? selected]) async {
    final jobs = selected ?? _jobs;
    _captureDescendants(jobs);
    for (final job in jobs) {
      for (final entry in job.descendants.entries) {
        final process = _processIdentity(entry.key);
        if (process != null && process.start == entry.value && process.state != 'Z') return true;
      }
      final leader = _processIdentity(job.process.pid);
      if (leader != null && leader.start == job.startTicks && leader.state != 'Z') return true;
    }
    return false;
  }

  Set<String> _processPipes(int processId) {
    final pipes = <String>{};
    for (final descriptor in ['1', '2']) {
      try {
        final target = Link(p.join('/proc', '$processId', 'fd', descriptor)).targetSync();
        if (target.startsWith('pipe:[')) pipes.add(target);
      } on FileSystemException {
        // Early launch/cancellation failure: the handshake never execs the tool.
      }
    }
    return pipes;
  }

  bool _capturePipeWriters(_RunningJob job, {Map<int, ({int parent, int group, int start, String state})>? processes}) {
    if (job.pipes.isEmpty) return false;
    var found = false;
    final processIds =
        processes?.keys ??
        Directory('/proc')
            .listSync(followLinks: false)
            .map((entry) => int.tryParse(p.basename(entry.path)))
            .whereType<int>();
    for (final processId in processIds) {
      // The supervisor owns the read ends; only inherited writable ends count.
      if (processId == pid) continue;
      final identity = processes?[processId] ?? _processIdentity(processId);
      if (identity == null || identity.state == 'Z') continue;
      try {
        for (final descriptor in Directory(p.join('/proc', '$processId', 'fd')).listSync(followLinks: false)) {
          final target = Link(descriptor.path).targetSync();
          if (!job.pipes.contains(target)) continue;
          final info = File(p.join('/proc', '$processId', 'fdinfo', p.basename(descriptor.path))).readAsStringSync();
          final flags = _fdFlags.firstMatch(info)?.group(1);
          if (flags != null && (int.parse(flags, radix: 8) & 3) != 0) {
            job.descendants[processId] = identity.start;
            found = true;
            break;
          }
        }
      } on FileSystemException {
        // A process/fd can disappear between the snapshots; no ownership inferred.
      }
    }
    return found;
  }

  ({int parent, int group, int start, String state})? _processIdentity(int processId) {
    try {
      final stat = File(p.join('/proc', '$processId', 'stat')).readAsStringSync();
      final end = stat.lastIndexOf(')');
      if (end < 0) return null;
      final fields = stat.substring(end + 1).trim().split(_whitespace);
      if (fields.length < 20) return null;
      return (
        parent: int.parse(fields[1]),
        group: int.parse(fields[2]),
        start: int.parse(fields[19]),
        state: fields[0],
      );
    } on FileSystemException {
      return null;
    } on FormatException {
      return null;
    }
  }

  void _captureDescendants([Iterable<_RunningJob>? selected]) {
    final processes = <int, ({int parent, int group, int start, String state})>{};
    for (final entry in Directory('/proc').listSync(followLinks: false)) {
      final processId = int.tryParse(p.basename(entry.path));
      if (processId == null) continue;
      final identity = _processIdentity(processId);
      if (identity != null) processes[processId] = identity;
    }
    for (final job in selected ?? _jobs) {
      final leader = processes[job.process.pid];
      // Adopted servers do not use our launch protocol. The setsid PGID proves
      // exec/stdio setup has finished before their pipe identities are trusted.
      if (job.pipes.isEmpty && leader != null && leader.start == job.startTicks && leader.group == job.process.pid) {
        job.pipes.addAll(_processPipes(job.process.pid));
      }
      _capturePipeWriters(job, processes: processes);
      // Group membership remains attributable after its leader has exited and
      // children were reparented to init. Zombies are identities, not live work.
      for (final entry in processes.entries) {
        if (entry.value.group == job.process.pid && (job.startTicks == null || entry.value.start >= job.startTicks!)) {
          job.descendants[entry.key] = entry.value.start;
        }
      }
      final parents = <int>{
        if (processes[job.process.pid]?.start == job.startTicks) job.process.pid,
        for (final entry in job.descendants.entries)
          if (processes[entry.key]?.start == entry.value) entry.key,
      };
      var added = true;
      while (added) {
        added = false;
        for (final entry in processes.entries) {
          if (parents.contains(entry.value.parent) && parents.add(entry.key)) {
            job.descendants[entry.key] = entry.value.start;
            added = true;
          }
        }
      }
    }
  }

  void _signalEscapedDescendants(ProcessSignal signal, [Iterable<_RunningJob>? selected]) {
    for (final job in selected ?? _jobs) {
      for (final entry in job.descendants.entries) {
        final identity = _processIdentity(entry.key);
        if (identity != null &&
            identity.start == entry.value &&
            identity.state != 'Z' &&
            identity.group != job.process.pid) {
          Process.killPid(entry.key, signal);
        }
      }
    }
  }

  Future<void> _signal(_RunningJob job, ProcessSignal signal) async {
    final result = await Process.run('/bin/kill', ['-${signal.signalNumber}', '--', '-${job.process.pid}']);
    if (result.exitCode != 0) {
      // Cancellation may arrive before setsid creates its session. Signal the
      // still-owned direct child rather than waiting forever for a missed group.
      final identity = _processIdentity(job.process.pid);
      if (identity != null && identity.start == job.startTicks && identity.state != 'Z') {
        Process.killPid(job.process.pid, signal);
      }
    }
  }

  /// Completes the owned operation; successful jobs must not retain descendants.
  Future<void> close() async {
    if (_cancelling != null) {
      await _cancelling;
    } else if (await _anyGroupAlive()) {
      await cancel();
    }
  }
}

class _RunningJob {
  _RunningJob(this.process, this.startTicks, this.pipes);
  final Process process;
  final int? startTicks;
  final Set<String> pipes;
  Future<void>? stopping;
  final descendants = <int, int>{};
  bool exited = false;
}
