import 'dart:io';
import 'dart:math';

import 'package:dslideshow_backend/src/service/storage/disk/disk_storage_config.dart';
import 'package:dslideshow_backend/src/service/storage/storage.dart';
import 'package:dslideshow_backend/environment.dart';
import 'package:logging/logging.dart';
//import 'package:database/database.dart';
import 'package:path/path.dart' as path;

class DiskMediaItem extends MediaItem{
  DiskMediaItem(String id, Uri uri):super(id, uri);
}

class DiskStorage extends Storage{
  static final Logger _log = new Logger('DiskStorage');
  final Directory _folder = new Directory(path.join(externalStorage.path, 'images'));
  final DiskStorageConfig _config;
  // Choose a database
//  static final _database = MemoryDatabaseAdapter().database();
  // Our collection
//  final Collection _items = _database.collection('items');

  final Random _rnd = new Random(new DateTime.now().millisecondsSinceEpoch);

  DiskStorage(Map<String, dynamic> config): this._config= new DiskStorageConfig(config){
  }

  MediaItem _current;
  MediaItem _next;

  @override
  Future<MediaItem> getCurrent() async{
    return _current;
  }

  @override
  Future<MediaItem> getNext() async{
    return _next;
  }

  @override
  DateTime get lastSync => new DateTime.now();


  Future<Uri> _getRandomItem() async{
    final items = await _folder.listSync();
    if (items.length == 0){
      return null;
    }
    final index = _rnd.nextInt(items.length);
    return items[index].uri;
  }

  @override
  Future<MediaItem> next() async{
    _current = _next;
    var nextUri = await _getRandomItem();
    _next = new DiskMediaItem(nextUri.path, nextUri);
    return _next;
  }

  @override
  Future<Null> sync() async{
    return;
  }

  @override
  final StorageType type = StorageType.local;

  @override
  Future<Null> init() async{
    await next();
    await next();
    return;
  }
}