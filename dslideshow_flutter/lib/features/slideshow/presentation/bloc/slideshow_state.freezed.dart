// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'slideshow_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SlideshowState {

 MediaItem? get currentItem; MediaItem? get nextItem; Effect get effect;// Текущий эффект перехода
 SlideshowPhase get phase; bool get isScreenLocked; bool get isPaused; bool get fadeOut;
/// Create a copy of SlideshowState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SlideshowStateCopyWith<SlideshowState> get copyWith => _$SlideshowStateCopyWithImpl<SlideshowState>(this as SlideshowState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SlideshowState&&(identical(other.currentItem, currentItem) || other.currentItem == currentItem)&&(identical(other.nextItem, nextItem) || other.nextItem == nextItem)&&(identical(other.effect, effect) || other.effect == effect)&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.isScreenLocked, isScreenLocked) || other.isScreenLocked == isScreenLocked)&&(identical(other.isPaused, isPaused) || other.isPaused == isPaused)&&(identical(other.fadeOut, fadeOut) || other.fadeOut == fadeOut));
}


@override
int get hashCode => Object.hash(runtimeType,currentItem,nextItem,effect,phase,isScreenLocked,isPaused,fadeOut);

@override
String toString() {
  return 'SlideshowState(currentItem: $currentItem, nextItem: $nextItem, effect: $effect, phase: $phase, isScreenLocked: $isScreenLocked, isPaused: $isPaused, fadeOut: $fadeOut)';
}


}

/// @nodoc
abstract mixin class $SlideshowStateCopyWith<$Res>  {
  factory $SlideshowStateCopyWith(SlideshowState value, $Res Function(SlideshowState) _then) = _$SlideshowStateCopyWithImpl;
@useResult
$Res call({
 MediaItem? currentItem, MediaItem? nextItem, Effect effect, SlideshowPhase phase, bool isScreenLocked, bool isPaused, bool fadeOut
});




}
/// @nodoc
class _$SlideshowStateCopyWithImpl<$Res>
    implements $SlideshowStateCopyWith<$Res> {
  _$SlideshowStateCopyWithImpl(this._self, this._then);

  final SlideshowState _self;
  final $Res Function(SlideshowState) _then;

/// Create a copy of SlideshowState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentItem = freezed,Object? nextItem = freezed,Object? effect = null,Object? phase = null,Object? isScreenLocked = null,Object? isPaused = null,Object? fadeOut = null,}) {
  return _then(_self.copyWith(
currentItem: freezed == currentItem ? _self.currentItem : currentItem // ignore: cast_nullable_to_non_nullable
as MediaItem?,nextItem: freezed == nextItem ? _self.nextItem : nextItem // ignore: cast_nullable_to_non_nullable
as MediaItem?,effect: null == effect ? _self.effect : effect // ignore: cast_nullable_to_non_nullable
as Effect,phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as SlideshowPhase,isScreenLocked: null == isScreenLocked ? _self.isScreenLocked : isScreenLocked // ignore: cast_nullable_to_non_nullable
as bool,isPaused: null == isPaused ? _self.isPaused : isPaused // ignore: cast_nullable_to_non_nullable
as bool,fadeOut: null == fadeOut ? _self.fadeOut : fadeOut // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SlideshowState].
extension SlideshowStatePatterns on SlideshowState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SlideshowState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SlideshowState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SlideshowState value)  $default,){
final _that = this;
switch (_that) {
case _SlideshowState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SlideshowState value)?  $default,){
final _that = this;
switch (_that) {
case _SlideshowState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MediaItem? currentItem,  MediaItem? nextItem,  Effect effect,  SlideshowPhase phase,  bool isScreenLocked,  bool isPaused,  bool fadeOut)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SlideshowState() when $default != null:
return $default(_that.currentItem,_that.nextItem,_that.effect,_that.phase,_that.isScreenLocked,_that.isPaused,_that.fadeOut);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MediaItem? currentItem,  MediaItem? nextItem,  Effect effect,  SlideshowPhase phase,  bool isScreenLocked,  bool isPaused,  bool fadeOut)  $default,) {final _that = this;
switch (_that) {
case _SlideshowState():
return $default(_that.currentItem,_that.nextItem,_that.effect,_that.phase,_that.isScreenLocked,_that.isPaused,_that.fadeOut);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MediaItem? currentItem,  MediaItem? nextItem,  Effect effect,  SlideshowPhase phase,  bool isScreenLocked,  bool isPaused,  bool fadeOut)?  $default,) {final _that = this;
switch (_that) {
case _SlideshowState() when $default != null:
return $default(_that.currentItem,_that.nextItem,_that.effect,_that.phase,_that.isScreenLocked,_that.isPaused,_that.fadeOut);case _:
  return null;

}
}

}

/// @nodoc


class _SlideshowState implements SlideshowState {
  const _SlideshowState({required this.currentItem, required this.nextItem, required this.effect, this.phase = SlideshowPhase.initial, this.isScreenLocked = false, this.isPaused = false, this.fadeOut = false});
  

@override final  MediaItem? currentItem;
@override final  MediaItem? nextItem;
@override final  Effect effect;
// Текущий эффект перехода
@override@JsonKey() final  SlideshowPhase phase;
@override@JsonKey() final  bool isScreenLocked;
@override@JsonKey() final  bool isPaused;
@override@JsonKey() final  bool fadeOut;

/// Create a copy of SlideshowState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SlideshowStateCopyWith<_SlideshowState> get copyWith => __$SlideshowStateCopyWithImpl<_SlideshowState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SlideshowState&&(identical(other.currentItem, currentItem) || other.currentItem == currentItem)&&(identical(other.nextItem, nextItem) || other.nextItem == nextItem)&&(identical(other.effect, effect) || other.effect == effect)&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.isScreenLocked, isScreenLocked) || other.isScreenLocked == isScreenLocked)&&(identical(other.isPaused, isPaused) || other.isPaused == isPaused)&&(identical(other.fadeOut, fadeOut) || other.fadeOut == fadeOut));
}


@override
int get hashCode => Object.hash(runtimeType,currentItem,nextItem,effect,phase,isScreenLocked,isPaused,fadeOut);

@override
String toString() {
  return 'SlideshowState(currentItem: $currentItem, nextItem: $nextItem, effect: $effect, phase: $phase, isScreenLocked: $isScreenLocked, isPaused: $isPaused, fadeOut: $fadeOut)';
}


}

/// @nodoc
abstract mixin class _$SlideshowStateCopyWith<$Res> implements $SlideshowStateCopyWith<$Res> {
  factory _$SlideshowStateCopyWith(_SlideshowState value, $Res Function(_SlideshowState) _then) = __$SlideshowStateCopyWithImpl;
@override @useResult
$Res call({
 MediaItem? currentItem, MediaItem? nextItem, Effect effect, SlideshowPhase phase, bool isScreenLocked, bool isPaused, bool fadeOut
});




}
/// @nodoc
class __$SlideshowStateCopyWithImpl<$Res>
    implements _$SlideshowStateCopyWith<$Res> {
  __$SlideshowStateCopyWithImpl(this._self, this._then);

  final _SlideshowState _self;
  final $Res Function(_SlideshowState) _then;

/// Create a copy of SlideshowState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentItem = freezed,Object? nextItem = freezed,Object? effect = null,Object? phase = null,Object? isScreenLocked = null,Object? isPaused = null,Object? fadeOut = null,}) {
  return _then(_SlideshowState(
currentItem: freezed == currentItem ? _self.currentItem : currentItem // ignore: cast_nullable_to_non_nullable
as MediaItem?,nextItem: freezed == nextItem ? _self.nextItem : nextItem // ignore: cast_nullable_to_non_nullable
as MediaItem?,effect: null == effect ? _self.effect : effect // ignore: cast_nullable_to_non_nullable
as Effect,phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as SlideshowPhase,isScreenLocked: null == isScreenLocked ? _self.isScreenLocked : isScreenLocked // ignore: cast_nullable_to_non_nullable
as bool,isPaused: null == isPaused ? _self.isPaused : isPaused // ignore: cast_nullable_to_non_nullable
as bool,fadeOut: null == fadeOut ? _self.fadeOut : fadeOut // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
