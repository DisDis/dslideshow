// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'slideshow_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SlideShowConfig {


/// Create a copy of SlideShowConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SlideShowConfigCopyWith<SlideShowConfig> get copyWith => _$SlideShowConfigCopyWithImpl<SlideShowConfig>(this as SlideShowConfig, _$identity);





@override
String toString() {
  final _this = this as SlideShowConfig;
  return 'SlideShowConfig(buttons: ${_this.buttons}, menu: ${_this.menu}, specialScreens: ${_this.specialScreens}, photoMotion: ${_this.photoMotion}, displayTimeMs: ${_this.displayTimeMs}, fadeTimeMs: ${_this.fadeTimeMs}, effects: ${_this.effects}, isBlurredBackground: ${_this.isBlurredBackground}, backgroundBlurSigma: ${_this.backgroundBlurSigma}, backgroundOpacity: ${_this.backgroundOpacity}, backgroundColor: ${_this.backgroundColor})';
}


}

/// @nodoc
abstract mixin class $SlideShowConfigCopyWith<$Res>  {
  factory $SlideShowConfigCopyWith(SlideShowConfig value, $Res Function(SlideShowConfig) _then) = _$SlideShowConfigCopyWithImpl;
@useResult
$Res call({
 EffectsConfig? effects, int backgroundBlurSigma, int backgroundColor, double backgroundOpacity, int displayTimeMs, int fadeTimeMs, bool isBlurredBackground, SlideShowButtons buttons, SlideShowMenuConfig menu, List<SpecialScreenConfig>? specialScreens, PhotoMotionConfig? photoMotion
});


$EffectsConfigCopyWith<$Res>? get effects;

}
/// @nodoc
class _$SlideShowConfigCopyWithImpl<$Res>
    implements $SlideShowConfigCopyWith<$Res> {
  _$SlideShowConfigCopyWithImpl(this._self, this._then);

  final SlideShowConfig _self;
  final $Res Function(SlideShowConfig) _then;

/// Create a copy of SlideShowConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? effects = freezed,Object? backgroundBlurSigma = null,Object? backgroundColor = null,Object? backgroundOpacity = null,Object? displayTimeMs = null,Object? fadeTimeMs = null,Object? isBlurredBackground = null,Object? buttons = null,Object? menu = null,Object? specialScreens = freezed,Object? photoMotion = freezed,}) {
  return _then(SlideShowConfig(
effects: freezed == effects ? _self.effects! : effects // ignore: cast_nullable_to_non_nullable
as EffectsConfig?,backgroundBlurSigma: null == backgroundBlurSigma ? _self.backgroundBlurSigma : backgroundBlurSigma // ignore: cast_nullable_to_non_nullable
as int,backgroundColor: null == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as int,backgroundOpacity: null == backgroundOpacity ? _self.backgroundOpacity : backgroundOpacity // ignore: cast_nullable_to_non_nullable
as double,displayTimeMs: null == displayTimeMs ? _self.displayTimeMs : displayTimeMs // ignore: cast_nullable_to_non_nullable
as int,fadeTimeMs: null == fadeTimeMs ? _self.fadeTimeMs : fadeTimeMs // ignore: cast_nullable_to_non_nullable
as int,isBlurredBackground: null == isBlurredBackground ? _self.isBlurredBackground : isBlurredBackground // ignore: cast_nullable_to_non_nullable
as bool,buttons: null == buttons ? _self.buttons : buttons // ignore: cast_nullable_to_non_nullable
as SlideShowButtons,menu: null == menu ? _self.menu : menu // ignore: cast_nullable_to_non_nullable
as SlideShowMenuConfig,specialScreens: freezed == specialScreens ? _self.specialScreens! : specialScreens // ignore: cast_nullable_to_non_nullable
as List<SpecialScreenConfig>?,photoMotion: freezed == photoMotion ? _self.photoMotion! : photoMotion // ignore: cast_nullable_to_non_nullable
as PhotoMotionConfig?,
  ));
}
/// Create a copy of SlideShowConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EffectsConfigCopyWith<$Res>? get effects {
    if (_self.effects == null) {
    return null;
  }

  return $EffectsConfigCopyWith<$Res>(_self.effects!, (value) {
    return _then(_self.copyWith(effects: value));
  });
}
}


/// Adds pattern-matching-related methods to [SlideShowConfig].
extension SlideShowConfigPatterns on SlideShowConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({required TResult orElse(),}){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({required TResult orElse(),}) {final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
  return null;

}
}

}

// dart format on
