// Standalone current-worker probe; compile with backend's package config.
// ignore_for_file: depend_on_referenced_packages
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:crypto/crypto.dart';
import 'package:dslideshow_backend/src/service/gallery/thumbnail_service.dart';

Future<void> main(List<String> arguments) async {
  if (arguments.length != 3) throw ArgumentError('source size output-file');
  final source = File(arguments[0]);
  final size = int.parse(arguments[1]);
  final output = File(arguments[2]);
  final watch = Stopwatch()..start();
  var lastTick = 0;
  var maxEventLoopGapMicros = 0;
  final timer = Timer.periodic(const Duration(milliseconds: 2), (_) {
    final now = watch.elapsedMicroseconds;
    maxEventLoopGapMicros = math.max(maxEventLoopGapMicros, now - lastTick);
    lastTick = now;
  });
  late ThumbnailWorkerResult result;
  try {
    result = await const FfmpegThumbnailWorker().run(
      ThumbnailWorkRequest(
        path: source.path,
        size: size,
        maxSourceBytes: 200 * 1024 * 1024,
        maxSourcePixels: 64 * 1024 * 1024,
        maxOutputBytes: 8 * 1024 * 1024,
      ),
      timeout: const Duration(seconds: 20),
      cancellation: ThumbnailCancellationToken(),
    );
  } finally {
    timer.cancel();
  }
  final elapsed = watch.elapsedMicroseconds;
  await output.writeAsBytes(result.bytes);
  stdout.writeln(
    jsonEncode({
      'sdk': Platform.version,
      'mode': 'ffmpeg',
      'size': size,
      'elapsedMs': elapsed / 1000,
      'maxEventLoopGapMs': maxEventLoopGapMicros / 1000,
      'format': 'jpeg',
      'sourceBytes': await source.length(),
      'sourceSha256': (await sha256.bind(source.openRead()).first).toString(),
      'outputBytes': result.bytes.length,
      'outputMd5': result.digest,
      'scope':
          'local Linux fresh process; warm source filesystem; no Pi/GPU/UI',
    }),
  );
}
