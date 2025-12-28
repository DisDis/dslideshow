// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'slideshow_status_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SlideshowStatusEvent {

 Object get value;



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SlideshowStatusEvent&&const DeepCollectionEquality().equals(other.value, value));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(value));

@override
String toString() {
  return 'SlideshowStatusEvent(value: $value)';
}


}

/// @nodoc
class $SlideshowStatusEventCopyWith<$Res>  {
$SlideshowStatusEventCopyWith(SlideshowStatusEvent _, $Res Function(SlideshowStatusEvent) __);
}


/// Adds pattern-matching-related methods to [SlideshowStatusEvent].
extension SlideshowStatusEventPatterns on SlideshowStatusEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SlideshowScreenLockEvent value)?  toggleScreenLock,TResult Function( SlideshowPauseEvent value)?  pause,TResult Function( SlideshowMenuEvent value)?  showMenu,TResult Function( SlideshowSystemInfoEvent value)?  showInfo,TResult Function( SlideshowInternetEvent value)?  changeInternetConnection,TResult Function( SlideshowDebugEvent value)?  showDebug,TResult Function( SlideshowChangeStorageStatusEvent value)?  changeStorageStatus,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SlideshowScreenLockEvent() when toggleScreenLock != null:
return toggleScreenLock(_that);case SlideshowPauseEvent() when pause != null:
return pause(_that);case SlideshowMenuEvent() when showMenu != null:
return showMenu(_that);case SlideshowSystemInfoEvent() when showInfo != null:
return showInfo(_that);case SlideshowInternetEvent() when changeInternetConnection != null:
return changeInternetConnection(_that);case SlideshowDebugEvent() when showDebug != null:
return showDebug(_that);case SlideshowChangeStorageStatusEvent() when changeStorageStatus != null:
return changeStorageStatus(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SlideshowScreenLockEvent value)  toggleScreenLock,required TResult Function( SlideshowPauseEvent value)  pause,required TResult Function( SlideshowMenuEvent value)  showMenu,required TResult Function( SlideshowSystemInfoEvent value)  showInfo,required TResult Function( SlideshowInternetEvent value)  changeInternetConnection,required TResult Function( SlideshowDebugEvent value)  showDebug,required TResult Function( SlideshowChangeStorageStatusEvent value)  changeStorageStatus,}){
final _that = this;
switch (_that) {
case SlideshowScreenLockEvent():
return toggleScreenLock(_that);case SlideshowPauseEvent():
return pause(_that);case SlideshowMenuEvent():
return showMenu(_that);case SlideshowSystemInfoEvent():
return showInfo(_that);case SlideshowInternetEvent():
return changeInternetConnection(_that);case SlideshowDebugEvent():
return showDebug(_that);case SlideshowChangeStorageStatusEvent():
return changeStorageStatus(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SlideshowScreenLockEvent value)?  toggleScreenLock,TResult? Function( SlideshowPauseEvent value)?  pause,TResult? Function( SlideshowMenuEvent value)?  showMenu,TResult? Function( SlideshowSystemInfoEvent value)?  showInfo,TResult? Function( SlideshowInternetEvent value)?  changeInternetConnection,TResult? Function( SlideshowDebugEvent value)?  showDebug,TResult? Function( SlideshowChangeStorageStatusEvent value)?  changeStorageStatus,}){
final _that = this;
switch (_that) {
case SlideshowScreenLockEvent() when toggleScreenLock != null:
return toggleScreenLock(_that);case SlideshowPauseEvent() when pause != null:
return pause(_that);case SlideshowMenuEvent() when showMenu != null:
return showMenu(_that);case SlideshowSystemInfoEvent() when showInfo != null:
return showInfo(_that);case SlideshowInternetEvent() when changeInternetConnection != null:
return changeInternetConnection(_that);case SlideshowDebugEvent() when showDebug != null:
return showDebug(_that);case SlideshowChangeStorageStatusEvent() when changeStorageStatus != null:
return changeStorageStatus(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( bool value)?  toggleScreenLock,TResult Function( bool value)?  pause,TResult Function( bool value)?  showMenu,TResult Function( bool value)?  showInfo,TResult Function( bool value)?  changeInternetConnection,TResult Function( bool value)?  showDebug,TResult Function( StorageStatusEnum value)?  changeStorageStatus,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SlideshowScreenLockEvent() when toggleScreenLock != null:
return toggleScreenLock(_that.value);case SlideshowPauseEvent() when pause != null:
return pause(_that.value);case SlideshowMenuEvent() when showMenu != null:
return showMenu(_that.value);case SlideshowSystemInfoEvent() when showInfo != null:
return showInfo(_that.value);case SlideshowInternetEvent() when changeInternetConnection != null:
return changeInternetConnection(_that.value);case SlideshowDebugEvent() when showDebug != null:
return showDebug(_that.value);case SlideshowChangeStorageStatusEvent() when changeStorageStatus != null:
return changeStorageStatus(_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( bool value)  toggleScreenLock,required TResult Function( bool value)  pause,required TResult Function( bool value)  showMenu,required TResult Function( bool value)  showInfo,required TResult Function( bool value)  changeInternetConnection,required TResult Function( bool value)  showDebug,required TResult Function( StorageStatusEnum value)  changeStorageStatus,}) {final _that = this;
switch (_that) {
case SlideshowScreenLockEvent():
return toggleScreenLock(_that.value);case SlideshowPauseEvent():
return pause(_that.value);case SlideshowMenuEvent():
return showMenu(_that.value);case SlideshowSystemInfoEvent():
return showInfo(_that.value);case SlideshowInternetEvent():
return changeInternetConnection(_that.value);case SlideshowDebugEvent():
return showDebug(_that.value);case SlideshowChangeStorageStatusEvent():
return changeStorageStatus(_that.value);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( bool value)?  toggleScreenLock,TResult? Function( bool value)?  pause,TResult? Function( bool value)?  showMenu,TResult? Function( bool value)?  showInfo,TResult? Function( bool value)?  changeInternetConnection,TResult? Function( bool value)?  showDebug,TResult? Function( StorageStatusEnum value)?  changeStorageStatus,}) {final _that = this;
switch (_that) {
case SlideshowScreenLockEvent() when toggleScreenLock != null:
return toggleScreenLock(_that.value);case SlideshowPauseEvent() when pause != null:
return pause(_that.value);case SlideshowMenuEvent() when showMenu != null:
return showMenu(_that.value);case SlideshowSystemInfoEvent() when showInfo != null:
return showInfo(_that.value);case SlideshowInternetEvent() when changeInternetConnection != null:
return changeInternetConnection(_that.value);case SlideshowDebugEvent() when showDebug != null:
return showDebug(_that.value);case SlideshowChangeStorageStatusEvent() when changeStorageStatus != null:
return changeStorageStatus(_that.value);case _:
  return null;

}
}

}

/// @nodoc


class SlideshowScreenLockEvent implements SlideshowStatusEvent {
  const SlideshowScreenLockEvent(this.value);
  

@override final  bool value;

/// Create a copy of SlideshowStatusEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SlideshowScreenLockEventCopyWith<SlideshowScreenLockEvent> get copyWith => _$SlideshowScreenLockEventCopyWithImpl<SlideshowScreenLockEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SlideshowScreenLockEvent&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'SlideshowStatusEvent.toggleScreenLock(value: $value)';
}


}

/// @nodoc
abstract mixin class $SlideshowScreenLockEventCopyWith<$Res> implements $SlideshowStatusEventCopyWith<$Res> {
  factory $SlideshowScreenLockEventCopyWith(SlideshowScreenLockEvent value, $Res Function(SlideshowScreenLockEvent) _then) = _$SlideshowScreenLockEventCopyWithImpl;
@useResult
$Res call({
 bool value
});




}
/// @nodoc
class _$SlideshowScreenLockEventCopyWithImpl<$Res>
    implements $SlideshowScreenLockEventCopyWith<$Res> {
  _$SlideshowScreenLockEventCopyWithImpl(this._self, this._then);

  final SlideshowScreenLockEvent _self;
  final $Res Function(SlideshowScreenLockEvent) _then;

/// Create a copy of SlideshowStatusEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(SlideshowScreenLockEvent(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class SlideshowPauseEvent implements SlideshowStatusEvent {
  const SlideshowPauseEvent(this.value);
  

@override final  bool value;

/// Create a copy of SlideshowStatusEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SlideshowPauseEventCopyWith<SlideshowPauseEvent> get copyWith => _$SlideshowPauseEventCopyWithImpl<SlideshowPauseEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SlideshowPauseEvent&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'SlideshowStatusEvent.pause(value: $value)';
}


}

/// @nodoc
abstract mixin class $SlideshowPauseEventCopyWith<$Res> implements $SlideshowStatusEventCopyWith<$Res> {
  factory $SlideshowPauseEventCopyWith(SlideshowPauseEvent value, $Res Function(SlideshowPauseEvent) _then) = _$SlideshowPauseEventCopyWithImpl;
@useResult
$Res call({
 bool value
});




}
/// @nodoc
class _$SlideshowPauseEventCopyWithImpl<$Res>
    implements $SlideshowPauseEventCopyWith<$Res> {
  _$SlideshowPauseEventCopyWithImpl(this._self, this._then);

  final SlideshowPauseEvent _self;
  final $Res Function(SlideshowPauseEvent) _then;

/// Create a copy of SlideshowStatusEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(SlideshowPauseEvent(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class SlideshowMenuEvent implements SlideshowStatusEvent {
  const SlideshowMenuEvent(this.value);
  

@override final  bool value;

/// Create a copy of SlideshowStatusEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SlideshowMenuEventCopyWith<SlideshowMenuEvent> get copyWith => _$SlideshowMenuEventCopyWithImpl<SlideshowMenuEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SlideshowMenuEvent&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'SlideshowStatusEvent.showMenu(value: $value)';
}


}

/// @nodoc
abstract mixin class $SlideshowMenuEventCopyWith<$Res> implements $SlideshowStatusEventCopyWith<$Res> {
  factory $SlideshowMenuEventCopyWith(SlideshowMenuEvent value, $Res Function(SlideshowMenuEvent) _then) = _$SlideshowMenuEventCopyWithImpl;
@useResult
$Res call({
 bool value
});




}
/// @nodoc
class _$SlideshowMenuEventCopyWithImpl<$Res>
    implements $SlideshowMenuEventCopyWith<$Res> {
  _$SlideshowMenuEventCopyWithImpl(this._self, this._then);

  final SlideshowMenuEvent _self;
  final $Res Function(SlideshowMenuEvent) _then;

/// Create a copy of SlideshowStatusEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(SlideshowMenuEvent(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class SlideshowSystemInfoEvent implements SlideshowStatusEvent {
  const SlideshowSystemInfoEvent(this.value);
  

@override final  bool value;

/// Create a copy of SlideshowStatusEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SlideshowSystemInfoEventCopyWith<SlideshowSystemInfoEvent> get copyWith => _$SlideshowSystemInfoEventCopyWithImpl<SlideshowSystemInfoEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SlideshowSystemInfoEvent&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'SlideshowStatusEvent.showInfo(value: $value)';
}


}

/// @nodoc
abstract mixin class $SlideshowSystemInfoEventCopyWith<$Res> implements $SlideshowStatusEventCopyWith<$Res> {
  factory $SlideshowSystemInfoEventCopyWith(SlideshowSystemInfoEvent value, $Res Function(SlideshowSystemInfoEvent) _then) = _$SlideshowSystemInfoEventCopyWithImpl;
@useResult
$Res call({
 bool value
});




}
/// @nodoc
class _$SlideshowSystemInfoEventCopyWithImpl<$Res>
    implements $SlideshowSystemInfoEventCopyWith<$Res> {
  _$SlideshowSystemInfoEventCopyWithImpl(this._self, this._then);

  final SlideshowSystemInfoEvent _self;
  final $Res Function(SlideshowSystemInfoEvent) _then;

/// Create a copy of SlideshowStatusEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(SlideshowSystemInfoEvent(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class SlideshowInternetEvent implements SlideshowStatusEvent {
  const SlideshowInternetEvent(this.value);
  

@override final  bool value;

/// Create a copy of SlideshowStatusEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SlideshowInternetEventCopyWith<SlideshowInternetEvent> get copyWith => _$SlideshowInternetEventCopyWithImpl<SlideshowInternetEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SlideshowInternetEvent&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'SlideshowStatusEvent.changeInternetConnection(value: $value)';
}


}

/// @nodoc
abstract mixin class $SlideshowInternetEventCopyWith<$Res> implements $SlideshowStatusEventCopyWith<$Res> {
  factory $SlideshowInternetEventCopyWith(SlideshowInternetEvent value, $Res Function(SlideshowInternetEvent) _then) = _$SlideshowInternetEventCopyWithImpl;
@useResult
$Res call({
 bool value
});




}
/// @nodoc
class _$SlideshowInternetEventCopyWithImpl<$Res>
    implements $SlideshowInternetEventCopyWith<$Res> {
  _$SlideshowInternetEventCopyWithImpl(this._self, this._then);

  final SlideshowInternetEvent _self;
  final $Res Function(SlideshowInternetEvent) _then;

/// Create a copy of SlideshowStatusEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(SlideshowInternetEvent(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class SlideshowDebugEvent implements SlideshowStatusEvent {
  const SlideshowDebugEvent(this.value);
  

@override final  bool value;

/// Create a copy of SlideshowStatusEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SlideshowDebugEventCopyWith<SlideshowDebugEvent> get copyWith => _$SlideshowDebugEventCopyWithImpl<SlideshowDebugEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SlideshowDebugEvent&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'SlideshowStatusEvent.showDebug(value: $value)';
}


}

/// @nodoc
abstract mixin class $SlideshowDebugEventCopyWith<$Res> implements $SlideshowStatusEventCopyWith<$Res> {
  factory $SlideshowDebugEventCopyWith(SlideshowDebugEvent value, $Res Function(SlideshowDebugEvent) _then) = _$SlideshowDebugEventCopyWithImpl;
@useResult
$Res call({
 bool value
});




}
/// @nodoc
class _$SlideshowDebugEventCopyWithImpl<$Res>
    implements $SlideshowDebugEventCopyWith<$Res> {
  _$SlideshowDebugEventCopyWithImpl(this._self, this._then);

  final SlideshowDebugEvent _self;
  final $Res Function(SlideshowDebugEvent) _then;

/// Create a copy of SlideshowStatusEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(SlideshowDebugEvent(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class SlideshowChangeStorageStatusEvent implements SlideshowStatusEvent {
  const SlideshowChangeStorageStatusEvent(this.value);
  

@override final  StorageStatusEnum value;

/// Create a copy of SlideshowStatusEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SlideshowChangeStorageStatusEventCopyWith<SlideshowChangeStorageStatusEvent> get copyWith => _$SlideshowChangeStorageStatusEventCopyWithImpl<SlideshowChangeStorageStatusEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SlideshowChangeStorageStatusEvent&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'SlideshowStatusEvent.changeStorageStatus(value: $value)';
}


}

/// @nodoc
abstract mixin class $SlideshowChangeStorageStatusEventCopyWith<$Res> implements $SlideshowStatusEventCopyWith<$Res> {
  factory $SlideshowChangeStorageStatusEventCopyWith(SlideshowChangeStorageStatusEvent value, $Res Function(SlideshowChangeStorageStatusEvent) _then) = _$SlideshowChangeStorageStatusEventCopyWithImpl;
@useResult
$Res call({
 StorageStatusEnum value
});




}
/// @nodoc
class _$SlideshowChangeStorageStatusEventCopyWithImpl<$Res>
    implements $SlideshowChangeStorageStatusEventCopyWith<$Res> {
  _$SlideshowChangeStorageStatusEventCopyWithImpl(this._self, this._then);

  final SlideshowChangeStorageStatusEvent _self;
  final $Res Function(SlideshowChangeStorageStatusEvent) _then;

/// Create a copy of SlideshowStatusEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(SlideshowChangeStorageStatusEvent(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as StorageStatusEnum,
  ));
}


}

/// @nodoc
mixin _$SlideshowStatusState {

 bool get hasInternet; bool get isScreenLock; StorageStatusEnum get storageStatus; bool get isDebug; bool get isMenu; bool get isInfo; bool get isPaused;
/// Create a copy of SlideshowStatusState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SlideshowStatusStateCopyWith<SlideshowStatusState> get copyWith => _$SlideshowStatusStateCopyWithImpl<SlideshowStatusState>(this as SlideshowStatusState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SlideshowStatusState&&(identical(other.hasInternet, hasInternet) || other.hasInternet == hasInternet)&&(identical(other.isScreenLock, isScreenLock) || other.isScreenLock == isScreenLock)&&(identical(other.storageStatus, storageStatus) || other.storageStatus == storageStatus)&&(identical(other.isDebug, isDebug) || other.isDebug == isDebug)&&(identical(other.isMenu, isMenu) || other.isMenu == isMenu)&&(identical(other.isInfo, isInfo) || other.isInfo == isInfo)&&(identical(other.isPaused, isPaused) || other.isPaused == isPaused));
}


@override
int get hashCode => Object.hash(runtimeType,hasInternet,isScreenLock,storageStatus,isDebug,isMenu,isInfo,isPaused);

@override
String toString() {
  return 'SlideshowStatusState(hasInternet: $hasInternet, isScreenLock: $isScreenLock, storageStatus: $storageStatus, isDebug: $isDebug, isMenu: $isMenu, isInfo: $isInfo, isPaused: $isPaused)';
}


}

/// @nodoc
abstract mixin class $SlideshowStatusStateCopyWith<$Res>  {
  factory $SlideshowStatusStateCopyWith(SlideshowStatusState value, $Res Function(SlideshowStatusState) _then) = _$SlideshowStatusStateCopyWithImpl;
@useResult
$Res call({
 bool hasInternet, bool isScreenLock, StorageStatusEnum storageStatus, bool isDebug, bool isMenu, bool isInfo, bool isPaused
});




}
/// @nodoc
class _$SlideshowStatusStateCopyWithImpl<$Res>
    implements $SlideshowStatusStateCopyWith<$Res> {
  _$SlideshowStatusStateCopyWithImpl(this._self, this._then);

  final SlideshowStatusState _self;
  final $Res Function(SlideshowStatusState) _then;

/// Create a copy of SlideshowStatusState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hasInternet = null,Object? isScreenLock = null,Object? storageStatus = null,Object? isDebug = null,Object? isMenu = null,Object? isInfo = null,Object? isPaused = null,}) {
  return _then(_self.copyWith(
hasInternet: null == hasInternet ? _self.hasInternet : hasInternet // ignore: cast_nullable_to_non_nullable
as bool,isScreenLock: null == isScreenLock ? _self.isScreenLock : isScreenLock // ignore: cast_nullable_to_non_nullable
as bool,storageStatus: null == storageStatus ? _self.storageStatus : storageStatus // ignore: cast_nullable_to_non_nullable
as StorageStatusEnum,isDebug: null == isDebug ? _self.isDebug : isDebug // ignore: cast_nullable_to_non_nullable
as bool,isMenu: null == isMenu ? _self.isMenu : isMenu // ignore: cast_nullable_to_non_nullable
as bool,isInfo: null == isInfo ? _self.isInfo : isInfo // ignore: cast_nullable_to_non_nullable
as bool,isPaused: null == isPaused ? _self.isPaused : isPaused // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SlideshowStatusState].
extension SlideshowStatusStatePatterns on SlideshowStatusState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( SlideshowStatusInitial value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case SlideshowStatusInitial() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( SlideshowStatusInitial value)  $default,){
final _that = this;
switch (_that) {
case SlideshowStatusInitial():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( SlideshowStatusInitial value)?  $default,){
final _that = this;
switch (_that) {
case SlideshowStatusInitial() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool hasInternet,  bool isScreenLock,  StorageStatusEnum storageStatus,  bool isDebug,  bool isMenu,  bool isInfo,  bool isPaused)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case SlideshowStatusInitial() when $default != null:
return $default(_that.hasInternet,_that.isScreenLock,_that.storageStatus,_that.isDebug,_that.isMenu,_that.isInfo,_that.isPaused);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool hasInternet,  bool isScreenLock,  StorageStatusEnum storageStatus,  bool isDebug,  bool isMenu,  bool isInfo,  bool isPaused)  $default,) {final _that = this;
switch (_that) {
case SlideshowStatusInitial():
return $default(_that.hasInternet,_that.isScreenLock,_that.storageStatus,_that.isDebug,_that.isMenu,_that.isInfo,_that.isPaused);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool hasInternet,  bool isScreenLock,  StorageStatusEnum storageStatus,  bool isDebug,  bool isMenu,  bool isInfo,  bool isPaused)?  $default,) {final _that = this;
switch (_that) {
case SlideshowStatusInitial() when $default != null:
return $default(_that.hasInternet,_that.isScreenLock,_that.storageStatus,_that.isDebug,_that.isMenu,_that.isInfo,_that.isPaused);case _:
  return null;

}
}

}

/// @nodoc


class SlideshowStatusInitial implements SlideshowStatusState {
  const SlideshowStatusInitial({this.hasInternet = true, this.isScreenLock = false, this.storageStatus = StorageStatusEnum.done, this.isDebug = false, this.isMenu = false, this.isInfo = false, this.isPaused = false});
  

@override@JsonKey() final  bool hasInternet;
@override@JsonKey() final  bool isScreenLock;
@override@JsonKey() final  StorageStatusEnum storageStatus;
@override@JsonKey() final  bool isDebug;
@override@JsonKey() final  bool isMenu;
@override@JsonKey() final  bool isInfo;
@override@JsonKey() final  bool isPaused;

/// Create a copy of SlideshowStatusState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SlideshowStatusInitialCopyWith<SlideshowStatusInitial> get copyWith => _$SlideshowStatusInitialCopyWithImpl<SlideshowStatusInitial>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SlideshowStatusInitial&&(identical(other.hasInternet, hasInternet) || other.hasInternet == hasInternet)&&(identical(other.isScreenLock, isScreenLock) || other.isScreenLock == isScreenLock)&&(identical(other.storageStatus, storageStatus) || other.storageStatus == storageStatus)&&(identical(other.isDebug, isDebug) || other.isDebug == isDebug)&&(identical(other.isMenu, isMenu) || other.isMenu == isMenu)&&(identical(other.isInfo, isInfo) || other.isInfo == isInfo)&&(identical(other.isPaused, isPaused) || other.isPaused == isPaused));
}


@override
int get hashCode => Object.hash(runtimeType,hasInternet,isScreenLock,storageStatus,isDebug,isMenu,isInfo,isPaused);

@override
String toString() {
  return 'SlideshowStatusState(hasInternet: $hasInternet, isScreenLock: $isScreenLock, storageStatus: $storageStatus, isDebug: $isDebug, isMenu: $isMenu, isInfo: $isInfo, isPaused: $isPaused)';
}


}

/// @nodoc
abstract mixin class $SlideshowStatusInitialCopyWith<$Res> implements $SlideshowStatusStateCopyWith<$Res> {
  factory $SlideshowStatusInitialCopyWith(SlideshowStatusInitial value, $Res Function(SlideshowStatusInitial) _then) = _$SlideshowStatusInitialCopyWithImpl;
@override @useResult
$Res call({
 bool hasInternet, bool isScreenLock, StorageStatusEnum storageStatus, bool isDebug, bool isMenu, bool isInfo, bool isPaused
});




}
/// @nodoc
class _$SlideshowStatusInitialCopyWithImpl<$Res>
    implements $SlideshowStatusInitialCopyWith<$Res> {
  _$SlideshowStatusInitialCopyWithImpl(this._self, this._then);

  final SlideshowStatusInitial _self;
  final $Res Function(SlideshowStatusInitial) _then;

/// Create a copy of SlideshowStatusState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hasInternet = null,Object? isScreenLock = null,Object? storageStatus = null,Object? isDebug = null,Object? isMenu = null,Object? isInfo = null,Object? isPaused = null,}) {
  return _then(SlideshowStatusInitial(
hasInternet: null == hasInternet ? _self.hasInternet : hasInternet // ignore: cast_nullable_to_non_nullable
as bool,isScreenLock: null == isScreenLock ? _self.isScreenLock : isScreenLock // ignore: cast_nullable_to_non_nullable
as bool,storageStatus: null == storageStatus ? _self.storageStatus : storageStatus // ignore: cast_nullable_to_non_nullable
as StorageStatusEnum,isDebug: null == isDebug ? _self.isDebug : isDebug // ignore: cast_nullable_to_non_nullable
as bool,isMenu: null == isMenu ? _self.isMenu : isMenu // ignore: cast_nullable_to_non_nullable
as bool,isInfo: null == isInfo ? _self.isInfo : isInfo // ignore: cast_nullable_to_non_nullable
as bool,isPaused: null == isPaused ? _self.isPaused : isPaused // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
