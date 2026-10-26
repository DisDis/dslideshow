import 'dart:async';
import 'dart:io';

import 'package:dslideshow_backend/src/service/gallery/gallery_media_publisher.dart';
import 'package:dslideshow_backend/src/service/upload/streaming_upload.dart';

import 'package:dslideshow_backend/app_storage.dart';
import 'package:dslideshow_backend/src/service/googlephoto/googlephoto.dart';
import 'package:dslideshow_backend/src/service/storage/disk/disk_storage.dart';
import 'package:dslideshow_backend/src/service/storage/mediaitem.dart';
import 'package:dslideshow_backend/src/service/storage/storage_type.dart' as st;
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;

import 'gphoto_storage_config.dart';

class GPhotoMediaItem extends MediaItem {
  GPhotoMediaItem(String id, Uri uri) : super(id, uri);
}

class GPhotoStorage extends DiskStorage {
  static const String GPhotoStorage_lastSync = "GPhotoStorage_lastSync";
  static const String GPhotoStorage_accessTokenData =
      "GPhotoStorage_accessTokenData";
  static const String GPhotoStorage_accessTokenExpiry =
      "GPhotoStorage_accessTokenExpiry";

  static final Logger _log = new Logger('GPhotoStorage');
  final GPhotoStorageConfig _config;
  static const String name = 'GPhotoStorage';
  GooglePhotoService? _googlePhotoService;
  GooglePhotoService? get googlePhotoService => _googlePhotoService;

  @override
  DateTime lastSync = new DateTime.fromMicrosecondsSinceEpoch(1);
  bool _syncInProcess = false;
  bool _released = false;
  Timer? _syncTimer;
  StreamSubscription<dynamic>? _credentialsSubscription;
  final Set<HttpClient> _downloadClients = {};
  final Set<UploadCancellationToken> _downloadCancellations = {};
  final Set<Future<void>> _downloads = {};

  final StreamController<DateTime> _scStartSync =
      new StreamController.broadcast();
  final StreamController<DateTime> _scEndSync =
      new StreamController.broadcast();
  @override
  Stream<DateTime> get onStartSync => _scStartSync.stream;
  @override
  Stream<DateTime> get onEndSync => _scEndSync.stream;

  final AppStorage _appStorage;

  GPhotoStorage(
    this._config,
    this._appStorage, {
    Directory? folder,
    GooglePhotoService? googlePhotoService,
  }) : super(_config, folder: folder) {
    final accessTokenData = _appStorage.getValue<String>(
      GPhotoStorage_accessTokenData,
      '',
    );
    final accessTokenExpiryStr = _appStorage.getValue<String>(
      GPhotoStorage_accessTokenExpiry,
      '',
    );
    final accessTokenExpiry = accessTokenExpiryStr == ''
        ? new DateTime.now().toUtc()
        : DateTime.parse('$accessTokenExpiryStr');
    final lastSyncStr = _appStorage.getValue<String>(
      GPhotoStorage_lastSync,
      '',
    );
    if (lastSyncStr.isNotEmpty) {
      lastSync = DateTime.parse(lastSyncStr);
    }
    _googlePhotoService =
        googlePhotoService ??
        new GooglePhotoService(
          _config.clientId.identifier,
          _config.clientId.secret,
          _config.refreshToken,
          accessTokenData,
          accessTokenExpiry,
        );
    _credentialsSubscription = _googlePhotoService!.onUpdateCredentials.listen((
      event,
    ) {
      _appStorage.setValue(
        GPhotoStorage_accessTokenData,
        event.accessToken.data,
      );
      _appStorage.setValue(
        GPhotoStorage_accessTokenExpiry,
        event.accessToken.expiry.toIso8601String(),
      );
    });
  }

  @override
  final st.StorageType type = st.StorageType.remote;

  String _getFileName(GooglePhotoItem item) {
    final ext = item.mimeType!.substring(item.mimeType!.indexOf('/') + 1);
    return '${item.id}_${_config.imageWidth}x${_config.imageHeight}.${ext}';
  }

  @override
  Future<Null> sync() async {
    if (_released) return null;
    _log.info(
      'sync GPhoto Albums:"${_config.albumNames}" ${_config.imageWidth}x${_config.imageHeight}',
    );
    if (_syncInProcess) {
      _log.info('synchronization in progress');
      return;
    }
    var delta = new DateTime.now().difference(lastSync);
    if (delta < _config.syncPeriod) {
      _log.info(
        'last sync was done at $lastSync d:${delta}, period: ${_config.syncPeriod}',
      );
      return;
    }
    _syncInProcess = true;

    final syncDate = new DateTime.now();
    _scStartSync.add(syncDate);

    try {
      for (String albumName in _config.albumNames) {
        if (_released) return;
        _log.info('sync GPhoto Album:"${albumName}"');
        final items = await _googlePhotoService!.getMediaItemInAlbum(
          albumName,
          _config.imageWidth,
          _config.imageHeight,
        );
        final Map<String, GooglePhotoItem> itemMap = new Map.fromIterables(
          items.map((e) => _getFileName(e)),
          items,
        );
        if (_released) return;
        await folder.create(recursive: true);
        if (_released) return;
        final localItems = (await folder.list().toList()).map(
          (e) => path.basename(e.path),
        );
        if (_released) return;
        localItems.forEach((element) => itemMap.remove(element));

        var allItems = itemMap.keys.length;
        _log.info('Detect ${allItems} new media item(s)');

        var count = 0;
        await Future.forEach(itemMap.keys, (String fileName) async {
          var googleItem = itemMap[fileName]!;
          _log.info(
            '  downloading "${googleItem.id}": type=${googleItem.mimeType}',
          );
          if (_released) return;
          final operation = _download(googleItem, fileName);
          _downloads.add(operation);
          try {
            await operation;
          } finally {
            _downloads.remove(operation);
          }
          count++;
          _log.info(
            '  downloaded $count/$allItems(${(count * 100 / allItems).truncate()}%), "$fileName"',
          );
        });
      }

      if (_released) return;
      _scEndSync.add(syncDate);
      lastSync = syncDate;
      _appStorage.setValue<String>(
        GPhotoStorage_lastSync,
        lastSync.toIso8601String(),
      );
      return;
    } finally {
      _syncInProcess = false;
    }
  }

  Future<void> _download(GooglePhotoItem item, String filename) async {
    final client = HttpClient()
      ..connectionTimeout = const Duration(seconds: 30);
    final cancellation = UploadCancellationToken();
    _downloadClients.add(client);
    _downloadCancellations.add(cancellation);
    try {
      final request = await client
          .getUrl(Uri.parse(item.url))
          .timeout(const Duration(seconds: 30));
      final response = await request.close().timeout(
        const Duration(seconds: 30),
      );
      if (_released) throw const UploadFailure(503, 'Storage closed');
      if (response.statusCode != HttpStatus.ok)
        throw const UploadFailure(502, 'Media download failed');
      await GalleryMediaPublisher(originals: folder).publish(
        response,
        filename,
        contentLength: response.contentLength < 0
            ? null
            : response.contentLength,
        cancellation: cancellation,
      );
    } finally {
      client.close(force: true);
      _downloadClients.remove(client);
      _downloadCancellations.remove(cancellation);
    }
  }

  @override
  Future init() async {
    if (_released) return;
    _log.info('init');
    _startSync();
    await super.init();
    if (_released) return;
    _log.info('Start periodic sync timer d:${_config.syncPeriod}');
    _syncTimer ??= new Timer.periodic(_config.syncPeriod, (_) {
      _startSync();
    });
  }

  void _startSync() {
    if (_released) return;
    unawaited(
      Future<Null>.sync(sync).catchError((Object error, StackTrace stack) {
        _log.warning('Background synchronization failed', error, stack);
        return null;
      }),
    );
  }

  @override
  Future release() async {
    _released = true;
    final storageReleased = super.release();
    if (_syncTimer != null) {
      _syncTimer!.cancel();
      _syncTimer = null;
    }
    for (final cancellation in _downloadCancellations.toList()) {
      cancellation.cancel('Storage closed');
    }
    for (final client in _downloadClients.toList()) {
      client.close(force: true);
    }
    if (_downloads.isNotEmpty) {
      await Future.wait(
        _downloads.toList().map(
          (operation) => operation.then<void>(
            (_) {},
            onError: (Object _, StackTrace __) {},
          ),
        ),
      );
    }
    // Detaching the credential listener is synchronous; a notification stream's
    // completion must not keep hardware shutdown waiting for consumers.
    final credentials = _credentialsSubscription;
    _credentialsSubscription = null;
    if (credentials != null) unawaited(credentials.cancel());
    await storageReleased;
    // Notification consumers may pause indefinitely; they do not own shutdown.
    unawaited(_scStartSync.close());
    unawaited(_scEndSync.close());
  }
}
