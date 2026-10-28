// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'effects.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BasicEffectOptions {


/// Create a copy of BasicEffectOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BasicEffectOptionsCopyWith<BasicEffectOptions> get copyWith => _$BasicEffectOptionsCopyWithImpl<BasicEffectOptions>(this as BasicEffectOptions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BasicEffectOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BasicEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as BasicEffectOptions;
  return Object.hash(runtimeType,_this.durationMs);
}

@override
String toString() {
  final _this = this as BasicEffectOptions;
  return 'BasicEffectOptions(durationMs: ${_this.durationMs})';
}


}

/// @nodoc
abstract mixin class $BasicEffectOptionsCopyWith<$Res>  {
  factory $BasicEffectOptionsCopyWith(BasicEffectOptions value, $Res Function(BasicEffectOptions) _then) = _$BasicEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs
});




}
/// @nodoc
class _$BasicEffectOptionsCopyWithImpl<$Res>
    implements $BasicEffectOptionsCopyWith<$Res> {
  _$BasicEffectOptionsCopyWithImpl(this._self, this._then);

  final BasicEffectOptions _self;
  final $Res Function(BasicEffectOptions) _then;

/// Create a copy of BasicEffectOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,}) {
  return _then(BasicEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BasicEffectOptions].
extension BasicEffectOptionsPatterns on BasicEffectOptions {
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


/// @nodoc
mixin _$MosaicEffectOptions {


/// Create a copy of MosaicEffectOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MosaicEffectOptionsCopyWith<MosaicEffectOptions> get copyWith => _$MosaicEffectOptionsCopyWithImpl<MosaicEffectOptions>(this as MosaicEffectOptions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MosaicEffectOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MosaicEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.gridSize, _this.gridSize) || other.gridSize == _this.gridSize)&&(identical(other.fadeFraction, _this.fadeFraction) || other.fadeFraction == _this.fadeFraction)&&(identical(other.direction, _this.direction) || other.direction == _this.direction)&&(identical(other.randomness, _this.randomness) || other.randomness == _this.randomness));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MosaicEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.gridSize,_this.fadeFraction,_this.direction,_this.randomness);
}

@override
String toString() {
  final _this = this as MosaicEffectOptions;
  return 'MosaicEffectOptions(durationMs: ${_this.durationMs}, gridSize: ${_this.gridSize}, fadeFraction: ${_this.fadeFraction}, direction: ${_this.direction}, randomness: ${_this.randomness})';
}


}

/// @nodoc
abstract mixin class $MosaicEffectOptionsCopyWith<$Res>  {
  factory $MosaicEffectOptionsCopyWith(MosaicEffectOptions value, $Res Function(MosaicEffectOptions) _then) = _$MosaicEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, int gridSize, double fadeFraction, MosaicDirection direction, double randomness
});




}
/// @nodoc
class _$MosaicEffectOptionsCopyWithImpl<$Res>
    implements $MosaicEffectOptionsCopyWith<$Res> {
  _$MosaicEffectOptionsCopyWithImpl(this._self, this._then);

  final MosaicEffectOptions _self;
  final $Res Function(MosaicEffectOptions) _then;

/// Create a copy of MosaicEffectOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? gridSize = null,Object? fadeFraction = null,Object? direction = null,Object? randomness = null,}) {
  return _then(MosaicEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,gridSize: null == gridSize ? _self.gridSize : gridSize // ignore: cast_nullable_to_non_nullable
as int,fadeFraction: null == fadeFraction ? _self.fadeFraction : fadeFraction // ignore: cast_nullable_to_non_nullable
as double,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as MosaicDirection,randomness: null == randomness ? _self.randomness : randomness // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [MosaicEffectOptions].
extension MosaicEffectOptionsPatterns on MosaicEffectOptions {
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


/// @nodoc
mixin _$SlideEffectOptions {


/// Create a copy of SlideEffectOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SlideEffectOptionsCopyWith<SlideEffectOptions> get copyWith => _$SlideEffectOptionsCopyWithImpl<SlideEffectOptions>(this as SlideEffectOptions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SlideEffectOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SlideEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.mode, _this.mode) || other.mode == _this.mode)&&(identical(other.direction, _this.direction) || other.direction == _this.direction)&&(identical(other.motionCurve, _this.motionCurve) || other.motionCurve == _this.motionCurve)&&(identical(other.blurFraction, _this.blurFraction) || other.blurFraction == _this.blurFraction)&&(identical(other.decoration, _this.decoration) || other.decoration == _this.decoration)&&(identical(other.edgeWidth, _this.edgeWidth) || other.edgeWidth == _this.edgeWidth)&&(identical(other.tiltDegrees, _this.tiltDegrees) || other.tiltDegrees == _this.tiltDegrees)&&(identical(other.shadowStrength, _this.shadowStrength) || other.shadowStrength == _this.shadowStrength));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SlideEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.mode,_this.direction,_this.motionCurve,_this.blurFraction,_this.decoration,_this.edgeWidth,_this.tiltDegrees,_this.shadowStrength);
}

@override
String toString() {
  final _this = this as SlideEffectOptions;
  return 'SlideEffectOptions(durationMs: ${_this.durationMs}, mode: ${_this.mode}, direction: ${_this.direction}, motionCurve: ${_this.motionCurve}, blurFraction: ${_this.blurFraction}, decoration: ${_this.decoration}, edgeWidth: ${_this.edgeWidth}, tiltDegrees: ${_this.tiltDegrees}, shadowStrength: ${_this.shadowStrength})';
}


}

/// @nodoc
abstract mixin class $SlideEffectOptionsCopyWith<$Res>  {
  factory $SlideEffectOptionsCopyWith(SlideEffectOptions value, $Res Function(SlideEffectOptions) _then) = _$SlideEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, SlideMode mode, EffectDirection direction, BlendCurve motionCurve, double blurFraction, SlideDecoration decoration, double edgeWidth, double tiltDegrees, double shadowStrength
});




}
/// @nodoc
class _$SlideEffectOptionsCopyWithImpl<$Res>
    implements $SlideEffectOptionsCopyWith<$Res> {
  _$SlideEffectOptionsCopyWithImpl(this._self, this._then);

  final SlideEffectOptions _self;
  final $Res Function(SlideEffectOptions) _then;

/// Create a copy of SlideEffectOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? mode = null,Object? direction = null,Object? motionCurve = null,Object? blurFraction = null,Object? decoration = null,Object? edgeWidth = null,Object? tiltDegrees = null,Object? shadowStrength = null,}) {
  return _then(SlideEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as SlideMode,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as EffectDirection,motionCurve: null == motionCurve ? _self.motionCurve : motionCurve // ignore: cast_nullable_to_non_nullable
as BlendCurve,blurFraction: null == blurFraction ? _self.blurFraction : blurFraction // ignore: cast_nullable_to_non_nullable
as double,decoration: null == decoration ? _self.decoration : decoration // ignore: cast_nullable_to_non_nullable
as SlideDecoration,edgeWidth: null == edgeWidth ? _self.edgeWidth : edgeWidth // ignore: cast_nullable_to_non_nullable
as double,tiltDegrees: null == tiltDegrees ? _self.tiltDegrees : tiltDegrees // ignore: cast_nullable_to_non_nullable
as double,shadowStrength: null == shadowStrength ? _self.shadowStrength : shadowStrength // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SlideEffectOptions].
extension SlideEffectOptionsPatterns on SlideEffectOptions {
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


/// @nodoc
mixin _$RevealMaskEffectOptions {


/// Create a copy of RevealMaskEffectOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RevealMaskEffectOptionsCopyWith<RevealMaskEffectOptions> get copyWith => _$RevealMaskEffectOptionsCopyWithImpl<RevealMaskEffectOptions>(this as RevealMaskEffectOptions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RevealMaskEffectOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RevealMaskEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.shape, _this.shape) || other.shape == _this.shape)&&(identical(other.direction, _this.direction) || other.direction == _this.direction)&&(identical(other.axis, _this.axis) || other.axis == _this.axis)&&(identical(other.origin, _this.origin) || other.origin == _this.origin)&&(identical(other.operation, _this.operation) || other.operation == _this.operation)&&(identical(other.edgeStyle, _this.edgeStyle) || other.edgeStyle == _this.edgeStyle)&&(identical(other.featherFraction, _this.featherFraction) || other.featherFraction == _this.featherFraction)&&(identical(other.lightStrength, _this.lightStrength) || other.lightStrength == _this.lightStrength)&&(identical(other.frameEnabled, _this.frameEnabled) || other.frameEnabled == _this.frameEnabled)&&(identical(other.borderWidth, _this.borderWidth) || other.borderWidth == _this.borderWidth)&&(identical(other.borderColor, _this.borderColor) || other.borderColor == _this.borderColor)&&(identical(other.shadowStrength, _this.shadowStrength) || other.shadowStrength == _this.shadowStrength)&&(identical(other.pointCount, _this.pointCount) || other.pointCount == _this.pointCount)&&(identical(other.innerRadiusRatio, _this.innerRadiusRatio) || other.innerRadiusRatio == _this.innerRadiusRatio)&&(identical(other.rotationDegrees, _this.rotationDegrees) || other.rotationDegrees == _this.rotationDegrees)&&(identical(other.startAngleDegrees, _this.startAngleDegrees) || other.startAngleDegrees == _this.startAngleDegrees)&&(identical(other.circularDirection, _this.circularDirection) || other.circularDirection == _this.circularDirection));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RevealMaskEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.shape,_this.direction,_this.axis,_this.origin,_this.operation,_this.edgeStyle,_this.featherFraction,_this.lightStrength,_this.frameEnabled,_this.borderWidth,_this.borderColor,_this.shadowStrength,_this.pointCount,_this.innerRadiusRatio,_this.rotationDegrees,_this.startAngleDegrees,_this.circularDirection);
}

@override
String toString() {
  final _this = this as RevealMaskEffectOptions;
  return 'RevealMaskEffectOptions(durationMs: ${_this.durationMs}, shape: ${_this.shape}, direction: ${_this.direction}, axis: ${_this.axis}, origin: ${_this.origin}, operation: ${_this.operation}, edgeStyle: ${_this.edgeStyle}, featherFraction: ${_this.featherFraction}, lightStrength: ${_this.lightStrength}, frameEnabled: ${_this.frameEnabled}, borderWidth: ${_this.borderWidth}, borderColor: ${_this.borderColor}, shadowStrength: ${_this.shadowStrength}, pointCount: ${_this.pointCount}, innerRadiusRatio: ${_this.innerRadiusRatio}, rotationDegrees: ${_this.rotationDegrees}, startAngleDegrees: ${_this.startAngleDegrees}, circularDirection: ${_this.circularDirection})';
}


}

/// @nodoc
abstract mixin class $RevealMaskEffectOptionsCopyWith<$Res>  {
  factory $RevealMaskEffectOptionsCopyWith(RevealMaskEffectOptions value, $Res Function(RevealMaskEffectOptions) _then) = _$RevealMaskEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, RevealShape shape, EffectDirection direction, EffectAxis axis, EffectOrigin origin, RevealOperation operation, WipeEdgeStyle edgeStyle, double? featherFraction, double lightStrength, bool frameEnabled, double borderWidth, int borderColor, double shadowStrength, int pointCount, double innerRadiusRatio, double rotationDegrees, double startAngleDegrees, CircularDirection circularDirection
});




}
/// @nodoc
class _$RevealMaskEffectOptionsCopyWithImpl<$Res>
    implements $RevealMaskEffectOptionsCopyWith<$Res> {
  _$RevealMaskEffectOptionsCopyWithImpl(this._self, this._then);

  final RevealMaskEffectOptions _self;
  final $Res Function(RevealMaskEffectOptions) _then;

/// Create a copy of RevealMaskEffectOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? shape = null,Object? direction = null,Object? axis = null,Object? origin = null,Object? operation = null,Object? edgeStyle = null,Object? featherFraction = freezed,Object? lightStrength = null,Object? frameEnabled = null,Object? borderWidth = null,Object? borderColor = null,Object? shadowStrength = null,Object? pointCount = null,Object? innerRadiusRatio = null,Object? rotationDegrees = null,Object? startAngleDegrees = null,Object? circularDirection = null,}) {
  return _then(RevealMaskEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,shape: null == shape ? _self.shape : shape // ignore: cast_nullable_to_non_nullable
as RevealShape,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as EffectDirection,axis: null == axis ? _self.axis : axis // ignore: cast_nullable_to_non_nullable
as EffectAxis,origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as EffectOrigin,operation: null == operation ? _self.operation : operation // ignore: cast_nullable_to_non_nullable
as RevealOperation,edgeStyle: null == edgeStyle ? _self.edgeStyle : edgeStyle // ignore: cast_nullable_to_non_nullable
as WipeEdgeStyle,featherFraction: freezed == featherFraction ? _self.featherFraction : featherFraction // ignore: cast_nullable_to_non_nullable
as double?,lightStrength: null == lightStrength ? _self.lightStrength : lightStrength // ignore: cast_nullable_to_non_nullable
as double,frameEnabled: null == frameEnabled ? _self.frameEnabled : frameEnabled // ignore: cast_nullable_to_non_nullable
as bool,borderWidth: null == borderWidth ? _self.borderWidth : borderWidth // ignore: cast_nullable_to_non_nullable
as double,borderColor: null == borderColor ? _self.borderColor : borderColor // ignore: cast_nullable_to_non_nullable
as int,shadowStrength: null == shadowStrength ? _self.shadowStrength : shadowStrength // ignore: cast_nullable_to_non_nullable
as double,pointCount: null == pointCount ? _self.pointCount : pointCount // ignore: cast_nullable_to_non_nullable
as int,innerRadiusRatio: null == innerRadiusRatio ? _self.innerRadiusRatio : innerRadiusRatio // ignore: cast_nullable_to_non_nullable
as double,rotationDegrees: null == rotationDegrees ? _self.rotationDegrees : rotationDegrees // ignore: cast_nullable_to_non_nullable
as double,startAngleDegrees: null == startAngleDegrees ? _self.startAngleDegrees : startAngleDegrees // ignore: cast_nullable_to_non_nullable
as double,circularDirection: null == circularDirection ? _self.circularDirection : circularDirection // ignore: cast_nullable_to_non_nullable
as CircularDirection,
  ));
}

}


/// Adds pattern-matching-related methods to [RevealMaskEffectOptions].
extension RevealMaskEffectOptionsPatterns on RevealMaskEffectOptions {
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


/// @nodoc
mixin _$FadeThroughColorEffectOptions {


/// Create a copy of FadeThroughColorEffectOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FadeThroughColorEffectOptionsCopyWith<FadeThroughColorEffectOptions> get copyWith => _$FadeThroughColorEffectOptionsCopyWithImpl<FadeThroughColorEffectOptions>(this as FadeThroughColorEffectOptions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as FadeThroughColorEffectOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FadeThroughColorEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.color, _this.color) || other.color == _this.color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FadeThroughColorEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.color);
}

@override
String toString() {
  final _this = this as FadeThroughColorEffectOptions;
  return 'FadeThroughColorEffectOptions(durationMs: ${_this.durationMs}, color: ${_this.color})';
}


}

/// @nodoc
abstract mixin class $FadeThroughColorEffectOptionsCopyWith<$Res>  {
  factory $FadeThroughColorEffectOptionsCopyWith(FadeThroughColorEffectOptions value, $Res Function(FadeThroughColorEffectOptions) _then) = _$FadeThroughColorEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, int color
});




}
/// @nodoc
class _$FadeThroughColorEffectOptionsCopyWithImpl<$Res>
    implements $FadeThroughColorEffectOptionsCopyWith<$Res> {
  _$FadeThroughColorEffectOptionsCopyWithImpl(this._self, this._then);

  final FadeThroughColorEffectOptions _self;
  final $Res Function(FadeThroughColorEffectOptions) _then;

/// Create a copy of FadeThroughColorEffectOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? color = null,}) {
  return _then(FadeThroughColorEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [FadeThroughColorEffectOptions].
extension FadeThroughColorEffectOptionsPatterns on FadeThroughColorEffectOptions {
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


/// @nodoc
mixin _$SoftWipeEffectOptions {


/// Create a copy of SoftWipeEffectOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SoftWipeEffectOptionsCopyWith<SoftWipeEffectOptions> get copyWith => _$SoftWipeEffectOptionsCopyWithImpl<SoftWipeEffectOptions>(this as SoftWipeEffectOptions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SoftWipeEffectOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SoftWipeEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.style, _this.style) || other.style == _this.style));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SoftWipeEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.style);
}

@override
String toString() {
  final _this = this as SoftWipeEffectOptions;
  return 'SoftWipeEffectOptions(durationMs: ${_this.durationMs}, style: ${_this.style})';
}


}

/// @nodoc
abstract mixin class $SoftWipeEffectOptionsCopyWith<$Res>  {
  factory $SoftWipeEffectOptionsCopyWith(SoftWipeEffectOptions value, $Res Function(SoftWipeEffectOptions) _then) = _$SoftWipeEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, SoftWipeStyle style
});




}
/// @nodoc
class _$SoftWipeEffectOptionsCopyWithImpl<$Res>
    implements $SoftWipeEffectOptionsCopyWith<$Res> {
  _$SoftWipeEffectOptionsCopyWithImpl(this._self, this._then);

  final SoftWipeEffectOptions _self;
  final $Res Function(SoftWipeEffectOptions) _then;

/// Create a copy of SoftWipeEffectOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? style = null,}) {
  return _then(SoftWipeEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,style: null == style ? _self.style : style // ignore: cast_nullable_to_non_nullable
as SoftWipeStyle,
  ));
}

}


/// Adds pattern-matching-related methods to [SoftWipeEffectOptions].
extension SoftWipeEffectOptionsPatterns on SoftWipeEffectOptions {
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


/// @nodoc
mixin _$FlipEffectOptions {


/// Create a copy of FlipEffectOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FlipEffectOptionsCopyWith<FlipEffectOptions> get copyWith => _$FlipEffectOptionsCopyWithImpl<FlipEffectOptions>(this as FlipEffectOptions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as FlipEffectOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FlipEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.axis, _this.axis) || other.axis == _this.axis)&&(identical(other.rotationSense, _this.rotationSense) || other.rotationSense == _this.rotationSense)&&(identical(other.perspectiveStrength, _this.perspectiveStrength) || other.perspectiveStrength == _this.perspectiveStrength));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FlipEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.axis,_this.rotationSense,_this.perspectiveStrength);
}

@override
String toString() {
  final _this = this as FlipEffectOptions;
  return 'FlipEffectOptions(durationMs: ${_this.durationMs}, axis: ${_this.axis}, rotationSense: ${_this.rotationSense}, perspectiveStrength: ${_this.perspectiveStrength})';
}


}

/// @nodoc
abstract mixin class $FlipEffectOptionsCopyWith<$Res>  {
  factory $FlipEffectOptionsCopyWith(FlipEffectOptions value, $Res Function(FlipEffectOptions) _then) = _$FlipEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, EffectAxis axis, RotationSense rotationSense, double perspectiveStrength
});




}
/// @nodoc
class _$FlipEffectOptionsCopyWithImpl<$Res>
    implements $FlipEffectOptionsCopyWith<$Res> {
  _$FlipEffectOptionsCopyWithImpl(this._self, this._then);

  final FlipEffectOptions _self;
  final $Res Function(FlipEffectOptions) _then;

/// Create a copy of FlipEffectOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? axis = null,Object? rotationSense = null,Object? perspectiveStrength = null,}) {
  return _then(FlipEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,axis: null == axis ? _self.axis : axis // ignore: cast_nullable_to_non_nullable
as EffectAxis,rotationSense: null == rotationSense ? _self.rotationSense : rotationSense // ignore: cast_nullable_to_non_nullable
as RotationSense,perspectiveStrength: null == perspectiveStrength ? _self.perspectiveStrength : perspectiveStrength // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [FlipEffectOptions].
extension FlipEffectOptionsPatterns on FlipEffectOptions {
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


/// @nodoc
mixin _$RotateEffectOptions {


/// Create a copy of RotateEffectOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RotateEffectOptionsCopyWith<RotateEffectOptions> get copyWith => _$RotateEffectOptionsCopyWithImpl<RotateEffectOptions>(this as RotateEffectOptions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RotateEffectOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RotateEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.edge, _this.edge) || other.edge == _this.edge)&&(identical(other.angleDegrees, _this.angleDegrees) || other.angleDegrees == _this.angleDegrees)&&(identical(other.direction, _this.direction) || other.direction == _this.direction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RotateEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.edge,_this.angleDegrees,_this.direction);
}

@override
String toString() {
  final _this = this as RotateEffectOptions;
  return 'RotateEffectOptions(durationMs: ${_this.durationMs}, edge: ${_this.edge}, angleDegrees: ${_this.angleDegrees}, direction: ${_this.direction})';
}


}

/// @nodoc
abstract mixin class $RotateEffectOptionsCopyWith<$Res>  {
  factory $RotateEffectOptionsCopyWith(RotateEffectOptions value, $Res Function(RotateEffectOptions) _then) = _$RotateEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, RotationEdge edge, double angleDegrees, EffectDirection direction
});




}
/// @nodoc
class _$RotateEffectOptionsCopyWithImpl<$Res>
    implements $RotateEffectOptionsCopyWith<$Res> {
  _$RotateEffectOptionsCopyWithImpl(this._self, this._then);

  final RotateEffectOptions _self;
  final $Res Function(RotateEffectOptions) _then;

/// Create a copy of RotateEffectOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? edge = null,Object? angleDegrees = null,Object? direction = null,}) {
  return _then(RotateEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,edge: null == edge ? _self.edge : edge // ignore: cast_nullable_to_non_nullable
as RotationEdge,angleDegrees: null == angleDegrees ? _self.angleDegrees : angleDegrees // ignore: cast_nullable_to_non_nullable
as double,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as EffectDirection,
  ));
}

}


/// Adds pattern-matching-related methods to [RotateEffectOptions].
extension RotateEffectOptionsPatterns on RotateEffectOptions {
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


/// @nodoc
mixin _$BlindsEffectOptions {


/// Create a copy of BlindsEffectOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BlindsEffectOptionsCopyWith<BlindsEffectOptions> get copyWith => _$BlindsEffectOptionsCopyWithImpl<BlindsEffectOptions>(this as BlindsEffectOptions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BlindsEffectOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BlindsEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.stripCount, _this.stripCount) || other.stripCount == _this.stripCount)&&(identical(other.axis, _this.axis) || other.axis == _this.axis)&&(identical(other.order, _this.order) || other.order == _this.order)&&(identical(other.staggerFraction, _this.staggerFraction) || other.staggerFraction == _this.staggerFraction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as BlindsEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.stripCount,_this.axis,_this.order,_this.staggerFraction);
}

@override
String toString() {
  final _this = this as BlindsEffectOptions;
  return 'BlindsEffectOptions(durationMs: ${_this.durationMs}, stripCount: ${_this.stripCount}, axis: ${_this.axis}, order: ${_this.order}, staggerFraction: ${_this.staggerFraction})';
}


}

/// @nodoc
abstract mixin class $BlindsEffectOptionsCopyWith<$Res>  {
  factory $BlindsEffectOptionsCopyWith(BlindsEffectOptions value, $Res Function(BlindsEffectOptions) _then) = _$BlindsEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, int stripCount, EffectAxis axis, SequenceOrder order, double staggerFraction
});




}
/// @nodoc
class _$BlindsEffectOptionsCopyWithImpl<$Res>
    implements $BlindsEffectOptionsCopyWith<$Res> {
  _$BlindsEffectOptionsCopyWithImpl(this._self, this._then);

  final BlindsEffectOptions _self;
  final $Res Function(BlindsEffectOptions) _then;

/// Create a copy of BlindsEffectOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? stripCount = null,Object? axis = null,Object? order = null,Object? staggerFraction = null,}) {
  return _then(BlindsEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,stripCount: null == stripCount ? _self.stripCount : stripCount // ignore: cast_nullable_to_non_nullable
as int,axis: null == axis ? _self.axis : axis // ignore: cast_nullable_to_non_nullable
as EffectAxis,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as SequenceOrder,staggerFraction: null == staggerFraction ? _self.staggerFraction : staggerFraction // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [BlindsEffectOptions].
extension BlindsEffectOptionsPatterns on BlindsEffectOptions {
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


/// @nodoc
mixin _$SliceEffectOptions {


/// Create a copy of SliceEffectOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SliceEffectOptionsCopyWith<SliceEffectOptions> get copyWith => _$SliceEffectOptionsCopyWithImpl<SliceEffectOptions>(this as SliceEffectOptions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SliceEffectOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SliceEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.stripCount, _this.stripCount) || other.stripCount == _this.stripCount)&&(identical(other.mode, _this.mode) || other.mode == _this.mode)&&(identical(other.axis, _this.axis) || other.axis == _this.axis)&&(identical(other.staggerFraction, _this.staggerFraction) || other.staggerFraction == _this.staggerFraction)&&(identical(other.pattern, _this.pattern) || other.pattern == _this.pattern));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SliceEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.stripCount,_this.mode,_this.axis,_this.staggerFraction,_this.pattern);
}

@override
String toString() {
  final _this = this as SliceEffectOptions;
  return 'SliceEffectOptions(durationMs: ${_this.durationMs}, stripCount: ${_this.stripCount}, mode: ${_this.mode}, axis: ${_this.axis}, staggerFraction: ${_this.staggerFraction}, pattern: ${_this.pattern})';
}


}

/// @nodoc
abstract mixin class $SliceEffectOptionsCopyWith<$Res>  {
  factory $SliceEffectOptionsCopyWith(SliceEffectOptions value, $Res Function(SliceEffectOptions) _then) = _$SliceEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, int stripCount, SliceMode mode, EffectAxis axis, double staggerFraction, StripPattern pattern
});




}
/// @nodoc
class _$SliceEffectOptionsCopyWithImpl<$Res>
    implements $SliceEffectOptionsCopyWith<$Res> {
  _$SliceEffectOptionsCopyWithImpl(this._self, this._then);

  final SliceEffectOptions _self;
  final $Res Function(SliceEffectOptions) _then;

/// Create a copy of SliceEffectOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? stripCount = null,Object? mode = null,Object? axis = null,Object? staggerFraction = null,Object? pattern = null,}) {
  return _then(SliceEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,stripCount: null == stripCount ? _self.stripCount : stripCount // ignore: cast_nullable_to_non_nullable
as int,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as SliceMode,axis: null == axis ? _self.axis : axis // ignore: cast_nullable_to_non_nullable
as EffectAxis,staggerFraction: null == staggerFraction ? _self.staggerFraction : staggerFraction // ignore: cast_nullable_to_non_nullable
as double,pattern: null == pattern ? _self.pattern : pattern // ignore: cast_nullable_to_non_nullable
as StripPattern,
  ));
}

}


/// Adds pattern-matching-related methods to [SliceEffectOptions].
extension SliceEffectOptionsPatterns on SliceEffectOptions {
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


/// @nodoc
mixin _$GlassEffectOptions {


/// Create a copy of GlassEffectOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GlassEffectOptionsCopyWith<GlassEffectOptions> get copyWith => _$GlassEffectOptionsCopyWithImpl<GlassEffectOptions>(this as GlassEffectOptions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as GlassEffectOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GlassEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.paneCount, _this.paneCount) || other.paneCount == _this.paneCount)&&(identical(other.axis, _this.axis) || other.axis == _this.axis)&&(identical(other.refractionStrength, _this.refractionStrength) || other.refractionStrength == _this.refractionStrength)&&(identical(other.glintStrength, _this.glintStrength) || other.glintStrength == _this.glintStrength));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as GlassEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.paneCount,_this.axis,_this.refractionStrength,_this.glintStrength);
}

@override
String toString() {
  final _this = this as GlassEffectOptions;
  return 'GlassEffectOptions(durationMs: ${_this.durationMs}, paneCount: ${_this.paneCount}, axis: ${_this.axis}, refractionStrength: ${_this.refractionStrength}, glintStrength: ${_this.glintStrength})';
}


}

/// @nodoc
abstract mixin class $GlassEffectOptionsCopyWith<$Res>  {
  factory $GlassEffectOptionsCopyWith(GlassEffectOptions value, $Res Function(GlassEffectOptions) _then) = _$GlassEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, int paneCount, EffectAxis axis, double refractionStrength, double glintStrength
});




}
/// @nodoc
class _$GlassEffectOptionsCopyWithImpl<$Res>
    implements $GlassEffectOptionsCopyWith<$Res> {
  _$GlassEffectOptionsCopyWithImpl(this._self, this._then);

  final GlassEffectOptions _self;
  final $Res Function(GlassEffectOptions) _then;

/// Create a copy of GlassEffectOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? paneCount = null,Object? axis = null,Object? refractionStrength = null,Object? glintStrength = null,}) {
  return _then(GlassEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,paneCount: null == paneCount ? _self.paneCount : paneCount // ignore: cast_nullable_to_non_nullable
as int,axis: null == axis ? _self.axis : axis // ignore: cast_nullable_to_non_nullable
as EffectAxis,refractionStrength: null == refractionStrength ? _self.refractionStrength : refractionStrength // ignore: cast_nullable_to_non_nullable
as double,glintStrength: null == glintStrength ? _self.glintStrength : glintStrength // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [GlassEffectOptions].
extension GlassEffectOptionsPatterns on GlassEffectOptions {
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


/// @nodoc
mixin _$PanelWipeEffectOptions {


/// Create a copy of PanelWipeEffectOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PanelWipeEffectOptionsCopyWith<PanelWipeEffectOptions> get copyWith => _$PanelWipeEffectOptionsCopyWithImpl<PanelWipeEffectOptions>(this as PanelWipeEffectOptions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PanelWipeEffectOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PanelWipeEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.panelCount, _this.panelCount) || other.panelCount == _this.panelCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PanelWipeEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.panelCount);
}

@override
String toString() {
  final _this = this as PanelWipeEffectOptions;
  return 'PanelWipeEffectOptions(durationMs: ${_this.durationMs}, panelCount: ${_this.panelCount})';
}


}

/// @nodoc
abstract mixin class $PanelWipeEffectOptionsCopyWith<$Res>  {
  factory $PanelWipeEffectOptionsCopyWith(PanelWipeEffectOptions value, $Res Function(PanelWipeEffectOptions) _then) = _$PanelWipeEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, int panelCount
});




}
/// @nodoc
class _$PanelWipeEffectOptionsCopyWithImpl<$Res>
    implements $PanelWipeEffectOptionsCopyWith<$Res> {
  _$PanelWipeEffectOptionsCopyWithImpl(this._self, this._then);

  final PanelWipeEffectOptions _self;
  final $Res Function(PanelWipeEffectOptions) _then;

/// Create a copy of PanelWipeEffectOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? panelCount = null,}) {
  return _then(PanelWipeEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,panelCount: null == panelCount ? _self.panelCount : panelCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PanelWipeEffectOptions].
extension PanelWipeEffectOptionsPatterns on PanelWipeEffectOptions {
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


/// @nodoc
mixin _$LouverEffectOptions {


/// Create a copy of LouverEffectOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LouverEffectOptionsCopyWith<LouverEffectOptions> get copyWith => _$LouverEffectOptionsCopyWithImpl<LouverEffectOptions>(this as LouverEffectOptions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LouverEffectOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LouverEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.slatCount, _this.slatCount) || other.slatCount == _this.slatCount)&&(identical(other.axis, _this.axis) || other.axis == _this.axis)&&(identical(other.staggerFraction, _this.staggerFraction) || other.staggerFraction == _this.staggerFraction)&&(identical(other.shadowIntensity, _this.shadowIntensity) || other.shadowIntensity == _this.shadowIntensity)&&(identical(other.rotationSense, _this.rotationSense) || other.rotationSense == _this.rotationSense));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as LouverEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.slatCount,_this.axis,_this.staggerFraction,_this.shadowIntensity,_this.rotationSense);
}

@override
String toString() {
  final _this = this as LouverEffectOptions;
  return 'LouverEffectOptions(durationMs: ${_this.durationMs}, slatCount: ${_this.slatCount}, axis: ${_this.axis}, staggerFraction: ${_this.staggerFraction}, shadowIntensity: ${_this.shadowIntensity}, rotationSense: ${_this.rotationSense})';
}


}

/// @nodoc
abstract mixin class $LouverEffectOptionsCopyWith<$Res>  {
  factory $LouverEffectOptionsCopyWith(LouverEffectOptions value, $Res Function(LouverEffectOptions) _then) = _$LouverEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, int slatCount, EffectAxis axis, double staggerFraction, double shadowIntensity, RotationSense rotationSense
});




}
/// @nodoc
class _$LouverEffectOptionsCopyWithImpl<$Res>
    implements $LouverEffectOptionsCopyWith<$Res> {
  _$LouverEffectOptionsCopyWithImpl(this._self, this._then);

  final LouverEffectOptions _self;
  final $Res Function(LouverEffectOptions) _then;

/// Create a copy of LouverEffectOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? slatCount = null,Object? axis = null,Object? staggerFraction = null,Object? shadowIntensity = null,Object? rotationSense = null,}) {
  return _then(LouverEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,slatCount: null == slatCount ? _self.slatCount : slatCount // ignore: cast_nullable_to_non_nullable
as int,axis: null == axis ? _self.axis : axis // ignore: cast_nullable_to_non_nullable
as EffectAxis,staggerFraction: null == staggerFraction ? _self.staggerFraction : staggerFraction // ignore: cast_nullable_to_non_nullable
as double,shadowIntensity: null == shadowIntensity ? _self.shadowIntensity : shadowIntensity // ignore: cast_nullable_to_non_nullable
as double,rotationSense: null == rotationSense ? _self.rotationSense : rotationSense // ignore: cast_nullable_to_non_nullable
as RotationSense,
  ));
}

}


/// Adds pattern-matching-related methods to [LouverEffectOptions].
extension LouverEffectOptionsPatterns on LouverEffectOptions {
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


/// @nodoc
mixin _$FadeEffectOptions {


/// Create a copy of FadeEffectOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FadeEffectOptionsCopyWith<FadeEffectOptions> get copyWith => _$FadeEffectOptionsCopyWithImpl<FadeEffectOptions>(this as FadeEffectOptions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as FadeEffectOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FadeEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.style, _this.style) || other.style == _this.style)&&(identical(other.blendCurve, _this.blendCurve) || other.blendCurve == _this.blendCurve)&&(identical(other.maxSigma, _this.maxSigma) || other.maxSigma == _this.maxSigma)&&(identical(other.blurTarget, _this.blurTarget) || other.blurTarget == _this.blurTarget)&&(identical(other.color, _this.color) || other.color == _this.color)&&(identical(other.holdFraction, _this.holdFraction) || other.holdFraction == _this.holdFraction)&&(identical(other.fadeOutShare, _this.fadeOutShare) || other.fadeOutShare == _this.fadeOutShare));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FadeEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.style,_this.blendCurve,_this.maxSigma,_this.blurTarget,_this.color,_this.holdFraction,_this.fadeOutShare);
}

@override
String toString() {
  final _this = this as FadeEffectOptions;
  return 'FadeEffectOptions(durationMs: ${_this.durationMs}, style: ${_this.style}, blendCurve: ${_this.blendCurve}, maxSigma: ${_this.maxSigma}, blurTarget: ${_this.blurTarget}, color: ${_this.color}, holdFraction: ${_this.holdFraction}, fadeOutShare: ${_this.fadeOutShare})';
}


}

/// @nodoc
abstract mixin class $FadeEffectOptionsCopyWith<$Res>  {
  factory $FadeEffectOptionsCopyWith(FadeEffectOptions value, $Res Function(FadeEffectOptions) _then) = _$FadeEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, FadeStyle style, BlendCurve blendCurve, double maxSigma, BlurTarget blurTarget, int color, double holdFraction, double fadeOutShare
});




}
/// @nodoc
class _$FadeEffectOptionsCopyWithImpl<$Res>
    implements $FadeEffectOptionsCopyWith<$Res> {
  _$FadeEffectOptionsCopyWithImpl(this._self, this._then);

  final FadeEffectOptions _self;
  final $Res Function(FadeEffectOptions) _then;

/// Create a copy of FadeEffectOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? style = null,Object? blendCurve = null,Object? maxSigma = null,Object? blurTarget = null,Object? color = null,Object? holdFraction = null,Object? fadeOutShare = null,}) {
  return _then(FadeEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,style: null == style ? _self.style : style // ignore: cast_nullable_to_non_nullable
as FadeStyle,blendCurve: null == blendCurve ? _self.blendCurve : blendCurve // ignore: cast_nullable_to_non_nullable
as BlendCurve,maxSigma: null == maxSigma ? _self.maxSigma : maxSigma // ignore: cast_nullable_to_non_nullable
as double,blurTarget: null == blurTarget ? _self.blurTarget : blurTarget // ignore: cast_nullable_to_non_nullable
as BlurTarget,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int,holdFraction: null == holdFraction ? _self.holdFraction : holdFraction // ignore: cast_nullable_to_non_nullable
as double,fadeOutShare: null == fadeOutShare ? _self.fadeOutShare : fadeOutShare // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [FadeEffectOptions].
extension FadeEffectOptionsPatterns on FadeEffectOptions {
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


/// @nodoc
mixin _$LumaFadeEffectOptions {


/// Create a copy of LumaFadeEffectOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LumaFadeEffectOptionsCopyWith<LumaFadeEffectOptions> get copyWith => _$LumaFadeEffectOptionsCopyWithImpl<LumaFadeEffectOptions>(this as LumaFadeEffectOptions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LumaFadeEffectOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LumaFadeEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.order, _this.order) || other.order == _this.order)&&(identical(other.softness, _this.softness) || other.softness == _this.softness));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as LumaFadeEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.order,_this.softness);
}

@override
String toString() {
  final _this = this as LumaFadeEffectOptions;
  return 'LumaFadeEffectOptions(durationMs: ${_this.durationMs}, order: ${_this.order}, softness: ${_this.softness})';
}


}

/// @nodoc
abstract mixin class $LumaFadeEffectOptionsCopyWith<$Res>  {
  factory $LumaFadeEffectOptionsCopyWith(LumaFadeEffectOptions value, $Res Function(LumaFadeEffectOptions) _then) = _$LumaFadeEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, LumaOrder order, double softness
});




}
/// @nodoc
class _$LumaFadeEffectOptionsCopyWithImpl<$Res>
    implements $LumaFadeEffectOptionsCopyWith<$Res> {
  _$LumaFadeEffectOptionsCopyWithImpl(this._self, this._then);

  final LumaFadeEffectOptions _self;
  final $Res Function(LumaFadeEffectOptions) _then;

/// Create a copy of LumaFadeEffectOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? order = null,Object? softness = null,}) {
  return _then(LumaFadeEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as LumaOrder,softness: null == softness ? _self.softness : softness // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [LumaFadeEffectOptions].
extension LumaFadeEffectOptionsPatterns on LumaFadeEffectOptions {
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


/// @nodoc
mixin _$NoiseDissolveEffectOptions {


/// Create a copy of NoiseDissolveEffectOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NoiseDissolveEffectOptionsCopyWith<NoiseDissolveEffectOptions> get copyWith => _$NoiseDissolveEffectOptionsCopyWithImpl<NoiseDissolveEffectOptions>(this as NoiseDissolveEffectOptions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as NoiseDissolveEffectOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoiseDissolveEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.noiseScale, _this.noiseScale) || other.noiseScale == _this.noiseScale)&&(identical(other.softness, _this.softness) || other.softness == _this.softness));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as NoiseDissolveEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.noiseScale,_this.softness);
}

@override
String toString() {
  final _this = this as NoiseDissolveEffectOptions;
  return 'NoiseDissolveEffectOptions(durationMs: ${_this.durationMs}, noiseScale: ${_this.noiseScale}, softness: ${_this.softness})';
}


}

/// @nodoc
abstract mixin class $NoiseDissolveEffectOptionsCopyWith<$Res>  {
  factory $NoiseDissolveEffectOptionsCopyWith(NoiseDissolveEffectOptions value, $Res Function(NoiseDissolveEffectOptions) _then) = _$NoiseDissolveEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, double noiseScale, double softness
});




}
/// @nodoc
class _$NoiseDissolveEffectOptionsCopyWithImpl<$Res>
    implements $NoiseDissolveEffectOptionsCopyWith<$Res> {
  _$NoiseDissolveEffectOptionsCopyWithImpl(this._self, this._then);

  final NoiseDissolveEffectOptions _self;
  final $Res Function(NoiseDissolveEffectOptions) _then;

/// Create a copy of NoiseDissolveEffectOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? noiseScale = null,Object? softness = null,}) {
  return _then(NoiseDissolveEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,noiseScale: null == noiseScale ? _self.noiseScale : noiseScale // ignore: cast_nullable_to_non_nullable
as double,softness: null == softness ? _self.softness : softness // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [NoiseDissolveEffectOptions].
extension NoiseDissolveEffectOptionsPatterns on NoiseDissolveEffectOptions {
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


/// @nodoc
mixin _$RippleRevealEffectOptions {


/// Create a copy of RippleRevealEffectOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RippleRevealEffectOptionsCopyWith<RippleRevealEffectOptions> get copyWith => _$RippleRevealEffectOptionsCopyWithImpl<RippleRevealEffectOptions>(this as RippleRevealEffectOptions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RippleRevealEffectOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RippleRevealEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.origin, _this.origin) || other.origin == _this.origin)&&(identical(other.waveAmplitude, _this.waveAmplitude) || other.waveAmplitude == _this.waveAmplitude)&&(identical(other.waveFrequency, _this.waveFrequency) || other.waveFrequency == _this.waveFrequency)&&(identical(other.softness, _this.softness) || other.softness == _this.softness));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RippleRevealEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.origin,_this.waveAmplitude,_this.waveFrequency,_this.softness);
}

@override
String toString() {
  final _this = this as RippleRevealEffectOptions;
  return 'RippleRevealEffectOptions(durationMs: ${_this.durationMs}, origin: ${_this.origin}, waveAmplitude: ${_this.waveAmplitude}, waveFrequency: ${_this.waveFrequency}, softness: ${_this.softness})';
}


}

/// @nodoc
abstract mixin class $RippleRevealEffectOptionsCopyWith<$Res>  {
  factory $RippleRevealEffectOptionsCopyWith(RippleRevealEffectOptions value, $Res Function(RippleRevealEffectOptions) _then) = _$RippleRevealEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, EffectOrigin origin, double waveAmplitude, double waveFrequency, double softness
});




}
/// @nodoc
class _$RippleRevealEffectOptionsCopyWithImpl<$Res>
    implements $RippleRevealEffectOptionsCopyWith<$Res> {
  _$RippleRevealEffectOptionsCopyWithImpl(this._self, this._then);

  final RippleRevealEffectOptions _self;
  final $Res Function(RippleRevealEffectOptions) _then;

/// Create a copy of RippleRevealEffectOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? origin = null,Object? waveAmplitude = null,Object? waveFrequency = null,Object? softness = null,}) {
  return _then(RippleRevealEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as EffectOrigin,waveAmplitude: null == waveAmplitude ? _self.waveAmplitude : waveAmplitude // ignore: cast_nullable_to_non_nullable
as double,waveFrequency: null == waveFrequency ? _self.waveFrequency : waveFrequency // ignore: cast_nullable_to_non_nullable
as double,softness: null == softness ? _self.softness : softness // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [RippleRevealEffectOptions].
extension RippleRevealEffectOptionsPatterns on RippleRevealEffectOptions {
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


/// @nodoc
mixin _$WaterRefractionEffectOptions {


/// Create a copy of WaterRefractionEffectOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WaterRefractionEffectOptionsCopyWith<WaterRefractionEffectOptions> get copyWith => _$WaterRefractionEffectOptionsCopyWithImpl<WaterRefractionEffectOptions>(this as WaterRefractionEffectOptions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as WaterRefractionEffectOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WaterRefractionEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.origin, _this.origin) || other.origin == _this.origin)&&(identical(other.refractionStrength, _this.refractionStrength) || other.refractionStrength == _this.refractionStrength)&&(identical(other.waveFrequency, _this.waveFrequency) || other.waveFrequency == _this.waveFrequency)&&(identical(other.bandWidth, _this.bandWidth) || other.bandWidth == _this.bandWidth));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as WaterRefractionEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.origin,_this.refractionStrength,_this.waveFrequency,_this.bandWidth);
}

@override
String toString() {
  final _this = this as WaterRefractionEffectOptions;
  return 'WaterRefractionEffectOptions(durationMs: ${_this.durationMs}, origin: ${_this.origin}, refractionStrength: ${_this.refractionStrength}, waveFrequency: ${_this.waveFrequency}, bandWidth: ${_this.bandWidth})';
}


}

/// @nodoc
abstract mixin class $WaterRefractionEffectOptionsCopyWith<$Res>  {
  factory $WaterRefractionEffectOptionsCopyWith(WaterRefractionEffectOptions value, $Res Function(WaterRefractionEffectOptions) _then) = _$WaterRefractionEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, EffectOrigin origin, double refractionStrength, double waveFrequency, double bandWidth
});




}
/// @nodoc
class _$WaterRefractionEffectOptionsCopyWithImpl<$Res>
    implements $WaterRefractionEffectOptionsCopyWith<$Res> {
  _$WaterRefractionEffectOptionsCopyWithImpl(this._self, this._then);

  final WaterRefractionEffectOptions _self;
  final $Res Function(WaterRefractionEffectOptions) _then;

/// Create a copy of WaterRefractionEffectOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? origin = null,Object? refractionStrength = null,Object? waveFrequency = null,Object? bandWidth = null,}) {
  return _then(WaterRefractionEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as EffectOrigin,refractionStrength: null == refractionStrength ? _self.refractionStrength : refractionStrength // ignore: cast_nullable_to_non_nullable
as double,waveFrequency: null == waveFrequency ? _self.waveFrequency : waveFrequency // ignore: cast_nullable_to_non_nullable
as double,bandWidth: null == bandWidth ? _self.bandWidth : bandWidth // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [WaterRefractionEffectOptions].
extension WaterRefractionEffectOptionsPatterns on WaterRefractionEffectOptions {
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


/// @nodoc
mixin _$LiquidMorphEffectOptions {


/// Create a copy of LiquidMorphEffectOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiquidMorphEffectOptionsCopyWith<LiquidMorphEffectOptions> get copyWith => _$LiquidMorphEffectOptionsCopyWithImpl<LiquidMorphEffectOptions>(this as LiquidMorphEffectOptions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LiquidMorphEffectOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiquidMorphEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.waveCount, _this.waveCount) || other.waveCount == _this.waveCount)&&(identical(other.waveIntensity, _this.waveIntensity) || other.waveIntensity == _this.waveIntensity)&&(identical(other.outgoingScale, _this.outgoingScale) || other.outgoingScale == _this.outgoingScale)&&(identical(other.origin, _this.origin) || other.origin == _this.origin));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as LiquidMorphEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.waveCount,_this.waveIntensity,_this.outgoingScale,_this.origin);
}

@override
String toString() {
  final _this = this as LiquidMorphEffectOptions;
  return 'LiquidMorphEffectOptions(durationMs: ${_this.durationMs}, waveCount: ${_this.waveCount}, waveIntensity: ${_this.waveIntensity}, outgoingScale: ${_this.outgoingScale}, origin: ${_this.origin})';
}


}

/// @nodoc
abstract mixin class $LiquidMorphEffectOptionsCopyWith<$Res>  {
  factory $LiquidMorphEffectOptionsCopyWith(LiquidMorphEffectOptions value, $Res Function(LiquidMorphEffectOptions) _then) = _$LiquidMorphEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, int waveCount, double waveIntensity, double outgoingScale, EffectOrigin origin
});




}
/// @nodoc
class _$LiquidMorphEffectOptionsCopyWithImpl<$Res>
    implements $LiquidMorphEffectOptionsCopyWith<$Res> {
  _$LiquidMorphEffectOptionsCopyWithImpl(this._self, this._then);

  final LiquidMorphEffectOptions _self;
  final $Res Function(LiquidMorphEffectOptions) _then;

/// Create a copy of LiquidMorphEffectOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? waveCount = null,Object? waveIntensity = null,Object? outgoingScale = null,Object? origin = null,}) {
  return _then(LiquidMorphEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,waveCount: null == waveCount ? _self.waveCount : waveCount // ignore: cast_nullable_to_non_nullable
as int,waveIntensity: null == waveIntensity ? _self.waveIntensity : waveIntensity // ignore: cast_nullable_to_non_nullable
as double,outgoingScale: null == outgoingScale ? _self.outgoingScale : outgoingScale // ignore: cast_nullable_to_non_nullable
as double,origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as EffectOrigin,
  ));
}

}


/// Adds pattern-matching-related methods to [LiquidMorphEffectOptions].
extension LiquidMorphEffectOptionsPatterns on LiquidMorphEffectOptions {
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


/// @nodoc
mixin _$CubeEffectOptions {


/// Create a copy of CubeEffectOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CubeEffectOptionsCopyWith<CubeEffectOptions> get copyWith => _$CubeEffectOptionsCopyWithImpl<CubeEffectOptions>(this as CubeEffectOptions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CubeEffectOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CubeEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.direction, _this.direction) || other.direction == _this.direction)&&(identical(other.shadowIntensity, _this.shadowIntensity) || other.shadowIntensity == _this.shadowIntensity)&&(identical(other.perspectiveStrength, _this.perspectiveStrength) || other.perspectiveStrength == _this.perspectiveStrength));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CubeEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.direction,_this.shadowIntensity,_this.perspectiveStrength);
}

@override
String toString() {
  final _this = this as CubeEffectOptions;
  return 'CubeEffectOptions(durationMs: ${_this.durationMs}, direction: ${_this.direction}, shadowIntensity: ${_this.shadowIntensity}, perspectiveStrength: ${_this.perspectiveStrength})';
}


}

/// @nodoc
abstract mixin class $CubeEffectOptionsCopyWith<$Res>  {
  factory $CubeEffectOptionsCopyWith(CubeEffectOptions value, $Res Function(CubeEffectOptions) _then) = _$CubeEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, EffectDirection direction, double shadowIntensity, double perspectiveStrength
});




}
/// @nodoc
class _$CubeEffectOptionsCopyWithImpl<$Res>
    implements $CubeEffectOptionsCopyWith<$Res> {
  _$CubeEffectOptionsCopyWithImpl(this._self, this._then);

  final CubeEffectOptions _self;
  final $Res Function(CubeEffectOptions) _then;

/// Create a copy of CubeEffectOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? direction = null,Object? shadowIntensity = null,Object? perspectiveStrength = null,}) {
  return _then(CubeEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as EffectDirection,shadowIntensity: null == shadowIntensity ? _self.shadowIntensity : shadowIntensity // ignore: cast_nullable_to_non_nullable
as double,perspectiveStrength: null == perspectiveStrength ? _self.perspectiveStrength : perspectiveStrength // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [CubeEffectOptions].
extension CubeEffectOptionsPatterns on CubeEffectOptions {
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


/// @nodoc
mixin _$AccordionEffectOptions {


/// Create a copy of AccordionEffectOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccordionEffectOptionsCopyWith<AccordionEffectOptions> get copyWith => _$AccordionEffectOptionsCopyWithImpl<AccordionEffectOptions>(this as AccordionEffectOptions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AccordionEffectOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccordionEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.direction, _this.direction) || other.direction == _this.direction)&&(identical(other.shadowIntensity, _this.shadowIntensity) || other.shadowIntensity == _this.shadowIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AccordionEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.direction,_this.shadowIntensity);
}

@override
String toString() {
  final _this = this as AccordionEffectOptions;
  return 'AccordionEffectOptions(durationMs: ${_this.durationMs}, direction: ${_this.direction}, shadowIntensity: ${_this.shadowIntensity})';
}


}

/// @nodoc
abstract mixin class $AccordionEffectOptionsCopyWith<$Res>  {
  factory $AccordionEffectOptionsCopyWith(AccordionEffectOptions value, $Res Function(AccordionEffectOptions) _then) = _$AccordionEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, EffectDirection direction, double shadowIntensity
});




}
/// @nodoc
class _$AccordionEffectOptionsCopyWithImpl<$Res>
    implements $AccordionEffectOptionsCopyWith<$Res> {
  _$AccordionEffectOptionsCopyWithImpl(this._self, this._then);

  final AccordionEffectOptions _self;
  final $Res Function(AccordionEffectOptions) _then;

/// Create a copy of AccordionEffectOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? direction = null,Object? shadowIntensity = null,}) {
  return _then(AccordionEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as EffectDirection,shadowIntensity: null == shadowIntensity ? _self.shadowIntensity : shadowIntensity // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [AccordionEffectOptions].
extension AccordionEffectOptionsPatterns on AccordionEffectOptions {
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


/// @nodoc
mixin _$DepthEffectOptions {


/// Create a copy of DepthEffectOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DepthEffectOptionsCopyWith<DepthEffectOptions> get copyWith => _$DepthEffectOptionsCopyWithImpl<DepthEffectOptions>(this as DepthEffectOptions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DepthEffectOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DepthEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.mode, _this.mode) || other.mode == _this.mode)&&(identical(other.scale, _this.scale) || other.scale == _this.scale)&&(identical(other.shadowIntensity, _this.shadowIntensity) || other.shadowIntensity == _this.shadowIntensity)&&(identical(other.direction, _this.direction) || other.direction == _this.direction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DepthEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.mode,_this.scale,_this.shadowIntensity,_this.direction);
}

@override
String toString() {
  final _this = this as DepthEffectOptions;
  return 'DepthEffectOptions(durationMs: ${_this.durationMs}, mode: ${_this.mode}, scale: ${_this.scale}, shadowIntensity: ${_this.shadowIntensity}, direction: ${_this.direction})';
}


}

/// @nodoc
abstract mixin class $DepthEffectOptionsCopyWith<$Res>  {
  factory $DepthEffectOptionsCopyWith(DepthEffectOptions value, $Res Function(DepthEffectOptions) _then) = _$DepthEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, DepthMode mode, double scale, double shadowIntensity, EffectDirection direction
});




}
/// @nodoc
class _$DepthEffectOptionsCopyWithImpl<$Res>
    implements $DepthEffectOptionsCopyWith<$Res> {
  _$DepthEffectOptionsCopyWithImpl(this._self, this._then);

  final DepthEffectOptions _self;
  final $Res Function(DepthEffectOptions) _then;

/// Create a copy of DepthEffectOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? mode = null,Object? scale = null,Object? shadowIntensity = null,Object? direction = null,}) {
  return _then(DepthEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as DepthMode,scale: null == scale ? _self.scale : scale // ignore: cast_nullable_to_non_nullable
as double,shadowIntensity: null == shadowIntensity ? _self.shadowIntensity : shadowIntensity // ignore: cast_nullable_to_non_nullable
as double,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as EffectDirection,
  ));
}

}


/// Adds pattern-matching-related methods to [DepthEffectOptions].
extension DepthEffectOptionsPatterns on DepthEffectOptions {
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


/// @nodoc
mixin _$ParallaxEffectOptions {


/// Create a copy of ParallaxEffectOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParallaxEffectOptionsCopyWith<ParallaxEffectOptions> get copyWith => _$ParallaxEffectOptionsCopyWithImpl<ParallaxEffectOptions>(this as ParallaxEffectOptions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ParallaxEffectOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParallaxEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.clipAmount, _this.clipAmount) || other.clipAmount == _this.clipAmount)&&(identical(other.direction, _this.direction) || other.direction == _this.direction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ParallaxEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.clipAmount,_this.direction);
}

@override
String toString() {
  final _this = this as ParallaxEffectOptions;
  return 'ParallaxEffectOptions(durationMs: ${_this.durationMs}, clipAmount: ${_this.clipAmount}, direction: ${_this.direction})';
}


}

/// @nodoc
abstract mixin class $ParallaxEffectOptionsCopyWith<$Res>  {
  factory $ParallaxEffectOptionsCopyWith(ParallaxEffectOptions value, $Res Function(ParallaxEffectOptions) _then) = _$ParallaxEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, double clipAmount, EffectDirection direction
});




}
/// @nodoc
class _$ParallaxEffectOptionsCopyWithImpl<$Res>
    implements $ParallaxEffectOptionsCopyWith<$Res> {
  _$ParallaxEffectOptionsCopyWithImpl(this._self, this._then);

  final ParallaxEffectOptions _self;
  final $Res Function(ParallaxEffectOptions) _then;

/// Create a copy of ParallaxEffectOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? clipAmount = null,Object? direction = null,}) {
  return _then(ParallaxEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,clipAmount: null == clipAmount ? _self.clipAmount : clipAmount // ignore: cast_nullable_to_non_nullable
as double,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as EffectDirection,
  ));
}

}


/// Adds pattern-matching-related methods to [ParallaxEffectOptions].
extension ParallaxEffectOptionsPatterns on ParallaxEffectOptions {
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


/// @nodoc
mixin _$TabletEffectOptions {


/// Create a copy of TabletEffectOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TabletEffectOptionsCopyWith<TabletEffectOptions> get copyWith => _$TabletEffectOptionsCopyWithImpl<TabletEffectOptions>(this as TabletEffectOptions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TabletEffectOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TabletEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.direction, _this.direction) || other.direction == _this.direction)&&(identical(other.tiltDegrees, _this.tiltDegrees) || other.tiltDegrees == _this.tiltDegrees)&&(identical(other.perspectiveStrength, _this.perspectiveStrength) || other.perspectiveStrength == _this.perspectiveStrength));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TabletEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.direction,_this.tiltDegrees,_this.perspectiveStrength);
}

@override
String toString() {
  final _this = this as TabletEffectOptions;
  return 'TabletEffectOptions(durationMs: ${_this.durationMs}, direction: ${_this.direction}, tiltDegrees: ${_this.tiltDegrees}, perspectiveStrength: ${_this.perspectiveStrength})';
}


}

/// @nodoc
abstract mixin class $TabletEffectOptionsCopyWith<$Res>  {
  factory $TabletEffectOptionsCopyWith(TabletEffectOptions value, $Res Function(TabletEffectOptions) _then) = _$TabletEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, EffectDirection direction, double tiltDegrees, double perspectiveStrength
});




}
/// @nodoc
class _$TabletEffectOptionsCopyWithImpl<$Res>
    implements $TabletEffectOptionsCopyWith<$Res> {
  _$TabletEffectOptionsCopyWithImpl(this._self, this._then);

  final TabletEffectOptions _self;
  final $Res Function(TabletEffectOptions) _then;

/// Create a copy of TabletEffectOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? direction = null,Object? tiltDegrees = null,Object? perspectiveStrength = null,}) {
  return _then(TabletEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as EffectDirection,tiltDegrees: null == tiltDegrees ? _self.tiltDegrees : tiltDegrees // ignore: cast_nullable_to_non_nullable
as double,perspectiveStrength: null == perspectiveStrength ? _self.perspectiveStrength : perspectiveStrength // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [TabletEffectOptions].
extension TabletEffectOptionsPatterns on TabletEffectOptions {
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


/// @nodoc
mixin _$ZoomOutEffectOptions {


/// Create a copy of ZoomOutEffectOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ZoomOutEffectOptionsCopyWith<ZoomOutEffectOptions> get copyWith => _$ZoomOutEffectOptionsCopyWithImpl<ZoomOutEffectOptions>(this as ZoomOutEffectOptions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ZoomOutEffectOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ZoomOutEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.zoomOutScale, _this.zoomOutScale) || other.zoomOutScale == _this.zoomOutScale)&&(identical(other.enableOpacity, _this.enableOpacity) || other.enableOpacity == _this.enableOpacity)&&(identical(other.direction, _this.direction) || other.direction == _this.direction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ZoomOutEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.zoomOutScale,_this.enableOpacity,_this.direction);
}

@override
String toString() {
  final _this = this as ZoomOutEffectOptions;
  return 'ZoomOutEffectOptions(durationMs: ${_this.durationMs}, zoomOutScale: ${_this.zoomOutScale}, enableOpacity: ${_this.enableOpacity}, direction: ${_this.direction})';
}


}

/// @nodoc
abstract mixin class $ZoomOutEffectOptionsCopyWith<$Res>  {
  factory $ZoomOutEffectOptionsCopyWith(ZoomOutEffectOptions value, $Res Function(ZoomOutEffectOptions) _then) = _$ZoomOutEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, double zoomOutScale, bool enableOpacity, EffectDirection direction
});




}
/// @nodoc
class _$ZoomOutEffectOptionsCopyWithImpl<$Res>
    implements $ZoomOutEffectOptionsCopyWith<$Res> {
  _$ZoomOutEffectOptionsCopyWithImpl(this._self, this._then);

  final ZoomOutEffectOptions _self;
  final $Res Function(ZoomOutEffectOptions) _then;

/// Create a copy of ZoomOutEffectOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? zoomOutScale = null,Object? enableOpacity = null,Object? direction = null,}) {
  return _then(ZoomOutEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,zoomOutScale: null == zoomOutScale ? _self.zoomOutScale : zoomOutScale // ignore: cast_nullable_to_non_nullable
as double,enableOpacity: null == enableOpacity ? _self.enableOpacity : enableOpacity // ignore: cast_nullable_to_non_nullable
as bool,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as EffectDirection,
  ));
}

}


/// Adds pattern-matching-related methods to [ZoomOutEffectOptions].
extension ZoomOutEffectOptionsPatterns on ZoomOutEffectOptions {
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


/// @nodoc
mixin _$ZoomOverEffectOptions {


/// Create a copy of ZoomOverEffectOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ZoomOverEffectOptionsCopyWith<ZoomOverEffectOptions> get copyWith => _$ZoomOverEffectOptionsCopyWithImpl<ZoomOverEffectOptions>(this as ZoomOverEffectOptions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ZoomOverEffectOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ZoomOverEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.mode, _this.mode) || other.mode == _this.mode)&&(identical(other.startScale, _this.startScale) || other.startScale == _this.startScale)&&(identical(other.outgoingScale, _this.outgoingScale) || other.outgoingScale == _this.outgoingScale)&&(identical(other.blurFraction, _this.blurFraction) || other.blurFraction == _this.blurFraction)&&(identical(other.origin, _this.origin) || other.origin == _this.origin));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ZoomOverEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.mode,_this.startScale,_this.outgoingScale,_this.blurFraction,_this.origin);
}

@override
String toString() {
  final _this = this as ZoomOverEffectOptions;
  return 'ZoomOverEffectOptions(durationMs: ${_this.durationMs}, mode: ${_this.mode}, startScale: ${_this.startScale}, outgoingScale: ${_this.outgoingScale}, blurFraction: ${_this.blurFraction}, origin: ${_this.origin})';
}


}

/// @nodoc
abstract mixin class $ZoomOverEffectOptionsCopyWith<$Res>  {
  factory $ZoomOverEffectOptionsCopyWith(ZoomOverEffectOptions value, $Res Function(ZoomOverEffectOptions) _then) = _$ZoomOverEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, ZoomMode mode, double startScale, double outgoingScale, double blurFraction, EffectOrigin origin
});




}
/// @nodoc
class _$ZoomOverEffectOptionsCopyWithImpl<$Res>
    implements $ZoomOverEffectOptionsCopyWith<$Res> {
  _$ZoomOverEffectOptionsCopyWithImpl(this._self, this._then);

  final ZoomOverEffectOptions _self;
  final $Res Function(ZoomOverEffectOptions) _then;

/// Create a copy of ZoomOverEffectOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? mode = null,Object? startScale = null,Object? outgoingScale = null,Object? blurFraction = null,Object? origin = null,}) {
  return _then(ZoomOverEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as ZoomMode,startScale: null == startScale ? _self.startScale : startScale // ignore: cast_nullable_to_non_nullable
as double,outgoingScale: null == outgoingScale ? _self.outgoingScale : outgoingScale // ignore: cast_nullable_to_non_nullable
as double,blurFraction: null == blurFraction ? _self.blurFraction : blurFraction // ignore: cast_nullable_to_non_nullable
as double,origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as EffectOrigin,
  ));
}

}


/// Adds pattern-matching-related methods to [ZoomOverEffectOptions].
extension ZoomOverEffectOptionsPatterns on ZoomOverEffectOptions {
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


/// @nodoc
mixin _$PagePeelEffectOptions {


/// Create a copy of PagePeelEffectOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PagePeelEffectOptionsCopyWith<PagePeelEffectOptions> get copyWith => _$PagePeelEffectOptionsCopyWithImpl<PagePeelEffectOptions>(this as PagePeelEffectOptions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PagePeelEffectOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PagePeelEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.corner, _this.corner) || other.corner == _this.corner)&&(identical(other.foldWidth, _this.foldWidth) || other.foldWidth == _this.foldWidth)&&(identical(other.paperColor, _this.paperColor) || other.paperColor == _this.paperColor)&&(identical(other.shadowStrength, _this.shadowStrength) || other.shadowStrength == _this.shadowStrength));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PagePeelEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.corner,_this.foldWidth,_this.paperColor,_this.shadowStrength);
}

@override
String toString() {
  final _this = this as PagePeelEffectOptions;
  return 'PagePeelEffectOptions(durationMs: ${_this.durationMs}, corner: ${_this.corner}, foldWidth: ${_this.foldWidth}, paperColor: ${_this.paperColor}, shadowStrength: ${_this.shadowStrength})';
}


}

/// @nodoc
abstract mixin class $PagePeelEffectOptionsCopyWith<$Res>  {
  factory $PagePeelEffectOptionsCopyWith(PagePeelEffectOptions value, $Res Function(PagePeelEffectOptions) _then) = _$PagePeelEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, EffectOrigin corner, double foldWidth, int paperColor, double shadowStrength
});




}
/// @nodoc
class _$PagePeelEffectOptionsCopyWithImpl<$Res>
    implements $PagePeelEffectOptionsCopyWith<$Res> {
  _$PagePeelEffectOptionsCopyWithImpl(this._self, this._then);

  final PagePeelEffectOptions _self;
  final $Res Function(PagePeelEffectOptions) _then;

/// Create a copy of PagePeelEffectOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? corner = null,Object? foldWidth = null,Object? paperColor = null,Object? shadowStrength = null,}) {
  return _then(PagePeelEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,corner: null == corner ? _self.corner : corner // ignore: cast_nullable_to_non_nullable
as EffectOrigin,foldWidth: null == foldWidth ? _self.foldWidth : foldWidth // ignore: cast_nullable_to_non_nullable
as double,paperColor: null == paperColor ? _self.paperColor : paperColor // ignore: cast_nullable_to_non_nullable
as int,shadowStrength: null == shadowStrength ? _self.shadowStrength : shadowStrength // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [PagePeelEffectOptions].
extension PagePeelEffectOptionsPatterns on PagePeelEffectOptions {
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


/// @nodoc
mixin _$SplitEffectOptions {


/// Create a copy of SplitEffectOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SplitEffectOptionsCopyWith<SplitEffectOptions> get copyWith => _$SplitEffectOptionsCopyWithImpl<SplitEffectOptions>(this as SplitEffectOptions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SplitEffectOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SplitEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.axis, _this.axis) || other.axis == _this.axis)&&(identical(other.splitPosition, _this.splitPosition) || other.splitPosition == _this.splitPosition));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SplitEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.axis,_this.splitPosition);
}

@override
String toString() {
  final _this = this as SplitEffectOptions;
  return 'SplitEffectOptions(durationMs: ${_this.durationMs}, axis: ${_this.axis}, splitPosition: ${_this.splitPosition})';
}


}

/// @nodoc
abstract mixin class $SplitEffectOptionsCopyWith<$Res>  {
  factory $SplitEffectOptionsCopyWith(SplitEffectOptions value, $Res Function(SplitEffectOptions) _then) = _$SplitEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, EffectAxis axis, double splitPosition
});




}
/// @nodoc
class _$SplitEffectOptionsCopyWithImpl<$Res>
    implements $SplitEffectOptionsCopyWith<$Res> {
  _$SplitEffectOptionsCopyWithImpl(this._self, this._then);

  final SplitEffectOptions _self;
  final $Res Function(SplitEffectOptions) _then;

/// Create a copy of SplitEffectOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? axis = null,Object? splitPosition = null,}) {
  return _then(SplitEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,axis: null == axis ? _self.axis : axis // ignore: cast_nullable_to_non_nullable
as EffectAxis,splitPosition: null == splitPosition ? _self.splitPosition : splitPosition // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SplitEffectOptions].
extension SplitEffectOptionsPatterns on SplitEffectOptions {
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


/// @nodoc
mixin _$StretchEffectOptions {


/// Create a copy of StretchEffectOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StretchEffectOptionsCopyWith<StretchEffectOptions> get copyWith => _$StretchEffectOptionsCopyWithImpl<StretchEffectOptions>(this as StretchEffectOptions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as StretchEffectOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StretchEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.axis, _this.axis) || other.axis == _this.axis)&&(identical(other.maxScale, _this.maxScale) || other.maxScale == _this.maxScale));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as StretchEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.axis,_this.maxScale);
}

@override
String toString() {
  final _this = this as StretchEffectOptions;
  return 'StretchEffectOptions(durationMs: ${_this.durationMs}, axis: ${_this.axis}, maxScale: ${_this.maxScale})';
}


}

/// @nodoc
abstract mixin class $StretchEffectOptionsCopyWith<$Res>  {
  factory $StretchEffectOptionsCopyWith(StretchEffectOptions value, $Res Function(StretchEffectOptions) _then) = _$StretchEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, EffectAxis axis, double maxScale
});




}
/// @nodoc
class _$StretchEffectOptionsCopyWithImpl<$Res>
    implements $StretchEffectOptionsCopyWith<$Res> {
  _$StretchEffectOptionsCopyWithImpl(this._self, this._then);

  final StretchEffectOptions _self;
  final $Res Function(StretchEffectOptions) _then;

/// Create a copy of StretchEffectOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? axis = null,Object? maxScale = null,}) {
  return _then(StretchEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,axis: null == axis ? _self.axis : axis // ignore: cast_nullable_to_non_nullable
as EffectAxis,maxScale: null == maxScale ? _self.maxScale : maxScale // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [StretchEffectOptions].
extension StretchEffectOptionsPatterns on StretchEffectOptions {
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


/// @nodoc
mixin _$MirrorEffectOptions {


/// Create a copy of MirrorEffectOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MirrorEffectOptionsCopyWith<MirrorEffectOptions> get copyWith => _$MirrorEffectOptionsCopyWithImpl<MirrorEffectOptions>(this as MirrorEffectOptions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MirrorEffectOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MirrorEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.axis, _this.axis) || other.axis == _this.axis)&&(identical(other.side, _this.side) || other.side == _this.side)&&(identical(other.strength, _this.strength) || other.strength == _this.strength));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MirrorEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.axis,_this.side,_this.strength);
}

@override
String toString() {
  final _this = this as MirrorEffectOptions;
  return 'MirrorEffectOptions(durationMs: ${_this.durationMs}, axis: ${_this.axis}, side: ${_this.side}, strength: ${_this.strength})';
}


}

/// @nodoc
abstract mixin class $MirrorEffectOptionsCopyWith<$Res>  {
  factory $MirrorEffectOptionsCopyWith(MirrorEffectOptions value, $Res Function(MirrorEffectOptions) _then) = _$MirrorEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, EffectAxis axis, MirrorSide side, double strength
});




}
/// @nodoc
class _$MirrorEffectOptionsCopyWithImpl<$Res>
    implements $MirrorEffectOptionsCopyWith<$Res> {
  _$MirrorEffectOptionsCopyWithImpl(this._self, this._then);

  final MirrorEffectOptions _self;
  final $Res Function(MirrorEffectOptions) _then;

/// Create a copy of MirrorEffectOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? axis = null,Object? side = null,Object? strength = null,}) {
  return _then(MirrorEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,axis: null == axis ? _self.axis : axis // ignore: cast_nullable_to_non_nullable
as EffectAxis,side: null == side ? _self.side : side // ignore: cast_nullable_to_non_nullable
as MirrorSide,strength: null == strength ? _self.strength : strength // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [MirrorEffectOptions].
extension MirrorEffectOptionsPatterns on MirrorEffectOptions {
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


/// @nodoc
mixin _$LightLeakEffectOptions {


/// Create a copy of LightLeakEffectOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LightLeakEffectOptionsCopyWith<LightLeakEffectOptions> get copyWith => _$LightLeakEffectOptionsCopyWithImpl<LightLeakEffectOptions>(this as LightLeakEffectOptions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LightLeakEffectOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LightLeakEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.direction, _this.direction) || other.direction == _this.direction)&&(identical(other.strength, _this.strength) || other.strength == _this.strength)&&(identical(other.radius, _this.radius) || other.radius == _this.radius)&&(identical(other.warmColor, _this.warmColor) || other.warmColor == _this.warmColor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as LightLeakEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.direction,_this.strength,_this.radius,_this.warmColor);
}

@override
String toString() {
  final _this = this as LightLeakEffectOptions;
  return 'LightLeakEffectOptions(durationMs: ${_this.durationMs}, direction: ${_this.direction}, strength: ${_this.strength}, radius: ${_this.radius}, warmColor: ${_this.warmColor})';
}


}

/// @nodoc
abstract mixin class $LightLeakEffectOptionsCopyWith<$Res>  {
  factory $LightLeakEffectOptionsCopyWith(LightLeakEffectOptions value, $Res Function(LightLeakEffectOptions) _then) = _$LightLeakEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, EffectDirection direction, double strength, double radius, int warmColor
});




}
/// @nodoc
class _$LightLeakEffectOptionsCopyWithImpl<$Res>
    implements $LightLeakEffectOptionsCopyWith<$Res> {
  _$LightLeakEffectOptionsCopyWithImpl(this._self, this._then);

  final LightLeakEffectOptions _self;
  final $Res Function(LightLeakEffectOptions) _then;

/// Create a copy of LightLeakEffectOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? direction = null,Object? strength = null,Object? radius = null,Object? warmColor = null,}) {
  return _then(LightLeakEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as EffectDirection,strength: null == strength ? _self.strength : strength // ignore: cast_nullable_to_non_nullable
as double,radius: null == radius ? _self.radius : radius // ignore: cast_nullable_to_non_nullable
as double,warmColor: null == warmColor ? _self.warmColor : warmColor // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [LightLeakEffectOptions].
extension LightLeakEffectOptionsPatterns on LightLeakEffectOptions {
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


/// @nodoc
mixin _$BurnAlphaEffectOptions {


/// Create a copy of BurnAlphaEffectOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BurnAlphaEffectOptionsCopyWith<BurnAlphaEffectOptions> get copyWith => _$BurnAlphaEffectOptionsCopyWithImpl<BurnAlphaEffectOptions>(this as BurnAlphaEffectOptions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BurnAlphaEffectOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BurnAlphaEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.direction, _this.direction) || other.direction == _this.direction)&&(identical(other.roughness, _this.roughness) || other.roughness == _this.roughness)&&(identical(other.edgeWidth, _this.edgeWidth) || other.edgeWidth == _this.edgeWidth)&&(identical(other.emberColor, _this.emberColor) || other.emberColor == _this.emberColor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as BurnAlphaEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.direction,_this.roughness,_this.edgeWidth,_this.emberColor);
}

@override
String toString() {
  final _this = this as BurnAlphaEffectOptions;
  return 'BurnAlphaEffectOptions(durationMs: ${_this.durationMs}, direction: ${_this.direction}, roughness: ${_this.roughness}, edgeWidth: ${_this.edgeWidth}, emberColor: ${_this.emberColor})';
}


}

/// @nodoc
abstract mixin class $BurnAlphaEffectOptionsCopyWith<$Res>  {
  factory $BurnAlphaEffectOptionsCopyWith(BurnAlphaEffectOptions value, $Res Function(BurnAlphaEffectOptions) _then) = _$BurnAlphaEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, EffectDirection direction, double roughness, double edgeWidth, int emberColor
});




}
/// @nodoc
class _$BurnAlphaEffectOptionsCopyWithImpl<$Res>
    implements $BurnAlphaEffectOptionsCopyWith<$Res> {
  _$BurnAlphaEffectOptionsCopyWithImpl(this._self, this._then);

  final BurnAlphaEffectOptions _self;
  final $Res Function(BurnAlphaEffectOptions) _then;

/// Create a copy of BurnAlphaEffectOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? direction = null,Object? roughness = null,Object? edgeWidth = null,Object? emberColor = null,}) {
  return _then(BurnAlphaEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as EffectDirection,roughness: null == roughness ? _self.roughness : roughness // ignore: cast_nullable_to_non_nullable
as double,edgeWidth: null == edgeWidth ? _self.edgeWidth : edgeWidth // ignore: cast_nullable_to_non_nullable
as double,emberColor: null == emberColor ? _self.emberColor : emberColor // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BurnAlphaEffectOptions].
extension BurnAlphaEffectOptionsPatterns on BurnAlphaEffectOptions {
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


/// @nodoc
mixin _$FoldMotionEffectOptions {


/// Create a copy of FoldMotionEffectOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FoldMotionEffectOptionsCopyWith<FoldMotionEffectOptions> get copyWith => _$FoldMotionEffectOptionsCopyWithImpl<FoldMotionEffectOptions>(this as FoldMotionEffectOptions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as FoldMotionEffectOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FoldMotionEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.axis, _this.axis) || other.axis == _this.axis)&&(identical(other.shadowIntensity, _this.shadowIntensity) || other.shadowIntensity == _this.shadowIntensity)&&(identical(other.perspectiveStrength, _this.perspectiveStrength) || other.perspectiveStrength == _this.perspectiveStrength));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FoldMotionEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.axis,_this.shadowIntensity,_this.perspectiveStrength);
}

@override
String toString() {
  final _this = this as FoldMotionEffectOptions;
  return 'FoldMotionEffectOptions(durationMs: ${_this.durationMs}, axis: ${_this.axis}, shadowIntensity: ${_this.shadowIntensity}, perspectiveStrength: ${_this.perspectiveStrength})';
}


}

/// @nodoc
abstract mixin class $FoldMotionEffectOptionsCopyWith<$Res>  {
  factory $FoldMotionEffectOptionsCopyWith(FoldMotionEffectOptions value, $Res Function(FoldMotionEffectOptions) _then) = _$FoldMotionEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, EffectAxis axis, double shadowIntensity, double perspectiveStrength
});




}
/// @nodoc
class _$FoldMotionEffectOptionsCopyWithImpl<$Res>
    implements $FoldMotionEffectOptionsCopyWith<$Res> {
  _$FoldMotionEffectOptionsCopyWithImpl(this._self, this._then);

  final FoldMotionEffectOptions _self;
  final $Res Function(FoldMotionEffectOptions) _then;

/// Create a copy of FoldMotionEffectOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? axis = null,Object? shadowIntensity = null,Object? perspectiveStrength = null,}) {
  return _then(FoldMotionEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,axis: null == axis ? _self.axis : axis // ignore: cast_nullable_to_non_nullable
as EffectAxis,shadowIntensity: null == shadowIntensity ? _self.shadowIntensity : shadowIntensity // ignore: cast_nullable_to_non_nullable
as double,perspectiveStrength: null == perspectiveStrength ? _self.perspectiveStrength : perspectiveStrength // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [FoldMotionEffectOptions].
extension FoldMotionEffectOptionsPatterns on FoldMotionEffectOptions {
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


/// @nodoc
mixin _$GlowEffectOptions {


/// Create a copy of GlowEffectOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GlowEffectOptionsCopyWith<GlowEffectOptions> get copyWith => _$GlowEffectOptionsCopyWithImpl<GlowEffectOptions>(this as GlowEffectOptions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as GlowEffectOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GlowEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.strength, _this.strength) || other.strength == _this.strength)&&(identical(other.radius, _this.radius) || other.radius == _this.radius)&&(identical(other.gain, _this.gain) || other.gain == _this.gain));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as GlowEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.strength,_this.radius,_this.gain);
}

@override
String toString() {
  final _this = this as GlowEffectOptions;
  return 'GlowEffectOptions(durationMs: ${_this.durationMs}, strength: ${_this.strength}, radius: ${_this.radius}, gain: ${_this.gain})';
}


}

/// @nodoc
abstract mixin class $GlowEffectOptionsCopyWith<$Res>  {
  factory $GlowEffectOptionsCopyWith(GlowEffectOptions value, $Res Function(GlowEffectOptions) _then) = _$GlowEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, double strength, double radius, double gain
});




}
/// @nodoc
class _$GlowEffectOptionsCopyWithImpl<$Res>
    implements $GlowEffectOptionsCopyWith<$Res> {
  _$GlowEffectOptionsCopyWithImpl(this._self, this._then);

  final GlowEffectOptions _self;
  final $Res Function(GlowEffectOptions) _then;

/// Create a copy of GlowEffectOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? strength = null,Object? radius = null,Object? gain = null,}) {
  return _then(GlowEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,strength: null == strength ? _self.strength : strength // ignore: cast_nullable_to_non_nullable
as double,radius: null == radius ? _self.radius : radius // ignore: cast_nullable_to_non_nullable
as double,gain: null == gain ? _self.gain : gain // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [GlowEffectOptions].
extension GlowEffectOptionsPatterns on GlowEffectOptions {
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


/// @nodoc
mixin _$KaleidoscopeEffectOptions {


/// Create a copy of KaleidoscopeEffectOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KaleidoscopeEffectOptionsCopyWith<KaleidoscopeEffectOptions> get copyWith => _$KaleidoscopeEffectOptionsCopyWithImpl<KaleidoscopeEffectOptions>(this as KaleidoscopeEffectOptions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as KaleidoscopeEffectOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KaleidoscopeEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.sectorCount, _this.sectorCount) || other.sectorCount == _this.sectorCount)&&(identical(other.rotationDegrees, _this.rotationDegrees) || other.rotationDegrees == _this.rotationDegrees)&&(identical(other.origin, _this.origin) || other.origin == _this.origin));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as KaleidoscopeEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.sectorCount,_this.rotationDegrees,_this.origin);
}

@override
String toString() {
  final _this = this as KaleidoscopeEffectOptions;
  return 'KaleidoscopeEffectOptions(durationMs: ${_this.durationMs}, sectorCount: ${_this.sectorCount}, rotationDegrees: ${_this.rotationDegrees}, origin: ${_this.origin})';
}


}

/// @nodoc
abstract mixin class $KaleidoscopeEffectOptionsCopyWith<$Res>  {
  factory $KaleidoscopeEffectOptionsCopyWith(KaleidoscopeEffectOptions value, $Res Function(KaleidoscopeEffectOptions) _then) = _$KaleidoscopeEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, int sectorCount, double rotationDegrees, EffectOrigin origin
});




}
/// @nodoc
class _$KaleidoscopeEffectOptionsCopyWithImpl<$Res>
    implements $KaleidoscopeEffectOptionsCopyWith<$Res> {
  _$KaleidoscopeEffectOptionsCopyWithImpl(this._self, this._then);

  final KaleidoscopeEffectOptions _self;
  final $Res Function(KaleidoscopeEffectOptions) _then;

/// Create a copy of KaleidoscopeEffectOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? sectorCount = null,Object? rotationDegrees = null,Object? origin = null,}) {
  return _then(KaleidoscopeEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,sectorCount: null == sectorCount ? _self.sectorCount : sectorCount // ignore: cast_nullable_to_non_nullable
as int,rotationDegrees: null == rotationDegrees ? _self.rotationDegrees : rotationDegrees // ignore: cast_nullable_to_non_nullable
as double,origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as EffectOrigin,
  ));
}

}


/// Adds pattern-matching-related methods to [KaleidoscopeEffectOptions].
extension KaleidoscopeEffectOptionsPatterns on KaleidoscopeEffectOptions {
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


/// @nodoc
mixin _$TvPowerEffectOptions {


/// Create a copy of TvPowerEffectOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TvPowerEffectOptionsCopyWith<TvPowerEffectOptions> get copyWith => _$TvPowerEffectOptionsCopyWithImpl<TvPowerEffectOptions>(this as TvPowerEffectOptions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TvPowerEffectOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TvPowerEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.lineAxis, _this.lineAxis) || other.lineAxis == _this.lineAxis)&&(identical(other.glowStrength, _this.glowStrength) || other.glowStrength == _this.glowStrength)&&(identical(other.glowColor, _this.glowColor) || other.glowColor == _this.glowColor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TvPowerEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.lineAxis,_this.glowStrength,_this.glowColor);
}

@override
String toString() {
  final _this = this as TvPowerEffectOptions;
  return 'TvPowerEffectOptions(durationMs: ${_this.durationMs}, lineAxis: ${_this.lineAxis}, glowStrength: ${_this.glowStrength}, glowColor: ${_this.glowColor})';
}


}

/// @nodoc
abstract mixin class $TvPowerEffectOptionsCopyWith<$Res>  {
  factory $TvPowerEffectOptionsCopyWith(TvPowerEffectOptions value, $Res Function(TvPowerEffectOptions) _then) = _$TvPowerEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, EffectAxis lineAxis, double glowStrength, int glowColor
});




}
/// @nodoc
class _$TvPowerEffectOptionsCopyWithImpl<$Res>
    implements $TvPowerEffectOptionsCopyWith<$Res> {
  _$TvPowerEffectOptionsCopyWithImpl(this._self, this._then);

  final TvPowerEffectOptions _self;
  final $Res Function(TvPowerEffectOptions) _then;

/// Create a copy of TvPowerEffectOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? lineAxis = null,Object? glowStrength = null,Object? glowColor = null,}) {
  return _then(TvPowerEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,lineAxis: null == lineAxis ? _self.lineAxis : lineAxis // ignore: cast_nullable_to_non_nullable
as EffectAxis,glowStrength: null == glowStrength ? _self.glowStrength : glowStrength // ignore: cast_nullable_to_non_nullable
as double,glowColor: null == glowColor ? _self.glowColor : glowColor // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TvPowerEffectOptions].
extension TvPowerEffectOptionsPatterns on TvPowerEffectOptions {
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


/// @nodoc
mixin _$SpringMotionEffectOptions {


/// Create a copy of SpringMotionEffectOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpringMotionEffectOptionsCopyWith<SpringMotionEffectOptions> get copyWith => _$SpringMotionEffectOptionsCopyWithImpl<SpringMotionEffectOptions>(this as SpringMotionEffectOptions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SpringMotionEffectOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpringMotionEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.direction, _this.direction) || other.direction == _this.direction)&&(identical(other.springStrength, _this.springStrength) || other.springStrength == _this.springStrength)&&(identical(other.startScale, _this.startScale) || other.startScale == _this.startScale));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SpringMotionEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.direction,_this.springStrength,_this.startScale);
}

@override
String toString() {
  final _this = this as SpringMotionEffectOptions;
  return 'SpringMotionEffectOptions(durationMs: ${_this.durationMs}, direction: ${_this.direction}, springStrength: ${_this.springStrength}, startScale: ${_this.startScale})';
}


}

/// @nodoc
abstract mixin class $SpringMotionEffectOptionsCopyWith<$Res>  {
  factory $SpringMotionEffectOptionsCopyWith(SpringMotionEffectOptions value, $Res Function(SpringMotionEffectOptions) _then) = _$SpringMotionEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, EffectDirection direction, double springStrength, double startScale
});




}
/// @nodoc
class _$SpringMotionEffectOptionsCopyWithImpl<$Res>
    implements $SpringMotionEffectOptionsCopyWith<$Res> {
  _$SpringMotionEffectOptionsCopyWithImpl(this._self, this._then);

  final SpringMotionEffectOptions _self;
  final $Res Function(SpringMotionEffectOptions) _then;

/// Create a copy of SpringMotionEffectOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? direction = null,Object? springStrength = null,Object? startScale = null,}) {
  return _then(SpringMotionEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as EffectDirection,springStrength: null == springStrength ? _self.springStrength : springStrength // ignore: cast_nullable_to_non_nullable
as double,startScale: null == startScale ? _self.startScale : startScale // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SpringMotionEffectOptions].
extension SpringMotionEffectOptionsPatterns on SpringMotionEffectOptions {
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


/// @nodoc
mixin _$ShapeDissolveEffectOptions {


/// Create a copy of ShapeDissolveEffectOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShapeDissolveEffectOptionsCopyWith<ShapeDissolveEffectOptions> get copyWith => _$ShapeDissolveEffectOptionsCopyWithImpl<ShapeDissolveEffectOptions>(this as ShapeDissolveEffectOptions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ShapeDissolveEffectOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShapeDissolveEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.shape, _this.shape) || other.shape == _this.shape)&&(identical(other.cellsAcross, _this.cellsAcross) || other.cellsAcross == _this.cellsAcross)&&(identical(other.staggerFraction, _this.staggerFraction) || other.staggerFraction == _this.staggerFraction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ShapeDissolveEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.shape,_this.cellsAcross,_this.staggerFraction);
}

@override
String toString() {
  final _this = this as ShapeDissolveEffectOptions;
  return 'ShapeDissolveEffectOptions(durationMs: ${_this.durationMs}, shape: ${_this.shape}, cellsAcross: ${_this.cellsAcross}, staggerFraction: ${_this.staggerFraction})';
}


}

/// @nodoc
abstract mixin class $ShapeDissolveEffectOptionsCopyWith<$Res>  {
  factory $ShapeDissolveEffectOptionsCopyWith(ShapeDissolveEffectOptions value, $Res Function(ShapeDissolveEffectOptions) _then) = _$ShapeDissolveEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, CellShape shape, int cellsAcross, double staggerFraction
});




}
/// @nodoc
class _$ShapeDissolveEffectOptionsCopyWithImpl<$Res>
    implements $ShapeDissolveEffectOptionsCopyWith<$Res> {
  _$ShapeDissolveEffectOptionsCopyWithImpl(this._self, this._then);

  final ShapeDissolveEffectOptions _self;
  final $Res Function(ShapeDissolveEffectOptions) _then;

/// Create a copy of ShapeDissolveEffectOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? shape = null,Object? cellsAcross = null,Object? staggerFraction = null,}) {
  return _then(ShapeDissolveEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,shape: null == shape ? _self.shape : shape // ignore: cast_nullable_to_non_nullable
as CellShape,cellsAcross: null == cellsAcross ? _self.cellsAcross : cellsAcross // ignore: cast_nullable_to_non_nullable
as int,staggerFraction: null == staggerFraction ? _self.staggerFraction : staggerFraction // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ShapeDissolveEffectOptions].
extension ShapeDissolveEffectOptionsPatterns on ShapeDissolveEffectOptions {
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


/// @nodoc
mixin _$VhsDamageEffectOptions {


/// Create a copy of VhsDamageEffectOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VhsDamageEffectOptionsCopyWith<VhsDamageEffectOptions> get copyWith => _$VhsDamageEffectOptionsCopyWithImpl<VhsDamageEffectOptions>(this as VhsDamageEffectOptions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as VhsDamageEffectOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VhsDamageEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.colorShiftFraction, _this.colorShiftFraction) || other.colorShiftFraction == _this.colorShiftFraction)&&(identical(other.trackingStrength, _this.trackingStrength) || other.trackingStrength == _this.trackingStrength)&&(identical(other.noiseStrength, _this.noiseStrength) || other.noiseStrength == _this.noiseStrength));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as VhsDamageEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.colorShiftFraction,_this.trackingStrength,_this.noiseStrength);
}

@override
String toString() {
  final _this = this as VhsDamageEffectOptions;
  return 'VhsDamageEffectOptions(durationMs: ${_this.durationMs}, colorShiftFraction: ${_this.colorShiftFraction}, trackingStrength: ${_this.trackingStrength}, noiseStrength: ${_this.noiseStrength})';
}


}

/// @nodoc
abstract mixin class $VhsDamageEffectOptionsCopyWith<$Res>  {
  factory $VhsDamageEffectOptionsCopyWith(VhsDamageEffectOptions value, $Res Function(VhsDamageEffectOptions) _then) = _$VhsDamageEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, double colorShiftFraction, double trackingStrength, double noiseStrength
});




}
/// @nodoc
class _$VhsDamageEffectOptionsCopyWithImpl<$Res>
    implements $VhsDamageEffectOptionsCopyWith<$Res> {
  _$VhsDamageEffectOptionsCopyWithImpl(this._self, this._then);

  final VhsDamageEffectOptions _self;
  final $Res Function(VhsDamageEffectOptions) _then;

/// Create a copy of VhsDamageEffectOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? colorShiftFraction = null,Object? trackingStrength = null,Object? noiseStrength = null,}) {
  return _then(VhsDamageEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,colorShiftFraction: null == colorShiftFraction ? _self.colorShiftFraction : colorShiftFraction // ignore: cast_nullable_to_non_nullable
as double,trackingStrength: null == trackingStrength ? _self.trackingStrength : trackingStrength // ignore: cast_nullable_to_non_nullable
as double,noiseStrength: null == noiseStrength ? _self.noiseStrength : noiseStrength // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [VhsDamageEffectOptions].
extension VhsDamageEffectOptionsPatterns on VhsDamageEffectOptions {
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


/// @nodoc
mixin _$RadialBlurEffectOptions {


/// Create a copy of RadialBlurEffectOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RadialBlurEffectOptionsCopyWith<RadialBlurEffectOptions> get copyWith => _$RadialBlurEffectOptionsCopyWithImpl<RadialBlurEffectOptions>(this as RadialBlurEffectOptions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RadialBlurEffectOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RadialBlurEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.angleDegrees, _this.angleDegrees) || other.angleDegrees == _this.angleDegrees)&&(identical(other.origin, _this.origin) || other.origin == _this.origin));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RadialBlurEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.angleDegrees,_this.origin);
}

@override
String toString() {
  final _this = this as RadialBlurEffectOptions;
  return 'RadialBlurEffectOptions(durationMs: ${_this.durationMs}, angleDegrees: ${_this.angleDegrees}, origin: ${_this.origin})';
}


}

/// @nodoc
abstract mixin class $RadialBlurEffectOptionsCopyWith<$Res>  {
  factory $RadialBlurEffectOptionsCopyWith(RadialBlurEffectOptions value, $Res Function(RadialBlurEffectOptions) _then) = _$RadialBlurEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, double angleDegrees, EffectOrigin origin
});




}
/// @nodoc
class _$RadialBlurEffectOptionsCopyWithImpl<$Res>
    implements $RadialBlurEffectOptionsCopyWith<$Res> {
  _$RadialBlurEffectOptionsCopyWithImpl(this._self, this._then);

  final RadialBlurEffectOptions _self;
  final $Res Function(RadialBlurEffectOptions) _then;

/// Create a copy of RadialBlurEffectOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? angleDegrees = null,Object? origin = null,}) {
  return _then(RadialBlurEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,angleDegrees: null == angleDegrees ? _self.angleDegrees : angleDegrees // ignore: cast_nullable_to_non_nullable
as double,origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as EffectOrigin,
  ));
}

}


/// Adds pattern-matching-related methods to [RadialBlurEffectOptions].
extension RadialBlurEffectOptionsPatterns on RadialBlurEffectOptions {
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


/// @nodoc
mixin _$PhosphorEffectOptions {


/// Create a copy of PhosphorEffectOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhosphorEffectOptionsCopyWith<PhosphorEffectOptions> get copyWith => _$PhosphorEffectOptionsCopyWithImpl<PhosphorEffectOptions>(this as PhosphorEffectOptions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PhosphorEffectOptions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhosphorEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.trailCount, _this.trailCount) || other.trailCount == _this.trailCount)&&(identical(other.driftFraction, _this.driftFraction) || other.driftFraction == _this.driftFraction)&&(identical(other.trailStrength, _this.trailStrength) || other.trailStrength == _this.trailStrength)&&(identical(other.trailColor, _this.trailColor) || other.trailColor == _this.trailColor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PhosphorEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.trailCount,_this.driftFraction,_this.trailStrength,_this.trailColor);
}

@override
String toString() {
  final _this = this as PhosphorEffectOptions;
  return 'PhosphorEffectOptions(durationMs: ${_this.durationMs}, trailCount: ${_this.trailCount}, driftFraction: ${_this.driftFraction}, trailStrength: ${_this.trailStrength}, trailColor: ${_this.trailColor})';
}


}

/// @nodoc
abstract mixin class $PhosphorEffectOptionsCopyWith<$Res>  {
  factory $PhosphorEffectOptionsCopyWith(PhosphorEffectOptions value, $Res Function(PhosphorEffectOptions) _then) = _$PhosphorEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, int trailCount, double driftFraction, double trailStrength, int trailColor
});




}
/// @nodoc
class _$PhosphorEffectOptionsCopyWithImpl<$Res>
    implements $PhosphorEffectOptionsCopyWith<$Res> {
  _$PhosphorEffectOptionsCopyWithImpl(this._self, this._then);

  final PhosphorEffectOptions _self;
  final $Res Function(PhosphorEffectOptions) _then;

/// Create a copy of PhosphorEffectOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? trailCount = null,Object? driftFraction = null,Object? trailStrength = null,Object? trailColor = null,}) {
  return _then(PhosphorEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,trailCount: null == trailCount ? _self.trailCount : trailCount // ignore: cast_nullable_to_non_nullable
as int,driftFraction: null == driftFraction ? _self.driftFraction : driftFraction // ignore: cast_nullable_to_non_nullable
as double,trailStrength: null == trailStrength ? _self.trailStrength : trailStrength // ignore: cast_nullable_to_non_nullable
as double,trailColor: null == trailColor ? _self.trailColor : trailColor // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PhosphorEffectOptions].
extension PhosphorEffectOptionsPatterns on PhosphorEffectOptions {
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

/// @nodoc
mixin _$EffectConfig {


/// Create a copy of EffectConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EffectConfigCopyWith<EffectConfig> get copyWith => _$EffectConfigCopyWithImpl<EffectConfig>(this as EffectConfig, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as EffectConfig;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EffectConfig&&(identical(other.enabled, _this.enabled) || other.enabled == _this.enabled)&&(identical(other.options, _this.options) || other.options == _this.options)&&(identical(other.invalid, _this.invalid) || other.invalid == _this.invalid));
}


@override
int get hashCode {
  final _this = this as EffectConfig;
  return Object.hash(runtimeType,_this.enabled,_this.options,_this.invalid);
}

@override
String toString() {
  final _this = this as EffectConfig;
  return 'EffectConfig(enabled: ${_this.enabled}, options: ${_this.options}, invalid: ${_this.invalid})';
}


}

/// @nodoc
abstract mixin class $EffectConfigCopyWith<$Res>  {
  factory $EffectConfigCopyWith(EffectConfig value, $Res Function(EffectConfig) _then) = _$EffectConfigCopyWithImpl;
@useResult
$Res call({
 bool enabled, EffectOptions options, InvalidEffectData? invalid
});


$InvalidEffectDataCopyWith<$Res>? get invalid;

}
/// @nodoc
class _$EffectConfigCopyWithImpl<$Res>
    implements $EffectConfigCopyWith<$Res> {
  _$EffectConfigCopyWithImpl(this._self, this._then);

  final EffectConfig _self;
  final $Res Function(EffectConfig) _then;

/// Create a copy of EffectConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,Object? options = null,Object? invalid = freezed,}) {
  return _then(EffectConfig(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as EffectOptions,invalid: freezed == invalid ? _self.invalid : invalid // ignore: cast_nullable_to_non_nullable
as InvalidEffectData?,
  ));
}
/// Create a copy of EffectConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InvalidEffectDataCopyWith<$Res>? get invalid {
    if (_self.invalid == null) {
    return null;
  }

  return $InvalidEffectDataCopyWith<$Res>(_self.invalid!, (value) {
    return _then(_self.copyWith(invalid: value));
  });
}
}


/// Adds pattern-matching-related methods to [EffectConfig].
extension EffectConfigPatterns on EffectConfig {
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


/// @nodoc
mixin _$InvalidEffectData {


/// Create a copy of InvalidEffectData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvalidEffectDataCopyWith<InvalidEffectData> get copyWith => _$InvalidEffectDataCopyWithImpl<InvalidEffectData>(this as InvalidEffectData, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as InvalidEffectData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvalidEffectData&&const DeepCollectionEquality().equals(other.raw, _this.raw)&&(identical(other.error, _this.error) || other.error == _this.error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as InvalidEffectData;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.raw),_this.error);
}

@override
String toString() {
  final _this = this as InvalidEffectData;
  return 'InvalidEffectData(raw: ${_this.raw}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $InvalidEffectDataCopyWith<$Res>  {
  factory $InvalidEffectDataCopyWith(InvalidEffectData value, $Res Function(InvalidEffectData) _then) = _$InvalidEffectDataCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> raw, String error
});




}
/// @nodoc
class _$InvalidEffectDataCopyWithImpl<$Res>
    implements $InvalidEffectDataCopyWith<$Res> {
  _$InvalidEffectDataCopyWithImpl(this._self, this._then);

  final InvalidEffectData _self;
  final $Res Function(InvalidEffectData) _then;

/// Create a copy of InvalidEffectData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? raw = null,Object? error = null,}) {
  return _then(InvalidEffectData(
null == raw ? _self.raw : raw // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [InvalidEffectData].
extension InvalidEffectDataPatterns on InvalidEffectData {
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


/// @nodoc
mixin _$EffectsConfig {


/// Create a copy of EffectsConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EffectsConfigCopyWith<EffectsConfig> get copyWith => _$EffectsConfigCopyWithImpl<EffectsConfig>(this as EffectsConfig, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as EffectsConfig;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EffectsConfig&&(identical(other.schemaVersion, _this.schemaVersion) || other.schemaVersion == _this.schemaVersion)&&(identical(other.defaultDurationMs, _this.defaultDurationMs) || other.defaultDurationMs == _this.defaultDurationMs)&&const DeepCollectionEquality().equals(other.items, _this.items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as EffectsConfig;
  return Object.hash(runtimeType,_this.schemaVersion,_this.defaultDurationMs,const DeepCollectionEquality().hash(_this.items));
}

@override
String toString() {
  final _this = this as EffectsConfig;
  return 'EffectsConfig(schemaVersion: ${_this.schemaVersion}, defaultDurationMs: ${_this.defaultDurationMs}, items: ${_this.items})';
}


}

/// @nodoc
abstract mixin class $EffectsConfigCopyWith<$Res>  {
  factory $EffectsConfigCopyWith(EffectsConfig value, $Res Function(EffectsConfig) _then) = _$EffectsConfigCopyWithImpl;
@useResult
$Res call({
 int schemaVersion, int defaultDurationMs, Map<EffectType, EffectConfig>? items
});




}
/// @nodoc
class _$EffectsConfigCopyWithImpl<$Res>
    implements $EffectsConfigCopyWith<$Res> {
  _$EffectsConfigCopyWithImpl(this._self, this._then);

  final EffectsConfig _self;
  final $Res Function(EffectsConfig) _then;

/// Create a copy of EffectsConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? schemaVersion = null,Object? defaultDurationMs = null,Object? items = freezed,}) {
  return _then(EffectsConfig(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,defaultDurationMs: null == defaultDurationMs ? _self.defaultDurationMs : defaultDurationMs // ignore: cast_nullable_to_non_nullable
as int,items: freezed == items ? _self.items! : items // ignore: cast_nullable_to_non_nullable
as Map<EffectType, EffectConfig>?,
  ));
}

}


/// Adds pattern-matching-related methods to [EffectsConfig].
extension EffectsConfigPatterns on EffectsConfig {
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

/// @nodoc
mixin _$EffectPreset {


/// Create a copy of EffectPreset
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EffectPresetCopyWith<EffectPreset> get copyWith => _$EffectPresetCopyWithImpl<EffectPreset>(this as EffectPreset, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as EffectPreset;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EffectPreset&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.sourceType, _this.sourceType) || other.sourceType == _this.sourceType)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.options, _this.options) || other.options == _this.options));
}


@override
int get hashCode {
  final _this = this as EffectPreset;
  return Object.hash(runtimeType,_this.id,_this.sourceType,_this.type,_this.options);
}

@override
String toString() {
  final _this = this as EffectPreset;
  return 'EffectPreset(id: ${_this.id}, sourceType: ${_this.sourceType}, type: ${_this.type}, options: ${_this.options})';
}


}

/// @nodoc
abstract mixin class $EffectPresetCopyWith<$Res>  {
  factory $EffectPresetCopyWith(EffectPreset value, $Res Function(EffectPreset) _then) = _$EffectPresetCopyWithImpl;
@useResult
$Res call({
 EffectPresetId id, EffectType sourceType, EffectType type, EffectOptions options
});




}
/// @nodoc
class _$EffectPresetCopyWithImpl<$Res>
    implements $EffectPresetCopyWith<$Res> {
  _$EffectPresetCopyWithImpl(this._self, this._then);

  final EffectPreset _self;
  final $Res Function(EffectPreset) _then;

/// Create a copy of EffectPreset
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? sourceType = null,Object? type = null,Object? options = null,}) {
  return _then(EffectPreset(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as EffectPresetId,sourceType: null == sourceType ? _self.sourceType : sourceType // ignore: cast_nullable_to_non_nullable
as EffectType,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EffectType,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as EffectOptions,
  ));
}

}


/// Adds pattern-matching-related methods to [EffectPreset].
extension EffectPresetPatterns on EffectPreset {
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
