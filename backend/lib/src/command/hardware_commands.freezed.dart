// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hardware_commands.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AreYouReadyCommand {

 int get id; String get type;
/// Create a copy of AreYouReadyCommand
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AreYouReadyCommandCopyWith<AreYouReadyCommand> get copyWith => _$AreYouReadyCommandCopyWithImpl<AreYouReadyCommand>(this as AreYouReadyCommand, _$identity);

  /// Serializes this AreYouReadyCommand to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AreYouReadyCommand&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type);

@override
String toString() {
  return 'AreYouReadyCommand(id: $id, type: $type)';
}


}

/// @nodoc
abstract mixin class $AreYouReadyCommandCopyWith<$Res>  {
  factory $AreYouReadyCommandCopyWith(AreYouReadyCommand value, $Res Function(AreYouReadyCommand) _then) = _$AreYouReadyCommandCopyWithImpl;
@useResult
$Res call({
 int id, String type
});




}
/// @nodoc
class _$AreYouReadyCommandCopyWithImpl<$Res>
    implements $AreYouReadyCommandCopyWith<$Res> {
  _$AreYouReadyCommandCopyWithImpl(this._self, this._then);

  final AreYouReadyCommand _self;
  final $Res Function(AreYouReadyCommand) _then;

/// Create a copy of AreYouReadyCommand
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AreYouReadyCommand].
extension AreYouReadyCommandPatterns on AreYouReadyCommand {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AreYouReadyCommand value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AreYouReadyCommand() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AreYouReadyCommand value)  $default,){
final _that = this;
switch (_that) {
case _AreYouReadyCommand():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AreYouReadyCommand value)?  $default,){
final _that = this;
switch (_that) {
case _AreYouReadyCommand() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AreYouReadyCommand() when $default != null:
return $default(_that.id,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String type)  $default,) {final _that = this;
switch (_that) {
case _AreYouReadyCommand():
return $default(_that.id,_that.type);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String type)?  $default,) {final _that = this;
switch (_that) {
case _AreYouReadyCommand() when $default != null:
return $default(_that.id,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AreYouReadyCommand implements AreYouReadyCommand {
  const _AreYouReadyCommand({required this.id, this.type = AreYouReadyCommand.TYPE});
  factory _AreYouReadyCommand.fromJson(Map<String, dynamic> json) => _$AreYouReadyCommandFromJson(json);

@override final  int id;
@override@JsonKey() final  String type;

/// Create a copy of AreYouReadyCommand
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AreYouReadyCommandCopyWith<_AreYouReadyCommand> get copyWith => __$AreYouReadyCommandCopyWithImpl<_AreYouReadyCommand>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AreYouReadyCommandToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AreYouReadyCommand&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type);

@override
String toString() {
  return 'AreYouReadyCommand(id: $id, type: $type)';
}


}

/// @nodoc
abstract mixin class _$AreYouReadyCommandCopyWith<$Res> implements $AreYouReadyCommandCopyWith<$Res> {
  factory _$AreYouReadyCommandCopyWith(_AreYouReadyCommand value, $Res Function(_AreYouReadyCommand) _then) = __$AreYouReadyCommandCopyWithImpl;
@override @useResult
$Res call({
 int id, String type
});




}
/// @nodoc
class __$AreYouReadyCommandCopyWithImpl<$Res>
    implements _$AreYouReadyCommandCopyWith<$Res> {
  __$AreYouReadyCommandCopyWithImpl(this._self, this._then);

  final _AreYouReadyCommand _self;
  final $Res Function(_AreYouReadyCommand) _then;

/// Create a copy of AreYouReadyCommand
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,}) {
  return _then(_AreYouReadyCommand(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ButtonChangeStateCommand {

 ButtonType get button; ButtonEventType get event; int get durationMs; int get id; String get type;
/// Create a copy of ButtonChangeStateCommand
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ButtonChangeStateCommandCopyWith<ButtonChangeStateCommand> get copyWith => _$ButtonChangeStateCommandCopyWithImpl<ButtonChangeStateCommand>(this as ButtonChangeStateCommand, _$identity);

  /// Serializes this ButtonChangeStateCommand to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ButtonChangeStateCommand&&(identical(other.button, button) || other.button == button)&&(identical(other.event, event) || other.event == event)&&(identical(other.durationMs, durationMs) || other.durationMs == durationMs)&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,button,event,durationMs,id,type);

@override
String toString() {
  return 'ButtonChangeStateCommand(button: $button, event: $event, durationMs: $durationMs, id: $id, type: $type)';
}


}

/// @nodoc
abstract mixin class $ButtonChangeStateCommandCopyWith<$Res>  {
  factory $ButtonChangeStateCommandCopyWith(ButtonChangeStateCommand value, $Res Function(ButtonChangeStateCommand) _then) = _$ButtonChangeStateCommandCopyWithImpl;
@useResult
$Res call({
 ButtonType button, ButtonEventType event, int durationMs, int id, String type
});




}
/// @nodoc
class _$ButtonChangeStateCommandCopyWithImpl<$Res>
    implements $ButtonChangeStateCommandCopyWith<$Res> {
  _$ButtonChangeStateCommandCopyWithImpl(this._self, this._then);

  final ButtonChangeStateCommand _self;
  final $Res Function(ButtonChangeStateCommand) _then;

/// Create a copy of ButtonChangeStateCommand
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? button = null,Object? event = null,Object? durationMs = null,Object? id = null,Object? type = null,}) {
  return _then(_self.copyWith(
button: null == button ? _self.button : button // ignore: cast_nullable_to_non_nullable
as ButtonType,event: null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as ButtonEventType,durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ButtonChangeStateCommand].
extension ButtonChangeStateCommandPatterns on ButtonChangeStateCommand {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ButtonChangeStateCommand value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ButtonChangeStateCommand() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ButtonChangeStateCommand value)  $default,){
final _that = this;
switch (_that) {
case _ButtonChangeStateCommand():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ButtonChangeStateCommand value)?  $default,){
final _that = this;
switch (_that) {
case _ButtonChangeStateCommand() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ButtonType button,  ButtonEventType event,  int durationMs,  int id,  String type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ButtonChangeStateCommand() when $default != null:
return $default(_that.button,_that.event,_that.durationMs,_that.id,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ButtonType button,  ButtonEventType event,  int durationMs,  int id,  String type)  $default,) {final _that = this;
switch (_that) {
case _ButtonChangeStateCommand():
return $default(_that.button,_that.event,_that.durationMs,_that.id,_that.type);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ButtonType button,  ButtonEventType event,  int durationMs,  int id,  String type)?  $default,) {final _that = this;
switch (_that) {
case _ButtonChangeStateCommand() when $default != null:
return $default(_that.button,_that.event,_that.durationMs,_that.id,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ButtonChangeStateCommand implements ButtonChangeStateCommand {
  const _ButtonChangeStateCommand({required this.button, required this.event, required this.durationMs, required this.id, this.type = ButtonChangeStateCommand.TYPE});
  factory _ButtonChangeStateCommand.fromJson(Map<String, dynamic> json) => _$ButtonChangeStateCommandFromJson(json);

@override final  ButtonType button;
@override final  ButtonEventType event;
@override final  int durationMs;
@override final  int id;
@override@JsonKey() final  String type;

/// Create a copy of ButtonChangeStateCommand
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ButtonChangeStateCommandCopyWith<_ButtonChangeStateCommand> get copyWith => __$ButtonChangeStateCommandCopyWithImpl<_ButtonChangeStateCommand>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ButtonChangeStateCommandToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ButtonChangeStateCommand&&(identical(other.button, button) || other.button == button)&&(identical(other.event, event) || other.event == event)&&(identical(other.durationMs, durationMs) || other.durationMs == durationMs)&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,button,event,durationMs,id,type);

@override
String toString() {
  return 'ButtonChangeStateCommand(button: $button, event: $event, durationMs: $durationMs, id: $id, type: $type)';
}


}

/// @nodoc
abstract mixin class _$ButtonChangeStateCommandCopyWith<$Res> implements $ButtonChangeStateCommandCopyWith<$Res> {
  factory _$ButtonChangeStateCommandCopyWith(_ButtonChangeStateCommand value, $Res Function(_ButtonChangeStateCommand) _then) = __$ButtonChangeStateCommandCopyWithImpl;
@override @useResult
$Res call({
 ButtonType button, ButtonEventType event, int durationMs, int id, String type
});




}
/// @nodoc
class __$ButtonChangeStateCommandCopyWithImpl<$Res>
    implements _$ButtonChangeStateCommandCopyWith<$Res> {
  __$ButtonChangeStateCommandCopyWithImpl(this._self, this._then);

  final _ButtonChangeStateCommand _self;
  final $Res Function(_ButtonChangeStateCommand) _then;

/// Create a copy of ButtonChangeStateCommand
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? button = null,Object? event = null,Object? durationMs = null,Object? id = null,Object? type = null,}) {
  return _then(_ButtonChangeStateCommand(
button: null == button ? _self.button : button // ignore: cast_nullable_to_non_nullable
as ButtonType,event: null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as ButtonEventType,durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$EmulatePushButtonCommand {

 ButtonType get button; int get durationMs; int get id; String get type;
/// Create a copy of EmulatePushButtonCommand
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmulatePushButtonCommandCopyWith<EmulatePushButtonCommand> get copyWith => _$EmulatePushButtonCommandCopyWithImpl<EmulatePushButtonCommand>(this as EmulatePushButtonCommand, _$identity);

  /// Serializes this EmulatePushButtonCommand to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmulatePushButtonCommand&&(identical(other.button, button) || other.button == button)&&(identical(other.durationMs, durationMs) || other.durationMs == durationMs)&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,button,durationMs,id,type);

@override
String toString() {
  return 'EmulatePushButtonCommand(button: $button, durationMs: $durationMs, id: $id, type: $type)';
}


}

/// @nodoc
abstract mixin class $EmulatePushButtonCommandCopyWith<$Res>  {
  factory $EmulatePushButtonCommandCopyWith(EmulatePushButtonCommand value, $Res Function(EmulatePushButtonCommand) _then) = _$EmulatePushButtonCommandCopyWithImpl;
@useResult
$Res call({
 ButtonType button, int durationMs, int id, String type
});




}
/// @nodoc
class _$EmulatePushButtonCommandCopyWithImpl<$Res>
    implements $EmulatePushButtonCommandCopyWith<$Res> {
  _$EmulatePushButtonCommandCopyWithImpl(this._self, this._then);

  final EmulatePushButtonCommand _self;
  final $Res Function(EmulatePushButtonCommand) _then;

/// Create a copy of EmulatePushButtonCommand
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? button = null,Object? durationMs = null,Object? id = null,Object? type = null,}) {
  return _then(_self.copyWith(
button: null == button ? _self.button : button // ignore: cast_nullable_to_non_nullable
as ButtonType,durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EmulatePushButtonCommand].
extension EmulatePushButtonCommandPatterns on EmulatePushButtonCommand {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmulatePushButtonCommand value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmulatePushButtonCommand() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmulatePushButtonCommand value)  $default,){
final _that = this;
switch (_that) {
case _EmulatePushButtonCommand():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmulatePushButtonCommand value)?  $default,){
final _that = this;
switch (_that) {
case _EmulatePushButtonCommand() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ButtonType button,  int durationMs,  int id,  String type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmulatePushButtonCommand() when $default != null:
return $default(_that.button,_that.durationMs,_that.id,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ButtonType button,  int durationMs,  int id,  String type)  $default,) {final _that = this;
switch (_that) {
case _EmulatePushButtonCommand():
return $default(_that.button,_that.durationMs,_that.id,_that.type);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ButtonType button,  int durationMs,  int id,  String type)?  $default,) {final _that = this;
switch (_that) {
case _EmulatePushButtonCommand() when $default != null:
return $default(_that.button,_that.durationMs,_that.id,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EmulatePushButtonCommand implements EmulatePushButtonCommand {
  const _EmulatePushButtonCommand({required this.button, required this.durationMs, required this.id, this.type = EmulatePushButtonCommand.TYPE});
  factory _EmulatePushButtonCommand.fromJson(Map<String, dynamic> json) => _$EmulatePushButtonCommandFromJson(json);

@override final  ButtonType button;
@override final  int durationMs;
@override final  int id;
@override@JsonKey() final  String type;

/// Create a copy of EmulatePushButtonCommand
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmulatePushButtonCommandCopyWith<_EmulatePushButtonCommand> get copyWith => __$EmulatePushButtonCommandCopyWithImpl<_EmulatePushButtonCommand>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EmulatePushButtonCommandToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmulatePushButtonCommand&&(identical(other.button, button) || other.button == button)&&(identical(other.durationMs, durationMs) || other.durationMs == durationMs)&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,button,durationMs,id,type);

@override
String toString() {
  return 'EmulatePushButtonCommand(button: $button, durationMs: $durationMs, id: $id, type: $type)';
}


}

/// @nodoc
abstract mixin class _$EmulatePushButtonCommandCopyWith<$Res> implements $EmulatePushButtonCommandCopyWith<$Res> {
  factory _$EmulatePushButtonCommandCopyWith(_EmulatePushButtonCommand value, $Res Function(_EmulatePushButtonCommand) _then) = __$EmulatePushButtonCommandCopyWithImpl;
@override @useResult
$Res call({
 ButtonType button, int durationMs, int id, String type
});




}
/// @nodoc
class __$EmulatePushButtonCommandCopyWithImpl<$Res>
    implements _$EmulatePushButtonCommandCopyWith<$Res> {
  __$EmulatePushButtonCommandCopyWithImpl(this._self, this._then);

  final _EmulatePushButtonCommand _self;
  final $Res Function(_EmulatePushButtonCommand) _then;

/// Create a copy of EmulatePushButtonCommand
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? button = null,Object? durationMs = null,Object? id = null,Object? type = null,}) {
  return _then(_EmulatePushButtonCommand(
button: null == button ? _self.button : button // ignore: cast_nullable_to_non_nullable
as ButtonType,durationMs: null == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ExecuteSSActionCommand {

 SlideshowAction get action; bool get value; int get id; String get type;
/// Create a copy of ExecuteSSActionCommand
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExecuteSSActionCommandCopyWith<ExecuteSSActionCommand> get copyWith => _$ExecuteSSActionCommandCopyWithImpl<ExecuteSSActionCommand>(this as ExecuteSSActionCommand, _$identity);

  /// Serializes this ExecuteSSActionCommand to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExecuteSSActionCommand&&(identical(other.action, action) || other.action == action)&&(identical(other.value, value) || other.value == value)&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,action,value,id,type);

@override
String toString() {
  return 'ExecuteSSActionCommand(action: $action, value: $value, id: $id, type: $type)';
}


}

/// @nodoc
abstract mixin class $ExecuteSSActionCommandCopyWith<$Res>  {
  factory $ExecuteSSActionCommandCopyWith(ExecuteSSActionCommand value, $Res Function(ExecuteSSActionCommand) _then) = _$ExecuteSSActionCommandCopyWithImpl;
@useResult
$Res call({
 SlideshowAction action, bool value, int id, String type
});




}
/// @nodoc
class _$ExecuteSSActionCommandCopyWithImpl<$Res>
    implements $ExecuteSSActionCommandCopyWith<$Res> {
  _$ExecuteSSActionCommandCopyWithImpl(this._self, this._then);

  final ExecuteSSActionCommand _self;
  final $Res Function(ExecuteSSActionCommand) _then;

/// Create a copy of ExecuteSSActionCommand
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? action = null,Object? value = null,Object? id = null,Object? type = null,}) {
  return _then(_self.copyWith(
action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as SlideshowAction,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as bool,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ExecuteSSActionCommand].
extension ExecuteSSActionCommandPatterns on ExecuteSSActionCommand {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExecuteSSActionCommand value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExecuteSSActionCommand() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExecuteSSActionCommand value)  $default,){
final _that = this;
switch (_that) {
case _ExecuteSSActionCommand():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExecuteSSActionCommand value)?  $default,){
final _that = this;
switch (_that) {
case _ExecuteSSActionCommand() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SlideshowAction action,  bool value,  int id,  String type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExecuteSSActionCommand() when $default != null:
return $default(_that.action,_that.value,_that.id,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SlideshowAction action,  bool value,  int id,  String type)  $default,) {final _that = this;
switch (_that) {
case _ExecuteSSActionCommand():
return $default(_that.action,_that.value,_that.id,_that.type);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SlideshowAction action,  bool value,  int id,  String type)?  $default,) {final _that = this;
switch (_that) {
case _ExecuteSSActionCommand() when $default != null:
return $default(_that.action,_that.value,_that.id,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExecuteSSActionCommand implements ExecuteSSActionCommand {
  const _ExecuteSSActionCommand({required this.action, required this.value, required this.id, this.type = ExecuteSSActionCommand.TYPE});
  factory _ExecuteSSActionCommand.fromJson(Map<String, dynamic> json) => _$ExecuteSSActionCommandFromJson(json);

@override final  SlideshowAction action;
@override final  bool value;
@override final  int id;
@override@JsonKey() final  String type;

/// Create a copy of ExecuteSSActionCommand
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExecuteSSActionCommandCopyWith<_ExecuteSSActionCommand> get copyWith => __$ExecuteSSActionCommandCopyWithImpl<_ExecuteSSActionCommand>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExecuteSSActionCommandToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExecuteSSActionCommand&&(identical(other.action, action) || other.action == action)&&(identical(other.value, value) || other.value == value)&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,action,value,id,type);

@override
String toString() {
  return 'ExecuteSSActionCommand(action: $action, value: $value, id: $id, type: $type)';
}


}

/// @nodoc
abstract mixin class _$ExecuteSSActionCommandCopyWith<$Res> implements $ExecuteSSActionCommandCopyWith<$Res> {
  factory _$ExecuteSSActionCommandCopyWith(_ExecuteSSActionCommand value, $Res Function(_ExecuteSSActionCommand) _then) = __$ExecuteSSActionCommandCopyWithImpl;
@override @useResult
$Res call({
 SlideshowAction action, bool value, int id, String type
});




}
/// @nodoc
class __$ExecuteSSActionCommandCopyWithImpl<$Res>
    implements _$ExecuteSSActionCommandCopyWith<$Res> {
  __$ExecuteSSActionCommandCopyWithImpl(this._self, this._then);

  final _ExecuteSSActionCommand _self;
  final $Res Function(_ExecuteSSActionCommand) _then;

/// Create a copy of ExecuteSSActionCommand
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? action = null,Object? value = null,Object? id = null,Object? type = null,}) {
  return _then(_ExecuteSSActionCommand(
action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as SlideshowAction,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as bool,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$LEDControlCommand {

 LEDType get led; bool get value; int get id; String get type;
/// Create a copy of LEDControlCommand
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LEDControlCommandCopyWith<LEDControlCommand> get copyWith => _$LEDControlCommandCopyWithImpl<LEDControlCommand>(this as LEDControlCommand, _$identity);

  /// Serializes this LEDControlCommand to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LEDControlCommand&&(identical(other.led, led) || other.led == led)&&(identical(other.value, value) || other.value == value)&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,led,value,id,type);

@override
String toString() {
  return 'LEDControlCommand(led: $led, value: $value, id: $id, type: $type)';
}


}

/// @nodoc
abstract mixin class $LEDControlCommandCopyWith<$Res>  {
  factory $LEDControlCommandCopyWith(LEDControlCommand value, $Res Function(LEDControlCommand) _then) = _$LEDControlCommandCopyWithImpl;
@useResult
$Res call({
 LEDType led, bool value, int id, String type
});




}
/// @nodoc
class _$LEDControlCommandCopyWithImpl<$Res>
    implements $LEDControlCommandCopyWith<$Res> {
  _$LEDControlCommandCopyWithImpl(this._self, this._then);

  final LEDControlCommand _self;
  final $Res Function(LEDControlCommand) _then;

/// Create a copy of LEDControlCommand
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? led = null,Object? value = null,Object? id = null,Object? type = null,}) {
  return _then(_self.copyWith(
led: null == led ? _self.led : led // ignore: cast_nullable_to_non_nullable
as LEDType,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as bool,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LEDControlCommand].
extension LEDControlCommandPatterns on LEDControlCommand {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LEDControlCommand value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LEDControlCommand() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LEDControlCommand value)  $default,){
final _that = this;
switch (_that) {
case _LEDControlCommand():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LEDControlCommand value)?  $default,){
final _that = this;
switch (_that) {
case _LEDControlCommand() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LEDType led,  bool value,  int id,  String type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LEDControlCommand() when $default != null:
return $default(_that.led,_that.value,_that.id,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LEDType led,  bool value,  int id,  String type)  $default,) {final _that = this;
switch (_that) {
case _LEDControlCommand():
return $default(_that.led,_that.value,_that.id,_that.type);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LEDType led,  bool value,  int id,  String type)?  $default,) {final _that = this;
switch (_that) {
case _LEDControlCommand() when $default != null:
return $default(_that.led,_that.value,_that.id,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LEDControlCommand implements LEDControlCommand {
  const _LEDControlCommand({required this.led, required this.value, required this.id, this.type = LEDControlCommand.TYPE});
  factory _LEDControlCommand.fromJson(Map<String, dynamic> json) => _$LEDControlCommandFromJson(json);

@override final  LEDType led;
@override final  bool value;
@override final  int id;
@override@JsonKey() final  String type;

/// Create a copy of LEDControlCommand
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LEDControlCommandCopyWith<_LEDControlCommand> get copyWith => __$LEDControlCommandCopyWithImpl<_LEDControlCommand>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LEDControlCommandToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LEDControlCommand&&(identical(other.led, led) || other.led == led)&&(identical(other.value, value) || other.value == value)&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,led,value,id,type);

@override
String toString() {
  return 'LEDControlCommand(led: $led, value: $value, id: $id, type: $type)';
}


}

/// @nodoc
abstract mixin class _$LEDControlCommandCopyWith<$Res> implements $LEDControlCommandCopyWith<$Res> {
  factory _$LEDControlCommandCopyWith(_LEDControlCommand value, $Res Function(_LEDControlCommand) _then) = __$LEDControlCommandCopyWithImpl;
@override @useResult
$Res call({
 LEDType led, bool value, int id, String type
});




}
/// @nodoc
class __$LEDControlCommandCopyWithImpl<$Res>
    implements _$LEDControlCommandCopyWith<$Res> {
  __$LEDControlCommandCopyWithImpl(this._self, this._then);

  final _LEDControlCommand _self;
  final $Res Function(_LEDControlCommand) _then;

/// Create a copy of LEDControlCommand
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? led = null,Object? value = null,Object? id = null,Object? type = null,}) {
  return _then(_LEDControlCommand(
led: null == led ? _self.led : led // ignore: cast_nullable_to_non_nullable
as LEDType,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as bool,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$PowerOffCommand {

 String get type; int get id;
/// Create a copy of PowerOffCommand
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PowerOffCommandCopyWith<PowerOffCommand> get copyWith => _$PowerOffCommandCopyWithImpl<PowerOffCommand>(this as PowerOffCommand, _$identity);

  /// Serializes this PowerOffCommand to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PowerOffCommand&&(identical(other.type, type) || other.type == type)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,id);

@override
String toString() {
  return 'PowerOffCommand(type: $type, id: $id)';
}


}

/// @nodoc
abstract mixin class $PowerOffCommandCopyWith<$Res>  {
  factory $PowerOffCommandCopyWith(PowerOffCommand value, $Res Function(PowerOffCommand) _then) = _$PowerOffCommandCopyWithImpl;
@useResult
$Res call({
 String type, int id
});




}
/// @nodoc
class _$PowerOffCommandCopyWithImpl<$Res>
    implements $PowerOffCommandCopyWith<$Res> {
  _$PowerOffCommandCopyWithImpl(this._self, this._then);

  final PowerOffCommand _self;
  final $Res Function(PowerOffCommand) _then;

/// Create a copy of PowerOffCommand
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? id = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PowerOffCommand].
extension PowerOffCommandPatterns on PowerOffCommand {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PowerOffCommand value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PowerOffCommand() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PowerOffCommand value)  $default,){
final _that = this;
switch (_that) {
case _PowerOffCommand():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PowerOffCommand value)?  $default,){
final _that = this;
switch (_that) {
case _PowerOffCommand() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  int id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PowerOffCommand() when $default != null:
return $default(_that.type,_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  int id)  $default,) {final _that = this;
switch (_that) {
case _PowerOffCommand():
return $default(_that.type,_that.id);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  int id)?  $default,) {final _that = this;
switch (_that) {
case _PowerOffCommand() when $default != null:
return $default(_that.type,_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PowerOffCommand implements PowerOffCommand {
  const _PowerOffCommand({this.type = PowerOffCommand.TYPE, required this.id});
  factory _PowerOffCommand.fromJson(Map<String, dynamic> json) => _$PowerOffCommandFromJson(json);

@override@JsonKey() final  String type;
@override final  int id;

/// Create a copy of PowerOffCommand
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PowerOffCommandCopyWith<_PowerOffCommand> get copyWith => __$PowerOffCommandCopyWithImpl<_PowerOffCommand>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PowerOffCommandToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PowerOffCommand&&(identical(other.type, type) || other.type == type)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,id);

@override
String toString() {
  return 'PowerOffCommand(type: $type, id: $id)';
}


}

/// @nodoc
abstract mixin class _$PowerOffCommandCopyWith<$Res> implements $PowerOffCommandCopyWith<$Res> {
  factory _$PowerOffCommandCopyWith(_PowerOffCommand value, $Res Function(_PowerOffCommand) _then) = __$PowerOffCommandCopyWithImpl;
@override @useResult
$Res call({
 String type, int id
});




}
/// @nodoc
class __$PowerOffCommandCopyWithImpl<$Res>
    implements _$PowerOffCommandCopyWith<$Res> {
  __$PowerOffCommandCopyWithImpl(this._self, this._then);

  final _PowerOffCommand _self;
  final $Res Function(_PowerOffCommand) _then;

/// Create a copy of PowerOffCommand
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? id = null,}) {
  return _then(_PowerOffCommand(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$RestartAppCommand {

 String get type; int get id;
/// Create a copy of RestartAppCommand
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RestartAppCommandCopyWith<RestartAppCommand> get copyWith => _$RestartAppCommandCopyWithImpl<RestartAppCommand>(this as RestartAppCommand, _$identity);

  /// Serializes this RestartAppCommand to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RestartAppCommand&&(identical(other.type, type) || other.type == type)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,id);

@override
String toString() {
  return 'RestartAppCommand(type: $type, id: $id)';
}


}

/// @nodoc
abstract mixin class $RestartAppCommandCopyWith<$Res>  {
  factory $RestartAppCommandCopyWith(RestartAppCommand value, $Res Function(RestartAppCommand) _then) = _$RestartAppCommandCopyWithImpl;
@useResult
$Res call({
 String type, int id
});




}
/// @nodoc
class _$RestartAppCommandCopyWithImpl<$Res>
    implements $RestartAppCommandCopyWith<$Res> {
  _$RestartAppCommandCopyWithImpl(this._self, this._then);

  final RestartAppCommand _self;
  final $Res Function(RestartAppCommand) _then;

/// Create a copy of RestartAppCommand
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? id = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [RestartAppCommand].
extension RestartAppCommandPatterns on RestartAppCommand {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RestartAppCommand value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RestartAppCommand() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RestartAppCommand value)  $default,){
final _that = this;
switch (_that) {
case _RestartAppCommand():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RestartAppCommand value)?  $default,){
final _that = this;
switch (_that) {
case _RestartAppCommand() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  int id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RestartAppCommand() when $default != null:
return $default(_that.type,_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  int id)  $default,) {final _that = this;
switch (_that) {
case _RestartAppCommand():
return $default(_that.type,_that.id);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  int id)?  $default,) {final _that = this;
switch (_that) {
case _RestartAppCommand() when $default != null:
return $default(_that.type,_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RestartAppCommand implements RestartAppCommand {
  const _RestartAppCommand({this.type = RestartAppCommand.TYPE, required this.id});
  factory _RestartAppCommand.fromJson(Map<String, dynamic> json) => _$RestartAppCommandFromJson(json);

@override@JsonKey() final  String type;
@override final  int id;

/// Create a copy of RestartAppCommand
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RestartAppCommandCopyWith<_RestartAppCommand> get copyWith => __$RestartAppCommandCopyWithImpl<_RestartAppCommand>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RestartAppCommandToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RestartAppCommand&&(identical(other.type, type) || other.type == type)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,id);

@override
String toString() {
  return 'RestartAppCommand(type: $type, id: $id)';
}


}

/// @nodoc
abstract mixin class _$RestartAppCommandCopyWith<$Res> implements $RestartAppCommandCopyWith<$Res> {
  factory _$RestartAppCommandCopyWith(_RestartAppCommand value, $Res Function(_RestartAppCommand) _then) = __$RestartAppCommandCopyWithImpl;
@override @useResult
$Res call({
 String type, int id
});




}
/// @nodoc
class __$RestartAppCommandCopyWithImpl<$Res>
    implements _$RestartAppCommandCopyWith<$Res> {
  __$RestartAppCommandCopyWithImpl(this._self, this._then);

  final _RestartAppCommand _self;
  final $Res Function(_RestartAppCommand) _then;

/// Create a copy of RestartAppCommand
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? id = null,}) {
  return _then(_RestartAppCommand(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
