// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gallery_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GalleryEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is GalleryEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'GalleryEvent()';
  }
}

/// @nodoc
class $GalleryEventCopyWith<$Res> {
  $GalleryEventCopyWith(GalleryEvent _, $Res Function(GalleryEvent) __);
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
    TResult Function()? load,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case GalleryLoadEvent() when load != null:
        return load();
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
    required TResult Function() load,
  }) {
    final _that = this;
    switch (_that) {
      case GalleryLoadEvent():
        return load();
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
    TResult? Function()? load,
  }) {
    final _that = this;
    switch (_that) {
      case GalleryLoadEvent() when load != null:
        return load();
      case _:
        return null;
    }
  }
}

/// @nodoc

class GalleryLoadEvent implements GalleryEvent {
  const GalleryLoadEvent();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is GalleryLoadEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'GalleryEvent.load()';
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
    TResult Function(List<String> items)? loaded,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case UninitializedGalleryState() when uninitialized != null:
        return uninitialized();
      case ErrorGalleryState() when error != null:
        return error(_that.errorMessage);
      case LoadedGalleryState() when loaded != null:
        return loaded(_that.items);
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
    required TResult Function(List<String> items) loaded,
  }) {
    final _that = this;
    switch (_that) {
      case UninitializedGalleryState():
        return uninitialized();
      case ErrorGalleryState():
        return error(_that.errorMessage);
      case LoadedGalleryState():
        return loaded(_that.items);
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
    TResult? Function(List<String> items)? loaded,
  }) {
    final _that = this;
    switch (_that) {
      case UninitializedGalleryState() when uninitialized != null:
        return uninitialized();
      case ErrorGalleryState() when error != null:
        return error(_that.errorMessage);
      case LoadedGalleryState() when loaded != null:
        return loaded(_that.items);
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
  int get hashCode => Object.hash(runtimeType, errorMessage);

  @override
  String toString() {
    return 'GalleryState.error(errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class $ErrorGalleryStateCopyWith<$Res>
    implements $GalleryStateCopyWith<$Res> {
  factory $ErrorGalleryStateCopyWith(
          ErrorGalleryState value, $Res Function(ErrorGalleryState) _then) =
      _$ErrorGalleryStateCopyWithImpl;
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
  $Res call({
    Object? errorMessage = null,
  }) {
    return _then(ErrorGalleryState(
      null == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class LoadedGalleryState implements GalleryState {
  const LoadedGalleryState({required final List<String> items})
      : _items = items;

  final List<String> _items;
  List<String> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

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
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_items));

  @override
  String toString() {
    return 'GalleryState.loaded(items: $items)';
  }
}

/// @nodoc
abstract mixin class $LoadedGalleryStateCopyWith<$Res>
    implements $GalleryStateCopyWith<$Res> {
  factory $LoadedGalleryStateCopyWith(
          LoadedGalleryState value, $Res Function(LoadedGalleryState) _then) =
      _$LoadedGalleryStateCopyWithImpl;
  @useResult
  $Res call({List<String> items});
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
  }) {
    return _then(LoadedGalleryState(
      items: null == items
          ? _self._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on
