// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'web_server_commands.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WebServerControlCommand {
  bool get enable;
  int get id;
  String get type;

  /// Create a copy of WebServerControlCommand
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WebServerControlCommandCopyWith<WebServerControlCommand> get copyWith =>
      _$WebServerControlCommandCopyWithImpl<WebServerControlCommand>(
          this as WebServerControlCommand, _$identity);

  /// Serializes this WebServerControlCommand to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WebServerControlCommand &&
            (identical(other.enable, enable) || other.enable == enable) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, enable, id, type);

  @override
  String toString() {
    return 'WebServerControlCommand(enable: $enable, id: $id, type: $type)';
  }
}

/// @nodoc
abstract mixin class $WebServerControlCommandCopyWith<$Res> {
  factory $WebServerControlCommandCopyWith(WebServerControlCommand value,
          $Res Function(WebServerControlCommand) _then) =
      _$WebServerControlCommandCopyWithImpl;
  @useResult
  $Res call({bool enable, int id, String type});
}

/// @nodoc
class _$WebServerControlCommandCopyWithImpl<$Res>
    implements $WebServerControlCommandCopyWith<$Res> {
  _$WebServerControlCommandCopyWithImpl(this._self, this._then);

  final WebServerControlCommand _self;
  final $Res Function(WebServerControlCommand) _then;

  /// Create a copy of WebServerControlCommand
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enable = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_self.copyWith(
      enable: null == enable
          ? _self.enable
          : enable // ignore: cast_nullable_to_non_nullable
              as bool,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _WebServerControlCommand implements WebServerControlCommand {
  const _WebServerControlCommand(
      {required this.enable,
      required this.id,
      this.type = WebServerControlCommand.TYPE});
  factory _WebServerControlCommand.fromJson(Map<String, dynamic> json) =>
      _$WebServerControlCommandFromJson(json);

  @override
  final bool enable;
  @override
  final int id;
  @override
  @JsonKey()
  final String type;

  /// Create a copy of WebServerControlCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WebServerControlCommandCopyWith<_WebServerControlCommand> get copyWith =>
      __$WebServerControlCommandCopyWithImpl<_WebServerControlCommand>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WebServerControlCommandToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WebServerControlCommand &&
            (identical(other.enable, enable) || other.enable == enable) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, enable, id, type);

  @override
  String toString() {
    return 'WebServerControlCommand(enable: $enable, id: $id, type: $type)';
  }
}

/// @nodoc
abstract mixin class _$WebServerControlCommandCopyWith<$Res>
    implements $WebServerControlCommandCopyWith<$Res> {
  factory _$WebServerControlCommandCopyWith(_WebServerControlCommand value,
          $Res Function(_WebServerControlCommand) _then) =
      __$WebServerControlCommandCopyWithImpl;
  @override
  @useResult
  $Res call({bool enable, int id, String type});
}

/// @nodoc
class __$WebServerControlCommandCopyWithImpl<$Res>
    implements _$WebServerControlCommandCopyWith<$Res> {
  __$WebServerControlCommandCopyWithImpl(this._self, this._then);

  final _WebServerControlCommand _self;
  final $Res Function(_WebServerControlCommand) _then;

  /// Create a copy of WebServerControlCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? enable = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_WebServerControlCommand(
      enable: null == enable
          ? _self.enable
          : enable // ignore: cast_nullable_to_non_nullable
              as bool,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$WebServerControlCommandResult {
  String get code;
  bool get enable;
  int get id;

  /// Create a copy of WebServerControlCommandResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WebServerControlCommandResultCopyWith<WebServerControlCommandResult>
      get copyWith => _$WebServerControlCommandResultCopyWithImpl<
              WebServerControlCommandResult>(
          this as WebServerControlCommandResult, _$identity);

  /// Serializes this WebServerControlCommandResult to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WebServerControlCommandResult &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.enable, enable) || other.enable == enable) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, code, enable, id);

  @override
  String toString() {
    return 'WebServerControlCommandResult(code: $code, enable: $enable, id: $id)';
  }
}

/// @nodoc
abstract mixin class $WebServerControlCommandResultCopyWith<$Res> {
  factory $WebServerControlCommandResultCopyWith(
          WebServerControlCommandResult value,
          $Res Function(WebServerControlCommandResult) _then) =
      _$WebServerControlCommandResultCopyWithImpl;
  @useResult
  $Res call({String code, bool enable, int id});
}

/// @nodoc
class _$WebServerControlCommandResultCopyWithImpl<$Res>
    implements $WebServerControlCommandResultCopyWith<$Res> {
  _$WebServerControlCommandResultCopyWithImpl(this._self, this._then);

  final WebServerControlCommandResult _self;
  final $Res Function(WebServerControlCommandResult) _then;

  /// Create a copy of WebServerControlCommandResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? enable = null,
    Object? id = null,
  }) {
    return _then(_self.copyWith(
      code: null == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      enable: null == enable
          ? _self.enable
          : enable // ignore: cast_nullable_to_non_nullable
              as bool,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _WebServerControlCommandResult implements WebServerControlCommandResult {
  const _WebServerControlCommandResult(
      {required this.code, required this.enable, required this.id});
  factory _WebServerControlCommandResult.fromJson(Map<String, dynamic> json) =>
      _$WebServerControlCommandResultFromJson(json);

  @override
  final String code;
  @override
  final bool enable;
  @override
  final int id;

  /// Create a copy of WebServerControlCommandResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WebServerControlCommandResultCopyWith<_WebServerControlCommandResult>
      get copyWith => __$WebServerControlCommandResultCopyWithImpl<
          _WebServerControlCommandResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WebServerControlCommandResultToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WebServerControlCommandResult &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.enable, enable) || other.enable == enable) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, code, enable, id);

  @override
  String toString() {
    return 'WebServerControlCommandResult(code: $code, enable: $enable, id: $id)';
  }
}

/// @nodoc
abstract mixin class _$WebServerControlCommandResultCopyWith<$Res>
    implements $WebServerControlCommandResultCopyWith<$Res> {
  factory _$WebServerControlCommandResultCopyWith(
          _WebServerControlCommandResult value,
          $Res Function(_WebServerControlCommandResult) _then) =
      __$WebServerControlCommandResultCopyWithImpl;
  @override
  @useResult
  $Res call({String code, bool enable, int id});
}

/// @nodoc
class __$WebServerControlCommandResultCopyWithImpl<$Res>
    implements _$WebServerControlCommandResultCopyWith<$Res> {
  __$WebServerControlCommandResultCopyWithImpl(this._self, this._then);

  final _WebServerControlCommandResult _self;
  final $Res Function(_WebServerControlCommandResult) _then;

  /// Create a copy of WebServerControlCommandResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? code = null,
    Object? enable = null,
    Object? id = null,
  }) {
    return _then(_WebServerControlCommandResult(
      code: null == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      enable: null == enable
          ? _self.enable
          : enable // ignore: cast_nullable_to_non_nullable
              as bool,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$WSErrorResult {
  String get error;
  int get id;

  /// Create a copy of WSErrorResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WSErrorResultCopyWith<WSErrorResult> get copyWith =>
      _$WSErrorResultCopyWithImpl<WSErrorResult>(
          this as WSErrorResult, _$identity);

  /// Serializes this WSErrorResult to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WSErrorResult &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, error, id);

  @override
  String toString() {
    return 'WSErrorResult(error: $error, id: $id)';
  }
}

/// @nodoc
abstract mixin class $WSErrorResultCopyWith<$Res> {
  factory $WSErrorResultCopyWith(
          WSErrorResult value, $Res Function(WSErrorResult) _then) =
      _$WSErrorResultCopyWithImpl;
  @useResult
  $Res call({String error, int id});
}

/// @nodoc
class _$WSErrorResultCopyWithImpl<$Res>
    implements $WSErrorResultCopyWith<$Res> {
  _$WSErrorResultCopyWithImpl(this._self, this._then);

  final WSErrorResult _self;
  final $Res Function(WSErrorResult) _then;

  /// Create a copy of WSErrorResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? id = null,
  }) {
    return _then(_self.copyWith(
      error: null == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _WSErrorResult implements WSErrorResult {
  const _WSErrorResult({required this.error, required this.id});
  factory _WSErrorResult.fromJson(Map<String, dynamic> json) =>
      _$WSErrorResultFromJson(json);

  @override
  final String error;
  @override
  final int id;

  /// Create a copy of WSErrorResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WSErrorResultCopyWith<_WSErrorResult> get copyWith =>
      __$WSErrorResultCopyWithImpl<_WSErrorResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WSErrorResultToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WSErrorResult &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, error, id);

  @override
  String toString() {
    return 'WSErrorResult(error: $error, id: $id)';
  }
}

/// @nodoc
abstract mixin class _$WSErrorResultCopyWith<$Res>
    implements $WSErrorResultCopyWith<$Res> {
  factory _$WSErrorResultCopyWith(
          _WSErrorResult value, $Res Function(_WSErrorResult) _then) =
      __$WSErrorResultCopyWithImpl;
  @override
  @useResult
  $Res call({String error, int id});
}

/// @nodoc
class __$WSErrorResultCopyWithImpl<$Res>
    implements _$WSErrorResultCopyWith<$Res> {
  __$WSErrorResultCopyWithImpl(this._self, this._then);

  final _WSErrorResult _self;
  final $Res Function(_WSErrorResult) _then;

  /// Create a copy of WSErrorResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? error = null,
    Object? id = null,
  }) {
    return _then(_WSErrorResult(
      error: null == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$WSHelloCommand {
  int get id;
  String get type;

  /// Create a copy of WSHelloCommand
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WSHelloCommandCopyWith<WSHelloCommand> get copyWith =>
      _$WSHelloCommandCopyWithImpl<WSHelloCommand>(
          this as WSHelloCommand, _$identity);

  /// Serializes this WSHelloCommand to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WSHelloCommand &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, type);

  @override
  String toString() {
    return 'WSHelloCommand(id: $id, type: $type)';
  }
}

/// @nodoc
abstract mixin class $WSHelloCommandCopyWith<$Res> {
  factory $WSHelloCommandCopyWith(
          WSHelloCommand value, $Res Function(WSHelloCommand) _then) =
      _$WSHelloCommandCopyWithImpl;
  @useResult
  $Res call({int id, String type});
}

/// @nodoc
class _$WSHelloCommandCopyWithImpl<$Res>
    implements $WSHelloCommandCopyWith<$Res> {
  _$WSHelloCommandCopyWithImpl(this._self, this._then);

  final WSHelloCommand _self;
  final $Res Function(WSHelloCommand) _then;

  /// Create a copy of WSHelloCommand
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _WSHelloCommand implements WSHelloCommand {
  const _WSHelloCommand({required this.id, this.type = WSHelloCommand.TYPE});
  factory _WSHelloCommand.fromJson(Map<String, dynamic> json) =>
      _$WSHelloCommandFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final String type;

  /// Create a copy of WSHelloCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WSHelloCommandCopyWith<_WSHelloCommand> get copyWith =>
      __$WSHelloCommandCopyWithImpl<_WSHelloCommand>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WSHelloCommandToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WSHelloCommand &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, type);

  @override
  String toString() {
    return 'WSHelloCommand(id: $id, type: $type)';
  }
}

/// @nodoc
abstract mixin class _$WSHelloCommandCopyWith<$Res>
    implements $WSHelloCommandCopyWith<$Res> {
  factory _$WSHelloCommandCopyWith(
          _WSHelloCommand value, $Res Function(_WSHelloCommand) _then) =
      __$WSHelloCommandCopyWithImpl;
  @override
  @useResult
  $Res call({int id, String type});
}

/// @nodoc
class __$WSHelloCommandCopyWithImpl<$Res>
    implements _$WSHelloCommandCopyWith<$Res> {
  __$WSHelloCommandCopyWithImpl(this._self, this._then);

  final _WSHelloCommand _self;
  final $Res Function(_WSHelloCommand) _then;

  /// Create a copy of WSHelloCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_WSHelloCommand(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$WSAuthCommand {
  String get userName;
  String get code;
  int get id;
  String get type;

  /// Create a copy of WSAuthCommand
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WSAuthCommandCopyWith<WSAuthCommand> get copyWith =>
      _$WSAuthCommandCopyWithImpl<WSAuthCommand>(
          this as WSAuthCommand, _$identity);

  /// Serializes this WSAuthCommand to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WSAuthCommand &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userName, code, id, type);

  @override
  String toString() {
    return 'WSAuthCommand(userName: $userName, code: $code, id: $id, type: $type)';
  }
}

/// @nodoc
abstract mixin class $WSAuthCommandCopyWith<$Res> {
  factory $WSAuthCommandCopyWith(
          WSAuthCommand value, $Res Function(WSAuthCommand) _then) =
      _$WSAuthCommandCopyWithImpl;
  @useResult
  $Res call({String userName, String code, int id, String type});
}

/// @nodoc
class _$WSAuthCommandCopyWithImpl<$Res>
    implements $WSAuthCommandCopyWith<$Res> {
  _$WSAuthCommandCopyWithImpl(this._self, this._then);

  final WSAuthCommand _self;
  final $Res Function(WSAuthCommand) _then;

  /// Create a copy of WSAuthCommand
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
    Object? code = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_self.copyWith(
      userName: null == userName
          ? _self.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _WSAuthCommand implements WSAuthCommand {
  const _WSAuthCommand(
      {required this.userName,
      required this.code,
      required this.id,
      this.type = WSAuthCommand.TYPE});
  factory _WSAuthCommand.fromJson(Map<String, dynamic> json) =>
      _$WSAuthCommandFromJson(json);

  @override
  final String userName;
  @override
  final String code;
  @override
  final int id;
  @override
  @JsonKey()
  final String type;

  /// Create a copy of WSAuthCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WSAuthCommandCopyWith<_WSAuthCommand> get copyWith =>
      __$WSAuthCommandCopyWithImpl<_WSAuthCommand>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WSAuthCommandToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WSAuthCommand &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userName, code, id, type);

  @override
  String toString() {
    return 'WSAuthCommand(userName: $userName, code: $code, id: $id, type: $type)';
  }
}

/// @nodoc
abstract mixin class _$WSAuthCommandCopyWith<$Res>
    implements $WSAuthCommandCopyWith<$Res> {
  factory _$WSAuthCommandCopyWith(
          _WSAuthCommand value, $Res Function(_WSAuthCommand) _then) =
      __$WSAuthCommandCopyWithImpl;
  @override
  @useResult
  $Res call({String userName, String code, int id, String type});
}

/// @nodoc
class __$WSAuthCommandCopyWithImpl<$Res>
    implements _$WSAuthCommandCopyWith<$Res> {
  __$WSAuthCommandCopyWithImpl(this._self, this._then);

  final _WSAuthCommand _self;
  final $Res Function(_WSAuthCommand) _then;

  /// Create a copy of WSAuthCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? userName = null,
    Object? code = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_WSAuthCommand(
      userName: null == userName
          ? _self.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$WSSendRpcCommand {
  ///TODO: FIX it
//required RpcCommand command,
  Object get commandData; //WebSocketCommand.generateId()
  int get id;
  String get type;

  /// Create a copy of WSSendRpcCommand
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WSSendRpcCommandCopyWith<WSSendRpcCommand> get copyWith =>
      _$WSSendRpcCommandCopyWithImpl<WSSendRpcCommand>(
          this as WSSendRpcCommand, _$identity);

  /// Serializes this WSSendRpcCommand to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WSSendRpcCommand &&
            const DeepCollectionEquality()
                .equals(other.commandData, commandData) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(commandData), id, type);

  @override
  String toString() {
    return 'WSSendRpcCommand(commandData: $commandData, id: $id, type: $type)';
  }
}

/// @nodoc
abstract mixin class $WSSendRpcCommandCopyWith<$Res> {
  factory $WSSendRpcCommandCopyWith(
          WSSendRpcCommand value, $Res Function(WSSendRpcCommand) _then) =
      _$WSSendRpcCommandCopyWithImpl;
  @useResult
  $Res call({Object commandData, int id, String type});
}

/// @nodoc
class _$WSSendRpcCommandCopyWithImpl<$Res>
    implements $WSSendRpcCommandCopyWith<$Res> {
  _$WSSendRpcCommandCopyWithImpl(this._self, this._then);

  final WSSendRpcCommand _self;
  final $Res Function(WSSendRpcCommand) _then;

  /// Create a copy of WSSendRpcCommand
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? commandData = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_self.copyWith(
      commandData: null == commandData ? _self.commandData : commandData,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _WSSendRpcCommand implements WSSendRpcCommand {
  const _WSSendRpcCommand(
      {required this.commandData,
      required this.id,
      this.type = WSSendRpcCommand.TYPE});
  factory _WSSendRpcCommand.fromJson(Map<String, dynamic> json) =>
      _$WSSendRpcCommandFromJson(json);

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

  /// Create a copy of WSSendRpcCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WSSendRpcCommandCopyWith<_WSSendRpcCommand> get copyWith =>
      __$WSSendRpcCommandCopyWithImpl<_WSSendRpcCommand>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WSSendRpcCommandToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WSSendRpcCommand &&
            const DeepCollectionEquality()
                .equals(other.commandData, commandData) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(commandData), id, type);

  @override
  String toString() {
    return 'WSSendRpcCommand(commandData: $commandData, id: $id, type: $type)';
  }
}

/// @nodoc
abstract mixin class _$WSSendRpcCommandCopyWith<$Res>
    implements $WSSendRpcCommandCopyWith<$Res> {
  factory _$WSSendRpcCommandCopyWith(
          _WSSendRpcCommand value, $Res Function(_WSSendRpcCommand) _then) =
      __$WSSendRpcCommandCopyWithImpl;
  @override
  @useResult
  $Res call({Object commandData, int id, String type});
}

/// @nodoc
class __$WSSendRpcCommandCopyWithImpl<$Res>
    implements _$WSSendRpcCommandCopyWith<$Res> {
  __$WSSendRpcCommandCopyWithImpl(this._self, this._then);

  final _WSSendRpcCommand _self;
  final $Res Function(_WSSendRpcCommand) _then;

  /// Create a copy of WSSendRpcCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? commandData = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_WSSendRpcCommand(
      commandData: null == commandData ? _self.commandData : commandData,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$WSRpcResult {
  ///TODO: FIX it
//required RpcResult result,
  Object get resultData;
  int get id;

  /// Create a copy of WSRpcResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WSRpcResultCopyWith<WSRpcResult> get copyWith =>
      _$WSRpcResultCopyWithImpl<WSRpcResult>(this as WSRpcResult, _$identity);

  /// Serializes this WSRpcResult to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WSRpcResult &&
            const DeepCollectionEquality()
                .equals(other.resultData, resultData) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(resultData), id);

  @override
  String toString() {
    return 'WSRpcResult(resultData: $resultData, id: $id)';
  }
}

/// @nodoc
abstract mixin class $WSRpcResultCopyWith<$Res> {
  factory $WSRpcResultCopyWith(
          WSRpcResult value, $Res Function(WSRpcResult) _then) =
      _$WSRpcResultCopyWithImpl;
  @useResult
  $Res call({Object resultData, int id});
}

/// @nodoc
class _$WSRpcResultCopyWithImpl<$Res> implements $WSRpcResultCopyWith<$Res> {
  _$WSRpcResultCopyWithImpl(this._self, this._then);

  final WSRpcResult _self;
  final $Res Function(WSRpcResult) _then;

  /// Create a copy of WSRpcResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resultData = null,
    Object? id = null,
  }) {
    return _then(_self.copyWith(
      resultData: null == resultData ? _self.resultData : resultData,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _WSRpcResult implements WSRpcResult {
  const _WSRpcResult({required this.resultData, required this.id});
  factory _WSRpcResult.fromJson(Map<String, dynamic> json) =>
      _$WSRpcResultFromJson(json);

  ///TODO: FIX it
//required RpcResult result,
  @override
  final Object resultData;
  @override
  final int id;

  /// Create a copy of WSRpcResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WSRpcResultCopyWith<_WSRpcResult> get copyWith =>
      __$WSRpcResultCopyWithImpl<_WSRpcResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WSRpcResultToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WSRpcResult &&
            const DeepCollectionEquality()
                .equals(other.resultData, resultData) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(resultData), id);

  @override
  String toString() {
    return 'WSRpcResult(resultData: $resultData, id: $id)';
  }
}

/// @nodoc
abstract mixin class _$WSRpcResultCopyWith<$Res>
    implements $WSRpcResultCopyWith<$Res> {
  factory _$WSRpcResultCopyWith(
          _WSRpcResult value, $Res Function(_WSRpcResult) _then) =
      __$WSRpcResultCopyWithImpl;
  @override
  @useResult
  $Res call({Object resultData, int id});
}

/// @nodoc
class __$WSRpcResultCopyWithImpl<$Res> implements _$WSRpcResultCopyWith<$Res> {
  __$WSRpcResultCopyWithImpl(this._self, this._then);

  final _WSRpcResult _self;
  final $Res Function(_WSRpcResult) _then;

  /// Create a copy of WSRpcResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? resultData = null,
    Object? id = null,
  }) {
    return _then(_WSRpcResult(
      resultData: null == resultData ? _self.resultData : resultData,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$WSConfigDownloadCommand {
  int get id;
  String get type;

  /// Create a copy of WSConfigDownloadCommand
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WSConfigDownloadCommandCopyWith<WSConfigDownloadCommand> get copyWith =>
      _$WSConfigDownloadCommandCopyWithImpl<WSConfigDownloadCommand>(
          this as WSConfigDownloadCommand, _$identity);

  /// Serializes this WSConfigDownloadCommand to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WSConfigDownloadCommand &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, type);

  @override
  String toString() {
    return 'WSConfigDownloadCommand(id: $id, type: $type)';
  }
}

/// @nodoc
abstract mixin class $WSConfigDownloadCommandCopyWith<$Res> {
  factory $WSConfigDownloadCommandCopyWith(WSConfigDownloadCommand value,
          $Res Function(WSConfigDownloadCommand) _then) =
      _$WSConfigDownloadCommandCopyWithImpl;
  @useResult
  $Res call({int id, String type});
}

/// @nodoc
class _$WSConfigDownloadCommandCopyWithImpl<$Res>
    implements $WSConfigDownloadCommandCopyWith<$Res> {
  _$WSConfigDownloadCommandCopyWithImpl(this._self, this._then);

  final WSConfigDownloadCommand _self;
  final $Res Function(WSConfigDownloadCommand) _then;

  /// Create a copy of WSConfigDownloadCommand
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _WSConfigDownloadCommand implements WSConfigDownloadCommand {
  const _WSConfigDownloadCommand(
      {required this.id, this.type = WSConfigDownloadCommand.TYPE});
  factory _WSConfigDownloadCommand.fromJson(Map<String, dynamic> json) =>
      _$WSConfigDownloadCommandFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final String type;

  /// Create a copy of WSConfigDownloadCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WSConfigDownloadCommandCopyWith<_WSConfigDownloadCommand> get copyWith =>
      __$WSConfigDownloadCommandCopyWithImpl<_WSConfigDownloadCommand>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WSConfigDownloadCommandToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WSConfigDownloadCommand &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, type);

  @override
  String toString() {
    return 'WSConfigDownloadCommand(id: $id, type: $type)';
  }
}

/// @nodoc
abstract mixin class _$WSConfigDownloadCommandCopyWith<$Res>
    implements $WSConfigDownloadCommandCopyWith<$Res> {
  factory _$WSConfigDownloadCommandCopyWith(_WSConfigDownloadCommand value,
          $Res Function(_WSConfigDownloadCommand) _then) =
      __$WSConfigDownloadCommandCopyWithImpl;
  @override
  @useResult
  $Res call({int id, String type});
}

/// @nodoc
class __$WSConfigDownloadCommandCopyWithImpl<$Res>
    implements _$WSConfigDownloadCommandCopyWith<$Res> {
  __$WSConfigDownloadCommandCopyWithImpl(this._self, this._then);

  final _WSConfigDownloadCommand _self;
  final $Res Function(_WSConfigDownloadCommand) _then;

  /// Create a copy of WSConfigDownloadCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_WSConfigDownloadCommand(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$WSConfigUploadCommand {
  String get content;
  int get id;
  String get type;

  /// Create a copy of WSConfigUploadCommand
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WSConfigUploadCommandCopyWith<WSConfigUploadCommand> get copyWith =>
      _$WSConfigUploadCommandCopyWithImpl<WSConfigUploadCommand>(
          this as WSConfigUploadCommand, _$identity);

  /// Serializes this WSConfigUploadCommand to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WSConfigUploadCommand &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, content, id, type);

  @override
  String toString() {
    return 'WSConfigUploadCommand(content: $content, id: $id, type: $type)';
  }
}

/// @nodoc
abstract mixin class $WSConfigUploadCommandCopyWith<$Res> {
  factory $WSConfigUploadCommandCopyWith(WSConfigUploadCommand value,
          $Res Function(WSConfigUploadCommand) _then) =
      _$WSConfigUploadCommandCopyWithImpl;
  @useResult
  $Res call({String content, int id, String type});
}

/// @nodoc
class _$WSConfigUploadCommandCopyWithImpl<$Res>
    implements $WSConfigUploadCommandCopyWith<$Res> {
  _$WSConfigUploadCommandCopyWithImpl(this._self, this._then);

  final WSConfigUploadCommand _self;
  final $Res Function(WSConfigUploadCommand) _then;

  /// Create a copy of WSConfigUploadCommand
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_self.copyWith(
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _WSConfigUploadCommand implements WSConfigUploadCommand {
  const _WSConfigUploadCommand(
      {required this.content,
      required this.id,
      this.type = WSConfigUploadCommand.TYPE});
  factory _WSConfigUploadCommand.fromJson(Map<String, dynamic> json) =>
      _$WSConfigUploadCommandFromJson(json);

  @override
  final String content;
  @override
  final int id;
  @override
  @JsonKey()
  final String type;

  /// Create a copy of WSConfigUploadCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WSConfigUploadCommandCopyWith<_WSConfigUploadCommand> get copyWith =>
      __$WSConfigUploadCommandCopyWithImpl<_WSConfigUploadCommand>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WSConfigUploadCommandToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WSConfigUploadCommand &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, content, id, type);

  @override
  String toString() {
    return 'WSConfigUploadCommand(content: $content, id: $id, type: $type)';
  }
}

/// @nodoc
abstract mixin class _$WSConfigUploadCommandCopyWith<$Res>
    implements $WSConfigUploadCommandCopyWith<$Res> {
  factory _$WSConfigUploadCommandCopyWith(_WSConfigUploadCommand value,
          $Res Function(_WSConfigUploadCommand) _then) =
      __$WSConfigUploadCommandCopyWithImpl;
  @override
  @useResult
  $Res call({String content, int id, String type});
}

/// @nodoc
class __$WSConfigUploadCommandCopyWithImpl<$Res>
    implements _$WSConfigUploadCommandCopyWith<$Res> {
  __$WSConfigUploadCommandCopyWithImpl(this._self, this._then);

  final _WSConfigUploadCommand _self;
  final $Res Function(_WSConfigUploadCommand) _then;

  /// Create a copy of WSConfigUploadCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? content = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_WSConfigUploadCommand(
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$WSConfigDownloadResult {
  String get content;
  int get id;

  /// Create a copy of WSConfigDownloadResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WSConfigDownloadResultCopyWith<WSConfigDownloadResult> get copyWith =>
      _$WSConfigDownloadResultCopyWithImpl<WSConfigDownloadResult>(
          this as WSConfigDownloadResult, _$identity);

  /// Serializes this WSConfigDownloadResult to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WSConfigDownloadResult &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, content, id);

  @override
  String toString() {
    return 'WSConfigDownloadResult(content: $content, id: $id)';
  }
}

/// @nodoc
abstract mixin class $WSConfigDownloadResultCopyWith<$Res> {
  factory $WSConfigDownloadResultCopyWith(WSConfigDownloadResult value,
          $Res Function(WSConfigDownloadResult) _then) =
      _$WSConfigDownloadResultCopyWithImpl;
  @useResult
  $Res call({String content, int id});
}

/// @nodoc
class _$WSConfigDownloadResultCopyWithImpl<$Res>
    implements $WSConfigDownloadResultCopyWith<$Res> {
  _$WSConfigDownloadResultCopyWithImpl(this._self, this._then);

  final WSConfigDownloadResult _self;
  final $Res Function(WSConfigDownloadResult) _then;

  /// Create a copy of WSConfigDownloadResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
    Object? id = null,
  }) {
    return _then(_self.copyWith(
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _WSConfigDownloadResult implements WSConfigDownloadResult {
  const _WSConfigDownloadResult({required this.content, required this.id});
  factory _WSConfigDownloadResult.fromJson(Map<String, dynamic> json) =>
      _$WSConfigDownloadResultFromJson(json);

  @override
  final String content;
  @override
  final int id;

  /// Create a copy of WSConfigDownloadResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WSConfigDownloadResultCopyWith<_WSConfigDownloadResult> get copyWith =>
      __$WSConfigDownloadResultCopyWithImpl<_WSConfigDownloadResult>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WSConfigDownloadResultToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WSConfigDownloadResult &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, content, id);

  @override
  String toString() {
    return 'WSConfigDownloadResult(content: $content, id: $id)';
  }
}

/// @nodoc
abstract mixin class _$WSConfigDownloadResultCopyWith<$Res>
    implements $WSConfigDownloadResultCopyWith<$Res> {
  factory _$WSConfigDownloadResultCopyWith(_WSConfigDownloadResult value,
          $Res Function(_WSConfigDownloadResult) _then) =
      __$WSConfigDownloadResultCopyWithImpl;
  @override
  @useResult
  $Res call({String content, int id});
}

/// @nodoc
class __$WSConfigDownloadResultCopyWithImpl<$Res>
    implements _$WSConfigDownloadResultCopyWith<$Res> {
  __$WSConfigDownloadResultCopyWithImpl(this._self, this._then);

  final _WSConfigDownloadResult _self;
  final $Res Function(_WSConfigDownloadResult) _then;

  /// Create a copy of WSConfigDownloadResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? content = null,
    Object? id = null,
  }) {
    return _then(_WSConfigDownloadResult(
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$WSRestartApplicationCommand {
  int get id;
  String get type;

  /// Create a copy of WSRestartApplicationCommand
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WSRestartApplicationCommandCopyWith<WSRestartApplicationCommand>
      get copyWith => _$WSRestartApplicationCommandCopyWithImpl<
              WSRestartApplicationCommand>(
          this as WSRestartApplicationCommand, _$identity);

  /// Serializes this WSRestartApplicationCommand to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WSRestartApplicationCommand &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, type);

  @override
  String toString() {
    return 'WSRestartApplicationCommand(id: $id, type: $type)';
  }
}

/// @nodoc
abstract mixin class $WSRestartApplicationCommandCopyWith<$Res> {
  factory $WSRestartApplicationCommandCopyWith(
          WSRestartApplicationCommand value,
          $Res Function(WSRestartApplicationCommand) _then) =
      _$WSRestartApplicationCommandCopyWithImpl;
  @useResult
  $Res call({int id, String type});
}

/// @nodoc
class _$WSRestartApplicationCommandCopyWithImpl<$Res>
    implements $WSRestartApplicationCommandCopyWith<$Res> {
  _$WSRestartApplicationCommandCopyWithImpl(this._self, this._then);

  final WSRestartApplicationCommand _self;
  final $Res Function(WSRestartApplicationCommand) _then;

  /// Create a copy of WSRestartApplicationCommand
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _WSRestartApplicationCommand implements WSRestartApplicationCommand {
  const _WSRestartApplicationCommand(
      {required this.id, this.type = WSRestartApplicationCommand.TYPE});
  factory _WSRestartApplicationCommand.fromJson(Map<String, dynamic> json) =>
      _$WSRestartApplicationCommandFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final String type;

  /// Create a copy of WSRestartApplicationCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WSRestartApplicationCommandCopyWith<_WSRestartApplicationCommand>
      get copyWith => __$WSRestartApplicationCommandCopyWithImpl<
          _WSRestartApplicationCommand>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WSRestartApplicationCommandToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WSRestartApplicationCommand &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, type);

  @override
  String toString() {
    return 'WSRestartApplicationCommand(id: $id, type: $type)';
  }
}

/// @nodoc
abstract mixin class _$WSRestartApplicationCommandCopyWith<$Res>
    implements $WSRestartApplicationCommandCopyWith<$Res> {
  factory _$WSRestartApplicationCommandCopyWith(
          _WSRestartApplicationCommand value,
          $Res Function(_WSRestartApplicationCommand) _then) =
      __$WSRestartApplicationCommandCopyWithImpl;
  @override
  @useResult
  $Res call({int id, String type});
}

/// @nodoc
class __$WSRestartApplicationCommandCopyWithImpl<$Res>
    implements _$WSRestartApplicationCommandCopyWith<$Res> {
  __$WSRestartApplicationCommandCopyWithImpl(this._self, this._then);

  final _WSRestartApplicationCommand _self;
  final $Res Function(_WSRestartApplicationCommand) _then;

  /// Create a copy of WSRestartApplicationCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_WSRestartApplicationCommand(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$WSResultOk {
  int get id;

  /// Create a copy of WSResultOk
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WSResultOkCopyWith<WSResultOk> get copyWith =>
      _$WSResultOkCopyWithImpl<WSResultOk>(this as WSResultOk, _$identity);

  /// Serializes this WSResultOk to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WSResultOk &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id);

  @override
  String toString() {
    return 'WSResultOk(id: $id)';
  }
}

/// @nodoc
abstract mixin class $WSResultOkCopyWith<$Res> {
  factory $WSResultOkCopyWith(
          WSResultOk value, $Res Function(WSResultOk) _then) =
      _$WSResultOkCopyWithImpl;
  @useResult
  $Res call({int id});
}

/// @nodoc
class _$WSResultOkCopyWithImpl<$Res> implements $WSResultOkCopyWith<$Res> {
  _$WSResultOkCopyWithImpl(this._self, this._then);

  final WSResultOk _self;
  final $Res Function(WSResultOk) _then;

  /// Create a copy of WSResultOk
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _WSResultOk implements WSResultOk {
  const _WSResultOk({required this.id});
  factory _WSResultOk.fromJson(Map<String, dynamic> json) =>
      _$WSResultOkFromJson(json);

  @override
  final int id;

  /// Create a copy of WSResultOk
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WSResultOkCopyWith<_WSResultOk> get copyWith =>
      __$WSResultOkCopyWithImpl<_WSResultOk>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WSResultOkToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WSResultOk &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id);

  @override
  String toString() {
    return 'WSResultOk(id: $id)';
  }
}

/// @nodoc
abstract mixin class _$WSResultOkCopyWith<$Res>
    implements $WSResultOkCopyWith<$Res> {
  factory _$WSResultOkCopyWith(
          _WSResultOk value, $Res Function(_WSResultOk) _then) =
      __$WSResultOkCopyWithImpl;
  @override
  @useResult
  $Res call({int id});
}

/// @nodoc
class __$WSResultOkCopyWithImpl<$Res> implements _$WSResultOkCopyWith<$Res> {
  __$WSResultOkCopyWithImpl(this._self, this._then);

  final _WSResultOk _self;
  final $Res Function(_WSResultOk) _then;

  /// Create a copy of WSResultOk
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
  }) {
    return _then(_WSResultOk(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$WSEchoResult {
  String get msg;
  int get id;

  /// Create a copy of WSEchoResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WSEchoResultCopyWith<WSEchoResult> get copyWith =>
      _$WSEchoResultCopyWithImpl<WSEchoResult>(
          this as WSEchoResult, _$identity);

  /// Serializes this WSEchoResult to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WSEchoResult &&
            (identical(other.msg, msg) || other.msg == msg) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, msg, id);

  @override
  String toString() {
    return 'WSEchoResult(msg: $msg, id: $id)';
  }
}

/// @nodoc
abstract mixin class $WSEchoResultCopyWith<$Res> {
  factory $WSEchoResultCopyWith(
          WSEchoResult value, $Res Function(WSEchoResult) _then) =
      _$WSEchoResultCopyWithImpl;
  @useResult
  $Res call({String msg, int id});
}

/// @nodoc
class _$WSEchoResultCopyWithImpl<$Res> implements $WSEchoResultCopyWith<$Res> {
  _$WSEchoResultCopyWithImpl(this._self, this._then);

  final WSEchoResult _self;
  final $Res Function(WSEchoResult) _then;

  /// Create a copy of WSEchoResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? msg = null,
    Object? id = null,
  }) {
    return _then(_self.copyWith(
      msg: null == msg
          ? _self.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _WSEchoResult implements WSEchoResult {
  const _WSEchoResult({required this.msg, required this.id});
  factory _WSEchoResult.fromJson(Map<String, dynamic> json) =>
      _$WSEchoResultFromJson(json);

  @override
  final String msg;
  @override
  final int id;

  /// Create a copy of WSEchoResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WSEchoResultCopyWith<_WSEchoResult> get copyWith =>
      __$WSEchoResultCopyWithImpl<_WSEchoResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WSEchoResultToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WSEchoResult &&
            (identical(other.msg, msg) || other.msg == msg) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, msg, id);

  @override
  String toString() {
    return 'WSEchoResult(msg: $msg, id: $id)';
  }
}

/// @nodoc
abstract mixin class _$WSEchoResultCopyWith<$Res>
    implements $WSEchoResultCopyWith<$Res> {
  factory _$WSEchoResultCopyWith(
          _WSEchoResult value, $Res Function(_WSEchoResult) _then) =
      __$WSEchoResultCopyWithImpl;
  @override
  @useResult
  $Res call({String msg, int id});
}

/// @nodoc
class __$WSEchoResultCopyWithImpl<$Res>
    implements _$WSEchoResultCopyWith<$Res> {
  __$WSEchoResultCopyWithImpl(this._self, this._then);

  final _WSEchoResult _self;
  final $Res Function(_WSEchoResult) _then;

  /// Create a copy of WSEchoResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? msg = null,
    Object? id = null,
  }) {
    return _then(_WSEchoResult(
      msg: null == msg
          ? _self.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$WSEchoCommand {
  String get msg;
  int get id;
  String get type;

  /// Create a copy of WSEchoCommand
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WSEchoCommandCopyWith<WSEchoCommand> get copyWith =>
      _$WSEchoCommandCopyWithImpl<WSEchoCommand>(
          this as WSEchoCommand, _$identity);

  /// Serializes this WSEchoCommand to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WSEchoCommand &&
            (identical(other.msg, msg) || other.msg == msg) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, msg, id, type);

  @override
  String toString() {
    return 'WSEchoCommand(msg: $msg, id: $id, type: $type)';
  }
}

/// @nodoc
abstract mixin class $WSEchoCommandCopyWith<$Res> {
  factory $WSEchoCommandCopyWith(
          WSEchoCommand value, $Res Function(WSEchoCommand) _then) =
      _$WSEchoCommandCopyWithImpl;
  @useResult
  $Res call({String msg, int id, String type});
}

/// @nodoc
class _$WSEchoCommandCopyWithImpl<$Res>
    implements $WSEchoCommandCopyWith<$Res> {
  _$WSEchoCommandCopyWithImpl(this._self, this._then);

  final WSEchoCommand _self;
  final $Res Function(WSEchoCommand) _then;

  /// Create a copy of WSEchoCommand
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? msg = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_self.copyWith(
      msg: null == msg
          ? _self.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _WSEchoCommand implements WSEchoCommand {
  const _WSEchoCommand(
      {required this.msg, required this.id, this.type = WSEchoCommand.TYPE});
  factory _WSEchoCommand.fromJson(Map<String, dynamic> json) =>
      _$WSEchoCommandFromJson(json);

  @override
  final String msg;
  @override
  final int id;
  @override
  @JsonKey()
  final String type;

  /// Create a copy of WSEchoCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WSEchoCommandCopyWith<_WSEchoCommand> get copyWith =>
      __$WSEchoCommandCopyWithImpl<_WSEchoCommand>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WSEchoCommandToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WSEchoCommand &&
            (identical(other.msg, msg) || other.msg == msg) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, msg, id, type);

  @override
  String toString() {
    return 'WSEchoCommand(msg: $msg, id: $id, type: $type)';
  }
}

/// @nodoc
abstract mixin class _$WSEchoCommandCopyWith<$Res>
    implements $WSEchoCommandCopyWith<$Res> {
  factory _$WSEchoCommandCopyWith(
          _WSEchoCommand value, $Res Function(_WSEchoCommand) _then) =
      __$WSEchoCommandCopyWithImpl;
  @override
  @useResult
  $Res call({String msg, int id, String type});
}

/// @nodoc
class __$WSEchoCommandCopyWithImpl<$Res>
    implements _$WSEchoCommandCopyWith<$Res> {
  __$WSEchoCommandCopyWithImpl(this._self, this._then);

  final _WSEchoCommand _self;
  final $Res Function(_WSEchoCommand) _then;

  /// Create a copy of WSEchoCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? msg = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_WSEchoCommand(
      msg: null == msg
          ? _self.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
