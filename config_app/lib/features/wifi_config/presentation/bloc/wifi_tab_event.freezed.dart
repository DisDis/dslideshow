// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wifi_tab_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WifiTabEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is WifiTabEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'WifiTabEvent()';
  }
}

/// @nodoc
class $WifiTabEventCopyWith<$Res> {
  $WifiTabEventCopyWith(WifiTabEvent _, $Res Function(WifiTabEvent) __);
}

/// @nodoc

class _WifiTabEvent implements WifiTabEvent {
  const _WifiTabEvent();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _WifiTabEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'WifiTabEvent()';
  }
}

/// @nodoc

class UnWifiTabEvent implements WifiTabEvent {
  const UnWifiTabEvent();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is UnWifiTabEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'WifiTabEvent.uninitialized()';
  }
}

/// @nodoc

class LoadWifiTabEvent implements WifiTabEvent {
  const LoadWifiTabEvent();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is LoadWifiTabEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'WifiTabEvent.load()';
  }
}

/// @nodoc

class AddWifiTabEvent implements WifiTabEvent {
  const AddWifiTabEvent(this.name, this.SSID, this.psk);

  final String name;
  final String SSID;
  final String psk;

  /// Create a copy of WifiTabEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AddWifiTabEventCopyWith<AddWifiTabEvent> get copyWith =>
      _$AddWifiTabEventCopyWithImpl<AddWifiTabEvent>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AddWifiTabEvent &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.SSID, SSID) || other.SSID == SSID) &&
            (identical(other.psk, psk) || other.psk == psk));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, SSID, psk);

  @override
  String toString() {
    return 'WifiTabEvent.add(name: $name, SSID: $SSID, psk: $psk)';
  }
}

/// @nodoc
abstract mixin class $AddWifiTabEventCopyWith<$Res>
    implements $WifiTabEventCopyWith<$Res> {
  factory $AddWifiTabEventCopyWith(
          AddWifiTabEvent value, $Res Function(AddWifiTabEvent) _then) =
      _$AddWifiTabEventCopyWithImpl;
  @useResult
  $Res call({String name, String SSID, String psk});
}

/// @nodoc
class _$AddWifiTabEventCopyWithImpl<$Res>
    implements $AddWifiTabEventCopyWith<$Res> {
  _$AddWifiTabEventCopyWithImpl(this._self, this._then);

  final AddWifiTabEvent _self;
  final $Res Function(AddWifiTabEvent) _then;

  /// Create a copy of WifiTabEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? SSID = null,
    Object? psk = null,
  }) {
    return _then(AddWifiTabEvent(
      null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      null == SSID
          ? _self.SSID
          : SSID // ignore: cast_nullable_to_non_nullable
              as String,
      null == psk
          ? _self.psk
          : psk // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class RemoveWifiTabEvent implements WifiTabEvent {
  const RemoveWifiTabEvent(this.connectionId);

  final String connectionId;

  /// Create a copy of WifiTabEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RemoveWifiTabEventCopyWith<RemoveWifiTabEvent> get copyWith =>
      _$RemoveWifiTabEventCopyWithImpl<RemoveWifiTabEvent>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RemoveWifiTabEvent &&
            (identical(other.connectionId, connectionId) ||
                other.connectionId == connectionId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, connectionId);

  @override
  String toString() {
    return 'WifiTabEvent.remove(connectionId: $connectionId)';
  }
}

/// @nodoc
abstract mixin class $RemoveWifiTabEventCopyWith<$Res>
    implements $WifiTabEventCopyWith<$Res> {
  factory $RemoveWifiTabEventCopyWith(
          RemoveWifiTabEvent value, $Res Function(RemoveWifiTabEvent) _then) =
      _$RemoveWifiTabEventCopyWithImpl;
  @useResult
  $Res call({String connectionId});
}

/// @nodoc
class _$RemoveWifiTabEventCopyWithImpl<$Res>
    implements $RemoveWifiTabEventCopyWith<$Res> {
  _$RemoveWifiTabEventCopyWithImpl(this._self, this._then);

  final RemoveWifiTabEvent _self;
  final $Res Function(RemoveWifiTabEvent) _then;

  /// Create a copy of WifiTabEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? connectionId = null,
  }) {
    return _then(RemoveWifiTabEvent(
      null == connectionId
          ? _self.connectionId
          : connectionId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class EnableWifiTabEvent implements WifiTabEvent {
  const EnableWifiTabEvent(this.connectionId, this.value);

  final String connectionId;
  final bool value;

  /// Create a copy of WifiTabEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EnableWifiTabEventCopyWith<EnableWifiTabEvent> get copyWith =>
      _$EnableWifiTabEventCopyWithImpl<EnableWifiTabEvent>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EnableWifiTabEvent &&
            (identical(other.connectionId, connectionId) ||
                other.connectionId == connectionId) &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, connectionId, value);

  @override
  String toString() {
    return 'WifiTabEvent.enable(connectionId: $connectionId, value: $value)';
  }
}

/// @nodoc
abstract mixin class $EnableWifiTabEventCopyWith<$Res>
    implements $WifiTabEventCopyWith<$Res> {
  factory $EnableWifiTabEventCopyWith(
          EnableWifiTabEvent value, $Res Function(EnableWifiTabEvent) _then) =
      _$EnableWifiTabEventCopyWithImpl;
  @useResult
  $Res call({String connectionId, bool value});
}

/// @nodoc
class _$EnableWifiTabEventCopyWithImpl<$Res>
    implements $EnableWifiTabEventCopyWith<$Res> {
  _$EnableWifiTabEventCopyWithImpl(this._self, this._then);

  final EnableWifiTabEvent _self;
  final $Res Function(EnableWifiTabEvent) _then;

  /// Create a copy of WifiTabEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? connectionId = null,
    Object? value = null,
  }) {
    return _then(EnableWifiTabEvent(
      null == connectionId
          ? _self.connectionId
          : connectionId // ignore: cast_nullable_to_non_nullable
              as String,
      null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
