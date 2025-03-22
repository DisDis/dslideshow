// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wifi_commands.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WiFiScanCommand {
  int get id;
  String get type;

  /// Create a copy of WiFiScanCommand
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WiFiScanCommandCopyWith<WiFiScanCommand> get copyWith =>
      _$WiFiScanCommandCopyWithImpl<WiFiScanCommand>(
          this as WiFiScanCommand, _$identity);

  /// Serializes this WiFiScanCommand to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WiFiScanCommand &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, type);

  @override
  String toString() {
    return 'WiFiScanCommand(id: $id, type: $type)';
  }
}

/// @nodoc
abstract mixin class $WiFiScanCommandCopyWith<$Res> {
  factory $WiFiScanCommandCopyWith(
          WiFiScanCommand value, $Res Function(WiFiScanCommand) _then) =
      _$WiFiScanCommandCopyWithImpl;
  @useResult
  $Res call({int id, String type});
}

/// @nodoc
class _$WiFiScanCommandCopyWithImpl<$Res>
    implements $WiFiScanCommandCopyWith<$Res> {
  _$WiFiScanCommandCopyWithImpl(this._self, this._then);

  final WiFiScanCommand _self;
  final $Res Function(WiFiScanCommand) _then;

  /// Create a copy of WiFiScanCommand
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
class _WiFiScanCommand implements WiFiScanCommand {
  const _WiFiScanCommand({required this.id, this.type = WiFiScanCommand.TYPE});
  factory _WiFiScanCommand.fromJson(Map<String, dynamic> json) =>
      _$WiFiScanCommandFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final String type;

  /// Create a copy of WiFiScanCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WiFiScanCommandCopyWith<_WiFiScanCommand> get copyWith =>
      __$WiFiScanCommandCopyWithImpl<_WiFiScanCommand>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WiFiScanCommandToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WiFiScanCommand &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, type);

  @override
  String toString() {
    return 'WiFiScanCommand(id: $id, type: $type)';
  }
}

/// @nodoc
abstract mixin class _$WiFiScanCommandCopyWith<$Res>
    implements $WiFiScanCommandCopyWith<$Res> {
  factory _$WiFiScanCommandCopyWith(
          _WiFiScanCommand value, $Res Function(_WiFiScanCommand) _then) =
      __$WiFiScanCommandCopyWithImpl;
  @override
  @useResult
  $Res call({int id, String type});
}

/// @nodoc
class __$WiFiScanCommandCopyWithImpl<$Res>
    implements _$WiFiScanCommandCopyWith<$Res> {
  __$WiFiScanCommandCopyWithImpl(this._self, this._then);

  final _WiFiScanCommand _self;
  final $Res Function(_WiFiScanCommand) _then;

  /// Create a copy of WiFiScanCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_WiFiScanCommand(
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
mixin _$WiFiScanResult {
  List<WiFiNetworkInfo> get networks;
  int get id;

  /// Create a copy of WiFiScanResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WiFiScanResultCopyWith<WiFiScanResult> get copyWith =>
      _$WiFiScanResultCopyWithImpl<WiFiScanResult>(
          this as WiFiScanResult, _$identity);

  /// Serializes this WiFiScanResult to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WiFiScanResult &&
            const DeepCollectionEquality().equals(other.networks, networks) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(networks), id);

  @override
  String toString() {
    return 'WiFiScanResult(networks: $networks, id: $id)';
  }
}

/// @nodoc
abstract mixin class $WiFiScanResultCopyWith<$Res> {
  factory $WiFiScanResultCopyWith(
          WiFiScanResult value, $Res Function(WiFiScanResult) _then) =
      _$WiFiScanResultCopyWithImpl;
  @useResult
  $Res call({List<WiFiNetworkInfo> networks, int id});
}

/// @nodoc
class _$WiFiScanResultCopyWithImpl<$Res>
    implements $WiFiScanResultCopyWith<$Res> {
  _$WiFiScanResultCopyWithImpl(this._self, this._then);

  final WiFiScanResult _self;
  final $Res Function(WiFiScanResult) _then;

  /// Create a copy of WiFiScanResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? networks = null,
    Object? id = null,
  }) {
    return _then(_self.copyWith(
      networks: null == networks
          ? _self.networks
          : networks // ignore: cast_nullable_to_non_nullable
              as List<WiFiNetworkInfo>,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _WiFiScanResult implements WiFiScanResult {
  const _WiFiScanResult(
      {required final List<WiFiNetworkInfo> networks, required this.id})
      : _networks = networks;
  factory _WiFiScanResult.fromJson(Map<String, dynamic> json) =>
      _$WiFiScanResultFromJson(json);

  final List<WiFiNetworkInfo> _networks;
  @override
  List<WiFiNetworkInfo> get networks {
    if (_networks is EqualUnmodifiableListView) return _networks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_networks);
  }

  @override
  final int id;

  /// Create a copy of WiFiScanResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WiFiScanResultCopyWith<_WiFiScanResult> get copyWith =>
      __$WiFiScanResultCopyWithImpl<_WiFiScanResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WiFiScanResultToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WiFiScanResult &&
            const DeepCollectionEquality().equals(other._networks, _networks) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_networks), id);

  @override
  String toString() {
    return 'WiFiScanResult(networks: $networks, id: $id)';
  }
}

/// @nodoc
abstract mixin class _$WiFiScanResultCopyWith<$Res>
    implements $WiFiScanResultCopyWith<$Res> {
  factory _$WiFiScanResultCopyWith(
          _WiFiScanResult value, $Res Function(_WiFiScanResult) _then) =
      __$WiFiScanResultCopyWithImpl;
  @override
  @useResult
  $Res call({List<WiFiNetworkInfo> networks, int id});
}

/// @nodoc
class __$WiFiScanResultCopyWithImpl<$Res>
    implements _$WiFiScanResultCopyWith<$Res> {
  __$WiFiScanResultCopyWithImpl(this._self, this._then);

  final _WiFiScanResult _self;
  final $Res Function(_WiFiScanResult) _then;

  /// Create a copy of WiFiScanResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? networks = null,
    Object? id = null,
  }) {
    return _then(_WiFiScanResult(
      networks: null == networks
          ? _self._networks
          : networks // ignore: cast_nullable_to_non_nullable
              as List<WiFiNetworkInfo>,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$WiFiNetworkInfo {
  String get SSID;
  int get signal;
  String get capability;
  int get freq;

  /// Create a copy of WiFiNetworkInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WiFiNetworkInfoCopyWith<WiFiNetworkInfo> get copyWith =>
      _$WiFiNetworkInfoCopyWithImpl<WiFiNetworkInfo>(
          this as WiFiNetworkInfo, _$identity);

  /// Serializes this WiFiNetworkInfo to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WiFiNetworkInfo &&
            (identical(other.SSID, SSID) || other.SSID == SSID) &&
            (identical(other.signal, signal) || other.signal == signal) &&
            (identical(other.capability, capability) ||
                other.capability == capability) &&
            (identical(other.freq, freq) || other.freq == freq));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, SSID, signal, capability, freq);

  @override
  String toString() {
    return 'WiFiNetworkInfo(SSID: $SSID, signal: $signal, capability: $capability, freq: $freq)';
  }
}

/// @nodoc
abstract mixin class $WiFiNetworkInfoCopyWith<$Res> {
  factory $WiFiNetworkInfoCopyWith(
          WiFiNetworkInfo value, $Res Function(WiFiNetworkInfo) _then) =
      _$WiFiNetworkInfoCopyWithImpl;
  @useResult
  $Res call({String SSID, int signal, String capability, int freq});
}

/// @nodoc
class _$WiFiNetworkInfoCopyWithImpl<$Res>
    implements $WiFiNetworkInfoCopyWith<$Res> {
  _$WiFiNetworkInfoCopyWithImpl(this._self, this._then);

  final WiFiNetworkInfo _self;
  final $Res Function(WiFiNetworkInfo) _then;

  /// Create a copy of WiFiNetworkInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? SSID = null,
    Object? signal = null,
    Object? capability = null,
    Object? freq = null,
  }) {
    return _then(_self.copyWith(
      SSID: null == SSID
          ? _self.SSID
          : SSID // ignore: cast_nullable_to_non_nullable
              as String,
      signal: null == signal
          ? _self.signal
          : signal // ignore: cast_nullable_to_non_nullable
              as int,
      capability: null == capability
          ? _self.capability
          : capability // ignore: cast_nullable_to_non_nullable
              as String,
      freq: null == freq
          ? _self.freq
          : freq // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _WiFiNetworkInfo implements WiFiNetworkInfo {
  const _WiFiNetworkInfo(
      {required this.SSID,
      required this.signal,
      required this.capability,
      required this.freq});
  factory _WiFiNetworkInfo.fromJson(Map<String, dynamic> json) =>
      _$WiFiNetworkInfoFromJson(json);

  @override
  final String SSID;
  @override
  final int signal;
  @override
  final String capability;
  @override
  final int freq;

  /// Create a copy of WiFiNetworkInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WiFiNetworkInfoCopyWith<_WiFiNetworkInfo> get copyWith =>
      __$WiFiNetworkInfoCopyWithImpl<_WiFiNetworkInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WiFiNetworkInfoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WiFiNetworkInfo &&
            (identical(other.SSID, SSID) || other.SSID == SSID) &&
            (identical(other.signal, signal) || other.signal == signal) &&
            (identical(other.capability, capability) ||
                other.capability == capability) &&
            (identical(other.freq, freq) || other.freq == freq));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, SSID, signal, capability, freq);

  @override
  String toString() {
    return 'WiFiNetworkInfo(SSID: $SSID, signal: $signal, capability: $capability, freq: $freq)';
  }
}

/// @nodoc
abstract mixin class _$WiFiNetworkInfoCopyWith<$Res>
    implements $WiFiNetworkInfoCopyWith<$Res> {
  factory _$WiFiNetworkInfoCopyWith(
          _WiFiNetworkInfo value, $Res Function(_WiFiNetworkInfo) _then) =
      __$WiFiNetworkInfoCopyWithImpl;
  @override
  @useResult
  $Res call({String SSID, int signal, String capability, int freq});
}

/// @nodoc
class __$WiFiNetworkInfoCopyWithImpl<$Res>
    implements _$WiFiNetworkInfoCopyWith<$Res> {
  __$WiFiNetworkInfoCopyWithImpl(this._self, this._then);

  final _WiFiNetworkInfo _self;
  final $Res Function(_WiFiNetworkInfo) _then;

  /// Create a copy of WiFiNetworkInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? SSID = null,
    Object? signal = null,
    Object? capability = null,
    Object? freq = null,
  }) {
    return _then(_WiFiNetworkInfo(
      SSID: null == SSID
          ? _self.SSID
          : SSID // ignore: cast_nullable_to_non_nullable
              as String,
      signal: null == signal
          ? _self.signal
          : signal // ignore: cast_nullable_to_non_nullable
              as int,
      capability: null == capability
          ? _self.capability
          : capability // ignore: cast_nullable_to_non_nullable
              as String,
      freq: null == freq
          ? _self.freq
          : freq // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$WiFiStoredNetworkInfo {
  int get id;
  String get SSID;
  bool get disabled;

  /// Create a copy of WiFiStoredNetworkInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WiFiStoredNetworkInfoCopyWith<WiFiStoredNetworkInfo> get copyWith =>
      _$WiFiStoredNetworkInfoCopyWithImpl<WiFiStoredNetworkInfo>(
          this as WiFiStoredNetworkInfo, _$identity);

  /// Serializes this WiFiStoredNetworkInfo to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WiFiStoredNetworkInfo &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.SSID, SSID) || other.SSID == SSID) &&
            (identical(other.disabled, disabled) ||
                other.disabled == disabled));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, SSID, disabled);

  @override
  String toString() {
    return 'WiFiStoredNetworkInfo(id: $id, SSID: $SSID, disabled: $disabled)';
  }
}

/// @nodoc
abstract mixin class $WiFiStoredNetworkInfoCopyWith<$Res> {
  factory $WiFiStoredNetworkInfoCopyWith(WiFiStoredNetworkInfo value,
          $Res Function(WiFiStoredNetworkInfo) _then) =
      _$WiFiStoredNetworkInfoCopyWithImpl;
  @useResult
  $Res call({int id, String SSID, bool disabled});
}

/// @nodoc
class _$WiFiStoredNetworkInfoCopyWithImpl<$Res>
    implements $WiFiStoredNetworkInfoCopyWith<$Res> {
  _$WiFiStoredNetworkInfoCopyWithImpl(this._self, this._then);

  final WiFiStoredNetworkInfo _self;
  final $Res Function(WiFiStoredNetworkInfo) _then;

  /// Create a copy of WiFiStoredNetworkInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? SSID = null,
    Object? disabled = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      SSID: null == SSID
          ? _self.SSID
          : SSID // ignore: cast_nullable_to_non_nullable
              as String,
      disabled: null == disabled
          ? _self.disabled
          : disabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _WiFiStoredNetworkInfo implements WiFiStoredNetworkInfo {
  const _WiFiStoredNetworkInfo(
      {required this.id, required this.SSID, required this.disabled});
  factory _WiFiStoredNetworkInfo.fromJson(Map<String, dynamic> json) =>
      _$WiFiStoredNetworkInfoFromJson(json);

  @override
  final int id;
  @override
  final String SSID;
  @override
  final bool disabled;

  /// Create a copy of WiFiStoredNetworkInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WiFiStoredNetworkInfoCopyWith<_WiFiStoredNetworkInfo> get copyWith =>
      __$WiFiStoredNetworkInfoCopyWithImpl<_WiFiStoredNetworkInfo>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WiFiStoredNetworkInfoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WiFiStoredNetworkInfo &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.SSID, SSID) || other.SSID == SSID) &&
            (identical(other.disabled, disabled) ||
                other.disabled == disabled));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, SSID, disabled);

  @override
  String toString() {
    return 'WiFiStoredNetworkInfo(id: $id, SSID: $SSID, disabled: $disabled)';
  }
}

/// @nodoc
abstract mixin class _$WiFiStoredNetworkInfoCopyWith<$Res>
    implements $WiFiStoredNetworkInfoCopyWith<$Res> {
  factory _$WiFiStoredNetworkInfoCopyWith(_WiFiStoredNetworkInfo value,
          $Res Function(_WiFiStoredNetworkInfo) _then) =
      __$WiFiStoredNetworkInfoCopyWithImpl;
  @override
  @useResult
  $Res call({int id, String SSID, bool disabled});
}

/// @nodoc
class __$WiFiStoredNetworkInfoCopyWithImpl<$Res>
    implements _$WiFiStoredNetworkInfoCopyWith<$Res> {
  __$WiFiStoredNetworkInfoCopyWithImpl(this._self, this._then);

  final _WiFiStoredNetworkInfo _self;
  final $Res Function(_WiFiStoredNetworkInfo) _then;

  /// Create a copy of WiFiStoredNetworkInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? SSID = null,
    Object? disabled = null,
  }) {
    return _then(_WiFiStoredNetworkInfo(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      SSID: null == SSID
          ? _self.SSID
          : SSID // ignore: cast_nullable_to_non_nullable
              as String,
      disabled: null == disabled
          ? _self.disabled
          : disabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
mixin _$WiFiRemoveCommand {
  int get wifiId;
  int get id;
  String get type;

  /// Create a copy of WiFiRemoveCommand
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WiFiRemoveCommandCopyWith<WiFiRemoveCommand> get copyWith =>
      _$WiFiRemoveCommandCopyWithImpl<WiFiRemoveCommand>(
          this as WiFiRemoveCommand, _$identity);

  /// Serializes this WiFiRemoveCommand to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WiFiRemoveCommand &&
            (identical(other.wifiId, wifiId) || other.wifiId == wifiId) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, wifiId, id, type);

  @override
  String toString() {
    return 'WiFiRemoveCommand(wifiId: $wifiId, id: $id, type: $type)';
  }
}

/// @nodoc
abstract mixin class $WiFiRemoveCommandCopyWith<$Res> {
  factory $WiFiRemoveCommandCopyWith(
          WiFiRemoveCommand value, $Res Function(WiFiRemoveCommand) _then) =
      _$WiFiRemoveCommandCopyWithImpl;
  @useResult
  $Res call({int wifiId, int id, String type});
}

/// @nodoc
class _$WiFiRemoveCommandCopyWithImpl<$Res>
    implements $WiFiRemoveCommandCopyWith<$Res> {
  _$WiFiRemoveCommandCopyWithImpl(this._self, this._then);

  final WiFiRemoveCommand _self;
  final $Res Function(WiFiRemoveCommand) _then;

  /// Create a copy of WiFiRemoveCommand
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wifiId = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_self.copyWith(
      wifiId: null == wifiId
          ? _self.wifiId
          : wifiId // ignore: cast_nullable_to_non_nullable
              as int,
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
class _WiFiRemoveCommand implements WiFiRemoveCommand {
  const _WiFiRemoveCommand(
      {required this.wifiId,
      required this.id,
      this.type = WiFiRemoveCommand.TYPE});
  factory _WiFiRemoveCommand.fromJson(Map<String, dynamic> json) =>
      _$WiFiRemoveCommandFromJson(json);

  @override
  final int wifiId;
  @override
  final int id;
  @override
  @JsonKey()
  final String type;

  /// Create a copy of WiFiRemoveCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WiFiRemoveCommandCopyWith<_WiFiRemoveCommand> get copyWith =>
      __$WiFiRemoveCommandCopyWithImpl<_WiFiRemoveCommand>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WiFiRemoveCommandToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WiFiRemoveCommand &&
            (identical(other.wifiId, wifiId) || other.wifiId == wifiId) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, wifiId, id, type);

  @override
  String toString() {
    return 'WiFiRemoveCommand(wifiId: $wifiId, id: $id, type: $type)';
  }
}

/// @nodoc
abstract mixin class _$WiFiRemoveCommandCopyWith<$Res>
    implements $WiFiRemoveCommandCopyWith<$Res> {
  factory _$WiFiRemoveCommandCopyWith(
          _WiFiRemoveCommand value, $Res Function(_WiFiRemoveCommand) _then) =
      __$WiFiRemoveCommandCopyWithImpl;
  @override
  @useResult
  $Res call({int wifiId, int id, String type});
}

/// @nodoc
class __$WiFiRemoveCommandCopyWithImpl<$Res>
    implements _$WiFiRemoveCommandCopyWith<$Res> {
  __$WiFiRemoveCommandCopyWithImpl(this._self, this._then);

  final _WiFiRemoveCommand _self;
  final $Res Function(_WiFiRemoveCommand) _then;

  /// Create a copy of WiFiRemoveCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? wifiId = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_WiFiRemoveCommand(
      wifiId: null == wifiId
          ? _self.wifiId
          : wifiId // ignore: cast_nullable_to_non_nullable
              as int,
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
mixin _$WiFiSaveConfigCommand {
  int get id;
  String get type;

  /// Create a copy of WiFiSaveConfigCommand
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WiFiSaveConfigCommandCopyWith<WiFiSaveConfigCommand> get copyWith =>
      _$WiFiSaveConfigCommandCopyWithImpl<WiFiSaveConfigCommand>(
          this as WiFiSaveConfigCommand, _$identity);

  /// Serializes this WiFiSaveConfigCommand to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WiFiSaveConfigCommand &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, type);

  @override
  String toString() {
    return 'WiFiSaveConfigCommand(id: $id, type: $type)';
  }
}

/// @nodoc
abstract mixin class $WiFiSaveConfigCommandCopyWith<$Res> {
  factory $WiFiSaveConfigCommandCopyWith(WiFiSaveConfigCommand value,
          $Res Function(WiFiSaveConfigCommand) _then) =
      _$WiFiSaveConfigCommandCopyWithImpl;
  @useResult
  $Res call({int id, String type});
}

/// @nodoc
class _$WiFiSaveConfigCommandCopyWithImpl<$Res>
    implements $WiFiSaveConfigCommandCopyWith<$Res> {
  _$WiFiSaveConfigCommandCopyWithImpl(this._self, this._then);

  final WiFiSaveConfigCommand _self;
  final $Res Function(WiFiSaveConfigCommand) _then;

  /// Create a copy of WiFiSaveConfigCommand
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
class _WiFiSaveConfigCommand implements WiFiSaveConfigCommand {
  const _WiFiSaveConfigCommand(
      {required this.id, this.type = WiFiSaveConfigCommand.TYPE});
  factory _WiFiSaveConfigCommand.fromJson(Map<String, dynamic> json) =>
      _$WiFiSaveConfigCommandFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final String type;

  /// Create a copy of WiFiSaveConfigCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WiFiSaveConfigCommandCopyWith<_WiFiSaveConfigCommand> get copyWith =>
      __$WiFiSaveConfigCommandCopyWithImpl<_WiFiSaveConfigCommand>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WiFiSaveConfigCommandToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WiFiSaveConfigCommand &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, type);

  @override
  String toString() {
    return 'WiFiSaveConfigCommand(id: $id, type: $type)';
  }
}

/// @nodoc
abstract mixin class _$WiFiSaveConfigCommandCopyWith<$Res>
    implements $WiFiSaveConfigCommandCopyWith<$Res> {
  factory _$WiFiSaveConfigCommandCopyWith(_WiFiSaveConfigCommand value,
          $Res Function(_WiFiSaveConfigCommand) _then) =
      __$WiFiSaveConfigCommandCopyWithImpl;
  @override
  @useResult
  $Res call({int id, String type});
}

/// @nodoc
class __$WiFiSaveConfigCommandCopyWithImpl<$Res>
    implements _$WiFiSaveConfigCommandCopyWith<$Res> {
  __$WiFiSaveConfigCommandCopyWithImpl(this._self, this._then);

  final _WiFiSaveConfigCommand _self;
  final $Res Function(_WiFiSaveConfigCommand) _then;

  /// Create a copy of WiFiSaveConfigCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_WiFiSaveConfigCommand(
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
mixin _$WiFiAddCommand {
  String get SSID;
  String get psk;
  int get id;
  String get type;

  /// Create a copy of WiFiAddCommand
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WiFiAddCommandCopyWith<WiFiAddCommand> get copyWith =>
      _$WiFiAddCommandCopyWithImpl<WiFiAddCommand>(
          this as WiFiAddCommand, _$identity);

  /// Serializes this WiFiAddCommand to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WiFiAddCommand &&
            (identical(other.SSID, SSID) || other.SSID == SSID) &&
            (identical(other.psk, psk) || other.psk == psk) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, SSID, psk, id, type);

  @override
  String toString() {
    return 'WiFiAddCommand(SSID: $SSID, psk: $psk, id: $id, type: $type)';
  }
}

/// @nodoc
abstract mixin class $WiFiAddCommandCopyWith<$Res> {
  factory $WiFiAddCommandCopyWith(
          WiFiAddCommand value, $Res Function(WiFiAddCommand) _then) =
      _$WiFiAddCommandCopyWithImpl;
  @useResult
  $Res call({String SSID, String psk, int id, String type});
}

/// @nodoc
class _$WiFiAddCommandCopyWithImpl<$Res>
    implements $WiFiAddCommandCopyWith<$Res> {
  _$WiFiAddCommandCopyWithImpl(this._self, this._then);

  final WiFiAddCommand _self;
  final $Res Function(WiFiAddCommand) _then;

  /// Create a copy of WiFiAddCommand
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? SSID = null,
    Object? psk = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_self.copyWith(
      SSID: null == SSID
          ? _self.SSID
          : SSID // ignore: cast_nullable_to_non_nullable
              as String,
      psk: null == psk
          ? _self.psk
          : psk // ignore: cast_nullable_to_non_nullable
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
class _WiFiAddCommand implements WiFiAddCommand {
  const _WiFiAddCommand(
      {required this.SSID,
      required this.psk,
      required this.id,
      this.type = WiFiAddCommand.TYPE});
  factory _WiFiAddCommand.fromJson(Map<String, dynamic> json) =>
      _$WiFiAddCommandFromJson(json);

  @override
  final String SSID;
  @override
  final String psk;
  @override
  final int id;
  @override
  @JsonKey()
  final String type;

  /// Create a copy of WiFiAddCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WiFiAddCommandCopyWith<_WiFiAddCommand> get copyWith =>
      __$WiFiAddCommandCopyWithImpl<_WiFiAddCommand>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WiFiAddCommandToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WiFiAddCommand &&
            (identical(other.SSID, SSID) || other.SSID == SSID) &&
            (identical(other.psk, psk) || other.psk == psk) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, SSID, psk, id, type);

  @override
  String toString() {
    return 'WiFiAddCommand(SSID: $SSID, psk: $psk, id: $id, type: $type)';
  }
}

/// @nodoc
abstract mixin class _$WiFiAddCommandCopyWith<$Res>
    implements $WiFiAddCommandCopyWith<$Res> {
  factory _$WiFiAddCommandCopyWith(
          _WiFiAddCommand value, $Res Function(_WiFiAddCommand) _then) =
      __$WiFiAddCommandCopyWithImpl;
  @override
  @useResult
  $Res call({String SSID, String psk, int id, String type});
}

/// @nodoc
class __$WiFiAddCommandCopyWithImpl<$Res>
    implements _$WiFiAddCommandCopyWith<$Res> {
  __$WiFiAddCommandCopyWithImpl(this._self, this._then);

  final _WiFiAddCommand _self;
  final $Res Function(_WiFiAddCommand) _then;

  /// Create a copy of WiFiAddCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? SSID = null,
    Object? psk = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_WiFiAddCommand(
      SSID: null == SSID
          ? _self.SSID
          : SSID // ignore: cast_nullable_to_non_nullable
              as String,
      psk: null == psk
          ? _self.psk
          : psk // ignore: cast_nullable_to_non_nullable
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
mixin _$WiFiGetStoredCommand {
  int get id;
  String get type;

  /// Create a copy of WiFiGetStoredCommand
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WiFiGetStoredCommandCopyWith<WiFiGetStoredCommand> get copyWith =>
      _$WiFiGetStoredCommandCopyWithImpl<WiFiGetStoredCommand>(
          this as WiFiGetStoredCommand, _$identity);

  /// Serializes this WiFiGetStoredCommand to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WiFiGetStoredCommand &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, type);

  @override
  String toString() {
    return 'WiFiGetStoredCommand(id: $id, type: $type)';
  }
}

/// @nodoc
abstract mixin class $WiFiGetStoredCommandCopyWith<$Res> {
  factory $WiFiGetStoredCommandCopyWith(WiFiGetStoredCommand value,
          $Res Function(WiFiGetStoredCommand) _then) =
      _$WiFiGetStoredCommandCopyWithImpl;
  @useResult
  $Res call({int id, String type});
}

/// @nodoc
class _$WiFiGetStoredCommandCopyWithImpl<$Res>
    implements $WiFiGetStoredCommandCopyWith<$Res> {
  _$WiFiGetStoredCommandCopyWithImpl(this._self, this._then);

  final WiFiGetStoredCommand _self;
  final $Res Function(WiFiGetStoredCommand) _then;

  /// Create a copy of WiFiGetStoredCommand
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
class _WiFiGetStoredCommand implements WiFiGetStoredCommand {
  const _WiFiGetStoredCommand(
      {required this.id, this.type = WiFiGetStoredCommand.TYPE});
  factory _WiFiGetStoredCommand.fromJson(Map<String, dynamic> json) =>
      _$WiFiGetStoredCommandFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final String type;

  /// Create a copy of WiFiGetStoredCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WiFiGetStoredCommandCopyWith<_WiFiGetStoredCommand> get copyWith =>
      __$WiFiGetStoredCommandCopyWithImpl<_WiFiGetStoredCommand>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WiFiGetStoredCommandToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WiFiGetStoredCommand &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, type);

  @override
  String toString() {
    return 'WiFiGetStoredCommand(id: $id, type: $type)';
  }
}

/// @nodoc
abstract mixin class _$WiFiGetStoredCommandCopyWith<$Res>
    implements $WiFiGetStoredCommandCopyWith<$Res> {
  factory _$WiFiGetStoredCommandCopyWith(_WiFiGetStoredCommand value,
          $Res Function(_WiFiGetStoredCommand) _then) =
      __$WiFiGetStoredCommandCopyWithImpl;
  @override
  @useResult
  $Res call({int id, String type});
}

/// @nodoc
class __$WiFiGetStoredCommandCopyWithImpl<$Res>
    implements _$WiFiGetStoredCommandCopyWith<$Res> {
  __$WiFiGetStoredCommandCopyWithImpl(this._self, this._then);

  final _WiFiGetStoredCommand _self;
  final $Res Function(_WiFiGetStoredCommand) _then;

  /// Create a copy of WiFiGetStoredCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_WiFiGetStoredCommand(
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
mixin _$WiFiGetStoredResult {
  List<WiFiStoredNetworkInfo> get networks;
  int get id;

  /// Create a copy of WiFiGetStoredResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WiFiGetStoredResultCopyWith<WiFiGetStoredResult> get copyWith =>
      _$WiFiGetStoredResultCopyWithImpl<WiFiGetStoredResult>(
          this as WiFiGetStoredResult, _$identity);

  /// Serializes this WiFiGetStoredResult to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WiFiGetStoredResult &&
            const DeepCollectionEquality().equals(other.networks, networks) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(networks), id);

  @override
  String toString() {
    return 'WiFiGetStoredResult(networks: $networks, id: $id)';
  }
}

/// @nodoc
abstract mixin class $WiFiGetStoredResultCopyWith<$Res> {
  factory $WiFiGetStoredResultCopyWith(
          WiFiGetStoredResult value, $Res Function(WiFiGetStoredResult) _then) =
      _$WiFiGetStoredResultCopyWithImpl;
  @useResult
  $Res call({List<WiFiStoredNetworkInfo> networks, int id});
}

/// @nodoc
class _$WiFiGetStoredResultCopyWithImpl<$Res>
    implements $WiFiGetStoredResultCopyWith<$Res> {
  _$WiFiGetStoredResultCopyWithImpl(this._self, this._then);

  final WiFiGetStoredResult _self;
  final $Res Function(WiFiGetStoredResult) _then;

  /// Create a copy of WiFiGetStoredResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? networks = null,
    Object? id = null,
  }) {
    return _then(_self.copyWith(
      networks: null == networks
          ? _self.networks
          : networks // ignore: cast_nullable_to_non_nullable
              as List<WiFiStoredNetworkInfo>,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _WiFiGetStoredResult implements WiFiGetStoredResult {
  const _WiFiGetStoredResult(
      {required final List<WiFiStoredNetworkInfo> networks, required this.id})
      : _networks = networks;
  factory _WiFiGetStoredResult.fromJson(Map<String, dynamic> json) =>
      _$WiFiGetStoredResultFromJson(json);

  final List<WiFiStoredNetworkInfo> _networks;
  @override
  List<WiFiStoredNetworkInfo> get networks {
    if (_networks is EqualUnmodifiableListView) return _networks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_networks);
  }

  @override
  final int id;

  /// Create a copy of WiFiGetStoredResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WiFiGetStoredResultCopyWith<_WiFiGetStoredResult> get copyWith =>
      __$WiFiGetStoredResultCopyWithImpl<_WiFiGetStoredResult>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WiFiGetStoredResultToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WiFiGetStoredResult &&
            const DeepCollectionEquality().equals(other._networks, _networks) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_networks), id);

  @override
  String toString() {
    return 'WiFiGetStoredResult(networks: $networks, id: $id)';
  }
}

/// @nodoc
abstract mixin class _$WiFiGetStoredResultCopyWith<$Res>
    implements $WiFiGetStoredResultCopyWith<$Res> {
  factory _$WiFiGetStoredResultCopyWith(_WiFiGetStoredResult value,
          $Res Function(_WiFiGetStoredResult) _then) =
      __$WiFiGetStoredResultCopyWithImpl;
  @override
  @useResult
  $Res call({List<WiFiStoredNetworkInfo> networks, int id});
}

/// @nodoc
class __$WiFiGetStoredResultCopyWithImpl<$Res>
    implements _$WiFiGetStoredResultCopyWith<$Res> {
  __$WiFiGetStoredResultCopyWithImpl(this._self, this._then);

  final _WiFiGetStoredResult _self;
  final $Res Function(_WiFiGetStoredResult) _then;

  /// Create a copy of WiFiGetStoredResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? networks = null,
    Object? id = null,
  }) {
    return _then(_WiFiGetStoredResult(
      networks: null == networks
          ? _self._networks
          : networks // ignore: cast_nullable_to_non_nullable
              as List<WiFiStoredNetworkInfo>,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
