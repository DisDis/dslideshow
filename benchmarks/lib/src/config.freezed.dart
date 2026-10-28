// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BenchmarkConfig {


/// Create a copy of BenchmarkConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BenchmarkConfigCopyWith<BenchmarkConfig> get copyWith => _$BenchmarkConfigCopyWithImpl<BenchmarkConfig>(this as BenchmarkConfig, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BenchmarkConfig;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BenchmarkConfig&&(identical(other.suite, _this.suite) || other.suite == _this.suite)&&(identical(other.repeats, _this.repeats) || other.repeats == _this.repeats)&&(identical(other.warmups, _this.warmups) || other.warmups == _this.warmups)&&(identical(other.transitionMs, _this.transitionMs) || other.transitionMs == _this.transitionMs)&&(identical(other.transitionTimeoutSeconds, _this.transitionTimeoutSeconds) || other.transitionTimeoutSeconds == _this.transitionTimeoutSeconds)&&(identical(other.prepareTimeoutSeconds, _this.prepareTimeoutSeconds) || other.prepareTimeoutSeconds == _this.prepareTimeoutSeconds)&&(identical(other.telemetryMs, _this.telemetryMs) || other.telemetryMs == _this.telemetryMs)&&(identical(other.timingDrainMs, _this.timingDrainMs) || other.timingDrainMs == _this.timingDrainMs)&&(identical(other.soakSeconds, _this.soakSeconds) || other.soakSeconds == _this.soakSeconds)&&(identical(other.seed, _this.seed) || other.seed == _this.seed)&&const DeepCollectionEquality().equals(other.grids, _this.grids)&&const DeepCollectionEquality().equals(other.backends, _this.backends)&&const DeepCollectionEquality().equals(other.effects, _this.effects)&&const DeepCollectionEquality().equals(other.effectConfigs, _this.effectConfigs)&&const DeepCollectionEquality().equals(other.mediaCases, _this.mediaCases)&&(identical(other.captureFrames, _this.captureFrames) || other.captureFrames == _this.captureFrames)&&(identical(other.exitWhenDone, _this.exitWhenDone) || other.exitWhenDone == _this.exitWhenDone)&&(identical(other.requireTimings, _this.requireTimings) || other.requireTimings == _this.requireTimings)&&(identical(other.vulkanVideo, _this.vulkanVideo) || other.vulkanVideo == _this.vulkanVideo)&&(identical(other.visualAudit, _this.visualAudit) || other.visualAudit == _this.visualAudit)&&(identical(other.productionPhotoInputs, _this.productionPhotoInputs) || other.productionPhotoInputs == _this.productionPhotoInputs)&&(identical(other.mediaDirectory, _this.mediaDirectory) || other.mediaDirectory == _this.mediaDirectory)&&(identical(other.expectedWidth, _this.expectedWidth) || other.expectedWidth == _this.expectedWidth)&&(identical(other.expectedHeight, _this.expectedHeight) || other.expectedHeight == _this.expectedHeight));
}


@override
int get hashCode {
  final _this = this as BenchmarkConfig;
  return Object.hashAll([runtimeType,_this.suite,_this.repeats,_this.warmups,_this.transitionMs,_this.transitionTimeoutSeconds,_this.prepareTimeoutSeconds,_this.telemetryMs,_this.timingDrainMs,_this.soakSeconds,_this.seed,const DeepCollectionEquality().hash(_this.grids),const DeepCollectionEquality().hash(_this.backends),const DeepCollectionEquality().hash(_this.effects),const DeepCollectionEquality().hash(_this.effectConfigs),const DeepCollectionEquality().hash(_this.mediaCases),_this.captureFrames,_this.exitWhenDone,_this.requireTimings,_this.vulkanVideo,_this.visualAudit,_this.productionPhotoInputs,_this.mediaDirectory,_this.expectedWidth,_this.expectedHeight]);
}

@override
String toString() {
  final _this = this as BenchmarkConfig;
  return 'BenchmarkConfig(suite: ${_this.suite}, repeats: ${_this.repeats}, warmups: ${_this.warmups}, transitionMs: ${_this.transitionMs}, transitionTimeoutSeconds: ${_this.transitionTimeoutSeconds}, prepareTimeoutSeconds: ${_this.prepareTimeoutSeconds}, telemetryMs: ${_this.telemetryMs}, timingDrainMs: ${_this.timingDrainMs}, soakSeconds: ${_this.soakSeconds}, seed: ${_this.seed}, grids: ${_this.grids}, backends: ${_this.backends}, effects: ${_this.effects}, effectConfigs: ${_this.effectConfigs}, mediaCases: ${_this.mediaCases}, captureFrames: ${_this.captureFrames}, exitWhenDone: ${_this.exitWhenDone}, requireTimings: ${_this.requireTimings}, vulkanVideo: ${_this.vulkanVideo}, visualAudit: ${_this.visualAudit}, productionPhotoInputs: ${_this.productionPhotoInputs}, mediaDirectory: ${_this.mediaDirectory}, expectedWidth: ${_this.expectedWidth}, expectedHeight: ${_this.expectedHeight})';
}


}

/// @nodoc
abstract mixin class $BenchmarkConfigCopyWith<$Res>  {
  factory $BenchmarkConfigCopyWith(BenchmarkConfig value, $Res Function(BenchmarkConfig) _then) = _$BenchmarkConfigCopyWithImpl;
@useResult
$Res call({
 String suite, int? repeats, int? warmups, int transitionMs, int transitionTimeoutSeconds, int prepareTimeoutSeconds, int telemetryMs, int timingDrainMs, int? soakSeconds, int seed, List<int>? grids, List<String> backends, List<String>? effects, Map<EffectType, List<EffectConfig>>? effectConfigs, List<String>? mediaCases, bool? captureFrames, bool exitWhenDone, bool requireTimings, bool vulkanVideo, bool visualAudit, bool productionPhotoInputs, String? mediaDirectory, int expectedWidth, int expectedHeight
});




}
/// @nodoc
class _$BenchmarkConfigCopyWithImpl<$Res>
    implements $BenchmarkConfigCopyWith<$Res> {
  _$BenchmarkConfigCopyWithImpl(this._self, this._then);

  final BenchmarkConfig _self;
  final $Res Function(BenchmarkConfig) _then;

/// Create a copy of BenchmarkConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? suite = null,Object? repeats = freezed,Object? warmups = freezed,Object? transitionMs = null,Object? transitionTimeoutSeconds = null,Object? prepareTimeoutSeconds = null,Object? telemetryMs = null,Object? timingDrainMs = null,Object? soakSeconds = freezed,Object? seed = null,Object? grids = freezed,Object? backends = null,Object? effects = freezed,Object? effectConfigs = freezed,Object? mediaCases = freezed,Object? captureFrames = freezed,Object? exitWhenDone = null,Object? requireTimings = null,Object? vulkanVideo = null,Object? visualAudit = null,Object? productionPhotoInputs = null,Object? mediaDirectory = freezed,Object? expectedWidth = null,Object? expectedHeight = null,}) {
  return _then(BenchmarkConfig(
suite: null == suite ? _self.suite : suite // ignore: cast_nullable_to_non_nullable
as String,repeats: freezed == repeats ? _self.repeats! : repeats // ignore: cast_nullable_to_non_nullable
as int?,warmups: freezed == warmups ? _self.warmups! : warmups // ignore: cast_nullable_to_non_nullable
as int?,transitionMs: null == transitionMs ? _self.transitionMs : transitionMs // ignore: cast_nullable_to_non_nullable
as int,transitionTimeoutSeconds: null == transitionTimeoutSeconds ? _self.transitionTimeoutSeconds : transitionTimeoutSeconds // ignore: cast_nullable_to_non_nullable
as int,prepareTimeoutSeconds: null == prepareTimeoutSeconds ? _self.prepareTimeoutSeconds : prepareTimeoutSeconds // ignore: cast_nullable_to_non_nullable
as int,telemetryMs: null == telemetryMs ? _self.telemetryMs : telemetryMs // ignore: cast_nullable_to_non_nullable
as int,timingDrainMs: null == timingDrainMs ? _self.timingDrainMs : timingDrainMs // ignore: cast_nullable_to_non_nullable
as int,soakSeconds: freezed == soakSeconds ? _self.soakSeconds! : soakSeconds // ignore: cast_nullable_to_non_nullable
as int?,seed: null == seed ? _self.seed : seed // ignore: cast_nullable_to_non_nullable
as int,grids: freezed == grids ? _self.grids! : grids // ignore: cast_nullable_to_non_nullable
as List<int>?,backends: null == backends ? _self.backends : backends // ignore: cast_nullable_to_non_nullable
as List<String>,effects: freezed == effects ? _self.effects : effects // ignore: cast_nullable_to_non_nullable
as List<String>?,effectConfigs: freezed == effectConfigs ? _self.effectConfigs : effectConfigs // ignore: cast_nullable_to_non_nullable
as Map<EffectType, List<EffectConfig>>?,mediaCases: freezed == mediaCases ? _self.mediaCases : mediaCases // ignore: cast_nullable_to_non_nullable
as List<String>?,captureFrames: freezed == captureFrames ? _self.captureFrames! : captureFrames // ignore: cast_nullable_to_non_nullable
as bool?,exitWhenDone: null == exitWhenDone ? _self.exitWhenDone : exitWhenDone // ignore: cast_nullable_to_non_nullable
as bool,requireTimings: null == requireTimings ? _self.requireTimings : requireTimings // ignore: cast_nullable_to_non_nullable
as bool,vulkanVideo: null == vulkanVideo ? _self.vulkanVideo : vulkanVideo // ignore: cast_nullable_to_non_nullable
as bool,visualAudit: null == visualAudit ? _self.visualAudit : visualAudit // ignore: cast_nullable_to_non_nullable
as bool,productionPhotoInputs: null == productionPhotoInputs ? _self.productionPhotoInputs : productionPhotoInputs // ignore: cast_nullable_to_non_nullable
as bool,mediaDirectory: freezed == mediaDirectory ? _self.mediaDirectory : mediaDirectory // ignore: cast_nullable_to_non_nullable
as String?,expectedWidth: null == expectedWidth ? _self.expectedWidth : expectedWidth // ignore: cast_nullable_to_non_nullable
as int,expectedHeight: null == expectedHeight ? _self.expectedHeight : expectedHeight // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BenchmarkConfig].
extension BenchmarkConfigPatterns on BenchmarkConfig {
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
