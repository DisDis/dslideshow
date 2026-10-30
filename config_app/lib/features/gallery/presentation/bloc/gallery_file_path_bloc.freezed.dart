// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gallery_file_path_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GalleryFilePathState {
  String get name;
  String? get displayPath;
  List<String> get folders;
  bool get expanded;

  /// Create a copy of GalleryFilePathState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryFilePathStateCopyWith<GalleryFilePathState> get copyWith =>
      _$GalleryFilePathStateCopyWithImpl<GalleryFilePathState>(
        this as GalleryFilePathState,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    final _this = this as GalleryFilePathState;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryFilePathState &&
            (identical(other.name, _this.name) || other.name == _this.name) &&
            (identical(other.displayPath, _this.displayPath) ||
                other.displayPath == _this.displayPath) &&
            const DeepCollectionEquality().equals(
              other.folders,
              _this.folders,
            ) &&
            (identical(other.expanded, _this.expanded) ||
                other.expanded == _this.expanded));
  }

  @override
  int get hashCode {
    final _this = this as GalleryFilePathState;
    return Object.hash(
      runtimeType,
      _this.name,
      _this.displayPath,
      const DeepCollectionEquality().hash(_this.folders),
      _this.expanded,
    );
  }

  @override
  String toString() {
    final _this = this as GalleryFilePathState;
    return 'GalleryFilePathState(name: ${_this.name}, displayPath: ${_this.displayPath}, folders: ${_this.folders}, expanded: ${_this.expanded})';
  }
}

/// @nodoc
abstract mixin class $GalleryFilePathStateCopyWith<$Res> {
  factory $GalleryFilePathStateCopyWith(
    GalleryFilePathState value,
    $Res Function(GalleryFilePathState) _then,
  ) = _$GalleryFilePathStateCopyWithImpl;
  @useResult
  $Res call({
    String name,
    String? displayPath,
    List<String> folders,
    bool expanded,
  });
}

/// @nodoc
class _$GalleryFilePathStateCopyWithImpl<$Res>
    implements $GalleryFilePathStateCopyWith<$Res> {
  _$GalleryFilePathStateCopyWithImpl(this._self, this._then);

  final GalleryFilePathState _self;
  final $Res Function(GalleryFilePathState) _then;

  /// Create a copy of GalleryFilePathState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayPath = freezed,
    Object? folders = null,
    Object? expanded = null,
  }) {
    return _then(
      GalleryFilePathState(
        name: null == name
            ? _self.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        displayPath: freezed == displayPath
            ? _self.displayPath
            : displayPath // ignore: cast_nullable_to_non_nullable
                  as String?,
        folders: null == folders
            ? _self.folders
            : folders // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        expanded: null == expanded
            ? _self.expanded
            : expanded // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [GalleryFilePathState].
extension GalleryFilePathStatePatterns on GalleryFilePathState {
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
    TResult Function(_GalleryFilePathState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryFilePathState() when $default != null:
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
    TResult Function(_GalleryFilePathState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryFilePathState():
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
    TResult? Function(_GalleryFilePathState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryFilePathState() when $default != null:
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
      String name,
      String? displayPath,
      List<String> folders,
      bool expanded,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryFilePathState() when $default != null:
        return $default(
          _that.name,
          _that.displayPath,
          _that.folders,
          _that.expanded,
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
      String name,
      String? displayPath,
      List<String> folders,
      bool expanded,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryFilePathState():
        return $default(
          _that.name,
          _that.displayPath,
          _that.folders,
          _that.expanded,
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
      String name,
      String? displayPath,
      List<String> folders,
      bool expanded,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryFilePathState() when $default != null:
        return $default(
          _that.name,
          _that.displayPath,
          _that.folders,
          _that.expanded,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _GalleryFilePathState implements GalleryFilePathState {
  const _GalleryFilePathState({
    required this.name,
    this.displayPath,
    List<String> folders = const [],
    this.expanded = false,
  }) : _folders = folders;

  @override
  final String name;
  @override
  final String? displayPath;
  final List<String> _folders;
  @override
  @JsonKey()
  List<String> get folders {
    if (_folders is EqualUnmodifiableListView) return _folders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_folders);
  }

  @override
  @JsonKey()
  final bool expanded;

  /// Create a copy of GalleryFilePathState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GalleryFilePathStateCopyWith<_GalleryFilePathState> get copyWith =>
      __$GalleryFilePathStateCopyWithImpl<_GalleryFilePathState>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GalleryFilePathState &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.displayPath, displayPath) ||
                other.displayPath == displayPath) &&
            const DeepCollectionEquality().equals(other.folders, _folders) &&
            (identical(other.expanded, expanded) ||
                other.expanded == expanded));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      name,
      displayPath,
      const DeepCollectionEquality().hash(_folders),
      expanded,
    );
  }

  @override
  String toString() {
    return 'GalleryFilePathState(name: $name, displayPath: $displayPath, folders: $folders, expanded: $expanded)';
  }
}

/// @nodoc
abstract mixin class _$GalleryFilePathStateCopyWith<$Res>
    implements $GalleryFilePathStateCopyWith<$Res> {
  factory _$GalleryFilePathStateCopyWith(
    _GalleryFilePathState value,
    $Res Function(_GalleryFilePathState) _then,
  ) = __$GalleryFilePathStateCopyWithImpl;
  @override
  @useResult
  $Res call({
    String name,
    String? displayPath,
    List<String> folders,
    bool expanded,
  });
}

/// @nodoc
class __$GalleryFilePathStateCopyWithImpl<$Res>
    implements _$GalleryFilePathStateCopyWith<$Res> {
  __$GalleryFilePathStateCopyWithImpl(this._self, this._then);

  final _GalleryFilePathState _self;
  final $Res Function(_GalleryFilePathState) _then;

  /// Create a copy of GalleryFilePathState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? displayPath = freezed,
    Object? folders = null,
    Object? expanded = null,
  }) {
    return _then(
      _GalleryFilePathState(
        name: null == name
            ? _self.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        displayPath: freezed == displayPath
            ? _self.displayPath
            : displayPath // ignore: cast_nullable_to_non_nullable
                  as String?,
        folders: null == folders
            ? _self._folders
            : folders // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        expanded: null == expanded
            ? _self.expanded
            : expanded // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}
