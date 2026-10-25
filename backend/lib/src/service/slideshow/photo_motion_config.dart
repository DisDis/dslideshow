import 'package:json_annotation/json_annotation.dart';

part 'photo_motion_config.g.dart';

enum PhotoMotionMode { off, kenBurns }

@JsonSerializable()
class PhotoMotionConfig {
  @JsonKey(
    defaultValue: PhotoMotionMode.off,
    unknownEnumValue: PhotoMotionMode.off,
  )
  PhotoMotionMode mode;

  @JsonKey(defaultValue: 1.06, fromJson: _parseZoom)
  double maxZoom;

  PhotoMotionConfig({this.mode = PhotoMotionMode.off, double maxZoom = 1.06})
    : maxZoom = _parseZoom(maxZoom);

  static double _parseZoom(dynamic value) =>
      value is num && value.isFinite ? value.toDouble().clamp(1.0, 1.15) : 1.06;

  factory PhotoMotionConfig.fromJson(Map<String, dynamic> json) =>
      _$PhotoMotionConfigFromJson(json);
  Map<String, dynamic> toJson() => _$PhotoMotionConfigToJson(this);
}
