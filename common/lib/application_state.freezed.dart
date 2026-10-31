// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'application_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ApplicationState {
  bool get hasInternet;
  bool get isScreenOn;
  @JsonKey(unknownEnumValue: StorageStatusEnum.off)
  StorageStatusEnum get storageStatus;
  bool get isMenu;
  bool get isPaused;
  bool get isMotion;

  /// Create a copy of ApplicationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ApplicationStateCopyWith<ApplicationState> get copyWith =>
      _$ApplicationStateCopyWithImpl<ApplicationState>(
        this as ApplicationState,
        _$identity,
      );

  /// Serializes this ApplicationState to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as ApplicationState;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ApplicationState &&
            (identical(other.hasInternet, _this.hasInternet) ||
                other.hasInternet == _this.hasInternet) &&
            (identical(other.isScreenOn, _this.isScreenOn) ||
                other.isScreenOn == _this.isScreenOn) &&
            (identical(other.storageStatus, _this.storageStatus) ||
                other.storageStatus == _this.storageStatus) &&
            (identical(other.isMenu, _this.isMenu) ||
                other.isMenu == _this.isMenu) &&
            (identical(other.isPaused, _this.isPaused) ||
                other.isPaused == _this.isPaused) &&
            (identical(other.isMotion, _this.isMotion) ||
                other.isMotion == _this.isMotion));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as ApplicationState;
    return Object.hash(
      runtimeType,
      _this.hasInternet,
      _this.isScreenOn,
      _this.storageStatus,
      _this.isMenu,
      _this.isPaused,
      _this.isMotion,
    );
  }

  @override
  String toString() {
    final _this = this as ApplicationState;
    return 'ApplicationState(hasInternet: ${_this.hasInternet}, isScreenOn: ${_this.isScreenOn}, storageStatus: ${_this.storageStatus}, isMenu: ${_this.isMenu}, isPaused: ${_this.isPaused}, isMotion: ${_this.isMotion})';
  }
}

/// @nodoc
abstract mixin class $ApplicationStateCopyWith<$Res> {
  factory $ApplicationStateCopyWith(
    ApplicationState value,
    $Res Function(ApplicationState) _then,
  ) = _$ApplicationStateCopyWithImpl;
  @useResult
  $Res call({
    bool hasInternet,
    bool isScreenOn,
    @JsonKey(unknownEnumValue: StorageStatusEnum.off)
    StorageStatusEnum storageStatus,
    bool isMenu,
    bool isPaused,
    bool isMotion,
  });
}

/// @nodoc
class _$ApplicationStateCopyWithImpl<$Res>
    implements $ApplicationStateCopyWith<$Res> {
  _$ApplicationStateCopyWithImpl(this._self, this._then);

  final ApplicationState _self;
  final $Res Function(ApplicationState) _then;

  /// Create a copy of ApplicationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasInternet = null,
    Object? isScreenOn = null,
    Object? storageStatus = null,
    Object? isMenu = null,
    Object? isPaused = null,
    Object? isMotion = null,
  }) {
    return _then(
      ApplicationState(
        hasInternet: null == hasInternet
            ? _self.hasInternet
            : hasInternet // ignore: cast_nullable_to_non_nullable
                  as bool,
        isScreenOn: null == isScreenOn
            ? _self.isScreenOn
            : isScreenOn // ignore: cast_nullable_to_non_nullable
                  as bool,
        storageStatus: null == storageStatus
            ? _self.storageStatus
            : storageStatus // ignore: cast_nullable_to_non_nullable
                  as StorageStatusEnum,
        isMenu: null == isMenu
            ? _self.isMenu
            : isMenu // ignore: cast_nullable_to_non_nullable
                  as bool,
        isPaused: null == isPaused
            ? _self.isPaused
            : isPaused // ignore: cast_nullable_to_non_nullable
                  as bool,
        isMotion: null == isMotion
            ? _self.isMotion
            : isMotion // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [ApplicationState].
extension ApplicationStatePatterns on ApplicationState {
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
    TResult Function(_ApplicationState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ApplicationState() when $default != null:
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
    TResult Function(_ApplicationState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ApplicationState():
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
    TResult? Function(_ApplicationState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ApplicationState() when $default != null:
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
      bool hasInternet,
      bool isScreenOn,
      @JsonKey(unknownEnumValue: StorageStatusEnum.off)
      StorageStatusEnum storageStatus,
      bool isMenu,
      bool isPaused,
      bool isMotion,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ApplicationState() when $default != null:
        return $default(
          _that.hasInternet,
          _that.isScreenOn,
          _that.storageStatus,
          _that.isMenu,
          _that.isPaused,
          _that.isMotion,
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
      bool hasInternet,
      bool isScreenOn,
      @JsonKey(unknownEnumValue: StorageStatusEnum.off)
      StorageStatusEnum storageStatus,
      bool isMenu,
      bool isPaused,
      bool isMotion,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ApplicationState():
        return $default(
          _that.hasInternet,
          _that.isScreenOn,
          _that.storageStatus,
          _that.isMenu,
          _that.isPaused,
          _that.isMotion,
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
      bool hasInternet,
      bool isScreenOn,
      @JsonKey(unknownEnumValue: StorageStatusEnum.off)
      StorageStatusEnum storageStatus,
      bool isMenu,
      bool isPaused,
      bool isMotion,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ApplicationState() when $default != null:
        return $default(
          _that.hasInternet,
          _that.isScreenOn,
          _that.storageStatus,
          _that.isMenu,
          _that.isPaused,
          _that.isMotion,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable()
class _ApplicationState implements ApplicationState {
  const _ApplicationState({
    this.hasInternet = true,
    this.isScreenOn = true,
    @JsonKey(unknownEnumValue: StorageStatusEnum.off)
    this.storageStatus = StorageStatusEnum.done,
    this.isMenu = false,
    this.isPaused = false,
    this.isMotion = true,
  });
  factory _ApplicationState.fromJson(Map<String, dynamic> json) =>
      _$ApplicationStateFromJson(json);

  @override
  @JsonKey()
  final bool hasInternet;
  @override
  @JsonKey()
  final bool isScreenOn;
  @override
  @JsonKey(unknownEnumValue: StorageStatusEnum.off)
  final StorageStatusEnum storageStatus;
  @override
  @JsonKey()
  final bool isMenu;
  @override
  @JsonKey()
  final bool isPaused;
  @override
  @JsonKey()
  final bool isMotion;

  /// Create a copy of ApplicationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ApplicationStateCopyWith<_ApplicationState> get copyWith =>
      __$ApplicationStateCopyWithImpl<_ApplicationState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ApplicationStateToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ApplicationState &&
            (identical(other.hasInternet, hasInternet) ||
                other.hasInternet == hasInternet) &&
            (identical(other.isScreenOn, isScreenOn) ||
                other.isScreenOn == isScreenOn) &&
            (identical(other.storageStatus, storageStatus) ||
                other.storageStatus == storageStatus) &&
            (identical(other.isMenu, isMenu) || other.isMenu == isMenu) &&
            (identical(other.isPaused, isPaused) ||
                other.isPaused == isPaused) &&
            (identical(other.isMotion, isMotion) ||
                other.isMotion == isMotion));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      hasInternet,
      isScreenOn,
      storageStatus,
      isMenu,
      isPaused,
      isMotion,
    );
  }

  @override
  String toString() {
    return 'ApplicationState(hasInternet: $hasInternet, isScreenOn: $isScreenOn, storageStatus: $storageStatus, isMenu: $isMenu, isPaused: $isPaused, isMotion: $isMotion)';
  }
}

/// @nodoc
abstract mixin class _$ApplicationStateCopyWith<$Res>
    implements $ApplicationStateCopyWith<$Res> {
  factory _$ApplicationStateCopyWith(
    _ApplicationState value,
    $Res Function(_ApplicationState) _then,
  ) = __$ApplicationStateCopyWithImpl;
  @override
  @useResult
  $Res call({
    bool hasInternet,
    bool isScreenOn,
    @JsonKey(unknownEnumValue: StorageStatusEnum.off)
    StorageStatusEnum storageStatus,
    bool isMenu,
    bool isPaused,
    bool isMotion,
  });
}

/// @nodoc
class __$ApplicationStateCopyWithImpl<$Res>
    implements _$ApplicationStateCopyWith<$Res> {
  __$ApplicationStateCopyWithImpl(this._self, this._then);

  final _ApplicationState _self;
  final $Res Function(_ApplicationState) _then;

  /// Create a copy of ApplicationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? hasInternet = null,
    Object? isScreenOn = null,
    Object? storageStatus = null,
    Object? isMenu = null,
    Object? isPaused = null,
    Object? isMotion = null,
  }) {
    return _then(
      _ApplicationState(
        hasInternet: null == hasInternet
            ? _self.hasInternet
            : hasInternet // ignore: cast_nullable_to_non_nullable
                  as bool,
        isScreenOn: null == isScreenOn
            ? _self.isScreenOn
            : isScreenOn // ignore: cast_nullable_to_non_nullable
                  as bool,
        storageStatus: null == storageStatus
            ? _self.storageStatus
            : storageStatus // ignore: cast_nullable_to_non_nullable
                  as StorageStatusEnum,
        isMenu: null == isMenu
            ? _self.isMenu
            : isMenu // ignore: cast_nullable_to_non_nullable
                  as bool,
        isPaused: null == isPaused
            ? _self.isPaused
            : isPaused // ignore: cast_nullable_to_non_nullable
                  as bool,
        isMotion: null == isMotion
            ? _self.isMotion
            : isMotion // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}
