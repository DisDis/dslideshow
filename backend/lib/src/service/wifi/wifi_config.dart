import 'package:json_annotation/json_annotation.dart';

part 'wifi_config.g.dart';

@JsonSerializable()
class WiFiConfig {
  @JsonKey(defaultValue: 'wlan0')
  String devId;

  @JsonKey(defaultValue: './scripts/scanWiFi.sh')
  String scanWiFiScript;

  WiFiConfig({
    required this.devId,
    required this.scanWiFiScript,
  });

  factory WiFiConfig.fromJson(Map<String, dynamic> json) => _$WiFiConfigFromJson(json);

  Map<String, dynamic> toJson() => _$WiFiConfigToJson(this);
}
