// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gallery_mutation_confirmation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GalleryMutationConfirmation {
  int get token;
  GalleryMutation get action;
  List<GalleryMediaRef> get items;
  List<String> get names;
  int? get sizeBytes;
  GalleryMutationScope get scope;

  /// Create a copy of GalleryMutationConfirmation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryMutationConfirmationCopyWith<GalleryMutationConfirmation>
  get copyWith =>
      _$GalleryMutationConfirmationCopyWithImpl<GalleryMutationConfirmation>(
        this as GalleryMutationConfirmation,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    final _this = this as GalleryMutationConfirmation;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryMutationConfirmation &&
            (identical(other.token, _this.token) ||
                other.token == _this.token) &&
            (identical(other.action, _this.action) ||
                other.action == _this.action) &&
            const DeepCollectionEquality().equals(other.items, _this.items) &&
            const DeepCollectionEquality().equals(other.names, _this.names) &&
            (identical(other.sizeBytes, _this.sizeBytes) ||
                other.sizeBytes == _this.sizeBytes) &&
            (identical(other.scope, _this.scope) ||
                other.scope == _this.scope));
  }

  @override
  int get hashCode {
    final _this = this as GalleryMutationConfirmation;
    return Object.hash(
      runtimeType,
      _this.token,
      _this.action,
      const DeepCollectionEquality().hash(_this.items),
      const DeepCollectionEquality().hash(_this.names),
      _this.sizeBytes,
      _this.scope,
    );
  }

  @override
  String toString() {
    final _this = this as GalleryMutationConfirmation;
    return 'GalleryMutationConfirmation(token: ${_this.token}, action: ${_this.action}, items: ${_this.items}, names: ${_this.names}, sizeBytes: ${_this.sizeBytes}, scope: ${_this.scope})';
  }
}

/// @nodoc
abstract mixin class $GalleryMutationConfirmationCopyWith<$Res> {
  factory $GalleryMutationConfirmationCopyWith(
    GalleryMutationConfirmation value,
    $Res Function(GalleryMutationConfirmation) _then,
  ) = _$GalleryMutationConfirmationCopyWithImpl;
  @useResult
  $Res call({
    int token,
    GalleryMutation action,
    List<GalleryMediaRef> items,
    List<String> names,
    int? sizeBytes,
    GalleryMutationScope scope,
  });
}

/// @nodoc
class _$GalleryMutationConfirmationCopyWithImpl<$Res>
    implements $GalleryMutationConfirmationCopyWith<$Res> {
  _$GalleryMutationConfirmationCopyWithImpl(this._self, this._then);

  final GalleryMutationConfirmation _self;
  final $Res Function(GalleryMutationConfirmation) _then;

  /// Create a copy of GalleryMutationConfirmation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? action = null,
    Object? items = null,
    Object? names = null,
    Object? sizeBytes = freezed,
    Object? scope = null,
  }) {
    return _then(
      GalleryMutationConfirmation(
        token: null == token
            ? _self.token
            : token // ignore: cast_nullable_to_non_nullable
                  as int,
        action: null == action
            ? _self.action
            : action // ignore: cast_nullable_to_non_nullable
                  as GalleryMutation,
        items: null == items
            ? _self.items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<GalleryMediaRef>,
        names: null == names
            ? _self.names
            : names // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        sizeBytes: freezed == sizeBytes
            ? _self.sizeBytes
            : sizeBytes // ignore: cast_nullable_to_non_nullable
                  as int?,
        scope: null == scope
            ? _self.scope
            : scope // ignore: cast_nullable_to_non_nullable
                  as GalleryMutationScope,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [GalleryMutationConfirmation].
extension GalleryMutationConfirmationPatterns on GalleryMutationConfirmation {
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
    TResult Function(_GalleryMutationConfirmation value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryMutationConfirmation() when $default != null:
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
    TResult Function(_GalleryMutationConfirmation value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryMutationConfirmation():
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
    TResult? Function(_GalleryMutationConfirmation value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryMutationConfirmation() when $default != null:
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
      int token,
      GalleryMutation action,
      List<GalleryMediaRef> items,
      List<String> names,
      int? sizeBytes,
      GalleryMutationScope scope,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryMutationConfirmation() when $default != null:
        return $default(
          _that.token,
          _that.action,
          _that.items,
          _that.names,
          _that.sizeBytes,
          _that.scope,
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
      int token,
      GalleryMutation action,
      List<GalleryMediaRef> items,
      List<String> names,
      int? sizeBytes,
      GalleryMutationScope scope,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryMutationConfirmation():
        return $default(
          _that.token,
          _that.action,
          _that.items,
          _that.names,
          _that.sizeBytes,
          _that.scope,
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
      int token,
      GalleryMutation action,
      List<GalleryMediaRef> items,
      List<String> names,
      int? sizeBytes,
      GalleryMutationScope scope,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryMutationConfirmation() when $default != null:
        return $default(
          _that.token,
          _that.action,
          _that.items,
          _that.names,
          _that.sizeBytes,
          _that.scope,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _GalleryMutationConfirmation implements GalleryMutationConfirmation {
  const _GalleryMutationConfirmation({
    required this.token,
    required this.action,
    required List<GalleryMediaRef> items,
    required List<String> names,
    this.sizeBytes,
    this.scope = GalleryMutationScope.selection,
  }) : _items = items,
       _names = names;

  @override
  final int token;
  @override
  final GalleryMutation action;
  final List<GalleryMediaRef> _items;
  @override
  List<GalleryMediaRef> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  final List<String> _names;
  @override
  List<String> get names {
    if (_names is EqualUnmodifiableListView) return _names;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_names);
  }

  @override
  final int? sizeBytes;
  @override
  @JsonKey()
  final GalleryMutationScope scope;

  /// Create a copy of GalleryMutationConfirmation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GalleryMutationConfirmationCopyWith<_GalleryMutationConfirmation>
  get copyWith =>
      __$GalleryMutationConfirmationCopyWithImpl<_GalleryMutationConfirmation>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GalleryMutationConfirmation &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.action, action) || other.action == action) &&
            const DeepCollectionEquality().equals(other.items, _items) &&
            const DeepCollectionEquality().equals(other.names, _names) &&
            (identical(other.sizeBytes, sizeBytes) ||
                other.sizeBytes == sizeBytes) &&
            (identical(other.scope, scope) || other.scope == scope));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      token,
      action,
      const DeepCollectionEquality().hash(_items),
      const DeepCollectionEquality().hash(_names),
      sizeBytes,
      scope,
    );
  }

  @override
  String toString() {
    return 'GalleryMutationConfirmation(token: $token, action: $action, items: $items, names: $names, sizeBytes: $sizeBytes, scope: $scope)';
  }
}

/// @nodoc
abstract mixin class _$GalleryMutationConfirmationCopyWith<$Res>
    implements $GalleryMutationConfirmationCopyWith<$Res> {
  factory _$GalleryMutationConfirmationCopyWith(
    _GalleryMutationConfirmation value,
    $Res Function(_GalleryMutationConfirmation) _then,
  ) = __$GalleryMutationConfirmationCopyWithImpl;
  @override
  @useResult
  $Res call({
    int token,
    GalleryMutation action,
    List<GalleryMediaRef> items,
    List<String> names,
    int? sizeBytes,
    GalleryMutationScope scope,
  });
}

/// @nodoc
class __$GalleryMutationConfirmationCopyWithImpl<$Res>
    implements _$GalleryMutationConfirmationCopyWith<$Res> {
  __$GalleryMutationConfirmationCopyWithImpl(this._self, this._then);

  final _GalleryMutationConfirmation _self;
  final $Res Function(_GalleryMutationConfirmation) _then;

  /// Create a copy of GalleryMutationConfirmation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? token = null,
    Object? action = null,
    Object? items = null,
    Object? names = null,
    Object? sizeBytes = freezed,
    Object? scope = null,
  }) {
    return _then(
      _GalleryMutationConfirmation(
        token: null == token
            ? _self.token
            : token // ignore: cast_nullable_to_non_nullable
                  as int,
        action: null == action
            ? _self.action
            : action // ignore: cast_nullable_to_non_nullable
                  as GalleryMutation,
        items: null == items
            ? _self._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<GalleryMediaRef>,
        names: null == names
            ? _self._names
            : names // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        sizeBytes: freezed == sizeBytes
            ? _self.sizeBytes
            : sizeBytes // ignore: cast_nullable_to_non_nullable
                  as int?,
        scope: null == scope
            ? _self.scope
            : scope // ignore: cast_nullable_to_non_nullable
                  as GalleryMutationScope,
      ),
    );
  }
}
