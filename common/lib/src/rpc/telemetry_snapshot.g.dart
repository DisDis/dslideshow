// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'telemetry_snapshot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RpcTelemetrySnapshot _$RpcTelemetrySnapshotFromJson(
  Map<String, dynamic> json,
) => RpcTelemetrySnapshot(
  nodes:
      (json['nodes'] as List<dynamic>?)
          ?.map((e) => RpcNodeSnapshot.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$RpcTelemetrySnapshotToJson(
  RpcTelemetrySnapshot instance,
) => <String, dynamic>{'nodes': instance.nodes.map((e) => e.toJson()).toList()};

RpcNodeSnapshot _$RpcNodeSnapshotFromJson(Map<String, dynamic> json) =>
    RpcNodeSnapshot(
      node: $enumDecode(
        _$RpcNodeEnumMap,
        json['node'],
        unknownValue: RpcNode.unknown,
      ),
      sessionId: json['sessionId'] as String,
      sampledAt: DateTime.parse(json['sampledAt'] as String),
      elapsedMicros: (json['elapsedMicros'] as num).toInt(),
      stale: json['stale'] as bool? ?? false,
      connections:
          (json['connections'] as List<dynamic>?)
              ?.map(
                (e) =>
                    RpcConnectionSnapshot.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$RpcNodeSnapshotToJson(RpcNodeSnapshot instance) =>
    <String, dynamic>{
      'node': _$RpcNodeEnumMap[instance.node]!,
      'sessionId': instance.sessionId,
      'sampledAt': instance.sampledAt.toIso8601String(),
      'elapsedMicros': instance.elapsedMicros,
      'stale': instance.stale,
      'connections': instance.connections.map((e) => e.toJson()).toList(),
    };

const _$RpcNodeEnumMap = {
  RpcNode.unknown: 'unknown',
  RpcNode.frontend: 'frontend',
  RpcNode.backend: 'backend',
  RpcNode.web: 'web',
  RpcNode.ota: 'ota',
};

RpcConnectionSnapshot _$RpcConnectionSnapshotFromJson(
  Map<String, dynamic> json,
) => RpcConnectionSnapshot(
  peer: $enumDecode(
    _$RpcNodeEnumMap,
    json['peer'],
    unknownValue: RpcNode.unknown,
  ),
  outgoing: RpcQueueSnapshot.fromJson(json['outgoing'] as Map<String, dynamic>),
  incoming: RpcHandlerSnapshot.fromJson(
    json['incoming'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$RpcConnectionSnapshotToJson(
  RpcConnectionSnapshot instance,
) => <String, dynamic>{
  'peer': _$RpcNodeEnumMap[instance.peer]!,
  'outgoing': instance.outgoing.toJson(),
  'incoming': instance.incoming.toJson(),
};

RpcDurationSnapshot _$RpcDurationSnapshotFromJson(Map<String, dynamic> json) =>
    RpcDurationSnapshot(
      count: (json['count'] as num?)?.toInt() ?? 0,
      totalMicros: (json['totalMicros'] as num?)?.toInt() ?? 0,
      maxMicros: (json['maxMicros'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$RpcDurationSnapshotToJson(
  RpcDurationSnapshot instance,
) => <String, dynamic>{
  'count': instance.count,
  'totalMicros': instance.totalMicros,
  'maxMicros': instance.maxMicros,
};

RpcPendingSnapshot _$RpcPendingSnapshotFromJson(Map<String, dynamic> json) =>
    RpcPendingSnapshot(
      commandType: json['commandType'] as String?,
      ageMicros: (json['ageMicros'] as num).toInt(),
    );

Map<String, dynamic> _$RpcPendingSnapshotToJson(RpcPendingSnapshot instance) =>
    <String, dynamic>{
      'commandType': instance.commandType,
      'ageMicros': instance.ageMicros,
    };

RpcQueueSnapshot _$RpcQueueSnapshotFromJson(Map<String, dynamic> json) =>
    RpcQueueSnapshot(
      capacity: (json['capacity'] as num).toInt(),
      queued: (json['queued'] as num?)?.toInt() ?? 0,
      inFlight: (json['inFlight'] as num?)?.toInt() ?? 0,
      maxQueued: (json['maxQueued'] as num?)?.toInt() ?? 0,
      maxInFlight: (json['maxInFlight'] as num?)?.toInt() ?? 0,
      submitted: (json['submitted'] as num?)?.toInt() ?? 0,
      sent: (json['sent'] as num?)?.toInt() ?? 0,
      responses: (json['responses'] as num?)?.toInt() ?? 0,
      transportErrors: (json['transportErrors'] as num?)?.toInt() ?? 0,
      responseErrors: (json['responseErrors'] as num?)?.toInt() ?? 0,
      slotWait: json['slotWait'] == null
          ? const RpcDurationSnapshot()
          : RpcDurationSnapshot.fromJson(
              json['slotWait'] as Map<String, dynamic>,
            ),
      responseWait: json['responseWait'] == null
          ? const RpcDurationSnapshot()
          : RpcDurationSnapshot.fromJson(
              json['responseWait'] as Map<String, dynamic>,
            ),
      oldestQueued: json['oldestQueued'] == null
          ? null
          : RpcPendingSnapshot.fromJson(
              json['oldestQueued'] as Map<String, dynamic>,
            ),
      oldestInFlight: json['oldestInFlight'] == null
          ? null
          : RpcPendingSnapshot.fromJson(
              json['oldestInFlight'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$RpcQueueSnapshotToJson(RpcQueueSnapshot instance) =>
    <String, dynamic>{
      'capacity': instance.capacity,
      'queued': instance.queued,
      'inFlight': instance.inFlight,
      'maxQueued': instance.maxQueued,
      'maxInFlight': instance.maxInFlight,
      'submitted': instance.submitted,
      'sent': instance.sent,
      'responses': instance.responses,
      'transportErrors': instance.transportErrors,
      'responseErrors': instance.responseErrors,
      'slotWait': instance.slotWait.toJson(),
      'responseWait': instance.responseWait.toJson(),
      'oldestQueued': instance.oldestQueued?.toJson(),
      'oldestInFlight': instance.oldestInFlight?.toJson(),
    };

RpcHandlerSnapshot _$RpcHandlerSnapshotFromJson(Map<String, dynamic> json) =>
    RpcHandlerSnapshot(
      active: (json['active'] as num?)?.toInt() ?? 0,
      maxActive: (json['maxActive'] as num?)?.toInt() ?? 0,
      completed: (json['completed'] as num?)?.toInt() ?? 0,
      errors: (json['errors'] as num?)?.toInt() ?? 0,
      duration: json['duration'] == null
          ? const RpcDurationSnapshot()
          : RpcDurationSnapshot.fromJson(
              json['duration'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$RpcHandlerSnapshotToJson(RpcHandlerSnapshot instance) =>
    <String, dynamic>{
      'active': instance.active,
      'maxActive': instance.maxActive,
      'completed': instance.completed,
      'errors': instance.errors,
      'duration': instance.duration.toJson(),
    };

GetRpcTelemetryCommand _$GetRpcTelemetryCommandFromJson(
  Map<String, dynamic> json,
) => GetRpcTelemetryCommand(
  id: (json['id'] as num).toInt(),
  type: json['type'] as String? ?? 'get_rpc_telemetry',
);

Map<String, dynamic> _$GetRpcTelemetryCommandToJson(
  GetRpcTelemetryCommand instance,
) => <String, dynamic>{'id': instance.id, 'type': instance.type};

GetRpcTelemetryResult _$GetRpcTelemetryResultFromJson(
  Map<String, dynamic> json,
) => GetRpcTelemetryResult(
  id: (json['id'] as num).toInt(),
  snapshot: RpcTelemetrySnapshot.fromJson(
    json['snapshot'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$GetRpcTelemetryResultToJson(
  GetRpcTelemetryResult instance,
) => <String, dynamic>{
  'id': instance.id,
  'snapshot': instance.snapshot.toJson(),
};
