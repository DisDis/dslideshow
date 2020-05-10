import 'package:dslideshow_backend/src/service/storage/storage.dart';
import 'package:logging/logging.dart';

// Переносит если это необходимо на локальный диск медиа файлы, кэшируя их
class MediaCache{
  static final Logger _log = new Logger('MediaCache');
  // путь где размещается кэш
  final String path;
  final int maxSize;
  int get size=> _size;
  int _size = 0;
  final MediaStorage storage;

  MediaCache(this.path, this.maxSize, this.storage);
}