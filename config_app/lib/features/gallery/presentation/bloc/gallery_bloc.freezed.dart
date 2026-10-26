// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gallery_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GalleryEvent {
  bool get scan;
  Completer<void>? get completion;

  /// Create a copy of GalleryEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryEventCopyWith<GalleryEvent> get copyWith =>
      _$GalleryEventCopyWithImpl<GalleryEvent>(
        this as GalleryEvent,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    final _this = this as GalleryEvent;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryEvent &&
            (identical(other.scan, _this.scan) || other.scan == _this.scan) &&
            (identical(other.completion, _this.completion) ||
                other.completion == _this.completion));
  }

  @override
  int get hashCode {
    final _this = this as GalleryEvent;
    return Object.hash(runtimeType, _this.scan, _this.completion);
  }

  @override
  String toString() {
    final _this = this as GalleryEvent;
    return 'GalleryEvent(scan: ${_this.scan}, completion: ${_this.completion})';
  }
}

/// @nodoc
abstract mixin class $GalleryEventCopyWith<$Res> {
  factory $GalleryEventCopyWith(
    GalleryEvent value,
    $Res Function(GalleryEvent) _then,
  ) = _$GalleryEventCopyWithImpl;
  @useResult
  $Res call({bool scan, Completer<void>? completion});
}

/// @nodoc
class _$GalleryEventCopyWithImpl<$Res> implements $GalleryEventCopyWith<$Res> {
  _$GalleryEventCopyWithImpl(this._self, this._then);

  final GalleryEvent _self;
  final $Res Function(GalleryEvent) _then;

  /// Create a copy of GalleryEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? scan = null, Object? completion = freezed}) {
    return _then(
      GalleryEvent.load(
        scan: null == scan
            ? _self.scan
            : scan // ignore: cast_nullable_to_non_nullable
                  as bool,
        completion: freezed == completion
            ? _self.completion
            : completion // ignore: cast_nullable_to_non_nullable
                  as Completer<void>?,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [GalleryEvent].
extension GalleryEventPatterns on GalleryEvent {
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
    TResult Function(GalleryLoadEvent value)? load,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case GalleryLoadEvent() when load != null:
        return load(_that);
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
    required TResult Function(GalleryLoadEvent value) load,
  }) {
    final _that = this;
    switch (_that) {
      case GalleryLoadEvent():
        return load(_that);
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
    TResult? Function(GalleryLoadEvent value)? load,
  }) {
    final _that = this;
    switch (_that) {
      case GalleryLoadEvent() when load != null:
        return load(_that);
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
    TResult Function(bool scan, Completer<void>? completion)? load,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case GalleryLoadEvent() when load != null:
        return load(_that.scan, _that.completion);
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
    required TResult Function(bool scan, Completer<void>? completion) load,
  }) {
    final _that = this;
    switch (_that) {
      case GalleryLoadEvent():
        return load(_that.scan, _that.completion);
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
    TResult? Function(bool scan, Completer<void>? completion)? load,
  }) {
    final _that = this;
    switch (_that) {
      case GalleryLoadEvent() when load != null:
        return load(_that.scan, _that.completion);
      case _:
        return null;
    }
  }
}

/// @nodoc

class GalleryLoadEvent implements GalleryEvent {
  const GalleryLoadEvent({this.scan = false, this.completion});

  @override
  @JsonKey()
  final bool scan;
  @override
  final Completer<void>? completion;

  /// Create a copy of GalleryEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryLoadEventCopyWith<GalleryLoadEvent> get copyWith =>
      _$GalleryLoadEventCopyWithImpl<GalleryLoadEvent>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryLoadEvent &&
            (identical(other.scan, scan) || other.scan == scan) &&
            (identical(other.completion, completion) ||
                other.completion == completion));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, scan, completion);
  }

  @override
  String toString() {
    return 'GalleryEvent.load(scan: $scan, completion: $completion)';
  }
}

/// @nodoc
abstract mixin class $GalleryLoadEventCopyWith<$Res>
    implements $GalleryEventCopyWith<$Res> {
  factory $GalleryLoadEventCopyWith(
    GalleryLoadEvent value,
    $Res Function(GalleryLoadEvent) _then,
  ) = _$GalleryLoadEventCopyWithImpl;
  @override
  @useResult
  $Res call({bool scan, Completer<void>? completion});
}

/// @nodoc
class _$GalleryLoadEventCopyWithImpl<$Res>
    implements $GalleryLoadEventCopyWith<$Res> {
  _$GalleryLoadEventCopyWithImpl(this._self, this._then);

  final GalleryLoadEvent _self;
  final $Res Function(GalleryLoadEvent) _then;

  /// Create a copy of GalleryEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? scan = null, Object? completion = freezed}) {
    return _then(
      GalleryLoadEvent(
        scan: null == scan
            ? _self.scan
            : scan // ignore: cast_nullable_to_non_nullable
                  as bool,
        completion: freezed == completion
            ? _self.completion
            : completion // ignore: cast_nullable_to_non_nullable
                  as Completer<void>?,
      ),
    );
  }
}

/// @nodoc
mixin _$GalleryState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is GalleryState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'GalleryState()';
  }
}

/// @nodoc
class $GalleryStateCopyWith<$Res> {
  $GalleryStateCopyWith(GalleryState _, $Res Function(GalleryState) __);
}

/// Adds pattern-matching-related methods to [GalleryState].
extension GalleryStatePatterns on GalleryState {
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
    TResult Function(UninitializedGalleryState value)? uninitialized,
    TResult Function(ErrorGalleryState value)? error,
    TResult Function(LoadedGalleryState value)? loaded,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case UninitializedGalleryState() when uninitialized != null:
        return uninitialized(_that);
      case ErrorGalleryState() when error != null:
        return error(_that);
      case LoadedGalleryState() when loaded != null:
        return loaded(_that);
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
    required TResult Function(UninitializedGalleryState value) uninitialized,
    required TResult Function(ErrorGalleryState value) error,
    required TResult Function(LoadedGalleryState value) loaded,
  }) {
    final _that = this;
    switch (_that) {
      case UninitializedGalleryState():
        return uninitialized(_that);
      case ErrorGalleryState():
        return error(_that);
      case LoadedGalleryState():
        return loaded(_that);
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
    TResult? Function(UninitializedGalleryState value)? uninitialized,
    TResult? Function(ErrorGalleryState value)? error,
    TResult? Function(LoadedGalleryState value)? loaded,
  }) {
    final _that = this;
    switch (_that) {
      case UninitializedGalleryState() when uninitialized != null:
        return uninitialized(_that);
      case ErrorGalleryState() when error != null:
        return error(_that);
      case LoadedGalleryState() when loaded != null:
        return loaded(_that);
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
    TResult Function(String errorMessage)? error,
    TResult Function(
      List<GalleryItem> items,
      bool refreshing,
      bool refreshFailed,
    )?
    loaded,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case UninitializedGalleryState() when uninitialized != null:
        return uninitialized();
      case ErrorGalleryState() when error != null:
        return error(_that.errorMessage);
      case LoadedGalleryState() when loaded != null:
        return loaded(_that.items, _that.refreshing, _that.refreshFailed);
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
    required TResult Function(String errorMessage) error,
    required TResult Function(
      List<GalleryItem> items,
      bool refreshing,
      bool refreshFailed,
    )
    loaded,
  }) {
    final _that = this;
    switch (_that) {
      case UninitializedGalleryState():
        return uninitialized();
      case ErrorGalleryState():
        return error(_that.errorMessage);
      case LoadedGalleryState():
        return loaded(_that.items, _that.refreshing, _that.refreshFailed);
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
    TResult? Function(String errorMessage)? error,
    TResult? Function(
      List<GalleryItem> items,
      bool refreshing,
      bool refreshFailed,
    )?
    loaded,
  }) {
    final _that = this;
    switch (_that) {
      case UninitializedGalleryState() when uninitialized != null:
        return uninitialized();
      case ErrorGalleryState() when error != null:
        return error(_that.errorMessage);
      case LoadedGalleryState() when loaded != null:
        return loaded(_that.items, _that.refreshing, _that.refreshFailed);
      case _:
        return null;
    }
  }
}

/// @nodoc

class UninitializedGalleryState implements GalleryState {
  const UninitializedGalleryState();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UninitializedGalleryState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'GalleryState.uninitialized()';
  }
}

/// @nodoc

class ErrorGalleryState implements GalleryState {
  const ErrorGalleryState(this.errorMessage);

  final String errorMessage;

  /// Create a copy of GalleryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ErrorGalleryStateCopyWith<ErrorGalleryState> get copyWith =>
      _$ErrorGalleryStateCopyWithImpl<ErrorGalleryState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ErrorGalleryState &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, errorMessage);
  }

  @override
  String toString() {
    return 'GalleryState.error(errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class $ErrorGalleryStateCopyWith<$Res>
    implements $GalleryStateCopyWith<$Res> {
  factory $ErrorGalleryStateCopyWith(
    ErrorGalleryState value,
    $Res Function(ErrorGalleryState) _then,
  ) = _$ErrorGalleryStateCopyWithImpl;
  @useResult
  $Res call({String errorMessage});
}

/// @nodoc
class _$ErrorGalleryStateCopyWithImpl<$Res>
    implements $ErrorGalleryStateCopyWith<$Res> {
  _$ErrorGalleryStateCopyWithImpl(this._self, this._then);

  final ErrorGalleryState _self;
  final $Res Function(ErrorGalleryState) _then;

  /// Create a copy of GalleryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? errorMessage = null}) {
    return _then(
      ErrorGalleryState(
        null == errorMessage
            ? _self.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class LoadedGalleryState implements GalleryState {
  const LoadedGalleryState({
    required List<GalleryItem> items,
    this.refreshing = false,
    this.refreshFailed = false,
  }) : _items = items;

  final List<GalleryItem> _items;
  List<GalleryItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @JsonKey()
  final bool refreshing;
  @JsonKey()
  final bool refreshFailed;

  /// Create a copy of GalleryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LoadedGalleryStateCopyWith<LoadedGalleryState> get copyWith =>
      _$LoadedGalleryStateCopyWithImpl<LoadedGalleryState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LoadedGalleryState &&
            const DeepCollectionEquality().equals(other.items, _items) &&
            (identical(other.refreshing, refreshing) ||
                other.refreshing == refreshing) &&
            (identical(other.refreshFailed, refreshFailed) ||
                other.refreshFailed == refreshFailed));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_items),
      refreshing,
      refreshFailed,
    );
  }

  @override
  String toString() {
    return 'GalleryState.loaded(items: $items, refreshing: $refreshing, refreshFailed: $refreshFailed)';
  }
}

/// @nodoc
abstract mixin class $LoadedGalleryStateCopyWith<$Res>
    implements $GalleryStateCopyWith<$Res> {
  factory $LoadedGalleryStateCopyWith(
    LoadedGalleryState value,
    $Res Function(LoadedGalleryState) _then,
  ) = _$LoadedGalleryStateCopyWithImpl;
  @useResult
  $Res call({List<GalleryItem> items, bool refreshing, bool refreshFailed});
}

/// @nodoc
class _$LoadedGalleryStateCopyWithImpl<$Res>
    implements $LoadedGalleryStateCopyWith<$Res> {
  _$LoadedGalleryStateCopyWithImpl(this._self, this._then);

  final LoadedGalleryState _self;
  final $Res Function(LoadedGalleryState) _then;

  /// Create a copy of GalleryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? items = null,
    Object? refreshing = null,
    Object? refreshFailed = null,
  }) {
    return _then(
      LoadedGalleryState(
        items: null == items
            ? _self._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<GalleryItem>,
        refreshing: null == refreshing
            ? _self.refreshing
            : refreshing // ignore: cast_nullable_to_non_nullable
                  as bool,
        refreshFailed: null == refreshFailed
            ? _self.refreshFailed
            : refreshFailed // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}
