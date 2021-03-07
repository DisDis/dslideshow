// Какой следующий медиа файл показать?
import 'package:dslideshow_backend/src/service/media_shuffle/cache.dart';
import 'package:dslideshow_backend/src/service/storage/storage.dart';
import 'package:logging/logging.dart';
import 'dart:convert';

class MediaShuffle{
  static const int _supportVersion = 1;
  static const String versionKey = 'ver';
  static const String itemsKey = 'items';
  static final Logger _log = new Logger('MediaShuffle');
  final ShuffleAlgorithm _algorithm;
  final Map<String, int> _mediaItems = new Map<String, int>();
  final MediaCache _mediaCache;

  MediaShuffle(this._algorithm, this._mediaCache){
    _loadState();
  }

  void _loadState() {
    _log.info('Loading state...');
    //TODO: add load from file
    final String jsonData = '{"$versionKey":1,"$itemsKey":{}}';
    var state = json.decode(jsonData) as Map<String, dynamic>;
    final version = state[versionKey] as String?;
    if (version != _supportVersion) {
      _log.warning('Unsupport state version "$version" != "$_supportVersion"');
      return;
    }
    var items = state[itemsKey] as Map<String, int>?;
    if (items == null){
      _log.warning('"items" is null');
      return;
    }
    _mediaItems.addAll(items);
    _log.info('State loaded');
  }

  String getCurrent(){
    return '';
  }
}

class ShuffleAlgorithm{

}

