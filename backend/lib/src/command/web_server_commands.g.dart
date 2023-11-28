// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_server_commands.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<WebServerControlCommand> _$webServerControlCommandSerializer =
    new _$WebServerControlCommandSerializer();
Serializer<WebServerControlCommandResult>
    _$webServerControlCommandResultSerializer =
    new _$WebServerControlCommandResultSerializer();
Serializer<WSErrorResult> _$wSErrorResultSerializer =
    new _$WSErrorResultSerializer();
Serializer<WSHelloCommand> _$wSHelloCommandSerializer =
    new _$WSHelloCommandSerializer();
Serializer<WSAuthCommand> _$wSAuthCommandSerializer =
    new _$WSAuthCommandSerializer();
Serializer<WSSendRpcCommand> _$wSSendRpcCommandSerializer =
    new _$WSSendRpcCommandSerializer();
Serializer<WSRpcResult> _$wSRpcResultSerializer = new _$WSRpcResultSerializer();
Serializer<WSConfigDownloadCommand> _$wSConfigDownloadCommandSerializer =
    new _$WSConfigDownloadCommandSerializer();
Serializer<WSConfigUploadCommand> _$wSConfigUploadCommandSerializer =
    new _$WSConfigUploadCommandSerializer();
Serializer<WSConfigDownloadResult> _$wSConfigDownloadResultSerializer =
    new _$WSConfigDownloadResultSerializer();
Serializer<WSRestartApplicationCommand>
    _$wSRestartApplicationCommandSerializer =
    new _$WSRestartApplicationCommandSerializer();
Serializer<WSResultOk> _$wSResultOkSerializer = new _$WSResultOkSerializer();
Serializer<WSEchoResult> _$wSEchoResultSerializer =
    new _$WSEchoResultSerializer();
Serializer<WSEchoCommand> _$wSEchoCommandSerializer =
    new _$WSEchoCommandSerializer();

class _$WebServerControlCommandSerializer
    implements StructuredSerializer<WebServerControlCommand> {
  @override
  final Iterable<Type> types = const [
    WebServerControlCommand,
    _$WebServerControlCommand
  ];
  @override
  final String wireName = 'WebServerControlCommand';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, WebServerControlCommand object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'enable',
      serializers.serialize(object.enable, specifiedType: const FullType(bool)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  WebServerControlCommand deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WebServerControlCommandBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'enable':
          result.enable = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
      }
    }

    return result.build();
  }
}

class _$WebServerControlCommandResultSerializer
    implements StructuredSerializer<WebServerControlCommandResult> {
  @override
  final Iterable<Type> types = const [
    WebServerControlCommandResult,
    _$WebServerControlCommandResult
  ];
  @override
  final String wireName = 'WebServerControlCommandResult';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, WebServerControlCommandResult object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'code',
      serializers.serialize(object.code, specifiedType: const FullType(String)),
      'enable',
      serializers.serialize(object.enable, specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  WebServerControlCommandResult deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WebServerControlCommandResultBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'code':
          result.code = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'enable':
          result.enable = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$WSErrorResultSerializer implements StructuredSerializer<WSErrorResult> {
  @override
  final Iterable<Type> types = const [WSErrorResult, _$WSErrorResult];
  @override
  final String wireName = 'WSErrorResult';

  @override
  Iterable<Object?> serialize(Serializers serializers, WSErrorResult object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'error',
      serializers.serialize(object.error,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  WSErrorResult deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WSErrorResultBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'error':
          result.error = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
      }
    }

    return result.build();
  }
}

class _$WSHelloCommandSerializer
    implements StructuredSerializer<WSHelloCommand> {
  @override
  final Iterable<Type> types = const [WSHelloCommand, _$WSHelloCommand];
  @override
  final String wireName = 'WSHelloCommand';

  @override
  Iterable<Object?> serialize(Serializers serializers, WSHelloCommand object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  WSHelloCommand deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WSHelloCommandBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
      }
    }

    return result.build();
  }
}

class _$WSAuthCommandSerializer implements StructuredSerializer<WSAuthCommand> {
  @override
  final Iterable<Type> types = const [WSAuthCommand, _$WSAuthCommand];
  @override
  final String wireName = 'WSAuthCommand';

  @override
  Iterable<Object?> serialize(Serializers serializers, WSAuthCommand object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'userName',
      serializers.serialize(object.userName,
          specifiedType: const FullType(String)),
      'code',
      serializers.serialize(object.code, specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  WSAuthCommand deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WSAuthCommandBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'userName':
          result.userName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'code':
          result.code = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
      }
    }

    return result.build();
  }
}

class _$WSSendRpcCommandSerializer
    implements StructuredSerializer<WSSendRpcCommand> {
  @override
  final Iterable<Type> types = const [WSSendRpcCommand, _$WSSendRpcCommand];
  @override
  final String wireName = 'WSSendRpcCommand';

  @override
  Iterable<Object?> serialize(Serializers serializers, WSSendRpcCommand object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'command',
      serializers.serialize(object.command,
          specifiedType: const FullType(RpcCommand)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  WSSendRpcCommand deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WSSendRpcCommandBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'command':
          result.command = serializers.deserialize(value,
              specifiedType: const FullType(RpcCommand))! as RpcCommand;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
      }
    }

    return result.build();
  }
}

class _$WSRpcResultSerializer implements StructuredSerializer<WSRpcResult> {
  @override
  final Iterable<Type> types = const [WSRpcResult, _$WSRpcResult];
  @override
  final String wireName = 'WSRpcResult';

  @override
  Iterable<Object?> serialize(Serializers serializers, WSRpcResult object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'result',
      serializers.serialize(object.result,
          specifiedType: const FullType(RpcResult)),
    ];

    return result;
  }

  @override
  WSRpcResult deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WSRpcResultBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'result':
          result.result = serializers.deserialize(value,
              specifiedType: const FullType(RpcResult))! as RpcResult;
          break;
      }
    }

    return result.build();
  }
}

class _$WSConfigDownloadCommandSerializer
    implements StructuredSerializer<WSConfigDownloadCommand> {
  @override
  final Iterable<Type> types = const [
    WSConfigDownloadCommand,
    _$WSConfigDownloadCommand
  ];
  @override
  final String wireName = 'WSConfigDownloadCommand';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, WSConfigDownloadCommand object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  WSConfigDownloadCommand deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WSConfigDownloadCommandBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
      }
    }

    return result.build();
  }
}

class _$WSConfigUploadCommandSerializer
    implements StructuredSerializer<WSConfigUploadCommand> {
  @override
  final Iterable<Type> types = const [
    WSConfigUploadCommand,
    _$WSConfigUploadCommand
  ];
  @override
  final String wireName = 'WSConfigUploadCommand';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, WSConfigUploadCommand object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'content',
      serializers.serialize(object.content,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  WSConfigUploadCommand deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WSConfigUploadCommandBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'content':
          result.content = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
      }
    }

    return result.build();
  }
}

class _$WSConfigDownloadResultSerializer
    implements StructuredSerializer<WSConfigDownloadResult> {
  @override
  final Iterable<Type> types = const [
    WSConfigDownloadResult,
    _$WSConfigDownloadResult
  ];
  @override
  final String wireName = 'WSConfigDownloadResult';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, WSConfigDownloadResult object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'content',
      serializers.serialize(object.content,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  WSConfigDownloadResult deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WSConfigDownloadResultBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'content':
          result.content = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
      }
    }

    return result.build();
  }
}

class _$WSRestartApplicationCommandSerializer
    implements StructuredSerializer<WSRestartApplicationCommand> {
  @override
  final Iterable<Type> types = const [
    WSRestartApplicationCommand,
    _$WSRestartApplicationCommand
  ];
  @override
  final String wireName = 'WSRestartApplicationCommand';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, WSRestartApplicationCommand object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  WSRestartApplicationCommand deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WSRestartApplicationCommandBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
      }
    }

    return result.build();
  }
}

class _$WSResultOkSerializer implements StructuredSerializer<WSResultOk> {
  @override
  final Iterable<Type> types = const [WSResultOk, _$WSResultOk];
  @override
  final String wireName = 'WSResultOk';

  @override
  Iterable<Object?> serialize(Serializers serializers, WSResultOk object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  WSResultOk deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WSResultOkBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
      }
    }

    return result.build();
  }
}

class _$WSEchoResultSerializer implements StructuredSerializer<WSEchoResult> {
  @override
  final Iterable<Type> types = const [WSEchoResult, _$WSEchoResult];
  @override
  final String wireName = 'WSEchoResult';

  @override
  Iterable<Object?> serialize(Serializers serializers, WSEchoResult object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'msg',
      serializers.serialize(object.msg, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  WSEchoResult deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WSEchoResultBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'msg':
          result.msg = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$WSEchoCommandSerializer implements StructuredSerializer<WSEchoCommand> {
  @override
  final Iterable<Type> types = const [WSEchoCommand, _$WSEchoCommand];
  @override
  final String wireName = 'WSEchoCommand';

  @override
  Iterable<Object?> serialize(Serializers serializers, WSEchoCommand object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'msg',
      serializers.serialize(object.msg, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  WSEchoCommand deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WSEchoCommandBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'msg':
          result.msg = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$WebServerControlCommand extends WebServerControlCommand {
  @override
  final bool enable;
  @override
  final int id;

  factory _$WebServerControlCommand(
          [void Function(WebServerControlCommandBuilder)? updates]) =>
      (new WebServerControlCommandBuilder()..update(updates))._build();

  _$WebServerControlCommand._({required this.enable, required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        enable, r'WebServerControlCommand', 'enable');
    BuiltValueNullFieldError.checkNotNull(id, r'WebServerControlCommand', 'id');
  }

  @override
  WebServerControlCommand rebuild(
          void Function(WebServerControlCommandBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WebServerControlCommandBuilder toBuilder() =>
      new WebServerControlCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WebServerControlCommand &&
        enable == other.enable &&
        id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, enable.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WebServerControlCommand')
          ..add('enable', enable)
          ..add('id', id))
        .toString();
  }
}

class WebServerControlCommandBuilder
    implements
        Builder<WebServerControlCommand, WebServerControlCommandBuilder> {
  _$WebServerControlCommand? _$v;

  bool? _enable;
  bool? get enable => _$this._enable;
  set enable(bool? enable) => _$this._enable = enable;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  WebServerControlCommandBuilder() {
    WebServerControlCommand._setDefaults(this);
  }

  WebServerControlCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _enable = $v.enable;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WebServerControlCommand other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$WebServerControlCommand;
  }

  @override
  void update(void Function(WebServerControlCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WebServerControlCommand build() => _build();

  _$WebServerControlCommand _build() {
    final _$result = _$v ??
        new _$WebServerControlCommand._(
            enable: BuiltValueNullFieldError.checkNotNull(
                enable, r'WebServerControlCommand', 'enable'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'WebServerControlCommand', 'id'));
    replace(_$result);
    return _$result;
  }
}

class _$WebServerControlCommandResult extends WebServerControlCommandResult {
  @override
  final int id;
  @override
  final String code;
  @override
  final bool enable;

  factory _$WebServerControlCommandResult(
          [void Function(WebServerControlCommandResultBuilder)? updates]) =>
      (new WebServerControlCommandResultBuilder()..update(updates))._build();

  _$WebServerControlCommandResult._(
      {required this.id, required this.code, required this.enable})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        id, r'WebServerControlCommandResult', 'id');
    BuiltValueNullFieldError.checkNotNull(
        code, r'WebServerControlCommandResult', 'code');
    BuiltValueNullFieldError.checkNotNull(
        enable, r'WebServerControlCommandResult', 'enable');
  }

  @override
  WebServerControlCommandResult rebuild(
          void Function(WebServerControlCommandResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WebServerControlCommandResultBuilder toBuilder() =>
      new WebServerControlCommandResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WebServerControlCommandResult &&
        id == other.id &&
        code == other.code &&
        enable == other.enable;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, enable.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WebServerControlCommandResult')
          ..add('id', id)
          ..add('code', code)
          ..add('enable', enable))
        .toString();
  }
}

class WebServerControlCommandResultBuilder
    implements
        Builder<WebServerControlCommandResult,
            WebServerControlCommandResultBuilder> {
  _$WebServerControlCommandResult? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  bool? _enable;
  bool? get enable => _$this._enable;
  set enable(bool? enable) => _$this._enable = enable;

  WebServerControlCommandResultBuilder();

  WebServerControlCommandResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _code = $v.code;
      _enable = $v.enable;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WebServerControlCommandResult other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$WebServerControlCommandResult;
  }

  @override
  void update(void Function(WebServerControlCommandResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WebServerControlCommandResult build() => _build();

  _$WebServerControlCommandResult _build() {
    final _$result = _$v ??
        new _$WebServerControlCommandResult._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'WebServerControlCommandResult', 'id'),
            code: BuiltValueNullFieldError.checkNotNull(
                code, r'WebServerControlCommandResult', 'code'),
            enable: BuiltValueNullFieldError.checkNotNull(
                enable, r'WebServerControlCommandResult', 'enable'));
    replace(_$result);
    return _$result;
  }
}

class _$WSErrorResult extends WSErrorResult {
  @override
  final String error;
  @override
  final int id;

  factory _$WSErrorResult([void Function(WSErrorResultBuilder)? updates]) =>
      (new WSErrorResultBuilder()..update(updates))._build();

  _$WSErrorResult._({required this.error, required this.id}) : super._() {
    BuiltValueNullFieldError.checkNotNull(error, r'WSErrorResult', 'error');
    BuiltValueNullFieldError.checkNotNull(id, r'WSErrorResult', 'id');
  }

  @override
  WSErrorResult rebuild(void Function(WSErrorResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WSErrorResultBuilder toBuilder() => new WSErrorResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WSErrorResult && error == other.error && id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, error.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WSErrorResult')
          ..add('error', error)
          ..add('id', id))
        .toString();
  }
}

class WSErrorResultBuilder
    implements Builder<WSErrorResult, WSErrorResultBuilder> {
  _$WSErrorResult? _$v;

  String? _error;
  String? get error => _$this._error;
  set error(String? error) => _$this._error = error;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  WSErrorResultBuilder();

  WSErrorResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _error = $v.error;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WSErrorResult other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$WSErrorResult;
  }

  @override
  void update(void Function(WSErrorResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WSErrorResult build() => _build();

  _$WSErrorResult _build() {
    final _$result = _$v ??
        new _$WSErrorResult._(
            error: BuiltValueNullFieldError.checkNotNull(
                error, r'WSErrorResult', 'error'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'WSErrorResult', 'id'));
    replace(_$result);
    return _$result;
  }
}

class _$WSHelloCommand extends WSHelloCommand {
  @override
  final int id;

  factory _$WSHelloCommand([void Function(WSHelloCommandBuilder)? updates]) =>
      (new WSHelloCommandBuilder()..update(updates))._build();

  _$WSHelloCommand._({required this.id}) : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'WSHelloCommand', 'id');
  }

  @override
  WSHelloCommand rebuild(void Function(WSHelloCommandBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WSHelloCommandBuilder toBuilder() =>
      new WSHelloCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WSHelloCommand && id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WSHelloCommand')..add('id', id))
        .toString();
  }
}

class WSHelloCommandBuilder
    implements Builder<WSHelloCommand, WSHelloCommandBuilder> {
  _$WSHelloCommand? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  WSHelloCommandBuilder() {
    WSHelloCommand._setDefaults(this);
  }

  WSHelloCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WSHelloCommand other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$WSHelloCommand;
  }

  @override
  void update(void Function(WSHelloCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WSHelloCommand build() => _build();

  _$WSHelloCommand _build() {
    final _$result = _$v ??
        new _$WSHelloCommand._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'WSHelloCommand', 'id'));
    replace(_$result);
    return _$result;
  }
}

class _$WSAuthCommand extends WSAuthCommand {
  @override
  final String userName;
  @override
  final String code;
  @override
  final int id;

  factory _$WSAuthCommand([void Function(WSAuthCommandBuilder)? updates]) =>
      (new WSAuthCommandBuilder()..update(updates))._build();

  _$WSAuthCommand._(
      {required this.userName, required this.code, required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        userName, r'WSAuthCommand', 'userName');
    BuiltValueNullFieldError.checkNotNull(code, r'WSAuthCommand', 'code');
    BuiltValueNullFieldError.checkNotNull(id, r'WSAuthCommand', 'id');
  }

  @override
  WSAuthCommand rebuild(void Function(WSAuthCommandBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WSAuthCommandBuilder toBuilder() => new WSAuthCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WSAuthCommand &&
        userName == other.userName &&
        code == other.code &&
        id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userName.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WSAuthCommand')
          ..add('userName', userName)
          ..add('code', code)
          ..add('id', id))
        .toString();
  }
}

class WSAuthCommandBuilder
    implements Builder<WSAuthCommand, WSAuthCommandBuilder> {
  _$WSAuthCommand? _$v;

  String? _userName;
  String? get userName => _$this._userName;
  set userName(String? userName) => _$this._userName = userName;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  WSAuthCommandBuilder() {
    WSAuthCommand._setDefaults(this);
  }

  WSAuthCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userName = $v.userName;
      _code = $v.code;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WSAuthCommand other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$WSAuthCommand;
  }

  @override
  void update(void Function(WSAuthCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WSAuthCommand build() => _build();

  _$WSAuthCommand _build() {
    final _$result = _$v ??
        new _$WSAuthCommand._(
            userName: BuiltValueNullFieldError.checkNotNull(
                userName, r'WSAuthCommand', 'userName'),
            code: BuiltValueNullFieldError.checkNotNull(
                code, r'WSAuthCommand', 'code'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'WSAuthCommand', 'id'));
    replace(_$result);
    return _$result;
  }
}

class _$WSSendRpcCommand extends WSSendRpcCommand {
  @override
  final RpcCommand command;
  @override
  final int id;

  factory _$WSSendRpcCommand(
          [void Function(WSSendRpcCommandBuilder)? updates]) =>
      (new WSSendRpcCommandBuilder()..update(updates))._build();

  _$WSSendRpcCommand._({required this.command, required this.id}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        command, r'WSSendRpcCommand', 'command');
    BuiltValueNullFieldError.checkNotNull(id, r'WSSendRpcCommand', 'id');
  }

  @override
  WSSendRpcCommand rebuild(void Function(WSSendRpcCommandBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WSSendRpcCommandBuilder toBuilder() =>
      new WSSendRpcCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WSSendRpcCommand &&
        command == other.command &&
        id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, command.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WSSendRpcCommand')
          ..add('command', command)
          ..add('id', id))
        .toString();
  }
}

class WSSendRpcCommandBuilder
    implements Builder<WSSendRpcCommand, WSSendRpcCommandBuilder> {
  _$WSSendRpcCommand? _$v;

  RpcCommand? _command;
  RpcCommand? get command => _$this._command;
  set command(RpcCommand? command) => _$this._command = command;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  WSSendRpcCommandBuilder() {
    WSSendRpcCommand._setDefaults(this);
  }

  WSSendRpcCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _command = $v.command;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WSSendRpcCommand other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$WSSendRpcCommand;
  }

  @override
  void update(void Function(WSSendRpcCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WSSendRpcCommand build() => _build();

  _$WSSendRpcCommand _build() {
    final _$result = _$v ??
        new _$WSSendRpcCommand._(
            command: BuiltValueNullFieldError.checkNotNull(
                command, r'WSSendRpcCommand', 'command'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'WSSendRpcCommand', 'id'));
    replace(_$result);
    return _$result;
  }
}

class _$WSRpcResult extends WSRpcResult {
  @override
  final int id;
  @override
  final RpcResult result;

  factory _$WSRpcResult([void Function(WSRpcResultBuilder)? updates]) =>
      (new WSRpcResultBuilder()..update(updates))._build();

  _$WSRpcResult._({required this.id, required this.result}) : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'WSRpcResult', 'id');
    BuiltValueNullFieldError.checkNotNull(result, r'WSRpcResult', 'result');
  }

  @override
  WSRpcResult rebuild(void Function(WSRpcResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WSRpcResultBuilder toBuilder() => new WSRpcResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WSRpcResult && id == other.id && result == other.result;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, result.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WSRpcResult')
          ..add('id', id)
          ..add('result', result))
        .toString();
  }
}

class WSRpcResultBuilder implements Builder<WSRpcResult, WSRpcResultBuilder> {
  _$WSRpcResult? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  RpcResult? _result;
  RpcResult? get result => _$this._result;
  set result(RpcResult? result) => _$this._result = result;

  WSRpcResultBuilder();

  WSRpcResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _result = $v.result;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WSRpcResult other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$WSRpcResult;
  }

  @override
  void update(void Function(WSRpcResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WSRpcResult build() => _build();

  _$WSRpcResult _build() {
    final _$result = _$v ??
        new _$WSRpcResult._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'WSRpcResult', 'id'),
            result: BuiltValueNullFieldError.checkNotNull(
                result, r'WSRpcResult', 'result'));
    replace(_$result);
    return _$result;
  }
}

class _$WSConfigDownloadCommand extends WSConfigDownloadCommand {
  @override
  final int id;

  factory _$WSConfigDownloadCommand(
          [void Function(WSConfigDownloadCommandBuilder)? updates]) =>
      (new WSConfigDownloadCommandBuilder()..update(updates))._build();

  _$WSConfigDownloadCommand._({required this.id}) : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'WSConfigDownloadCommand', 'id');
  }

  @override
  WSConfigDownloadCommand rebuild(
          void Function(WSConfigDownloadCommandBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WSConfigDownloadCommandBuilder toBuilder() =>
      new WSConfigDownloadCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WSConfigDownloadCommand && id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WSConfigDownloadCommand')
          ..add('id', id))
        .toString();
  }
}

class WSConfigDownloadCommandBuilder
    implements
        Builder<WSConfigDownloadCommand, WSConfigDownloadCommandBuilder> {
  _$WSConfigDownloadCommand? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  WSConfigDownloadCommandBuilder() {
    WSConfigDownloadCommand._setDefaults(this);
  }

  WSConfigDownloadCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WSConfigDownloadCommand other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$WSConfigDownloadCommand;
  }

  @override
  void update(void Function(WSConfigDownloadCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WSConfigDownloadCommand build() => _build();

  _$WSConfigDownloadCommand _build() {
    final _$result = _$v ??
        new _$WSConfigDownloadCommand._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'WSConfigDownloadCommand', 'id'));
    replace(_$result);
    return _$result;
  }
}

class _$WSConfigUploadCommand extends WSConfigUploadCommand {
  @override
  final String content;
  @override
  final int id;

  factory _$WSConfigUploadCommand(
          [void Function(WSConfigUploadCommandBuilder)? updates]) =>
      (new WSConfigUploadCommandBuilder()..update(updates))._build();

  _$WSConfigUploadCommand._({required this.content, required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        content, r'WSConfigUploadCommand', 'content');
    BuiltValueNullFieldError.checkNotNull(id, r'WSConfigUploadCommand', 'id');
  }

  @override
  WSConfigUploadCommand rebuild(
          void Function(WSConfigUploadCommandBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WSConfigUploadCommandBuilder toBuilder() =>
      new WSConfigUploadCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WSConfigUploadCommand &&
        content == other.content &&
        id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WSConfigUploadCommand')
          ..add('content', content)
          ..add('id', id))
        .toString();
  }
}

class WSConfigUploadCommandBuilder
    implements Builder<WSConfigUploadCommand, WSConfigUploadCommandBuilder> {
  _$WSConfigUploadCommand? _$v;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  WSConfigUploadCommandBuilder() {
    WSConfigUploadCommand._setDefaults(this);
  }

  WSConfigUploadCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _content = $v.content;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WSConfigUploadCommand other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$WSConfigUploadCommand;
  }

  @override
  void update(void Function(WSConfigUploadCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WSConfigUploadCommand build() => _build();

  _$WSConfigUploadCommand _build() {
    final _$result = _$v ??
        new _$WSConfigUploadCommand._(
            content: BuiltValueNullFieldError.checkNotNull(
                content, r'WSConfigUploadCommand', 'content'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'WSConfigUploadCommand', 'id'));
    replace(_$result);
    return _$result;
  }
}

class _$WSConfigDownloadResult extends WSConfigDownloadResult {
  @override
  final String content;
  @override
  final int id;

  factory _$WSConfigDownloadResult(
          [void Function(WSConfigDownloadResultBuilder)? updates]) =>
      (new WSConfigDownloadResultBuilder()..update(updates))._build();

  _$WSConfigDownloadResult._({required this.content, required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        content, r'WSConfigDownloadResult', 'content');
    BuiltValueNullFieldError.checkNotNull(id, r'WSConfigDownloadResult', 'id');
  }

  @override
  WSConfigDownloadResult rebuild(
          void Function(WSConfigDownloadResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WSConfigDownloadResultBuilder toBuilder() =>
      new WSConfigDownloadResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WSConfigDownloadResult &&
        content == other.content &&
        id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WSConfigDownloadResult')
          ..add('content', content)
          ..add('id', id))
        .toString();
  }
}

class WSConfigDownloadResultBuilder
    implements Builder<WSConfigDownloadResult, WSConfigDownloadResultBuilder> {
  _$WSConfigDownloadResult? _$v;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  WSConfigDownloadResultBuilder();

  WSConfigDownloadResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _content = $v.content;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WSConfigDownloadResult other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$WSConfigDownloadResult;
  }

  @override
  void update(void Function(WSConfigDownloadResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WSConfigDownloadResult build() => _build();

  _$WSConfigDownloadResult _build() {
    final _$result = _$v ??
        new _$WSConfigDownloadResult._(
            content: BuiltValueNullFieldError.checkNotNull(
                content, r'WSConfigDownloadResult', 'content'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'WSConfigDownloadResult', 'id'));
    replace(_$result);
    return _$result;
  }
}

class _$WSRestartApplicationCommand extends WSRestartApplicationCommand {
  @override
  final int id;

  factory _$WSRestartApplicationCommand(
          [void Function(WSRestartApplicationCommandBuilder)? updates]) =>
      (new WSRestartApplicationCommandBuilder()..update(updates))._build();

  _$WSRestartApplicationCommand._({required this.id}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        id, r'WSRestartApplicationCommand', 'id');
  }

  @override
  WSRestartApplicationCommand rebuild(
          void Function(WSRestartApplicationCommandBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WSRestartApplicationCommandBuilder toBuilder() =>
      new WSRestartApplicationCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WSRestartApplicationCommand && id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WSRestartApplicationCommand')
          ..add('id', id))
        .toString();
  }
}

class WSRestartApplicationCommandBuilder
    implements
        Builder<WSRestartApplicationCommand,
            WSRestartApplicationCommandBuilder> {
  _$WSRestartApplicationCommand? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  WSRestartApplicationCommandBuilder() {
    WSRestartApplicationCommand._setDefaults(this);
  }

  WSRestartApplicationCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WSRestartApplicationCommand other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$WSRestartApplicationCommand;
  }

  @override
  void update(void Function(WSRestartApplicationCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WSRestartApplicationCommand build() => _build();

  _$WSRestartApplicationCommand _build() {
    final _$result = _$v ??
        new _$WSRestartApplicationCommand._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'WSRestartApplicationCommand', 'id'));
    replace(_$result);
    return _$result;
  }
}

class _$WSResultOk extends WSResultOk {
  @override
  final int id;

  factory _$WSResultOk([void Function(WSResultOkBuilder)? updates]) =>
      (new WSResultOkBuilder()..update(updates))._build();

  _$WSResultOk._({required this.id}) : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'WSResultOk', 'id');
  }

  @override
  WSResultOk rebuild(void Function(WSResultOkBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WSResultOkBuilder toBuilder() => new WSResultOkBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WSResultOk && id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WSResultOk')..add('id', id))
        .toString();
  }
}

class WSResultOkBuilder implements Builder<WSResultOk, WSResultOkBuilder> {
  _$WSResultOk? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  WSResultOkBuilder();

  WSResultOkBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WSResultOk other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$WSResultOk;
  }

  @override
  void update(void Function(WSResultOkBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WSResultOk build() => _build();

  _$WSResultOk _build() {
    final _$result = _$v ??
        new _$WSResultOk._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'WSResultOk', 'id'));
    replace(_$result);
    return _$result;
  }
}

class _$WSEchoResult extends WSEchoResult {
  @override
  final int id;
  @override
  final String msg;

  factory _$WSEchoResult([void Function(WSEchoResultBuilder)? updates]) =>
      (new WSEchoResultBuilder()..update(updates))._build();

  _$WSEchoResult._({required this.id, required this.msg}) : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'WSEchoResult', 'id');
    BuiltValueNullFieldError.checkNotNull(msg, r'WSEchoResult', 'msg');
  }

  @override
  WSEchoResult rebuild(void Function(WSEchoResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WSEchoResultBuilder toBuilder() => new WSEchoResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WSEchoResult && id == other.id && msg == other.msg;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, msg.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WSEchoResult')
          ..add('id', id)
          ..add('msg', msg))
        .toString();
  }
}

class WSEchoResultBuilder
    implements Builder<WSEchoResult, WSEchoResultBuilder> {
  _$WSEchoResult? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _msg;
  String? get msg => _$this._msg;
  set msg(String? msg) => _$this._msg = msg;

  WSEchoResultBuilder();

  WSEchoResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _msg = $v.msg;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WSEchoResult other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$WSEchoResult;
  }

  @override
  void update(void Function(WSEchoResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WSEchoResult build() => _build();

  _$WSEchoResult _build() {
    final _$result = _$v ??
        new _$WSEchoResult._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'WSEchoResult', 'id'),
            msg: BuiltValueNullFieldError.checkNotNull(
                msg, r'WSEchoResult', 'msg'));
    replace(_$result);
    return _$result;
  }
}

class _$WSEchoCommand extends WSEchoCommand {
  @override
  final int id;
  @override
  final String msg;

  factory _$WSEchoCommand([void Function(WSEchoCommandBuilder)? updates]) =>
      (new WSEchoCommandBuilder()..update(updates))._build();

  _$WSEchoCommand._({required this.id, required this.msg}) : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'WSEchoCommand', 'id');
    BuiltValueNullFieldError.checkNotNull(msg, r'WSEchoCommand', 'msg');
  }

  @override
  WSEchoCommand rebuild(void Function(WSEchoCommandBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WSEchoCommandBuilder toBuilder() => new WSEchoCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WSEchoCommand && id == other.id && msg == other.msg;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, msg.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WSEchoCommand')
          ..add('id', id)
          ..add('msg', msg))
        .toString();
  }
}

class WSEchoCommandBuilder
    implements Builder<WSEchoCommand, WSEchoCommandBuilder> {
  _$WSEchoCommand? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _msg;
  String? get msg => _$this._msg;
  set msg(String? msg) => _$this._msg = msg;

  WSEchoCommandBuilder() {
    WSEchoCommand._setDefaults(this);
  }

  WSEchoCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _msg = $v.msg;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WSEchoCommand other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$WSEchoCommand;
  }

  @override
  void update(void Function(WSEchoCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WSEchoCommand build() => _build();

  _$WSEchoCommand _build() {
    final _$result = _$v ??
        new _$WSEchoCommand._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'WSEchoCommand', 'id'),
            msg: BuiltValueNullFieldError.checkNotNull(
                msg, r'WSEchoCommand', 'msg'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
