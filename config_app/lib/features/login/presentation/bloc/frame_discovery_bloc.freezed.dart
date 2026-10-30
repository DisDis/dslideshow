// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'frame_discovery_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FrameDiscoveryState {
  FrameDiscoveryStatus get status;
  List<DiscoveredFrame> get frames;
  bool get limited;
  int get unresolved;

  /// Create a copy of FrameDiscoveryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FrameDiscoveryStateCopyWith<FrameDiscoveryState> get copyWith =>
      _$FrameDiscoveryStateCopyWithImpl<FrameDiscoveryState>(
        this as FrameDiscoveryState,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    final _this = this as FrameDiscoveryState;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FrameDiscoveryState &&
            (identical(other.status, _this.status) ||
                other.status == _this.status) &&
            const DeepCollectionEquality().equals(other.frames, _this.frames) &&
            (identical(other.limited, _this.limited) ||
                other.limited == _this.limited) &&
            (identical(other.unresolved, _this.unresolved) ||
                other.unresolved == _this.unresolved));
  }

  @override
  int get hashCode {
    final _this = this as FrameDiscoveryState;
    return Object.hash(
      runtimeType,
      _this.status,
      const DeepCollectionEquality().hash(_this.frames),
      _this.limited,
      _this.unresolved,
    );
  }

  @override
  String toString() {
    final _this = this as FrameDiscoveryState;
    return 'FrameDiscoveryState(status: ${_this.status}, frames: ${_this.frames}, limited: ${_this.limited}, unresolved: ${_this.unresolved})';
  }
}

/// @nodoc
abstract mixin class $FrameDiscoveryStateCopyWith<$Res> {
  factory $FrameDiscoveryStateCopyWith(
    FrameDiscoveryState value,
    $Res Function(FrameDiscoveryState) _then,
  ) = _$FrameDiscoveryStateCopyWithImpl;
  @useResult
  $Res call({
    FrameDiscoveryStatus status,
    List<DiscoveredFrame> frames,
    bool limited,
    int unresolved,
  });
}

/// @nodoc
class _$FrameDiscoveryStateCopyWithImpl<$Res>
    implements $FrameDiscoveryStateCopyWith<$Res> {
  _$FrameDiscoveryStateCopyWithImpl(this._self, this._then);

  final FrameDiscoveryState _self;
  final $Res Function(FrameDiscoveryState) _then;

  /// Create a copy of FrameDiscoveryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? frames = null,
    Object? limited = null,
    Object? unresolved = null,
  }) {
    return _then(
      FrameDiscoveryState(
        status: null == status
            ? _self.status
            : status // ignore: cast_nullable_to_non_nullable
                  as FrameDiscoveryStatus,
        frames: null == frames
            ? _self.frames
            : frames // ignore: cast_nullable_to_non_nullable
                  as List<DiscoveredFrame>,
        limited: null == limited
            ? _self.limited
            : limited // ignore: cast_nullable_to_non_nullable
                  as bool,
        unresolved: null == unresolved
            ? _self.unresolved
            : unresolved // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [FrameDiscoveryState].
extension FrameDiscoveryStatePatterns on FrameDiscoveryState {
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
    TResult Function(_FrameDiscoveryState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FrameDiscoveryState() when $default != null:
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
    TResult Function(_FrameDiscoveryState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FrameDiscoveryState():
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
    TResult? Function(_FrameDiscoveryState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FrameDiscoveryState() when $default != null:
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
      FrameDiscoveryStatus status,
      List<DiscoveredFrame> frames,
      bool limited,
      int unresolved,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FrameDiscoveryState() when $default != null:
        return $default(
          _that.status,
          _that.frames,
          _that.limited,
          _that.unresolved,
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
      FrameDiscoveryStatus status,
      List<DiscoveredFrame> frames,
      bool limited,
      int unresolved,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FrameDiscoveryState():
        return $default(
          _that.status,
          _that.frames,
          _that.limited,
          _that.unresolved,
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
      FrameDiscoveryStatus status,
      List<DiscoveredFrame> frames,
      bool limited,
      int unresolved,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FrameDiscoveryState() when $default != null:
        return $default(
          _that.status,
          _that.frames,
          _that.limited,
          _that.unresolved,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _FrameDiscoveryState implements FrameDiscoveryState {
  const _FrameDiscoveryState({
    this.status = FrameDiscoveryStatus.initial,
    List<DiscoveredFrame> frames = const [],
    this.limited = false,
    this.unresolved = 0,
  }) : _frames = frames;

  @override
  @JsonKey()
  final FrameDiscoveryStatus status;
  final List<DiscoveredFrame> _frames;
  @override
  @JsonKey()
  List<DiscoveredFrame> get frames {
    if (_frames is EqualUnmodifiableListView) return _frames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_frames);
  }

  @override
  @JsonKey()
  final bool limited;
  @override
  @JsonKey()
  final int unresolved;

  /// Create a copy of FrameDiscoveryState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FrameDiscoveryStateCopyWith<_FrameDiscoveryState> get copyWith =>
      __$FrameDiscoveryStateCopyWithImpl<_FrameDiscoveryState>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FrameDiscoveryState &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other.frames, _frames) &&
            (identical(other.limited, limited) || other.limited == limited) &&
            (identical(other.unresolved, unresolved) ||
                other.unresolved == unresolved));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      status,
      const DeepCollectionEquality().hash(_frames),
      limited,
      unresolved,
    );
  }

  @override
  String toString() {
    return 'FrameDiscoveryState(status: $status, frames: $frames, limited: $limited, unresolved: $unresolved)';
  }
}

/// @nodoc
abstract mixin class _$FrameDiscoveryStateCopyWith<$Res>
    implements $FrameDiscoveryStateCopyWith<$Res> {
  factory _$FrameDiscoveryStateCopyWith(
    _FrameDiscoveryState value,
    $Res Function(_FrameDiscoveryState) _then,
  ) = __$FrameDiscoveryStateCopyWithImpl;
  @override
  @useResult
  $Res call({
    FrameDiscoveryStatus status,
    List<DiscoveredFrame> frames,
    bool limited,
    int unresolved,
  });
}

/// @nodoc
class __$FrameDiscoveryStateCopyWithImpl<$Res>
    implements _$FrameDiscoveryStateCopyWith<$Res> {
  __$FrameDiscoveryStateCopyWithImpl(this._self, this._then);

  final _FrameDiscoveryState _self;
  final $Res Function(_FrameDiscoveryState) _then;

  /// Create a copy of FrameDiscoveryState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? status = null,
    Object? frames = null,
    Object? limited = null,
    Object? unresolved = null,
  }) {
    return _then(
      _FrameDiscoveryState(
        status: null == status
            ? _self.status
            : status // ignore: cast_nullable_to_non_nullable
                  as FrameDiscoveryStatus,
        frames: null == frames
            ? _self._frames
            : frames // ignore: cast_nullable_to_non_nullable
                  as List<DiscoveredFrame>,
        limited: null == limited
            ? _self.limited
            : limited // ignore: cast_nullable_to_non_nullable
                  as bool,
        unresolved: null == unresolved
            ? _self.unresolved
            : unresolved // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
mixin _$FrameDiscoveryEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is FrameDiscoveryEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'FrameDiscoveryEvent()';
  }
}

/// @nodoc
class $FrameDiscoveryEventCopyWith<$Res> {
  $FrameDiscoveryEventCopyWith(
    FrameDiscoveryEvent _,
    $Res Function(FrameDiscoveryEvent) __,
  );
}

/// Adds pattern-matching-related methods to [FrameDiscoveryEvent].
extension FrameDiscoveryEventPatterns on FrameDiscoveryEvent {
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
    TResult Function(FrameSearchRequested value)? search,
    TResult Function(FrameSearchCancelled value)? cancel,
    TResult Function(_Update value)? update,
    TResult Function(_Finish value)? finish,
    TResult Function(_Failed value)? failed,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case FrameSearchRequested() when search != null:
        return search(_that);
      case FrameSearchCancelled() when cancel != null:
        return cancel(_that);
      case _Update() when update != null:
        return update(_that);
      case _Finish() when finish != null:
        return finish(_that);
      case _Failed() when failed != null:
        return failed(_that);
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
    required TResult Function(FrameSearchRequested value) search,
    required TResult Function(FrameSearchCancelled value) cancel,
    required TResult Function(_Update value) update,
    required TResult Function(_Finish value) finish,
    required TResult Function(_Failed value) failed,
  }) {
    final _that = this;
    switch (_that) {
      case FrameSearchRequested():
        return search(_that);
      case FrameSearchCancelled():
        return cancel(_that);
      case _Update():
        return update(_that);
      case _Finish():
        return finish(_that);
      case _Failed():
        return failed(_that);
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
    TResult? Function(FrameSearchRequested value)? search,
    TResult? Function(FrameSearchCancelled value)? cancel,
    TResult? Function(_Update value)? update,
    TResult? Function(_Finish value)? finish,
    TResult? Function(_Failed value)? failed,
  }) {
    final _that = this;
    switch (_that) {
      case FrameSearchRequested() when search != null:
        return search(_that);
      case FrameSearchCancelled() when cancel != null:
        return cancel(_that);
      case _Update() when update != null:
        return update(_that);
      case _Finish() when finish != null:
        return finish(_that);
      case _Failed() when failed != null:
        return failed(_that);
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
    TResult Function()? search,
    TResult Function()? cancel,
    TResult Function(
      FrameDiscoverySession session,
      FrameDiscoveryUpdate update,
    )?
    update,
    TResult Function(FrameDiscoverySession session)? finish,
    TResult Function(FrameDiscoverySession session)? failed,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case FrameSearchRequested() when search != null:
        return search();
      case FrameSearchCancelled() when cancel != null:
        return cancel();
      case _Update() when update != null:
        return update(_that.session, _that.update);
      case _Finish() when finish != null:
        return finish(_that.session);
      case _Failed() when failed != null:
        return failed(_that.session);
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
    required TResult Function() search,
    required TResult Function() cancel,
    required TResult Function(
      FrameDiscoverySession session,
      FrameDiscoveryUpdate update,
    )
    update,
    required TResult Function(FrameDiscoverySession session) finish,
    required TResult Function(FrameDiscoverySession session) failed,
  }) {
    final _that = this;
    switch (_that) {
      case FrameSearchRequested():
        return search();
      case FrameSearchCancelled():
        return cancel();
      case _Update():
        return update(_that.session, _that.update);
      case _Finish():
        return finish(_that.session);
      case _Failed():
        return failed(_that.session);
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
    TResult? Function()? search,
    TResult? Function()? cancel,
    TResult? Function(
      FrameDiscoverySession session,
      FrameDiscoveryUpdate update,
    )?
    update,
    TResult? Function(FrameDiscoverySession session)? finish,
    TResult? Function(FrameDiscoverySession session)? failed,
  }) {
    final _that = this;
    switch (_that) {
      case FrameSearchRequested() when search != null:
        return search();
      case FrameSearchCancelled() when cancel != null:
        return cancel();
      case _Update() when update != null:
        return update(_that.session, _that.update);
      case _Finish() when finish != null:
        return finish(_that.session);
      case _Failed() when failed != null:
        return failed(_that.session);
      case _:
        return null;
    }
  }
}

/// @nodoc

class FrameSearchRequested implements FrameDiscoveryEvent {
  const FrameSearchRequested();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is FrameSearchRequested);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'FrameDiscoveryEvent.search()';
  }
}

/// @nodoc

class FrameSearchCancelled implements FrameDiscoveryEvent {
  const FrameSearchCancelled();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is FrameSearchCancelled);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'FrameDiscoveryEvent.cancel()';
  }
}

/// @nodoc

class _Update implements FrameDiscoveryEvent {
  const _Update(this.session, this.update);

  final FrameDiscoverySession session;
  final FrameDiscoveryUpdate update;

  /// Create a copy of FrameDiscoveryEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UpdateCopyWith<_Update> get copyWith =>
      __$UpdateCopyWithImpl<_Update>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Update &&
            (identical(other.session, session) || other.session == session) &&
            (identical(other.update, update) || other.update == update));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, session, update);
  }

  @override
  String toString() {
    return 'FrameDiscoveryEvent.update(session: $session, update: $update)';
  }
}

/// @nodoc
abstract mixin class _$UpdateCopyWith<$Res>
    implements $FrameDiscoveryEventCopyWith<$Res> {
  factory _$UpdateCopyWith(_Update value, $Res Function(_Update) _then) =
      __$UpdateCopyWithImpl;
  @useResult
  $Res call({FrameDiscoverySession session, FrameDiscoveryUpdate update});

  $FrameDiscoveryUpdateCopyWith<$Res> get update;
}

/// @nodoc
class __$UpdateCopyWithImpl<$Res> implements _$UpdateCopyWith<$Res> {
  __$UpdateCopyWithImpl(this._self, this._then);

  final _Update _self;
  final $Res Function(_Update) _then;

  /// Create a copy of FrameDiscoveryEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? session = null, Object? update = null}) {
    return _then(
      _Update(
        null == session
            ? _self.session
            : session // ignore: cast_nullable_to_non_nullable
                  as FrameDiscoverySession,
        null == update
            ? _self.update
            : update // ignore: cast_nullable_to_non_nullable
                  as FrameDiscoveryUpdate,
      ),
    );
  }

  /// Create a copy of FrameDiscoveryEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FrameDiscoveryUpdateCopyWith<$Res> get update {
    return $FrameDiscoveryUpdateCopyWith<$Res>(_self.update, (value) {
      return _then(_self.copyWith(update: value));
    });
  }
}

/// @nodoc

class _Finish implements FrameDiscoveryEvent {
  const _Finish(this.session);

  final FrameDiscoverySession session;

  /// Create a copy of FrameDiscoveryEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FinishCopyWith<_Finish> get copyWith =>
      __$FinishCopyWithImpl<_Finish>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Finish &&
            (identical(other.session, session) || other.session == session));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, session);
  }

  @override
  String toString() {
    return 'FrameDiscoveryEvent.finish(session: $session)';
  }
}

/// @nodoc
abstract mixin class _$FinishCopyWith<$Res>
    implements $FrameDiscoveryEventCopyWith<$Res> {
  factory _$FinishCopyWith(_Finish value, $Res Function(_Finish) _then) =
      __$FinishCopyWithImpl;
  @useResult
  $Res call({FrameDiscoverySession session});
}

/// @nodoc
class __$FinishCopyWithImpl<$Res> implements _$FinishCopyWith<$Res> {
  __$FinishCopyWithImpl(this._self, this._then);

  final _Finish _self;
  final $Res Function(_Finish) _then;

  /// Create a copy of FrameDiscoveryEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? session = null}) {
    return _then(
      _Finish(
        null == session
            ? _self.session
            : session // ignore: cast_nullable_to_non_nullable
                  as FrameDiscoverySession,
      ),
    );
  }
}

/// @nodoc

class _Failed implements FrameDiscoveryEvent {
  const _Failed(this.session);

  final FrameDiscoverySession session;

  /// Create a copy of FrameDiscoveryEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FailedCopyWith<_Failed> get copyWith =>
      __$FailedCopyWithImpl<_Failed>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Failed &&
            (identical(other.session, session) || other.session == session));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, session);
  }

  @override
  String toString() {
    return 'FrameDiscoveryEvent.failed(session: $session)';
  }
}

/// @nodoc
abstract mixin class _$FailedCopyWith<$Res>
    implements $FrameDiscoveryEventCopyWith<$Res> {
  factory _$FailedCopyWith(_Failed value, $Res Function(_Failed) _then) =
      __$FailedCopyWithImpl;
  @useResult
  $Res call({FrameDiscoverySession session});
}

/// @nodoc
class __$FailedCopyWithImpl<$Res> implements _$FailedCopyWith<$Res> {
  __$FailedCopyWithImpl(this._self, this._then);

  final _Failed _self;
  final $Res Function(_Failed) _then;

  /// Create a copy of FrameDiscoveryEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? session = null}) {
    return _then(
      _Failed(
        null == session
            ? _self.session
            : session // ignore: cast_nullable_to_non_nullable
                  as FrameDiscoverySession,
      ),
    );
  }
}
