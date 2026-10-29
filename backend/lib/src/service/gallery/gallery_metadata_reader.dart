// Synchronous random-access metadata parsing runs only in a bounded worker.
// ignore_for_file: avoid_slow_async_io, implementation_imports
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:exif/exif.dart' as exif;
import 'package:exif/src/file_interface.dart' as exif_io;
import 'package:exif/src/read_exif.dart' as exif_reader;
import 'package:logging/logging.dart';

import 'gallery_catalog_service.dart';
import 'gallery_tool_runner.dart';

enum _ImageContainer { jpeg, png, webp, gif, tiff, heic, avif, unknown }

/// Reads still-image metadata in Dart; only video probing uses a child process.
/// The owner still validates catalog revisions before and after a read.
class GalleryMetadataReader {
  static final _log = Logger('GalleryMetadataReader');
  final GalleryToolRunner _runner;
  final bool _ownsRunner;
  final int maxReadBytes;
  final int maxTags;
  final Duration timeout;
  final void Function()? checkActive;
  final Completer<void> _cancel = Completer<void>();
  final Set<Future<void>> _active = {};
  bool _closed = false;
  Future<void>? _closing;

  GalleryMetadataReader({
    GalleryToolRunner? runner,
    Future<void>? cancellation,
    this.maxReadBytes = 16 * 1024 * 1024,
    this.maxTags = 1024,
    this.timeout = const Duration(seconds: 30),
    this.checkActive,
  }) : _runner = runner ?? ProcessGalleryToolRunner(),
       _ownsRunner = runner == null {
    if (maxReadBytes < 1 || maxTags < 1 || timeout <= Duration.zero) {
      throw ArgumentError('Invalid metadata reader limits');
    }
    final signal = _cancel;
    cancellation?.then((_) {
      if (!signal.isCompleted) signal.complete();
    });
  }

  void _check() {
    if (_closed || _cancel.isCompleted) {
      throw const GalleryCatalogFailure(GalleryErrorCode.cancelled);
    }
    checkActive?.call();
  }

  Future<T> _track<T>(Future<T> Function() work) async {
    _check();
    final done = Completer<void>();
    _active.add(done.future);
    try {
      final value = await work();
      _check();
      return value;
    } on FileSystemException catch (error) {
      throw GalleryCatalogFailure(switch (error.osError?.errorCode) {
        2 => GalleryErrorCode.notFound,
        13 => GalleryErrorCode.forbidden,
        _ => GalleryErrorCode.unavailable,
      });
    } finally {
      _active.remove(done.future);
      done.complete();
    }
  }

  Future<GalleryMetadata> read(GallerySource source, {String? input}) =>
      _track(() async {
        final filePath = input ?? source.absolutePath;
        if (source.entry.kind == GalleryEntryKind.video)
          return _video(source, filePath);
        final bytes = maxReadBytes, tags = maxTags, deadline = timeout;
        // Capture values, never this reader/runner/cancellation ports, in the worker.
        return _readInWorker(source, filePath, bytes, tags, deadline);
      });

  Future<String?> profileDigest(File file) => _track(() async {
    final name = file.path, bytes = maxReadBytes, deadline = timeout;
    return _profileInWorker(name, bytes, deadline);
  });

  Future<String?> exifDigest(File file) => _track(() async {
    final name = file.path,
        bytes = maxReadBytes,
        tags = maxTags,
        deadline = timeout;
    return _exifInWorker(name, bytes, tags, deadline);
  });

  Future<GalleryMetadata> _video(GallerySource source, String filePath) async {
    final stat = await File(filePath).stat();
    final result = await _runner.run(
      'ffprobe',
      [
        '-v',
        'error',
        '-select_streams',
        'v:0',
        '-show_entries',
        'stream=width,height,codec_name,bits_per_raw_sample:format=format_name,duration:format_tags=creation_time',
        '-of',
        'json',
        '--',
        filePath,
      ],
      timeout: timeout,
      cancellation: _cancel.future,
      maxOutputBytes: 1024 * 1024,
    );
    if (result.exitCode != 0) _failed();
    try {
      final decoded = jsonDecode(result.stdout) as Map<String, dynamic>;
      final streams = decoded['streams'] as List;
      final stream = streams.isEmpty
          ? <String, dynamic>{}
          : streams.first as Map<String, dynamic>;
      final format = decoded['format'] as Map<String, dynamic>? ?? const {};
      final tags = format['tags'] as Map<String, dynamic>? ?? const {};
      final duration = double.tryParse('${format['duration']}');
      final depth = int.tryParse('${stream['bits_per_raw_sample']}');
      return GalleryMetadata(
        mediaId: source.entry.mediaId,
        sourceRevision: source.entry.sourceRevision!,
        name: source.entry.name,
        path: source.entry.path,
        kind: source.entry.kind,
        sizeBytes: stat.size,
        fileModified: stat.modified.toUtc(),
        width: (stream['width'] as num?)?.toInt(),
        height: (stream['height'] as num?)?.toInt(),
        format: format['format_name'] as String?,
        codec: stream['codec_name'] as String?,
        dateTaken: tags['creation_time'] as String?,
        durationSeconds: duration != null && duration.isFinite && duration >= 0
            ? duration
            : null,
        bitDepth: depth != null && depth > 0 ? depth : null,
      );
    } on GalleryCatalogFailure {
      rethrow;
    } on Object {
      _failed();
    }
  }

  Future<void> close() => _closing ??= _close();
  Future<void> _close() async {
    _closed = true;
    if (!_cancel.isCompleted) _cancel.complete();
    if (_ownsRunner) await _runner.close();
    await Future.wait(_active.toList());
    _log.fine('Metadata reader closed active=0');
  }
}

typedef _Container = ({
  _ImageContainer kind,
  int? width,
  int? height,
  int? depth,
  bool? alpha,
  Uint8List? exifBytes,
  Uint8List? profile,
});

// Top-level launchers prevent Dart closure-context sharing from capturing the
// calling service's cancellation completers or an injected process runner.
Future<GalleryMetadata> _readInWorker(
  GallerySource source,
  String name,
  int bytes,
  int tags,
  Duration timeout,
) => Isolate.run(() => _readStill(source, name, bytes, tags, timeout));

Future<String?> _profileInWorker(String name, int bytes, Duration timeout) =>
    Isolate.run(() {
      final reader = _MetadataFile(name, bytes, timeout);
      try {
        final data = _container(reader);
        return data.profile == null
            ? null
            : sha256.convert(data.profile!).toString();
      } finally {
        reader.close();
      }
    });

Future<String?> _exifInWorker(
  String name,
  int limit,
  int maxTags,
  Duration timeout,
) => Isolate.run(() {
  final reader = _MetadataFile(name, limit, timeout);
  try {
    final tags = _readExifTags(
      reader,
      _container(reader),
      limit,
      maxTags,
      timeout,
    );
    if (tags.isEmpty) return null;
    final names = tags.keys.toList()..sort();
    final normalized = {
      for (final name in names)
        name: [
          tags[name]!.tagType,
          for (final value in tags[name]!.values.toList())
            value is exif.Ratio
                ? [value.numerator, value.denominator]
                : value is num && !value.isFinite
                ? value.toString()
                : value,
        ],
    };
    reader.check();
    final digest = sha256
        .convert(utf8.encode(jsonEncode(normalized)))
        .toString();
    reader.check();
    return digest;
  } finally {
    reader.close();
  }
});

Map<String, exif.IfdTag> _readExifTags(
  _MetadataFile reader,
  _Container container,
  int limit,
  int maxTags,
  Duration timeout,
) {
  Map<String, exif.IfdTag> tags = const {};
  if (container.exifBytes != null) {
    // We own every descriptor; the package's public File API lacks finally.
    final memory = _MetadataBytes(
      container.exifBytes!,
      limit,
      reader.clock,
      timeout,
    );
    tags = exif_reader.readExifFromFileReader(memory, details: false).tags;
  } else if (container.kind == _ImageContainer.tiff ||
      container.kind == _ImageContainer.heic ||
      container.kind == _ImageContainer.avif) {
    reader.setPositionSync(0);
    tags = exif_reader.readExifFromFileReader(reader, details: false).tags;
  }
  if (tags.length > maxTags) _limit();
  return tags;
}

GalleryMetadata _readStill(
  GallerySource source,
  String filePath,
  int limit,
  int maxTags,
  Duration timeout,
) {
  final reader = _MetadataFile(filePath, limit, timeout);
  try {
    final stat = File(filePath).statSync();
    final container = _container(reader);
    final tags = _readExifTags(reader, container, limit, maxTags, timeout);
    final values = _ExifValues(tags);
    final date = values.text('DateTimeOriginal');
    final offset = values.text('OffsetTimeOriginal');
    final profile = container.profile;
    final width =
        container.width ??
        (container.kind == _ImageContainer.tiff
            ? values.integer('ImageWidth')
            : null);
    final height =
        container.height ??
        (container.kind == _ImageContainer.tiff
            ? values.integer('ImageLength')
            : null);
    reader.check();
    return GalleryMetadata(
      mediaId: source.entry.mediaId,
      sourceRevision: source.entry.sourceRevision!,
      name: source.entry.name,
      path: source.entry.path,
      kind: source.entry.kind,
      sizeBytes: stat.size,
      fileModified: stat.modified.toUtc(),
      width: width,
      height: height,
      format: switch (container.kind) {
        _ImageContainer.jpeg => 'JPEG',
        _ImageContainer.png => 'PNG',
        _ImageContainer.webp => 'WEBP',
        _ImageContainer.gif => 'GIF',
        _ImageContainer.tiff => 'TIFF',
        _ImageContainer.heic => 'HEIC',
        _ImageContainer.avif => 'AVIF',
        _ImageContainer.unknown => null,
      },
      dateTaken: date == null
          ? null
          : _ExifValues.dateOffset.hasMatch(date)
          ? date
          : '$date${offset ?? ''}',
      camera: [
        values.text('Make'),
        values.text('Model'),
      ].whereType<String>().join(' ')._nonEmpty,
      lens: values.text('LensModel'),
      iso: values.scalar('ISOSpeedRatings') ?? values.scalar('ISOSpeed'),
      exposure: values.text('ExposureTime'),
      aperture: values.scalar('FNumber'),
      focalLength: values.scalar('FocalLength'),
      orientation: values.integer('Orientation'),
      latitude: values.coordinate('GPSLatitude', 'GPSLatitudeRef'),
      longitude: values.coordinate('GPSLongitude', 'GPSLongitudeRef'),
      colorProfile: profile == null ? null : _profileDescription(profile),
      bitDepth: container.depth ?? values.integer('BitsPerSample'),
      hasAlpha: container.alpha,
    );
  } on GalleryCatalogFailure {
    rethrow;
  } on FileSystemException {
    rethrow;
  } on Object {
    _failed();
  } finally {
    reader.close();
  }
}

class _MetadataFile implements exif_io.FileReader {
  final RandomAccessFile _file;
  final int limit;
  final Duration timeout;
  final Stopwatch clock = Stopwatch()..start();
  final int length;
  int _read = 0;
  factory _MetadataFile(String name, int limit, Duration timeout) {
    final handle = File(name).openSync();
    try {
      return _MetadataFile._(handle, limit, timeout, handle.lengthSync());
    } on Object {
      handle.closeSync();
      rethrow;
    }
  }
  _MetadataFile._(this._file, this.limit, this.timeout, this.length);
  void check() {
    if (clock.elapsed > timeout)
      throw const GalleryCatalogFailure(GalleryErrorCode.timeout);
  }

  @override
  int positionSync() {
    check();
    return _file.positionSync();
  }

  @override
  void setPositionSync(int position) {
    check();
    if (position < 0 || position > length) _failed();
    _file.setPositionSync(position);
  }

  @override
  List<int> readSync(int count) {
    check();
    if (count < 0 || count > limit - _read) _limit();
    final bytes = _file.readSync(count);
    _read += bytes.length;
    return bytes;
  }

  @override
  int readByteSync() {
    final data = readSync(1);
    return data.isEmpty ? -1 : data.first;
  }

  List<int> exact(int count) {
    final value = readSync(count);
    if (value.length != count) _failed();
    return value;
  }

  void close() => _file.closeSync();
}

class _MetadataBytes implements exif_io.FileReader {
  final Uint8List bytes;
  final int limit;
  final Stopwatch clock;
  final Duration timeout;
  int _position = 0, _read = 0;
  _MetadataBytes(this.bytes, this.limit, this.clock, this.timeout);
  void _check() {
    if (clock.elapsed > timeout)
      throw const GalleryCatalogFailure(GalleryErrorCode.timeout);
  }

  @override
  int positionSync() {
    _check();
    return _position;
  }

  @override
  void setPositionSync(int position) {
    _check();
    if (position < 0 || position > bytes.length) _failed();
    _position = position;
  }

  @override
  List<int> readSync(int count) {
    _check();
    if (count < 0 || count > limit - _read) _limit();
    final end = min(_position + count, bytes.length);
    final value = Uint8List.sublistView(bytes, _position, end);
    _position = end;
    _read += value.length;
    return value;
  }

  @override
  int readByteSync() {
    final data = readSync(1);
    return data.isEmpty ? -1 : data.first;
  }
}

_Container _container(_MetadataFile f) {
  f.setPositionSync(0);
  final header = f.readSync(16);
  f.setPositionSync(0);
  if (header.length >= 2 && header[0] == 0xff && header[1] == 0xd8)
    return _jpeg(f);
  if (_starts(header, [137, 80, 78, 71, 13, 10, 26, 10])) return _png(f);
  if (_ascii(header, 0, 4) == 'RIFF' && _ascii(header, 8, 12) == 'WEBP')
    return _webp(f);
  if (_ascii(header, 0, 3) == 'GIF' && header.length >= 10)
    return _base(
      _ImageContainer.gif,
      width: _u16(header, 6, Endian.little),
      height: _u16(header, 8, Endian.little),
      depth: 8,
    );
  if (_starts(header, [73, 73, 42, 0]) || _starts(header, [77, 77, 0, 42]))
    return _base(_ImageContainer.tiff);
  if (_ascii(header, 4, 8) == 'ftyp') {
    return _base(
      _ascii(header, 8, 12) == 'avif'
          ? _ImageContainer.avif
          : _ImageContainer.heic,
    );
  }
  return _base(_ImageContainer.unknown);
}

_Container _base(
  _ImageContainer kind, {
  int? width,
  int? height,
  int? depth,
  bool? alpha,
  Uint8List? exifBytes,
  Uint8List? profile,
}) => (
  kind: kind,
  width: width,
  height: height,
  depth: depth,
  alpha: alpha,
  exifBytes: exifBytes,
  profile: profile,
);

_Container _jpeg(_MetadataFile f) {
  f.setPositionSync(2);
  int? width, height, depth;
  Uint8List? tags;
  final profile = <int, List<int>>{};
  int? profileCount;
  for (var chunk = 0; chunk < 100000; chunk++) {
    if (f.readByteSync() != 0xff) _failed();
    var marker = f.readByteSync();
    while (marker == 0xff) {
      marker = f.readByteSync();
    }
    if (marker == 0xda || marker == 0xd9) {
      if (width == null || width <= 0 || height == null || height <= 0)
        _failed();
      Uint8List? icc;
      if (profileCount != null) {
        final bytes = BytesBuilder(copy: false);
        for (var i = 1; i <= profileCount; i++) {
          if (profile[i] == null) _failed();
          bytes.add(profile[i]!);
        }
        if (bytes.length > f.limit) _limit();
        icc = bytes.takeBytes();
      }
      return _base(
        _ImageContainer.jpeg,
        width: width,
        height: height,
        depth: depth,
        alpha: false,
        exifBytes: tags,
        profile: icc,
      );
    }
    if (marker <= 0 || marker == 0xd8 || marker >= 0xd0 && marker <= 0xd7)
      _failed();
    final size = _u16(f.exact(2), 0);
    final start = f.positionSync();
    if (size < 2 || start + size - 2 > f.length) _failed();
    if (marker >= 0xc0 &&
        marker <= 0xcf &&
        marker != 0xc4 &&
        marker != 0xc8 &&
        marker != 0xcc) {
      final info = f.exact(6);
      depth = info[0];
      height = _u16(info, 1);
      width = _u16(info, 3);
    } else if (marker == 0xe1 && size >= 8) {
      final prefix = f.exact(6);
      if (_starts(prefix, [69, 120, 105, 102, 0, 0]))
        tags = Uint8List.fromList(f.exact(size - 8));
    } else if (marker == 0xe2 && size >= 16) {
      final prefix = f.exact(14);
      if (_ascii(prefix, 0, 12) == 'ICC_PROFILE\u0000') {
        final count = prefix[13], index = prefix[12];
        if (index < 1 ||
            count < index ||
            profileCount != null && profileCount != count ||
            profile.containsKey(index))
          _failed();
        profileCount = count;
        profile[index] = f.exact(size - 16);
      }
    }
    f.setPositionSync(start + size - 2);
  }
  _limit();
}

_Container _png(_MetadataFile f) {
  f.setPositionSync(8);
  int? width, height, depth;
  bool? alpha;
  Uint8List? tags, profile;
  for (var count = 0; count < 100000; count++) {
    final header = f.exact(8);
    final length = _u32(header, 0), start = f.positionSync();
    if (length > 0x7fffffff || start + length + 4 > f.length) _failed();
    switch (_ascii(header, 4, 8)) {
      case 'IHDR':
        if (width != null || length != 13) _failed();
        final info = f.exact(13);
        width = _u32(info, 0);
        height = _u32(info, 4);
        depth = info[8];
        alpha = info[9] == 4 || info[9] == 6;
      case 'eXIf':
        tags = Uint8List.fromList(f.exact(length));
      case 'iCCP':
        final data = f.exact(length);
        final separator = data.indexOf(0);
        if (separator < 1 ||
            separator + 2 > data.length ||
            data[separator + 1] != 0)
          _failed();
        profile = _inflate(data.sublist(separator + 2), f.limit);
      case 'tRNS':
        alpha = true;
      case 'IEND':
        if (length != 0 ||
            width == null ||
            width <= 0 ||
            height == null ||
            height <= 0)
          _failed();
        return _base(
          _ImageContainer.png,
          width: width,
          height: height,
          depth: depth,
          alpha: alpha,
          exifBytes: tags,
          profile: profile,
        );
    }
    f.setPositionSync(start + length + 4);
  }
  _limit();
}

_Container _webp(_MetadataFile f) {
  f.setPositionSync(12);
  int? width, height;
  bool? alpha;
  Uint8List? tags, profile;
  for (var count = 0; count < 100000 && f.positionSync() < f.length; count++) {
    final chunk = f.exact(8);
    final length = _u32(chunk, 4, Endian.little), start = f.positionSync();
    if (start + length + (length & 1) > f.length) _failed();
    switch (_ascii(chunk, 0, 4)) {
      case 'VP8X':
        if (length < 10) _failed();
        final info = f.exact(10);
        width = 1 + _u24(info, 4);
        height = 1 + _u24(info, 7);
        alpha = (info[0] & 0x10) != 0;
      case 'VP8 ':
        if (length < 10) _failed();
        final info = f.exact(10);
        if (!_starts(info.sublist(3), [157, 1, 42])) _failed();
        width ??= _u16(info, 6, Endian.little) & 0x3fff;
        height ??= _u16(info, 8, Endian.little) & 0x3fff;
        alpha ??= false;
      case 'VP8L':
        if (length < 5) _failed();
        final info = f.exact(5);
        if (info[0] != 0x2f) _failed();
        width ??= 1 + info[1] + ((info[2] & 0x3f) << 8);
        height ??= 1 + (info[2] >> 6) + (info[3] << 2) + ((info[4] & 15) << 10);
        alpha ??= (info[4] & 16) != 0;
      case 'EXIF':
        final data = f.exact(length);
        tags = Uint8List.fromList(
          _starts(data, [69, 120, 105, 102, 0, 0]) ? data.sublist(6) : data,
        );
      case 'ICCP':
        profile = Uint8List.fromList(f.exact(length));
    }
    f.setPositionSync(start + length + (length & 1));
  }
  if (width == null || height == null || width <= 0 || height <= 0) _failed();
  return _base(
    _ImageContainer.webp,
    width: width,
    height: height,
    depth: 8,
    alpha: alpha,
    exifBytes: tags,
    profile: profile,
  );
}

class _BoundedSink extends ByteConversionSinkBase {
  final int limit;
  final BytesBuilder data = BytesBuilder(copy: false);
  _BoundedSink(this.limit);
  @override
  void add(List<int> chunk) {
    if (data.length + chunk.length > limit) _limit();
    data.add(chunk);
  }

  @override
  void close() {}
}

Uint8List _inflate(List<int> compressed, int limit) {
  final target = _BoundedSink(limit);
  final sink = ZLibDecoder().startChunkedConversion(target);
  for (var start = 0; start < compressed.length; start += 4096) {
    sink.add(compressed.sublist(start, min(start + 4096, compressed.length)));
  }
  sink.close();
  return target.data.takeBytes();
}

String? _profileDescription(Uint8List bytes) {
  if (bytes.length < 132) return null;
  final count = _u32(bytes, 128);
  if (count > 1024 || 132 + count * 12 > bytes.length) return null;
  for (var index = 0; index < count; index++) {
    final entry = 132 + index * 12;
    if (_ascii(bytes, entry, entry + 4) != 'desc') continue;
    final offset = _u32(bytes, entry + 4), length = _u32(bytes, entry + 8);
    if (offset + length > bytes.length || length < 12) return null;
    if (_ascii(bytes, offset, offset + 4) == 'desc') {
      final size = _u32(bytes, offset + 8);
      if (size == 0 || size > length - 12) return null;
      return latin1
          .decode(bytes.sublist(offset + 12, offset + 12 + size))
          .replaceAll('\u0000', '')
          ._nonEmpty;
    }
    if (_ascii(bytes, offset, offset + 4) == 'mluc' && length >= 28) {
      final size = _u32(bytes, offset + 20),
          textOffset = _u32(bytes, offset + 24);
      if (size.isOdd || textOffset + size > length) return null;
      return String.fromCharCodes([
        for (var i = 0; i < size; i += 2) _u16(bytes, offset + textOffset + i),
      ])._nonEmpty;
    }
  }
  return null;
}

class _ExifValues {
  static final dateOffset = RegExp(r'(?:Z|[+-]\d{2}:?\d{2})$');
  final Map<String, exif.IfdTag> tags;
  _ExifValues(this.tags);
  exif.IfdTag? _tag(String name) {
    for (final group in ['EXIF', 'Image', 'GPS']) {
      final tag = tags['$group $name'];
      if (tag != null) return tag;
    }
    return null;
  }

  String? text(String name) => _tag(name)?.printable._nonEmpty;
  int? integer(String name) {
    final values = _tag(name)?.values;
    return values == null || values.length == 0 ? null : values.firstAsInt();
  }

  String? scalar(String name) {
    final values = _tag(name)?.values.toList();
    if (values == null || values.isEmpty) return null;
    final first = values.first;
    if (first is exif.Ratio) {
      final number = first.toDouble();
      return number.isFinite ? number.toString() : null;
    }
    return first.toString();
  }

  double? coordinate(String name, String ref) {
    final values = _tag(name)?.values.toList();
    if (values == null || values.length != 3) return null;
    final parts = values
        .map(
          (v) => v is exif.Ratio
              ? v.toDouble()
              : v is num
              ? v.toDouble()
              : double.nan,
        )
        .toList();
    if (parts.any((v) => !v.isFinite)) return null;
    var value = parts[0] + parts[1] / 60 + parts[2] / 3600;
    // Use the original ASCII hemisphere rather than formatted tag labels.
    final references = _tag(ref)?.values.toList();
    final reference = references != null && references.isNotEmpty
        ? references.first
        : null;
    if (reference == 83 || reference == 87) value = -value.abs();
    return value;
  }
}

bool _starts(List<int> bytes, List<int> prefix) {
  if (bytes.length < prefix.length) return false;
  for (var i = 0; i < prefix.length; i++) {
    if (bytes[i] != prefix[i]) return false;
  }
  return true;
}

String _ascii(List<int> bytes, int start, int end) =>
    bytes.length < end ? '' : String.fromCharCodes(bytes.sublist(start, end));
int _u16(List<int> b, int offset, [Endian endian = Endian.big]) =>
    endian == Endian.big
    ? b[offset] * 256 + b[offset + 1]
    : b[offset] + b[offset + 1] * 256;
int _u24(List<int> b, int offset) =>
    b[offset] + b[offset + 1] * 256 + b[offset + 2] * 65536;
int _u32(List<int> b, int offset, [Endian endian = Endian.big]) =>
    endian == Endian.big
    ? b[offset] * 0x1000000 +
          b[offset + 1] * 0x10000 +
          b[offset + 2] * 256 +
          b[offset + 3]
    : b[offset] +
          b[offset + 1] * 256 +
          b[offset + 2] * 0x10000 +
          b[offset + 3] * 0x1000000;
Never _failed() =>
    throw const GalleryCatalogFailure(GalleryErrorCode.processingFailed);
Never _limit() =>
    throw const GalleryCatalogFailure(GalleryErrorCode.outputLimitExceeded);

extension on String {
  String? get _nonEmpty => isEmpty ? null : this;
}
