// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ErrorResult {

 String get error; int get id;
/// Create a copy of ErrorResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorResultCopyWith<ErrorResult> get copyWith => _$ErrorResultCopyWithImpl<ErrorResult>(this as ErrorResult, _$identity);

  /// Serializes this ErrorResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorResult&&(identical(other.error, error) || other.error == error)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,error,id);

@override
String toString() {
  return 'ErrorResult(error: $error, id: $id)';
}


}

/// @nodoc
abstract mixin class $ErrorResultCopyWith<$Res>  {
  factory $ErrorResultCopyWith(ErrorResult value, $Res Function(ErrorResult) _then) = _$ErrorResultCopyWithImpl;
@useResult
$Res call({
 String error, int id
});




}
/// @nodoc
class _$ErrorResultCopyWithImpl<$Res>
    implements $ErrorResultCopyWith<$Res> {
  _$ErrorResultCopyWithImpl(this._self, this._then);

  final ErrorResult _self;
  final $Res Function(ErrorResult) _then;

/// Create a copy of ErrorResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? error = null,Object? id = null,}) {
  return _then(_self.copyWith(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ErrorResult].
extension ErrorResultPatterns on ErrorResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ErrorResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ErrorResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ErrorResult value)  $default,){
final _that = this;
switch (_that) {
case _ErrorResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ErrorResult value)?  $default,){
final _that = this;
switch (_that) {
case _ErrorResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String error,  int id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ErrorResult() when $default != null:
return $default(_that.error,_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String error,  int id)  $default,) {final _that = this;
switch (_that) {
case _ErrorResult():
return $default(_that.error,_that.id);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String error,  int id)?  $default,) {final _that = this;
switch (_that) {
case _ErrorResult() when $default != null:
return $default(_that.error,_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ErrorResult implements ErrorResult {
  const _ErrorResult({required this.error, required this.id});
  factory _ErrorResult.fromJson(Map<String, dynamic> json) => _$ErrorResultFromJson(json);

@override final  String error;
@override final  int id;

/// Create a copy of ErrorResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorResultCopyWith<_ErrorResult> get copyWith => __$ErrorResultCopyWithImpl<_ErrorResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ErrorResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ErrorResult&&(identical(other.error, error) || other.error == error)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,error,id);

@override
String toString() {
  return 'ErrorResult(error: $error, id: $id)';
}


}

/// @nodoc
abstract mixin class _$ErrorResultCopyWith<$Res> implements $ErrorResultCopyWith<$Res> {
  factory _$ErrorResultCopyWith(_ErrorResult value, $Res Function(_ErrorResult) _then) = __$ErrorResultCopyWithImpl;
@override @useResult
$Res call({
 String error, int id
});




}
/// @nodoc
class __$ErrorResultCopyWithImpl<$Res>
    implements _$ErrorResultCopyWith<$Res> {
  __$ErrorResultCopyWithImpl(this._self, this._then);

  final _ErrorResult _self;
  final $Res Function(_ErrorResult) _then;

/// Create a copy of ErrorResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? error = null,Object? id = null,}) {
  return _then(_ErrorResult(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
