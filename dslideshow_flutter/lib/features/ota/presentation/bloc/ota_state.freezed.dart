// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ota_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OtaState {

 OTAInfo get info;
/// Create a copy of OtaState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OtaStateCopyWith<OtaState> get copyWith => _$OtaStateCopyWithImpl<OtaState>(this as OtaState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtaState&&(identical(other.info, info) || other.info == info));
}


@override
int get hashCode => Object.hash(runtimeType,info);

@override
String toString() {
  return 'OtaState(info: $info)';
}


}

/// @nodoc
abstract mixin class $OtaStateCopyWith<$Res>  {
  factory $OtaStateCopyWith(OtaState value, $Res Function(OtaState) _then) = _$OtaStateCopyWithImpl;
@useResult
$Res call({
 OTAInfo info
});


$OTAInfoCopyWith<$Res> get info;

}
/// @nodoc
class _$OtaStateCopyWithImpl<$Res>
    implements $OtaStateCopyWith<$Res> {
  _$OtaStateCopyWithImpl(this._self, this._then);

  final OtaState _self;
  final $Res Function(OtaState) _then;

/// Create a copy of OtaState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? info = null,}) {
  return _then(_self.copyWith(
info: null == info ? _self.info : info // ignore: cast_nullable_to_non_nullable
as OTAInfo,
  ));
}
/// Create a copy of OtaState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OTAInfoCopyWith<$Res> get info {
  
  return $OTAInfoCopyWith<$Res>(_self.info, (value) {
    return _then(_self.copyWith(info: value));
  });
}
}


/// Adds pattern-matching-related methods to [OtaState].
extension OtaStatePatterns on OtaState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OtaInitialState value)?  initial,TResult Function( OtaReadyState value)?  ready,TResult Function( OtaProgressState value)?  progress,TResult Function( OtaSuccessState value)?  success,TResult Function( OtaFailureState value)?  failure,TResult Function( OtaExitState value)?  exit,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OtaInitialState() when initial != null:
return initial(_that);case OtaReadyState() when ready != null:
return ready(_that);case OtaProgressState() when progress != null:
return progress(_that);case OtaSuccessState() when success != null:
return success(_that);case OtaFailureState() when failure != null:
return failure(_that);case OtaExitState() when exit != null:
return exit(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OtaInitialState value)  initial,required TResult Function( OtaReadyState value)  ready,required TResult Function( OtaProgressState value)  progress,required TResult Function( OtaSuccessState value)  success,required TResult Function( OtaFailureState value)  failure,required TResult Function( OtaExitState value)  exit,}){
final _that = this;
switch (_that) {
case OtaInitialState():
return initial(_that);case OtaReadyState():
return ready(_that);case OtaProgressState():
return progress(_that);case OtaSuccessState():
return success(_that);case OtaFailureState():
return failure(_that);case OtaExitState():
return exit(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OtaInitialState value)?  initial,TResult? Function( OtaReadyState value)?  ready,TResult? Function( OtaProgressState value)?  progress,TResult? Function( OtaSuccessState value)?  success,TResult? Function( OtaFailureState value)?  failure,TResult? Function( OtaExitState value)?  exit,}){
final _that = this;
switch (_that) {
case OtaInitialState() when initial != null:
return initial(_that);case OtaReadyState() when ready != null:
return ready(_that);case OtaProgressState() when progress != null:
return progress(_that);case OtaSuccessState() when success != null:
return success(_that);case OtaFailureState() when failure != null:
return failure(_that);case OtaExitState() when exit != null:
return exit(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( OTAInfo info)?  initial,TResult Function( OTAInfo info)?  ready,TResult Function( OTAInfo info)?  progress,TResult Function( OTAInfo info)?  success,TResult Function( OTAInfo info)?  failure,TResult Function( OTAInfo info)?  exit,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OtaInitialState() when initial != null:
return initial(_that.info);case OtaReadyState() when ready != null:
return ready(_that.info);case OtaProgressState() when progress != null:
return progress(_that.info);case OtaSuccessState() when success != null:
return success(_that.info);case OtaFailureState() when failure != null:
return failure(_that.info);case OtaExitState() when exit != null:
return exit(_that.info);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( OTAInfo info)  initial,required TResult Function( OTAInfo info)  ready,required TResult Function( OTAInfo info)  progress,required TResult Function( OTAInfo info)  success,required TResult Function( OTAInfo info)  failure,required TResult Function( OTAInfo info)  exit,}) {final _that = this;
switch (_that) {
case OtaInitialState():
return initial(_that.info);case OtaReadyState():
return ready(_that.info);case OtaProgressState():
return progress(_that.info);case OtaSuccessState():
return success(_that.info);case OtaFailureState():
return failure(_that.info);case OtaExitState():
return exit(_that.info);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( OTAInfo info)?  initial,TResult? Function( OTAInfo info)?  ready,TResult? Function( OTAInfo info)?  progress,TResult? Function( OTAInfo info)?  success,TResult? Function( OTAInfo info)?  failure,TResult? Function( OTAInfo info)?  exit,}) {final _that = this;
switch (_that) {
case OtaInitialState() when initial != null:
return initial(_that.info);case OtaReadyState() when ready != null:
return ready(_that.info);case OtaProgressState() when progress != null:
return progress(_that.info);case OtaSuccessState() when success != null:
return success(_that.info);case OtaFailureState() when failure != null:
return failure(_that.info);case OtaExitState() when exit != null:
return exit(_that.info);case _:
  return null;

}
}

}

/// @nodoc


class OtaInitialState implements OtaState {
  const OtaInitialState({required this.info});
  

@override final  OTAInfo info;

/// Create a copy of OtaState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OtaInitialStateCopyWith<OtaInitialState> get copyWith => _$OtaInitialStateCopyWithImpl<OtaInitialState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtaInitialState&&(identical(other.info, info) || other.info == info));
}


@override
int get hashCode => Object.hash(runtimeType,info);

@override
String toString() {
  return 'OtaState.initial(info: $info)';
}


}

/// @nodoc
abstract mixin class $OtaInitialStateCopyWith<$Res> implements $OtaStateCopyWith<$Res> {
  factory $OtaInitialStateCopyWith(OtaInitialState value, $Res Function(OtaInitialState) _then) = _$OtaInitialStateCopyWithImpl;
@override @useResult
$Res call({
 OTAInfo info
});


@override $OTAInfoCopyWith<$Res> get info;

}
/// @nodoc
class _$OtaInitialStateCopyWithImpl<$Res>
    implements $OtaInitialStateCopyWith<$Res> {
  _$OtaInitialStateCopyWithImpl(this._self, this._then);

  final OtaInitialState _self;
  final $Res Function(OtaInitialState) _then;

/// Create a copy of OtaState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? info = null,}) {
  return _then(OtaInitialState(
info: null == info ? _self.info : info // ignore: cast_nullable_to_non_nullable
as OTAInfo,
  ));
}

/// Create a copy of OtaState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OTAInfoCopyWith<$Res> get info {
  
  return $OTAInfoCopyWith<$Res>(_self.info, (value) {
    return _then(_self.copyWith(info: value));
  });
}
}

/// @nodoc


class OtaReadyState implements OtaState {
  const OtaReadyState({required this.info});
  

@override final  OTAInfo info;

/// Create a copy of OtaState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OtaReadyStateCopyWith<OtaReadyState> get copyWith => _$OtaReadyStateCopyWithImpl<OtaReadyState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtaReadyState&&(identical(other.info, info) || other.info == info));
}


@override
int get hashCode => Object.hash(runtimeType,info);

@override
String toString() {
  return 'OtaState.ready(info: $info)';
}


}

/// @nodoc
abstract mixin class $OtaReadyStateCopyWith<$Res> implements $OtaStateCopyWith<$Res> {
  factory $OtaReadyStateCopyWith(OtaReadyState value, $Res Function(OtaReadyState) _then) = _$OtaReadyStateCopyWithImpl;
@override @useResult
$Res call({
 OTAInfo info
});


@override $OTAInfoCopyWith<$Res> get info;

}
/// @nodoc
class _$OtaReadyStateCopyWithImpl<$Res>
    implements $OtaReadyStateCopyWith<$Res> {
  _$OtaReadyStateCopyWithImpl(this._self, this._then);

  final OtaReadyState _self;
  final $Res Function(OtaReadyState) _then;

/// Create a copy of OtaState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? info = null,}) {
  return _then(OtaReadyState(
info: null == info ? _self.info : info // ignore: cast_nullable_to_non_nullable
as OTAInfo,
  ));
}

/// Create a copy of OtaState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OTAInfoCopyWith<$Res> get info {
  
  return $OTAInfoCopyWith<$Res>(_self.info, (value) {
    return _then(_self.copyWith(info: value));
  });
}
}

/// @nodoc


class OtaProgressState implements OtaState {
  const OtaProgressState({required this.info});
  

@override final  OTAInfo info;

/// Create a copy of OtaState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OtaProgressStateCopyWith<OtaProgressState> get copyWith => _$OtaProgressStateCopyWithImpl<OtaProgressState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtaProgressState&&(identical(other.info, info) || other.info == info));
}


@override
int get hashCode => Object.hash(runtimeType,info);

@override
String toString() {
  return 'OtaState.progress(info: $info)';
}


}

/// @nodoc
abstract mixin class $OtaProgressStateCopyWith<$Res> implements $OtaStateCopyWith<$Res> {
  factory $OtaProgressStateCopyWith(OtaProgressState value, $Res Function(OtaProgressState) _then) = _$OtaProgressStateCopyWithImpl;
@override @useResult
$Res call({
 OTAInfo info
});


@override $OTAInfoCopyWith<$Res> get info;

}
/// @nodoc
class _$OtaProgressStateCopyWithImpl<$Res>
    implements $OtaProgressStateCopyWith<$Res> {
  _$OtaProgressStateCopyWithImpl(this._self, this._then);

  final OtaProgressState _self;
  final $Res Function(OtaProgressState) _then;

/// Create a copy of OtaState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? info = null,}) {
  return _then(OtaProgressState(
info: null == info ? _self.info : info // ignore: cast_nullable_to_non_nullable
as OTAInfo,
  ));
}

/// Create a copy of OtaState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OTAInfoCopyWith<$Res> get info {
  
  return $OTAInfoCopyWith<$Res>(_self.info, (value) {
    return _then(_self.copyWith(info: value));
  });
}
}

/// @nodoc


class OtaSuccessState implements OtaState {
  const OtaSuccessState({required this.info});
  

@override final  OTAInfo info;

/// Create a copy of OtaState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OtaSuccessStateCopyWith<OtaSuccessState> get copyWith => _$OtaSuccessStateCopyWithImpl<OtaSuccessState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtaSuccessState&&(identical(other.info, info) || other.info == info));
}


@override
int get hashCode => Object.hash(runtimeType,info);

@override
String toString() {
  return 'OtaState.success(info: $info)';
}


}

/// @nodoc
abstract mixin class $OtaSuccessStateCopyWith<$Res> implements $OtaStateCopyWith<$Res> {
  factory $OtaSuccessStateCopyWith(OtaSuccessState value, $Res Function(OtaSuccessState) _then) = _$OtaSuccessStateCopyWithImpl;
@override @useResult
$Res call({
 OTAInfo info
});


@override $OTAInfoCopyWith<$Res> get info;

}
/// @nodoc
class _$OtaSuccessStateCopyWithImpl<$Res>
    implements $OtaSuccessStateCopyWith<$Res> {
  _$OtaSuccessStateCopyWithImpl(this._self, this._then);

  final OtaSuccessState _self;
  final $Res Function(OtaSuccessState) _then;

/// Create a copy of OtaState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? info = null,}) {
  return _then(OtaSuccessState(
info: null == info ? _self.info : info // ignore: cast_nullable_to_non_nullable
as OTAInfo,
  ));
}

/// Create a copy of OtaState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OTAInfoCopyWith<$Res> get info {
  
  return $OTAInfoCopyWith<$Res>(_self.info, (value) {
    return _then(_self.copyWith(info: value));
  });
}
}

/// @nodoc


class OtaFailureState implements OtaState {
  const OtaFailureState({required this.info});
  

@override final  OTAInfo info;

/// Create a copy of OtaState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OtaFailureStateCopyWith<OtaFailureState> get copyWith => _$OtaFailureStateCopyWithImpl<OtaFailureState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtaFailureState&&(identical(other.info, info) || other.info == info));
}


@override
int get hashCode => Object.hash(runtimeType,info);

@override
String toString() {
  return 'OtaState.failure(info: $info)';
}


}

/// @nodoc
abstract mixin class $OtaFailureStateCopyWith<$Res> implements $OtaStateCopyWith<$Res> {
  factory $OtaFailureStateCopyWith(OtaFailureState value, $Res Function(OtaFailureState) _then) = _$OtaFailureStateCopyWithImpl;
@override @useResult
$Res call({
 OTAInfo info
});


@override $OTAInfoCopyWith<$Res> get info;

}
/// @nodoc
class _$OtaFailureStateCopyWithImpl<$Res>
    implements $OtaFailureStateCopyWith<$Res> {
  _$OtaFailureStateCopyWithImpl(this._self, this._then);

  final OtaFailureState _self;
  final $Res Function(OtaFailureState) _then;

/// Create a copy of OtaState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? info = null,}) {
  return _then(OtaFailureState(
info: null == info ? _self.info : info // ignore: cast_nullable_to_non_nullable
as OTAInfo,
  ));
}

/// Create a copy of OtaState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OTAInfoCopyWith<$Res> get info {
  
  return $OTAInfoCopyWith<$Res>(_self.info, (value) {
    return _then(_self.copyWith(info: value));
  });
}
}

/// @nodoc


class OtaExitState implements OtaState {
  const OtaExitState({required this.info});
  

@override final  OTAInfo info;

/// Create a copy of OtaState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OtaExitStateCopyWith<OtaExitState> get copyWith => _$OtaExitStateCopyWithImpl<OtaExitState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtaExitState&&(identical(other.info, info) || other.info == info));
}


@override
int get hashCode => Object.hash(runtimeType,info);

@override
String toString() {
  return 'OtaState.exit(info: $info)';
}


}

/// @nodoc
abstract mixin class $OtaExitStateCopyWith<$Res> implements $OtaStateCopyWith<$Res> {
  factory $OtaExitStateCopyWith(OtaExitState value, $Res Function(OtaExitState) _then) = _$OtaExitStateCopyWithImpl;
@override @useResult
$Res call({
 OTAInfo info
});


@override $OTAInfoCopyWith<$Res> get info;

}
/// @nodoc
class _$OtaExitStateCopyWithImpl<$Res>
    implements $OtaExitStateCopyWith<$Res> {
  _$OtaExitStateCopyWithImpl(this._self, this._then);

  final OtaExitState _self;
  final $Res Function(OtaExitState) _then;

/// Create a copy of OtaState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? info = null,}) {
  return _then(OtaExitState(
info: null == info ? _self.info : info // ignore: cast_nullable_to_non_nullable
as OTAInfo,
  ));
}

/// Create a copy of OtaState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OTAInfoCopyWith<$Res> get info {
  
  return $OTAInfoCopyWith<$Res>(_self.info, (value) {
    return _then(_self.copyWith(info: value));
  });
}
}

// dart format on
