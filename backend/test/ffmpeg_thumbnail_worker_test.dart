// Real codec/process regressions; missing FFmpeg is a failed prerequisite.
// ignore_for_file: avoid_slow_async_io
import 'dart:async';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dslideshow_backend/src/service/gallery/thumbnail_service.dart';
import 'package:image/image.dart' as image;
import 'package:test/test.dart';

import 'helpers/capture_logs.dart';
import 'support/external_process_fixture.dart' show ExternalProcessMode;

import 'package:path/path.dart' as p;

Matcher fails(ThumbnailFailureKind kind) =>
    throwsA(isA<ThumbnailFailure>().having((failure) => failure.kind, 'kind', kind));

void main() {
  late Directory root;
  late File source;
  setUp(() async {
    root = await Directory.systemTemp.createTemp('ffmpeg-thumbnail-');
    source = File('${root.path}/source with spaces ; literal.png');
    await source.writeAsBytes(image.encodePng(image.Image(width: 8, height: 8)));
  });
  tearDown(() => root.delete(recursive: true));

  ThumbnailWorkRequest request({
    int size = 256,
    int maxSourceBytes = 200 * 1024 * 1024,
    int maxSourcePixels = 64 * 1024 * 1024,
    int maxOutputBytes = 8 * 1024 * 1024,
    int jpegQuality = 60,
    int backgroundColor = 0xff202020,
    int frameSelectionFrames = 30,
  }) => ThumbnailWorkRequest(
    path: source.path,
    size: size,
    jpegQuality: jpegQuality,
    backgroundColor: backgroundColor,
    frameSelectionFrames: frameSelectionFrames,
    maxSourceBytes: maxSourceBytes,
    maxSourcePixels: maxSourcePixels,
    maxOutputBytes: maxOutputBytes,
  );
  Future<ThumbnailWorkerResult> run({
    FfmpegThumbnailWorker worker = const FfmpegThumbnailWorker(),
    ThumbnailWorkRequest? work,
    Duration timeout = const Duration(seconds: 10),
    ThumbnailCancellationToken? token,
  }) => worker.run(work ?? request(), timeout: timeout, cancellation: token ?? ThumbnailCancellationToken());

  Future<Process> helper(ExternalProcessMode mode) async {
    final server = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
    final ready = server.first.then((socket) async {
      await socket.first;
      socket.destroy();
    });
    final process = await Process.start(Platform.environment['DSLIDESHOW_DART'] ?? 'dart', [
      '--disable-dart-dev',
      p.absolute('test/support/external_process_fixture.dart'),
      mode.name,
      '${server.port}',
    ]);
    addTearDown(() async {
      process.kill(ProcessSignal.sigkill);
      await process.exitCode;
    });
    try {
      await ready.timeout(const Duration(seconds: 5), onTimeout: () => fail('Helper did not start'));
    } finally {
      await server.close();
    }
    return process;
  }

  test('EXIF rotations and mirrors precede crop without orientation metadata', () async {
    for (var orientation = 1; orientation <= 8; orientation++) {
      final pixels = image.Image(width: 35, height: 23);
      for (final pixel in pixels) {
        pixel.setRgb(pixel.x < 17 ? 220 : 20, pixel.y < 11 ? 200 : 20, pixel.x < 17 ? 20 : 220);
      }
      pixels.exif.imageIfd.orientation = orientation;
      final original = image.encodeJpg(pixels, quality: 100);
      await source.writeAsBytes(original);
      final oriented = image.bakeOrientation(image.decodeJpg(original)!);
      final expected = image.copyCrop(
        oriented,
        x: (oriented.width - 23) ~/ 2,
        y: (oriented.height - 23) ~/ 2,
        width: 23,
        height: 23,
      );
      final result = await run(work: request(jpegQuality: 100));
      final actual = image.decodeJpg(result.bytes)!;
      expect([actual.width, actual.height], [23, 23]);
      for (final x in [4, 18]) {
        for (final y in [4, 18]) {
          final a = actual.getPixel(x, y), b = expected.getPixel(x, y);
          for (final pair in [(a.r, b.r), (a.g, b.g), (a.b, b.b)]) {
            expect((pair.$1 - pair.$2).abs(), lessThan(22), reason: 'EXIF $orientation');
          }
        }
      }
      expect(actual.exif.imageIfd.hasOrientation, false);
      expect(await source.readAsBytes(), original);
      expect(result.digest, md5.convert(result.bytes).toString());
    }
  });

  test('alpha is composited on configured background and always encoded as JPEG', () async {
    for (final alpha in [0, 128, 255]) {
      await source.writeAsBytes(
        image.encodePng(image.Image(width: 5, height: 3, numChannels: 4)..clear(image.ColorRgba8(255, 0, 0, alpha))),
      );
      final decoded = image.decodeJpg((await run(work: request(jpegQuality: 100))).bytes)!;
      expect([decoded.width, decoded.height], [3, 3]);
      expect(decoded.hasAlpha, false);
      final pixel = decoded.getPixel(1, 1);
      expect(pixel.r, closeTo((255 * alpha + 32 * (255 - alpha)) / 255, 8));
      expect(pixel.g, closeTo(32 * (255 - alpha) / 255, 8));
      expect(pixel.b, closeTo(32 * (255 - alpha) / 255, 8));
      if (alpha == 0) {
        final white = image.decodeJpg((await run(work: request(backgroundColor: 0xffffffff))).bytes)!;
        expect(white.getPixel(1, 1).r, greaterThan(245));
      }
    }
  });

  test('WebP and one-pixel PNG remain small JPEGs regardless of filename', () async {
    await source.writeAsBytes(
      image.encodeWebP(image.Image(width: 17, height: 9)..clear(image.ColorRgb8(220, 40, 20)), lossless: true),
    );
    var decoded = image.decodeJpg((await run()).bytes)!;
    expect([decoded.width, decoded.height], [9, 9]);
    expect(decoded.getPixel(4, 4).r, greaterThan(200));
    await source.writeAsBytes(image.encodePng(image.Image(width: 1, height: 2)));
    decoded = image.decodeJpg((await run()).bytes)!;
    expect([decoded.width, decoded.height], [1, 1]);
  });

  test('one FFmpeg invocation reads the local source and emits one JPEG', () async {
    await source.writeAsBytes(image.encodeJpg(image.Image(width: 2048, height: 1024)));
    final commands = <(String, List<String>)>[];
    final result = await run(
      work: request(size: 128),
      worker: FfmpegThumbnailWorker(
        startProcess: (executable, arguments) {
          commands.add((executable, arguments));
          return Process.start(executable, arguments);
        },
      ),
    );
    expect(commands.length, 1);
    expect(commands.single.$1, 'ffmpeg');
    expect(commands.single.$2, containsAllInOrder(['-i', source.absolute.path]));
    final decoded = image.decodeJpg(result.bytes)!;
    expect([decoded.width, decoded.height], [128, 128]);
  });

  test('quality changes byte size while preserving geometry', () async {
    final pixels = image.Image(width: 256, height: 256);
    for (final pixel in pixels) {
      pixel.setRgb(
        (pixel.x * 37 + pixel.y * 17) % 256,
        (pixel.x * 19 + pixel.y * 43) % 256,
        (pixel.x * 53 + pixel.y * 29) % 256,
      );
    }
    await source.writeAsBytes(image.encodePng(pixels));
    final high = await run(work: request(jpegQuality: 100));
    final low = await run(work: request(jpegQuality: 25));
    expect(low.bytes.length, lessThan(high.bytes.length));
    expect(image.decodeJpg(low.bytes)!.width, 256);
  });

  test('thumbnail selects a representative animation frame', () async {
    final animation = image.Image(width: 32, height: 24)..clear(image.ColorRgb8(255, 0, 0));
    for (var i = 1; i <= 2; i++) {
      animation.addFrame(image.Image(width: 32, height: 24)..clear(image.ColorRgb8(255, i, 0)));
    }
    for (var i = 0; i < 8; i++) {
      animation.addFrame(image.Image(width: 32, height: 24)..clear(image.ColorRgb8(0, i, 240)));
    }
    await source.writeAsBytes(image.encodeGif(animation));
    final decoded = image.decodeJpg((await run()).bytes)!;
    expect(decoded.getPixel(10, 10).b, greaterThan(200));
    expect(decoded.getPixel(10, 10).r, lessThan(30));
    expect(decoded.numFrames, 1);
    final initialBatch = image.decodeJpg((await run(work: request(frameSelectionFrames: 2))).bytes)!;
    expect(initialBatch.getPixel(10, 10).r, greaterThan(200));
    expect(initialBatch.getPixel(10, 10).b, lessThan(30));
  });

  test('seekable MOV gets a representative JPEG poster', () async {
    for (var i = 0; i < 9; i++) {
      final pixels = image.Image(width: 32, height: 24)
        ..clear(i == 0 ? image.ColorRgb8(255, 0, 0) : image.ColorRgb8(0, i, 240));
      await File('${root.path}/frame-${i.toString().padLeft(2, '0')}.png').writeAsBytes(image.encodePng(pixels));
    }
    source = File('${root.path}/video with spaces.mov');
    final fixture = await Process.run('ffmpeg', [
      '-hide_banner',
      '-loglevel',
      'error',
      '-threads',
      '1',
      '-framerate',
      '4',
      '-i',
      '${root.path}/frame-%02d.png',
      '-threads',
      '1',
      '-c:v',
      'mpeg4',
      source.path,
    ]);
    expect(fixture.exitCode, 0, reason: '${fixture.stderr}');
    final decoded = image.decodeJpg((await run()).bytes)!;
    expect([decoded.width, decoded.height], [24, 24]);
    expect(decoded.getPixel(10, 10).b, greaterThan(180));
    expect(decoded.getPixel(10, 10).r, lessThan(40));
  });

  test('invalid input and byte, pixel, output limits return typed failures', () async {
    await expectLater(run(work: request(maxSourceBytes: 4)), fails(ThumbnailFailureKind.sourceTooLarge));
    await expectLater(run(work: request(maxSourcePixels: 32)), fails(ThumbnailFailureKind.sourceTooLarge));
    await expectLater(run(work: request(maxOutputBytes: 4)), fails(ThumbnailFailureKind.sourceTooLarge));
    await source.writeAsString('not media');
    await expectLater(run(), fails(ThumbnailFailureKind.decodeFailed));
    await source.writeAsBytes([0xff, 0xd8, 0xff, 0, 0, 0]);
    await expectLater(run(), fails(ThumbnailFailureKind.decodeFailed));
  });

  test('file growth during native work cannot publish an oversized source', () async {
    final limit = await source.length() + 10;
    final worker = FfmpegThumbnailWorker(
      startProcess: (executable, arguments) async {
        await source.writeAsBytes(List.filled(32, 0), mode: FileMode.append);
        return Process.start(executable, arguments);
      },
    );
    await expectLater(
      run(
        worker: worker,
        work: request(maxSourceBytes: limit),
      ),
      fails(ThumbnailFailureKind.sourceTooLarge),
    );
  });

  test('missing ffmpeg returns unavailable without fallback', () async {
    await expectLater(
      run(worker: FfmpegThumbnailWorker(ffmpegExecutable: '${root.path}/missing')),
      fails(ThumbnailFailureKind.unavailable),
    );
  });

  test(
    'native failure logs exit code, source and stderr before returning',
    () => captureLogs((records) async {
      final worker = FfmpegThumbnailWorker(startProcess: (_, __) => helper(ExternalProcessMode.diagnostic));
      await expectLater(run(worker: worker), fails(ThumbnailFailureKind.decodeFailed));
      final diagnostic = records.singleWhere((record) => record.message.startsWith('FFmpeg failed'));
      expect(diagnostic.loggerName, 'FfmpegThumbnailWorker');
      expect(diagnostic.message, contains('exit=23'));
      expect(diagnostic.message, contains('Unsupported filter from native decoder'));
      expect(diagnostic.message, contains(source.path));
      expect(records.any((record) => record.message.startsWith('FFmpeg command')), isTrue);
    }),
  );

  test(
    'missing executable logs ProcessException and source context',
    () => captureLogs((records) async {
      await expectLater(
        run(worker: FfmpegThumbnailWorker(ffmpegExecutable: '${root.path}/missing')),
        fails(ThumbnailFailureKind.unavailable),
      );
      final diagnostic = records.singleWhere((record) => record.message.startsWith('Cannot start FFmpeg'));
      expect(diagnostic.error, isA<ProcessException>());
      expect(diagnostic.message, contains(source.path));
      expect(diagnostic.stackTrace, isNotNull);
    }),
  );

  test(
    'stderr flood retains a bounded diagnostic prefix and reaps its child',
    () => captureLogs((records) async {
      final worker = FfmpegThumbnailWorker(startProcess: (_, __) => helper(ExternalProcessMode.diagnosticFlood));
      await expectLater(run(worker: worker), fails(ThumbnailFailureKind.sourceTooLarge));
      final diagnostic = records.singleWhere((record) => record.message.startsWith('FFmpeg failed'));
      expect(diagnostic.message, contains('native-diagnostic-prefix'));
      expect(diagnostic.message, contains('[truncated]'));
      expect(diagnostic.message.length, lessThan(10000));
    }),
  );

  test('cancellation during Process.start waits for its child and KILL escalation', () async {
    final started = Completer<void>(), release = Completer<void>();
    final token = ThumbnailCancellationToken();
    late Process child;
    final worker = FfmpegThumbnailWorker(
      killGrace: const Duration(milliseconds: 50),
      startProcess: (_, __) async {
        child = await helper(ExternalProcessMode.resist);
        started.complete();
        await release.future;
        return child;
      },
    );
    var settled = false;
    final pending = run(worker: worker, token: token).whenComplete(() => settled = true);
    final rejected = expectLater(pending, fails(ThumbnailFailureKind.cancelled));
    await started.future;
    token.cancel();
    await Future<void>.delayed(const Duration(milliseconds: 20));
    expect(settled, false);
    release.complete();
    await rejected;
    expect(await child.exitCode, -ProcessSignal.sigkill.signalNumber);
  });

  test('timeout reaps the owned process and closes its pipes', () async {
    await source.writeAsBytes([0xff, 0xd8, 0xff, ...List.filled(2 * 1024 * 1024, 0)]);
    late Process child;
    final worker = FfmpegThumbnailWorker(
      killGrace: const Duration(milliseconds: 50),
      startProcess: (_, __) async => child = await helper(ExternalProcessMode.resist),
    );
    await expectLater(run(worker: worker, timeout: const Duration(seconds: 1)), fails(ThumbnailFailureKind.timeout));
    expect(await child.exitCode, -ProcessSignal.sigkill.signalNumber);
    // A descriptor can close during enumeration. Inspect links themselves;
    // disappearing entries are handled by the per-entry readlink below.
    final openSource = Directory('/proc/self/fd').listSync(followLinks: false).where((entry) {
      try {
        return Link(entry.path).targetSync() == source.path;
      } on FileSystemException {
        return false;
      }
    });
    expect(openSource, isEmpty);
  });

  test('stdout and stderr overflow kills and reaps the child', () async {
    for (final stream in ['stdout', 'stderr']) {
      late Process child;
      final worker = FfmpegThumbnailWorker(
        killGrace: const Duration(milliseconds: 50),
        startProcess: (_, __) async => child = await helper(
          stream == 'stdout' ? ExternalProcessMode.stdoutFlood : ExternalProcessMode.stderrFlood,
        ),
      );
      await expectLater(
        run(
          worker: worker,
          work: request(maxOutputBytes: 64 * 1024),
        ),
        fails(ThumbnailFailureKind.sourceTooLarge),
      );
      expect(await child.exitCode, -ProcessSignal.sigkill.signalNumber);
    }
  });

  test('deadline includes a delayed Process.start', () async {
    var calls = 0;
    late Process child;
    final worker = FfmpegThumbnailWorker(
      killGrace: const Duration(milliseconds: 20),
      startProcess: (executable, arguments) async {
        calls++;
        await Future<void>.delayed(const Duration(milliseconds: 200));
        return child = await Process.start(executable, arguments);
      },
    );
    await expectLater(
      run(worker: worker, timeout: const Duration(milliseconds: 50)),
      fails(ThumbnailFailureKind.timeout),
    );
    expect(calls, 1);
    await child.exitCode;
  });

  test('service shutdown holds its running slot until the child exits', () async {
    final started = Completer<void>();
    late Process child;
    final worker = FfmpegThumbnailWorker(
      killGrace: const Duration(milliseconds: 50),
      startProcess: (_, __) async {
        child = await helper(ExternalProcessMode.resist);
        started.complete();
        return child;
      },
    );
    final service = ThumbnailService(
      cacheDirectory: Directory('${root.path}/cache'),
      worker: worker,
      isCurrent: (_) async => true,
    );
    addTearDown(service.close);
    final pending = service.acquire(
      ThumbnailSource(mediaId: 'one', revision: '1', path: source.path, fingerprintToken: 'one'),
      const ThumbnailVariantSpec(bucketId: '256', size: 256),
    );
    final rejected = expectLater(pending, fails(ThumbnailFailureKind.closed));
    await started.future;
    await service.close();
    await rejected;
    expect(await child.exitCode, -ProcessSignal.sigkill.signalNumber);
    expect(await Directory('${root.path}/cache').list().toList(), isEmpty);
  });
}
