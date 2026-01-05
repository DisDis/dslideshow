import 'package:json_annotation/json_annotation.dart';

part 'ota_config.g.dart';

@JsonSerializable()
class OTAConfig{
  @JsonKey(defaultValue: true)
  bool alwaysEnabled;
  @JsonKey(defaultValue: true)
  bool autoUpdateEnabled;
  OTAConfig({required this.autoUpdateEnabled, required this.alwaysEnabled});
  factory OTAConfig.fromJson(Map<String, dynamic> json) =>
      _$OTAConfigFromJson(json);

  Map<String, dynamic> toJson() => _$OTAConfigToJson(this);
}