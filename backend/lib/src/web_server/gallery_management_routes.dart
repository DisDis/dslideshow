import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:dslideshow_common/gallery.dart';
import 'package:logging/logging.dart';
import 'package:mime/mime.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../service/gallery/gallery_catalog_service.dart';
import '../service/gallery/gallery_duplicate_service.dart';
import '../service/gallery/gallery_file_operations.dart';
import '../service/gallery/gallery_media_tools.dart';
import '../service/gallery/gallery_tool_runner.dart';
import 'media_file_responder.dart';

enum _GalleryManagementRoute {
  metadata,
  rotation,
  trashCatalog,
  trashOriginal,
  trashMetadata,
  mutation,
  duplicateStatus,
  duplicateGroup,
  duplicateStart,
  duplicateStop,
}

/// Authenticated file operations share one lifecycle with the web service.
class GalleryManagementRoutes {
  static final _log = Logger('GalleryManagementRoutes');
  final String Function() accessCode;
  final MediaFileResponder files;
  late final GalleryFileOperations operations;
  late final GalleryMediaTools tools;
  late final GalleryDuplicateService duplicates;
  final GalleryToolRunner _runner;
  final bool _ownsRunner;
  bool _closed = false;
  Future<void>? _closing;

  GalleryManagementRoutes({
    required GalleryCatalogService catalog,
    required this.accessCode,
    required this.files,
    GalleryToolRunner? runner,
    String duplicateExecutable = 'czkawka_cli',
    Directory? trashDirectory,
  }) : _runner = runner ?? ProcessGalleryToolRunner(),
       _ownsRunner = runner == null {
    operations = GalleryFileOperations(
      catalog: catalog,
      trashDirectory: trashDirectory,
      beforeMutation: (request) => duplicates.validateTrash(request),
    );
    tools = GalleryMediaTools(
      catalog: catalog,
      runner: _runner,
      operations: operations,
    );
    duplicates = GalleryDuplicateService(
      catalog: catalog,
      runner: _runner,
      executable: duplicateExecutable,
    );
  }

  void register(Router router) {
    router.get('/cache/<code>/v2/metadata/<id>/<revision>', _metadata);
    router.post('/cache/<code>/v2/rotate', _rotate);
    router.get('/cache/<code>/v2/trash', _trash);
    router.get(
      '/cache/<code>/v2/trash/original/<id>/<revision>',
      _trashOriginal,
    );
    router.get(
      '/cache/<code>/v2/trash/metadata/<id>/<revision>',
      _trashMetadata,
    );
    router.post('/cache/<code>/v2/operations', _operate);
    router.get('/cache/<code>/v2/duplicates', _duplicateStatus);
    router.get(
      '/cache/<code>/v2/duplicates/<id>/groups/<index>',
      _duplicateGroup,
    );
    router.post('/cache/<code>/v2/duplicates', _startDuplicates);
    router.post('/cache/<code>/v2/duplicates/<id>/stop', _stopDuplicates);
  }

  Future<Response> _guard(
    String code,
    _GalleryManagementRoute route,
    Future<Response> Function() work,
  ) async {
    final clock = Stopwatch()..start();
    final closedAtStart = _closed;
    Response rejected(GalleryErrorCode failure, [Object? error]) {
      final response = _error(failure);
      _reportFailure(
        route,
        failure,
        response.statusCode,
        clock,
        errorType: error?.runtimeType.toString(),
        shuttingDown: closedAtStart,
      );
      return response;
    }

    if (code != accessCode()) return rejected(GalleryErrorCode.forbidden);
    if (_closed) return rejected(GalleryErrorCode.unavailable);
    try {
      final response = await work();
      if (response.statusCode >= 400) {
        final failure = switch (response.statusCode) {
          400 => GalleryErrorCode.invalidRequest,
          403 => GalleryErrorCode.forbidden,
          404 => GalleryErrorCode.notFound,
          409 => GalleryErrorCode.revisionMismatch,
          413 => GalleryErrorCode.outputLimitExceeded,
          415 => GalleryErrorCode.unsupported,
          429 => GalleryErrorCode.busy,
          504 => GalleryErrorCode.timeout,
          _ => GalleryErrorCode.unavailable,
        };
        _reportFailure(
          route,
          failure,
          response.statusCode,
          clock,
          shuttingDown: closedAtStart,
        );
      } else {
        _log.fine(
          'Gallery management response ready route=${route.name} '
          'httpStatus=${response.statusCode} elapsedMs=${clock.elapsedMilliseconds}',
        );
      }
      return response;
    } on GalleryCatalogFailure catch (error) {
      return rejected(error.code, error);
    } on TimeoutException catch (error) {
      return rejected(GalleryErrorCode.timeout, error);
    } on FormatException catch (error) {
      return rejected(GalleryErrorCode.invalidRequest, error);
    } on ArgumentError catch (error) {
      return rejected(GalleryErrorCode.invalidRequest, error);
    } on TypeError catch (error) {
      return rejected(GalleryErrorCode.invalidRequest, error);
    } on FileSystemException catch (error) {
      return rejected(GalleryErrorCode.unavailable, error);
    } on Object catch (error) {
      return rejected(GalleryErrorCode.processingFailed, error);
    }
  }

  void _reportFailure(
    _GalleryManagementRoute route,
    GalleryErrorCode code,
    int status,
    Stopwatch clock, {
    String? errorType,
    bool shuttingDown = false,
  }) {
    final unexpected =
        status >= 500 ||
        code == GalleryErrorCode.processingFailed ||
        code == GalleryErrorCode.outputLimitExceeded;
    _log.log(
      unexpected && !shuttingDown && code != GalleryErrorCode.cancelled
          ? Level.WARNING
          : Level.FINE,
      'Gallery management request rejected route=${route.name} '
      'httpStatus=$status code=${code.name} type=${errorType ?? 'none'} '
      'elapsedMs=${clock.elapsedMilliseconds}',
    );
  }

  Future<Response> _metadata(
    Request request,
    String code,
    String id,
    String revision,
  ) => _guard(
    code,
    _GalleryManagementRoute.metadata,
    () async => _json((await tools.metadata(id, revision: revision)).toJson()),
  );

  Future<Response> _rotate(Request request, String code) =>
      _guard(code, _GalleryManagementRoute.rotation, () async {
        final command = GalleryRotateRequest.fromJson(await _body(request));
        return _json((await tools.rotate(command)).toJson());
      });

  Future<Response> _trash(Request request, String code) => _guard(
    code,
    _GalleryManagementRoute.trashCatalog,
    () async => _json((await operations.trashCatalog()).toJson()),
  );

  Future<GalleryTrashEntry> _trashEntry(String id, String revision) async {
    return operations.resolveTrashEntry(id, revision: revision);
  }

  Future<Response> _trashOriginal(
    Request request,
    String code,
    String id,
    String revision,
  ) => _guard(code, _GalleryManagementRoute.trashOriginal, () async {
    final entry = await _trashEntry(id, revision);
    final file = await operations.resolveTrash(id, revision: revision);
    return files.serve(
      request,
      file,
      contentType: lookupMimeType(entry.name),
      isCurrent: () async {
        try {
          await operations.resolveTrash(id, revision: revision);
          return true;
        } on GalleryCatalogFailure {
          return false;
        }
      },
    );
  });

  Future<Response> _trashMetadata(
    Request request,
    String code,
    String id,
    String revision,
  ) => _guard(code, _GalleryManagementRoute.trashMetadata, () async {
    final entry = await _trashEntry(id, revision);
    final file = await operations.resolveTrash(id, revision: revision);
    final data = await tools.trashMetadata(entry, file);
    await operations.resolveTrash(id, revision: revision);
    return _json(data.toJson());
  });

  Future<Response> _operate(Request request, String code) =>
      _guard(code, _GalleryManagementRoute.mutation, () async {
        final command = GalleryOperationRequest.fromJson(await _body(request));
        return _json((await operations.mutate(command)).toJson());
      });

  Future<Response> _duplicateStatus(Request request, String code) => _guard(
    code,
    _GalleryManagementRoute.duplicateStatus,
    () async => _json((await duplicates.status()).toJson()),
  );

  Future<Response> _duplicateGroup(
    Request request,
    String code,
    String id,
    String index,
  ) => _guard(code, _GalleryManagementRoute.duplicateGroup, () async {
    final position = int.tryParse(index);
    if (position == null) {
      throw const GalleryCatalogFailure(GalleryErrorCode.invalidRequest);
    }
    return _json((await duplicates.group(id, position)).toJson());
  });

  Future<Response> _startDuplicates(Request request, String code) =>
      _guard(code, _GalleryManagementRoute.duplicateStart, () async {
        final command = GalleryDuplicateStartRequest.fromJson(
          await _body(request),
        );
        return _json((await duplicates.start(command)).toJson());
      });

  Future<Response> _stopDuplicates(Request request, String code, String id) =>
      _guard(
        code,
        _GalleryManagementRoute.duplicateStop,
        () async => _json((await duplicates.stop(id)).toJson()),
      );

  Future<Map<String, dynamic>> _body(Request request) async {
    final bytes = BytesBuilder(copy: false);
    var size = 0;
    await for (final chunk in request.read().timeout(
      const Duration(seconds: 5),
    )) {
      size += chunk.length;
      if (size > 256 * 1024)
        throw const GalleryCatalogFailure(GalleryErrorCode.invalidRequest);
      bytes.add(chunk);
    }
    final decoded = jsonDecode(utf8.decode(bytes.takeBytes()));
    if (decoded is! Map<String, dynamic>)
      throw const FormatException('Expected object');
    return decoded;
  }

  Future<Response> _json(Map<String, dynamic> data) async => Response.ok(
    await Isolate.run(() => jsonEncode(data)),
    headers: {
      ...galleryCorsHeaders,
      'content-type': 'application/json; charset=utf-8',
      'cache-control': 'no-store',
    },
  );

  Response _error(GalleryErrorCode code) => Response(
    switch (code) {
      GalleryErrorCode.invalidRequest => 400,
      GalleryErrorCode.forbidden => 403,
      GalleryErrorCode.notFound => 404,
      GalleryErrorCode.revisionMismatch ||
      GalleryErrorCode.conflict ||
      GalleryErrorCode.cancelled => 409,
      GalleryErrorCode.unsupported => 415,
      GalleryErrorCode.outputLimitExceeded => 413,
      GalleryErrorCode.processingFailed => 422,
      GalleryErrorCode.busy => 429,
      GalleryErrorCode.timeout => 504,
      _ => 503,
    },
    body: jsonEncode(GalleryErrorResponse(code).toJson()),
    headers: {
      ...galleryCorsHeaders,
      'content-type': 'application/json; charset=utf-8',
      'cache-control': 'no-store',
      if (code == GalleryErrorCode.busy || code == GalleryErrorCode.unavailable)
        'retry-after': '1',
    },
  );

  Future<void> close() => _closing ??= _close();

  Future<void> _close() async {
    _closed = true;
    await Future.wait([duplicates.close(), tools.close()]);
    await operations.close();
    if (_ownsRunner) await _runner.close();
  }
}
