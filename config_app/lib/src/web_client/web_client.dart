import 'dart:async';

import 'package:http/http.dart' as http;

enum MediaUploadFailure { sourceUnavailable, lengthUnknown, transferFailed }

class MediaUploadException implements Exception {
  final MediaUploadFailure failure;

  const MediaUploadException(this.failure);
}

class MediaUploadCancelled implements Exception {
  const MediaUploadCancelled();
}

class MediaUploadCancellation {
  final _cancelled = Completer<void>();

  bool get isCancelled => _cancelled.isCompleted;
  Future<void> get whenCancelled => _cancelled.future;

  void cancel() {
    if (!isCancelled) _cancelled.complete();
  }
}

class WebClient {
  final String host;
  final int port;
  final String code;
  final String scheme;
  final http.Client Function() _clientFactory;
  final Duration uploadTimeout;

  WebClient({
    required this.host,
    required this.port,
    required this.code,
    this.scheme = 'http',
    http.Client Function()? clientFactory,
    this.uploadTimeout = const Duration(minutes: 30),
  }) : _clientFactory = clientFactory ?? http.Client.new;

  Uri _uri(List<String> segments) => Uri(scheme: scheme, host: host, port: port, pathSegments: segments);

  Future<void> uploadMediaStream({
    required String serverPath,
    required Future<int?> Function() length,
    required Stream<List<int>> Function() openRead,
    required MediaUploadCancellation cancellation,
    required void Function(int sent, int total) onProgress,
  }) async {
    if (cancellation.isCancelled) throw const MediaUploadCancelled();
    final aborted = Completer<void>();
    http.Client? client;
    _UploadBody? body;
    Future<int?>? metadata;
    var timedOut = false;
    var finished = false;
    void abort() {
      if (finished) return;
      if (!aborted.isCompleted) aborted.complete();
      client?.close();
      // Cleanup is awaited by the request owner below, including async onCancel.
      unawaited(body?.close());
    }

    final timer = Timer(uploadTimeout, () {
      timedOut = true;
      abort();
    });
    unawaited(cancellation.whenCancelled.then((_) => abort()));
    try {
      int? size;
      try {
        metadata = Future<int?>.sync(length);
        size = await Future.any<int?>([metadata, aborted.future.then<int?>((_) => throw const MediaUploadCancelled())]);
      } catch (_) {
        if (cancellation.isCancelled || timedOut) rethrow;
        throw const MediaUploadException(MediaUploadFailure.lengthUnknown);
      }
      if (cancellation.isCancelled) throw const MediaUploadCancelled();
      if (timedOut) {
        throw const MediaUploadException(MediaUploadFailure.transferFailed);
      }
      if (size == null || size < 0) {
        throw const MediaUploadException(MediaUploadFailure.lengthUnknown);
      }
      body = _UploadBody(openRead, size, onProgress);
      final request = http.AbortableMultipartRequest('POST', _uri(['upload', code, '']), abortTrigger: aborted.future)
        ..files.add(http.MultipartFile('file', body.stream, size, filename: serverPath));
      client = _clientFactory();
      final response = await client.send(request);
      // The backend only acknowledges the upload; never retain response content.
      await response.stream.drain<void>();
      if (response.statusCode != 200) {
        throw const MediaUploadException(MediaUploadFailure.transferFailed);
      }
      if (cancellation.isCancelled) throw const MediaUploadCancelled();
      if (timedOut) {
        throw const MediaUploadException(MediaUploadFailure.transferFailed);
      }
    } catch (error) {
      if (cancellation.isCancelled) throw const MediaUploadCancelled();
      if (body?.sourceFailed ?? false) {
        throw const MediaUploadException(MediaUploadFailure.sourceUnavailable);
      }
      if (error is MediaUploadException) rethrow;
      throw const MediaUploadException(MediaUploadFailure.transferFailed);
    } finally {
      finished = true;
      timer.cancel();
      if (!aborted.isCompleted) aborted.complete();
      client?.close();
      await body?.close();
      // PlatformFile has no cancellation API for length(). Its implementation
      // may read the source, so retain the queue slot until that work settles.
      if (metadata != null) {
        try {
          await metadata;
        } catch (_) {
          // The original failure is classified above; consume late errors too.
        }
      }
    }
  }
}

// Owns the selected source subscription independently of the HTTP body consumer.
// Cancellation can stop a blocked source and await its resource cleanup.
class _UploadBody {
  final Stream<List<int>> Function() _openRead;
  final int _length;
  final void Function(int, int) _onProgress;
  late final StreamController<List<int>> _controller;
  StreamSubscription<List<int>>? _source;
  Future<void>? _cleanup;
  bool sourceFailed = false;
  int _sent = 0;

  _UploadBody(this._openRead, this._length, this._onProgress) {
    _controller = StreamController<List<int>>(
      onListen: _listen,
      onPause: () => _source?.pause(),
      onResume: () => _source?.resume(),
      onCancel: close,
    );
  }

  Stream<List<int>> get stream => _controller.stream;

  void _listen() {
    if (_cleanup != null) {
      unawaited(_controller.close());
      return;
    }
    try {
      _source = _openRead().listen(
        (chunk) {
          if (_cleanup != null) return;
          _sent += chunk.length;
          if (_sent > _length) {
            _fail();
          } else {
            _controller.add(chunk);
            _onProgress(_sent, _length);
          }
        },
        onError: (Object error, StackTrace stack) => _fail(),
        onDone: () {
          if (_sent != _length) _fail();
          if (!_controller.isClosed) unawaited(_controller.close());
        },
        cancelOnError: true,
      );
    } catch (_) {
      _fail();
    }
  }

  void _fail() {
    sourceFailed = true;
    if (!_controller.isClosed) {
      _controller.addError(const MediaUploadException(MediaUploadFailure.sourceUnavailable));
      unawaited(_controller.close());
    }
  }

  Future<void> close() => _cleanup ??= _close();

  Future<void> _close() async {
    try {
      await _source?.cancel();
    } catch (_) {
      // A cleanup failure must not expose source paths or hide cancellation.
      sourceFailed = true;
    } finally {
      if (!_controller.isClosed) unawaited(_controller.close());
    }
  }
}
