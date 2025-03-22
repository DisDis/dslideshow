import 'package:dslideshow_backend/serializers.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'web_server_commands.g.dart';
part 'web_server_commands.freezed.dart';

@freezed
sealed class WebServerControlCommand with _$WebServerControlCommand implements RpcCommand {
  static const String TYPE = 'web_server_control';
  const factory WebServerControlCommand({
    required bool enable,
    required int id,
    @Default(WebServerControlCommand.TYPE) String type,
  }) = _WebServerControlCommand;

  factory WebServerControlCommand.fromJson(Map<String, dynamic> json) => _$WebServerControlCommandFromJson(json);
}

@freezed
sealed class WebServerControlCommandResult with _$WebServerControlCommandResult implements RpcResult {
  static WebServerControlCommandResult respond(RpcCommand command, String code, bool enable) {
    return WebServerControlCommandResult(id: command.id, enable: enable, code: code);
  }

  const factory WebServerControlCommandResult({
    required String code,
    required bool enable,
    required int id,
  }) = _WebServerControlCommandResult;

  factory WebServerControlCommandResult.fromJson(Map<String, dynamic> json) => _$WebServerControlCommandResultFromJson(json);
}

abstract class WebSocketResult {
  int get id;
}

abstract class WebSocketCommand implements WebSocketResult {
  static int _id = 0;

  static int generateId() => _id++;

  String get type;
}

abstract class WebSocketErrorResult extends WebSocketResult {
  String get error;
}

@freezed
sealed class WSErrorResult with _$WSErrorResult implements WebSocketErrorResult {
  const factory WSErrorResult({
    required String error,
    required int id,
  }) = _WSErrorResult;

  static WSErrorResult byId(String error, int commandId) {
    return WSErrorResult(
      id: commandId,
      error: error,
    );
  }

  static WSErrorResult byCommand(String error, WebSocketCommand command) {
    return WSErrorResult(
      id: command.id,
      error: error,
    );
  }

  factory WSErrorResult.fromJson(Map<String, dynamic> json) => _$WSErrorResultFromJson(json);
}

@freezed
sealed class WSHelloCommand with _$WSHelloCommand implements WebSocketCommand {
  static const String TYPE = 'ws_hello';
  const factory WSHelloCommand({
    required int id,
    @Default(WSHelloCommand.TYPE) String type,
  }) = _WSHelloCommand;

  factory WSHelloCommand.fromJson(Map<String, dynamic> json) => _$WSHelloCommandFromJson(json);
}

@freezed
sealed class WSAuthCommand with _$WSAuthCommand implements WebSocketCommand {
  static const String TYPE = 'ws_auth';
  const factory WSAuthCommand({
    required String userName,
    required String code,
    required int id,
    @Default(WSAuthCommand.TYPE) String type,
  }) = _WSAuthCommand;

  factory WSAuthCommand.fromJson(Map<String, dynamic> json) => _$WSAuthCommandFromJson(json);
}

@freezed
sealed class WSSendRpcCommand with _$WSSendRpcCommand implements WebSocketCommand {
  static const String TYPE = 'ws_rpc';
  const factory WSSendRpcCommand({
    ///TODO: FIX it
    //required RpcCommand command,
    required Object commandData,
    //WebSocketCommand.generateId()
    required int id,
    @Default(WSSendRpcCommand.TYPE) String type,
  }) = _WSSendRpcCommand;

  static WSSendRpcCommand byCommand<T extends RpcCommand>(T command) {
    return WSSendRpcCommand(
      id: WebSocketCommand.generateId(),
      commandData: serializers.serialize(command)!,
    );
  }

  factory WSSendRpcCommand.fromJson(Map<String, dynamic> json) => _$WSSendRpcCommandFromJson(json);
}

@freezed
sealed class WSRpcResult with _$WSRpcResult implements WebSocketResult {
  const factory WSRpcResult({
    ///TODO: FIX it
    //required RpcResult result,
    required Object resultData,
    required int id,
  }) = _WSRpcResult;

  factory WSRpcResult.fromJson(Map<String, dynamic> json) => _$WSRpcResultFromJson(json);
  static WSRpcResult byCommand<T extends RpcResult>(T result, WebSocketCommand command) {
    return WSRpcResult(
      id: command.id,
      resultData: serializers.serialize(result)!,
    );
  }
}

@freezed
sealed class WSConfigDownloadCommand with _$WSConfigDownloadCommand implements WebSocketCommand {
  static const String TYPE = 'ws_config_download';
  const factory WSConfigDownloadCommand({
    required int id,
    @Default(WSConfigDownloadCommand.TYPE) String type,
  }) = _WSConfigDownloadCommand;

  factory WSConfigDownloadCommand.fromJson(Map<String, dynamic> json) => _$WSConfigDownloadCommandFromJson(json);
}

@freezed
sealed class WSConfigUploadCommand with _$WSConfigUploadCommand implements WebSocketCommand {
  static const String TYPE = 'ws_config_upload';
  const factory WSConfigUploadCommand({
    required String content,
    required int id,
    @Default(WSConfigUploadCommand.TYPE) String type,
  }) = _WSConfigUploadCommand;

  factory WSConfigUploadCommand.fromJson(Map<String, dynamic> json) => _$WSConfigUploadCommandFromJson(json);
}

@freezed
sealed class WSConfigDownloadResult with _$WSConfigDownloadResult implements WebSocketResult {
  const factory WSConfigDownloadResult({
    required String content,
    required int id,
  }) = _WSConfigDownloadResult;

  factory WSConfigDownloadResult.fromJson(Map<String, dynamic> json) => _$WSConfigDownloadResultFromJson(json);
}

@freezed
sealed class WSRestartApplicationCommand with _$WSRestartApplicationCommand implements WebSocketCommand {
  static const String TYPE = 'ws_restart_application';
  const factory WSRestartApplicationCommand({
    required int id,
    @Default(WSRestartApplicationCommand.TYPE) String type,
  }) = _WSRestartApplicationCommand;

  factory WSRestartApplicationCommand.fromJson(Map<String, dynamic> json) => _$WSRestartApplicationCommandFromJson(json);
}

@freezed
sealed class WSResultOk with _$WSResultOk implements WebSocketResult {
  const factory WSResultOk({
    required int id,
  }) = _WSResultOk;
  static WSResultOk byCommand(WebSocketCommand command) {
    return WSResultOk(id: command.id);
  }

  factory WSResultOk.fromJson(Map<String, dynamic> json) => _$WSResultOkFromJson(json);
}

@freezed
sealed class WSEchoResult with _$WSEchoResult implements WebSocketResult {
  const factory WSEchoResult({
    required String msg,
    required int id,
  }) = _WSEchoResult;

  factory WSEchoResult.fromJson(Map<String, dynamic> json) => _$WSEchoResultFromJson(json);
}

@freezed
sealed class WSEchoCommand with _$WSEchoCommand implements WebSocketCommand {
  static const String TYPE = 'ws_echo';
  const factory WSEchoCommand({
    required String msg,
    required int id,
    @Default(WSEchoCommand.TYPE) String type,
  }) = _WSEchoCommand;

  factory WSEchoCommand.fromJson(Map<String, dynamic> json) => _$WSEchoCommandFromJson(json);
}
