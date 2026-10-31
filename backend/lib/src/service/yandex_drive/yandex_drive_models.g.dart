// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'yandex_drive_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_YandexDriveCredential _$YandexDriveCredentialFromJson(
  Map<String, dynamic> json,
) => _YandexDriveCredential(
  accountId: json['accountId'] as String,
  label: json['label'] as String,
  accessToken: json['accessToken'] as String,
  refreshToken: json['refreshToken'] as String? ?? '',
  expiresAt: DateTime.parse(json['expiresAt'] as String),
);

Map<String, dynamic> _$YandexDriveCredentialToJson(
  _YandexDriveCredential instance,
) => <String, dynamic>{
  'accountId': instance.accountId,
  'label': instance.label,
  'accessToken': instance.accessToken,
  'refreshToken': instance.refreshToken,
  'expiresAt': instance.expiresAt.toIso8601String(),
};

_YandexDriveResource _$YandexDriveResourceFromJson(Map<String, dynamic> json) =>
    _YandexDriveResource(
      path: json['path'] as String,
      name: json['name'] as String? ?? '',
      type:
          $enumDecodeNullable(
            _$YandexDriveResourceTypeEnumMap,
            json['type'],
            unknownValue: YandexDriveResourceType.unknown,
          ) ??
          YandexDriveResourceType.unknown,
      size: (json['size'] as num?)?.toInt() ?? 0,
      md5: json['md5'] as String?,
      sha256: json['sha256'] as String?,
      children: json['_embedded'] == null
          ? null
          : YandexDriveResourceList.fromJson(
              json['_embedded'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$YandexDriveResourceToJson(
  _YandexDriveResource instance,
) => <String, dynamic>{
  'path': instance.path,
  'name': instance.name,
  'type': _$YandexDriveResourceTypeEnumMap[instance.type]!,
  'size': instance.size,
  'md5': instance.md5,
  'sha256': instance.sha256,
  '_embedded': instance.children?.toJson(),
};

const _$YandexDriveResourceTypeEnumMap = {
  YandexDriveResourceType.unknown: 'unknown',
  YandexDriveResourceType.file: 'file',
  YandexDriveResourceType.dir: 'dir',
};

_YandexDriveResourceList _$YandexDriveResourceListFromJson(
  Map<String, dynamic> json,
) => _YandexDriveResourceList(
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => YandexDriveResource.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  offset: (json['offset'] as num?)?.toInt() ?? 0,
  limit: (json['limit'] as num?)?.toInt() ?? 0,
  total: (json['total'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$YandexDriveResourceListToJson(
  _YandexDriveResourceList instance,
) => <String, dynamic>{
  'items': instance.items.map((e) => e.toJson()).toList(),
  'offset': instance.offset,
  'limit': instance.limit,
  'total': instance.total,
};

_YandexDriveTokenResponse _$YandexDriveTokenResponseFromJson(
  Map<String, dynamic> json,
) => _YandexDriveTokenResponse(
  accessToken: json['access_token'] as String?,
  refreshToken: json['refresh_token'] as String?,
  expiresIn: (json['expires_in'] as num?)?.toInt(),
  error: json['error'] as String?,
);

Map<String, dynamic> _$YandexDriveTokenResponseToJson(
  _YandexDriveTokenResponse instance,
) => <String, dynamic>{
  'access_token': instance.accessToken,
  'refresh_token': instance.refreshToken,
  'expires_in': instance.expiresIn,
  'error': instance.error,
};

_YandexDriveDeviceResponse _$YandexDriveDeviceResponseFromJson(
  Map<String, dynamic> json,
) => _YandexDriveDeviceResponse(
  deviceCode: json['device_code'] as String,
  userCode: json['user_code'] as String,
  verificationUrl: Uri.parse(json['verification_url'] as String),
  interval: (json['interval'] as num).toInt(),
  expiresIn: (json['expires_in'] as num).toInt(),
);

Map<String, dynamic> _$YandexDriveDeviceResponseToJson(
  _YandexDriveDeviceResponse instance,
) => <String, dynamic>{
  'device_code': instance.deviceCode,
  'user_code': instance.userCode,
  'verification_url': instance.verificationUrl.toString(),
  'interval': instance.interval,
  'expires_in': instance.expiresIn,
};

_YandexDriveDiskInfo _$YandexDriveDiskInfoFromJson(Map<String, dynamic> json) =>
    _YandexDriveDiskInfo(
      user: YandexDriveUser.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$YandexDriveDiskInfoToJson(
  _YandexDriveDiskInfo instance,
) => <String, dynamic>{'user': instance.user.toJson()};

_YandexDriveUser _$YandexDriveUserFromJson(Map<String, dynamic> json) =>
    _YandexDriveUser(
      uid: json['uid'] as String,
      login: json['login'] as String? ?? '',
      displayName: json['display_name'] as String? ?? '',
    );

Map<String, dynamic> _$YandexDriveUserToJson(_YandexDriveUser instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'login': instance.login,
      'display_name': instance.displayName,
    };

_YandexDriveDownloadLink _$YandexDriveDownloadLinkFromJson(
  Map<String, dynamic> json,
) => _YandexDriveDownloadLink(href: Uri.parse(json['href'] as String));

Map<String, dynamic> _$YandexDriveDownloadLinkToJson(
  _YandexDriveDownloadLink instance,
) => <String, dynamic>{'href': instance.href.toString()};
