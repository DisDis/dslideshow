// Хранить список всех файлов которые есть в облаке
abstract class MediaStorage{
  // удалённое хранилище
  bool get isRemote;
  // когда последний раз происходила синхронизация
  DateTime get lastSync;
  // принудительно синхронизироваться
  Future<Null> sync();
  Future<List<MediaItem>> getItems();
}

abstract class MediaItem{
  String get id;
  Uri get uri;
}