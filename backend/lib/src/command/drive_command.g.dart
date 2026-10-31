// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drive_command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DriveCommand _$DriveCommandFromJson(Map<String, dynamic> json) =>
    _DriveCommand(
      id: (json['id'] as num).toInt(),
      provider: $enumDecode(_$StorageTypeEnumMap, json['provider']),
      action: $enumDecode(
        _$DriveActionEnumMap,
        json['action'],
        unknownValue: DriveAction.unknown,
      ),
      clientId: json['clientId'] as String?,
      clientSecret: json['clientSecret'] as String?,
      sessionId: json['sessionId'] as String?,
      accountId: json['accountId'] as String?,
      path: json['path'] as String?,
      offset: (json['offset'] as num?)?.toInt() ?? 0,
      paused: json['paused'] as bool?,
      type: json['type'] as String? ?? DriveCommand.TYPE,
    );

Map<String, dynamic> _$DriveCommandToJson(_DriveCommand instance) =>
    <String, dynamic>{
      'id': instance.id,
      'provider': _$StorageTypeEnumMap[instance.provider]!,
      'action': _$DriveActionEnumMap[instance.action]!,
      'clientId': instance.clientId,
      'clientSecret': instance.clientSecret,
      'sessionId': instance.sessionId,
      'accountId': instance.accountId,
      'path': instance.path,
      'offset': instance.offset,
      'paused': instance.paused,
      'type': instance.type,
    };

const _$StorageTypeEnumMap = {
  StorageType.DiskStorage: 'DiskStorage',
  StorageType.GPhotoStorage: 'GPhotoStorage',
  StorageType.YandexDriveStorage: 'YandexDriveStorage',
};

const _$DriveActionEnumMap = {
  DriveAction.unknown: 'unknown',
  DriveAction.state: 'state',
  DriveAction.configureApplication: 'configureApplication',
  DriveAction.startAuthorization: 'startAuthorization',
  DriveAction.authorization: 'authorization',
  DriveAction.cancelAuthorization: 'cancelAuthorization',
  DriveAction.disconnectAccount: 'disconnectAccount',
  DriveAction.folders: 'folders',
  DriveAction.syncNow: 'syncNow',
  DriveAction.setPaused: 'setPaused',
};

_DriveResult _$DriveResultFromJson(Map<String, dynamic> json) => _DriveResult(
  id: (json['id'] as num).toInt(),
  state: DriveState.fromJson(json['state'] as Map<String, dynamic>),
  authorization: json['authorization'] == null
      ? null
      : DriveAuthorization.fromJson(
          json['authorization'] as Map<String, dynamic>,
        ),
  folderPage: json['folderPage'] == null
      ? null
      : DriveFolderPage.fromJson(json['folderPage'] as Map<String, dynamic>),
  error: $enumDecodeNullable(
    _$DriveFailureEnumMap,
    json['error'],
    unknownValue: DriveFailure.unknown,
  ),
);

Map<String, dynamic> _$DriveResultToJson(_DriveResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'state': instance.state.toJson(),
      'authorization': instance.authorization?.toJson(),
      'folderPage': instance.folderPage?.toJson(),
      'error': _$DriveFailureEnumMap[instance.error],
    };

const _$DriveFailureEnumMap = {
  DriveFailure.unknown: 'unknown',
  DriveFailure.notConfigured: 'notConfigured',
  DriveFailure.invalidClient: 'invalidClient',
  DriveFailure.invalidScope: 'invalidScope',
  DriveFailure.clientUnavailable: 'clientUnavailable',
  DriveFailure.authorizationRequired: 'authorizationRequired',
  DriveFailure.authorizationDenied: 'authorizationDenied',
  DriveFailure.authorizationExpired: 'authorizationExpired',
  DriveFailure.invalidRequest: 'invalidRequest',
  DriveFailure.notActive: 'notActive',
  DriveFailure.busy: 'busy',
  DriveFailure.network: 'network',
  DriveFailure.rateLimited: 'rateLimited',
  DriveFailure.serviceUnavailable: 'serviceUnavailable',
  DriveFailure.invalidResponse: 'invalidResponse',
  DriveFailure.storage: 'storage',
  DriveFailure.checksum: 'checksum',
  DriveFailure.cancelled: 'cancelled',
};

_DriveState _$DriveStateFromJson(Map<String, dynamic> json) => _DriveState(
  clientId: json['clientId'] as String? ?? '',
  clientSecretConfigured: json['clientSecretConfigured'] as bool? ?? false,
  connections:
      (json['connections'] as List<dynamic>?)
          ?.map((e) => DriveConnection.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  runtime: json['runtime'] == null
      ? const DriveRuntime()
      : DriveRuntime.fromJson(json['runtime'] as Map<String, dynamic>),
);

Map<String, dynamic> _$DriveStateToJson(_DriveState instance) =>
    <String, dynamic>{
      'clientId': instance.clientId,
      'clientSecretConfigured': instance.clientSecretConfigured,
      'connections': instance.connections.map((e) => e.toJson()).toList(),
      'runtime': instance.runtime.toJson(),
    };

_DriveConnection _$DriveConnectionFromJson(Map<String, dynamic> json) =>
    _DriveConnection(
      accountId: json['accountId'] as String,
      label: json['label'] as String,
    );

Map<String, dynamic> _$DriveConnectionToJson(_DriveConnection instance) =>
    <String, dynamic>{'accountId': instance.accountId, 'label': instance.label};

_DriveAuthorization _$DriveAuthorizationFromJson(Map<String, dynamic> json) =>
    _DriveAuthorization(
      sessionId: json['sessionId'] as String,
      status: $enumDecode(_$DriveAuthorizationStatusEnumMap, json['status']),
      userCode: json['userCode'] as String?,
      verificationUrl: json['verificationUrl'] == null
          ? null
          : Uri.parse(json['verificationUrl'] as String),
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
      accountId: json['accountId'] as String?,
      error: $enumDecodeNullable(
        _$DriveFailureEnumMap,
        json['error'],
        unknownValue: DriveFailure.unknown,
      ),
    );

Map<String, dynamic> _$DriveAuthorizationToJson(_DriveAuthorization instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'status': _$DriveAuthorizationStatusEnumMap[instance.status]!,
      'userCode': instance.userCode,
      'verificationUrl': instance.verificationUrl?.toString(),
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'accountId': instance.accountId,
      'error': _$DriveFailureEnumMap[instance.error],
    };

const _$DriveAuthorizationStatusEnumMap = {
  DriveAuthorizationStatus.pending: 'pending',
  DriveAuthorizationStatus.connected: 'connected',
  DriveAuthorizationStatus.cancelled: 'cancelled',
  DriveAuthorizationStatus.expired: 'expired',
  DriveAuthorizationStatus.failed: 'failed',
};

_DriveFolder _$DriveFolderFromJson(Map<String, dynamic> json) =>
    _DriveFolder(name: json['name'] as String, path: json['path'] as String);

Map<String, dynamic> _$DriveFolderToJson(_DriveFolder instance) =>
    <String, dynamic>{'name': instance.name, 'path': instance.path};

_DriveFolderPage _$DriveFolderPageFromJson(Map<String, dynamic> json) =>
    _DriveFolderPage(
      path: json['path'] as String,
      folders:
          (json['folders'] as List<dynamic>?)
              ?.map((e) => DriveFolder.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      offset: (json['offset'] as num?)?.toInt() ?? 0,
      nextOffset: (json['nextOffset'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DriveFolderPageToJson(_DriveFolderPage instance) =>
    <String, dynamic>{
      'path': instance.path,
      'folders': instance.folders.map((e) => e.toJson()).toList(),
      'offset': instance.offset,
      'nextOffset': instance.nextOffset,
    };

_DriveRuntime _$DriveRuntimeFromJson(Map<String, dynamic> json) =>
    _DriveRuntime(
      active: json['active'] as bool? ?? false,
      running: json['running'] as bool? ?? false,
      paused: json['paused'] as bool? ?? false,
      lastSync: json['lastSync'] == null
          ? null
          : DateTime.parse(json['lastSync'] as String),
      totalItems: (json['totalItems'] as num?)?.toInt(),
      processedItems: (json['processedItems'] as num?)?.toInt() ?? 0,
      downloaded: (json['downloaded'] as num?)?.toInt() ?? 0,
      skipped: (json['skipped'] as num?)?.toInt() ?? 0,
      failed: (json['failed'] as num?)?.toInt() ?? 0,
      error: $enumDecodeNullable(
        _$DriveFailureEnumMap,
        json['error'],
        unknownValue: DriveFailure.unknown,
      ),
    );

Map<String, dynamic> _$DriveRuntimeToJson(_DriveRuntime instance) =>
    <String, dynamic>{
      'active': instance.active,
      'running': instance.running,
      'paused': instance.paused,
      'lastSync': instance.lastSync?.toIso8601String(),
      'totalItems': instance.totalItems,
      'processedItems': instance.processedItems,
      'downloaded': instance.downloaded,
      'skipped': instance.skipped,
      'failed': instance.failed,
      'error': _$DriveFailureEnumMap[instance.error],
    };
