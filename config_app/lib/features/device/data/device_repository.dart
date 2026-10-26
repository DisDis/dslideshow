import 'package:config_app/features/realtime/domain/services/realtime_service.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/serializers.dart';
import 'package:dslideshow_common/rpc.dart';

enum DeviceFailureKind { load, command, disconnected, invalidResponse }

/// A safe, localizable failure category. Remote response text stays off the UI.
class DeviceFailure implements Exception {
  final DeviceFailureKind kind;

  const DeviceFailure(this.kind);
}

class DeviceRepository {
  final RealtimeService client;

  DeviceRepository(this.client);

  Stream get onDisconnect => client.onDisconnect;

  int? get webSocketTimeouts => client is RealtimeDiagnostics
      ? (client as RealtimeDiagnostics).requestTimeouts
      : null;

  Future<RpcTelemetrySnapshot> getRpcTelemetry() async {
    final result = await _request<GetRpcTelemetryResult>(
      GetRpcTelemetryCommand(id: RpcCommand.generateId()),
    );
    return result.snapshot;
  }

  Future<FrameState> getState() async {
    final result = await _request<GetFrameStateResult>(
      GetFrameStateCommand(id: RpcCommand.generateId()),
    );
    return result.state;
  }

  Future<SystemInfo> getSystemInfo() async {
    final result = await _request<GetSystemInfoCommandResult>(
      GetSystemInfoCommand(id: RpcCommand.generateId()),
    );
    return result.systemInfo;
  }

  Future<FrameState> setControl(FrameControl control, bool enabled) async {
    final result = await _request<GetFrameStateResult>(
      SetFrameControlCommand(
        id: RpcCommand.generateId(),
        control: control,
        enabled: enabled,
      ),
      failureKind: DeviceFailureKind.command,
    );
    return result.state;
  }

  Future<T> _request<T extends RpcResult>(
    RpcCommand command, {
    DeviceFailureKind failureKind = DeviceFailureKind.load,
  }) async {
    final envelope = WSSendRpcCommand.byCommand(command);
    final WebSocketResult response;
    try {
      response = await client.send(envelope);
    } catch (_) {
      throw DeviceFailure(failureKind);
    }
    if (response.id != envelope.id) {
      throw const DeviceFailure(DeviceFailureKind.invalidResponse);
    }
    if (response is WebSocketErrorResult) {
      throw DeviceFailure(failureKind);
    }
    if (response is! WSRpcResult) {
      throw const DeviceFailure(DeviceFailureKind.invalidResponse);
    }
    final Object? result;
    try {
      result = serializers.deserialize(response.resultData);
    } catch (_) {
      throw const DeviceFailure(DeviceFailureKind.invalidResponse);
    }
    if (result is! RpcResult || result.id != command.id) {
      throw const DeviceFailure(DeviceFailureKind.invalidResponse);
    }
    if (result is RpcErrorResult) {
      throw DeviceFailure(failureKind);
    }
    if (result is! T) {
      throw const DeviceFailure(DeviceFailureKind.invalidResponse);
    }
    return result;
  }
}
