// Хранить список всех файлов которые есть в облаке
abstract class Storage{
  Future<Null> init();

  StorageType get type;
  // когда последний раз происходила синхронизация
  DateTime get lastSync;
  // принудительно синхронизироваться
  Future<Null> sync();
  // Вернуть текищий
  Future<MediaItem> getCurrent();
  // Вернуть следующий
  Future<MediaItem> getNext();
  // Осуществить сдвиг
  Future<MediaItem> next();
}

class MediaItem{
  final String id;
  final Uri uri;

  MediaItem(this.id, this.uri);
}


enum StorageType{
  local,
  remote
}