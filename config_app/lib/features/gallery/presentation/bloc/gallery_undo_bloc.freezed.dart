// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gallery_undo_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GalleryUndoState {
  GalleryUndoPhase get phase;
  GalleryOperationRequest? get request;
  GalleryOperationResult? get result;
  GalleryErrorCode? get error;
  int get missingCount;

  /// Create a copy of GalleryUndoState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryUndoStateCopyWith<GalleryUndoState> get copyWith =>
      _$GalleryUndoStateCopyWithImpl<GalleryUndoState>(
        this as GalleryUndoState,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    final _this = this as GalleryUndoState;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryUndoState &&
            (identical(other.phase, _this.phase) ||
                other.phase == _this.phase) &&
            (identical(other.request, _this.request) ||
                other.request == _this.request) &&
            (identical(other.result, _this.result) ||
                other.result == _this.result) &&
            (identical(other.error, _this.error) ||
                other.error == _this.error) &&
            (identical(other.missingCount, _this.missingCount) ||
                other.missingCount == _this.missingCount));
  }

  @override
  int get hashCode {
    final _this = this as GalleryUndoState;
    return Object.hash(
      runtimeType,
      _this.phase,
      _this.request,
      _this.result,
      _this.error,
      _this.missingCount,
    );
  }

  @override
  String toString() {
    final _this = this as GalleryUndoState;
    return 'GalleryUndoState(phase: ${_this.phase}, request: ${_this.request}, result: ${_this.result}, error: ${_this.error}, missingCount: ${_this.missingCount})';
  }
}

/// @nodoc
abstract mixin class $GalleryUndoStateCopyWith<$Res> {
  factory $GalleryUndoStateCopyWith(
    GalleryUndoState value,
    $Res Function(GalleryUndoState) _then,
  ) = _$GalleryUndoStateCopyWithImpl;
  @useResult
  $Res call({
    GalleryUndoPhase phase,
    GalleryOperationRequest? request,
    GalleryOperationResult? result,
    GalleryErrorCode? error,
    int missingCount,
  });

  $GalleryOperationRequestCopyWith<$Res>? get request;
  $GalleryOperationResultCopyWith<$Res>? get result;
}

/// @nodoc
class _$GalleryUndoStateCopyWithImpl<$Res>
    implements $GalleryUndoStateCopyWith<$Res> {
  _$GalleryUndoStateCopyWithImpl(this._self, this._then);

  final GalleryUndoState _self;
  final $Res Function(GalleryUndoState) _then;

  /// Create a copy of GalleryUndoState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phase = null,
    Object? request = freezed,
    Object? result = freezed,
    Object? error = freezed,
    Object? missingCount = null,
  }) {
    return _then(
      GalleryUndoState(
        phase: null == phase
            ? _self.phase
            : phase // ignore: cast_nullable_to_non_nullable
                  as GalleryUndoPhase,
        request: freezed == request
            ? _self.request
            : request // ignore: cast_nullable_to_non_nullable
                  as GalleryOperationRequest?,
        result: freezed == result
            ? _self.result
            : result // ignore: cast_nullable_to_non_nullable
                  as GalleryOperationResult?,
        error: freezed == error
            ? _self.error
            : error // ignore: cast_nullable_to_non_nullable
                  as GalleryErrorCode?,
        missingCount: null == missingCount
            ? _self.missingCount
            : missingCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }

  /// Create a copy of GalleryUndoState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryOperationRequestCopyWith<$Res>? get request {
    if (_self.request == null) {
      return null;
    }

    return $GalleryOperationRequestCopyWith<$Res>(_self.request!, (value) {
      return _then(_self.copyWith(request: value));
    });
  }

  /// Create a copy of GalleryUndoState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryOperationResultCopyWith<$Res>? get result {
    if (_self.result == null) {
      return null;
    }

    return $GalleryOperationResultCopyWith<$Res>(_self.result!, (value) {
      return _then(_self.copyWith(result: value));
    });
  }
}

/// Adds pattern-matching-related methods to [GalleryUndoState].
extension GalleryUndoStatePatterns on GalleryUndoState {
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
    TResult Function(_GalleryUndoState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryUndoState() when $default != null:
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
    TResult Function(_GalleryUndoState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryUndoState():
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
    TResult? Function(_GalleryUndoState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryUndoState() when $default != null:
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
      GalleryUndoPhase phase,
      GalleryOperationRequest? request,
      GalleryOperationResult? result,
      GalleryErrorCode? error,
      int missingCount,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryUndoState() when $default != null:
        return $default(
          _that.phase,
          _that.request,
          _that.result,
          _that.error,
          _that.missingCount,
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
      GalleryUndoPhase phase,
      GalleryOperationRequest? request,
      GalleryOperationResult? result,
      GalleryErrorCode? error,
      int missingCount,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryUndoState():
        return $default(
          _that.phase,
          _that.request,
          _that.result,
          _that.error,
          _that.missingCount,
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
      GalleryUndoPhase phase,
      GalleryOperationRequest? request,
      GalleryOperationResult? result,
      GalleryErrorCode? error,
      int missingCount,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryUndoState() when $default != null:
        return $default(
          _that.phase,
          _that.request,
          _that.result,
          _that.error,
          _that.missingCount,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _GalleryUndoState implements GalleryUndoState {
  const _GalleryUndoState({
    this.phase = GalleryUndoPhase.idle,
    this.request,
    this.result,
    this.error,
    this.missingCount = 0,
  });

  @override
  @JsonKey()
  final GalleryUndoPhase phase;
  @override
  final GalleryOperationRequest? request;
  @override
  final GalleryOperationResult? result;
  @override
  final GalleryErrorCode? error;
  @override
  @JsonKey()
  final int missingCount;

  /// Create a copy of GalleryUndoState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GalleryUndoStateCopyWith<_GalleryUndoState> get copyWith =>
      __$GalleryUndoStateCopyWithImpl<_GalleryUndoState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GalleryUndoState &&
            (identical(other.phase, phase) || other.phase == phase) &&
            (identical(other.request, request) || other.request == request) &&
            (identical(other.result, result) || other.result == result) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.missingCount, missingCount) ||
                other.missingCount == missingCount));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      phase,
      request,
      result,
      error,
      missingCount,
    );
  }

  @override
  String toString() {
    return 'GalleryUndoState(phase: $phase, request: $request, result: $result, error: $error, missingCount: $missingCount)';
  }
}

/// @nodoc
abstract mixin class _$GalleryUndoStateCopyWith<$Res>
    implements $GalleryUndoStateCopyWith<$Res> {
  factory _$GalleryUndoStateCopyWith(
    _GalleryUndoState value,
    $Res Function(_GalleryUndoState) _then,
  ) = __$GalleryUndoStateCopyWithImpl;
  @override
  @useResult
  $Res call({
    GalleryUndoPhase phase,
    GalleryOperationRequest? request,
    GalleryOperationResult? result,
    GalleryErrorCode? error,
    int missingCount,
  });

  @override
  $GalleryOperationRequestCopyWith<$Res>? get request;
  @override
  $GalleryOperationResultCopyWith<$Res>? get result;
}

/// @nodoc
class __$GalleryUndoStateCopyWithImpl<$Res>
    implements _$GalleryUndoStateCopyWith<$Res> {
  __$GalleryUndoStateCopyWithImpl(this._self, this._then);

  final _GalleryUndoState _self;
  final $Res Function(_GalleryUndoState) _then;

  /// Create a copy of GalleryUndoState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? phase = null,
    Object? request = freezed,
    Object? result = freezed,
    Object? error = freezed,
    Object? missingCount = null,
  }) {
    return _then(
      _GalleryUndoState(
        phase: null == phase
            ? _self.phase
            : phase // ignore: cast_nullable_to_non_nullable
                  as GalleryUndoPhase,
        request: freezed == request
            ? _self.request
            : request // ignore: cast_nullable_to_non_nullable
                  as GalleryOperationRequest?,
        result: freezed == result
            ? _self.result
            : result // ignore: cast_nullable_to_non_nullable
                  as GalleryOperationResult?,
        error: freezed == error
            ? _self.error
            : error // ignore: cast_nullable_to_non_nullable
                  as GalleryErrorCode?,
        missingCount: null == missingCount
            ? _self.missingCount
            : missingCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }

  /// Create a copy of GalleryUndoState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryOperationRequestCopyWith<$Res>? get request {
    if (_self.request == null) {
      return null;
    }

    return $GalleryOperationRequestCopyWith<$Res>(_self.request!, (value) {
      return _then(_self.copyWith(request: value));
    });
  }

  /// Create a copy of GalleryUndoState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryOperationResultCopyWith<$Res>? get result {
    if (_self.result == null) {
      return null;
    }

    return $GalleryOperationResultCopyWith<$Res>(_self.result!, (value) {
      return _then(_self.copyWith(result: value));
    });
  }
}

/// @nodoc
mixin _$GalleryUndoEvent {
  Completer<GalleryOperationResult> get completion;

  /// Create a copy of GalleryUndoEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryUndoEventCopyWith<GalleryUndoEvent> get copyWith =>
      _$GalleryUndoEventCopyWithImpl<GalleryUndoEvent>(
        this as GalleryUndoEvent,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    final _this = this as GalleryUndoEvent;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryUndoEvent &&
            (identical(other.completion, _this.completion) ||
                other.completion == _this.completion));
  }

  @override
  int get hashCode {
    final _this = this as GalleryUndoEvent;
    return Object.hash(runtimeType, _this.completion);
  }

  @override
  String toString() {
    final _this = this as GalleryUndoEvent;
    return 'GalleryUndoEvent(completion: ${_this.completion})';
  }
}

/// @nodoc
abstract mixin class $GalleryUndoEventCopyWith<$Res> {
  factory $GalleryUndoEventCopyWith(
    GalleryUndoEvent value,
    $Res Function(GalleryUndoEvent) _then,
  ) = _$GalleryUndoEventCopyWithImpl;
  @useResult
  $Res call({Completer<GalleryOperationResult> completion});
}

/// @nodoc
class _$GalleryUndoEventCopyWithImpl<$Res>
    implements $GalleryUndoEventCopyWith<$Res> {
  _$GalleryUndoEventCopyWithImpl(this._self, this._then);

  final GalleryUndoEvent _self;
  final $Res Function(GalleryUndoEvent) _then;

  /// Create a copy of GalleryUndoEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? completion = null}) {
    return _then(
      GalleryUndoEvent.restore(
        null == completion
            ? _self.completion
            : completion // ignore: cast_nullable_to_non_nullable
                  as Completer<GalleryOperationResult>,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [GalleryUndoEvent].
extension GalleryUndoEventPatterns on GalleryUndoEvent {
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
    TResult Function(GalleryUndoRestoreRequested value)? restore,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case GalleryUndoRestoreRequested() when restore != null:
        return restore(_that);
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
    required TResult Function(GalleryUndoRestoreRequested value) restore,
  }) {
    final _that = this;
    switch (_that) {
      case GalleryUndoRestoreRequested():
        return restore(_that);
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
    TResult? Function(GalleryUndoRestoreRequested value)? restore,
  }) {
    final _that = this;
    switch (_that) {
      case GalleryUndoRestoreRequested() when restore != null:
        return restore(_that);
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
    TResult Function(Completer<GalleryOperationResult> completion)? restore,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case GalleryUndoRestoreRequested() when restore != null:
        return restore(_that.completion);
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
    required TResult Function(Completer<GalleryOperationResult> completion)
    restore,
  }) {
    final _that = this;
    switch (_that) {
      case GalleryUndoRestoreRequested():
        return restore(_that.completion);
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
    TResult? Function(Completer<GalleryOperationResult> completion)? restore,
  }) {
    final _that = this;
    switch (_that) {
      case GalleryUndoRestoreRequested() when restore != null:
        return restore(_that.completion);
      case _:
        return null;
    }
  }
}

/// @nodoc

class GalleryUndoRestoreRequested implements GalleryUndoEvent {
  const GalleryUndoRestoreRequested(this.completion);

  @override
  final Completer<GalleryOperationResult> completion;

  /// Create a copy of GalleryUndoEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryUndoRestoreRequestedCopyWith<GalleryUndoRestoreRequested>
  get copyWith =>
      _$GalleryUndoRestoreRequestedCopyWithImpl<GalleryUndoRestoreRequested>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryUndoRestoreRequested &&
            (identical(other.completion, completion) ||
                other.completion == completion));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, completion);
  }

  @override
  String toString() {
    return 'GalleryUndoEvent.restore(completion: $completion)';
  }
}

/// @nodoc
abstract mixin class $GalleryUndoRestoreRequestedCopyWith<$Res>
    implements $GalleryUndoEventCopyWith<$Res> {
  factory $GalleryUndoRestoreRequestedCopyWith(
    GalleryUndoRestoreRequested value,
    $Res Function(GalleryUndoRestoreRequested) _then,
  ) = _$GalleryUndoRestoreRequestedCopyWithImpl;
  @override
  @useResult
  $Res call({Completer<GalleryOperationResult> completion});
}

/// @nodoc
class _$GalleryUndoRestoreRequestedCopyWithImpl<$Res>
    implements $GalleryUndoRestoreRequestedCopyWith<$Res> {
  _$GalleryUndoRestoreRequestedCopyWithImpl(this._self, this._then);

  final GalleryUndoRestoreRequested _self;
  final $Res Function(GalleryUndoRestoreRequested) _then;

  /// Create a copy of GalleryUndoEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? completion = null}) {
    return _then(
      GalleryUndoRestoreRequested(
        null == completion
            ? _self.completion
            : completion // ignore: cast_nullable_to_non_nullable
                  as Completer<GalleryOperationResult>,
      ),
    );
  }
}
