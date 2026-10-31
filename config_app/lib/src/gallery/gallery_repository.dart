import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dslideshow_common/gallery.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import '../../features/gallery/domain/gallery_item.dart';
import 'media_image_loader.dart';

enum GalleryProtocol { undecided, versioned }

class GalleryCatalogResult {
  const GalleryCatalogResult(this.items, this.protocol, this.catalogRevision);
  final List<GalleryItem> items;
  final GalleryProtocol protocol;
  final String catalogRevision;
}

/// Catalog operations have their own cancellable transport, so a saturated
/// image queue cannot block refresh or authentication.
class GalleryRepository {
  static final _policyRevisionPattern = RegExp(r'^[a-f0-9]{64}$');
  GalleryRepository({
    required this.baseUri,
    required this.code,
    http.Client? client,
    this.timeout = const Duration(seconds: 20),
    this.maxCatalogBytes = 64 << 20,
  }) : _client = client ?? http.Client();

  final Uri baseUri;
  final String code;
  final http.Client _client;
  final Duration timeout;
  final int maxCatalogBytes;
  GalleryProtocol _protocol = GalleryProtocol.undecided;
  bool _supportsRefresh = false;
  Set<GalleryCapability> _capabilities = const {};
  Completer<void>? _activeAbort;
  int _generation = 0;
  bool _closed = false;

  GalleryProtocol get protocol => _protocol;
  Set<GalleryCapability> get capabilities => _capabilities;
  String get authScope => '${baseUri.origin}|$code';

  Uri _uri(List<String> segments, [Map<String, String>? query]) =>
      baseUri.replace(pathSegments: ['cache', code, ...segments], queryParameters: query);

  Future<GalleryCatalogResult> load({bool refresh = false}) async {
    if (_closed) throw StateError('Gallery repository closed');
    cancel();
    final generation = ++_generation;
    final abort = _activeAbort = Completer<void>();
    final timer = Timer(timeout, () {
      if (!abort.isCompleted) abort.complete();
    });
    try {
      final scan = refresh && _protocol == GalleryProtocol.versioned && _supportsRefresh;
      final request = http.AbortableRequest(
        scan ? 'POST' : 'GET',
        _uri(['v2', 'published', 'catalog', if (scan) 'refresh']),
        abortTrigger: abort.future,
      );
      if (scan) {
        request.headers['content-type'] = 'application/json';
        request.body = jsonEncode(
          GalleryRefreshRequest(operationId: const Uuid().v4(), mode: GalleryRefreshMode.scan).toJson(),
        );
      }
      final response = await _client.send(request);
      if (!_isCurrent(generation, abort)) {
        await response.stream.listen((_) {}).cancel();
        throw const GalleryImageCancelled();
      }
      final catalog = GalleryCatalog.fromJson(await _jsonResponse(response));
      _check(generation, abort);
      if (catalog.schemaVersion != GalleryCatalog.supportedSchemaVersion ||
          catalog.section != GalleryMediaSection.published ||
          catalog.catalogRevision.isEmpty) {
        throw const FormatException('Invalid gallery catalog');
      }
      if (catalog.capabilities.contains(GalleryCapability.thumbnails) &&
          (catalog.thumbnailPolicy == null ||
              catalog.thumbnailPolicy!.version < 1 ||
              (catalog.thumbnailPolicy!.revision.isNotEmpty &&
                  !_policyRevisionPattern.hasMatch(catalog.thumbnailPolicy!.revision)) ||
              !catalog.thumbnailPolicy!.sizes.any((size) => size.pixels > 0))) {
        throw const FormatException('Unsupported thumbnail policy');
      }
      final ids = <String>{};
      for (final entry in catalog.entries) {
        if (entry.section != catalog.section ||
            entry.mediaId.isEmpty ||
            !ids.add(entry.mediaId) ||
            (entry.kind != GalleryEntryKind.directory && entry.sourceRevision.isEmpty)) {
          throw const FormatException('Invalid gallery identity');
        }
      }
      _protocol = GalleryProtocol.versioned;
      _capabilities = Set.unmodifiable(catalog.capabilities);
      _supportsRefresh = catalog.capabilities.contains(GalleryCapability.refresh);
      return GalleryCatalogResult(
        List.unmodifiable([
          for (final entry in catalog.entries)
            GalleryItem.fromEntry(
              entry,
              baseUri: baseUri,
              code: code,
              scope: authScope,
              thumbnailPolicy: catalog.capabilities.contains(GalleryCapability.thumbnails)
                  ? catalog.thumbnailPolicy
                  : null,
            ),
        ]),
        GalleryProtocol.versioned,
        catalog.catalogRevision,
      );
    } finally {
      timer.cancel();
      if (identical(_activeAbort, abort)) _activeAbort = null;
    }
  }

  Future<Map<String, dynamic>> _jsonResponse(http.StreamedResponse response) async {
    if (response.statusCode != 200) {
      await response.stream.listen((_) {}).cancel();
      throw GalleryImageHttpException(response.statusCode);
    }
    var length = 0;
    final bytes = BytesBuilder(copy: false);
    await for (final chunk in response.stream) {
      length += chunk.length;
      if (length > maxCatalogBytes) {
        throw const GalleryImageBudgetException();
      }
      bytes.add(chunk);
    }
    final data = jsonDecode(utf8.decode(bytes.takeBytes()));
    if (data is! Map<String, dynamic>) {
      throw const FormatException('Invalid gallery catalog');
    }
    return data;
  }

  void _check(int generation, Completer<void> abort) {
    if (!_isCurrent(generation, abort)) {
      throw const GalleryImageCancelled();
    }
  }

  bool _isCurrent(int generation, Completer<void> abort) => !_closed && generation == _generation && !abort.isCompleted;

  void cancel() {
    final abort = _activeAbort;
    if (abort != null && !abort.isCompleted) abort.complete();
    _generation++;
  }

  void close() {
    _closed = true;
    cancel();
    _client.close();
  }
}
