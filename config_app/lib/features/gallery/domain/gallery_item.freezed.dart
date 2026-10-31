// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gallery_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GalleryItem {
  /// Create a copy of GalleryItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GalleryItemCopyWith<GalleryItem> get copyWith =>
      _$GalleryItemCopyWithImpl<GalleryItem>(this as GalleryItem, _$identity);

  @override
  bool operator ==(Object other) {
    final _this = this as GalleryItem;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GalleryItem &&
            (identical(other.uri, _this.uri) || other.uri == _this.uri) &&
            (identical(other.title, _this.title) ||
                other.title == _this.title) &&
            (identical(other.mediaId, _this.mediaId) ||
                other.mediaId == _this.mediaId) &&
            (identical(other.revision, _this.revision) ||
                other.revision == _this.revision) &&
            (identical(other.scope, _this.scope) ||
                other.scope == _this.scope) &&
            (identical(other.kind, _this.kind) || other.kind == _this.kind) &&
            (identical(other.section, _this.section) ||
                other.section == _this.section) &&
            (identical(other.thumbnailBaseUri, _this.thumbnailBaseUri) ||
                other.thumbnailBaseUri == _this.thumbnailBaseUri) &&
            (identical(other.thumbnailPolicy, _this.thumbnailPolicy) ||
                other.thumbnailPolicy == _this.thumbnailPolicy) &&
            (identical(other.thumbnailsEnabled, _this.thumbnailsEnabled) ||
                other.thumbnailsEnabled == _this.thumbnailsEnabled) &&
            (identical(other.selected, _this.selected) ||
                other.selected == _this.selected));
  }

  @override
  int get hashCode {
    final _this = this as GalleryItem;
    return Object.hash(
      runtimeType,
      _this.uri,
      _this.title,
      _this.mediaId,
      _this.revision,
      _this.scope,
      _this.kind,
      _this.section,
      _this.thumbnailBaseUri,
      _this.thumbnailPolicy,
      _this.thumbnailsEnabled,
      _this.selected,
    );
  }

  @override
  String toString() {
    final _this = this as GalleryItem;
    return 'GalleryItem(uri: ${_this.uri}, title: ${_this.title}, mediaId: ${_this.mediaId}, revision: ${_this.revision}, scope: ${_this.scope}, kind: ${_this.kind}, section: ${_this.section}, thumbnailBaseUri: ${_this.thumbnailBaseUri}, thumbnailPolicy: ${_this.thumbnailPolicy}, thumbnailsEnabled: ${_this.thumbnailsEnabled}, selected: ${_this.selected})';
  }
}

/// @nodoc
abstract mixin class $GalleryItemCopyWith<$Res> {
  factory $GalleryItemCopyWith(
    GalleryItem value,
    $Res Function(GalleryItem) _then,
  ) = _$GalleryItemCopyWithImpl;
  @useResult
  $Res call({
    Uri uri,
    String title,
    String? mediaId,
    String revision,
    String scope,
    GalleryEntryKind? kind,
    Uri? thumbnailBaseUri,
    GalleryThumbnailPolicy? thumbnailPolicy,
    bool thumbnailsEnabled,
    bool selected,
    GalleryMediaSection section,
  });
}

/// @nodoc
class _$GalleryItemCopyWithImpl<$Res> implements $GalleryItemCopyWith<$Res> {
  _$GalleryItemCopyWithImpl(this._self, this._then);

  final GalleryItem _self;
  final $Res Function(GalleryItem) _then;

  /// Create a copy of GalleryItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uri = null,
    Object? title = null,
    Object? mediaId = freezed,
    Object? revision = null,
    Object? scope = null,
    Object? kind = freezed,
    Object? thumbnailBaseUri = freezed,
    Object? thumbnailPolicy = freezed,
    Object? thumbnailsEnabled = null,
    Object? selected = null,
    Object? section = null,
  }) {
    return _then(
      GalleryItem(
        uri: null == uri
            ? _self.uri
            : uri // ignore: cast_nullable_to_non_nullable
                  as Uri,
        title: null == title
            ? _self.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        mediaId: freezed == mediaId
            ? _self.mediaId!
            : mediaId // ignore: cast_nullable_to_non_nullable
                  as String?,
        revision: null == revision
            ? _self.revision
            : revision // ignore: cast_nullable_to_non_nullable
                  as String,
        scope: null == scope
            ? _self.scope
            : scope // ignore: cast_nullable_to_non_nullable
                  as String,
        kind: freezed == kind
            ? _self.kind!
            : kind // ignore: cast_nullable_to_non_nullable
                  as GalleryEntryKind?,
        thumbnailBaseUri: freezed == thumbnailBaseUri
            ? _self.thumbnailBaseUri
            : thumbnailBaseUri // ignore: cast_nullable_to_non_nullable
                  as Uri?,
        thumbnailPolicy: freezed == thumbnailPolicy
            ? _self.thumbnailPolicy
            : thumbnailPolicy // ignore: cast_nullable_to_non_nullable
                  as GalleryThumbnailPolicy?,
        thumbnailsEnabled: null == thumbnailsEnabled
            ? _self.thumbnailsEnabled
            : thumbnailsEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        selected: null == selected
            ? _self.selected
            : selected // ignore: cast_nullable_to_non_nullable
                  as bool,
        section: null == section
            ? _self.section
            : section // ignore: cast_nullable_to_non_nullable
                  as GalleryMediaSection,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [GalleryItem].
extension GalleryItemPatterns on GalleryItem {
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
  TResult maybeMap<TResult extends Object?>({required TResult orElse()}) {
    final _that = this;
    switch (_that) {
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
  TResult map<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
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
  TResult? mapOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
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
  TResult maybeWhen<TResult extends Object?>({required TResult orElse()}) {
    final _that = this;
    switch (_that) {
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
  TResult when<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
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
  TResult? whenOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }
}
