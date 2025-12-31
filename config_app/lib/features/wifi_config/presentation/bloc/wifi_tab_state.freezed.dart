// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
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

/// Adds pattern-matching-related methods to [WifiTabState].
extension WifiTabStatePatterns on WifiTabState {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UnWifiTabState value)? uninitialized,
    TResult Function(InWifiTabState value)? initialized,
    TResult Function(ErrorWifiTabState value)? error,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case UnWifiTabState() when uninitialized != null:
        return uninitialized(_that);
      case InWifiTabState() when initialized != null:
        return initialized(_that);
      case ErrorWifiTabState() when error != null:
        return error(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UnWifiTabState value) uninitialized,
    required TResult Function(InWifiTabState value) initialized,
    required TResult Function(ErrorWifiTabState value) error,
  }) {
    final _that = this;
    switch (_that) {
      case UnWifiTabState():
        return uninitialized(_that);
      case InWifiTabState():
        return initialized(_that);
      case ErrorWifiTabState():
        return error(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UnWifiTabState value)? uninitialized,
    TResult? Function(InWifiTabState value)? initialized,
    TResult? Function(ErrorWifiTabState value)? error,
  }) {
    final _that = this;
    switch (_that) {
      case UnWifiTabState() when uninitialized != null:
        return uninitialized(_that);
      case InWifiTabState() when initialized != null:
        return initialized(_that);
      case ErrorWifiTabState() when error != null:
        return error(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? uninitialized,
    TResult Function(Iterable<WiFiNetworkInfo> availableNetworks,
            Iterable<WiFiConnectionInfo> connections)?
        initialized,
    TResult Function(String errorMessage)? error,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case UnWifiTabState() when uninitialized != null:
        return uninitialized();
      case InWifiTabState() when initialized != null:
        return initialized(_that.availableNetworks, _that.connections);
      case ErrorWifiTabState() when error != null:
        return error(_that.errorMessage);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() uninitialized,
    required TResult Function(Iterable<WiFiNetworkInfo> availableNetworks,
            Iterable<WiFiConnectionInfo> connections)
        initialized,
    required TResult Function(String errorMessage) error,
  }) {
    final _that = this;
    switch (_that) {
      case UnWifiTabState():
        return uninitialized();
      case InWifiTabState():
        return initialized(_that.availableNetworks, _that.connections);
      case ErrorWifiTabState():
        return error(_that.errorMessage);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? uninitialized,
    TResult? Function(Iterable<WiFiNetworkInfo> availableNetworks,
            Iterable<WiFiConnectionInfo> connections)?
        initialized,
    TResult? Function(String errorMessage)? error,
  }) {
    final _that = this;
    switch (_that) {
      case UnWifiTabState() when uninitialized != null:
        return uninitialized();
      case InWifiTabState() when initialized != null:
        return initialized(_that.availableNetworks, _that.connections);
      case ErrorWifiTabState() when error != null:
        return error(_that.errorMessage);
      case _:
        return null;
    }
  }
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
