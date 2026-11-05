// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'night_mode_policy.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NightModeState {
  bool get enabled;
  NightMode get mode;
  bool get inSchedule;
  bool get automaticWakeBlocked;
  AutomaticSleepReason get reason;
  AmbientLightStatus get lightStatus;
  int? get illuminance;
  DateTime? get lightReceivedAt;
  DateTime? get nextBoundary;

  /// Create a copy of NightModeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NightModeStateCopyWith<NightModeState> get copyWith =>
      _$NightModeStateCopyWithImpl<NightModeState>(
        this as NightModeState,
        _$identity,
      );

  /// Serializes this NightModeState to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as NightModeState;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NightModeState &&
            (identical(other.enabled, _this.enabled) ||
                other.enabled == _this.enabled) &&
            (identical(other.mode, _this.mode) || other.mode == _this.mode) &&
            (identical(other.inSchedule, _this.inSchedule) ||
                other.inSchedule == _this.inSchedule) &&
            (identical(
                  other.automaticWakeBlocked,
                  _this.automaticWakeBlocked,
                ) ||
                other.automaticWakeBlocked == _this.automaticWakeBlocked) &&
            (identical(other.reason, _this.reason) ||
                other.reason == _this.reason) &&
            (identical(other.lightStatus, _this.lightStatus) ||
                other.lightStatus == _this.lightStatus) &&
            (identical(other.illuminance, _this.illuminance) ||
                other.illuminance == _this.illuminance) &&
            (identical(other.lightReceivedAt, _this.lightReceivedAt) ||
                other.lightReceivedAt == _this.lightReceivedAt) &&
            (identical(other.nextBoundary, _this.nextBoundary) ||
                other.nextBoundary == _this.nextBoundary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as NightModeState;
    return Object.hash(
      runtimeType,
      _this.enabled,
      _this.mode,
      _this.inSchedule,
      _this.automaticWakeBlocked,
      _this.reason,
      _this.lightStatus,
      _this.illuminance,
      _this.lightReceivedAt,
      _this.nextBoundary,
    );
  }

  @override
  String toString() {
    final _this = this as NightModeState;
    return 'NightModeState(enabled: ${_this.enabled}, mode: ${_this.mode}, inSchedule: ${_this.inSchedule}, automaticWakeBlocked: ${_this.automaticWakeBlocked}, reason: ${_this.reason}, lightStatus: ${_this.lightStatus}, illuminance: ${_this.illuminance}, lightReceivedAt: ${_this.lightReceivedAt}, nextBoundary: ${_this.nextBoundary})';
  }
}

/// @nodoc
abstract mixin class $NightModeStateCopyWith<$Res> {
  factory $NightModeStateCopyWith(
    NightModeState value,
    $Res Function(NightModeState) _then,
  ) = _$NightModeStateCopyWithImpl;
  @useResult
  $Res call({
    bool enabled,
    NightMode mode,
    bool inSchedule,
    bool automaticWakeBlocked,
    AutomaticSleepReason reason,
    AmbientLightStatus lightStatus,
    int? illuminance,
    DateTime? lightReceivedAt,
    DateTime? nextBoundary,
  });
}

/// @nodoc
class _$NightModeStateCopyWithImpl<$Res>
    implements $NightModeStateCopyWith<$Res> {
  _$NightModeStateCopyWithImpl(this._self, this._then);

  final NightModeState _self;
  final $Res Function(NightModeState) _then;

  /// Create a copy of NightModeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
    Object? mode = null,
    Object? inSchedule = null,
    Object? automaticWakeBlocked = null,
    Object? reason = null,
    Object? lightStatus = null,
    Object? illuminance = freezed,
    Object? lightReceivedAt = freezed,
    Object? nextBoundary = freezed,
  }) {
    return _then(
      NightModeState(
        enabled: null == enabled
            ? _self.enabled
            : enabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        mode: null == mode
            ? _self.mode
            : mode // ignore: cast_nullable_to_non_nullable
                  as NightMode,
        inSchedule: null == inSchedule
            ? _self.inSchedule
            : inSchedule // ignore: cast_nullable_to_non_nullable
                  as bool,
        automaticWakeBlocked: null == automaticWakeBlocked
            ? _self.automaticWakeBlocked
            : automaticWakeBlocked // ignore: cast_nullable_to_non_nullable
                  as bool,
        reason: null == reason
            ? _self.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as AutomaticSleepReason,
        lightStatus: null == lightStatus
            ? _self.lightStatus
            : lightStatus // ignore: cast_nullable_to_non_nullable
                  as AmbientLightStatus,
        illuminance: freezed == illuminance
            ? _self.illuminance
            : illuminance // ignore: cast_nullable_to_non_nullable
                  as int?,
        lightReceivedAt: freezed == lightReceivedAt
            ? _self.lightReceivedAt
            : lightReceivedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        nextBoundary: freezed == nextBoundary
            ? _self.nextBoundary
            : nextBoundary // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [NightModeState].
extension NightModeStatePatterns on NightModeState {
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
    TResult Function(_NightModeState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NightModeState() when $default != null:
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
    TResult Function(_NightModeState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NightModeState():
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
    TResult? Function(_NightModeState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NightModeState() when $default != null:
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
      bool enabled,
      NightMode mode,
      bool inSchedule,
      bool automaticWakeBlocked,
      AutomaticSleepReason reason,
      AmbientLightStatus lightStatus,
      int? illuminance,
      DateTime? lightReceivedAt,
      DateTime? nextBoundary,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NightModeState() when $default != null:
        return $default(
          _that.enabled,
          _that.mode,
          _that.inSchedule,
          _that.automaticWakeBlocked,
          _that.reason,
          _that.lightStatus,
          _that.illuminance,
          _that.lightReceivedAt,
          _that.nextBoundary,
        );
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
      bool enabled,
      NightMode mode,
      bool inSchedule,
      bool automaticWakeBlocked,
      AutomaticSleepReason reason,
      AmbientLightStatus lightStatus,
      int? illuminance,
      DateTime? lightReceivedAt,
      DateTime? nextBoundary,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NightModeState():
        return $default(
          _that.enabled,
          _that.mode,
          _that.inSchedule,
          _that.automaticWakeBlocked,
          _that.reason,
          _that.lightStatus,
          _that.illuminance,
          _that.lightReceivedAt,
          _that.nextBoundary,
        );
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
      bool enabled,
      NightMode mode,
      bool inSchedule,
      bool automaticWakeBlocked,
      AutomaticSleepReason reason,
      AmbientLightStatus lightStatus,
      int? illuminance,
      DateTime? lightReceivedAt,
      DateTime? nextBoundary,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NightModeState() when $default != null:
        return $default(
          _that.enabled,
          _that.mode,
          _that.inSchedule,
          _that.automaticWakeBlocked,
          _that.reason,
          _that.lightStatus,
          _that.illuminance,
          _that.lightReceivedAt,
          _that.nextBoundary,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable()
class _NightModeState implements NightModeState {
  const _NightModeState({
    this.enabled = false,
    this.mode = NightMode.scheduleOnly,
    this.inSchedule = false,
    this.automaticWakeBlocked = false,
    this.reason = AutomaticSleepReason.none,
    this.lightStatus = AmbientLightStatus.disabled,
    this.illuminance,
    this.lightReceivedAt,
    this.nextBoundary,
  });
  factory _NightModeState.fromJson(Map<String, dynamic> json) =>
      _$NightModeStateFromJson(json);

  @override
  @JsonKey()
  final bool enabled;
  @override
  @JsonKey()
  final NightMode mode;
  @override
  @JsonKey()
  final bool inSchedule;
  @override
  @JsonKey()
  final bool automaticWakeBlocked;
  @override
  @JsonKey()
  final AutomaticSleepReason reason;
  @override
  @JsonKey()
  final AmbientLightStatus lightStatus;
  @override
  final int? illuminance;
  @override
  final DateTime? lightReceivedAt;
  @override
  final DateTime? nextBoundary;

  /// Create a copy of NightModeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NightModeStateCopyWith<_NightModeState> get copyWith =>
      __$NightModeStateCopyWithImpl<_NightModeState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$NightModeStateToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NightModeState &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.inSchedule, inSchedule) ||
                other.inSchedule == inSchedule) &&
            (identical(other.automaticWakeBlocked, automaticWakeBlocked) ||
                other.automaticWakeBlocked == automaticWakeBlocked) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.lightStatus, lightStatus) ||
                other.lightStatus == lightStatus) &&
            (identical(other.illuminance, illuminance) ||
                other.illuminance == illuminance) &&
            (identical(other.lightReceivedAt, lightReceivedAt) ||
                other.lightReceivedAt == lightReceivedAt) &&
            (identical(other.nextBoundary, nextBoundary) ||
                other.nextBoundary == nextBoundary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      enabled,
      mode,
      inSchedule,
      automaticWakeBlocked,
      reason,
      lightStatus,
      illuminance,
      lightReceivedAt,
      nextBoundary,
    );
  }

  @override
  String toString() {
    return 'NightModeState(enabled: $enabled, mode: $mode, inSchedule: $inSchedule, automaticWakeBlocked: $automaticWakeBlocked, reason: $reason, lightStatus: $lightStatus, illuminance: $illuminance, lightReceivedAt: $lightReceivedAt, nextBoundary: $nextBoundary)';
  }
}

/// @nodoc
abstract mixin class _$NightModeStateCopyWith<$Res>
    implements $NightModeStateCopyWith<$Res> {
  factory _$NightModeStateCopyWith(
    _NightModeState value,
    $Res Function(_NightModeState) _then,
  ) = __$NightModeStateCopyWithImpl;
  @override
  @useResult
  $Res call({
    bool enabled,
    NightMode mode,
    bool inSchedule,
    bool automaticWakeBlocked,
    AutomaticSleepReason reason,
    AmbientLightStatus lightStatus,
    int? illuminance,
    DateTime? lightReceivedAt,
    DateTime? nextBoundary,
  });
}

/// @nodoc
class __$NightModeStateCopyWithImpl<$Res>
    implements _$NightModeStateCopyWith<$Res> {
  __$NightModeStateCopyWithImpl(this._self, this._then);

  final _NightModeState _self;
  final $Res Function(_NightModeState) _then;

  /// Create a copy of NightModeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? enabled = null,
    Object? mode = null,
    Object? inSchedule = null,
    Object? automaticWakeBlocked = null,
    Object? reason = null,
    Object? lightStatus = null,
    Object? illuminance = freezed,
    Object? lightReceivedAt = freezed,
    Object? nextBoundary = freezed,
  }) {
    return _then(
      _NightModeState(
        enabled: null == enabled
            ? _self.enabled
            : enabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        mode: null == mode
            ? _self.mode
            : mode // ignore: cast_nullable_to_non_nullable
                  as NightMode,
        inSchedule: null == inSchedule
            ? _self.inSchedule
            : inSchedule // ignore: cast_nullable_to_non_nullable
                  as bool,
        automaticWakeBlocked: null == automaticWakeBlocked
            ? _self.automaticWakeBlocked
            : automaticWakeBlocked // ignore: cast_nullable_to_non_nullable
                  as bool,
        reason: null == reason
            ? _self.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as AutomaticSleepReason,
        lightStatus: null == lightStatus
            ? _self.lightStatus
            : lightStatus // ignore: cast_nullable_to_non_nullable
                  as AmbientLightStatus,
        illuminance: freezed == illuminance
            ? _self.illuminance
            : illuminance // ignore: cast_nullable_to_non_nullable
                  as int?,
        lightReceivedAt: freezed == lightReceivedAt
            ? _self.lightReceivedAt
            : lightReceivedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        nextBoundary: freezed == nextBoundary
            ? _self.nextBoundary
            : nextBoundary // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
mixin _$AmbientLightReading {
  int get lux;
  DateTime get receivedAt;

  /// Create a copy of AmbientLightReading
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AmbientLightReadingCopyWith<AmbientLightReading> get copyWith =>
      _$AmbientLightReadingCopyWithImpl<AmbientLightReading>(
        this as AmbientLightReading,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    final _this = this as AmbientLightReading;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AmbientLightReading &&
            (identical(other.lux, _this.lux) || other.lux == _this.lux) &&
            (identical(other.receivedAt, _this.receivedAt) ||
                other.receivedAt == _this.receivedAt));
  }

  @override
  int get hashCode {
    final _this = this as AmbientLightReading;
    return Object.hash(runtimeType, _this.lux, _this.receivedAt);
  }

  @override
  String toString() {
    final _this = this as AmbientLightReading;
    return 'AmbientLightReading(lux: ${_this.lux}, receivedAt: ${_this.receivedAt})';
  }
}

/// @nodoc
abstract mixin class $AmbientLightReadingCopyWith<$Res> {
  factory $AmbientLightReadingCopyWith(
    AmbientLightReading value,
    $Res Function(AmbientLightReading) _then,
  ) = _$AmbientLightReadingCopyWithImpl;
  @useResult
  $Res call({int lux, DateTime receivedAt});
}

/// @nodoc
class _$AmbientLightReadingCopyWithImpl<$Res>
    implements $AmbientLightReadingCopyWith<$Res> {
  _$AmbientLightReadingCopyWithImpl(this._self, this._then);

  final AmbientLightReading _self;
  final $Res Function(AmbientLightReading) _then;

  /// Create a copy of AmbientLightReading
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? lux = null, Object? receivedAt = null}) {
    return _then(
      AmbientLightReading(
        lux: null == lux
            ? _self.lux
            : lux // ignore: cast_nullable_to_non_nullable
                  as int,
        receivedAt: null == receivedAt
            ? _self.receivedAt
            : receivedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [AmbientLightReading].
extension AmbientLightReadingPatterns on AmbientLightReading {
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
    TResult Function(_AmbientLightReading value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AmbientLightReading() when $default != null:
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
    TResult Function(_AmbientLightReading value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AmbientLightReading():
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
    TResult? Function(_AmbientLightReading value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AmbientLightReading() when $default != null:
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
    TResult Function(int lux, DateTime receivedAt)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AmbientLightReading() when $default != null:
        return $default(_that.lux, _that.receivedAt);
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
    TResult Function(int lux, DateTime receivedAt) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AmbientLightReading():
        return $default(_that.lux, _that.receivedAt);
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
    TResult? Function(int lux, DateTime receivedAt)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AmbientLightReading() when $default != null:
        return $default(_that.lux, _that.receivedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _AmbientLightReading implements AmbientLightReading {
  const _AmbientLightReading({required this.lux, required this.receivedAt});

  @override
  final int lux;
  @override
  final DateTime receivedAt;

  /// Create a copy of AmbientLightReading
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AmbientLightReadingCopyWith<_AmbientLightReading> get copyWith =>
      __$AmbientLightReadingCopyWithImpl<_AmbientLightReading>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AmbientLightReading &&
            (identical(other.lux, lux) || other.lux == lux) &&
            (identical(other.receivedAt, receivedAt) ||
                other.receivedAt == receivedAt));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, lux, receivedAt);
  }

  @override
  String toString() {
    return 'AmbientLightReading(lux: $lux, receivedAt: $receivedAt)';
  }
}

/// @nodoc
abstract mixin class _$AmbientLightReadingCopyWith<$Res>
    implements $AmbientLightReadingCopyWith<$Res> {
  factory _$AmbientLightReadingCopyWith(
    _AmbientLightReading value,
    $Res Function(_AmbientLightReading) _then,
  ) = __$AmbientLightReadingCopyWithImpl;
  @override
  @useResult
  $Res call({int lux, DateTime receivedAt});
}

/// @nodoc
class __$AmbientLightReadingCopyWithImpl<$Res>
    implements _$AmbientLightReadingCopyWith<$Res> {
  __$AmbientLightReadingCopyWithImpl(this._self, this._then);

  final _AmbientLightReading _self;
  final $Res Function(_AmbientLightReading) _then;

  /// Create a copy of AmbientLightReading
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? lux = null, Object? receivedAt = null}) {
    return _then(
      _AmbientLightReading(
        lux: null == lux
            ? _self.lux
            : lux // ignore: cast_nullable_to_non_nullable
                  as int,
        receivedAt: null == receivedAt
            ? _self.receivedAt
            : receivedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}
