// Temporary fixtures exercise the real PNG worker and files without CLI tools.
// ignore_for_file: avoid_slow_async_io
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dslideshow_backend/src/service/gallery/gallery_catalog_service.dart';
import 'package:dslideshow_backend/src/service/gallery/gallery_png_rotation.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:image/image.dart' as image;
import 'package:logging/logging.dart';
import 'package:test/test.dart';

typedef _Chunk = ({String type, Uint8List bytes, Uint8List data});

Matcher _fails(GalleryErrorCode code) => throwsA(
  isA<GalleryCatalogFailure>().having((error) => error.code, 'code', code),
);

void main() {
  late Directory root;
  late File source, staged;
  late GalleryPngRotation rotation;
  setUp(() async {
    root = await Directory.systemTemp.createTemp('gallery-dart-png-');
    source = File('${root.path}/source.png');
    staged = await File('${root.path}/staged.part').create();
    rotation = GalleryPngRotation();
  });
  tearDown(() async {
    await rotation.close();
    await root.delete(recursive: true);
  });

  test('all EXIF orientations become correct 16-bit display samples and normalized geometry', () async {
    for (var orientation = 1; orientation <= 8; orientation++) {
      final original = _pixels(3, 2, 4);
      original.iccProfile = image.IccProfile(
        'Fixture',
        image.IccProfileCompression.none,
        _profile(),
      );
      final input = _insert(
        image.encodePng(original),
        before: [
          _chunk('eXIf', _exif(orientation)),
          _chunk('vpAg', [11, 12]),
          _chunk('vpAG', [99]),
        ],
        after: [_chunk('tEXt', ascii.encode('Comment\u0000after pixels'))],
      );
      await source.writeAsBytes(input);
      await staged.writeAsBytes(const []);
      final direction = orientation.isEven
          ? GalleryRotation.left
          : GalleryRotation.right;
      await rotation.rotate(
        source: source,
        staged: staged,
        rotation: direction,
      );
      final output = await staged.readAsBytes();
      final actual = image.decodePng(output)!;
      _expectDisplaySamples(actual, original, orientation, direction);
      expect(actual.format, image.Format.uint16);
      expect(actual.numChannels, 4);
      final tags = _readExif(output);
      expect(tags.imageIfd.orientation, 1);
      expect(tags.imageIfd[0x0100]!.toInt(), actual.width);
      expect(tags.imageIfd[0x0101]!.toInt(), actual.height);
      expect(tags.exifIfd[0xa002]!.toInt(), actual.width);
      expect(tags.exifIfd[0xa003]!.toInt(), actual.height);
      expect(tags.imageIfd.make, 'Fixture camera');
      expect(
        tags.exifIfd['DateTimeOriginal']!.toString(),
        '2024:03:04 05:06:07',
      );
      expect(tags.gpsIfd[2]!.toRational(0).numerator, 12);
      expect(tags.gpsIfd[2]!.toRational(1).numerator, 34);
      expect(tags.gpsIfd[2]!.toRational(2).numerator, 56);
      expect(tags.directories.containsKey('ifd1'), isFalse);
      expect(tags.thumbnailData, isNull);
      final originalChunks = _chunks(input), resultChunks = _chunks(output);
      expect(resultChunks.where((chunk) => chunk.type == 'eXIf'), hasLength(1));
      expect(
        resultChunks.singleWhere((chunk) => chunk.type == 'iCCP').bytes,
        originalChunks.singleWhere((chunk) => chunk.type == 'iCCP').bytes,
      );
      expect(actual.iccProfile!.decompressed(), _profile());
      expect(resultChunks.singleWhere((chunk) => chunk.type == 'vpAg').data, [
        11,
        12,
      ]);
      expect(resultChunks.any((chunk) => chunk.type == 'vpAG'), isFalse);
      expect(
        resultChunks.singleWhere((chunk) => chunk.type == 'tEXt').data,
        ascii.encode('Comment\u0000after pixels'),
      );
      expect(
        resultChunks.indexWhere((chunk) => chunk.type == 'tEXt'),
        greaterThan(
          resultChunks.lastIndexWhere((chunk) => chunk.type == 'IDAT'),
        ),
      );
      expect(await source.readAsBytes(), input);
    }
  });

  test(
    '16-bit grayscale and grayscale alpha retain every integer sample',
    () async {
      for (final channels in [1, 2]) {
        final original = _pixels(5, 3, channels);
        await source.writeAsBytes(
          _insert(
            image.encodePng(original),
            before: [_chunk('eXIf', _exif(6))],
          ),
        );
        await rotation.rotate(
          source: source,
          staged: staged,
          rotation: GalleryRotation.right,
        );
        final actual = image.decodePng(await staged.readAsBytes())!;
        expect(actual.format, image.Format.uint16);
        expect(actual.numChannels, channels);
        _expectDisplaySamples(actual, original, 6, GalleryRotation.right);
      }
    },
  );

  test(
    'physical density follows the complete normalized pixel-axis transform',
    () async {
      final density = Uint8List(9);
      ByteData.sublistView(density)
        ..setUint32(0, 1000)
        ..setUint32(4, 2000);
      density[8] = 1;
      final ancillary = [
        _chunk('PLTE', [0, 0, 0, 255, 255, 255]),
        _chunk('bKGD', [0, 1, 0, 2, 0, 3]),
        _chunk('hIST', [0, 2, 0, 4]),
        _chunk('sPLT', [
          ...ascii.encode('Fixture'),
          0,
          16,
          ...List.filled(10, 0),
        ]),
      ];
      for (final orientation in [1, 6]) {
        await source.writeAsBytes(
          _insert(
            image.encodePng(_pixels(3, 2, 4)),
            before: [
              ...ancillary,
              _chunk('eXIf', _exif(orientation)),
              _chunk('pHYs', density),
            ],
          ),
        );
        await rotation.rotate(
          source: source,
          staged: staged,
          rotation: GalleryRotation.right,
        );
        final after = ByteData.sublistView(
          _chunks(await staged.readAsBytes())
              .singleWhere((chunk) => chunk.type == 'pHYs')
              .data,
        );
        expect([
          after.getUint32(0),
          after.getUint32(4),
          after.getUint8(8),
        ], orientation == 1 ? [2000, 1000, 1] : [1000, 2000, 1]);
        final outputChunks = _chunks(await staged.readAsBytes());
        for (final chunk in ancillary) {
          final type = ascii.decode(chunk.sublist(4, 8));
          expect(
            outputChunks.singleWhere((value) => value.type == type).bytes,
            chunk,
          );
        }
      }
    },
  );

  test(
    'CRC, framing, unsupported layouts and budgets fail before staging writes',
    () async {
      final clean = image.encodePng(_pixels(3, 2, 4));
      final corrupted = _insert(clean, before: [_chunk('eXIf', _exif(1))]);
      corrupted[45] ^= 1;
      final oversized = Uint8List.fromList(clean);
      ByteData.sublistView(oversized).setUint32(8, 0x7fffffff);
      final hugeHeader = Uint8List.fromList(_chunks(clean).first.data);
      ByteData.sublistView(hugeHeader)
        ..setUint32(0, 0xffffffff)
        ..setUint32(4, 0xffffffff);
      final overflow = Uint8List.fromList([
        ...clean.sublist(0, 8),
        ..._chunk('IHDR', hugeHeader),
        ...clean.sublist(33),
      ]);
      final background = _chunk('bKGD', List.filled(6, 0));
      final suggested = _chunk('sPLT', [65, 0, 8, ...List.filled(6, 0)]);
      final cases = <(Uint8List, GalleryErrorCode)>[
        (corrupted, GalleryErrorCode.processingFailed),
        (oversized, GalleryErrorCode.processingFailed),
        (overflow, GalleryErrorCode.unsupported),
        (
          _insert(clean, before: [_chunk('acTL', List.filled(8, 0))]),
          GalleryErrorCode.unsupported,
        ),
        (
          _insert(clean, before: [_chunk('tRNS', List.filled(6, 0))]),
          GalleryErrorCode.unsupported,
        ),
        (
          _insert(clean, before: [_chunk('ABCD', [])]),
          GalleryErrorCode.unsupported,
        ),
        (
          _insert(clean, before: [background, background]),
          GalleryErrorCode.processingFailed,
        ),
        (
          _insert(clean, after: [background]),
          GalleryErrorCode.processingFailed,
        ),
        (
          _insert(
            clean,
            before: [
              _chunk('hIST', [0, 1]),
            ],
          ),
          GalleryErrorCode.processingFailed,
        ),
        (
          _insert(
            clean,
            before: [
              background,
              _chunk('PLTE', [0, 0, 0]),
            ],
          ),
          GalleryErrorCode.processingFailed,
        ),
        (
          _insert(clean, before: [suggested, suggested]),
          GalleryErrorCode.processingFailed,
        ),
        (_insert(clean, after: [suggested]), GalleryErrorCode.processingFailed),
      ];
      for (final (bytes, code) in cases) {
        await source.writeAsBytes(bytes);
        await staged.writeAsBytes(const []);
        await expectLater(
          rotation.rotate(
            source: source,
            staged: staged,
            rotation: GalleryRotation.right,
          ),
          _fails(code),
        );
        expect(await source.readAsBytes(), bytes);
        expect(await staged.length(), 0);
      }
      for (final limited in [
        GalleryPngRotation(maxSourceBytes: clean.length - 1),
        GalleryPngRotation(maxSourcePixels: 4),
        GalleryPngRotation(maxMetadataBytes: 32),
      ]) {
        final bytes = _insert(clean, before: [_chunk('eXIf', _exif(1))]);
        await source.writeAsBytes(bytes);
        try {
          await expectLater(
            limited.rotate(
              source: source,
              staged: staged,
              rotation: GalleryRotation.left,
            ),
            _fails(GalleryErrorCode.unsupported),
          );
        } finally {
          await limited.close();
        }
        expect(await staged.length(), 0);
      }
      expect((await root.list().toList()).length, 2);
    },
  );

  test('consumer cancellation after worker startup waits for exit and leaves no late writer', () async {
    await source.writeAsBytes(image.encodePng(_pixels(128, 128, 4)));
    final cancel = Completer<void>();
    var ready = false;
    final previous = Logger.root.level;
    Logger.root.level = Level.ALL;
    final observer = Logger.root.onRecord.listen((record) {
      if (record.loggerName == 'GalleryPngRotation' &&
          record.message == 'PNG worker ready') {
        ready = true;
        if (!cancel.isCompleted) cancel.complete();
      }
    });
    try {
      await expectLater(
        rotation.rotate(
          source: source,
          staged: staged,
          rotation: GalleryRotation.right,
          cancellation: cancel.future,
        ),
        _fails(GalleryErrorCode.cancelled),
      );
      expect(ready, isTrue);
      await staged.writeAsBytes([99]);
      await rotation.close().timeout(const Duration(seconds: 2));
      expect(await staged.readAsBytes(), [99]);
    } finally {
      await observer.cancel();
      Logger.root.level = previous;
    }
  });

  test('close after worker startup cancels its job; timeout and pre-cancel stay typed', () async {
    await source.writeAsBytes(image.encodePng(_pixels(128, 128, 4)));
    Future<void>? closing;
    final previous = Logger.root.level;
    Logger.root.level = Level.ALL;
    final observer = Logger.root.onRecord.listen((record) {
      if (record.loggerName == 'GalleryPngRotation' &&
          record.message == 'PNG worker ready') {
        closing ??= rotation.close();
      }
    });
    try {
      await expectLater(
        rotation.rotate(
          source: source,
          staged: staged,
          rotation: GalleryRotation.left,
        ),
        _fails(GalleryErrorCode.cancelled),
      );
      expect(closing, isNotNull);
      await closing!.timeout(const Duration(seconds: 2));
      await expectLater(
        rotation.rotate(
          source: source,
          staged: staged,
          rotation: GalleryRotation.left,
        ),
        _fails(GalleryErrorCode.unavailable),
      );
    } finally {
      await observer.cancel();
      Logger.root.level = previous;
    }
    final timed = GalleryPngRotation(timeout: const Duration(microseconds: 1));
    try {
      await expectLater(
        timed.rotate(
          source: source,
          staged: staged,
          rotation: GalleryRotation.left,
        ),
        _fails(GalleryErrorCode.timeout),
      );
    } finally {
      await timed.close();
    }
    final cancelled = GalleryPngRotation();
    try {
      await expectLater(
        cancelled.rotate(
          source: source,
          staged: staged,
          rotation: GalleryRotation.right,
          cancellation: Future.value(),
        ),
        _fails(GalleryErrorCode.cancelled),
      );
    } finally {
      await cancelled.close();
    }
    expect(await staged.length(), 0);
  });
}

image.Image _pixels(int width, int height, int channels) {
  final result = image.Image(
    width: width,
    height: height,
    format: image.Format.uint16,
    numChannels: channels,
  );
  for (final pixel in result) {
    pixel.setRgba(
      1000 + pixel.x * 111 + pixel.y * 17,
      20000 + pixel.y * 97 + pixel.x * 3,
      60000 - pixel.x * 37 - pixel.y * 31,
      30000 + pixel.x * 41 + pixel.y * 53,
    );
  }
  return result;
}

// Independent coordinate oracle: no production bakeOrientation/copyRotate calls.
void _expectDisplaySamples(
  image.Image actual,
  image.Image raw,
  int orientation,
  GalleryRotation rotation,
) {
  final width = orientation >= 5 ? raw.height : raw.width;
  final height = orientation >= 5 ? raw.width : raw.height;
  expect([actual.width, actual.height], [height, width]);
  for (var y = 0; y < actual.height; y++) {
    for (var x = 0; x < actual.width; x++) {
      final (u, v) = rotation == GalleryRotation.right
          ? (y, height - 1 - x)
          : (width - 1 - y, x);
      final (sx, sy) = switch (orientation) {
        1 => (u, v),
        2 => (raw.width - 1 - u, v),
        3 => (raw.width - 1 - u, raw.height - 1 - v),
        4 => (u, raw.height - 1 - v),
        5 => (v, u),
        6 => (v, raw.height - 1 - u),
        7 => (raw.width - 1 - v, raw.height - 1 - u),
        _ => (raw.width - 1 - v, u),
      };
      final expected = raw.getPixel(sx, sy), found = actual.getPixel(x, y);
      expect(
        [found.r, found.g, found.b, found.a],
        [expected.r, expected.g, expected.b, expected.a],
        reason:
            'orientation=$orientation direction=${rotation.name} pixel=($x,$y)',
      );
    }
  }
}

Uint8List _exif(int orientation) {
  final tags = image.ExifData();
  tags.imageIfd
    ..orientation = orientation
    ..make = 'Fixture camera';
  tags.imageIfd[0x0100] = image.IfdValueLong(999);
  tags.imageIfd[0x0101] = image.IfdValueLong(888);
  tags.exifIfd['DateTimeOriginal'] = '2024:03:04 05:06:07';
  final gps = Uint8List(24);
  final data = ByteData.sublistView(gps);
  for (var i = 0; i < 3; i++) {
    data
      ..setUint32(i * 8, [12, 34, 56][i])
      ..setUint32(i * 8 + 4, 1);
  }
  tags.gpsIfd[1] = image.IfdValueAscii('N');
  tags.gpsIfd[2] = image.IfdValueRational.data(
    image.InputBuffer(gps, bigEndian: true),
    3,
  );
  tags.thumbnailIfd[0x0100] = image.IfdValueLong(20);
  tags.thumbnailData = Uint8List.fromList([255, 216, 255, 217]);
  final out = image.OutputBuffer();
  tags.write(out);
  return out.getBytes();
}

image.ExifData _readExif(Uint8List bytes) => image.ExifData.fromInputBuffer(
  image.InputBuffer(
    _chunks(bytes).singleWhere((chunk) => chunk.type == 'eXIf').data,
  ),
);

Uint8List _profile() {
  final result = Uint8List(128);
  ByteData.sublistView(result)
    ..setUint32(0, 128)
    ..setUint32(8, 0x02100000);
  result.setRange(12, 16, ascii.encode('mntr'));
  result.setRange(16, 20, ascii.encode('RGB '));
  result.setRange(20, 24, ascii.encode('XYZ '));
  result.setRange(36, 40, ascii.encode('acsp'));
  return result;
}

Uint8List _insert(
  Uint8List bytes, {
  List<Uint8List> before = const [],
  List<Uint8List> after = const [],
}) {
  final chunks = _chunks(bytes);
  return Uint8List.fromList([
    ...bytes.sublist(0, 8),
    ...chunks.first.bytes,
    for (final chunk in before) ...chunk,
    for (final chunk in chunks.skip(1).take(chunks.length - 2)) ...chunk.bytes,
    for (final chunk in after) ...chunk,
    ...chunks.last.bytes,
  ]);
}

List<_Chunk> _chunks(Uint8List bytes) {
  final chunks = <_Chunk>[];
  for (var offset = 8; offset < bytes.length;) {
    final length = ByteData.sublistView(bytes, offset, offset + 4).getUint32(0);
    chunks.add((
      type: ascii.decode(bytes.sublist(offset + 4, offset + 8)),
      bytes: Uint8List.sublistView(bytes, offset, offset + 12 + length),
      data: Uint8List.sublistView(bytes, offset + 8, offset + 8 + length),
    ));
    offset += 12 + length;
  }
  return chunks;
}

Uint8List _chunk(String type, List<int> data) {
  final result = Uint8List(data.length + 12);
  ByteData.sublistView(result).setUint32(0, data.length);
  result.setRange(4, 8, ascii.encode(type));
  result.setRange(8, 8 + data.length, data);
  var crc = 0xffffffff;
  for (final byte in result.sublist(4, result.length - 4)) {
    crc ^= byte;
    for (var bit = 0; bit < 8; bit++) {
      crc = crc & 1 == 1 ? crc >> 1 ^ 0xedb88320 : crc >> 1;
    }
  }
  ByteData.sublistView(result).setUint32(result.length - 4, crc ^ 0xffffffff);
  return result;
}
