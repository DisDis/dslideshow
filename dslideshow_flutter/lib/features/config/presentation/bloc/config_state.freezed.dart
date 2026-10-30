// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'config_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ConfigState {

 ConfigAccessStatus get access; ConfigNetworkStatus get network; ConfigExitStatus get exit; String? get code; Uri? get address; ConfigFailureKind? get startFailure; ConfigFailureKind? get networkFailure; ConfigFailureKind? get stopFailure; Set<ConfigOperation> get pending;
/// Create a copy of ConfigState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConfigStateCopyWith<ConfigState> get copyWith => _$ConfigStateCopyWithImpl<ConfigState>(this as ConfigState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ConfigState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConfigState&&(identical(other.access, _this.access) || other.access == _this.access)&&(identical(other.network, _this.network) || other.network == _this.network)&&(identical(other.exit, _this.exit) || other.exit == _this.exit)&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.address, _this.address) || other.address == _this.address)&&(identical(other.startFailure, _this.startFailure) || other.startFailure == _this.startFailure)&&(identical(other.networkFailure, _this.networkFailure) || other.networkFailure == _this.networkFailure)&&(identical(other.stopFailure, _this.stopFailure) || other.stopFailure == _this.stopFailure)&&const DeepCollectionEquality().equals(other.pending, _this.pending));
}


@override
int get hashCode {
  final _this = this as ConfigState;
  return Object.hash(runtimeType,_this.access,_this.network,_this.exit,_this.code,_this.address,_this.startFailure,_this.networkFailure,_this.stopFailure,const DeepCollectionEquality().hash(_this.pending));
}

@override
String toString() {
  final _this = this as ConfigState;
  return 'ConfigState(access: ${_this.access}, network: ${_this.network}, exit: ${_this.exit}, code: ${_this.code}, address: ${_this.address}, startFailure: ${_this.startFailure}, networkFailure: ${_this.networkFailure}, stopFailure: ${_this.stopFailure}, pending: ${_this.pending})';
}


}

/// @nodoc
abstract mixin class $ConfigStateCopyWith<$Res>  {
  factory $ConfigStateCopyWith(ConfigState value, $Res Function(ConfigState) _then) = _$ConfigStateCopyWithImpl;
@useResult
$Res call({
 ConfigAccessStatus access, ConfigNetworkStatus network, ConfigExitStatus exit, String? code, Uri? address, ConfigFailureKind? startFailure, ConfigFailureKind? networkFailure, ConfigFailureKind? stopFailure, Set<ConfigOperation> pending
});




}
/// @nodoc
class _$ConfigStateCopyWithImpl<$Res>
    implements $ConfigStateCopyWith<$Res> {
  _$ConfigStateCopyWithImpl(this._self, this._then);

  final ConfigState _self;
  final $Res Function(ConfigState) _then;

/// Create a copy of ConfigState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? access = null,Object? network = null,Object? exit = null,Object? code = freezed,Object? address = freezed,Object? startFailure = freezed,Object? networkFailure = freezed,Object? stopFailure = freezed,Object? pending = null,}) {
  return _then(ConfigState(
access: null == access ? _self.access : access // ignore: cast_nullable_to_non_nullable
as ConfigAccessStatus,network: null == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as ConfigNetworkStatus,exit: null == exit ? _self.exit : exit // ignore: cast_nullable_to_non_nullable
as ConfigExitStatus,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as Uri?,startFailure: freezed == startFailure ? _self.startFailure : startFailure // ignore: cast_nullable_to_non_nullable
as ConfigFailureKind?,networkFailure: freezed == networkFailure ? _self.networkFailure : networkFailure // ignore: cast_nullable_to_non_nullable
as ConfigFailureKind?,stopFailure: freezed == stopFailure ? _self.stopFailure : stopFailure // ignore: cast_nullable_to_non_nullable
as ConfigFailureKind?,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as Set<ConfigOperation>,
  ));
}

}


/// Adds pattern-matching-related methods to [ConfigState].
extension ConfigStatePatterns on ConfigState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConfigState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConfigState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConfigState value)  $default,){
final _that = this;
switch (_that) {
case _ConfigState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConfigState value)?  $default,){
final _that = this;
switch (_that) {
case _ConfigState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ConfigAccessStatus access,  ConfigNetworkStatus network,  ConfigExitStatus exit,  String? code,  Uri? address,  ConfigFailureKind? startFailure,  ConfigFailureKind? networkFailure,  ConfigFailureKind? stopFailure,  Set<ConfigOperation> pending)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConfigState() when $default != null:
return $default(_that.access,_that.network,_that.exit,_that.code,_that.address,_that.startFailure,_that.networkFailure,_that.stopFailure,_that.pending);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ConfigAccessStatus access,  ConfigNetworkStatus network,  ConfigExitStatus exit,  String? code,  Uri? address,  ConfigFailureKind? startFailure,  ConfigFailureKind? networkFailure,  ConfigFailureKind? stopFailure,  Set<ConfigOperation> pending)  $default,) {final _that = this;
switch (_that) {
case _ConfigState():
return $default(_that.access,_that.network,_that.exit,_that.code,_that.address,_that.startFailure,_that.networkFailure,_that.stopFailure,_that.pending);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ConfigAccessStatus access,  ConfigNetworkStatus network,  ConfigExitStatus exit,  String? code,  Uri? address,  ConfigFailureKind? startFailure,  ConfigFailureKind? networkFailure,  ConfigFailureKind? stopFailure,  Set<ConfigOperation> pending)?  $default,) {final _that = this;
switch (_that) {
case _ConfigState() when $default != null:
return $default(_that.access,_that.network,_that.exit,_that.code,_that.address,_that.startFailure,_that.networkFailure,_that.stopFailure,_that.pending);case _:
  return null;

}
}

}

/// @nodoc


class _ConfigState extends ConfigState {
  const _ConfigState({this.access = ConfigAccessStatus.preparing, this.network = ConfigNetworkStatus.preparing, this.exit = ConfigExitStatus.active, this.code, this.address, this.startFailure, this.networkFailure, this.stopFailure,  Set<ConfigOperation> pending = const <ConfigOperation>{}}): _pending = pending,super._();
  

@override@JsonKey() final  ConfigAccessStatus access;
@override@JsonKey() final  ConfigNetworkStatus network;
@override@JsonKey() final  ConfigExitStatus exit;
@override final  String? code;
@override final  Uri? address;
@override final  ConfigFailureKind? startFailure;
@override final  ConfigFailureKind? networkFailure;
@override final  ConfigFailureKind? stopFailure;
 final  Set<ConfigOperation> _pending;
@override@JsonKey() Set<ConfigOperation> get pending {
  if (_pending is EqualUnmodifiableSetView) return _pending;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_pending);
}


/// Create a copy of ConfigState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConfigStateCopyWith<_ConfigState> get copyWith => __$ConfigStateCopyWithImpl<_ConfigState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConfigState&&(identical(other.access, access) || other.access == access)&&(identical(other.network, network) || other.network == network)&&(identical(other.exit, exit) || other.exit == exit)&&(identical(other.code, code) || other.code == code)&&(identical(other.address, address) || other.address == address)&&(identical(other.startFailure, startFailure) || other.startFailure == startFailure)&&(identical(other.networkFailure, networkFailure) || other.networkFailure == networkFailure)&&(identical(other.stopFailure, stopFailure) || other.stopFailure == stopFailure)&&const DeepCollectionEquality().equals(other.pending, _pending));
}


@override
int get hashCode {
    return Object.hash(runtimeType,access,network,exit,code,address,startFailure,networkFailure,stopFailure,const DeepCollectionEquality().hash(_pending));
}

@override
String toString() {
    return 'ConfigState(access: $access, network: $network, exit: $exit, code: $code, address: $address, startFailure: $startFailure, networkFailure: $networkFailure, stopFailure: $stopFailure, pending: $pending)';
}


}

/// @nodoc
abstract mixin class _$ConfigStateCopyWith<$Res> implements $ConfigStateCopyWith<$Res> {
  factory _$ConfigStateCopyWith(_ConfigState value, $Res Function(_ConfigState) _then) = __$ConfigStateCopyWithImpl;
@override @useResult
$Res call({
 ConfigAccessStatus access, ConfigNetworkStatus network, ConfigExitStatus exit, String? code, Uri? address, ConfigFailureKind? startFailure, ConfigFailureKind? networkFailure, ConfigFailureKind? stopFailure, Set<ConfigOperation> pending
});




}
/// @nodoc
class __$ConfigStateCopyWithImpl<$Res>
    implements _$ConfigStateCopyWith<$Res> {
  __$ConfigStateCopyWithImpl(this._self, this._then);

  final _ConfigState _self;
  final $Res Function(_ConfigState) _then;

/// Create a copy of ConfigState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? access = null,Object? network = null,Object? exit = null,Object? code = freezed,Object? address = freezed,Object? startFailure = freezed,Object? networkFailure = freezed,Object? stopFailure = freezed,Object? pending = null,}) {
  return _then(_ConfigState(
access: null == access ? _self.access : access // ignore: cast_nullable_to_non_nullable
as ConfigAccessStatus,network: null == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as ConfigNetworkStatus,exit: null == exit ? _self.exit : exit // ignore: cast_nullable_to_non_nullable
as ConfigExitStatus,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as Uri?,startFailure: freezed == startFailure ? _self.startFailure : startFailure // ignore: cast_nullable_to_non_nullable
as ConfigFailureKind?,networkFailure: freezed == networkFailure ? _self.networkFailure : networkFailure // ignore: cast_nullable_to_non_nullable
as ConfigFailureKind?,stopFailure: freezed == stopFailure ? _self.stopFailure : stopFailure // ignore: cast_nullable_to_non_nullable
as ConfigFailureKind?,pending: null == pending ? _self._pending : pending // ignore: cast_nullable_to_non_nullable
as Set<ConfigOperation>,
  ));
}


}

// dart format on
