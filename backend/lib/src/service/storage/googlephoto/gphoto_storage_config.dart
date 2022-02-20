import 'package:json_annotation/json_annotation.dart';
part 'gphoto_storage_config.g.dart';

@JsonSerializable()
class GPhotoStorageConfig {
  @JsonKey(defaultValue: 2560)
  int imageWidth;

  @JsonKey(defaultValue: 1600)
  int imageHeight;

  @JsonKey(fromJson: _parseDuration, toJson: _durationToJson)
  Duration syncPeriod; //1 hour

  @JsonKey(defaultValue: <String>["SlideShow"])
  List<String> albumNames;

  @JsonKey(defaultValue: 'clientId')
  GPhotoClientIdConfig clientId;

  @JsonKey(defaultValue: '')

  /// A refresh token, which can be used to refresh the access credentials.
  ///
  /// This field may be null.
  String refreshToken;

  static const Duration _DEFAULT_SYNC_PERIOD = const Duration(seconds: 60 * 60);

  static Duration _parseDuration(dynamic value) {
    if (value == null) {
      return _DEFAULT_SYNC_PERIOD;
    } else if (value is int) {
      return new Duration(seconds: value);
    }
    return _DEFAULT_SYNC_PERIOD;
  }

  static int _durationToJson(Duration value) {
    return value.inSeconds;
  }

  GPhotoStorageConfig(
      {required this.albumNames,
      required this.clientId,
      required this.imageHeight,
      required this.imageWidth,
      required this.refreshToken,
      required this.syncPeriod});

  factory GPhotoStorageConfig.fromJson(Map<String, dynamic> json) => _$GPhotoStorageConfigFromJson(json);

  Map<String, dynamic> toJson() => _$GPhotoStorageConfigToJson(this);
}

@JsonSerializable()
class GPhotoClientIdConfig {
  @JsonKey(defaultValue: 'identifier')

  /// The identifier used to identify this application to the server.
  String identifier;

  @JsonKey(defaultValue: 'secret')

  /// The client secret used to identify this application to the server.
  String secret;
  GPhotoClientIdConfig({required this.identifier, required this.secret});

  factory GPhotoClientIdConfig.fromJson(Map<String, dynamic> json) => _$GPhotoClientIdConfigFromJson(json);

  Map<String, dynamic> toJson() => _$GPhotoClientIdConfigToJson(this);
}
