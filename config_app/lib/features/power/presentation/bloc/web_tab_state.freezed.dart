// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'web_tab_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WebTabState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is WebTabState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'WebTabState()';
  }
}

/// @nodoc
class $WebTabStateCopyWith<$Res> {
  $WebTabStateCopyWith(WebTabState _, $Res Function(WebTabState) __);
}

/// Adds pattern-matching-related methods to [WebTabState].
extension WebTabStatePatterns on WebTabState {
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
    TResult Function(UnWebTabState value)? uninitialized,
    TResult Function(ErrorWebTabState value)? error,
    TResult Function(InWebTabState value)? initialized,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case UnWebTabState() when uninitialized != null:
        return uninitialized(_that);
      case ErrorWebTabState() when error != null:
        return error(_that);
      case InWebTabState() when initialized != null:
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
    required TResult Function(UnWebTabState value) uninitialized,
    required TResult Function(ErrorWebTabState value) error,
    required TResult Function(InWebTabState value) initialized,
  }) {
    final _that = this;
    switch (_that) {
      case UnWebTabState():
        return uninitialized(_that);
      case ErrorWebTabState():
        return error(_that);
      case InWebTabState():
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
    TResult? Function(UnWebTabState value)? uninitialized,
    TResult? Function(ErrorWebTabState value)? error,
    TResult? Function(InWebTabState value)? initialized,
  }) {
    final _that = this;
    switch (_that) {
      case UnWebTabState() when uninitialized != null:
        return uninitialized(_that);
      case ErrorWebTabState() when error != null:
        return error(_that);
      case InWebTabState() when initialized != null:
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
      case UnWebTabState() when uninitialized != null:
        return uninitialized();
      case ErrorWebTabState() when error != null:
        return error(_that.errorMessage);
      case InWebTabState() when initialized != null:
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
      case UnWebTabState():
        return uninitialized();
      case ErrorWebTabState():
        return error(_that.errorMessage);
      case InWebTabState():
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
      case UnWebTabState() when uninitialized != null:
        return uninitialized();
      case ErrorWebTabState() when error != null:
        return error(_that.errorMessage);
      case InWebTabState() when initialized != null:
        return initialized(_that.config);
      case _:
        return null;
    }
  }
}

/// @nodoc

class UnWebTabState implements WebTabState {
  const UnWebTabState();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is UnWebTabState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'WebTabState.uninitialized()';
  }
}

/// @nodoc

class ErrorWebTabState implements WebTabState {
  const ErrorWebTabState(this.errorMessage);

  final String errorMessage;

  /// Create a copy of WebTabState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ErrorWebTabStateCopyWith<ErrorWebTabState> get copyWith =>
      _$ErrorWebTabStateCopyWithImpl<ErrorWebTabState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ErrorWebTabState &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorMessage);

  @override
  String toString() {
    return 'WebTabState.error(errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class $ErrorWebTabStateCopyWith<$Res>
    implements $WebTabStateCopyWith<$Res> {
  factory $ErrorWebTabStateCopyWith(
          ErrorWebTabState value, $Res Function(ErrorWebTabState) _then) =
      _$ErrorWebTabStateCopyWithImpl;
  @useResult
  $Res call({String errorMessage});
}

/// @nodoc
class _$ErrorWebTabStateCopyWithImpl<$Res>
    implements $ErrorWebTabStateCopyWith<$Res> {
  _$ErrorWebTabStateCopyWithImpl(this._self, this._then);

  final ErrorWebTabState _self;
  final $Res Function(ErrorWebTabState) _then;

  /// Create a copy of WebTabState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? errorMessage = null,
  }) {
    return _then(ErrorWebTabState(
      null == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class InWebTabState implements WebTabState {
  const InWebTabState(this.config);

  final AppConfig config;

  /// Create a copy of WebTabState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $InWebTabStateCopyWith<InWebTabState> get copyWith =>
      _$InWebTabStateCopyWithImpl<InWebTabState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is InWebTabState &&
            (identical(other.config, config) || other.config == config));
  }

  @override
  int get hashCode => Object.hash(runtimeType, config);

  @override
  String toString() {
    return 'WebTabState.initialized(config: $config)';
  }
}

/// @nodoc
abstract mixin class $InWebTabStateCopyWith<$Res>
    implements $WebTabStateCopyWith<$Res> {
  factory $InWebTabStateCopyWith(
          InWebTabState value, $Res Function(InWebTabState) _then) =
      _$InWebTabStateCopyWithImpl;
  @useResult
  $Res call({AppConfig config});
}

/// @nodoc
class _$InWebTabStateCopyWithImpl<$Res>
    implements $InWebTabStateCopyWith<$Res> {
  _$InWebTabStateCopyWithImpl(this._self, this._then);

  final InWebTabState _self;
  final $Res Function(InWebTabState) _then;

  /// Create a copy of WebTabState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? config = null,
  }) {
    return _then(InWebTabState(
      null == config
          ? _self.config
          : config // ignore: cast_nullable_to_non_nullable
              as AppConfig,
    ));
  }
}

// dart format on
