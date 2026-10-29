// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gallery_tool_runner.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GalleryToolResult {

 int get exitCode; String get stdout; String get stderr;
/// Create a copy of GalleryToolResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GalleryToolResultCopyWith<GalleryToolResult> get copyWith => _$GalleryToolResultCopyWithImpl<GalleryToolResult>(this as GalleryToolResult, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as GalleryToolResult;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GalleryToolResult&&(identical(other.exitCode, _this.exitCode) || other.exitCode == _this.exitCode)&&(identical(other.stdout, _this.stdout) || other.stdout == _this.stdout)&&(identical(other.stderr, _this.stderr) || other.stderr == _this.stderr));
}


@override
int get hashCode {
  final _this = this as GalleryToolResult;
  return Object.hash(runtimeType,_this.exitCode,_this.stdout,_this.stderr);
}

@override
String toString() {
  final _this = this as GalleryToolResult;
  return 'GalleryToolResult(exitCode: ${_this.exitCode}, stdout: ${_this.stdout}, stderr: ${_this.stderr})';
}


}

/// @nodoc
abstract mixin class $GalleryToolResultCopyWith<$Res>  {
  factory $GalleryToolResultCopyWith(GalleryToolResult value, $Res Function(GalleryToolResult) _then) = _$GalleryToolResultCopyWithImpl;
@useResult
$Res call({
 int exitCode, String stdout, String stderr
});




}
/// @nodoc
class _$GalleryToolResultCopyWithImpl<$Res>
    implements $GalleryToolResultCopyWith<$Res> {
  _$GalleryToolResultCopyWithImpl(this._self, this._then);

  final GalleryToolResult _self;
  final $Res Function(GalleryToolResult) _then;

/// Create a copy of GalleryToolResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? exitCode = null,Object? stdout = null,Object? stderr = null,}) {
  return _then(GalleryToolResult(
exitCode: null == exitCode ? _self.exitCode : exitCode // ignore: cast_nullable_to_non_nullable
as int,stdout: null == stdout ? _self.stdout : stdout // ignore: cast_nullable_to_non_nullable
as String,stderr: null == stderr ? _self.stderr : stderr // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GalleryToolResult].
extension GalleryToolResultPatterns on GalleryToolResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GalleryToolResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GalleryToolResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GalleryToolResult value)  $default,){
final _that = this;
switch (_that) {
case _GalleryToolResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GalleryToolResult value)?  $default,){
final _that = this;
switch (_that) {
case _GalleryToolResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int exitCode,  String stdout,  String stderr)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GalleryToolResult() when $default != null:
return $default(_that.exitCode,_that.stdout,_that.stderr);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int exitCode,  String stdout,  String stderr)  $default,) {final _that = this;
switch (_that) {
case _GalleryToolResult():
return $default(_that.exitCode,_that.stdout,_that.stderr);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int exitCode,  String stdout,  String stderr)?  $default,) {final _that = this;
switch (_that) {
case _GalleryToolResult() when $default != null:
return $default(_that.exitCode,_that.stdout,_that.stderr);case _:
  return null;

}
}

}

/// @nodoc


class _GalleryToolResult implements GalleryToolResult {
  const _GalleryToolResult({required this.exitCode, required this.stdout, required this.stderr});
  

@override final  int exitCode;
@override final  String stdout;
@override final  String stderr;

/// Create a copy of GalleryToolResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GalleryToolResultCopyWith<_GalleryToolResult> get copyWith => __$GalleryToolResultCopyWithImpl<_GalleryToolResult>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GalleryToolResult&&(identical(other.exitCode, exitCode) || other.exitCode == exitCode)&&(identical(other.stdout, stdout) || other.stdout == stdout)&&(identical(other.stderr, stderr) || other.stderr == stderr));
}


@override
int get hashCode {
    return Object.hash(runtimeType,exitCode,stdout,stderr);
}

@override
String toString() {
    return 'GalleryToolResult(exitCode: $exitCode, stdout: $stdout, stderr: $stderr)';
}


}

/// @nodoc
abstract mixin class _$GalleryToolResultCopyWith<$Res> implements $GalleryToolResultCopyWith<$Res> {
  factory _$GalleryToolResultCopyWith(_GalleryToolResult value, $Res Function(_GalleryToolResult) _then) = __$GalleryToolResultCopyWithImpl;
@override @useResult
$Res call({
 int exitCode, String stdout, String stderr
});




}
/// @nodoc
class __$GalleryToolResultCopyWithImpl<$Res>
    implements _$GalleryToolResultCopyWith<$Res> {
  __$GalleryToolResultCopyWithImpl(this._self, this._then);

  final _GalleryToolResult _self;
  final $Res Function(_GalleryToolResult) _then;

/// Create a copy of GalleryToolResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? exitCode = null,Object? stdout = null,Object? stderr = null,}) {
  return _then(_GalleryToolResult(
exitCode: null == exitCode ? _self.exitCode : exitCode // ignore: cast_nullable_to_non_nullable
as int,stdout: null == stdout ? _self.stdout : stdout // ignore: cast_nullable_to_non_nullable
as String,stderr: null == stderr ? _self.stderr : stderr // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
