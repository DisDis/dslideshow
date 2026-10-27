// Compile with backend's package config; run with the FFmpeg under test in PATH.
// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dslideshow_backend/src/service/gallery/thumbnail_service.dart';
import 'package:dslideshow_common/log.dart';
import 'package:image/image.dart' as image;
import 'package:logging/logging.dart';

Future<void> main(List<String> arguments) async {
  initLog('ffmpeg-compat');
  Logger.root.level = Level.WARNING;
  final root = await Directory.systemTemp.createTemp('ffmpeg-compat-');
  var passed = 0;
  Future<void> check(
    String name,
    File source, {
    int size = 256,
    int background = 0xff202020,
    bool Function(image.Image)? validate,
  }) async {
    final before = (await sha256.bind(source.openRead()).first).toString();
    final watch = Stopwatch()..start();
    final result = await const FfmpegThumbnailWorker().run(
      ThumbnailWorkRequest(
        path: source.path,
        size: size,
        backgroundColor: background,
        maxSourceBytes: 200 * 1024 * 1024,
        maxSourcePixels: 64 * 1024 * 1024,
        maxOutputBytes: 8 * 1024 * 1024,
      ),
      timeout: const Duration(seconds: 20),
      cancellation: ThumbnailCancellationToken(),
    );
    final decoded = image.decodeJpg(result.bytes);
    final after = (await sha256.bind(source.openRead()).first).toString();
    if (before != after ||
        result.digest != md5.convert(result.bytes).toString() ||
        decoded == null ||
        decoded.width != decoded.height ||
        decoded.width > size ||
        decoded.hasAlpha ||
        (validate != null && !validate(decoded))) {
      throw StateError('Invalid JPEG or modified original: $name');
    }
    passed++;
    stdout.writeln(
      jsonEncode({
        'case': name,
        'status': 'passed',
        'width': decoded.width,
        'height': decoded.height,
        'bytes': result.bytes.length,
        'elapsedMs': watch.elapsedMilliseconds,
        'md5': result.digest,
      }),
    );
  }

  Future<File> fixture(String name, List<int> bytes) =>
      File('${root.path}/$name').writeAsBytes(bytes);
  bool near(num actual, num expected) => (actual - expected).abs() <= 12;
  try {
    for (final alpha in [0, 128, 255]) {
      final pixels = image.Image(width: 32, height: 24, numChannels: 4)
        ..clear(image.ColorRgba8(255, 0, 0, alpha));
      final source = await fixture('alpha-$alpha.png', image.encodePng(pixels));
      await check(
        'alpha-$alpha',
        source,
        validate: (jpeg) {
          final pixel = jpeg.getPixel(10, 10);
          return jpeg.width == 24 &&
              near(pixel.r, (255 * alpha + 32 * (255 - alpha)) / 255) &&
              near(pixel.g, 32 * (255 - alpha) / 255) &&
              near(pixel.b, 32 * (255 - alpha) / 255);
        },
      );
      if (alpha == 0) {
        await check(
          'white-background',
          source,
          background: 0xffffffff,
          validate: (jpeg) =>
              jpeg.getPixel(10, 10).r > 245 &&
              jpeg.getPixel(10, 10).g > 245 &&
              jpeg.getPixel(10, 10).b > 245,
        );
      }
    }
    await check(
      'one-pixel',
      await fixture(
        'tiny.png',
        image.encodePng(image.Image(width: 1, height: 2)),
      ),
      validate: (jpeg) => jpeg.width == 1,
    );
    final oriented = image.Image(width: 40, height: 20);
    for (final pixel in oriented) {
      pixel.setRgb(pixel.x < 20 ? 255 : 0, 0, pixel.x < 20 ? 0 : 255);
    }
    oriented.exif.imageIfd.orientation = 6;
    await check(
      'exif-rotation',
      await fixture('oriented.jpg', image.encodeJpg(oriented)),
      validate: (jpeg) =>
          jpeg.width == 20 &&
          jpeg.getPixel(5, 4).r > 200 &&
          jpeg.getPixel(5, 15).b > 200,
    );
    final animation = image.Image(width: 32, height: 24)
      ..clear(image.ColorRgb8(255, 0, 0));
    for (var i = 0; i < 8; i++) {
      animation.addFrame(
        image.Image(width: 32, height: 24)..clear(image.ColorRgb8(0, i, 240)),
      );
    }
    await check(
      'representative-gif',
      await fixture('animation.gif', image.encodeGif(animation)),
      validate: (jpeg) =>
          jpeg.width == 24 &&
          jpeg.getPixel(10, 10).b > 200 &&
          jpeg.getPixel(10, 10).r < 30,
    );
    if (arguments.isNotEmpty) {
      for (final size in [256, 512, 1024]) {
        for (final name in [
          'photo_a.jpg',
          'photo_b.jpg',
          'photo_large.jpg',
          'video_a.mp4',
        ]) {
          await check(
            '$name-$size',
            File('${arguments.single}/$name'),
            size: size,
            validate: (jpeg) => jpeg.width == size,
          );
        }
      }
    }
    stdout.writeln(
      jsonEncode({
        'status': 'passed',
        'cases': passed,
        'scope': 'local native codecs; no Pi or UI',
      }),
    );
  } finally {
    await root.delete(recursive: true);
  }
}
