// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'web_server_commands.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WebServerControlCommand _$WebServerControlCommandFromJson(
    Map<String, dynamic> json) {
  return _WebServerControlCommand.fromJson(json);
}

/// @nodoc
mixin _$WebServerControlCommand {
  bool get enable => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WebServerControlCommandCopyWith<WebServerControlCommand> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WebServerControlCommandCopyWith<$Res> {
  factory $WebServerControlCommandCopyWith(WebServerControlCommand value,
          $Res Function(WebServerControlCommand) then) =
      _$WebServerControlCommandCopyWithImpl<$Res, WebServerControlCommand>;
  @useResult
  $Res call({bool enable, int id, String type});
}

/// @nodoc
class _$WebServerControlCommandCopyWithImpl<$Res,
        $Val extends WebServerControlCommand>
    implements $WebServerControlCommandCopyWith<$Res> {
  _$WebServerControlCommandCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enable = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      enable: null == enable
          ? _value.enable
          : enable // ignore: cast_nullable_to_non_nullable
              as bool,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WebServerControlCommandImplCopyWith<$Res>
    implements $WebServerControlCommandCopyWith<$Res> {
  factory _$$WebServerControlCommandImplCopyWith(
          _$WebServerControlCommandImpl value,
          $Res Function(_$WebServerControlCommandImpl) then) =
      __$$WebServerControlCommandImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool enable, int id, String type});
}

/// @nodoc
class __$$WebServerControlCommandImplCopyWithImpl<$Res>
    extends _$WebServerControlCommandCopyWithImpl<$Res,
        _$WebServerControlCommandImpl>
    implements _$$WebServerControlCommandImplCopyWith<$Res> {
  __$$WebServerControlCommandImplCopyWithImpl(
      _$WebServerControlCommandImpl _value,
      $Res Function(_$WebServerControlCommandImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enable = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_$WebServerControlCommandImpl(
      enable: null == enable
          ? _value.enable
          : enable // ignore: cast_nullable_to_non_nullable
              as bool,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WebServerControlCommandImpl implements _WebServerControlCommand {
  const _$WebServerControlCommandImpl(
      {required this.enable,
      required this.id,
      this.type = WebServerControlCommand.TYPE});

  factory _$WebServerControlCommandImpl.fromJson(Map<String, dynamic> json) =>
      _$$WebServerControlCommandImplFromJson(json);

  @override
  final bool enable;
  @override
  final int id;
  @override
  @JsonKey()
  final String type;

  @override
  String toString() {
    return 'WebServerControlCommand(enable: $enable, id: $id, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebServerControlCommandImpl &&
            (identical(other.enable, enable) || other.enable == enable) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, enable, id, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WebServerControlCommandImplCopyWith<_$WebServerControlCommandImpl>
      get copyWith => __$$WebServerControlCommandImplCopyWithImpl<
          _$WebServerControlCommandImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WebServerControlCommandImplToJson(
      this,
    );
  }
}

abstract class _WebServerControlCommand implements WebServerControlCommand {
  const factory _WebServerControlCommand(
      {required final bool enable,
      required final int id,
      final String type}) = _$WebServerControlCommandImpl;

  factory _WebServerControlCommand.fromJson(Map<String, dynamic> json) =
      _$WebServerControlCommandImpl.fromJson;

  @override
  bool get enable;
  @override
  int get id;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$WebServerControlCommandImplCopyWith<_$WebServerControlCommandImpl>
      get copyWith => throw _privateConstructorUsedError;
}

WebServerControlCommandResult _$WebServerControlCommandResultFromJson(
    Map<String, dynamic> json) {
  return _WebServerControlCommandResult.fromJson(json);
}

/// @nodoc
mixin _$WebServerControlCommandResult {
  String get code => throw _privateConstructorUsedError;
  bool get enable => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WebServerControlCommandResultCopyWith<WebServerControlCommandResult>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WebServerControlCommandResultCopyWith<$Res> {
  factory $WebServerControlCommandResultCopyWith(
          WebServerControlCommandResult value,
          $Res Function(WebServerControlCommandResult) then) =
      _$WebServerControlCommandResultCopyWithImpl<$Res,
          WebServerControlCommandResult>;
  @useResult
  $Res call({String code, bool enable, int id});
}

/// @nodoc
class _$WebServerControlCommandResultCopyWithImpl<$Res,
        $Val extends WebServerControlCommandResult>
    implements $WebServerControlCommandResultCopyWith<$Res> {
  _$WebServerControlCommandResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? enable = null,
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      enable: null == enable
          ? _value.enable
          : enable // ignore: cast_nullable_to_non_nullable
              as bool,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WebServerControlCommandResultImplCopyWith<$Res>
    implements $WebServerControlCommandResultCopyWith<$Res> {
  factory _$$WebServerControlCommandResultImplCopyWith(
          _$WebServerControlCommandResultImpl value,
          $Res Function(_$WebServerControlCommandResultImpl) then) =
      __$$WebServerControlCommandResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String code, bool enable, int id});
}

/// @nodoc
class __$$WebServerControlCommandResultImplCopyWithImpl<$Res>
    extends _$WebServerControlCommandResultCopyWithImpl<$Res,
        _$WebServerControlCommandResultImpl>
    implements _$$WebServerControlCommandResultImplCopyWith<$Res> {
  __$$WebServerControlCommandResultImplCopyWithImpl(
      _$WebServerControlCommandResultImpl _value,
      $Res Function(_$WebServerControlCommandResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? enable = null,
    Object? id = null,
  }) {
    return _then(_$WebServerControlCommandResultImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      enable: null == enable
          ? _value.enable
          : enable // ignore: cast_nullable_to_non_nullable
              as bool,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WebServerControlCommandResultImpl
    implements _WebServerControlCommandResult {
  const _$WebServerControlCommandResultImpl(
      {required this.code, required this.enable, required this.id});

  factory _$WebServerControlCommandResultImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$WebServerControlCommandResultImplFromJson(json);

  @override
  final String code;
  @override
  final bool enable;
  @override
  final int id;

  @override
  String toString() {
    return 'WebServerControlCommandResult(code: $code, enable: $enable, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebServerControlCommandResultImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.enable, enable) || other.enable == enable) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, enable, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WebServerControlCommandResultImplCopyWith<
          _$WebServerControlCommandResultImpl>
      get copyWith => __$$WebServerControlCommandResultImplCopyWithImpl<
          _$WebServerControlCommandResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WebServerControlCommandResultImplToJson(
      this,
    );
  }
}

abstract class _WebServerControlCommandResult
    implements WebServerControlCommandResult {
  const factory _WebServerControlCommandResult(
      {required final String code,
      required final bool enable,
      required final int id}) = _$WebServerControlCommandResultImpl;

  factory _WebServerControlCommandResult.fromJson(Map<String, dynamic> json) =
      _$WebServerControlCommandResultImpl.fromJson;

  @override
  String get code;
  @override
  bool get enable;
  @override
  int get id;
  @override
  @JsonKey(ignore: true)
  _$$WebServerControlCommandResultImplCopyWith<
          _$WebServerControlCommandResultImpl>
      get copyWith => throw _privateConstructorUsedError;
}

WSErrorResult _$WSErrorResultFromJson(Map<String, dynamic> json) {
  return _WSErrorResult.fromJson(json);
}

/// @nodoc
mixin _$WSErrorResult {
  String get error => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WSErrorResultCopyWith<WSErrorResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WSErrorResultCopyWith<$Res> {
  factory $WSErrorResultCopyWith(
          WSErrorResult value, $Res Function(WSErrorResult) then) =
      _$WSErrorResultCopyWithImpl<$Res, WSErrorResult>;
  @useResult
  $Res call({String error, int id});
}

/// @nodoc
class _$WSErrorResultCopyWithImpl<$Res, $Val extends WSErrorResult>
    implements $WSErrorResultCopyWith<$Res> {
  _$WSErrorResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WSErrorResultImplCopyWith<$Res>
    implements $WSErrorResultCopyWith<$Res> {
  factory _$$WSErrorResultImplCopyWith(
          _$WSErrorResultImpl value, $Res Function(_$WSErrorResultImpl) then) =
      __$$WSErrorResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String error, int id});
}

/// @nodoc
class __$$WSErrorResultImplCopyWithImpl<$Res>
    extends _$WSErrorResultCopyWithImpl<$Res, _$WSErrorResultImpl>
    implements _$$WSErrorResultImplCopyWith<$Res> {
  __$$WSErrorResultImplCopyWithImpl(
      _$WSErrorResultImpl _value, $Res Function(_$WSErrorResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? id = null,
  }) {
    return _then(_$WSErrorResultImpl(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WSErrorResultImpl implements _WSErrorResult {
  const _$WSErrorResultImpl({required this.error, required this.id});

  factory _$WSErrorResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$WSErrorResultImplFromJson(json);

  @override
  final String error;
  @override
  final int id;

  @override
  String toString() {
    return 'WSErrorResult(error: $error, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WSErrorResultImpl &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, error, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WSErrorResultImplCopyWith<_$WSErrorResultImpl> get copyWith =>
      __$$WSErrorResultImplCopyWithImpl<_$WSErrorResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WSErrorResultImplToJson(
      this,
    );
  }
}

abstract class _WSErrorResult implements WSErrorResult {
  const factory _WSErrorResult(
      {required final String error,
      required final int id}) = _$WSErrorResultImpl;

  factory _WSErrorResult.fromJson(Map<String, dynamic> json) =
      _$WSErrorResultImpl.fromJson;

  @override
  String get error;
  @override
  int get id;
  @override
  @JsonKey(ignore: true)
  _$$WSErrorResultImplCopyWith<_$WSErrorResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WSHelloCommand _$WSHelloCommandFromJson(Map<String, dynamic> json) {
  return _WSHelloCommand.fromJson(json);
}

/// @nodoc
mixin _$WSHelloCommand {
  int get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WSHelloCommandCopyWith<WSHelloCommand> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WSHelloCommandCopyWith<$Res> {
  factory $WSHelloCommandCopyWith(
          WSHelloCommand value, $Res Function(WSHelloCommand) then) =
      _$WSHelloCommandCopyWithImpl<$Res, WSHelloCommand>;
  @useResult
  $Res call({int id, String type});
}

/// @nodoc
class _$WSHelloCommandCopyWithImpl<$Res, $Val extends WSHelloCommand>
    implements $WSHelloCommandCopyWith<$Res> {
  _$WSHelloCommandCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WSHelloCommandImplCopyWith<$Res>
    implements $WSHelloCommandCopyWith<$Res> {
  factory _$$WSHelloCommandImplCopyWith(_$WSHelloCommandImpl value,
          $Res Function(_$WSHelloCommandImpl) then) =
      __$$WSHelloCommandImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String type});
}

/// @nodoc
class __$$WSHelloCommandImplCopyWithImpl<$Res>
    extends _$WSHelloCommandCopyWithImpl<$Res, _$WSHelloCommandImpl>
    implements _$$WSHelloCommandImplCopyWith<$Res> {
  __$$WSHelloCommandImplCopyWithImpl(
      _$WSHelloCommandImpl _value, $Res Function(_$WSHelloCommandImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_$WSHelloCommandImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WSHelloCommandImpl implements _WSHelloCommand {
  const _$WSHelloCommandImpl(
      {required this.id, this.type = WSHelloCommand.TYPE});

  factory _$WSHelloCommandImpl.fromJson(Map<String, dynamic> json) =>
      _$$WSHelloCommandImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final String type;

  @override
  String toString() {
    return 'WSHelloCommand(id: $id, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WSHelloCommandImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WSHelloCommandImplCopyWith<_$WSHelloCommandImpl> get copyWith =>
      __$$WSHelloCommandImplCopyWithImpl<_$WSHelloCommandImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WSHelloCommandImplToJson(
      this,
    );
  }
}

abstract class _WSHelloCommand implements WSHelloCommand {
  const factory _WSHelloCommand({required final int id, final String type}) =
      _$WSHelloCommandImpl;

  factory _WSHelloCommand.fromJson(Map<String, dynamic> json) =
      _$WSHelloCommandImpl.fromJson;

  @override
  int get id;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$WSHelloCommandImplCopyWith<_$WSHelloCommandImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WSAuthCommand _$WSAuthCommandFromJson(Map<String, dynamic> json) {
  return _WSAuthCommand.fromJson(json);
}

/// @nodoc
mixin _$WSAuthCommand {
  String get userName => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WSAuthCommandCopyWith<WSAuthCommand> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WSAuthCommandCopyWith<$Res> {
  factory $WSAuthCommandCopyWith(
          WSAuthCommand value, $Res Function(WSAuthCommand) then) =
      _$WSAuthCommandCopyWithImpl<$Res, WSAuthCommand>;
  @useResult
  $Res call({String userName, String code, int id, String type});
}

/// @nodoc
class _$WSAuthCommandCopyWithImpl<$Res, $Val extends WSAuthCommand>
    implements $WSAuthCommandCopyWith<$Res> {
  _$WSAuthCommandCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
    Object? code = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WSAuthCommandImplCopyWith<$Res>
    implements $WSAuthCommandCopyWith<$Res> {
  factory _$$WSAuthCommandImplCopyWith(
          _$WSAuthCommandImpl value, $Res Function(_$WSAuthCommandImpl) then) =
      __$$WSAuthCommandImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userName, String code, int id, String type});
}

/// @nodoc
class __$$WSAuthCommandImplCopyWithImpl<$Res>
    extends _$WSAuthCommandCopyWithImpl<$Res, _$WSAuthCommandImpl>
    implements _$$WSAuthCommandImplCopyWith<$Res> {
  __$$WSAuthCommandImplCopyWithImpl(
      _$WSAuthCommandImpl _value, $Res Function(_$WSAuthCommandImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
    Object? code = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_$WSAuthCommandImpl(
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WSAuthCommandImpl implements _WSAuthCommand {
  const _$WSAuthCommandImpl(
      {required this.userName,
      required this.code,
      required this.id,
      this.type = WSAuthCommand.TYPE});

  factory _$WSAuthCommandImpl.fromJson(Map<String, dynamic> json) =>
      _$$WSAuthCommandImplFromJson(json);

  @override
  final String userName;
  @override
  final String code;
  @override
  final int id;
  @override
  @JsonKey()
  final String type;

  @override
  String toString() {
    return 'WSAuthCommand(userName: $userName, code: $code, id: $id, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WSAuthCommandImpl &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userName, code, id, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WSAuthCommandImplCopyWith<_$WSAuthCommandImpl> get copyWith =>
      __$$WSAuthCommandImplCopyWithImpl<_$WSAuthCommandImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WSAuthCommandImplToJson(
      this,
    );
  }
}

abstract class _WSAuthCommand implements WSAuthCommand {
  const factory _WSAuthCommand(
      {required final String userName,
      required final String code,
      required final int id,
      final String type}) = _$WSAuthCommandImpl;

  factory _WSAuthCommand.fromJson(Map<String, dynamic> json) =
      _$WSAuthCommandImpl.fromJson;

  @override
  String get userName;
  @override
  String get code;
  @override
  int get id;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$WSAuthCommandImplCopyWith<_$WSAuthCommandImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WSSendRpcCommand _$WSSendRpcCommandFromJson(Map<String, dynamic> json) {
  return _WSSendRpcCommand.fromJson(json);
}

/// @nodoc
mixin _$WSSendRpcCommand {
  ///TODO: FIX it
//required RpcCommand command,
  Object get commandData =>
      throw _privateConstructorUsedError; //WebSocketCommand.generateId()
  int get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WSSendRpcCommandCopyWith<WSSendRpcCommand> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WSSendRpcCommandCopyWith<$Res> {
  factory $WSSendRpcCommandCopyWith(
          WSSendRpcCommand value, $Res Function(WSSendRpcCommand) then) =
      _$WSSendRpcCommandCopyWithImpl<$Res, WSSendRpcCommand>;
  @useResult
  $Res call({Object commandData, int id, String type});
}

/// @nodoc
class _$WSSendRpcCommandCopyWithImpl<$Res, $Val extends WSSendRpcCommand>
    implements $WSSendRpcCommandCopyWith<$Res> {
  _$WSSendRpcCommandCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? commandData = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      commandData: null == commandData ? _value.commandData : commandData,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WSSendRpcCommandImplCopyWith<$Res>
    implements $WSSendRpcCommandCopyWith<$Res> {
  factory _$$WSSendRpcCommandImplCopyWith(_$WSSendRpcCommandImpl value,
          $Res Function(_$WSSendRpcCommandImpl) then) =
      __$$WSSendRpcCommandImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Object commandData, int id, String type});
}

/// @nodoc
class __$$WSSendRpcCommandImplCopyWithImpl<$Res>
    extends _$WSSendRpcCommandCopyWithImpl<$Res, _$WSSendRpcCommandImpl>
    implements _$$WSSendRpcCommandImplCopyWith<$Res> {
  __$$WSSendRpcCommandImplCopyWithImpl(_$WSSendRpcCommandImpl _value,
      $Res Function(_$WSSendRpcCommandImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? commandData = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_$WSSendRpcCommandImpl(
      commandData: null == commandData ? _value.commandData : commandData,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WSSendRpcCommandImpl implements _WSSendRpcCommand {
  const _$WSSendRpcCommandImpl(
      {required this.commandData,
      required this.id,
      this.type = WSSendRpcCommand.TYPE});

  factory _$WSSendRpcCommandImpl.fromJson(Map<String, dynamic> json) =>
      _$$WSSendRpcCommandImplFromJson(json);

  ///TODO: FIX it
//required RpcCommand command,
  @override
  final Object commandData;
//WebSocketCommand.generateId()
  @override
  final int id;
  @override
  @JsonKey()
  final String type;

  @override
  String toString() {
    return 'WSSendRpcCommand(commandData: $commandData, id: $id, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WSSendRpcCommandImpl &&
            const DeepCollectionEquality()
                .equals(other.commandData, commandData) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(commandData), id, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WSSendRpcCommandImplCopyWith<_$WSSendRpcCommandImpl> get copyWith =>
      __$$WSSendRpcCommandImplCopyWithImpl<_$WSSendRpcCommandImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WSSendRpcCommandImplToJson(
      this,
    );
  }
}

abstract class _WSSendRpcCommand implements WSSendRpcCommand {
  const factory _WSSendRpcCommand(
      {required final Object commandData,
      required final int id,
      final String type}) = _$WSSendRpcCommandImpl;

  factory _WSSendRpcCommand.fromJson(Map<String, dynamic> json) =
      _$WSSendRpcCommandImpl.fromJson;

  @override

  ///TODO: FIX it
//required RpcCommand command,
  Object get commandData;
  @override //WebSocketCommand.generateId()
  int get id;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$WSSendRpcCommandImplCopyWith<_$WSSendRpcCommandImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WSRpcResult _$WSRpcResultFromJson(Map<String, dynamic> json) {
  return _WSRpcResult.fromJson(json);
}

/// @nodoc
mixin _$WSRpcResult {
  ///TODO: FIX it
//required RpcResult result,
  Object get resultData => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WSRpcResultCopyWith<WSRpcResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WSRpcResultCopyWith<$Res> {
  factory $WSRpcResultCopyWith(
          WSRpcResult value, $Res Function(WSRpcResult) then) =
      _$WSRpcResultCopyWithImpl<$Res, WSRpcResult>;
  @useResult
  $Res call({Object resultData, int id});
}

/// @nodoc
class _$WSRpcResultCopyWithImpl<$Res, $Val extends WSRpcResult>
    implements $WSRpcResultCopyWith<$Res> {
  _$WSRpcResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resultData = null,
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      resultData: null == resultData ? _value.resultData : resultData,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WSRpcResultImplCopyWith<$Res>
    implements $WSRpcResultCopyWith<$Res> {
  factory _$$WSRpcResultImplCopyWith(
          _$WSRpcResultImpl value, $Res Function(_$WSRpcResultImpl) then) =
      __$$WSRpcResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Object resultData, int id});
}

/// @nodoc
class __$$WSRpcResultImplCopyWithImpl<$Res>
    extends _$WSRpcResultCopyWithImpl<$Res, _$WSRpcResultImpl>
    implements _$$WSRpcResultImplCopyWith<$Res> {
  __$$WSRpcResultImplCopyWithImpl(
      _$WSRpcResultImpl _value, $Res Function(_$WSRpcResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resultData = null,
    Object? id = null,
  }) {
    return _then(_$WSRpcResultImpl(
      resultData: null == resultData ? _value.resultData : resultData,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WSRpcResultImpl implements _WSRpcResult {
  const _$WSRpcResultImpl({required this.resultData, required this.id});

  factory _$WSRpcResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$WSRpcResultImplFromJson(json);

  ///TODO: FIX it
//required RpcResult result,
  @override
  final Object resultData;
  @override
  final int id;

  @override
  String toString() {
    return 'WSRpcResult(resultData: $resultData, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WSRpcResultImpl &&
            const DeepCollectionEquality()
                .equals(other.resultData, resultData) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(resultData), id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WSRpcResultImplCopyWith<_$WSRpcResultImpl> get copyWith =>
      __$$WSRpcResultImplCopyWithImpl<_$WSRpcResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WSRpcResultImplToJson(
      this,
    );
  }
}

abstract class _WSRpcResult implements WSRpcResult {
  const factory _WSRpcResult(
      {required final Object resultData,
      required final int id}) = _$WSRpcResultImpl;

  factory _WSRpcResult.fromJson(Map<String, dynamic> json) =
      _$WSRpcResultImpl.fromJson;

  @override

  ///TODO: FIX it
//required RpcResult result,
  Object get resultData;
  @override
  int get id;
  @override
  @JsonKey(ignore: true)
  _$$WSRpcResultImplCopyWith<_$WSRpcResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WSConfigDownloadCommand _$WSConfigDownloadCommandFromJson(
    Map<String, dynamic> json) {
  return _WSConfigDownloadCommand.fromJson(json);
}

/// @nodoc
mixin _$WSConfigDownloadCommand {
  int get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WSConfigDownloadCommandCopyWith<WSConfigDownloadCommand> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WSConfigDownloadCommandCopyWith<$Res> {
  factory $WSConfigDownloadCommandCopyWith(WSConfigDownloadCommand value,
          $Res Function(WSConfigDownloadCommand) then) =
      _$WSConfigDownloadCommandCopyWithImpl<$Res, WSConfigDownloadCommand>;
  @useResult
  $Res call({int id, String type});
}

/// @nodoc
class _$WSConfigDownloadCommandCopyWithImpl<$Res,
        $Val extends WSConfigDownloadCommand>
    implements $WSConfigDownloadCommandCopyWith<$Res> {
  _$WSConfigDownloadCommandCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WSConfigDownloadCommandImplCopyWith<$Res>
    implements $WSConfigDownloadCommandCopyWith<$Res> {
  factory _$$WSConfigDownloadCommandImplCopyWith(
          _$WSConfigDownloadCommandImpl value,
          $Res Function(_$WSConfigDownloadCommandImpl) then) =
      __$$WSConfigDownloadCommandImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String type});
}

/// @nodoc
class __$$WSConfigDownloadCommandImplCopyWithImpl<$Res>
    extends _$WSConfigDownloadCommandCopyWithImpl<$Res,
        _$WSConfigDownloadCommandImpl>
    implements _$$WSConfigDownloadCommandImplCopyWith<$Res> {
  __$$WSConfigDownloadCommandImplCopyWithImpl(
      _$WSConfigDownloadCommandImpl _value,
      $Res Function(_$WSConfigDownloadCommandImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_$WSConfigDownloadCommandImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WSConfigDownloadCommandImpl implements _WSConfigDownloadCommand {
  const _$WSConfigDownloadCommandImpl(
      {required this.id, this.type = WSConfigDownloadCommand.TYPE});

  factory _$WSConfigDownloadCommandImpl.fromJson(Map<String, dynamic> json) =>
      _$$WSConfigDownloadCommandImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final String type;

  @override
  String toString() {
    return 'WSConfigDownloadCommand(id: $id, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WSConfigDownloadCommandImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WSConfigDownloadCommandImplCopyWith<_$WSConfigDownloadCommandImpl>
      get copyWith => __$$WSConfigDownloadCommandImplCopyWithImpl<
          _$WSConfigDownloadCommandImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WSConfigDownloadCommandImplToJson(
      this,
    );
  }
}

abstract class _WSConfigDownloadCommand implements WSConfigDownloadCommand {
  const factory _WSConfigDownloadCommand(
      {required final int id,
      final String type}) = _$WSConfigDownloadCommandImpl;

  factory _WSConfigDownloadCommand.fromJson(Map<String, dynamic> json) =
      _$WSConfigDownloadCommandImpl.fromJson;

  @override
  int get id;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$WSConfigDownloadCommandImplCopyWith<_$WSConfigDownloadCommandImpl>
      get copyWith => throw _privateConstructorUsedError;
}

WSConfigUploadCommand _$WSConfigUploadCommandFromJson(
    Map<String, dynamic> json) {
  return _WSConfigUploadCommand.fromJson(json);
}

/// @nodoc
mixin _$WSConfigUploadCommand {
  String get content => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WSConfigUploadCommandCopyWith<WSConfigUploadCommand> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WSConfigUploadCommandCopyWith<$Res> {
  factory $WSConfigUploadCommandCopyWith(WSConfigUploadCommand value,
          $Res Function(WSConfigUploadCommand) then) =
      _$WSConfigUploadCommandCopyWithImpl<$Res, WSConfigUploadCommand>;
  @useResult
  $Res call({String content, int id, String type});
}

/// @nodoc
class _$WSConfigUploadCommandCopyWithImpl<$Res,
        $Val extends WSConfigUploadCommand>
    implements $WSConfigUploadCommandCopyWith<$Res> {
  _$WSConfigUploadCommandCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WSConfigUploadCommandImplCopyWith<$Res>
    implements $WSConfigUploadCommandCopyWith<$Res> {
  factory _$$WSConfigUploadCommandImplCopyWith(
          _$WSConfigUploadCommandImpl value,
          $Res Function(_$WSConfigUploadCommandImpl) then) =
      __$$WSConfigUploadCommandImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String content, int id, String type});
}

/// @nodoc
class __$$WSConfigUploadCommandImplCopyWithImpl<$Res>
    extends _$WSConfigUploadCommandCopyWithImpl<$Res,
        _$WSConfigUploadCommandImpl>
    implements _$$WSConfigUploadCommandImplCopyWith<$Res> {
  __$$WSConfigUploadCommandImplCopyWithImpl(_$WSConfigUploadCommandImpl _value,
      $Res Function(_$WSConfigUploadCommandImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_$WSConfigUploadCommandImpl(
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WSConfigUploadCommandImpl implements _WSConfigUploadCommand {
  const _$WSConfigUploadCommandImpl(
      {required this.content,
      required this.id,
      this.type = WSConfigUploadCommand.TYPE});

  factory _$WSConfigUploadCommandImpl.fromJson(Map<String, dynamic> json) =>
      _$$WSConfigUploadCommandImplFromJson(json);

  @override
  final String content;
  @override
  final int id;
  @override
  @JsonKey()
  final String type;

  @override
  String toString() {
    return 'WSConfigUploadCommand(content: $content, id: $id, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WSConfigUploadCommandImpl &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, content, id, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WSConfigUploadCommandImplCopyWith<_$WSConfigUploadCommandImpl>
      get copyWith => __$$WSConfigUploadCommandImplCopyWithImpl<
          _$WSConfigUploadCommandImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WSConfigUploadCommandImplToJson(
      this,
    );
  }
}

abstract class _WSConfigUploadCommand implements WSConfigUploadCommand {
  const factory _WSConfigUploadCommand(
      {required final String content,
      required final int id,
      final String type}) = _$WSConfigUploadCommandImpl;

  factory _WSConfigUploadCommand.fromJson(Map<String, dynamic> json) =
      _$WSConfigUploadCommandImpl.fromJson;

  @override
  String get content;
  @override
  int get id;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$WSConfigUploadCommandImplCopyWith<_$WSConfigUploadCommandImpl>
      get copyWith => throw _privateConstructorUsedError;
}

WSConfigDownloadResult _$WSConfigDownloadResultFromJson(
    Map<String, dynamic> json) {
  return _WSConfigDownloadResult.fromJson(json);
}

/// @nodoc
mixin _$WSConfigDownloadResult {
  String get content => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WSConfigDownloadResultCopyWith<WSConfigDownloadResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WSConfigDownloadResultCopyWith<$Res> {
  factory $WSConfigDownloadResultCopyWith(WSConfigDownloadResult value,
          $Res Function(WSConfigDownloadResult) then) =
      _$WSConfigDownloadResultCopyWithImpl<$Res, WSConfigDownloadResult>;
  @useResult
  $Res call({String content, int id});
}

/// @nodoc
class _$WSConfigDownloadResultCopyWithImpl<$Res,
        $Val extends WSConfigDownloadResult>
    implements $WSConfigDownloadResultCopyWith<$Res> {
  _$WSConfigDownloadResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WSConfigDownloadResultImplCopyWith<$Res>
    implements $WSConfigDownloadResultCopyWith<$Res> {
  factory _$$WSConfigDownloadResultImplCopyWith(
          _$WSConfigDownloadResultImpl value,
          $Res Function(_$WSConfigDownloadResultImpl) then) =
      __$$WSConfigDownloadResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String content, int id});
}

/// @nodoc
class __$$WSConfigDownloadResultImplCopyWithImpl<$Res>
    extends _$WSConfigDownloadResultCopyWithImpl<$Res,
        _$WSConfigDownloadResultImpl>
    implements _$$WSConfigDownloadResultImplCopyWith<$Res> {
  __$$WSConfigDownloadResultImplCopyWithImpl(
      _$WSConfigDownloadResultImpl _value,
      $Res Function(_$WSConfigDownloadResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
    Object? id = null,
  }) {
    return _then(_$WSConfigDownloadResultImpl(
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WSConfigDownloadResultImpl implements _WSConfigDownloadResult {
  const _$WSConfigDownloadResultImpl({required this.content, required this.id});

  factory _$WSConfigDownloadResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$WSConfigDownloadResultImplFromJson(json);

  @override
  final String content;
  @override
  final int id;

  @override
  String toString() {
    return 'WSConfigDownloadResult(content: $content, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WSConfigDownloadResultImpl &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, content, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WSConfigDownloadResultImplCopyWith<_$WSConfigDownloadResultImpl>
      get copyWith => __$$WSConfigDownloadResultImplCopyWithImpl<
          _$WSConfigDownloadResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WSConfigDownloadResultImplToJson(
      this,
    );
  }
}

abstract class _WSConfigDownloadResult implements WSConfigDownloadResult {
  const factory _WSConfigDownloadResult(
      {required final String content,
      required final int id}) = _$WSConfigDownloadResultImpl;

  factory _WSConfigDownloadResult.fromJson(Map<String, dynamic> json) =
      _$WSConfigDownloadResultImpl.fromJson;

  @override
  String get content;
  @override
  int get id;
  @override
  @JsonKey(ignore: true)
  _$$WSConfigDownloadResultImplCopyWith<_$WSConfigDownloadResultImpl>
      get copyWith => throw _privateConstructorUsedError;
}

WSRestartApplicationCommand _$WSRestartApplicationCommandFromJson(
    Map<String, dynamic> json) {
  return _WSRestartApplicationCommand.fromJson(json);
}

/// @nodoc
mixin _$WSRestartApplicationCommand {
  int get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WSRestartApplicationCommandCopyWith<WSRestartApplicationCommand>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WSRestartApplicationCommandCopyWith<$Res> {
  factory $WSRestartApplicationCommandCopyWith(
          WSRestartApplicationCommand value,
          $Res Function(WSRestartApplicationCommand) then) =
      _$WSRestartApplicationCommandCopyWithImpl<$Res,
          WSRestartApplicationCommand>;
  @useResult
  $Res call({int id, String type});
}

/// @nodoc
class _$WSRestartApplicationCommandCopyWithImpl<$Res,
        $Val extends WSRestartApplicationCommand>
    implements $WSRestartApplicationCommandCopyWith<$Res> {
  _$WSRestartApplicationCommandCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WSRestartApplicationCommandImplCopyWith<$Res>
    implements $WSRestartApplicationCommandCopyWith<$Res> {
  factory _$$WSRestartApplicationCommandImplCopyWith(
          _$WSRestartApplicationCommandImpl value,
          $Res Function(_$WSRestartApplicationCommandImpl) then) =
      __$$WSRestartApplicationCommandImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String type});
}

/// @nodoc
class __$$WSRestartApplicationCommandImplCopyWithImpl<$Res>
    extends _$WSRestartApplicationCommandCopyWithImpl<$Res,
        _$WSRestartApplicationCommandImpl>
    implements _$$WSRestartApplicationCommandImplCopyWith<$Res> {
  __$$WSRestartApplicationCommandImplCopyWithImpl(
      _$WSRestartApplicationCommandImpl _value,
      $Res Function(_$WSRestartApplicationCommandImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_$WSRestartApplicationCommandImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WSRestartApplicationCommandImpl
    implements _WSRestartApplicationCommand {
  const _$WSRestartApplicationCommandImpl(
      {required this.id, this.type = WSRestartApplicationCommand.TYPE});

  factory _$WSRestartApplicationCommandImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$WSRestartApplicationCommandImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final String type;

  @override
  String toString() {
    return 'WSRestartApplicationCommand(id: $id, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WSRestartApplicationCommandImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WSRestartApplicationCommandImplCopyWith<_$WSRestartApplicationCommandImpl>
      get copyWith => __$$WSRestartApplicationCommandImplCopyWithImpl<
          _$WSRestartApplicationCommandImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WSRestartApplicationCommandImplToJson(
      this,
    );
  }
}

abstract class _WSRestartApplicationCommand
    implements WSRestartApplicationCommand {
  const factory _WSRestartApplicationCommand(
      {required final int id,
      final String type}) = _$WSRestartApplicationCommandImpl;

  factory _WSRestartApplicationCommand.fromJson(Map<String, dynamic> json) =
      _$WSRestartApplicationCommandImpl.fromJson;

  @override
  int get id;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$WSRestartApplicationCommandImplCopyWith<_$WSRestartApplicationCommandImpl>
      get copyWith => throw _privateConstructorUsedError;
}

WSResultOk _$WSResultOkFromJson(Map<String, dynamic> json) {
  return _WSResultOk.fromJson(json);
}

/// @nodoc
mixin _$WSResultOk {
  int get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WSResultOkCopyWith<WSResultOk> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WSResultOkCopyWith<$Res> {
  factory $WSResultOkCopyWith(
          WSResultOk value, $Res Function(WSResultOk) then) =
      _$WSResultOkCopyWithImpl<$Res, WSResultOk>;
  @useResult
  $Res call({int id});
}

/// @nodoc
class _$WSResultOkCopyWithImpl<$Res, $Val extends WSResultOk>
    implements $WSResultOkCopyWith<$Res> {
  _$WSResultOkCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WSResultOkImplCopyWith<$Res>
    implements $WSResultOkCopyWith<$Res> {
  factory _$$WSResultOkImplCopyWith(
          _$WSResultOkImpl value, $Res Function(_$WSResultOkImpl) then) =
      __$$WSResultOkImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id});
}

/// @nodoc
class __$$WSResultOkImplCopyWithImpl<$Res>
    extends _$WSResultOkCopyWithImpl<$Res, _$WSResultOkImpl>
    implements _$$WSResultOkImplCopyWith<$Res> {
  __$$WSResultOkImplCopyWithImpl(
      _$WSResultOkImpl _value, $Res Function(_$WSResultOkImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$WSResultOkImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WSResultOkImpl implements _WSResultOk {
  const _$WSResultOkImpl({required this.id});

  factory _$WSResultOkImpl.fromJson(Map<String, dynamic> json) =>
      _$$WSResultOkImplFromJson(json);

  @override
  final int id;

  @override
  String toString() {
    return 'WSResultOk(id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WSResultOkImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WSResultOkImplCopyWith<_$WSResultOkImpl> get copyWith =>
      __$$WSResultOkImplCopyWithImpl<_$WSResultOkImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WSResultOkImplToJson(
      this,
    );
  }
}

abstract class _WSResultOk implements WSResultOk {
  const factory _WSResultOk({required final int id}) = _$WSResultOkImpl;

  factory _WSResultOk.fromJson(Map<String, dynamic> json) =
      _$WSResultOkImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(ignore: true)
  _$$WSResultOkImplCopyWith<_$WSResultOkImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WSEchoResult _$WSEchoResultFromJson(Map<String, dynamic> json) {
  return _WSEchoResult.fromJson(json);
}

/// @nodoc
mixin _$WSEchoResult {
  String get msg => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WSEchoResultCopyWith<WSEchoResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WSEchoResultCopyWith<$Res> {
  factory $WSEchoResultCopyWith(
          WSEchoResult value, $Res Function(WSEchoResult) then) =
      _$WSEchoResultCopyWithImpl<$Res, WSEchoResult>;
  @useResult
  $Res call({String msg, int id});
}

/// @nodoc
class _$WSEchoResultCopyWithImpl<$Res, $Val extends WSEchoResult>
    implements $WSEchoResultCopyWith<$Res> {
  _$WSEchoResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? msg = null,
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      msg: null == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WSEchoResultImplCopyWith<$Res>
    implements $WSEchoResultCopyWith<$Res> {
  factory _$$WSEchoResultImplCopyWith(
          _$WSEchoResultImpl value, $Res Function(_$WSEchoResultImpl) then) =
      __$$WSEchoResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String msg, int id});
}

/// @nodoc
class __$$WSEchoResultImplCopyWithImpl<$Res>
    extends _$WSEchoResultCopyWithImpl<$Res, _$WSEchoResultImpl>
    implements _$$WSEchoResultImplCopyWith<$Res> {
  __$$WSEchoResultImplCopyWithImpl(
      _$WSEchoResultImpl _value, $Res Function(_$WSEchoResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? msg = null,
    Object? id = null,
  }) {
    return _then(_$WSEchoResultImpl(
      msg: null == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WSEchoResultImpl implements _WSEchoResult {
  const _$WSEchoResultImpl({required this.msg, required this.id});

  factory _$WSEchoResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$WSEchoResultImplFromJson(json);

  @override
  final String msg;
  @override
  final int id;

  @override
  String toString() {
    return 'WSEchoResult(msg: $msg, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WSEchoResultImpl &&
            (identical(other.msg, msg) || other.msg == msg) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, msg, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WSEchoResultImplCopyWith<_$WSEchoResultImpl> get copyWith =>
      __$$WSEchoResultImplCopyWithImpl<_$WSEchoResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WSEchoResultImplToJson(
      this,
    );
  }
}

abstract class _WSEchoResult implements WSEchoResult {
  const factory _WSEchoResult(
      {required final String msg, required final int id}) = _$WSEchoResultImpl;

  factory _WSEchoResult.fromJson(Map<String, dynamic> json) =
      _$WSEchoResultImpl.fromJson;

  @override
  String get msg;
  @override
  int get id;
  @override
  @JsonKey(ignore: true)
  _$$WSEchoResultImplCopyWith<_$WSEchoResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WSEchoCommand _$WSEchoCommandFromJson(Map<String, dynamic> json) {
  return _WSEchoCommand.fromJson(json);
}

/// @nodoc
mixin _$WSEchoCommand {
  String get msg => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WSEchoCommandCopyWith<WSEchoCommand> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WSEchoCommandCopyWith<$Res> {
  factory $WSEchoCommandCopyWith(
          WSEchoCommand value, $Res Function(WSEchoCommand) then) =
      _$WSEchoCommandCopyWithImpl<$Res, WSEchoCommand>;
  @useResult
  $Res call({String msg, int id, String type});
}

/// @nodoc
class _$WSEchoCommandCopyWithImpl<$Res, $Val extends WSEchoCommand>
    implements $WSEchoCommandCopyWith<$Res> {
  _$WSEchoCommandCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? msg = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      msg: null == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WSEchoCommandImplCopyWith<$Res>
    implements $WSEchoCommandCopyWith<$Res> {
  factory _$$WSEchoCommandImplCopyWith(
          _$WSEchoCommandImpl value, $Res Function(_$WSEchoCommandImpl) then) =
      __$$WSEchoCommandImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String msg, int id, String type});
}

/// @nodoc
class __$$WSEchoCommandImplCopyWithImpl<$Res>
    extends _$WSEchoCommandCopyWithImpl<$Res, _$WSEchoCommandImpl>
    implements _$$WSEchoCommandImplCopyWith<$Res> {
  __$$WSEchoCommandImplCopyWithImpl(
      _$WSEchoCommandImpl _value, $Res Function(_$WSEchoCommandImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? msg = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_$WSEchoCommandImpl(
      msg: null == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WSEchoCommandImpl implements _WSEchoCommand {
  const _$WSEchoCommandImpl(
      {required this.msg, required this.id, this.type = WSEchoCommand.TYPE});

  factory _$WSEchoCommandImpl.fromJson(Map<String, dynamic> json) =>
      _$$WSEchoCommandImplFromJson(json);

  @override
  final String msg;
  @override
  final int id;
  @override
  @JsonKey()
  final String type;

  @override
  String toString() {
    return 'WSEchoCommand(msg: $msg, id: $id, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WSEchoCommandImpl &&
            (identical(other.msg, msg) || other.msg == msg) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, msg, id, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WSEchoCommandImplCopyWith<_$WSEchoCommandImpl> get copyWith =>
      __$$WSEchoCommandImplCopyWithImpl<_$WSEchoCommandImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WSEchoCommandImplToJson(
      this,
    );
  }
}

abstract class _WSEchoCommand implements WSEchoCommand {
  const factory _WSEchoCommand(
      {required final String msg,
      required final int id,
      final String type}) = _$WSEchoCommandImpl;

  factory _WSEchoCommand.fromJson(Map<String, dynamic> json) =
      _$WSEchoCommandImpl.fromJson;

  @override
  String get msg;
  @override
  int get id;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$WSEchoCommandImplCopyWith<_$WSEchoCommandImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
