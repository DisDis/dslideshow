import 'dart:async';
import 'dart:io';

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/src/service/googlephoto/googlephoto.dart';
import 'package:dslideshow_backend/src/service/storage/disk/disk_storage.dart';
import 'package:dslideshow_backend/src/service/storage/mediaitem.dart';
import 'package:dslideshow_backend/src/service/storage/storage_type.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;

import 'gphoto_storage_config.dart';

class GPhotoMediaItem extends MediaItem{
  GPhotoMediaItem(String id, Uri uri):super(id, uri);
}

class GPhotoStorage extends DiskStorage{
  static const String GPhotoStorage_lastSync = "GPhotoStorage_lastSync";
  static const String GPhotoStorage_accessTokenData = "GPhotoStorage_accessTokenData";
  static const String GPhotoStorage_accessTokenExpiry = "GPhotoStorage_accessTokenExpiry";

  static final Logger _log = new Logger('GPhotoStorage');
  final GPhotoStorageConfig _config;
  static const String name = 'GPhotoStorage';
  GooglePhotoService _googlePhotoService;
  GooglePhotoService get googlePhotoService => _googlePhotoService;

  @override
  DateTime lastSync = new DateTime.fromMicrosecondsSinceEpoch(1);
  bool _syncInProcess = false;
  Timer _syncTimer;

  final StreamController<DateTime> _scStartSync = new StreamController.broadcast();
  final StreamController<DateTime> _scEndSync = new StreamController.broadcast();
  @override
  Stream<DateTime> get onStartSync => _scStartSync.stream;
  @override
  Stream<DateTime> get onEndSync => _scEndSync.stream;

  final AppStorage _appStorage;

  GPhotoStorage(Map<String, dynamic> config, AppStorage this._appStorage): this._config = new GPhotoStorageConfig(config) , super(config){
    final accessTokenData = _appStorage.getValue<String>(GPhotoStorage_accessTokenData,'');
    final accessTokenExpiryStr = _appStorage.getValue<String>(GPhotoStorage_accessTokenExpiry,'');
    final accessTokenExpiry = accessTokenExpiryStr == ''?new DateTime.now().toUtc(): DateTime.parse('$accessTokenExpiryStr');
    final lastSyncStr = _appStorage.getValue<String>(GPhotoStorage_lastSync,'');
    if (lastSyncStr.isNotEmpty){
      lastSync = DateTime.parse(lastSyncStr);
    }
    _googlePhotoService = new GooglePhotoService(_config.clientId.identifier,_config.clientId.secret,_config.refreshToken,accessTokenData, accessTokenExpiry);
    _googlePhotoService.onUpdateCredentials.listen((event) {
      _appStorage.setValue(GPhotoStorage_accessTokenData, event.accessToken.data);
      _appStorage.setValue(GPhotoStorage_accessTokenExpiry, event.accessToken.expiry.toIso8601String());
    });
  }

  @override
  final StorageType type = StorageType.remote;

  String _getFileName(GooglePhotoItem item){
    final ext = item.mimeType.substring(item.mimeType.indexOf('/')+1);
    return '${item.id}_${_config.imageWidth}x${_config.imageHeight}.${ext}';
  }

  @override
  Future<Null> sync() async {
    _log.info('sync GPhoto Albums:"${_config.albumNames}" ${_config.imageWidth}x${_config.imageHeight}');
    if (_syncInProcess) {
      _log.info('synchronization in progress');
      return;
    }
    var delta = new DateTime.now().difference(lastSync);
    if (delta < _config.syncPeriod) {
      _log.info('last sync was done at $lastSync d:${delta}, period: ${_config.syncPeriod}');
      return;
    }
    _syncInProcess = true;

    final syncDate = new DateTime.now();
    _scStartSync.add(syncDate);

    for (String albumName in _config.albumNames) {
      _log.info('sync GPhoto Album:"${albumName}"');
      final items = await _googlePhotoService.getMediaItemInAlbum(albumName, _config.imageWidth, _config.imageHeight);
      final Map<String, GooglePhotoItem> itemMap = new Map.fromIterables(items.map((e) => _getFileName(e)), items);
      final localItems = (await folder.listSync()).map((e) => path.basename(e.path));
      localItems.forEach((element) => itemMap.remove(element));

      var allItems = itemMap.keys.length;
      _log.info('Detect ${allItems} new media item(s)');

      var count = 0;
      await Future.forEach(itemMap.keys, (String fileName) async {
        var googleItem = itemMap[fileName];
        _log.info('  downloading "${googleItem.id}": type=${googleItem.mimeType}');
        HttpClient client = new HttpClient();
        await client.getUrl(Uri.parse(googleItem.url))
            .then((HttpClientRequest request) {
          return request.close();
        })
            .then((HttpClientResponse response) {
          response.pipe(new File(path.join(folder.path, fileName)).openWrite());
        });
        count++;
        _log.info('  downloaded $count/$allItems(${(count * 100 / allItems).truncate()}%), "$fileName"');
      });
    }

    _scEndSync.add(syncDate);
    lastSync = syncDate;
    _appStorage.setValue<String>(GPhotoStorage_lastSync, lastSync.toIso8601String());
    _syncInProcess = false;
    return;
  }


  @override
  Future init() async{
    _log.info('init');
    sync();
    await super.init();
    _log.info('Start periodic sync timer d:${_config.syncPeriod}');
    _syncTimer = new Timer.periodic(_config.syncPeriod, (_){
      sync();
    });
  }

  @override
  Future release() async{
    if (_syncTimer != null){
      _syncTimer.cancel();
      _syncTimer = null;
    }
    super.release();
  }
}