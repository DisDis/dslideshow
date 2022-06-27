import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:dslideshow_common/rpc.dart';

part 'web_server_commands.g.dart';

abstract class WebServerControlCommand
    implements RpcCommand, Built<WebServerControlCommand, WebServerControlCommandBuilder> {
  static const String TYPE = 'web_server_control';
  @override
  String get type => TYPE;
  bool get enable;
  @override
  int get id;

  static Serializer<WebServerControlCommand> get serializer => _$webServerControlCommandSerializer;
  @BuiltValueHook(initializeBuilder: true)
  static void _setDefaults(WebServerControlCommandBuilder b) => b.id = RpcCommand.generateId();
  factory WebServerControlCommand([void updates(WebServerControlCommandBuilder b)?]) = _$WebServerControlCommand;
  WebServerControlCommand._();
}

abstract class WebServerControlCommandResult
    implements RpcResult, Built<WebServerControlCommandResult, WebServerControlCommandResultBuilder> {
  @override
  int get id;

  String get code;
  bool get enable;

  static Serializer<WebServerControlCommandResult> get serializer => _$webServerControlCommandResultSerializer;

  factory WebServerControlCommandResult([void updates(WebServerControlCommandResultBuilder b)?]) =
      _$WebServerControlCommandResult;
  factory WebServerControlCommandResult.respond(RpcCommand command, String code, bool enable) {
    return _$WebServerControlCommandResult((b) => b
      ..id = command.id
      ..enable = enable
      ..code = code);
  }
  WebServerControlCommandResult._();
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

abstract class WSErrorResult implements WebSocketErrorResult, Built<WSErrorResult, WSErrorResultBuilder> {
  String get error;
  int get id;

  static Serializer<WSErrorResult> get serializer => _$wSErrorResultSerializer;

  factory WSErrorResult.id(String error, int commandId) {
    return _$WSErrorResult((b) {
      b.id = commandId;
      b.error = error;
    });
  }
  factory WSErrorResult(String error, WebSocketCommand command) {
    return _$WSErrorResult((b) {
      b.id = command.id;
      b.error = error;
    });
  }
  WSErrorResult._();
}

abstract class WSHelloCommand implements WebSocketCommand, Built<WSHelloCommand, WSHelloCommandBuilder> {
  static const String TYPE = 'ws_hello';
  @override
  String get type => TYPE;

  @override
  int get id;

  @BuiltValueHook(initializeBuilder: true)
  static void _setDefaults(WSHelloCommandBuilder b) => b.id = WebSocketCommand.generateId();

  static Serializer<WSHelloCommand> get serializer => _$wSHelloCommandSerializer;
  factory WSHelloCommand([void updates(WSHelloCommandBuilder b)?]) = _$WSHelloCommand;
  WSHelloCommand._();
}

abstract class WSAuthCommand implements WebSocketCommand, Built<WSAuthCommand, WSAuthCommandBuilder> {
  static const String TYPE = 'ws_auth';
  @override
  String get type => TYPE;

  String get userName;
  String get code;

  @override
  int get id;

  @BuiltValueHook(initializeBuilder: true)
  static void _setDefaults(WSAuthCommandBuilder b) {
    b.id = WebSocketCommand.generateId();
    b.userName = 'admin';
  }

  static Serializer<WSAuthCommand> get serializer => _$wSAuthCommandSerializer;
  factory WSAuthCommand([void updates(WSAuthCommandBuilder b)?]) = _$WSAuthCommand;
  WSAuthCommand._();
}

// abstract class WSAuthReqCommand implements WebSocketCommand, Built<WSAuthReqCommand, WSAuthReqCommandBuilder> {
//   static const String TYPE = 'ws_auth_req';
//   @override
//   String get type => TYPE;

//   static Serializer<WSAuthReqCommand> get serializer => _$wSAuthReqCommandSerializer;
//   factory WSAuthReqCommand([void updates(WSAuthReqCommandBuilder b)?]) = _$WSAuthReqCommand;
//   WSAuthReqCommand._();
// }

abstract class WSSendRpcCommand implements WebSocketCommand, Built<WSSendRpcCommand, WSSendRpcCommandBuilder> {
  static const String TYPE = 'ws_rpc';
  @override
  String get type => TYPE;

  RpcCommand get command;

  @override
  int get id;

  @BuiltValueHook(initializeBuilder: true)
  static void _setDefaults(WSSendRpcCommandBuilder b) => b.id = WebSocketCommand.generateId();

  static Serializer<WSSendRpcCommand> get serializer => _$wSSendRpcCommandSerializer;
  factory WSSendRpcCommand([void updates(WSSendRpcCommandBuilder b)?]) = _$WSSendRpcCommand;
  WSSendRpcCommand._();
}

abstract class WSRpcResult implements WebSocketResult, Built<WSRpcResult, WSRpcResultBuilder> {
  @override
  int get id;

  RpcResult get result;

  static Serializer<WSRpcResult> get serializer => _$wSRpcResultSerializer;
  factory WSRpcResult(RpcResult result, WebSocketCommand command) {
    return _$WSRpcResult((b) {
      b.id = command.id;
      b.result = result;
    });
  }
  WSRpcResult._();
}

abstract class WSConfigDownloadCommand
    implements WebSocketCommand, Built<WSConfigDownloadCommand, WSConfigDownloadCommandBuilder> {
  static const String TYPE = 'ws_config_download';
  @override
  String get type => TYPE;

  @override
  int get id;

  @BuiltValueHook(initializeBuilder: true)
  static void _setDefaults(WSConfigDownloadCommandBuilder b) => b.id = WebSocketCommand.generateId();

  static Serializer<WSConfigDownloadCommand> get serializer => _$wSConfigDownloadCommandSerializer;
  factory WSConfigDownloadCommand([void updates(WSConfigDownloadCommandBuilder b)?]) = _$WSConfigDownloadCommand;
  WSConfigDownloadCommand._();
}

abstract class WSConfigUploadCommand
    implements WebSocketCommand, Built<WSConfigUploadCommand, WSConfigUploadCommandBuilder> {
  static const String TYPE = 'ws_config_upload';
  @override
  String get type => TYPE;

  String get content;

  @override
  int get id;

  @BuiltValueHook(initializeBuilder: true)
  static void _setDefaults(WSConfigUploadCommandBuilder b) => b.id = WebSocketCommand.generateId();

  static Serializer<WSConfigUploadCommand> get serializer => _$wSConfigUploadCommandSerializer;
  factory WSConfigUploadCommand([void updates(WSConfigUploadCommandBuilder b)?]) = _$WSConfigUploadCommand;
  WSConfigUploadCommand._();
}

abstract class WSConfigDownloadResult
    implements WebSocketResult, Built<WSConfigDownloadResult, WSConfigDownloadResultBuilder> {
  String get content;
  @override
  int get id;

  static Serializer<WSConfigDownloadResult> get serializer => _$wSConfigDownloadResultSerializer;
  factory WSConfigDownloadResult([void updates(WSConfigDownloadResultBuilder b)?]) = _$WSConfigDownloadResult;
  WSConfigDownloadResult._();
}

abstract class WSRestartApplicationCommand
    implements WebSocketCommand, Built<WSRestartApplicationCommand, WSRestartApplicationCommandBuilder> {
  static const String TYPE = 'ws_restart_application';
  @override
  String get type => TYPE;

  @override
  int get id;

  @BuiltValueHook(initializeBuilder: true)
  static void _setDefaults(WSRestartApplicationCommandBuilder b) => b.id = WebSocketCommand.generateId();

  static Serializer<WSRestartApplicationCommand> get serializer => _$wSRestartApplicationCommandSerializer;
  factory WSRestartApplicationCommand([void updates(WSRestartApplicationCommandBuilder b)?]) =
      _$WSRestartApplicationCommand;
  WSRestartApplicationCommand._();
}

abstract class WSResultOk implements WebSocketResult, Built<WSResultOk, WSResultOkBuilder> {
  @override
  int get id;

  static Serializer<WSResultOk> get serializer => _$wSResultOkSerializer;
  factory WSResultOk(WebSocketCommand command) {
    return _$WSResultOk((b) => b.id = command.id);
  }
  WSResultOk._();
}

abstract class WSEchoResult implements WebSocketResult, Built<WSEchoResult, WSEchoResultBuilder> {
  @override
  int get id;
  String get msg;

  static Serializer<WSEchoResult> get serializer => _$wSEchoResultSerializer;
  factory WSEchoResult(WSEchoCommand command) {
    return _$WSEchoResult((b) {
      b.id = command.id;
      b.msg = command.msg;
    });
  }
  WSEchoResult._();
}

abstract class WSEchoCommand implements WebSocketCommand, Built<WSEchoCommand, WSEchoCommandBuilder> {
  static const String TYPE = 'ws_echo';
  @override
  String get type => TYPE;

  @override
  int get id;

  String get msg;

  @BuiltValueHook(initializeBuilder: true)
  static void _setDefaults(WSEchoCommandBuilder b) => b.id = WebSocketCommand.generateId();

  static Serializer<WSEchoCommand> get serializer => _$wSEchoCommandSerializer;
  factory WSEchoCommand([void updates(WSEchoCommandBuilder b)?]) = _$WSEchoCommand;
  WSEchoCommand._();
}
