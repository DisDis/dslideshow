// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gallery_catalog.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GalleryCatalog {

 int get schemaVersion; String get catalogRevision;@JsonKey(unknownEnumValue: GalleryCapability.unknown) List<GalleryCapability> get capabilities; GalleryThumbnailPolicy? get thumbnailPolicy; List<GalleryEntry> get entries;
/// Create a copy of GalleryCatalog
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GalleryCatalogCopyWith<GalleryCatalog> get copyWith => _$GalleryCatalogCopyWithImpl<GalleryCatalog>(this as GalleryCatalog, _$identity);

  /// Serializes this GalleryCatalog to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as GalleryCatalog;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GalleryCatalog&&(identical(other.schemaVersion, _this.schemaVersion) || other.schemaVersion == _this.schemaVersion)&&(identical(other.catalogRevision, _this.catalogRevision) || other.catalogRevision == _this.catalogRevision)&&const DeepCollectionEquality().equals(other.capabilities, _this.capabilities)&&(identical(other.thumbnailPolicy, _this.thumbnailPolicy) || other.thumbnailPolicy == _this.thumbnailPolicy)&&const DeepCollectionEquality().equals(other.entries, _this.entries));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as GalleryCatalog;
  return Object.hash(runtimeType,_this.schemaVersion,_this.catalogRevision,const DeepCollectionEquality().hash(_this.capabilities),_this.thumbnailPolicy,const DeepCollectionEquality().hash(_this.entries));
}

@override
String toString() {
  final _this = this as GalleryCatalog;
  return 'GalleryCatalog(schemaVersion: ${_this.schemaVersion}, catalogRevision: ${_this.catalogRevision}, capabilities: ${_this.capabilities}, thumbnailPolicy: ${_this.thumbnailPolicy}, entries: ${_this.entries})';
}


}

/// @nodoc
abstract mixin class $GalleryCatalogCopyWith<$Res>  {
  factory $GalleryCatalogCopyWith(GalleryCatalog value, $Res Function(GalleryCatalog) _then) = _$GalleryCatalogCopyWithImpl;
@useResult
$Res call({
 int schemaVersion, String catalogRevision,@JsonKey(unknownEnumValue: GalleryCapability.unknown) List<GalleryCapability> capabilities, GalleryThumbnailPolicy? thumbnailPolicy, List<GalleryEntry> entries
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
@pragma('vm:prefer-inline') @override $Res call({Object? schemaVersion = null,Object? catalogRevision = null,Object? capabilities = null,Object? thumbnailPolicy = freezed,Object? entries = null,}) {
  return _then(GalleryCatalog(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,catalogRevision: null == catalogRevision ? _self.catalogRevision : catalogRevision // ignore: cast_nullable_to_non_nullable
as String,capabilities: null == capabilities ? _self.capabilities : capabilities // ignore: cast_nullable_to_non_nullable
as List<GalleryCapability>,thumbnailPolicy: freezed == thumbnailPolicy ? _self.thumbnailPolicy : thumbnailPolicy // ignore: cast_nullable_to_non_nullable
as GalleryThumbnailPolicy?,entries: null == entries ? _self.entries : entries // ignore: cast_nullable_to_non_nullable
as List<GalleryEntry>,
  ));
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GalleryCatalog value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GalleryCatalog() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GalleryCatalog value)  $default,){
final _that = this;
switch (_that) {
case _GalleryCatalog():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GalleryCatalog value)?  $default,){
final _that = this;
switch (_that) {
case _GalleryCatalog() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int schemaVersion,  String catalogRevision, @JsonKey(unknownEnumValue: GalleryCapability.unknown)  List<GalleryCapability> capabilities,  GalleryThumbnailPolicy? thumbnailPolicy,  List<GalleryEntry> entries)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GalleryCatalog() when $default != null:
return $default(_that.schemaVersion,_that.catalogRevision,_that.capabilities,_that.thumbnailPolicy,_that.entries);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int schemaVersion,  String catalogRevision, @JsonKey(unknownEnumValue: GalleryCapability.unknown)  List<GalleryCapability> capabilities,  GalleryThumbnailPolicy? thumbnailPolicy,  List<GalleryEntry> entries)  $default,) {final _that = this;
switch (_that) {
case _GalleryCatalog():
return $default(_that.schemaVersion,_that.catalogRevision,_that.capabilities,_that.thumbnailPolicy,_that.entries);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int schemaVersion,  String catalogRevision, @JsonKey(unknownEnumValue: GalleryCapability.unknown)  List<GalleryCapability> capabilities,  GalleryThumbnailPolicy? thumbnailPolicy,  List<GalleryEntry> entries)?  $default,) {final _that = this;
switch (_that) {
case _GalleryCatalog() when $default != null:
return $default(_that.schemaVersion,_that.catalogRevision,_that.capabilities,_that.thumbnailPolicy,_that.entries);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _GalleryCatalog extends GalleryCatalog {
  const _GalleryCatalog({this.schemaVersion = GalleryCatalog.supportedSchemaVersion, required this.catalogRevision, @JsonKey(unknownEnumValue: GalleryCapability.unknown) required  List<GalleryCapability> capabilities, required this.thumbnailPolicy, required  List<GalleryEntry> entries}): _capabilities = capabilities,_entries = entries,super._();
  factory _GalleryCatalog.fromJson(Map<String, dynamic> json) => _$GalleryCatalogFromJson(json);

@override@JsonKey() final  int schemaVersion;
@override final  String catalogRevision;
 final  List<GalleryCapability> _capabilities;
@override@JsonKey(unknownEnumValue: GalleryCapability.unknown) List<GalleryCapability> get capabilities {
  if (_capabilities is EqualUnmodifiableListView) return _capabilities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_capabilities);
}

@override final  GalleryThumbnailPolicy? thumbnailPolicy;
 final  List<GalleryEntry> _entries;
@override List<GalleryEntry> get entries {
  if (_entries is EqualUnmodifiableListView) return _entries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_entries);
}


/// Create a copy of GalleryCatalog
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GalleryCatalogCopyWith<_GalleryCatalog> get copyWith => __$GalleryCatalogCopyWithImpl<_GalleryCatalog>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GalleryCatalogToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GalleryCatalog&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.catalogRevision, catalogRevision) || other.catalogRevision == catalogRevision)&&const DeepCollectionEquality().equals(other.capabilities, _capabilities)&&(identical(other.thumbnailPolicy, thumbnailPolicy) || other.thumbnailPolicy == thumbnailPolicy)&&const DeepCollectionEquality().equals(other.entries, _entries));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,schemaVersion,catalogRevision,const DeepCollectionEquality().hash(_capabilities),thumbnailPolicy,const DeepCollectionEquality().hash(_entries));
}

@override
String toString() {
    return 'GalleryCatalog(schemaVersion: $schemaVersion, catalogRevision: $catalogRevision, capabilities: $capabilities, thumbnailPolicy: $thumbnailPolicy, entries: $entries)';
}


}

/// @nodoc
abstract mixin class _$GalleryCatalogCopyWith<$Res> implements $GalleryCatalogCopyWith<$Res> {
  factory _$GalleryCatalogCopyWith(_GalleryCatalog value, $Res Function(_GalleryCatalog) _then) = __$GalleryCatalogCopyWithImpl;
@override @useResult
$Res call({
 int schemaVersion, String catalogRevision,@JsonKey(unknownEnumValue: GalleryCapability.unknown) List<GalleryCapability> capabilities, GalleryThumbnailPolicy? thumbnailPolicy, List<GalleryEntry> entries
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
@override @pragma('vm:prefer-inline') $Res call({Object? schemaVersion = null,Object? catalogRevision = null,Object? capabilities = null,Object? thumbnailPolicy = freezed,Object? entries = null,}) {
  return _then(_GalleryCatalog(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,catalogRevision: null == catalogRevision ? _self.catalogRevision : catalogRevision // ignore: cast_nullable_to_non_nullable
as String,capabilities: null == capabilities ? _self._capabilities : capabilities // ignore: cast_nullable_to_non_nullable
as List<GalleryCapability>,thumbnailPolicy: freezed == thumbnailPolicy ? _self.thumbnailPolicy : thumbnailPolicy // ignore: cast_nullable_to_non_nullable
as GalleryThumbnailPolicy?,entries: null == entries ? _self._entries : entries // ignore: cast_nullable_to_non_nullable
as List<GalleryEntry>,
  ));
}


}

// dart format on
