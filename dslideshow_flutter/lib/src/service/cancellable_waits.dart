import 'dart:async';

/// Ends local waits on shutdown without cancelling the external operations.
/// Completed operations remove their cancellation callbacks immediately.
class CancellableWaits {
  final _pending = <void Function()>{};
  bool _closed = false;
  bool get isClosed => _closed;

  Future<T?> wait<T>(Future<T> operation) {
    final completion = Completer<T?>();
    void cancel() {
      if (!completion.isCompleted) completion.complete(null);
    }

    if (_closed) {
      cancel();
    } else {
      _pending.add(cancel);
    }
    // Always consume late errors, including after local cancellation.
    unawaited(
      operation.then<void>(
        (value) {
          _pending.remove(cancel);
          if (!completion.isCompleted) completion.complete(value);
        },
        onError: (Object error, StackTrace stack) {
          _pending.remove(cancel);
          if (!completion.isCompleted) completion.completeError(error, stack);
        },
      ),
    );
    return completion.future;
  }

  void close() {
    if (_closed) return;
    _closed = true;
    for (final cancel in _pending) {
      cancel();
    }
    _pending.clear();
  }
}
