import 'package:json_annotation/json_annotation.dart';

import 'command.dart';

part 'telemetry_snapshot.g.dart';

enum RpcNode { unknown, frontend, backend, web, ota }

@JsonSerializable(explicitToJson: true)
class RpcTelemetrySnapshot {
  final List<RpcNodeSnapshot> nodes;
  const RpcTelemetrySnapshot({this.nodes = const []});
  factory RpcTelemetrySnapshot.fromJson(Map<String, dynamic> json) =>
      _$RpcTelemetrySnapshotFromJson(json);
  Map<String, dynamic> toJson() => _$RpcTelemetrySnapshotToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RpcNodeSnapshot {
  @JsonKey(unknownEnumValue: RpcNode.unknown)
  final RpcNode node;
  final String sessionId;
  final DateTime sampledAt;
  final int elapsedMicros;
  final bool stale;
  final List<RpcConnectionSnapshot> connections;
  const RpcNodeSnapshot({
    required this.node,
    required this.sessionId,
    required this.sampledAt,
    required this.elapsedMicros,
    this.stale = false,
    this.connections = const [],
  });
  factory RpcNodeSnapshot.fromJson(Map<String, dynamic> json) =>
      _$RpcNodeSnapshotFromJson(json);
  Map<String, dynamic> toJson() => _$RpcNodeSnapshotToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RpcConnectionSnapshot {
  @JsonKey(unknownEnumValue: RpcNode.unknown)
  final RpcNode peer;
  final RpcQueueSnapshot outgoing;
  final RpcHandlerSnapshot incoming;
  const RpcConnectionSnapshot({
    required this.peer,
    required this.outgoing,
    required this.incoming,
  });
  factory RpcConnectionSnapshot.fromJson(Map<String, dynamic> json) =>
      _$RpcConnectionSnapshotFromJson(json);
  Map<String, dynamic> toJson() => _$RpcConnectionSnapshotToJson(this);
}

@JsonSerializable()
class RpcDurationSnapshot {
  final int count;
  final int totalMicros;
  final int maxMicros;
  const RpcDurationSnapshot({
    this.count = 0,
    this.totalMicros = 0,
    this.maxMicros = 0,
  });
  double get meanMicros => count == 0 ? 0 : totalMicros / count;
  factory RpcDurationSnapshot.fromJson(Map<String, dynamic> json) =>
      _$RpcDurationSnapshotFromJson(json);
  Map<String, dynamic> toJson() => _$RpcDurationSnapshotToJson(this);
}

@JsonSerializable()
class RpcPendingSnapshot {
  final String? commandType;
  final int ageMicros;
  const RpcPendingSnapshot({this.commandType, required this.ageMicros});
  factory RpcPendingSnapshot.fromJson(Map<String, dynamic> json) =>
      _$RpcPendingSnapshotFromJson(json);
  Map<String, dynamic> toJson() => _$RpcPendingSnapshotToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RpcQueueSnapshot {
  final int capacity;
  final int queued;
  final int inFlight;
  final int maxQueued;
  final int maxInFlight;
  final int submitted;
  final int sent;
  final int responses;
  final int transportErrors;
  final int responseErrors;
  final RpcDurationSnapshot slotWait;
  final RpcDurationSnapshot responseWait;
  final RpcPendingSnapshot? oldestQueued;
  final RpcPendingSnapshot? oldestInFlight;
  const RpcQueueSnapshot({
    required this.capacity,
    this.queued = 0,
    this.inFlight = 0,
    this.maxQueued = 0,
    this.maxInFlight = 0,
    this.submitted = 0,
    this.sent = 0,
    this.responses = 0,
    this.transportErrors = 0,
    this.responseErrors = 0,
    this.slotWait = const RpcDurationSnapshot(),
    this.responseWait = const RpcDurationSnapshot(),
    this.oldestQueued,
    this.oldestInFlight,
  });
  factory RpcQueueSnapshot.fromJson(Map<String, dynamic> json) =>
      _$RpcQueueSnapshotFromJson(json);
  Map<String, dynamic> toJson() => _$RpcQueueSnapshotToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RpcHandlerSnapshot {
  final int active;
  final int maxActive;
  final int completed;
  final int errors;
  final RpcDurationSnapshot duration;
  const RpcHandlerSnapshot({
    this.active = 0,
    this.maxActive = 0,
    this.completed = 0,
    this.errors = 0,
    this.duration = const RpcDurationSnapshot(),
  });
  factory RpcHandlerSnapshot.fromJson(Map<String, dynamic> json) =>
      _$RpcHandlerSnapshotFromJson(json);
  Map<String, dynamic> toJson() => _$RpcHandlerSnapshotToJson(this);
}

@JsonSerializable()
class GetRpcTelemetryCommand implements RpcCommand {
  @override
  final int id;
  @override
  final String type;
  const GetRpcTelemetryCommand({
    required this.id,
    this.type = 'get_rpc_telemetry',
  });
  factory GetRpcTelemetryCommand.fromJson(Map<String, dynamic> json) =>
      _$GetRpcTelemetryCommandFromJson(json);
  Map<String, dynamic> toJson() => _$GetRpcTelemetryCommandToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetRpcTelemetryResult implements RpcResult {
  @override
  final int id;
  final RpcTelemetrySnapshot snapshot;
  const GetRpcTelemetryResult({required this.id, required this.snapshot});
  factory GetRpcTelemetryResult.fromJson(Map<String, dynamic> json) =>
      _$GetRpcTelemetryResultFromJson(json);
  Map<String, dynamic> toJson() => _$GetRpcTelemetryResultToJson(this);
}
