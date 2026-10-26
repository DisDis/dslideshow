// Standalone decoder experiment. Run with backend's existing package config.
// ignore_for_file: depend_on_referenced_packages
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:crypto/crypto.dart';
import 'package:dslideshow_backend/src/service/gallery/thumbnail_worker.dart';
import 'package:image/image.dart' as image;

enum ProbeMode { scaled, full, webp, scaledWebp }

Future<void> main(List<String> arguments) async {
  if (arguments.length != 4) {
    throw ArgumentError('source size scaled|full|webp|scaledWebp output-file');
  }
  final source = File(arguments[0]);
  final size = int.parse(arguments[1]);
  final mode = ProbeMode.values.byName(arguments[2]);
  final output = File(arguments[3]);
  final watch = Stopwatch()..start();
  var lastTick = 0;
  var maxEventLoopGapMicros = 0;
  final timer = Timer.periodic(const Duration(milliseconds: 2), (_) {
    final now = watch.elapsedMicroseconds;
    maxEventLoopGapMicros = math.max(maxEventLoopGapMicros, now - lastTick);
    lastTick = now;
  });
  late List<int> bytes;
  int scale = 1;
  int? workerMicros;
  if (mode == ProbeMode.scaled) {
    final result = await const IsolateThumbnailWorker().run(
      ThumbnailWorkRequest(
        path: source.path,
        size: size,
        jpegQuality: 88,
        format: ThumbnailFormat.automatic,
        maxSourceBytes: 200 * 1024 * 1024,
        maxSourcePixels: 64 * 1024 * 1024,
        maxOutputBytes: 8 * 1024 * 1024,
      ),
      timeout: const Duration(seconds: 55),
      cancellation: ThumbnailCancellationToken(),
    );
    scale = result.jpegScale;
    workerMicros = result.elapsedMicroseconds;
    bytes = result.takeBytes();
  } else {
    final input = await source.readAsBytes();
    image.Image decoded;
    if (mode == ProbeMode.scaledWebp) {
      final info = image.JpegDecoder().startDecode(input)!;
      for (final candidate in [8, 4, 2]) {
        if (math.min(info.width, info.height) ~/ candidate >= size) {
          scale = candidate;
          break;
        }
      }
      decoded = image.JpegDecoder(scale: scale).decode(input)!;
    } else {
      decoded = image.decodeImage(input, frame: 0)!;
    }
    final oriented =
        decoded.exif.imageIfd.hasOrientation &&
            decoded.exif.imageIfd.orientation != 1
        ? image.bakeOrientation(decoded)
        : decoded;
    final edge = math.min(oriented.width, oriented.height);
    final square = image.copyCrop(
      oriented,
      x: (oriented.width - edge) ~/ 2,
      y: (oriented.height - edge) ~/ 2,
      width: edge,
      height: edge,
    );
    final thumbnail = image.copyResize(
      square,
      width: math.min(size, edge),
      height: math.min(size, edge),
      interpolation: image.Interpolation.average,
    );
    thumbnail.exif = image.ExifData();
    bytes = mode == ProbeMode.webp || mode == ProbeMode.scaledWebp
        ? image.encodeWebP(thumbnail, lossless: false, quality: 88)
        : image.encodeJpg(thumbnail, quality: 88);
  }
  final elapsed = watch.elapsedMicroseconds;
  await output.writeAsBytes(bytes, flush: true);
  timer.cancel();
  final proc = await File('/proc/self/status').readAsString();
  final peakKiB = int.parse(
    RegExp(r'^VmHWM:\s+(\d+) kB', multiLine: true).firstMatch(proc)![1]!,
  );
  stdout.writeln(
    jsonEncode({
      'sdk': Platform.version,
      'mode': mode.name,
      'size': size,
      'jpegDecodeScale': scale,
      'elapsedMs': elapsed / 1000,
      'workerMs': workerMicros == null ? null : workerMicros / 1000,
      'maxEventLoopGapMs': maxEventLoopGapMicros / 1000,
      'processPeakRssKiB': peakKiB,
      'sourceBytes': await source.length(),
      'sourceSha256': (await sha256.bind(source.openRead()).first).toString(),
      'outputBytes': bytes.length,
      'outputSha256': sha256.convert(bytes).toString(),
      'scope':
          'local Linux fresh process; source filesystem warm; no Pi/GPU/UI',
    }),
  );
}
