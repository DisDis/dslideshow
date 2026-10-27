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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MosaicEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.gridSize, _this.gridSize) || other.gridSize == _this.gridSize)&&(identical(other.fadeFraction, _this.fadeFraction) || other.fadeFraction == _this.fadeFraction)&&(identical(other.direction, _this.direction) || other.direction == _this.direction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MosaicEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.gridSize,_this.fadeFraction,_this.direction);
}

@override
String toString() {
  final _this = this as MosaicEffectOptions;
  return 'MosaicEffectOptions(durationMs: ${_this.durationMs}, gridSize: ${_this.gridSize}, fadeFraction: ${_this.fadeFraction}, direction: ${_this.direction})';
}


}

/// @nodoc
abstract mixin class $MosaicEffectOptionsCopyWith<$Res>  {
  factory $MosaicEffectOptionsCopyWith(MosaicEffectOptions value, $Res Function(MosaicEffectOptions) _then) = _$MosaicEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, int gridSize, double fadeFraction, MosaicDirection direction
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
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? gridSize = null,Object? fadeFraction = null,Object? direction = null,}) {
  return _then(MosaicEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,gridSize: null == gridSize ? _self.gridSize : gridSize // ignore: cast_nullable_to_non_nullable
as int,fadeFraction: null == fadeFraction ? _self.fadeFraction : fadeFraction // ignore: cast_nullable_to_non_nullable
as double,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as MosaicDirection,
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SlideEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.mode, _this.mode) || other.mode == _this.mode)&&(identical(other.direction, _this.direction) || other.direction == _this.direction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SlideEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.mode,_this.direction);
}

@override
String toString() {
  final _this = this as SlideEffectOptions;
  return 'SlideEffectOptions(durationMs: ${_this.durationMs}, mode: ${_this.mode}, direction: ${_this.direction})';
}


}

/// @nodoc
abstract mixin class $SlideEffectOptionsCopyWith<$Res>  {
  factory $SlideEffectOptionsCopyWith(SlideEffectOptions value, $Res Function(SlideEffectOptions) _then) = _$SlideEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, SlideMode mode, EffectDirection direction
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
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? mode = null,Object? direction = null,}) {
  return _then(SlideEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as SlideMode,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as EffectDirection,
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RevealMaskEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.shape, _this.shape) || other.shape == _this.shape)&&(identical(other.direction, _this.direction) || other.direction == _this.direction)&&(identical(other.axis, _this.axis) || other.axis == _this.axis)&&(identical(other.origin, _this.origin) || other.origin == _this.origin));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RevealMaskEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.shape,_this.direction,_this.axis,_this.origin);
}

@override
String toString() {
  final _this = this as RevealMaskEffectOptions;
  return 'RevealMaskEffectOptions(durationMs: ${_this.durationMs}, shape: ${_this.shape}, direction: ${_this.direction}, axis: ${_this.axis}, origin: ${_this.origin})';
}


}

/// @nodoc
abstract mixin class $RevealMaskEffectOptionsCopyWith<$Res>  {
  factory $RevealMaskEffectOptionsCopyWith(RevealMaskEffectOptions value, $Res Function(RevealMaskEffectOptions) _then) = _$RevealMaskEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, RevealShape shape, EffectDirection direction, EffectAxis axis, EffectOrigin origin
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
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? shape = null,Object? direction = null,Object? axis = null,Object? origin = null,}) {
  return _then(RevealMaskEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,shape: null == shape ? _self.shape : shape // ignore: cast_nullable_to_non_nullable
as RevealShape,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as EffectDirection,axis: null == axis ? _self.axis : axis // ignore: cast_nullable_to_non_nullable
as EffectAxis,origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as EffectOrigin,
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FlipEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.axis, _this.axis) || other.axis == _this.axis));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FlipEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.axis);
}

@override
String toString() {
  final _this = this as FlipEffectOptions;
  return 'FlipEffectOptions(durationMs: ${_this.durationMs}, axis: ${_this.axis})';
}


}

/// @nodoc
abstract mixin class $FlipEffectOptionsCopyWith<$Res>  {
  factory $FlipEffectOptionsCopyWith(FlipEffectOptions value, $Res Function(FlipEffectOptions) _then) = _$FlipEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, EffectAxis axis
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
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? axis = null,}) {
  return _then(FlipEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,axis: null == axis ? _self.axis : axis // ignore: cast_nullable_to_non_nullable
as EffectAxis,
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RotateEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.edge, _this.edge) || other.edge == _this.edge)&&(identical(other.angleDegrees, _this.angleDegrees) || other.angleDegrees == _this.angleDegrees));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RotateEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.edge,_this.angleDegrees);
}

@override
String toString() {
  final _this = this as RotateEffectOptions;
  return 'RotateEffectOptions(durationMs: ${_this.durationMs}, edge: ${_this.edge}, angleDegrees: ${_this.angleDegrees})';
}


}

/// @nodoc
abstract mixin class $RotateEffectOptionsCopyWith<$Res>  {
  factory $RotateEffectOptionsCopyWith(RotateEffectOptions value, $Res Function(RotateEffectOptions) _then) = _$RotateEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, RotationEdge edge, double angleDegrees
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
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? edge = null,Object? angleDegrees = null,}) {
  return _then(RotateEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,edge: null == edge ? _self.edge : edge // ignore: cast_nullable_to_non_nullable
as RotationEdge,angleDegrees: null == angleDegrees ? _self.angleDegrees : angleDegrees // ignore: cast_nullable_to_non_nullable
as double,
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BlindsEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.stripCount, _this.stripCount) || other.stripCount == _this.stripCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as BlindsEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.stripCount);
}

@override
String toString() {
  final _this = this as BlindsEffectOptions;
  return 'BlindsEffectOptions(durationMs: ${_this.durationMs}, stripCount: ${_this.stripCount})';
}


}

/// @nodoc
abstract mixin class $BlindsEffectOptionsCopyWith<$Res>  {
  factory $BlindsEffectOptionsCopyWith(BlindsEffectOptions value, $Res Function(BlindsEffectOptions) _then) = _$BlindsEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, int stripCount
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
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? stripCount = null,}) {
  return _then(BlindsEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,stripCount: null == stripCount ? _self.stripCount : stripCount // ignore: cast_nullable_to_non_nullable
as int,
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SliceEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.stripCount, _this.stripCount) || other.stripCount == _this.stripCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SliceEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.stripCount);
}

@override
String toString() {
  final _this = this as SliceEffectOptions;
  return 'SliceEffectOptions(durationMs: ${_this.durationMs}, stripCount: ${_this.stripCount})';
}


}

/// @nodoc
abstract mixin class $SliceEffectOptionsCopyWith<$Res>  {
  factory $SliceEffectOptionsCopyWith(SliceEffectOptions value, $Res Function(SliceEffectOptions) _then) = _$SliceEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, int stripCount
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
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? stripCount = null,}) {
  return _then(SliceEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,stripCount: null == stripCount ? _self.stripCount : stripCount // ignore: cast_nullable_to_non_nullable
as int,
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GlassEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.paneCount, _this.paneCount) || other.paneCount == _this.paneCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as GlassEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.paneCount);
}

@override
String toString() {
  final _this = this as GlassEffectOptions;
  return 'GlassEffectOptions(durationMs: ${_this.durationMs}, paneCount: ${_this.paneCount})';
}


}

/// @nodoc
abstract mixin class $GlassEffectOptionsCopyWith<$Res>  {
  factory $GlassEffectOptionsCopyWith(GlassEffectOptions value, $Res Function(GlassEffectOptions) _then) = _$GlassEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, int paneCount
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
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? paneCount = null,}) {
  return _then(GlassEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,paneCount: null == paneCount ? _self.paneCount : paneCount // ignore: cast_nullable_to_non_nullable
as int,
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LouverEffectOptions&&(identical(other.durationMs, _this.durationMs) || other.durationMs == _this.durationMs)&&(identical(other.slatCount, _this.slatCount) || other.slatCount == _this.slatCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as LouverEffectOptions;
  return Object.hash(runtimeType,_this.durationMs,_this.slatCount);
}

@override
String toString() {
  final _this = this as LouverEffectOptions;
  return 'LouverEffectOptions(durationMs: ${_this.durationMs}, slatCount: ${_this.slatCount})';
}


}

/// @nodoc
abstract mixin class $LouverEffectOptionsCopyWith<$Res>  {
  factory $LouverEffectOptionsCopyWith(LouverEffectOptions value, $Res Function(LouverEffectOptions) _then) = _$LouverEffectOptionsCopyWithImpl;
@useResult
$Res call({
 int durationMs, int slatCount
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
@pragma('vm:prefer-inline') @override $Res call({Object? durationMs = null,Object? slatCount = null,}) {
  return _then(LouverEffectOptions(
durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,slatCount: null == slatCount ? _self.slatCount : slatCount // ignore: cast_nullable_to_non_nullable
as int,
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
mixin _$EffectConfig {


/// Create a copy of EffectConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EffectConfigCopyWith<EffectConfig> get copyWith => _$EffectConfigCopyWithImpl<EffectConfig>(this as EffectConfig, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as EffectConfig;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EffectConfig&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.enabled, _this.enabled) || other.enabled == _this.enabled)&&(identical(other.options, _this.options) || other.options == _this.options)&&(identical(other.invalid, _this.invalid) || other.invalid == _this.invalid));
}


@override
int get hashCode {
  final _this = this as EffectConfig;
  return Object.hash(runtimeType,_this.type,_this.enabled,_this.options,_this.invalid);
}

@override
String toString() {
  final _this = this as EffectConfig;
  return 'EffectConfig(type: ${_this.type}, enabled: ${_this.enabled}, options: ${_this.options}, invalid: ${_this.invalid})';
}


}

/// @nodoc
abstract mixin class $EffectConfigCopyWith<$Res>  {
  factory $EffectConfigCopyWith(EffectConfig value, $Res Function(EffectConfig) _then) = _$EffectConfigCopyWithImpl;
@useResult
$Res call({
 EffectType type, bool enabled, EffectOptions? options, InvalidEffectData? invalid
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
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? enabled = null,Object? options = freezed,Object? invalid = freezed,}) {
  return _then(EffectConfig(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EffectType,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,options: freezed == options ? _self.options! : options // ignore: cast_nullable_to_non_nullable
as EffectOptions?,invalid: freezed == invalid ? _self.invalid : invalid // ignore: cast_nullable_to_non_nullable
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
 int schemaVersion, int defaultDurationMs, List<EffectConfig>? items
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
as List<EffectConfig>?,
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

// dart format on
