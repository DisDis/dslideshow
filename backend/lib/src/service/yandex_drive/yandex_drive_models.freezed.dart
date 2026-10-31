// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'yandex_drive_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$YandexDriveCredential {

 String get accountId; String get label; String get accessToken; String get refreshToken; DateTime get expiresAt;
/// Create a copy of YandexDriveCredential
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$YandexDriveCredentialCopyWith<YandexDriveCredential> get copyWith => _$YandexDriveCredentialCopyWithImpl<YandexDriveCredential>(this as YandexDriveCredential, _$identity);

  /// Serializes this YandexDriveCredential to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as YandexDriveCredential;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is YandexDriveCredential&&(identical(other.accountId, _this.accountId) || other.accountId == _this.accountId)&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.accessToken, _this.accessToken) || other.accessToken == _this.accessToken)&&(identical(other.refreshToken, _this.refreshToken) || other.refreshToken == _this.refreshToken)&&(identical(other.expiresAt, _this.expiresAt) || other.expiresAt == _this.expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as YandexDriveCredential;
  return Object.hash(runtimeType,_this.accountId,_this.label,_this.accessToken,_this.refreshToken,_this.expiresAt);
}



}

/// @nodoc
abstract mixin class $YandexDriveCredentialCopyWith<$Res>  {
  factory $YandexDriveCredentialCopyWith(YandexDriveCredential value, $Res Function(YandexDriveCredential) _then) = _$YandexDriveCredentialCopyWithImpl;
@useResult
$Res call({
 String accountId, String label, String accessToken, String refreshToken, DateTime expiresAt
});




}
/// @nodoc
class _$YandexDriveCredentialCopyWithImpl<$Res>
    implements $YandexDriveCredentialCopyWith<$Res> {
  _$YandexDriveCredentialCopyWithImpl(this._self, this._then);

  final YandexDriveCredential _self;
  final $Res Function(YandexDriveCredential) _then;

/// Create a copy of YandexDriveCredential
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accountId = null,Object? label = null,Object? accessToken = null,Object? refreshToken = null,Object? expiresAt = null,}) {
  return _then(YandexDriveCredential(
accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [YandexDriveCredential].
extension YandexDriveCredentialPatterns on YandexDriveCredential {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _YandexDriveCredential value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _YandexDriveCredential() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _YandexDriveCredential value)  $default,){
final _that = this;
switch (_that) {
case _YandexDriveCredential():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _YandexDriveCredential value)?  $default,){
final _that = this;
switch (_that) {
case _YandexDriveCredential() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String accountId,  String label,  String accessToken,  String refreshToken,  DateTime expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _YandexDriveCredential() when $default != null:
return $default(_that.accountId,_that.label,_that.accessToken,_that.refreshToken,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String accountId,  String label,  String accessToken,  String refreshToken,  DateTime expiresAt)  $default,) {final _that = this;
switch (_that) {
case _YandexDriveCredential():
return $default(_that.accountId,_that.label,_that.accessToken,_that.refreshToken,_that.expiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String accountId,  String label,  String accessToken,  String refreshToken,  DateTime expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _YandexDriveCredential() when $default != null:
return $default(_that.accountId,_that.label,_that.accessToken,_that.refreshToken,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _YandexDriveCredential implements YandexDriveCredential {
  const _YandexDriveCredential({required this.accountId, required this.label, required this.accessToken, this.refreshToken = '', required this.expiresAt});
  factory _YandexDriveCredential.fromJson(Map<String, dynamic> json) => _$YandexDriveCredentialFromJson(json);

@override final  String accountId;
@override final  String label;
@override final  String accessToken;
@override@JsonKey() final  String refreshToken;
@override final  DateTime expiresAt;

/// Create a copy of YandexDriveCredential
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$YandexDriveCredentialCopyWith<_YandexDriveCredential> get copyWith => __$YandexDriveCredentialCopyWithImpl<_YandexDriveCredential>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$YandexDriveCredentialToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _YandexDriveCredential&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.label, label) || other.label == label)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,accountId,label,accessToken,refreshToken,expiresAt);
}



}

/// @nodoc
abstract mixin class _$YandexDriveCredentialCopyWith<$Res> implements $YandexDriveCredentialCopyWith<$Res> {
  factory _$YandexDriveCredentialCopyWith(_YandexDriveCredential value, $Res Function(_YandexDriveCredential) _then) = __$YandexDriveCredentialCopyWithImpl;
@override @useResult
$Res call({
 String accountId, String label, String accessToken, String refreshToken, DateTime expiresAt
});




}
/// @nodoc
class __$YandexDriveCredentialCopyWithImpl<$Res>
    implements _$YandexDriveCredentialCopyWith<$Res> {
  __$YandexDriveCredentialCopyWithImpl(this._self, this._then);

  final _YandexDriveCredential _self;
  final $Res Function(_YandexDriveCredential) _then;

/// Create a copy of YandexDriveCredential
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accountId = null,Object? label = null,Object? accessToken = null,Object? refreshToken = null,Object? expiresAt = null,}) {
  return _then(_YandexDriveCredential(
accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$YandexDriveResource {

 String get path; String get name;@JsonKey(unknownEnumValue: YandexDriveResourceType.unknown) YandexDriveResourceType get type; int get size; String? get md5; String? get sha256;@JsonKey(name: '_embedded') YandexDriveResourceList? get children;
/// Create a copy of YandexDriveResource
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$YandexDriveResourceCopyWith<YandexDriveResource> get copyWith => _$YandexDriveResourceCopyWithImpl<YandexDriveResource>(this as YandexDriveResource, _$identity);

  /// Serializes this YandexDriveResource to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as YandexDriveResource;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is YandexDriveResource&&(identical(other.path, _this.path) || other.path == _this.path)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.size, _this.size) || other.size == _this.size)&&(identical(other.md5, _this.md5) || other.md5 == _this.md5)&&(identical(other.sha256, _this.sha256) || other.sha256 == _this.sha256)&&(identical(other.children, _this.children) || other.children == _this.children));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as YandexDriveResource;
  return Object.hash(runtimeType,_this.path,_this.name,_this.type,_this.size,_this.md5,_this.sha256,_this.children);
}

@override
String toString() {
  final _this = this as YandexDriveResource;
  return 'YandexDriveResource(path: ${_this.path}, name: ${_this.name}, type: ${_this.type}, size: ${_this.size}, md5: ${_this.md5}, sha256: ${_this.sha256}, children: ${_this.children})';
}


}

/// @nodoc
abstract mixin class $YandexDriveResourceCopyWith<$Res>  {
  factory $YandexDriveResourceCopyWith(YandexDriveResource value, $Res Function(YandexDriveResource) _then) = _$YandexDriveResourceCopyWithImpl;
@useResult
$Res call({
 String path, String name,@JsonKey(unknownEnumValue: YandexDriveResourceType.unknown) YandexDriveResourceType type, int size, String? md5, String? sha256,@JsonKey(name: '_embedded') YandexDriveResourceList? children
});


$YandexDriveResourceListCopyWith<$Res>? get children;

}
/// @nodoc
class _$YandexDriveResourceCopyWithImpl<$Res>
    implements $YandexDriveResourceCopyWith<$Res> {
  _$YandexDriveResourceCopyWithImpl(this._self, this._then);

  final YandexDriveResource _self;
  final $Res Function(YandexDriveResource) _then;

/// Create a copy of YandexDriveResource
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? path = null,Object? name = null,Object? type = null,Object? size = null,Object? md5 = freezed,Object? sha256 = freezed,Object? children = freezed,}) {
  return _then(YandexDriveResource(
path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as YandexDriveResourceType,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,md5: freezed == md5 ? _self.md5 : md5 // ignore: cast_nullable_to_non_nullable
as String?,sha256: freezed == sha256 ? _self.sha256 : sha256 // ignore: cast_nullable_to_non_nullable
as String?,children: freezed == children ? _self.children : children // ignore: cast_nullable_to_non_nullable
as YandexDriveResourceList?,
  ));
}
/// Create a copy of YandexDriveResource
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$YandexDriveResourceListCopyWith<$Res>? get children {
    if (_self.children == null) {
    return null;
  }

  return $YandexDriveResourceListCopyWith<$Res>(_self.children!, (value) {
    return _then(_self.copyWith(children: value));
  });
}
}


/// Adds pattern-matching-related methods to [YandexDriveResource].
extension YandexDriveResourcePatterns on YandexDriveResource {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _YandexDriveResource value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _YandexDriveResource() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _YandexDriveResource value)  $default,){
final _that = this;
switch (_that) {
case _YandexDriveResource():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _YandexDriveResource value)?  $default,){
final _that = this;
switch (_that) {
case _YandexDriveResource() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String path,  String name, @JsonKey(unknownEnumValue: YandexDriveResourceType.unknown)  YandexDriveResourceType type,  int size,  String? md5,  String? sha256, @JsonKey(name: '_embedded')  YandexDriveResourceList? children)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _YandexDriveResource() when $default != null:
return $default(_that.path,_that.name,_that.type,_that.size,_that.md5,_that.sha256,_that.children);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String path,  String name, @JsonKey(unknownEnumValue: YandexDriveResourceType.unknown)  YandexDriveResourceType type,  int size,  String? md5,  String? sha256, @JsonKey(name: '_embedded')  YandexDriveResourceList? children)  $default,) {final _that = this;
switch (_that) {
case _YandexDriveResource():
return $default(_that.path,_that.name,_that.type,_that.size,_that.md5,_that.sha256,_that.children);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String path,  String name, @JsonKey(unknownEnumValue: YandexDriveResourceType.unknown)  YandexDriveResourceType type,  int size,  String? md5,  String? sha256, @JsonKey(name: '_embedded')  YandexDriveResourceList? children)?  $default,) {final _that = this;
switch (_that) {
case _YandexDriveResource() when $default != null:
return $default(_that.path,_that.name,_that.type,_that.size,_that.md5,_that.sha256,_that.children);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _YandexDriveResource implements YandexDriveResource {
  const _YandexDriveResource({required this.path, this.name = '', @JsonKey(unknownEnumValue: YandexDriveResourceType.unknown) this.type = YandexDriveResourceType.unknown, this.size = 0, this.md5, this.sha256, @JsonKey(name: '_embedded') this.children});
  factory _YandexDriveResource.fromJson(Map<String, dynamic> json) => _$YandexDriveResourceFromJson(json);

@override final  String path;
@override@JsonKey() final  String name;
@override@JsonKey(unknownEnumValue: YandexDriveResourceType.unknown) final  YandexDriveResourceType type;
@override@JsonKey() final  int size;
@override final  String? md5;
@override final  String? sha256;
@override@JsonKey(name: '_embedded') final  YandexDriveResourceList? children;

/// Create a copy of YandexDriveResource
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$YandexDriveResourceCopyWith<_YandexDriveResource> get copyWith => __$YandexDriveResourceCopyWithImpl<_YandexDriveResource>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$YandexDriveResourceToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _YandexDriveResource&&(identical(other.path, path) || other.path == path)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.size, size) || other.size == size)&&(identical(other.md5, md5) || other.md5 == md5)&&(identical(other.sha256, sha256) || other.sha256 == sha256)&&(identical(other.children, children) || other.children == children));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,path,name,type,size,md5,sha256,children);
}

@override
String toString() {
    return 'YandexDriveResource(path: $path, name: $name, type: $type, size: $size, md5: $md5, sha256: $sha256, children: $children)';
}


}

/// @nodoc
abstract mixin class _$YandexDriveResourceCopyWith<$Res> implements $YandexDriveResourceCopyWith<$Res> {
  factory _$YandexDriveResourceCopyWith(_YandexDriveResource value, $Res Function(_YandexDriveResource) _then) = __$YandexDriveResourceCopyWithImpl;
@override @useResult
$Res call({
 String path, String name,@JsonKey(unknownEnumValue: YandexDriveResourceType.unknown) YandexDriveResourceType type, int size, String? md5, String? sha256,@JsonKey(name: '_embedded') YandexDriveResourceList? children
});


@override $YandexDriveResourceListCopyWith<$Res>? get children;

}
/// @nodoc
class __$YandexDriveResourceCopyWithImpl<$Res>
    implements _$YandexDriveResourceCopyWith<$Res> {
  __$YandexDriveResourceCopyWithImpl(this._self, this._then);

  final _YandexDriveResource _self;
  final $Res Function(_YandexDriveResource) _then;

/// Create a copy of YandexDriveResource
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? path = null,Object? name = null,Object? type = null,Object? size = null,Object? md5 = freezed,Object? sha256 = freezed,Object? children = freezed,}) {
  return _then(_YandexDriveResource(
path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as YandexDriveResourceType,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,md5: freezed == md5 ? _self.md5 : md5 // ignore: cast_nullable_to_non_nullable
as String?,sha256: freezed == sha256 ? _self.sha256 : sha256 // ignore: cast_nullable_to_non_nullable
as String?,children: freezed == children ? _self.children : children // ignore: cast_nullable_to_non_nullable
as YandexDriveResourceList?,
  ));
}

/// Create a copy of YandexDriveResource
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$YandexDriveResourceListCopyWith<$Res>? get children {
    if (_self.children == null) {
    return null;
  }

  return $YandexDriveResourceListCopyWith<$Res>(_self.children!, (value) {
    return _then(_self.copyWith(children: value));
  });
}
}


/// @nodoc
mixin _$YandexDriveResourceList {

 List<YandexDriveResource> get items; int get offset; int get limit; int get total;
/// Create a copy of YandexDriveResourceList
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$YandexDriveResourceListCopyWith<YandexDriveResourceList> get copyWith => _$YandexDriveResourceListCopyWithImpl<YandexDriveResourceList>(this as YandexDriveResourceList, _$identity);

  /// Serializes this YandexDriveResourceList to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as YandexDriveResourceList;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is YandexDriveResourceList&&const DeepCollectionEquality().equals(other.items, _this.items)&&(identical(other.offset, _this.offset) || other.offset == _this.offset)&&(identical(other.limit, _this.limit) || other.limit == _this.limit)&&(identical(other.total, _this.total) || other.total == _this.total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as YandexDriveResourceList;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.items),_this.offset,_this.limit,_this.total);
}

@override
String toString() {
  final _this = this as YandexDriveResourceList;
  return 'YandexDriveResourceList(items: ${_this.items}, offset: ${_this.offset}, limit: ${_this.limit}, total: ${_this.total})';
}


}

/// @nodoc
abstract mixin class $YandexDriveResourceListCopyWith<$Res>  {
  factory $YandexDriveResourceListCopyWith(YandexDriveResourceList value, $Res Function(YandexDriveResourceList) _then) = _$YandexDriveResourceListCopyWithImpl;
@useResult
$Res call({
 List<YandexDriveResource> items, int offset, int limit, int total
});




}
/// @nodoc
class _$YandexDriveResourceListCopyWithImpl<$Res>
    implements $YandexDriveResourceListCopyWith<$Res> {
  _$YandexDriveResourceListCopyWithImpl(this._self, this._then);

  final YandexDriveResourceList _self;
  final $Res Function(YandexDriveResourceList) _then;

/// Create a copy of YandexDriveResourceList
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? offset = null,Object? limit = null,Object? total = null,}) {
  return _then(YandexDriveResourceList(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<YandexDriveResource>,offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as int,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [YandexDriveResourceList].
extension YandexDriveResourceListPatterns on YandexDriveResourceList {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _YandexDriveResourceList value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _YandexDriveResourceList() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _YandexDriveResourceList value)  $default,){
final _that = this;
switch (_that) {
case _YandexDriveResourceList():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _YandexDriveResourceList value)?  $default,){
final _that = this;
switch (_that) {
case _YandexDriveResourceList() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<YandexDriveResource> items,  int offset,  int limit,  int total)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _YandexDriveResourceList() when $default != null:
return $default(_that.items,_that.offset,_that.limit,_that.total);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<YandexDriveResource> items,  int offset,  int limit,  int total)  $default,) {final _that = this;
switch (_that) {
case _YandexDriveResourceList():
return $default(_that.items,_that.offset,_that.limit,_that.total);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<YandexDriveResource> items,  int offset,  int limit,  int total)?  $default,) {final _that = this;
switch (_that) {
case _YandexDriveResourceList() when $default != null:
return $default(_that.items,_that.offset,_that.limit,_that.total);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _YandexDriveResourceList implements YandexDriveResourceList {
  const _YandexDriveResourceList({ List<YandexDriveResource> items = const [], this.offset = 0, this.limit = 0, this.total = 0}): _items = items;
  factory _YandexDriveResourceList.fromJson(Map<String, dynamic> json) => _$YandexDriveResourceListFromJson(json);

 final  List<YandexDriveResource> _items;
@override@JsonKey() List<YandexDriveResource> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey() final  int offset;
@override@JsonKey() final  int limit;
@override@JsonKey() final  int total;

/// Create a copy of YandexDriveResourceList
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$YandexDriveResourceListCopyWith<_YandexDriveResourceList> get copyWith => __$YandexDriveResourceListCopyWithImpl<_YandexDriveResourceList>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$YandexDriveResourceListToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _YandexDriveResourceList&&const DeepCollectionEquality().equals(other.items, _items)&&(identical(other.offset, offset) || other.offset == offset)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),offset,limit,total);
}

@override
String toString() {
    return 'YandexDriveResourceList(items: $items, offset: $offset, limit: $limit, total: $total)';
}


}

/// @nodoc
abstract mixin class _$YandexDriveResourceListCopyWith<$Res> implements $YandexDriveResourceListCopyWith<$Res> {
  factory _$YandexDriveResourceListCopyWith(_YandexDriveResourceList value, $Res Function(_YandexDriveResourceList) _then) = __$YandexDriveResourceListCopyWithImpl;
@override @useResult
$Res call({
 List<YandexDriveResource> items, int offset, int limit, int total
});




}
/// @nodoc
class __$YandexDriveResourceListCopyWithImpl<$Res>
    implements _$YandexDriveResourceListCopyWith<$Res> {
  __$YandexDriveResourceListCopyWithImpl(this._self, this._then);

  final _YandexDriveResourceList _self;
  final $Res Function(_YandexDriveResourceList) _then;

/// Create a copy of YandexDriveResourceList
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? offset = null,Object? limit = null,Object? total = null,}) {
  return _then(_YandexDriveResourceList(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<YandexDriveResource>,offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as int,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$YandexDriveTokenResponse {

@JsonKey(name: 'access_token') String? get accessToken;@JsonKey(name: 'refresh_token') String? get refreshToken;@JsonKey(name: 'expires_in') int? get expiresIn; String? get error;
/// Create a copy of YandexDriveTokenResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$YandexDriveTokenResponseCopyWith<YandexDriveTokenResponse> get copyWith => _$YandexDriveTokenResponseCopyWithImpl<YandexDriveTokenResponse>(this as YandexDriveTokenResponse, _$identity);

  /// Serializes this YandexDriveTokenResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as YandexDriveTokenResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is YandexDriveTokenResponse&&(identical(other.accessToken, _this.accessToken) || other.accessToken == _this.accessToken)&&(identical(other.refreshToken, _this.refreshToken) || other.refreshToken == _this.refreshToken)&&(identical(other.expiresIn, _this.expiresIn) || other.expiresIn == _this.expiresIn)&&(identical(other.error, _this.error) || other.error == _this.error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as YandexDriveTokenResponse;
  return Object.hash(runtimeType,_this.accessToken,_this.refreshToken,_this.expiresIn,_this.error);
}



}

/// @nodoc
abstract mixin class $YandexDriveTokenResponseCopyWith<$Res>  {
  factory $YandexDriveTokenResponseCopyWith(YandexDriveTokenResponse value, $Res Function(YandexDriveTokenResponse) _then) = _$YandexDriveTokenResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'access_token') String? accessToken,@JsonKey(name: 'refresh_token') String? refreshToken,@JsonKey(name: 'expires_in') int? expiresIn, String? error
});




}
/// @nodoc
class _$YandexDriveTokenResponseCopyWithImpl<$Res>
    implements $YandexDriveTokenResponseCopyWith<$Res> {
  _$YandexDriveTokenResponseCopyWithImpl(this._self, this._then);

  final YandexDriveTokenResponse _self;
  final $Res Function(YandexDriveTokenResponse) _then;

/// Create a copy of YandexDriveTokenResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accessToken = freezed,Object? refreshToken = freezed,Object? expiresIn = freezed,Object? error = freezed,}) {
  return _then(YandexDriveTokenResponse(
accessToken: freezed == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String?,refreshToken: freezed == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String?,expiresIn: freezed == expiresIn ? _self.expiresIn : expiresIn // ignore: cast_nullable_to_non_nullable
as int?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [YandexDriveTokenResponse].
extension YandexDriveTokenResponsePatterns on YandexDriveTokenResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _YandexDriveTokenResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _YandexDriveTokenResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _YandexDriveTokenResponse value)  $default,){
final _that = this;
switch (_that) {
case _YandexDriveTokenResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _YandexDriveTokenResponse value)?  $default,){
final _that = this;
switch (_that) {
case _YandexDriveTokenResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'access_token')  String? accessToken, @JsonKey(name: 'refresh_token')  String? refreshToken, @JsonKey(name: 'expires_in')  int? expiresIn,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _YandexDriveTokenResponse() when $default != null:
return $default(_that.accessToken,_that.refreshToken,_that.expiresIn,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'access_token')  String? accessToken, @JsonKey(name: 'refresh_token')  String? refreshToken, @JsonKey(name: 'expires_in')  int? expiresIn,  String? error)  $default,) {final _that = this;
switch (_that) {
case _YandexDriveTokenResponse():
return $default(_that.accessToken,_that.refreshToken,_that.expiresIn,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'access_token')  String? accessToken, @JsonKey(name: 'refresh_token')  String? refreshToken, @JsonKey(name: 'expires_in')  int? expiresIn,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _YandexDriveTokenResponse() when $default != null:
return $default(_that.accessToken,_that.refreshToken,_that.expiresIn,_that.error);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _YandexDriveTokenResponse implements YandexDriveTokenResponse {
  const _YandexDriveTokenResponse({@JsonKey(name: 'access_token') this.accessToken, @JsonKey(name: 'refresh_token') this.refreshToken, @JsonKey(name: 'expires_in') this.expiresIn, this.error});
  factory _YandexDriveTokenResponse.fromJson(Map<String, dynamic> json) => _$YandexDriveTokenResponseFromJson(json);

@override@JsonKey(name: 'access_token') final  String? accessToken;
@override@JsonKey(name: 'refresh_token') final  String? refreshToken;
@override@JsonKey(name: 'expires_in') final  int? expiresIn;
@override final  String? error;

/// Create a copy of YandexDriveTokenResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$YandexDriveTokenResponseCopyWith<_YandexDriveTokenResponse> get copyWith => __$YandexDriveTokenResponseCopyWithImpl<_YandexDriveTokenResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$YandexDriveTokenResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _YandexDriveTokenResponse&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.expiresIn, expiresIn) || other.expiresIn == expiresIn)&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,accessToken,refreshToken,expiresIn,error);
}



}

/// @nodoc
abstract mixin class _$YandexDriveTokenResponseCopyWith<$Res> implements $YandexDriveTokenResponseCopyWith<$Res> {
  factory _$YandexDriveTokenResponseCopyWith(_YandexDriveTokenResponse value, $Res Function(_YandexDriveTokenResponse) _then) = __$YandexDriveTokenResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'access_token') String? accessToken,@JsonKey(name: 'refresh_token') String? refreshToken,@JsonKey(name: 'expires_in') int? expiresIn, String? error
});




}
/// @nodoc
class __$YandexDriveTokenResponseCopyWithImpl<$Res>
    implements _$YandexDriveTokenResponseCopyWith<$Res> {
  __$YandexDriveTokenResponseCopyWithImpl(this._self, this._then);

  final _YandexDriveTokenResponse _self;
  final $Res Function(_YandexDriveTokenResponse) _then;

/// Create a copy of YandexDriveTokenResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accessToken = freezed,Object? refreshToken = freezed,Object? expiresIn = freezed,Object? error = freezed,}) {
  return _then(_YandexDriveTokenResponse(
accessToken: freezed == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String?,refreshToken: freezed == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String?,expiresIn: freezed == expiresIn ? _self.expiresIn : expiresIn // ignore: cast_nullable_to_non_nullable
as int?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$YandexDriveDeviceResponse {

@JsonKey(name: 'device_code') String get deviceCode;@JsonKey(name: 'user_code') String get userCode;@JsonKey(name: 'verification_url') Uri get verificationUrl; int get interval;@JsonKey(name: 'expires_in') int get expiresIn;
/// Create a copy of YandexDriveDeviceResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$YandexDriveDeviceResponseCopyWith<YandexDriveDeviceResponse> get copyWith => _$YandexDriveDeviceResponseCopyWithImpl<YandexDriveDeviceResponse>(this as YandexDriveDeviceResponse, _$identity);

  /// Serializes this YandexDriveDeviceResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as YandexDriveDeviceResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is YandexDriveDeviceResponse&&(identical(other.deviceCode, _this.deviceCode) || other.deviceCode == _this.deviceCode)&&(identical(other.userCode, _this.userCode) || other.userCode == _this.userCode)&&(identical(other.verificationUrl, _this.verificationUrl) || other.verificationUrl == _this.verificationUrl)&&(identical(other.interval, _this.interval) || other.interval == _this.interval)&&(identical(other.expiresIn, _this.expiresIn) || other.expiresIn == _this.expiresIn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as YandexDriveDeviceResponse;
  return Object.hash(runtimeType,_this.deviceCode,_this.userCode,_this.verificationUrl,_this.interval,_this.expiresIn);
}



}

/// @nodoc
abstract mixin class $YandexDriveDeviceResponseCopyWith<$Res>  {
  factory $YandexDriveDeviceResponseCopyWith(YandexDriveDeviceResponse value, $Res Function(YandexDriveDeviceResponse) _then) = _$YandexDriveDeviceResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'device_code') String deviceCode,@JsonKey(name: 'user_code') String userCode,@JsonKey(name: 'verification_url') Uri verificationUrl, int interval,@JsonKey(name: 'expires_in') int expiresIn
});




}
/// @nodoc
class _$YandexDriveDeviceResponseCopyWithImpl<$Res>
    implements $YandexDriveDeviceResponseCopyWith<$Res> {
  _$YandexDriveDeviceResponseCopyWithImpl(this._self, this._then);

  final YandexDriveDeviceResponse _self;
  final $Res Function(YandexDriveDeviceResponse) _then;

/// Create a copy of YandexDriveDeviceResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? deviceCode = null,Object? userCode = null,Object? verificationUrl = null,Object? interval = null,Object? expiresIn = null,}) {
  return _then(YandexDriveDeviceResponse(
deviceCode: null == deviceCode ? _self.deviceCode : deviceCode // ignore: cast_nullable_to_non_nullable
as String,userCode: null == userCode ? _self.userCode : userCode // ignore: cast_nullable_to_non_nullable
as String,verificationUrl: null == verificationUrl ? _self.verificationUrl : verificationUrl // ignore: cast_nullable_to_non_nullable
as Uri,interval: null == interval ? _self.interval : interval // ignore: cast_nullable_to_non_nullable
as int,expiresIn: null == expiresIn ? _self.expiresIn : expiresIn // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [YandexDriveDeviceResponse].
extension YandexDriveDeviceResponsePatterns on YandexDriveDeviceResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _YandexDriveDeviceResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _YandexDriveDeviceResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _YandexDriveDeviceResponse value)  $default,){
final _that = this;
switch (_that) {
case _YandexDriveDeviceResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _YandexDriveDeviceResponse value)?  $default,){
final _that = this;
switch (_that) {
case _YandexDriveDeviceResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'device_code')  String deviceCode, @JsonKey(name: 'user_code')  String userCode, @JsonKey(name: 'verification_url')  Uri verificationUrl,  int interval, @JsonKey(name: 'expires_in')  int expiresIn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _YandexDriveDeviceResponse() when $default != null:
return $default(_that.deviceCode,_that.userCode,_that.verificationUrl,_that.interval,_that.expiresIn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'device_code')  String deviceCode, @JsonKey(name: 'user_code')  String userCode, @JsonKey(name: 'verification_url')  Uri verificationUrl,  int interval, @JsonKey(name: 'expires_in')  int expiresIn)  $default,) {final _that = this;
switch (_that) {
case _YandexDriveDeviceResponse():
return $default(_that.deviceCode,_that.userCode,_that.verificationUrl,_that.interval,_that.expiresIn);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'device_code')  String deviceCode, @JsonKey(name: 'user_code')  String userCode, @JsonKey(name: 'verification_url')  Uri verificationUrl,  int interval, @JsonKey(name: 'expires_in')  int expiresIn)?  $default,) {final _that = this;
switch (_that) {
case _YandexDriveDeviceResponse() when $default != null:
return $default(_that.deviceCode,_that.userCode,_that.verificationUrl,_that.interval,_that.expiresIn);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _YandexDriveDeviceResponse implements YandexDriveDeviceResponse {
  const _YandexDriveDeviceResponse({@JsonKey(name: 'device_code') required this.deviceCode, @JsonKey(name: 'user_code') required this.userCode, @JsonKey(name: 'verification_url') required this.verificationUrl, required this.interval, @JsonKey(name: 'expires_in') required this.expiresIn});
  factory _YandexDriveDeviceResponse.fromJson(Map<String, dynamic> json) => _$YandexDriveDeviceResponseFromJson(json);

@override@JsonKey(name: 'device_code') final  String deviceCode;
@override@JsonKey(name: 'user_code') final  String userCode;
@override@JsonKey(name: 'verification_url') final  Uri verificationUrl;
@override final  int interval;
@override@JsonKey(name: 'expires_in') final  int expiresIn;

/// Create a copy of YandexDriveDeviceResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$YandexDriveDeviceResponseCopyWith<_YandexDriveDeviceResponse> get copyWith => __$YandexDriveDeviceResponseCopyWithImpl<_YandexDriveDeviceResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$YandexDriveDeviceResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _YandexDriveDeviceResponse&&(identical(other.deviceCode, deviceCode) || other.deviceCode == deviceCode)&&(identical(other.userCode, userCode) || other.userCode == userCode)&&(identical(other.verificationUrl, verificationUrl) || other.verificationUrl == verificationUrl)&&(identical(other.interval, interval) || other.interval == interval)&&(identical(other.expiresIn, expiresIn) || other.expiresIn == expiresIn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,deviceCode,userCode,verificationUrl,interval,expiresIn);
}



}

/// @nodoc
abstract mixin class _$YandexDriveDeviceResponseCopyWith<$Res> implements $YandexDriveDeviceResponseCopyWith<$Res> {
  factory _$YandexDriveDeviceResponseCopyWith(_YandexDriveDeviceResponse value, $Res Function(_YandexDriveDeviceResponse) _then) = __$YandexDriveDeviceResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'device_code') String deviceCode,@JsonKey(name: 'user_code') String userCode,@JsonKey(name: 'verification_url') Uri verificationUrl, int interval,@JsonKey(name: 'expires_in') int expiresIn
});




}
/// @nodoc
class __$YandexDriveDeviceResponseCopyWithImpl<$Res>
    implements _$YandexDriveDeviceResponseCopyWith<$Res> {
  __$YandexDriveDeviceResponseCopyWithImpl(this._self, this._then);

  final _YandexDriveDeviceResponse _self;
  final $Res Function(_YandexDriveDeviceResponse) _then;

/// Create a copy of YandexDriveDeviceResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deviceCode = null,Object? userCode = null,Object? verificationUrl = null,Object? interval = null,Object? expiresIn = null,}) {
  return _then(_YandexDriveDeviceResponse(
deviceCode: null == deviceCode ? _self.deviceCode : deviceCode // ignore: cast_nullable_to_non_nullable
as String,userCode: null == userCode ? _self.userCode : userCode // ignore: cast_nullable_to_non_nullable
as String,verificationUrl: null == verificationUrl ? _self.verificationUrl : verificationUrl // ignore: cast_nullable_to_non_nullable
as Uri,interval: null == interval ? _self.interval : interval // ignore: cast_nullable_to_non_nullable
as int,expiresIn: null == expiresIn ? _self.expiresIn : expiresIn // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$YandexDriveDiskInfo {

 YandexDriveUser get user;
/// Create a copy of YandexDriveDiskInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$YandexDriveDiskInfoCopyWith<YandexDriveDiskInfo> get copyWith => _$YandexDriveDiskInfoCopyWithImpl<YandexDriveDiskInfo>(this as YandexDriveDiskInfo, _$identity);

  /// Serializes this YandexDriveDiskInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as YandexDriveDiskInfo;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is YandexDriveDiskInfo&&(identical(other.user, _this.user) || other.user == _this.user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as YandexDriveDiskInfo;
  return Object.hash(runtimeType,_this.user);
}

@override
String toString() {
  final _this = this as YandexDriveDiskInfo;
  return 'YandexDriveDiskInfo(user: ${_this.user})';
}


}

/// @nodoc
abstract mixin class $YandexDriveDiskInfoCopyWith<$Res>  {
  factory $YandexDriveDiskInfoCopyWith(YandexDriveDiskInfo value, $Res Function(YandexDriveDiskInfo) _then) = _$YandexDriveDiskInfoCopyWithImpl;
@useResult
$Res call({
 YandexDriveUser user
});


$YandexDriveUserCopyWith<$Res> get user;

}
/// @nodoc
class _$YandexDriveDiskInfoCopyWithImpl<$Res>
    implements $YandexDriveDiskInfoCopyWith<$Res> {
  _$YandexDriveDiskInfoCopyWithImpl(this._self, this._then);

  final YandexDriveDiskInfo _self;
  final $Res Function(YandexDriveDiskInfo) _then;

/// Create a copy of YandexDriveDiskInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? user = null,}) {
  return _then(YandexDriveDiskInfo(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as YandexDriveUser,
  ));
}
/// Create a copy of YandexDriveDiskInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$YandexDriveUserCopyWith<$Res> get user {
  
  return $YandexDriveUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [YandexDriveDiskInfo].
extension YandexDriveDiskInfoPatterns on YandexDriveDiskInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _YandexDriveDiskInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _YandexDriveDiskInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _YandexDriveDiskInfo value)  $default,){
final _that = this;
switch (_that) {
case _YandexDriveDiskInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _YandexDriveDiskInfo value)?  $default,){
final _that = this;
switch (_that) {
case _YandexDriveDiskInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( YandexDriveUser user)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _YandexDriveDiskInfo() when $default != null:
return $default(_that.user);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( YandexDriveUser user)  $default,) {final _that = this;
switch (_that) {
case _YandexDriveDiskInfo():
return $default(_that.user);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( YandexDriveUser user)?  $default,) {final _that = this;
switch (_that) {
case _YandexDriveDiskInfo() when $default != null:
return $default(_that.user);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _YandexDriveDiskInfo implements YandexDriveDiskInfo {
  const _YandexDriveDiskInfo({required this.user});
  factory _YandexDriveDiskInfo.fromJson(Map<String, dynamic> json) => _$YandexDriveDiskInfoFromJson(json);

@override final  YandexDriveUser user;

/// Create a copy of YandexDriveDiskInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$YandexDriveDiskInfoCopyWith<_YandexDriveDiskInfo> get copyWith => __$YandexDriveDiskInfoCopyWithImpl<_YandexDriveDiskInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$YandexDriveDiskInfoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _YandexDriveDiskInfo&&(identical(other.user, user) || other.user == user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,user);
}

@override
String toString() {
    return 'YandexDriveDiskInfo(user: $user)';
}


}

/// @nodoc
abstract mixin class _$YandexDriveDiskInfoCopyWith<$Res> implements $YandexDriveDiskInfoCopyWith<$Res> {
  factory _$YandexDriveDiskInfoCopyWith(_YandexDriveDiskInfo value, $Res Function(_YandexDriveDiskInfo) _then) = __$YandexDriveDiskInfoCopyWithImpl;
@override @useResult
$Res call({
 YandexDriveUser user
});


@override $YandexDriveUserCopyWith<$Res> get user;

}
/// @nodoc
class __$YandexDriveDiskInfoCopyWithImpl<$Res>
    implements _$YandexDriveDiskInfoCopyWith<$Res> {
  __$YandexDriveDiskInfoCopyWithImpl(this._self, this._then);

  final _YandexDriveDiskInfo _self;
  final $Res Function(_YandexDriveDiskInfo) _then;

/// Create a copy of YandexDriveDiskInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? user = null,}) {
  return _then(_YandexDriveDiskInfo(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as YandexDriveUser,
  ));
}

/// Create a copy of YandexDriveDiskInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$YandexDriveUserCopyWith<$Res> get user {
  
  return $YandexDriveUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// @nodoc
mixin _$YandexDriveUser {

 String get uid; String get login;@JsonKey(name: 'display_name') String get displayName;
/// Create a copy of YandexDriveUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$YandexDriveUserCopyWith<YandexDriveUser> get copyWith => _$YandexDriveUserCopyWithImpl<YandexDriveUser>(this as YandexDriveUser, _$identity);

  /// Serializes this YandexDriveUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as YandexDriveUser;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is YandexDriveUser&&(identical(other.uid, _this.uid) || other.uid == _this.uid)&&(identical(other.login, _this.login) || other.login == _this.login)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as YandexDriveUser;
  return Object.hash(runtimeType,_this.uid,_this.login,_this.displayName);
}

@override
String toString() {
  final _this = this as YandexDriveUser;
  return 'YandexDriveUser(uid: ${_this.uid}, login: ${_this.login}, displayName: ${_this.displayName})';
}


}

/// @nodoc
abstract mixin class $YandexDriveUserCopyWith<$Res>  {
  factory $YandexDriveUserCopyWith(YandexDriveUser value, $Res Function(YandexDriveUser) _then) = _$YandexDriveUserCopyWithImpl;
@useResult
$Res call({
 String uid, String login,@JsonKey(name: 'display_name') String displayName
});




}
/// @nodoc
class _$YandexDriveUserCopyWithImpl<$Res>
    implements $YandexDriveUserCopyWith<$Res> {
  _$YandexDriveUserCopyWithImpl(this._self, this._then);

  final YandexDriveUser _self;
  final $Res Function(YandexDriveUser) _then;

/// Create a copy of YandexDriveUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uid = null,Object? login = null,Object? displayName = null,}) {
  return _then(YandexDriveUser(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,login: null == login ? _self.login : login // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [YandexDriveUser].
extension YandexDriveUserPatterns on YandexDriveUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _YandexDriveUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _YandexDriveUser() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _YandexDriveUser value)  $default,){
final _that = this;
switch (_that) {
case _YandexDriveUser():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _YandexDriveUser value)?  $default,){
final _that = this;
switch (_that) {
case _YandexDriveUser() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String uid,  String login, @JsonKey(name: 'display_name')  String displayName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _YandexDriveUser() when $default != null:
return $default(_that.uid,_that.login,_that.displayName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String uid,  String login, @JsonKey(name: 'display_name')  String displayName)  $default,) {final _that = this;
switch (_that) {
case _YandexDriveUser():
return $default(_that.uid,_that.login,_that.displayName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String uid,  String login, @JsonKey(name: 'display_name')  String displayName)?  $default,) {final _that = this;
switch (_that) {
case _YandexDriveUser() when $default != null:
return $default(_that.uid,_that.login,_that.displayName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _YandexDriveUser implements YandexDriveUser {
  const _YandexDriveUser({required this.uid, this.login = '', @JsonKey(name: 'display_name') this.displayName = ''});
  factory _YandexDriveUser.fromJson(Map<String, dynamic> json) => _$YandexDriveUserFromJson(json);

@override final  String uid;
@override@JsonKey() final  String login;
@override@JsonKey(name: 'display_name') final  String displayName;

/// Create a copy of YandexDriveUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$YandexDriveUserCopyWith<_YandexDriveUser> get copyWith => __$YandexDriveUserCopyWithImpl<_YandexDriveUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$YandexDriveUserToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _YandexDriveUser&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.login, login) || other.login == login)&&(identical(other.displayName, displayName) || other.displayName == displayName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,uid,login,displayName);
}

@override
String toString() {
    return 'YandexDriveUser(uid: $uid, login: $login, displayName: $displayName)';
}


}

/// @nodoc
abstract mixin class _$YandexDriveUserCopyWith<$Res> implements $YandexDriveUserCopyWith<$Res> {
  factory _$YandexDriveUserCopyWith(_YandexDriveUser value, $Res Function(_YandexDriveUser) _then) = __$YandexDriveUserCopyWithImpl;
@override @useResult
$Res call({
 String uid, String login,@JsonKey(name: 'display_name') String displayName
});




}
/// @nodoc
class __$YandexDriveUserCopyWithImpl<$Res>
    implements _$YandexDriveUserCopyWith<$Res> {
  __$YandexDriveUserCopyWithImpl(this._self, this._then);

  final _YandexDriveUser _self;
  final $Res Function(_YandexDriveUser) _then;

/// Create a copy of YandexDriveUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uid = null,Object? login = null,Object? displayName = null,}) {
  return _then(_YandexDriveUser(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,login: null == login ? _self.login : login // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$YandexDriveDownloadLink {

 Uri get href;
/// Create a copy of YandexDriveDownloadLink
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$YandexDriveDownloadLinkCopyWith<YandexDriveDownloadLink> get copyWith => _$YandexDriveDownloadLinkCopyWithImpl<YandexDriveDownloadLink>(this as YandexDriveDownloadLink, _$identity);

  /// Serializes this YandexDriveDownloadLink to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as YandexDriveDownloadLink;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is YandexDriveDownloadLink&&(identical(other.href, _this.href) || other.href == _this.href));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as YandexDriveDownloadLink;
  return Object.hash(runtimeType,_this.href);
}

@override
String toString() {
  final _this = this as YandexDriveDownloadLink;
  return 'YandexDriveDownloadLink(href: ${_this.href})';
}


}

/// @nodoc
abstract mixin class $YandexDriveDownloadLinkCopyWith<$Res>  {
  factory $YandexDriveDownloadLinkCopyWith(YandexDriveDownloadLink value, $Res Function(YandexDriveDownloadLink) _then) = _$YandexDriveDownloadLinkCopyWithImpl;
@useResult
$Res call({
 Uri href
});




}
/// @nodoc
class _$YandexDriveDownloadLinkCopyWithImpl<$Res>
    implements $YandexDriveDownloadLinkCopyWith<$Res> {
  _$YandexDriveDownloadLinkCopyWithImpl(this._self, this._then);

  final YandexDriveDownloadLink _self;
  final $Res Function(YandexDriveDownloadLink) _then;

/// Create a copy of YandexDriveDownloadLink
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? href = null,}) {
  return _then(YandexDriveDownloadLink(
href: null == href ? _self.href : href // ignore: cast_nullable_to_non_nullable
as Uri,
  ));
}

}


/// Adds pattern-matching-related methods to [YandexDriveDownloadLink].
extension YandexDriveDownloadLinkPatterns on YandexDriveDownloadLink {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _YandexDriveDownloadLink value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _YandexDriveDownloadLink() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _YandexDriveDownloadLink value)  $default,){
final _that = this;
switch (_that) {
case _YandexDriveDownloadLink():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _YandexDriveDownloadLink value)?  $default,){
final _that = this;
switch (_that) {
case _YandexDriveDownloadLink() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Uri href)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _YandexDriveDownloadLink() when $default != null:
return $default(_that.href);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Uri href)  $default,) {final _that = this;
switch (_that) {
case _YandexDriveDownloadLink():
return $default(_that.href);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Uri href)?  $default,) {final _that = this;
switch (_that) {
case _YandexDriveDownloadLink() when $default != null:
return $default(_that.href);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _YandexDriveDownloadLink implements YandexDriveDownloadLink {
  const _YandexDriveDownloadLink({required this.href});
  factory _YandexDriveDownloadLink.fromJson(Map<String, dynamic> json) => _$YandexDriveDownloadLinkFromJson(json);

@override final  Uri href;

/// Create a copy of YandexDriveDownloadLink
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$YandexDriveDownloadLinkCopyWith<_YandexDriveDownloadLink> get copyWith => __$YandexDriveDownloadLinkCopyWithImpl<_YandexDriveDownloadLink>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$YandexDriveDownloadLinkToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _YandexDriveDownloadLink&&(identical(other.href, href) || other.href == href));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,href);
}

@override
String toString() {
    return 'YandexDriveDownloadLink(href: $href)';
}


}

/// @nodoc
abstract mixin class _$YandexDriveDownloadLinkCopyWith<$Res> implements $YandexDriveDownloadLinkCopyWith<$Res> {
  factory _$YandexDriveDownloadLinkCopyWith(_YandexDriveDownloadLink value, $Res Function(_YandexDriveDownloadLink) _then) = __$YandexDriveDownloadLinkCopyWithImpl;
@override @useResult
$Res call({
 Uri href
});




}
/// @nodoc
class __$YandexDriveDownloadLinkCopyWithImpl<$Res>
    implements _$YandexDriveDownloadLinkCopyWith<$Res> {
  __$YandexDriveDownloadLinkCopyWithImpl(this._self, this._then);

  final _YandexDriveDownloadLink _self;
  final $Res Function(_YandexDriveDownloadLink) _then;

/// Create a copy of YandexDriveDownloadLink
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? href = null,}) {
  return _then(_YandexDriveDownloadLink(
href: null == href ? _self.href : href // ignore: cast_nullable_to_non_nullable
as Uri,
  ));
}


}

// dart format on
