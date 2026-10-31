import 'package:config_app/features/realtime/domain/services/realtime_service.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart' as storage_config show StorageType;
import 'package:dslideshow_backend/serializers.dart';
import 'package:dslideshow_common/rpc.dart';

enum YandexPanelFailureKind { load, rejected, outcomeUnknown, authorization }

/// Transport failures expose a safe category, never OAuth response contents.
class YandexPanelFailure implements Exception {
  const YandexPanelFailure(this.kind);
  final YandexPanelFailureKind kind;
}

class YandexDriveRepository {
  YandexDriveRepository(this.client);
  final RealtimeService client;

  Future<DriveResult> request(
    DriveAction action, {
    String? clientId,
    String? clientSecret,
    String? sessionId,
    String? accountId,
    String? path,
    int offset = 0,
    bool? paused,
  }) async {
    final command = DriveCommand(
      provider: storage_config.StorageType.YandexDriveStorage,
      id: RpcCommand.generateId(),
      action: action,
      clientId: clientId,
      clientSecret: clientSecret,
      sessionId: sessionId,
      accountId: accountId,
      path: path,
      offset: offset,
      paused: paused,
    );
    final envelope = WSSendRpcCommand.byCommand(command);
    final readOnly =
        action == DriveAction.state || action == DriveAction.authorization || action == DriveAction.folders;
    final unknown = YandexPanelFailure(readOnly ? YandexPanelFailureKind.load : YandexPanelFailureKind.outcomeUnknown);
    final WebSocketResult response;
    try {
      response = await client.send(envelope, timeout: const Duration(seconds: 20));
    } catch (_) {
      throw unknown;
    }
    if (response.id != envelope.id || response is! WSRpcResult) throw unknown;
    final Object? result;
    try {
      result = serializers.deserialize(response.resultData);
    } catch (_) {
      throw unknown;
    }
    if (result is RpcErrorResult) throw const YandexPanelFailure(YandexPanelFailureKind.rejected);
    if (result is! DriveResult || result.id != command.id) throw unknown;
    if (result.error == DriveFailure.authorizationRequired ||
        result.error == DriveFailure.authorizationDenied ||
        result.error == DriveFailure.authorizationExpired) {
      throw const YandexPanelFailure(YandexPanelFailureKind.authorization);
    }
    if (result.error != null) throw const YandexPanelFailure(YandexPanelFailureKind.rejected);
    return result;
  }
}
