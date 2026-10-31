// Freezed forwards factory annotations to the generated implementation class.
// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

import 'gallery_catalog.dart';

part 'media_management.freezed.dart';
part 'media_management.g.dart';

enum GalleryMutation { trash, restore, purge, hide, unhide }

enum GalleryItemOperationState { succeeded, failed }

enum GalleryRotation { left, right }

enum GalleryDuplicateMode { exact, similar }

enum GalleryDuplicateStatus { idle, running, stopping, completed, cancelled, failed, interrupted }

enum GalleryDuplicateStage { unknown, snapshot, versionProbe, scanning, validation, persistence }

enum GalleryDuplicateFailureReason {
  unknown,
  toolUnavailable,
  unsupportedVersion,
  versionProbeFailed,
  processFailed,
  timeout,
  outputLimitExceeded,
  invalidResult,
  storageUnavailable,
  unexpected,
}

@freezed
abstract class GalleryOperationRequest with _$GalleryOperationRequest {
  @JsonSerializable(explicitToJson: true)
  const factory GalleryOperationRequest({
    required String operationId,
    required GalleryMutation action,
    required List<GalleryMediaRef> items,
  }) = _GalleryOperationRequest;

  factory GalleryOperationRequest.fromJson(Map<String, dynamic> json) => _$GalleryOperationRequestFromJson(json);
}

@freezed
abstract class GalleryOperationItemResult with _$GalleryOperationItemResult {
  const factory GalleryOperationItemResult({
    required String mediaId,
    @JsonKey(required: true, disallowNullValue: true) required GalleryMediaSection section,
    required GalleryItemOperationState state,
    @JsonKey(unknownEnumValue: GalleryErrorCode.unknown) GalleryErrorCode? error,
    GalleryMediaRef? destination,
    String? restoredPath,
  }) = _GalleryOperationItemResult;

  factory GalleryOperationItemResult.fromJson(Map<String, dynamic> json) => _$GalleryOperationItemResultFromJson(json);
}

@freezed
abstract class GalleryOperationResult with _$GalleryOperationResult {
  @JsonSerializable(explicitToJson: true)
  const factory GalleryOperationResult({required String operationId, required List<GalleryOperationItemResult> items}) =
      _GalleryOperationResult;

  factory GalleryOperationResult.fromJson(Map<String, dynamic> json) => _$GalleryOperationResultFromJson(json);
}

@freezed
abstract class GalleryRotateRequest with _$GalleryRotateRequest {
  const factory GalleryRotateRequest({
    required String operationId,
    required String mediaId,
    required String sourceRevision,
    required GalleryRotation rotation,
    @JsonKey(required: true, disallowNullValue: true) required GalleryMediaSection section,
  }) = _GalleryRotateRequest;

  factory GalleryRotateRequest.fromJson(Map<String, dynamic> json) => _$GalleryRotateRequestFromJson(json);
}

@freezed
abstract class GalleryMetadata with _$GalleryMetadata {
  const factory GalleryMetadata({
    required String mediaId,
    required String sourceRevision,
    required String name,
    required String path,
    @JsonKey(unknownEnumValue: GalleryEntryKind.unknown) required GalleryEntryKind kind,
    required int sizeBytes,
    @JsonKey(required: true, disallowNullValue: true) required GalleryMediaSection section,
    int? width,
    int? height,
    String? dateTaken,
    DateTime? fileModified,
    String? format,
    String? camera,
    String? lens,
    String? iso,
    String? exposure,
    String? aperture,
    String? focalLength,
    int? orientation,
    double? latitude,
    double? longitude,
    double? durationSeconds,
    String? codec,
    String? colorProfile,
    int? bitDepth,
    bool? hasAlpha,
  }) = _GalleryMetadata;

  factory GalleryMetadata.fromJson(Map<String, dynamic> json) => _$GalleryMetadataFromJson(json);
}

@freezed
abstract class GalleryDuplicateStartRequest with _$GalleryDuplicateStartRequest {
  const factory GalleryDuplicateStartRequest({required String operationId, required List<GalleryDuplicateMode> modes}) =
      _GalleryDuplicateStartRequest;

  factory GalleryDuplicateStartRequest.fromJson(Map<String, dynamic> json) =>
      _$GalleryDuplicateStartRequestFromJson(json);
}

@freezed
abstract class GalleryDuplicateMember with _$GalleryDuplicateMember {
  const factory GalleryDuplicateMember({
    required String mediaId,
    required String sourceRevision,
    required String path,
    required String name,
    required int sizeBytes,
    int? width,
    int? height,
    @JsonKey(required: true, disallowNullValue: true) required GalleryMediaSection section,
  }) = _GalleryDuplicateMember;

  factory GalleryDuplicateMember.fromJson(Map<String, dynamic> json) => _$GalleryDuplicateMemberFromJson(json);
}

@freezed
abstract class GalleryDuplicateGroup with _$GalleryDuplicateGroup {
  @JsonSerializable(explicitToJson: true)
  const factory GalleryDuplicateGroup({
    required String groupId,
    required GalleryDuplicateMode mode,
    required List<GalleryDuplicateMember> items,
  }) = _GalleryDuplicateGroup;

  factory GalleryDuplicateGroup.fromJson(Map<String, dynamic> json) => _$GalleryDuplicateGroupFromJson(json);
}

@freezed
abstract class GalleryDuplicateGroupPage with _$GalleryDuplicateGroupPage {
  @JsonSerializable(explicitToJson: true)
  const factory GalleryDuplicateGroupPage({required String jobId, required int index, GalleryDuplicateGroup? group}) =
      _GalleryDuplicateGroupPage;

  factory GalleryDuplicateGroupPage.fromJson(Map<String, dynamic> json) => _$GalleryDuplicateGroupPageFromJson(json);
}

@freezed
abstract class GalleryDuplicateDiagnostics with _$GalleryDuplicateDiagnostics {
  @JsonSerializable(explicitToJson: true)
  const factory GalleryDuplicateDiagnostics({
    @JsonKey(unknownEnumValue: GalleryDuplicateStage.unknown) required GalleryDuplicateStage stage,
    @JsonKey(unknownEnumValue: GalleryDuplicateFailureReason.unknown) GalleryDuplicateFailureReason? failureReason,
    String? toolVersion,
    int? exitCode,
    @Default(0) int candidateCount,
    @Default(0) int matchedFileCount,
    @Default(0) int rejectedResultCount,
    @Default(0) int snapshotSkippedCount,
    @Default(false) bool rootAliased,
    @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) GalleryDuplicateMode? mode,
  }) = _GalleryDuplicateDiagnostics;

  factory GalleryDuplicateDiagnostics.fromJson(Map<String, dynamic> json) =>
      _$GalleryDuplicateDiagnosticsFromJson(json);
}

@freezed
abstract class GalleryDuplicateJob with _$GalleryDuplicateJob {
  @JsonSerializable(explicitToJson: true)
  const factory GalleryDuplicateJob({
    required String jobId,
    required GalleryDuplicateStatus status,
    DateTime? startedAt,
    DateTime? finishedAt,
    @Default([]) List<GalleryDuplicateMode> modes,
    @Default([]) List<GalleryDuplicateGroup> groups,
    @JsonKey(unknownEnumValue: GalleryErrorCode.unknown) GalleryErrorCode? error,
    @Default(0) int skipped,
    GalleryDuplicateDiagnostics? diagnostics,
  }) = _GalleryDuplicateJob;

  factory GalleryDuplicateJob.fromJson(Map<String, dynamic> json) => _$GalleryDuplicateJobFromJson(json);
}
