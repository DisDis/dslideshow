import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dslideshow_common/gallery.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

import '../../features/gallery/domain/gallery_item.dart';
import 'media_image_loader.dart';

enum GalleryProtocol { undecided, versioned, legacy }

class GalleryCatalogResult {
  const GalleryCatalogResult(this.items, this.protocol, this.catalogRevision);
  final List<GalleryItem> items;
  final GalleryProtocol protocol;
  final String catalogRevision;
}

/// Catalog operations have their own cancellable transport, so a saturated
/// image queue cannot block refresh or authentication.
class GalleryRepository {
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
  Completer<void>? _activeAbort;
  int _generation = 0;
  int _legacyEpoch = 0;
  bool _closed = false;

  GalleryProtocol get protocol => _protocol;
  String get authScope => '${baseUri.origin}|$code';

  Uri _uri(List<String> segments, [Map<String, String>? query]) =>
      baseUri.replace(
        pathSegments: ['cache', code, ...segments],
        queryParameters: query,
      );

  Future<GalleryCatalogResult> load({bool refresh = false}) async {
    if (_closed) throw StateError('Gallery repository closed');
    cancel();
    final generation = ++_generation;
    final abort = _activeAbort = Completer<void>();
    final timer = Timer(timeout, () {
      if (!abort.isCompleted) abort.complete();
    });
    try {
      if (_protocol != GalleryProtocol.legacy) {
        final scan =
            refresh &&
            _protocol == GalleryProtocol.versioned &&
            _supportsRefresh;
        final request = http.AbortableRequest(
          scan ? 'POST' : 'GET',
          _uri(['v2', 'catalog', if (scan) 'refresh']),
          abortTrigger: abort.future,
        );
        if (scan) {
          request.headers['content-type'] = 'application/json';
          request.body = jsonEncode(
            GalleryRefreshRequest(
              operationId: const Uuid().v4(),
              mode: GalleryRefreshMode.scan,
            ).toJson(),
          );
        }
        final response = await _client.send(request);
        if (!_isCurrent(generation, abort)) {
          await response.stream.listen((_) {}).cancel();
          throw const GalleryImageCancelled();
        }
        if ((response.statusCode == 404 || response.statusCode == 405) &&
            _protocol == GalleryProtocol.undecided) {
          await response.stream.drain<void>();
          _check(generation, abort);
          _protocol = GalleryProtocol.legacy;
        } else {
          final data = await _jsonResponse(response);
          _check(generation, abort);
          final catalog = GalleryCatalog.fromJson(data);
          if (catalog.schemaVersion != GalleryCatalog.supportedSchemaVersion) {
            throw const FormatException('Unsupported gallery schema');
          }
          if (catalog.serverId.isEmpty || catalog.catalogRevision.isEmpty) {
            throw const FormatException('Invalid gallery scope');
          }
          if (catalog.capabilities.contains(GalleryCapability.thumbnails) &&
              (catalog.thumbnailPolicy == null ||
                  catalog.thumbnailPolicy!.version < 1 ||
                  !catalog.thumbnailPolicy!.sizes.any(
                    (size) => size.pixels > 0,
                  ))) {
            throw const FormatException('Unsupported thumbnail policy');
          }
          final ids = <String>{};
          for (final entry in catalog.entries) {
            if (entry.mediaId.isEmpty ||
                !ids.add(entry.mediaId) ||
                (entry.kind != GalleryEntryKind.directory &&
                    (entry.sourceRevision?.isEmpty ?? true))) {
              throw const FormatException('Invalid gallery identity');
            }
          }
          _protocol = GalleryProtocol.versioned;
          _supportsRefresh = catalog.capabilities.contains(
            GalleryCapability.refresh,
          );
          final scope = '$authScope|${catalog.serverId}';
          final items = catalog.entries
              .map((entry) {
                final revision =
                    entry.sourceRevision ?? catalog.catalogRevision;
                final thumbnail =
                    entry.thumbnailSupported &&
                    catalog.capabilities.contains(
                      GalleryCapability.thumbnails,
                    ) &&
                    catalog.thumbnailPolicy != null;
                return GalleryItem(
                  uri: _uri(
                    ['get', ...entry.path.split('/')],
                    entry.sourceRevision != null &&
                            catalog.capabilities.contains(
                              GalleryCapability.revisionedOriginals,
                            )
                        ? {'rev': revision}
                        : null,
                  ),
                  title: entry.name,
                  mediaId: entry.mediaId,
                  revision: revision,
                  scope: scope,
                  kind: entry.kind,
                  thumbnailPolicy: thumbnail ? catalog.thumbnailPolicy : null,
                  thumbnailsEnabled: catalog.capabilities.contains(
                    GalleryCapability.thumbnails,
                  ),
                  thumbnailBaseUri: thumbnail
                      ? _uri([
                          'v2',
                          'thumbnail',
                          entry.mediaId,
                          revision,
                          '${catalog.thumbnailPolicy!.version}',
                        ])
                      : null,
                );
              })
              .toList(growable: false);
          return GalleryCatalogResult(
            List.unmodifiable(items),
            _protocol,
            catalog.catalogRevision,
          );
        }
      }
      if (refresh) _legacyEpoch++;
      final response = await _client.send(
        http.AbortableRequest(
          'GET',
          _uri(['list']),
          abortTrigger: abort.future,
        ),
      );
      if (!_isCurrent(generation, abort)) {
        await response.stream.listen((_) {}).cancel();
        throw const GalleryImageCancelled();
      }
      final data = await _jsonResponse(response);
      _check(generation, abort);
      final paths = data['items'];
      if (paths is! List || paths.any((entry) => entry is! String)) {
        throw const FormatException('Invalid gallery list');
      }
      // Query identity also bypasses the browser's old week-long legacy copy
      // after explicit refresh; memory eviction alone would not do so.
      final items = paths
          .cast<String>()
          .toSet()
          .map(
            (item) => GalleryItem(
              uri: _uri(
                ['get', ...item.split('/')],
                {'galleryEpoch': '$_legacyEpoch'},
              ),
              title: path.basename(item),
              mediaId: item,
              scope: authScope,
              revision: 'legacy:$_legacyEpoch',
            ),
          )
          .toList(growable: false);
      return GalleryCatalogResult(
        List.unmodifiable(items),
        GalleryProtocol.legacy,
        'legacy:$_legacyEpoch',
      );
    } finally {
      timer.cancel();
      if (identical(_activeAbort, abort)) _activeAbort = null;
    }
  }

  Future<Map<String, dynamic>> _jsonResponse(
    http.StreamedResponse response,
  ) async {
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

  bool _isCurrent(int generation, Completer<void> abort) =>
      !_closed && generation == _generation && !abort.isCompleted;

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
