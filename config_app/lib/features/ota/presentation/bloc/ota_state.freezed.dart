// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ota_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OtaState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is OtaState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'OtaState()';
  }
}

/// @nodoc
class $OtaStateCopyWith<$Res> {
  $OtaStateCopyWith(OtaState _, $Res Function(OtaState) __);
}

/// Adds pattern-matching-related methods to [OtaState].
extension OtaStatePatterns on OtaState {
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
    TResult Function(UninitializedOtaState value)? uninitialized,
    TResult Function(InitializedOtaState value)? initialized,
    TResult Function(UploadingOtaState value)? uploading,
    TResult Function(UploadCompleteOtaState value)? uploadComplete,
    TResult Function(ErrorOtaState value)? error,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case UninitializedOtaState() when uninitialized != null:
        return uninitialized(_that);
      case InitializedOtaState() when initialized != null:
        return initialized(_that);
      case UploadingOtaState() when uploading != null:
        return uploading(_that);
      case UploadCompleteOtaState() when uploadComplete != null:
        return uploadComplete(_that);
      case ErrorOtaState() when error != null:
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
    required TResult Function(UninitializedOtaState value) uninitialized,
    required TResult Function(InitializedOtaState value) initialized,
    required TResult Function(UploadingOtaState value) uploading,
    required TResult Function(UploadCompleteOtaState value) uploadComplete,
    required TResult Function(ErrorOtaState value) error,
  }) {
    final _that = this;
    switch (_that) {
      case UninitializedOtaState():
        return uninitialized(_that);
      case InitializedOtaState():
        return initialized(_that);
      case UploadingOtaState():
        return uploading(_that);
      case UploadCompleteOtaState():
        return uploadComplete(_that);
      case ErrorOtaState():
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
    TResult? Function(UninitializedOtaState value)? uninitialized,
    TResult? Function(InitializedOtaState value)? initialized,
    TResult? Function(UploadingOtaState value)? uploading,
    TResult? Function(UploadCompleteOtaState value)? uploadComplete,
    TResult? Function(ErrorOtaState value)? error,
  }) {
    final _that = this;
    switch (_that) {
      case UninitializedOtaState() when uninitialized != null:
        return uninitialized(_that);
      case InitializedOtaState() when initialized != null:
        return initialized(_that);
      case UploadingOtaState() when uploading != null:
        return uploading(_that);
      case UploadCompleteOtaState() when uploadComplete != null:
        return uploadComplete(_that);
      case ErrorOtaState() when error != null:
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
    TResult Function(String version)? initialized,
    TResult Function(String version, double progress)? uploading,
    TResult Function()? uploadComplete,
    TResult Function(String errorMessage)? error,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case UninitializedOtaState() when uninitialized != null:
        return uninitialized();
      case InitializedOtaState() when initialized != null:
        return initialized(_that.version);
      case UploadingOtaState() when uploading != null:
        return uploading(_that.version, _that.progress);
      case UploadCompleteOtaState() when uploadComplete != null:
        return uploadComplete();
      case ErrorOtaState() when error != null:
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
    required TResult Function(String version) initialized,
    required TResult Function(String version, double progress) uploading,
    required TResult Function() uploadComplete,
    required TResult Function(String errorMessage) error,
  }) {
    final _that = this;
    switch (_that) {
      case UninitializedOtaState():
        return uninitialized();
      case InitializedOtaState():
        return initialized(_that.version);
      case UploadingOtaState():
        return uploading(_that.version, _that.progress);
      case UploadCompleteOtaState():
        return uploadComplete();
      case ErrorOtaState():
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
    TResult? Function(String version)? initialized,
    TResult? Function(String version, double progress)? uploading,
    TResult? Function()? uploadComplete,
    TResult? Function(String errorMessage)? error,
  }) {
    final _that = this;
    switch (_that) {
      case UninitializedOtaState() when uninitialized != null:
        return uninitialized();
      case InitializedOtaState() when initialized != null:
        return initialized(_that.version);
      case UploadingOtaState() when uploading != null:
        return uploading(_that.version, _that.progress);
      case UploadCompleteOtaState() when uploadComplete != null:
        return uploadComplete();
      case ErrorOtaState() when error != null:
        return error(_that.errorMessage);
      case _:
        return null;
    }
  }
}

/// @nodoc

class UninitializedOtaState implements OtaState {
  const UninitializedOtaState();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is UninitializedOtaState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'OtaState.uninitialized()';
  }
}

/// @nodoc

class InitializedOtaState implements OtaState {
  const InitializedOtaState({required this.version});

  final String version;

  /// Create a copy of OtaState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $InitializedOtaStateCopyWith<InitializedOtaState> get copyWith =>
      _$InitializedOtaStateCopyWithImpl<InitializedOtaState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is InitializedOtaState &&
            (identical(other.version, version) || other.version == version));
  }

  @override
  int get hashCode => Object.hash(runtimeType, version);

  @override
  String toString() {
    return 'OtaState.initialized(version: $version)';
  }
}

/// @nodoc
abstract mixin class $InitializedOtaStateCopyWith<$Res>
    implements $OtaStateCopyWith<$Res> {
  factory $InitializedOtaStateCopyWith(
          InitializedOtaState value, $Res Function(InitializedOtaState) _then) =
      _$InitializedOtaStateCopyWithImpl;
  @useResult
  $Res call({String version});
}

/// @nodoc
class _$InitializedOtaStateCopyWithImpl<$Res>
    implements $InitializedOtaStateCopyWith<$Res> {
  _$InitializedOtaStateCopyWithImpl(this._self, this._then);

  final InitializedOtaState _self;
  final $Res Function(InitializedOtaState) _then;

  /// Create a copy of OtaState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? version = null,
  }) {
    return _then(InitializedOtaState(
      version: null == version
          ? _self.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class UploadingOtaState implements OtaState {
  const UploadingOtaState({required this.version, required this.progress});

  final String version;
  final double progress;

  /// Create a copy of OtaState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UploadingOtaStateCopyWith<UploadingOtaState> get copyWith =>
      _$UploadingOtaStateCopyWithImpl<UploadingOtaState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UploadingOtaState &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.progress, progress) ||
                other.progress == progress));
  }

  @override
  int get hashCode => Object.hash(runtimeType, version, progress);

  @override
  String toString() {
    return 'OtaState.uploading(version: $version, progress: $progress)';
  }
}

/// @nodoc
abstract mixin class $UploadingOtaStateCopyWith<$Res>
    implements $OtaStateCopyWith<$Res> {
  factory $UploadingOtaStateCopyWith(
          UploadingOtaState value, $Res Function(UploadingOtaState) _then) =
      _$UploadingOtaStateCopyWithImpl;
  @useResult
  $Res call({String version, double progress});
}

/// @nodoc
class _$UploadingOtaStateCopyWithImpl<$Res>
    implements $UploadingOtaStateCopyWith<$Res> {
  _$UploadingOtaStateCopyWithImpl(this._self, this._then);

  final UploadingOtaState _self;
  final $Res Function(UploadingOtaState) _then;

  /// Create a copy of OtaState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? version = null,
    Object? progress = null,
  }) {
    return _then(UploadingOtaState(
      version: null == version
          ? _self.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      progress: null == progress
          ? _self.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class UploadCompleteOtaState implements OtaState {
  const UploadCompleteOtaState();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is UploadCompleteOtaState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'OtaState.uploadComplete()';
  }
}

/// @nodoc

class ErrorOtaState implements OtaState {
  const ErrorOtaState(this.errorMessage);

  final String errorMessage;

  /// Create a copy of OtaState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ErrorOtaStateCopyWith<ErrorOtaState> get copyWith =>
      _$ErrorOtaStateCopyWithImpl<ErrorOtaState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ErrorOtaState &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorMessage);

  @override
  String toString() {
    return 'OtaState.error(errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class $ErrorOtaStateCopyWith<$Res>
    implements $OtaStateCopyWith<$Res> {
  factory $ErrorOtaStateCopyWith(
          ErrorOtaState value, $Res Function(ErrorOtaState) _then) =
      _$ErrorOtaStateCopyWithImpl;
  @useResult
  $Res call({String errorMessage});
}

/// @nodoc
class _$ErrorOtaStateCopyWithImpl<$Res>
    implements $ErrorOtaStateCopyWith<$Res> {
  _$ErrorOtaStateCopyWithImpl(this._self, this._then);

  final ErrorOtaState _self;
  final $Res Function(ErrorOtaState) _then;

  /// Create a copy of OtaState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? errorMessage = null,
  }) {
    return _then(ErrorOtaState(
      null == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
