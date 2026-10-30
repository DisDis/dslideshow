// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'backend_version_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BackendVersionState {
  BackendVersionStatus get status;
  String? get version;
  BackendCompatibility get compatibility;

  /// Create a copy of BackendVersionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BackendVersionStateCopyWith<BackendVersionState> get copyWith =>
      _$BackendVersionStateCopyWithImpl<BackendVersionState>(
        this as BackendVersionState,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    final _this = this as BackendVersionState;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BackendVersionState &&
            (identical(other.status, _this.status) ||
                other.status == _this.status) &&
            (identical(other.version, _this.version) ||
                other.version == _this.version) &&
            (identical(other.compatibility, _this.compatibility) ||
                other.compatibility == _this.compatibility));
  }

  @override
  int get hashCode {
    final _this = this as BackendVersionState;
    return Object.hash(
      runtimeType,
      _this.status,
      _this.version,
      _this.compatibility,
    );
  }

  @override
  String toString() {
    final _this = this as BackendVersionState;
    return 'BackendVersionState(status: ${_this.status}, version: ${_this.version}, compatibility: ${_this.compatibility})';
  }
}

/// @nodoc
abstract mixin class $BackendVersionStateCopyWith<$Res> {
  factory $BackendVersionStateCopyWith(
    BackendVersionState value,
    $Res Function(BackendVersionState) _then,
  ) = _$BackendVersionStateCopyWithImpl;
  @useResult
  $Res call({
    BackendVersionStatus status,
    String? version,
    BackendCompatibility compatibility,
  });
}

/// @nodoc
class _$BackendVersionStateCopyWithImpl<$Res>
    implements $BackendVersionStateCopyWith<$Res> {
  _$BackendVersionStateCopyWithImpl(this._self, this._then);

  final BackendVersionState _self;
  final $Res Function(BackendVersionState) _then;

  /// Create a copy of BackendVersionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? version = freezed,
    Object? compatibility = null,
  }) {
    return _then(
      BackendVersionState(
        status: null == status
            ? _self.status
            : status // ignore: cast_nullable_to_non_nullable
                  as BackendVersionStatus,
        version: freezed == version
            ? _self.version
            : version // ignore: cast_nullable_to_non_nullable
                  as String?,
        compatibility: null == compatibility
            ? _self.compatibility
            : compatibility // ignore: cast_nullable_to_non_nullable
                  as BackendCompatibility,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [BackendVersionState].
extension BackendVersionStatePatterns on BackendVersionState {
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
    TResult Function(_BackendVersionState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BackendVersionState() when $default != null:
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
    TResult Function(_BackendVersionState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BackendVersionState():
        return $default(_that);
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
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_BackendVersionState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BackendVersionState() when $default != null:
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
      BackendVersionStatus status,
      String? version,
      BackendCompatibility compatibility,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BackendVersionState() when $default != null:
        return $default(_that.status, _that.version, _that.compatibility);
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
      BackendVersionStatus status,
      String? version,
      BackendCompatibility compatibility,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BackendVersionState():
        return $default(_that.status, _that.version, _that.compatibility);
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
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
      BackendVersionStatus status,
      String? version,
      BackendCompatibility compatibility,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BackendVersionState() when $default != null:
        return $default(_that.status, _that.version, _that.compatibility);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _BackendVersionState implements BackendVersionState {
  const _BackendVersionState({
    this.status = BackendVersionStatus.idle,
    this.version,
    this.compatibility = BackendCompatibility.unknown,
  });

  @override
  @JsonKey()
  final BackendVersionStatus status;
  @override
  final String? version;
  @override
  @JsonKey()
  final BackendCompatibility compatibility;

  /// Create a copy of BackendVersionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BackendVersionStateCopyWith<_BackendVersionState> get copyWith =>
      __$BackendVersionStateCopyWithImpl<_BackendVersionState>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BackendVersionState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.compatibility, compatibility) ||
                other.compatibility == compatibility));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, status, version, compatibility);
  }

  @override
  String toString() {
    return 'BackendVersionState(status: $status, version: $version, compatibility: $compatibility)';
  }
}

/// @nodoc
abstract mixin class _$BackendVersionStateCopyWith<$Res>
    implements $BackendVersionStateCopyWith<$Res> {
  factory _$BackendVersionStateCopyWith(
    _BackendVersionState value,
    $Res Function(_BackendVersionState) _then,
  ) = __$BackendVersionStateCopyWithImpl;
  @override
  @useResult
  $Res call({
    BackendVersionStatus status,
    String? version,
    BackendCompatibility compatibility,
  });
}

/// @nodoc
class __$BackendVersionStateCopyWithImpl<$Res>
    implements _$BackendVersionStateCopyWith<$Res> {
  __$BackendVersionStateCopyWithImpl(this._self, this._then);

  final _BackendVersionState _self;
  final $Res Function(_BackendVersionState) _then;

  /// Create a copy of BackendVersionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? status = null,
    Object? version = freezed,
    Object? compatibility = null,
  }) {
    return _then(
      _BackendVersionState(
        status: null == status
            ? _self.status
            : status // ignore: cast_nullable_to_non_nullable
                  as BackendVersionStatus,
        version: freezed == version
            ? _self.version
            : version // ignore: cast_nullable_to_non_nullable
                  as String?,
        compatibility: null == compatibility
            ? _self.compatibility
            : compatibility // ignore: cast_nullable_to_non_nullable
                  as BackendCompatibility,
      ),
    );
  }
}
