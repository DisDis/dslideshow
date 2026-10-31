// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gallery_catalog.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GalleryMediaRef {
  String get mediaId;
  String get sourceRevision;
  @JsonKey(required: true, disallowNullValue: true)
  GalleryMediaSection get section;

  /// Create a copy of GalleryMediaRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryMediaRefCopyWith<GalleryMediaRef> get copyWith =>
      _$GalleryMediaRefCopyWithImpl<GalleryMediaRef>(
        this as GalleryMediaRef,
        _$identity,
      );

  /// Serializes this GalleryMediaRef to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as GalleryMediaRef;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryMediaRef &&
            (identical(other.mediaId, _this.mediaId) ||
                other.mediaId == _this.mediaId) &&
            (identical(other.sourceRevision, _this.sourceRevision) ||
                other.sourceRevision == _this.sourceRevision) &&
            (identical(other.section, _this.section) ||
                other.section == _this.section));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as GalleryMediaRef;
    return Object.hash(
      runtimeType,
      _this.mediaId,
      _this.sourceRevision,
      _this.section,
    );
  }

  @override
  String toString() {
    final _this = this as GalleryMediaRef;
    return 'GalleryMediaRef(mediaId: ${_this.mediaId}, sourceRevision: ${_this.sourceRevision}, section: ${_this.section})';
  }
}

/// @nodoc
abstract mixin class $GalleryMediaRefCopyWith<$Res> {
  factory $GalleryMediaRefCopyWith(
    GalleryMediaRef value,
    $Res Function(GalleryMediaRef) _then,
  ) = _$GalleryMediaRefCopyWithImpl;
  @useResult
  $Res call({
    String mediaId,
    String sourceRevision,
    @JsonKey(required: true, disallowNullValue: true)
    GalleryMediaSection section,
  });
}

/// @nodoc
class _$GalleryMediaRefCopyWithImpl<$Res>
    implements $GalleryMediaRefCopyWith<$Res> {
  _$GalleryMediaRefCopyWithImpl(this._self, this._then);

  final GalleryMediaRef _self;
  final $Res Function(GalleryMediaRef) _then;

  /// Create a copy of GalleryMediaRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mediaId = null,
    Object? sourceRevision = null,
    Object? section = null,
  }) {
    return _then(
      GalleryMediaRef(
        mediaId: null == mediaId
            ? _self.mediaId
            : mediaId // ignore: cast_nullable_to_non_nullable
                  as String,
        sourceRevision: null == sourceRevision
            ? _self.sourceRevision
            : sourceRevision // ignore: cast_nullable_to_non_nullable
                  as String,
        section: null == section
            ? _self.section
            : section // ignore: cast_nullable_to_non_nullable
                  as GalleryMediaSection,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [GalleryMediaRef].
extension GalleryMediaRefPatterns on GalleryMediaRef {
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
    TResult Function(_GalleryMediaRef value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryMediaRef() when $default != null:
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
    TResult Function(_GalleryMediaRef value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryMediaRef():
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
    TResult? Function(_GalleryMediaRef value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryMediaRef() when $default != null:
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
      @JsonKey(required: true, disallowNullValue: true)
      GalleryMediaSection section,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryMediaRef() when $default != null:
        return $default(_that.mediaId, _that.sourceRevision, _that.section);
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
      @JsonKey(required: true, disallowNullValue: true)
      GalleryMediaSection section,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryMediaRef():
        return $default(_that.mediaId, _that.sourceRevision, _that.section);
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
      @JsonKey(required: true, disallowNullValue: true)
      GalleryMediaSection section,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryMediaRef() when $default != null:
        return $default(_that.mediaId, _that.sourceRevision, _that.section);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _GalleryMediaRef implements GalleryMediaRef {
  const _GalleryMediaRef({
    required this.mediaId,
    required this.sourceRevision,
    @JsonKey(required: true, disallowNullValue: true) required this.section,
  });
  factory _GalleryMediaRef.fromJson(Map<String, dynamic> json) =>
      _$GalleryMediaRefFromJson(json);

  @override
  final String mediaId;
  @override
  final String sourceRevision;
  @override
  @JsonKey(required: true, disallowNullValue: true)
  final GalleryMediaSection section;

  /// Create a copy of GalleryMediaRef
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GalleryMediaRefCopyWith<_GalleryMediaRef> get copyWith =>
      __$GalleryMediaRefCopyWithImpl<_GalleryMediaRef>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$GalleryMediaRefToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GalleryMediaRef &&
            (identical(other.mediaId, mediaId) || other.mediaId == mediaId) &&
            (identical(other.sourceRevision, sourceRevision) ||
                other.sourceRevision == sourceRevision) &&
            (identical(other.section, section) || other.section == section));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(runtimeType, mediaId, sourceRevision, section);
  }

  @override
  String toString() {
    return 'GalleryMediaRef(mediaId: $mediaId, sourceRevision: $sourceRevision, section: $section)';
  }
}

/// @nodoc
abstract mixin class _$GalleryMediaRefCopyWith<$Res>
    implements $GalleryMediaRefCopyWith<$Res> {
  factory _$GalleryMediaRefCopyWith(
    _GalleryMediaRef value,
    $Res Function(_GalleryMediaRef) _then,
  ) = __$GalleryMediaRefCopyWithImpl;
  @override
  @useResult
  $Res call({
    String mediaId,
    String sourceRevision,
    @JsonKey(required: true, disallowNullValue: true)
    GalleryMediaSection section,
  });
}

/// @nodoc
class __$GalleryMediaRefCopyWithImpl<$Res>
    implements _$GalleryMediaRefCopyWith<$Res> {
  __$GalleryMediaRefCopyWithImpl(this._self, this._then);

  final _GalleryMediaRef _self;
  final $Res Function(_GalleryMediaRef) _then;

  /// Create a copy of GalleryMediaRef
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? mediaId = null,
    Object? sourceRevision = null,
    Object? section = null,
  }) {
    return _then(
      _GalleryMediaRef(
        mediaId: null == mediaId
            ? _self.mediaId
            : mediaId // ignore: cast_nullable_to_non_nullable
                  as String,
        sourceRevision: null == sourceRevision
            ? _self.sourceRevision
            : sourceRevision // ignore: cast_nullable_to_non_nullable
                  as String,
        section: null == section
            ? _self.section
            : section // ignore: cast_nullable_to_non_nullable
                  as GalleryMediaSection,
      ),
    );
  }
}

/// @nodoc
mixin _$GalleryEntry {
  String get mediaId;
  String get path;
  String get name;
  @JsonKey(unknownEnumValue: GalleryEntryKind.unknown)
  GalleryEntryKind get kind;
  String get sourceRevision;
  @JsonKey(required: true, disallowNullValue: true)
  GalleryMediaSection get section;
  bool get thumbnailSupported;
  @JsonKey(includeIfNull: false)
  int? get sizeBytes;
  @JsonKey(includeIfNull: false)
  DateTime? get fileChanged;

  /// Create a copy of GalleryEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryEntryCopyWith<GalleryEntry> get copyWith =>
      _$GalleryEntryCopyWithImpl<GalleryEntry>(
        this as GalleryEntry,
        _$identity,
      );

  /// Serializes this GalleryEntry to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as GalleryEntry;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryEntry &&
            (identical(other.mediaId, _this.mediaId) ||
                other.mediaId == _this.mediaId) &&
            (identical(other.path, _this.path) || other.path == _this.path) &&
            (identical(other.name, _this.name) || other.name == _this.name) &&
            (identical(other.kind, _this.kind) || other.kind == _this.kind) &&
            (identical(other.sourceRevision, _this.sourceRevision) ||
                other.sourceRevision == _this.sourceRevision) &&
            (identical(other.section, _this.section) ||
                other.section == _this.section) &&
            (identical(other.thumbnailSupported, _this.thumbnailSupported) ||
                other.thumbnailSupported == _this.thumbnailSupported) &&
            (identical(other.sizeBytes, _this.sizeBytes) ||
                other.sizeBytes == _this.sizeBytes) &&
            (identical(other.fileChanged, _this.fileChanged) ||
                other.fileChanged == _this.fileChanged));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as GalleryEntry;
    return Object.hash(
      runtimeType,
      _this.mediaId,
      _this.path,
      _this.name,
      _this.kind,
      _this.sourceRevision,
      _this.section,
      _this.thumbnailSupported,
      _this.sizeBytes,
      _this.fileChanged,
    );
  }

  @override
  String toString() {
    final _this = this as GalleryEntry;
    return 'GalleryEntry(mediaId: ${_this.mediaId}, path: ${_this.path}, name: ${_this.name}, kind: ${_this.kind}, sourceRevision: ${_this.sourceRevision}, section: ${_this.section}, thumbnailSupported: ${_this.thumbnailSupported}, sizeBytes: ${_this.sizeBytes}, fileChanged: ${_this.fileChanged})';
  }
}

/// @nodoc
abstract mixin class $GalleryEntryCopyWith<$Res> {
  factory $GalleryEntryCopyWith(
    GalleryEntry value,
    $Res Function(GalleryEntry) _then,
  ) = _$GalleryEntryCopyWithImpl;
  @useResult
  $Res call({
    String mediaId,
    String path,
    String name,
    @JsonKey(unknownEnumValue: GalleryEntryKind.unknown) GalleryEntryKind kind,
    String sourceRevision,
    @JsonKey(required: true, disallowNullValue: true)
    GalleryMediaSection section,
    bool thumbnailSupported,
    @JsonKey(includeIfNull: false) int? sizeBytes,
    @JsonKey(includeIfNull: false) DateTime? fileChanged,
  });
}

/// @nodoc
class _$GalleryEntryCopyWithImpl<$Res> implements $GalleryEntryCopyWith<$Res> {
  _$GalleryEntryCopyWithImpl(this._self, this._then);

  final GalleryEntry _self;
  final $Res Function(GalleryEntry) _then;

  /// Create a copy of GalleryEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mediaId = null,
    Object? path = null,
    Object? name = null,
    Object? kind = null,
    Object? sourceRevision = null,
    Object? section = null,
    Object? thumbnailSupported = null,
    Object? sizeBytes = freezed,
    Object? fileChanged = freezed,
  }) {
    return _then(
      GalleryEntry(
        mediaId: null == mediaId
            ? _self.mediaId
            : mediaId // ignore: cast_nullable_to_non_nullable
                  as String,
        path: null == path
            ? _self.path
            : path // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _self.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        kind: null == kind
            ? _self.kind
            : kind // ignore: cast_nullable_to_non_nullable
                  as GalleryEntryKind,
        sourceRevision: null == sourceRevision
            ? _self.sourceRevision
            : sourceRevision // ignore: cast_nullable_to_non_nullable
                  as String,
        section: null == section
            ? _self.section
            : section // ignore: cast_nullable_to_non_nullable
                  as GalleryMediaSection,
        thumbnailSupported: null == thumbnailSupported
            ? _self.thumbnailSupported
            : thumbnailSupported // ignore: cast_nullable_to_non_nullable
                  as bool,
        sizeBytes: freezed == sizeBytes
            ? _self.sizeBytes
            : sizeBytes // ignore: cast_nullable_to_non_nullable
                  as int?,
        fileChanged: freezed == fileChanged
            ? _self.fileChanged
            : fileChanged // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [GalleryEntry].
extension GalleryEntryPatterns on GalleryEntry {
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
    TResult Function(_GalleryEntry value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryEntry() when $default != null:
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
    TResult Function(_GalleryEntry value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryEntry():
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
    TResult? Function(_GalleryEntry value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryEntry() when $default != null:
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
      String path,
      String name,
      @JsonKey(unknownEnumValue: GalleryEntryKind.unknown)
      GalleryEntryKind kind,
      String sourceRevision,
      @JsonKey(required: true, disallowNullValue: true)
      GalleryMediaSection section,
      bool thumbnailSupported,
      @JsonKey(includeIfNull: false) int? sizeBytes,
      @JsonKey(includeIfNull: false) DateTime? fileChanged,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryEntry() when $default != null:
        return $default(
          _that.mediaId,
          _that.path,
          _that.name,
          _that.kind,
          _that.sourceRevision,
          _that.section,
          _that.thumbnailSupported,
          _that.sizeBytes,
          _that.fileChanged,
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
      String path,
      String name,
      @JsonKey(unknownEnumValue: GalleryEntryKind.unknown)
      GalleryEntryKind kind,
      String sourceRevision,
      @JsonKey(required: true, disallowNullValue: true)
      GalleryMediaSection section,
      bool thumbnailSupported,
      @JsonKey(includeIfNull: false) int? sizeBytes,
      @JsonKey(includeIfNull: false) DateTime? fileChanged,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryEntry():
        return $default(
          _that.mediaId,
          _that.path,
          _that.name,
          _that.kind,
          _that.sourceRevision,
          _that.section,
          _that.thumbnailSupported,
          _that.sizeBytes,
          _that.fileChanged,
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
      String path,
      String name,
      @JsonKey(unknownEnumValue: GalleryEntryKind.unknown)
      GalleryEntryKind kind,
      String sourceRevision,
      @JsonKey(required: true, disallowNullValue: true)
      GalleryMediaSection section,
      bool thumbnailSupported,
      @JsonKey(includeIfNull: false) int? sizeBytes,
      @JsonKey(includeIfNull: false) DateTime? fileChanged,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryEntry() when $default != null:
        return $default(
          _that.mediaId,
          _that.path,
          _that.name,
          _that.kind,
          _that.sourceRevision,
          _that.section,
          _that.thumbnailSupported,
          _that.sizeBytes,
          _that.fileChanged,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _GalleryEntry extends GalleryEntry {
  const _GalleryEntry({
    required this.mediaId,
    required this.path,
    required this.name,
    @JsonKey(unknownEnumValue: GalleryEntryKind.unknown) required this.kind,
    this.sourceRevision = '',
    @JsonKey(required: true, disallowNullValue: true) required this.section,
    this.thumbnailSupported = false,
    @JsonKey(includeIfNull: false) this.sizeBytes,
    @JsonKey(includeIfNull: false) this.fileChanged,
  }) : super._();
  factory _GalleryEntry.fromJson(Map<String, dynamic> json) =>
      _$GalleryEntryFromJson(json);

  @override
  final String mediaId;
  @override
  final String path;
  @override
  final String name;
  @override
  @JsonKey(unknownEnumValue: GalleryEntryKind.unknown)
  final GalleryEntryKind kind;
  @override
  @JsonKey()
  final String sourceRevision;
  @override
  @JsonKey(required: true, disallowNullValue: true)
  final GalleryMediaSection section;
  @override
  @JsonKey()
  final bool thumbnailSupported;
  @override
  @JsonKey(includeIfNull: false)
  final int? sizeBytes;
  @override
  @JsonKey(includeIfNull: false)
  final DateTime? fileChanged;

  /// Create a copy of GalleryEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GalleryEntryCopyWith<_GalleryEntry> get copyWith =>
      __$GalleryEntryCopyWithImpl<_GalleryEntry>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$GalleryEntryToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GalleryEntry &&
            (identical(other.mediaId, mediaId) || other.mediaId == mediaId) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.kind, kind) || other.kind == kind) &&
            (identical(other.sourceRevision, sourceRevision) ||
                other.sourceRevision == sourceRevision) &&
            (identical(other.section, section) || other.section == section) &&
            (identical(other.thumbnailSupported, thumbnailSupported) ||
                other.thumbnailSupported == thumbnailSupported) &&
            (identical(other.sizeBytes, sizeBytes) ||
                other.sizeBytes == sizeBytes) &&
            (identical(other.fileChanged, fileChanged) ||
                other.fileChanged == fileChanged));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      mediaId,
      path,
      name,
      kind,
      sourceRevision,
      section,
      thumbnailSupported,
      sizeBytes,
      fileChanged,
    );
  }

  @override
  String toString() {
    return 'GalleryEntry(mediaId: $mediaId, path: $path, name: $name, kind: $kind, sourceRevision: $sourceRevision, section: $section, thumbnailSupported: $thumbnailSupported, sizeBytes: $sizeBytes, fileChanged: $fileChanged)';
  }
}

/// @nodoc
abstract mixin class _$GalleryEntryCopyWith<$Res>
    implements $GalleryEntryCopyWith<$Res> {
  factory _$GalleryEntryCopyWith(
    _GalleryEntry value,
    $Res Function(_GalleryEntry) _then,
  ) = __$GalleryEntryCopyWithImpl;
  @override
  @useResult
  $Res call({
    String mediaId,
    String path,
    String name,
    @JsonKey(unknownEnumValue: GalleryEntryKind.unknown) GalleryEntryKind kind,
    String sourceRevision,
    @JsonKey(required: true, disallowNullValue: true)
    GalleryMediaSection section,
    bool thumbnailSupported,
    @JsonKey(includeIfNull: false) int? sizeBytes,
    @JsonKey(includeIfNull: false) DateTime? fileChanged,
  });
}

/// @nodoc
class __$GalleryEntryCopyWithImpl<$Res>
    implements _$GalleryEntryCopyWith<$Res> {
  __$GalleryEntryCopyWithImpl(this._self, this._then);

  final _GalleryEntry _self;
  final $Res Function(_GalleryEntry) _then;

  /// Create a copy of GalleryEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? mediaId = null,
    Object? path = null,
    Object? name = null,
    Object? kind = null,
    Object? sourceRevision = null,
    Object? section = null,
    Object? thumbnailSupported = null,
    Object? sizeBytes = freezed,
    Object? fileChanged = freezed,
  }) {
    return _then(
      _GalleryEntry(
        mediaId: null == mediaId
            ? _self.mediaId
            : mediaId // ignore: cast_nullable_to_non_nullable
                  as String,
        path: null == path
            ? _self.path
            : path // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _self.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        kind: null == kind
            ? _self.kind
            : kind // ignore: cast_nullable_to_non_nullable
                  as GalleryEntryKind,
        sourceRevision: null == sourceRevision
            ? _self.sourceRevision
            : sourceRevision // ignore: cast_nullable_to_non_nullable
                  as String,
        section: null == section
            ? _self.section
            : section // ignore: cast_nullable_to_non_nullable
                  as GalleryMediaSection,
        thumbnailSupported: null == thumbnailSupported
            ? _self.thumbnailSupported
            : thumbnailSupported // ignore: cast_nullable_to_non_nullable
                  as bool,
        sizeBytes: freezed == sizeBytes
            ? _self.sizeBytes
            : sizeBytes // ignore: cast_nullable_to_non_nullable
                  as int?,
        fileChanged: freezed == fileChanged
            ? _self.fileChanged
            : fileChanged // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
mixin _$GalleryCatalog {
  int get schemaVersion;
  @JsonKey(required: true, disallowNullValue: true)
  GalleryMediaSection get section;
  String get catalogRevision;
  @JsonKey(unknownEnumValue: GalleryCapability.unknown)
  List<GalleryCapability> get capabilities;
  GalleryThumbnailPolicy? get thumbnailPolicy;
  List<GalleryEntry> get entries;

  /// Create a copy of GalleryCatalog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryCatalogCopyWith<GalleryCatalog> get copyWith =>
      _$GalleryCatalogCopyWithImpl<GalleryCatalog>(
        this as GalleryCatalog,
        _$identity,
      );

  /// Serializes this GalleryCatalog to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as GalleryCatalog;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryCatalog &&
            (identical(other.schemaVersion, _this.schemaVersion) ||
                other.schemaVersion == _this.schemaVersion) &&
            (identical(other.section, _this.section) ||
                other.section == _this.section) &&
            (identical(other.catalogRevision, _this.catalogRevision) ||
                other.catalogRevision == _this.catalogRevision) &&
            const DeepCollectionEquality().equals(
              other.capabilities,
              _this.capabilities,
            ) &&
            (identical(other.thumbnailPolicy, _this.thumbnailPolicy) ||
                other.thumbnailPolicy == _this.thumbnailPolicy) &&
            const DeepCollectionEquality().equals(
              other.entries,
              _this.entries,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as GalleryCatalog;
    return Object.hash(
      runtimeType,
      _this.schemaVersion,
      _this.section,
      _this.catalogRevision,
      const DeepCollectionEquality().hash(_this.capabilities),
      _this.thumbnailPolicy,
      const DeepCollectionEquality().hash(_this.entries),
    );
  }

  @override
  String toString() {
    final _this = this as GalleryCatalog;
    return 'GalleryCatalog(schemaVersion: ${_this.schemaVersion}, section: ${_this.section}, catalogRevision: ${_this.catalogRevision}, capabilities: ${_this.capabilities}, thumbnailPolicy: ${_this.thumbnailPolicy}, entries: ${_this.entries})';
  }
}

/// @nodoc
abstract mixin class $GalleryCatalogCopyWith<$Res> {
  factory $GalleryCatalogCopyWith(
    GalleryCatalog value,
    $Res Function(GalleryCatalog) _then,
  ) = _$GalleryCatalogCopyWithImpl;
  @useResult
  $Res call({
    int schemaVersion,
    @JsonKey(required: true, disallowNullValue: true)
    GalleryMediaSection section,
    String catalogRevision,
    @JsonKey(unknownEnumValue: GalleryCapability.unknown)
    List<GalleryCapability> capabilities,
    GalleryThumbnailPolicy? thumbnailPolicy,
    List<GalleryEntry> entries,
  });
}

/// @nodoc
class _$GalleryCatalogCopyWithImpl<$Res>
    implements $GalleryCatalogCopyWith<$Res> {
  _$GalleryCatalogCopyWithImpl(this._self, this._then);

  final GalleryCatalog _self;
  final $Res Function(GalleryCatalog) _then;

  /// Create a copy of GalleryCatalog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? schemaVersion = null,
    Object? section = null,
    Object? catalogRevision = null,
    Object? capabilities = null,
    Object? thumbnailPolicy = freezed,
    Object? entries = null,
  }) {
    return _then(
      GalleryCatalog(
        schemaVersion: null == schemaVersion
            ? _self.schemaVersion
            : schemaVersion // ignore: cast_nullable_to_non_nullable
                  as int,
        section: null == section
            ? _self.section
            : section // ignore: cast_nullable_to_non_nullable
                  as GalleryMediaSection,
        catalogRevision: null == catalogRevision
            ? _self.catalogRevision
            : catalogRevision // ignore: cast_nullable_to_non_nullable
                  as String,
        capabilities: null == capabilities
            ? _self.capabilities
            : capabilities // ignore: cast_nullable_to_non_nullable
                  as List<GalleryCapability>,
        thumbnailPolicy: freezed == thumbnailPolicy
            ? _self.thumbnailPolicy
            : thumbnailPolicy // ignore: cast_nullable_to_non_nullable
                  as GalleryThumbnailPolicy?,
        entries: null == entries
            ? _self.entries
            : entries // ignore: cast_nullable_to_non_nullable
                  as List<GalleryEntry>,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [GalleryCatalog].
extension GalleryCatalogPatterns on GalleryCatalog {
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
    TResult Function(_GalleryCatalog value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryCatalog() when $default != null:
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
    TResult Function(_GalleryCatalog value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryCatalog():
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
    TResult? Function(_GalleryCatalog value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryCatalog() when $default != null:
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
      int schemaVersion,
      @JsonKey(required: true, disallowNullValue: true)
      GalleryMediaSection section,
      String catalogRevision,
      @JsonKey(unknownEnumValue: GalleryCapability.unknown)
      List<GalleryCapability> capabilities,
      GalleryThumbnailPolicy? thumbnailPolicy,
      List<GalleryEntry> entries,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GalleryCatalog() when $default != null:
        return $default(
          _that.schemaVersion,
          _that.section,
          _that.catalogRevision,
          _that.capabilities,
          _that.thumbnailPolicy,
          _that.entries,
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
      int schemaVersion,
      @JsonKey(required: true, disallowNullValue: true)
      GalleryMediaSection section,
      String catalogRevision,
      @JsonKey(unknownEnumValue: GalleryCapability.unknown)
      List<GalleryCapability> capabilities,
      GalleryThumbnailPolicy? thumbnailPolicy,
      List<GalleryEntry> entries,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryCatalog():
        return $default(
          _that.schemaVersion,
          _that.section,
          _that.catalogRevision,
          _that.capabilities,
          _that.thumbnailPolicy,
          _that.entries,
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
      int schemaVersion,
      @JsonKey(required: true, disallowNullValue: true)
      GalleryMediaSection section,
      String catalogRevision,
      @JsonKey(unknownEnumValue: GalleryCapability.unknown)
      List<GalleryCapability> capabilities,
      GalleryThumbnailPolicy? thumbnailPolicy,
      List<GalleryEntry> entries,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GalleryCatalog() when $default != null:
        return $default(
          _that.schemaVersion,
          _that.section,
          _that.catalogRevision,
          _that.capabilities,
          _that.thumbnailPolicy,
          _that.entries,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _GalleryCatalog extends GalleryCatalog {
  const _GalleryCatalog({
    this.schemaVersion = GalleryCatalog.supportedSchemaVersion,
    @JsonKey(required: true, disallowNullValue: true) required this.section,
    this.catalogRevision = '',
    @JsonKey(unknownEnumValue: GalleryCapability.unknown)
    List<GalleryCapability> capabilities = const [],
    this.thumbnailPolicy,
    required List<GalleryEntry> entries,
  }) : _capabilities = capabilities,
       _entries = entries,
       super._();
  factory _GalleryCatalog.fromJson(Map<String, dynamic> json) =>
      _$GalleryCatalogFromJson(json);

  @override
  @JsonKey()
  final int schemaVersion;
  @override
  @JsonKey(required: true, disallowNullValue: true)
  final GalleryMediaSection section;
  @override
  @JsonKey()
  final String catalogRevision;
  final List<GalleryCapability> _capabilities;
  @override
  @JsonKey(unknownEnumValue: GalleryCapability.unknown)
  List<GalleryCapability> get capabilities {
    if (_capabilities is EqualUnmodifiableListView) return _capabilities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_capabilities);
  }

  @override
  final GalleryThumbnailPolicy? thumbnailPolicy;
  final List<GalleryEntry> _entries;
  @override
  List<GalleryEntry> get entries {
    if (_entries is EqualUnmodifiableListView) return _entries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_entries);
  }

  /// Create a copy of GalleryCatalog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GalleryCatalogCopyWith<_GalleryCatalog> get copyWith =>
      __$GalleryCatalogCopyWithImpl<_GalleryCatalog>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$GalleryCatalogToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GalleryCatalog &&
            (identical(other.schemaVersion, schemaVersion) ||
                other.schemaVersion == schemaVersion) &&
            (identical(other.section, section) || other.section == section) &&
            (identical(other.catalogRevision, catalogRevision) ||
                other.catalogRevision == catalogRevision) &&
            const DeepCollectionEquality().equals(
              other.capabilities,
              _capabilities,
            ) &&
            (identical(other.thumbnailPolicy, thumbnailPolicy) ||
                other.thumbnailPolicy == thumbnailPolicy) &&
            const DeepCollectionEquality().equals(other.entries, _entries));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      schemaVersion,
      section,
      catalogRevision,
      const DeepCollectionEquality().hash(_capabilities),
      thumbnailPolicy,
      const DeepCollectionEquality().hash(_entries),
    );
  }

  @override
  String toString() {
    return 'GalleryCatalog(schemaVersion: $schemaVersion, section: $section, catalogRevision: $catalogRevision, capabilities: $capabilities, thumbnailPolicy: $thumbnailPolicy, entries: $entries)';
  }
}

/// @nodoc
abstract mixin class _$GalleryCatalogCopyWith<$Res>
    implements $GalleryCatalogCopyWith<$Res> {
  factory _$GalleryCatalogCopyWith(
    _GalleryCatalog value,
    $Res Function(_GalleryCatalog) _then,
  ) = __$GalleryCatalogCopyWithImpl;
  @override
  @useResult
  $Res call({
    int schemaVersion,
    @JsonKey(required: true, disallowNullValue: true)
    GalleryMediaSection section,
    String catalogRevision,
    @JsonKey(unknownEnumValue: GalleryCapability.unknown)
    List<GalleryCapability> capabilities,
    GalleryThumbnailPolicy? thumbnailPolicy,
    List<GalleryEntry> entries,
  });
}

/// @nodoc
class __$GalleryCatalogCopyWithImpl<$Res>
    implements _$GalleryCatalogCopyWith<$Res> {
  __$GalleryCatalogCopyWithImpl(this._self, this._then);

  final _GalleryCatalog _self;
  final $Res Function(_GalleryCatalog) _then;

  /// Create a copy of GalleryCatalog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? schemaVersion = null,
    Object? section = null,
    Object? catalogRevision = null,
    Object? capabilities = null,
    Object? thumbnailPolicy = freezed,
    Object? entries = null,
  }) {
    return _then(
      _GalleryCatalog(
        schemaVersion: null == schemaVersion
            ? _self.schemaVersion
            : schemaVersion // ignore: cast_nullable_to_non_nullable
                  as int,
        section: null == section
            ? _self.section
            : section // ignore: cast_nullable_to_non_nullable
                  as GalleryMediaSection,
        catalogRevision: null == catalogRevision
            ? _self.catalogRevision
            : catalogRevision // ignore: cast_nullable_to_non_nullable
                  as String,
        capabilities: null == capabilities
            ? _self._capabilities
            : capabilities // ignore: cast_nullable_to_non_nullable
                  as List<GalleryCapability>,
        thumbnailPolicy: freezed == thumbnailPolicy
            ? _self.thumbnailPolicy
            : thumbnailPolicy // ignore: cast_nullable_to_non_nullable
                  as GalleryThumbnailPolicy?,
        entries: null == entries
            ? _self._entries
            : entries // ignore: cast_nullable_to_non_nullable
                  as List<GalleryEntry>,
      ),
    );
  }
}
