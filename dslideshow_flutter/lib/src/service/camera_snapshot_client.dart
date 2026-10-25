import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:dslideshow_backend/config.dart';

class _SnapshotJob {
  final String key;
  final CameraConfig camera;
  final completion = Completer<Uint8List>();
  final cancelled = Completer<void>();
  http.Client? client;
  StreamSubscription<List<int>>? body;
  _SnapshotJob(this.key, this.camera);
}

/// Loads HTTP(S) JPEG/PNG snapshots directly from the camera, with bounded
/// parallelism, response size and request lifetime. Never uses the backend.
class CameraSnapshotClient {
  final http.Client Function() createClient;
  final Duration timeout;
  final int maxBytes;
  final int maxConcurrent;
  final _jobs = <String, _SnapshotJob>{};
  final _queue = Queue<_SnapshotJob>();
  int _running = 0;
  bool _closed = false;
  CameraSnapshotClient({
    http.Client Function()? createClient,
    this.timeout = const Duration(seconds: 10),
    this.maxBytes = 10 * 1024 * 1024,
    this.maxConcurrent = 4,
  }) : createClient = createClient ?? http.Client.new;

  Future<Uint8List> fetch(String requestKey, CameraConfig camera) {
    if (_closed) return Future.error(StateError('Snapshot service closed'));
    if (!camera.hasValidUrl) {
      return Future.error(FormatException('Expected an HTTP/HTTPS camera URL'));
    }
    if (_jobs.containsKey(requestKey)) {
      return Future.error(StateError('Duplicate snapshot request'));
    }
    final job = _SnapshotJob(requestKey, camera);
    _jobs[requestKey] = job;
    _queue.add(job);
    _pump();
    return job.completion.future;
  }

  void cancel(String key) {
    final job = _jobs.remove(key);
    if (job == null) return;
    _queue.remove(job);
    if (!job.cancelled.isCompleted) job.cancelled.complete();
    job.client?.close();
    if (!job.completion.isCompleted) {
      job.completion.completeError(StateError('Snapshot cancelled'));
    }
  }

  void dispose() {
    _closed = true;
    for (final key in _jobs.keys.toList()) {
      cancel(key);
    }
  }

  void _pump() {
    while (!_closed && _running < maxConcurrent && _queue.isNotEmpty) {
      final job = _queue.removeFirst();
      _running++;
      unawaited(_run(job));
    }
  }

  Future<void> _run(_SnapshotJob job) async {
    try {
      job.client = createClient();
      final bytes = await Future.any([
        _download(job),
        job.cancelled.future.then<Uint8List>(
          (_) => throw StateError('Snapshot cancelled'),
        ),
      ]).timeout(timeout);
      if (!job.completion.isCompleted) job.completion.complete(bytes);
    } catch (e, st) {
      if (!job.completion.isCompleted) job.completion.completeError(e, st);
    } finally {
      if (!job.cancelled.isCompleted) job.cancelled.complete();
      job.client?.close();
      // Start cleanup without letting an asynchronous transport cancellation
      // retain a slot in our bounded queue.
      job.body?.cancel().ignore();
      if (identical(_jobs[job.key], job)) _jobs.remove(job.key);
      _running--;
      _pump();
    }
  }

  Future<Uint8List> _download(_SnapshotJob job) async {
    final request = http.Request('GET', Uri.parse(job.camera.url));
    request.headers['cache-control'] = 'no-cache';
    request.headers['accept'] = 'image/jpeg, image/png';
    if (job.camera.username.isNotEmpty) {
      request.headers['authorization'] =
          'Basic ${base64Encode(utf8.encode('${job.camera.username}:${job.camera.password}'))}';
    }
    final response = await job.client!.send(request);
    if (job.cancelled.isCompleted) {
      response.stream.listen((_) {}, onError: (Object _) {}).cancel().ignore();
      throw StateError('Snapshot cancelled');
    }
    if (response.statusCode != 200) {
      job.body = response.stream.listen((_) {}, onError: (Object _) {});
      throw StateError('Camera HTTP ${response.statusCode}');
    }
    if ((response.contentLength ?? 0) > maxBytes) {
      job.body = response.stream.listen((_) {}, onError: (Object _) {});
      throw StateError('Camera image too large');
    }
    final builder = BytesBuilder(copy: false);
    final body = Completer<Uint8List>();
    job.body = response.stream.listen(
      (chunk) {
        if (body.isCompleted) return;
        if (builder.length + chunk.length > maxBytes) {
          body.completeError(StateError('Camera image too large'));
        } else {
          builder.add(chunk);
        }
      },
      onDone: () {
        if (!body.isCompleted) body.complete(builder.takeBytes());
      },
      onError: (Object error, StackTrace stack) {
        if (!body.isCompleted) body.completeError(error, stack);
      },
    );
    unawaited(
      job.cancelled.future.then((_) {
        if (!body.isCompleted) {
          body.completeError(StateError('Snapshot cancelled'));
        }
      }),
    );
    final bytes = await body.future;
    final jpeg =
        bytes.length >= 3 &&
        bytes[0] == 255 &&
        bytes[1] == 216 &&
        bytes[2] == 255;
    final png =
        bytes.length >= 8 &&
        bytes[0] == 137 &&
        bytes[1] == 80 &&
        bytes[2] == 78 &&
        bytes[3] == 71 &&
        bytes[4] == 13 &&
        bytes[5] == 10 &&
        bytes[6] == 26 &&
        bytes[7] == 10;
    if (!jpeg && !png) throw FormatException('Camera must return JPEG or PNG');
    return bytes;
  }
}
