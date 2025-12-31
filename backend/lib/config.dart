import 'dart:convert';
import 'dart:io';
import 'package:dslideshow_backend/src/service/mqtt/mqtt_config.dart';
import 'package:dslideshow_backend/src/service/storage/storages_config.dart';
import 'package:dslideshow_backend/src/service/wifi/wifi_config.dart';
import 'package:dslideshow_backend/src/web_server/web_server_config.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:dslideshow_backend/src/service/hardware/hardware.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:dslideshow_backend/src/service/slideshow/slideshow_config.dart';
import 'package:dslideshow_backend/src/service/slideshow/welcome_config.dart';

export 'package:dslideshow_backend/src/service/slideshow/slideshow_config.dart';
export 'package:dslideshow_backend/src/service/slideshow/welcome_config.dart';

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
  @JsonKey(fromJson: _parseWebServer, name: 'web')
  WebServerConfig webServer;
  @JsonKey(fromJson: _parseMQTT)
  MqttConfig mqtt;
  @JsonKey(fromJson: _parseStorages)
  StoragesConfig storages;
  @JsonKey(fromJson: _parseWifi)
  WiFiConfig wifi;

  AppConfig({
    required this.hardware,
    required this.log,
    required this.slideshow,
    required this.welcome,
    required this.webServer,
    required this.mqtt,
    required this.storages,
    required this.wifi,
  });

  @JsonKey(includeToJson: false, includeFromJson: false)
  String fullConfigFilename = '';

  factory AppConfig.fromJson(Map<String, dynamic> json) =>
      _$AppConfigFromJson(json);
  factory AppConfig.fromFile([String? rootPath]) {
    String fullConfigFilename = rootPath != null
        ? path.join(rootPath, CONFIG_FILE)
        : CONFIG_FILE;
    _log.info("Loading '$fullConfigFilename'");
    var config = new File(fullConfigFilename);
    String configStr;
    if (!config.existsSync()) {
      _log.fine('Not found config file "$config"');
      //exit(1);
      configStr = '{}';
    } else {
      configStr = config.readAsStringSync();
    }
    try {
      Map<String, dynamic> _config = Map<String, dynamic>();
      try {
        _config = json.decode(configStr) as Map<String, dynamic>;
      } catch (e, st) {
        _log.severe(e.toString(), e, st);
      }
      return AppConfig.fromJson(_config)
        ..fullConfigFilename = fullConfigFilename;
    } finally {
      _log.info("Config loaded");
    }
  }

  static final prettyPrintJSONEncode = new JsonEncoder.withIndent('  ');
  void toFile([String? filenameOutput]) {
    final fileName = filenameOutput ?? fullConfigFilename;
    _log.info('Saving to "$fileName"');
    File(fileName)
      ..openWrite()
      ..writeAsStringSync(prettyPrintJSONEncode.convert(this.toJson()));
    _log.info('Saved to "$fileName"');
  }

  Map<String, dynamic> toJson() => _$AppConfigToJson(this);

  static HardwareConfig _parseHardware(dynamic data) {
    _log.info("- parsing 'hardware'");
    final dataV = data is Map<String, dynamic> ? data : <String, dynamic>{};
    return new HardwareConfig.fromJson(dataV);
  }

  static LogConfig _parseLog(dynamic data) {
    _log.info("- parsing 'log'");
    final dataV = data is Map<String, dynamic> ? data : <String, dynamic>{};
    return new LogConfig.fromJson(dataV);
  }

  static SlideShowConfig _parseSlideshow(dynamic data) {
    _log.info("- parsing 'slideshow'");
    final dataV = data is Map<String, dynamic> ? data : <String, dynamic>{};
    return new SlideShowConfig.fromJson(dataV);
  }

  static WelcomeConfig _parseWelcome(dynamic data) {
    _log.info("- parsing 'welcome'");
    final dataV = data is Map<String, dynamic> ? data : <String, dynamic>{};
    return new WelcomeConfig.fromJson(dataV);
  }

  static WebServerConfig _parseWebServer(dynamic data) {
    _log.info("- parsing 'web'");
    final dataV = data is Map<String, dynamic> ? data : <String, dynamic>{};
    return new WebServerConfig.fromJson(dataV);
  }

  static MqttConfig _parseMQTT(dynamic data) {
    _log.info("- parsing 'mqtt'");
    final dataV = data is Map<String, dynamic> ? data : <String, dynamic>{};
    return new MqttConfig.fromJson(dataV);
  }

  static StoragesConfig _parseStorages(dynamic data) {
    _log.info("- parsing 'storage'");
    final dataV = data is Map<String, dynamic> ? data : <String, dynamic>{};
    return StoragesConfig.fromJson(dataV);
  }

  static WiFiConfig _parseWifi(dynamic data) {
    _log.info("- parsing 'wifi'");
    final dataV = data is Map<String, dynamic> ? data : <String, dynamic>{};
    return WiFiConfig.fromJson(dataV);
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
      return Level.INFO;
    }
    return Level.LEVELS.firstWhere(
      (item) => item.toString() == value,
      orElse: () => Level.INFO,
    );
  }

  LogConfig({
    required this.levelHwFrame,
    required this.levelMain,
    required this.levelOTA,
    required this.levelWeb,
  });

  factory LogConfig.fromJson(Map<String, dynamic> json) =>
      _$LogConfigFromJson(json);

  Map<String, dynamic> toJson() => _$LogConfigToJson(this);
}
