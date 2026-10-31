// Freezed forwards factory annotations to the generated implementation class.
// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'yandex_drive_models.freezed.dart';
part 'yandex_drive_models.g.dart';

enum YandexDriveResourceType { unknown, file, dir }

@Freezed(toStringOverride: false)
abstract class YandexDriveCredential with _$YandexDriveCredential {
  const factory YandexDriveCredential({
    required String accountId,
    required String label,
    required String accessToken,
    @Default('') String refreshToken,
    required DateTime expiresAt,
  }) = _YandexDriveCredential;
  factory YandexDriveCredential.fromJson(Map<String, dynamic> json) => _$YandexDriveCredentialFromJson(json);
}

@freezed
abstract class YandexDriveResource with _$YandexDriveResource {
  @JsonSerializable(explicitToJson: true)
  const factory YandexDriveResource({
    required String path,
    @Default('') String name,
    @JsonKey(unknownEnumValue: YandexDriveResourceType.unknown)
    @Default(YandexDriveResourceType.unknown)
    YandexDriveResourceType type,
    @Default(0) int size,
    String? md5,
    String? sha256,
    @JsonKey(name: '_embedded') YandexDriveResourceList? children,
  }) = _YandexDriveResource;
  factory YandexDriveResource.fromJson(Map<String, dynamic> json) => _$YandexDriveResourceFromJson(json);
}

@freezed
abstract class YandexDriveResourceList with _$YandexDriveResourceList {
  @JsonSerializable(explicitToJson: true)
  const factory YandexDriveResourceList({
    @Default([]) List<YandexDriveResource> items,
    @Default(0) int offset,
    @Default(0) int limit,
    @Default(0) int total,
  }) = _YandexDriveResourceList;
  factory YandexDriveResourceList.fromJson(Map<String, dynamic> json) => _$YandexDriveResourceListFromJson(json);
}

@Freezed(toStringOverride: false)
abstract class YandexDriveTokenResponse with _$YandexDriveTokenResponse {
  const factory YandexDriveTokenResponse({
    @JsonKey(name: 'access_token') String? accessToken,
    @JsonKey(name: 'refresh_token') String? refreshToken,
    @JsonKey(name: 'expires_in') int? expiresIn,
    String? error,
  }) = _YandexDriveTokenResponse;
  factory YandexDriveTokenResponse.fromJson(Map<String, dynamic> json) => _$YandexDriveTokenResponseFromJson(json);
}

@Freezed(toStringOverride: false)
abstract class YandexDriveDeviceResponse with _$YandexDriveDeviceResponse {
  const factory YandexDriveDeviceResponse({
    @JsonKey(name: 'device_code') required String deviceCode,
    @JsonKey(name: 'user_code') required String userCode,
    @JsonKey(name: 'verification_url') required Uri verificationUrl,
    required int interval,
    @JsonKey(name: 'expires_in') required int expiresIn,
  }) = _YandexDriveDeviceResponse;
  factory YandexDriveDeviceResponse.fromJson(Map<String, dynamic> json) => _$YandexDriveDeviceResponseFromJson(json);
}

@freezed
abstract class YandexDriveDiskInfo with _$YandexDriveDiskInfo {
  @JsonSerializable(explicitToJson: true)
  const factory YandexDriveDiskInfo({required YandexDriveUser user}) = _YandexDriveDiskInfo;
  factory YandexDriveDiskInfo.fromJson(Map<String, dynamic> json) => _$YandexDriveDiskInfoFromJson(json);
}

@freezed
abstract class YandexDriveUser with _$YandexDriveUser {
  const factory YandexDriveUser({
    required String uid,
    @Default('') String login,
    @JsonKey(name: 'display_name') @Default('') String displayName,
  }) = _YandexDriveUser;
  factory YandexDriveUser.fromJson(Map<String, dynamic> json) => _$YandexDriveUserFromJson(json);
}

@freezed
abstract class YandexDriveDownloadLink with _$YandexDriveDownloadLink {
  const factory YandexDriveDownloadLink({required Uri href}) = _YandexDriveDownloadLink;
  factory YandexDriveDownloadLink.fromJson(Map<String, dynamic> json) => _$YandexDriveDownloadLinkFromJson(json);
}
