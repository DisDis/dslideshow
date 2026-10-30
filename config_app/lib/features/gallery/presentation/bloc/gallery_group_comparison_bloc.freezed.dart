// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gallery_group_comparison_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GalleryImageResolution {
  int get width;
  int get height;

  /// Create a copy of GalleryImageResolution
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryImageResolutionCopyWith<GalleryImageResolution> get copyWith =>
      _$GalleryImageResolutionCopyWithImpl<GalleryImageResolution>(
        this as GalleryImageResolution,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    final _this = this as GalleryImageResolution;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryImageResolution &&
            (identical(other.width, _this.width) ||
                other.width == _this.width) &&
            (identical(other.height, _this.height) ||
                other.height == _this.height));
  }

  @override
  int get hashCode {
    final _this = this as GalleryImageResolution;
    return Object.hash(runtimeType, _this.width, _this.height);
  }

  @override
  String toString() {
    final _this = this as GalleryImageResolution;
    return 'GalleryImageResolution(width: ${_this.width}, height: ${_this.height})';
  }
}

/// @nodoc
abstract mixin class $GalleryImageResolutionCopyWith<$Res> {
  factory $GalleryImageResolutionCopyWith(
    GalleryImageResolution value,
    $Res Function(GalleryImageResolution) _then,
  ) = _$GalleryImageResolutionCopyWithImpl;
  @useResult
  $Res call({int width, int height});
}

/// @nodoc
class _$GalleryImageResolutionCopyWithImpl<$Res>
    implements $GalleryImageResolutionCopyWith<$Res> {
  _$GalleryImageResolutionCopyWithImpl(this._self, this._then);

  final GalleryImageResolution _self;
  final $Res Function(GalleryImageResolution) _then;

  /// Create a copy of GalleryImageResolution
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? width = null, Object? height = null}) {
    return _then(
      GalleryImageResolution(
        width: null == width
            ? _self.width
            : width // ignore: cast_nullable_to_non_nullable
                  as int,
        height: null == height
            ? _self.height
            : height // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [GalleryImageResolution].
extension GalleryImageResolutionPatterns on GalleryImageResolution {
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
    TResult Function(_GalleryImageResolution value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryImageResolution() when $default != null:
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
    TResult Function(_GalleryImageResolution value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryImageResolution():
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
    TResult? Function(_GalleryImageResolution value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryImageResolution() when $default != null:
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
    TResult Function(int width, int height)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryImageResolution() when $default != null:
        return $default(_that.width, _that.height);
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
    TResult Function(int width, int height) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryImageResolution():
        return $default(_that.width, _that.height);
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
    TResult? Function(int width, int height)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryImageResolution() when $default != null:
        return $default(_that.width, _that.height);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _GalleryImageResolution extends GalleryImageResolution {
  const _GalleryImageResolution({required this.width, required this.height})
    : super._();

  @override
  final int width;
  @override
  final int height;

  /// Create a copy of GalleryImageResolution
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GalleryImageResolutionCopyWith<_GalleryImageResolution> get copyWith =>
      __$GalleryImageResolutionCopyWithImpl<_GalleryImageResolution>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GalleryImageResolution &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, width, height);
  }

  @override
  String toString() {
    return 'GalleryImageResolution(width: $width, height: $height)';
  }
}

/// @nodoc
abstract mixin class _$GalleryImageResolutionCopyWith<$Res>
    implements $GalleryImageResolutionCopyWith<$Res> {
  factory _$GalleryImageResolutionCopyWith(
    _GalleryImageResolution value,
    $Res Function(_GalleryImageResolution) _then,
  ) = __$GalleryImageResolutionCopyWithImpl;
  @override
  @useResult
  $Res call({int width, int height});
}

/// @nodoc
class __$GalleryImageResolutionCopyWithImpl<$Res>
    implements _$GalleryImageResolutionCopyWith<$Res> {
  __$GalleryImageResolutionCopyWithImpl(this._self, this._then);

  final _GalleryImageResolution _self;
  final $Res Function(_GalleryImageResolution) _then;

  /// Create a copy of GalleryImageResolution
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? width = null, Object? height = null}) {
    return _then(
      _GalleryImageResolution(
        width: null == width
            ? _self.width
            : width // ignore: cast_nullable_to_non_nullable
                  as int,
        height: null == height
            ? _self.height
            : height // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
mixin _$GalleryGroupComparisonState {
  bool get exact;
  int get totalCount;
  int get knownCount;
  int? get minPixels;
  int? get maxPixels;
  int get maximumCount;
  int get minSizeBytes;
  int get maxSizeBytes;
  String? get recommendedMediaId;

  /// Create a copy of GalleryGroupComparisonState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryGroupComparisonStateCopyWith<GalleryGroupComparisonState>
  get copyWith =>
      _$GalleryGroupComparisonStateCopyWithImpl<GalleryGroupComparisonState>(
        this as GalleryGroupComparisonState,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    final _this = this as GalleryGroupComparisonState;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryGroupComparisonState &&
            (identical(other.exact, _this.exact) ||
                other.exact == _this.exact) &&
            (identical(other.totalCount, _this.totalCount) ||
                other.totalCount == _this.totalCount) &&
            (identical(other.knownCount, _this.knownCount) ||
                other.knownCount == _this.knownCount) &&
            (identical(other.minPixels, _this.minPixels) ||
                other.minPixels == _this.minPixels) &&
            (identical(other.maxPixels, _this.maxPixels) ||
                other.maxPixels == _this.maxPixels) &&
            (identical(other.maximumCount, _this.maximumCount) ||
                other.maximumCount == _this.maximumCount) &&
            (identical(other.minSizeBytes, _this.minSizeBytes) ||
                other.minSizeBytes == _this.minSizeBytes) &&
            (identical(other.maxSizeBytes, _this.maxSizeBytes) ||
                other.maxSizeBytes == _this.maxSizeBytes) &&
            (identical(other.recommendedMediaId, _this.recommendedMediaId) ||
                other.recommendedMediaId == _this.recommendedMediaId));
  }

  @override
  int get hashCode {
    final _this = this as GalleryGroupComparisonState;
    return Object.hash(
      runtimeType,
      _this.exact,
      _this.totalCount,
      _this.knownCount,
      _this.minPixels,
      _this.maxPixels,
      _this.maximumCount,
      _this.minSizeBytes,
      _this.maxSizeBytes,
      _this.recommendedMediaId,
    );
  }

  @override
  String toString() {
    final _this = this as GalleryGroupComparisonState;
    return 'GalleryGroupComparisonState(exact: ${_this.exact}, totalCount: ${_this.totalCount}, knownCount: ${_this.knownCount}, minPixels: ${_this.minPixels}, maxPixels: ${_this.maxPixels}, maximumCount: ${_this.maximumCount}, minSizeBytes: ${_this.minSizeBytes}, maxSizeBytes: ${_this.maxSizeBytes}, recommendedMediaId: ${_this.recommendedMediaId})';
  }
}

/// @nodoc
abstract mixin class $GalleryGroupComparisonStateCopyWith<$Res> {
  factory $GalleryGroupComparisonStateCopyWith(
    GalleryGroupComparisonState value,
    $Res Function(GalleryGroupComparisonState) _then,
  ) = _$GalleryGroupComparisonStateCopyWithImpl;
  @useResult
  $Res call({
    bool exact,
    int totalCount,
    int knownCount,
    int? minPixels,
    int? maxPixels,
    int maximumCount,
    int minSizeBytes,
    int maxSizeBytes,
    String? recommendedMediaId,
  });
}

/// @nodoc
class _$GalleryGroupComparisonStateCopyWithImpl<$Res>
    implements $GalleryGroupComparisonStateCopyWith<$Res> {
  _$GalleryGroupComparisonStateCopyWithImpl(this._self, this._then);

  final GalleryGroupComparisonState _self;
  final $Res Function(GalleryGroupComparisonState) _then;

  /// Create a copy of GalleryGroupComparisonState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exact = null,
    Object? totalCount = null,
    Object? knownCount = null,
    Object? minPixels = freezed,
    Object? maxPixels = freezed,
    Object? maximumCount = null,
    Object? minSizeBytes = null,
    Object? maxSizeBytes = null,
    Object? recommendedMediaId = freezed,
  }) {
    return _then(
      GalleryGroupComparisonState(
        exact: null == exact
            ? _self.exact
            : exact // ignore: cast_nullable_to_non_nullable
                  as bool,
        totalCount: null == totalCount
            ? _self.totalCount
            : totalCount // ignore: cast_nullable_to_non_nullable
                  as int,
        knownCount: null == knownCount
            ? _self.knownCount
            : knownCount // ignore: cast_nullable_to_non_nullable
                  as int,
        minPixels: freezed == minPixels
            ? _self.minPixels
            : minPixels // ignore: cast_nullable_to_non_nullable
                  as int?,
        maxPixels: freezed == maxPixels
            ? _self.maxPixels
            : maxPixels // ignore: cast_nullable_to_non_nullable
                  as int?,
        maximumCount: null == maximumCount
            ? _self.maximumCount
            : maximumCount // ignore: cast_nullable_to_non_nullable
                  as int,
        minSizeBytes: null == minSizeBytes
            ? _self.minSizeBytes
            : minSizeBytes // ignore: cast_nullable_to_non_nullable
                  as int,
        maxSizeBytes: null == maxSizeBytes
            ? _self.maxSizeBytes
            : maxSizeBytes // ignore: cast_nullable_to_non_nullable
                  as int,
        recommendedMediaId: freezed == recommendedMediaId
            ? _self.recommendedMediaId
            : recommendedMediaId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [GalleryGroupComparisonState].
extension GalleryGroupComparisonStatePatterns on GalleryGroupComparisonState {
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
    TResult Function(_GalleryGroupComparisonState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryGroupComparisonState() when $default != null:
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
    TResult Function(_GalleryGroupComparisonState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryGroupComparisonState():
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
    TResult? Function(_GalleryGroupComparisonState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryGroupComparisonState() when $default != null:
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
      bool exact,
      int totalCount,
      int knownCount,
      int? minPixels,
      int? maxPixels,
      int maximumCount,
      int minSizeBytes,
      int maxSizeBytes,
      String? recommendedMediaId,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryGroupComparisonState() when $default != null:
        return $default(
          _that.exact,
          _that.totalCount,
          _that.knownCount,
          _that.minPixels,
          _that.maxPixels,
          _that.maximumCount,
          _that.minSizeBytes,
          _that.maxSizeBytes,
          _that.recommendedMediaId,
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
      bool exact,
      int totalCount,
      int knownCount,
      int? minPixels,
      int? maxPixels,
      int maximumCount,
      int minSizeBytes,
      int maxSizeBytes,
      String? recommendedMediaId,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryGroupComparisonState():
        return $default(
          _that.exact,
          _that.totalCount,
          _that.knownCount,
          _that.minPixels,
          _that.maxPixels,
          _that.maximumCount,
          _that.minSizeBytes,
          _that.maxSizeBytes,
          _that.recommendedMediaId,
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
      bool exact,
      int totalCount,
      int knownCount,
      int? minPixels,
      int? maxPixels,
      int maximumCount,
      int minSizeBytes,
      int maxSizeBytes,
      String? recommendedMediaId,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryGroupComparisonState() when $default != null:
        return $default(
          _that.exact,
          _that.totalCount,
          _that.knownCount,
          _that.minPixels,
          _that.maxPixels,
          _that.maximumCount,
          _that.minSizeBytes,
          _that.maxSizeBytes,
          _that.recommendedMediaId,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _GalleryGroupComparisonState extends GalleryGroupComparisonState {
  const _GalleryGroupComparisonState({
    required this.exact,
    required this.totalCount,
    required this.knownCount,
    required this.minPixels,
    required this.maxPixels,
    required this.maximumCount,
    required this.minSizeBytes,
    required this.maxSizeBytes,
    required this.recommendedMediaId,
  }) : super._();

  @override
  final bool exact;
  @override
  final int totalCount;
  @override
  final int knownCount;
  @override
  final int? minPixels;
  @override
  final int? maxPixels;
  @override
  final int maximumCount;
  @override
  final int minSizeBytes;
  @override
  final int maxSizeBytes;
  @override
  final String? recommendedMediaId;

  /// Create a copy of GalleryGroupComparisonState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GalleryGroupComparisonStateCopyWith<_GalleryGroupComparisonState>
  get copyWith =>
      __$GalleryGroupComparisonStateCopyWithImpl<_GalleryGroupComparisonState>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GalleryGroupComparisonState &&
            (identical(other.exact, exact) || other.exact == exact) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.knownCount, knownCount) ||
                other.knownCount == knownCount) &&
            (identical(other.minPixels, minPixels) ||
                other.minPixels == minPixels) &&
            (identical(other.maxPixels, maxPixels) ||
                other.maxPixels == maxPixels) &&
            (identical(other.maximumCount, maximumCount) ||
                other.maximumCount == maximumCount) &&
            (identical(other.minSizeBytes, minSizeBytes) ||
                other.minSizeBytes == minSizeBytes) &&
            (identical(other.maxSizeBytes, maxSizeBytes) ||
                other.maxSizeBytes == maxSizeBytes) &&
            (identical(other.recommendedMediaId, recommendedMediaId) ||
                other.recommendedMediaId == recommendedMediaId));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      exact,
      totalCount,
      knownCount,
      minPixels,
      maxPixels,
      maximumCount,
      minSizeBytes,
      maxSizeBytes,
      recommendedMediaId,
    );
  }

  @override
  String toString() {
    return 'GalleryGroupComparisonState(exact: $exact, totalCount: $totalCount, knownCount: $knownCount, minPixels: $minPixels, maxPixels: $maxPixels, maximumCount: $maximumCount, minSizeBytes: $minSizeBytes, maxSizeBytes: $maxSizeBytes, recommendedMediaId: $recommendedMediaId)';
  }
}

/// @nodoc
abstract mixin class _$GalleryGroupComparisonStateCopyWith<$Res>
    implements $GalleryGroupComparisonStateCopyWith<$Res> {
  factory _$GalleryGroupComparisonStateCopyWith(
    _GalleryGroupComparisonState value,
    $Res Function(_GalleryGroupComparisonState) _then,
  ) = __$GalleryGroupComparisonStateCopyWithImpl;
  @override
  @useResult
  $Res call({
    bool exact,
    int totalCount,
    int knownCount,
    int? minPixels,
    int? maxPixels,
    int maximumCount,
    int minSizeBytes,
    int maxSizeBytes,
    String? recommendedMediaId,
  });
}

/// @nodoc
class __$GalleryGroupComparisonStateCopyWithImpl<$Res>
    implements _$GalleryGroupComparisonStateCopyWith<$Res> {
  __$GalleryGroupComparisonStateCopyWithImpl(this._self, this._then);

  final _GalleryGroupComparisonState _self;
  final $Res Function(_GalleryGroupComparisonState) _then;

  /// Create a copy of GalleryGroupComparisonState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? exact = null,
    Object? totalCount = null,
    Object? knownCount = null,
    Object? minPixels = freezed,
    Object? maxPixels = freezed,
    Object? maximumCount = null,
    Object? minSizeBytes = null,
    Object? maxSizeBytes = null,
    Object? recommendedMediaId = freezed,
  }) {
    return _then(
      _GalleryGroupComparisonState(
        exact: null == exact
            ? _self.exact
            : exact // ignore: cast_nullable_to_non_nullable
                  as bool,
        totalCount: null == totalCount
            ? _self.totalCount
            : totalCount // ignore: cast_nullable_to_non_nullable
                  as int,
        knownCount: null == knownCount
            ? _self.knownCount
            : knownCount // ignore: cast_nullable_to_non_nullable
                  as int,
        minPixels: freezed == minPixels
            ? _self.minPixels
            : minPixels // ignore: cast_nullable_to_non_nullable
                  as int?,
        maxPixels: freezed == maxPixels
            ? _self.maxPixels
            : maxPixels // ignore: cast_nullable_to_non_nullable
                  as int?,
        maximumCount: null == maximumCount
            ? _self.maximumCount
            : maximumCount // ignore: cast_nullable_to_non_nullable
                  as int,
        minSizeBytes: null == minSizeBytes
            ? _self.minSizeBytes
            : minSizeBytes // ignore: cast_nullable_to_non_nullable
                  as int,
        maxSizeBytes: null == maxSizeBytes
            ? _self.maxSizeBytes
            : maxSizeBytes // ignore: cast_nullable_to_non_nullable
                  as int,
        recommendedMediaId: freezed == recommendedMediaId
            ? _self.recommendedMediaId
            : recommendedMediaId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}
