// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gallery_duplicates_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GalleryDuplicatesCatalogSnapshot {
  List<GalleryItem> get items;
  Map<String, GalleryItem> get byId;

  /// Create a copy of GalleryDuplicatesCatalogSnapshot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryDuplicatesCatalogSnapshotCopyWith<GalleryDuplicatesCatalogSnapshot>
  get copyWith =>
      _$GalleryDuplicatesCatalogSnapshotCopyWithImpl<
        GalleryDuplicatesCatalogSnapshot
      >(this as GalleryDuplicatesCatalogSnapshot, _$identity);

  @override
  bool operator ==(Object other) {
    final _this = this as GalleryDuplicatesCatalogSnapshot;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryDuplicatesCatalogSnapshot &&
            const DeepCollectionEquality().equals(other.items, _this.items) &&
            const DeepCollectionEquality().equals(other.byId, _this.byId));
  }

  @override
  int get hashCode {
    final _this = this as GalleryDuplicatesCatalogSnapshot;
    return Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_this.items),
      const DeepCollectionEquality().hash(_this.byId),
    );
  }

  @override
  String toString() {
    final _this = this as GalleryDuplicatesCatalogSnapshot;
    return 'GalleryDuplicatesCatalogSnapshot(items: ${_this.items}, byId: ${_this.byId})';
  }
}

/// @nodoc
abstract mixin class $GalleryDuplicatesCatalogSnapshotCopyWith<$Res> {
  factory $GalleryDuplicatesCatalogSnapshotCopyWith(
    GalleryDuplicatesCatalogSnapshot value,
    $Res Function(GalleryDuplicatesCatalogSnapshot) _then,
  ) = _$GalleryDuplicatesCatalogSnapshotCopyWithImpl;
  @useResult
  $Res call({List<GalleryItem> items, Map<String, GalleryItem> byId});
}

/// @nodoc
class _$GalleryDuplicatesCatalogSnapshotCopyWithImpl<$Res>
    implements $GalleryDuplicatesCatalogSnapshotCopyWith<$Res> {
  _$GalleryDuplicatesCatalogSnapshotCopyWithImpl(this._self, this._then);

  final GalleryDuplicatesCatalogSnapshot _self;
  final $Res Function(GalleryDuplicatesCatalogSnapshot) _then;

  /// Create a copy of GalleryDuplicatesCatalogSnapshot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? items = null, Object? byId = null}) {
    return _then(
      GalleryDuplicatesCatalogSnapshot(
        items: null == items
            ? _self.items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<GalleryItem>,
        byId: null == byId
            ? _self.byId
            : byId // ignore: cast_nullable_to_non_nullable
                  as Map<String, GalleryItem>,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [GalleryDuplicatesCatalogSnapshot].
extension GalleryDuplicatesCatalogSnapshotPatterns
    on GalleryDuplicatesCatalogSnapshot {
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
    TResult Function(_GalleryDuplicatesCatalogSnapshot value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicatesCatalogSnapshot() when $default != null:
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
    TResult Function(_GalleryDuplicatesCatalogSnapshot value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicatesCatalogSnapshot():
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
    TResult? Function(_GalleryDuplicatesCatalogSnapshot value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicatesCatalogSnapshot() when $default != null:
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
    TResult Function(List<GalleryItem> items, Map<String, GalleryItem> byId)?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicatesCatalogSnapshot() when $default != null:
        return $default(_that.items, _that.byId);
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
    TResult Function(List<GalleryItem> items, Map<String, GalleryItem> byId)
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicatesCatalogSnapshot():
        return $default(_that.items, _that.byId);
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
    TResult? Function(List<GalleryItem> items, Map<String, GalleryItem> byId)?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicatesCatalogSnapshot() when $default != null:
        return $default(_that.items, _that.byId);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _GalleryDuplicatesCatalogSnapshot
    implements GalleryDuplicatesCatalogSnapshot {
  const _GalleryDuplicatesCatalogSnapshot({
    List<GalleryItem> items = const [],
    Map<String, GalleryItem> byId = const {},
  }) : _items = items,
       _byId = byId;

  final List<GalleryItem> _items;
  @override
  @JsonKey()
  List<GalleryItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  final Map<String, GalleryItem> _byId;
  @override
  @JsonKey()
  Map<String, GalleryItem> get byId {
    if (_byId is EqualUnmodifiableMapView) return _byId;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_byId);
  }

  /// Create a copy of GalleryDuplicatesCatalogSnapshot
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GalleryDuplicatesCatalogSnapshotCopyWith<_GalleryDuplicatesCatalogSnapshot>
  get copyWith =>
      __$GalleryDuplicatesCatalogSnapshotCopyWithImpl<
        _GalleryDuplicatesCatalogSnapshot
      >(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GalleryDuplicatesCatalogSnapshot &&
            const DeepCollectionEquality().equals(other.items, _items) &&
            const DeepCollectionEquality().equals(other.byId, _byId));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_items),
      const DeepCollectionEquality().hash(_byId),
    );
  }

  @override
  String toString() {
    return 'GalleryDuplicatesCatalogSnapshot(items: $items, byId: $byId)';
  }
}

/// @nodoc
abstract mixin class _$GalleryDuplicatesCatalogSnapshotCopyWith<$Res>
    implements $GalleryDuplicatesCatalogSnapshotCopyWith<$Res> {
  factory _$GalleryDuplicatesCatalogSnapshotCopyWith(
    _GalleryDuplicatesCatalogSnapshot value,
    $Res Function(_GalleryDuplicatesCatalogSnapshot) _then,
  ) = __$GalleryDuplicatesCatalogSnapshotCopyWithImpl;
  @override
  @useResult
  $Res call({List<GalleryItem> items, Map<String, GalleryItem> byId});
}

/// @nodoc
class __$GalleryDuplicatesCatalogSnapshotCopyWithImpl<$Res>
    implements _$GalleryDuplicatesCatalogSnapshotCopyWith<$Res> {
  __$GalleryDuplicatesCatalogSnapshotCopyWithImpl(this._self, this._then);

  final _GalleryDuplicatesCatalogSnapshot _self;
  final $Res Function(_GalleryDuplicatesCatalogSnapshot) _then;

  /// Create a copy of GalleryDuplicatesCatalogSnapshot
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? items = null, Object? byId = null}) {
    return _then(
      _GalleryDuplicatesCatalogSnapshot(
        items: null == items
            ? _self._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<GalleryItem>,
        byId: null == byId
            ? _self._byId
            : byId // ignore: cast_nullable_to_non_nullable
                  as Map<String, GalleryItem>,
      ),
    );
  }
}

/// @nodoc
mixin _$GalleryDuplicatesEffect {
  int get sequence;
  GalleryDuplicatesNotice get notice;
  String? get jobId;
  List<GalleryDuplicateMember> get members;
  GalleryOperationResult? get result;

  /// Create a copy of GalleryDuplicatesEffect
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryDuplicatesEffectCopyWith<GalleryDuplicatesEffect> get copyWith =>
      _$GalleryDuplicatesEffectCopyWithImpl<GalleryDuplicatesEffect>(
        this as GalleryDuplicatesEffect,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    final _this = this as GalleryDuplicatesEffect;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryDuplicatesEffect &&
            (identical(other.sequence, _this.sequence) ||
                other.sequence == _this.sequence) &&
            (identical(other.notice, _this.notice) ||
                other.notice == _this.notice) &&
            (identical(other.jobId, _this.jobId) ||
                other.jobId == _this.jobId) &&
            const DeepCollectionEquality().equals(
              other.members,
              _this.members,
            ) &&
            (identical(other.result, _this.result) ||
                other.result == _this.result));
  }

  @override
  int get hashCode {
    final _this = this as GalleryDuplicatesEffect;
    return Object.hash(
      runtimeType,
      _this.sequence,
      _this.notice,
      _this.jobId,
      const DeepCollectionEquality().hash(_this.members),
      _this.result,
    );
  }

  @override
  String toString() {
    final _this = this as GalleryDuplicatesEffect;
    return 'GalleryDuplicatesEffect(sequence: ${_this.sequence}, notice: ${_this.notice}, jobId: ${_this.jobId}, members: ${_this.members}, result: ${_this.result})';
  }
}

/// @nodoc
abstract mixin class $GalleryDuplicatesEffectCopyWith<$Res> {
  factory $GalleryDuplicatesEffectCopyWith(
    GalleryDuplicatesEffect value,
    $Res Function(GalleryDuplicatesEffect) _then,
  ) = _$GalleryDuplicatesEffectCopyWithImpl;
  @useResult
  $Res call({
    int sequence,
    GalleryDuplicatesNotice notice,
    String? jobId,
    List<GalleryDuplicateMember> members,
    GalleryOperationResult? result,
  });

  $GalleryOperationResultCopyWith<$Res>? get result;
}

/// @nodoc
class _$GalleryDuplicatesEffectCopyWithImpl<$Res>
    implements $GalleryDuplicatesEffectCopyWith<$Res> {
  _$GalleryDuplicatesEffectCopyWithImpl(this._self, this._then);

  final GalleryDuplicatesEffect _self;
  final $Res Function(GalleryDuplicatesEffect) _then;

  /// Create a copy of GalleryDuplicatesEffect
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sequence = null,
    Object? notice = null,
    Object? jobId = freezed,
    Object? members = null,
    Object? result = freezed,
  }) {
    return _then(
      GalleryDuplicatesEffect(
        sequence: null == sequence
            ? _self.sequence
            : sequence // ignore: cast_nullable_to_non_nullable
                  as int,
        notice: null == notice
            ? _self.notice
            : notice // ignore: cast_nullable_to_non_nullable
                  as GalleryDuplicatesNotice,
        jobId: freezed == jobId
            ? _self.jobId
            : jobId // ignore: cast_nullable_to_non_nullable
                  as String?,
        members: null == members
            ? _self.members
            : members // ignore: cast_nullable_to_non_nullable
                  as List<GalleryDuplicateMember>,
        result: freezed == result
            ? _self.result
            : result // ignore: cast_nullable_to_non_nullable
                  as GalleryOperationResult?,
      ),
    );
  }

  /// Create a copy of GalleryDuplicatesEffect
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

/// Adds pattern-matching-related methods to [GalleryDuplicatesEffect].
extension GalleryDuplicatesEffectPatterns on GalleryDuplicatesEffect {
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
    TResult Function(_GalleryDuplicatesEffect value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicatesEffect() when $default != null:
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
    TResult Function(_GalleryDuplicatesEffect value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicatesEffect():
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
    TResult? Function(_GalleryDuplicatesEffect value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicatesEffect() when $default != null:
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
      int sequence,
      GalleryDuplicatesNotice notice,
      String? jobId,
      List<GalleryDuplicateMember> members,
      GalleryOperationResult? result,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicatesEffect() when $default != null:
        return $default(
          _that.sequence,
          _that.notice,
          _that.jobId,
          _that.members,
          _that.result,
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
      int sequence,
      GalleryDuplicatesNotice notice,
      String? jobId,
      List<GalleryDuplicateMember> members,
      GalleryOperationResult? result,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicatesEffect():
        return $default(
          _that.sequence,
          _that.notice,
          _that.jobId,
          _that.members,
          _that.result,
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
      int sequence,
      GalleryDuplicatesNotice notice,
      String? jobId,
      List<GalleryDuplicateMember> members,
      GalleryOperationResult? result,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicatesEffect() when $default != null:
        return $default(
          _that.sequence,
          _that.notice,
          _that.jobId,
          _that.members,
          _that.result,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _GalleryDuplicatesEffect implements GalleryDuplicatesEffect {
  const _GalleryDuplicatesEffect({
    required this.sequence,
    required this.notice,
    this.jobId,
    List<GalleryDuplicateMember> members = const [],
    this.result,
  }) : _members = members;

  @override
  final int sequence;
  @override
  final GalleryDuplicatesNotice notice;
  @override
  final String? jobId;
  final List<GalleryDuplicateMember> _members;
  @override
  @JsonKey()
  List<GalleryDuplicateMember> get members {
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  @override
  final GalleryOperationResult? result;

  /// Create a copy of GalleryDuplicatesEffect
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GalleryDuplicatesEffectCopyWith<_GalleryDuplicatesEffect> get copyWith =>
      __$GalleryDuplicatesEffectCopyWithImpl<_GalleryDuplicatesEffect>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GalleryDuplicatesEffect &&
            (identical(other.sequence, sequence) ||
                other.sequence == sequence) &&
            (identical(other.notice, notice) || other.notice == notice) &&
            (identical(other.jobId, jobId) || other.jobId == jobId) &&
            const DeepCollectionEquality().equals(other.members, _members) &&
            (identical(other.result, result) || other.result == result));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      sequence,
      notice,
      jobId,
      const DeepCollectionEquality().hash(_members),
      result,
    );
  }

  @override
  String toString() {
    return 'GalleryDuplicatesEffect(sequence: $sequence, notice: $notice, jobId: $jobId, members: $members, result: $result)';
  }
}

/// @nodoc
abstract mixin class _$GalleryDuplicatesEffectCopyWith<$Res>
    implements $GalleryDuplicatesEffectCopyWith<$Res> {
  factory _$GalleryDuplicatesEffectCopyWith(
    _GalleryDuplicatesEffect value,
    $Res Function(_GalleryDuplicatesEffect) _then,
  ) = __$GalleryDuplicatesEffectCopyWithImpl;
  @override
  @useResult
  $Res call({
    int sequence,
    GalleryDuplicatesNotice notice,
    String? jobId,
    List<GalleryDuplicateMember> members,
    GalleryOperationResult? result,
  });

  @override
  $GalleryOperationResultCopyWith<$Res>? get result;
}

/// @nodoc
class __$GalleryDuplicatesEffectCopyWithImpl<$Res>
    implements _$GalleryDuplicatesEffectCopyWith<$Res> {
  __$GalleryDuplicatesEffectCopyWithImpl(this._self, this._then);

  final _GalleryDuplicatesEffect _self;
  final $Res Function(_GalleryDuplicatesEffect) _then;

  /// Create a copy of GalleryDuplicatesEffect
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? sequence = null,
    Object? notice = null,
    Object? jobId = freezed,
    Object? members = null,
    Object? result = freezed,
  }) {
    return _then(
      _GalleryDuplicatesEffect(
        sequence: null == sequence
            ? _self.sequence
            : sequence // ignore: cast_nullable_to_non_nullable
                  as int,
        notice: null == notice
            ? _self.notice
            : notice // ignore: cast_nullable_to_non_nullable
                  as GalleryDuplicatesNotice,
        jobId: freezed == jobId
            ? _self.jobId
            : jobId // ignore: cast_nullable_to_non_nullable
                  as String?,
        members: null == members
            ? _self._members
            : members // ignore: cast_nullable_to_non_nullable
                  as List<GalleryDuplicateMember>,
        result: freezed == result
            ? _self.result
            : result // ignore: cast_nullable_to_non_nullable
                  as GalleryOperationResult?,
      ),
    );
  }

  /// Create a copy of GalleryDuplicatesEffect
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
mixin _$GalleryDuplicatesState {
  GalleryDuplicatesCatalogSnapshot get catalogSnapshot;
  Set<GalleryDuplicateMode> get modes;
  Map<String, GalleryDuplicateDecision> get decisions;
  Set<GalleryMediaRef> get invalidated;
  GalleryDuplicateJob? get job;
  GalleryDuplicateStartRequest? get pendingStart;
  GalleryDuplicatesEffect? get effect;
  bool get loading;
  bool get busy;
  bool get failed;
  GalleryErrorCode? get requestError;
  bool get setup;
  bool get polling;
  int get elapsedSeconds;
  int get groupIndex;
  int get memberOffset;
  GalleryDuplicateGroup? get visibleGroup;
  bool get groupLoading;

  /// Create a copy of GalleryDuplicatesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryDuplicatesStateCopyWith<GalleryDuplicatesState> get copyWith =>
      _$GalleryDuplicatesStateCopyWithImpl<GalleryDuplicatesState>(
        this as GalleryDuplicatesState,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    final _this = this as GalleryDuplicatesState;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryDuplicatesState &&
            (identical(other.catalogSnapshot, _this.catalogSnapshot) ||
                other.catalogSnapshot == _this.catalogSnapshot) &&
            const DeepCollectionEquality().equals(other.modes, _this.modes) &&
            const DeepCollectionEquality().equals(
              other.decisions,
              _this.decisions,
            ) &&
            const DeepCollectionEquality().equals(
              other.invalidated,
              _this.invalidated,
            ) &&
            (identical(other.job, _this.job) || other.job == _this.job) &&
            (identical(other.pendingStart, _this.pendingStart) ||
                other.pendingStart == _this.pendingStart) &&
            (identical(other.effect, _this.effect) ||
                other.effect == _this.effect) &&
            (identical(other.loading, _this.loading) ||
                other.loading == _this.loading) &&
            (identical(other.busy, _this.busy) || other.busy == _this.busy) &&
            (identical(other.failed, _this.failed) ||
                other.failed == _this.failed) &&
            (identical(other.requestError, _this.requestError) ||
                other.requestError == _this.requestError) &&
            (identical(other.setup, _this.setup) ||
                other.setup == _this.setup) &&
            (identical(other.polling, _this.polling) ||
                other.polling == _this.polling) &&
            (identical(other.elapsedSeconds, _this.elapsedSeconds) ||
                other.elapsedSeconds == _this.elapsedSeconds) &&
            (identical(other.groupIndex, _this.groupIndex) ||
                other.groupIndex == _this.groupIndex) &&
            (identical(other.memberOffset, _this.memberOffset) ||
                other.memberOffset == _this.memberOffset) &&
            (identical(other.visibleGroup, _this.visibleGroup) ||
                other.visibleGroup == _this.visibleGroup) &&
            (identical(other.groupLoading, _this.groupLoading) ||
                other.groupLoading == _this.groupLoading));
  }

  @override
  int get hashCode {
    final _this = this as GalleryDuplicatesState;
    return Object.hash(
      runtimeType,
      _this.catalogSnapshot,
      const DeepCollectionEquality().hash(_this.modes),
      const DeepCollectionEquality().hash(_this.decisions),
      const DeepCollectionEquality().hash(_this.invalidated),
      _this.job,
      _this.pendingStart,
      _this.effect,
      _this.loading,
      _this.busy,
      _this.failed,
      _this.requestError,
      _this.setup,
      _this.polling,
      _this.elapsedSeconds,
      _this.groupIndex,
      _this.memberOffset,
      _this.visibleGroup,
      _this.groupLoading,
    );
  }

  @override
  String toString() {
    final _this = this as GalleryDuplicatesState;
    return 'GalleryDuplicatesState(catalogSnapshot: ${_this.catalogSnapshot}, modes: ${_this.modes}, decisions: ${_this.decisions}, invalidated: ${_this.invalidated}, job: ${_this.job}, pendingStart: ${_this.pendingStart}, effect: ${_this.effect}, loading: ${_this.loading}, busy: ${_this.busy}, failed: ${_this.failed}, requestError: ${_this.requestError}, setup: ${_this.setup}, polling: ${_this.polling}, elapsedSeconds: ${_this.elapsedSeconds}, groupIndex: ${_this.groupIndex}, memberOffset: ${_this.memberOffset}, visibleGroup: ${_this.visibleGroup}, groupLoading: ${_this.groupLoading})';
  }
}

/// @nodoc
abstract mixin class $GalleryDuplicatesStateCopyWith<$Res> {
  factory $GalleryDuplicatesStateCopyWith(
    GalleryDuplicatesState value,
    $Res Function(GalleryDuplicatesState) _then,
  ) = _$GalleryDuplicatesStateCopyWithImpl;
  @useResult
  $Res call({
    GalleryDuplicatesCatalogSnapshot catalogSnapshot,
    Set<GalleryDuplicateMode> modes,
    Map<String, GalleryDuplicateDecision> decisions,
    Set<GalleryMediaRef> invalidated,
    GalleryDuplicateJob? job,
    GalleryDuplicateStartRequest? pendingStart,
    GalleryDuplicatesEffect? effect,
    bool loading,
    bool busy,
    bool failed,
    GalleryErrorCode? requestError,
    bool setup,
    bool polling,
    int elapsedSeconds,
    int groupIndex,
    int memberOffset,
    GalleryDuplicateGroup? visibleGroup,
    bool groupLoading,
  });

  $GalleryDuplicatesCatalogSnapshotCopyWith<$Res> get catalogSnapshot;
  $GalleryDuplicateJobCopyWith<$Res>? get job;
  $GalleryDuplicateStartRequestCopyWith<$Res>? get pendingStart;
  $GalleryDuplicatesEffectCopyWith<$Res>? get effect;
  $GalleryDuplicateGroupCopyWith<$Res>? get visibleGroup;
}

/// @nodoc
class _$GalleryDuplicatesStateCopyWithImpl<$Res>
    implements $GalleryDuplicatesStateCopyWith<$Res> {
  _$GalleryDuplicatesStateCopyWithImpl(this._self, this._then);

  final GalleryDuplicatesState _self;
  final $Res Function(GalleryDuplicatesState) _then;

  /// Create a copy of GalleryDuplicatesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? catalogSnapshot = null,
    Object? modes = null,
    Object? decisions = null,
    Object? invalidated = null,
    Object? job = freezed,
    Object? pendingStart = freezed,
    Object? effect = freezed,
    Object? loading = null,
    Object? busy = null,
    Object? failed = null,
    Object? requestError = freezed,
    Object? setup = null,
    Object? polling = null,
    Object? elapsedSeconds = null,
    Object? groupIndex = null,
    Object? memberOffset = null,
    Object? visibleGroup = freezed,
    Object? groupLoading = null,
  }) {
    return _then(
      GalleryDuplicatesState(
        catalogSnapshot: null == catalogSnapshot
            ? _self.catalogSnapshot
            : catalogSnapshot // ignore: cast_nullable_to_non_nullable
                  as GalleryDuplicatesCatalogSnapshot,
        modes: null == modes
            ? _self.modes
            : modes // ignore: cast_nullable_to_non_nullable
                  as Set<GalleryDuplicateMode>,
        decisions: null == decisions
            ? _self.decisions
            : decisions // ignore: cast_nullable_to_non_nullable
                  as Map<String, GalleryDuplicateDecision>,
        invalidated: null == invalidated
            ? _self.invalidated
            : invalidated // ignore: cast_nullable_to_non_nullable
                  as Set<GalleryMediaRef>,
        job: freezed == job
            ? _self.job
            : job // ignore: cast_nullable_to_non_nullable
                  as GalleryDuplicateJob?,
        pendingStart: freezed == pendingStart
            ? _self.pendingStart
            : pendingStart // ignore: cast_nullable_to_non_nullable
                  as GalleryDuplicateStartRequest?,
        effect: freezed == effect
            ? _self.effect
            : effect // ignore: cast_nullable_to_non_nullable
                  as GalleryDuplicatesEffect?,
        loading: null == loading
            ? _self.loading
            : loading // ignore: cast_nullable_to_non_nullable
                  as bool,
        busy: null == busy
            ? _self.busy
            : busy // ignore: cast_nullable_to_non_nullable
                  as bool,
        failed: null == failed
            ? _self.failed
            : failed // ignore: cast_nullable_to_non_nullable
                  as bool,
        requestError: freezed == requestError
            ? _self.requestError
            : requestError // ignore: cast_nullable_to_non_nullable
                  as GalleryErrorCode?,
        setup: null == setup
            ? _self.setup
            : setup // ignore: cast_nullable_to_non_nullable
                  as bool,
        polling: null == polling
            ? _self.polling
            : polling // ignore: cast_nullable_to_non_nullable
                  as bool,
        elapsedSeconds: null == elapsedSeconds
            ? _self.elapsedSeconds
            : elapsedSeconds // ignore: cast_nullable_to_non_nullable
                  as int,
        groupIndex: null == groupIndex
            ? _self.groupIndex
            : groupIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        memberOffset: null == memberOffset
            ? _self.memberOffset
            : memberOffset // ignore: cast_nullable_to_non_nullable
                  as int,
        visibleGroup: freezed == visibleGroup
            ? _self.visibleGroup
            : visibleGroup // ignore: cast_nullable_to_non_nullable
                  as GalleryDuplicateGroup?,
        groupLoading: null == groupLoading
            ? _self.groupLoading
            : groupLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }

  /// Create a copy of GalleryDuplicatesState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryDuplicatesCatalogSnapshotCopyWith<$Res> get catalogSnapshot {
    return $GalleryDuplicatesCatalogSnapshotCopyWith<$Res>(
      _self.catalogSnapshot,
      (value) {
        return _then(_self.copyWith(catalogSnapshot: value));
      },
    );
  }

  /// Create a copy of GalleryDuplicatesState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryDuplicateJobCopyWith<$Res>? get job {
    if (_self.job == null) {
      return null;
    }

    return $GalleryDuplicateJobCopyWith<$Res>(_self.job!, (value) {
      return _then(_self.copyWith(job: value));
    });
  }

  /// Create a copy of GalleryDuplicatesState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryDuplicateStartRequestCopyWith<$Res>? get pendingStart {
    if (_self.pendingStart == null) {
      return null;
    }

    return $GalleryDuplicateStartRequestCopyWith<$Res>(_self.pendingStart!, (
      value,
    ) {
      return _then(_self.copyWith(pendingStart: value));
    });
  }

  /// Create a copy of GalleryDuplicatesState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryDuplicatesEffectCopyWith<$Res>? get effect {
    if (_self.effect == null) {
      return null;
    }

    return $GalleryDuplicatesEffectCopyWith<$Res>(_self.effect!, (value) {
      return _then(_self.copyWith(effect: value));
    });
  }

  /// Create a copy of GalleryDuplicatesState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryDuplicateGroupCopyWith<$Res>? get visibleGroup {
    if (_self.visibleGroup == null) {
      return null;
    }

    return $GalleryDuplicateGroupCopyWith<$Res>(_self.visibleGroup!, (value) {
      return _then(_self.copyWith(visibleGroup: value));
    });
  }
}

/// Adds pattern-matching-related methods to [GalleryDuplicatesState].
extension GalleryDuplicatesStatePatterns on GalleryDuplicatesState {
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
    TResult Function(_GalleryDuplicatesState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicatesState() when $default != null:
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
    TResult Function(_GalleryDuplicatesState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicatesState():
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
    TResult? Function(_GalleryDuplicatesState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicatesState() when $default != null:
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
      GalleryDuplicatesCatalogSnapshot catalogSnapshot,
      Set<GalleryDuplicateMode> modes,
      Map<String, GalleryDuplicateDecision> decisions,
      Set<GalleryMediaRef> invalidated,
      GalleryDuplicateJob? job,
      GalleryDuplicateStartRequest? pendingStart,
      GalleryDuplicatesEffect? effect,
      bool loading,
      bool busy,
      bool failed,
      GalleryErrorCode? requestError,
      bool setup,
      bool polling,
      int elapsedSeconds,
      int groupIndex,
      int memberOffset,
      GalleryDuplicateGroup? visibleGroup,
      bool groupLoading,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicatesState() when $default != null:
        return $default(
          _that.catalogSnapshot,
          _that.modes,
          _that.decisions,
          _that.invalidated,
          _that.job,
          _that.pendingStart,
          _that.effect,
          _that.loading,
          _that.busy,
          _that.failed,
          _that.requestError,
          _that.setup,
          _that.polling,
          _that.elapsedSeconds,
          _that.groupIndex,
          _that.memberOffset,
          _that.visibleGroup,
          _that.groupLoading,
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
      GalleryDuplicatesCatalogSnapshot catalogSnapshot,
      Set<GalleryDuplicateMode> modes,
      Map<String, GalleryDuplicateDecision> decisions,
      Set<GalleryMediaRef> invalidated,
      GalleryDuplicateJob? job,
      GalleryDuplicateStartRequest? pendingStart,
      GalleryDuplicatesEffect? effect,
      bool loading,
      bool busy,
      bool failed,
      GalleryErrorCode? requestError,
      bool setup,
      bool polling,
      int elapsedSeconds,
      int groupIndex,
      int memberOffset,
      GalleryDuplicateGroup? visibleGroup,
      bool groupLoading,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicatesState():
        return $default(
          _that.catalogSnapshot,
          _that.modes,
          _that.decisions,
          _that.invalidated,
          _that.job,
          _that.pendingStart,
          _that.effect,
          _that.loading,
          _that.busy,
          _that.failed,
          _that.requestError,
          _that.setup,
          _that.polling,
          _that.elapsedSeconds,
          _that.groupIndex,
          _that.memberOffset,
          _that.visibleGroup,
          _that.groupLoading,
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
      GalleryDuplicatesCatalogSnapshot catalogSnapshot,
      Set<GalleryDuplicateMode> modes,
      Map<String, GalleryDuplicateDecision> decisions,
      Set<GalleryMediaRef> invalidated,
      GalleryDuplicateJob? job,
      GalleryDuplicateStartRequest? pendingStart,
      GalleryDuplicatesEffect? effect,
      bool loading,
      bool busy,
      bool failed,
      GalleryErrorCode? requestError,
      bool setup,
      bool polling,
      int elapsedSeconds,
      int groupIndex,
      int memberOffset,
      GalleryDuplicateGroup? visibleGroup,
      bool groupLoading,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicatesState() when $default != null:
        return $default(
          _that.catalogSnapshot,
          _that.modes,
          _that.decisions,
          _that.invalidated,
          _that.job,
          _that.pendingStart,
          _that.effect,
          _that.loading,
          _that.busy,
          _that.failed,
          _that.requestError,
          _that.setup,
          _that.polling,
          _that.elapsedSeconds,
          _that.groupIndex,
          _that.memberOffset,
          _that.visibleGroup,
          _that.groupLoading,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _GalleryDuplicatesState extends GalleryDuplicatesState {
  const _GalleryDuplicatesState({
    this.catalogSnapshot = const GalleryDuplicatesCatalogSnapshot(),
    Set<GalleryDuplicateMode> modes = const {
      GalleryDuplicateMode.exact,
      GalleryDuplicateMode.similar,
    },
    Map<String, GalleryDuplicateDecision> decisions = const {},
    Set<GalleryMediaRef> invalidated = const {},
    this.job,
    this.pendingStart,
    this.effect,
    this.loading = true,
    this.busy = false,
    this.failed = false,
    this.requestError,
    this.setup = false,
    this.polling = false,
    this.elapsedSeconds = 0,
    this.groupIndex = 0,
    this.memberOffset = 0,
    this.visibleGroup,
    this.groupLoading = false,
  }) : _modes = modes,
       _decisions = decisions,
       _invalidated = invalidated,
       super._();

  @override
  @JsonKey()
  final GalleryDuplicatesCatalogSnapshot catalogSnapshot;
  final Set<GalleryDuplicateMode> _modes;
  @override
  @JsonKey()
  Set<GalleryDuplicateMode> get modes {
    if (_modes is EqualUnmodifiableSetView) return _modes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_modes);
  }

  final Map<String, GalleryDuplicateDecision> _decisions;
  @override
  @JsonKey()
  Map<String, GalleryDuplicateDecision> get decisions {
    if (_decisions is EqualUnmodifiableMapView) return _decisions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_decisions);
  }

  final Set<GalleryMediaRef> _invalidated;
  @override
  @JsonKey()
  Set<GalleryMediaRef> get invalidated {
    if (_invalidated is EqualUnmodifiableSetView) return _invalidated;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_invalidated);
  }

  @override
  final GalleryDuplicateJob? job;
  @override
  final GalleryDuplicateStartRequest? pendingStart;
  @override
  final GalleryDuplicatesEffect? effect;
  @override
  @JsonKey()
  final bool loading;
  @override
  @JsonKey()
  final bool busy;
  @override
  @JsonKey()
  final bool failed;
  @override
  final GalleryErrorCode? requestError;
  @override
  @JsonKey()
  final bool setup;
  @override
  @JsonKey()
  final bool polling;
  @override
  @JsonKey()
  final int elapsedSeconds;
  @override
  @JsonKey()
  final int groupIndex;
  @override
  @JsonKey()
  final int memberOffset;
  @override
  final GalleryDuplicateGroup? visibleGroup;
  @override
  @JsonKey()
  final bool groupLoading;

  /// Create a copy of GalleryDuplicatesState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GalleryDuplicatesStateCopyWith<_GalleryDuplicatesState> get copyWith =>
      __$GalleryDuplicatesStateCopyWithImpl<_GalleryDuplicatesState>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GalleryDuplicatesState &&
            (identical(other.catalogSnapshot, catalogSnapshot) ||
                other.catalogSnapshot == catalogSnapshot) &&
            const DeepCollectionEquality().equals(other.modes, _modes) &&
            const DeepCollectionEquality().equals(
              other.decisions,
              _decisions,
            ) &&
            const DeepCollectionEquality().equals(
              other.invalidated,
              _invalidated,
            ) &&
            (identical(other.job, job) || other.job == job) &&
            (identical(other.pendingStart, pendingStart) ||
                other.pendingStart == pendingStart) &&
            (identical(other.effect, effect) || other.effect == effect) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.busy, busy) || other.busy == busy) &&
            (identical(other.failed, failed) || other.failed == failed) &&
            (identical(other.requestError, requestError) ||
                other.requestError == requestError) &&
            (identical(other.setup, setup) || other.setup == setup) &&
            (identical(other.polling, polling) || other.polling == polling) &&
            (identical(other.elapsedSeconds, elapsedSeconds) ||
                other.elapsedSeconds == elapsedSeconds) &&
            (identical(other.groupIndex, groupIndex) ||
                other.groupIndex == groupIndex) &&
            (identical(other.memberOffset, memberOffset) ||
                other.memberOffset == memberOffset) &&
            (identical(other.visibleGroup, visibleGroup) ||
                other.visibleGroup == visibleGroup) &&
            (identical(other.groupLoading, groupLoading) ||
                other.groupLoading == groupLoading));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      catalogSnapshot,
      const DeepCollectionEquality().hash(_modes),
      const DeepCollectionEquality().hash(_decisions),
      const DeepCollectionEquality().hash(_invalidated),
      job,
      pendingStart,
      effect,
      loading,
      busy,
      failed,
      requestError,
      setup,
      polling,
      elapsedSeconds,
      groupIndex,
      memberOffset,
      visibleGroup,
      groupLoading,
    );
  }

  @override
  String toString() {
    return 'GalleryDuplicatesState(catalogSnapshot: $catalogSnapshot, modes: $modes, decisions: $decisions, invalidated: $invalidated, job: $job, pendingStart: $pendingStart, effect: $effect, loading: $loading, busy: $busy, failed: $failed, requestError: $requestError, setup: $setup, polling: $polling, elapsedSeconds: $elapsedSeconds, groupIndex: $groupIndex, memberOffset: $memberOffset, visibleGroup: $visibleGroup, groupLoading: $groupLoading)';
  }
}

/// @nodoc
abstract mixin class _$GalleryDuplicatesStateCopyWith<$Res>
    implements $GalleryDuplicatesStateCopyWith<$Res> {
  factory _$GalleryDuplicatesStateCopyWith(
    _GalleryDuplicatesState value,
    $Res Function(_GalleryDuplicatesState) _then,
  ) = __$GalleryDuplicatesStateCopyWithImpl;
  @override
  @useResult
  $Res call({
    GalleryDuplicatesCatalogSnapshot catalogSnapshot,
    Set<GalleryDuplicateMode> modes,
    Map<String, GalleryDuplicateDecision> decisions,
    Set<GalleryMediaRef> invalidated,
    GalleryDuplicateJob? job,
    GalleryDuplicateStartRequest? pendingStart,
    GalleryDuplicatesEffect? effect,
    bool loading,
    bool busy,
    bool failed,
    GalleryErrorCode? requestError,
    bool setup,
    bool polling,
    int elapsedSeconds,
    int groupIndex,
    int memberOffset,
    GalleryDuplicateGroup? visibleGroup,
    bool groupLoading,
  });

  @override
  $GalleryDuplicatesCatalogSnapshotCopyWith<$Res> get catalogSnapshot;
  @override
  $GalleryDuplicateJobCopyWith<$Res>? get job;
  @override
  $GalleryDuplicateStartRequestCopyWith<$Res>? get pendingStart;
  @override
  $GalleryDuplicatesEffectCopyWith<$Res>? get effect;
  @override
  $GalleryDuplicateGroupCopyWith<$Res>? get visibleGroup;
}

/// @nodoc
class __$GalleryDuplicatesStateCopyWithImpl<$Res>
    implements _$GalleryDuplicatesStateCopyWith<$Res> {
  __$GalleryDuplicatesStateCopyWithImpl(this._self, this._then);

  final _GalleryDuplicatesState _self;
  final $Res Function(_GalleryDuplicatesState) _then;

  /// Create a copy of GalleryDuplicatesState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? catalogSnapshot = null,
    Object? modes = null,
    Object? decisions = null,
    Object? invalidated = null,
    Object? job = freezed,
    Object? pendingStart = freezed,
    Object? effect = freezed,
    Object? loading = null,
    Object? busy = null,
    Object? failed = null,
    Object? requestError = freezed,
    Object? setup = null,
    Object? polling = null,
    Object? elapsedSeconds = null,
    Object? groupIndex = null,
    Object? memberOffset = null,
    Object? visibleGroup = freezed,
    Object? groupLoading = null,
  }) {
    return _then(
      _GalleryDuplicatesState(
        catalogSnapshot: null == catalogSnapshot
            ? _self.catalogSnapshot
            : catalogSnapshot // ignore: cast_nullable_to_non_nullable
                  as GalleryDuplicatesCatalogSnapshot,
        modes: null == modes
            ? _self._modes
            : modes // ignore: cast_nullable_to_non_nullable
                  as Set<GalleryDuplicateMode>,
        decisions: null == decisions
            ? _self._decisions
            : decisions // ignore: cast_nullable_to_non_nullable
                  as Map<String, GalleryDuplicateDecision>,
        invalidated: null == invalidated
            ? _self._invalidated
            : invalidated // ignore: cast_nullable_to_non_nullable
                  as Set<GalleryMediaRef>,
        job: freezed == job
            ? _self.job
            : job // ignore: cast_nullable_to_non_nullable
                  as GalleryDuplicateJob?,
        pendingStart: freezed == pendingStart
            ? _self.pendingStart
            : pendingStart // ignore: cast_nullable_to_non_nullable
                  as GalleryDuplicateStartRequest?,
        effect: freezed == effect
            ? _self.effect
            : effect // ignore: cast_nullable_to_non_nullable
                  as GalleryDuplicatesEffect?,
        loading: null == loading
            ? _self.loading
            : loading // ignore: cast_nullable_to_non_nullable
                  as bool,
        busy: null == busy
            ? _self.busy
            : busy // ignore: cast_nullable_to_non_nullable
                  as bool,
        failed: null == failed
            ? _self.failed
            : failed // ignore: cast_nullable_to_non_nullable
                  as bool,
        requestError: freezed == requestError
            ? _self.requestError
            : requestError // ignore: cast_nullable_to_non_nullable
                  as GalleryErrorCode?,
        setup: null == setup
            ? _self.setup
            : setup // ignore: cast_nullable_to_non_nullable
                  as bool,
        polling: null == polling
            ? _self.polling
            : polling // ignore: cast_nullable_to_non_nullable
                  as bool,
        elapsedSeconds: null == elapsedSeconds
            ? _self.elapsedSeconds
            : elapsedSeconds // ignore: cast_nullable_to_non_nullable
                  as int,
        groupIndex: null == groupIndex
            ? _self.groupIndex
            : groupIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        memberOffset: null == memberOffset
            ? _self.memberOffset
            : memberOffset // ignore: cast_nullable_to_non_nullable
                  as int,
        visibleGroup: freezed == visibleGroup
            ? _self.visibleGroup
            : visibleGroup // ignore: cast_nullable_to_non_nullable
                  as GalleryDuplicateGroup?,
        groupLoading: null == groupLoading
            ? _self.groupLoading
            : groupLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }

  /// Create a copy of GalleryDuplicatesState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryDuplicatesCatalogSnapshotCopyWith<$Res> get catalogSnapshot {
    return $GalleryDuplicatesCatalogSnapshotCopyWith<$Res>(
      _self.catalogSnapshot,
      (value) {
        return _then(_self.copyWith(catalogSnapshot: value));
      },
    );
  }

  /// Create a copy of GalleryDuplicatesState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryDuplicateJobCopyWith<$Res>? get job {
    if (_self.job == null) {
      return null;
    }

    return $GalleryDuplicateJobCopyWith<$Res>(_self.job!, (value) {
      return _then(_self.copyWith(job: value));
    });
  }

  /// Create a copy of GalleryDuplicatesState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryDuplicateStartRequestCopyWith<$Res>? get pendingStart {
    if (_self.pendingStart == null) {
      return null;
    }

    return $GalleryDuplicateStartRequestCopyWith<$Res>(_self.pendingStart!, (
      value,
    ) {
      return _then(_self.copyWith(pendingStart: value));
    });
  }

  /// Create a copy of GalleryDuplicatesState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryDuplicatesEffectCopyWith<$Res>? get effect {
    if (_self.effect == null) {
      return null;
    }

    return $GalleryDuplicatesEffectCopyWith<$Res>(_self.effect!, (value) {
      return _then(_self.copyWith(effect: value));
    });
  }

  /// Create a copy of GalleryDuplicatesState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryDuplicateGroupCopyWith<$Res>? get visibleGroup {
    if (_self.visibleGroup == null) {
      return null;
    }

    return $GalleryDuplicateGroupCopyWith<$Res>(_self.visibleGroup!, (value) {
      return _then(_self.copyWith(visibleGroup: value));
    });
  }
}

/// @nodoc
mixin _$GalleryDuplicatesEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is GalleryDuplicatesEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'GalleryDuplicatesEvent()';
  }
}

/// @nodoc
class $GalleryDuplicatesEventCopyWith<$Res> {
  $GalleryDuplicatesEventCopyWith(
    GalleryDuplicatesEvent _,
    $Res Function(GalleryDuplicatesEvent) __,
  );
}

/// Adds pattern-matching-related methods to [GalleryDuplicatesEvent].
extension GalleryDuplicatesEventPatterns on GalleryDuplicatesEvent {
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
    TResult Function(GalleryDuplicatesLoad value)? load,
    TResult Function(GalleryDuplicatesTick value)? tick,
    TResult Function(GalleryDuplicatesCatalog value)? catalog,
    TResult Function(GalleryDuplicatesMode value)? mode,
    TResult Function(GalleryDuplicatesStart value)? start,
    TResult Function(GalleryDuplicatesStop value)? stop,
    TResult Function(GalleryDuplicatesSetup value)? setup,
    TResult Function(GalleryDuplicatesDecide value)? decide,
    TResult Function(GalleryDuplicatesMembers value)? members,
    TResult Function(GalleryDuplicatesSkip value)? skip,
    TResult Function(GalleryDuplicatesInvalidate value)? invalidate,
    TResult Function(GalleryDuplicatesReview value)? review,
    TResult Function(GalleryDuplicatesApply value)? apply,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case GalleryDuplicatesLoad() when load != null:
        return load(_that);
      case GalleryDuplicatesTick() when tick != null:
        return tick(_that);
      case GalleryDuplicatesCatalog() when catalog != null:
        return catalog(_that);
      case GalleryDuplicatesMode() when mode != null:
        return mode(_that);
      case GalleryDuplicatesStart() when start != null:
        return start(_that);
      case GalleryDuplicatesStop() when stop != null:
        return stop(_that);
      case GalleryDuplicatesSetup() when setup != null:
        return setup(_that);
      case GalleryDuplicatesDecide() when decide != null:
        return decide(_that);
      case GalleryDuplicatesMembers() when members != null:
        return members(_that);
      case GalleryDuplicatesSkip() when skip != null:
        return skip(_that);
      case GalleryDuplicatesInvalidate() when invalidate != null:
        return invalidate(_that);
      case GalleryDuplicatesReview() when review != null:
        return review(_that);
      case GalleryDuplicatesApply() when apply != null:
        return apply(_that);
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
    required TResult Function(GalleryDuplicatesLoad value) load,
    required TResult Function(GalleryDuplicatesTick value) tick,
    required TResult Function(GalleryDuplicatesCatalog value) catalog,
    required TResult Function(GalleryDuplicatesMode value) mode,
    required TResult Function(GalleryDuplicatesStart value) start,
    required TResult Function(GalleryDuplicatesStop value) stop,
    required TResult Function(GalleryDuplicatesSetup value) setup,
    required TResult Function(GalleryDuplicatesDecide value) decide,
    required TResult Function(GalleryDuplicatesMembers value) members,
    required TResult Function(GalleryDuplicatesSkip value) skip,
    required TResult Function(GalleryDuplicatesInvalidate value) invalidate,
    required TResult Function(GalleryDuplicatesReview value) review,
    required TResult Function(GalleryDuplicatesApply value) apply,
  }) {
    final _that = this;
    switch (_that) {
      case GalleryDuplicatesLoad():
        return load(_that);
      case GalleryDuplicatesTick():
        return tick(_that);
      case GalleryDuplicatesCatalog():
        return catalog(_that);
      case GalleryDuplicatesMode():
        return mode(_that);
      case GalleryDuplicatesStart():
        return start(_that);
      case GalleryDuplicatesStop():
        return stop(_that);
      case GalleryDuplicatesSetup():
        return setup(_that);
      case GalleryDuplicatesDecide():
        return decide(_that);
      case GalleryDuplicatesMembers():
        return members(_that);
      case GalleryDuplicatesSkip():
        return skip(_that);
      case GalleryDuplicatesInvalidate():
        return invalidate(_that);
      case GalleryDuplicatesReview():
        return review(_that);
      case GalleryDuplicatesApply():
        return apply(_that);
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
    TResult? Function(GalleryDuplicatesLoad value)? load,
    TResult? Function(GalleryDuplicatesTick value)? tick,
    TResult? Function(GalleryDuplicatesCatalog value)? catalog,
    TResult? Function(GalleryDuplicatesMode value)? mode,
    TResult? Function(GalleryDuplicatesStart value)? start,
    TResult? Function(GalleryDuplicatesStop value)? stop,
    TResult? Function(GalleryDuplicatesSetup value)? setup,
    TResult? Function(GalleryDuplicatesDecide value)? decide,
    TResult? Function(GalleryDuplicatesMembers value)? members,
    TResult? Function(GalleryDuplicatesSkip value)? skip,
    TResult? Function(GalleryDuplicatesInvalidate value)? invalidate,
    TResult? Function(GalleryDuplicatesReview value)? review,
    TResult? Function(GalleryDuplicatesApply value)? apply,
  }) {
    final _that = this;
    switch (_that) {
      case GalleryDuplicatesLoad() when load != null:
        return load(_that);
      case GalleryDuplicatesTick() when tick != null:
        return tick(_that);
      case GalleryDuplicatesCatalog() when catalog != null:
        return catalog(_that);
      case GalleryDuplicatesMode() when mode != null:
        return mode(_that);
      case GalleryDuplicatesStart() when start != null:
        return start(_that);
      case GalleryDuplicatesStop() when stop != null:
        return stop(_that);
      case GalleryDuplicatesSetup() when setup != null:
        return setup(_that);
      case GalleryDuplicatesDecide() when decide != null:
        return decide(_that);
      case GalleryDuplicatesMembers() when members != null:
        return members(_that);
      case GalleryDuplicatesSkip() when skip != null:
        return skip(_that);
      case GalleryDuplicatesInvalidate() when invalidate != null:
        return invalidate(_that);
      case GalleryDuplicatesReview() when review != null:
        return review(_that);
      case GalleryDuplicatesApply() when apply != null:
        return apply(_that);
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
    TResult Function()? tick,
    TResult Function(List<GalleryItem> items)? catalog,
    TResult Function(GalleryDuplicateMode mode, bool enabled)? mode,
    TResult Function()? start,
    TResult Function()? stop,
    TResult Function(bool visible)? setup,
    TResult Function(
      String groupId,
      String mediaId,
      GalleryDuplicateDecision decision,
    )?
    decide,
    TResult Function(int offset)? members,
    TResult Function()? skip,
    TResult Function(GalleryDuplicateMember member)? invalidate,
    TResult Function()? review,
    TResult Function(String jobId, List<GalleryDuplicateMember> members)? apply,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case GalleryDuplicatesLoad() when load != null:
        return load();
      case GalleryDuplicatesTick() when tick != null:
        return tick();
      case GalleryDuplicatesCatalog() when catalog != null:
        return catalog(_that.items);
      case GalleryDuplicatesMode() when mode != null:
        return mode(_that.mode, _that.enabled);
      case GalleryDuplicatesStart() when start != null:
        return start();
      case GalleryDuplicatesStop() when stop != null:
        return stop();
      case GalleryDuplicatesSetup() when setup != null:
        return setup(_that.visible);
      case GalleryDuplicatesDecide() when decide != null:
        return decide(_that.groupId, _that.mediaId, _that.decision);
      case GalleryDuplicatesMembers() when members != null:
        return members(_that.offset);
      case GalleryDuplicatesSkip() when skip != null:
        return skip();
      case GalleryDuplicatesInvalidate() when invalidate != null:
        return invalidate(_that.member);
      case GalleryDuplicatesReview() when review != null:
        return review();
      case GalleryDuplicatesApply() when apply != null:
        return apply(_that.jobId, _that.members);
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
    required TResult Function() tick,
    required TResult Function(List<GalleryItem> items) catalog,
    required TResult Function(GalleryDuplicateMode mode, bool enabled) mode,
    required TResult Function() start,
    required TResult Function() stop,
    required TResult Function(bool visible) setup,
    required TResult Function(
      String groupId,
      String mediaId,
      GalleryDuplicateDecision decision,
    )
    decide,
    required TResult Function(int offset) members,
    required TResult Function() skip,
    required TResult Function(GalleryDuplicateMember member) invalidate,
    required TResult Function() review,
    required TResult Function(
      String jobId,
      List<GalleryDuplicateMember> members,
    )
    apply,
  }) {
    final _that = this;
    switch (_that) {
      case GalleryDuplicatesLoad():
        return load();
      case GalleryDuplicatesTick():
        return tick();
      case GalleryDuplicatesCatalog():
        return catalog(_that.items);
      case GalleryDuplicatesMode():
        return mode(_that.mode, _that.enabled);
      case GalleryDuplicatesStart():
        return start();
      case GalleryDuplicatesStop():
        return stop();
      case GalleryDuplicatesSetup():
        return setup(_that.visible);
      case GalleryDuplicatesDecide():
        return decide(_that.groupId, _that.mediaId, _that.decision);
      case GalleryDuplicatesMembers():
        return members(_that.offset);
      case GalleryDuplicatesSkip():
        return skip();
      case GalleryDuplicatesInvalidate():
        return invalidate(_that.member);
      case GalleryDuplicatesReview():
        return review();
      case GalleryDuplicatesApply():
        return apply(_that.jobId, _that.members);
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
    TResult? Function()? tick,
    TResult? Function(List<GalleryItem> items)? catalog,
    TResult? Function(GalleryDuplicateMode mode, bool enabled)? mode,
    TResult? Function()? start,
    TResult? Function()? stop,
    TResult? Function(bool visible)? setup,
    TResult? Function(
      String groupId,
      String mediaId,
      GalleryDuplicateDecision decision,
    )?
    decide,
    TResult? Function(int offset)? members,
    TResult? Function()? skip,
    TResult? Function(GalleryDuplicateMember member)? invalidate,
    TResult? Function()? review,
    TResult? Function(String jobId, List<GalleryDuplicateMember> members)?
    apply,
  }) {
    final _that = this;
    switch (_that) {
      case GalleryDuplicatesLoad() when load != null:
        return load();
      case GalleryDuplicatesTick() when tick != null:
        return tick();
      case GalleryDuplicatesCatalog() when catalog != null:
        return catalog(_that.items);
      case GalleryDuplicatesMode() when mode != null:
        return mode(_that.mode, _that.enabled);
      case GalleryDuplicatesStart() when start != null:
        return start();
      case GalleryDuplicatesStop() when stop != null:
        return stop();
      case GalleryDuplicatesSetup() when setup != null:
        return setup(_that.visible);
      case GalleryDuplicatesDecide() when decide != null:
        return decide(_that.groupId, _that.mediaId, _that.decision);
      case GalleryDuplicatesMembers() when members != null:
        return members(_that.offset);
      case GalleryDuplicatesSkip() when skip != null:
        return skip();
      case GalleryDuplicatesInvalidate() when invalidate != null:
        return invalidate(_that.member);
      case GalleryDuplicatesReview() when review != null:
        return review();
      case GalleryDuplicatesApply() when apply != null:
        return apply(_that.jobId, _that.members);
      case _:
        return null;
    }
  }
}

/// @nodoc

class GalleryDuplicatesLoad implements GalleryDuplicatesEvent {
  const GalleryDuplicatesLoad();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is GalleryDuplicatesLoad);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'GalleryDuplicatesEvent.load()';
  }
}

/// @nodoc

class GalleryDuplicatesTick implements GalleryDuplicatesEvent {
  const GalleryDuplicatesTick();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is GalleryDuplicatesTick);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'GalleryDuplicatesEvent.tick()';
  }
}

/// @nodoc

class GalleryDuplicatesCatalog implements GalleryDuplicatesEvent {
  const GalleryDuplicatesCatalog(List<GalleryItem> items) : _items = items;

  final List<GalleryItem> _items;
  List<GalleryItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  /// Create a copy of GalleryDuplicatesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryDuplicatesCatalogCopyWith<GalleryDuplicatesCatalog> get copyWith =>
      _$GalleryDuplicatesCatalogCopyWithImpl<GalleryDuplicatesCatalog>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryDuplicatesCatalog &&
            const DeepCollectionEquality().equals(other.items, _items));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_items),
    );
  }

  @override
  String toString() {
    return 'GalleryDuplicatesEvent.catalog(items: $items)';
  }
}

/// @nodoc
abstract mixin class $GalleryDuplicatesCatalogCopyWith<$Res>
    implements $GalleryDuplicatesEventCopyWith<$Res> {
  factory $GalleryDuplicatesCatalogCopyWith(
    GalleryDuplicatesCatalog value,
    $Res Function(GalleryDuplicatesCatalog) _then,
  ) = _$GalleryDuplicatesCatalogCopyWithImpl;
  @useResult
  $Res call({List<GalleryItem> items});
}

/// @nodoc
class _$GalleryDuplicatesCatalogCopyWithImpl<$Res>
    implements $GalleryDuplicatesCatalogCopyWith<$Res> {
  _$GalleryDuplicatesCatalogCopyWithImpl(this._self, this._then);

  final GalleryDuplicatesCatalog _self;
  final $Res Function(GalleryDuplicatesCatalog) _then;

  /// Create a copy of GalleryDuplicatesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? items = null}) {
    return _then(
      GalleryDuplicatesCatalog(
        null == items
            ? _self._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<GalleryItem>,
      ),
    );
  }
}

/// @nodoc

class GalleryDuplicatesMode implements GalleryDuplicatesEvent {
  const GalleryDuplicatesMode(this.mode, this.enabled);

  final GalleryDuplicateMode mode;
  final bool enabled;

  /// Create a copy of GalleryDuplicatesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryDuplicatesModeCopyWith<GalleryDuplicatesMode> get copyWith =>
      _$GalleryDuplicatesModeCopyWithImpl<GalleryDuplicatesMode>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryDuplicatesMode &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.enabled, enabled) || other.enabled == enabled));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, mode, enabled);
  }

  @override
  String toString() {
    return 'GalleryDuplicatesEvent.mode(mode: $mode, enabled: $enabled)';
  }
}

/// @nodoc
abstract mixin class $GalleryDuplicatesModeCopyWith<$Res>
    implements $GalleryDuplicatesEventCopyWith<$Res> {
  factory $GalleryDuplicatesModeCopyWith(
    GalleryDuplicatesMode value,
    $Res Function(GalleryDuplicatesMode) _then,
  ) = _$GalleryDuplicatesModeCopyWithImpl;
  @useResult
  $Res call({GalleryDuplicateMode mode, bool enabled});
}

/// @nodoc
class _$GalleryDuplicatesModeCopyWithImpl<$Res>
    implements $GalleryDuplicatesModeCopyWith<$Res> {
  _$GalleryDuplicatesModeCopyWithImpl(this._self, this._then);

  final GalleryDuplicatesMode _self;
  final $Res Function(GalleryDuplicatesMode) _then;

  /// Create a copy of GalleryDuplicatesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? mode = null, Object? enabled = null}) {
    return _then(
      GalleryDuplicatesMode(
        null == mode
            ? _self.mode
            : mode // ignore: cast_nullable_to_non_nullable
                  as GalleryDuplicateMode,
        null == enabled
            ? _self.enabled
            : enabled // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class GalleryDuplicatesStart implements GalleryDuplicatesEvent {
  const GalleryDuplicatesStart();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is GalleryDuplicatesStart);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'GalleryDuplicatesEvent.start()';
  }
}

/// @nodoc

class GalleryDuplicatesStop implements GalleryDuplicatesEvent {
  const GalleryDuplicatesStop();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is GalleryDuplicatesStop);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'GalleryDuplicatesEvent.stop()';
  }
}

/// @nodoc

class GalleryDuplicatesSetup implements GalleryDuplicatesEvent {
  const GalleryDuplicatesSetup(this.visible);

  final bool visible;

  /// Create a copy of GalleryDuplicatesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryDuplicatesSetupCopyWith<GalleryDuplicatesSetup> get copyWith =>
      _$GalleryDuplicatesSetupCopyWithImpl<GalleryDuplicatesSetup>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryDuplicatesSetup &&
            (identical(other.visible, visible) || other.visible == visible));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, visible);
  }

  @override
  String toString() {
    return 'GalleryDuplicatesEvent.setup(visible: $visible)';
  }
}

/// @nodoc
abstract mixin class $GalleryDuplicatesSetupCopyWith<$Res>
    implements $GalleryDuplicatesEventCopyWith<$Res> {
  factory $GalleryDuplicatesSetupCopyWith(
    GalleryDuplicatesSetup value,
    $Res Function(GalleryDuplicatesSetup) _then,
  ) = _$GalleryDuplicatesSetupCopyWithImpl;
  @useResult
  $Res call({bool visible});
}

/// @nodoc
class _$GalleryDuplicatesSetupCopyWithImpl<$Res>
    implements $GalleryDuplicatesSetupCopyWith<$Res> {
  _$GalleryDuplicatesSetupCopyWithImpl(this._self, this._then);

  final GalleryDuplicatesSetup _self;
  final $Res Function(GalleryDuplicatesSetup) _then;

  /// Create a copy of GalleryDuplicatesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? visible = null}) {
    return _then(
      GalleryDuplicatesSetup(
        null == visible
            ? _self.visible
            : visible // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class GalleryDuplicatesDecide implements GalleryDuplicatesEvent {
  const GalleryDuplicatesDecide(this.groupId, this.mediaId, this.decision);

  final String groupId;
  final String mediaId;
  final GalleryDuplicateDecision decision;

  /// Create a copy of GalleryDuplicatesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryDuplicatesDecideCopyWith<GalleryDuplicatesDecide> get copyWith =>
      _$GalleryDuplicatesDecideCopyWithImpl<GalleryDuplicatesDecide>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryDuplicatesDecide &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.mediaId, mediaId) || other.mediaId == mediaId) &&
            (identical(other.decision, decision) ||
                other.decision == decision));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, groupId, mediaId, decision);
  }

  @override
  String toString() {
    return 'GalleryDuplicatesEvent.decide(groupId: $groupId, mediaId: $mediaId, decision: $decision)';
  }
}

/// @nodoc
abstract mixin class $GalleryDuplicatesDecideCopyWith<$Res>
    implements $GalleryDuplicatesEventCopyWith<$Res> {
  factory $GalleryDuplicatesDecideCopyWith(
    GalleryDuplicatesDecide value,
    $Res Function(GalleryDuplicatesDecide) _then,
  ) = _$GalleryDuplicatesDecideCopyWithImpl;
  @useResult
  $Res call({
    String groupId,
    String mediaId,
    GalleryDuplicateDecision decision,
  });
}

/// @nodoc
class _$GalleryDuplicatesDecideCopyWithImpl<$Res>
    implements $GalleryDuplicatesDecideCopyWith<$Res> {
  _$GalleryDuplicatesDecideCopyWithImpl(this._self, this._then);

  final GalleryDuplicatesDecide _self;
  final $Res Function(GalleryDuplicatesDecide) _then;

  /// Create a copy of GalleryDuplicatesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? groupId = null,
    Object? mediaId = null,
    Object? decision = null,
  }) {
    return _then(
      GalleryDuplicatesDecide(
        null == groupId
            ? _self.groupId
            : groupId // ignore: cast_nullable_to_non_nullable
                  as String,
        null == mediaId
            ? _self.mediaId
            : mediaId // ignore: cast_nullable_to_non_nullable
                  as String,
        null == decision
            ? _self.decision
            : decision // ignore: cast_nullable_to_non_nullable
                  as GalleryDuplicateDecision,
      ),
    );
  }
}

/// @nodoc

class GalleryDuplicatesMembers implements GalleryDuplicatesEvent {
  const GalleryDuplicatesMembers(this.offset);

  final int offset;

  /// Create a copy of GalleryDuplicatesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryDuplicatesMembersCopyWith<GalleryDuplicatesMembers> get copyWith =>
      _$GalleryDuplicatesMembersCopyWithImpl<GalleryDuplicatesMembers>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryDuplicatesMembers &&
            (identical(other.offset, offset) || other.offset == offset));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, offset);
  }

  @override
  String toString() {
    return 'GalleryDuplicatesEvent.members(offset: $offset)';
  }
}

/// @nodoc
abstract mixin class $GalleryDuplicatesMembersCopyWith<$Res>
    implements $GalleryDuplicatesEventCopyWith<$Res> {
  factory $GalleryDuplicatesMembersCopyWith(
    GalleryDuplicatesMembers value,
    $Res Function(GalleryDuplicatesMembers) _then,
  ) = _$GalleryDuplicatesMembersCopyWithImpl;
  @useResult
  $Res call({int offset});
}

/// @nodoc
class _$GalleryDuplicatesMembersCopyWithImpl<$Res>
    implements $GalleryDuplicatesMembersCopyWith<$Res> {
  _$GalleryDuplicatesMembersCopyWithImpl(this._self, this._then);

  final GalleryDuplicatesMembers _self;
  final $Res Function(GalleryDuplicatesMembers) _then;

  /// Create a copy of GalleryDuplicatesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? offset = null}) {
    return _then(
      GalleryDuplicatesMembers(
        null == offset
            ? _self.offset
            : offset // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class GalleryDuplicatesSkip implements GalleryDuplicatesEvent {
  const GalleryDuplicatesSkip();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is GalleryDuplicatesSkip);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'GalleryDuplicatesEvent.skip()';
  }
}

/// @nodoc

class GalleryDuplicatesInvalidate implements GalleryDuplicatesEvent {
  const GalleryDuplicatesInvalidate(this.member);

  final GalleryDuplicateMember member;

  /// Create a copy of GalleryDuplicatesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryDuplicatesInvalidateCopyWith<GalleryDuplicatesInvalidate>
  get copyWith =>
      _$GalleryDuplicatesInvalidateCopyWithImpl<GalleryDuplicatesInvalidate>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryDuplicatesInvalidate &&
            (identical(other.member, member) || other.member == member));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, member);
  }

  @override
  String toString() {
    return 'GalleryDuplicatesEvent.invalidate(member: $member)';
  }
}

/// @nodoc
abstract mixin class $GalleryDuplicatesInvalidateCopyWith<$Res>
    implements $GalleryDuplicatesEventCopyWith<$Res> {
  factory $GalleryDuplicatesInvalidateCopyWith(
    GalleryDuplicatesInvalidate value,
    $Res Function(GalleryDuplicatesInvalidate) _then,
  ) = _$GalleryDuplicatesInvalidateCopyWithImpl;
  @useResult
  $Res call({GalleryDuplicateMember member});

  $GalleryDuplicateMemberCopyWith<$Res> get member;
}

/// @nodoc
class _$GalleryDuplicatesInvalidateCopyWithImpl<$Res>
    implements $GalleryDuplicatesInvalidateCopyWith<$Res> {
  _$GalleryDuplicatesInvalidateCopyWithImpl(this._self, this._then);

  final GalleryDuplicatesInvalidate _self;
  final $Res Function(GalleryDuplicatesInvalidate) _then;

  /// Create a copy of GalleryDuplicatesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? member = null}) {
    return _then(
      GalleryDuplicatesInvalidate(
        null == member
            ? _self.member
            : member // ignore: cast_nullable_to_non_nullable
                  as GalleryDuplicateMember,
      ),
    );
  }

  /// Create a copy of GalleryDuplicatesEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryDuplicateMemberCopyWith<$Res> get member {
    return $GalleryDuplicateMemberCopyWith<$Res>(_self.member, (value) {
      return _then(_self.copyWith(member: value));
    });
  }
}

/// @nodoc

class GalleryDuplicatesReview implements GalleryDuplicatesEvent {
  const GalleryDuplicatesReview();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is GalleryDuplicatesReview);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'GalleryDuplicatesEvent.review()';
  }
}

/// @nodoc

class GalleryDuplicatesApply implements GalleryDuplicatesEvent {
  const GalleryDuplicatesApply(this.jobId, List<GalleryDuplicateMember> members)
    : _members = members;

  final String jobId;
  final List<GalleryDuplicateMember> _members;
  List<GalleryDuplicateMember> get members {
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  /// Create a copy of GalleryDuplicatesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryDuplicatesApplyCopyWith<GalleryDuplicatesApply> get copyWith =>
      _$GalleryDuplicatesApplyCopyWithImpl<GalleryDuplicatesApply>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryDuplicatesApply &&
            (identical(other.jobId, jobId) || other.jobId == jobId) &&
            const DeepCollectionEquality().equals(other.members, _members));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      jobId,
      const DeepCollectionEquality().hash(_members),
    );
  }

  @override
  String toString() {
    return 'GalleryDuplicatesEvent.apply(jobId: $jobId, members: $members)';
  }
}

/// @nodoc
abstract mixin class $GalleryDuplicatesApplyCopyWith<$Res>
    implements $GalleryDuplicatesEventCopyWith<$Res> {
  factory $GalleryDuplicatesApplyCopyWith(
    GalleryDuplicatesApply value,
    $Res Function(GalleryDuplicatesApply) _then,
  ) = _$GalleryDuplicatesApplyCopyWithImpl;
  @useResult
  $Res call({String jobId, List<GalleryDuplicateMember> members});
}

/// @nodoc
class _$GalleryDuplicatesApplyCopyWithImpl<$Res>
    implements $GalleryDuplicatesApplyCopyWith<$Res> {
  _$GalleryDuplicatesApplyCopyWithImpl(this._self, this._then);

  final GalleryDuplicatesApply _self;
  final $Res Function(GalleryDuplicatesApply) _then;

  /// Create a copy of GalleryDuplicatesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? jobId = null, Object? members = null}) {
    return _then(
      GalleryDuplicatesApply(
        null == jobId
            ? _self.jobId
            : jobId // ignore: cast_nullable_to_non_nullable
                  as String,
        null == members
            ? _self._members
            : members // ignore: cast_nullable_to_non_nullable
                  as List<GalleryDuplicateMember>,
      ),
    );
  }
}
