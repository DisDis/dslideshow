import 'dart:async';
import 'dart:typed_data';

import 'package:config_app/features/realtime/domain/services/realtime_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

final class SelectedUploadFile extends PlatformFile {
  @override
  final String name;
  int? size;
  final Uri? selectedUri;
  final Completer<int?>? metadata;
  final Completer<void>? cleanupGate;
  final lengthStarted = Completer<void>();
  final opened = Completer<void>();
  final cancelStarted = Completer<void>();
  late StreamController<Uint8List> chunks;
  int lengthCalls = 0;
  int streamCalls = 0;
  int byteReads = 0;

  SelectedUploadFile(
    this.name, {
    this.size = 4,
    this.metadata,
    this.cleanupGate,
    this.selectedUri,
  }) {
    chunks = _newChunks();
  }

  StreamController<Uint8List> _newChunks() => StreamController<Uint8List>(
    onCancel: () async {
      if (!cancelStarted.isCompleted) cancelStarted.complete();
      await cleanupGate?.future;
    },
  );

  @override
  Uri get uri => selectedUri ?? Uri(scheme: 'blob', path: 'selected-file');

  @override
  Future<int?> length() {
    lengthCalls++;
    if (!lengthStarted.isCompleted) lengthStarted.complete();
    return metadata?.future ?? Future.value(size);
  }

  @override
  Stream<Uint8List> readAsByteStream() {
    streamCalls++;
    if (streamCalls > 1) chunks = _newChunks();
    if (!opened.isCompleted) opened.complete();
    return chunks.stream;
  }

  @override
  Future<Uint8List> readAsBytes() async {
    byteReads++;
    throw StateError('Unexpected whole-file read');
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class UploadRealtimeService implements RealtimeService {
  @override
  final Uri connectUri;
  @override
  final String authCode;

  UploadRealtimeService({Uri? uri, this.authCode = 'private-access-code'})
    : connectUri = uri ?? Uri.parse('wss://frame.example:444/socket');

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

// Models the external HTTP boundary: it consumes the real multipart request and
// completes an aborted send before a potentially slow source onCancel finishes.
class ControlledUploadHttpClient extends http.BaseClient {
  final sent = Completer<void>();
  final bodyDone = Completer<void>();
  final _response = Completer<http.StreamedResponse>();
  StreamSubscription<List<int>>? _body;
  http.BaseRequest? request;
  bool closed = false;
  int sends = 0;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    sends++;
    this.request = request;
    if (!sent.isCompleted) sent.complete();
    _body = request.finalize().listen(
      (_) {},
      onDone: () {
        if (!bodyDone.isCompleted) bodyDone.complete();
      },
      onError: (Object error, StackTrace stack) {
        if (!_response.isCompleted) _response.completeError(error, stack);
      },
      cancelOnError: true,
    );
    if (request is http.Abortable) {
      unawaited(request.abortTrigger?.then((_) => close()));
    }
    return _response.future;
  }

  void respond([int status = 200]) {
    if (!_response.isCompleted) {
      _response.complete(http.StreamedResponse(const Stream.empty(), status));
    }
  }

  @override
  void close() {
    if (closed) return;
    closed = true;
    unawaited(_body?.cancel());
    if (!_response.isCompleted) {
      _response.completeError(
        http.ClientException('secret authenticated URL must stay private'),
      );
    }
  }
}
