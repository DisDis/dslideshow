// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'screen_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ScreenState {
  bool? get isScreenOn;
  bool get autoWakeEnabled;
  ScreenPhase get phase;

  /// Create a copy of ScreenState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ScreenStateCopyWith<ScreenState> get copyWith =>
      _$ScreenStateCopyWithImpl<ScreenState>(this as ScreenState, _$identity);

  @override
  bool operator ==(Object other) {
    final _this = this as ScreenState;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ScreenState &&
            (identical(other.isScreenOn, _this.isScreenOn) ||
                other.isScreenOn == _this.isScreenOn) &&
            (identical(other.autoWakeEnabled, _this.autoWakeEnabled) ||
                other.autoWakeEnabled == _this.autoWakeEnabled) &&
            (identical(other.phase, _this.phase) ||
                other.phase == _this.phase));
  }

  @override
  int get hashCode {
    final _this = this as ScreenState;
    return Object.hash(
      runtimeType,
      _this.isScreenOn,
      _this.autoWakeEnabled,
      _this.phase,
    );
  }

  @override
  String toString() {
    final _this = this as ScreenState;
    return 'ScreenState(isScreenOn: ${_this.isScreenOn}, autoWakeEnabled: ${_this.autoWakeEnabled}, phase: ${_this.phase})';
  }
}

/// @nodoc
abstract mixin class $ScreenStateCopyWith<$Res> {
  factory $ScreenStateCopyWith(
    ScreenState value,
    $Res Function(ScreenState) _then,
  ) = _$ScreenStateCopyWithImpl;
  @useResult
  $Res call({bool? isScreenOn, bool autoWakeEnabled, ScreenPhase phase});
}

/// @nodoc
class _$ScreenStateCopyWithImpl<$Res> implements $ScreenStateCopyWith<$Res> {
  _$ScreenStateCopyWithImpl(this._self, this._then);

  final ScreenState _self;
  final $Res Function(ScreenState) _then;

  /// Create a copy of ScreenState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isScreenOn = freezed,
    Object? autoWakeEnabled = null,
    Object? phase = null,
  }) {
    return _then(
      ScreenState(
        isScreenOn: freezed == isScreenOn
            ? _self.isScreenOn
            : isScreenOn // ignore: cast_nullable_to_non_nullable
                  as bool?,
        autoWakeEnabled: null == autoWakeEnabled
            ? _self.autoWakeEnabled
            : autoWakeEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        phase: null == phase
            ? _self.phase
            : phase // ignore: cast_nullable_to_non_nullable
                  as ScreenPhase,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [ScreenState].
extension ScreenStatePatterns on ScreenState {
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
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ScreenState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ScreenState() when $default != null:
        return $default(_that);
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
  TResult map<TResult extends Object?>(
    TResult Function(_ScreenState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ScreenState():
        return $default(_that);
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
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ScreenState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ScreenState() when $default != null:
        return $default(_that);
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
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(bool? isScreenOn, bool autoWakeEnabled, ScreenPhase phase)?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ScreenState() when $default != null:
        return $default(_that.isScreenOn, _that.autoWakeEnabled, _that.phase);
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
  TResult when<TResult extends Object?>(
    TResult Function(bool? isScreenOn, bool autoWakeEnabled, ScreenPhase phase)
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ScreenState():
        return $default(_that.isScreenOn, _that.autoWakeEnabled, _that.phase);
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
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
      bool? isScreenOn,
      bool autoWakeEnabled,
      ScreenPhase phase,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ScreenState() when $default != null:
        return $default(_that.isScreenOn, _that.autoWakeEnabled, _that.phase);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ScreenState implements ScreenState {
  const _ScreenState({
    required this.isScreenOn,
    required this.autoWakeEnabled,
    required this.phase,
  });

  @override
  final bool? isScreenOn;
  @override
  final bool autoWakeEnabled;
  @override
  final ScreenPhase phase;

  /// Create a copy of ScreenState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ScreenStateCopyWith<_ScreenState> get copyWith =>
      __$ScreenStateCopyWithImpl<_ScreenState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ScreenState &&
            (identical(other.isScreenOn, isScreenOn) ||
                other.isScreenOn == isScreenOn) &&
            (identical(other.autoWakeEnabled, autoWakeEnabled) ||
                other.autoWakeEnabled == autoWakeEnabled) &&
            (identical(other.phase, phase) || other.phase == phase));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, isScreenOn, autoWakeEnabled, phase);
  }

  @override
  String toString() {
    return 'ScreenState(isScreenOn: $isScreenOn, autoWakeEnabled: $autoWakeEnabled, phase: $phase)';
  }
}

/// @nodoc
abstract mixin class _$ScreenStateCopyWith<$Res>
    implements $ScreenStateCopyWith<$Res> {
  factory _$ScreenStateCopyWith(
    _ScreenState value,
    $Res Function(_ScreenState) _then,
  ) = __$ScreenStateCopyWithImpl;
  @override
  @useResult
  $Res call({bool? isScreenOn, bool autoWakeEnabled, ScreenPhase phase});
}

/// @nodoc
class __$ScreenStateCopyWithImpl<$Res> implements _$ScreenStateCopyWith<$Res> {
  __$ScreenStateCopyWithImpl(this._self, this._then);

  final _ScreenState _self;
  final $Res Function(_ScreenState) _then;

  /// Create a copy of ScreenState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isScreenOn = freezed,
    Object? autoWakeEnabled = null,
    Object? phase = null,
  }) {
    return _then(
      _ScreenState(
        isScreenOn: freezed == isScreenOn
            ? _self.isScreenOn
            : isScreenOn // ignore: cast_nullable_to_non_nullable
                  as bool?,
        autoWakeEnabled: null == autoWakeEnabled
            ? _self.autoWakeEnabled
            : autoWakeEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        phase: null == phase
            ? _self.phase
            : phase // ignore: cast_nullable_to_non_nullable
                  as ScreenPhase,
      ),
    );
  }
}
