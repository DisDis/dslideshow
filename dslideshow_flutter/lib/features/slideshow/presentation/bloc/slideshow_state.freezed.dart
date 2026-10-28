// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'slideshow_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SlideshowState {

 SlideshowSlide? get currentSlide; SlideshowSlide? get nextSlide; Effect get effect; SlideshowPhase get phase; bool get isScreenLocked; bool get isPaused; bool get fadeOut;
/// Create a copy of SlideshowState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SlideshowStateCopyWith<SlideshowState> get copyWith => _$SlideshowStateCopyWithImpl<SlideshowState>(this as SlideshowState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SlideshowState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SlideshowState&&(identical(other.currentSlide, _this.currentSlide) || other.currentSlide == _this.currentSlide)&&(identical(other.nextSlide, _this.nextSlide) || other.nextSlide == _this.nextSlide)&&(identical(other.effect, _this.effect) || other.effect == _this.effect)&&(identical(other.phase, _this.phase) || other.phase == _this.phase)&&(identical(other.isScreenLocked, _this.isScreenLocked) || other.isScreenLocked == _this.isScreenLocked)&&(identical(other.isPaused, _this.isPaused) || other.isPaused == _this.isPaused)&&(identical(other.fadeOut, _this.fadeOut) || other.fadeOut == _this.fadeOut));
}


@override
int get hashCode {
  final _this = this as SlideshowState;
  return Object.hash(runtimeType,_this.currentSlide,_this.nextSlide,_this.effect,_this.phase,_this.isScreenLocked,_this.isPaused,_this.fadeOut);
}

@override
String toString() {
  final _this = this as SlideshowState;
  return 'SlideshowState(currentSlide: ${_this.currentSlide}, nextSlide: ${_this.nextSlide}, effect: ${_this.effect}, phase: ${_this.phase}, isScreenLocked: ${_this.isScreenLocked}, isPaused: ${_this.isPaused}, fadeOut: ${_this.fadeOut})';
}


}

/// @nodoc
abstract mixin class $SlideshowStateCopyWith<$Res>  {
  factory $SlideshowStateCopyWith(SlideshowState value, $Res Function(SlideshowState) _then) = _$SlideshowStateCopyWithImpl;
@useResult
$Res call({
 SlideshowSlide? currentSlide, SlideshowSlide? nextSlide, Effect effect, SlideshowPhase phase, bool isScreenLocked, bool isPaused, bool fadeOut
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
@pragma('vm:prefer-inline') @override $Res call({Object? currentSlide = freezed,Object? nextSlide = freezed,Object? effect = null,Object? phase = null,Object? isScreenLocked = null,Object? isPaused = null,Object? fadeOut = null,}) {
  return _then(SlideshowState(
currentSlide: freezed == currentSlide ? _self.currentSlide : currentSlide // ignore: cast_nullable_to_non_nullable
as SlideshowSlide?,nextSlide: freezed == nextSlide ? _self.nextSlide : nextSlide // ignore: cast_nullable_to_non_nullable
as SlideshowSlide?,effect: null == effect ? _self.effect : effect // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SlideshowSlide? currentSlide,  SlideshowSlide? nextSlide,  Effect effect,  SlideshowPhase phase,  bool isScreenLocked,  bool isPaused,  bool fadeOut)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SlideshowState() when $default != null:
return $default(_that.currentSlide,_that.nextSlide,_that.effect,_that.phase,_that.isScreenLocked,_that.isPaused,_that.fadeOut);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SlideshowSlide? currentSlide,  SlideshowSlide? nextSlide,  Effect effect,  SlideshowPhase phase,  bool isScreenLocked,  bool isPaused,  bool fadeOut)  $default,) {final _that = this;
switch (_that) {
case _SlideshowState():
return $default(_that.currentSlide,_that.nextSlide,_that.effect,_that.phase,_that.isScreenLocked,_that.isPaused,_that.fadeOut);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SlideshowSlide? currentSlide,  SlideshowSlide? nextSlide,  Effect effect,  SlideshowPhase phase,  bool isScreenLocked,  bool isPaused,  bool fadeOut)?  $default,) {final _that = this;
switch (_that) {
case _SlideshowState() when $default != null:
return $default(_that.currentSlide,_that.nextSlide,_that.effect,_that.phase,_that.isScreenLocked,_that.isPaused,_that.fadeOut);case _:
  return null;

}
}

}

/// @nodoc


class _SlideshowState implements SlideshowState {
  const _SlideshowState({this.currentSlide, this.nextSlide, required this.effect, this.phase = SlideshowPhase.initial, this.isScreenLocked = false, this.isPaused = false, this.fadeOut = false});
  

@override final  SlideshowSlide? currentSlide;
@override final  SlideshowSlide? nextSlide;
@override final  Effect effect;
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
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SlideshowState&&(identical(other.currentSlide, currentSlide) || other.currentSlide == currentSlide)&&(identical(other.nextSlide, nextSlide) || other.nextSlide == nextSlide)&&(identical(other.effect, effect) || other.effect == effect)&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.isScreenLocked, isScreenLocked) || other.isScreenLocked == isScreenLocked)&&(identical(other.isPaused, isPaused) || other.isPaused == isPaused)&&(identical(other.fadeOut, fadeOut) || other.fadeOut == fadeOut));
}


@override
int get hashCode {
    return Object.hash(runtimeType,currentSlide,nextSlide,effect,phase,isScreenLocked,isPaused,fadeOut);
}

@override
String toString() {
    return 'SlideshowState(currentSlide: $currentSlide, nextSlide: $nextSlide, effect: $effect, phase: $phase, isScreenLocked: $isScreenLocked, isPaused: $isPaused, fadeOut: $fadeOut)';
}


}

/// @nodoc
abstract mixin class _$SlideshowStateCopyWith<$Res> implements $SlideshowStateCopyWith<$Res> {
  factory _$SlideshowStateCopyWith(_SlideshowState value, $Res Function(_SlideshowState) _then) = __$SlideshowStateCopyWithImpl;
@override @useResult
$Res call({
 SlideshowSlide? currentSlide, SlideshowSlide? nextSlide, Effect effect, SlideshowPhase phase, bool isScreenLocked, bool isPaused, bool fadeOut
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
@override @pragma('vm:prefer-inline') $Res call({Object? currentSlide = freezed,Object? nextSlide = freezed,Object? effect = null,Object? phase = null,Object? isScreenLocked = null,Object? isPaused = null,Object? fadeOut = null,}) {
  return _then(_SlideshowState(
currentSlide: freezed == currentSlide ? _self.currentSlide : currentSlide // ignore: cast_nullable_to_non_nullable
as SlideshowSlide?,nextSlide: freezed == nextSlide ? _self.nextSlide : nextSlide // ignore: cast_nullable_to_non_nullable
as SlideshowSlide?,effect: null == effect ? _self.effect : effect // ignore: cast_nullable_to_non_nullable
as Effect,phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as SlideshowPhase,isScreenLocked: null == isScreenLocked ? _self.isScreenLocked : isScreenLocked // ignore: cast_nullable_to_non_nullable
as bool,isPaused: null == isPaused ? _self.isPaused : isPaused // ignore: cast_nullable_to_non_nullable
as bool,fadeOut: null == fadeOut ? _self.fadeOut : fadeOut // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
