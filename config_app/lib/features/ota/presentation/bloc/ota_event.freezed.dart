// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ota_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OtaEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is OtaEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'OtaEvent()';
  }
}

/// @nodoc
class $OtaEventCopyWith<$Res> {
  $OtaEventCopyWith(OtaEvent _, $Res Function(OtaEvent) __);
}

/// Adds pattern-matching-related methods to [OtaEvent].
extension OtaEventPatterns on OtaEvent {
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
    TResult Function(InitOtaEvent value)? init,
    TResult Function(UploadFileOtaEvent value)? uploadFile,
    TResult Function(UploadProgressOtaEvent value)? uploadProgress,
    TResult Function(UploadCompleteOtaEvent value)? uploadComplete,
    TResult Function(ResetOtaEvent value)? reset,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case InitOtaEvent() when init != null:
        return init(_that);
      case UploadFileOtaEvent() when uploadFile != null:
        return uploadFile(_that);
      case UploadProgressOtaEvent() when uploadProgress != null:
        return uploadProgress(_that);
      case UploadCompleteOtaEvent() when uploadComplete != null:
        return uploadComplete(_that);
      case ResetOtaEvent() when reset != null:
        return reset(_that);
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
    required TResult Function(InitOtaEvent value) init,
    required TResult Function(UploadFileOtaEvent value) uploadFile,
    required TResult Function(UploadProgressOtaEvent value) uploadProgress,
    required TResult Function(UploadCompleteOtaEvent value) uploadComplete,
    required TResult Function(ResetOtaEvent value) reset,
  }) {
    final _that = this;
    switch (_that) {
      case InitOtaEvent():
        return init(_that);
      case UploadFileOtaEvent():
        return uploadFile(_that);
      case UploadProgressOtaEvent():
        return uploadProgress(_that);
      case UploadCompleteOtaEvent():
        return uploadComplete(_that);
      case ResetOtaEvent():
        return reset(_that);
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
    TResult? Function(InitOtaEvent value)? init,
    TResult? Function(UploadFileOtaEvent value)? uploadFile,
    TResult? Function(UploadProgressOtaEvent value)? uploadProgress,
    TResult? Function(UploadCompleteOtaEvent value)? uploadComplete,
    TResult? Function(ResetOtaEvent value)? reset,
  }) {
    final _that = this;
    switch (_that) {
      case InitOtaEvent() when init != null:
        return init(_that);
      case UploadFileOtaEvent() when uploadFile != null:
        return uploadFile(_that);
      case UploadProgressOtaEvent() when uploadProgress != null:
        return uploadProgress(_that);
      case UploadCompleteOtaEvent() when uploadComplete != null:
        return uploadComplete(_that);
      case ResetOtaEvent() when reset != null:
        return reset(_that);
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
    TResult Function()? init,
    TResult Function(String filePath, String code)? uploadFile,
    TResult Function(double progress)? uploadProgress,
    TResult Function()? uploadComplete,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case InitOtaEvent() when init != null:
        return init();
      case UploadFileOtaEvent() when uploadFile != null:
        return uploadFile(_that.filePath, _that.code);
      case UploadProgressOtaEvent() when uploadProgress != null:
        return uploadProgress(_that.progress);
      case UploadCompleteOtaEvent() when uploadComplete != null:
        return uploadComplete();
      case ResetOtaEvent() when reset != null:
        return reset();
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
    required TResult Function() init,
    required TResult Function(String filePath, String code) uploadFile,
    required TResult Function(double progress) uploadProgress,
    required TResult Function() uploadComplete,
    required TResult Function() reset,
  }) {
    final _that = this;
    switch (_that) {
      case InitOtaEvent():
        return init();
      case UploadFileOtaEvent():
        return uploadFile(_that.filePath, _that.code);
      case UploadProgressOtaEvent():
        return uploadProgress(_that.progress);
      case UploadCompleteOtaEvent():
        return uploadComplete();
      case ResetOtaEvent():
        return reset();
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
    TResult? Function()? init,
    TResult? Function(String filePath, String code)? uploadFile,
    TResult? Function(double progress)? uploadProgress,
    TResult? Function()? uploadComplete,
    TResult? Function()? reset,
  }) {
    final _that = this;
    switch (_that) {
      case InitOtaEvent() when init != null:
        return init();
      case UploadFileOtaEvent() when uploadFile != null:
        return uploadFile(_that.filePath, _that.code);
      case UploadProgressOtaEvent() when uploadProgress != null:
        return uploadProgress(_that.progress);
      case UploadCompleteOtaEvent() when uploadComplete != null:
        return uploadComplete();
      case ResetOtaEvent() when reset != null:
        return reset();
      case _:
        return null;
    }
  }
}

/// @nodoc

class InitOtaEvent implements OtaEvent {
  const InitOtaEvent();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is InitOtaEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'OtaEvent.init()';
  }
}

/// @nodoc

class UploadFileOtaEvent implements OtaEvent {
  const UploadFileOtaEvent(this.filePath, this.code);

  final String filePath;
  final String code;

  /// Create a copy of OtaEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UploadFileOtaEventCopyWith<UploadFileOtaEvent> get copyWith =>
      _$UploadFileOtaEventCopyWithImpl<UploadFileOtaEvent>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UploadFileOtaEvent &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath) &&
            (identical(other.code, code) || other.code == code));
  }

  @override
  int get hashCode => Object.hash(runtimeType, filePath, code);

  @override
  String toString() {
    return 'OtaEvent.uploadFile(filePath: $filePath, code: $code)';
  }
}

/// @nodoc
abstract mixin class $UploadFileOtaEventCopyWith<$Res>
    implements $OtaEventCopyWith<$Res> {
  factory $UploadFileOtaEventCopyWith(
          UploadFileOtaEvent value, $Res Function(UploadFileOtaEvent) _then) =
      _$UploadFileOtaEventCopyWithImpl;
  @useResult
  $Res call({String filePath, String code});
}

/// @nodoc
class _$UploadFileOtaEventCopyWithImpl<$Res>
    implements $UploadFileOtaEventCopyWith<$Res> {
  _$UploadFileOtaEventCopyWithImpl(this._self, this._then);

  final UploadFileOtaEvent _self;
  final $Res Function(UploadFileOtaEvent) _then;

  /// Create a copy of OtaEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? filePath = null,
    Object? code = null,
  }) {
    return _then(UploadFileOtaEvent(
      null == filePath
          ? _self.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
      null == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class UploadProgressOtaEvent implements OtaEvent {
  const UploadProgressOtaEvent(this.progress);

  final double progress;

  /// Create a copy of OtaEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UploadProgressOtaEventCopyWith<UploadProgressOtaEvent> get copyWith =>
      _$UploadProgressOtaEventCopyWithImpl<UploadProgressOtaEvent>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UploadProgressOtaEvent &&
            (identical(other.progress, progress) ||
                other.progress == progress));
  }

  @override
  int get hashCode => Object.hash(runtimeType, progress);

  @override
  String toString() {
    return 'OtaEvent.uploadProgress(progress: $progress)';
  }
}

/// @nodoc
abstract mixin class $UploadProgressOtaEventCopyWith<$Res>
    implements $OtaEventCopyWith<$Res> {
  factory $UploadProgressOtaEventCopyWith(UploadProgressOtaEvent value,
          $Res Function(UploadProgressOtaEvent) _then) =
      _$UploadProgressOtaEventCopyWithImpl;
  @useResult
  $Res call({double progress});
}

/// @nodoc
class _$UploadProgressOtaEventCopyWithImpl<$Res>
    implements $UploadProgressOtaEventCopyWith<$Res> {
  _$UploadProgressOtaEventCopyWithImpl(this._self, this._then);

  final UploadProgressOtaEvent _self;
  final $Res Function(UploadProgressOtaEvent) _then;

  /// Create a copy of OtaEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? progress = null,
  }) {
    return _then(UploadProgressOtaEvent(
      null == progress
          ? _self.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class UploadCompleteOtaEvent implements OtaEvent {
  const UploadCompleteOtaEvent();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is UploadCompleteOtaEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'OtaEvent.uploadComplete()';
  }
}

/// @nodoc

class ResetOtaEvent implements OtaEvent {
  const ResetOtaEvent();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ResetOtaEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'OtaEvent.reset()';
  }
}

// dart format on
