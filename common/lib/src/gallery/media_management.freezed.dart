// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'media_management.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GalleryOperationRequest {
  String get operationId;
  GalleryMutation get action;
  List<GalleryMediaRef> get items;

  /// Create a copy of GalleryOperationRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryOperationRequestCopyWith<GalleryOperationRequest> get copyWith =>
      _$GalleryOperationRequestCopyWithImpl<GalleryOperationRequest>(
        this as GalleryOperationRequest,
        _$identity,
      );

  /// Serializes this GalleryOperationRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as GalleryOperationRequest;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryOperationRequest &&
            (identical(other.operationId, _this.operationId) ||
                other.operationId == _this.operationId) &&
            (identical(other.action, _this.action) ||
                other.action == _this.action) &&
            const DeepCollectionEquality().equals(other.items, _this.items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as GalleryOperationRequest;
    return Object.hash(
      runtimeType,
      _this.operationId,
      _this.action,
      const DeepCollectionEquality().hash(_this.items),
    );
  }

  @override
  String toString() {
    final _this = this as GalleryOperationRequest;
    return 'GalleryOperationRequest(operationId: ${_this.operationId}, action: ${_this.action}, items: ${_this.items})';
  }
}

/// @nodoc
abstract mixin class $GalleryOperationRequestCopyWith<$Res> {
  factory $GalleryOperationRequestCopyWith(
    GalleryOperationRequest value,
    $Res Function(GalleryOperationRequest) _then,
  ) = _$GalleryOperationRequestCopyWithImpl;
  @useResult
  $Res call({
    String operationId,
    GalleryMutation action,
    List<GalleryMediaRef> items,
  });
}

/// @nodoc
class _$GalleryOperationRequestCopyWithImpl<$Res>
    implements $GalleryOperationRequestCopyWith<$Res> {
  _$GalleryOperationRequestCopyWithImpl(this._self, this._then);

  final GalleryOperationRequest _self;
  final $Res Function(GalleryOperationRequest) _then;

  /// Create a copy of GalleryOperationRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? operationId = null,
    Object? action = null,
    Object? items = null,
  }) {
    return _then(
      GalleryOperationRequest(
        operationId: null == operationId
            ? _self.operationId
            : operationId // ignore: cast_nullable_to_non_nullable
                  as String,
        action: null == action
            ? _self.action
            : action // ignore: cast_nullable_to_non_nullable
                  as GalleryMutation,
        items: null == items
            ? _self.items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<GalleryMediaRef>,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [GalleryOperationRequest].
extension GalleryOperationRequestPatterns on GalleryOperationRequest {
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
    TResult Function(_GalleryOperationRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryOperationRequest() when $default != null:
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
    TResult Function(_GalleryOperationRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryOperationRequest():
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
    TResult? Function(_GalleryOperationRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryOperationRequest() when $default != null:
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
      String operationId,
      GalleryMutation action,
      List<GalleryMediaRef> items,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryOperationRequest() when $default != null:
        return $default(_that.operationId, _that.action, _that.items);
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
      String operationId,
      GalleryMutation action,
      List<GalleryMediaRef> items,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryOperationRequest():
        return $default(_that.operationId, _that.action, _that.items);
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
      String operationId,
      GalleryMutation action,
      List<GalleryMediaRef> items,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryOperationRequest() when $default != null:
        return $default(_that.operationId, _that.action, _that.items);
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _GalleryOperationRequest implements GalleryOperationRequest {
  const _GalleryOperationRequest({
    required this.operationId,
    required this.action,
    required List<GalleryMediaRef> items,
  }) : _items = items;
  factory _GalleryOperationRequest.fromJson(Map<String, dynamic> json) =>
      _$GalleryOperationRequestFromJson(json);

  @override
  final String operationId;
  @override
  final GalleryMutation action;
  final List<GalleryMediaRef> _items;
  @override
  List<GalleryMediaRef> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  /// Create a copy of GalleryOperationRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GalleryOperationRequestCopyWith<_GalleryOperationRequest> get copyWith =>
      __$GalleryOperationRequestCopyWithImpl<_GalleryOperationRequest>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$GalleryOperationRequestToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GalleryOperationRequest &&
            (identical(other.operationId, operationId) ||
                other.operationId == operationId) &&
            (identical(other.action, action) || other.action == action) &&
            const DeepCollectionEquality().equals(other.items, _items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      operationId,
      action,
      const DeepCollectionEquality().hash(_items),
    );
  }

  @override
  String toString() {
    return 'GalleryOperationRequest(operationId: $operationId, action: $action, items: $items)';
  }
}

/// @nodoc
abstract mixin class _$GalleryOperationRequestCopyWith<$Res>
    implements $GalleryOperationRequestCopyWith<$Res> {
  factory _$GalleryOperationRequestCopyWith(
    _GalleryOperationRequest value,
    $Res Function(_GalleryOperationRequest) _then,
  ) = __$GalleryOperationRequestCopyWithImpl;
  @override
  @useResult
  $Res call({
    String operationId,
    GalleryMutation action,
    List<GalleryMediaRef> items,
  });
}

/// @nodoc
class __$GalleryOperationRequestCopyWithImpl<$Res>
    implements _$GalleryOperationRequestCopyWith<$Res> {
  __$GalleryOperationRequestCopyWithImpl(this._self, this._then);

  final _GalleryOperationRequest _self;
  final $Res Function(_GalleryOperationRequest) _then;

  /// Create a copy of GalleryOperationRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? operationId = null,
    Object? action = null,
    Object? items = null,
  }) {
    return _then(
      _GalleryOperationRequest(
        operationId: null == operationId
            ? _self.operationId
            : operationId // ignore: cast_nullable_to_non_nullable
                  as String,
        action: null == action
            ? _self.action
            : action // ignore: cast_nullable_to_non_nullable
                  as GalleryMutation,
        items: null == items
            ? _self._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<GalleryMediaRef>,
      ),
    );
  }
}

/// @nodoc
mixin _$GalleryOperationItemResult {
  String get mediaId;
  @JsonKey(required: true, disallowNullValue: true)
  GalleryMediaSection get section;
  GalleryItemOperationState get state;
  @JsonKey(unknownEnumValue: GalleryErrorCode.unknown)
  GalleryErrorCode? get error;
  GalleryMediaRef? get destination;
  String? get restoredPath;

  /// Create a copy of GalleryOperationItemResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryOperationItemResultCopyWith<GalleryOperationItemResult>
  get copyWith =>
      _$GalleryOperationItemResultCopyWithImpl<GalleryOperationItemResult>(
        this as GalleryOperationItemResult,
        _$identity,
      );

  /// Serializes this GalleryOperationItemResult to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as GalleryOperationItemResult;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryOperationItemResult &&
            (identical(other.mediaId, _this.mediaId) ||
                other.mediaId == _this.mediaId) &&
            (identical(other.section, _this.section) ||
                other.section == _this.section) &&
            (identical(other.state, _this.state) ||
                other.state == _this.state) &&
            (identical(other.error, _this.error) ||
                other.error == _this.error) &&
            (identical(other.destination, _this.destination) ||
                other.destination == _this.destination) &&
            (identical(other.restoredPath, _this.restoredPath) ||
                other.restoredPath == _this.restoredPath));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as GalleryOperationItemResult;
    return Object.hash(
      runtimeType,
      _this.mediaId,
      _this.section,
      _this.state,
      _this.error,
      _this.destination,
      _this.restoredPath,
    );
  }

  @override
  String toString() {
    final _this = this as GalleryOperationItemResult;
    return 'GalleryOperationItemResult(mediaId: ${_this.mediaId}, section: ${_this.section}, state: ${_this.state}, error: ${_this.error}, destination: ${_this.destination}, restoredPath: ${_this.restoredPath})';
  }
}

/// @nodoc
abstract mixin class $GalleryOperationItemResultCopyWith<$Res> {
  factory $GalleryOperationItemResultCopyWith(
    GalleryOperationItemResult value,
    $Res Function(GalleryOperationItemResult) _then,
  ) = _$GalleryOperationItemResultCopyWithImpl;
  @useResult
  $Res call({
    String mediaId,
    @JsonKey(required: true, disallowNullValue: true)
    GalleryMediaSection section,
    GalleryItemOperationState state,
    @JsonKey(unknownEnumValue: GalleryErrorCode.unknown)
    GalleryErrorCode? error,
    GalleryMediaRef? destination,
    String? restoredPath,
  });

  $GalleryMediaRefCopyWith<$Res>? get destination;
}

/// @nodoc
class _$GalleryOperationItemResultCopyWithImpl<$Res>
    implements $GalleryOperationItemResultCopyWith<$Res> {
  _$GalleryOperationItemResultCopyWithImpl(this._self, this._then);

  final GalleryOperationItemResult _self;
  final $Res Function(GalleryOperationItemResult) _then;

  /// Create a copy of GalleryOperationItemResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mediaId = null,
    Object? section = null,
    Object? state = null,
    Object? error = freezed,
    Object? destination = freezed,
    Object? restoredPath = freezed,
  }) {
    return _then(
      GalleryOperationItemResult(
        mediaId: null == mediaId
            ? _self.mediaId
            : mediaId // ignore: cast_nullable_to_non_nullable
                  as String,
        section: null == section
            ? _self.section
            : section // ignore: cast_nullable_to_non_nullable
                  as GalleryMediaSection,
        state: null == state
            ? _self.state
            : state // ignore: cast_nullable_to_non_nullable
                  as GalleryItemOperationState,
        error: freezed == error
            ? _self.error
            : error // ignore: cast_nullable_to_non_nullable
                  as GalleryErrorCode?,
        destination: freezed == destination
            ? _self.destination
            : destination // ignore: cast_nullable_to_non_nullable
                  as GalleryMediaRef?,
        restoredPath: freezed == restoredPath
            ? _self.restoredPath
            : restoredPath // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }

  /// Create a copy of GalleryOperationItemResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryMediaRefCopyWith<$Res>? get destination {
    if (_self.destination == null) {
      return null;
    }

    return $GalleryMediaRefCopyWith<$Res>(_self.destination!, (value) {
      return _then(_self.copyWith(destination: value));
    });
  }
}

/// Adds pattern-matching-related methods to [GalleryOperationItemResult].
extension GalleryOperationItemResultPatterns on GalleryOperationItemResult {
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
    TResult Function(_GalleryOperationItemResult value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryOperationItemResult() when $default != null:
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
    TResult Function(_GalleryOperationItemResult value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryOperationItemResult():
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
    TResult? Function(_GalleryOperationItemResult value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryOperationItemResult() when $default != null:
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
      String mediaId,
      @JsonKey(required: true, disallowNullValue: true)
      GalleryMediaSection section,
      GalleryItemOperationState state,
      @JsonKey(unknownEnumValue: GalleryErrorCode.unknown)
      GalleryErrorCode? error,
      GalleryMediaRef? destination,
      String? restoredPath,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryOperationItemResult() when $default != null:
        return $default(
          _that.mediaId,
          _that.section,
          _that.state,
          _that.error,
          _that.destination,
          _that.restoredPath,
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
      String mediaId,
      @JsonKey(required: true, disallowNullValue: true)
      GalleryMediaSection section,
      GalleryItemOperationState state,
      @JsonKey(unknownEnumValue: GalleryErrorCode.unknown)
      GalleryErrorCode? error,
      GalleryMediaRef? destination,
      String? restoredPath,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryOperationItemResult():
        return $default(
          _that.mediaId,
          _that.section,
          _that.state,
          _that.error,
          _that.destination,
          _that.restoredPath,
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
      String mediaId,
      @JsonKey(required: true, disallowNullValue: true)
      GalleryMediaSection section,
      GalleryItemOperationState state,
      @JsonKey(unknownEnumValue: GalleryErrorCode.unknown)
      GalleryErrorCode? error,
      GalleryMediaRef? destination,
      String? restoredPath,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryOperationItemResult() when $default != null:
        return $default(
          _that.mediaId,
          _that.section,
          _that.state,
          _that.error,
          _that.destination,
          _that.restoredPath,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _GalleryOperationItemResult implements GalleryOperationItemResult {
  const _GalleryOperationItemResult({
    required this.mediaId,
    @JsonKey(required: true, disallowNullValue: true) required this.section,
    required this.state,
    @JsonKey(unknownEnumValue: GalleryErrorCode.unknown) this.error,
    this.destination,
    this.restoredPath,
  });
  factory _GalleryOperationItemResult.fromJson(Map<String, dynamic> json) =>
      _$GalleryOperationItemResultFromJson(json);

  @override
  final String mediaId;
  @override
  @JsonKey(required: true, disallowNullValue: true)
  final GalleryMediaSection section;
  @override
  final GalleryItemOperationState state;
  @override
  @JsonKey(unknownEnumValue: GalleryErrorCode.unknown)
  final GalleryErrorCode? error;
  @override
  final GalleryMediaRef? destination;
  @override
  final String? restoredPath;

  /// Create a copy of GalleryOperationItemResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GalleryOperationItemResultCopyWith<_GalleryOperationItemResult>
  get copyWith =>
      __$GalleryOperationItemResultCopyWithImpl<_GalleryOperationItemResult>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$GalleryOperationItemResultToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GalleryOperationItemResult &&
            (identical(other.mediaId, mediaId) || other.mediaId == mediaId) &&
            (identical(other.section, section) || other.section == section) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.destination, destination) ||
                other.destination == destination) &&
            (identical(other.restoredPath, restoredPath) ||
                other.restoredPath == restoredPath));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      mediaId,
      section,
      state,
      error,
      destination,
      restoredPath,
    );
  }

  @override
  String toString() {
    return 'GalleryOperationItemResult(mediaId: $mediaId, section: $section, state: $state, error: $error, destination: $destination, restoredPath: $restoredPath)';
  }
}

/// @nodoc
abstract mixin class _$GalleryOperationItemResultCopyWith<$Res>
    implements $GalleryOperationItemResultCopyWith<$Res> {
  factory _$GalleryOperationItemResultCopyWith(
    _GalleryOperationItemResult value,
    $Res Function(_GalleryOperationItemResult) _then,
  ) = __$GalleryOperationItemResultCopyWithImpl;
  @override
  @useResult
  $Res call({
    String mediaId,
    @JsonKey(required: true, disallowNullValue: true)
    GalleryMediaSection section,
    GalleryItemOperationState state,
    @JsonKey(unknownEnumValue: GalleryErrorCode.unknown)
    GalleryErrorCode? error,
    GalleryMediaRef? destination,
    String? restoredPath,
  });

  @override
  $GalleryMediaRefCopyWith<$Res>? get destination;
}

/// @nodoc
class __$GalleryOperationItemResultCopyWithImpl<$Res>
    implements _$GalleryOperationItemResultCopyWith<$Res> {
  __$GalleryOperationItemResultCopyWithImpl(this._self, this._then);

  final _GalleryOperationItemResult _self;
  final $Res Function(_GalleryOperationItemResult) _then;

  /// Create a copy of GalleryOperationItemResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? mediaId = null,
    Object? section = null,
    Object? state = null,
    Object? error = freezed,
    Object? destination = freezed,
    Object? restoredPath = freezed,
  }) {
    return _then(
      _GalleryOperationItemResult(
        mediaId: null == mediaId
            ? _self.mediaId
            : mediaId // ignore: cast_nullable_to_non_nullable
                  as String,
        section: null == section
            ? _self.section
            : section // ignore: cast_nullable_to_non_nullable
                  as GalleryMediaSection,
        state: null == state
            ? _self.state
            : state // ignore: cast_nullable_to_non_nullable
                  as GalleryItemOperationState,
        error: freezed == error
            ? _self.error
            : error // ignore: cast_nullable_to_non_nullable
                  as GalleryErrorCode?,
        destination: freezed == destination
            ? _self.destination
            : destination // ignore: cast_nullable_to_non_nullable
                  as GalleryMediaRef?,
        restoredPath: freezed == restoredPath
            ? _self.restoredPath
            : restoredPath // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }

  /// Create a copy of GalleryOperationItemResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryMediaRefCopyWith<$Res>? get destination {
    if (_self.destination == null) {
      return null;
    }

    return $GalleryMediaRefCopyWith<$Res>(_self.destination!, (value) {
      return _then(_self.copyWith(destination: value));
    });
  }
}

/// @nodoc
mixin _$GalleryOperationResult {
  String get operationId;
  List<GalleryOperationItemResult> get items;

  /// Create a copy of GalleryOperationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryOperationResultCopyWith<GalleryOperationResult> get copyWith =>
      _$GalleryOperationResultCopyWithImpl<GalleryOperationResult>(
        this as GalleryOperationResult,
        _$identity,
      );

  /// Serializes this GalleryOperationResult to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as GalleryOperationResult;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryOperationResult &&
            (identical(other.operationId, _this.operationId) ||
                other.operationId == _this.operationId) &&
            const DeepCollectionEquality().equals(other.items, _this.items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as GalleryOperationResult;
    return Object.hash(
      runtimeType,
      _this.operationId,
      const DeepCollectionEquality().hash(_this.items),
    );
  }

  @override
  String toString() {
    final _this = this as GalleryOperationResult;
    return 'GalleryOperationResult(operationId: ${_this.operationId}, items: ${_this.items})';
  }
}

/// @nodoc
abstract mixin class $GalleryOperationResultCopyWith<$Res> {
  factory $GalleryOperationResultCopyWith(
    GalleryOperationResult value,
    $Res Function(GalleryOperationResult) _then,
  ) = _$GalleryOperationResultCopyWithImpl;
  @useResult
  $Res call({String operationId, List<GalleryOperationItemResult> items});
}

/// @nodoc
class _$GalleryOperationResultCopyWithImpl<$Res>
    implements $GalleryOperationResultCopyWith<$Res> {
  _$GalleryOperationResultCopyWithImpl(this._self, this._then);

  final GalleryOperationResult _self;
  final $Res Function(GalleryOperationResult) _then;

  /// Create a copy of GalleryOperationResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? operationId = null, Object? items = null}) {
    return _then(
      GalleryOperationResult(
        operationId: null == operationId
            ? _self.operationId
            : operationId // ignore: cast_nullable_to_non_nullable
                  as String,
        items: null == items
            ? _self.items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<GalleryOperationItemResult>,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [GalleryOperationResult].
extension GalleryOperationResultPatterns on GalleryOperationResult {
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
    TResult Function(_GalleryOperationResult value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryOperationResult() when $default != null:
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
    TResult Function(_GalleryOperationResult value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryOperationResult():
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
    TResult? Function(_GalleryOperationResult value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryOperationResult() when $default != null:
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
      String operationId,
      List<GalleryOperationItemResult> items,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryOperationResult() when $default != null:
        return $default(_that.operationId, _that.items);
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
    TResult Function(String operationId, List<GalleryOperationItemResult> items)
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryOperationResult():
        return $default(_that.operationId, _that.items);
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
      String operationId,
      List<GalleryOperationItemResult> items,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryOperationResult() when $default != null:
        return $default(_that.operationId, _that.items);
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _GalleryOperationResult implements GalleryOperationResult {
  const _GalleryOperationResult({
    required this.operationId,
    required List<GalleryOperationItemResult> items,
  }) : _items = items;
  factory _GalleryOperationResult.fromJson(Map<String, dynamic> json) =>
      _$GalleryOperationResultFromJson(json);

  @override
  final String operationId;
  final List<GalleryOperationItemResult> _items;
  @override
  List<GalleryOperationItemResult> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  /// Create a copy of GalleryOperationResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GalleryOperationResultCopyWith<_GalleryOperationResult> get copyWith =>
      __$GalleryOperationResultCopyWithImpl<_GalleryOperationResult>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$GalleryOperationResultToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GalleryOperationResult &&
            (identical(other.operationId, operationId) ||
                other.operationId == operationId) &&
            const DeepCollectionEquality().equals(other.items, _items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      operationId,
      const DeepCollectionEquality().hash(_items),
    );
  }

  @override
  String toString() {
    return 'GalleryOperationResult(operationId: $operationId, items: $items)';
  }
}

/// @nodoc
abstract mixin class _$GalleryOperationResultCopyWith<$Res>
    implements $GalleryOperationResultCopyWith<$Res> {
  factory _$GalleryOperationResultCopyWith(
    _GalleryOperationResult value,
    $Res Function(_GalleryOperationResult) _then,
  ) = __$GalleryOperationResultCopyWithImpl;
  @override
  @useResult
  $Res call({String operationId, List<GalleryOperationItemResult> items});
}

/// @nodoc
class __$GalleryOperationResultCopyWithImpl<$Res>
    implements _$GalleryOperationResultCopyWith<$Res> {
  __$GalleryOperationResultCopyWithImpl(this._self, this._then);

  final _GalleryOperationResult _self;
  final $Res Function(_GalleryOperationResult) _then;

  /// Create a copy of GalleryOperationResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? operationId = null, Object? items = null}) {
    return _then(
      _GalleryOperationResult(
        operationId: null == operationId
            ? _self.operationId
            : operationId // ignore: cast_nullable_to_non_nullable
                  as String,
        items: null == items
            ? _self._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<GalleryOperationItemResult>,
      ),
    );
  }
}

/// @nodoc
mixin _$GalleryRotateRequest {
  String get operationId;
  String get mediaId;
  String get sourceRevision;
  GalleryRotation get rotation;
  @JsonKey(required: true, disallowNullValue: true)
  GalleryMediaSection get section;

  /// Create a copy of GalleryRotateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryRotateRequestCopyWith<GalleryRotateRequest> get copyWith =>
      _$GalleryRotateRequestCopyWithImpl<GalleryRotateRequest>(
        this as GalleryRotateRequest,
        _$identity,
      );

  /// Serializes this GalleryRotateRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as GalleryRotateRequest;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryRotateRequest &&
            (identical(other.operationId, _this.operationId) ||
                other.operationId == _this.operationId) &&
            (identical(other.mediaId, _this.mediaId) ||
                other.mediaId == _this.mediaId) &&
            (identical(other.sourceRevision, _this.sourceRevision) ||
                other.sourceRevision == _this.sourceRevision) &&
            (identical(other.rotation, _this.rotation) ||
                other.rotation == _this.rotation) &&
            (identical(other.section, _this.section) ||
                other.section == _this.section));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as GalleryRotateRequest;
    return Object.hash(
      runtimeType,
      _this.operationId,
      _this.mediaId,
      _this.sourceRevision,
      _this.rotation,
      _this.section,
    );
  }

  @override
  String toString() {
    final _this = this as GalleryRotateRequest;
    return 'GalleryRotateRequest(operationId: ${_this.operationId}, mediaId: ${_this.mediaId}, sourceRevision: ${_this.sourceRevision}, rotation: ${_this.rotation}, section: ${_this.section})';
  }
}

/// @nodoc
abstract mixin class $GalleryRotateRequestCopyWith<$Res> {
  factory $GalleryRotateRequestCopyWith(
    GalleryRotateRequest value,
    $Res Function(GalleryRotateRequest) _then,
  ) = _$GalleryRotateRequestCopyWithImpl;
  @useResult
  $Res call({
    String operationId,
    String mediaId,
    String sourceRevision,
    GalleryRotation rotation,
    @JsonKey(required: true, disallowNullValue: true)
    GalleryMediaSection section,
  });
}

/// @nodoc
class _$GalleryRotateRequestCopyWithImpl<$Res>
    implements $GalleryRotateRequestCopyWith<$Res> {
  _$GalleryRotateRequestCopyWithImpl(this._self, this._then);

  final GalleryRotateRequest _self;
  final $Res Function(GalleryRotateRequest) _then;

  /// Create a copy of GalleryRotateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? operationId = null,
    Object? mediaId = null,
    Object? sourceRevision = null,
    Object? rotation = null,
    Object? section = null,
  }) {
    return _then(
      GalleryRotateRequest(
        operationId: null == operationId
            ? _self.operationId
            : operationId // ignore: cast_nullable_to_non_nullable
                  as String,
        mediaId: null == mediaId
            ? _self.mediaId
            : mediaId // ignore: cast_nullable_to_non_nullable
                  as String,
        sourceRevision: null == sourceRevision
            ? _self.sourceRevision
            : sourceRevision // ignore: cast_nullable_to_non_nullable
                  as String,
        rotation: null == rotation
            ? _self.rotation
            : rotation // ignore: cast_nullable_to_non_nullable
                  as GalleryRotation,
        section: null == section
            ? _self.section
            : section // ignore: cast_nullable_to_non_nullable
                  as GalleryMediaSection,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [GalleryRotateRequest].
extension GalleryRotateRequestPatterns on GalleryRotateRequest {
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
    TResult Function(_GalleryRotateRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryRotateRequest() when $default != null:
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
    TResult Function(_GalleryRotateRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryRotateRequest():
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
    TResult? Function(_GalleryRotateRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryRotateRequest() when $default != null:
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
      String operationId,
      String mediaId,
      String sourceRevision,
      GalleryRotation rotation,
      @JsonKey(required: true, disallowNullValue: true)
      GalleryMediaSection section,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryRotateRequest() when $default != null:
        return $default(
          _that.operationId,
          _that.mediaId,
          _that.sourceRevision,
          _that.rotation,
          _that.section,
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
      String operationId,
      String mediaId,
      String sourceRevision,
      GalleryRotation rotation,
      @JsonKey(required: true, disallowNullValue: true)
      GalleryMediaSection section,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryRotateRequest():
        return $default(
          _that.operationId,
          _that.mediaId,
          _that.sourceRevision,
          _that.rotation,
          _that.section,
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
      String operationId,
      String mediaId,
      String sourceRevision,
      GalleryRotation rotation,
      @JsonKey(required: true, disallowNullValue: true)
      GalleryMediaSection section,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryRotateRequest() when $default != null:
        return $default(
          _that.operationId,
          _that.mediaId,
          _that.sourceRevision,
          _that.rotation,
          _that.section,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _GalleryRotateRequest implements GalleryRotateRequest {
  const _GalleryRotateRequest({
    required this.operationId,
    required this.mediaId,
    required this.sourceRevision,
    required this.rotation,
    @JsonKey(required: true, disallowNullValue: true) required this.section,
  });
  factory _GalleryRotateRequest.fromJson(Map<String, dynamic> json) =>
      _$GalleryRotateRequestFromJson(json);

  @override
  final String operationId;
  @override
  final String mediaId;
  @override
  final String sourceRevision;
  @override
  final GalleryRotation rotation;
  @override
  @JsonKey(required: true, disallowNullValue: true)
  final GalleryMediaSection section;

  /// Create a copy of GalleryRotateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GalleryRotateRequestCopyWith<_GalleryRotateRequest> get copyWith =>
      __$GalleryRotateRequestCopyWithImpl<_GalleryRotateRequest>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$GalleryRotateRequestToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GalleryRotateRequest &&
            (identical(other.operationId, operationId) ||
                other.operationId == operationId) &&
            (identical(other.mediaId, mediaId) || other.mediaId == mediaId) &&
            (identical(other.sourceRevision, sourceRevision) ||
                other.sourceRevision == sourceRevision) &&
            (identical(other.rotation, rotation) ||
                other.rotation == rotation) &&
            (identical(other.section, section) || other.section == section));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      operationId,
      mediaId,
      sourceRevision,
      rotation,
      section,
    );
  }

  @override
  String toString() {
    return 'GalleryRotateRequest(operationId: $operationId, mediaId: $mediaId, sourceRevision: $sourceRevision, rotation: $rotation, section: $section)';
  }
}

/// @nodoc
abstract mixin class _$GalleryRotateRequestCopyWith<$Res>
    implements $GalleryRotateRequestCopyWith<$Res> {
  factory _$GalleryRotateRequestCopyWith(
    _GalleryRotateRequest value,
    $Res Function(_GalleryRotateRequest) _then,
  ) = __$GalleryRotateRequestCopyWithImpl;
  @override
  @useResult
  $Res call({
    String operationId,
    String mediaId,
    String sourceRevision,
    GalleryRotation rotation,
    @JsonKey(required: true, disallowNullValue: true)
    GalleryMediaSection section,
  });
}

/// @nodoc
class __$GalleryRotateRequestCopyWithImpl<$Res>
    implements _$GalleryRotateRequestCopyWith<$Res> {
  __$GalleryRotateRequestCopyWithImpl(this._self, this._then);

  final _GalleryRotateRequest _self;
  final $Res Function(_GalleryRotateRequest) _then;

  /// Create a copy of GalleryRotateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? operationId = null,
    Object? mediaId = null,
    Object? sourceRevision = null,
    Object? rotation = null,
    Object? section = null,
  }) {
    return _then(
      _GalleryRotateRequest(
        operationId: null == operationId
            ? _self.operationId
            : operationId // ignore: cast_nullable_to_non_nullable
                  as String,
        mediaId: null == mediaId
            ? _self.mediaId
            : mediaId // ignore: cast_nullable_to_non_nullable
                  as String,
        sourceRevision: null == sourceRevision
            ? _self.sourceRevision
            : sourceRevision // ignore: cast_nullable_to_non_nullable
                  as String,
        rotation: null == rotation
            ? _self.rotation
            : rotation // ignore: cast_nullable_to_non_nullable
                  as GalleryRotation,
        section: null == section
            ? _self.section
            : section // ignore: cast_nullable_to_non_nullable
                  as GalleryMediaSection,
      ),
    );
  }
}

/// @nodoc
mixin _$GalleryMetadata {
  String get mediaId;
  String get sourceRevision;
  String get name;
  String get path;
  @JsonKey(unknownEnumValue: GalleryEntryKind.unknown)
  GalleryEntryKind get kind;
  int get sizeBytes;
  @JsonKey(required: true, disallowNullValue: true)
  GalleryMediaSection get section;
  int? get width;
  int? get height;
  String? get dateTaken;
  DateTime? get fileModified;
  String? get format;
  String? get camera;
  String? get lens;
  String? get iso;
  String? get exposure;
  String? get aperture;
  String? get focalLength;
  int? get orientation;
  double? get latitude;
  double? get longitude;
  double? get durationSeconds;
  String? get codec;
  String? get colorProfile;
  int? get bitDepth;
  bool? get hasAlpha;

  /// Create a copy of GalleryMetadata
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryMetadataCopyWith<GalleryMetadata> get copyWith =>
      _$GalleryMetadataCopyWithImpl<GalleryMetadata>(
        this as GalleryMetadata,
        _$identity,
      );

  /// Serializes this GalleryMetadata to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as GalleryMetadata;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryMetadata &&
            (identical(other.mediaId, _this.mediaId) ||
                other.mediaId == _this.mediaId) &&
            (identical(other.sourceRevision, _this.sourceRevision) ||
                other.sourceRevision == _this.sourceRevision) &&
            (identical(other.name, _this.name) || other.name == _this.name) &&
            (identical(other.path, _this.path) || other.path == _this.path) &&
            (identical(other.kind, _this.kind) || other.kind == _this.kind) &&
            (identical(other.sizeBytes, _this.sizeBytes) ||
                other.sizeBytes == _this.sizeBytes) &&
            (identical(other.section, _this.section) ||
                other.section == _this.section) &&
            (identical(other.width, _this.width) ||
                other.width == _this.width) &&
            (identical(other.height, _this.height) ||
                other.height == _this.height) &&
            (identical(other.dateTaken, _this.dateTaken) ||
                other.dateTaken == _this.dateTaken) &&
            (identical(other.fileModified, _this.fileModified) ||
                other.fileModified == _this.fileModified) &&
            (identical(other.format, _this.format) ||
                other.format == _this.format) &&
            (identical(other.camera, _this.camera) ||
                other.camera == _this.camera) &&
            (identical(other.lens, _this.lens) || other.lens == _this.lens) &&
            (identical(other.iso, _this.iso) || other.iso == _this.iso) &&
            (identical(other.exposure, _this.exposure) ||
                other.exposure == _this.exposure) &&
            (identical(other.aperture, _this.aperture) ||
                other.aperture == _this.aperture) &&
            (identical(other.focalLength, _this.focalLength) ||
                other.focalLength == _this.focalLength) &&
            (identical(other.orientation, _this.orientation) ||
                other.orientation == _this.orientation) &&
            (identical(other.latitude, _this.latitude) ||
                other.latitude == _this.latitude) &&
            (identical(other.longitude, _this.longitude) ||
                other.longitude == _this.longitude) &&
            (identical(other.durationSeconds, _this.durationSeconds) ||
                other.durationSeconds == _this.durationSeconds) &&
            (identical(other.codec, _this.codec) ||
                other.codec == _this.codec) &&
            (identical(other.colorProfile, _this.colorProfile) ||
                other.colorProfile == _this.colorProfile) &&
            (identical(other.bitDepth, _this.bitDepth) ||
                other.bitDepth == _this.bitDepth) &&
            (identical(other.hasAlpha, _this.hasAlpha) ||
                other.hasAlpha == _this.hasAlpha));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as GalleryMetadata;
    return Object.hashAll([
      runtimeType,
      _this.mediaId,
      _this.sourceRevision,
      _this.name,
      _this.path,
      _this.kind,
      _this.sizeBytes,
      _this.section,
      _this.width,
      _this.height,
      _this.dateTaken,
      _this.fileModified,
      _this.format,
      _this.camera,
      _this.lens,
      _this.iso,
      _this.exposure,
      _this.aperture,
      _this.focalLength,
      _this.orientation,
      _this.latitude,
      _this.longitude,
      _this.durationSeconds,
      _this.codec,
      _this.colorProfile,
      _this.bitDepth,
      _this.hasAlpha,
    ]);
  }

  @override
  String toString() {
    final _this = this as GalleryMetadata;
    return 'GalleryMetadata(mediaId: ${_this.mediaId}, sourceRevision: ${_this.sourceRevision}, name: ${_this.name}, path: ${_this.path}, kind: ${_this.kind}, sizeBytes: ${_this.sizeBytes}, section: ${_this.section}, width: ${_this.width}, height: ${_this.height}, dateTaken: ${_this.dateTaken}, fileModified: ${_this.fileModified}, format: ${_this.format}, camera: ${_this.camera}, lens: ${_this.lens}, iso: ${_this.iso}, exposure: ${_this.exposure}, aperture: ${_this.aperture}, focalLength: ${_this.focalLength}, orientation: ${_this.orientation}, latitude: ${_this.latitude}, longitude: ${_this.longitude}, durationSeconds: ${_this.durationSeconds}, codec: ${_this.codec}, colorProfile: ${_this.colorProfile}, bitDepth: ${_this.bitDepth}, hasAlpha: ${_this.hasAlpha})';
  }
}

/// @nodoc
abstract mixin class $GalleryMetadataCopyWith<$Res> {
  factory $GalleryMetadataCopyWith(
    GalleryMetadata value,
    $Res Function(GalleryMetadata) _then,
  ) = _$GalleryMetadataCopyWithImpl;
  @useResult
  $Res call({
    String mediaId,
    String sourceRevision,
    String name,
    String path,
    @JsonKey(unknownEnumValue: GalleryEntryKind.unknown) GalleryEntryKind kind,
    int sizeBytes,
    @JsonKey(required: true, disallowNullValue: true)
    GalleryMediaSection section,
    int? width,
    int? height,
    String? dateTaken,
    DateTime? fileModified,
    String? format,
    String? camera,
    String? lens,
    String? iso,
    String? exposure,
    String? aperture,
    String? focalLength,
    int? orientation,
    double? latitude,
    double? longitude,
    double? durationSeconds,
    String? codec,
    String? colorProfile,
    int? bitDepth,
    bool? hasAlpha,
  });
}

/// @nodoc
class _$GalleryMetadataCopyWithImpl<$Res>
    implements $GalleryMetadataCopyWith<$Res> {
  _$GalleryMetadataCopyWithImpl(this._self, this._then);

  final GalleryMetadata _self;
  final $Res Function(GalleryMetadata) _then;

  /// Create a copy of GalleryMetadata
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mediaId = null,
    Object? sourceRevision = null,
    Object? name = null,
    Object? path = null,
    Object? kind = null,
    Object? sizeBytes = null,
    Object? section = null,
    Object? width = freezed,
    Object? height = freezed,
    Object? dateTaken = freezed,
    Object? fileModified = freezed,
    Object? format = freezed,
    Object? camera = freezed,
    Object? lens = freezed,
    Object? iso = freezed,
    Object? exposure = freezed,
    Object? aperture = freezed,
    Object? focalLength = freezed,
    Object? orientation = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? durationSeconds = freezed,
    Object? codec = freezed,
    Object? colorProfile = freezed,
    Object? bitDepth = freezed,
    Object? hasAlpha = freezed,
  }) {
    return _then(
      GalleryMetadata(
        mediaId: null == mediaId
            ? _self.mediaId
            : mediaId // ignore: cast_nullable_to_non_nullable
                  as String,
        sourceRevision: null == sourceRevision
            ? _self.sourceRevision
            : sourceRevision // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _self.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        path: null == path
            ? _self.path
            : path // ignore: cast_nullable_to_non_nullable
                  as String,
        kind: null == kind
            ? _self.kind
            : kind // ignore: cast_nullable_to_non_nullable
                  as GalleryEntryKind,
        sizeBytes: null == sizeBytes
            ? _self.sizeBytes
            : sizeBytes // ignore: cast_nullable_to_non_nullable
                  as int,
        section: null == section
            ? _self.section
            : section // ignore: cast_nullable_to_non_nullable
                  as GalleryMediaSection,
        width: freezed == width
            ? _self.width
            : width // ignore: cast_nullable_to_non_nullable
                  as int?,
        height: freezed == height
            ? _self.height
            : height // ignore: cast_nullable_to_non_nullable
                  as int?,
        dateTaken: freezed == dateTaken
            ? _self.dateTaken
            : dateTaken // ignore: cast_nullable_to_non_nullable
                  as String?,
        fileModified: freezed == fileModified
            ? _self.fileModified
            : fileModified // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        format: freezed == format
            ? _self.format
            : format // ignore: cast_nullable_to_non_nullable
                  as String?,
        camera: freezed == camera
            ? _self.camera
            : camera // ignore: cast_nullable_to_non_nullable
                  as String?,
        lens: freezed == lens
            ? _self.lens
            : lens // ignore: cast_nullable_to_non_nullable
                  as String?,
        iso: freezed == iso
            ? _self.iso
            : iso // ignore: cast_nullable_to_non_nullable
                  as String?,
        exposure: freezed == exposure
            ? _self.exposure
            : exposure // ignore: cast_nullable_to_non_nullable
                  as String?,
        aperture: freezed == aperture
            ? _self.aperture
            : aperture // ignore: cast_nullable_to_non_nullable
                  as String?,
        focalLength: freezed == focalLength
            ? _self.focalLength
            : focalLength // ignore: cast_nullable_to_non_nullable
                  as String?,
        orientation: freezed == orientation
            ? _self.orientation
            : orientation // ignore: cast_nullable_to_non_nullable
                  as int?,
        latitude: freezed == latitude
            ? _self.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        longitude: freezed == longitude
            ? _self.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        durationSeconds: freezed == durationSeconds
            ? _self.durationSeconds
            : durationSeconds // ignore: cast_nullable_to_non_nullable
                  as double?,
        codec: freezed == codec
            ? _self.codec
            : codec // ignore: cast_nullable_to_non_nullable
                  as String?,
        colorProfile: freezed == colorProfile
            ? _self.colorProfile
            : colorProfile // ignore: cast_nullable_to_non_nullable
                  as String?,
        bitDepth: freezed == bitDepth
            ? _self.bitDepth
            : bitDepth // ignore: cast_nullable_to_non_nullable
                  as int?,
        hasAlpha: freezed == hasAlpha
            ? _self.hasAlpha
            : hasAlpha // ignore: cast_nullable_to_non_nullable
                  as bool?,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [GalleryMetadata].
extension GalleryMetadataPatterns on GalleryMetadata {
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
    TResult Function(_GalleryMetadata value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryMetadata() when $default != null:
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
    TResult Function(_GalleryMetadata value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryMetadata():
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
    TResult? Function(_GalleryMetadata value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryMetadata() when $default != null:
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
      String mediaId,
      String sourceRevision,
      String name,
      String path,
      @JsonKey(unknownEnumValue: GalleryEntryKind.unknown)
      GalleryEntryKind kind,
      int sizeBytes,
      @JsonKey(required: true, disallowNullValue: true)
      GalleryMediaSection section,
      int? width,
      int? height,
      String? dateTaken,
      DateTime? fileModified,
      String? format,
      String? camera,
      String? lens,
      String? iso,
      String? exposure,
      String? aperture,
      String? focalLength,
      int? orientation,
      double? latitude,
      double? longitude,
      double? durationSeconds,
      String? codec,
      String? colorProfile,
      int? bitDepth,
      bool? hasAlpha,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryMetadata() when $default != null:
        return $default(
          _that.mediaId,
          _that.sourceRevision,
          _that.name,
          _that.path,
          _that.kind,
          _that.sizeBytes,
          _that.section,
          _that.width,
          _that.height,
          _that.dateTaken,
          _that.fileModified,
          _that.format,
          _that.camera,
          _that.lens,
          _that.iso,
          _that.exposure,
          _that.aperture,
          _that.focalLength,
          _that.orientation,
          _that.latitude,
          _that.longitude,
          _that.durationSeconds,
          _that.codec,
          _that.colorProfile,
          _that.bitDepth,
          _that.hasAlpha,
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
      String mediaId,
      String sourceRevision,
      String name,
      String path,
      @JsonKey(unknownEnumValue: GalleryEntryKind.unknown)
      GalleryEntryKind kind,
      int sizeBytes,
      @JsonKey(required: true, disallowNullValue: true)
      GalleryMediaSection section,
      int? width,
      int? height,
      String? dateTaken,
      DateTime? fileModified,
      String? format,
      String? camera,
      String? lens,
      String? iso,
      String? exposure,
      String? aperture,
      String? focalLength,
      int? orientation,
      double? latitude,
      double? longitude,
      double? durationSeconds,
      String? codec,
      String? colorProfile,
      int? bitDepth,
      bool? hasAlpha,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryMetadata():
        return $default(
          _that.mediaId,
          _that.sourceRevision,
          _that.name,
          _that.path,
          _that.kind,
          _that.sizeBytes,
          _that.section,
          _that.width,
          _that.height,
          _that.dateTaken,
          _that.fileModified,
          _that.format,
          _that.camera,
          _that.lens,
          _that.iso,
          _that.exposure,
          _that.aperture,
          _that.focalLength,
          _that.orientation,
          _that.latitude,
          _that.longitude,
          _that.durationSeconds,
          _that.codec,
          _that.colorProfile,
          _that.bitDepth,
          _that.hasAlpha,
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
      String mediaId,
      String sourceRevision,
      String name,
      String path,
      @JsonKey(unknownEnumValue: GalleryEntryKind.unknown)
      GalleryEntryKind kind,
      int sizeBytes,
      @JsonKey(required: true, disallowNullValue: true)
      GalleryMediaSection section,
      int? width,
      int? height,
      String? dateTaken,
      DateTime? fileModified,
      String? format,
      String? camera,
      String? lens,
      String? iso,
      String? exposure,
      String? aperture,
      String? focalLength,
      int? orientation,
      double? latitude,
      double? longitude,
      double? durationSeconds,
      String? codec,
      String? colorProfile,
      int? bitDepth,
      bool? hasAlpha,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryMetadata() when $default != null:
        return $default(
          _that.mediaId,
          _that.sourceRevision,
          _that.name,
          _that.path,
          _that.kind,
          _that.sizeBytes,
          _that.section,
          _that.width,
          _that.height,
          _that.dateTaken,
          _that.fileModified,
          _that.format,
          _that.camera,
          _that.lens,
          _that.iso,
          _that.exposure,
          _that.aperture,
          _that.focalLength,
          _that.orientation,
          _that.latitude,
          _that.longitude,
          _that.durationSeconds,
          _that.codec,
          _that.colorProfile,
          _that.bitDepth,
          _that.hasAlpha,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _GalleryMetadata implements GalleryMetadata {
  const _GalleryMetadata({
    required this.mediaId,
    required this.sourceRevision,
    required this.name,
    required this.path,
    @JsonKey(unknownEnumValue: GalleryEntryKind.unknown) required this.kind,
    required this.sizeBytes,
    @JsonKey(required: true, disallowNullValue: true) required this.section,
    this.width,
    this.height,
    this.dateTaken,
    this.fileModified,
    this.format,
    this.camera,
    this.lens,
    this.iso,
    this.exposure,
    this.aperture,
    this.focalLength,
    this.orientation,
    this.latitude,
    this.longitude,
    this.durationSeconds,
    this.codec,
    this.colorProfile,
    this.bitDepth,
    this.hasAlpha,
  });
  factory _GalleryMetadata.fromJson(Map<String, dynamic> json) =>
      _$GalleryMetadataFromJson(json);

  @override
  final String mediaId;
  @override
  final String sourceRevision;
  @override
  final String name;
  @override
  final String path;
  @override
  @JsonKey(unknownEnumValue: GalleryEntryKind.unknown)
  final GalleryEntryKind kind;
  @override
  final int sizeBytes;
  @override
  @JsonKey(required: true, disallowNullValue: true)
  final GalleryMediaSection section;
  @override
  final int? width;
  @override
  final int? height;
  @override
  final String? dateTaken;
  @override
  final DateTime? fileModified;
  @override
  final String? format;
  @override
  final String? camera;
  @override
  final String? lens;
  @override
  final String? iso;
  @override
  final String? exposure;
  @override
  final String? aperture;
  @override
  final String? focalLength;
  @override
  final int? orientation;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  final double? durationSeconds;
  @override
  final String? codec;
  @override
  final String? colorProfile;
  @override
  final int? bitDepth;
  @override
  final bool? hasAlpha;

  /// Create a copy of GalleryMetadata
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GalleryMetadataCopyWith<_GalleryMetadata> get copyWith =>
      __$GalleryMetadataCopyWithImpl<_GalleryMetadata>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$GalleryMetadataToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GalleryMetadata &&
            (identical(other.mediaId, mediaId) || other.mediaId == mediaId) &&
            (identical(other.sourceRevision, sourceRevision) ||
                other.sourceRevision == sourceRevision) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.kind, kind) || other.kind == kind) &&
            (identical(other.sizeBytes, sizeBytes) ||
                other.sizeBytes == sizeBytes) &&
            (identical(other.section, section) || other.section == section) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.dateTaken, dateTaken) ||
                other.dateTaken == dateTaken) &&
            (identical(other.fileModified, fileModified) ||
                other.fileModified == fileModified) &&
            (identical(other.format, format) || other.format == format) &&
            (identical(other.camera, camera) || other.camera == camera) &&
            (identical(other.lens, lens) || other.lens == lens) &&
            (identical(other.iso, iso) || other.iso == iso) &&
            (identical(other.exposure, exposure) ||
                other.exposure == exposure) &&
            (identical(other.aperture, aperture) ||
                other.aperture == aperture) &&
            (identical(other.focalLength, focalLength) ||
                other.focalLength == focalLength) &&
            (identical(other.orientation, orientation) ||
                other.orientation == orientation) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds) &&
            (identical(other.codec, codec) || other.codec == codec) &&
            (identical(other.colorProfile, colorProfile) ||
                other.colorProfile == colorProfile) &&
            (identical(other.bitDepth, bitDepth) ||
                other.bitDepth == bitDepth) &&
            (identical(other.hasAlpha, hasAlpha) ||
                other.hasAlpha == hasAlpha));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      mediaId,
      sourceRevision,
      name,
      path,
      kind,
      sizeBytes,
      section,
      width,
      height,
      dateTaken,
      fileModified,
      format,
      camera,
      lens,
      iso,
      exposure,
      aperture,
      focalLength,
      orientation,
      latitude,
      longitude,
      durationSeconds,
      codec,
      colorProfile,
      bitDepth,
      hasAlpha,
    ]);
  }

  @override
  String toString() {
    return 'GalleryMetadata(mediaId: $mediaId, sourceRevision: $sourceRevision, name: $name, path: $path, kind: $kind, sizeBytes: $sizeBytes, section: $section, width: $width, height: $height, dateTaken: $dateTaken, fileModified: $fileModified, format: $format, camera: $camera, lens: $lens, iso: $iso, exposure: $exposure, aperture: $aperture, focalLength: $focalLength, orientation: $orientation, latitude: $latitude, longitude: $longitude, durationSeconds: $durationSeconds, codec: $codec, colorProfile: $colorProfile, bitDepth: $bitDepth, hasAlpha: $hasAlpha)';
  }
}

/// @nodoc
abstract mixin class _$GalleryMetadataCopyWith<$Res>
    implements $GalleryMetadataCopyWith<$Res> {
  factory _$GalleryMetadataCopyWith(
    _GalleryMetadata value,
    $Res Function(_GalleryMetadata) _then,
  ) = __$GalleryMetadataCopyWithImpl;
  @override
  @useResult
  $Res call({
    String mediaId,
    String sourceRevision,
    String name,
    String path,
    @JsonKey(unknownEnumValue: GalleryEntryKind.unknown) GalleryEntryKind kind,
    int sizeBytes,
    @JsonKey(required: true, disallowNullValue: true)
    GalleryMediaSection section,
    int? width,
    int? height,
    String? dateTaken,
    DateTime? fileModified,
    String? format,
    String? camera,
    String? lens,
    String? iso,
    String? exposure,
    String? aperture,
    String? focalLength,
    int? orientation,
    double? latitude,
    double? longitude,
    double? durationSeconds,
    String? codec,
    String? colorProfile,
    int? bitDepth,
    bool? hasAlpha,
  });
}

/// @nodoc
class __$GalleryMetadataCopyWithImpl<$Res>
    implements _$GalleryMetadataCopyWith<$Res> {
  __$GalleryMetadataCopyWithImpl(this._self, this._then);

  final _GalleryMetadata _self;
  final $Res Function(_GalleryMetadata) _then;

  /// Create a copy of GalleryMetadata
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? mediaId = null,
    Object? sourceRevision = null,
    Object? name = null,
    Object? path = null,
    Object? kind = null,
    Object? sizeBytes = null,
    Object? section = null,
    Object? width = freezed,
    Object? height = freezed,
    Object? dateTaken = freezed,
    Object? fileModified = freezed,
    Object? format = freezed,
    Object? camera = freezed,
    Object? lens = freezed,
    Object? iso = freezed,
    Object? exposure = freezed,
    Object? aperture = freezed,
    Object? focalLength = freezed,
    Object? orientation = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? durationSeconds = freezed,
    Object? codec = freezed,
    Object? colorProfile = freezed,
    Object? bitDepth = freezed,
    Object? hasAlpha = freezed,
  }) {
    return _then(
      _GalleryMetadata(
        mediaId: null == mediaId
            ? _self.mediaId
            : mediaId // ignore: cast_nullable_to_non_nullable
                  as String,
        sourceRevision: null == sourceRevision
            ? _self.sourceRevision
            : sourceRevision // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _self.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        path: null == path
            ? _self.path
            : path // ignore: cast_nullable_to_non_nullable
                  as String,
        kind: null == kind
            ? _self.kind
            : kind // ignore: cast_nullable_to_non_nullable
                  as GalleryEntryKind,
        sizeBytes: null == sizeBytes
            ? _self.sizeBytes
            : sizeBytes // ignore: cast_nullable_to_non_nullable
                  as int,
        section: null == section
            ? _self.section
            : section // ignore: cast_nullable_to_non_nullable
                  as GalleryMediaSection,
        width: freezed == width
            ? _self.width
            : width // ignore: cast_nullable_to_non_nullable
                  as int?,
        height: freezed == height
            ? _self.height
            : height // ignore: cast_nullable_to_non_nullable
                  as int?,
        dateTaken: freezed == dateTaken
            ? _self.dateTaken
            : dateTaken // ignore: cast_nullable_to_non_nullable
                  as String?,
        fileModified: freezed == fileModified
            ? _self.fileModified
            : fileModified // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        format: freezed == format
            ? _self.format
            : format // ignore: cast_nullable_to_non_nullable
                  as String?,
        camera: freezed == camera
            ? _self.camera
            : camera // ignore: cast_nullable_to_non_nullable
                  as String?,
        lens: freezed == lens
            ? _self.lens
            : lens // ignore: cast_nullable_to_non_nullable
                  as String?,
        iso: freezed == iso
            ? _self.iso
            : iso // ignore: cast_nullable_to_non_nullable
                  as String?,
        exposure: freezed == exposure
            ? _self.exposure
            : exposure // ignore: cast_nullable_to_non_nullable
                  as String?,
        aperture: freezed == aperture
            ? _self.aperture
            : aperture // ignore: cast_nullable_to_non_nullable
                  as String?,
        focalLength: freezed == focalLength
            ? _self.focalLength
            : focalLength // ignore: cast_nullable_to_non_nullable
                  as String?,
        orientation: freezed == orientation
            ? _self.orientation
            : orientation // ignore: cast_nullable_to_non_nullable
                  as int?,
        latitude: freezed == latitude
            ? _self.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        longitude: freezed == longitude
            ? _self.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        durationSeconds: freezed == durationSeconds
            ? _self.durationSeconds
            : durationSeconds // ignore: cast_nullable_to_non_nullable
                  as double?,
        codec: freezed == codec
            ? _self.codec
            : codec // ignore: cast_nullable_to_non_nullable
                  as String?,
        colorProfile: freezed == colorProfile
            ? _self.colorProfile
            : colorProfile // ignore: cast_nullable_to_non_nullable
                  as String?,
        bitDepth: freezed == bitDepth
            ? _self.bitDepth
            : bitDepth // ignore: cast_nullable_to_non_nullable
                  as int?,
        hasAlpha: freezed == hasAlpha
            ? _self.hasAlpha
            : hasAlpha // ignore: cast_nullable_to_non_nullable
                  as bool?,
      ),
    );
  }
}

/// @nodoc
mixin _$GalleryDuplicateStartRequest {
  String get operationId;
  List<GalleryDuplicateMode> get modes;

  /// Create a copy of GalleryDuplicateStartRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryDuplicateStartRequestCopyWith<GalleryDuplicateStartRequest>
  get copyWith =>
      _$GalleryDuplicateStartRequestCopyWithImpl<GalleryDuplicateStartRequest>(
        this as GalleryDuplicateStartRequest,
        _$identity,
      );

  /// Serializes this GalleryDuplicateStartRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as GalleryDuplicateStartRequest;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryDuplicateStartRequest &&
            (identical(other.operationId, _this.operationId) ||
                other.operationId == _this.operationId) &&
            const DeepCollectionEquality().equals(other.modes, _this.modes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as GalleryDuplicateStartRequest;
    return Object.hash(
      runtimeType,
      _this.operationId,
      const DeepCollectionEquality().hash(_this.modes),
    );
  }

  @override
  String toString() {
    final _this = this as GalleryDuplicateStartRequest;
    return 'GalleryDuplicateStartRequest(operationId: ${_this.operationId}, modes: ${_this.modes})';
  }
}

/// @nodoc
abstract mixin class $GalleryDuplicateStartRequestCopyWith<$Res> {
  factory $GalleryDuplicateStartRequestCopyWith(
    GalleryDuplicateStartRequest value,
    $Res Function(GalleryDuplicateStartRequest) _then,
  ) = _$GalleryDuplicateStartRequestCopyWithImpl;
  @useResult
  $Res call({String operationId, List<GalleryDuplicateMode> modes});
}

/// @nodoc
class _$GalleryDuplicateStartRequestCopyWithImpl<$Res>
    implements $GalleryDuplicateStartRequestCopyWith<$Res> {
  _$GalleryDuplicateStartRequestCopyWithImpl(this._self, this._then);

  final GalleryDuplicateStartRequest _self;
  final $Res Function(GalleryDuplicateStartRequest) _then;

  /// Create a copy of GalleryDuplicateStartRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? operationId = null, Object? modes = null}) {
    return _then(
      GalleryDuplicateStartRequest(
        operationId: null == operationId
            ? _self.operationId
            : operationId // ignore: cast_nullable_to_non_nullable
                  as String,
        modes: null == modes
            ? _self.modes
            : modes // ignore: cast_nullable_to_non_nullable
                  as List<GalleryDuplicateMode>,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [GalleryDuplicateStartRequest].
extension GalleryDuplicateStartRequestPatterns on GalleryDuplicateStartRequest {
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
    TResult Function(_GalleryDuplicateStartRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicateStartRequest() when $default != null:
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
    TResult Function(_GalleryDuplicateStartRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicateStartRequest():
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
    TResult? Function(_GalleryDuplicateStartRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicateStartRequest() when $default != null:
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
    TResult Function(String operationId, List<GalleryDuplicateMode> modes)?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicateStartRequest() when $default != null:
        return $default(_that.operationId, _that.modes);
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
    TResult Function(String operationId, List<GalleryDuplicateMode> modes)
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicateStartRequest():
        return $default(_that.operationId, _that.modes);
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
    TResult? Function(String operationId, List<GalleryDuplicateMode> modes)?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicateStartRequest() when $default != null:
        return $default(_that.operationId, _that.modes);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _GalleryDuplicateStartRequest implements GalleryDuplicateStartRequest {
  const _GalleryDuplicateStartRequest({
    required this.operationId,
    required List<GalleryDuplicateMode> modes,
  }) : _modes = modes;
  factory _GalleryDuplicateStartRequest.fromJson(Map<String, dynamic> json) =>
      _$GalleryDuplicateStartRequestFromJson(json);

  @override
  final String operationId;
  final List<GalleryDuplicateMode> _modes;
  @override
  List<GalleryDuplicateMode> get modes {
    if (_modes is EqualUnmodifiableListView) return _modes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_modes);
  }

  /// Create a copy of GalleryDuplicateStartRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GalleryDuplicateStartRequestCopyWith<_GalleryDuplicateStartRequest>
  get copyWith =>
      __$GalleryDuplicateStartRequestCopyWithImpl<
        _GalleryDuplicateStartRequest
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$GalleryDuplicateStartRequestToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GalleryDuplicateStartRequest &&
            (identical(other.operationId, operationId) ||
                other.operationId == operationId) &&
            const DeepCollectionEquality().equals(other.modes, _modes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      operationId,
      const DeepCollectionEquality().hash(_modes),
    );
  }

  @override
  String toString() {
    return 'GalleryDuplicateStartRequest(operationId: $operationId, modes: $modes)';
  }
}

/// @nodoc
abstract mixin class _$GalleryDuplicateStartRequestCopyWith<$Res>
    implements $GalleryDuplicateStartRequestCopyWith<$Res> {
  factory _$GalleryDuplicateStartRequestCopyWith(
    _GalleryDuplicateStartRequest value,
    $Res Function(_GalleryDuplicateStartRequest) _then,
  ) = __$GalleryDuplicateStartRequestCopyWithImpl;
  @override
  @useResult
  $Res call({String operationId, List<GalleryDuplicateMode> modes});
}

/// @nodoc
class __$GalleryDuplicateStartRequestCopyWithImpl<$Res>
    implements _$GalleryDuplicateStartRequestCopyWith<$Res> {
  __$GalleryDuplicateStartRequestCopyWithImpl(this._self, this._then);

  final _GalleryDuplicateStartRequest _self;
  final $Res Function(_GalleryDuplicateStartRequest) _then;

  /// Create a copy of GalleryDuplicateStartRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? operationId = null, Object? modes = null}) {
    return _then(
      _GalleryDuplicateStartRequest(
        operationId: null == operationId
            ? _self.operationId
            : operationId // ignore: cast_nullable_to_non_nullable
                  as String,
        modes: null == modes
            ? _self._modes
            : modes // ignore: cast_nullable_to_non_nullable
                  as List<GalleryDuplicateMode>,
      ),
    );
  }
}

/// @nodoc
mixin _$GalleryDuplicateMember {
  String get mediaId;
  String get sourceRevision;
  String get path;
  String get name;
  int get sizeBytes;
  int? get width;
  int? get height;
  @JsonKey(required: true, disallowNullValue: true)
  GalleryMediaSection get section;

  /// Create a copy of GalleryDuplicateMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryDuplicateMemberCopyWith<GalleryDuplicateMember> get copyWith =>
      _$GalleryDuplicateMemberCopyWithImpl<GalleryDuplicateMember>(
        this as GalleryDuplicateMember,
        _$identity,
      );

  /// Serializes this GalleryDuplicateMember to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as GalleryDuplicateMember;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryDuplicateMember &&
            (identical(other.mediaId, _this.mediaId) ||
                other.mediaId == _this.mediaId) &&
            (identical(other.sourceRevision, _this.sourceRevision) ||
                other.sourceRevision == _this.sourceRevision) &&
            (identical(other.path, _this.path) || other.path == _this.path) &&
            (identical(other.name, _this.name) || other.name == _this.name) &&
            (identical(other.sizeBytes, _this.sizeBytes) ||
                other.sizeBytes == _this.sizeBytes) &&
            (identical(other.width, _this.width) ||
                other.width == _this.width) &&
            (identical(other.height, _this.height) ||
                other.height == _this.height) &&
            (identical(other.section, _this.section) ||
                other.section == _this.section));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as GalleryDuplicateMember;
    return Object.hash(
      runtimeType,
      _this.mediaId,
      _this.sourceRevision,
      _this.path,
      _this.name,
      _this.sizeBytes,
      _this.width,
      _this.height,
      _this.section,
    );
  }

  @override
  String toString() {
    final _this = this as GalleryDuplicateMember;
    return 'GalleryDuplicateMember(mediaId: ${_this.mediaId}, sourceRevision: ${_this.sourceRevision}, path: ${_this.path}, name: ${_this.name}, sizeBytes: ${_this.sizeBytes}, width: ${_this.width}, height: ${_this.height}, section: ${_this.section})';
  }
}

/// @nodoc
abstract mixin class $GalleryDuplicateMemberCopyWith<$Res> {
  factory $GalleryDuplicateMemberCopyWith(
    GalleryDuplicateMember value,
    $Res Function(GalleryDuplicateMember) _then,
  ) = _$GalleryDuplicateMemberCopyWithImpl;
  @useResult
  $Res call({
    String mediaId,
    String sourceRevision,
    String path,
    String name,
    int sizeBytes,
    int? width,
    int? height,
    @JsonKey(required: true, disallowNullValue: true)
    GalleryMediaSection section,
  });
}

/// @nodoc
class _$GalleryDuplicateMemberCopyWithImpl<$Res>
    implements $GalleryDuplicateMemberCopyWith<$Res> {
  _$GalleryDuplicateMemberCopyWithImpl(this._self, this._then);

  final GalleryDuplicateMember _self;
  final $Res Function(GalleryDuplicateMember) _then;

  /// Create a copy of GalleryDuplicateMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mediaId = null,
    Object? sourceRevision = null,
    Object? path = null,
    Object? name = null,
    Object? sizeBytes = null,
    Object? width = freezed,
    Object? height = freezed,
    Object? section = null,
  }) {
    return _then(
      GalleryDuplicateMember(
        mediaId: null == mediaId
            ? _self.mediaId
            : mediaId // ignore: cast_nullable_to_non_nullable
                  as String,
        sourceRevision: null == sourceRevision
            ? _self.sourceRevision
            : sourceRevision // ignore: cast_nullable_to_non_nullable
                  as String,
        path: null == path
            ? _self.path
            : path // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _self.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        sizeBytes: null == sizeBytes
            ? _self.sizeBytes
            : sizeBytes // ignore: cast_nullable_to_non_nullable
                  as int,
        width: freezed == width
            ? _self.width
            : width // ignore: cast_nullable_to_non_nullable
                  as int?,
        height: freezed == height
            ? _self.height
            : height // ignore: cast_nullable_to_non_nullable
                  as int?,
        section: null == section
            ? _self.section
            : section // ignore: cast_nullable_to_non_nullable
                  as GalleryMediaSection,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [GalleryDuplicateMember].
extension GalleryDuplicateMemberPatterns on GalleryDuplicateMember {
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
    TResult Function(_GalleryDuplicateMember value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicateMember() when $default != null:
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
    TResult Function(_GalleryDuplicateMember value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicateMember():
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
    TResult? Function(_GalleryDuplicateMember value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicateMember() when $default != null:
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
      String mediaId,
      String sourceRevision,
      String path,
      String name,
      int sizeBytes,
      int? width,
      int? height,
      @JsonKey(required: true, disallowNullValue: true)
      GalleryMediaSection section,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicateMember() when $default != null:
        return $default(
          _that.mediaId,
          _that.sourceRevision,
          _that.path,
          _that.name,
          _that.sizeBytes,
          _that.width,
          _that.height,
          _that.section,
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
      String mediaId,
      String sourceRevision,
      String path,
      String name,
      int sizeBytes,
      int? width,
      int? height,
      @JsonKey(required: true, disallowNullValue: true)
      GalleryMediaSection section,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicateMember():
        return $default(
          _that.mediaId,
          _that.sourceRevision,
          _that.path,
          _that.name,
          _that.sizeBytes,
          _that.width,
          _that.height,
          _that.section,
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
      String mediaId,
      String sourceRevision,
      String path,
      String name,
      int sizeBytes,
      int? width,
      int? height,
      @JsonKey(required: true, disallowNullValue: true)
      GalleryMediaSection section,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicateMember() when $default != null:
        return $default(
          _that.mediaId,
          _that.sourceRevision,
          _that.path,
          _that.name,
          _that.sizeBytes,
          _that.width,
          _that.height,
          _that.section,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _GalleryDuplicateMember implements GalleryDuplicateMember {
  const _GalleryDuplicateMember({
    required this.mediaId,
    required this.sourceRevision,
    required this.path,
    required this.name,
    required this.sizeBytes,
    this.width,
    this.height,
    @JsonKey(required: true, disallowNullValue: true) required this.section,
  });
  factory _GalleryDuplicateMember.fromJson(Map<String, dynamic> json) =>
      _$GalleryDuplicateMemberFromJson(json);

  @override
  final String mediaId;
  @override
  final String sourceRevision;
  @override
  final String path;
  @override
  final String name;
  @override
  final int sizeBytes;
  @override
  final int? width;
  @override
  final int? height;
  @override
  @JsonKey(required: true, disallowNullValue: true)
  final GalleryMediaSection section;

  /// Create a copy of GalleryDuplicateMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GalleryDuplicateMemberCopyWith<_GalleryDuplicateMember> get copyWith =>
      __$GalleryDuplicateMemberCopyWithImpl<_GalleryDuplicateMember>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$GalleryDuplicateMemberToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GalleryDuplicateMember &&
            (identical(other.mediaId, mediaId) || other.mediaId == mediaId) &&
            (identical(other.sourceRevision, sourceRevision) ||
                other.sourceRevision == sourceRevision) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.sizeBytes, sizeBytes) ||
                other.sizeBytes == sizeBytes) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.section, section) || other.section == section));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      mediaId,
      sourceRevision,
      path,
      name,
      sizeBytes,
      width,
      height,
      section,
    );
  }

  @override
  String toString() {
    return 'GalleryDuplicateMember(mediaId: $mediaId, sourceRevision: $sourceRevision, path: $path, name: $name, sizeBytes: $sizeBytes, width: $width, height: $height, section: $section)';
  }
}

/// @nodoc
abstract mixin class _$GalleryDuplicateMemberCopyWith<$Res>
    implements $GalleryDuplicateMemberCopyWith<$Res> {
  factory _$GalleryDuplicateMemberCopyWith(
    _GalleryDuplicateMember value,
    $Res Function(_GalleryDuplicateMember) _then,
  ) = __$GalleryDuplicateMemberCopyWithImpl;
  @override
  @useResult
  $Res call({
    String mediaId,
    String sourceRevision,
    String path,
    String name,
    int sizeBytes,
    int? width,
    int? height,
    @JsonKey(required: true, disallowNullValue: true)
    GalleryMediaSection section,
  });
}

/// @nodoc
class __$GalleryDuplicateMemberCopyWithImpl<$Res>
    implements _$GalleryDuplicateMemberCopyWith<$Res> {
  __$GalleryDuplicateMemberCopyWithImpl(this._self, this._then);

  final _GalleryDuplicateMember _self;
  final $Res Function(_GalleryDuplicateMember) _then;

  /// Create a copy of GalleryDuplicateMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? mediaId = null,
    Object? sourceRevision = null,
    Object? path = null,
    Object? name = null,
    Object? sizeBytes = null,
    Object? width = freezed,
    Object? height = freezed,
    Object? section = null,
  }) {
    return _then(
      _GalleryDuplicateMember(
        mediaId: null == mediaId
            ? _self.mediaId
            : mediaId // ignore: cast_nullable_to_non_nullable
                  as String,
        sourceRevision: null == sourceRevision
            ? _self.sourceRevision
            : sourceRevision // ignore: cast_nullable_to_non_nullable
                  as String,
        path: null == path
            ? _self.path
            : path // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _self.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        sizeBytes: null == sizeBytes
            ? _self.sizeBytes
            : sizeBytes // ignore: cast_nullable_to_non_nullable
                  as int,
        width: freezed == width
            ? _self.width
            : width // ignore: cast_nullable_to_non_nullable
                  as int?,
        height: freezed == height
            ? _self.height
            : height // ignore: cast_nullable_to_non_nullable
                  as int?,
        section: null == section
            ? _self.section
            : section // ignore: cast_nullable_to_non_nullable
                  as GalleryMediaSection,
      ),
    );
  }
}

/// @nodoc
mixin _$GalleryDuplicateGroup {
  String get groupId;
  GalleryDuplicateMode get mode;
  List<GalleryDuplicateMember> get items;

  /// Create a copy of GalleryDuplicateGroup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryDuplicateGroupCopyWith<GalleryDuplicateGroup> get copyWith =>
      _$GalleryDuplicateGroupCopyWithImpl<GalleryDuplicateGroup>(
        this as GalleryDuplicateGroup,
        _$identity,
      );

  /// Serializes this GalleryDuplicateGroup to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as GalleryDuplicateGroup;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryDuplicateGroup &&
            (identical(other.groupId, _this.groupId) ||
                other.groupId == _this.groupId) &&
            (identical(other.mode, _this.mode) || other.mode == _this.mode) &&
            const DeepCollectionEquality().equals(other.items, _this.items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as GalleryDuplicateGroup;
    return Object.hash(
      runtimeType,
      _this.groupId,
      _this.mode,
      const DeepCollectionEquality().hash(_this.items),
    );
  }

  @override
  String toString() {
    final _this = this as GalleryDuplicateGroup;
    return 'GalleryDuplicateGroup(groupId: ${_this.groupId}, mode: ${_this.mode}, items: ${_this.items})';
  }
}

/// @nodoc
abstract mixin class $GalleryDuplicateGroupCopyWith<$Res> {
  factory $GalleryDuplicateGroupCopyWith(
    GalleryDuplicateGroup value,
    $Res Function(GalleryDuplicateGroup) _then,
  ) = _$GalleryDuplicateGroupCopyWithImpl;
  @useResult
  $Res call({
    String groupId,
    GalleryDuplicateMode mode,
    List<GalleryDuplicateMember> items,
  });
}

/// @nodoc
class _$GalleryDuplicateGroupCopyWithImpl<$Res>
    implements $GalleryDuplicateGroupCopyWith<$Res> {
  _$GalleryDuplicateGroupCopyWithImpl(this._self, this._then);

  final GalleryDuplicateGroup _self;
  final $Res Function(GalleryDuplicateGroup) _then;

  /// Create a copy of GalleryDuplicateGroup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupId = null,
    Object? mode = null,
    Object? items = null,
  }) {
    return _then(
      GalleryDuplicateGroup(
        groupId: null == groupId
            ? _self.groupId
            : groupId // ignore: cast_nullable_to_non_nullable
                  as String,
        mode: null == mode
            ? _self.mode
            : mode // ignore: cast_nullable_to_non_nullable
                  as GalleryDuplicateMode,
        items: null == items
            ? _self.items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<GalleryDuplicateMember>,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [GalleryDuplicateGroup].
extension GalleryDuplicateGroupPatterns on GalleryDuplicateGroup {
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
    TResult Function(_GalleryDuplicateGroup value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicateGroup() when $default != null:
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
    TResult Function(_GalleryDuplicateGroup value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicateGroup():
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
    TResult? Function(_GalleryDuplicateGroup value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicateGroup() when $default != null:
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
      String groupId,
      GalleryDuplicateMode mode,
      List<GalleryDuplicateMember> items,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicateGroup() when $default != null:
        return $default(_that.groupId, _that.mode, _that.items);
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
      String groupId,
      GalleryDuplicateMode mode,
      List<GalleryDuplicateMember> items,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicateGroup():
        return $default(_that.groupId, _that.mode, _that.items);
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
      String groupId,
      GalleryDuplicateMode mode,
      List<GalleryDuplicateMember> items,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicateGroup() when $default != null:
        return $default(_that.groupId, _that.mode, _that.items);
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _GalleryDuplicateGroup implements GalleryDuplicateGroup {
  const _GalleryDuplicateGroup({
    required this.groupId,
    required this.mode,
    required List<GalleryDuplicateMember> items,
  }) : _items = items;
  factory _GalleryDuplicateGroup.fromJson(Map<String, dynamic> json) =>
      _$GalleryDuplicateGroupFromJson(json);

  @override
  final String groupId;
  @override
  final GalleryDuplicateMode mode;
  final List<GalleryDuplicateMember> _items;
  @override
  List<GalleryDuplicateMember> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  /// Create a copy of GalleryDuplicateGroup
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GalleryDuplicateGroupCopyWith<_GalleryDuplicateGroup> get copyWith =>
      __$GalleryDuplicateGroupCopyWithImpl<_GalleryDuplicateGroup>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$GalleryDuplicateGroupToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GalleryDuplicateGroup &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            const DeepCollectionEquality().equals(other.items, _items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      groupId,
      mode,
      const DeepCollectionEquality().hash(_items),
    );
  }

  @override
  String toString() {
    return 'GalleryDuplicateGroup(groupId: $groupId, mode: $mode, items: $items)';
  }
}

/// @nodoc
abstract mixin class _$GalleryDuplicateGroupCopyWith<$Res>
    implements $GalleryDuplicateGroupCopyWith<$Res> {
  factory _$GalleryDuplicateGroupCopyWith(
    _GalleryDuplicateGroup value,
    $Res Function(_GalleryDuplicateGroup) _then,
  ) = __$GalleryDuplicateGroupCopyWithImpl;
  @override
  @useResult
  $Res call({
    String groupId,
    GalleryDuplicateMode mode,
    List<GalleryDuplicateMember> items,
  });
}

/// @nodoc
class __$GalleryDuplicateGroupCopyWithImpl<$Res>
    implements _$GalleryDuplicateGroupCopyWith<$Res> {
  __$GalleryDuplicateGroupCopyWithImpl(this._self, this._then);

  final _GalleryDuplicateGroup _self;
  final $Res Function(_GalleryDuplicateGroup) _then;

  /// Create a copy of GalleryDuplicateGroup
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? groupId = null,
    Object? mode = null,
    Object? items = null,
  }) {
    return _then(
      _GalleryDuplicateGroup(
        groupId: null == groupId
            ? _self.groupId
            : groupId // ignore: cast_nullable_to_non_nullable
                  as String,
        mode: null == mode
            ? _self.mode
            : mode // ignore: cast_nullable_to_non_nullable
                  as GalleryDuplicateMode,
        items: null == items
            ? _self._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<GalleryDuplicateMember>,
      ),
    );
  }
}

/// @nodoc
mixin _$GalleryDuplicateGroupPage {
  String get jobId;
  int get index;
  GalleryDuplicateGroup? get group;

  /// Create a copy of GalleryDuplicateGroupPage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryDuplicateGroupPageCopyWith<GalleryDuplicateGroupPage> get copyWith =>
      _$GalleryDuplicateGroupPageCopyWithImpl<GalleryDuplicateGroupPage>(
        this as GalleryDuplicateGroupPage,
        _$identity,
      );

  /// Serializes this GalleryDuplicateGroupPage to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as GalleryDuplicateGroupPage;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryDuplicateGroupPage &&
            (identical(other.jobId, _this.jobId) ||
                other.jobId == _this.jobId) &&
            (identical(other.index, _this.index) ||
                other.index == _this.index) &&
            (identical(other.group, _this.group) ||
                other.group == _this.group));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as GalleryDuplicateGroupPage;
    return Object.hash(runtimeType, _this.jobId, _this.index, _this.group);
  }

  @override
  String toString() {
    final _this = this as GalleryDuplicateGroupPage;
    return 'GalleryDuplicateGroupPage(jobId: ${_this.jobId}, index: ${_this.index}, group: ${_this.group})';
  }
}

/// @nodoc
abstract mixin class $GalleryDuplicateGroupPageCopyWith<$Res> {
  factory $GalleryDuplicateGroupPageCopyWith(
    GalleryDuplicateGroupPage value,
    $Res Function(GalleryDuplicateGroupPage) _then,
  ) = _$GalleryDuplicateGroupPageCopyWithImpl;
  @useResult
  $Res call({String jobId, int index, GalleryDuplicateGroup? group});

  $GalleryDuplicateGroupCopyWith<$Res>? get group;
}

/// @nodoc
class _$GalleryDuplicateGroupPageCopyWithImpl<$Res>
    implements $GalleryDuplicateGroupPageCopyWith<$Res> {
  _$GalleryDuplicateGroupPageCopyWithImpl(this._self, this._then);

  final GalleryDuplicateGroupPage _self;
  final $Res Function(GalleryDuplicateGroupPage) _then;

  /// Create a copy of GalleryDuplicateGroupPage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? jobId = null,
    Object? index = null,
    Object? group = freezed,
  }) {
    return _then(
      GalleryDuplicateGroupPage(
        jobId: null == jobId
            ? _self.jobId
            : jobId // ignore: cast_nullable_to_non_nullable
                  as String,
        index: null == index
            ? _self.index
            : index // ignore: cast_nullable_to_non_nullable
                  as int,
        group: freezed == group
            ? _self.group
            : group // ignore: cast_nullable_to_non_nullable
                  as GalleryDuplicateGroup?,
      ),
    );
  }

  /// Create a copy of GalleryDuplicateGroupPage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryDuplicateGroupCopyWith<$Res>? get group {
    if (_self.group == null) {
      return null;
    }

    return $GalleryDuplicateGroupCopyWith<$Res>(_self.group!, (value) {
      return _then(_self.copyWith(group: value));
    });
  }
}

/// Adds pattern-matching-related methods to [GalleryDuplicateGroupPage].
extension GalleryDuplicateGroupPagePatterns on GalleryDuplicateGroupPage {
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
    TResult Function(_GalleryDuplicateGroupPage value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicateGroupPage() when $default != null:
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
    TResult Function(_GalleryDuplicateGroupPage value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicateGroupPage():
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
    TResult? Function(_GalleryDuplicateGroupPage value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicateGroupPage() when $default != null:
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
    TResult Function(String jobId, int index, GalleryDuplicateGroup? group)?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicateGroupPage() when $default != null:
        return $default(_that.jobId, _that.index, _that.group);
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
    TResult Function(String jobId, int index, GalleryDuplicateGroup? group)
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicateGroupPage():
        return $default(_that.jobId, _that.index, _that.group);
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
    TResult? Function(String jobId, int index, GalleryDuplicateGroup? group)?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicateGroupPage() when $default != null:
        return $default(_that.jobId, _that.index, _that.group);
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _GalleryDuplicateGroupPage implements GalleryDuplicateGroupPage {
  const _GalleryDuplicateGroupPage({
    required this.jobId,
    required this.index,
    this.group,
  });
  factory _GalleryDuplicateGroupPage.fromJson(Map<String, dynamic> json) =>
      _$GalleryDuplicateGroupPageFromJson(json);

  @override
  final String jobId;
  @override
  final int index;
  @override
  final GalleryDuplicateGroup? group;

  /// Create a copy of GalleryDuplicateGroupPage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GalleryDuplicateGroupPageCopyWith<_GalleryDuplicateGroupPage>
  get copyWith =>
      __$GalleryDuplicateGroupPageCopyWithImpl<_GalleryDuplicateGroupPage>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$GalleryDuplicateGroupPageToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GalleryDuplicateGroupPage &&
            (identical(other.jobId, jobId) || other.jobId == jobId) &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.group, group) || other.group == group));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(runtimeType, jobId, index, group);
  }

  @override
  String toString() {
    return 'GalleryDuplicateGroupPage(jobId: $jobId, index: $index, group: $group)';
  }
}

/// @nodoc
abstract mixin class _$GalleryDuplicateGroupPageCopyWith<$Res>
    implements $GalleryDuplicateGroupPageCopyWith<$Res> {
  factory _$GalleryDuplicateGroupPageCopyWith(
    _GalleryDuplicateGroupPage value,
    $Res Function(_GalleryDuplicateGroupPage) _then,
  ) = __$GalleryDuplicateGroupPageCopyWithImpl;
  @override
  @useResult
  $Res call({String jobId, int index, GalleryDuplicateGroup? group});

  @override
  $GalleryDuplicateGroupCopyWith<$Res>? get group;
}

/// @nodoc
class __$GalleryDuplicateGroupPageCopyWithImpl<$Res>
    implements _$GalleryDuplicateGroupPageCopyWith<$Res> {
  __$GalleryDuplicateGroupPageCopyWithImpl(this._self, this._then);

  final _GalleryDuplicateGroupPage _self;
  final $Res Function(_GalleryDuplicateGroupPage) _then;

  /// Create a copy of GalleryDuplicateGroupPage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? jobId = null,
    Object? index = null,
    Object? group = freezed,
  }) {
    return _then(
      _GalleryDuplicateGroupPage(
        jobId: null == jobId
            ? _self.jobId
            : jobId // ignore: cast_nullable_to_non_nullable
                  as String,
        index: null == index
            ? _self.index
            : index // ignore: cast_nullable_to_non_nullable
                  as int,
        group: freezed == group
            ? _self.group
            : group // ignore: cast_nullable_to_non_nullable
                  as GalleryDuplicateGroup?,
      ),
    );
  }

  /// Create a copy of GalleryDuplicateGroupPage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryDuplicateGroupCopyWith<$Res>? get group {
    if (_self.group == null) {
      return null;
    }

    return $GalleryDuplicateGroupCopyWith<$Res>(_self.group!, (value) {
      return _then(_self.copyWith(group: value));
    });
  }
}

/// @nodoc
mixin _$GalleryDuplicateDiagnostics {
  @JsonKey(unknownEnumValue: GalleryDuplicateStage.unknown)
  GalleryDuplicateStage get stage;
  @JsonKey(unknownEnumValue: GalleryDuplicateFailureReason.unknown)
  GalleryDuplicateFailureReason? get failureReason;
  String? get toolVersion;
  int? get exitCode;
  int get candidateCount;
  int get matchedFileCount;
  int get rejectedResultCount;
  int get snapshotSkippedCount;
  bool get rootAliased;
  @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
  GalleryDuplicateMode? get mode;

  /// Create a copy of GalleryDuplicateDiagnostics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryDuplicateDiagnosticsCopyWith<GalleryDuplicateDiagnostics>
  get copyWith =>
      _$GalleryDuplicateDiagnosticsCopyWithImpl<GalleryDuplicateDiagnostics>(
        this as GalleryDuplicateDiagnostics,
        _$identity,
      );

  /// Serializes this GalleryDuplicateDiagnostics to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as GalleryDuplicateDiagnostics;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryDuplicateDiagnostics &&
            (identical(other.stage, _this.stage) ||
                other.stage == _this.stage) &&
            (identical(other.failureReason, _this.failureReason) ||
                other.failureReason == _this.failureReason) &&
            (identical(other.toolVersion, _this.toolVersion) ||
                other.toolVersion == _this.toolVersion) &&
            (identical(other.exitCode, _this.exitCode) ||
                other.exitCode == _this.exitCode) &&
            (identical(other.candidateCount, _this.candidateCount) ||
                other.candidateCount == _this.candidateCount) &&
            (identical(other.matchedFileCount, _this.matchedFileCount) ||
                other.matchedFileCount == _this.matchedFileCount) &&
            (identical(other.rejectedResultCount, _this.rejectedResultCount) ||
                other.rejectedResultCount == _this.rejectedResultCount) &&
            (identical(
                  other.snapshotSkippedCount,
                  _this.snapshotSkippedCount,
                ) ||
                other.snapshotSkippedCount == _this.snapshotSkippedCount) &&
            (identical(other.rootAliased, _this.rootAliased) ||
                other.rootAliased == _this.rootAliased) &&
            (identical(other.mode, _this.mode) || other.mode == _this.mode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as GalleryDuplicateDiagnostics;
    return Object.hash(
      runtimeType,
      _this.stage,
      _this.failureReason,
      _this.toolVersion,
      _this.exitCode,
      _this.candidateCount,
      _this.matchedFileCount,
      _this.rejectedResultCount,
      _this.snapshotSkippedCount,
      _this.rootAliased,
      _this.mode,
    );
  }

  @override
  String toString() {
    final _this = this as GalleryDuplicateDiagnostics;
    return 'GalleryDuplicateDiagnostics(stage: ${_this.stage}, failureReason: ${_this.failureReason}, toolVersion: ${_this.toolVersion}, exitCode: ${_this.exitCode}, candidateCount: ${_this.candidateCount}, matchedFileCount: ${_this.matchedFileCount}, rejectedResultCount: ${_this.rejectedResultCount}, snapshotSkippedCount: ${_this.snapshotSkippedCount}, rootAliased: ${_this.rootAliased}, mode: ${_this.mode})';
  }
}

/// @nodoc
abstract mixin class $GalleryDuplicateDiagnosticsCopyWith<$Res> {
  factory $GalleryDuplicateDiagnosticsCopyWith(
    GalleryDuplicateDiagnostics value,
    $Res Function(GalleryDuplicateDiagnostics) _then,
  ) = _$GalleryDuplicateDiagnosticsCopyWithImpl;
  @useResult
  $Res call({
    @JsonKey(unknownEnumValue: GalleryDuplicateStage.unknown)
    GalleryDuplicateStage stage,
    @JsonKey(unknownEnumValue: GalleryDuplicateFailureReason.unknown)
    GalleryDuplicateFailureReason? failureReason,
    String? toolVersion,
    int? exitCode,
    int candidateCount,
    int matchedFileCount,
    int rejectedResultCount,
    int snapshotSkippedCount,
    bool rootAliased,
    @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
    GalleryDuplicateMode? mode,
  });
}

/// @nodoc
class _$GalleryDuplicateDiagnosticsCopyWithImpl<$Res>
    implements $GalleryDuplicateDiagnosticsCopyWith<$Res> {
  _$GalleryDuplicateDiagnosticsCopyWithImpl(this._self, this._then);

  final GalleryDuplicateDiagnostics _self;
  final $Res Function(GalleryDuplicateDiagnostics) _then;

  /// Create a copy of GalleryDuplicateDiagnostics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stage = null,
    Object? failureReason = freezed,
    Object? toolVersion = freezed,
    Object? exitCode = freezed,
    Object? candidateCount = null,
    Object? matchedFileCount = null,
    Object? rejectedResultCount = null,
    Object? snapshotSkippedCount = null,
    Object? rootAliased = null,
    Object? mode = freezed,
  }) {
    return _then(
      GalleryDuplicateDiagnostics(
        stage: null == stage
            ? _self.stage
            : stage // ignore: cast_nullable_to_non_nullable
                  as GalleryDuplicateStage,
        failureReason: freezed == failureReason
            ? _self.failureReason
            : failureReason // ignore: cast_nullable_to_non_nullable
                  as GalleryDuplicateFailureReason?,
        toolVersion: freezed == toolVersion
            ? _self.toolVersion
            : toolVersion // ignore: cast_nullable_to_non_nullable
                  as String?,
        exitCode: freezed == exitCode
            ? _self.exitCode
            : exitCode // ignore: cast_nullable_to_non_nullable
                  as int?,
        candidateCount: null == candidateCount
            ? _self.candidateCount
            : candidateCount // ignore: cast_nullable_to_non_nullable
                  as int,
        matchedFileCount: null == matchedFileCount
            ? _self.matchedFileCount
            : matchedFileCount // ignore: cast_nullable_to_non_nullable
                  as int,
        rejectedResultCount: null == rejectedResultCount
            ? _self.rejectedResultCount
            : rejectedResultCount // ignore: cast_nullable_to_non_nullable
                  as int,
        snapshotSkippedCount: null == snapshotSkippedCount
            ? _self.snapshotSkippedCount
            : snapshotSkippedCount // ignore: cast_nullable_to_non_nullable
                  as int,
        rootAliased: null == rootAliased
            ? _self.rootAliased
            : rootAliased // ignore: cast_nullable_to_non_nullable
                  as bool,
        mode: freezed == mode
            ? _self.mode
            : mode // ignore: cast_nullable_to_non_nullable
                  as GalleryDuplicateMode?,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [GalleryDuplicateDiagnostics].
extension GalleryDuplicateDiagnosticsPatterns on GalleryDuplicateDiagnostics {
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
    TResult Function(_GalleryDuplicateDiagnostics value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicateDiagnostics() when $default != null:
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
    TResult Function(_GalleryDuplicateDiagnostics value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicateDiagnostics():
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
    TResult? Function(_GalleryDuplicateDiagnostics value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicateDiagnostics() when $default != null:
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
      @JsonKey(unknownEnumValue: GalleryDuplicateStage.unknown)
      GalleryDuplicateStage stage,
      @JsonKey(unknownEnumValue: GalleryDuplicateFailureReason.unknown)
      GalleryDuplicateFailureReason? failureReason,
      String? toolVersion,
      int? exitCode,
      int candidateCount,
      int matchedFileCount,
      int rejectedResultCount,
      int snapshotSkippedCount,
      bool rootAliased,
      @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
      GalleryDuplicateMode? mode,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicateDiagnostics() when $default != null:
        return $default(
          _that.stage,
          _that.failureReason,
          _that.toolVersion,
          _that.exitCode,
          _that.candidateCount,
          _that.matchedFileCount,
          _that.rejectedResultCount,
          _that.snapshotSkippedCount,
          _that.rootAliased,
          _that.mode,
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
      @JsonKey(unknownEnumValue: GalleryDuplicateStage.unknown)
      GalleryDuplicateStage stage,
      @JsonKey(unknownEnumValue: GalleryDuplicateFailureReason.unknown)
      GalleryDuplicateFailureReason? failureReason,
      String? toolVersion,
      int? exitCode,
      int candidateCount,
      int matchedFileCount,
      int rejectedResultCount,
      int snapshotSkippedCount,
      bool rootAliased,
      @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
      GalleryDuplicateMode? mode,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicateDiagnostics():
        return $default(
          _that.stage,
          _that.failureReason,
          _that.toolVersion,
          _that.exitCode,
          _that.candidateCount,
          _that.matchedFileCount,
          _that.rejectedResultCount,
          _that.snapshotSkippedCount,
          _that.rootAliased,
          _that.mode,
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
      @JsonKey(unknownEnumValue: GalleryDuplicateStage.unknown)
      GalleryDuplicateStage stage,
      @JsonKey(unknownEnumValue: GalleryDuplicateFailureReason.unknown)
      GalleryDuplicateFailureReason? failureReason,
      String? toolVersion,
      int? exitCode,
      int candidateCount,
      int matchedFileCount,
      int rejectedResultCount,
      int snapshotSkippedCount,
      bool rootAliased,
      @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
      GalleryDuplicateMode? mode,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicateDiagnostics() when $default != null:
        return $default(
          _that.stage,
          _that.failureReason,
          _that.toolVersion,
          _that.exitCode,
          _that.candidateCount,
          _that.matchedFileCount,
          _that.rejectedResultCount,
          _that.snapshotSkippedCount,
          _that.rootAliased,
          _that.mode,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _GalleryDuplicateDiagnostics implements GalleryDuplicateDiagnostics {
  const _GalleryDuplicateDiagnostics({
    @JsonKey(unknownEnumValue: GalleryDuplicateStage.unknown)
    required this.stage,
    @JsonKey(unknownEnumValue: GalleryDuplicateFailureReason.unknown)
    this.failureReason,
    this.toolVersion,
    this.exitCode,
    this.candidateCount = 0,
    this.matchedFileCount = 0,
    this.rejectedResultCount = 0,
    this.snapshotSkippedCount = 0,
    this.rootAliased = false,
    @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) this.mode,
  });
  factory _GalleryDuplicateDiagnostics.fromJson(Map<String, dynamic> json) =>
      _$GalleryDuplicateDiagnosticsFromJson(json);

  @override
  @JsonKey(unknownEnumValue: GalleryDuplicateStage.unknown)
  final GalleryDuplicateStage stage;
  @override
  @JsonKey(unknownEnumValue: GalleryDuplicateFailureReason.unknown)
  final GalleryDuplicateFailureReason? failureReason;
  @override
  final String? toolVersion;
  @override
  final int? exitCode;
  @override
  @JsonKey()
  final int candidateCount;
  @override
  @JsonKey()
  final int matchedFileCount;
  @override
  @JsonKey()
  final int rejectedResultCount;
  @override
  @JsonKey()
  final int snapshotSkippedCount;
  @override
  @JsonKey()
  final bool rootAliased;
  @override
  @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
  final GalleryDuplicateMode? mode;

  /// Create a copy of GalleryDuplicateDiagnostics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GalleryDuplicateDiagnosticsCopyWith<_GalleryDuplicateDiagnostics>
  get copyWith =>
      __$GalleryDuplicateDiagnosticsCopyWithImpl<_GalleryDuplicateDiagnostics>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$GalleryDuplicateDiagnosticsToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GalleryDuplicateDiagnostics &&
            (identical(other.stage, stage) || other.stage == stage) &&
            (identical(other.failureReason, failureReason) ||
                other.failureReason == failureReason) &&
            (identical(other.toolVersion, toolVersion) ||
                other.toolVersion == toolVersion) &&
            (identical(other.exitCode, exitCode) ||
                other.exitCode == exitCode) &&
            (identical(other.candidateCount, candidateCount) ||
                other.candidateCount == candidateCount) &&
            (identical(other.matchedFileCount, matchedFileCount) ||
                other.matchedFileCount == matchedFileCount) &&
            (identical(other.rejectedResultCount, rejectedResultCount) ||
                other.rejectedResultCount == rejectedResultCount) &&
            (identical(other.snapshotSkippedCount, snapshotSkippedCount) ||
                other.snapshotSkippedCount == snapshotSkippedCount) &&
            (identical(other.rootAliased, rootAliased) ||
                other.rootAliased == rootAliased) &&
            (identical(other.mode, mode) || other.mode == mode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      stage,
      failureReason,
      toolVersion,
      exitCode,
      candidateCount,
      matchedFileCount,
      rejectedResultCount,
      snapshotSkippedCount,
      rootAliased,
      mode,
    );
  }

  @override
  String toString() {
    return 'GalleryDuplicateDiagnostics(stage: $stage, failureReason: $failureReason, toolVersion: $toolVersion, exitCode: $exitCode, candidateCount: $candidateCount, matchedFileCount: $matchedFileCount, rejectedResultCount: $rejectedResultCount, snapshotSkippedCount: $snapshotSkippedCount, rootAliased: $rootAliased, mode: $mode)';
  }
}

/// @nodoc
abstract mixin class _$GalleryDuplicateDiagnosticsCopyWith<$Res>
    implements $GalleryDuplicateDiagnosticsCopyWith<$Res> {
  factory _$GalleryDuplicateDiagnosticsCopyWith(
    _GalleryDuplicateDiagnostics value,
    $Res Function(_GalleryDuplicateDiagnostics) _then,
  ) = __$GalleryDuplicateDiagnosticsCopyWithImpl;
  @override
  @useResult
  $Res call({
    @JsonKey(unknownEnumValue: GalleryDuplicateStage.unknown)
    GalleryDuplicateStage stage,
    @JsonKey(unknownEnumValue: GalleryDuplicateFailureReason.unknown)
    GalleryDuplicateFailureReason? failureReason,
    String? toolVersion,
    int? exitCode,
    int candidateCount,
    int matchedFileCount,
    int rejectedResultCount,
    int snapshotSkippedCount,
    bool rootAliased,
    @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
    GalleryDuplicateMode? mode,
  });
}

/// @nodoc
class __$GalleryDuplicateDiagnosticsCopyWithImpl<$Res>
    implements _$GalleryDuplicateDiagnosticsCopyWith<$Res> {
  __$GalleryDuplicateDiagnosticsCopyWithImpl(this._self, this._then);

  final _GalleryDuplicateDiagnostics _self;
  final $Res Function(_GalleryDuplicateDiagnostics) _then;

  /// Create a copy of GalleryDuplicateDiagnostics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? stage = null,
    Object? failureReason = freezed,
    Object? toolVersion = freezed,
    Object? exitCode = freezed,
    Object? candidateCount = null,
    Object? matchedFileCount = null,
    Object? rejectedResultCount = null,
    Object? snapshotSkippedCount = null,
    Object? rootAliased = null,
    Object? mode = freezed,
  }) {
    return _then(
      _GalleryDuplicateDiagnostics(
        stage: null == stage
            ? _self.stage
            : stage // ignore: cast_nullable_to_non_nullable
                  as GalleryDuplicateStage,
        failureReason: freezed == failureReason
            ? _self.failureReason
            : failureReason // ignore: cast_nullable_to_non_nullable
                  as GalleryDuplicateFailureReason?,
        toolVersion: freezed == toolVersion
            ? _self.toolVersion
            : toolVersion // ignore: cast_nullable_to_non_nullable
                  as String?,
        exitCode: freezed == exitCode
            ? _self.exitCode
            : exitCode // ignore: cast_nullable_to_non_nullable
                  as int?,
        candidateCount: null == candidateCount
            ? _self.candidateCount
            : candidateCount // ignore: cast_nullable_to_non_nullable
                  as int,
        matchedFileCount: null == matchedFileCount
            ? _self.matchedFileCount
            : matchedFileCount // ignore: cast_nullable_to_non_nullable
                  as int,
        rejectedResultCount: null == rejectedResultCount
            ? _self.rejectedResultCount
            : rejectedResultCount // ignore: cast_nullable_to_non_nullable
                  as int,
        snapshotSkippedCount: null == snapshotSkippedCount
            ? _self.snapshotSkippedCount
            : snapshotSkippedCount // ignore: cast_nullable_to_non_nullable
                  as int,
        rootAliased: null == rootAliased
            ? _self.rootAliased
            : rootAliased // ignore: cast_nullable_to_non_nullable
                  as bool,
        mode: freezed == mode
            ? _self.mode
            : mode // ignore: cast_nullable_to_non_nullable
                  as GalleryDuplicateMode?,
      ),
    );
  }
}

/// @nodoc
mixin _$GalleryDuplicateJob {
  String get jobId;
  GalleryDuplicateStatus get status;
  DateTime? get startedAt;
  DateTime? get finishedAt;
  List<GalleryDuplicateMode> get modes;
  List<GalleryDuplicateGroup> get groups;
  @JsonKey(unknownEnumValue: GalleryErrorCode.unknown)
  GalleryErrorCode? get error;
  int get skipped;
  GalleryDuplicateDiagnostics? get diagnostics;

  /// Create a copy of GalleryDuplicateJob
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryDuplicateJobCopyWith<GalleryDuplicateJob> get copyWith =>
      _$GalleryDuplicateJobCopyWithImpl<GalleryDuplicateJob>(
        this as GalleryDuplicateJob,
        _$identity,
      );

  /// Serializes this GalleryDuplicateJob to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as GalleryDuplicateJob;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryDuplicateJob &&
            (identical(other.jobId, _this.jobId) ||
                other.jobId == _this.jobId) &&
            (identical(other.status, _this.status) ||
                other.status == _this.status) &&
            (identical(other.startedAt, _this.startedAt) ||
                other.startedAt == _this.startedAt) &&
            (identical(other.finishedAt, _this.finishedAt) ||
                other.finishedAt == _this.finishedAt) &&
            const DeepCollectionEquality().equals(other.modes, _this.modes) &&
            const DeepCollectionEquality().equals(other.groups, _this.groups) &&
            (identical(other.error, _this.error) ||
                other.error == _this.error) &&
            (identical(other.skipped, _this.skipped) ||
                other.skipped == _this.skipped) &&
            (identical(other.diagnostics, _this.diagnostics) ||
                other.diagnostics == _this.diagnostics));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as GalleryDuplicateJob;
    return Object.hash(
      runtimeType,
      _this.jobId,
      _this.status,
      _this.startedAt,
      _this.finishedAt,
      const DeepCollectionEquality().hash(_this.modes),
      const DeepCollectionEquality().hash(_this.groups),
      _this.error,
      _this.skipped,
      _this.diagnostics,
    );
  }

  @override
  String toString() {
    final _this = this as GalleryDuplicateJob;
    return 'GalleryDuplicateJob(jobId: ${_this.jobId}, status: ${_this.status}, startedAt: ${_this.startedAt}, finishedAt: ${_this.finishedAt}, modes: ${_this.modes}, groups: ${_this.groups}, error: ${_this.error}, skipped: ${_this.skipped}, diagnostics: ${_this.diagnostics})';
  }
}

/// @nodoc
abstract mixin class $GalleryDuplicateJobCopyWith<$Res> {
  factory $GalleryDuplicateJobCopyWith(
    GalleryDuplicateJob value,
    $Res Function(GalleryDuplicateJob) _then,
  ) = _$GalleryDuplicateJobCopyWithImpl;
  @useResult
  $Res call({
    String jobId,
    GalleryDuplicateStatus status,
    DateTime? startedAt,
    DateTime? finishedAt,
    List<GalleryDuplicateMode> modes,
    List<GalleryDuplicateGroup> groups,
    @JsonKey(unknownEnumValue: GalleryErrorCode.unknown)
    GalleryErrorCode? error,
    int skipped,
    GalleryDuplicateDiagnostics? diagnostics,
  });

  $GalleryDuplicateDiagnosticsCopyWith<$Res>? get diagnostics;
}

/// @nodoc
class _$GalleryDuplicateJobCopyWithImpl<$Res>
    implements $GalleryDuplicateJobCopyWith<$Res> {
  _$GalleryDuplicateJobCopyWithImpl(this._self, this._then);

  final GalleryDuplicateJob _self;
  final $Res Function(GalleryDuplicateJob) _then;

  /// Create a copy of GalleryDuplicateJob
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? jobId = null,
    Object? status = null,
    Object? startedAt = freezed,
    Object? finishedAt = freezed,
    Object? modes = null,
    Object? groups = null,
    Object? error = freezed,
    Object? skipped = null,
    Object? diagnostics = freezed,
  }) {
    return _then(
      GalleryDuplicateJob(
        jobId: null == jobId
            ? _self.jobId
            : jobId // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _self.status
            : status // ignore: cast_nullable_to_non_nullable
                  as GalleryDuplicateStatus,
        startedAt: freezed == startedAt
            ? _self.startedAt
            : startedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        finishedAt: freezed == finishedAt
            ? _self.finishedAt
            : finishedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        modes: null == modes
            ? _self.modes
            : modes // ignore: cast_nullable_to_non_nullable
                  as List<GalleryDuplicateMode>,
        groups: null == groups
            ? _self.groups
            : groups // ignore: cast_nullable_to_non_nullable
                  as List<GalleryDuplicateGroup>,
        error: freezed == error
            ? _self.error
            : error // ignore: cast_nullable_to_non_nullable
                  as GalleryErrorCode?,
        skipped: null == skipped
            ? _self.skipped
            : skipped // ignore: cast_nullable_to_non_nullable
                  as int,
        diagnostics: freezed == diagnostics
            ? _self.diagnostics
            : diagnostics // ignore: cast_nullable_to_non_nullable
                  as GalleryDuplicateDiagnostics?,
      ),
    );
  }

  /// Create a copy of GalleryDuplicateJob
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryDuplicateDiagnosticsCopyWith<$Res>? get diagnostics {
    if (_self.diagnostics == null) {
      return null;
    }

    return $GalleryDuplicateDiagnosticsCopyWith<$Res>(_self.diagnostics!, (
      value,
    ) {
      return _then(_self.copyWith(diagnostics: value));
    });
  }
}

/// Adds pattern-matching-related methods to [GalleryDuplicateJob].
extension GalleryDuplicateJobPatterns on GalleryDuplicateJob {
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
    TResult Function(_GalleryDuplicateJob value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicateJob() when $default != null:
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
    TResult Function(_GalleryDuplicateJob value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicateJob():
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
    TResult? Function(_GalleryDuplicateJob value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicateJob() when $default != null:
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
      String jobId,
      GalleryDuplicateStatus status,
      DateTime? startedAt,
      DateTime? finishedAt,
      List<GalleryDuplicateMode> modes,
      List<GalleryDuplicateGroup> groups,
      @JsonKey(unknownEnumValue: GalleryErrorCode.unknown)
      GalleryErrorCode? error,
      int skipped,
      GalleryDuplicateDiagnostics? diagnostics,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicateJob() when $default != null:
        return $default(
          _that.jobId,
          _that.status,
          _that.startedAt,
          _that.finishedAt,
          _that.modes,
          _that.groups,
          _that.error,
          _that.skipped,
          _that.diagnostics,
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
      String jobId,
      GalleryDuplicateStatus status,
      DateTime? startedAt,
      DateTime? finishedAt,
      List<GalleryDuplicateMode> modes,
      List<GalleryDuplicateGroup> groups,
      @JsonKey(unknownEnumValue: GalleryErrorCode.unknown)
      GalleryErrorCode? error,
      int skipped,
      GalleryDuplicateDiagnostics? diagnostics,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicateJob():
        return $default(
          _that.jobId,
          _that.status,
          _that.startedAt,
          _that.finishedAt,
          _that.modes,
          _that.groups,
          _that.error,
          _that.skipped,
          _that.diagnostics,
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
      String jobId,
      GalleryDuplicateStatus status,
      DateTime? startedAt,
      DateTime? finishedAt,
      List<GalleryDuplicateMode> modes,
      List<GalleryDuplicateGroup> groups,
      @JsonKey(unknownEnumValue: GalleryErrorCode.unknown)
      GalleryErrorCode? error,
      int skipped,
      GalleryDuplicateDiagnostics? diagnostics,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryDuplicateJob() when $default != null:
        return $default(
          _that.jobId,
          _that.status,
          _that.startedAt,
          _that.finishedAt,
          _that.modes,
          _that.groups,
          _that.error,
          _that.skipped,
          _that.diagnostics,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _GalleryDuplicateJob implements GalleryDuplicateJob {
  const _GalleryDuplicateJob({
    required this.jobId,
    required this.status,
    this.startedAt,
    this.finishedAt,
    List<GalleryDuplicateMode> modes = const [],
    List<GalleryDuplicateGroup> groups = const [],
    @JsonKey(unknownEnumValue: GalleryErrorCode.unknown) this.error,
    this.skipped = 0,
    this.diagnostics,
  }) : _modes = modes,
       _groups = groups;
  factory _GalleryDuplicateJob.fromJson(Map<String, dynamic> json) =>
      _$GalleryDuplicateJobFromJson(json);

  @override
  final String jobId;
  @override
  final GalleryDuplicateStatus status;
  @override
  final DateTime? startedAt;
  @override
  final DateTime? finishedAt;
  final List<GalleryDuplicateMode> _modes;
  @override
  @JsonKey()
  List<GalleryDuplicateMode> get modes {
    if (_modes is EqualUnmodifiableListView) return _modes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_modes);
  }

  final List<GalleryDuplicateGroup> _groups;
  @override
  @JsonKey()
  List<GalleryDuplicateGroup> get groups {
    if (_groups is EqualUnmodifiableListView) return _groups;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_groups);
  }

  @override
  @JsonKey(unknownEnumValue: GalleryErrorCode.unknown)
  final GalleryErrorCode? error;
  @override
  @JsonKey()
  final int skipped;
  @override
  final GalleryDuplicateDiagnostics? diagnostics;

  /// Create a copy of GalleryDuplicateJob
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GalleryDuplicateJobCopyWith<_GalleryDuplicateJob> get copyWith =>
      __$GalleryDuplicateJobCopyWithImpl<_GalleryDuplicateJob>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$GalleryDuplicateJobToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GalleryDuplicateJob &&
            (identical(other.jobId, jobId) || other.jobId == jobId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.finishedAt, finishedAt) ||
                other.finishedAt == finishedAt) &&
            const DeepCollectionEquality().equals(other.modes, _modes) &&
            const DeepCollectionEquality().equals(other.groups, _groups) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.skipped, skipped) || other.skipped == skipped) &&
            (identical(other.diagnostics, diagnostics) ||
                other.diagnostics == diagnostics));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      jobId,
      status,
      startedAt,
      finishedAt,
      const DeepCollectionEquality().hash(_modes),
      const DeepCollectionEquality().hash(_groups),
      error,
      skipped,
      diagnostics,
    );
  }

  @override
  String toString() {
    return 'GalleryDuplicateJob(jobId: $jobId, status: $status, startedAt: $startedAt, finishedAt: $finishedAt, modes: $modes, groups: $groups, error: $error, skipped: $skipped, diagnostics: $diagnostics)';
  }
}

/// @nodoc
abstract mixin class _$GalleryDuplicateJobCopyWith<$Res>
    implements $GalleryDuplicateJobCopyWith<$Res> {
  factory _$GalleryDuplicateJobCopyWith(
    _GalleryDuplicateJob value,
    $Res Function(_GalleryDuplicateJob) _then,
  ) = __$GalleryDuplicateJobCopyWithImpl;
  @override
  @useResult
  $Res call({
    String jobId,
    GalleryDuplicateStatus status,
    DateTime? startedAt,
    DateTime? finishedAt,
    List<GalleryDuplicateMode> modes,
    List<GalleryDuplicateGroup> groups,
    @JsonKey(unknownEnumValue: GalleryErrorCode.unknown)
    GalleryErrorCode? error,
    int skipped,
    GalleryDuplicateDiagnostics? diagnostics,
  });

  @override
  $GalleryDuplicateDiagnosticsCopyWith<$Res>? get diagnostics;
}

/// @nodoc
class __$GalleryDuplicateJobCopyWithImpl<$Res>
    implements _$GalleryDuplicateJobCopyWith<$Res> {
  __$GalleryDuplicateJobCopyWithImpl(this._self, this._then);

  final _GalleryDuplicateJob _self;
  final $Res Function(_GalleryDuplicateJob) _then;

  /// Create a copy of GalleryDuplicateJob
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? jobId = null,
    Object? status = null,
    Object? startedAt = freezed,
    Object? finishedAt = freezed,
    Object? modes = null,
    Object? groups = null,
    Object? error = freezed,
    Object? skipped = null,
    Object? diagnostics = freezed,
  }) {
    return _then(
      _GalleryDuplicateJob(
        jobId: null == jobId
            ? _self.jobId
            : jobId // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _self.status
            : status // ignore: cast_nullable_to_non_nullable
                  as GalleryDuplicateStatus,
        startedAt: freezed == startedAt
            ? _self.startedAt
            : startedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        finishedAt: freezed == finishedAt
            ? _self.finishedAt
            : finishedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        modes: null == modes
            ? _self._modes
            : modes // ignore: cast_nullable_to_non_nullable
                  as List<GalleryDuplicateMode>,
        groups: null == groups
            ? _self._groups
            : groups // ignore: cast_nullable_to_non_nullable
                  as List<GalleryDuplicateGroup>,
        error: freezed == error
            ? _self.error
            : error // ignore: cast_nullable_to_non_nullable
                  as GalleryErrorCode?,
        skipped: null == skipped
            ? _self.skipped
            : skipped // ignore: cast_nullable_to_non_nullable
                  as int,
        diagnostics: freezed == diagnostics
            ? _self.diagnostics
            : diagnostics // ignore: cast_nullable_to_non_nullable
                  as GalleryDuplicateDiagnostics?,
      ),
    );
  }

  /// Create a copy of GalleryDuplicateJob
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryDuplicateDiagnosticsCopyWith<$Res>? get diagnostics {
    if (_self.diagnostics == null) {
      return null;
    }

    return $GalleryDuplicateDiagnosticsCopyWith<$Res>(_self.diagnostics!, (
      value,
    ) {
      return _then(_self.copyWith(diagnostics: value));
    });
  }
}
