// PNG CPU work runs in a disposable isolate; IO owners close before completion.
// ignore_for_file: avoid_slow_async_io
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'dart:typed_data';

import 'package:dslideshow_common/gallery.dart';
import 'package:image/image.dart' as image;
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;

import 'gallery_catalog_service.dart';

typedef _WorkerInput = ({
  SendPort reply,
  TransferableTypedData bytes,
  GalleryRotation rotation,
  int maxSourceBytes,
  int maxSourcePixels,
  int maxMetadataBytes,
});

enum _WorkerSignal { ready }

/// Rotates a PNG into an existing private staging file without external tools.
/// The caller owns staging cleanup and publication; completion awaits all IO
/// and worker termination, including cancellation and timeout.
class GalleryPngRotation {
  static final _log = Logger('GalleryPngRotation');
  final int maxSourceBytes;
  final int maxSourcePixels;
  final int maxMetadataBytes;
  final Duration timeout;
  final Set<_PngJob> _active = {};
  bool _closed = false;
  Future<void>? _closing;

  GalleryPngRotation({
    this.maxSourceBytes = 200 * 1024 * 1024,
    this.maxSourcePixels = 64 * 1024 * 1024,
    this.maxMetadataBytes = 4 * 1024 * 1024,
    this.timeout = const Duration(seconds: 60),
  }) {
    if (maxSourceBytes < 1 || maxSourcePixels < 1 || maxMetadataBytes < 1 || timeout <= Duration.zero) {
      throw ArgumentError('Invalid PNG rotation limits');
    }
  }

  Future<void> rotate({
    required File source,
    required File staged,
    required GalleryRotation rotation,
    Future<void>? cancellation,
  }) async {
    if (_closed) throw const GalleryCatalogFailure(GalleryErrorCode.unavailable);
    if (_active.isNotEmpty) throw const GalleryCatalogFailure(GalleryErrorCode.busy);
    final job = _PngJob(this);
    _active.add(job);
    _log.fine(
      'PNG rotation started direction=${rotation.name} '
      'maxSourceBytes=$maxSourceBytes maxSourcePixels=$maxSourcePixels '
      'maxMetadataBytes=$maxMetadataBytes timeoutMs=${timeout.inMilliseconds}',
    );
    try {
      await job.run(source, staged, rotation, cancellation);
      _log.fine('PNG rotation completed direction=${rotation.name} ');
    } on GalleryCatalogFailure catch (error) {
      _log.log(
        error.code == GalleryErrorCode.cancelled ? Level.FINE : Level.WARNING,
        'PNG rotation stopped direction=${rotation.name} code=${error.code.name} ',
      );
      rethrow;
    } on Object {
      _log.warning(
        'PNG rotation stopped direction=${rotation.name} '
        'code=processingFailed',
      );
      throw const GalleryCatalogFailure(GalleryErrorCode.processingFailed);
    } finally {
      _active.remove(job);
      job.finished.complete();
    }
  }

  Future<void> close() => _closing ??= () async {
    _closed = true;
    final jobs = _active.toList();
    for (final job in jobs) {
      job.stop(GalleryErrorCode.cancelled);
    }
    await Future.wait(jobs.map((job) => job.finished.future));
  }();
}

class _PngCancellation {
  _PngJob? job;
  _PngCancellation(this.job);
  void stop() => job?.stop(GalleryErrorCode.cancelled);
}

class _PngJob {
  final GalleryPngRotation owner;
  final finished = Completer<void>();
  final _stopped = Completer<void>();
  GalleryErrorCode? _failure;
  Isolate? _worker;

  _PngJob(this.owner);

  void stop(GalleryErrorCode reason) {
    _failure ??= reason;
    if (!_stopped.isCompleted) _stopped.complete();
    _worker?.kill(priority: Isolate.immediate);
  }

  void _check() {
    if (_failure != null) throw GalleryCatalogFailure(_failure!);
  }

  Future<void> run(File source, File staged, GalleryRotation rotation, Future<void>? cancellation) async {
    final timer = Timer(owner.timeout, () => stop(GalleryErrorCode.timeout));
    final listener = _PngCancellation(this);
    cancellation?.then<void>((_) => listener.stop(), onError: (Object _) => listener.stop());
    final port = ReceivePort();
    final exited = Completer<void>();
    TransferableTypedData? rendered;
    GalleryErrorCode? resultError;
    final subscription = port.listen((Object? message) {
      if (message == null) {
        if (!exited.isCompleted) exited.complete();
      } else if (message == _WorkerSignal.ready) {
        GalleryPngRotation._log.fine('PNG worker ready');
      } else if (message is TransferableTypedData) {
        rendered = message;
      } else {
        resultError = message is GalleryErrorCode ? message : GalleryErrorCode.processingFailed;
      }
    });
    try {
      await Future<void>.value();
      _check();
      if (path.equals(source.absolute.path, staged.absolute.path) ||
          await FileSystemEntity.type(staged.path, followLinks: false) != FileSystemEntityType.file ||
          await source.resolveSymbolicLinks() == await staged.resolveSymbolicLinks()) {
        throw const GalleryCatalogFailure(GalleryErrorCode.invalidRequest);
      }
      final bytes = await _read(source);
      _check();
      _worker = await Isolate.spawn<_WorkerInput>(
        _pngWorker,
        (
          reply: port.sendPort,
          bytes: TransferableTypedData.fromList([bytes]),
          rotation: rotation,
          maxSourceBytes: owner.maxSourceBytes,
          maxSourcePixels: owner.maxSourcePixels,
          maxMetadataBytes: owner.maxMetadataBytes,
        ),
        onExit: port.sendPort,
        onError: port.sendPort,
        errorsAreFatal: true,
        paused: true,
        debugName: 'gallery-png-rotation',
      );
      if (_failure != null) {
        _worker!.kill(priority: Isolate.immediate);
      } else {
        _worker!.resume(_worker!.pauseCapability!);
      }
      await exited.future;
      _worker = null;
      _check();
      if (resultError != null) throw GalleryCatalogFailure(resultError!);
      final encoded = rendered;
      if (encoded == null) throw const GalleryCatalogFailure(GalleryErrorCode.processingFailed);
      final output = encoded.materialize().asUint8List();
      final file = await staged.open(mode: FileMode.write);
      try {
        for (var offset = 0; offset < output.length; offset += 64 * 1024) {
          _check();
          await file.writeFrom(output, offset, min(offset + 64 * 1024, output.length));
        }
        _check();
        await file.flush();
      } finally {
        await file.close();
      }
      _check();
    } on FileSystemException {
      _check();
      throw const GalleryCatalogFailure(GalleryErrorCode.unavailable);
    } finally {
      timer.cancel();
      listener.job = null;
      if (_worker != null) {
        _worker!.kill(priority: Isolate.immediate);
        await exited.future;
        _worker = null;
      }
      await subscription.cancel();
      port.close();
    }
  }

  Future<Uint8List> _read(File source) async {
    if (await source.length() > owner.maxSourceBytes) {
      throw const GalleryCatalogFailure(GalleryErrorCode.unsupported);
    }
    final input = StreamIterator(source.openRead());
    final bytes = BytesBuilder(copy: false);
    var count = 0;
    try {
      while (await Future.any<bool>([input.moveNext(), _stopped.future.then((_) => false)])) {
        _check();
        count += input.current.length;
        if (count > owner.maxSourceBytes) {
          throw const GalleryCatalogFailure(GalleryErrorCode.unsupported);
        }
        bytes.add(input.current);
      }
      _check();
      return bytes.takeBytes();
    } finally {
      await input.cancel();
    }
  }
}

void _pngWorker(_WorkerInput input) {
  input.reply.send(_WorkerSignal.ready);
  try {
    final bytes = _PngCodec.rotate(
      input.bytes.materialize().asUint8List(),
      input.rotation,
      input.maxSourceBytes,
      input.maxSourcePixels,
      input.maxMetadataBytes,
    );
    Isolate.exit(input.reply, TransferableTypedData.fromList([bytes]));
  } on GalleryCatalogFailure catch (error) {
    Isolate.exit(input.reply, error.code);
  } on Object {
    Isolate.exit(input.reply, GalleryErrorCode.processingFailed);
  }
}

typedef _PngScan = ({
  int width,
  int height,
  int depth,
  int colorType,
  Uint8List header,
  Uint8List end,
  Uint8List? exif,
  List<Uint8List> pixels,
  List<Uint8List> before,
  List<Uint8List> after,
});

enum _ChunkKind {
  header,
  pixels,
  end,
  exif,
  palette,
  color,
  density,
  background,
  histogram,
  suggestedPalette,
  metadata,
  forbidden,
  unknown,
}

class _PngCodec {
  static const _signature = [137, 80, 78, 71, 13, 10, 26, 10];
  static final _crcTable = List<int>.generate(256, (value) {
    var crc = value;
    for (var bit = 0; bit < 8; bit++) {
      crc = (crc & 1) == 0 ? crc >> 1 : 0xedb88320 ^ (crc >> 1);
    }
    return crc;
  }, growable: false);

  static Uint8List rotate(Uint8List bytes, GalleryRotation rotation, int maxBytes, int maxPixels, int maxMetadata) {
    final source = _scan(bytes, maxPixels, maxMetadata);
    var exif = image.ExifData();
    if (source.exif case final Uint8List payload) {
      if (payload.length < 8 ||
          !((payload[0] == 73 && payload[1] == 73 && payload[2] == 42 && payload[3] == 0) ||
              (payload[0] == 77 && payload[1] == 77 && payload[2] == 0 && payload[3] == 42)))
        _bad();
      exif = image.ExifData.fromInputBuffer(image.InputBuffer(payload));
      if (!exif.directories.containsKey('ifd0')) _bad();
    }
    final orientation = exif.imageIfd.orientation ?? 1;
    if (orientation < 1 || orientation > 8) _unsupported();
    // Ancillary payloads remain opaque and bounded. Decode only the pixel
    // stream so optional text/profile parsers cannot expand or reinterpret it.
    final pixelInput = BytesBuilder(copy: false)
      ..add(_signature)
      ..add(source.header);
    for (final chunk in source.pixels) {
      pixelInput.add(chunk);
    }
    pixelInput.add(source.end);
    var pixels = image.PngDecoder(maxPixels: maxPixels).decode(pixelInput.takeBytes());
    if (pixels == null) _bad();
    final channels = switch (source.colorType) {
      0 => 1,
      2 => 3,
      4 => 2,
      _ => 4,
    };
    if (pixels.bitsPerChannel != source.depth || pixels.numChannels != channels || pixels.hasPalette) _bad();
    pixels.exif = exif;
    if (orientation != 1) pixels = image.bakeOrientation(pixels);
    pixels = image.copyRotate(pixels, angle: rotation == GalleryRotation.right ? 90 : -90);
    exif = pixels.exif;
    exif.imageIfd.orientation = 1;
    exif.imageIfd[0x0100] = image.IfdValueLong(pixels.width);
    exif.imageIfd[0x0101] = image.IfdValueLong(pixels.height);
    exif.exifIfd[0xa002] = image.IfdValueLong(pixels.width);
    exif.exifIfd[0xa003] = image.IfdValueLong(pixels.height);
    exif.directories.remove('ifd1');
    exif.thumbnailData = null;
    final exifOutput = image.OutputBuffer();
    exif.write(exifOutput);
    final normalizedExif = _chunk('eXIf', exifOutput.getBytes());
    pixels.iccProfile = null;
    pixels.textData = null;
    final encoded = image.PngEncoder(level: 6).encode(pixels);
    final rendered = _scan(encoded, maxPixels, maxMetadata);
    if (rendered.depth != source.depth || rendered.colorType != source.colorType) _bad();
    final swapsAxes = orientation < 5;
    List<Uint8List> metadata(List<Uint8List> chunks) => chunks
        .map((chunk) {
          if (swapsAxes && ascii.decode(chunk.sublist(4, 8)) == 'pHYs') {
            final density = Uint8List.fromList(chunk.sublist(8, 17));
            final view = ByteData.sublistView(density);
            final x = view.getUint32(0), y = view.getUint32(4);
            view.setUint32(0, y);
            view.setUint32(4, x);
            return _chunk('pHYs', density);
          }
          return chunk;
        })
        .toList(growable: false);
    final before = metadata(source.before), after = metadata(source.after);
    final metadataSize =
        normalizedExif.length +
        before.fold<int>(0, (total, chunk) => total + chunk.length) +
        after.fold<int>(0, (total, chunk) => total + chunk.length);
    if (metadataSize > maxMetadata) _unsupported();
    final output = BytesBuilder(copy: false)
      ..add(_signature)
      ..add(rendered.header);
    for (final chunk in before) {
      output.add(chunk);
    }
    output.add(normalizedExif);
    for (final chunk in rendered.pixels) {
      output.add(chunk);
    }
    for (final chunk in after) {
      output.add(chunk);
    }
    output.add(rendered.end);
    if (output.length > maxBytes) _unsupported();
    return output.takeBytes();
  }

  static _PngScan _scan(Uint8List bytes, int maxPixels, int maxMetadata) {
    if (bytes.length < 33 || !List.generate(8, (i) => bytes[i] == _signature[i]).every((v) => v)) _bad();
    final before = <Uint8List>[], after = <Uint8List>[], pixels = <Uint8List>[];
    Uint8List? header, exif;
    var width = 0, height = 0, depth = 0, colorType = 0;
    var offset = 8, metadataBytes = 0;
    var seenPixels = false, pixelsEnded = false;
    var paletteEntries = 0, seenBackground = false;
    final singles = <String>{};
    final paletteNames = <String>{};
    for (var count = 0; count < 100000 && offset + 12 <= bytes.length; count++) {
      final size = ByteData.sublistView(bytes, offset, offset + 4).getUint32(0);
      if (size > 0x7fffffff || offset + size + 12 > bytes.length) _bad();
      final typeBytes = Uint8List.sublistView(bytes, offset + 4, offset + 8);
      if (typeBytes.any((b) => !(b >= 65 && b <= 90 || b >= 97 && b <= 122)) || typeBytes[2] & 0x20 != 0) _bad();
      final type = ascii.decode(typeBytes), kind = _kind(type);
      final end = offset + size + 12;
      final chunk = Uint8List.sublistView(bytes, offset, end);
      if (_crc(bytes, offset + 4, end - 4) != ByteData.sublistView(bytes, end - 4, end).getUint32(0)) _bad();
      if (header == null && kind != _ChunkKind.header) _bad();
      if (kind == _ChunkKind.header) {
        if (header != null || size != 13) _bad();
        header = chunk;
        final fields = ByteData.sublistView(chunk, 8, 21);
        width = fields.getUint32(0);
        height = fields.getUint32(4);
        depth = chunk[16];
        colorType = chunk[17];
        if (width == 0 || height == 0) _bad();
        if (width > maxPixels ~/ height || !const {8, 16}.contains(depth) || !const {0, 2, 4, 6}.contains(colorType))
          _unsupported();
        if (chunk[18] != 0 || chunk[19] != 0 || chunk[20] > 1) _unsupported();
      } else if (kind == _ChunkKind.pixels) {
        if (pixelsEnded) _bad();
        seenPixels = true;
        pixels.add(chunk);
      } else {
        if (seenPixels) pixelsEnded = true;
        if (kind == _ChunkKind.end) {
          if (size != 0 || !seenPixels || end != bytes.length) _bad();
          return (
            width: width,
            height: height,
            depth: depth,
            colorType: colorType,
            header: header!,
            end: chunk,
            exif: exif,
            pixels: pixels,
            before: before,
            after: after,
          );
        }
        if (kind == _ChunkKind.forbidden || kind == _ChunkKind.unknown && typeBytes[0] & 0x20 == 0) _unsupported();
        final single =
            kind == _ChunkKind.exif ||
            kind == _ChunkKind.palette ||
            kind == _ChunkKind.color ||
            kind == _ChunkKind.density ||
            kind == _ChunkKind.background ||
            kind == _ChunkKind.histogram;
        if (single && !singles.add(type)) _bad();
        if ((kind == _ChunkKind.color ||
                kind == _ChunkKind.palette ||
                kind == _ChunkKind.density ||
                kind == _ChunkKind.background ||
                kind == _ChunkKind.histogram ||
                kind == _ChunkKind.suggestedPalette) &&
            seenPixels)
          _bad();
        if (kind == _ChunkKind.color && paletteEntries != 0) _bad();
        if (kind == _ChunkKind.palette &&
            (!const {2, 6}.contains(colorType) || size == 0 || size > 768 || size % 3 != 0))
          _unsupported();
        if (kind == _ChunkKind.palette) {
          if (seenBackground) _bad();
          paletteEntries = size ~/ 3;
        }
        if (kind == _ChunkKind.density && (size != 9 || chunk[16] > 1)) _bad();
        if (kind == _ChunkKind.background) {
          if (size != (colorType == 0 || colorType == 4 ? 2 : 6)) _bad();
          seenBackground = true;
        }
        if (kind == _ChunkKind.histogram && (paletteEntries == 0 || size != paletteEntries * 2)) _bad();
        if (kind == _ChunkKind.suggestedPalette) {
          final payload = Uint8List.sublistView(chunk, 8, 8 + size);
          final nameEnd = payload.indexOf(0);
          if (nameEnd < 1 || nameEnd > 79 || nameEnd + 2 >= size) _bad();
          final name = payload.sublist(0, nameEnd);
          if (name.first == 32 ||
              name.last == 32 ||
              name.any((b) => !(b >= 32 && b <= 126 || b >= 161)) ||
              !paletteNames.add(latin1.decode(name)))
            _bad();
          for (var i = 1; i < name.length; i++) {
            if (name[i] == 32 && name[i - 1] == 32) _bad();
          }
          final sampleDepth = payload[nameEnd + 1];
          final entryBytes = switch (sampleDepth) {
            8 => 6,
            16 => 10,
            _ => 0,
          };
          if (entryBytes == 0 || (size - nameEnd - 2) % entryBytes != 0) _bad();
        }
        final retained = kind != _ChunkKind.unknown || typeBytes[3] & 0x20 != 0;
        if (retained) {
          metadataBytes += chunk.length;
          if (metadataBytes > maxMetadata) _unsupported();
          if (kind == _ChunkKind.exif) {
            exif = Uint8List.sublistView(chunk, 8, 8 + size);
          } else {
            (seenPixels ? after : before).add(chunk);
          }
        }
      }
      offset = end;
    }
    _bad();
  }

  static _ChunkKind _kind(String type) => switch (type) {
    'IHDR' => _ChunkKind.header,
    'IDAT' => _ChunkKind.pixels,
    'IEND' => _ChunkKind.end,
    'eXIf' => _ChunkKind.exif,
    'PLTE' => _ChunkKind.palette,
    'pHYs' => _ChunkKind.density,
    'bKGD' => _ChunkKind.background,
    'hIST' => _ChunkKind.histogram,
    'sPLT' => _ChunkKind.suggestedPalette,
    'cHRM' || 'gAMA' || 'iCCP' || 'sRGB' || 'sBIT' || 'cICP' || 'mDCV' || 'cLLI' => _ChunkKind.color,
    'tEXt' || 'zTXt' || 'iTXt' || 'tIME' => _ChunkKind.metadata,
    'tRNS' || 'acTL' || 'fcTL' || 'fdAT' => _ChunkKind.forbidden,
    _ => _ChunkKind.unknown,
  };

  static Uint8List _chunk(String type, List<int> payload) {
    final result = Uint8List(payload.length + 12);
    ByteData.sublistView(result).setUint32(0, payload.length);
    result.setRange(4, 8, ascii.encode(type));
    result.setRange(8, 8 + payload.length, payload);
    ByteData.sublistView(result).setUint32(result.length - 4, _crc(result, 4, result.length - 4));
    return result;
  }

  static int _crc(Uint8List bytes, int start, int end) {
    var crc = 0xffffffff;
    for (var i = start; i < end; i++) {
      crc = _crcTable[(crc ^ bytes[i]) & 0xff] ^ (crc >> 8);
    }
    return (crc ^ 0xffffffff) & 0xffffffff;
  }

  static Never _bad() => throw const GalleryCatalogFailure(GalleryErrorCode.processingFailed);
  static Never _unsupported() => throw const GalleryCatalogFailure(GalleryErrorCode.unsupported);
}
