// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ota_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OtaEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtaEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OtaEvent()';
}


}

/// @nodoc
class $OtaEventCopyWith<$Res>  {
$OtaEventCopyWith(OtaEvent _, $Res Function(OtaEvent) __);
}


/// Adds pattern-matching-related methods to [OtaEvent].
extension OtaEventPatterns on OtaEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OtaInitializationEvent value)?  initialization,TResult Function( OtaUpdateInfoEvent value)?  updateInfo,TResult Function( OtaReadyEvent value)?  ready,TResult Function( OtaExitEvent value)?  exit,TResult Function( OtaTerminalUpdateEvent value)?  terminalUpdate,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OtaInitializationEvent() when initialization != null:
return initialization(_that);case OtaUpdateInfoEvent() when updateInfo != null:
return updateInfo(_that);case OtaReadyEvent() when ready != null:
return ready(_that);case OtaExitEvent() when exit != null:
return exit(_that);case OtaTerminalUpdateEvent() when terminalUpdate != null:
return terminalUpdate(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OtaInitializationEvent value)  initialization,required TResult Function( OtaUpdateInfoEvent value)  updateInfo,required TResult Function( OtaReadyEvent value)  ready,required TResult Function( OtaExitEvent value)  exit,required TResult Function( OtaTerminalUpdateEvent value)  terminalUpdate,}){
final _that = this;
switch (_that) {
case OtaInitializationEvent():
return initialization(_that);case OtaUpdateInfoEvent():
return updateInfo(_that);case OtaReadyEvent():
return ready(_that);case OtaExitEvent():
return exit(_that);case OtaTerminalUpdateEvent():
return terminalUpdate(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OtaInitializationEvent value)?  initialization,TResult? Function( OtaUpdateInfoEvent value)?  updateInfo,TResult? Function( OtaReadyEvent value)?  ready,TResult? Function( OtaExitEvent value)?  exit,TResult? Function( OtaTerminalUpdateEvent value)?  terminalUpdate,}){
final _that = this;
switch (_that) {
case OtaInitializationEvent() when initialization != null:
return initialization(_that);case OtaUpdateInfoEvent() when updateInfo != null:
return updateInfo(_that);case OtaReadyEvent() when ready != null:
return ready(_that);case OtaExitEvent() when exit != null:
return exit(_that);case OtaTerminalUpdateEvent() when terminalUpdate != null:
return terminalUpdate(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initialization,TResult Function( OTAInfo info)?  updateInfo,TResult Function()?  ready,TResult Function()?  exit,TResult Function()?  terminalUpdate,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OtaInitializationEvent() when initialization != null:
return initialization();case OtaUpdateInfoEvent() when updateInfo != null:
return updateInfo(_that.info);case OtaReadyEvent() when ready != null:
return ready();case OtaExitEvent() when exit != null:
return exit();case OtaTerminalUpdateEvent() when terminalUpdate != null:
return terminalUpdate();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initialization,required TResult Function( OTAInfo info)  updateInfo,required TResult Function()  ready,required TResult Function()  exit,required TResult Function()  terminalUpdate,}) {final _that = this;
switch (_that) {
case OtaInitializationEvent():
return initialization();case OtaUpdateInfoEvent():
return updateInfo(_that.info);case OtaReadyEvent():
return ready();case OtaExitEvent():
return exit();case OtaTerminalUpdateEvent():
return terminalUpdate();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initialization,TResult? Function( OTAInfo info)?  updateInfo,TResult? Function()?  ready,TResult? Function()?  exit,TResult? Function()?  terminalUpdate,}) {final _that = this;
switch (_that) {
case OtaInitializationEvent() when initialization != null:
return initialization();case OtaUpdateInfoEvent() when updateInfo != null:
return updateInfo(_that.info);case OtaReadyEvent() when ready != null:
return ready();case OtaExitEvent() when exit != null:
return exit();case OtaTerminalUpdateEvent() when terminalUpdate != null:
return terminalUpdate();case _:
  return null;

}
}

}

/// @nodoc


class OtaInitializationEvent implements OtaEvent {
  const OtaInitializationEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtaInitializationEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OtaEvent.initialization()';
}


}




/// @nodoc


class OtaUpdateInfoEvent implements OtaEvent {
  const OtaUpdateInfoEvent(this.info);
  

 final  OTAInfo info;

/// Create a copy of OtaEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OtaUpdateInfoEventCopyWith<OtaUpdateInfoEvent> get copyWith => _$OtaUpdateInfoEventCopyWithImpl<OtaUpdateInfoEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtaUpdateInfoEvent&&(identical(other.info, info) || other.info == info));
}


@override
int get hashCode => Object.hash(runtimeType,info);

@override
String toString() {
  return 'OtaEvent.updateInfo(info: $info)';
}


}

/// @nodoc
abstract mixin class $OtaUpdateInfoEventCopyWith<$Res> implements $OtaEventCopyWith<$Res> {
  factory $OtaUpdateInfoEventCopyWith(OtaUpdateInfoEvent value, $Res Function(OtaUpdateInfoEvent) _then) = _$OtaUpdateInfoEventCopyWithImpl;
@useResult
$Res call({
 OTAInfo info
});


$OTAInfoCopyWith<$Res> get info;

}
/// @nodoc
class _$OtaUpdateInfoEventCopyWithImpl<$Res>
    implements $OtaUpdateInfoEventCopyWith<$Res> {
  _$OtaUpdateInfoEventCopyWithImpl(this._self, this._then);

  final OtaUpdateInfoEvent _self;
  final $Res Function(OtaUpdateInfoEvent) _then;

/// Create a copy of OtaEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? info = null,}) {
  return _then(OtaUpdateInfoEvent(
null == info ? _self.info : info // ignore: cast_nullable_to_non_nullable
as OTAInfo,
  ));
}

/// Create a copy of OtaEvent
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


class OtaReadyEvent implements OtaEvent {
  const OtaReadyEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtaReadyEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OtaEvent.ready()';
}


}




/// @nodoc


class OtaExitEvent implements OtaEvent {
  const OtaExitEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtaExitEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OtaEvent.exit()';
}


}




/// @nodoc


class OtaTerminalUpdateEvent implements OtaEvent {
  const OtaTerminalUpdateEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtaTerminalUpdateEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OtaEvent.terminalUpdate()';
}


}




// dart format on
