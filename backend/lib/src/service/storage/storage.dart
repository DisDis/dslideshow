// Хранить список всех файлов которые есть в облаке
import 'package:dslideshow_backend/src/service/storage/mediaitem.dart';
import 'package:dslideshow_backend/src/service/storage/storage_type.dart';

abstract class Storage {
  DateTime get lastSync;
  Stream<DateTime> get onEndSync;
  Stream<DateTime> get onStartSync;
  StorageType get type;

  Future<MediaItem?> getCurrent();

  // когда последний раз происходила синхронизация
  Future<MediaItem?> getNext();
  // принудительно синхронизироваться
  Future init();
  // Вернуть текищий
  Future<MediaItem?> next();
  // Вернуть следующий
  Future release();
  // Осуществить сдвиг
  Future<Null> sync();
}
