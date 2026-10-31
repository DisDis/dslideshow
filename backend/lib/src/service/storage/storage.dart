// Хранить список всех файлов которые есть в облаке
import 'dart:async';

import 'package:dslideshow_backend/src/service/storage/mediaitem.dart';
import 'package:dslideshow_backend/src/service/storage/storage_type.dart';
import 'package:dslideshow_common/storage_status.dart';
import 'package:logging/logging.dart';

export 'package:dslideshow_common/storage_status.dart';

abstract class Storage {
  static final _log = Logger('Storage');
  final _statusChanges = StreamController<StorageStatusEnum>.broadcast();
  StorageStatusEnum _status = StorageStatusEnum.done;

  StorageStatusEnum get status => _status;
  Stream<StorageStatusEnum> get onStatusChanged => _statusChanges.stream;

  void updateStatus(StorageStatusEnum value) {
    if (_status == value) return;
    _status = value;
    _log.info('Storage status changed type=${type.name} status=${value.name}');
    _statusChanges.add(value);
  }

  /// Notification consumers do not own or delay provider shutdown.
  void closeStatusNotifications() => unawaited(_statusChanges.close());

  DateTime get lastSync;
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
