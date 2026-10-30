// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'config_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ConfigEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ConfigEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ConfigEvent()';
}


}

/// @nodoc
class $ConfigEventCopyWith<$Res>  {
$ConfigEventCopyWith(ConfigEvent _, $Res Function(ConfigEvent) __);
}


/// Adds pattern-matching-related methods to [ConfigEvent].
extension ConfigEventPatterns on ConfigEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ConfigInitialize value)?  initialize,TResult Function( ConfigRetry value)?  retry,TResult Function( ConfigExit value)?  exit,TResult Function( ConfigNetworkUpdated value)?  networkUpdated,TResult Function( ConfigButton value)?  button,TResult Function( ConfigCompleted value)?  completed,TResult Function( ConfigTimedOut value)?  timedOut,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ConfigInitialize() when initialize != null:
return initialize(_that);case ConfigRetry() when retry != null:
return retry(_that);case ConfigExit() when exit != null:
return exit(_that);case ConfigNetworkUpdated() when networkUpdated != null:
return networkUpdated(_that);case ConfigButton() when button != null:
return button(_that);case ConfigCompleted() when completed != null:
return completed(_that);case ConfigTimedOut() when timedOut != null:
return timedOut(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ConfigInitialize value)  initialize,required TResult Function( ConfigRetry value)  retry,required TResult Function( ConfigExit value)  exit,required TResult Function( ConfigNetworkUpdated value)  networkUpdated,required TResult Function( ConfigButton value)  button,required TResult Function( ConfigCompleted value)  completed,required TResult Function( ConfigTimedOut value)  timedOut,}){
final _that = this;
switch (_that) {
case ConfigInitialize():
return initialize(_that);case ConfigRetry():
return retry(_that);case ConfigExit():
return exit(_that);case ConfigNetworkUpdated():
return networkUpdated(_that);case ConfigButton():
return button(_that);case ConfigCompleted():
return completed(_that);case ConfigTimedOut():
return timedOut(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ConfigInitialize value)?  initialize,TResult? Function( ConfigRetry value)?  retry,TResult? Function( ConfigExit value)?  exit,TResult? Function( ConfigNetworkUpdated value)?  networkUpdated,TResult? Function( ConfigButton value)?  button,TResult? Function( ConfigCompleted value)?  completed,TResult? Function( ConfigTimedOut value)?  timedOut,}){
final _that = this;
switch (_that) {
case ConfigInitialize() when initialize != null:
return initialize(_that);case ConfigRetry() when retry != null:
return retry(_that);case ConfigExit() when exit != null:
return exit(_that);case ConfigNetworkUpdated() when networkUpdated != null:
return networkUpdated(_that);case ConfigButton() when button != null:
return button(_that);case ConfigCompleted() when completed != null:
return completed(_that);case ConfigTimedOut() when timedOut != null:
return timedOut(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initialize,TResult Function()?  retry,TResult Function()?  exit,TResult Function( SystemInfo info)?  networkUpdated,TResult Function( ButtonEvent button)?  button,TResult Function( ConfigOperation operation,  int id,  String? code,  SystemInfo? info,  ConfigFailureKind? failure)?  completed,TResult Function( ConfigOperation operation,  int id)?  timedOut,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ConfigInitialize() when initialize != null:
return initialize();case ConfigRetry() when retry != null:
return retry();case ConfigExit() when exit != null:
return exit();case ConfigNetworkUpdated() when networkUpdated != null:
return networkUpdated(_that.info);case ConfigButton() when button != null:
return button(_that.button);case ConfigCompleted() when completed != null:
return completed(_that.operation,_that.id,_that.code,_that.info,_that.failure);case ConfigTimedOut() when timedOut != null:
return timedOut(_that.operation,_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initialize,required TResult Function()  retry,required TResult Function()  exit,required TResult Function( SystemInfo info)  networkUpdated,required TResult Function( ButtonEvent button)  button,required TResult Function( ConfigOperation operation,  int id,  String? code,  SystemInfo? info,  ConfigFailureKind? failure)  completed,required TResult Function( ConfigOperation operation,  int id)  timedOut,}) {final _that = this;
switch (_that) {
case ConfigInitialize():
return initialize();case ConfigRetry():
return retry();case ConfigExit():
return exit();case ConfigNetworkUpdated():
return networkUpdated(_that.info);case ConfigButton():
return button(_that.button);case ConfigCompleted():
return completed(_that.operation,_that.id,_that.code,_that.info,_that.failure);case ConfigTimedOut():
return timedOut(_that.operation,_that.id);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initialize,TResult? Function()?  retry,TResult? Function()?  exit,TResult? Function( SystemInfo info)?  networkUpdated,TResult? Function( ButtonEvent button)?  button,TResult? Function( ConfigOperation operation,  int id,  String? code,  SystemInfo? info,  ConfigFailureKind? failure)?  completed,TResult? Function( ConfigOperation operation,  int id)?  timedOut,}) {final _that = this;
switch (_that) {
case ConfigInitialize() when initialize != null:
return initialize();case ConfigRetry() when retry != null:
return retry();case ConfigExit() when exit != null:
return exit();case ConfigNetworkUpdated() when networkUpdated != null:
return networkUpdated(_that.info);case ConfigButton() when button != null:
return button(_that.button);case ConfigCompleted() when completed != null:
return completed(_that.operation,_that.id,_that.code,_that.info,_that.failure);case ConfigTimedOut() when timedOut != null:
return timedOut(_that.operation,_that.id);case _:
  return null;

}
}

}

/// @nodoc


class ConfigInitialize implements ConfigEvent {
  const ConfigInitialize();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ConfigInitialize);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ConfigEvent.initialize()';
}


}




/// @nodoc


class ConfigRetry implements ConfigEvent {
  const ConfigRetry();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ConfigRetry);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ConfigEvent.retry()';
}


}




/// @nodoc


class ConfigExit implements ConfigEvent {
  const ConfigExit();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ConfigExit);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ConfigEvent.exit()';
}


}




/// @nodoc


class ConfigNetworkUpdated implements ConfigEvent {
  const ConfigNetworkUpdated(this.info);
  

 final  SystemInfo info;

/// Create a copy of ConfigEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConfigNetworkUpdatedCopyWith<ConfigNetworkUpdated> get copyWith => _$ConfigNetworkUpdatedCopyWithImpl<ConfigNetworkUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ConfigNetworkUpdated&&(identical(other.info, info) || other.info == info));
}


@override
int get hashCode {
    return Object.hash(runtimeType,info);
}

@override
String toString() {
    return 'ConfigEvent.networkUpdated(info: $info)';
}


}

/// @nodoc
abstract mixin class $ConfigNetworkUpdatedCopyWith<$Res> implements $ConfigEventCopyWith<$Res> {
  factory $ConfigNetworkUpdatedCopyWith(ConfigNetworkUpdated value, $Res Function(ConfigNetworkUpdated) _then) = _$ConfigNetworkUpdatedCopyWithImpl;
@useResult
$Res call({
 SystemInfo info
});


$SystemInfoCopyWith<$Res> get info;

}
/// @nodoc
class _$ConfigNetworkUpdatedCopyWithImpl<$Res>
    implements $ConfigNetworkUpdatedCopyWith<$Res> {
  _$ConfigNetworkUpdatedCopyWithImpl(this._self, this._then);

  final ConfigNetworkUpdated _self;
  final $Res Function(ConfigNetworkUpdated) _then;

/// Create a copy of ConfigEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? info = null,}) {
  return _then(ConfigNetworkUpdated(
null == info ? _self.info : info // ignore: cast_nullable_to_non_nullable
as SystemInfo,
  ));
}

/// Create a copy of ConfigEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SystemInfoCopyWith<$Res> get info {
  
  return $SystemInfoCopyWith<$Res>(_self.info, (value) {
    return _then(_self.copyWith(info: value));
  });
}
}

/// @nodoc


class ConfigButton implements ConfigEvent {
  const ConfigButton(this.button);
  

 final  ButtonEvent button;

/// Create a copy of ConfigEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConfigButtonCopyWith<ConfigButton> get copyWith => _$ConfigButtonCopyWithImpl<ConfigButton>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ConfigButton&&(identical(other.button, button) || other.button == button));
}


@override
int get hashCode {
    return Object.hash(runtimeType,button);
}

@override
String toString() {
    return 'ConfigEvent.button(button: $button)';
}


}

/// @nodoc
abstract mixin class $ConfigButtonCopyWith<$Res> implements $ConfigEventCopyWith<$Res> {
  factory $ConfigButtonCopyWith(ConfigButton value, $Res Function(ConfigButton) _then) = _$ConfigButtonCopyWithImpl;
@useResult
$Res call({
 ButtonEvent button
});




}
/// @nodoc
class _$ConfigButtonCopyWithImpl<$Res>
    implements $ConfigButtonCopyWith<$Res> {
  _$ConfigButtonCopyWithImpl(this._self, this._then);

  final ConfigButton _self;
  final $Res Function(ConfigButton) _then;

/// Create a copy of ConfigEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? button = null,}) {
  return _then(ConfigButton(
null == button ? _self.button : button // ignore: cast_nullable_to_non_nullable
as ButtonEvent,
  ));
}


}

/// @nodoc


class ConfigCompleted implements ConfigEvent {
  const ConfigCompleted(this.operation, this.id, {this.code, this.info, this.failure});
  

 final  ConfigOperation operation;
 final  int id;
 final  String? code;
 final  SystemInfo? info;
 final  ConfigFailureKind? failure;

/// Create a copy of ConfigEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConfigCompletedCopyWith<ConfigCompleted> get copyWith => _$ConfigCompletedCopyWithImpl<ConfigCompleted>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ConfigCompleted&&(identical(other.operation, operation) || other.operation == operation)&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.info, info) || other.info == info)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,operation,id,code,info,failure);
}

@override
String toString() {
    return 'ConfigEvent.completed(operation: $operation, id: $id, code: $code, info: $info, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $ConfigCompletedCopyWith<$Res> implements $ConfigEventCopyWith<$Res> {
  factory $ConfigCompletedCopyWith(ConfigCompleted value, $Res Function(ConfigCompleted) _then) = _$ConfigCompletedCopyWithImpl;
@useResult
$Res call({
 ConfigOperation operation, int id, String? code, SystemInfo? info, ConfigFailureKind? failure
});


$SystemInfoCopyWith<$Res>? get info;

}
/// @nodoc
class _$ConfigCompletedCopyWithImpl<$Res>
    implements $ConfigCompletedCopyWith<$Res> {
  _$ConfigCompletedCopyWithImpl(this._self, this._then);

  final ConfigCompleted _self;
  final $Res Function(ConfigCompleted) _then;

/// Create a copy of ConfigEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? operation = null,Object? id = null,Object? code = freezed,Object? info = freezed,Object? failure = freezed,}) {
  return _then(ConfigCompleted(
null == operation ? _self.operation : operation // ignore: cast_nullable_to_non_nullable
as ConfigOperation,null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,info: freezed == info ? _self.info : info // ignore: cast_nullable_to_non_nullable
as SystemInfo?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as ConfigFailureKind?,
  ));
}

/// Create a copy of ConfigEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SystemInfoCopyWith<$Res>? get info {
    if (_self.info == null) {
    return null;
  }

  return $SystemInfoCopyWith<$Res>(_self.info!, (value) {
    return _then(_self.copyWith(info: value));
  });
}
}

/// @nodoc


class ConfigTimedOut implements ConfigEvent {
  const ConfigTimedOut(this.operation, this.id);
  

 final  ConfigOperation operation;
 final  int id;

/// Create a copy of ConfigEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConfigTimedOutCopyWith<ConfigTimedOut> get copyWith => _$ConfigTimedOutCopyWithImpl<ConfigTimedOut>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ConfigTimedOut&&(identical(other.operation, operation) || other.operation == operation)&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode {
    return Object.hash(runtimeType,operation,id);
}

@override
String toString() {
    return 'ConfigEvent.timedOut(operation: $operation, id: $id)';
}


}

/// @nodoc
abstract mixin class $ConfigTimedOutCopyWith<$Res> implements $ConfigEventCopyWith<$Res> {
  factory $ConfigTimedOutCopyWith(ConfigTimedOut value, $Res Function(ConfigTimedOut) _then) = _$ConfigTimedOutCopyWithImpl;
@useResult
$Res call({
 ConfigOperation operation, int id
});




}
/// @nodoc
class _$ConfigTimedOutCopyWithImpl<$Res>
    implements $ConfigTimedOutCopyWith<$Res> {
  _$ConfigTimedOutCopyWithImpl(this._self, this._then);

  final ConfigTimedOut _self;
  final $Res Function(ConfigTimedOut) _then;

/// Create a copy of ConfigEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? operation = null,Object? id = null,}) {
  return _then(ConfigTimedOut(
null == operation ? _self.operation : operation // ignore: cast_nullable_to_non_nullable
as ConfigOperation,null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
