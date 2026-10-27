// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'special_screen_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SpecialScreenSchedule {


/// Create a copy of SpecialScreenSchedule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpecialScreenScheduleCopyWith<SpecialScreenSchedule> get copyWith => _$SpecialScreenScheduleCopyWithImpl<SpecialScreenSchedule>(this as SpecialScreenSchedule, _$identity);





@override
String toString() {
  final _this = this as SpecialScreenSchedule;
  return 'SpecialScreenSchedule(type: ${_this.type}, count: ${_this.count}, intervalMs: ${_this.intervalMs})';
}


}

/// @nodoc
abstract mixin class $SpecialScreenScheduleCopyWith<$Res>  {
  factory $SpecialScreenScheduleCopyWith(SpecialScreenSchedule value, $Res Function(SpecialScreenSchedule) _then) = _$SpecialScreenScheduleCopyWithImpl;
@useResult
$Res call({
 SpecialScreenScheduleType type, int count, int intervalMs
});




}
/// @nodoc
class _$SpecialScreenScheduleCopyWithImpl<$Res>
    implements $SpecialScreenScheduleCopyWith<$Res> {
  _$SpecialScreenScheduleCopyWithImpl(this._self, this._then);

  final SpecialScreenSchedule _self;
  final $Res Function(SpecialScreenSchedule) _then;

/// Create a copy of SpecialScreenSchedule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? count = null,Object? intervalMs = null,}) {
  return _then(SpecialScreenSchedule(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SpecialScreenScheduleType,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,intervalMs: null == intervalMs ? _self.intervalMs : intervalMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SpecialScreenSchedule].
extension SpecialScreenSchedulePatterns on SpecialScreenSchedule {
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
mixin _$ClockScreenOptions {


/// Create a copy of ClockScreenOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClockScreenOptionsCopyWith<ClockScreenOptions> get copyWith => _$ClockScreenOptionsCopyWithImpl<ClockScreenOptions>(this as ClockScreenOptions, _$identity);





@override
String toString() {
  final _this = this as ClockScreenOptions;
  return 'ClockScreenOptions(timeFormat: ${_this.timeFormat}, showSeconds: ${_this.showSeconds}, showDate: ${_this.showDate}, showWeekday: ${_this.showWeekday}, dateFormat: ${_this.dateFormat}, timeFont: ${_this.timeFont}, dateFont: ${_this.dateFont}, timeFontSizePercent: ${_this.timeFontSizePercent}, dateFontSizePercent: ${_this.dateFontSizePercent}, textColor: ${_this.textColor}, backgroundColor: ${_this.backgroundColor})';
}


}

/// @nodoc
abstract mixin class $ClockScreenOptionsCopyWith<$Res>  {
  factory $ClockScreenOptionsCopyWith(ClockScreenOptions value, $Res Function(ClockScreenOptions) _then) = _$ClockScreenOptionsCopyWithImpl;
@useResult
$Res call({
 ClockTimeFormat timeFormat, bool showSeconds, bool showDate, bool showWeekday, ClockDateFormat dateFormat, ClockFont timeFont, ClockFont dateFont, double timeFontSizePercent, double dateFontSizePercent, int textColor, int backgroundColor
});




}
/// @nodoc
class _$ClockScreenOptionsCopyWithImpl<$Res>
    implements $ClockScreenOptionsCopyWith<$Res> {
  _$ClockScreenOptionsCopyWithImpl(this._self, this._then);

  final ClockScreenOptions _self;
  final $Res Function(ClockScreenOptions) _then;

/// Create a copy of ClockScreenOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? timeFormat = null,Object? showSeconds = null,Object? showDate = null,Object? showWeekday = null,Object? dateFormat = null,Object? timeFont = null,Object? dateFont = null,Object? timeFontSizePercent = null,Object? dateFontSizePercent = null,Object? textColor = null,Object? backgroundColor = null,}) {
  return _then(ClockScreenOptions(
timeFormat: null == timeFormat ? _self.timeFormat : timeFormat // ignore: cast_nullable_to_non_nullable
as ClockTimeFormat,showSeconds: null == showSeconds ? _self.showSeconds : showSeconds // ignore: cast_nullable_to_non_nullable
as bool,showDate: null == showDate ? _self.showDate : showDate // ignore: cast_nullable_to_non_nullable
as bool,showWeekday: null == showWeekday ? _self.showWeekday : showWeekday // ignore: cast_nullable_to_non_nullable
as bool,dateFormat: null == dateFormat ? _self.dateFormat : dateFormat // ignore: cast_nullable_to_non_nullable
as ClockDateFormat,timeFont: null == timeFont ? _self.timeFont : timeFont // ignore: cast_nullable_to_non_nullable
as ClockFont,dateFont: null == dateFont ? _self.dateFont : dateFont // ignore: cast_nullable_to_non_nullable
as ClockFont,timeFontSizePercent: null == timeFontSizePercent ? _self.timeFontSizePercent : timeFontSizePercent // ignore: cast_nullable_to_non_nullable
as double,dateFontSizePercent: null == dateFontSizePercent ? _self.dateFontSizePercent : dateFontSizePercent // ignore: cast_nullable_to_non_nullable
as double,textColor: null == textColor ? _self.textColor : textColor // ignore: cast_nullable_to_non_nullable
as int,backgroundColor: null == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ClockScreenOptions].
extension ClockScreenOptionsPatterns on ClockScreenOptions {
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
mixin _$CameraConfig {


/// Create a copy of CameraConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CameraConfigCopyWith<CameraConfig> get copyWith => _$CameraConfigCopyWithImpl<CameraConfig>(this as CameraConfig, _$identity);





@override
String toString() {
  final _this = this as CameraConfig;
  return 'CameraConfig(id: ${_this.id}, name: ${_this.name}, url: ${_this.url}, username: ${_this.username}, password: ${_this.password})';
}


}

/// @nodoc
abstract mixin class $CameraConfigCopyWith<$Res>  {
  factory $CameraConfigCopyWith(CameraConfig value, $Res Function(CameraConfig) _then) = _$CameraConfigCopyWithImpl;
@useResult
$Res call({
 String id, String name, String url, String username, String password
});




}
/// @nodoc
class _$CameraConfigCopyWithImpl<$Res>
    implements $CameraConfigCopyWith<$Res> {
  _$CameraConfigCopyWithImpl(this._self, this._then);

  final CameraConfig _self;
  final $Res Function(CameraConfig) _then;

/// Create a copy of CameraConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? url = null,Object? username = null,Object? password = null,}) {
  return _then(CameraConfig(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CameraConfig].
extension CameraConfigPatterns on CameraConfig {
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
mixin _$CamerasScreenOptions {


/// Create a copy of CamerasScreenOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CamerasScreenOptionsCopyWith<CamerasScreenOptions> get copyWith => _$CamerasScreenOptionsCopyWithImpl<CamerasScreenOptions>(this as CamerasScreenOptions, _$identity);





@override
String toString() {
  final _this = this as CamerasScreenOptions;
  return 'CamerasScreenOptions(mode: ${_this.mode}, cameras: ${_this.cameras}, columns: ${_this.columns}, fit: ${_this.fit}, showNames: ${_this.showNames}, refreshIntervalMs: ${_this.refreshIntervalMs}, requestTimeoutMs: ${_this.requestTimeoutMs})';
}


}

/// @nodoc
abstract mixin class $CamerasScreenOptionsCopyWith<$Res>  {
  factory $CamerasScreenOptionsCopyWith(CamerasScreenOptions value, $Res Function(CamerasScreenOptions) _then) = _$CamerasScreenOptionsCopyWithImpl;
@useResult
$Res call({
 CameraDisplayMode mode, List<CameraConfig>? cameras, int columns, CameraImageFit fit, bool showNames, int refreshIntervalMs, int requestTimeoutMs
});




}
/// @nodoc
class _$CamerasScreenOptionsCopyWithImpl<$Res>
    implements $CamerasScreenOptionsCopyWith<$Res> {
  _$CamerasScreenOptionsCopyWithImpl(this._self, this._then);

  final CamerasScreenOptions _self;
  final $Res Function(CamerasScreenOptions) _then;

/// Create a copy of CamerasScreenOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mode = null,Object? cameras = freezed,Object? columns = null,Object? fit = null,Object? showNames = null,Object? refreshIntervalMs = null,Object? requestTimeoutMs = null,}) {
  return _then(CamerasScreenOptions(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as CameraDisplayMode,cameras: freezed == cameras ? _self.cameras! : cameras // ignore: cast_nullable_to_non_nullable
as List<CameraConfig>?,columns: null == columns ? _self.columns : columns // ignore: cast_nullable_to_non_nullable
as int,fit: null == fit ? _self.fit : fit // ignore: cast_nullable_to_non_nullable
as CameraImageFit,showNames: null == showNames ? _self.showNames : showNames // ignore: cast_nullable_to_non_nullable
as bool,refreshIntervalMs: null == refreshIntervalMs ? _self.refreshIntervalMs : refreshIntervalMs // ignore: cast_nullable_to_non_nullable
as int,requestTimeoutMs: null == requestTimeoutMs ? _self.requestTimeoutMs : requestTimeoutMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CamerasScreenOptions].
extension CamerasScreenOptionsPatterns on CamerasScreenOptions {
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
mixin _$SpecialScreenDefinition {


/// Create a copy of SpecialScreenDefinition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpecialScreenDefinitionCopyWith<SpecialScreenDefinition> get copyWith => _$SpecialScreenDefinitionCopyWithImpl<SpecialScreenDefinition>(this as SpecialScreenDefinition, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SpecialScreenDefinition;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpecialScreenDefinition&&(identical(other.parseOptions, _this.parseOptions) || other.parseOptions == _this.parseOptions));
}


@override
int get hashCode {
  final _this = this as SpecialScreenDefinition;
  return Object.hash(runtimeType,_this.parseOptions);
}

@override
String toString() {
  final _this = this as SpecialScreenDefinition;
  return 'SpecialScreenDefinition(parseOptions: ${_this.parseOptions})';
}


}

/// @nodoc
abstract mixin class $SpecialScreenDefinitionCopyWith<$Res>  {
  factory $SpecialScreenDefinitionCopyWith(SpecialScreenDefinition value, $Res Function(SpecialScreenDefinition) _then) = _$SpecialScreenDefinitionCopyWithImpl;
@useResult
$Res call({
 SpecialScreenOptions Function(Map<String, dynamic>) parseOptions
});




}
/// @nodoc
class _$SpecialScreenDefinitionCopyWithImpl<$Res>
    implements $SpecialScreenDefinitionCopyWith<$Res> {
  _$SpecialScreenDefinitionCopyWithImpl(this._self, this._then);

  final SpecialScreenDefinition _self;
  final $Res Function(SpecialScreenDefinition) _then;

/// Create a copy of SpecialScreenDefinition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? parseOptions = null,}) {
  return _then(SpecialScreenDefinition(
null == parseOptions ? _self.parseOptions : parseOptions // ignore: cast_nullable_to_non_nullable
as SpecialScreenOptions Function(Map<String, dynamic>),
  ));
}

}


/// Adds pattern-matching-related methods to [SpecialScreenDefinition].
extension SpecialScreenDefinitionPatterns on SpecialScreenDefinition {
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
mixin _$SpecialScreenConfig {


/// Create a copy of SpecialScreenConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpecialScreenConfigCopyWith<SpecialScreenConfig> get copyWith => _$SpecialScreenConfigCopyWithImpl<SpecialScreenConfig>(this as SpecialScreenConfig, _$identity);





@override
String toString() {
  final _this = this as SpecialScreenConfig;
  return 'SpecialScreenConfig(id: ${_this.id}, type: ${_this.type}, name: ${_this.name}, enabled: ${_this.enabled}, schedule: ${_this.schedule}, displayTimeMs: ${_this.displayTimeMs}, options: ${_this.options})';
}


}

/// @nodoc
abstract mixin class $SpecialScreenConfigCopyWith<$Res>  {
  factory $SpecialScreenConfigCopyWith(SpecialScreenConfig value, $Res Function(SpecialScreenConfig) _then) = _$SpecialScreenConfigCopyWithImpl;
@useResult
$Res call({
 String id, SpecialScreenType type, String name, bool enabled, SpecialScreenSchedule? schedule, int displayTimeMs, SpecialScreenOptions? options
});


$SpecialScreenScheduleCopyWith<$Res>? get schedule;

}
/// @nodoc
class _$SpecialScreenConfigCopyWithImpl<$Res>
    implements $SpecialScreenConfigCopyWith<$Res> {
  _$SpecialScreenConfigCopyWithImpl(this._self, this._then);

  final SpecialScreenConfig _self;
  final $Res Function(SpecialScreenConfig) _then;

/// Create a copy of SpecialScreenConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? name = null,Object? enabled = null,Object? schedule = freezed,Object? displayTimeMs = null,Object? options = freezed,}) {
  return _then(SpecialScreenConfig(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SpecialScreenType,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,schedule: freezed == schedule ? _self.schedule! : schedule // ignore: cast_nullable_to_non_nullable
as SpecialScreenSchedule?,displayTimeMs: null == displayTimeMs ? _self.displayTimeMs : displayTimeMs // ignore: cast_nullable_to_non_nullable
as int,options: freezed == options ? _self.options! : options // ignore: cast_nullable_to_non_nullable
as SpecialScreenOptions?,
  ));
}
/// Create a copy of SpecialScreenConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SpecialScreenScheduleCopyWith<$Res>? get schedule {
    if (_self.schedule == null) {
    return null;
  }

  return $SpecialScreenScheduleCopyWith<$Res>(_self.schedule!, (value) {
    return _then(_self.copyWith(schedule: value));
  });
}
}


/// Adds pattern-matching-related methods to [SpecialScreenConfig].
extension SpecialScreenConfigPatterns on SpecialScreenConfig {
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
