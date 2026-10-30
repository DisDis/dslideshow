// Asynchronous filesystem work keeps HTTP and RPC event loops responsive.
// ignore_for_file: avoid_slow_async_io
import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'dart:io' as io;
import 'dart:isolate';

import 'package:crypto/crypto.dart';
import 'package:dslideshow_common/gallery.dart';

import '../service/discovery/frame_publisher.dart';

import 'package:dslideshow_backend/src/service/gallery/gallery_catalog_service.dart';
import 'package:dslideshow_backend/src/service/gallery/gallery_files.dart';
import 'package:dslideshow_backend/src/service/gallery/thumbnail_service.dart';

import 'media_file_responder.dart';
import 'web_socket_user.dart';
import 'gallery_management_routes.dart';
import '../service/gallery/gallery_tool_runner.dart';

import 'package:dslideshow_backend/src/service/storage/disk/disk_storage.dart';
import 'package:dslideshow_backend/src/service/upload/streaming_upload.dart';
import 'package:dslideshow_backend/src/web_server/web_server_routes.dart';
import 'package:path/path.dart' as path;

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:dslideshow_common/version.dart';
import 'package:logging/logging.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:shelf_virtual_directory/shelf_virtual_directory.dart';
import 'package:dslideshow_backend/environment.dart';

// Preserve the existing import path for WebSocket session consumers.
export 'web_socket_user.dart' show WebSocketUser, WebSocketUserStatus;

enum _GalleryRequestKind { catalog, refresh, original, thumbnail, legacyCatalog }

class WebService {
  static final _thumbnailPolicyPattern = RegExp(r'^[1-9][0-9]*(?:-[a-f0-9]{64})?$');
  static final Logger _log = new Logger('WebService');
  static final math.Random _rnd = math.Random();
  final io.Directory _cacheFolder;
  final StreamingUploadReceiver _uploadReceiver;
  final int _maxConcurrentUploads;
  final FramePublisher _framePublisher;
  late final io.Directory _galleryDirectory;
  late final GalleryCatalogService _galleryCatalog;
  late final ThumbnailService _thumbnails;
  late final MediaFileResponder _mediaFiles;
  late final GalleryManagementRoutes _galleryManagement;
  String? _encodedCatalogRevision;
  Future<String>? _encodedCatalog;

  final _uploads = <UploadCancellationToken, Completer<void>>{};
  bool _closed = false;
  Future<void> _serverTransition = Future<void>.value();

  Handler get handler => _router.call;

  Response _galleryResponse(
    _GalleryRequestKind kind,
    Response response, {
    GalleryErrorCode? reason,
    Object? error,
    String? mediaId,
  }) {
    final cancelled =
        error is ThumbnailFailure &&
        (error.kind == ThumbnailFailureKind.cancelled || error.kind == ThumbnailFailureKind.closed);
    _log.log(
      response.statusCode >= 500 && !_closed && !cancelled ? Level.WARNING : Level.FINE,
      () =>
          'Gallery ${kind.name} ${reason == null ? 'response' : 'rejected'} status=${response.statusCode}'
          '${reason == null ? '' : ' reason=${reason.name}'}'
          '${mediaId == null ? '' : ' media=id-${sha256.convert(utf8.encode(mediaId)).toString().substring(0, 12)}'}'
          '${error == null ? '' : ' type=${error.runtimeType}'}',
    );
    return response;
  }

  final RemoteService _remoteBackendService;
  String _code = '__';
  String get code => _code;
  final WebServerConfig _config;
  final AppConfig _appConfig;

  Router _router = Router();

  bool _enabled = false;
  bool get enabled => _enabled;

  Future<void> setEnabled(bool requested) {
    if (_closed) return Future.error(StateError('Web service is closed'));
    final target = requested || _config.alwaysEnabled;
    final result = _serverTransition.then((_) async {
      _log.info('Web control target=$target started');
      try {
        if (_closed) throw StateError('Web service is closed');
        _enabled = target;
        if (target) {
          await _startWebServer();
        } else {
          await _stopWebServer();
        }
        if (_closed) throw StateError('Web service is closed');
        _log.info('Web control target=$target completed');
      } catch (error) {
        _log.warning('Web control target=$target failed type=${error.runtimeType}');
        rethrow;
      }
    });
    // A failed command must reach its caller without poisoning later commands.
    _serverTransition = result.then<void>((_) {}, onError: (Object _) {});
    return result;
  }

  String _generateCode() {
    var sb = new StringBuffer();
    var count = 5;
    while (count > 0) {
      sb.write(_rnd.nextInt(10));
      count--;
    }
    if (_config.permanentCode.isNotEmpty) {
      return _config.permanentCode;
    }
    return sb.toString();
  }

  void updateCode() {
    _code = _generateCode();
    _log.info('Access code updated code=$_code');
  }

  WebService(
    this._appConfig,
    this._config,
    this._remoteBackendService, {
    io.Directory? cacheDirectory,
    io.Directory? galleryDirectory,
    ThumbnailWorker thumbnailWorker = const FfmpegThumbnailWorker(),
    ThumbnailPolicy? thumbnailPolicy,
    int? maxConcurrentMediaStreams,
    StreamingUploadReceiver? uploadReceiver,
    int maxConcurrentUploads = 2,
    GalleryToolRunner? galleryToolRunner,
    String duplicateExecutable = 'czkawka_cli',
    FramePublisher framePublisher = const NoopFramePublisher(),
    bool startServer = true,
  }) : _cacheFolder = cacheDirectory ?? io.Directory(path.join(externalStorage.path, DiskStorage.CACHE_FOLDER_NAME)),
       _uploadReceiver = uploadReceiver ?? StreamingUploadReceiver(),
       _framePublisher = framePublisher,
       _maxConcurrentUploads = maxConcurrentUploads {
    if (maxConcurrentUploads <= 0) {
      throw ArgumentError.value(maxConcurrentUploads, 'maxConcurrentUploads');
    }
    final effectiveThumbnailPolicy = thumbnailPolicy ?? ThumbnailPolicy.fromConfig(_appConfig.gallery.thumbnail);
    _galleryDirectory = galleryDirectory ?? galleryStateDirectory(_cacheFolder);
    _galleryCatalog = GalleryCatalogService(
      originals: _cacheFolder,
      stateDirectory: _galleryDirectory,
      thumbnailPolicy: effectiveThumbnailPolicy.catalogPolicy,
      additionalCapabilities: const [
        GalleryCapability.metadata,
        GalleryCapability.mutations,
        GalleryCapability.rotation,
        GalleryCapability.trash,
        GalleryCapability.duplicates,
      ],
    );
    _mediaFiles = MediaFileResponder(
      maxStreams: maxConcurrentMediaStreams ?? _appConfig.gallery.maxConcurrentMediaStreams,
    );
    _thumbnails = ThumbnailService(
      cacheDirectory: io.Directory(path.join(_galleryDirectory.path, 'thumbnails')),
      originalsDirectory: _cacheFolder,
      policy: effectiveThumbnailPolicy,
      worker: thumbnailWorker,
      isCurrent: (source) async {
        try {
          final current = await _galleryCatalog.resolve(source.mediaId, revision: source.revision);
          return current.absolutePath == source.path && current.fingerprint == source.fingerprintToken;
        } on GalleryCatalogFailure catch (error) {
          if (error.code == GalleryErrorCode.notFound || error.code == GalleryErrorCode.revisionMismatch) return false;
          if (error.code == GalleryErrorCode.busy) {
            throw const ThumbnailFailure(ThumbnailFailureKind.queueFull);
          }
          throw const ThumbnailFailure(ThumbnailFailureKind.closed);
        }
      },
    );
    _galleryManagement = GalleryManagementRoutes(
      catalog: _galleryCatalog,
      accessCode: () => _code,
      files: _mediaFiles,
      runner: galleryToolRunner,
      duplicateExecutable: duplicateExecutable,
    );
    _log.info(
      () =>
          'Gallery configured thumbnailWorker=${thumbnailWorker.runtimeType} '
          'policy=${effectiveThumbnailPolicy.catalogPolicy.identity} '
          'sizes=${effectiveThumbnailPolicy.sizes.map((size) => size.name).join(',')} '
          'quality=${effectiveThumbnailPolicy.jpegQuality} '
          'frames=${effectiveThumbnailPolicy.frameSelectionFrames} '
          'maxWorkers=${effectiveThumbnailPolicy.maxWorkers} '
          'maxQueued=${effectiveThumbnailPolicy.maxQueued} '
          'maxWaiters=${effectiveThumbnailPolicy.maxWaiters} '
          'timeoutMs=${effectiveThumbnailPolicy.workerTimeout.inMilliseconds}',
    );
    updateCode();
    _router.options(
      '/cache/<code>/<tail|.*>',
      (Request request, String code, String tail) => Response(code == _code ? 204 : 403, headers: galleryCorsHeaders),
    );
    _router.get('/cache/<code>/v2/catalog', _getCatalog);
    _router.post('/cache/<code>/v2/catalog/refresh', _refreshCatalog);
    _galleryManagement.register(_router);
    _router.get('/cache/<code>/v2/thumbnail/<id>/<revision>/<policy>/<bucket>', _getThumbnail);
    _router.get(WebServerRoutes.info, _getInfo);
    _router.get(WebServerRoutes.webSocket, _webSocketHandler);
    _router.get(WebServerRoutes.getMedialItemsList, _getItemsList);
    _router.get(WebServerRoutes.getMediaItem, _getItem);
    _router.post(WebServerRoutes.uploadMedia, _postUploadMedia);
    _router.get(WebServerRoutes.uploadMedia, _getUploadForm);

    final fsPath = path.join(io.Directory.current.path, 'web'); // path to server
    _log.info('Web routes configured logLevel=${Logger.root.level.name}');
    final virtualDir = ShelfVirtualDirectory(fsPath, defaultFile: 'index.html', default404File: '404.html');
    _router.mount('/', virtualDir.router);

    if (startServer) {
      unawaited(setEnabled(_config.alwaysEnabled).catchError((Object _) {}));
    }
    if (_config.alwaysEnabled) {
      _log.info('Web server alwaysEnabled=true');
    }
    if (_config.permanentCode.isNotEmpty) {
      _log.info('Permanent access code configured code=$_code');
    }
  }

  io.HttpServer? _server;

  Response _getUploadForm(Request request) {
    return Response.ok(_uploadMediaForm, headers: {'content-type': 'text/html; charset=utf-8'});
  }

  static const _uploadMediaForm =
      """
<html>
<head>
<title>Upload media file</title>
</head>
<body>
<form method="post" enctype="multipart/form-data">
 <div>
    <p>v${ApplicationInfo.frontendVersion}</p> 
    <p><b>Upload media file</b></p>
   <label for="file">Choose file to upload</label><Br>
   <input type="file" id="file" name="file" multiple>
 </div>
 <div>
   <button>Upload</button>
 </div>
</form>
</body>
</html>
""";

  Response _getInfo(Request request) {
    if (request.params.isNotEmpty && request.params.containsKey("format")) {
      if (request.params['format'] == 'json') {
        return Response.ok(_infoJSON, headers: {'content-type': 'text/json; charset=utf-8'});
      }
    }
    return Response.ok(_infoHtml, headers: {'content-type': 'text/html; charset=utf-8'});
  }

  static const _infoJSON =
      '{"version":{"frontend":"${ApplicationInfo.frontendVersion}","backend":"${ApplicationInfo.backendVersion}"}}';
  static const _infoHtml =
      """
<html>
<head>
<title>DSlideShow v${ApplicationInfo.frontendVersion}</title>
</head>
<body>
 <div>
    <p><b>DSlideShow</b></p>
    <p>frontend: v${ApplicationInfo.frontendVersion}</p> 
    <p>backend: v${ApplicationInfo.backendVersion}</p> 
    <p>Use ?format=json for JSON data</p>
 </div>
</body>
</html>
""";

  final _activeUsers = <WebSocketUser>[];
  Future<Response> _webSocketHandler(Request request) async {
    _log.fine('WebSocket upgrade requested');
    final response = await webSocketHandler((WebSocketChannel webSocket, _) {
      _log.fine('WebSocket upgrade accepted');
      final newUser = new WebSocketUser(_appConfig, _code, webSocket, request.headers, this._remoteBackendService);
      _activeUsers.add(newUser);
      _log.info('WebSocket connected active=${_activeUsers.length}');
      newUser.onDisconnect.then((dynamic value) {
        _activeUsers.remove(newUser);
        _log.info('WebSocket disconnected active=${_activeUsers.length}');
      });
    })(request);
    _log.log(
      response.statusCode >= 500 ? Level.WARNING : Level.FINE,
      'WebSocket upgrade rejected status=${response.statusCode} ',
    );
    return response;
  }

  Future<Response> _postUploadMedia(Request request, String code) async {
    if (_closed) return Response(503, body: 'Web server is closed');
    if (code != _code) return Response.forbidden('Code is incorrect');
    if (_uploads.length >= _maxConcurrentUploads) {
      return Response(429, body: 'Upload slots are busy', headers: {'retry-after': '1'});
    }

    final cancellation = UploadCancellationToken();
    final done = Completer<void>();
    _uploads[cancellation] = done;
    StagedUploadBatch? batch;
    final published = <String>[];
    final progressClock = Stopwatch()..start();
    var lastProgress = -250;
    try {
      batch = await _uploadReceiver.receiveMultipart(
        request,
        cancellation: cancellation,
        destinationFor: _mediaDestination,
        onField: (name, value) {
          throw UploadFailure(400, 'Unexpected form field');
        },
        onProgress: (received, total) {
          final now = progressClock.elapsedMilliseconds;
          if (now - lastProgress < 250) return;
          lastProgress = now;
          _log.fine('Receiving media: $received bytes');
        },
      );
      for (final file in batch.files) {
        if (_closed || cancellation.isCancelled) {
          throw UploadFailure(503, 'Upload cancelled');
        }
        await file.publish();
        published.add(file.filename);
        _galleryCatalog.markDirty();
      }
      _log.info('Media upload completed: ${published.length} file(s)');
      return Response.ok('File uploaded');
    } catch (error, stack) {
      final failure = uploadFailureFor(error);
      _log.warning('Media upload failed (${failure.statusCode})', error, stack);
      return Response(
        failure.statusCode,
        body: json.encode({'error': failure.message, 'published': published}),
        headers: {'content-type': 'application/json; charset=utf-8'},
      );
    } finally {
      try {
        await batch?.cleanup();
      } catch (error, stack) {
        _log.warning('Unable to clean up media upload', error, stack);
      }
      _uploads.remove(cancellation);
      done.complete();
    }
  }

  // Path validation is kept unchanged; hardening paths is a separate stage.
  String _mediaDestination(String itemPath) {
    itemPath = Uri.decodeFull(itemPath);
    final fullFilename = path.absolute(path.join(_cacheFolder.path, itemPath));
    if (!fullFilename.startsWith(_cacheFolder.path)) {
      throw UploadFailure(400, 'Outside cache folder');
    }
    return fullFilename;
  }

  Future<void> _startWebServer() async {
    _log.info('Web server listen requested');
    if (_server != null) {
      _log.fine('Web server already listening');
      return;
    }
    //HTTPS? securityContext: io.SecurityContext()
    io.HttpServer server = await io.serve(
      _router,
      io.InternetAddress.anyIPv4,
      _config.port,
      poweredByHeader: null,
      backlog: 32,
      shared: true,
    );
    if (_closed || !_enabled) {
      await server.close(force: true);
      return;
    }
    _server = server;

    server.idleTimeout = const Duration(seconds: 120);
    // Disable content compression
    // RaPi is SLOW CPU
    server.autoCompress = false;

    _log.info(
      'HTTP server listening port=${server.port} accessCode=$_code '
      'logLevel=${Logger.root.level.name}',
    );
    try {
      await _framePublisher.publish(server.port);
    } catch (error) {
      _log.warning('Advertisement publish failed type=${error.runtimeType}');
    }
  }

  Future<void> _stopWebServer() async {
    try {
      await _framePublisher.unpublish();
    } catch (error) {
      _log.warning('Advertisement removal failed type=${error.runtimeType}');
    }
    for (final cancellation in _uploads.keys.toList()) {
      cancellation.cancel();
    }
    final users = List<WebSocketUser>.of(_activeUsers);
    _activeUsers.clear();
    for (final user in users) {
      user.disconnect();
    }
    final server = _server;
    _server = null;
    await server?.close(force: true);
    if (server != null) _log.info('Web server stopped');
  }

  Future<void> close() async {
    _closed = true;
    _enabled = false;
    final pending = _uploads.values.map((done) => done.future).toList();
    await _serverTransition;
    await _stopWebServer();
    try {
      await _framePublisher.close();
    } catch (error) {
      _log.warning('Advertisement cleanup failed type=${error.runtimeType}');
    }
    await Future.wait(pending);
    await _galleryManagement.close();
    await _galleryCatalog.close();
    await _thumbnails.close();
    await _mediaFiles.close();
  }

  Future<Response> _getItemsList(Request request, String code) async {
    const kind = _GalleryRequestKind.legacyCatalog;
    Response reject(GalleryErrorCode code) => _galleryResponse(kind, _galleryError(code), reason: code);
    if (code != _code) return reject(GalleryErrorCode.forbidden);
    if (_closed) return reject(GalleryErrorCode.unavailable);
    final items = <String>[];
    if (await _cacheFolder.exists()) {
      await for (final item in _cacheFolder.list(recursive: true)) {
        if (_closed) return reject(GalleryErrorCode.unavailable);
        if (!isGalleryStagingPath(item.path)) items.add(path.relative(item.path, from: _cacheFolder.path));
      }
    }
    return _galleryResponse(
      kind,
      Response.ok(
        jsonEncode({'items': items}),
        headers: {
          ...galleryCorsHeaders,
          'content-type': 'application/json; charset=utf-8',
          'cache-control': 'private, no-cache',
        },
      ),
    );
  }

  Future<Response> _catalogResponse(GalleryCatalog catalog) async {
    if (_encodedCatalogRevision != catalog.catalogRevision) {
      _encodedCatalogRevision = catalog.catalogRevision;
      _encodedCatalog = Isolate.run(() => jsonEncode(catalog.toJson()));
    }
    final body = await _encodedCatalog!;
    return Response.ok(
      body,
      headers: {
        ...galleryCorsHeaders,
        'content-type': 'application/json; charset=utf-8',
        'cache-control': 'private, no-cache',
      },
    );
  }

  Future<Response> _getCatalog(Request request, String code) async {
    const kind = _GalleryRequestKind.catalog;
    if (code != _code)
      return _galleryResponse(kind, _galleryError(GalleryErrorCode.forbidden), reason: GalleryErrorCode.forbidden);
    try {
      final catalog = await _galleryCatalog.catalog();
      return _galleryResponse(kind, await _catalogResponse(catalog));
    } on GalleryCatalogFailure catch (error) {
      return _galleryResponse(kind, _galleryError(error.code), reason: error.code);
    } on Object catch (error) {
      return _galleryResponse(
        kind,
        _galleryError(GalleryErrorCode.unavailable),
        reason: GalleryErrorCode.unavailable,
        error: error,
      );
    }
  }

  Future<Response> _refreshCatalog(Request request, String code) async {
    const kind = _GalleryRequestKind.refresh;
    Response reject(GalleryErrorCode code, {Object? error}) =>
        _galleryResponse(kind, _galleryError(code), reason: code, error: error);
    if (code != _code) return reject(GalleryErrorCode.forbidden);
    try {
      final bytes = <int>[];
      await for (final chunk in request.read().timeout(const Duration(seconds: 5))) {
        if (bytes.length + chunk.length > 4096) return reject(GalleryErrorCode.invalidRequest);
        bytes.addAll(chunk);
      }
      final refresh = GalleryRefreshRequest.fromJson(jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>);
      final catalog = await _galleryCatalog.refresh(refresh);
      return _galleryResponse(kind, await _catalogResponse(catalog));
    } on GalleryCatalogFailure catch (error) {
      return reject(error.code);
    } on FormatException {
      return reject(GalleryErrorCode.invalidRequest);
    } on TypeError {
      return reject(GalleryErrorCode.invalidRequest);
    } on ArgumentError {
      return reject(GalleryErrorCode.invalidRequest);
    } on Object catch (error) {
      return reject(GalleryErrorCode.unavailable, error: error);
    }
  }

  Future<Response> _getThumbnail(
    Request request,
    String code,
    String id,
    String revision,
    String policy,
    String bucket,
  ) async {
    const kind = _GalleryRequestKind.thumbnail;
    Response reject(GalleryErrorCode reason, {Object? error}) =>
        _galleryResponse(kind, _galleryError(reason), reason: reason, error: error, mediaId: id);

    if (code != _code) return reject(GalleryErrorCode.forbidden);
    final size = int.tryParse(bucket);
    if (!_thumbnailPolicyPattern.hasMatch(policy) || size == null || size <= 0) {
      return reject(GalleryErrorCode.invalidRequest);
    }
    if (policy != _galleryCatalog.thumbnailPolicy.identity) {
      return reject(GalleryErrorCode.revisionMismatch);
    }
    if (!_galleryCatalog.thumbnailPolicy.sizes.any((item) => item.pixels == size)) {
      return reject(GalleryErrorCode.invalidRequest);
    }
    try {
      final source = await _galleryCatalog.resolve(id, revision: revision);
      if (!source.entry.thumbnailSupported) return reject(GalleryErrorCode.unsupported);
      final lease = await _thumbnails.acquire(
        ThumbnailSource(
          mediaId: id,
          revision: revision,
          path: source.absolutePath,
          fingerprintToken: source.fingerprint,
        ),
        ThumbnailVariantSpec(bucketId: bucket, size: size, policyRevision: _galleryCatalog.thumbnailPolicy.revision),
      );
      final response = await _mediaFiles.serve(
        request,
        io.File(lease.artifact.path),
        etag: lease.artifact.etag,
        contentType: lease.artifact.mimeType,
        cacheControl: 'private, max-age=604800, immutable',
        isCurrent: () => _galleryCatalog.isCurrent(source),
        onRelease: lease.release,
      );
      return _galleryResponse(kind, response);
    } on GalleryCatalogFailure catch (error) {
      return reject(error.code);
    } on ThumbnailFailure catch (error) {
      return reject(switch (error.kind) {
        ThumbnailFailureKind.queueFull => GalleryErrorCode.busy,
        ThumbnailFailureKind.staleSource => GalleryErrorCode.revisionMismatch,
        ThumbnailFailureKind.unsupported || ThumbnailFailureKind.sourceTooLarge => GalleryErrorCode.unsupported,
        _ => GalleryErrorCode.unavailable,
      }, error: error);
    } on Object catch (error) {
      return reject(GalleryErrorCode.unavailable, error: error);
    }
  }

  Response _galleryError(GalleryErrorCode code) => Response(
    switch (code) {
      GalleryErrorCode.invalidRequest => 400,
      GalleryErrorCode.forbidden => 403,
      GalleryErrorCode.notFound => 404,
      GalleryErrorCode.revisionMismatch => 409,
      GalleryErrorCode.unsupported => 415,
      GalleryErrorCode.busy => 429,
      _ => 503,
    },
    body: jsonEncode(GalleryErrorResponse(code).toJson()),
    headers: {
      ...galleryCorsHeaders,
      'content-type': 'application/json; charset=utf-8',
      'cache-control': 'no-store',
      if (code == GalleryErrorCode.busy || code == GalleryErrorCode.unavailable) 'retry-after': '1',
    },
  );

  Future<Response> _getItem(Request request, String code, String itemPath) async {
    const kind = _GalleryRequestKind.original;
    Response reject(GalleryErrorCode code) => _galleryResponse(kind, _galleryError(code), reason: code);
    if (code != _code) return reject(GalleryErrorCode.forbidden);
    if (_closed) return reject(GalleryErrorCode.unavailable);
    itemPath = Uri.decodeFull(itemPath);
    final absolute = path.absolute(path.join(_cacheFolder.path, itemPath));
    if (!absolute.startsWith(_cacheFolder.path)) return reject(GalleryErrorCode.notFound);
    try {
      GallerySource? source;
      final revision = request.url.queryParameters['rev'];
      if (revision != null) {
        source = await _galleryCatalog.resolvePath(
          path.relative(absolute, from: _cacheFolder.absolute.path),
          revision: revision,
        );
      }
      return _galleryResponse(
        kind,
        await _mediaFiles.serve(
          request,
          io.File(absolute),
          isCurrent: source == null ? null : () => _galleryCatalog.isCurrent(source!),
        ),
      );
    } on GalleryCatalogFailure catch (error) {
      return reject(error.code);
    }
  }
}
