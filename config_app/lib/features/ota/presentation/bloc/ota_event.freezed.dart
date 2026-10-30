// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ota_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
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
    TResult Function(PickFileOtaEvent value)? pickFile,
    TResult Function(CodeChangedOtaEvent value)? codeChanged,
    TResult Function(UploadFileOtaEvent value)? upload,
    TResult Function(ResetOtaEvent value)? reset,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case InitOtaEvent() when init != null:
        return init(_that);
      case PickFileOtaEvent() when pickFile != null:
        return pickFile(_that);
      case CodeChangedOtaEvent() when codeChanged != null:
        return codeChanged(_that);
      case UploadFileOtaEvent() when upload != null:
        return upload(_that);
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
    required TResult Function(PickFileOtaEvent value) pickFile,
    required TResult Function(CodeChangedOtaEvent value) codeChanged,
    required TResult Function(UploadFileOtaEvent value) upload,
    required TResult Function(ResetOtaEvent value) reset,
  }) {
    final _that = this;
    switch (_that) {
      case InitOtaEvent():
        return init(_that);
      case PickFileOtaEvent():
        return pickFile(_that);
      case CodeChangedOtaEvent():
        return codeChanged(_that);
      case UploadFileOtaEvent():
        return upload(_that);
      case ResetOtaEvent():
        return reset(_that);
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
    TResult? Function(PickFileOtaEvent value)? pickFile,
    TResult? Function(CodeChangedOtaEvent value)? codeChanged,
    TResult? Function(UploadFileOtaEvent value)? upload,
    TResult? Function(ResetOtaEvent value)? reset,
  }) {
    final _that = this;
    switch (_that) {
      case InitOtaEvent() when init != null:
        return init(_that);
      case PickFileOtaEvent() when pickFile != null:
        return pickFile(_that);
      case CodeChangedOtaEvent() when codeChanged != null:
        return codeChanged(_that);
      case UploadFileOtaEvent() when upload != null:
        return upload(_that);
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
    TResult Function()? pickFile,
    TResult Function(String value)? codeChanged,
    TResult Function()? upload,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case InitOtaEvent() when init != null:
        return init();
      case PickFileOtaEvent() when pickFile != null:
        return pickFile();
      case CodeChangedOtaEvent() when codeChanged != null:
        return codeChanged(_that.value);
      case UploadFileOtaEvent() when upload != null:
        return upload();
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
    required TResult Function() pickFile,
    required TResult Function(String value) codeChanged,
    required TResult Function() upload,
    required TResult Function() reset,
  }) {
    final _that = this;
    switch (_that) {
      case InitOtaEvent():
        return init();
      case PickFileOtaEvent():
        return pickFile();
      case CodeChangedOtaEvent():
        return codeChanged(_that.value);
      case UploadFileOtaEvent():
        return upload();
      case ResetOtaEvent():
        return reset();
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
    TResult? Function()? pickFile,
    TResult? Function(String value)? codeChanged,
    TResult? Function()? upload,
    TResult? Function()? reset,
  }) {
    final _that = this;
    switch (_that) {
      case InitOtaEvent() when init != null:
        return init();
      case PickFileOtaEvent() when pickFile != null:
        return pickFile();
      case CodeChangedOtaEvent() when codeChanged != null:
        return codeChanged(_that.value);
      case UploadFileOtaEvent() when upload != null:
        return upload();
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

class PickFileOtaEvent implements OtaEvent {
  const PickFileOtaEvent();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is PickFileOtaEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'OtaEvent.pickFile()';
  }
}

/// @nodoc

class CodeChangedOtaEvent implements OtaEvent {
  const CodeChangedOtaEvent(this.value);

  final String value;

  /// Create a copy of OtaEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CodeChangedOtaEventCopyWith<CodeChangedOtaEvent> get copyWith =>
      _$CodeChangedOtaEventCopyWithImpl<CodeChangedOtaEvent>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CodeChangedOtaEvent &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, value);
  }

  @override
  String toString() {
    return 'OtaEvent.codeChanged(value: $value)';
  }
}

/// @nodoc
abstract mixin class $CodeChangedOtaEventCopyWith<$Res>
    implements $OtaEventCopyWith<$Res> {
  factory $CodeChangedOtaEventCopyWith(
    CodeChangedOtaEvent value,
    $Res Function(CodeChangedOtaEvent) _then,
  ) = _$CodeChangedOtaEventCopyWithImpl;
  @useResult
  $Res call({String value});
}

/// @nodoc
class _$CodeChangedOtaEventCopyWithImpl<$Res>
    implements $CodeChangedOtaEventCopyWith<$Res> {
  _$CodeChangedOtaEventCopyWithImpl(this._self, this._then);

  final CodeChangedOtaEvent _self;
  final $Res Function(CodeChangedOtaEvent) _then;

  /// Create a copy of OtaEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? value = null}) {
    return _then(
      CodeChangedOtaEvent(
        null == value
            ? _self.value
            : value // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class UploadFileOtaEvent implements OtaEvent {
  const UploadFileOtaEvent();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is UploadFileOtaEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'OtaEvent.upload()';
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
