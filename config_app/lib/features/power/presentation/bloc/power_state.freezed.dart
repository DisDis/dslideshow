// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'power_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PowerState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is PowerState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'PowerState()';
  }
}

/// @nodoc
class $PowerStateCopyWith<$Res> {
  $PowerStateCopyWith(PowerState _, $Res Function(PowerState) __);
}

/// Adds pattern-matching-related methods to [PowerState].
extension PowerStatePatterns on PowerState {
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
    TResult Function(UninitializedPowerState value)? uninitialized,
    TResult Function(ErrorPowerState value)? error,
    TResult Function(InitializedPowerState value)? initialized,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case UninitializedPowerState() when uninitialized != null:
        return uninitialized(_that);
      case ErrorPowerState() when error != null:
        return error(_that);
      case InitializedPowerState() when initialized != null:
        return initialized(_that);
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
    required TResult Function(UninitializedPowerState value) uninitialized,
    required TResult Function(ErrorPowerState value) error,
    required TResult Function(InitializedPowerState value) initialized,
  }) {
    final _that = this;
    switch (_that) {
      case UninitializedPowerState():
        return uninitialized(_that);
      case ErrorPowerState():
        return error(_that);
      case InitializedPowerState():
        return initialized(_that);
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
    TResult? Function(UninitializedPowerState value)? uninitialized,
    TResult? Function(ErrorPowerState value)? error,
    TResult? Function(InitializedPowerState value)? initialized,
  }) {
    final _that = this;
    switch (_that) {
      case UninitializedPowerState() when uninitialized != null:
        return uninitialized(_that);
      case ErrorPowerState() when error != null:
        return error(_that);
      case InitializedPowerState() when initialized != null:
        return initialized(_that);
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
    TResult Function(String errorMessage)? error,
    TResult Function(AppConfig config)? initialized,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case UninitializedPowerState() when uninitialized != null:
        return uninitialized();
      case ErrorPowerState() when error != null:
        return error(_that.errorMessage);
      case InitializedPowerState() when initialized != null:
        return initialized(_that.config);
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
    required TResult Function(String errorMessage) error,
    required TResult Function(AppConfig config) initialized,
  }) {
    final _that = this;
    switch (_that) {
      case UninitializedPowerState():
        return uninitialized();
      case ErrorPowerState():
        return error(_that.errorMessage);
      case InitializedPowerState():
        return initialized(_that.config);
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
    TResult? Function(String errorMessage)? error,
    TResult? Function(AppConfig config)? initialized,
  }) {
    final _that = this;
    switch (_that) {
      case UninitializedPowerState() when uninitialized != null:
        return uninitialized();
      case ErrorPowerState() when error != null:
        return error(_that.errorMessage);
      case InitializedPowerState() when initialized != null:
        return initialized(_that.config);
      case _:
        return null;
    }
  }
}

/// @nodoc

class UninitializedPowerState implements PowerState {
  const UninitializedPowerState();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is UninitializedPowerState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'PowerState.uninitialized()';
  }
}

/// @nodoc

class ErrorPowerState implements PowerState {
  const ErrorPowerState(this.errorMessage);

  final String errorMessage;

  /// Create a copy of PowerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ErrorPowerStateCopyWith<ErrorPowerState> get copyWith =>
      _$ErrorPowerStateCopyWithImpl<ErrorPowerState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ErrorPowerState &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorMessage);

  @override
  String toString() {
    return 'PowerState.error(errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class $ErrorPowerStateCopyWith<$Res>
    implements $PowerStateCopyWith<$Res> {
  factory $ErrorPowerStateCopyWith(
          ErrorPowerState value, $Res Function(ErrorPowerState) _then) =
      _$ErrorPowerStateCopyWithImpl;
  @useResult
  $Res call({String errorMessage});
}

/// @nodoc
class _$ErrorPowerStateCopyWithImpl<$Res>
    implements $ErrorPowerStateCopyWith<$Res> {
  _$ErrorPowerStateCopyWithImpl(this._self, this._then);

  final ErrorPowerState _self;
  final $Res Function(ErrorPowerState) _then;

  /// Create a copy of PowerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? errorMessage = null,
  }) {
    return _then(ErrorPowerState(
      null == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class InitializedPowerState implements PowerState {
  const InitializedPowerState(this.config);

  final AppConfig config;

  /// Create a copy of PowerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $InitializedPowerStateCopyWith<InitializedPowerState> get copyWith =>
      _$InitializedPowerStateCopyWithImpl<InitializedPowerState>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is InitializedPowerState &&
            (identical(other.config, config) || other.config == config));
  }

  @override
  int get hashCode => Object.hash(runtimeType, config);

  @override
  String toString() {
    return 'PowerState.initialized(config: $config)';
  }
}

/// @nodoc
abstract mixin class $InitializedPowerStateCopyWith<$Res>
    implements $PowerStateCopyWith<$Res> {
  factory $InitializedPowerStateCopyWith(InitializedPowerState value,
          $Res Function(InitializedPowerState) _then) =
      _$InitializedPowerStateCopyWithImpl;
  @useResult
  $Res call({AppConfig config});
}

/// @nodoc
class _$InitializedPowerStateCopyWithImpl<$Res>
    implements $InitializedPowerStateCopyWith<$Res> {
  _$InitializedPowerStateCopyWithImpl(this._self, this._then);

  final InitializedPowerState _self;
  final $Res Function(InitializedPowerState) _then;

  /// Create a copy of PowerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? config = null,
  }) {
    return _then(InitializedPowerState(
      null == config
          ? _self.config
          : config // ignore: cast_nullable_to_non_nullable
              as AppConfig,
    ));
  }
}

// dart format on
