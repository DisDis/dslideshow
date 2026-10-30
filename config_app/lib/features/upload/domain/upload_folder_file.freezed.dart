// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'upload_folder_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UploadFolderFile {
  Object get file;
  String get relativePath;

  /// Create a copy of UploadFolderFile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UploadFolderFileCopyWith<UploadFolderFile> get copyWith =>
      _$UploadFolderFileCopyWithImpl<UploadFolderFile>(this as UploadFolderFile, _$identity);

  @override
  bool operator ==(Object other) {
    final _this = this as UploadFolderFile;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UploadFolderFile &&
            const DeepCollectionEquality().equals(other.file, _this.file) &&
            (identical(other.relativePath, _this.relativePath) || other.relativePath == _this.relativePath));
  }

  @override
  int get hashCode {
    final _this = this as UploadFolderFile;
    return Object.hash(runtimeType, const DeepCollectionEquality().hash(_this.file), _this.relativePath);
  }

  @override
  String toString() {
    final _this = this as UploadFolderFile;
    return 'UploadFolderFile(file: ${_this.file}, relativePath: ${_this.relativePath})';
  }
}

/// @nodoc
abstract mixin class $UploadFolderFileCopyWith<$Res> {
  factory $UploadFolderFileCopyWith(UploadFolderFile value, $Res Function(UploadFolderFile) _then) =
      _$UploadFolderFileCopyWithImpl;
  @useResult
  $Res call({String relativePath});
}

/// @nodoc
class _$UploadFolderFileCopyWithImpl<$Res> implements $UploadFolderFileCopyWith<$Res> {
  _$UploadFolderFileCopyWithImpl(this._self, this._then);

  final UploadFolderFile _self;
  final $Res Function(UploadFolderFile) _then;

  /// Create a copy of UploadFolderFile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? relativePath = null}) {
    return _then(
      _self.copyWith(
        relativePath: null == relativePath
            ? _self.relativePath
            : relativePath // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [UploadFolderFile].
extension UploadFolderFilePatterns on UploadFolderFile {
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
    TResult Function(LocalUploadFolderFile value)? local,
    TResult Function(DocumentUploadFolderFile value)? document,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case LocalUploadFolderFile() when local != null:
        return local(_that);
      case DocumentUploadFolderFile() when document != null:
        return document(_that);
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
    required TResult Function(LocalUploadFolderFile value) local,
    required TResult Function(DocumentUploadFolderFile value) document,
  }) {
    final _that = this;
    switch (_that) {
      case LocalUploadFolderFile():
        return local(_that);
      case DocumentUploadFolderFile():
        return document(_that);
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
    TResult? Function(LocalUploadFolderFile value)? local,
    TResult? Function(DocumentUploadFolderFile value)? document,
  }) {
    final _that = this;
    switch (_that) {
      case LocalUploadFolderFile() when local != null:
        return local(_that);
      case DocumentUploadFolderFile() when document != null:
        return document(_that);
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
    TResult Function(File file, String relativePath)? local,
    TResult Function(PlatformFile file, String relativePath)? document,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case LocalUploadFolderFile() when local != null:
        return local(_that.file, _that.relativePath);
      case DocumentUploadFolderFile() when document != null:
        return document(_that.file, _that.relativePath);
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
    required TResult Function(File file, String relativePath) local,
    required TResult Function(PlatformFile file, String relativePath) document,
  }) {
    final _that = this;
    switch (_that) {
      case LocalUploadFolderFile():
        return local(_that.file, _that.relativePath);
      case DocumentUploadFolderFile():
        return document(_that.file, _that.relativePath);
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
    TResult? Function(File file, String relativePath)? local,
    TResult? Function(PlatformFile file, String relativePath)? document,
  }) {
    final _that = this;
    switch (_that) {
      case LocalUploadFolderFile() when local != null:
        return local(_that.file, _that.relativePath);
      case DocumentUploadFolderFile() when document != null:
        return document(_that.file, _that.relativePath);
      case _:
        return null;
    }
  }
}

/// @nodoc

class LocalUploadFolderFile implements UploadFolderFile {
  const LocalUploadFolderFile(this.file, this.relativePath);

  @override
  final File file;
  @override
  final String relativePath;

  /// Create a copy of UploadFolderFile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LocalUploadFolderFileCopyWith<LocalUploadFolderFile> get copyWith =>
      _$LocalUploadFolderFileCopyWithImpl<LocalUploadFolderFile>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LocalUploadFolderFile &&
            (identical(other.file, file) || other.file == file) &&
            (identical(other.relativePath, relativePath) || other.relativePath == relativePath));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, file, relativePath);
  }

  @override
  String toString() {
    return 'UploadFolderFile.local(file: $file, relativePath: $relativePath)';
  }
}

/// @nodoc
abstract mixin class $LocalUploadFolderFileCopyWith<$Res> implements $UploadFolderFileCopyWith<$Res> {
  factory $LocalUploadFolderFileCopyWith(LocalUploadFolderFile value, $Res Function(LocalUploadFolderFile) _then) =
      _$LocalUploadFolderFileCopyWithImpl;
  @override
  @useResult
  $Res call({File file, String relativePath});
}

/// @nodoc
class _$LocalUploadFolderFileCopyWithImpl<$Res> implements $LocalUploadFolderFileCopyWith<$Res> {
  _$LocalUploadFolderFileCopyWithImpl(this._self, this._then);

  final LocalUploadFolderFile _self;
  final $Res Function(LocalUploadFolderFile) _then;

  /// Create a copy of UploadFolderFile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? file = null, Object? relativePath = null}) {
    return _then(
      LocalUploadFolderFile(
        null == file
            ? _self.file
            : file // ignore: cast_nullable_to_non_nullable
                  as File,
        null == relativePath
            ? _self.relativePath
            : relativePath // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class DocumentUploadFolderFile implements UploadFolderFile {
  const DocumentUploadFolderFile(this.file, this.relativePath);

  @override
  final PlatformFile file;
  @override
  final String relativePath;

  /// Create a copy of UploadFolderFile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DocumentUploadFolderFileCopyWith<DocumentUploadFolderFile> get copyWith =>
      _$DocumentUploadFolderFileCopyWithImpl<DocumentUploadFolderFile>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DocumentUploadFolderFile &&
            (identical(other.file, file) || other.file == file) &&
            (identical(other.relativePath, relativePath) || other.relativePath == relativePath));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, file, relativePath);
  }

  @override
  String toString() {
    return 'UploadFolderFile.document(file: $file, relativePath: $relativePath)';
  }
}

/// @nodoc
abstract mixin class $DocumentUploadFolderFileCopyWith<$Res> implements $UploadFolderFileCopyWith<$Res> {
  factory $DocumentUploadFolderFileCopyWith(
    DocumentUploadFolderFile value,
    $Res Function(DocumentUploadFolderFile) _then,
  ) = _$DocumentUploadFolderFileCopyWithImpl;
  @override
  @useResult
  $Res call({PlatformFile file, String relativePath});
}

/// @nodoc
class _$DocumentUploadFolderFileCopyWithImpl<$Res> implements $DocumentUploadFolderFileCopyWith<$Res> {
  _$DocumentUploadFolderFileCopyWithImpl(this._self, this._then);

  final DocumentUploadFolderFile _self;
  final $Res Function(DocumentUploadFolderFile) _then;

  /// Create a copy of UploadFolderFile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? file = null, Object? relativePath = null}) {
    return _then(
      DocumentUploadFolderFile(
        null == file
            ? _self.file
            : file // ignore: cast_nullable_to_non_nullable
                  as PlatformFile,
        null == relativePath
            ? _self.relativePath
            : relativePath // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}
