// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gallery_comparison_metadata_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GalleryComparisonMetadataState {
  GalleryItem? get item;
  GalleryMetadata? get metadata;
  bool get loading;
  bool get failed;
  GalleryErrorCode? get error;
  int get revisionMismatch;

  /// Create a copy of GalleryComparisonMetadataState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryComparisonMetadataStateCopyWith<GalleryComparisonMetadataState>
  get copyWith =>
      _$GalleryComparisonMetadataStateCopyWithImpl<
        GalleryComparisonMetadataState
      >(this as GalleryComparisonMetadataState, _$identity);

  @override
  bool operator ==(Object other) {
    final _this = this as GalleryComparisonMetadataState;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryComparisonMetadataState &&
            (identical(other.item, _this.item) || other.item == _this.item) &&
            (identical(other.metadata, _this.metadata) ||
                other.metadata == _this.metadata) &&
            (identical(other.loading, _this.loading) ||
                other.loading == _this.loading) &&
            (identical(other.failed, _this.failed) ||
                other.failed == _this.failed) &&
            (identical(other.error, _this.error) ||
                other.error == _this.error) &&
            (identical(other.revisionMismatch, _this.revisionMismatch) ||
                other.revisionMismatch == _this.revisionMismatch));
  }

  @override
  int get hashCode {
    final _this = this as GalleryComparisonMetadataState;
    return Object.hash(
      runtimeType,
      _this.item,
      _this.metadata,
      _this.loading,
      _this.failed,
      _this.error,
      _this.revisionMismatch,
    );
  }

  @override
  String toString() {
    final _this = this as GalleryComparisonMetadataState;
    return 'GalleryComparisonMetadataState(item: ${_this.item}, metadata: ${_this.metadata}, loading: ${_this.loading}, failed: ${_this.failed}, error: ${_this.error}, revisionMismatch: ${_this.revisionMismatch})';
  }
}

/// @nodoc
abstract mixin class $GalleryComparisonMetadataStateCopyWith<$Res> {
  factory $GalleryComparisonMetadataStateCopyWith(
    GalleryComparisonMetadataState value,
    $Res Function(GalleryComparisonMetadataState) _then,
  ) = _$GalleryComparisonMetadataStateCopyWithImpl;
  @useResult
  $Res call({
    GalleryItem? item,
    GalleryMetadata? metadata,
    bool loading,
    bool failed,
    GalleryErrorCode? error,
    int revisionMismatch,
  });

  $GalleryItemCopyWith<$Res>? get item;
  $GalleryMetadataCopyWith<$Res>? get metadata;
}

/// @nodoc
class _$GalleryComparisonMetadataStateCopyWithImpl<$Res>
    implements $GalleryComparisonMetadataStateCopyWith<$Res> {
  _$GalleryComparisonMetadataStateCopyWithImpl(this._self, this._then);

  final GalleryComparisonMetadataState _self;
  final $Res Function(GalleryComparisonMetadataState) _then;

  /// Create a copy of GalleryComparisonMetadataState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item = freezed,
    Object? metadata = freezed,
    Object? loading = null,
    Object? failed = null,
    Object? error = freezed,
    Object? revisionMismatch = null,
  }) {
    return _then(
      GalleryComparisonMetadataState(
        item: freezed == item
            ? _self.item
            : item // ignore: cast_nullable_to_non_nullable
                  as GalleryItem?,
        metadata: freezed == metadata
            ? _self.metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as GalleryMetadata?,
        loading: null == loading
            ? _self.loading
            : loading // ignore: cast_nullable_to_non_nullable
                  as bool,
        failed: null == failed
            ? _self.failed
            : failed // ignore: cast_nullable_to_non_nullable
                  as bool,
        error: freezed == error
            ? _self.error
            : error // ignore: cast_nullable_to_non_nullable
                  as GalleryErrorCode?,
        revisionMismatch: null == revisionMismatch
            ? _self.revisionMismatch
            : revisionMismatch // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }

  /// Create a copy of GalleryComparisonMetadataState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryItemCopyWith<$Res>? get item {
    if (_self.item == null) {
      return null;
    }

    return $GalleryItemCopyWith<$Res>(_self.item!, (value) {
      return _then(_self.copyWith(item: value));
    });
  }

  /// Create a copy of GalleryComparisonMetadataState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryMetadataCopyWith<$Res>? get metadata {
    if (_self.metadata == null) {
      return null;
    }

    return $GalleryMetadataCopyWith<$Res>(_self.metadata!, (value) {
      return _then(_self.copyWith(metadata: value));
    });
  }
}

/// Adds pattern-matching-related methods to [GalleryComparisonMetadataState].
extension GalleryComparisonMetadataStatePatterns
    on GalleryComparisonMetadataState {
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
    TResult Function(_GalleryComparisonMetadataState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryComparisonMetadataState() when $default != null:
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
    TResult Function(_GalleryComparisonMetadataState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryComparisonMetadataState():
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
    TResult? Function(_GalleryComparisonMetadataState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryComparisonMetadataState() when $default != null:
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
      GalleryItem? item,
      GalleryMetadata? metadata,
      bool loading,
      bool failed,
      GalleryErrorCode? error,
      int revisionMismatch,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryComparisonMetadataState() when $default != null:
        return $default(
          _that.item,
          _that.metadata,
          _that.loading,
          _that.failed,
          _that.error,
          _that.revisionMismatch,
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
      GalleryItem? item,
      GalleryMetadata? metadata,
      bool loading,
      bool failed,
      GalleryErrorCode? error,
      int revisionMismatch,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryComparisonMetadataState():
        return $default(
          _that.item,
          _that.metadata,
          _that.loading,
          _that.failed,
          _that.error,
          _that.revisionMismatch,
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
      GalleryItem? item,
      GalleryMetadata? metadata,
      bool loading,
      bool failed,
      GalleryErrorCode? error,
      int revisionMismatch,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryComparisonMetadataState() when $default != null:
        return $default(
          _that.item,
          _that.metadata,
          _that.loading,
          _that.failed,
          _that.error,
          _that.revisionMismatch,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _GalleryComparisonMetadataState
    implements GalleryComparisonMetadataState {
  const _GalleryComparisonMetadataState({
    required this.item,
    this.metadata,
    this.loading = false,
    this.failed = false,
    this.error,
    this.revisionMismatch = 0,
  });

  @override
  final GalleryItem? item;
  @override
  final GalleryMetadata? metadata;
  @override
  @JsonKey()
  final bool loading;
  @override
  @JsonKey()
  final bool failed;
  @override
  final GalleryErrorCode? error;
  @override
  @JsonKey()
  final int revisionMismatch;

  /// Create a copy of GalleryComparisonMetadataState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GalleryComparisonMetadataStateCopyWith<_GalleryComparisonMetadataState>
  get copyWith =>
      __$GalleryComparisonMetadataStateCopyWithImpl<
        _GalleryComparisonMetadataState
      >(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GalleryComparisonMetadataState &&
            (identical(other.item, item) || other.item == item) &&
            (identical(other.metadata, metadata) ||
                other.metadata == metadata) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.failed, failed) || other.failed == failed) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.revisionMismatch, revisionMismatch) ||
                other.revisionMismatch == revisionMismatch));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      item,
      metadata,
      loading,
      failed,
      error,
      revisionMismatch,
    );
  }

  @override
  String toString() {
    return 'GalleryComparisonMetadataState(item: $item, metadata: $metadata, loading: $loading, failed: $failed, error: $error, revisionMismatch: $revisionMismatch)';
  }
}

/// @nodoc
abstract mixin class _$GalleryComparisonMetadataStateCopyWith<$Res>
    implements $GalleryComparisonMetadataStateCopyWith<$Res> {
  factory _$GalleryComparisonMetadataStateCopyWith(
    _GalleryComparisonMetadataState value,
    $Res Function(_GalleryComparisonMetadataState) _then,
  ) = __$GalleryComparisonMetadataStateCopyWithImpl;
  @override
  @useResult
  $Res call({
    GalleryItem? item,
    GalleryMetadata? metadata,
    bool loading,
    bool failed,
    GalleryErrorCode? error,
    int revisionMismatch,
  });

  @override
  $GalleryItemCopyWith<$Res>? get item;
  @override
  $GalleryMetadataCopyWith<$Res>? get metadata;
}

/// @nodoc
class __$GalleryComparisonMetadataStateCopyWithImpl<$Res>
    implements _$GalleryComparisonMetadataStateCopyWith<$Res> {
  __$GalleryComparisonMetadataStateCopyWithImpl(this._self, this._then);

  final _GalleryComparisonMetadataState _self;
  final $Res Function(_GalleryComparisonMetadataState) _then;

  /// Create a copy of GalleryComparisonMetadataState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? item = freezed,
    Object? metadata = freezed,
    Object? loading = null,
    Object? failed = null,
    Object? error = freezed,
    Object? revisionMismatch = null,
  }) {
    return _then(
      _GalleryComparisonMetadataState(
        item: freezed == item
            ? _self.item
            : item // ignore: cast_nullable_to_non_nullable
                  as GalleryItem?,
        metadata: freezed == metadata
            ? _self.metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as GalleryMetadata?,
        loading: null == loading
            ? _self.loading
            : loading // ignore: cast_nullable_to_non_nullable
                  as bool,
        failed: null == failed
            ? _self.failed
            : failed // ignore: cast_nullable_to_non_nullable
                  as bool,
        error: freezed == error
            ? _self.error
            : error // ignore: cast_nullable_to_non_nullable
                  as GalleryErrorCode?,
        revisionMismatch: null == revisionMismatch
            ? _self.revisionMismatch
            : revisionMismatch // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }

  /// Create a copy of GalleryComparisonMetadataState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryItemCopyWith<$Res>? get item {
    if (_self.item == null) {
      return null;
    }

    return $GalleryItemCopyWith<$Res>(_self.item!, (value) {
      return _then(_self.copyWith(item: value));
    });
  }

  /// Create a copy of GalleryComparisonMetadataState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryMetadataCopyWith<$Res>? get metadata {
    if (_self.metadata == null) {
      return null;
    }

    return $GalleryMetadataCopyWith<$Res>(_self.metadata!, (value) {
      return _then(_self.copyWith(metadata: value));
    });
  }
}

/// @nodoc
mixin _$GalleryComparisonMetadataEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryComparisonMetadataEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'GalleryComparisonMetadataEvent()';
  }
}

/// @nodoc
class $GalleryComparisonMetadataEventCopyWith<$Res> {
  $GalleryComparisonMetadataEventCopyWith(
    GalleryComparisonMetadataEvent _,
    $Res Function(GalleryComparisonMetadataEvent) __,
  );
}

/// Adds pattern-matching-related methods to [GalleryComparisonMetadataEvent].
extension GalleryComparisonMetadataEventPatterns
    on GalleryComparisonMetadataEvent {
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
    TResult Function(GalleryComparisonMetadataLoad value)? load,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case GalleryComparisonMetadataLoad() when load != null:
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
    required TResult Function(GalleryComparisonMetadataLoad value) load,
  }) {
    final _that = this;
    switch (_that) {
      case GalleryComparisonMetadataLoad():
        return load(_that);
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
    TResult? Function(GalleryComparisonMetadataLoad value)? load,
  }) {
    final _that = this;
    switch (_that) {
      case GalleryComparisonMetadataLoad() when load != null:
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
      case GalleryComparisonMetadataLoad() when load != null:
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
  TResult when<TResult extends Object?>({required TResult Function() load}) {
    final _that = this;
    switch (_that) {
      case GalleryComparisonMetadataLoad():
        return load();
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
  TResult? whenOrNull<TResult extends Object?>({TResult? Function()? load}) {
    final _that = this;
    switch (_that) {
      case GalleryComparisonMetadataLoad() when load != null:
        return load();
      case _:
        return null;
    }
  }
}

/// @nodoc

class GalleryComparisonMetadataLoad implements GalleryComparisonMetadataEvent {
  const GalleryComparisonMetadataLoad();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryComparisonMetadataLoad);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'GalleryComparisonMetadataEvent.load()';
  }
}
