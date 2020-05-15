import 'dart:convert';
import 'dart:io';
//import 'package:crazy_pigs_backend/result_service/src/result_service_config.dart';
//import 'package:crazy_pigs_backend/universe_service/src/universe_config.dart';
//import 'package:crazy_pigs_backend/world_service/src/avatar_config.dart';
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

  _LogConfig _logConfig;
  _LogConfig get log => _logConfig??=new _LogConfig(_config["log"] as Map<String, dynamic>);

  HardwareConfig _hardware;
  HardwareConfig get hardware => _hardware??=new HardwareConfig(_config["hardware"] as Map<String, dynamic>);

  Map<String, dynamic> _storageSection;
  Map<String, dynamic> get storageSection => _storageSection??=(_config["storage"]==null?<String, dynamic>{}: _config["storage"] as Map<String, dynamic>);
}

abstract class BaseConfig{
  static final Logger _log = new Logger('BaseConfig');
  final Map<String, dynamic> _config;
  BaseConfig(Map<String, dynamic> config): _config = config??<String, dynamic>{};

  T readValue<T>(String field, [T defaultValue]){
    var value = _config[field] as T;
    if (value == null){
      if (defaultValue == null){
        throw new Exception('Field "$field" not set.');
      }
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