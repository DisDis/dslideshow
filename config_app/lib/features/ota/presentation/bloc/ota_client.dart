import 'dart:async';
import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

import 'ota_state.dart';

/// A safe failure code; transport exceptions and response bodies stay private.
class OtaClientException implements Exception {
  const OtaClientException(this.failure);

  final OtaFailure failure;
}

/// Owns the transports for one panel action. Does not own a picked file's bytes.
class OTAClient {
  OTAClient({required this.baseUri, http.Client Function()? clientFactory, this.timeout = const Duration(minutes: 30)})
    : _clientFactory = clientFactory ?? http.Client.new {
    if (timeout <= Duration.zero) throw ArgumentError.value(timeout, 'timeout');
  }

  static final _log = Logger('OTAClient');
  static const _maxResponseBytes = 64 * 1024;
  final Uri baseUri;
  final http.Client Function() _clientFactory;
  final Duration timeout;
  final _clients = <http.Client>{};
  final _requests = <Future<void>>{};
  final _sources = <_OtaUploadSource>{};
  bool _closed = false;
  Future<void>? _closeFuture;

  Future<String> start({required Future<void> cancellation}) async {
    final uri = baseUri.resolve('/ota_start?format=json');
    final request = http.AbortableRequest('GET', uri, abortTrigger: cancellation);
    final response = await _send(request);
    if (response.$1 != 200) {
      throw const OtaClientException(OtaFailure.requestFailed);
    }
    try {
      final payload = jsonDecode(response.$2);
      if (payload case {'version': {'frontend': final String version}}) {
        if (version.isNotEmpty) return version;
      }
    } catch (_) {
      // A malformed JSON exception can contain the server's entire payload.
    }
    throw const OtaClientException(OtaFailure.invalidResponse);
  }

  Future<void> uploadFile({
    required String code,
    required PlatformFile file,
    required int length,
    required Future<void> cancellation,
    required void Function(int sent, int total) onProgress,
  }) async {
    if (_closed) throw const OtaClientException(OtaFailure.cancelled);
    final request = http.AbortableMultipartRequest('POST', baseUri.resolve('/ota_upload'), abortTrigger: cancellation);
    request.fields['code'] = code;
    var sent = 0;
    final source = _OtaUploadSource(
      () => file.readAsByteStream().map((chunk) {
        sent += chunk.length;
        onProgress(sent, length);
        return chunk;
      }),
    );
    _sources.add(source);
    try {
      request.files.add(http.MultipartFile('file', source.stream, length, filename: file.name));
      final response = await _send(request);
      if (response.$1 != 200) {
        throw const OtaClientException(OtaFailure.uploadRejected);
      }
    } finally {
      await source.cancel();
      _sources.remove(source);
    }
  }

  Future<(int, String)> _send(http.BaseRequest request) async {
    if (_closed) throw const OtaClientException(OtaFailure.cancelled);
    final client = _clientFactory();
    final done = Completer<void>();
    _requests.add(done.future);
    _clients.add(client);
    final ordinaryTimeout = timeout < const Duration(seconds: 60) ? timeout : const Duration(seconds: 60);
    final requestTimeout = request is http.MultipartRequest ? timeout : ordinaryTimeout;
    try {
      final response = await client.send(request).timeout(requestTimeout);
      final bytes = <int>[];
      await for (final chunk in response.stream.timeout(ordinaryTimeout)) {
        if (bytes.length + chunk.length > _maxResponseBytes) {
          throw const OtaClientException(OtaFailure.invalidResponse);
        }
        bytes.addAll(chunk);
      }
      _log.fine('event=response status=${response.statusCode} bytes=${bytes.length}');
      return (response.statusCode, utf8.decode(bytes, allowMalformed: true));
    } on OtaClientException {
      rethrow;
    } on http.RequestAbortedException {
      throw const OtaClientException(OtaFailure.cancelled);
    } catch (error, stack) {
      if (_closed) throw const OtaClientException(OtaFailure.cancelled);
      _log.warning('event=requestFailed type=${error.runtimeType}', error, stack);
      throw const OtaClientException(OtaFailure.requestFailed);
    } finally {
      if (_clients.remove(client)) client.close();
      done.complete();
      _requests.remove(done.future);
    }
  }

  Future<void> close() => _closeFuture ??= _close();

  Future<void> _close() async {
    _closed = true;
    for (final client in _clients) {
      client.close();
    }
    _clients.clear();
    await Future.wait(_sources.map((source) => source.cancel()).toList());
    await Future.wait(_requests.toList());
  }
}

/// Forwards back pressure and explicitly owns asynchronous file cancellation.
class _OtaUploadSource {
  _OtaUploadSource(Stream<List<int>> Function() open) {
    _controller = StreamController<List<int>>(
      sync: true,
      onListen: () {
        if (_cancelled) return;
        try {
          _subscription = open().listen(_controller.add, onError: _controller.addError, onDone: _controller.close);
        } catch (error, stack) {
          _controller.addError(error, stack);
          unawaited(_controller.close());
        }
      },
      onPause: () => _subscription?.pause(),
      onResume: () => _subscription?.resume(),
      onCancel: cancel,
    );
  }

  late final StreamController<List<int>> _controller;
  StreamSubscription<List<int>>? _subscription;
  bool _cancelled = false;
  Future<void>? _cancelFuture;
  Stream<List<int>> get stream => _controller.stream;

  Future<void> cancel() => _cancelFuture ??= _cancel();

  Future<void> _cancel() async {
    _cancelled = true;
    try {
      await _subscription?.cancel();
    } catch (error, stack) {
      OTAClient._log.warning('event=sourceCleanupFailed type=${error.runtimeType}', error, stack);
    } finally {
      // Closing an unconsumed controller need not delay releasing its source.
      unawaited(_controller.close());
    }
  }
}
