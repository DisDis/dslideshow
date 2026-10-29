// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BenchmarkCase {


/// Create a copy of BenchmarkCase
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BenchmarkCaseCopyWith<BenchmarkCase> get copyWith => _$BenchmarkCaseCopyWithImpl<BenchmarkCase>(this as BenchmarkCase, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BenchmarkCase;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BenchmarkCase&&(identical(other.effect, _this.effect) || other.effect == _this.effect)&&(identical(other.photoMotion, _this.photoMotion) || other.photoMotion == _this.photoMotion)&&(identical(other.media, _this.media) || other.media == _this.media)&&(identical(other.grid, _this.grid) || other.grid == _this.grid)&&(identical(other.backend, _this.backend) || other.backend == _this.backend)&&(identical(other.injectStall, _this.injectStall) || other.injectStall == _this.injectStall));
}


@override
int get hashCode {
  final _this = this as BenchmarkCase;
  return Object.hash(runtimeType,_this.effect,_this.photoMotion,_this.media,_this.grid,_this.backend,_this.injectStall);
}

@override
String toString() {
  final _this = this as BenchmarkCase;
  return 'BenchmarkCase(effect: ${_this.effect}, photoMotion: ${_this.photoMotion}, media: ${_this.media}, grid: ${_this.grid}, backend: ${_this.backend}, injectStall: ${_this.injectStall})';
}


}

/// @nodoc
abstract mixin class $BenchmarkCaseCopyWith<$Res>  {
  factory $BenchmarkCaseCopyWith(BenchmarkCase value, $Res Function(BenchmarkCase) _then) = _$BenchmarkCaseCopyWithImpl;
@useResult
$Res call({
 Effect? effect, MediaPair media, bool photoMotion, int grid, MosaicBackend backend, bool injectStall
});




}
/// @nodoc
class _$BenchmarkCaseCopyWithImpl<$Res>
    implements $BenchmarkCaseCopyWith<$Res> {
  _$BenchmarkCaseCopyWithImpl(this._self, this._then);

  final BenchmarkCase _self;
  final $Res Function(BenchmarkCase) _then;

/// Create a copy of BenchmarkCase
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? effect = freezed,Object? media = null,Object? photoMotion = null,Object? grid = null,Object? backend = null,Object? injectStall = null,}) {
  return _then(BenchmarkCase(
freezed == effect ? _self.effect : effect // ignore: cast_nullable_to_non_nullable
as Effect?,null == media ? _self.media : media // ignore: cast_nullable_to_non_nullable
as MediaPair,photoMotion: null == photoMotion ? _self.photoMotion : photoMotion // ignore: cast_nullable_to_non_nullable
as bool,grid: null == grid ? _self.grid : grid // ignore: cast_nullable_to_non_nullable
as int,backend: null == backend ? _self.backend : backend // ignore: cast_nullable_to_non_nullable
as MosaicBackend,injectStall: null == injectStall ? _self.injectStall : injectStall // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [BenchmarkCase].
extension BenchmarkCasePatterns on BenchmarkCase {
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
