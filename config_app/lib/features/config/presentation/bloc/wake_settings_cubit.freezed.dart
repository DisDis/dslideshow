// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wake_settings_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WakeSettingsState {
  NightModeConfig get config;
  Map<WakeField, String> get inputs;
  Map<WakeField, WakeInputError> get errors;
  FrameState? get device;

  /// Create a copy of WakeSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WakeSettingsStateCopyWith<WakeSettingsState> get copyWith =>
      _$WakeSettingsStateCopyWithImpl<WakeSettingsState>(
        this as WakeSettingsState,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    final _this = this as WakeSettingsState;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WakeSettingsState &&
            (identical(other.config, _this.config) ||
                other.config == _this.config) &&
            const DeepCollectionEquality().equals(other.inputs, _this.inputs) &&
            const DeepCollectionEquality().equals(other.errors, _this.errors) &&
            (identical(other.device, _this.device) ||
                other.device == _this.device));
  }

  @override
  int get hashCode {
    final _this = this as WakeSettingsState;
    return Object.hash(
      runtimeType,
      _this.config,
      const DeepCollectionEquality().hash(_this.inputs),
      const DeepCollectionEquality().hash(_this.errors),
      _this.device,
    );
  }

  @override
  String toString() {
    final _this = this as WakeSettingsState;
    return 'WakeSettingsState(config: ${_this.config}, inputs: ${_this.inputs}, errors: ${_this.errors}, device: ${_this.device})';
  }
}

/// @nodoc
abstract mixin class $WakeSettingsStateCopyWith<$Res> {
  factory $WakeSettingsStateCopyWith(
    WakeSettingsState value,
    $Res Function(WakeSettingsState) _then,
  ) = _$WakeSettingsStateCopyWithImpl;
  @useResult
  $Res call({
    NightModeConfig config,
    Map<WakeField, String> inputs,
    Map<WakeField, WakeInputError> errors,
    FrameState? device,
  });

  $NightModeConfigCopyWith<$Res> get config;
  $FrameStateCopyWith<$Res>? get device;
}

/// @nodoc
class _$WakeSettingsStateCopyWithImpl<$Res>
    implements $WakeSettingsStateCopyWith<$Res> {
  _$WakeSettingsStateCopyWithImpl(this._self, this._then);

  final WakeSettingsState _self;
  final $Res Function(WakeSettingsState) _then;

  /// Create a copy of WakeSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? config = null,
    Object? inputs = null,
    Object? errors = null,
    Object? device = freezed,
  }) {
    return _then(
      WakeSettingsState(
        config: null == config
            ? _self.config
            : config // ignore: cast_nullable_to_non_nullable
                  as NightModeConfig,
        inputs: null == inputs
            ? _self.inputs
            : inputs // ignore: cast_nullable_to_non_nullable
                  as Map<WakeField, String>,
        errors: null == errors
            ? _self.errors
            : errors // ignore: cast_nullable_to_non_nullable
                  as Map<WakeField, WakeInputError>,
        device: freezed == device
            ? _self.device
            : device // ignore: cast_nullable_to_non_nullable
                  as FrameState?,
      ),
    );
  }

  /// Create a copy of WakeSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NightModeConfigCopyWith<$Res> get config {
    return $NightModeConfigCopyWith<$Res>(_self.config, (value) {
      return _then(_self.copyWith(config: value));
    });
  }

  /// Create a copy of WakeSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FrameStateCopyWith<$Res>? get device {
    if (_self.device == null) {
      return null;
    }

    return $FrameStateCopyWith<$Res>(_self.device!, (value) {
      return _then(_self.copyWith(device: value));
    });
  }
}

/// Adds pattern-matching-related methods to [WakeSettingsState].
extension WakeSettingsStatePatterns on WakeSettingsState {
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
    TResult Function(_WakeSettingsState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WakeSettingsState() when $default != null:
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
    TResult Function(_WakeSettingsState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WakeSettingsState():
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
    TResult? Function(_WakeSettingsState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WakeSettingsState() when $default != null:
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
    TResult Function(
      NightModeConfig config,
      Map<WakeField, String> inputs,
      Map<WakeField, WakeInputError> errors,
      FrameState? device,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WakeSettingsState() when $default != null:
        return $default(_that.config, _that.inputs, _that.errors, _that.device);
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
    TResult Function(
      NightModeConfig config,
      Map<WakeField, String> inputs,
      Map<WakeField, WakeInputError> errors,
      FrameState? device,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WakeSettingsState():
        return $default(_that.config, _that.inputs, _that.errors, _that.device);
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
      NightModeConfig config,
      Map<WakeField, String> inputs,
      Map<WakeField, WakeInputError> errors,
      FrameState? device,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WakeSettingsState() when $default != null:
        return $default(_that.config, _that.inputs, _that.errors, _that.device);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _WakeSettingsState extends WakeSettingsState {
  const _WakeSettingsState({
    required this.config,
    required Map<WakeField, String> inputs,
    Map<WakeField, WakeInputError> errors = const {},
    this.device,
  }) : _inputs = inputs,
       _errors = errors,
       super._();

  @override
  final NightModeConfig config;
  final Map<WakeField, String> _inputs;
  @override
  Map<WakeField, String> get inputs {
    if (_inputs is EqualUnmodifiableMapView) return _inputs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_inputs);
  }

  final Map<WakeField, WakeInputError> _errors;
  @override
  @JsonKey()
  Map<WakeField, WakeInputError> get errors {
    if (_errors is EqualUnmodifiableMapView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_errors);
  }

  @override
  final FrameState? device;

  /// Create a copy of WakeSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WakeSettingsStateCopyWith<_WakeSettingsState> get copyWith =>
      __$WakeSettingsStateCopyWithImpl<_WakeSettingsState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WakeSettingsState &&
            (identical(other.config, config) || other.config == config) &&
            const DeepCollectionEquality().equals(other.inputs, _inputs) &&
            const DeepCollectionEquality().equals(other.errors, _errors) &&
            (identical(other.device, device) || other.device == device));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      config,
      const DeepCollectionEquality().hash(_inputs),
      const DeepCollectionEquality().hash(_errors),
      device,
    );
  }

  @override
  String toString() {
    return 'WakeSettingsState(config: $config, inputs: $inputs, errors: $errors, device: $device)';
  }
}

/// @nodoc
abstract mixin class _$WakeSettingsStateCopyWith<$Res>
    implements $WakeSettingsStateCopyWith<$Res> {
  factory _$WakeSettingsStateCopyWith(
    _WakeSettingsState value,
    $Res Function(_WakeSettingsState) _then,
  ) = __$WakeSettingsStateCopyWithImpl;
  @override
  @useResult
  $Res call({
    NightModeConfig config,
    Map<WakeField, String> inputs,
    Map<WakeField, WakeInputError> errors,
    FrameState? device,
  });

  @override
  $NightModeConfigCopyWith<$Res> get config;
  @override
  $FrameStateCopyWith<$Res>? get device;
}

/// @nodoc
class __$WakeSettingsStateCopyWithImpl<$Res>
    implements _$WakeSettingsStateCopyWith<$Res> {
  __$WakeSettingsStateCopyWithImpl(this._self, this._then);

  final _WakeSettingsState _self;
  final $Res Function(_WakeSettingsState) _then;

  /// Create a copy of WakeSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? config = null,
    Object? inputs = null,
    Object? errors = null,
    Object? device = freezed,
  }) {
    return _then(
      _WakeSettingsState(
        config: null == config
            ? _self.config
            : config // ignore: cast_nullable_to_non_nullable
                  as NightModeConfig,
        inputs: null == inputs
            ? _self._inputs
            : inputs // ignore: cast_nullable_to_non_nullable
                  as Map<WakeField, String>,
        errors: null == errors
            ? _self._errors
            : errors // ignore: cast_nullable_to_non_nullable
                  as Map<WakeField, WakeInputError>,
        device: freezed == device
            ? _self.device
            : device // ignore: cast_nullable_to_non_nullable
                  as FrameState?,
      ),
    );
  }

  /// Create a copy of WakeSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NightModeConfigCopyWith<$Res> get config {
    return $NightModeConfigCopyWith<$Res>(_self.config, (value) {
      return _then(_self.copyWith(config: value));
    });
  }

  /// Create a copy of WakeSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FrameStateCopyWith<$Res>? get device {
    if (_self.device == null) {
      return null;
    }

    return $FrameStateCopyWith<$Res>(_self.device!, (value) {
      return _then(_self.copyWith(device: value));
    });
  }
}
