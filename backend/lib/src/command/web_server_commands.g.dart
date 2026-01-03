// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_server_commands.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WebServerControlCommand _$WebServerControlCommandFromJson(
  Map<String, dynamic> json,
) => _WebServerControlCommand(
  enable: json['enable'] as bool,
  id: (json['id'] as num).toInt(),
  type: json['type'] as String? ?? WebServerControlCommand.TYPE,
);

Map<String, dynamic> _$WebServerControlCommandToJson(
  _WebServerControlCommand instance,
) => <String, dynamic>{
  'enable': instance.enable,
  'id': instance.id,
  'type': instance.type,
};

_WebServerControlCommandResult _$WebServerControlCommandResultFromJson(
  Map<String, dynamic> json,
) => _WebServerControlCommandResult(
  code: json['code'] as String,
  enable: json['enable'] as bool,
  id: (json['id'] as num).toInt(),
);

Map<String, dynamic> _$WebServerControlCommandResultToJson(
  _WebServerControlCommandResult instance,
) => <String, dynamic>{
  'code': instance.code,
  'enable': instance.enable,
  'id': instance.id,
};

_WSErrorResult _$WSErrorResultFromJson(Map<String, dynamic> json) =>
    _WSErrorResult(
      error: json['error'] as String,
      id: (json['id'] as num).toInt(),
    );

Map<String, dynamic> _$WSErrorResultToJson(_WSErrorResult instance) =>
    <String, dynamic>{'error': instance.error, 'id': instance.id};

_WSHelloCommand _$WSHelloCommandFromJson(Map<String, dynamic> json) =>
    _WSHelloCommand(
      id: (json['id'] as num).toInt(),
      type: json['type'] as String? ?? WSHelloCommand.TYPE,
    );

Map<String, dynamic> _$WSHelloCommandToJson(_WSHelloCommand instance) =>
    <String, dynamic>{'id': instance.id, 'type': instance.type};

_WSAuthCommand _$WSAuthCommandFromJson(Map<String, dynamic> json) =>
    _WSAuthCommand(
      userName: json['userName'] as String,
      code: json['code'] as String,
      id: (json['id'] as num).toInt(),
      type: json['type'] as String? ?? WSAuthCommand.TYPE,
    );

Map<String, dynamic> _$WSAuthCommandToJson(_WSAuthCommand instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'code': instance.code,
      'id': instance.id,
      'type': instance.type,
    };

_WSSendRpcCommand _$WSSendRpcCommandFromJson(Map<String, dynamic> json) =>
    _WSSendRpcCommand(
      commandData: json['commandData'] as Object,
      id: (json['id'] as num).toInt(),
      type: json['type'] as String? ?? WSSendRpcCommand.TYPE,
    );

Map<String, dynamic> _$WSSendRpcCommandToJson(_WSSendRpcCommand instance) =>
    <String, dynamic>{
      'commandData': instance.commandData,
      'id': instance.id,
      'type': instance.type,
    };

_WSRpcResult _$WSRpcResultFromJson(Map<String, dynamic> json) => _WSRpcResult(
  resultData: json['resultData'] as Object,
  id: (json['id'] as num).toInt(),
);

Map<String, dynamic> _$WSRpcResultToJson(_WSRpcResult instance) =>
    <String, dynamic>{'resultData': instance.resultData, 'id': instance.id};

_WSConfigDownloadCommand _$WSConfigDownloadCommandFromJson(
  Map<String, dynamic> json,
) => _WSConfigDownloadCommand(
  id: (json['id'] as num).toInt(),
  type: json['type'] as String? ?? WSConfigDownloadCommand.TYPE,
);

Map<String, dynamic> _$WSConfigDownloadCommandToJson(
  _WSConfigDownloadCommand instance,
) => <String, dynamic>{'id': instance.id, 'type': instance.type};

_WSConfigUploadCommand _$WSConfigUploadCommandFromJson(
  Map<String, dynamic> json,
) => _WSConfigUploadCommand(
  content: json['content'] as String,
  id: (json['id'] as num).toInt(),
  type: json['type'] as String? ?? WSConfigUploadCommand.TYPE,
);

Map<String, dynamic> _$WSConfigUploadCommandToJson(
  _WSConfigUploadCommand instance,
) => <String, dynamic>{
  'content': instance.content,
  'id': instance.id,
  'type': instance.type,
};

_WSConfigDownloadResult _$WSConfigDownloadResultFromJson(
  Map<String, dynamic> json,
) => _WSConfigDownloadResult(
  content: json['content'] as String,
  id: (json['id'] as num).toInt(),
);

Map<String, dynamic> _$WSConfigDownloadResultToJson(
  _WSConfigDownloadResult instance,
) => <String, dynamic>{'content': instance.content, 'id': instance.id};

_WSResultOk _$WSResultOkFromJson(Map<String, dynamic> json) =>
    _WSResultOk(id: (json['id'] as num).toInt());

Map<String, dynamic> _$WSResultOkToJson(_WSResultOk instance) =>
    <String, dynamic>{'id': instance.id};

_WSEchoResult _$WSEchoResultFromJson(Map<String, dynamic> json) =>
    _WSEchoResult(msg: json['msg'] as String, id: (json['id'] as num).toInt());

Map<String, dynamic> _$WSEchoResultToJson(_WSEchoResult instance) =>
    <String, dynamic>{'msg': instance.msg, 'id': instance.id};

_WSEchoCommand _$WSEchoCommandFromJson(Map<String, dynamic> json) =>
    _WSEchoCommand(
      msg: json['msg'] as String,
      id: (json['id'] as num).toInt(),
      type: json['type'] as String? ?? WSEchoCommand.TYPE,
    );

Map<String, dynamic> _$WSEchoCommandToJson(_WSEchoCommand instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'id': instance.id,
      'type': instance.type,
    };
