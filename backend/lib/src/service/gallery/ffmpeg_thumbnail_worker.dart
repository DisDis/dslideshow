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
    final job = _FfmpegJob(startProcess, killGrace);
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
          throw const ThumbnailFailure(ThumbnailFailureKind.decodeFailed);
        }
        if (stat.size > request.maxSourceBytes) {
          throw const ThumbnailFailure(ThumbnailFailureKind.sourceTooLarge);
        }
      }

      await checkSource();
      final color = (request.backgroundColor & 0xffffff)
          .toRadixString(16)
          .padLeft(6, '0');
      // Scale before thumbnail: its frame batch must not retain full originals.
      // The second branch supplies an opaque background for alpha compositing.
      final filter =
          'crop=min(iw\\,ih):min(iw\\,ih):floor((iw-ow)/2):floor((ih-oh)/2):exact=1,'
          'scale=min(iw\\,${request.size}):min(ih\\,${request.size}):flags=area,'
          'setsar=1,format=rgba,split[foreground][background];'
          '[background]drawbox=c=0x$color@1:t=fill:replace=1[canvas];'
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
      return ThumbnailWorkerResult(bytes: bytes, digest: digest);
    } on ThumbnailFailure {
      rethrow;
    } on Object {
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
  final ThumbnailProcessStarter start;
  final Duration killGrace;
  ThumbnailFailure? failure;
  Process? process;
  Future<void>? termination;
  _FfmpegJob(this.start, this.killGrace);

  void check() {
    if (failure != null) throw failure!;
  }

  void stop(ThumbnailFailureKind kind) {
    failure ??= ThumbnailFailure(kind);
    final child = process;
    if (child == null || termination != null) return;
    child.kill(ProcessSignal.sigterm);
    termination = Future<void>.delayed(killGrace, () {
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
    Future<void>? outDone, errDone, stdinDone;
    try {
      try {
        process = await start(executable, arguments);
      } on ProcessException {
        Logger('FfmpegThumbnailWorker')
            .warning('Thumbnail executable unavailable: $executable');
        stop(ThumbnailFailureKind.unavailable);
        check();
      }
      final child = process!;
      child.stdin.done.ignore();
      outDone = collect(child.stdout, output, maxOutput);
      errDone = collect(child.stderr, errors, 64 * 1024);
      stdinDone = child.stdin.close().then<void>(
        (_) {},
        onError: (Object _) {},
      );
      if (failure != null) stop(failure!.kind);
      final exit = await child.exitCode;
      await Future.wait([outDone, errDone, stdinDone]);
      check();
      // FFmpeg decoder diagnostics are parsed only at this process boundary.
      final message = utf8.decode(errors.takeBytes(), allowMalformed: true);
      if (message.contains('exceeds specified max pixel count')) {
        stop(ThumbnailFailureKind.sourceTooLarge);
        check();
      }
      if (exit != 0)
        throw const ThumbnailFailure(ThumbnailFailureKind.decodeFailed);
      return output.takeBytes();
    } catch (_) {
      stop(ThumbnailFailureKind.decodeFailed);
      rethrow;
    } finally {
      final child = process;
      if (child != null) {
        // Also reap commands whose streams failed before exit was observed.
        child.kill(ProcessSignal.sigterm);
        await termination;
        await child.exitCode;
        await Future.wait([
          if (outDone != null) outDone,
          if (errDone != null) errDone,
          if (stdinDone != null) stdinDone,
        ]);
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
