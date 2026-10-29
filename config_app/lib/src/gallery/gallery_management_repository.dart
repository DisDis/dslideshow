import 'dart:async';
import 'dart:convert';
import 'dart:collection';
import 'dart:typed_data';

import 'package:dslideshow_common/gallery.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'package:logging/logging.dart';

import 'gallery_log.dart';

import '../../features/gallery/domain/gallery_item.dart';

/// Independent request cancellation keeps management from cancelling catalog
/// refreshes or image transfers. An aborted mutation may already have committed;
/// callers keep the same operation ID when retrying the same intent.
class GalleryManagementRepository {
  static final _log = Logger('GalleryManagementRepository');
  int _requestSequence = 0;
  GalleryManagementRepository({
    required this.baseUri,
    required this.code,
    http.Client? client,
    this.timeout = const Duration(seconds: 30),
    this.maxJsonBytes = 16 << 20,
    this.maxTrashCatalogBytes = 64 << 20,
    this.maxDuplicateResultBytes = 64 << 20,
  }) : _client = client ?? http.Client();

  final Uri baseUri;
  final String code;
  final http.Client _client;
  final Duration timeout;
  final int maxJsonBytes;
  final int maxTrashCatalogBytes;
  final int maxDuplicateResultBytes;
  final _requests = <Completer<void>>{};
  final _metadata = <String, GalleryMetadata>{};
  bool _closed = false;
  int _activeMetadata = 0;
  final _metadataQueue = Queue<Completer<void>>();
  final _closing = Completer<void>();

  String newOperationId() => const Uuid().v4();

  Uri uri(List<String> segments) =>
      baseUri.replace(pathSegments: ['cache', code, 'v2', ...segments]);

  Future<Map<String, dynamic>> _request(
    String method,
    List<String> segments, [
    Map<String, dynamic>? body,
    Future<void>? cancel,
    int? maxBytes,
  ]) async {
    if (_closed) throw StateError('Gallery management closed');
    final requestId = ++_requestSequence;
    final clock = Stopwatch()..start();
    final endpoint = _endpoint(method, segments);
    final operationId = body?['operationId'];
    final operation = operationId is String
        ? GalleryLog.id(operationId)
        : 'none';
    var receivedBytes = 0;
    int? status;
    var timedOut = false;
    _log.fine(
      () =>
          'event=requestStarted request=$requestId endpoint=${endpoint.name} operationId=$operation',
    );
    final abort = Completer<void>();
    _requests.add(abort);
    if (cancel != null) {
      unawaited(
        cancel.then((_) {
          if (_requests.contains(abort) && !abort.isCompleted) abort.complete();
        }),
      );
    }
    final timer = Timer(timeout, () {
      if (!abort.isCompleted) {
        timedOut = true;
        abort.complete();
      }
    });
    try {
      final request = http.AbortableRequest(
        method,
        uri(segments),
        abortTrigger: abort.future,
      );
      if (body != null) {
        request.headers['content-type'] = 'application/json';
        request.body = jsonEncode(body);
      }
      final response = await _client.send(request);
      status = response.statusCode;
      final bytes = BytesBuilder(copy: false);
      var length = 0;
      await for (final chunk in response.stream) {
        length += chunk.length;
        receivedBytes = length;
        if (length > (maxBytes ?? maxJsonBytes)) {
          throw const FormatException('Gallery response too large');
        }
        bytes.add(chunk);
      }
      if (_closed || abort.isCompleted) {
        throw const GalleryManagementException(GalleryErrorCode.unavailable);
      }
      final decoded = jsonDecode(utf8.decode(bytes.takeBytes()));
      if (decoded is! Map<String, dynamic>) {
        throw const FormatException('Invalid gallery response');
      }
      if (response.statusCode != 200) {
        throw GalleryManagementException(
          GalleryErrorResponse.fromJson(decoded).code,
        );
      }
      _log.fine(
        () =>
            'event=requestCompleted request=$requestId endpoint=${endpoint.name} operationId=$operation status=${response.statusCode} bytes=$receivedBytes elapsedMs=${clock.elapsedMilliseconds}',
      );
      return decoded;
    } catch (error) {
      if (timedOut) {
        _log.warning(
          'event=requestTimedOut request=$requestId endpoint=${endpoint.name} operationId=$operation code=timeout bytes=$receivedBytes elapsedMs=${clock.elapsedMilliseconds}',
        );
      } else if (_closed || abort.isCompleted) {
        _log.fine(
          () =>
              'event=requestCancelled request=$requestId endpoint=${endpoint.name} operationId=$operation reason=${_closed ? 'closed' : 'consumer'} bytes=$receivedBytes elapsedMs=${clock.elapsedMilliseconds}',
        );
      } else {
        final code = error is GalleryManagementException
            ? error.code.name
            : GalleryErrorCode.unknown.name;
        _log.warning(
          'event=requestFailed request=$requestId endpoint=${endpoint.name} operationId=$operation status=${status ?? 'none'} code=$code type=${error.runtimeType} bytes=$receivedBytes elapsedMs=${clock.elapsedMilliseconds}',
        );
      }
      rethrow;
    } finally {
      timer.cancel();
      _requests.remove(abort);
    }
  }

  Future<GalleryMetadata> metadata(
    GalleryItem item, {
    Future<void>? cancel,
    bool trash = false,
  }) async {
    final key = '${trash ? 'trash' : 'media'}:${item.mediaId}:${item.revision}';
    final cached = _metadata[key];
    if (cached != null) {
      _log.fine(
        () =>
            'event=metadataCacheHit source=${GalleryLog.source(item.mediaId)} revision=${GalleryLog.source(item.revision)} trash=$trash cacheEntries=${_metadata.length}',
      );
      return cached;
    }
    _log.fine(
      () =>
          'event=metadataCacheMiss source=${GalleryLog.source(item.mediaId)} revision=${GalleryLog.source(item.revision)} trash=$trash',
    );
    final slot = _acquireMetadata(cancel);
    if (slot != null) await slot;
    try {
      final result = GalleryMetadata.fromJson(
        await _request(
          'GET',
          [if (trash) 'trash', 'metadata', item.mediaId, item.revision],
          null,
          cancel,
        ),
      );
      if (result.mediaId != item.mediaId ||
          result.sourceRevision != item.revision) {
        throw const FormatException('Stale gallery metadata');
      }
      if (_metadata.length >= 64) _metadata.remove(_metadata.keys.first);
      _metadata[key] = result;
      return result;
    } finally {
      _releaseMetadata();
    }
  }

  Future<void>? _acquireMetadata(Future<void>? cancel) {
    if (_closed) {
      throw const GalleryManagementException(GalleryErrorCode.cancelled);
    }
    if (_activeMetadata < 4) {
      _activeMetadata++;
      return null;
    }
    final slot = Completer<void>();
    _metadataQueue.add(slot);
    return _waitForMetadata(slot, cancel);
  }

  Future<void> _waitForMetadata(
    Completer<void> slot,
    Future<void>? cancel,
  ) async {
    try {
      await Future.any<void>([
        slot.future,
        _closing.future.then(
          (_) => throw const GalleryManagementException(
            GalleryErrorCode.cancelled,
          ),
        ),
        if (cancel != null)
          cancel.then(
            (_) => throw const GalleryManagementException(
              GalleryErrorCode.cancelled,
            ),
          ),
      ]);
    } catch (_) {
      if (!_metadataQueue.remove(slot)) _releaseMetadata();
      rethrow;
    }
  }

  void _releaseMetadata() {
    _activeMetadata--;
    if (!_closed && _metadataQueue.isNotEmpty) {
      _activeMetadata++;
      _metadataQueue.removeFirst().complete();
    }
  }

  Future<GalleryMetadata> rotate(
    GalleryRotateRequest request, {
    Future<void>? cancel,
  }) async => GalleryMetadata.fromJson(
    await _request('POST', ['rotate'], request.toJson(), cancel),
  );

  Future<GalleryTrashCatalog> trash({Future<void>? cancel}) async =>
      GalleryTrashCatalog.fromJson(
        await _request('GET', ['trash'], null, cancel, maxTrashCatalogBytes),
      );

  Future<GalleryOperationResult> operate(
    GalleryOperationRequest request, {
    Future<void>? cancel,
  }) async {
    final result = GalleryOperationResult.fromJson(
      await _request('POST', ['operations'], request.toJson(), cancel),
    );
    final expected = request.items.map((item) => item.mediaId).toSet();
    if (result.operationId != request.operationId ||
        result.items.length != expected.length ||
        result.items.map((item) => item.mediaId).toSet().length !=
            expected.length ||
        result.items.any((item) => !expected.contains(item.mediaId))) {
      throw const FormatException('Invalid gallery operation result');
    }
    return result;
  }

  Future<GalleryDuplicateJob> duplicates({Future<void>? cancel}) async =>
      GalleryDuplicateJob.fromJson(
        await _request(
          'GET',
          ['duplicates'],
          null,
          cancel,
          maxDuplicateResultBytes,
        ),
      );

  Future<GalleryDuplicateGroupPage> duplicateGroup(
    String jobId,
    int index, {
    Future<void>? cancel,
  }) async => GalleryDuplicateGroupPage.fromJson(
    await _request(
      'GET',
      ['duplicates', jobId, 'groups', '$index'],
      null,
      cancel,
      maxDuplicateResultBytes,
    ),
  );

  Future<GalleryDuplicateJob> start(
    GalleryDuplicateStartRequest request, {
    Future<void>? cancel,
  }) async => GalleryDuplicateJob.fromJson(
    await _request(
      'POST',
      ['duplicates'],
      request.toJson(),
      cancel,
      maxDuplicateResultBytes,
    ),
  );

  Future<GalleryDuplicateJob> stop(
    String jobId, {
    Future<void>? cancel,
  }) async => GalleryDuplicateJob.fromJson(
    await _request(
      'POST',
      ['duplicates', jobId, 'stop'],
      null,
      cancel,
      maxDuplicateResultBytes,
    ),
  );

  GalleryItem trashItem(GalleryTrashEntry entry, String scope) => GalleryItem(
    uri: uri(['trash', 'original', entry.trashId, entry.sourceRevision]),
    title: entry.name,
    mediaId: entry.trashId,
    revision: entry.sourceRevision,
    scope: '$scope|trash',
    kind: entry.kind,
  );

  GalleryItem updatedItem(GalleryItem item, GalleryMetadata metadata) =>
      GalleryItem(
        uri: item.uri.replace(
          queryParameters: {
            ...item.uri.queryParameters,
            'rev': metadata.sourceRevision,
          },
        ),
        title: metadata.name,
        mediaId: metadata.mediaId,
        revision: metadata.sourceRevision,
        scope: item.scope,
        kind: metadata.kind,
        thumbnailPolicy: item.thumbnailPolicy,
        thumbnailsEnabled: item.thumbnailsEnabled,
        thumbnailBaseUri: _thumbnailRevision(
          item.thumbnailBaseUri,
          metadata.sourceRevision,
        ),
      );

  Uri? _thumbnailRevision(Uri? uri, String revision) {
    if (uri == null) return null;
    final segments = uri.pathSegments.toList();
    if (segments.length < 2) {
      throw const FormatException('Invalid thumbnail URI');
    }
    segments[segments.length - 2] = revision;
    return uri.replace(pathSegments: segments);
  }

  _ManagementEndpoint _endpoint(
    String method,
    List<String> segments,
  ) => switch ((method, segments)) {
    ('GET', ['metadata', _, _]) => _ManagementEndpoint.metadata,
    ('GET', ['trash', 'metadata', _, _]) => _ManagementEndpoint.trashMetadata,
    ('POST', ['rotate']) => _ManagementEndpoint.rotation,
    ('GET', ['trash']) => _ManagementEndpoint.trash,
    ('POST', ['operations']) => _ManagementEndpoint.operations,
    ('GET', ['duplicates', _, 'groups', _]) =>
      _ManagementEndpoint.duplicateGroup,
    ('GET', ['duplicates']) => _ManagementEndpoint.duplicateStatus,
    ('POST', ['duplicates']) => _ManagementEndpoint.duplicateStart,
    ('POST', ['duplicates', _, 'stop']) => _ManagementEndpoint.duplicateStop,
    _ => _ManagementEndpoint.unknown,
  };

  void close() {
    if (_closed) return;
    _closed = true;
    _closing.complete();
    _log.fine(
      () =>
          'event=repositoryClosed activeRequests=${_requests.length} metadataEntries=${_metadata.length}',
    );
    _metadata.clear();
    for (final abort in _requests) {
      if (!abort.isCompleted) abort.complete();
    }
    _client.close();
  }
}

class GalleryManagementException implements Exception {
  const GalleryManagementException(this.code);
  final GalleryErrorCode code;
}

enum _ManagementEndpoint {
  metadata,
  trashMetadata,
  rotation,
  trash,
  operations,
  duplicateStatus,
  duplicateGroup,
  duplicateStart,
  duplicateStop,
  unknown,
}
