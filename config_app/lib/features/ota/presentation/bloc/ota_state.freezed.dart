// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ota_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OtaState {
  OtaPhase get phase;
  String get version;
  String get code;
  String? get filename;
  int? get fileSize;
  bool get pickingFile;
  double get progress;
  OtaFailure? get failure;
  int get formGeneration;

  /// Create a copy of OtaState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OtaStateCopyWith<OtaState> get copyWith =>
      _$OtaStateCopyWithImpl<OtaState>(this as OtaState, _$identity);

  @override
  bool operator ==(Object other) {
    final _this = this as OtaState;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OtaState &&
            (identical(other.phase, _this.phase) ||
                other.phase == _this.phase) &&
            (identical(other.version, _this.version) ||
                other.version == _this.version) &&
            (identical(other.code, _this.code) || other.code == _this.code) &&
            (identical(other.filename, _this.filename) ||
                other.filename == _this.filename) &&
            (identical(other.fileSize, _this.fileSize) ||
                other.fileSize == _this.fileSize) &&
            (identical(other.pickingFile, _this.pickingFile) ||
                other.pickingFile == _this.pickingFile) &&
            (identical(other.progress, _this.progress) ||
                other.progress == _this.progress) &&
            (identical(other.failure, _this.failure) ||
                other.failure == _this.failure) &&
            (identical(other.formGeneration, _this.formGeneration) ||
                other.formGeneration == _this.formGeneration));
  }

  @override
  int get hashCode {
    final _this = this as OtaState;
    return Object.hash(
      runtimeType,
      _this.phase,
      _this.version,
      _this.code,
      _this.filename,
      _this.fileSize,
      _this.pickingFile,
      _this.progress,
      _this.failure,
      _this.formGeneration,
    );
  }

  @override
  String toString() {
    final _this = this as OtaState;
    return 'OtaState(phase: ${_this.phase}, version: ${_this.version}, code: ${_this.code}, filename: ${_this.filename}, fileSize: ${_this.fileSize}, pickingFile: ${_this.pickingFile}, progress: ${_this.progress}, failure: ${_this.failure}, formGeneration: ${_this.formGeneration})';
  }
}

/// @nodoc
abstract mixin class $OtaStateCopyWith<$Res> {
  factory $OtaStateCopyWith(OtaState value, $Res Function(OtaState) _then) =
      _$OtaStateCopyWithImpl;
  @useResult
  $Res call({
    OtaPhase phase,
    String version,
    String code,
    String? filename,
    int? fileSize,
    bool pickingFile,
    double progress,
    OtaFailure? failure,
    int formGeneration,
  });
}

/// @nodoc
class _$OtaStateCopyWithImpl<$Res> implements $OtaStateCopyWith<$Res> {
  _$OtaStateCopyWithImpl(this._self, this._then);

  final OtaState _self;
  final $Res Function(OtaState) _then;

  /// Create a copy of OtaState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phase = null,
    Object? version = null,
    Object? code = null,
    Object? filename = freezed,
    Object? fileSize = freezed,
    Object? pickingFile = null,
    Object? progress = null,
    Object? failure = freezed,
    Object? formGeneration = null,
  }) {
    return _then(
      OtaState(
        phase: null == phase
            ? _self.phase
            : phase // ignore: cast_nullable_to_non_nullable
                  as OtaPhase,
        version: null == version
            ? _self.version
            : version // ignore: cast_nullable_to_non_nullable
                  as String,
        code: null == code
            ? _self.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
        filename: freezed == filename
            ? _self.filename
            : filename // ignore: cast_nullable_to_non_nullable
                  as String?,
        fileSize: freezed == fileSize
            ? _self.fileSize
            : fileSize // ignore: cast_nullable_to_non_nullable
                  as int?,
        pickingFile: null == pickingFile
            ? _self.pickingFile
            : pickingFile // ignore: cast_nullable_to_non_nullable
                  as bool,
        progress: null == progress
            ? _self.progress
            : progress // ignore: cast_nullable_to_non_nullable
                  as double,
        failure: freezed == failure
            ? _self.failure
            : failure // ignore: cast_nullable_to_non_nullable
                  as OtaFailure?,
        formGeneration: null == formGeneration
            ? _self.formGeneration
            : formGeneration // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
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
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_OtaState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OtaState() when $default != null:
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
    TResult Function(_OtaState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OtaState():
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
    TResult? Function(_OtaState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OtaState() when $default != null:
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
      OtaPhase phase,
      String version,
      String code,
      String? filename,
      int? fileSize,
      bool pickingFile,
      double progress,
      OtaFailure? failure,
      int formGeneration,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OtaState() when $default != null:
        return $default(
          _that.phase,
          _that.version,
          _that.code,
          _that.filename,
          _that.fileSize,
          _that.pickingFile,
          _that.progress,
          _that.failure,
          _that.formGeneration,
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
      OtaPhase phase,
      String version,
      String code,
      String? filename,
      int? fileSize,
      bool pickingFile,
      double progress,
      OtaFailure? failure,
      int formGeneration,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OtaState():
        return $default(
          _that.phase,
          _that.version,
          _that.code,
          _that.filename,
          _that.fileSize,
          _that.pickingFile,
          _that.progress,
          _that.failure,
          _that.formGeneration,
        );
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
      OtaPhase phase,
      String version,
      String code,
      String? filename,
      int? fileSize,
      bool pickingFile,
      double progress,
      OtaFailure? failure,
      int formGeneration,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OtaState() when $default != null:
        return $default(
          _that.phase,
          _that.version,
          _that.code,
          _that.filename,
          _that.fileSize,
          _that.pickingFile,
          _that.progress,
          _that.failure,
          _that.formGeneration,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _OtaState extends OtaState {
  const _OtaState({
    this.phase = OtaPhase.uninitialized,
    this.version = '',
    this.code = '',
    this.filename,
    this.fileSize,
    this.pickingFile = false,
    this.progress = 0.0,
    this.failure,
    this.formGeneration = 0,
  }) : super._();

  @override
  @JsonKey()
  final OtaPhase phase;
  @override
  @JsonKey()
  final String version;
  @override
  @JsonKey()
  final String code;
  @override
  final String? filename;
  @override
  final int? fileSize;
  @override
  @JsonKey()
  final bool pickingFile;
  @override
  @JsonKey()
  final double progress;
  @override
  final OtaFailure? failure;
  @override
  @JsonKey()
  final int formGeneration;

  /// Create a copy of OtaState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OtaStateCopyWith<_OtaState> get copyWith =>
      __$OtaStateCopyWithImpl<_OtaState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OtaState &&
            (identical(other.phase, phase) || other.phase == phase) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.filename, filename) ||
                other.filename == filename) &&
            (identical(other.fileSize, fileSize) ||
                other.fileSize == fileSize) &&
            (identical(other.pickingFile, pickingFile) ||
                other.pickingFile == pickingFile) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.failure, failure) || other.failure == failure) &&
            (identical(other.formGeneration, formGeneration) ||
                other.formGeneration == formGeneration));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      phase,
      version,
      code,
      filename,
      fileSize,
      pickingFile,
      progress,
      failure,
      formGeneration,
    );
  }

  @override
  String toString() {
    return 'OtaState(phase: $phase, version: $version, code: $code, filename: $filename, fileSize: $fileSize, pickingFile: $pickingFile, progress: $progress, failure: $failure, formGeneration: $formGeneration)';
  }
}

/// @nodoc
abstract mixin class _$OtaStateCopyWith<$Res>
    implements $OtaStateCopyWith<$Res> {
  factory _$OtaStateCopyWith(_OtaState value, $Res Function(_OtaState) _then) =
      __$OtaStateCopyWithImpl;
  @override
  @useResult
  $Res call({
    OtaPhase phase,
    String version,
    String code,
    String? filename,
    int? fileSize,
    bool pickingFile,
    double progress,
    OtaFailure? failure,
    int formGeneration,
  });
}

/// @nodoc
class __$OtaStateCopyWithImpl<$Res> implements _$OtaStateCopyWith<$Res> {
  __$OtaStateCopyWithImpl(this._self, this._then);

  final _OtaState _self;
  final $Res Function(_OtaState) _then;

  /// Create a copy of OtaState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? phase = null,
    Object? version = null,
    Object? code = null,
    Object? filename = freezed,
    Object? fileSize = freezed,
    Object? pickingFile = null,
    Object? progress = null,
    Object? failure = freezed,
    Object? formGeneration = null,
  }) {
    return _then(
      _OtaState(
        phase: null == phase
            ? _self.phase
            : phase // ignore: cast_nullable_to_non_nullable
                  as OtaPhase,
        version: null == version
            ? _self.version
            : version // ignore: cast_nullable_to_non_nullable
                  as String,
        code: null == code
            ? _self.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
        filename: freezed == filename
            ? _self.filename
            : filename // ignore: cast_nullable_to_non_nullable
                  as String?,
        fileSize: freezed == fileSize
            ? _self.fileSize
            : fileSize // ignore: cast_nullable_to_non_nullable
                  as int?,
        pickingFile: null == pickingFile
            ? _self.pickingFile
            : pickingFile // ignore: cast_nullable_to_non_nullable
                  as bool,
        progress: null == progress
            ? _self.progress
            : progress // ignore: cast_nullable_to_non_nullable
                  as double,
        failure: freezed == failure
            ? _self.failure
            : failure // ignore: cast_nullable_to_non_nullable
                  as OtaFailure?,
        formGeneration: null == formGeneration
            ? _self.formGeneration
            : formGeneration // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}
