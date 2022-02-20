import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/src/service/storage/disk/disk_storage_config.dart';
import 'package:json_annotation/json_annotation.dart';
part 'gphoto_storage_config.g.dart';

@JsonSerializable()
class GPhotoStorageConfig implements AbstractStorageConfig, DiskStorageConfig {
  @JsonKey(defaultValue: 2560)
  int imageWidth;

  @JsonKey(defaultValue: 1600)
  int imageHeight;

  @JsonKey(fromJson: _parseDuration, toJson: _durationToJson)
  Duration syncPeriod; //1 hour

  @JsonKey(defaultValue: <String>["SlideShow"])
  List<String> albumNames;

  @JsonKey(fromJson: _parseClientId)
  GPhotoClientIdConfig clientId;

  /// A refresh token, which can be used to refresh the access credentials.
  ///
  /// This field may be null.
  @JsonKey(defaultValue: '')
  String refreshToken;

  static const Duration _DEFAULT_SYNC_PERIOD = const Duration(seconds: 60 * 60);

  static GPhotoClientIdConfig _parseClientId(dynamic value) {
    if (value is Map<String, dynamic>) {
      return GPhotoClientIdConfig.fromJson(value);
    } else {
      return GPhotoClientIdConfig.fromJson(<String, dynamic>{});
    }
  }

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

  final StorageType name = StorageType.GPhotoStorage;
}

@JsonSerializable()
class GPhotoClientIdConfig {
  /// The identifier used to identify this application to the server.
  @JsonKey(defaultValue: 'identifier')
  String identifier;

  /// The client secret used to identify this application to the server.
  @JsonKey(defaultValue: 'secret')
  String secret;
  GPhotoClientIdConfig({required this.identifier, required this.secret});

  factory GPhotoClientIdConfig.fromJson(Map<String, dynamic> json) => _$GPhotoClientIdConfigFromJson(json);

  Map<String, dynamic> toJson() => _$GPhotoClientIdConfigToJson(this);
}
