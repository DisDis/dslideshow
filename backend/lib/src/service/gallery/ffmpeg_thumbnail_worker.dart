// One local source, one native process, one JPEG. No shell or Dart decoder.
// ignore_for_file: avoid_slow_async_io
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:logging/logging.dart';

import 'thumbnail_worker.dart';

typedef ThumbnailProcessStarter = Future<Process> Function(
  String executable,
  List<String> arguments,
);

Future<Process> _startProcess(String executable, List<String> arguments) =>
    Process.start(executable, arguments, environment: {'LC_ALL': 'C'});

class FfmpegThumbnailWorker implements ThumbnailWorker {
  static final _log = Logger('FfmpegThumbnailWorker');
  final String ffmpegExecutable;
  final Duration killGrace;
  final ThumbnailProcessStarter startProcess;

  const FfmpegThumbnailWorker({
    this.ffmpegExecutable = 'ffmpeg',
    this.killGrace = const Duration(milliseconds: 200),
    this.startProcess = _startProcess,
  });

  @override
  Future<ThumbnailWorkerResult> run(
    ThumbnailWorkRequest request, {
    required Duration timeout,
    required ThumbnailCancellationToken cancellation,
  }) async {
    if (request.size < 1 ||
        request.size > 1024 ||
        timeout <= Duration.zero ||
        killGrace <= Duration.zero ||
        request.maxSourceBytes < 1 ||
        request.maxSourcePixels < 1 ||
        request.maxOutputBytes < 1 ||
        request.jpegQuality < 1 ||
        request.jpegQuality > 100 ||
        request.frameSelectionFrames < 2 ||
        request.frameSelectionFrames > 120 ||
        request.backgroundColor < 0xff000000 ||
        request.backgroundColor > 0xffffffff) {
      throw ArgumentError('Invalid FFmpeg thumbnail limits');
    }
    final job = _FfmpegJob(startProcess, killGrace, request);
    _log.fine(
      () =>
          'Render started ${job.context} '
          'quality=${request.jpegQuality} frames=${request.frameSelectionFrames} '
          'timeoutMs=${timeout.inMilliseconds}',
    );
    final remove = cancellation.listen(
      () => job.stop(ThumbnailFailureKind.cancelled),
    );
    final timer = Timer(timeout, () => job.stop(ThumbnailFailureKind.timeout));
    try {
      job.check();
      final source = File(request.path).absolute;
      Future<void> checkSource() async {
        final stat = await source.stat();
        job.check();
        if (stat.type != FileSystemEntityType.file) {
          _log.warning(
            () =>
                'Source is not a regular file ${job.context} type=${stat.type}',
          );
          throw const ThumbnailFailure(ThumbnailFailureKind.decodeFailed);
        }
        if (stat.size > request.maxSourceBytes) {
          _log.warning(
            () =>
                'Source exceeds byte limit ${job.context} '
                'bytes=${stat.size} limit=${request.maxSourceBytes}',
          );
          throw const ThumbnailFailure(ThumbnailFailureKind.sourceTooLarge);
        }
      }

      await checkSource();
      final color = (request.backgroundColor & 0xffffff)
          .toRadixString(16)
          .padLeft(6, '0');
      // Scale before thumbnail: its frame batch must not retain full originals.
      // Draw onto RGB: drawbox replace=1 on RGBA crashes FFmpeg 5.1.
      // The second branch supplies an opaque background for alpha compositing.
      final filter =
          'crop=min(iw\\,ih):min(iw\\,ih):floor((iw-ow)/2):floor((ih-oh)/2):exact=1,'
          'scale=min(iw\\,${request.size}):min(ih\\,${request.size}):flags=area,'
          'setsar=1,format=rgba,split[foreground][background];'
          '[background]format=rgb24,drawbox=c=0x$color:t=fill[canvas];'
          '[canvas][foreground]overlay=shortest=1:format=auto,format=yuvj420p,'
          'thumbnail=n=${request.frameSelectionFrames},sidedata=mode=delete';
      // Public quality is 1..100; mjpeg qscale is reversed, 31..2.
      final qscale = 31 - ((request.jpegQuality - 1) * 29 ~/ 99);
      final bytes = await job.command(ffmpegExecutable, [
        '-hide_banner',
        '-loglevel',
        'error',
        '-nostdin',
        '-threads',
        '1',
        '-max_pixels',
        '${request.maxSourcePixels}',
        '-protocol_whitelist',
        'file,pipe',
        '-i',
        source.path,
        '-map',
        '0:v:0',
        '-an',
        '-sn',
        '-dn',
        '-map_metadata',
        '-1',
        '-filter_threads',
        '1',
        '-vf',
        filter,
        '-frames:v',
        '1',
        '-threads',
        '1',
        '-c:v',
        'mjpeg',
        '-q:v',
        '$qscale',
        '-pix_fmt',
        'yuvj420p',
        '-f',
        'image2pipe',
        'pipe:1',
      ], maxOutput: request.maxOutputBytes);
      await checkSource();
      if (bytes.isEmpty)
        throw const ThumbnailFailure(ThumbnailFailureKind.decodeFailed);
      final digest = (await md5.bind(_yieldingChunks(bytes, job)).first)
          .toString();
      job.check();
      _log.fine(
        () =>
            'Render completed ${job.context} '
            'bytes=${bytes.length} elapsedMs=${job.clock.elapsedMilliseconds}',
      );
      return ThumbnailWorkerResult(bytes: bytes, digest: digest);
    } on ThumbnailFailure catch (error) {
      _log.log(
        error.kind == ThumbnailFailureKind.cancelled
            ? Level.FINE
            : Level.WARNING,
        () =>
            'Render failed ${job.context} reason=${error.kind.name} '
            'elapsedMs=${job.clock.elapsedMilliseconds}',
      );
      rethrow;
    } on Object catch (error, stack) {
      _log.warning(() => 'Render failed ${job.context}', error, stack);
      job.check();
      throw const ThumbnailFailure(ThumbnailFailureKind.decodeFailed);
    } finally {
      timer.cancel();
      remove();
    }
  }
}

Stream<List<int>> _yieldingChunks(Uint8List bytes, _FfmpegJob job) async* {
  for (var offset = 0; offset < bytes.length; offset += 64 * 1024) {
    await Future<void>.delayed(Duration.zero);
    job.check();
    yield Uint8List.sublistView(
      bytes,
      offset,
      math.min(bytes.length, offset + 64 * 1024),
    );
  }
}

/// One operation owns at most one child at a time. Failure is sticky across
/// Process.start and command boundaries; completion includes input/pipe cleanup.
class _FfmpegJob {
  static const _maxLoggedStderr = 8192;
  final ThumbnailProcessStarter start;
  final Duration killGrace;
  final ThumbnailWorkRequest request;
  final Stopwatch clock = Stopwatch()..start();
  ThumbnailFailure? failure;
  Process? process;
  bool _exited = false;
  Future<void>? termination;
  _FfmpegJob(this.start, this.killGrace, this.request);

  String get context =>
      'source=${jsonEncode(request.path)} size=${request.size}';

  void check() {
    if (failure != null) throw failure!;
  }

  void stop(ThumbnailFailureKind kind) {
    failure ??= ThumbnailFailure(kind);
    final child = process;
    if (child == null || termination != null || _exited) return;
    FfmpegThumbnailWorker._log.fine(
      () =>
          'Stopping FFmpeg $context '
          'pid=${child.pid} reason=${failure!.kind.name} signal=TERM',
    );
    child.kill(ProcessSignal.sigterm);
    termination = Future<void>.delayed(killGrace, () {
      if (_exited) return;
      FfmpegThumbnailWorker._log.fine(
        () =>
            'Stopping FFmpeg $context '
            'pid=${child.pid} signal=KILL',
      );
      child.kill(ProcessSignal.sigkill);
    });
  }

  Future<Uint8List> command(
    String executable,
    List<String> arguments, {
    required int maxOutput,
  }) async {
    check();
    final output = BytesBuilder(copy: false);
    final errors = BytesBuilder(copy: false);
    int? exitCode;
    String? stderrText;
    FfmpegThumbnailWorker._log.finer(
      () =>
          'FFmpeg command $context '
          'executable=${jsonEncode(executable)} arguments=${jsonEncode(arguments)}',
    );
    Future<void>? outDone, errDone, stdinDone;
    try {
      try {
        process = await start(executable, arguments);
      } on ProcessException catch (error, stack) {
        FfmpegThumbnailWorker._log.warning(
          () =>
              'Cannot start FFmpeg $context executable=${jsonEncode(executable)}',
          error,
          stack,
        );
        stop(ThumbnailFailureKind.unavailable);
        check();
      }
      final child = process!;
      FfmpegThumbnailWorker._log.fine(
        () => 'FFmpeg started $context pid=${child.pid}',
      );
      child.stdin.done.ignore();
      outDone = collect(child.stdout, output, maxOutput);
      errDone = collect(child.stderr, errors, 64 * 1024);
      stdinDone = child.stdin.close().then<void>(
        (_) {},
        onError: (Object _) {},
      );
      if (failure != null) stop(failure!.kind);
      exitCode = await child.exitCode;
      _exited = true;
      await Future.wait([outDone, errDone, stdinDone]);
      stderrText = utf8.decode(errors.takeBytes(), allowMalformed: true);
      check();
      // FFmpeg decoder diagnostics are parsed only at this process boundary.
      if (stderrText.contains('exceeds specified max pixel count')) {
        stop(ThumbnailFailureKind.sourceTooLarge);
        check();
      }
      if (exitCode != 0)
        throw const ThumbnailFailure(ThumbnailFailureKind.decodeFailed);
      return output.takeBytes();
    } catch (_) {
      stop(ThumbnailFailureKind.decodeFailed);
      rethrow;
    } finally {
      final child = process;
      if (child != null) {
        // Also reap commands whose streams failed before exit was observed.
        if (!_exited) child.kill(ProcessSignal.sigterm);
        await termination;
        exitCode = await child.exitCode;
        _exited = true;
        await Future.wait([
          if (outDone != null) outDone,
          if (errDone != null) errDone,
          if (stdinDone != null) stdinDone,
        ]);
      }
      if (failure != null) {
        stderrText ??= utf8.decode(errors.takeBytes(), allowMalformed: true);
        final truncated = stderrText.length > _maxLoggedStderr;
        final diagnostic = truncated
            ? stderrText.substring(0, _maxLoggedStderr)
            : stderrText;
        FfmpegThumbnailWorker._log.log(
          failure!.kind == ThumbnailFailureKind.cancelled
              ? Level.FINE
              : Level.WARNING,
          () =>
              'FFmpeg failed $context executable=${jsonEncode(executable)} '
              'pid=${child?.pid} exit=$exitCode reason=${failure!.kind.name} '
              'elapsedMs=${clock.elapsedMilliseconds} '
              'stderr=${jsonEncode(diagnostic)}${truncated ? ' [truncated]' : ''}',
        );
      } else {
        FfmpegThumbnailWorker._log.fine(
          () =>
              'FFmpeg exited $context '
              'pid=${child?.pid} exit=$exitCode elapsedMs=${clock.elapsedMilliseconds}',
        );
      }
      process = null;
      termination = null;
    }
  }

  Future<void> collect(
    Stream<List<int>> stream,
    BytesBuilder builder,
    int limit,
  ) async {
    try {
      await for (final chunk in stream) {
        if (builder.length + chunk.length > limit) {
          final remaining = limit - builder.length;
          if (remaining > 0) builder.add(chunk.sublist(0, remaining));
          stop(ThumbnailFailureKind.sourceTooLarge);
        } else {
          builder.add(chunk);
        }
      }
    } catch (_) {
      stop(ThumbnailFailureKind.decodeFailed);
    }
  }
}
