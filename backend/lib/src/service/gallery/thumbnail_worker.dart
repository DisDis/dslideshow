import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:image/image.dart' as image;

enum ThumbnailFormat { automatic, jpeg, png }

enum ThumbnailFailureKind {
  queueFull,
  staleSource,
  unsupported,
  decodeFailed,
  timeout,
  cancelled,
  closed,
  diskFull,
  sourceTooLarge,
}

class ThumbnailFailure implements Exception {
  final ThumbnailFailureKind kind;
  const ThumbnailFailure(this.kind);
  @override
  String toString() => 'ThumbnailFailure(${kind.name})';
}

/// Cancellation belongs to a real waiter or service lifetime, not widget state.
class ThumbnailCancellationToken {
  bool _cancelled = false;
  final Set<void Function()> _listeners = {};
  bool get isCancelled => _cancelled;

  void Function() listen(void Function() listener) {
    if (_cancelled) {
      listener();
      return () {};
    }
    _listeners.add(listener);
    return () => _listeners.remove(listener);
  }

  void cancel() {
    if (_cancelled) return;
    _cancelled = true;
    final listeners = List.of(_listeners);
    _listeners.clear();
    for (final listener in listeners) {
      listener();
    }
  }
}

class ThumbnailWorkRequest {
  final String path;
  final int size;
  final int jpegQuality;
  final ThumbnailFormat format;
  final int maxSourceBytes;
  final int maxSourcePixels;
  final int maxOutputBytes;
  const ThumbnailWorkRequest({
    required this.path,
    required this.size,
    required this.jpegQuality,
    required this.format,
    required this.maxSourceBytes,
    required this.maxSourcePixels,
    required this.maxOutputBytes,
  });
}

class ThumbnailWorkerResult {
  final TransferableTypedData data;
  final ThumbnailFormat format;
  final String digest;
  final int width;
  final int height;
  final int jpegScale;
  final int elapsedMicroseconds;
  ThumbnailWorkerResult({
    required this.data,
    required this.format,
    required this.digest,
    required this.width,
    required this.height,
    required this.jpegScale,
    required this.elapsedMicroseconds,
  });

  Uint8List takeBytes() => data.materialize().asUint8List();
}

abstract interface class ThumbnailWorker {
  /// Completion includes termination of work, including timeout/cancellation.
  Future<ThumbnailWorkerResult> run(
    ThumbnailWorkRequest request, {
    required Duration timeout,
    required ThumbnailCancellationToken cancellation,
  });
}

/// Only pure Dart decoder work runs here; no native decoder can outlive a kill.
/// Each operation owns an isolate and waits for onExit before releasing its slot.
class IsolateThumbnailWorker implements ThumbnailWorker {
  const IsolateThumbnailWorker();

  @override
  Future<ThumbnailWorkerResult> run(
    ThumbnailWorkRequest request, {
    required Duration timeout,
    required ThumbnailCancellationToken cancellation,
  }) async {
    final port = ReceivePort();
    final result = Completer<ThumbnailWorkerResult>();
    final exit = Completer<void>();
    final inputClosed = Completer<void>();
    final stopped = Completer<ThumbnailFailure>();
    final subscription = port.listen((message) {
      if (message == null) {
        if (!inputClosed.isCompleted) inputClosed.complete();
        if (!exit.isCompleted) exit.complete();
        if (!result.isCompleted) {
          result.completeError(
            const ThumbnailFailure(ThumbnailFailureKind.decodeFailed),
          );
        }
      } else if (message is _InputClosed) {
        if (!inputClosed.isCompleted) inputClosed.complete();
      } else if (message is ThumbnailWorkerResult) {
        if (!result.isCompleted) result.complete(message);
      } else if (message is ThumbnailFailure) {
        if (!result.isCompleted) result.completeError(message);
      } else if (message is List && !result.isCompleted) {
        result.completeError(
          const ThumbnailFailure(ThumbnailFailureKind.decodeFailed),
        );
      }
    });
    void stop(ThumbnailFailureKind kind) {
      if (!stopped.isCompleted) stopped.complete(ThumbnailFailure(kind));
    }

    final removeCancellation = cancellation.listen(
      () => stop(ThumbnailFailureKind.cancelled),
    );
    final timer = Timer(timeout, () => stop(ThumbnailFailureKind.timeout));
    // Attach error handlers before an isolate can finish during spawn.
    final outcome = Future.any<ThumbnailWorkerResult>([
      result.future,
      stopped.future.then((failure) => throw failure),
    ]);
    outcome.ignore();
    Isolate? isolate;
    try {
      isolate = await Isolate.spawn(
        _thumbnailWorkerMain,
        (port.sendPort, request),
        paused: true,
        onExit: port.sendPort,
        onError: port.sendPort,
        errorsAreFatal: true,
      );
      isolate.resume(isolate.pauseCapability!);
      return await outcome;
    } finally {
      timer.cancel();
      removeCancellation();
      if (isolate != null) {
        // Isolate.kill bypasses Dart finally blocks. Never kill an isolate
        // while it owns an open input FD; regular-file input is bounded and
        // closes before the long CPU decode starts. Pending OS IO may delay
        // cancellation, but cannot leak a killed worker's descriptor.
        await inputClosed.future;
        isolate.kill(priority: Isolate.immediate);
        await exit.future;
      }
      await subscription.cancel();
      port.close();
    }
  }
}

void _thumbnailWorkerMain((SendPort, ThumbnailWorkRequest) arguments) {
  final (reply, request) = arguments;
  try {
    final bytes = _readSource(request);
    reply.send(const _InputClosed());
    Isolate.exit(reply, _decodeThumbnail(request, bytes));
  } on ThumbnailFailure catch (failure) {
    reply.send(const _InputClosed());
    Isolate.exit(reply, failure);
  } on image.ImageException catch (error) {
    reply.send(const _InputClosed());
    // image 4.12 exposes decoder pixel-budget errors as ImageException text.
    // Keep this package boundary mapping centralized and regression tested.
    Isolate.exit(
      reply,
      ThumbnailFailure(
        error.message.endsWith('maximum of ${request.maxSourcePixels} pixels')
            ? ThumbnailFailureKind.sourceTooLarge
            : ThumbnailFailureKind.decodeFailed,
      ),
    );
  } catch (_) {
    reply.send(const _InputClosed());
    // Decoder exceptions may contain source paths. Do not send them to clients.
    Isolate.exit(
      reply,
      const ThumbnailFailure(ThumbnailFailureKind.decodeFailed),
    );
  }
}

class _InputClosed {
  const _InputClosed();
}

Uint8List _readSource(ThumbnailWorkRequest request) {
  final source = File(request.path);
  if (source.lengthSync() > request.maxSourceBytes) {
    throw const ThumbnailFailure(ThumbnailFailureKind.sourceTooLarge);
  }
  final input = source.openSync();
  final builder = BytesBuilder(copy: false);
  try {
    while (true) {
      final chunk = input.readSync(
        math.min(64 * 1024, request.maxSourceBytes - builder.length + 1),
      );
      if (chunk.isEmpty) break;
      builder.add(chunk);
      if (builder.length > request.maxSourceBytes) {
        throw const ThumbnailFailure(ThumbnailFailureKind.sourceTooLarge);
      }
    }
  } finally {
    input.closeSync();
  }
  return builder.takeBytes();
}

/// CPU routine starts only after the worker no longer owns any file descriptor.
ThumbnailWorkerResult _decodeThumbnail(
  ThumbnailWorkRequest request,
  Uint8List bytes,
) {
  final clock = Stopwatch()..start();
  image.Decoder.defaultMaxPixels = request.maxSourcePixels;
  final decoder = image.findDecoderForData(bytes);
  if (decoder == null) {
    throw const ThumbnailFailure(ThumbnailFailureKind.unsupported);
  }
  final info = decoder.startDecode(bytes);
  if (info == null || info.width <= 0 || info.height <= 0) {
    throw const ThumbnailFailure(ThumbnailFailureKind.decodeFailed);
  }
  if (info.width * info.height > request.maxSourcePixels) {
    throw const ThumbnailFailure(ThumbnailFailureKind.sourceTooLarge);
  }
  var scale = 1;
  image.Image? decoded;
  if (decoder is image.JpegDecoder) {
    final shortest = math.min(info.width, info.height);
    for (final candidate in [8, 4, 2]) {
      if (shortest ~/ candidate >= request.size) {
        scale = candidate;
        break;
      }
    }
    decoded = image.JpegDecoder(
      maxPixels: request.maxSourcePixels,
      scale: scale,
    ).decode(bytes, frame: 0);
  } else {
    // Decode one frame, never the whole GIF/APNG animation.
    decoded = decoder.decodeFrame(0);
  }
  if (decoded == null) {
    throw const ThumbnailFailure(ThumbnailFailureKind.decodeFailed);
  }
  if (decoded.exif.imageIfd.hasOrientation &&
      decoded.exif.imageIfd.orientation != 1) {
    decoded = image.bakeOrientation(decoded);
  }
  // Center cover matches the square grid. Avoid upscaling small originals.
  final edge = math.min(decoded.width, decoded.height);
  final square = decoded.width == decoded.height
      ? decoded
      : image.copyCrop(
          decoded,
          x: (decoded.width - edge) ~/ 2,
          y: (decoded.height - edge) ~/ 2,
          width: edge,
          height: edge,
        );
  final target = math.min(request.size, edge);
  final thumbnail = target == edge
      ? square
      : image.copyResize(
          square,
          width: target,
          height: target,
          interpolation: image.Interpolation.average,
        );
  thumbnail.exif = image.ExifData();
  final hasTransparency =
      thumbnail.hasAlpha &&
      thumbnail.any((pixel) => pixel.a < pixel.maxChannelValue);
  final format = request.format == ThumbnailFormat.automatic
      ? (hasTransparency ? ThumbnailFormat.png : ThumbnailFormat.jpeg)
      : request.format;
  // Explicit JPEG must not silently flatten transparency.
  if (hasTransparency && format == ThumbnailFormat.jpeg) {
    throw const ThumbnailFailure(ThumbnailFailureKind.unsupported);
  }
  final encoded = format == ThumbnailFormat.png
      ? image.encodePng(thumbnail)
      : image.encodeJpg(thumbnail, quality: request.jpegQuality);
  if (encoded.length > request.maxOutputBytes) {
    throw const ThumbnailFailure(ThumbnailFailureKind.sourceTooLarge);
  }
  return ThumbnailWorkerResult(
    data: TransferableTypedData.fromList([encoded]),
    format: format,
    digest: sha256.convert(encoded).toString(),
    width: thumbnail.width,
    height: thumbnail.height,
    jpegScale: scale,
    elapsedMicroseconds: clock.elapsedMicroseconds,
  );
}
