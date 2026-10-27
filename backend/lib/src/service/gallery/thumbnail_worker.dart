import 'dart:typed_data';

/// Increment when codec or geometry changes invalidate immutable derivatives.
const thumbnailPolicyVersion = 4;

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
  unavailable,
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
  final int backgroundColor;
  final int frameSelectionFrames;
  final int maxSourceBytes;
  final int maxSourcePixels;
  final int maxOutputBytes;
  const ThumbnailWorkRequest({
    required this.path,
    required this.size,
    this.jpegQuality = 60,
    this.backgroundColor = 0xff202020,
    this.frameSelectionFrames = 30,
    required this.maxSourceBytes,
    required this.maxSourcePixels,
    required this.maxOutputBytes,
  });
}

class ThumbnailWorkerResult {
  final Uint8List bytes;

  /// MD5 of the encoded JPEG: content ETag and disk-cache checksum.
  final String digest;
  ThumbnailWorkerResult({required this.bytes, required this.digest});
}

abstract interface class ThumbnailWorker {
  /// Completion includes termination of work, including timeout/cancellation.
  Future<ThumbnailWorkerResult> run(
    ThumbnailWorkRequest request, {
    required Duration timeout,
    required ThumbnailCancellationToken cancellation,
  });
}
