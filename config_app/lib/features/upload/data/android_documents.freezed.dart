// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'android_documents.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AndroidDocumentInfo {
  Uri get uri;
  String get name;
  AndroidDocumentKind get kind;
  int? get size;

  /// Create a copy of AndroidDocumentInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AndroidDocumentInfoCopyWith<AndroidDocumentInfo> get copyWith =>
      _$AndroidDocumentInfoCopyWithImpl<AndroidDocumentInfo>(this as AndroidDocumentInfo, _$identity);

  @override
  bool operator ==(Object other) {
    final _this = this as AndroidDocumentInfo;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AndroidDocumentInfo &&
            (identical(other.uri, _this.uri) || other.uri == _this.uri) &&
            (identical(other.name, _this.name) || other.name == _this.name) &&
            (identical(other.kind, _this.kind) || other.kind == _this.kind) &&
            (identical(other.size, _this.size) || other.size == _this.size));
  }

  @override
  int get hashCode {
    final _this = this as AndroidDocumentInfo;
    return Object.hash(runtimeType, _this.uri, _this.name, _this.kind, _this.size);
  }

  @override
  String toString() {
    final _this = this as AndroidDocumentInfo;
    return 'AndroidDocumentInfo(uri: ${_this.uri}, name: ${_this.name}, kind: ${_this.kind}, size: ${_this.size})';
  }
}

/// @nodoc
abstract mixin class $AndroidDocumentInfoCopyWith<$Res> {
  factory $AndroidDocumentInfoCopyWith(AndroidDocumentInfo value, $Res Function(AndroidDocumentInfo) _then) =
      _$AndroidDocumentInfoCopyWithImpl;
  @useResult
  $Res call({Uri uri, String name, AndroidDocumentKind kind, int? size});
}

/// @nodoc
class _$AndroidDocumentInfoCopyWithImpl<$Res> implements $AndroidDocumentInfoCopyWith<$Res> {
  _$AndroidDocumentInfoCopyWithImpl(this._self, this._then);

  final AndroidDocumentInfo _self;
  final $Res Function(AndroidDocumentInfo) _then;

  /// Create a copy of AndroidDocumentInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? uri = null, Object? name = null, Object? kind = null, Object? size = freezed}) {
    return _then(
      AndroidDocumentInfo(
        uri: null == uri
            ? _self.uri
            : uri // ignore: cast_nullable_to_non_nullable
                  as Uri,
        name: null == name
            ? _self.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        kind: null == kind
            ? _self.kind
            : kind // ignore: cast_nullable_to_non_nullable
                  as AndroidDocumentKind,
        size: freezed == size
            ? _self.size
            : size // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [AndroidDocumentInfo].
extension AndroidDocumentInfoPatterns on AndroidDocumentInfo {
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
    TResult Function(_AndroidDocumentInfo value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AndroidDocumentInfo() when $default != null:
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
  TResult map<TResult extends Object?>(TResult Function(_AndroidDocumentInfo value) $default) {
    final _that = this;
    switch (_that) {
      case _AndroidDocumentInfo():
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
  TResult? mapOrNull<TResult extends Object?>(TResult? Function(_AndroidDocumentInfo value)? $default) {
    final _that = this;
    switch (_that) {
      case _AndroidDocumentInfo() when $default != null:
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
    TResult Function(Uri uri, String name, AndroidDocumentKind kind, int? size)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AndroidDocumentInfo() when $default != null:
        return $default(_that.uri, _that.name, _that.kind, _that.size);
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
    TResult Function(Uri uri, String name, AndroidDocumentKind kind, int? size) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AndroidDocumentInfo():
        return $default(_that.uri, _that.name, _that.kind, _that.size);
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
    TResult? Function(Uri uri, String name, AndroidDocumentKind kind, int? size)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AndroidDocumentInfo() when $default != null:
        return $default(_that.uri, _that.name, _that.kind, _that.size);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _AndroidDocumentInfo implements AndroidDocumentInfo {
  const _AndroidDocumentInfo({required this.uri, required this.name, required this.kind, this.size});

  @override
  final Uri uri;
  @override
  final String name;
  @override
  final AndroidDocumentKind kind;
  @override
  final int? size;

  /// Create a copy of AndroidDocumentInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AndroidDocumentInfoCopyWith<_AndroidDocumentInfo> get copyWith =>
      __$AndroidDocumentInfoCopyWithImpl<_AndroidDocumentInfo>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AndroidDocumentInfo &&
            (identical(other.uri, uri) || other.uri == uri) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.kind, kind) || other.kind == kind) &&
            (identical(other.size, size) || other.size == size));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, uri, name, kind, size);
  }

  @override
  String toString() {
    return 'AndroidDocumentInfo(uri: $uri, name: $name, kind: $kind, size: $size)';
  }
}

/// @nodoc
abstract mixin class _$AndroidDocumentInfoCopyWith<$Res> implements $AndroidDocumentInfoCopyWith<$Res> {
  factory _$AndroidDocumentInfoCopyWith(_AndroidDocumentInfo value, $Res Function(_AndroidDocumentInfo) _then) =
      __$AndroidDocumentInfoCopyWithImpl;
  @override
  @useResult
  $Res call({Uri uri, String name, AndroidDocumentKind kind, int? size});
}

/// @nodoc
class __$AndroidDocumentInfoCopyWithImpl<$Res> implements _$AndroidDocumentInfoCopyWith<$Res> {
  __$AndroidDocumentInfoCopyWithImpl(this._self, this._then);

  final _AndroidDocumentInfo _self;
  final $Res Function(_AndroidDocumentInfo) _then;

  /// Create a copy of AndroidDocumentInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? uri = null, Object? name = null, Object? kind = null, Object? size = freezed}) {
    return _then(
      _AndroidDocumentInfo(
        uri: null == uri
            ? _self.uri
            : uri // ignore: cast_nullable_to_non_nullable
                  as Uri,
        name: null == name
            ? _self.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        kind: null == kind
            ? _self.kind
            : kind // ignore: cast_nullable_to_non_nullable
                  as AndroidDocumentKind,
        size: freezed == size
            ? _self.size
            : size // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}
