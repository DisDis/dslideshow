// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'system_info_commands.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GetSystemInfoCommand {

 int get id; String get type;
/// Create a copy of GetSystemInfoCommand
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetSystemInfoCommandCopyWith<GetSystemInfoCommand> get copyWith => _$GetSystemInfoCommandCopyWithImpl<GetSystemInfoCommand>(this as GetSystemInfoCommand, _$identity);

  /// Serializes this GetSystemInfoCommand to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetSystemInfoCommand&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type);

@override
String toString() {
  return 'GetSystemInfoCommand(id: $id, type: $type)';
}


}

/// @nodoc
abstract mixin class $GetSystemInfoCommandCopyWith<$Res>  {
  factory $GetSystemInfoCommandCopyWith(GetSystemInfoCommand value, $Res Function(GetSystemInfoCommand) _then) = _$GetSystemInfoCommandCopyWithImpl;
@useResult
$Res call({
 int id, String type
});




}
/// @nodoc
class _$GetSystemInfoCommandCopyWithImpl<$Res>
    implements $GetSystemInfoCommandCopyWith<$Res> {
  _$GetSystemInfoCommandCopyWithImpl(this._self, this._then);

  final GetSystemInfoCommand _self;
  final $Res Function(GetSystemInfoCommand) _then;

/// Create a copy of GetSystemInfoCommand
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GetSystemInfoCommand].
extension GetSystemInfoCommandPatterns on GetSystemInfoCommand {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetSystemInfoCommand value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetSystemInfoCommand() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetSystemInfoCommand value)  $default,){
final _that = this;
switch (_that) {
case _GetSystemInfoCommand():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetSystemInfoCommand value)?  $default,){
final _that = this;
switch (_that) {
case _GetSystemInfoCommand() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetSystemInfoCommand() when $default != null:
return $default(_that.id,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String type)  $default,) {final _that = this;
switch (_that) {
case _GetSystemInfoCommand():
return $default(_that.id,_that.type);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String type)?  $default,) {final _that = this;
switch (_that) {
case _GetSystemInfoCommand() when $default != null:
return $default(_that.id,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GetSystemInfoCommand implements GetSystemInfoCommand {
  const _GetSystemInfoCommand({required this.id, this.type = GetSystemInfoCommand.TYPE});
  factory _GetSystemInfoCommand.fromJson(Map<String, dynamic> json) => _$GetSystemInfoCommandFromJson(json);

@override final  int id;
@override@JsonKey() final  String type;

/// Create a copy of GetSystemInfoCommand
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetSystemInfoCommandCopyWith<_GetSystemInfoCommand> get copyWith => __$GetSystemInfoCommandCopyWithImpl<_GetSystemInfoCommand>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GetSystemInfoCommandToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetSystemInfoCommand&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type);

@override
String toString() {
  return 'GetSystemInfoCommand(id: $id, type: $type)';
}


}

/// @nodoc
abstract mixin class _$GetSystemInfoCommandCopyWith<$Res> implements $GetSystemInfoCommandCopyWith<$Res> {
  factory _$GetSystemInfoCommandCopyWith(_GetSystemInfoCommand value, $Res Function(_GetSystemInfoCommand) _then) = __$GetSystemInfoCommandCopyWithImpl;
@override @useResult
$Res call({
 int id, String type
});




}
/// @nodoc
class __$GetSystemInfoCommandCopyWithImpl<$Res>
    implements _$GetSystemInfoCommandCopyWith<$Res> {
  __$GetSystemInfoCommandCopyWithImpl(this._self, this._then);

  final _GetSystemInfoCommand _self;
  final $Res Function(_GetSystemInfoCommand) _then;

/// Create a copy of GetSystemInfoCommand
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,}) {
  return _then(_GetSystemInfoCommand(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$GetSystemInfoCommandResult {

 SystemInfo get systemInfo; int get id;
/// Create a copy of GetSystemInfoCommandResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetSystemInfoCommandResultCopyWith<GetSystemInfoCommandResult> get copyWith => _$GetSystemInfoCommandResultCopyWithImpl<GetSystemInfoCommandResult>(this as GetSystemInfoCommandResult, _$identity);

  /// Serializes this GetSystemInfoCommandResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetSystemInfoCommandResult&&(identical(other.systemInfo, systemInfo) || other.systemInfo == systemInfo)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,systemInfo,id);

@override
String toString() {
  return 'GetSystemInfoCommandResult(systemInfo: $systemInfo, id: $id)';
}


}

/// @nodoc
abstract mixin class $GetSystemInfoCommandResultCopyWith<$Res>  {
  factory $GetSystemInfoCommandResultCopyWith(GetSystemInfoCommandResult value, $Res Function(GetSystemInfoCommandResult) _then) = _$GetSystemInfoCommandResultCopyWithImpl;
@useResult
$Res call({
 SystemInfo systemInfo, int id
});


$SystemInfoCopyWith<$Res> get systemInfo;

}
/// @nodoc
class _$GetSystemInfoCommandResultCopyWithImpl<$Res>
    implements $GetSystemInfoCommandResultCopyWith<$Res> {
  _$GetSystemInfoCommandResultCopyWithImpl(this._self, this._then);

  final GetSystemInfoCommandResult _self;
  final $Res Function(GetSystemInfoCommandResult) _then;

/// Create a copy of GetSystemInfoCommandResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? systemInfo = null,Object? id = null,}) {
  return _then(_self.copyWith(
systemInfo: null == systemInfo ? _self.systemInfo : systemInfo // ignore: cast_nullable_to_non_nullable
as SystemInfo,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of GetSystemInfoCommandResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SystemInfoCopyWith<$Res> get systemInfo {
  
  return $SystemInfoCopyWith<$Res>(_self.systemInfo, (value) {
    return _then(_self.copyWith(systemInfo: value));
  });
}
}


/// Adds pattern-matching-related methods to [GetSystemInfoCommandResult].
extension GetSystemInfoCommandResultPatterns on GetSystemInfoCommandResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetSystemInfoCommandResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetSystemInfoCommandResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetSystemInfoCommandResult value)  $default,){
final _that = this;
switch (_that) {
case _GetSystemInfoCommandResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetSystemInfoCommandResult value)?  $default,){
final _that = this;
switch (_that) {
case _GetSystemInfoCommandResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SystemInfo systemInfo,  int id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetSystemInfoCommandResult() when $default != null:
return $default(_that.systemInfo,_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SystemInfo systemInfo,  int id)  $default,) {final _that = this;
switch (_that) {
case _GetSystemInfoCommandResult():
return $default(_that.systemInfo,_that.id);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SystemInfo systemInfo,  int id)?  $default,) {final _that = this;
switch (_that) {
case _GetSystemInfoCommandResult() when $default != null:
return $default(_that.systemInfo,_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GetSystemInfoCommandResult implements GetSystemInfoCommandResult {
  const _GetSystemInfoCommandResult({required this.systemInfo, required this.id});
  factory _GetSystemInfoCommandResult.fromJson(Map<String, dynamic> json) => _$GetSystemInfoCommandResultFromJson(json);

@override final  SystemInfo systemInfo;
@override final  int id;

/// Create a copy of GetSystemInfoCommandResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetSystemInfoCommandResultCopyWith<_GetSystemInfoCommandResult> get copyWith => __$GetSystemInfoCommandResultCopyWithImpl<_GetSystemInfoCommandResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GetSystemInfoCommandResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetSystemInfoCommandResult&&(identical(other.systemInfo, systemInfo) || other.systemInfo == systemInfo)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,systemInfo,id);

@override
String toString() {
  return 'GetSystemInfoCommandResult(systemInfo: $systemInfo, id: $id)';
}


}

/// @nodoc
abstract mixin class _$GetSystemInfoCommandResultCopyWith<$Res> implements $GetSystemInfoCommandResultCopyWith<$Res> {
  factory _$GetSystemInfoCommandResultCopyWith(_GetSystemInfoCommandResult value, $Res Function(_GetSystemInfoCommandResult) _then) = __$GetSystemInfoCommandResultCopyWithImpl;
@override @useResult
$Res call({
 SystemInfo systemInfo, int id
});


@override $SystemInfoCopyWith<$Res> get systemInfo;

}
/// @nodoc
class __$GetSystemInfoCommandResultCopyWithImpl<$Res>
    implements _$GetSystemInfoCommandResultCopyWith<$Res> {
  __$GetSystemInfoCommandResultCopyWithImpl(this._self, this._then);

  final _GetSystemInfoCommandResult _self;
  final $Res Function(_GetSystemInfoCommandResult) _then;

/// Create a copy of GetSystemInfoCommandResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? systemInfo = null,Object? id = null,}) {
  return _then(_GetSystemInfoCommandResult(
systemInfo: null == systemInfo ? _self.systemInfo : systemInfo // ignore: cast_nullable_to_non_nullable
as SystemInfo,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of GetSystemInfoCommandResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SystemInfoCopyWith<$Res> get systemInfo {
  
  return $SystemInfoCopyWith<$Res>(_self.systemInfo, (value) {
    return _then(_self.copyWith(systemInfo: value));
  });
}
}

// dart format on
