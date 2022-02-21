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
Serializer<WSHelloCommand> _$wSHelloCommandSerializer =
    new _$WSHelloCommandSerializer();
Serializer<WSAuthCommand> _$wSAuthCommandSerializer =
    new _$WSAuthCommandSerializer();
Serializer<WSAuthReqCommand> _$wSAuthReqCommandSerializer =
    new _$WSAuthReqCommandSerializer();
Serializer<WSSendRpcCommand> _$wSSendRpcCommandSerializer =
    new _$WSSendRpcCommandSerializer();
Serializer<WSRpcResult> _$wSRpcResultSerializer = new _$WSRpcResultSerializer();
Serializer<WSConfigDownloadCommand> _$wSConfigDownloadCommandSerializer =
    new _$WSConfigDownloadCommandSerializer();
Serializer<WSConfigUploadCommand> _$wSConfigUploadCommandSerializer =
    new _$WSConfigUploadCommandSerializer();
Serializer<WSConfigContentCommand> _$wSConfigContentCommandSerializer =
    new _$WSConfigContentCommandSerializer();
Serializer<WSRestartApplicationCommand>
    _$wSRestartApplicationCommandSerializer =
    new _$WSRestartApplicationCommandSerializer();
Serializer<WSResultOk> _$wSResultOkSerializer = new _$WSResultOkSerializer();

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
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'enable':
          result.enable = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
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
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'code':
          result.code = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'enable':
          result.enable = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
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
    return <Object?>[];
  }

  @override
  WSHelloCommand deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new WSHelloCommandBuilder().build();
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
      'code',
      serializers.serialize(object.code, specifiedType: const FullType(String)),
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
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'code':
          result.code = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$WSAuthReqCommandSerializer
    implements StructuredSerializer<WSAuthReqCommand> {
  @override
  final Iterable<Type> types = const [WSAuthReqCommand, _$WSAuthReqCommand];
  @override
  final String wireName = 'WSAuthReqCommand';

  @override
  Iterable<Object?> serialize(Serializers serializers, WSAuthReqCommand object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  WSAuthReqCommand deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new WSAuthReqCommandBuilder().build();
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
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'command':
          result.command = serializers.deserialize(value,
              specifiedType: const FullType(RpcCommand)) as RpcCommand;
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
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'result':
          result.result = serializers.deserialize(value,
              specifiedType: const FullType(RpcResult)) as RpcResult;
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
    return <Object?>[];
  }

  @override
  WSConfigDownloadCommand deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new WSConfigDownloadCommandBuilder().build();
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
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'content':
          result.content = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$WSConfigContentCommandSerializer
    implements StructuredSerializer<WSConfigContentCommand> {
  @override
  final Iterable<Type> types = const [
    WSConfigContentCommand,
    _$WSConfigContentCommand
  ];
  @override
  final String wireName = 'WSConfigContentCommand';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, WSConfigContentCommand object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'content',
      serializers.serialize(object.content,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  WSConfigContentCommand deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WSConfigContentCommandBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'content':
          result.content = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
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
    return <Object?>[];
  }

  @override
  WSRestartApplicationCommand deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new WSRestartApplicationCommandBuilder().build();
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
    return <Object?>[];
  }

  @override
  WSResultOk deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new WSResultOkBuilder().build();
  }
}

class _$WebServerControlCommand extends WebServerControlCommand {
  @override
  final bool enable;
  @override
  final int id;

  factory _$WebServerControlCommand(
          [void Function(WebServerControlCommandBuilder)? updates]) =>
      (new WebServerControlCommandBuilder()..update(updates)).build();

  _$WebServerControlCommand._({required this.enable, required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        enable, 'WebServerControlCommand', 'enable');
    BuiltValueNullFieldError.checkNotNull(id, 'WebServerControlCommand', 'id');
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
    return $jf($jc($jc(0, enable.hashCode), id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('WebServerControlCommand')
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
  _$WebServerControlCommand build() {
    final _$result = _$v ??
        new _$WebServerControlCommand._(
            enable: BuiltValueNullFieldError.checkNotNull(
                enable, 'WebServerControlCommand', 'enable'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, 'WebServerControlCommand', 'id'));
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
      (new WebServerControlCommandResultBuilder()..update(updates)).build();

  _$WebServerControlCommandResult._(
      {required this.id, required this.code, required this.enable})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        id, 'WebServerControlCommandResult', 'id');
    BuiltValueNullFieldError.checkNotNull(
        code, 'WebServerControlCommandResult', 'code');
    BuiltValueNullFieldError.checkNotNull(
        enable, 'WebServerControlCommandResult', 'enable');
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
    return $jf($jc($jc($jc(0, id.hashCode), code.hashCode), enable.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('WebServerControlCommandResult')
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
  _$WebServerControlCommandResult build() {
    final _$result = _$v ??
        new _$WebServerControlCommandResult._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, 'WebServerControlCommandResult', 'id'),
            code: BuiltValueNullFieldError.checkNotNull(
                code, 'WebServerControlCommandResult', 'code'),
            enable: BuiltValueNullFieldError.checkNotNull(
                enable, 'WebServerControlCommandResult', 'enable'));
    replace(_$result);
    return _$result;
  }
}

class _$WSHelloCommand extends WSHelloCommand {
  factory _$WSHelloCommand([void Function(WSHelloCommandBuilder)? updates]) =>
      (new WSHelloCommandBuilder()..update(updates)).build();

  _$WSHelloCommand._() : super._();

  @override
  WSHelloCommand rebuild(void Function(WSHelloCommandBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WSHelloCommandBuilder toBuilder() =>
      new WSHelloCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WSHelloCommand;
  }

  @override
  int get hashCode {
    return 9781298;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper('WSHelloCommand').toString();
  }
}

class WSHelloCommandBuilder
    implements Builder<WSHelloCommand, WSHelloCommandBuilder> {
  _$WSHelloCommand? _$v;

  WSHelloCommandBuilder();

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
  _$WSHelloCommand build() {
    final _$result = _$v ?? new _$WSHelloCommand._();
    replace(_$result);
    return _$result;
  }
}

class _$WSAuthCommand extends WSAuthCommand {
  @override
  final String code;

  factory _$WSAuthCommand([void Function(WSAuthCommandBuilder)? updates]) =>
      (new WSAuthCommandBuilder()..update(updates)).build();

  _$WSAuthCommand._({required this.code}) : super._() {
    BuiltValueNullFieldError.checkNotNull(code, 'WSAuthCommand', 'code');
  }

  @override
  WSAuthCommand rebuild(void Function(WSAuthCommandBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WSAuthCommandBuilder toBuilder() => new WSAuthCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WSAuthCommand && code == other.code;
  }

  @override
  int get hashCode {
    return $jf($jc(0, code.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('WSAuthCommand')..add('code', code))
        .toString();
  }
}

class WSAuthCommandBuilder
    implements Builder<WSAuthCommand, WSAuthCommandBuilder> {
  _$WSAuthCommand? _$v;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  WSAuthCommandBuilder();

  WSAuthCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _code = $v.code;
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
  _$WSAuthCommand build() {
    final _$result = _$v ??
        new _$WSAuthCommand._(
            code: BuiltValueNullFieldError.checkNotNull(
                code, 'WSAuthCommand', 'code'));
    replace(_$result);
    return _$result;
  }
}

class _$WSAuthReqCommand extends WSAuthReqCommand {
  factory _$WSAuthReqCommand(
          [void Function(WSAuthReqCommandBuilder)? updates]) =>
      (new WSAuthReqCommandBuilder()..update(updates)).build();

  _$WSAuthReqCommand._() : super._();

  @override
  WSAuthReqCommand rebuild(void Function(WSAuthReqCommandBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WSAuthReqCommandBuilder toBuilder() =>
      new WSAuthReqCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WSAuthReqCommand;
  }

  @override
  int get hashCode {
    return 852222057;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper('WSAuthReqCommand').toString();
  }
}

class WSAuthReqCommandBuilder
    implements Builder<WSAuthReqCommand, WSAuthReqCommandBuilder> {
  _$WSAuthReqCommand? _$v;

  WSAuthReqCommandBuilder();

  @override
  void replace(WSAuthReqCommand other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$WSAuthReqCommand;
  }

  @override
  void update(void Function(WSAuthReqCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$WSAuthReqCommand build() {
    final _$result = _$v ?? new _$WSAuthReqCommand._();
    replace(_$result);
    return _$result;
  }
}

class _$WSSendRpcCommand extends WSSendRpcCommand {
  @override
  final RpcCommand command;

  factory _$WSSendRpcCommand(
          [void Function(WSSendRpcCommandBuilder)? updates]) =>
      (new WSSendRpcCommandBuilder()..update(updates)).build();

  _$WSSendRpcCommand._({required this.command}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        command, 'WSSendRpcCommand', 'command');
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
    return other is WSSendRpcCommand && command == other.command;
  }

  @override
  int get hashCode {
    return $jf($jc(0, command.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('WSSendRpcCommand')
          ..add('command', command))
        .toString();
  }
}

class WSSendRpcCommandBuilder
    implements Builder<WSSendRpcCommand, WSSendRpcCommandBuilder> {
  _$WSSendRpcCommand? _$v;

  RpcCommand? _command;
  RpcCommand? get command => _$this._command;
  set command(RpcCommand? command) => _$this._command = command;

  WSSendRpcCommandBuilder();

  WSSendRpcCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _command = $v.command;
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
  _$WSSendRpcCommand build() {
    final _$result = _$v ??
        new _$WSSendRpcCommand._(
            command: BuiltValueNullFieldError.checkNotNull(
                command, 'WSSendRpcCommand', 'command'));
    replace(_$result);
    return _$result;
  }
}

class _$WSRpcResult extends WSRpcResult {
  @override
  final RpcResult result;

  factory _$WSRpcResult([void Function(WSRpcResultBuilder)? updates]) =>
      (new WSRpcResultBuilder()..update(updates)).build();

  _$WSRpcResult._({required this.result}) : super._() {
    BuiltValueNullFieldError.checkNotNull(result, 'WSRpcResult', 'result');
  }

  @override
  WSRpcResult rebuild(void Function(WSRpcResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WSRpcResultBuilder toBuilder() => new WSRpcResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WSRpcResult && result == other.result;
  }

  @override
  int get hashCode {
    return $jf($jc(0, result.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('WSRpcResult')..add('result', result))
        .toString();
  }
}

class WSRpcResultBuilder implements Builder<WSRpcResult, WSRpcResultBuilder> {
  _$WSRpcResult? _$v;

  RpcResult? _result;
  RpcResult? get result => _$this._result;
  set result(RpcResult? result) => _$this._result = result;

  WSRpcResultBuilder();

  WSRpcResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
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
  _$WSRpcResult build() {
    final _$result = _$v ??
        new _$WSRpcResult._(
            result: BuiltValueNullFieldError.checkNotNull(
                result, 'WSRpcResult', 'result'));
    replace(_$result);
    return _$result;
  }
}

class _$WSConfigDownloadCommand extends WSConfigDownloadCommand {
  factory _$WSConfigDownloadCommand(
          [void Function(WSConfigDownloadCommandBuilder)? updates]) =>
      (new WSConfigDownloadCommandBuilder()..update(updates)).build();

  _$WSConfigDownloadCommand._() : super._();

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
    return other is WSConfigDownloadCommand;
  }

  @override
  int get hashCode {
    return 750502900;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper('WSConfigDownloadCommand').toString();
  }
}

class WSConfigDownloadCommandBuilder
    implements
        Builder<WSConfigDownloadCommand, WSConfigDownloadCommandBuilder> {
  _$WSConfigDownloadCommand? _$v;

  WSConfigDownloadCommandBuilder();

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
  _$WSConfigDownloadCommand build() {
    final _$result = _$v ?? new _$WSConfigDownloadCommand._();
    replace(_$result);
    return _$result;
  }
}

class _$WSConfigUploadCommand extends WSConfigUploadCommand {
  @override
  final String content;

  factory _$WSConfigUploadCommand(
          [void Function(WSConfigUploadCommandBuilder)? updates]) =>
      (new WSConfigUploadCommandBuilder()..update(updates)).build();

  _$WSConfigUploadCommand._({required this.content}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        content, 'WSConfigUploadCommand', 'content');
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
    return other is WSConfigUploadCommand && content == other.content;
  }

  @override
  int get hashCode {
    return $jf($jc(0, content.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('WSConfigUploadCommand')
          ..add('content', content))
        .toString();
  }
}

class WSConfigUploadCommandBuilder
    implements Builder<WSConfigUploadCommand, WSConfigUploadCommandBuilder> {
  _$WSConfigUploadCommand? _$v;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  WSConfigUploadCommandBuilder();

  WSConfigUploadCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _content = $v.content;
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
  _$WSConfigUploadCommand build() {
    final _$result = _$v ??
        new _$WSConfigUploadCommand._(
            content: BuiltValueNullFieldError.checkNotNull(
                content, 'WSConfigUploadCommand', 'content'));
    replace(_$result);
    return _$result;
  }
}

class _$WSConfigContentCommand extends WSConfigContentCommand {
  @override
  final String content;

  factory _$WSConfigContentCommand(
          [void Function(WSConfigContentCommandBuilder)? updates]) =>
      (new WSConfigContentCommandBuilder()..update(updates)).build();

  _$WSConfigContentCommand._({required this.content}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        content, 'WSConfigContentCommand', 'content');
  }

  @override
  WSConfigContentCommand rebuild(
          void Function(WSConfigContentCommandBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WSConfigContentCommandBuilder toBuilder() =>
      new WSConfigContentCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WSConfigContentCommand && content == other.content;
  }

  @override
  int get hashCode {
    return $jf($jc(0, content.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('WSConfigContentCommand')
          ..add('content', content))
        .toString();
  }
}

class WSConfigContentCommandBuilder
    implements Builder<WSConfigContentCommand, WSConfigContentCommandBuilder> {
  _$WSConfigContentCommand? _$v;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  WSConfigContentCommandBuilder();

  WSConfigContentCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _content = $v.content;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WSConfigContentCommand other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$WSConfigContentCommand;
  }

  @override
  void update(void Function(WSConfigContentCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$WSConfigContentCommand build() {
    final _$result = _$v ??
        new _$WSConfigContentCommand._(
            content: BuiltValueNullFieldError.checkNotNull(
                content, 'WSConfigContentCommand', 'content'));
    replace(_$result);
    return _$result;
  }
}

class _$WSRestartApplicationCommand extends WSRestartApplicationCommand {
  factory _$WSRestartApplicationCommand(
          [void Function(WSRestartApplicationCommandBuilder)? updates]) =>
      (new WSRestartApplicationCommandBuilder()..update(updates)).build();

  _$WSRestartApplicationCommand._() : super._();

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
    return other is WSRestartApplicationCommand;
  }

  @override
  int get hashCode {
    return 388135512;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper('WSRestartApplicationCommand')
        .toString();
  }
}

class WSRestartApplicationCommandBuilder
    implements
        Builder<WSRestartApplicationCommand,
            WSRestartApplicationCommandBuilder> {
  _$WSRestartApplicationCommand? _$v;

  WSRestartApplicationCommandBuilder();

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
  _$WSRestartApplicationCommand build() {
    final _$result = _$v ?? new _$WSRestartApplicationCommand._();
    replace(_$result);
    return _$result;
  }
}

class _$WSResultOk extends WSResultOk {
  factory _$WSResultOk([void Function(WSResultOkBuilder)? updates]) =>
      (new WSResultOkBuilder()..update(updates)).build();

  _$WSResultOk._() : super._();

  @override
  WSResultOk rebuild(void Function(WSResultOkBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WSResultOkBuilder toBuilder() => new WSResultOkBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WSResultOk;
  }

  @override
  int get hashCode {
    return 309338272;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper('WSResultOk').toString();
  }
}

class WSResultOkBuilder implements Builder<WSResultOk, WSResultOkBuilder> {
  _$WSResultOk? _$v;

  WSResultOkBuilder();

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
  _$WSResultOk build() {
    final _$result = _$v ?? new _$WSResultOk._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
