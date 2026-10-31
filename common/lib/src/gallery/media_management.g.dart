// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_management.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GalleryOperationRequest _$GalleryOperationRequestFromJson(
  Map<String, dynamic> json,
) => _GalleryOperationRequest(
  operationId: json['operationId'] as String,
  action: $enumDecode(_$GalleryMutationEnumMap, json['action']),
  items: (json['items'] as List<dynamic>)
      .map((e) => GalleryMediaRef.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$GalleryOperationRequestToJson(
  _GalleryOperationRequest instance,
) => <String, dynamic>{
  'operationId': instance.operationId,
  'action': _$GalleryMutationEnumMap[instance.action]!,
  'items': instance.items.map((e) => e.toJson()).toList(),
};

const _$GalleryMutationEnumMap = {
  GalleryMutation.trash: 'trash',
  GalleryMutation.restore: 'restore',
  GalleryMutation.purge: 'purge',
  GalleryMutation.hide: 'hide',
  GalleryMutation.unhide: 'unhide',
};

_GalleryOperationItemResult _$GalleryOperationItemResultFromJson(
  Map<String, dynamic> json,
) {
  $checkKeys(
    json,
    requiredKeys: const ['section'],
    disallowNullValues: const ['section'],
  );
  return _GalleryOperationItemResult(
    mediaId: json['mediaId'] as String,
    section: $enumDecode(_$GalleryMediaSectionEnumMap, json['section']),
    state: $enumDecode(_$GalleryItemOperationStateEnumMap, json['state']),
    error: $enumDecodeNullable(
      _$GalleryErrorCodeEnumMap,
      json['error'],
      unknownValue: GalleryErrorCode.unknown,
    ),
    destination: json['destination'] == null
        ? null
        : GalleryMediaRef.fromJson(json['destination'] as Map<String, dynamic>),
    restoredPath: json['restoredPath'] as String?,
  );
}

Map<String, dynamic> _$GalleryOperationItemResultToJson(
  _GalleryOperationItemResult instance,
) => <String, dynamic>{
  'mediaId': instance.mediaId,
  'section': _$GalleryMediaSectionEnumMap[instance.section]!,
  'state': _$GalleryItemOperationStateEnumMap[instance.state]!,
  'error': _$GalleryErrorCodeEnumMap[instance.error],
  'destination': instance.destination,
  'restoredPath': instance.restoredPath,
};

const _$GalleryMediaSectionEnumMap = {
  GalleryMediaSection.published: 'published',
  GalleryMediaSection.hidden: 'hidden',
  GalleryMediaSection.trash: 'trash',
};

const _$GalleryItemOperationStateEnumMap = {
  GalleryItemOperationState.succeeded: 'succeeded',
  GalleryItemOperationState.failed: 'failed',
};

const _$GalleryErrorCodeEnumMap = {
  GalleryErrorCode.invalidRequest: 'invalidRequest',
  GalleryErrorCode.forbidden: 'forbidden',
  GalleryErrorCode.notFound: 'notFound',
  GalleryErrorCode.revisionMismatch: 'revisionMismatch',
  GalleryErrorCode.unsupported: 'unsupported',
  GalleryErrorCode.busy: 'busy',
  GalleryErrorCode.unavailable: 'unavailable',
  GalleryErrorCode.cancelled: 'cancelled',
  GalleryErrorCode.timeout: 'timeout',
  GalleryErrorCode.outputLimitExceeded: 'outputLimitExceeded',
  GalleryErrorCode.processingFailed: 'processingFailed',
  GalleryErrorCode.conflict: 'conflict',
  GalleryErrorCode.unknown: 'unknown',
};

_GalleryOperationResult _$GalleryOperationResultFromJson(
  Map<String, dynamic> json,
) => _GalleryOperationResult(
  operationId: json['operationId'] as String,
  items: (json['items'] as List<dynamic>)
      .map(
        (e) => GalleryOperationItemResult.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
);

Map<String, dynamic> _$GalleryOperationResultToJson(
  _GalleryOperationResult instance,
) => <String, dynamic>{
  'operationId': instance.operationId,
  'items': instance.items.map((e) => e.toJson()).toList(),
};

_GalleryRotateRequest _$GalleryRotateRequestFromJson(
  Map<String, dynamic> json,
) {
  $checkKeys(
    json,
    requiredKeys: const ['section'],
    disallowNullValues: const ['section'],
  );
  return _GalleryRotateRequest(
    operationId: json['operationId'] as String,
    mediaId: json['mediaId'] as String,
    sourceRevision: json['sourceRevision'] as String,
    rotation: $enumDecode(_$GalleryRotationEnumMap, json['rotation']),
    section: $enumDecode(_$GalleryMediaSectionEnumMap, json['section']),
  );
}

Map<String, dynamic> _$GalleryRotateRequestToJson(
  _GalleryRotateRequest instance,
) => <String, dynamic>{
  'operationId': instance.operationId,
  'mediaId': instance.mediaId,
  'sourceRevision': instance.sourceRevision,
  'rotation': _$GalleryRotationEnumMap[instance.rotation]!,
  'section': _$GalleryMediaSectionEnumMap[instance.section]!,
};

const _$GalleryRotationEnumMap = {
  GalleryRotation.left: 'left',
  GalleryRotation.right: 'right',
};

_GalleryMetadata _$GalleryMetadataFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['section'],
    disallowNullValues: const ['section'],
  );
  return _GalleryMetadata(
    mediaId: json['mediaId'] as String,
    sourceRevision: json['sourceRevision'] as String,
    name: json['name'] as String,
    path: json['path'] as String,
    kind: $enumDecode(
      _$GalleryEntryKindEnumMap,
      json['kind'],
      unknownValue: GalleryEntryKind.unknown,
    ),
    sizeBytes: (json['sizeBytes'] as num).toInt(),
    section: $enumDecode(_$GalleryMediaSectionEnumMap, json['section']),
    width: (json['width'] as num?)?.toInt(),
    height: (json['height'] as num?)?.toInt(),
    dateTaken: json['dateTaken'] as String?,
    fileModified: json['fileModified'] == null
        ? null
        : DateTime.parse(json['fileModified'] as String),
    format: json['format'] as String?,
    camera: json['camera'] as String?,
    lens: json['lens'] as String?,
    iso: json['iso'] as String?,
    exposure: json['exposure'] as String?,
    aperture: json['aperture'] as String?,
    focalLength: json['focalLength'] as String?,
    orientation: (json['orientation'] as num?)?.toInt(),
    latitude: (json['latitude'] as num?)?.toDouble(),
    longitude: (json['longitude'] as num?)?.toDouble(),
    durationSeconds: (json['durationSeconds'] as num?)?.toDouble(),
    codec: json['codec'] as String?,
    colorProfile: json['colorProfile'] as String?,
    bitDepth: (json['bitDepth'] as num?)?.toInt(),
    hasAlpha: json['hasAlpha'] as bool?,
  );
}

Map<String, dynamic> _$GalleryMetadataToJson(_GalleryMetadata instance) =>
    <String, dynamic>{
      'mediaId': instance.mediaId,
      'sourceRevision': instance.sourceRevision,
      'name': instance.name,
      'path': instance.path,
      'kind': _$GalleryEntryKindEnumMap[instance.kind]!,
      'sizeBytes': instance.sizeBytes,
      'section': _$GalleryMediaSectionEnumMap[instance.section]!,
      'width': instance.width,
      'height': instance.height,
      'dateTaken': instance.dateTaken,
      'fileModified': instance.fileModified?.toIso8601String(),
      'format': instance.format,
      'camera': instance.camera,
      'lens': instance.lens,
      'iso': instance.iso,
      'exposure': instance.exposure,
      'aperture': instance.aperture,
      'focalLength': instance.focalLength,
      'orientation': instance.orientation,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'durationSeconds': instance.durationSeconds,
      'codec': instance.codec,
      'colorProfile': instance.colorProfile,
      'bitDepth': instance.bitDepth,
      'hasAlpha': instance.hasAlpha,
    };

const _$GalleryEntryKindEnumMap = {
  GalleryEntryKind.image: 'image',
  GalleryEntryKind.animatedImage: 'animatedImage',
  GalleryEntryKind.video: 'video',
  GalleryEntryKind.directory: 'directory',
  GalleryEntryKind.unsupported: 'unsupported',
  GalleryEntryKind.unknown: 'unknown',
};

_GalleryDuplicateStartRequest _$GalleryDuplicateStartRequestFromJson(
  Map<String, dynamic> json,
) => _GalleryDuplicateStartRequest(
  operationId: json['operationId'] as String,
  modes: (json['modes'] as List<dynamic>)
      .map((e) => $enumDecode(_$GalleryDuplicateModeEnumMap, e))
      .toList(),
);

Map<String, dynamic> _$GalleryDuplicateStartRequestToJson(
  _GalleryDuplicateStartRequest instance,
) => <String, dynamic>{
  'operationId': instance.operationId,
  'modes': instance.modes
      .map((e) => _$GalleryDuplicateModeEnumMap[e]!)
      .toList(),
};

const _$GalleryDuplicateModeEnumMap = {
  GalleryDuplicateMode.exact: 'exact',
  GalleryDuplicateMode.similar: 'similar',
};

_GalleryDuplicateMember _$GalleryDuplicateMemberFromJson(
  Map<String, dynamic> json,
) {
  $checkKeys(
    json,
    requiredKeys: const ['section'],
    disallowNullValues: const ['section'],
  );
  return _GalleryDuplicateMember(
    mediaId: json['mediaId'] as String,
    sourceRevision: json['sourceRevision'] as String,
    path: json['path'] as String,
    name: json['name'] as String,
    sizeBytes: (json['sizeBytes'] as num).toInt(),
    width: (json['width'] as num?)?.toInt(),
    height: (json['height'] as num?)?.toInt(),
    section: $enumDecode(_$GalleryMediaSectionEnumMap, json['section']),
  );
}

Map<String, dynamic> _$GalleryDuplicateMemberToJson(
  _GalleryDuplicateMember instance,
) => <String, dynamic>{
  'mediaId': instance.mediaId,
  'sourceRevision': instance.sourceRevision,
  'path': instance.path,
  'name': instance.name,
  'sizeBytes': instance.sizeBytes,
  'width': instance.width,
  'height': instance.height,
  'section': _$GalleryMediaSectionEnumMap[instance.section]!,
};

_GalleryDuplicateGroup _$GalleryDuplicateGroupFromJson(
  Map<String, dynamic> json,
) => _GalleryDuplicateGroup(
  groupId: json['groupId'] as String,
  mode: $enumDecode(_$GalleryDuplicateModeEnumMap, json['mode']),
  items: (json['items'] as List<dynamic>)
      .map((e) => GalleryDuplicateMember.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$GalleryDuplicateGroupToJson(
  _GalleryDuplicateGroup instance,
) => <String, dynamic>{
  'groupId': instance.groupId,
  'mode': _$GalleryDuplicateModeEnumMap[instance.mode]!,
  'items': instance.items.map((e) => e.toJson()).toList(),
};

_GalleryDuplicateGroupPage _$GalleryDuplicateGroupPageFromJson(
  Map<String, dynamic> json,
) => _GalleryDuplicateGroupPage(
  jobId: json['jobId'] as String,
  index: (json['index'] as num).toInt(),
  group: json['group'] == null
      ? null
      : GalleryDuplicateGroup.fromJson(json['group'] as Map<String, dynamic>),
);

Map<String, dynamic> _$GalleryDuplicateGroupPageToJson(
  _GalleryDuplicateGroupPage instance,
) => <String, dynamic>{
  'jobId': instance.jobId,
  'index': instance.index,
  'group': instance.group?.toJson(),
};

_GalleryDuplicateDiagnostics _$GalleryDuplicateDiagnosticsFromJson(
  Map<String, dynamic> json,
) => _GalleryDuplicateDiagnostics(
  stage: $enumDecode(
    _$GalleryDuplicateStageEnumMap,
    json['stage'],
    unknownValue: GalleryDuplicateStage.unknown,
  ),
  failureReason: $enumDecodeNullable(
    _$GalleryDuplicateFailureReasonEnumMap,
    json['failureReason'],
    unknownValue: GalleryDuplicateFailureReason.unknown,
  ),
  toolVersion: json['toolVersion'] as String?,
  exitCode: (json['exitCode'] as num?)?.toInt(),
  candidateCount: (json['candidateCount'] as num?)?.toInt() ?? 0,
  matchedFileCount: (json['matchedFileCount'] as num?)?.toInt() ?? 0,
  rejectedResultCount: (json['rejectedResultCount'] as num?)?.toInt() ?? 0,
  snapshotSkippedCount: (json['snapshotSkippedCount'] as num?)?.toInt() ?? 0,
  rootAliased: json['rootAliased'] as bool? ?? false,
  mode: $enumDecodeNullable(
    _$GalleryDuplicateModeEnumMap,
    json['mode'],
    unknownValue: JsonKey.nullForUndefinedEnumValue,
  ),
);

Map<String, dynamic> _$GalleryDuplicateDiagnosticsToJson(
  _GalleryDuplicateDiagnostics instance,
) => <String, dynamic>{
  'stage': _$GalleryDuplicateStageEnumMap[instance.stage]!,
  'failureReason':
      _$GalleryDuplicateFailureReasonEnumMap[instance.failureReason],
  'toolVersion': instance.toolVersion,
  'exitCode': instance.exitCode,
  'candidateCount': instance.candidateCount,
  'matchedFileCount': instance.matchedFileCount,
  'rejectedResultCount': instance.rejectedResultCount,
  'snapshotSkippedCount': instance.snapshotSkippedCount,
  'rootAliased': instance.rootAliased,
  'mode': _$GalleryDuplicateModeEnumMap[instance.mode],
};

const _$GalleryDuplicateStageEnumMap = {
  GalleryDuplicateStage.unknown: 'unknown',
  GalleryDuplicateStage.snapshot: 'snapshot',
  GalleryDuplicateStage.versionProbe: 'versionProbe',
  GalleryDuplicateStage.scanning: 'scanning',
  GalleryDuplicateStage.validation: 'validation',
  GalleryDuplicateStage.persistence: 'persistence',
};

const _$GalleryDuplicateFailureReasonEnumMap = {
  GalleryDuplicateFailureReason.unknown: 'unknown',
  GalleryDuplicateFailureReason.toolUnavailable: 'toolUnavailable',
  GalleryDuplicateFailureReason.unsupportedVersion: 'unsupportedVersion',
  GalleryDuplicateFailureReason.versionProbeFailed: 'versionProbeFailed',
  GalleryDuplicateFailureReason.processFailed: 'processFailed',
  GalleryDuplicateFailureReason.timeout: 'timeout',
  GalleryDuplicateFailureReason.outputLimitExceeded: 'outputLimitExceeded',
  GalleryDuplicateFailureReason.invalidResult: 'invalidResult',
  GalleryDuplicateFailureReason.storageUnavailable: 'storageUnavailable',
  GalleryDuplicateFailureReason.unexpected: 'unexpected',
};

_GalleryDuplicateJob _$GalleryDuplicateJobFromJson(Map<String, dynamic> json) =>
    _GalleryDuplicateJob(
      jobId: json['jobId'] as String,
      status: $enumDecode(_$GalleryDuplicateStatusEnumMap, json['status']),
      startedAt: json['startedAt'] == null
          ? null
          : DateTime.parse(json['startedAt'] as String),
      finishedAt: json['finishedAt'] == null
          ? null
          : DateTime.parse(json['finishedAt'] as String),
      modes:
          (json['modes'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$GalleryDuplicateModeEnumMap, e))
              .toList() ??
          const [],
      groups:
          (json['groups'] as List<dynamic>?)
              ?.map(
                (e) =>
                    GalleryDuplicateGroup.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      error: $enumDecodeNullable(
        _$GalleryErrorCodeEnumMap,
        json['error'],
        unknownValue: GalleryErrorCode.unknown,
      ),
      skipped: (json['skipped'] as num?)?.toInt() ?? 0,
      diagnostics: json['diagnostics'] == null
          ? null
          : GalleryDuplicateDiagnostics.fromJson(
              json['diagnostics'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$GalleryDuplicateJobToJson(
  _GalleryDuplicateJob instance,
) => <String, dynamic>{
  'jobId': instance.jobId,
  'status': _$GalleryDuplicateStatusEnumMap[instance.status]!,
  'startedAt': instance.startedAt?.toIso8601String(),
  'finishedAt': instance.finishedAt?.toIso8601String(),
  'modes': instance.modes
      .map((e) => _$GalleryDuplicateModeEnumMap[e]!)
      .toList(),
  'groups': instance.groups.map((e) => e.toJson()).toList(),
  'error': _$GalleryErrorCodeEnumMap[instance.error],
  'skipped': instance.skipped,
  'diagnostics': instance.diagnostics?.toJson(),
};

const _$GalleryDuplicateStatusEnumMap = {
  GalleryDuplicateStatus.idle: 'idle',
  GalleryDuplicateStatus.running: 'running',
  GalleryDuplicateStatus.stopping: 'stopping',
  GalleryDuplicateStatus.completed: 'completed',
  GalleryDuplicateStatus.cancelled: 'cancelled',
  GalleryDuplicateStatus.failed: 'failed',
  GalleryDuplicateStatus.interrupted: 'interrupted',
};
