// ignore_for_file: avoid_slow_async_io
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dslideshow_backend/src/service/gallery/gallery_catalog_service.dart';
import 'package:dslideshow_backend/src/service/gallery/gallery_file_operations.dart';
import 'package:dslideshow_backend/src/service/gallery/gallery_media_tools.dart';
import 'package:dslideshow_backend/src/service/gallery/gallery_tool_runner.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:image/image.dart' as image;
import 'package:logging/logging.dart';
import 'package:test/test.dart';

import 'support/gallery_tool_runner.dart';
import 'support/gallery_metadata_reader.dart';
import 'helpers/capture_logs.dart';

Matcher fails(GalleryErrorCode code) => throwsA(isA<GalleryCatalogFailure>().having((e) => e.code, 'code', code));

void main() {
  late Directory root;
  late Directory media;
  late GalleryCatalogService catalog;
  late GalleryFileOperations operations;
  late GalleryMediaTools tools;
  late ProcessGalleryToolRunner subprocesses;
  late List<String> commands;
  setUp(() async {
    root = await Directory.systemTemp.createTemp('gallery-media-tools-');
    media = await Directory('${root.path}/images').create();
    catalog = GalleryCatalogService(originals: media, stateDirectory: Directory('${root.path}/images.gallery'));
    operations = GalleryFileOperations(catalog: catalog);
    subprocesses = ProcessGalleryToolRunner();
    commands = [];
    final runner = CallbackGalleryToolRunner((
      executable,
      arguments, {
      timeout,
      cancellation,
      environment,
      discardStdout = false,
      maxOutputBytes = 0,
    }) async {
      commands.add(executable);
      expect(
        {'chmod', 'jpegtran'},
        contains(executable),
        reason: 'Still images must not start an EXIF CLI or PNG codec process',
      );
      return subprocesses.run(
        executable,
        arguments,
        timeout: timeout,
        cancellation: cancellation,
        environment: environment,
        discardStdout: discardStdout,
        maxOutputBytes: maxOutputBytes,
      );
    });
    tools = GalleryMediaTools(catalog: catalog, runner: runner, operations: operations);
  });
  tearDown(() async {
    await tools.close();
    await subprocesses.close();
    await operations.close();
    await catalog.close();
    await root.delete(recursive: true);
  });

  Future<GalleryEntry> entry(String filename, List<int> bytes) async {
    await File('${media.path}/$filename').writeAsBytes(bytes);
    return (await catalog.refresh(
      GalleryRefreshRequest(
        operationId: 'scan-$filename-${DateTime.now().microsecondsSinceEpoch}',
        mode: GalleryRefreshMode.scan,
      ),
    )).entries.firstWhere((e) => e.name == filename);
  }

  Future<GalleryMetadata> rotate(GalleryEntry source, String id, {GalleryRotation rotation = GalleryRotation.right}) =>
      tools.rotate(
        GalleryRotateRequest(
          section: source.section,
          operationId: id,
          mediaId: source.mediaId,
          sourceRevision: source.sourceRevision,
          rotation: rotation,
        ),
      );

  Future<void> useCodecOutput(List<int> encoded) async {
    final runner = CallbackGalleryToolRunner((
      executable,
      arguments, {
      timeout,
      cancellation,
      environment,
      discardStdout = false,
      maxOutputBytes = 0,
    }) async {
      if (executable == 'jpegtran') {
        await File(arguments[arguments.indexOf('-outfile') + 1]).writeAsBytes(encoded);
        return const GalleryToolResult(exitCode: 0, stdout: '', stderr: '');
      }
      return subprocesses.run(
        executable,
        arguments,
        timeout: timeout,
        cancellation: cancellation,
        environment: environment,
        discardStdout: discardStdout,
        maxOutputBytes: maxOutputBytes,
      );
    });
    addTearDown(runner.close);
    await tools.close();
    tools = GalleryMediaTools(catalog: catalog, operations: operations, runner: runner);
  }

  test('metadata cache shares an injected read by revision', () async {
    final source = await entry('one.jpg', [1, 2, 3]);
    var calls = 0;
    final reader = CallbackGalleryMetadataReader((source, {input}) async {
      calls++;
      return _details(source);
    });
    addTearDown(reader.close);
    await tools.close();
    tools = GalleryMediaTools(catalog: catalog, metadataReader: reader, operations: operations);
    final first = await tools.metadata(
      GalleryMediaRef(section: source.section, mediaId: source.mediaId, sourceRevision: source.sourceRevision),
    );
    final cached = await tools.metadata(
      GalleryMediaRef(section: source.section, mediaId: source.mediaId, sourceRevision: source.sourceRevision),
    );
    expect(cached, same(first));
    expect(calls, 1);
    await tools.close();
    expect(reader.closeCount, 0, reason: 'The caller owns the injected reader');
  });

  test('late metadata cannot be cached for a replaced source', () async {
    final source = await entry('one.jpg', [1, 2, 3]);
    final entered = Completer<void>(), release = Completer<void>();
    final reader = CallbackGalleryMetadataReader((source, {input}) async {
      entered.complete();
      await release.future;
      return _details(source);
    });
    addTearDown(reader.close);
    await tools.close();
    tools = GalleryMediaTools(catalog: catalog, metadataReader: reader, operations: operations);
    final pending = tools.metadata(
      GalleryMediaRef(section: source.section, mediaId: source.mediaId, sourceRevision: source.sourceRevision),
    );
    final failed = expectLater(pending, fails(GalleryErrorCode.revisionMismatch));
    await entered.future;
    await File('${media.path}/one.jpg').writeAsString('replacement');
    release.complete();
    await failed;
  });

  test('close awaits borrowed metadata cleanup and never closes the injected runner', () async {
    final source = await entry('one.jpg', [1, 2, 3]);
    final entered = Completer<void>(), release = Completer<void>();
    final reader = CallbackGalleryMetadataReader((source, {input}) async {
      entered.complete();
      await release.future;
      return _details(source);
    });
    final runner = CallbackGalleryToolRunner(
      (executable, arguments, {timeout, cancellation, environment, discardStdout = false, maxOutputBytes = 0}) async =>
          throw StateError('No command expected'),
    );
    addTearDown(reader.close);
    await tools.close();
    tools = GalleryMediaTools(catalog: catalog, metadataReader: reader, runner: runner, operations: operations);
    final failed = expectLater(
      tools.metadata(
        GalleryMediaRef(section: source.section, mediaId: source.mediaId, sourceRevision: source.sourceRevision),
      ),
      fails(GalleryErrorCode.unavailable),
    );
    await entered.future;
    var closed = false;
    final closing = tools.close().then((_) => closed = true);
    await Future<void>.value();
    expect(closed, isFalse);
    release.complete();
    await closing;
    await failed;
    expect(runner.closeCount, 0);
  });

  test('real JPEG transform composes every mirrored EXIF orientation and keeps metadata/ICC', () async {
    for (var orientation = 1; orientation <= 8; orientation++) {
      final pixels = _quadrants(32, 16)
        ..exif.imageIfd.orientation = orientation
        ..exif.imageIfd['Make'] = 'Fixture camera'
        ..exif.imageIfd['Model'] = 'Fixture model';
      pixels.exif.exifIfd['DateTimeOriginal'] = '2024:03:04 05:06:07';
      pixels.exif.exifIfd[0x8827] = image.IfdValueShort(200);
      pixels.exif.exifIfd['LensModel'] = 'Fixture lens';
      pixels.exif.exifIfd['ExifImageWidth'] = 32;
      pixels.exif.exifIfd['ExifImageLength'] = 16;
      pixels.exif.thumbnailIfd.orientation = 1;
      pixels.exif.thumbnailData = image.encodeJpg(_quadrants(8, 8));
      final bytes = _jpegWithIcc(image.encodeJpg(pixels, quality: 100), _iccFixture());
      final source = await entry('orientation-$orientation.jpg', bytes);
      final current = await catalog.resolve(source.mediaId);
      final originalBytes = await File(current.absolutePath).readAsBytes();
      final original = image.decodeJpg(originalBytes)!;
      final expected = image.copyRotate(image.bakeOrientation(original), angle: 90);
      final details = await rotate(current.entry, 'rotate-$orientation');
      final actual = image.decodeJpg(await File(current.absolutePath).readAsBytes())!;
      _expectPixels(image.bakeOrientation(actual), expected, tolerance: 4);
      expect(details.orientation, orientation);
      expect([details.width, details.height], [16, 32]);
      expect(details.dateTaken, '2024:03:04 05:06:07');
      expect(details.lens, 'Fixture lens');
      expect(details.iso, '200');
      expect(details.sourceRevision, isNot(current.entry.sourceRevision));
      expect(actual.iccProfile!.decompressed(), original.iccProfile!.decompressed());
      final transformed = await File(current.absolutePath).readAsBytes();
      await expectLater(rotate(current.entry, 'rotate-$orientation'), fails(GalleryErrorCode.revisionMismatch));
      expect(await File(current.absolutePath).readAsBytes(), transformed);
      final next = await catalog.resolve(source.mediaId);
      await rotate(next.entry, 'return-$orientation', rotation: GalleryRotation.left);
      final restored = await File(next.absolutePath).readAsBytes();
      _expectPixels(image.bakeOrientation(image.decodeJpg(restored)!), image.bakeOrientation(original), tolerance: 4);
    }
  }, timeout: const Timeout(Duration(seconds: 90)));

  test('a codec result with another image format cannot replace the original', () async {
    final bytes = image.encodeJpg(_quadrants(32, 16));
    final source = await entry('format.jpg', bytes);
    await useCodecOutput(image.encodePng(_quadrants(16, 32)));
    await expectLater(rotate(source, 'wrong-format'), fails(GalleryErrorCode.processingFailed));
    expect(await File('${media.path}/format.jpg').readAsBytes(), bytes);
    expect((await media.list().toList()).map((entry) => pathName(entry.path)), ['format.jpg']);
  });

  test(
    'omitting normal JPEG Orientation is an EXIF warning without changing display geometry',
    () => captureLogs((records) async {
      final pixels = _quadrants(32, 16)..exif.imageIfd.orientation = 1;
      final source = await entry('normal-orientation.jpg', image.encodeJpg(pixels));
      await useCodecOutput(image.encodeJpg(_quadrants(16, 32)));
      final result = await rotate(source, 'omitted-normal-orientation');
      expect(result.orientation, isNull);
      expect([result.width, result.height], [16, 32]);
      expect(
        records.where((record) => record.level == Level.WARNING && record.message.startsWith('Rotation EXIF changed')),
        hasLength(1),
      );
    }),
  );

  test('JPEG imperfect block edges are rejected without touching original or leaving staging', () async {
    final bytes = image.encodeJpg(_quadrants(35, 23), quality: 100);
    final source = await entry('odd.jpg', bytes);
    await captureLogs((records) async {
      await expectLater(rotate(source, 'odd'), fails(GalleryErrorCode.unsupported));
      final diagnostics = records
          .where(
            (record) =>
                record.loggerName == 'GalleryMediaTools' ||
                record.loggerName == 'ProcessGalleryToolRunner' ||
                record.loggerName == 'GalleryPngRotation',
          )
          .toList();
      final messages = diagnostics.map((record) => record.message).join('\n');
      expect(messages, contains('tool=jpegtran'));
      expect(
        diagnostics.any((record) => record.level == Level.WARNING && record.message.contains('code=unsupported')),
        isTrue,
      );
      expect(messages, isNot(contains(root.path)));
      expect(messages, isNot(contains('odd.jpg')));
      expect(diagnostics.every((record) => record.error == null && record.stackTrace == null), isTrue);
    });
    expect(await File('${media.path}/odd.jpg').readAsBytes(), bytes);
    expect((await catalog.resolve(source.mediaId)).entry.sourceRevision, source.sourceRevision);
    expect((await media.list().toList()).map((e) => pathName(e.path)), ['odd.jpg']);
  });

  test('real PNG left rotation preserves every 16-bit RGBA sample and metadata', () async {
    final pixels = image.Image(width: 13, height: 7, format: image.Format.uint16, numChannels: 4);
    for (final pixel in pixels) {
      pixel.setRgba(1000 + pixel.x * 100, 10000 + pixel.y * 200, 60000 - pixel.x * 120, 30000 + pixel.y * 1000);
    }
    pixels.iccProfile = image.IccProfile('Fixture', image.IccProfileCompression.none, _iccFixture());
    pixels.exif.imageIfd.orientation = 7;
    pixels.exif.imageIfd['ImageWidth'] = 999;
    pixels.exif.imageIfd['ImageLength'] = 888;
    pixels.exif.exifIfd['DateTimeOriginal'] = '2024:03:04 05:06:07';
    pixels.exif.exifIfd['OffsetTimeOriginal'] = '+03:00';
    pixels.exif.exifIfd['ExifImageWidth'] = 999;
    pixels.exif.exifIfd['ExifImageLength'] = 888;
    pixels.exif.thumbnailIfd.orientation = 1;
    pixels.exif.thumbnailData = image.encodeJpg(_quadrants(8, 8));
    final source = await entry('alpha16.png', _pngWithExif(pixels));
    final current = await catalog.resolve(source.mediaId);
    final bytes = await File(current.absolutePath).readAsBytes();
    final original = image.decodePng(bytes)!;
    // This decoder deliberately does not parse PNG eXIf. For the fixture's
    // known mirrored Orientation 7 followed by a left turn, the visible
    // result is the raw image flipped horizontally.
    final expected = image.flipHorizontal(image.Image.from(original));
    final details = await captureLogs((records) async {
      final result = await rotate(current.entry, 'png-left', rotation: GalleryRotation.left);
      final diagnostics = records
          .where(
            (record) =>
                record.loggerName == 'GalleryMediaTools' ||
                record.loggerName == 'ProcessGalleryToolRunner' ||
                record.loggerName == 'GalleryPngRotation',
          )
          .toList();
      final messages = diagnostics.map((record) => record.message).join('\n');
      expect(messages, contains('Rotation started'));
      expect(messages, isNot(contains('operation=')));
      expect(messages, contains('direction=left'));
      expect(messages, contains('tool=dartImage'));
      expect(messages, contains('Rotation finished'));
      expect(
        diagnostics.any((record) => record.loggerName == 'GalleryMediaTools' && record.level == Level.INFO),
        isTrue,
      );
      expect(
        diagnostics.any((record) => record.loggerName == 'GalleryPngRotation' && record.level == Level.FINE),
        isTrue,
      );
      for (final sensitive in [
        root.path,
        'alpha16.png',
        'Gallery fixture',
        '2024:03:04 05:06:07',
        '+03:00',
        'base64:',
      ]) {
        expect(messages, isNot(contains(sensitive)));
      }
      expect(diagnostics.every((record) => record.error == null && record.stackTrace == null), isTrue);
      return result;
    });
    final actual = image.decodePng(await File(current.absolutePath).readAsBytes())!;
    _expectPixels(actual, expected, tolerance: 0, everyPixel: true);
    expect(actual.format, image.Format.uint16);
    expect(actual.numChannels, 4);
    expect(details.bitDepth, 16);
    expect(details.hasAlpha, true);
    expect(details.dateTaken, '2024:03:04 05:06:07+03:00');
    expect(actual.iccProfile!.decompressed(), original.iccProfile!.decompressed());
    expect(details.orientation, 1);
    expect(commands, everyElement('chmod'), reason: 'PNG metadata and pixels are processed entirely in Dart');
    final normalizedExif = image.ExifData.fromInputBuffer(
      image.InputBuffer(_pngExif(await File(current.absolutePath).readAsBytes())),
    );
    expect(normalizedExif.imageIfd.orientation, 1);
    expect(normalizedExif.imageIfd['ImageWidth']!.toInt(), 13);
    expect(normalizedExif.imageIfd['ImageLength']!.toInt(), 7);
    expect(normalizedExif.exifIfd['ExifImageWidth']!.toInt(), 13);
    expect(normalizedExif.exifIfd['ExifImageLength']!.toInt(), 7);
    expect(normalizedExif.thumbnailData, isNull);
    expect(normalizedExif.directories.containsKey('ifd1'), isFalse);
    // A repeated request is validated against the current file, without a journal.
    await tools.close();
    expect(await Directory('${catalog.stateDirectory.path}/rotations').exists(), isFalse);
    final transformed = await File(current.absolutePath).readAsBytes();
    tools = GalleryMediaTools(catalog: catalog, operations: operations);
    await expectLater(
      rotate(current.entry, 'png-left', rotation: GalleryRotation.left),
      fails(GalleryErrorCode.revisionMismatch),
    );
    expect(await File(current.absolutePath).readAsBytes(), transformed);
  });

  test('palette PNG is rejected instead of silently converting color depth', () async {
    final palette = image.Image(width: 8, height: 8, withPalette: true);
    final bytes = image.encodePng(palette);
    final source = await entry('palette.png', bytes);
    await expectLater(rotate(source, 'palette'), fails(GalleryErrorCode.unsupported));
    expect(await File('${media.path}/palette.png').readAsBytes(), bytes);
  });

  test('APNG in a png filename is rejected instead of keeping just its first frame', () async {
    final animation = _quadrants(8, 8)..addFrame(_quadrants(8, 8));
    final bytes = image.encodePng(animation);
    final source = await entry('animated.png', bytes);
    await expectLater(rotate(source, 'animated'), fails(GalleryErrorCode.unsupported));
    expect(await File('${media.path}/animated.png').readAsBytes(), bytes);
  });

  test('rotation preserves restrictive Unix file permissions', () async {
    final source = await entry('private.png', image.encodePng(_quadrants(8, 4)));
    final file = File('${media.path}/private.png');
    expect((await Process.run('chmod', ['0600', '--', file.path])).exitCode, 0);
    final current = await catalog.resolve(source.mediaId);
    final before = (await file.stat()).mode & 0xfff;
    await rotate(current.entry, 'private');
    expect((await file.stat()).mode & 0xfff, before);
  });

  test('external replacement during codec work is not overwritten', () async {
    final source = await entry('race.jpg', image.encodeJpg(_quadrants(32, 16)));
    final actualRunner = ProcessGalleryToolRunner();
    addTearDown(actualRunner.close);
    final replacement = image.encodeJpg(_quadrants(16, 32), quality: 80);
    final fake = CallbackGalleryToolRunner((
      executable,
      arguments, {
      timeout,
      cancellation,
      environment,
      discardStdout = false,
      maxOutputBytes = 0,
    }) async {
      final result = await actualRunner.run(
        executable,
        arguments,
        timeout: timeout,
        cancellation: cancellation,
        environment: environment,
        maxOutputBytes: maxOutputBytes,
      );
      if (executable == 'jpegtran') {
        await File('${media.path}/race.jpg').writeAsBytes(replacement);
      }
      return result;
    });
    await tools.close();
    tools = GalleryMediaTools(catalog: catalog, runner: fake, operations: operations);
    // The final revision precheck must reject the externally replaced source.
    await expectLater(rotate(source, 'race'), fails(GalleryErrorCode.revisionMismatch));
    expect(await File('${media.path}/race.jpg').readAsBytes(), replacement);
    expect((await media.list().toList()).length, 1);
  });

  test('metadata and rotation reject a file reached through a symlink parent', () async {
    await Directory('${media.path}/real').create();
    await Link('${media.path}/alias').create('${media.path}/real');
    await File('${media.path}/real/photo.jpg').writeAsBytes([1, 2, 3]);
    final snapshot = await catalog.refresh(
      const GalleryRefreshRequest(operationId: 'symlink-parent-scan', mode: GalleryRefreshMode.scan),
    );
    final aliased = snapshot.entries.firstWhere((item) => item.path == 'alias/photo.jpg');
    await expectLater(
      tools.metadata(
        GalleryMediaRef(section: aliased.section, mediaId: aliased.mediaId, sourceRevision: aliased.sourceRevision),
      ),
      fails(GalleryErrorCode.forbidden),
    );
    await expectLater(rotate(aliased, 'symlink-parent'), fails(GalleryErrorCode.forbidden));
    expect(await File('${media.path}/real/photo.jpg').readAsBytes(), [1, 2, 3]);
  });

  test(
    'changed JPEG EXIF is retained with a safe warning instead of restoring old tags',
    () => captureLogs((records) async {
      final pixels = _quadrants(32, 16)..exif.imageIfd['Make'] = 'Original';
      final source = await entry('changed-exif.jpg', image.encodeJpg(pixels));
      final alteredCodec = CallbackGalleryToolRunner((
        executable,
        arguments, {
        timeout,
        cancellation,
        environment,
        discardStdout = false,
        maxOutputBytes = 0,
      }) async {
        final result = await subprocesses.run(
          executable,
          arguments,
          timeout: timeout,
          cancellation: cancellation,
          environment: environment,
          discardStdout: discardStdout,
          maxOutputBytes: maxOutputBytes,
        );
        if (executable == 'jpegtran' && result.exitCode == 0) {
          final output = File(arguments[arguments.indexOf('-outfile') + 1]);
          final bytes = await output.readAsBytes();
          final needle = ascii.encode('Original');
          var replaced = false;
          for (var i = 0; i <= bytes.length - needle.length; i++) {
            if (List.generate(needle.length, (n) => bytes[i + n] == needle[n]).every((same) => same)) {
              bytes.setRange(i, i + needle.length, ascii.encode('Rendered'));
              replaced = true;
              break;
            }
          }
          expect(replaced, isTrue, reason: 'The codec fixture must change its EXIF Make');
          await output.writeAsBytes(bytes);
        }
        return result;
      });
      addTearDown(alteredCodec.close);
      await tools.close();
      tools = GalleryMediaTools(catalog: catalog, operations: operations, runner: alteredCodec);
      final result = await rotate(source, 'changed-exif');
      expect([result.width, result.height], [16, 32]);
      expect(result.camera, 'Rendered');
      final written = image.decodeJpg(await File('${media.path}/changed-exif.jpg').readAsBytes())!;
      expect([written.width, written.height], [16, 32]);
      final warning = records.singleWhere((record) => record.message.startsWith('Rotation EXIF changed'));
      expect(warning.level, Level.WARNING);
      expect(warning.message, isNot(contains('operation=')));
      for (final private in [root.path, 'Original', 'Rendered']) {
        expect(warning.message, isNot(contains(private)));
      }
      expect(warning.error, isNull);
      expect(warning.stackTrace, isNull);
    }),
  );
}

String pathName(String value) => value.split(Platform.pathSeparator).last;

image.Image _quadrants(int width, int height) {
  final pixels = image.Image(width: width, height: height);
  for (final pixel in pixels) {
    pixel.setRgb(pixel.x < width ~/ 2 ? 220 : 20, pixel.y < height ~/ 2 ? 200 : 20, pixel.x < width ~/ 2 ? 20 : 220);
  }
  return pixels;
}

void _expectPixels(image.Image actual, image.Image expected, {required int tolerance, bool everyPixel = false}) {
  expect([actual.width, actual.height], [expected.width, expected.height]);
  final coordinates = everyPixel
      ? [
          for (var y = 0; y < actual.height; y++)
            for (var x = 0; x < actual.width; x++) (x, y),
        ]
      : [
          (actual.width ~/ 4, actual.height ~/ 4),
          (actual.width * 3 ~/ 4, actual.height ~/ 4),
          (actual.width ~/ 4, actual.height * 3 ~/ 4),
          (actual.width * 3 ~/ 4, actual.height * 3 ~/ 4),
        ];
  for (final coordinate in coordinates) {
    final a = actual.getPixel(coordinate.$1, coordinate.$2);
    final b = expected.getPixel(coordinate.$1, coordinate.$2);
    for (final pair in [(a.r, b.r), (a.g, b.g), (a.b, b.b), (a.a, b.a)]) {
      expect((pair.$1 - pair.$2).abs(), lessThanOrEqualTo(tolerance), reason: 'pixel $coordinate');
    }
  }
}

/// Minimal deterministic ICC profile with a description tag. It is a metadata
/// round-trip fixture, not a color conversion reference or host system file.
Uint8List _iccFixture() {
  final description = ascii.encode('Gallery fixture\u0000');
  final tag = Uint8List(12 + description.length + 8 + 70);
  tag.setRange(0, 4, ascii.encode('desc'));
  ByteData.sublistView(tag).setUint32(8, description.length);
  tag.setRange(12, 12 + description.length, description);
  final profile = Uint8List(144 + tag.length);
  final data = ByteData.sublistView(profile);
  data.setUint32(0, profile.length);
  data.setUint32(8, 0x02100000);
  profile.setRange(12, 16, ascii.encode('mntr'));
  profile.setRange(16, 20, ascii.encode('RGB '));
  profile.setRange(20, 24, ascii.encode('XYZ '));
  data.setUint16(24, 2024);
  data.setUint16(26, 1);
  data.setUint16(28, 1);
  profile.setRange(36, 40, ascii.encode('acsp'));
  data.setUint32(128, 1);
  profile.setRange(132, 136, ascii.encode('desc'));
  data.setUint32(136, 144);
  data.setUint32(140, tag.length);
  profile.setRange(144, profile.length, tag);
  return profile;
}

GalleryMetadata _details(GallerySource source) => GalleryMetadata(
  section: source.entry.section,
  mediaId: source.entry.mediaId,
  sourceRevision: source.entry.sourceRevision,
  name: source.entry.name,
  path: source.entry.path,
  kind: source.entry.kind,
  sizeBytes: 3,
);

List<int> _jpegWithIcc(List<int> jpeg, List<int> profile) {
  // ICC JPEG APP2 includes one-based sequence and total chunk counts. The
  // image encoder does not write those bytes, so build this fixture directly.
  final payload = [...ascii.encode('ICC_PROFILE\u0000'), 1, 1, ...profile];
  final length = payload.length + 2;
  return [...jpeg.take(2), 0xff, 0xe2, length >> 8, length & 0xff, ...payload, ...jpeg.skip(2)];
}

Uint8List _pngWithExif(image.Image pixels) {
  final encoded = image.encodePng(pixels);
  final exif = image.OutputBuffer();
  pixels.exif.write(exif);
  return Uint8List.fromList([...encoded.take(33), ..._pngChunk('eXIf', exif.getBytes()), ...encoded.skip(33)]);
}

List<int> _pngExif(List<int> encoded) {
  for (var offset = 8; offset < encoded.length;) {
    final length =
        encoded[offset] * 0x1000000 + encoded[offset + 1] * 0x10000 + encoded[offset + 2] * 256 + encoded[offset + 3];
    if (ascii.decode(encoded.sublist(offset + 4, offset + 8)) == 'eXIf')
      return encoded.sublist(offset + 8, offset + 8 + length);
    offset += length + 12;
  }
  fail('Expected an eXIf chunk');
}

List<int> _pngChunk(String type, List<int> payload) {
  final result = Uint8List(payload.length + 12);
  ByteData.sublistView(result).setUint32(0, payload.length);
  result.setRange(4, 8, ascii.encode(type));
  result.setRange(8, payload.length + 8, payload);
  var crc = 0xffffffff;
  for (final value in result.sublist(4, payload.length + 8)) {
    crc ^= value;
    for (var bit = 0; bit < 8; bit++) {
      crc = (crc & 1) == 0 ? crc >> 1 : (crc >> 1) ^ 0xedb88320;
    }
  }
  ByteData.sublistView(result).setUint32(payload.length + 8, (crc ^ 0xffffffff) & 0xffffffff);
  return result;
}
