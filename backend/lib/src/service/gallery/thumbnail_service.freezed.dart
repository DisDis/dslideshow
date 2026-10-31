// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'thumbnail_service.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ThumbnailSource {


/// Create a copy of ThumbnailSource
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ThumbnailSourceCopyWith<ThumbnailSource> get copyWith => _$ThumbnailSourceCopyWithImpl<ThumbnailSource>(this as ThumbnailSource, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ThumbnailSource;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ThumbnailSource&&(identical(other.mediaId, _this.mediaId) || other.mediaId == _this.mediaId)&&(identical(other.revision, _this.revision) || other.revision == _this.revision)&&(identical(other.path, _this.path) || other.path == _this.path)&&(identical(other.fingerprintToken, _this.fingerprintToken) || other.fingerprintToken == _this.fingerprintToken)&&(identical(other.section, _this.section) || other.section == _this.section));
}


@override
int get hashCode {
  final _this = this as ThumbnailSource;
  return Object.hash(runtimeType,_this.mediaId,_this.revision,_this.path,_this.fingerprintToken,_this.section);
}

@override
String toString() {
  final _this = this as ThumbnailSource;
  return 'ThumbnailSource(mediaId: ${_this.mediaId}, revision: ${_this.revision}, path: ${_this.path}, fingerprintToken: ${_this.fingerprintToken}, section: ${_this.section})';
}


}

/// @nodoc
abstract mixin class $ThumbnailSourceCopyWith<$Res>  {
  factory $ThumbnailSourceCopyWith(ThumbnailSource value, $Res Function(ThumbnailSource) _then) = _$ThumbnailSourceCopyWithImpl;
@useResult
$Res call({
 String mediaId, String revision, String path, String fingerprintToken, GalleryMediaSection section
});




}
/// @nodoc
class _$ThumbnailSourceCopyWithImpl<$Res>
    implements $ThumbnailSourceCopyWith<$Res> {
  _$ThumbnailSourceCopyWithImpl(this._self, this._then);

  final ThumbnailSource _self;
  final $Res Function(ThumbnailSource) _then;

/// Create a copy of ThumbnailSource
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mediaId = null,Object? revision = null,Object? path = null,Object? fingerprintToken = null,Object? section = null,}) {
  return _then(ThumbnailSource(
mediaId: null == mediaId ? _self.mediaId : mediaId // ignore: cast_nullable_to_non_nullable
as String,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as String,path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,fingerprintToken: null == fingerprintToken ? _self.fingerprintToken : fingerprintToken // ignore: cast_nullable_to_non_nullable
as String,section: null == section ? _self.section : section // ignore: cast_nullable_to_non_nullable
as GalleryMediaSection,
  ));
}

}


/// Adds pattern-matching-related methods to [ThumbnailSource].
extension ThumbnailSourcePatterns on ThumbnailSource {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({required TResult orElse(),}){
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

@optionalTypeArgs TResult map<TResult extends Object?>(){
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(){
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({required TResult orElse(),}) {final _that = this;
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

@optionalTypeArgs TResult when<TResult extends Object?>() {final _that = this;
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
  return null;

}
}

}

// dart format on
