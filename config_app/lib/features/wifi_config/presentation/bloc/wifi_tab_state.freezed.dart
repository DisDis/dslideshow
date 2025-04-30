// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wifi_tab_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WifiTabState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is WifiTabState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'WifiTabState()';
  }
}

/// @nodoc
class $WifiTabStateCopyWith<$Res> {
  $WifiTabStateCopyWith(WifiTabState _, $Res Function(WifiTabState) __);
}

/// @nodoc

class UnWifiTabState implements WifiTabState {
  const UnWifiTabState();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is UnWifiTabState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'WifiTabState.uninitialized()';
  }
}

/// @nodoc

class InWifiTabState implements WifiTabState {
  const InWifiTabState(
      {required this.availableNetworks, required this.connections});

  final Iterable<WiFiNetworkInfo> availableNetworks;
  final Iterable<WiFiConnectionInfo> connections;

  /// Create a copy of WifiTabState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $InWifiTabStateCopyWith<InWifiTabState> get copyWith =>
      _$InWifiTabStateCopyWithImpl<InWifiTabState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is InWifiTabState &&
            const DeepCollectionEquality()
                .equals(other.availableNetworks, availableNetworks) &&
            const DeepCollectionEquality()
                .equals(other.connections, connections));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(availableNetworks),
      const DeepCollectionEquality().hash(connections));

  @override
  String toString() {
    return 'WifiTabState.initialized(availableNetworks: $availableNetworks, connections: $connections)';
  }
}

/// @nodoc
abstract mixin class $InWifiTabStateCopyWith<$Res>
    implements $WifiTabStateCopyWith<$Res> {
  factory $InWifiTabStateCopyWith(
          InWifiTabState value, $Res Function(InWifiTabState) _then) =
      _$InWifiTabStateCopyWithImpl;
  @useResult
  $Res call(
      {Iterable<WiFiNetworkInfo> availableNetworks,
      Iterable<WiFiConnectionInfo> connections});
}

/// @nodoc
class _$InWifiTabStateCopyWithImpl<$Res>
    implements $InWifiTabStateCopyWith<$Res> {
  _$InWifiTabStateCopyWithImpl(this._self, this._then);

  final InWifiTabState _self;
  final $Res Function(InWifiTabState) _then;

  /// Create a copy of WifiTabState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? availableNetworks = null,
    Object? connections = null,
  }) {
    return _then(InWifiTabState(
      availableNetworks: null == availableNetworks
          ? _self.availableNetworks
          : availableNetworks // ignore: cast_nullable_to_non_nullable
              as Iterable<WiFiNetworkInfo>,
      connections: null == connections
          ? _self.connections
          : connections // ignore: cast_nullable_to_non_nullable
              as Iterable<WiFiConnectionInfo>,
    ));
  }
}

/// @nodoc

class ErrorWifiTabState implements WifiTabState {
  const ErrorWifiTabState(this.errorMessage);

  final String errorMessage;

  /// Create a copy of WifiTabState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ErrorWifiTabStateCopyWith<ErrorWifiTabState> get copyWith =>
      _$ErrorWifiTabStateCopyWithImpl<ErrorWifiTabState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ErrorWifiTabState &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorMessage);

  @override
  String toString() {
    return 'WifiTabState.error(errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class $ErrorWifiTabStateCopyWith<$Res>
    implements $WifiTabStateCopyWith<$Res> {
  factory $ErrorWifiTabStateCopyWith(
          ErrorWifiTabState value, $Res Function(ErrorWifiTabState) _then) =
      _$ErrorWifiTabStateCopyWithImpl;
  @useResult
  $Res call({String errorMessage});
}

/// @nodoc
class _$ErrorWifiTabStateCopyWithImpl<$Res>
    implements $ErrorWifiTabStateCopyWith<$Res> {
  _$ErrorWifiTabStateCopyWithImpl(this._self, this._then);

  final ErrorWifiTabState _self;
  final $Res Function(ErrorWifiTabState) _then;

  /// Create a copy of WifiTabState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? errorMessage = null,
  }) {
    return _then(ErrorWifiTabState(
      null == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
