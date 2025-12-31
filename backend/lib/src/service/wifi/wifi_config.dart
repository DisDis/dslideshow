import 'package:json_annotation/json_annotation.dart';

part 'wifi_config.g.dart';

@JsonSerializable()
class WiFiConfig {
  WiFiConfig();

  factory WiFiConfig.fromJson(Map<String, dynamic> json) =>
      _$WiFiConfigFromJson(json);

  Map<String, dynamic> toJson() => _$WiFiConfigToJson(this);
}
