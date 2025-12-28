// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'empty_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EmptyResult {

 int get id;
/// Create a copy of EmptyResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmptyResultCopyWith<EmptyResult> get copyWith => _$EmptyResultCopyWithImpl<EmptyResult>(this as EmptyResult, _$identity);

  /// Serializes this EmptyResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmptyResult&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'EmptyResult(id: $id)';
}


}

/// @nodoc
abstract mixin class $EmptyResultCopyWith<$Res>  {
  factory $EmptyResultCopyWith(EmptyResult value, $Res Function(EmptyResult) _then) = _$EmptyResultCopyWithImpl;
@useResult
$Res call({
 int id
});




}
/// @nodoc
class _$EmptyResultCopyWithImpl<$Res>
    implements $EmptyResultCopyWith<$Res> {
  _$EmptyResultCopyWithImpl(this._self, this._then);

  final EmptyResult _self;
  final $Res Function(EmptyResult) _then;

/// Create a copy of EmptyResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [EmptyResult].
extension EmptyResultPatterns on EmptyResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmptyResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmptyResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmptyResult value)  $default,){
final _that = this;
switch (_that) {
case _EmptyResult():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmptyResult value)?  $default,){
final _that = this;
switch (_that) {
case _EmptyResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmptyResult() when $default != null:
return $default(_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id)  $default,) {final _that = this;
switch (_that) {
case _EmptyResult():
return $default(_that.id);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id)?  $default,) {final _that = this;
switch (_that) {
case _EmptyResult() when $default != null:
return $default(_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EmptyResult implements EmptyResult {
  const _EmptyResult({required this.id});
  factory _EmptyResult.fromJson(Map<String, dynamic> json) => _$EmptyResultFromJson(json);

@override final  int id;

/// Create a copy of EmptyResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmptyResultCopyWith<_EmptyResult> get copyWith => __$EmptyResultCopyWithImpl<_EmptyResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EmptyResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmptyResult&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'EmptyResult(id: $id)';
}


}

/// @nodoc
abstract mixin class _$EmptyResultCopyWith<$Res> implements $EmptyResultCopyWith<$Res> {
  factory _$EmptyResultCopyWith(_EmptyResult value, $Res Function(_EmptyResult) _then) = __$EmptyResultCopyWithImpl;
@override @useResult
$Res call({
 int id
});




}
/// @nodoc
class __$EmptyResultCopyWithImpl<$Res>
    implements _$EmptyResultCopyWith<$Res> {
  __$EmptyResultCopyWithImpl(this._self, this._then);

  final _EmptyResult _self;
  final $Res Function(_EmptyResult) _then;

/// Create a copy of EmptyResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_EmptyResult(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
