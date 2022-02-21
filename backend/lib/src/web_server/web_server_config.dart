import 'package:json_annotation/json_annotation.dart';
part 'web_server_config.g.dart';

@JsonSerializable()
class WebServerConfig {
  @JsonKey(defaultValue: 8080)
  int port;
  @JsonKey(defaultValue: false)
  bool enabled;

  WebServerConfig({required this.port, required this.enabled});
  factory WebServerConfig.fromJson(Map<String, dynamic> json) => _$WebServerConfigFromJson(json);

  Map<String, dynamic> toJson() => _$WebServerConfigToJson(this);
}
