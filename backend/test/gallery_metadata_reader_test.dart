// Real metadata/header parsing: no external image-metadata process is involved.
// ignore_for_file: avoid_slow_async_io, implementation_imports
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dslideshow_backend/src/service/gallery/gallery_catalog_service.dart';
import 'package:dslideshow_backend/src/service/gallery/gallery_metadata_reader.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:image/image.dart' as image;
import 'package:image/src/util/rational.dart' show Rational;
import 'package:test/test.dart';

import 'support/gallery_tool_runner.dart';

Matcher _failure(GalleryErrorCode code) =>
    throwsA(isA<GalleryCatalogFailure>().having((e) => e.code, 'code', code));

void main() {
  late Directory root;
  late GalleryMetadataReader reader;
  setUp(() async {
    root = await Directory.systemTemp.createTemp('gallery-dart-metadata-');
    reader = GalleryMetadataReader();
  });
  tearDown(() async {
    await reader.close();
    await root.delete(recursive: true);
  });

  Future<GallerySource> fixture(
    String name,
    List<int> bytes, {
    GalleryEntryKind kind = GalleryEntryKind.image,
  }) async {
    final file = await File('${root.path}/$name').writeAsBytes(bytes);
    return GallerySource(
      GalleryEntry(
        mediaId: 'photo',
        sourceRevision: 'revision-1',
        name: name,
        path: 'album/$name',
        kind: kind,
      ),
      file.path,
      'fingerprint',
    );
  }

  test(
    'EXIF digest compares parsed tags independently of pixel contents',
    () async {
      final pixels = image.Image(width: 32, height: 16)
        ..exif.imageIfd['ImageDescription'] = 'Original description';
      final first = await fixture('first.jpg', image.encodeJpg(pixels));
      final before = await reader.exifDigest(File(first.absolutePath));
      expect(before, isNotNull);
      pixels.clear(image.ColorRgb8(10, 20, 30));
      final sameTags = await fixture('pixels.jpg', image.encodeJpg(pixels));
      expect(await reader.exifDigest(File(sameTags.absolutePath)), before);
      pixels.exif.imageIfd['ImageDescription'] = 'Changed description';
      final changed = await fixture('changed.jpg', image.encodeJpg(pixels));
      expect(
        await reader.exifDigest(File(changed.absolutePath)),
        isNot(before),
      );
      final empty = await fixture(
        'no-exif.jpg',
        image.encodeJpg(image.Image(width: 8, height: 8)),
      );
      expect(await reader.exifDigest(File(empty.absolutePath)), isNull);
      expect(await _openSources(root), isEmpty);
    },
  );

  test('JPEG physical geometry, EXIF/GPS and timezone survive stale EXIF dimensions without a CLI', () async {
    final pixels = image.Image(width: 32, height: 16);
    pixels.exif.imageIfd
      ..orientation = 6
      ..imageWidth = 999
      ..imageHeight = 777
      ..['Make'] = 'Fixture'
      ..['Model'] = 'Camera';
    pixels.exif.exifIfd
      ..['ExifImageWidth'] = 333
      ..['ExifImageLength'] = 222
      ..['DateTimeOriginal'] = '2026:07:12 10:11:12'
      ..['OffsetTimeOriginal'] = '+03:00'
      ..['LensModel'] = 'Fixture lens'
      ..['ISOSpeed'] = 200
      ..['FNumber'] = image.IfdValueRational(28, 10)
      ..['ExposureTime'] = image.IfdValueRational(1, 250);
    pixels.exif.gpsIfd
      ..['GPSLatitudeRef'] = image.IfdValueAscii('S')
      ..['GPSLatitude'] = image.IfdValueRational.list([
        Rational(55, 1),
        Rational(30, 1),
        Rational(0, 1),
      ])
      ..['GPSLongitudeRef'] = image.IfdValueAscii('E')
      ..['GPSLongitude'] = image.IfdValueRational.list([
        Rational(37, 1),
        Rational(15, 1),
        Rational(0, 1),
      ]);
    final source = await fixture('private.jpg', image.encodeJpg(pixels));
    final noCommands = CallbackGalleryToolRunner(
      (
        _,
        _, {
        timeout,
        cancellation,
        environment,
        discardStdout = false,
        maxOutputBytes = 0,
      }) async => fail('Still metadata must not start a child process'),
    );
    await reader.close();
    reader = GalleryMetadataReader(runner: noCommands);
    final metadata = await reader.read(source);
    expect([metadata.width, metadata.height], [32, 16]);
    expect(metadata.orientation, 6);
    expect(metadata.camera, 'Fixture Camera');
    expect(metadata.lens, 'Fixture lens');
    expect(metadata.iso, '200');
    expect(metadata.aperture, '2.8');
    expect(metadata.exposure, '1/250');
    expect(metadata.dateTaken, '2026:07:12 10:11:12+03:00');
    expect(metadata.latitude, -55.5);
    expect(metadata.longitude, 37.25);
    expect(metadata.sourceRevision, 'revision-1');
    expect(metadata.fileModified!.isUtc, isTrue);
    expect(metadata.sizeBytes, await File(source.absolutePath).length());
    await reader.close();
    expect(noCommands.closeCount, 0);
  });

  test(
    'JPEG PNG GIF and WebP report container dimensions when EXIF is absent',
    () async {
      final pixels = image.Image(width: 23, height: 17);
      final cases = <String, List<int>>{
        'without.jpg': image.encodeJpg(pixels),
        'without.png': image.encodePng(pixels),
        'without.gif': image.encodeGif(pixels),
        'without.webp': image.encodeWebP(pixels),
      };
      for (final entry in cases.entries) {
        final source = await fixture(entry.key, entry.value);
        final metadata = await reader.read(source);
        expect([metadata.width, metadata.height], [23, 17], reason: entry.key);
        expect(metadata.orientation, isNull);
        expect(metadata.camera, isNull);
        expect(metadata.dateTaken, isNull);
        expect(metadata.colorProfile, isNull);
        expect(await reader.profileDigest(File(source.absolutePath)), isNull);
      }
    },
  );

  test('PNG eXIf after pixels and ICC have bounded Dart reads, 16-bit alpha and staged identity', () async {
    final profile = _icc();
    final pixels =
        image.Image(
            width: 13,
            height: 7,
            format: image.Format.uint16,
            numChannels: 4,
          )
          ..iccProfile = image.IccProfile(
            'Fixture',
            image.IccProfileCompression.none,
            profile,
          );
    final exifData = image.ExifData();
    exifData.imageIfd.orientation = 3;
    exifData.exifIfd['DateTimeOriginal'] = '2025:01:02 03:04:05';
    final output = image.OutputBuffer();
    exifData.write(output);
    final encoded = image.encodePng(pixels);
    final before = encoded.sublist(0, encoded.length - 12);
    final bytes = [
      ...before,
      ..._pngChunk('eXIf', output.getBytes()),
      ...encoded.sublist(encoded.length - 12),
    ];
    final source = await fixture('alpha16.png', bytes);
    final metadata = await reader.read(source);
    expect([metadata.width, metadata.height], [13, 7]);
    expect(metadata.orientation, 3);
    expect(
      metadata.dateTaken,
      '2025:01:02 03:04:05',
      reason: 'No timezone may be invented',
    );
    expect(metadata.bitDepth, 16);
    expect(metadata.hasAlpha, isTrue);
    expect(metadata.colorProfile, 'Fixture profile');
    final digest = await reader.profileDigest(File(source.absolutePath));
    expect(digest, isNotNull);
    final staged = await File('${root.path}/stage.part')
        .writeAsBytes(image.encodePng(image.Image(width: 7, height: 13)));
    final inspected = await reader.read(source, input: staged.path);
    expect([inspected.width, inspected.height], [7, 13]);
    expect(inspected.mediaId, source.entry.mediaId);
    expect(inspected.path, 'album/alpha16.png');
    expect(inspected.sizeBytes, await staged.length());
    expect(await reader.profileDigest(staged), isNull);
  });

  test(
    'malformed EXIF and read budget failures close every source descriptor',
    () async {
      final pixels = image.Image(width: 32, height: 16);
      pixels.exif.imageIfd.orientation = 6;
      final encoded = image.encodeJpg(pixels);
      final damaged = List<int>.of(encoded);
      final exifStart = _find(damaged, [69, 120, 105, 102, 0, 0]);
      expect(exifStart, greaterThan(0));
      // The IFD offset now points outside its APP1 segment.
      damaged.setRange(exifStart + 10, exifStart + 14, [127, 255, 255, 255]);
      final source = await fixture('damaged.jpg', damaged);
      for (var i = 0; i < 24; i++) {
        await expectLater(
          reader.read(source),
          _failure(GalleryErrorCode.processingFailed),
        );
      }
      await reader.close();
      reader = GalleryMetadataReader(maxReadBytes: 8);
      await expectLater(
        reader.read(source),
        _failure(GalleryErrorCode.outputLimitExceeded),
      );
      expect(await _openSources(root), isEmpty);
    },
  );

  test('close awaits active worker cleanup and cancellation does not close an injected runner', () async {
    final source = await fixture(
      'pending.jpg',
      image.encodeJpg(image.Image(width: 32, height: 16)),
    );
    final noCommands = CallbackGalleryToolRunner(
      (
        _,
        _, {
        timeout,
        cancellation,
        environment,
        discardStdout = false,
        maxOutputBytes = 0,
      }) async => fail('No image command'),
    );
    await reader.close();
    reader = GalleryMetadataReader(runner: noCommands);
    final read = reader.read(source);
    final failed = expectLater(read, _failure(GalleryErrorCode.cancelled));
    await reader.close();
    await failed;
    expect(await _openSources(root), isEmpty);
    expect(noCommands.closeCount, 0);
  });

  test('actual ffprobe reads video geometry codec and duration without decoding pixels', () async {
    final video = File('${root.path}/small.mp4');
    final encoded = await Process.run('ffmpeg', [
      '-hide_banner',
      '-loglevel',
      'error',
      '-nostdin',
      '-f',
      'lavfi',
      '-i',
      'color=c=blue:s=32x24:r=2',
      '-t',
      '1',
      '-c:v',
      'mpeg4',
      '-threads',
      '1',
      '-y',
      video.path,
    ]);
    expect(encoded.exitCode, 0, reason: encoded.stderr as String);
    final source = GallerySource(
      GalleryEntry(
        mediaId: 'video',
        sourceRevision: 'video-1',
        path: 'small.mp4',
        name: 'small.mp4',
        kind: GalleryEntryKind.video,
      ),
      video.path,
      'fingerprint',
    );
    final metadata = await reader.read(source);
    expect([metadata.width, metadata.height], [32, 24]);
    expect(metadata.codec, 'mpeg4');
    expect(metadata.durationSeconds, closeTo(1, 0.01));
    expect(metadata.sizeBytes, await video.length());
    expect(metadata.orientation, isNull);
  });
}

int _find(List<int> data, List<int> pattern) {
  for (var i = 0; i <= data.length - pattern.length; i++) {
    if (List.generate(
      pattern.length,
      (n) => data[i + n] == pattern[n],
    ).every((value) => value))
      return i;
  }
  return -1;
}

Future<List<String>> _openSources(Directory root) async {
  final paths = <String>[];
  await for (final entry in Directory(
    '/proc/self/fd',
  ).list(followLinks: false)) {
    try {
      final target = await Link(entry.path).target();
      if (target.startsWith(root.path)) paths.add(target);
    } on FileSystemException {
      /* A descriptor may close while it is observed. */
    }
  }
  return paths;
}

Uint8List _icc() {
  final description = ascii.encode('Fixture profile\u0000');
  final bytes = Uint8List(144 + 12 + description.length);
  final data = ByteData.sublistView(bytes);
  data.setUint32(0, bytes.length);
  bytes.setRange(36, 40, ascii.encode('acsp'));
  data.setUint32(128, 1);
  bytes.setRange(132, 136, ascii.encode('desc'));
  data.setUint32(136, 144);
  data.setUint32(140, 12 + description.length);
  bytes.setRange(144, 148, ascii.encode('desc'));
  data.setUint32(152, description.length);
  bytes.setRange(156, bytes.length, description);
  return bytes;
}

List<int> _pngChunk(String type, List<int> payload) {
  final bytes = [...ascii.encode(type), ...payload];
  var crc = 0xffffffff;
  for (final byte in bytes) {
    crc ^= byte;
    for (var i = 0; i < 8; i++) {
      crc = (crc & 1) == 0 ? crc >> 1 : (crc >> 1) ^ 0xedb88320;
    }
  }
  final size = ByteData(4)..setUint32(0, payload.length);
  final checksum = ByteData(4)..setUint32(0, crc ^ 0xffffffff);
  return [
    ...size.buffer.asUint8List(),
    ...bytes,
    ...checksum.buffer.asUint8List(),
  ];
}
