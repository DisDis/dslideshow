import 'package:dslideshow_backend/config.dart';

class WebServerConfig  extends BaseConfig {
  int _pinPauseButton;
  int get pinPauseButton => _pinPauseButton ??= readInt("pinPauseButton", 17);

  String _systemDiskDev;
  String get systemDiskDev => _systemDiskDev ??= readValue("systemDiskDev", '/dev/root');

  WebServerConfig(Map<String, dynamic> config) :super(config);
}