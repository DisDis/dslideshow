import 'package:dslideshow_backend/src/service/googlephoto/googlephoto.dart';
import 'package:dslideshow_backend/src/service/storage/disk/disk_storage.dart';
import 'package:dslideshow_backend/src/service/storage/storage.dart';

import 'gphoto_storage_config.dart';

class GPhotoMediaItem extends MediaItem{
  GPhotoMediaItem(String id, Uri uri):super(id, uri);
}

class GPhotoStorage extends DiskStorage{
  final GPhotoStorageConfig _config;
  GooglePhotoService _googlePhotoService;
  GPhotoStorage(Map<String, dynamic> config): this._config= new GPhotoStorageConfig(config) , super(config){
    _googlePhotoService = new GooglePhotoService(_config.clientId.identifier,_config.clientId.secret,_config.refreshToken);
  }

  @override
  final StorageType type = StorageType.remote;

  @override
  Future<Null> init() async{
    _googlePhotoService.run();
    await super.init();
  }
}