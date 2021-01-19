import 'dart:async';
import 'dart:convert';
import 'dart:io';
//import 'package:crazy_pigs_backend/result_service/src/result_service_config.dart';
//import 'package:crazy_pigs_backend/universe_service/src/universe_config.dart';
//import 'package:crazy_pigs_backend/world_service/src/avatar_config.dart';
import 'package:dslideshow_backend/src/service/mqtt/mqtt_config.dart';
import 'package:dslideshow_backend/src/web_server/web_server_config.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:dslideshow_backend/src/service/hardware/hardware.dart';

class AppConfig{
  static const String CONFIG_FILE = "config.json";
  static final Logger _log = new Logger('AppConfig');
  Map<String, dynamic> _config;
  AppConfig([String rootPath]){
    var config = new File(rootPath!=null ? path.join(rootPath,CONFIG_FILE):CONFIG_FILE) ;
    String configStr;
    if (!config.existsSync()){
      _log.fine('Not found config file "$config"');
      //exit(1);
      configStr = '{}';
    } else {
      configStr = config.readAsStringSync();
    }
    _config = json.decode(configStr) as Map<String,dynamic>;
    _log.info("Config loaded");
  }
  AppConfig.json(String data){
    _config = json.decode(data) as Map<String,dynamic>;
    _log.info("Config loaded");
  }

  _LogConfig _logConfig;
  _LogConfig get log => _logConfig??=new _LogConfig(_config["log"] as Map<String, dynamic>);

  HardwareConfig _hardware;
  HardwareConfig get hardware => _hardware??=new HardwareConfig(_config["hardware"] as Map<String, dynamic>);

  SlideShowConfig _slideShowConfig;
  SlideShowConfig get slideshow => _slideShowConfig??=new SlideShowConfig(_config["slideshow"] as Map<String, dynamic>);

  WebServerConfig _webServerConfig;
  WebServerConfig get webServer => _webServerConfig??=new WebServerConfig(_config["web"] as Map<String, dynamic>);

  MqttConfig _mqtt;
  MqttConfig get mqtt => _mqtt??=new MqttConfig(_config["mqtt"] as Map<String, dynamic>);

  Map<String, dynamic> _storageSection;
  Map<String, dynamic> get storageSection => _storageSection??=(_config["storage"]==null?<String, dynamic>{}: _config["storage"] as Map<String, dynamic>);
}

class SlideShowConfig  extends BaseConfig {

  int _displayTime;

  /// How long the image is shown
  int get displayTimeMs => _displayTime ??= readInt("displayTimeMs", 5000);

  int _fadeTime;

  int get fadeTimeMs => _fadeTime ??= readInt("fadeTimeMs", 2000);

  int _transitionTimeMs;
  /// How long do images change
  int get transitionTimeMs => _transitionTimeMs ??= readInt("transitionTimeMs", 1000);

  Iterable<String> _allowedEffects;

  /// Allowed effects
  Iterable<String> get allowedEffects => _allowedEffects ??=
        List<String>()..addAll(readValue<List<dynamic>>("allowedEffects", <dynamic>[]).map((dynamic i) => i.toString()));

  bool _isBlurredBackground;

  ///create a blurred background
  bool get isBlurredBackground => _isBlurredBackground ??= readValue("isBlurredBackground", true);

  SlideShowConfig(Map<String, dynamic> config) :super(config);
}

class AppStorage{
  static const String STORAGE_FILE = "storage.json";
  static final Logger _log = new Logger('AppStorage');
  Map<String, dynamic> _storage;
  final File _storageFile;
  Timer _saveTimer;

  AppStorage([String rootPath]): this._storageFile = new File(rootPath!=null ? path.join(rootPath,AppStorage.STORAGE_FILE):AppStorage.STORAGE_FILE){
    load();
  }

  void load() {
    _log.info('load');
    String configStr;
    if (!_storageFile.existsSync()){
      _log.fine('Not found storage file "$_storageFile"');
      configStr = '{}';
    } else {
      configStr = _storageFile.readAsStringSync();
    }
    _storage = json.decode(configStr) as Map<String,dynamic>;
    _log.info("Storage loaded");
  }
  void save() {
    _log.info('save');
    if (_saveTimer != null) {
      _saveTimer.cancel();
      _saveTimer = null;
    }
    String contents = json.encode(_storage);
    _storageFile.writeAsStringSync(contents);
    _log.info("Storage saved");
  }

  /// Autosave every 10 sec
  void setValue<T>(String key, T value){
   _storage[key] = value;
   if (_saveTimer == null) {
     _saveTimer = new Timer(new Duration(seconds: 10), (){
       save();
     });
   }
  }

  T getValue<T>(String field, [T defaultValue]){
    var value = _storage[field] as T;
    if (value == null){
      if (defaultValue == null){
        throw new Exception('Field "$field" not set.');
      }
      return defaultValue;
    }
    return value;
  }
  dynamic getRaw(String field)=> _storage[field];

  int getInt(String field, int defaultValue) {
    dynamic value = getRaw(field);
    if (value == null){
      _log.fine('Field "$field" not set. Set default value: "$defaultValue"');
      return defaultValue;
    }
    if (value is int){
      return value;
    }
    return int.parse(value as String, onError: (val) {
      _log.fine('Could not parse value "$val" (field "$field") into a number.');
      return defaultValue;
    });
  }

}

abstract class BaseConfig{
  static final Logger _log = new Logger('BaseConfig');
  final Map<String, dynamic> _config;
  BaseConfig(Map<String, dynamic> config): _config = config??<String, dynamic>{};

  T readValue<T>(String field, [T defaultValue]){
    dynamic tmp = _config[field];
    T value = null;
    if (tmp is T){
      value = tmp;
    } else {
      _log.fine('Field "$field" expects "$T", actual "${tmp==null?'null':tmp.runtimeType}"');
    }
    if (value == null) {
      if (defaultValue == null) {
        throw new Exception('Field "$field" not set.');
      }
      _log.fine('Field "$field" not set. Set default value: "$defaultValue"');
      return defaultValue;
    }
    return value;
  }
  dynamic readRaw(String field)=> _config[field];
  Level readLogLevel(String field, [Level defaultValue = Level.ALL]) => _parseLog(readRaw(field) as String, defaultValue);

  Level _parseLog(String value, Level defaultValue){
    return Level.LEVELS.firstWhere((item)=>item.toString() == value, orElse: ()=>defaultValue);
  }

  int readInt(String field, int defaultValue) {
    dynamic value = readRaw(field);
    if (value == null){
      _log.fine('Field "$field" not set. Set default value: "$defaultValue"');
      return defaultValue;
    }
    if (value is int){
      return value;
    }
    return int.parse(value as String, onError: (val) {
      _log.fine('Could not parse value "$val" (field "$field") into a number.');
      return defaultValue;
    });
  }
}

class _LogConfig extends BaseConfig{
  Level get levelWeb=>readLogLevel("web");
  Level get levelMain=>readLogLevel("main");
  Level get levelHwFrame=>readLogLevel("hw_frame");

  _LogConfig(Map<String, dynamic> config):super(config);
}