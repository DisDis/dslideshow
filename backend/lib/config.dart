import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dslideshow_backend/src/service/mqtt/mqtt_config.dart';
import 'package:dslideshow_backend/src/web_server/web_server_config.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:dslideshow_backend/src/service/hardware/hardware.dart';
import 'package:json_annotation/json_annotation.dart';

part 'config.g.dart';

@JsonSerializable()
class AppConfig {
  static const String CONFIG_FILE = "config.json";
  static final Logger _log = new Logger('AppConfig');
  @JsonKey(fromJson: _parseLog)
  LogConfig log;
  @JsonKey(fromJson: _parseHardware)
  HardwareConfig hardware;
  @JsonKey(fromJson: _parseSlideshow)
  SlideShowConfig slideshow;
  @JsonKey(fromJson: _parseWelcome)
  WelcomeConfig welcome;
  @JsonKey(fromJson: _parseWebServer)
  WebServerConfig webServer;
  @JsonKey(fromJson: _parseMQTT)
  MqttConfig mqtt;

  AppConfig(
      {required this.hardware,
      required this.log,
      required this.slideshow,
      required this.welcome,
      required this.webServer,
      required this.mqtt,
      required this.storageSection});

  @JsonKey(ignore: true)
  String fullConfigFilename = '';

  @JsonKey(fromJson: _parseStorageSection)
  Map<String, dynamic> storageSection;

  factory AppConfig.fromJson(Map<String, dynamic> json) => _$AppConfigFromJson(json);
  factory AppConfig.fromFile([String? rootPath]) {
    String fullConfigFilename = rootPath != null ? path.join(rootPath, CONFIG_FILE) : CONFIG_FILE;
    var config = new File(fullConfigFilename);
    String configStr;
    if (!config.existsSync()) {
      _log.fine('Not found config file "$config"');
      //exit(1);
      configStr = '{}';
    } else {
      configStr = config.readAsStringSync();
    }
    var _config = json.decode(configStr) as Map<String, dynamic>?;
    _log.info("Config loaded");
    return AppConfig.fromJson(_config!)..fullConfigFilename = fullConfigFilename;
  }

  void toFile([String? filenameOutput]) {
    final fileName = filenameOutput ?? fullConfigFilename;
    File(fileName)
      ..openWrite()
      ..writeAsStringSync(json.encode(this.toJson()));
  }

  Map<String, dynamic> toJson() => _$AppConfigToJson(this);

  static HardwareConfig _parseHardware(dynamic data) {
    final dataV = data is Map<String, dynamic> ? data : <String, dynamic>{};
    return new HardwareConfig.fromJson(dataV);
  }

  static LogConfig _parseLog(dynamic data) {
    final dataV = data is Map<String, dynamic> ? data : <String, dynamic>{};
    return new LogConfig.fromJson(dataV);
  }

  static SlideShowConfig _parseSlideshow(dynamic data) {
    final dataV = data is Map<String, dynamic> ? data : <String, dynamic>{};
    return new SlideShowConfig.fromJson(dataV);
  }

  static WelcomeConfig _parseWelcome(dynamic data) {
    final dataV = data is Map<String, dynamic> ? data : <String, dynamic>{};
    return new WelcomeConfig.fromJson(dataV);
  }

  static WebServerConfig _parseWebServer(dynamic data) {
    final dataV = data is Map<String, dynamic> ? data : <String, dynamic>{};
    return new WebServerConfig.fromJson(dataV);
  }

  static MqttConfig _parseMQTT(dynamic data) {
    final dataV = data is Map<String, dynamic> ? data : <String, dynamic>{};
    return new MqttConfig.fromJson(dataV);
  }

  static Map<String, dynamic> _parseStorageSection(dynamic data) {
    final dataV = data is Map<String, dynamic> ? data : <String, dynamic>{};
    return dataV;
  }
}

@JsonSerializable()
class SlideShowConfig {
  @JsonKey(defaultValue: 5000)
  int displayTimeMs;

  @JsonKey(defaultValue: 2000)
  int fadeTimeMs;

  /// How long do images change
  @JsonKey(defaultValue: 1000)
  int transitionTimeMs;

  /// Allowed effects
  @JsonKey(fromJson: _parseAllowedEffects)
  Iterable<String> allowedEffects;

  static List<String> _parseAllowedEffects(dynamic value) {
    final valueI = value is List<dynamic> ? value : <dynamic>[];
    return List<String>.from(valueI.map<String>((dynamic i) => i.toString()));
  }

  ///create a blurred background
  @JsonKey(defaultValue: true)
  bool isBlurredBackground;

  @JsonKey(defaultValue: 20)
  int backgroundBlurSigma;
  @JsonKey(defaultValue: 0.9)
  double backgroundOpacity;
  static const int DEFAULT_BACKGROUND_COLOR = 0xFFFFFFFF;
  @JsonKey(defaultValue: SlideShowConfig.DEFAULT_BACKGROUND_COLOR, fromJson: _parseColor, toJson: _colorToJson)
  int backgroundColor;
  static int _parseColor(dynamic value) {
    if (value is int) {
      return value;
    }
    if (value is String) {
      return int.tryParse(value, radix: 16) ?? SlideShowConfig.DEFAULT_BACKGROUND_COLOR;
    }
    return SlideShowConfig.DEFAULT_BACKGROUND_COLOR;
  }

  static String _colorToJson(int color) {
    return color.toRadixString(16);
  }

  SlideShowConfig(
      {required this.allowedEffects,
      required this.backgroundBlurSigma,
      required this.backgroundColor,
      required this.backgroundOpacity,
      required this.displayTimeMs,
      required this.fadeTimeMs,
      required this.isBlurredBackground,
      required this.transitionTimeMs});

  factory SlideShowConfig.fromJson(Map<String, dynamic> json) => _$SlideShowConfigFromJson(json);

  Map<String, dynamic> toJson() => _$SlideShowConfigToJson(this);
}

@JsonSerializable()
class WelcomeConfig {
  @JsonKey(defaultValue: "Welcome")
  String text;

  @JsonKey(defaultValue: 100)
  double size;

  @JsonKey(defaultValue: 2000)
  int delayMs;

  WelcomeConfig({required this.delayMs, required this.size, required this.text});
  factory WelcomeConfig.fromJson(Map<String, dynamic> json) => _$WelcomeConfigFromJson(json);

  Map<String, dynamic> toJson() => _$WelcomeConfigToJson(this);
}

class AppStorage {
  static const String STORAGE_FILE = "storage.json";
  static final Logger _log = new Logger('AppStorage');
  Map<String, dynamic>? _storage;
  final File _storageFile;
  Timer? _saveTimer;

  AppStorage([String? rootPath])
      : this._storageFile =
            new File(rootPath != null ? path.join(rootPath, AppStorage.STORAGE_FILE) : AppStorage.STORAGE_FILE) {
    load();
  }

  void load() {
    _log.info('load');
    String configStr;
    if (!_storageFile.existsSync()) {
      _log.fine('Not found storage file "$_storageFile"');
      configStr = '{}';
    } else {
      configStr = _storageFile.readAsStringSync();
    }
    try {
      _storage = json.decode(configStr) as Map<String, dynamic>?;
    } catch (e, st) {
      _log.severe("Storage.json", e, st);
      _storage = <String, dynamic>{};
    }
    _log.info("Storage loaded");
  }

  void save() {
    _log.info('save');
    if (_saveTimer != null) {
      _saveTimer!.cancel();
      _saveTimer = null;
    }
    String contents = json.encode(_storage);
    _storageFile.writeAsStringSync(contents);
    _log.info("Storage saved");
  }

  /// Autosave every 10 sec
  void setValue<T>(String key, T value) {
    _storage![key] = value;
    if (_saveTimer == null) {
      _saveTimer = new Timer(new Duration(seconds: 10), () {
        save();
      });
    }
  }

  T getValue<T>(String field, [T? defaultValue]) {
    var value = _storage![field] as T?;
    if (value == null) {
      if (defaultValue == null) {
        throw new Exception('Field "$field" not set.');
      }
      return defaultValue;
    }
    return value;
  }

  dynamic getRaw(String field) => _storage![field];

  int getInt(String field, int defaultValue) {
    dynamic value = getRaw(field);
    if (value == null) {
      _log.fine('Field "$field" not set. Set default value: "$defaultValue"');
      return defaultValue;
    }
    if (value is int) {
      return value;
    }
    final valueO = int.tryParse(value as String);
    if (valueO == null) {
      _log.fine('Could not parse value "$value" (field "$field") into a number.');
      return defaultValue;
    } else {
      return valueO;
    }
  }
}

@JsonSerializable()
class LogConfig {
  @JsonKey(name: "web", fromJson: _parseLogLevel, toJson: _logLevelToJson)
  Level levelWeb;
  @JsonKey(name: "main", fromJson: _parseLogLevel, toJson: _logLevelToJson)
  Level levelMain;
  @JsonKey(name: "ota", fromJson: _parseLogLevel, toJson: _logLevelToJson)
  Level levelOTA;
  @JsonKey(name: "hw_frame", fromJson: _parseLogLevel, toJson: _logLevelToJson)
  Level levelHwFrame;

  static String _logLevelToJson(Level value) {
    return value.toString();
  }

  static Level _parseLogLevel(dynamic value) {
    if (value == null) {
      return Level.ALL;
    }
    return Level.LEVELS.firstWhere((item) => item.toString() == value, orElse: () => Level.INFO);
  }

  LogConfig({required this.levelHwFrame, required this.levelMain, required this.levelOTA, required this.levelWeb});

  factory LogConfig.fromJson(Map<String, dynamic> json) => _$LogConfigFromJson(json);

  Map<String, dynamic> toJson() => _$LogConfigToJson(this);
}
