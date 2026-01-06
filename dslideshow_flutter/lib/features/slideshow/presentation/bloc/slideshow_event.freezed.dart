// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'slideshow_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SlideshowEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SlideshowEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SlideshowEvent()';
}


}

/// @nodoc
class $SlideshowEventCopyWith<$Res>  {
$SlideshowEventCopyWith(SlideshowEvent _, $Res Function(SlideshowEvent) __);
}


/// Adds pattern-matching-related methods to [SlideshowEvent].
extension SlideshowEventPatterns on SlideshowEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SlideshowInitEvent value)?  init,TResult Function( SlideshowLoadNextEvent value)?  loadNext,TResult Function( SlideshowImageReadyEvent value)?  imageReady,TResult Function( SlideshowTransitionCompleteEvent value)?  transitionComplete,TResult Function( SlideshowTimerCompleteEvent value)?  timerComplete,TResult Function( SlideshowTogglePauseEvent value)?  togglePause,TResult Function( SlideshowToggleScreenLockEvent value)?  toggleScreenLock,TResult Function( SlideshowScreenStatePreparationEvent value)?  screenStatePreparation,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SlideshowInitEvent() when init != null:
return init(_that);case SlideshowLoadNextEvent() when loadNext != null:
return loadNext(_that);case SlideshowImageReadyEvent() when imageReady != null:
return imageReady(_that);case SlideshowTransitionCompleteEvent() when transitionComplete != null:
return transitionComplete(_that);case SlideshowTimerCompleteEvent() when timerComplete != null:
return timerComplete(_that);case SlideshowTogglePauseEvent() when togglePause != null:
return togglePause(_that);case SlideshowToggleScreenLockEvent() when toggleScreenLock != null:
return toggleScreenLock(_that);case SlideshowScreenStatePreparationEvent() when screenStatePreparation != null:
return screenStatePreparation(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SlideshowInitEvent value)  init,required TResult Function( SlideshowLoadNextEvent value)  loadNext,required TResult Function( SlideshowImageReadyEvent value)  imageReady,required TResult Function( SlideshowTransitionCompleteEvent value)  transitionComplete,required TResult Function( SlideshowTimerCompleteEvent value)  timerComplete,required TResult Function( SlideshowTogglePauseEvent value)  togglePause,required TResult Function( SlideshowToggleScreenLockEvent value)  toggleScreenLock,required TResult Function( SlideshowScreenStatePreparationEvent value)  screenStatePreparation,}){
final _that = this;
switch (_that) {
case SlideshowInitEvent():
return init(_that);case SlideshowLoadNextEvent():
return loadNext(_that);case SlideshowImageReadyEvent():
return imageReady(_that);case SlideshowTransitionCompleteEvent():
return transitionComplete(_that);case SlideshowTimerCompleteEvent():
return timerComplete(_that);case SlideshowTogglePauseEvent():
return togglePause(_that);case SlideshowToggleScreenLockEvent():
return toggleScreenLock(_that);case SlideshowScreenStatePreparationEvent():
return screenStatePreparation(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SlideshowInitEvent value)?  init,TResult? Function( SlideshowLoadNextEvent value)?  loadNext,TResult? Function( SlideshowImageReadyEvent value)?  imageReady,TResult? Function( SlideshowTransitionCompleteEvent value)?  transitionComplete,TResult? Function( SlideshowTimerCompleteEvent value)?  timerComplete,TResult? Function( SlideshowTogglePauseEvent value)?  togglePause,TResult? Function( SlideshowToggleScreenLockEvent value)?  toggleScreenLock,TResult? Function( SlideshowScreenStatePreparationEvent value)?  screenStatePreparation,}){
final _that = this;
switch (_that) {
case SlideshowInitEvent() when init != null:
return init(_that);case SlideshowLoadNextEvent() when loadNext != null:
return loadNext(_that);case SlideshowImageReadyEvent() when imageReady != null:
return imageReady(_that);case SlideshowTransitionCompleteEvent() when transitionComplete != null:
return transitionComplete(_that);case SlideshowTimerCompleteEvent() when timerComplete != null:
return timerComplete(_that);case SlideshowTogglePauseEvent() when togglePause != null:
return togglePause(_that);case SlideshowToggleScreenLockEvent() when toggleScreenLock != null:
return toggleScreenLock(_that);case SlideshowScreenStatePreparationEvent() when screenStatePreparation != null:
return screenStatePreparation(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  init,TResult Function()?  loadNext,TResult Function()?  imageReady,TResult Function()?  transitionComplete,TResult Function()?  timerComplete,TResult Function( bool isPaused)?  togglePause,TResult Function( bool isLocked)?  toggleScreenLock,TResult Function( bool enabled)?  screenStatePreparation,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SlideshowInitEvent() when init != null:
return init();case SlideshowLoadNextEvent() when loadNext != null:
return loadNext();case SlideshowImageReadyEvent() when imageReady != null:
return imageReady();case SlideshowTransitionCompleteEvent() when transitionComplete != null:
return transitionComplete();case SlideshowTimerCompleteEvent() when timerComplete != null:
return timerComplete();case SlideshowTogglePauseEvent() when togglePause != null:
return togglePause(_that.isPaused);case SlideshowToggleScreenLockEvent() when toggleScreenLock != null:
return toggleScreenLock(_that.isLocked);case SlideshowScreenStatePreparationEvent() when screenStatePreparation != null:
return screenStatePreparation(_that.enabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  init,required TResult Function()  loadNext,required TResult Function()  imageReady,required TResult Function()  transitionComplete,required TResult Function()  timerComplete,required TResult Function( bool isPaused)  togglePause,required TResult Function( bool isLocked)  toggleScreenLock,required TResult Function( bool enabled)  screenStatePreparation,}) {final _that = this;
switch (_that) {
case SlideshowInitEvent():
return init();case SlideshowLoadNextEvent():
return loadNext();case SlideshowImageReadyEvent():
return imageReady();case SlideshowTransitionCompleteEvent():
return transitionComplete();case SlideshowTimerCompleteEvent():
return timerComplete();case SlideshowTogglePauseEvent():
return togglePause(_that.isPaused);case SlideshowToggleScreenLockEvent():
return toggleScreenLock(_that.isLocked);case SlideshowScreenStatePreparationEvent():
return screenStatePreparation(_that.enabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  init,TResult? Function()?  loadNext,TResult? Function()?  imageReady,TResult? Function()?  transitionComplete,TResult? Function()?  timerComplete,TResult? Function( bool isPaused)?  togglePause,TResult? Function( bool isLocked)?  toggleScreenLock,TResult? Function( bool enabled)?  screenStatePreparation,}) {final _that = this;
switch (_that) {
case SlideshowInitEvent() when init != null:
return init();case SlideshowLoadNextEvent() when loadNext != null:
return loadNext();case SlideshowImageReadyEvent() when imageReady != null:
return imageReady();case SlideshowTransitionCompleteEvent() when transitionComplete != null:
return transitionComplete();case SlideshowTimerCompleteEvent() when timerComplete != null:
return timerComplete();case SlideshowTogglePauseEvent() when togglePause != null:
return togglePause(_that.isPaused);case SlideshowToggleScreenLockEvent() when toggleScreenLock != null:
return toggleScreenLock(_that.isLocked);case SlideshowScreenStatePreparationEvent() when screenStatePreparation != null:
return screenStatePreparation(_that.enabled);case _:
  return null;

}
}

}

/// @nodoc


class SlideshowInitEvent implements SlideshowEvent {
  const SlideshowInitEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SlideshowInitEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SlideshowEvent.init()';
}


}




/// @nodoc


class SlideshowLoadNextEvent implements SlideshowEvent {
  const SlideshowLoadNextEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SlideshowLoadNextEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SlideshowEvent.loadNext()';
}


}




/// @nodoc


class SlideshowImageReadyEvent implements SlideshowEvent {
  const SlideshowImageReadyEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SlideshowImageReadyEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SlideshowEvent.imageReady()';
}


}




/// @nodoc


class SlideshowTransitionCompleteEvent implements SlideshowEvent {
  const SlideshowTransitionCompleteEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SlideshowTransitionCompleteEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SlideshowEvent.transitionComplete()';
}


}




/// @nodoc


class SlideshowTimerCompleteEvent implements SlideshowEvent {
  const SlideshowTimerCompleteEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SlideshowTimerCompleteEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SlideshowEvent.timerComplete()';
}


}




/// @nodoc


class SlideshowTogglePauseEvent implements SlideshowEvent {
  const SlideshowTogglePauseEvent(this.isPaused);
  

 final  bool isPaused;

/// Create a copy of SlideshowEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SlideshowTogglePauseEventCopyWith<SlideshowTogglePauseEvent> get copyWith => _$SlideshowTogglePauseEventCopyWithImpl<SlideshowTogglePauseEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SlideshowTogglePauseEvent&&(identical(other.isPaused, isPaused) || other.isPaused == isPaused));
}


@override
int get hashCode => Object.hash(runtimeType,isPaused);

@override
String toString() {
  return 'SlideshowEvent.togglePause(isPaused: $isPaused)';
}


}

/// @nodoc
abstract mixin class $SlideshowTogglePauseEventCopyWith<$Res> implements $SlideshowEventCopyWith<$Res> {
  factory $SlideshowTogglePauseEventCopyWith(SlideshowTogglePauseEvent value, $Res Function(SlideshowTogglePauseEvent) _then) = _$SlideshowTogglePauseEventCopyWithImpl;
@useResult
$Res call({
 bool isPaused
});




}
/// @nodoc
class _$SlideshowTogglePauseEventCopyWithImpl<$Res>
    implements $SlideshowTogglePauseEventCopyWith<$Res> {
  _$SlideshowTogglePauseEventCopyWithImpl(this._self, this._then);

  final SlideshowTogglePauseEvent _self;
  final $Res Function(SlideshowTogglePauseEvent) _then;

/// Create a copy of SlideshowEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isPaused = null,}) {
  return _then(SlideshowTogglePauseEvent(
null == isPaused ? _self.isPaused : isPaused // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class SlideshowToggleScreenLockEvent implements SlideshowEvent {
  const SlideshowToggleScreenLockEvent(this.isLocked);
  

 final  bool isLocked;

/// Create a copy of SlideshowEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SlideshowToggleScreenLockEventCopyWith<SlideshowToggleScreenLockEvent> get copyWith => _$SlideshowToggleScreenLockEventCopyWithImpl<SlideshowToggleScreenLockEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SlideshowToggleScreenLockEvent&&(identical(other.isLocked, isLocked) || other.isLocked == isLocked));
}


@override
int get hashCode => Object.hash(runtimeType,isLocked);

@override
String toString() {
  return 'SlideshowEvent.toggleScreenLock(isLocked: $isLocked)';
}


}

/// @nodoc
abstract mixin class $SlideshowToggleScreenLockEventCopyWith<$Res> implements $SlideshowEventCopyWith<$Res> {
  factory $SlideshowToggleScreenLockEventCopyWith(SlideshowToggleScreenLockEvent value, $Res Function(SlideshowToggleScreenLockEvent) _then) = _$SlideshowToggleScreenLockEventCopyWithImpl;
@useResult
$Res call({
 bool isLocked
});




}
/// @nodoc
class _$SlideshowToggleScreenLockEventCopyWithImpl<$Res>
    implements $SlideshowToggleScreenLockEventCopyWith<$Res> {
  _$SlideshowToggleScreenLockEventCopyWithImpl(this._self, this._then);

  final SlideshowToggleScreenLockEvent _self;
  final $Res Function(SlideshowToggleScreenLockEvent) _then;

/// Create a copy of SlideshowEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isLocked = null,}) {
  return _then(SlideshowToggleScreenLockEvent(
null == isLocked ? _self.isLocked : isLocked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class SlideshowScreenStatePreparationEvent implements SlideshowEvent {
  const SlideshowScreenStatePreparationEvent(this.enabled);
  

 final  bool enabled;

/// Create a copy of SlideshowEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SlideshowScreenStatePreparationEventCopyWith<SlideshowScreenStatePreparationEvent> get copyWith => _$SlideshowScreenStatePreparationEventCopyWithImpl<SlideshowScreenStatePreparationEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SlideshowScreenStatePreparationEvent&&(identical(other.enabled, enabled) || other.enabled == enabled));
}


@override
int get hashCode => Object.hash(runtimeType,enabled);

@override
String toString() {
  return 'SlideshowEvent.screenStatePreparation(enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class $SlideshowScreenStatePreparationEventCopyWith<$Res> implements $SlideshowEventCopyWith<$Res> {
  factory $SlideshowScreenStatePreparationEventCopyWith(SlideshowScreenStatePreparationEvent value, $Res Function(SlideshowScreenStatePreparationEvent) _then) = _$SlideshowScreenStatePreparationEventCopyWithImpl;
@useResult
$Res call({
 bool enabled
});




}
/// @nodoc
class _$SlideshowScreenStatePreparationEventCopyWithImpl<$Res>
    implements $SlideshowScreenStatePreparationEventCopyWith<$Res> {
  _$SlideshowScreenStatePreparationEventCopyWithImpl(this._self, this._then);

  final SlideshowScreenStatePreparationEvent _self;
  final $Res Function(SlideshowScreenStatePreparationEvent) _then;

/// Create a copy of SlideshowEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? enabled = null,}) {
  return _then(SlideshowScreenStatePreparationEvent(
null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
