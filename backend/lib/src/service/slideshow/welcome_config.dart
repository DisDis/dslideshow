import 'package:json_annotation/json_annotation.dart';

part 'welcome_config.g.dart';

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
