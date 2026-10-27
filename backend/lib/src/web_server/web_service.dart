// Asynchronous filesystem work keeps HTTP and RPC event loops responsive.
// ignore_for_file: avoid_slow_async_io
import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'dart:io' as io;
import 'dart:isolate';

import 'package:dslideshow_common/gallery.dart';
import 'package:dslideshow_backend/src/service/gallery/gallery_catalog_service.dart';
import 'package:dslideshow_backend/src/service/gallery/gallery_publication.dart';
import 'package:dslideshow_backend/src/service/gallery/thumbnail_service.dart';

import 'media_file_responder.dart';
import 'web_socket_user.dart';

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

class WebService {
  static final Logger _log = new Logger('WebService');
  static final math.Random _rnd = math.Random();
  final io.Directory _cacheFolder;
  final StreamingUploadReceiver _uploadReceiver;
  final int _maxConcurrentUploads;
  late final io.Directory _galleryDirectory;
  late final GalleryCatalogService _galleryCatalog;
  late final ThumbnailService _thumbnails;
  late final MediaFileResponder _mediaFiles;
  String? _encodedCatalogRevision;
  Future<String>? _encodedCatalog;

  final _uploads = <UploadCancellationToken, Completer<void>>{};
  bool _closed = false;
  Future<void> _serverTransition = Future<void>.value();

  Handler get handler => _router.call;

  final RemoteService _remoteBackendService;
  String _code = '__';
  String get code => _code;
  final WebServerConfig _config;
  final AppConfig _appConfig;

  Router _router = Router();

  bool _enabled = false;
  bool get enabled => _enabled;

  void set enabled(bool newvalue) {
    if (_closed) return;
    if (_config.alwaysEnabled) {
      newvalue = true;
    }
    if (newvalue == _enabled) {
      return;
    }
    _enabled = newvalue;
    _serverTransition = _serverTransition
        .then((_) async {
          if (_closed || !_enabled) {
            await _stopWebServer();
          } else {
            await _startWebServer();
          }
        })
        .catchError((Object error, StackTrace stack) {
          _log.severe('Unable to update web server', error, stack);
        });
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
    _log.info('New code: $_code');
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
    bool startServer = true,
  }) : _cacheFolder =
           cacheDirectory ??
           io.Directory(
             path.join(externalStorage.path, DiskStorage.CACHE_FOLDER_NAME),
           ),
       _uploadReceiver = uploadReceiver ?? StreamingUploadReceiver(),
       _maxConcurrentUploads = maxConcurrentUploads {
    if (maxConcurrentUploads <= 0) {
      throw ArgumentError.value(maxConcurrentUploads, 'maxConcurrentUploads');
    }
    final effectiveThumbnailPolicy =
        thumbnailPolicy ??
        ThumbnailPolicy.fromConfig(_appConfig.gallery.thumbnail);
    _galleryDirectory = galleryDirectory ?? galleryStateDirectory(_cacheFolder);
    _galleryCatalog = GalleryCatalogService(
      originals: _cacheFolder,
      stateDirectory: _galleryDirectory,
      thumbnailPolicy: effectiveThumbnailPolicy.catalogPolicy,
    );
    _mediaFiles = MediaFileResponder(
      maxStreams:
          maxConcurrentMediaStreams ??
          _appConfig.gallery.maxConcurrentMediaStreams,
    );
    _thumbnails = ThumbnailService(
      cacheDirectory: io.Directory(
        path.join(_galleryDirectory.path, 'thumbnails'),
      ),
      originalsDirectory: _cacheFolder,
      policy: effectiveThumbnailPolicy,
      worker: thumbnailWorker,
      isCurrent: (source) async {
        try {
          final current = await _galleryCatalog.resolve(
            source.mediaId,
            revision: source.revision,
          );
          return current.absolutePath == source.path &&
              current.fingerprint == source.fingerprintToken;
        } on GalleryCatalogFailure catch (error) {
          if (error.code == GalleryErrorCode.notFound ||
              error.code == GalleryErrorCode.revisionMismatch)
            return false;
          if (error.code == GalleryErrorCode.busy) {
            throw const ThumbnailFailure(ThumbnailFailureKind.queueFull);
          }
          throw const ThumbnailFailure(ThumbnailFailureKind.closed);
        }
      },
    );
    updateCode();
    _router.options(
      '/cache/<code>/<tail|.*>',
      (Request request, String code, String tail) =>
          Response(code == _code ? 204 : 403, headers: galleryCorsHeaders),
    );
    _router.get('/cache/<code>/v2/catalog', _getCatalog);
    _router.post('/cache/<code>/v2/catalog/refresh', _refreshCatalog);
    _router.get(
      '/cache/<code>/v2/thumbnail/<id>/<revision>/<policy>/<bucket>',
      _getThumbnail,
    );
    _router.get(WebServerRoutes.info, _getInfo);
    _router.get(WebServerRoutes.webSocket, _webSocketHandler);
    _router.get(WebServerRoutes.getMedialItemsList, _getItemsList);
    _router.get(WebServerRoutes.getMediaItem, _getItem);
    _router.post(WebServerRoutes.uploadMedia, _postUploadMedia);
    _router.get(WebServerRoutes.uploadMedia, _getUploadForm);

    final fsPath = path.join(
      io.Directory.current.path,
      'web',
    ); // path to server
    _log.info("WebServer root: $fsPath");
    final virtualDir = ShelfVirtualDirectory(
      fsPath,
      defaultFile: 'index.html',
      default404File: '404.html',
    );
    _router.mount('/', virtualDir.router);

    if (startServer) enabled = _config.alwaysEnabled;
    if (_config.alwaysEnabled) {
      _log.warning('Web server always on');
    }
    if (_config.permanentCode.isNotEmpty) {
      _log.severe('Permanent code enabled = "$_code"');
    }
  }

  io.HttpServer? _server;

  Response _getUploadForm(Request request) {
    return Response.ok(
      _uploadMediaForm,
      headers: {'content-type': 'text/html; charset=utf-8'},
    );
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
        return Response.ok(
          _infoJSON,
          headers: {'content-type': 'text/json; charset=utf-8'},
        );
      }
    }
    return Response.ok(
      _infoHtml,
      headers: {'content-type': 'text/html; charset=utf-8'},
    );
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
    _log.info('_webSocketHandler');
    return webSocketHandler((WebSocketChannel webSocket, _) {
      final newUser = new WebSocketUser(
        _appConfig,
        _code,
        webSocket,
        request.headers,
        this._remoteBackendService,
      );
      _activeUsers.add(newUser);
      newUser.onDisconnect.then((dynamic value) {
        _activeUsers.remove(newUser);
      });
    })(request);
  }

  Future<Response> _postUploadMedia(Request request, String code) async {
    if (_closed) return Response(503, body: 'Web server is closed');
    if (code != _code) return Response.forbidden('Code is incorrect');
    if (_uploads.length >= _maxConcurrentUploads) {
      return Response(
        429,
        body: 'Upload slots are busy',
        headers: {'retry-after': '1'},
      );
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
        final publication = await GalleryPublication.begin(
          _galleryDirectory,
          path.relative(file.destination, from: _cacheFolder.absolute.path),
        );
        try {
          await file.publish();
          published.add(file.filename);
        } finally {
          await publication.finish();
        }
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
    _log.info('_startServer');
    if (_server != null) {
      _log.info('Is the server running?');
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
      'Serving at http://${server.address.host}:${server.port} authCode:$_code',
    );
  }

  Future<void> _stopWebServer() async {
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
  }

  Future<void> close() async {
    _closed = true;
    _enabled = false;
    final pending = _uploads.values.map((done) => done.future).toList();
    await _stopWebServer();
    await _serverTransition;
    await Future.wait(pending);
    await _galleryCatalog.close();
    await _thumbnails.close();
    await _mediaFiles.close();
  }

  Future<Response> _getItemsList(Request request, String code) async {
    if (code != _code) return _galleryError(GalleryErrorCode.forbidden);
    if (_closed) return _galleryError(GalleryErrorCode.unavailable);
    final items = <String>[];
    if (await _cacheFolder.exists()) {
      await for (final item in _cacheFolder.list(recursive: true)) {
        if (_closed) return _galleryError(GalleryErrorCode.unavailable);
        if (!isGalleryStagingPath(item.path))
          items.add(path.relative(item.path, from: _cacheFolder.path));
      }
    }
    return Response.ok(
      jsonEncode({'items': items}),
      headers: {
        ...galleryCorsHeaders,
        'content-type': 'application/json; charset=utf-8',
        'cache-control': 'private, no-cache',
      },
    );
  }

  Future<Response> _catalogResponse(GalleryCatalog catalog) async {
    if (_encodedCatalogRevision != catalog.catalogRevision) {
      _encodedCatalogRevision = catalog.catalogRevision;
      _encodedCatalog = Isolate.run(() => jsonEncode(catalog.toJson()));
    }
    return Response.ok(
      await _encodedCatalog!,
      headers: {
        ...galleryCorsHeaders,
        'content-type': 'application/json; charset=utf-8',
        'cache-control': 'private, no-cache',
      },
    );
  }

  Future<Response> _getCatalog(Request request, String code) async {
    if (code != _code) return _galleryError(GalleryErrorCode.forbidden);
    try {
      return await _catalogResponse(await _galleryCatalog.catalog());
    } on GalleryCatalogFailure catch (error) {
      return _galleryError(error.code);
    } on Object {
      return _galleryError(GalleryErrorCode.unavailable);
    }
  }

  Future<Response> _refreshCatalog(Request request, String code) async {
    if (code != _code) return _galleryError(GalleryErrorCode.forbidden);
    try {
      final bytes = <int>[];
      await for (final chunk in request.read().timeout(
        const Duration(seconds: 5),
      )) {
        if (bytes.length + chunk.length > 4096)
          return _galleryError(GalleryErrorCode.invalidRequest);
        bytes.addAll(chunk);
      }
      final refresh = GalleryRefreshRequest.fromJson(
        jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>,
      );
      return await _catalogResponse(await _galleryCatalog.refresh(refresh));
    } on GalleryCatalogFailure catch (error) {
      return _galleryError(error.code);
    } on FormatException {
      return _galleryError(GalleryErrorCode.invalidRequest);
    } on TypeError {
      return _galleryError(GalleryErrorCode.invalidRequest);
    } on ArgumentError {
      return _galleryError(GalleryErrorCode.invalidRequest);
    } on Object {
      return _galleryError(GalleryErrorCode.unavailable);
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
    if (code != _code) return _galleryError(GalleryErrorCode.forbidden);
    final size = int.tryParse(bucket);
    if (!RegExp(r'^[1-9][0-9]*(?:-[a-f0-9]{64})?$').hasMatch(policy) ||
        size == null ||
        size <= 0) {
      return _galleryError(GalleryErrorCode.invalidRequest);
    }
    if (policy != _galleryCatalog.thumbnailPolicy.identity) {
      return _galleryError(GalleryErrorCode.revisionMismatch);
    }
    if (!_galleryCatalog.thumbnailPolicy.sizes.any(
      (item) => item.pixels == size,
    )) {
      return _galleryError(GalleryErrorCode.invalidRequest);
    }
    try {
      final source = await _galleryCatalog.resolve(id, revision: revision);
      if (!source.entry.thumbnailSupported)
        return _galleryError(GalleryErrorCode.unsupported);
      final lease = await _thumbnails.acquire(
        ThumbnailSource(
          mediaId: id,
          revision: revision,
          path: source.absolutePath,
          fingerprintToken: source.fingerprint,
        ),
        ThumbnailVariantSpec(
          bucketId: bucket,
          size: size,
          policyRevision: _galleryCatalog.thumbnailPolicy.revision,
        ),
      );
      return await _mediaFiles.serve(
        request,
        io.File(lease.artifact.path),
        etag: lease.artifact.etag,
        contentType: lease.artifact.mimeType,
        cacheControl: 'private, max-age=604800, immutable',
        isCurrent: () => _galleryCatalog.isCurrent(source),
        onRelease: lease.release,
      );
    } on GalleryCatalogFailure catch (error) {
      return _galleryError(error.code);
    } on ThumbnailFailure catch (error) {
      return _galleryError(switch (error.kind) {
        ThumbnailFailureKind.queueFull => GalleryErrorCode.busy,
        ThumbnailFailureKind.staleSource => GalleryErrorCode.revisionMismatch,
        ThumbnailFailureKind.unsupported ||
        ThumbnailFailureKind.sourceTooLarge => GalleryErrorCode.unsupported,
        _ => GalleryErrorCode.unavailable,
      });
    } on Object {
      return _galleryError(GalleryErrorCode.unavailable);
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
      if (code == GalleryErrorCode.busy || code == GalleryErrorCode.unavailable)
        'retry-after': '1',
    },
  );

  Future<Response> _getItem(
    Request request,
    String code,
    String itemPath,
  ) async {
    if (code != _code) return _galleryError(GalleryErrorCode.forbidden);
    if (_closed) return _galleryError(GalleryErrorCode.unavailable);
    itemPath = Uri.decodeFull(itemPath);
    final absolute = path.absolute(path.join(_cacheFolder.path, itemPath));
    if (!absolute.startsWith(_cacheFolder.path))
      return _galleryError(GalleryErrorCode.notFound);
    try {
      GallerySource? source;
      final revision = request.url.queryParameters['rev'];
      if (revision != null) {
        source = await _galleryCatalog.resolvePath(
          path.relative(absolute, from: _cacheFolder.absolute.path),
          revision: revision,
        );
      }
      return await _mediaFiles.serve(
        request,
        io.File(absolute),
        isCurrent: source == null
            ? null
            : () => _galleryCatalog.isCurrent(source!),
      );
    } on GalleryCatalogFailure catch (error) {
      return _galleryError(error.code);
    }
  }
}
