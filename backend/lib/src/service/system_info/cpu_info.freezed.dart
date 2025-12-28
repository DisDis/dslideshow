// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cpu_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CpuInfo {

 int get cores; String get hardware; String get model; String get revision;
/// Create a copy of CpuInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CpuInfoCopyWith<CpuInfo> get copyWith => _$CpuInfoCopyWithImpl<CpuInfo>(this as CpuInfo, _$identity);

  /// Serializes this CpuInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CpuInfo&&(identical(other.cores, cores) || other.cores == cores)&&(identical(other.hardware, hardware) || other.hardware == hardware)&&(identical(other.model, model) || other.model == model)&&(identical(other.revision, revision) || other.revision == revision));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cores,hardware,model,revision);

@override
String toString() {
  return 'CpuInfo(cores: $cores, hardware: $hardware, model: $model, revision: $revision)';
}


}

/// @nodoc
abstract mixin class $CpuInfoCopyWith<$Res>  {
  factory $CpuInfoCopyWith(CpuInfo value, $Res Function(CpuInfo) _then) = _$CpuInfoCopyWithImpl;
@useResult
$Res call({
 int cores, String hardware, String model, String revision
});




}
/// @nodoc
class _$CpuInfoCopyWithImpl<$Res>
    implements $CpuInfoCopyWith<$Res> {
  _$CpuInfoCopyWithImpl(this._self, this._then);

  final CpuInfo _self;
  final $Res Function(CpuInfo) _then;

/// Create a copy of CpuInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cores = null,Object? hardware = null,Object? model = null,Object? revision = null,}) {
  return _then(_self.copyWith(
cores: null == cores ? _self.cores : cores // ignore: cast_nullable_to_non_nullable
as int,hardware: null == hardware ? _self.hardware : hardware // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CpuInfo].
extension CpuInfoPatterns on CpuInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CpuInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CpuInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CpuInfo value)  $default,){
final _that = this;
switch (_that) {
case _CpuInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CpuInfo value)?  $default,){
final _that = this;
switch (_that) {
case _CpuInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int cores,  String hardware,  String model,  String revision)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CpuInfo() when $default != null:
return $default(_that.cores,_that.hardware,_that.model,_that.revision);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int cores,  String hardware,  String model,  String revision)  $default,) {final _that = this;
switch (_that) {
case _CpuInfo():
return $default(_that.cores,_that.hardware,_that.model,_that.revision);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int cores,  String hardware,  String model,  String revision)?  $default,) {final _that = this;
switch (_that) {
case _CpuInfo() when $default != null:
return $default(_that.cores,_that.hardware,_that.model,_that.revision);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CpuInfo implements CpuInfo {
  const _CpuInfo({required this.cores, required this.hardware, required this.model, required this.revision});
  factory _CpuInfo.fromJson(Map<String, dynamic> json) => _$CpuInfoFromJson(json);

@override final  int cores;
@override final  String hardware;
@override final  String model;
@override final  String revision;

/// Create a copy of CpuInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CpuInfoCopyWith<_CpuInfo> get copyWith => __$CpuInfoCopyWithImpl<_CpuInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CpuInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CpuInfo&&(identical(other.cores, cores) || other.cores == cores)&&(identical(other.hardware, hardware) || other.hardware == hardware)&&(identical(other.model, model) || other.model == model)&&(identical(other.revision, revision) || other.revision == revision));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cores,hardware,model,revision);

@override
String toString() {
  return 'CpuInfo(cores: $cores, hardware: $hardware, model: $model, revision: $revision)';
}


}

/// @nodoc
abstract mixin class _$CpuInfoCopyWith<$Res> implements $CpuInfoCopyWith<$Res> {
  factory _$CpuInfoCopyWith(_CpuInfo value, $Res Function(_CpuInfo) _then) = __$CpuInfoCopyWithImpl;
@override @useResult
$Res call({
 int cores, String hardware, String model, String revision
});




}
/// @nodoc
class __$CpuInfoCopyWithImpl<$Res>
    implements _$CpuInfoCopyWith<$Res> {
  __$CpuInfoCopyWithImpl(this._self, this._then);

  final _CpuInfo _self;
  final $Res Function(_CpuInfo) _then;

/// Create a copy of CpuInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cores = null,Object? hardware = null,Object? model = null,Object? revision = null,}) {
  return _then(_CpuInfo(
cores: null == cores ? _self.cores : cores // ignore: cast_nullable_to_non_nullable
as int,hardware: null == hardware ? _self.hardware : hardware // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
