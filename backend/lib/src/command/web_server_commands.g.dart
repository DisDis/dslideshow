// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_server_commands.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WebServerControlCommandImpl _$$WebServerControlCommandImplFromJson(
        Map<String, dynamic> json) =>
    _$WebServerControlCommandImpl(
      enable: json['enable'] as bool,
      id: json['id'] as int,
      type: json['type'] as String? ?? WebServerControlCommand.TYPE,
    );

Map<String, dynamic> _$$WebServerControlCommandImplToJson(
        _$WebServerControlCommandImpl instance) =>
    <String, dynamic>{
      'enable': instance.enable,
      'id': instance.id,
      'type': instance.type,
    };

_$WebServerControlCommandResultImpl
    _$$WebServerControlCommandResultImplFromJson(Map<String, dynamic> json) =>
        _$WebServerControlCommandResultImpl(
          code: json['code'] as String,
          enable: json['enable'] as bool,
          id: json['id'] as int,
        );

Map<String, dynamic> _$$WebServerControlCommandResultImplToJson(
        _$WebServerControlCommandResultImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'enable': instance.enable,
      'id': instance.id,
    };

_$WSErrorResultImpl _$$WSErrorResultImplFromJson(Map<String, dynamic> json) =>
    _$WSErrorResultImpl(
      error: json['error'] as String,
      id: json['id'] as int,
    );

Map<String, dynamic> _$$WSErrorResultImplToJson(_$WSErrorResultImpl instance) =>
    <String, dynamic>{
      'error': instance.error,
      'id': instance.id,
    };

_$WSHelloCommandImpl _$$WSHelloCommandImplFromJson(Map<String, dynamic> json) =>
    _$WSHelloCommandImpl(
      id: json['id'] as int,
      type: json['type'] as String? ?? WSHelloCommand.TYPE,
    );

Map<String, dynamic> _$$WSHelloCommandImplToJson(
        _$WSHelloCommandImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
    };

_$WSAuthCommandImpl _$$WSAuthCommandImplFromJson(Map<String, dynamic> json) =>
    _$WSAuthCommandImpl(
      userName: json['userName'] as String,
      code: json['code'] as String,
      id: json['id'] as int,
      type: json['type'] as String? ?? WSAuthCommand.TYPE,
    );

Map<String, dynamic> _$$WSAuthCommandImplToJson(_$WSAuthCommandImpl instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'code': instance.code,
      'id': instance.id,
      'type': instance.type,
    };

_$WSSendRpcCommandImpl _$$WSSendRpcCommandImplFromJson(
        Map<String, dynamic> json) =>
    _$WSSendRpcCommandImpl(
      commandData: json['commandData'] as Object,
      id: json['id'] as int,
      type: json['type'] as String? ?? WSSendRpcCommand.TYPE,
    );

Map<String, dynamic> _$$WSSendRpcCommandImplToJson(
        _$WSSendRpcCommandImpl instance) =>
    <String, dynamic>{
      'commandData': instance.commandData,
      'id': instance.id,
      'type': instance.type,
    };

_$WSRpcResultImpl _$$WSRpcResultImplFromJson(Map<String, dynamic> json) =>
    _$WSRpcResultImpl(
      resultData: json['resultData'] as Object,
      id: json['id'] as int,
    );

Map<String, dynamic> _$$WSRpcResultImplToJson(_$WSRpcResultImpl instance) =>
    <String, dynamic>{
      'resultData': instance.resultData,
      'id': instance.id,
    };

_$WSConfigDownloadCommandImpl _$$WSConfigDownloadCommandImplFromJson(
        Map<String, dynamic> json) =>
    _$WSConfigDownloadCommandImpl(
      id: json['id'] as int,
      type: json['type'] as String? ?? WSConfigDownloadCommand.TYPE,
    );

Map<String, dynamic> _$$WSConfigDownloadCommandImplToJson(
        _$WSConfigDownloadCommandImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
    };

_$WSConfigUploadCommandImpl _$$WSConfigUploadCommandImplFromJson(
        Map<String, dynamic> json) =>
    _$WSConfigUploadCommandImpl(
      content: json['content'] as String,
      id: json['id'] as int,
      type: json['type'] as String? ?? WSConfigUploadCommand.TYPE,
    );

Map<String, dynamic> _$$WSConfigUploadCommandImplToJson(
        _$WSConfigUploadCommandImpl instance) =>
    <String, dynamic>{
      'content': instance.content,
      'id': instance.id,
      'type': instance.type,
    };

_$WSConfigDownloadResultImpl _$$WSConfigDownloadResultImplFromJson(
        Map<String, dynamic> json) =>
    _$WSConfigDownloadResultImpl(
      content: json['content'] as String,
      id: json['id'] as int,
    );

Map<String, dynamic> _$$WSConfigDownloadResultImplToJson(
        _$WSConfigDownloadResultImpl instance) =>
    <String, dynamic>{
      'content': instance.content,
      'id': instance.id,
    };

_$WSRestartApplicationCommandImpl _$$WSRestartApplicationCommandImplFromJson(
        Map<String, dynamic> json) =>
    _$WSRestartApplicationCommandImpl(
      id: json['id'] as int,
      type: json['type'] as String? ?? WSRestartApplicationCommand.TYPE,
    );

Map<String, dynamic> _$$WSRestartApplicationCommandImplToJson(
        _$WSRestartApplicationCommandImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
    };

_$WSResultOkImpl _$$WSResultOkImplFromJson(Map<String, dynamic> json) =>
    _$WSResultOkImpl(
      id: json['id'] as int,
    );

Map<String, dynamic> _$$WSResultOkImplToJson(_$WSResultOkImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

_$WSEchoResultImpl _$$WSEchoResultImplFromJson(Map<String, dynamic> json) =>
    _$WSEchoResultImpl(
      msg: json['msg'] as String,
      id: json['id'] as int,
    );

Map<String, dynamic> _$$WSEchoResultImplToJson(_$WSEchoResultImpl instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'id': instance.id,
    };

_$WSEchoCommandImpl _$$WSEchoCommandImplFromJson(Map<String, dynamic> json) =>
    _$WSEchoCommandImpl(
      msg: json['msg'] as String,
      id: json['id'] as int,
      type: json['type'] as String? ?? WSEchoCommand.TYPE,
    );

Map<String, dynamic> _$$WSEchoCommandImplToJson(_$WSEchoCommandImpl instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'id': instance.id,
      'type': instance.type,
    };
