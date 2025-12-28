// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'frontend_commands.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UpdateFrontendStateCommand {

 String get type; int get id; bool? get isPaused; bool? get isMenu;
/// Create a copy of UpdateFrontendStateCommand
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateFrontendStateCommandCopyWith<UpdateFrontendStateCommand> get copyWith => _$UpdateFrontendStateCommandCopyWithImpl<UpdateFrontendStateCommand>(this as UpdateFrontendStateCommand, _$identity);

  /// Serializes this UpdateFrontendStateCommand to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateFrontendStateCommand&&(identical(other.type, type) || other.type == type)&&(identical(other.id, id) || other.id == id)&&(identical(other.isPaused, isPaused) || other.isPaused == isPaused)&&(identical(other.isMenu, isMenu) || other.isMenu == isMenu));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,id,isPaused,isMenu);

@override
String toString() {
  return 'UpdateFrontendStateCommand(type: $type, id: $id, isPaused: $isPaused, isMenu: $isMenu)';
}


}

/// @nodoc
abstract mixin class $UpdateFrontendStateCommandCopyWith<$Res>  {
  factory $UpdateFrontendStateCommandCopyWith(UpdateFrontendStateCommand value, $Res Function(UpdateFrontendStateCommand) _then) = _$UpdateFrontendStateCommandCopyWithImpl;
@useResult
$Res call({
 String type, int id, bool? isPaused, bool? isMenu
});




}
/// @nodoc
class _$UpdateFrontendStateCommandCopyWithImpl<$Res>
    implements $UpdateFrontendStateCommandCopyWith<$Res> {
  _$UpdateFrontendStateCommandCopyWithImpl(this._self, this._then);

  final UpdateFrontendStateCommand _self;
  final $Res Function(UpdateFrontendStateCommand) _then;

/// Create a copy of UpdateFrontendStateCommand
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? id = null,Object? isPaused = freezed,Object? isMenu = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,isPaused: freezed == isPaused ? _self.isPaused : isPaused // ignore: cast_nullable_to_non_nullable
as bool?,isMenu: freezed == isMenu ? _self.isMenu : isMenu // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateFrontendStateCommand].
extension UpdateFrontendStateCommandPatterns on UpdateFrontendStateCommand {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateFrontendStateCommand value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateFrontendStateCommand() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateFrontendStateCommand value)  $default,){
final _that = this;
switch (_that) {
case _UpdateFrontendStateCommand():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateFrontendStateCommand value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateFrontendStateCommand() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  int id,  bool? isPaused,  bool? isMenu)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateFrontendStateCommand() when $default != null:
return $default(_that.type,_that.id,_that.isPaused,_that.isMenu);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  int id,  bool? isPaused,  bool? isMenu)  $default,) {final _that = this;
switch (_that) {
case _UpdateFrontendStateCommand():
return $default(_that.type,_that.id,_that.isPaused,_that.isMenu);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  int id,  bool? isPaused,  bool? isMenu)?  $default,) {final _that = this;
switch (_that) {
case _UpdateFrontendStateCommand() when $default != null:
return $default(_that.type,_that.id,_that.isPaused,_that.isMenu);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateFrontendStateCommand implements UpdateFrontendStateCommand {
  const _UpdateFrontendStateCommand({this.type = UpdateFrontendStateCommand.TYPE, required this.id, this.isPaused, this.isMenu});
  factory _UpdateFrontendStateCommand.fromJson(Map<String, dynamic> json) => _$UpdateFrontendStateCommandFromJson(json);

@override@JsonKey() final  String type;
@override final  int id;
@override final  bool? isPaused;
@override final  bool? isMenu;

/// Create a copy of UpdateFrontendStateCommand
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateFrontendStateCommandCopyWith<_UpdateFrontendStateCommand> get copyWith => __$UpdateFrontendStateCommandCopyWithImpl<_UpdateFrontendStateCommand>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateFrontendStateCommandToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateFrontendStateCommand&&(identical(other.type, type) || other.type == type)&&(identical(other.id, id) || other.id == id)&&(identical(other.isPaused, isPaused) || other.isPaused == isPaused)&&(identical(other.isMenu, isMenu) || other.isMenu == isMenu));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,id,isPaused,isMenu);

@override
String toString() {
  return 'UpdateFrontendStateCommand(type: $type, id: $id, isPaused: $isPaused, isMenu: $isMenu)';
}


}

/// @nodoc
abstract mixin class _$UpdateFrontendStateCommandCopyWith<$Res> implements $UpdateFrontendStateCommandCopyWith<$Res> {
  factory _$UpdateFrontendStateCommandCopyWith(_UpdateFrontendStateCommand value, $Res Function(_UpdateFrontendStateCommand) _then) = __$UpdateFrontendStateCommandCopyWithImpl;
@override @useResult
$Res call({
 String type, int id, bool? isPaused, bool? isMenu
});




}
/// @nodoc
class __$UpdateFrontendStateCommandCopyWithImpl<$Res>
    implements _$UpdateFrontendStateCommandCopyWith<$Res> {
  __$UpdateFrontendStateCommandCopyWithImpl(this._self, this._then);

  final _UpdateFrontendStateCommand _self;
  final $Res Function(_UpdateFrontendStateCommand) _then;

/// Create a copy of UpdateFrontendStateCommand
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? id = null,Object? isPaused = freezed,Object? isMenu = freezed,}) {
  return _then(_UpdateFrontendStateCommand(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,isPaused: freezed == isPaused ? _self.isPaused : isPaused // ignore: cast_nullable_to_non_nullable
as bool?,isMenu: freezed == isMenu ? _self.isMenu : isMenu // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
