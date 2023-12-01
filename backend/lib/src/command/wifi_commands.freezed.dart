// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wifi_commands.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WiFiScanCommand _$WiFiScanCommandFromJson(Map<String, dynamic> json) {
  return _WiFiScanCommand.fromJson(json);
}

/// @nodoc
mixin _$WiFiScanCommand {
  int get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WiFiScanCommandCopyWith<WiFiScanCommand> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WiFiScanCommandCopyWith<$Res> {
  factory $WiFiScanCommandCopyWith(
          WiFiScanCommand value, $Res Function(WiFiScanCommand) then) =
      _$WiFiScanCommandCopyWithImpl<$Res, WiFiScanCommand>;
  @useResult
  $Res call({int id, String type});
}

/// @nodoc
class _$WiFiScanCommandCopyWithImpl<$Res, $Val extends WiFiScanCommand>
    implements $WiFiScanCommandCopyWith<$Res> {
  _$WiFiScanCommandCopyWithImpl(this._value, this._then);

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
abstract class _$$WiFiScanCommandImplCopyWith<$Res>
    implements $WiFiScanCommandCopyWith<$Res> {
  factory _$$WiFiScanCommandImplCopyWith(_$WiFiScanCommandImpl value,
          $Res Function(_$WiFiScanCommandImpl) then) =
      __$$WiFiScanCommandImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String type});
}

/// @nodoc
class __$$WiFiScanCommandImplCopyWithImpl<$Res>
    extends _$WiFiScanCommandCopyWithImpl<$Res, _$WiFiScanCommandImpl>
    implements _$$WiFiScanCommandImplCopyWith<$Res> {
  __$$WiFiScanCommandImplCopyWithImpl(
      _$WiFiScanCommandImpl _value, $Res Function(_$WiFiScanCommandImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_$WiFiScanCommandImpl(
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
class _$WiFiScanCommandImpl implements _WiFiScanCommand {
  const _$WiFiScanCommandImpl(
      {required this.id, this.type = WiFiScanCommand.TYPE});

  factory _$WiFiScanCommandImpl.fromJson(Map<String, dynamic> json) =>
      _$$WiFiScanCommandImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final String type;

  @override
  String toString() {
    return 'WiFiScanCommand(id: $id, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WiFiScanCommandImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WiFiScanCommandImplCopyWith<_$WiFiScanCommandImpl> get copyWith =>
      __$$WiFiScanCommandImplCopyWithImpl<_$WiFiScanCommandImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WiFiScanCommandImplToJson(
      this,
    );
  }
}

abstract class _WiFiScanCommand implements WiFiScanCommand {
  const factory _WiFiScanCommand({required final int id, final String type}) =
      _$WiFiScanCommandImpl;

  factory _WiFiScanCommand.fromJson(Map<String, dynamic> json) =
      _$WiFiScanCommandImpl.fromJson;

  @override
  int get id;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$WiFiScanCommandImplCopyWith<_$WiFiScanCommandImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WiFiScanResult _$WiFiScanResultFromJson(Map<String, dynamic> json) {
  return _WiFiScanResult.fromJson(json);
}

/// @nodoc
mixin _$WiFiScanResult {
  List<WiFiNetworkInfo> get networks => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WiFiScanResultCopyWith<WiFiScanResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WiFiScanResultCopyWith<$Res> {
  factory $WiFiScanResultCopyWith(
          WiFiScanResult value, $Res Function(WiFiScanResult) then) =
      _$WiFiScanResultCopyWithImpl<$Res, WiFiScanResult>;
  @useResult
  $Res call({List<WiFiNetworkInfo> networks, int id});
}

/// @nodoc
class _$WiFiScanResultCopyWithImpl<$Res, $Val extends WiFiScanResult>
    implements $WiFiScanResultCopyWith<$Res> {
  _$WiFiScanResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? networks = null,
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      networks: null == networks
          ? _value.networks
          : networks // ignore: cast_nullable_to_non_nullable
              as List<WiFiNetworkInfo>,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WiFiScanResultImplCopyWith<$Res>
    implements $WiFiScanResultCopyWith<$Res> {
  factory _$$WiFiScanResultImplCopyWith(_$WiFiScanResultImpl value,
          $Res Function(_$WiFiScanResultImpl) then) =
      __$$WiFiScanResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<WiFiNetworkInfo> networks, int id});
}

/// @nodoc
class __$$WiFiScanResultImplCopyWithImpl<$Res>
    extends _$WiFiScanResultCopyWithImpl<$Res, _$WiFiScanResultImpl>
    implements _$$WiFiScanResultImplCopyWith<$Res> {
  __$$WiFiScanResultImplCopyWithImpl(
      _$WiFiScanResultImpl _value, $Res Function(_$WiFiScanResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? networks = null,
    Object? id = null,
  }) {
    return _then(_$WiFiScanResultImpl(
      networks: null == networks
          ? _value._networks
          : networks // ignore: cast_nullable_to_non_nullable
              as List<WiFiNetworkInfo>,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WiFiScanResultImpl implements _WiFiScanResult {
  const _$WiFiScanResultImpl(
      {required final List<WiFiNetworkInfo> networks, required this.id})
      : _networks = networks;

  factory _$WiFiScanResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$WiFiScanResultImplFromJson(json);

  final List<WiFiNetworkInfo> _networks;
  @override
  List<WiFiNetworkInfo> get networks {
    if (_networks is EqualUnmodifiableListView) return _networks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_networks);
  }

  @override
  final int id;

  @override
  String toString() {
    return 'WiFiScanResult(networks: $networks, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WiFiScanResultImpl &&
            const DeepCollectionEquality().equals(other._networks, _networks) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_networks), id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WiFiScanResultImplCopyWith<_$WiFiScanResultImpl> get copyWith =>
      __$$WiFiScanResultImplCopyWithImpl<_$WiFiScanResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WiFiScanResultImplToJson(
      this,
    );
  }
}

abstract class _WiFiScanResult implements WiFiScanResult {
  const factory _WiFiScanResult(
      {required final List<WiFiNetworkInfo> networks,
      required final int id}) = _$WiFiScanResultImpl;

  factory _WiFiScanResult.fromJson(Map<String, dynamic> json) =
      _$WiFiScanResultImpl.fromJson;

  @override
  List<WiFiNetworkInfo> get networks;
  @override
  int get id;
  @override
  @JsonKey(ignore: true)
  _$$WiFiScanResultImplCopyWith<_$WiFiScanResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WiFiNetworkInfo _$WiFiNetworkInfoFromJson(Map<String, dynamic> json) {
  return _WiFiNetworkInfo.fromJson(json);
}

/// @nodoc
mixin _$WiFiNetworkInfo {
  String get SSID => throw _privateConstructorUsedError;
  int get signal => throw _privateConstructorUsedError;
  String get capability => throw _privateConstructorUsedError;
  int get freq => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WiFiNetworkInfoCopyWith<WiFiNetworkInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WiFiNetworkInfoCopyWith<$Res> {
  factory $WiFiNetworkInfoCopyWith(
          WiFiNetworkInfo value, $Res Function(WiFiNetworkInfo) then) =
      _$WiFiNetworkInfoCopyWithImpl<$Res, WiFiNetworkInfo>;
  @useResult
  $Res call({String SSID, int signal, String capability, int freq});
}

/// @nodoc
class _$WiFiNetworkInfoCopyWithImpl<$Res, $Val extends WiFiNetworkInfo>
    implements $WiFiNetworkInfoCopyWith<$Res> {
  _$WiFiNetworkInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? SSID = null,
    Object? signal = null,
    Object? capability = null,
    Object? freq = null,
  }) {
    return _then(_value.copyWith(
      SSID: null == SSID
          ? _value.SSID
          : SSID // ignore: cast_nullable_to_non_nullable
              as String,
      signal: null == signal
          ? _value.signal
          : signal // ignore: cast_nullable_to_non_nullable
              as int,
      capability: null == capability
          ? _value.capability
          : capability // ignore: cast_nullable_to_non_nullable
              as String,
      freq: null == freq
          ? _value.freq
          : freq // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WiFiNetworkInfoImplCopyWith<$Res>
    implements $WiFiNetworkInfoCopyWith<$Res> {
  factory _$$WiFiNetworkInfoImplCopyWith(_$WiFiNetworkInfoImpl value,
          $Res Function(_$WiFiNetworkInfoImpl) then) =
      __$$WiFiNetworkInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String SSID, int signal, String capability, int freq});
}

/// @nodoc
class __$$WiFiNetworkInfoImplCopyWithImpl<$Res>
    extends _$WiFiNetworkInfoCopyWithImpl<$Res, _$WiFiNetworkInfoImpl>
    implements _$$WiFiNetworkInfoImplCopyWith<$Res> {
  __$$WiFiNetworkInfoImplCopyWithImpl(
      _$WiFiNetworkInfoImpl _value, $Res Function(_$WiFiNetworkInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? SSID = null,
    Object? signal = null,
    Object? capability = null,
    Object? freq = null,
  }) {
    return _then(_$WiFiNetworkInfoImpl(
      SSID: null == SSID
          ? _value.SSID
          : SSID // ignore: cast_nullable_to_non_nullable
              as String,
      signal: null == signal
          ? _value.signal
          : signal // ignore: cast_nullable_to_non_nullable
              as int,
      capability: null == capability
          ? _value.capability
          : capability // ignore: cast_nullable_to_non_nullable
              as String,
      freq: null == freq
          ? _value.freq
          : freq // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WiFiNetworkInfoImpl implements _WiFiNetworkInfo {
  const _$WiFiNetworkInfoImpl(
      {required this.SSID,
      required this.signal,
      required this.capability,
      required this.freq});

  factory _$WiFiNetworkInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$WiFiNetworkInfoImplFromJson(json);

  @override
  final String SSID;
  @override
  final int signal;
  @override
  final String capability;
  @override
  final int freq;

  @override
  String toString() {
    return 'WiFiNetworkInfo(SSID: $SSID, signal: $signal, capability: $capability, freq: $freq)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WiFiNetworkInfoImpl &&
            (identical(other.SSID, SSID) || other.SSID == SSID) &&
            (identical(other.signal, signal) || other.signal == signal) &&
            (identical(other.capability, capability) ||
                other.capability == capability) &&
            (identical(other.freq, freq) || other.freq == freq));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, SSID, signal, capability, freq);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WiFiNetworkInfoImplCopyWith<_$WiFiNetworkInfoImpl> get copyWith =>
      __$$WiFiNetworkInfoImplCopyWithImpl<_$WiFiNetworkInfoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WiFiNetworkInfoImplToJson(
      this,
    );
  }
}

abstract class _WiFiNetworkInfo implements WiFiNetworkInfo {
  const factory _WiFiNetworkInfo(
      {required final String SSID,
      required final int signal,
      required final String capability,
      required final int freq}) = _$WiFiNetworkInfoImpl;

  factory _WiFiNetworkInfo.fromJson(Map<String, dynamic> json) =
      _$WiFiNetworkInfoImpl.fromJson;

  @override
  String get SSID;
  @override
  int get signal;
  @override
  String get capability;
  @override
  int get freq;
  @override
  @JsonKey(ignore: true)
  _$$WiFiNetworkInfoImplCopyWith<_$WiFiNetworkInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WiFiStoredNetworkInfo _$WiFiStoredNetworkInfoFromJson(
    Map<String, dynamic> json) {
  return _WiFiStoredNetworkInfo.fromJson(json);
}

/// @nodoc
mixin _$WiFiStoredNetworkInfo {
  int get id => throw _privateConstructorUsedError;
  String get SSID => throw _privateConstructorUsedError;
  bool get disabled => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WiFiStoredNetworkInfoCopyWith<WiFiStoredNetworkInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WiFiStoredNetworkInfoCopyWith<$Res> {
  factory $WiFiStoredNetworkInfoCopyWith(WiFiStoredNetworkInfo value,
          $Res Function(WiFiStoredNetworkInfo) then) =
      _$WiFiStoredNetworkInfoCopyWithImpl<$Res, WiFiStoredNetworkInfo>;
  @useResult
  $Res call({int id, String SSID, bool disabled});
}

/// @nodoc
class _$WiFiStoredNetworkInfoCopyWithImpl<$Res,
        $Val extends WiFiStoredNetworkInfo>
    implements $WiFiStoredNetworkInfoCopyWith<$Res> {
  _$WiFiStoredNetworkInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? SSID = null,
    Object? disabled = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      SSID: null == SSID
          ? _value.SSID
          : SSID // ignore: cast_nullable_to_non_nullable
              as String,
      disabled: null == disabled
          ? _value.disabled
          : disabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WiFiStoredNetworkInfoImplCopyWith<$Res>
    implements $WiFiStoredNetworkInfoCopyWith<$Res> {
  factory _$$WiFiStoredNetworkInfoImplCopyWith(
          _$WiFiStoredNetworkInfoImpl value,
          $Res Function(_$WiFiStoredNetworkInfoImpl) then) =
      __$$WiFiStoredNetworkInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String SSID, bool disabled});
}

/// @nodoc
class __$$WiFiStoredNetworkInfoImplCopyWithImpl<$Res>
    extends _$WiFiStoredNetworkInfoCopyWithImpl<$Res,
        _$WiFiStoredNetworkInfoImpl>
    implements _$$WiFiStoredNetworkInfoImplCopyWith<$Res> {
  __$$WiFiStoredNetworkInfoImplCopyWithImpl(_$WiFiStoredNetworkInfoImpl _value,
      $Res Function(_$WiFiStoredNetworkInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? SSID = null,
    Object? disabled = null,
  }) {
    return _then(_$WiFiStoredNetworkInfoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      SSID: null == SSID
          ? _value.SSID
          : SSID // ignore: cast_nullable_to_non_nullable
              as String,
      disabled: null == disabled
          ? _value.disabled
          : disabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WiFiStoredNetworkInfoImpl implements _WiFiStoredNetworkInfo {
  const _$WiFiStoredNetworkInfoImpl(
      {required this.id, required this.SSID, required this.disabled});

  factory _$WiFiStoredNetworkInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$WiFiStoredNetworkInfoImplFromJson(json);

  @override
  final int id;
  @override
  final String SSID;
  @override
  final bool disabled;

  @override
  String toString() {
    return 'WiFiStoredNetworkInfo(id: $id, SSID: $SSID, disabled: $disabled)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WiFiStoredNetworkInfoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.SSID, SSID) || other.SSID == SSID) &&
            (identical(other.disabled, disabled) ||
                other.disabled == disabled));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, SSID, disabled);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WiFiStoredNetworkInfoImplCopyWith<_$WiFiStoredNetworkInfoImpl>
      get copyWith => __$$WiFiStoredNetworkInfoImplCopyWithImpl<
          _$WiFiStoredNetworkInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WiFiStoredNetworkInfoImplToJson(
      this,
    );
  }
}

abstract class _WiFiStoredNetworkInfo implements WiFiStoredNetworkInfo {
  const factory _WiFiStoredNetworkInfo(
      {required final int id,
      required final String SSID,
      required final bool disabled}) = _$WiFiStoredNetworkInfoImpl;

  factory _WiFiStoredNetworkInfo.fromJson(Map<String, dynamic> json) =
      _$WiFiStoredNetworkInfoImpl.fromJson;

  @override
  int get id;
  @override
  String get SSID;
  @override
  bool get disabled;
  @override
  @JsonKey(ignore: true)
  _$$WiFiStoredNetworkInfoImplCopyWith<_$WiFiStoredNetworkInfoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

WiFiRemoveCommand _$WiFiRemoveCommandFromJson(Map<String, dynamic> json) {
  return _WiFiRemoveCommand.fromJson(json);
}

/// @nodoc
mixin _$WiFiRemoveCommand {
  int get wifiId => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WiFiRemoveCommandCopyWith<WiFiRemoveCommand> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WiFiRemoveCommandCopyWith<$Res> {
  factory $WiFiRemoveCommandCopyWith(
          WiFiRemoveCommand value, $Res Function(WiFiRemoveCommand) then) =
      _$WiFiRemoveCommandCopyWithImpl<$Res, WiFiRemoveCommand>;
  @useResult
  $Res call({int wifiId, int id, String type});
}

/// @nodoc
class _$WiFiRemoveCommandCopyWithImpl<$Res, $Val extends WiFiRemoveCommand>
    implements $WiFiRemoveCommandCopyWith<$Res> {
  _$WiFiRemoveCommandCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wifiId = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      wifiId: null == wifiId
          ? _value.wifiId
          : wifiId // ignore: cast_nullable_to_non_nullable
              as int,
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
abstract class _$$WiFiRemoveCommandImplCopyWith<$Res>
    implements $WiFiRemoveCommandCopyWith<$Res> {
  factory _$$WiFiRemoveCommandImplCopyWith(_$WiFiRemoveCommandImpl value,
          $Res Function(_$WiFiRemoveCommandImpl) then) =
      __$$WiFiRemoveCommandImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int wifiId, int id, String type});
}

/// @nodoc
class __$$WiFiRemoveCommandImplCopyWithImpl<$Res>
    extends _$WiFiRemoveCommandCopyWithImpl<$Res, _$WiFiRemoveCommandImpl>
    implements _$$WiFiRemoveCommandImplCopyWith<$Res> {
  __$$WiFiRemoveCommandImplCopyWithImpl(_$WiFiRemoveCommandImpl _value,
      $Res Function(_$WiFiRemoveCommandImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wifiId = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_$WiFiRemoveCommandImpl(
      wifiId: null == wifiId
          ? _value.wifiId
          : wifiId // ignore: cast_nullable_to_non_nullable
              as int,
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
class _$WiFiRemoveCommandImpl implements _WiFiRemoveCommand {
  const _$WiFiRemoveCommandImpl(
      {required this.wifiId,
      required this.id,
      this.type = WiFiRemoveCommand.TYPE});

  factory _$WiFiRemoveCommandImpl.fromJson(Map<String, dynamic> json) =>
      _$$WiFiRemoveCommandImplFromJson(json);

  @override
  final int wifiId;
  @override
  final int id;
  @override
  @JsonKey()
  final String type;

  @override
  String toString() {
    return 'WiFiRemoveCommand(wifiId: $wifiId, id: $id, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WiFiRemoveCommandImpl &&
            (identical(other.wifiId, wifiId) || other.wifiId == wifiId) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, wifiId, id, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WiFiRemoveCommandImplCopyWith<_$WiFiRemoveCommandImpl> get copyWith =>
      __$$WiFiRemoveCommandImplCopyWithImpl<_$WiFiRemoveCommandImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WiFiRemoveCommandImplToJson(
      this,
    );
  }
}

abstract class _WiFiRemoveCommand implements WiFiRemoveCommand {
  const factory _WiFiRemoveCommand(
      {required final int wifiId,
      required final int id,
      final String type}) = _$WiFiRemoveCommandImpl;

  factory _WiFiRemoveCommand.fromJson(Map<String, dynamic> json) =
      _$WiFiRemoveCommandImpl.fromJson;

  @override
  int get wifiId;
  @override
  int get id;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$WiFiRemoveCommandImplCopyWith<_$WiFiRemoveCommandImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WiFiSaveConfigCommand _$WiFiSaveConfigCommandFromJson(
    Map<String, dynamic> json) {
  return _WiFiSaveConfigCommand.fromJson(json);
}

/// @nodoc
mixin _$WiFiSaveConfigCommand {
  int get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WiFiSaveConfigCommandCopyWith<WiFiSaveConfigCommand> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WiFiSaveConfigCommandCopyWith<$Res> {
  factory $WiFiSaveConfigCommandCopyWith(WiFiSaveConfigCommand value,
          $Res Function(WiFiSaveConfigCommand) then) =
      _$WiFiSaveConfigCommandCopyWithImpl<$Res, WiFiSaveConfigCommand>;
  @useResult
  $Res call({int id, String type});
}

/// @nodoc
class _$WiFiSaveConfigCommandCopyWithImpl<$Res,
        $Val extends WiFiSaveConfigCommand>
    implements $WiFiSaveConfigCommandCopyWith<$Res> {
  _$WiFiSaveConfigCommandCopyWithImpl(this._value, this._then);

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
abstract class _$$WiFiSaveConfigCommandImplCopyWith<$Res>
    implements $WiFiSaveConfigCommandCopyWith<$Res> {
  factory _$$WiFiSaveConfigCommandImplCopyWith(
          _$WiFiSaveConfigCommandImpl value,
          $Res Function(_$WiFiSaveConfigCommandImpl) then) =
      __$$WiFiSaveConfigCommandImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String type});
}

/// @nodoc
class __$$WiFiSaveConfigCommandImplCopyWithImpl<$Res>
    extends _$WiFiSaveConfigCommandCopyWithImpl<$Res,
        _$WiFiSaveConfigCommandImpl>
    implements _$$WiFiSaveConfigCommandImplCopyWith<$Res> {
  __$$WiFiSaveConfigCommandImplCopyWithImpl(_$WiFiSaveConfigCommandImpl _value,
      $Res Function(_$WiFiSaveConfigCommandImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_$WiFiSaveConfigCommandImpl(
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
class _$WiFiSaveConfigCommandImpl implements _WiFiSaveConfigCommand {
  const _$WiFiSaveConfigCommandImpl(
      {required this.id, this.type = WiFiSaveConfigCommand.TYPE});

  factory _$WiFiSaveConfigCommandImpl.fromJson(Map<String, dynamic> json) =>
      _$$WiFiSaveConfigCommandImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final String type;

  @override
  String toString() {
    return 'WiFiSaveConfigCommand(id: $id, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WiFiSaveConfigCommandImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WiFiSaveConfigCommandImplCopyWith<_$WiFiSaveConfigCommandImpl>
      get copyWith => __$$WiFiSaveConfigCommandImplCopyWithImpl<
          _$WiFiSaveConfigCommandImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WiFiSaveConfigCommandImplToJson(
      this,
    );
  }
}

abstract class _WiFiSaveConfigCommand implements WiFiSaveConfigCommand {
  const factory _WiFiSaveConfigCommand(
      {required final int id, final String type}) = _$WiFiSaveConfigCommandImpl;

  factory _WiFiSaveConfigCommand.fromJson(Map<String, dynamic> json) =
      _$WiFiSaveConfigCommandImpl.fromJson;

  @override
  int get id;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$WiFiSaveConfigCommandImplCopyWith<_$WiFiSaveConfigCommandImpl>
      get copyWith => throw _privateConstructorUsedError;
}

WiFiAddCommand _$WiFiAddCommandFromJson(Map<String, dynamic> json) {
  return _WiFiAddCommand.fromJson(json);
}

/// @nodoc
mixin _$WiFiAddCommand {
  String get SSID => throw _privateConstructorUsedError;
  String get psk => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WiFiAddCommandCopyWith<WiFiAddCommand> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WiFiAddCommandCopyWith<$Res> {
  factory $WiFiAddCommandCopyWith(
          WiFiAddCommand value, $Res Function(WiFiAddCommand) then) =
      _$WiFiAddCommandCopyWithImpl<$Res, WiFiAddCommand>;
  @useResult
  $Res call({String SSID, String psk, int id, String type});
}

/// @nodoc
class _$WiFiAddCommandCopyWithImpl<$Res, $Val extends WiFiAddCommand>
    implements $WiFiAddCommandCopyWith<$Res> {
  _$WiFiAddCommandCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? SSID = null,
    Object? psk = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      SSID: null == SSID
          ? _value.SSID
          : SSID // ignore: cast_nullable_to_non_nullable
              as String,
      psk: null == psk
          ? _value.psk
          : psk // ignore: cast_nullable_to_non_nullable
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
abstract class _$$WiFiAddCommandImplCopyWith<$Res>
    implements $WiFiAddCommandCopyWith<$Res> {
  factory _$$WiFiAddCommandImplCopyWith(_$WiFiAddCommandImpl value,
          $Res Function(_$WiFiAddCommandImpl) then) =
      __$$WiFiAddCommandImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String SSID, String psk, int id, String type});
}

/// @nodoc
class __$$WiFiAddCommandImplCopyWithImpl<$Res>
    extends _$WiFiAddCommandCopyWithImpl<$Res, _$WiFiAddCommandImpl>
    implements _$$WiFiAddCommandImplCopyWith<$Res> {
  __$$WiFiAddCommandImplCopyWithImpl(
      _$WiFiAddCommandImpl _value, $Res Function(_$WiFiAddCommandImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? SSID = null,
    Object? psk = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_$WiFiAddCommandImpl(
      SSID: null == SSID
          ? _value.SSID
          : SSID // ignore: cast_nullable_to_non_nullable
              as String,
      psk: null == psk
          ? _value.psk
          : psk // ignore: cast_nullable_to_non_nullable
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
class _$WiFiAddCommandImpl implements _WiFiAddCommand {
  const _$WiFiAddCommandImpl(
      {required this.SSID,
      required this.psk,
      required this.id,
      this.type = WiFiAddCommand.TYPE});

  factory _$WiFiAddCommandImpl.fromJson(Map<String, dynamic> json) =>
      _$$WiFiAddCommandImplFromJson(json);

  @override
  final String SSID;
  @override
  final String psk;
  @override
  final int id;
  @override
  @JsonKey()
  final String type;

  @override
  String toString() {
    return 'WiFiAddCommand(SSID: $SSID, psk: $psk, id: $id, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WiFiAddCommandImpl &&
            (identical(other.SSID, SSID) || other.SSID == SSID) &&
            (identical(other.psk, psk) || other.psk == psk) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, SSID, psk, id, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WiFiAddCommandImplCopyWith<_$WiFiAddCommandImpl> get copyWith =>
      __$$WiFiAddCommandImplCopyWithImpl<_$WiFiAddCommandImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WiFiAddCommandImplToJson(
      this,
    );
  }
}

abstract class _WiFiAddCommand implements WiFiAddCommand {
  const factory _WiFiAddCommand(
      {required final String SSID,
      required final String psk,
      required final int id,
      final String type}) = _$WiFiAddCommandImpl;

  factory _WiFiAddCommand.fromJson(Map<String, dynamic> json) =
      _$WiFiAddCommandImpl.fromJson;

  @override
  String get SSID;
  @override
  String get psk;
  @override
  int get id;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$WiFiAddCommandImplCopyWith<_$WiFiAddCommandImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WiFiGetStoredCommand _$WiFiGetStoredCommandFromJson(Map<String, dynamic> json) {
  return _WiFiGetStoredCommand.fromJson(json);
}

/// @nodoc
mixin _$WiFiGetStoredCommand {
  int get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WiFiGetStoredCommandCopyWith<WiFiGetStoredCommand> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WiFiGetStoredCommandCopyWith<$Res> {
  factory $WiFiGetStoredCommandCopyWith(WiFiGetStoredCommand value,
          $Res Function(WiFiGetStoredCommand) then) =
      _$WiFiGetStoredCommandCopyWithImpl<$Res, WiFiGetStoredCommand>;
  @useResult
  $Res call({int id, String type});
}

/// @nodoc
class _$WiFiGetStoredCommandCopyWithImpl<$Res,
        $Val extends WiFiGetStoredCommand>
    implements $WiFiGetStoredCommandCopyWith<$Res> {
  _$WiFiGetStoredCommandCopyWithImpl(this._value, this._then);

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
abstract class _$$WiFiGetStoredCommandImplCopyWith<$Res>
    implements $WiFiGetStoredCommandCopyWith<$Res> {
  factory _$$WiFiGetStoredCommandImplCopyWith(_$WiFiGetStoredCommandImpl value,
          $Res Function(_$WiFiGetStoredCommandImpl) then) =
      __$$WiFiGetStoredCommandImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String type});
}

/// @nodoc
class __$$WiFiGetStoredCommandImplCopyWithImpl<$Res>
    extends _$WiFiGetStoredCommandCopyWithImpl<$Res, _$WiFiGetStoredCommandImpl>
    implements _$$WiFiGetStoredCommandImplCopyWith<$Res> {
  __$$WiFiGetStoredCommandImplCopyWithImpl(_$WiFiGetStoredCommandImpl _value,
      $Res Function(_$WiFiGetStoredCommandImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_$WiFiGetStoredCommandImpl(
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
class _$WiFiGetStoredCommandImpl implements _WiFiGetStoredCommand {
  const _$WiFiGetStoredCommandImpl(
      {required this.id, this.type = WiFiGetStoredCommand.TYPE});

  factory _$WiFiGetStoredCommandImpl.fromJson(Map<String, dynamic> json) =>
      _$$WiFiGetStoredCommandImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final String type;

  @override
  String toString() {
    return 'WiFiGetStoredCommand(id: $id, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WiFiGetStoredCommandImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WiFiGetStoredCommandImplCopyWith<_$WiFiGetStoredCommandImpl>
      get copyWith =>
          __$$WiFiGetStoredCommandImplCopyWithImpl<_$WiFiGetStoredCommandImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WiFiGetStoredCommandImplToJson(
      this,
    );
  }
}

abstract class _WiFiGetStoredCommand implements WiFiGetStoredCommand {
  const factory _WiFiGetStoredCommand(
      {required final int id, final String type}) = _$WiFiGetStoredCommandImpl;

  factory _WiFiGetStoredCommand.fromJson(Map<String, dynamic> json) =
      _$WiFiGetStoredCommandImpl.fromJson;

  @override
  int get id;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$WiFiGetStoredCommandImplCopyWith<_$WiFiGetStoredCommandImpl>
      get copyWith => throw _privateConstructorUsedError;
}

WiFiGetStoredResult _$WiFiGetStoredResultFromJson(Map<String, dynamic> json) {
  return _WiFiGetStoredResult.fromJson(json);
}

/// @nodoc
mixin _$WiFiGetStoredResult {
  List<WiFiStoredNetworkInfo> get networks =>
      throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WiFiGetStoredResultCopyWith<WiFiGetStoredResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WiFiGetStoredResultCopyWith<$Res> {
  factory $WiFiGetStoredResultCopyWith(
          WiFiGetStoredResult value, $Res Function(WiFiGetStoredResult) then) =
      _$WiFiGetStoredResultCopyWithImpl<$Res, WiFiGetStoredResult>;
  @useResult
  $Res call({List<WiFiStoredNetworkInfo> networks, int id});
}

/// @nodoc
class _$WiFiGetStoredResultCopyWithImpl<$Res, $Val extends WiFiGetStoredResult>
    implements $WiFiGetStoredResultCopyWith<$Res> {
  _$WiFiGetStoredResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? networks = null,
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      networks: null == networks
          ? _value.networks
          : networks // ignore: cast_nullable_to_non_nullable
              as List<WiFiStoredNetworkInfo>,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WiFiGetStoredResultImplCopyWith<$Res>
    implements $WiFiGetStoredResultCopyWith<$Res> {
  factory _$$WiFiGetStoredResultImplCopyWith(_$WiFiGetStoredResultImpl value,
          $Res Function(_$WiFiGetStoredResultImpl) then) =
      __$$WiFiGetStoredResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<WiFiStoredNetworkInfo> networks, int id});
}

/// @nodoc
class __$$WiFiGetStoredResultImplCopyWithImpl<$Res>
    extends _$WiFiGetStoredResultCopyWithImpl<$Res, _$WiFiGetStoredResultImpl>
    implements _$$WiFiGetStoredResultImplCopyWith<$Res> {
  __$$WiFiGetStoredResultImplCopyWithImpl(_$WiFiGetStoredResultImpl _value,
      $Res Function(_$WiFiGetStoredResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? networks = null,
    Object? id = null,
  }) {
    return _then(_$WiFiGetStoredResultImpl(
      networks: null == networks
          ? _value._networks
          : networks // ignore: cast_nullable_to_non_nullable
              as List<WiFiStoredNetworkInfo>,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WiFiGetStoredResultImpl implements _WiFiGetStoredResult {
  const _$WiFiGetStoredResultImpl(
      {required final List<WiFiStoredNetworkInfo> networks, required this.id})
      : _networks = networks;

  factory _$WiFiGetStoredResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$WiFiGetStoredResultImplFromJson(json);

  final List<WiFiStoredNetworkInfo> _networks;
  @override
  List<WiFiStoredNetworkInfo> get networks {
    if (_networks is EqualUnmodifiableListView) return _networks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_networks);
  }

  @override
  final int id;

  @override
  String toString() {
    return 'WiFiGetStoredResult(networks: $networks, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WiFiGetStoredResultImpl &&
            const DeepCollectionEquality().equals(other._networks, _networks) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_networks), id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WiFiGetStoredResultImplCopyWith<_$WiFiGetStoredResultImpl> get copyWith =>
      __$$WiFiGetStoredResultImplCopyWithImpl<_$WiFiGetStoredResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WiFiGetStoredResultImplToJson(
      this,
    );
  }
}

abstract class _WiFiGetStoredResult implements WiFiGetStoredResult {
  const factory _WiFiGetStoredResult(
      {required final List<WiFiStoredNetworkInfo> networks,
      required final int id}) = _$WiFiGetStoredResultImpl;

  factory _WiFiGetStoredResult.fromJson(Map<String, dynamic> json) =
      _$WiFiGetStoredResultImpl.fromJson;

  @override
  List<WiFiStoredNetworkInfo> get networks;
  @override
  int get id;
  @override
  @JsonKey(ignore: true)
  _$$WiFiGetStoredResultImplCopyWith<_$WiFiGetStoredResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
