// Freezed forwards factory annotations to the generated implementation class.
// ignore_for_file: invalid_annotation_target
import 'package:dslideshow_common/rpc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../service/storage/storages_config.dart' show StorageType;

part 'drive_command.freezed.dart';
part 'drive_command.g.dart';

enum DriveAction {
  unknown,
  state,
  configureApplication,
  startAuthorization,
  authorization,
  cancelAuthorization,
  disconnectAccount,
  folders,
  syncNow,
  setPaused,
}

enum DriveAuthorizationStatus { pending, connected, cancelled, expired, failed }

enum DriveFailure {
  unknown,
  notConfigured,
  invalidClient,
  invalidScope,
  clientUnavailable,
  authorizationRequired,
  authorizationDenied,
  authorizationExpired,
  invalidRequest,
  notActive,
  busy,
  network,
  rateLimited,
  serviceUnavailable,
  invalidResponse,
  storage,
  checksum,
  cancelled,
}

/// A cloud operation addressed to an explicit storage provider.
///
/// JSON requires a valid provider and an action. Missing or unknown providers
/// are rejected during decoding; unknown actions become [DriveAction.unknown]
/// and are rejected by the addressed provider.
@Freezed(toStringOverride: false)
sealed class DriveCommand with _$DriveCommand implements RpcCommand {
  static const TYPE = 'drive';
  const DriveCommand._();

  const factory DriveCommand({
    required int id,
    required StorageType provider,
    @JsonKey(unknownEnumValue: DriveAction.unknown) required DriveAction action,
    String? clientId,
    String? clientSecret,
    String? sessionId,
    String? accountId,
    String? path,
    @Default(0) int offset,
    bool? paused,
    @Default(DriveCommand.TYPE) String type,
  }) = _DriveCommand;
  factory DriveCommand.fromJson(Map<String, dynamic> json) => _$DriveCommandFromJson(json);
}

@freezed
sealed class DriveResult with _$DriveResult implements RpcResult {
  @JsonSerializable(explicitToJson: true)
  const factory DriveResult({
    required int id,
    required DriveState state,
    DriveAuthorization? authorization,
    DriveFolderPage? folderPage,
    @JsonKey(unknownEnumValue: DriveFailure.unknown) DriveFailure? error,
  }) = _DriveResult;
  factory DriveResult.fromJson(Map<String, dynamic> json) => _$DriveResultFromJson(json);
}

@freezed
abstract class DriveState with _$DriveState {
  @JsonSerializable(explicitToJson: true)
  const factory DriveState({
    @Default('') String clientId,
    @Default(false) bool clientSecretConfigured,
    @Default([]) List<DriveConnection> connections,
    @Default(DriveRuntime()) DriveRuntime runtime,
  }) = _DriveState;
  factory DriveState.fromJson(Map<String, dynamic> json) => _$DriveStateFromJson(json);
}

@freezed
abstract class DriveConnection with _$DriveConnection {
  const factory DriveConnection({required String accountId, required String label}) = _DriveConnection;
  factory DriveConnection.fromJson(Map<String, dynamic> json) => _$DriveConnectionFromJson(json);
}

@Freezed(toStringOverride: false)
abstract class DriveAuthorization with _$DriveAuthorization {
  const factory DriveAuthorization({
    required String sessionId,
    required DriveAuthorizationStatus status,
    String? userCode,
    Uri? verificationUrl,
    DateTime? expiresAt,
    String? accountId,
    @JsonKey(unknownEnumValue: DriveFailure.unknown) DriveFailure? error,
  }) = _DriveAuthorization;
  factory DriveAuthorization.fromJson(Map<String, dynamic> json) => _$DriveAuthorizationFromJson(json);
}

@freezed
abstract class DriveFolder with _$DriveFolder {
  const factory DriveFolder({required String name, required String path}) = _DriveFolder;
  factory DriveFolder.fromJson(Map<String, dynamic> json) => _$DriveFolderFromJson(json);
}

@freezed
abstract class DriveFolderPage with _$DriveFolderPage {
  @JsonSerializable(explicitToJson: true)
  const factory DriveFolderPage({
    required String path,
    @Default([]) List<DriveFolder> folders,
    @Default(0) int offset,
    int? nextOffset,
  }) = _DriveFolderPage;
  factory DriveFolderPage.fromJson(Map<String, dynamic> json) => _$DriveFolderPageFromJson(json);
}

@freezed
abstract class DriveRuntime with _$DriveRuntime {
  const DriveRuntime._();

  const factory DriveRuntime({
    @Default(false) bool active,
    @Default(false) bool running,
    @Default(false) bool paused,
    DateTime? lastSync,
    int? totalItems,
    @Default(0) int processedItems,
    @Default(0) int downloaded,
    @Default(0) int skipped,
    @Default(0) int failed,
    @JsonKey(unknownEnumValue: DriveFailure.unknown) DriveFailure? error,
  }) = _DriveRuntime;
  factory DriveRuntime.fromJson(Map<String, dynamic> json) => _$DriveRuntimeFromJson(json);

  /// An evolving estimate: directory totals are added as the traversal enters them.
  double? get progress {
    final total = totalItems;
    if (total == null || total < 0) return null;
    if (total == 0) return running ? null : 1;
    return (processedItems / total).clamp(0.0, 1.0);
  }
}
