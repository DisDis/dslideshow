import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:dslideshow_backend/src/service/storage/disk/disk_storage_config.dart';
import 'package:dslideshow_backend/src/service/storage/mediaitem.dart';
import 'package:dslideshow_backend/src/service/storage/storage.dart';
import 'package:dslideshow_backend/environment.dart';
import 'package:dslideshow_backend/src/service/storage/storage_type.dart';
import 'package:logging/logging.dart';
//import 'package:database/database.dart';
import 'package:path/path.dart' as path;

class DiskMediaItem extends MediaItem {
  DiskMediaItem(String? id, Uri? uri) : super(id, uri);
}

class DiskStorage extends Storage {
  static const String CACHE_FOLDER_NAME = 'images';
  static final Logger _log = new Logger('DiskStorage');
  static const String name = 'DiskStorage';
  final Directory _folder = new Directory(path.join(externalStorage.path, DiskStorage.CACHE_FOLDER_NAME));
  final DiskStorageConfig _config;
  Directory get folder => _folder;

  final StreamController<DateTime> _scStub = new StreamController.broadcast();
  @override
  Stream<DateTime> get onStartSync => _scStub.stream;
  @override
  Stream<DateTime> get onEndSync => _scStub.stream;

  // Choose a database
//  static final _database = MemoryDatabaseAdapter().database();
  // Our collection
//  final Collection _items = _database.collection('items');

  final Random _rnd = new Random(new DateTime.now().millisecondsSinceEpoch);

  DiskStorage(this._config);

  MediaItem? _current;
  MediaItem? _next;

  @override
  Future<MediaItem?> getCurrent() async {
    return _current;
  }

  @override
  Future<MediaItem?> getNext() async {
    return _next;
  }

  @override
  DateTime get lastSync => new DateTime.now();

  List<Uri> _cache = <Uri>[];

  Future<Uri?> _getRandomItem() async {
    if (_cache.isEmpty) {
      final items = await _folder.listSync();
      if (items.isEmpty) {
        return null;
      }
      _cache = items.map((e) => e.uri).toList(growable: true);
      _log.info('File cache has ${_cache.length} file(s)');
    }
    return _cache.removeAt(_rnd.nextInt(_cache.length));
  }

  static final _nullMediaItem = new DiskMediaItem(null, null);

  @override
  Future<MediaItem?> next() async {
    _current = _next;
    final nextUri = await _getRandomItem();
    _next = nextUri == null ? _nullMediaItem : new DiskMediaItem(nextUri.path, nextUri);
    return _next;
  }

  @override
  Future<Null> sync() async {
    return;
  }

  @override
  final StorageType type = StorageType.local;

  StreamSubscription? _watchSubscription;

  @override
  Future init() async {
    try {
      _watchSubscription = _folder.watch().listen(_onFolderUpdated);
    } catch (e, st) {
      _log.fine('init', e, st);
    }
    await next();
    await next();
  }

  Future release() async {
    if (_watchSubscription != null) {
      _watchSubscription!.cancel();
    }
  }

  Timer? _timerFolderUpdate;
  void _onFolderUpdated(FileSystemEvent event) {
    if (_timerFolderUpdate != null) {
      //_log.info('Storage folder changed, wait...');
      return;
    }
    _log.info('Storage folder changed, run timer');
    _timerFolderUpdate = new Timer(Duration(minutes: 1), () {
      _log.info('File cache flushed');
      _timerFolderUpdate = null;
      _cache = <Uri>[];
    });
  }
}
