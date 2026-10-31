// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'frame_commands.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FrameState {

 DateTime get sampledAt;@JsonKey(unknownEnumValue: FramePresence.unknown) FramePresence get presence; DateTime? get presenceObservedAt; bool get isScreenLocked; bool? get isScreenOn;@JsonKey(unknownEnumValue: FrameScreenPhase.unknown) FrameScreenPhase get screenPhase;@JsonKey(unknownEnumValue: StorageStatusEnum.off) StorageStatusEnum get storageStatus; String get backendVersion; FrameFrontendState? get frontend;
/// Create a copy of FrameState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FrameStateCopyWith<FrameState> get copyWith => _$FrameStateCopyWithImpl<FrameState>(this as FrameState, _$identity);

  /// Serializes this FrameState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FrameState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FrameState&&(identical(other.sampledAt, _this.sampledAt) || other.sampledAt == _this.sampledAt)&&(identical(other.presence, _this.presence) || other.presence == _this.presence)&&(identical(other.presenceObservedAt, _this.presenceObservedAt) || other.presenceObservedAt == _this.presenceObservedAt)&&(identical(other.isScreenLocked, _this.isScreenLocked) || other.isScreenLocked == _this.isScreenLocked)&&(identical(other.isScreenOn, _this.isScreenOn) || other.isScreenOn == _this.isScreenOn)&&(identical(other.screenPhase, _this.screenPhase) || other.screenPhase == _this.screenPhase)&&(identical(other.storageStatus, _this.storageStatus) || other.storageStatus == _this.storageStatus)&&(identical(other.backendVersion, _this.backendVersion) || other.backendVersion == _this.backendVersion)&&(identical(other.frontend, _this.frontend) || other.frontend == _this.frontend));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FrameState;
  return Object.hash(runtimeType,_this.sampledAt,_this.presence,_this.presenceObservedAt,_this.isScreenLocked,_this.isScreenOn,_this.screenPhase,_this.storageStatus,_this.backendVersion,_this.frontend);
}

@override
String toString() {
  final _this = this as FrameState;
  return 'FrameState(sampledAt: ${_this.sampledAt}, presence: ${_this.presence}, presenceObservedAt: ${_this.presenceObservedAt}, isScreenLocked: ${_this.isScreenLocked}, isScreenOn: ${_this.isScreenOn}, screenPhase: ${_this.screenPhase}, storageStatus: ${_this.storageStatus}, backendVersion: ${_this.backendVersion}, frontend: ${_this.frontend})';
}


}

/// @nodoc
abstract mixin class $FrameStateCopyWith<$Res>  {
  factory $FrameStateCopyWith(FrameState value, $Res Function(FrameState) _then) = _$FrameStateCopyWithImpl;
@useResult
$Res call({
 DateTime sampledAt,@JsonKey(unknownEnumValue: FramePresence.unknown) FramePresence presence, DateTime? presenceObservedAt, bool isScreenLocked, bool? isScreenOn,@JsonKey(unknownEnumValue: FrameScreenPhase.unknown) FrameScreenPhase screenPhase,@JsonKey(unknownEnumValue: StorageStatusEnum.off) StorageStatusEnum storageStatus, String backendVersion, FrameFrontendState? frontend
});




}
/// @nodoc
class _$FrameStateCopyWithImpl<$Res>
    implements $FrameStateCopyWith<$Res> {
  _$FrameStateCopyWithImpl(this._self, this._then);

  final FrameState _self;
  final $Res Function(FrameState) _then;

/// Create a copy of FrameState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sampledAt = null,Object? presence = null,Object? presenceObservedAt = freezed,Object? isScreenLocked = null,Object? isScreenOn = freezed,Object? screenPhase = null,Object? storageStatus = null,Object? backendVersion = null,Object? frontend = freezed,}) {
  return _then(FrameState(
sampledAt: null == sampledAt ? _self.sampledAt : sampledAt // ignore: cast_nullable_to_non_nullable
as DateTime,presence: null == presence ? _self.presence : presence // ignore: cast_nullable_to_non_nullable
as FramePresence,presenceObservedAt: freezed == presenceObservedAt ? _self.presenceObservedAt : presenceObservedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isScreenLocked: null == isScreenLocked ? _self.isScreenLocked : isScreenLocked // ignore: cast_nullable_to_non_nullable
as bool,isScreenOn: freezed == isScreenOn ? _self.isScreenOn : isScreenOn // ignore: cast_nullable_to_non_nullable
as bool?,screenPhase: null == screenPhase ? _self.screenPhase : screenPhase // ignore: cast_nullable_to_non_nullable
as FrameScreenPhase,storageStatus: null == storageStatus ? _self.storageStatus : storageStatus // ignore: cast_nullable_to_non_nullable
as StorageStatusEnum,backendVersion: null == backendVersion ? _self.backendVersion : backendVersion // ignore: cast_nullable_to_non_nullable
as String,frontend: freezed == frontend ? _self.frontend : frontend // ignore: cast_nullable_to_non_nullable
as FrameFrontendState?,
  ));
}

}


/// Adds pattern-matching-related methods to [FrameState].
extension FrameStatePatterns on FrameState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FrameState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FrameState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FrameState value)  $default,){
final _that = this;
switch (_that) {
case _FrameState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FrameState value)?  $default,){
final _that = this;
switch (_that) {
case _FrameState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime sampledAt, @JsonKey(unknownEnumValue: FramePresence.unknown)  FramePresence presence,  DateTime? presenceObservedAt,  bool isScreenLocked,  bool? isScreenOn, @JsonKey(unknownEnumValue: FrameScreenPhase.unknown)  FrameScreenPhase screenPhase, @JsonKey(unknownEnumValue: StorageStatusEnum.off)  StorageStatusEnum storageStatus,  String backendVersion,  FrameFrontendState? frontend)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FrameState() when $default != null:
return $default(_that.sampledAt,_that.presence,_that.presenceObservedAt,_that.isScreenLocked,_that.isScreenOn,_that.screenPhase,_that.storageStatus,_that.backendVersion,_that.frontend);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime sampledAt, @JsonKey(unknownEnumValue: FramePresence.unknown)  FramePresence presence,  DateTime? presenceObservedAt,  bool isScreenLocked,  bool? isScreenOn, @JsonKey(unknownEnumValue: FrameScreenPhase.unknown)  FrameScreenPhase screenPhase, @JsonKey(unknownEnumValue: StorageStatusEnum.off)  StorageStatusEnum storageStatus,  String backendVersion,  FrameFrontendState? frontend)  $default,) {final _that = this;
switch (_that) {
case _FrameState():
return $default(_that.sampledAt,_that.presence,_that.presenceObservedAt,_that.isScreenLocked,_that.isScreenOn,_that.screenPhase,_that.storageStatus,_that.backendVersion,_that.frontend);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime sampledAt, @JsonKey(unknownEnumValue: FramePresence.unknown)  FramePresence presence,  DateTime? presenceObservedAt,  bool isScreenLocked,  bool? isScreenOn, @JsonKey(unknownEnumValue: FrameScreenPhase.unknown)  FrameScreenPhase screenPhase, @JsonKey(unknownEnumValue: StorageStatusEnum.off)  StorageStatusEnum storageStatus,  String backendVersion,  FrameFrontendState? frontend)?  $default,) {final _that = this;
switch (_that) {
case _FrameState() when $default != null:
return $default(_that.sampledAt,_that.presence,_that.presenceObservedAt,_that.isScreenLocked,_that.isScreenOn,_that.screenPhase,_that.storageStatus,_that.backendVersion,_that.frontend);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _FrameState implements FrameState {
  const _FrameState({required this.sampledAt, @JsonKey(unknownEnumValue: FramePresence.unknown) this.presence = FramePresence.unknown, this.presenceObservedAt, required this.isScreenLocked, required this.isScreenOn, @JsonKey(unknownEnumValue: FrameScreenPhase.unknown) this.screenPhase = FrameScreenPhase.unknown, @JsonKey(unknownEnumValue: StorageStatusEnum.off) this.storageStatus = StorageStatusEnum.off, required this.backendVersion, this.frontend});
  factory _FrameState.fromJson(Map<String, dynamic> json) => _$FrameStateFromJson(json);

@override final  DateTime sampledAt;
@override@JsonKey(unknownEnumValue: FramePresence.unknown) final  FramePresence presence;
@override final  DateTime? presenceObservedAt;
@override final  bool isScreenLocked;
@override final  bool? isScreenOn;
@override@JsonKey(unknownEnumValue: FrameScreenPhase.unknown) final  FrameScreenPhase screenPhase;
@override@JsonKey(unknownEnumValue: StorageStatusEnum.off) final  StorageStatusEnum storageStatus;
@override final  String backendVersion;
@override final  FrameFrontendState? frontend;

/// Create a copy of FrameState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FrameStateCopyWith<_FrameState> get copyWith => __$FrameStateCopyWithImpl<_FrameState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FrameStateToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FrameState&&(identical(other.sampledAt, sampledAt) || other.sampledAt == sampledAt)&&(identical(other.presence, presence) || other.presence == presence)&&(identical(other.presenceObservedAt, presenceObservedAt) || other.presenceObservedAt == presenceObservedAt)&&(identical(other.isScreenLocked, isScreenLocked) || other.isScreenLocked == isScreenLocked)&&(identical(other.isScreenOn, isScreenOn) || other.isScreenOn == isScreenOn)&&(identical(other.screenPhase, screenPhase) || other.screenPhase == screenPhase)&&(identical(other.storageStatus, storageStatus) || other.storageStatus == storageStatus)&&(identical(other.backendVersion, backendVersion) || other.backendVersion == backendVersion)&&(identical(other.frontend, frontend) || other.frontend == frontend));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,sampledAt,presence,presenceObservedAt,isScreenLocked,isScreenOn,screenPhase,storageStatus,backendVersion,frontend);
}

@override
String toString() {
    return 'FrameState(sampledAt: $sampledAt, presence: $presence, presenceObservedAt: $presenceObservedAt, isScreenLocked: $isScreenLocked, isScreenOn: $isScreenOn, screenPhase: $screenPhase, storageStatus: $storageStatus, backendVersion: $backendVersion, frontend: $frontend)';
}


}

/// @nodoc
abstract mixin class _$FrameStateCopyWith<$Res> implements $FrameStateCopyWith<$Res> {
  factory _$FrameStateCopyWith(_FrameState value, $Res Function(_FrameState) _then) = __$FrameStateCopyWithImpl;
@override @useResult
$Res call({
 DateTime sampledAt,@JsonKey(unknownEnumValue: FramePresence.unknown) FramePresence presence, DateTime? presenceObservedAt, bool isScreenLocked, bool? isScreenOn,@JsonKey(unknownEnumValue: FrameScreenPhase.unknown) FrameScreenPhase screenPhase,@JsonKey(unknownEnumValue: StorageStatusEnum.off) StorageStatusEnum storageStatus, String backendVersion, FrameFrontendState? frontend
});




}
/// @nodoc
class __$FrameStateCopyWithImpl<$Res>
    implements _$FrameStateCopyWith<$Res> {
  __$FrameStateCopyWithImpl(this._self, this._then);

  final _FrameState _self;
  final $Res Function(_FrameState) _then;

/// Create a copy of FrameState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sampledAt = null,Object? presence = null,Object? presenceObservedAt = freezed,Object? isScreenLocked = null,Object? isScreenOn = freezed,Object? screenPhase = null,Object? storageStatus = null,Object? backendVersion = null,Object? frontend = freezed,}) {
  return _then(_FrameState(
sampledAt: null == sampledAt ? _self.sampledAt : sampledAt // ignore: cast_nullable_to_non_nullable
as DateTime,presence: null == presence ? _self.presence : presence // ignore: cast_nullable_to_non_nullable
as FramePresence,presenceObservedAt: freezed == presenceObservedAt ? _self.presenceObservedAt : presenceObservedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isScreenLocked: null == isScreenLocked ? _self.isScreenLocked : isScreenLocked // ignore: cast_nullable_to_non_nullable
as bool,isScreenOn: freezed == isScreenOn ? _self.isScreenOn : isScreenOn // ignore: cast_nullable_to_non_nullable
as bool?,screenPhase: null == screenPhase ? _self.screenPhase : screenPhase // ignore: cast_nullable_to_non_nullable
as FrameScreenPhase,storageStatus: null == storageStatus ? _self.storageStatus : storageStatus // ignore: cast_nullable_to_non_nullable
as StorageStatusEnum,backendVersion: null == backendVersion ? _self.backendVersion : backendVersion // ignore: cast_nullable_to_non_nullable
as String,frontend: freezed == frontend ? _self.frontend : frontend // ignore: cast_nullable_to_non_nullable
as FrameFrontendState?,
  ));
}


}

// dart format on
