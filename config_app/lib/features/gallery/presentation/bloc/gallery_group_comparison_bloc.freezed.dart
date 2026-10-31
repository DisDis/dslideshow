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
mixin _$GalleryComparisonDate {
  DateTime get value;
  GalleryComparisonDateSource get source;

  /// Create a copy of GalleryComparisonDate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryComparisonDateCopyWith<GalleryComparisonDate> get copyWith =>
      _$GalleryComparisonDateCopyWithImpl<GalleryComparisonDate>(
        this as GalleryComparisonDate,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    final _this = this as GalleryComparisonDate;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryComparisonDate &&
            (identical(other.value, _this.value) ||
                other.value == _this.value) &&
            (identical(other.source, _this.source) ||
                other.source == _this.source));
  }

  @override
  int get hashCode {
    final _this = this as GalleryComparisonDate;
    return Object.hash(runtimeType, _this.value, _this.source);
  }

  @override
  String toString() {
    final _this = this as GalleryComparisonDate;
    return 'GalleryComparisonDate(value: ${_this.value}, source: ${_this.source})';
  }
}

/// @nodoc
abstract mixin class $GalleryComparisonDateCopyWith<$Res> {
  factory $GalleryComparisonDateCopyWith(
    GalleryComparisonDate value,
    $Res Function(GalleryComparisonDate) _then,
  ) = _$GalleryComparisonDateCopyWithImpl;
  @useResult
  $Res call({DateTime value, GalleryComparisonDateSource source});
}

/// @nodoc
class _$GalleryComparisonDateCopyWithImpl<$Res>
    implements $GalleryComparisonDateCopyWith<$Res> {
  _$GalleryComparisonDateCopyWithImpl(this._self, this._then);

  final GalleryComparisonDate _self;
  final $Res Function(GalleryComparisonDate) _then;

  /// Create a copy of GalleryComparisonDate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? value = null, Object? source = null}) {
    return _then(
      GalleryComparisonDate(
        value: null == value
            ? _self.value
            : value // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        source: null == source
            ? _self.source
            : source // ignore: cast_nullable_to_non_nullable
                  as GalleryComparisonDateSource,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [GalleryComparisonDate].
extension GalleryComparisonDatePatterns on GalleryComparisonDate {
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
    TResult Function(_GalleryComparisonDate value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryComparisonDate() when $default != null:
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
    TResult Function(_GalleryComparisonDate value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryComparisonDate():
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
    TResult? Function(_GalleryComparisonDate value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryComparisonDate() when $default != null:
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
    TResult Function(DateTime value, GalleryComparisonDateSource source)?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryComparisonDate() when $default != null:
        return $default(_that.value, _that.source);
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
    TResult Function(DateTime value, GalleryComparisonDateSource source)
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryComparisonDate():
        return $default(_that.value, _that.source);
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
    TResult? Function(DateTime value, GalleryComparisonDateSource source)?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryComparisonDate() when $default != null:
        return $default(_that.value, _that.source);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _GalleryComparisonDate implements GalleryComparisonDate {
  const _GalleryComparisonDate({required this.value, required this.source});

  @override
  final DateTime value;
  @override
  final GalleryComparisonDateSource source;

  /// Create a copy of GalleryComparisonDate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GalleryComparisonDateCopyWith<_GalleryComparisonDate> get copyWith =>
      __$GalleryComparisonDateCopyWithImpl<_GalleryComparisonDate>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GalleryComparisonDate &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.source, source) || other.source == source));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, value, source);
  }

  @override
  String toString() {
    return 'GalleryComparisonDate(value: $value, source: $source)';
  }
}

/// @nodoc
abstract mixin class _$GalleryComparisonDateCopyWith<$Res>
    implements $GalleryComparisonDateCopyWith<$Res> {
  factory _$GalleryComparisonDateCopyWith(
    _GalleryComparisonDate value,
    $Res Function(_GalleryComparisonDate) _then,
  ) = __$GalleryComparisonDateCopyWithImpl;
  @override
  @useResult
  $Res call({DateTime value, GalleryComparisonDateSource source});
}

/// @nodoc
class __$GalleryComparisonDateCopyWithImpl<$Res>
    implements _$GalleryComparisonDateCopyWith<$Res> {
  __$GalleryComparisonDateCopyWithImpl(this._self, this._then);

  final _GalleryComparisonDate _self;
  final $Res Function(_GalleryComparisonDate) _then;

  /// Create a copy of GalleryComparisonDate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? value = null, Object? source = null}) {
    return _then(
      _GalleryComparisonDate(
        value: null == value
            ? _self.value
            : value // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        source: null == source
            ? _self.source
            : source // ignore: cast_nullable_to_non_nullable
                  as GalleryComparisonDateSource,
      ),
    );
  }
}

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
mixin _$GalleryMetricAssessment {
  int get knownCount;
  int? get minValue;
  int? get maxValue;
  String? get bestMediaId;
  int get bestCount;
  GalleryMetricDirection get direction;

  /// Create a copy of GalleryMetricAssessment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryMetricAssessmentCopyWith<GalleryMetricAssessment> get copyWith =>
      _$GalleryMetricAssessmentCopyWithImpl<GalleryMetricAssessment>(
        this as GalleryMetricAssessment,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    final _this = this as GalleryMetricAssessment;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryMetricAssessment &&
            (identical(other.knownCount, _this.knownCount) ||
                other.knownCount == _this.knownCount) &&
            (identical(other.minValue, _this.minValue) ||
                other.minValue == _this.minValue) &&
            (identical(other.maxValue, _this.maxValue) ||
                other.maxValue == _this.maxValue) &&
            (identical(other.bestMediaId, _this.bestMediaId) ||
                other.bestMediaId == _this.bestMediaId) &&
            (identical(other.bestCount, _this.bestCount) ||
                other.bestCount == _this.bestCount) &&
            (identical(other.direction, _this.direction) ||
                other.direction == _this.direction));
  }

  @override
  int get hashCode {
    final _this = this as GalleryMetricAssessment;
    return Object.hash(
      runtimeType,
      _this.knownCount,
      _this.minValue,
      _this.maxValue,
      _this.bestMediaId,
      _this.bestCount,
      _this.direction,
    );
  }

  @override
  String toString() {
    final _this = this as GalleryMetricAssessment;
    return 'GalleryMetricAssessment(knownCount: ${_this.knownCount}, minValue: ${_this.minValue}, maxValue: ${_this.maxValue}, bestMediaId: ${_this.bestMediaId}, bestCount: ${_this.bestCount}, direction: ${_this.direction})';
  }
}

/// @nodoc
abstract mixin class $GalleryMetricAssessmentCopyWith<$Res> {
  factory $GalleryMetricAssessmentCopyWith(
    GalleryMetricAssessment value,
    $Res Function(GalleryMetricAssessment) _then,
  ) = _$GalleryMetricAssessmentCopyWithImpl;
  @useResult
  $Res call({
    int knownCount,
    int? minValue,
    int? maxValue,
    String? bestMediaId,
    int bestCount,
    GalleryMetricDirection direction,
  });
}

/// @nodoc
class _$GalleryMetricAssessmentCopyWithImpl<$Res>
    implements $GalleryMetricAssessmentCopyWith<$Res> {
  _$GalleryMetricAssessmentCopyWithImpl(this._self, this._then);

  final GalleryMetricAssessment _self;
  final $Res Function(GalleryMetricAssessment) _then;

  /// Create a copy of GalleryMetricAssessment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? knownCount = null,
    Object? minValue = freezed,
    Object? maxValue = freezed,
    Object? bestMediaId = freezed,
    Object? bestCount = null,
    Object? direction = null,
  }) {
    return _then(
      GalleryMetricAssessment(
        knownCount: null == knownCount
            ? _self.knownCount
            : knownCount // ignore: cast_nullable_to_non_nullable
                  as int,
        minValue: freezed == minValue
            ? _self.minValue
            : minValue // ignore: cast_nullable_to_non_nullable
                  as int?,
        maxValue: freezed == maxValue
            ? _self.maxValue
            : maxValue // ignore: cast_nullable_to_non_nullable
                  as int?,
        bestMediaId: freezed == bestMediaId
            ? _self.bestMediaId
            : bestMediaId // ignore: cast_nullable_to_non_nullable
                  as String?,
        bestCount: null == bestCount
            ? _self.bestCount
            : bestCount // ignore: cast_nullable_to_non_nullable
                  as int,
        direction: null == direction
            ? _self.direction
            : direction // ignore: cast_nullable_to_non_nullable
                  as GalleryMetricDirection,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [GalleryMetricAssessment].
extension GalleryMetricAssessmentPatterns on GalleryMetricAssessment {
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
    TResult Function(_GalleryMetricAssessment value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryMetricAssessment() when $default != null:
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
    TResult Function(_GalleryMetricAssessment value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryMetricAssessment():
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
    TResult? Function(_GalleryMetricAssessment value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryMetricAssessment() when $default != null:
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
      int knownCount,
      int? minValue,
      int? maxValue,
      String? bestMediaId,
      int bestCount,
      GalleryMetricDirection direction,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryMetricAssessment() when $default != null:
        return $default(
          _that.knownCount,
          _that.minValue,
          _that.maxValue,
          _that.bestMediaId,
          _that.bestCount,
          _that.direction,
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
      int knownCount,
      int? minValue,
      int? maxValue,
      String? bestMediaId,
      int bestCount,
      GalleryMetricDirection direction,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryMetricAssessment():
        return $default(
          _that.knownCount,
          _that.minValue,
          _that.maxValue,
          _that.bestMediaId,
          _that.bestCount,
          _that.direction,
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
      int knownCount,
      int? minValue,
      int? maxValue,
      String? bestMediaId,
      int bestCount,
      GalleryMetricDirection direction,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryMetricAssessment() when $default != null:
        return $default(
          _that.knownCount,
          _that.minValue,
          _that.maxValue,
          _that.bestMediaId,
          _that.bestCount,
          _that.direction,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _GalleryMetricAssessment extends GalleryMetricAssessment {
  const _GalleryMetricAssessment({
    this.knownCount = 0,
    this.minValue,
    this.maxValue,
    this.bestMediaId,
    this.bestCount = 0,
    this.direction = GalleryMetricDirection.higher,
  }) : super._();

  @override
  @JsonKey()
  final int knownCount;
  @override
  final int? minValue;
  @override
  final int? maxValue;
  @override
  final String? bestMediaId;
  @override
  @JsonKey()
  final int bestCount;
  @override
  @JsonKey()
  final GalleryMetricDirection direction;

  /// Create a copy of GalleryMetricAssessment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GalleryMetricAssessmentCopyWith<_GalleryMetricAssessment> get copyWith =>
      __$GalleryMetricAssessmentCopyWithImpl<_GalleryMetricAssessment>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GalleryMetricAssessment &&
            (identical(other.knownCount, knownCount) ||
                other.knownCount == knownCount) &&
            (identical(other.minValue, minValue) ||
                other.minValue == minValue) &&
            (identical(other.maxValue, maxValue) ||
                other.maxValue == maxValue) &&
            (identical(other.bestMediaId, bestMediaId) ||
                other.bestMediaId == bestMediaId) &&
            (identical(other.bestCount, bestCount) ||
                other.bestCount == bestCount) &&
            (identical(other.direction, direction) ||
                other.direction == direction));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      knownCount,
      minValue,
      maxValue,
      bestMediaId,
      bestCount,
      direction,
    );
  }

  @override
  String toString() {
    return 'GalleryMetricAssessment(knownCount: $knownCount, minValue: $minValue, maxValue: $maxValue, bestMediaId: $bestMediaId, bestCount: $bestCount, direction: $direction)';
  }
}

/// @nodoc
abstract mixin class _$GalleryMetricAssessmentCopyWith<$Res>
    implements $GalleryMetricAssessmentCopyWith<$Res> {
  factory _$GalleryMetricAssessmentCopyWith(
    _GalleryMetricAssessment value,
    $Res Function(_GalleryMetricAssessment) _then,
  ) = __$GalleryMetricAssessmentCopyWithImpl;
  @override
  @useResult
  $Res call({
    int knownCount,
    int? minValue,
    int? maxValue,
    String? bestMediaId,
    int bestCount,
    GalleryMetricDirection direction,
  });
}

/// @nodoc
class __$GalleryMetricAssessmentCopyWithImpl<$Res>
    implements _$GalleryMetricAssessmentCopyWith<$Res> {
  __$GalleryMetricAssessmentCopyWithImpl(this._self, this._then);

  final _GalleryMetricAssessment _self;
  final $Res Function(_GalleryMetricAssessment) _then;

  /// Create a copy of GalleryMetricAssessment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? knownCount = null,
    Object? minValue = freezed,
    Object? maxValue = freezed,
    Object? bestMediaId = freezed,
    Object? bestCount = null,
    Object? direction = null,
  }) {
    return _then(
      _GalleryMetricAssessment(
        knownCount: null == knownCount
            ? _self.knownCount
            : knownCount // ignore: cast_nullable_to_non_nullable
                  as int,
        minValue: freezed == minValue
            ? _self.minValue
            : minValue // ignore: cast_nullable_to_non_nullable
                  as int?,
        maxValue: freezed == maxValue
            ? _self.maxValue
            : maxValue // ignore: cast_nullable_to_non_nullable
                  as int?,
        bestMediaId: freezed == bestMediaId
            ? _self.bestMediaId
            : bestMediaId // ignore: cast_nullable_to_non_nullable
                  as String?,
        bestCount: null == bestCount
            ? _self.bestCount
            : bestCount // ignore: cast_nullable_to_non_nullable
                  as int,
        direction: null == direction
            ? _self.direction
            : direction // ignore: cast_nullable_to_non_nullable
                  as GalleryMetricDirection,
      ),
    );
  }
}

/// @nodoc
mixin _$GalleryComparisonCandidate {
  String get mediaId;
  int get sizeBytes;
  GalleryImageResolution? get resolution;
  DateTime? get dateTaken;
  DateTime? get fileModified;
  GalleryJpegMetadata? get jpeg;
  bool get metadataLoaded;

  /// Create a copy of GalleryComparisonCandidate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryComparisonCandidateCopyWith<GalleryComparisonCandidate>
  get copyWith =>
      _$GalleryComparisonCandidateCopyWithImpl<GalleryComparisonCandidate>(
        this as GalleryComparisonCandidate,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    final _this = this as GalleryComparisonCandidate;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryComparisonCandidate &&
            (identical(other.mediaId, _this.mediaId) ||
                other.mediaId == _this.mediaId) &&
            (identical(other.sizeBytes, _this.sizeBytes) ||
                other.sizeBytes == _this.sizeBytes) &&
            (identical(other.resolution, _this.resolution) ||
                other.resolution == _this.resolution) &&
            (identical(other.dateTaken, _this.dateTaken) ||
                other.dateTaken == _this.dateTaken) &&
            (identical(other.fileModified, _this.fileModified) ||
                other.fileModified == _this.fileModified) &&
            (identical(other.jpeg, _this.jpeg) || other.jpeg == _this.jpeg) &&
            (identical(other.metadataLoaded, _this.metadataLoaded) ||
                other.metadataLoaded == _this.metadataLoaded));
  }

  @override
  int get hashCode {
    final _this = this as GalleryComparisonCandidate;
    return Object.hash(
      runtimeType,
      _this.mediaId,
      _this.sizeBytes,
      _this.resolution,
      _this.dateTaken,
      _this.fileModified,
      _this.jpeg,
      _this.metadataLoaded,
    );
  }

  @override
  String toString() {
    final _this = this as GalleryComparisonCandidate;
    return 'GalleryComparisonCandidate(mediaId: ${_this.mediaId}, sizeBytes: ${_this.sizeBytes}, resolution: ${_this.resolution}, dateTaken: ${_this.dateTaken}, fileModified: ${_this.fileModified}, jpeg: ${_this.jpeg}, metadataLoaded: ${_this.metadataLoaded})';
  }
}

/// @nodoc
abstract mixin class $GalleryComparisonCandidateCopyWith<$Res> {
  factory $GalleryComparisonCandidateCopyWith(
    GalleryComparisonCandidate value,
    $Res Function(GalleryComparisonCandidate) _then,
  ) = _$GalleryComparisonCandidateCopyWithImpl;
  @useResult
  $Res call({
    String mediaId,
    int sizeBytes,
    GalleryImageResolution? resolution,
    DateTime? dateTaken,
    DateTime? fileModified,
    GalleryJpegMetadata? jpeg,
    bool metadataLoaded,
  });

  $GalleryImageResolutionCopyWith<$Res>? get resolution;
  $GalleryJpegMetadataCopyWith<$Res>? get jpeg;
}

/// @nodoc
class _$GalleryComparisonCandidateCopyWithImpl<$Res>
    implements $GalleryComparisonCandidateCopyWith<$Res> {
  _$GalleryComparisonCandidateCopyWithImpl(this._self, this._then);

  final GalleryComparisonCandidate _self;
  final $Res Function(GalleryComparisonCandidate) _then;

  /// Create a copy of GalleryComparisonCandidate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mediaId = null,
    Object? sizeBytes = null,
    Object? resolution = freezed,
    Object? dateTaken = freezed,
    Object? fileModified = freezed,
    Object? jpeg = freezed,
    Object? metadataLoaded = null,
  }) {
    return _then(
      GalleryComparisonCandidate(
        mediaId: null == mediaId
            ? _self.mediaId
            : mediaId // ignore: cast_nullable_to_non_nullable
                  as String,
        sizeBytes: null == sizeBytes
            ? _self.sizeBytes
            : sizeBytes // ignore: cast_nullable_to_non_nullable
                  as int,
        resolution: freezed == resolution
            ? _self.resolution
            : resolution // ignore: cast_nullable_to_non_nullable
                  as GalleryImageResolution?,
        dateTaken: freezed == dateTaken
            ? _self.dateTaken
            : dateTaken // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        fileModified: freezed == fileModified
            ? _self.fileModified
            : fileModified // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        jpeg: freezed == jpeg
            ? _self.jpeg
            : jpeg // ignore: cast_nullable_to_non_nullable
                  as GalleryJpegMetadata?,
        metadataLoaded: null == metadataLoaded
            ? _self.metadataLoaded
            : metadataLoaded // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }

  /// Create a copy of GalleryComparisonCandidate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryImageResolutionCopyWith<$Res>? get resolution {
    if (_self.resolution == null) {
      return null;
    }

    return $GalleryImageResolutionCopyWith<$Res>(_self.resolution!, (value) {
      return _then(_self.copyWith(resolution: value));
    });
  }

  /// Create a copy of GalleryComparisonCandidate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryJpegMetadataCopyWith<$Res>? get jpeg {
    if (_self.jpeg == null) {
      return null;
    }

    return $GalleryJpegMetadataCopyWith<$Res>(_self.jpeg!, (value) {
      return _then(_self.copyWith(jpeg: value));
    });
  }
}

/// Adds pattern-matching-related methods to [GalleryComparisonCandidate].
extension GalleryComparisonCandidatePatterns on GalleryComparisonCandidate {
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
    TResult Function(_GalleryComparisonCandidate value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryComparisonCandidate() when $default != null:
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
    TResult Function(_GalleryComparisonCandidate value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryComparisonCandidate():
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
    TResult? Function(_GalleryComparisonCandidate value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryComparisonCandidate() when $default != null:
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
      int sizeBytes,
      GalleryImageResolution? resolution,
      DateTime? dateTaken,
      DateTime? fileModified,
      GalleryJpegMetadata? jpeg,
      bool metadataLoaded,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryComparisonCandidate() when $default != null:
        return $default(
          _that.mediaId,
          _that.sizeBytes,
          _that.resolution,
          _that.dateTaken,
          _that.fileModified,
          _that.jpeg,
          _that.metadataLoaded,
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
      int sizeBytes,
      GalleryImageResolution? resolution,
      DateTime? dateTaken,
      DateTime? fileModified,
      GalleryJpegMetadata? jpeg,
      bool metadataLoaded,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryComparisonCandidate():
        return $default(
          _that.mediaId,
          _that.sizeBytes,
          _that.resolution,
          _that.dateTaken,
          _that.fileModified,
          _that.jpeg,
          _that.metadataLoaded,
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
      int sizeBytes,
      GalleryImageResolution? resolution,
      DateTime? dateTaken,
      DateTime? fileModified,
      GalleryJpegMetadata? jpeg,
      bool metadataLoaded,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryComparisonCandidate() when $default != null:
        return $default(
          _that.mediaId,
          _that.sizeBytes,
          _that.resolution,
          _that.dateTaken,
          _that.fileModified,
          _that.jpeg,
          _that.metadataLoaded,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _GalleryComparisonCandidate extends GalleryComparisonCandidate {
  const _GalleryComparisonCandidate({
    required this.mediaId,
    required this.sizeBytes,
    this.resolution,
    this.dateTaken,
    this.fileModified,
    this.jpeg,
    this.metadataLoaded = false,
  }) : super._();

  @override
  final String mediaId;
  @override
  final int sizeBytes;
  @override
  final GalleryImageResolution? resolution;
  @override
  final DateTime? dateTaken;
  @override
  final DateTime? fileModified;
  @override
  final GalleryJpegMetadata? jpeg;
  @override
  @JsonKey()
  final bool metadataLoaded;

  /// Create a copy of GalleryComparisonCandidate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GalleryComparisonCandidateCopyWith<_GalleryComparisonCandidate>
  get copyWith =>
      __$GalleryComparisonCandidateCopyWithImpl<_GalleryComparisonCandidate>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GalleryComparisonCandidate &&
            (identical(other.mediaId, mediaId) || other.mediaId == mediaId) &&
            (identical(other.sizeBytes, sizeBytes) ||
                other.sizeBytes == sizeBytes) &&
            (identical(other.resolution, resolution) ||
                other.resolution == resolution) &&
            (identical(other.dateTaken, dateTaken) ||
                other.dateTaken == dateTaken) &&
            (identical(other.fileModified, fileModified) ||
                other.fileModified == fileModified) &&
            (identical(other.jpeg, jpeg) || other.jpeg == jpeg) &&
            (identical(other.metadataLoaded, metadataLoaded) ||
                other.metadataLoaded == metadataLoaded));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      mediaId,
      sizeBytes,
      resolution,
      dateTaken,
      fileModified,
      jpeg,
      metadataLoaded,
    );
  }

  @override
  String toString() {
    return 'GalleryComparisonCandidate(mediaId: $mediaId, sizeBytes: $sizeBytes, resolution: $resolution, dateTaken: $dateTaken, fileModified: $fileModified, jpeg: $jpeg, metadataLoaded: $metadataLoaded)';
  }
}

/// @nodoc
abstract mixin class _$GalleryComparisonCandidateCopyWith<$Res>
    implements $GalleryComparisonCandidateCopyWith<$Res> {
  factory _$GalleryComparisonCandidateCopyWith(
    _GalleryComparisonCandidate value,
    $Res Function(_GalleryComparisonCandidate) _then,
  ) = __$GalleryComparisonCandidateCopyWithImpl;
  @override
  @useResult
  $Res call({
    String mediaId,
    int sizeBytes,
    GalleryImageResolution? resolution,
    DateTime? dateTaken,
    DateTime? fileModified,
    GalleryJpegMetadata? jpeg,
    bool metadataLoaded,
  });

  @override
  $GalleryImageResolutionCopyWith<$Res>? get resolution;
  @override
  $GalleryJpegMetadataCopyWith<$Res>? get jpeg;
}

/// @nodoc
class __$GalleryComparisonCandidateCopyWithImpl<$Res>
    implements _$GalleryComparisonCandidateCopyWith<$Res> {
  __$GalleryComparisonCandidateCopyWithImpl(this._self, this._then);

  final _GalleryComparisonCandidate _self;
  final $Res Function(_GalleryComparisonCandidate) _then;

  /// Create a copy of GalleryComparisonCandidate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? mediaId = null,
    Object? sizeBytes = null,
    Object? resolution = freezed,
    Object? dateTaken = freezed,
    Object? fileModified = freezed,
    Object? jpeg = freezed,
    Object? metadataLoaded = null,
  }) {
    return _then(
      _GalleryComparisonCandidate(
        mediaId: null == mediaId
            ? _self.mediaId
            : mediaId // ignore: cast_nullable_to_non_nullable
                  as String,
        sizeBytes: null == sizeBytes
            ? _self.sizeBytes
            : sizeBytes // ignore: cast_nullable_to_non_nullable
                  as int,
        resolution: freezed == resolution
            ? _self.resolution
            : resolution // ignore: cast_nullable_to_non_nullable
                  as GalleryImageResolution?,
        dateTaken: freezed == dateTaken
            ? _self.dateTaken
            : dateTaken // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        fileModified: freezed == fileModified
            ? _self.fileModified
            : fileModified // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        jpeg: freezed == jpeg
            ? _self.jpeg
            : jpeg // ignore: cast_nullable_to_non_nullable
                  as GalleryJpegMetadata?,
        metadataLoaded: null == metadataLoaded
            ? _self.metadataLoaded
            : metadataLoaded // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }

  /// Create a copy of GalleryComparisonCandidate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryImageResolutionCopyWith<$Res>? get resolution {
    if (_self.resolution == null) {
      return null;
    }

    return $GalleryImageResolutionCopyWith<$Res>(_self.resolution!, (value) {
      return _then(_self.copyWith(resolution: value));
    });
  }

  /// Create a copy of GalleryComparisonCandidate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryJpegMetadataCopyWith<$Res>? get jpeg {
    if (_self.jpeg == null) {
      return null;
    }

    return $GalleryJpegMetadataCopyWith<$Res>(_self.jpeg!, (value) {
      return _then(_self.copyWith(jpeg: value));
    });
  }
}

/// @nodoc
mixin _$GalleryGroupComparisonState {
  bool get exact;
  int get totalCount;
  int get metadataCount;
  int get knownDateCount;
  GalleryMetricAssessment get resolution;
  GalleryMetricAssessment get jpegQuality;
  GalleryMetricAssessment get jpegSize;
  GalleryMetricAssessment get dateTaken;
  GalleryMetricAssessment get fileModified;
  String? get recommendedMediaId;
  GalleryComparisonDate? get recommendedDate;
  GalleryRecommendationReason get reason;

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
            (identical(other.metadataCount, _this.metadataCount) ||
                other.metadataCount == _this.metadataCount) &&
            (identical(other.knownDateCount, _this.knownDateCount) ||
                other.knownDateCount == _this.knownDateCount) &&
            (identical(other.resolution, _this.resolution) ||
                other.resolution == _this.resolution) &&
            (identical(other.jpegQuality, _this.jpegQuality) ||
                other.jpegQuality == _this.jpegQuality) &&
            (identical(other.jpegSize, _this.jpegSize) ||
                other.jpegSize == _this.jpegSize) &&
            (identical(other.dateTaken, _this.dateTaken) ||
                other.dateTaken == _this.dateTaken) &&
            (identical(other.fileModified, _this.fileModified) ||
                other.fileModified == _this.fileModified) &&
            (identical(other.recommendedMediaId, _this.recommendedMediaId) ||
                other.recommendedMediaId == _this.recommendedMediaId) &&
            (identical(other.recommendedDate, _this.recommendedDate) ||
                other.recommendedDate == _this.recommendedDate) &&
            (identical(other.reason, _this.reason) ||
                other.reason == _this.reason));
  }

  @override
  int get hashCode {
    final _this = this as GalleryGroupComparisonState;
    return Object.hash(
      runtimeType,
      _this.exact,
      _this.totalCount,
      _this.metadataCount,
      _this.knownDateCount,
      _this.resolution,
      _this.jpegQuality,
      _this.jpegSize,
      _this.dateTaken,
      _this.fileModified,
      _this.recommendedMediaId,
      _this.recommendedDate,
      _this.reason,
    );
  }

  @override
  String toString() {
    final _this = this as GalleryGroupComparisonState;
    return 'GalleryGroupComparisonState(exact: ${_this.exact}, totalCount: ${_this.totalCount}, metadataCount: ${_this.metadataCount}, knownDateCount: ${_this.knownDateCount}, resolution: ${_this.resolution}, jpegQuality: ${_this.jpegQuality}, jpegSize: ${_this.jpegSize}, dateTaken: ${_this.dateTaken}, fileModified: ${_this.fileModified}, recommendedMediaId: ${_this.recommendedMediaId}, recommendedDate: ${_this.recommendedDate}, reason: ${_this.reason})';
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
    int metadataCount,
    int knownDateCount,
    GalleryMetricAssessment resolution,
    GalleryMetricAssessment jpegQuality,
    GalleryMetricAssessment jpegSize,
    GalleryMetricAssessment dateTaken,
    GalleryMetricAssessment fileModified,
    String? recommendedMediaId,
    GalleryComparisonDate? recommendedDate,
    GalleryRecommendationReason reason,
  });

  $GalleryMetricAssessmentCopyWith<$Res> get resolution;
  $GalleryMetricAssessmentCopyWith<$Res> get jpegQuality;
  $GalleryMetricAssessmentCopyWith<$Res> get jpegSize;
  $GalleryMetricAssessmentCopyWith<$Res> get dateTaken;
  $GalleryMetricAssessmentCopyWith<$Res> get fileModified;
  $GalleryComparisonDateCopyWith<$Res>? get recommendedDate;
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
    Object? metadataCount = null,
    Object? knownDateCount = null,
    Object? resolution = null,
    Object? jpegQuality = null,
    Object? jpegSize = null,
    Object? dateTaken = null,
    Object? fileModified = null,
    Object? recommendedMediaId = freezed,
    Object? recommendedDate = freezed,
    Object? reason = null,
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
        metadataCount: null == metadataCount
            ? _self.metadataCount
            : metadataCount // ignore: cast_nullable_to_non_nullable
                  as int,
        knownDateCount: null == knownDateCount
            ? _self.knownDateCount
            : knownDateCount // ignore: cast_nullable_to_non_nullable
                  as int,
        resolution: null == resolution
            ? _self.resolution
            : resolution // ignore: cast_nullable_to_non_nullable
                  as GalleryMetricAssessment,
        jpegQuality: null == jpegQuality
            ? _self.jpegQuality
            : jpegQuality // ignore: cast_nullable_to_non_nullable
                  as GalleryMetricAssessment,
        jpegSize: null == jpegSize
            ? _self.jpegSize
            : jpegSize // ignore: cast_nullable_to_non_nullable
                  as GalleryMetricAssessment,
        dateTaken: null == dateTaken
            ? _self.dateTaken
            : dateTaken // ignore: cast_nullable_to_non_nullable
                  as GalleryMetricAssessment,
        fileModified: null == fileModified
            ? _self.fileModified
            : fileModified // ignore: cast_nullable_to_non_nullable
                  as GalleryMetricAssessment,
        recommendedMediaId: freezed == recommendedMediaId
            ? _self.recommendedMediaId
            : recommendedMediaId // ignore: cast_nullable_to_non_nullable
                  as String?,
        recommendedDate: freezed == recommendedDate
            ? _self.recommendedDate
            : recommendedDate // ignore: cast_nullable_to_non_nullable
                  as GalleryComparisonDate?,
        reason: null == reason
            ? _self.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as GalleryRecommendationReason,
      ),
    );
  }

  /// Create a copy of GalleryGroupComparisonState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryMetricAssessmentCopyWith<$Res> get resolution {
    return $GalleryMetricAssessmentCopyWith<$Res>(_self.resolution, (value) {
      return _then(_self.copyWith(resolution: value));
    });
  }

  /// Create a copy of GalleryGroupComparisonState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryMetricAssessmentCopyWith<$Res> get jpegQuality {
    return $GalleryMetricAssessmentCopyWith<$Res>(_self.jpegQuality, (value) {
      return _then(_self.copyWith(jpegQuality: value));
    });
  }

  /// Create a copy of GalleryGroupComparisonState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryMetricAssessmentCopyWith<$Res> get jpegSize {
    return $GalleryMetricAssessmentCopyWith<$Res>(_self.jpegSize, (value) {
      return _then(_self.copyWith(jpegSize: value));
    });
  }

  /// Create a copy of GalleryGroupComparisonState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryMetricAssessmentCopyWith<$Res> get dateTaken {
    return $GalleryMetricAssessmentCopyWith<$Res>(_self.dateTaken, (value) {
      return _then(_self.copyWith(dateTaken: value));
    });
  }

  /// Create a copy of GalleryGroupComparisonState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryMetricAssessmentCopyWith<$Res> get fileModified {
    return $GalleryMetricAssessmentCopyWith<$Res>(_self.fileModified, (value) {
      return _then(_self.copyWith(fileModified: value));
    });
  }

  /// Create a copy of GalleryGroupComparisonState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryComparisonDateCopyWith<$Res>? get recommendedDate {
    if (_self.recommendedDate == null) {
      return null;
    }

    return $GalleryComparisonDateCopyWith<$Res>(_self.recommendedDate!, (
      value,
    ) {
      return _then(_self.copyWith(recommendedDate: value));
    });
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
      int metadataCount,
      int knownDateCount,
      GalleryMetricAssessment resolution,
      GalleryMetricAssessment jpegQuality,
      GalleryMetricAssessment jpegSize,
      GalleryMetricAssessment dateTaken,
      GalleryMetricAssessment fileModified,
      String? recommendedMediaId,
      GalleryComparisonDate? recommendedDate,
      GalleryRecommendationReason reason,
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
          _that.metadataCount,
          _that.knownDateCount,
          _that.resolution,
          _that.jpegQuality,
          _that.jpegSize,
          _that.dateTaken,
          _that.fileModified,
          _that.recommendedMediaId,
          _that.recommendedDate,
          _that.reason,
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
      int metadataCount,
      int knownDateCount,
      GalleryMetricAssessment resolution,
      GalleryMetricAssessment jpegQuality,
      GalleryMetricAssessment jpegSize,
      GalleryMetricAssessment dateTaken,
      GalleryMetricAssessment fileModified,
      String? recommendedMediaId,
      GalleryComparisonDate? recommendedDate,
      GalleryRecommendationReason reason,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryGroupComparisonState():
        return $default(
          _that.exact,
          _that.totalCount,
          _that.metadataCount,
          _that.knownDateCount,
          _that.resolution,
          _that.jpegQuality,
          _that.jpegSize,
          _that.dateTaken,
          _that.fileModified,
          _that.recommendedMediaId,
          _that.recommendedDate,
          _that.reason,
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
      int metadataCount,
      int knownDateCount,
      GalleryMetricAssessment resolution,
      GalleryMetricAssessment jpegQuality,
      GalleryMetricAssessment jpegSize,
      GalleryMetricAssessment dateTaken,
      GalleryMetricAssessment fileModified,
      String? recommendedMediaId,
      GalleryComparisonDate? recommendedDate,
      GalleryRecommendationReason reason,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryGroupComparisonState() when $default != null:
        return $default(
          _that.exact,
          _that.totalCount,
          _that.metadataCount,
          _that.knownDateCount,
          _that.resolution,
          _that.jpegQuality,
          _that.jpegSize,
          _that.dateTaken,
          _that.fileModified,
          _that.recommendedMediaId,
          _that.recommendedDate,
          _that.reason,
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
    this.metadataCount = 0,
    this.knownDateCount = 0,
    this.resolution = const GalleryMetricAssessment(),
    this.jpegQuality = const GalleryMetricAssessment(),
    this.jpegSize = const GalleryMetricAssessment(),
    this.dateTaken = const GalleryMetricAssessment(
      direction: GalleryMetricDirection.lower,
    ),
    this.fileModified = const GalleryMetricAssessment(
      direction: GalleryMetricDirection.lower,
    ),
    this.recommendedMediaId,
    this.recommendedDate,
    this.reason = GalleryRecommendationReason.firstUnknown,
  }) : super._();

  @override
  final bool exact;
  @override
  final int totalCount;
  @override
  @JsonKey()
  final int metadataCount;
  @override
  @JsonKey()
  final int knownDateCount;
  @override
  @JsonKey()
  final GalleryMetricAssessment resolution;
  @override
  @JsonKey()
  final GalleryMetricAssessment jpegQuality;
  @override
  @JsonKey()
  final GalleryMetricAssessment jpegSize;
  @override
  @JsonKey()
  final GalleryMetricAssessment dateTaken;
  @override
  @JsonKey()
  final GalleryMetricAssessment fileModified;
  @override
  final String? recommendedMediaId;
  @override
  final GalleryComparisonDate? recommendedDate;
  @override
  @JsonKey()
  final GalleryRecommendationReason reason;

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
            (identical(other.metadataCount, metadataCount) ||
                other.metadataCount == metadataCount) &&
            (identical(other.knownDateCount, knownDateCount) ||
                other.knownDateCount == knownDateCount) &&
            (identical(other.resolution, resolution) ||
                other.resolution == resolution) &&
            (identical(other.jpegQuality, jpegQuality) ||
                other.jpegQuality == jpegQuality) &&
            (identical(other.jpegSize, jpegSize) ||
                other.jpegSize == jpegSize) &&
            (identical(other.dateTaken, dateTaken) ||
                other.dateTaken == dateTaken) &&
            (identical(other.fileModified, fileModified) ||
                other.fileModified == fileModified) &&
            (identical(other.recommendedMediaId, recommendedMediaId) ||
                other.recommendedMediaId == recommendedMediaId) &&
            (identical(other.recommendedDate, recommendedDate) ||
                other.recommendedDate == recommendedDate) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      exact,
      totalCount,
      metadataCount,
      knownDateCount,
      resolution,
      jpegQuality,
      jpegSize,
      dateTaken,
      fileModified,
      recommendedMediaId,
      recommendedDate,
      reason,
    );
  }

  @override
  String toString() {
    return 'GalleryGroupComparisonState(exact: $exact, totalCount: $totalCount, metadataCount: $metadataCount, knownDateCount: $knownDateCount, resolution: $resolution, jpegQuality: $jpegQuality, jpegSize: $jpegSize, dateTaken: $dateTaken, fileModified: $fileModified, recommendedMediaId: $recommendedMediaId, recommendedDate: $recommendedDate, reason: $reason)';
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
    int metadataCount,
    int knownDateCount,
    GalleryMetricAssessment resolution,
    GalleryMetricAssessment jpegQuality,
    GalleryMetricAssessment jpegSize,
    GalleryMetricAssessment dateTaken,
    GalleryMetricAssessment fileModified,
    String? recommendedMediaId,
    GalleryComparisonDate? recommendedDate,
    GalleryRecommendationReason reason,
  });

  @override
  $GalleryMetricAssessmentCopyWith<$Res> get resolution;
  @override
  $GalleryMetricAssessmentCopyWith<$Res> get jpegQuality;
  @override
  $GalleryMetricAssessmentCopyWith<$Res> get jpegSize;
  @override
  $GalleryMetricAssessmentCopyWith<$Res> get dateTaken;
  @override
  $GalleryMetricAssessmentCopyWith<$Res> get fileModified;
  @override
  $GalleryComparisonDateCopyWith<$Res>? get recommendedDate;
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
    Object? metadataCount = null,
    Object? knownDateCount = null,
    Object? resolution = null,
    Object? jpegQuality = null,
    Object? jpegSize = null,
    Object? dateTaken = null,
    Object? fileModified = null,
    Object? recommendedMediaId = freezed,
    Object? recommendedDate = freezed,
    Object? reason = null,
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
        metadataCount: null == metadataCount
            ? _self.metadataCount
            : metadataCount // ignore: cast_nullable_to_non_nullable
                  as int,
        knownDateCount: null == knownDateCount
            ? _self.knownDateCount
            : knownDateCount // ignore: cast_nullable_to_non_nullable
                  as int,
        resolution: null == resolution
            ? _self.resolution
            : resolution // ignore: cast_nullable_to_non_nullable
                  as GalleryMetricAssessment,
        jpegQuality: null == jpegQuality
            ? _self.jpegQuality
            : jpegQuality // ignore: cast_nullable_to_non_nullable
                  as GalleryMetricAssessment,
        jpegSize: null == jpegSize
            ? _self.jpegSize
            : jpegSize // ignore: cast_nullable_to_non_nullable
                  as GalleryMetricAssessment,
        dateTaken: null == dateTaken
            ? _self.dateTaken
            : dateTaken // ignore: cast_nullable_to_non_nullable
                  as GalleryMetricAssessment,
        fileModified: null == fileModified
            ? _self.fileModified
            : fileModified // ignore: cast_nullable_to_non_nullable
                  as GalleryMetricAssessment,
        recommendedMediaId: freezed == recommendedMediaId
            ? _self.recommendedMediaId
            : recommendedMediaId // ignore: cast_nullable_to_non_nullable
                  as String?,
        recommendedDate: freezed == recommendedDate
            ? _self.recommendedDate
            : recommendedDate // ignore: cast_nullable_to_non_nullable
                  as GalleryComparisonDate?,
        reason: null == reason
            ? _self.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as GalleryRecommendationReason,
      ),
    );
  }

  /// Create a copy of GalleryGroupComparisonState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryMetricAssessmentCopyWith<$Res> get resolution {
    return $GalleryMetricAssessmentCopyWith<$Res>(_self.resolution, (value) {
      return _then(_self.copyWith(resolution: value));
    });
  }

  /// Create a copy of GalleryGroupComparisonState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryMetricAssessmentCopyWith<$Res> get jpegQuality {
    return $GalleryMetricAssessmentCopyWith<$Res>(_self.jpegQuality, (value) {
      return _then(_self.copyWith(jpegQuality: value));
    });
  }

  /// Create a copy of GalleryGroupComparisonState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryMetricAssessmentCopyWith<$Res> get jpegSize {
    return $GalleryMetricAssessmentCopyWith<$Res>(_self.jpegSize, (value) {
      return _then(_self.copyWith(jpegSize: value));
    });
  }

  /// Create a copy of GalleryGroupComparisonState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryMetricAssessmentCopyWith<$Res> get dateTaken {
    return $GalleryMetricAssessmentCopyWith<$Res>(_self.dateTaken, (value) {
      return _then(_self.copyWith(dateTaken: value));
    });
  }

  /// Create a copy of GalleryGroupComparisonState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryMetricAssessmentCopyWith<$Res> get fileModified {
    return $GalleryMetricAssessmentCopyWith<$Res>(_self.fileModified, (value) {
      return _then(_self.copyWith(fileModified: value));
    });
  }

  /// Create a copy of GalleryGroupComparisonState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GalleryComparisonDateCopyWith<$Res>? get recommendedDate {
    if (_self.recommendedDate == null) {
      return null;
    }

    return $GalleryComparisonDateCopyWith<$Res>(_self.recommendedDate!, (
      value,
    ) {
      return _then(_self.copyWith(recommendedDate: value));
    });
  }
}
