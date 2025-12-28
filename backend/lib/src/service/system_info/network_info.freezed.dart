// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'network_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NetworkInfo {

 int get lastUpdate; bool get hasInternet; List<NetworkInterfaceInfo>? get interfaces;
/// Create a copy of NetworkInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NetworkInfoCopyWith<NetworkInfo> get copyWith => _$NetworkInfoCopyWithImpl<NetworkInfo>(this as NetworkInfo, _$identity);

  /// Serializes this NetworkInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkInfo&&(identical(other.lastUpdate, lastUpdate) || other.lastUpdate == lastUpdate)&&(identical(other.hasInternet, hasInternet) || other.hasInternet == hasInternet)&&const DeepCollectionEquality().equals(other.interfaces, interfaces));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lastUpdate,hasInternet,const DeepCollectionEquality().hash(interfaces));

@override
String toString() {
  return 'NetworkInfo(lastUpdate: $lastUpdate, hasInternet: $hasInternet, interfaces: $interfaces)';
}


}

/// @nodoc
abstract mixin class $NetworkInfoCopyWith<$Res>  {
  factory $NetworkInfoCopyWith(NetworkInfo value, $Res Function(NetworkInfo) _then) = _$NetworkInfoCopyWithImpl;
@useResult
$Res call({
 int lastUpdate, bool hasInternet, List<NetworkInterfaceInfo>? interfaces
});




}
/// @nodoc
class _$NetworkInfoCopyWithImpl<$Res>
    implements $NetworkInfoCopyWith<$Res> {
  _$NetworkInfoCopyWithImpl(this._self, this._then);

  final NetworkInfo _self;
  final $Res Function(NetworkInfo) _then;

/// Create a copy of NetworkInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lastUpdate = null,Object? hasInternet = null,Object? interfaces = freezed,}) {
  return _then(_self.copyWith(
lastUpdate: null == lastUpdate ? _self.lastUpdate : lastUpdate // ignore: cast_nullable_to_non_nullable
as int,hasInternet: null == hasInternet ? _self.hasInternet : hasInternet // ignore: cast_nullable_to_non_nullable
as bool,interfaces: freezed == interfaces ? _self.interfaces : interfaces // ignore: cast_nullable_to_non_nullable
as List<NetworkInterfaceInfo>?,
  ));
}

}


/// Adds pattern-matching-related methods to [NetworkInfo].
extension NetworkInfoPatterns on NetworkInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NetworkInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NetworkInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NetworkInfo value)  $default,){
final _that = this;
switch (_that) {
case _NetworkInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NetworkInfo value)?  $default,){
final _that = this;
switch (_that) {
case _NetworkInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int lastUpdate,  bool hasInternet,  List<NetworkInterfaceInfo>? interfaces)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NetworkInfo() when $default != null:
return $default(_that.lastUpdate,_that.hasInternet,_that.interfaces);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int lastUpdate,  bool hasInternet,  List<NetworkInterfaceInfo>? interfaces)  $default,) {final _that = this;
switch (_that) {
case _NetworkInfo():
return $default(_that.lastUpdate,_that.hasInternet,_that.interfaces);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int lastUpdate,  bool hasInternet,  List<NetworkInterfaceInfo>? interfaces)?  $default,) {final _that = this;
switch (_that) {
case _NetworkInfo() when $default != null:
return $default(_that.lastUpdate,_that.hasInternet,_that.interfaces);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NetworkInfo implements NetworkInfo {
  const _NetworkInfo({required this.lastUpdate, required this.hasInternet, required final  List<NetworkInterfaceInfo>? interfaces}): _interfaces = interfaces;
  factory _NetworkInfo.fromJson(Map<String, dynamic> json) => _$NetworkInfoFromJson(json);

@override final  int lastUpdate;
@override final  bool hasInternet;
 final  List<NetworkInterfaceInfo>? _interfaces;
@override List<NetworkInterfaceInfo>? get interfaces {
  final value = _interfaces;
  if (value == null) return null;
  if (_interfaces is EqualUnmodifiableListView) return _interfaces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of NetworkInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NetworkInfoCopyWith<_NetworkInfo> get copyWith => __$NetworkInfoCopyWithImpl<_NetworkInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NetworkInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NetworkInfo&&(identical(other.lastUpdate, lastUpdate) || other.lastUpdate == lastUpdate)&&(identical(other.hasInternet, hasInternet) || other.hasInternet == hasInternet)&&const DeepCollectionEquality().equals(other._interfaces, _interfaces));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lastUpdate,hasInternet,const DeepCollectionEquality().hash(_interfaces));

@override
String toString() {
  return 'NetworkInfo(lastUpdate: $lastUpdate, hasInternet: $hasInternet, interfaces: $interfaces)';
}


}

/// @nodoc
abstract mixin class _$NetworkInfoCopyWith<$Res> implements $NetworkInfoCopyWith<$Res> {
  factory _$NetworkInfoCopyWith(_NetworkInfo value, $Res Function(_NetworkInfo) _then) = __$NetworkInfoCopyWithImpl;
@override @useResult
$Res call({
 int lastUpdate, bool hasInternet, List<NetworkInterfaceInfo>? interfaces
});




}
/// @nodoc
class __$NetworkInfoCopyWithImpl<$Res>
    implements _$NetworkInfoCopyWith<$Res> {
  __$NetworkInfoCopyWithImpl(this._self, this._then);

  final _NetworkInfo _self;
  final $Res Function(_NetworkInfo) _then;

/// Create a copy of NetworkInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lastUpdate = null,Object? hasInternet = null,Object? interfaces = freezed,}) {
  return _then(_NetworkInfo(
lastUpdate: null == lastUpdate ? _self.lastUpdate : lastUpdate // ignore: cast_nullable_to_non_nullable
as int,hasInternet: null == hasInternet ? _self.hasInternet : hasInternet // ignore: cast_nullable_to_non_nullable
as bool,interfaces: freezed == interfaces ? _self._interfaces : interfaces // ignore: cast_nullable_to_non_nullable
as List<NetworkInterfaceInfo>?,
  ));
}


}


/// @nodoc
mixin _$NetworkInterfaceInfo {

 String get name; NetworkInterfaceStatus get status; String get ip4; String get ip6;
/// Create a copy of NetworkInterfaceInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NetworkInterfaceInfoCopyWith<NetworkInterfaceInfo> get copyWith => _$NetworkInterfaceInfoCopyWithImpl<NetworkInterfaceInfo>(this as NetworkInterfaceInfo, _$identity);

  /// Serializes this NetworkInterfaceInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkInterfaceInfo&&(identical(other.name, name) || other.name == name)&&(identical(other.status, status) || other.status == status)&&(identical(other.ip4, ip4) || other.ip4 == ip4)&&(identical(other.ip6, ip6) || other.ip6 == ip6));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,status,ip4,ip6);

@override
String toString() {
  return 'NetworkInterfaceInfo(name: $name, status: $status, ip4: $ip4, ip6: $ip6)';
}


}

/// @nodoc
abstract mixin class $NetworkInterfaceInfoCopyWith<$Res>  {
  factory $NetworkInterfaceInfoCopyWith(NetworkInterfaceInfo value, $Res Function(NetworkInterfaceInfo) _then) = _$NetworkInterfaceInfoCopyWithImpl;
@useResult
$Res call({
 String name, NetworkInterfaceStatus status, String ip4, String ip6
});




}
/// @nodoc
class _$NetworkInterfaceInfoCopyWithImpl<$Res>
    implements $NetworkInterfaceInfoCopyWith<$Res> {
  _$NetworkInterfaceInfoCopyWithImpl(this._self, this._then);

  final NetworkInterfaceInfo _self;
  final $Res Function(NetworkInterfaceInfo) _then;

/// Create a copy of NetworkInterfaceInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? status = null,Object? ip4 = null,Object? ip6 = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as NetworkInterfaceStatus,ip4: null == ip4 ? _self.ip4 : ip4 // ignore: cast_nullable_to_non_nullable
as String,ip6: null == ip6 ? _self.ip6 : ip6 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [NetworkInterfaceInfo].
extension NetworkInterfaceInfoPatterns on NetworkInterfaceInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NetworkInterfaceInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NetworkInterfaceInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NetworkInterfaceInfo value)  $default,){
final _that = this;
switch (_that) {
case _NetworkInterfaceInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NetworkInterfaceInfo value)?  $default,){
final _that = this;
switch (_that) {
case _NetworkInterfaceInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  NetworkInterfaceStatus status,  String ip4,  String ip6)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NetworkInterfaceInfo() when $default != null:
return $default(_that.name,_that.status,_that.ip4,_that.ip6);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  NetworkInterfaceStatus status,  String ip4,  String ip6)  $default,) {final _that = this;
switch (_that) {
case _NetworkInterfaceInfo():
return $default(_that.name,_that.status,_that.ip4,_that.ip6);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  NetworkInterfaceStatus status,  String ip4,  String ip6)?  $default,) {final _that = this;
switch (_that) {
case _NetworkInterfaceInfo() when $default != null:
return $default(_that.name,_that.status,_that.ip4,_that.ip6);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NetworkInterfaceInfo implements NetworkInterfaceInfo {
  const _NetworkInterfaceInfo({required this.name, required this.status, required this.ip4, required this.ip6});
  factory _NetworkInterfaceInfo.fromJson(Map<String, dynamic> json) => _$NetworkInterfaceInfoFromJson(json);

@override final  String name;
@override final  NetworkInterfaceStatus status;
@override final  String ip4;
@override final  String ip6;

/// Create a copy of NetworkInterfaceInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NetworkInterfaceInfoCopyWith<_NetworkInterfaceInfo> get copyWith => __$NetworkInterfaceInfoCopyWithImpl<_NetworkInterfaceInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NetworkInterfaceInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NetworkInterfaceInfo&&(identical(other.name, name) || other.name == name)&&(identical(other.status, status) || other.status == status)&&(identical(other.ip4, ip4) || other.ip4 == ip4)&&(identical(other.ip6, ip6) || other.ip6 == ip6));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,status,ip4,ip6);

@override
String toString() {
  return 'NetworkInterfaceInfo(name: $name, status: $status, ip4: $ip4, ip6: $ip6)';
}


}

/// @nodoc
abstract mixin class _$NetworkInterfaceInfoCopyWith<$Res> implements $NetworkInterfaceInfoCopyWith<$Res> {
  factory _$NetworkInterfaceInfoCopyWith(_NetworkInterfaceInfo value, $Res Function(_NetworkInterfaceInfo) _then) = __$NetworkInterfaceInfoCopyWithImpl;
@override @useResult
$Res call({
 String name, NetworkInterfaceStatus status, String ip4, String ip6
});




}
/// @nodoc
class __$NetworkInterfaceInfoCopyWithImpl<$Res>
    implements _$NetworkInterfaceInfoCopyWith<$Res> {
  __$NetworkInterfaceInfoCopyWithImpl(this._self, this._then);

  final _NetworkInterfaceInfo _self;
  final $Res Function(_NetworkInterfaceInfo) _then;

/// Create a copy of NetworkInterfaceInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? status = null,Object? ip4 = null,Object? ip6 = null,}) {
  return _then(_NetworkInterfaceInfo(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as NetworkInterfaceStatus,ip4: null == ip4 ? _self.ip4 : ip4 // ignore: cast_nullable_to_non_nullable
as String,ip6: null == ip6 ? _self.ip6 : ip6 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
