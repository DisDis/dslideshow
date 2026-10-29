import 'dart:async';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:dslideshow_backend/src/service/gallery/thumbnail_service.dart';

class ControlledWorker implements ThumbnailWorker {
  final List<Completer<ThumbnailWorkerResult>> requests = [];
  final List<ThumbnailCancellationToken> cancellations = [];
  Completer<void> _changed = Completer();
  int active = 0;
  int peak = 0;

  Future<void> waitForCalls(int count) async {
    while (requests.length < count) {
      await _changed.future.timeout(const Duration(seconds: 5));
    }
  }

  @override
  Future<ThumbnailWorkerResult> run(
    ThumbnailWorkRequest request, {
    required Duration timeout,
    required ThumbnailCancellationToken cancellation,
  }) async {
    final completer = Completer<ThumbnailWorkerResult>();
    requests.add(completer);
    cancellations.add(cancellation);
    active++;
    if (active > peak) peak = active;
    final changed = _changed;
    _changed = Completer();
    changed.complete();
    final remove = cancellation.listen(() {
      if (!completer.isCompleted) {
        completer.completeError(
          const ThumbnailFailure(ThumbnailFailureKind.cancelled),
        );
      }
    });
    try {
      return await completer.future;
    } finally {
      remove();
      active--;
    }
  }

  void complete(int index, [List<int> bytes = const [1, 2, 3, 4]]) {
    requests[index].complete(
      ThumbnailWorkerResult(
        bytes: Uint8List.fromList(bytes),
        digest: md5.convert(bytes).toString(),
      ),
    );
  }
}
