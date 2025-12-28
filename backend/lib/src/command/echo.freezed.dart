// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'echo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EchoCommand {

 int get id; String? get text; String get type;
/// Create a copy of EchoCommand
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EchoCommandCopyWith<EchoCommand> get copyWith => _$EchoCommandCopyWithImpl<EchoCommand>(this as EchoCommand, _$identity);

  /// Serializes this EchoCommand to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EchoCommand&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,type);

@override
String toString() {
  return 'EchoCommand(id: $id, text: $text, type: $type)';
}


}

/// @nodoc
abstract mixin class $EchoCommandCopyWith<$Res>  {
  factory $EchoCommandCopyWith(EchoCommand value, $Res Function(EchoCommand) _then) = _$EchoCommandCopyWithImpl;
@useResult
$Res call({
 int id, String? text, String type
});




}
/// @nodoc
class _$EchoCommandCopyWithImpl<$Res>
    implements $EchoCommandCopyWith<$Res> {
  _$EchoCommandCopyWithImpl(this._self, this._then);

  final EchoCommand _self;
  final $Res Function(EchoCommand) _then;

/// Create a copy of EchoCommand
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? text = freezed,Object? type = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EchoCommand].
extension EchoCommandPatterns on EchoCommand {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EchoCommand value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EchoCommand() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EchoCommand value)  $default,){
final _that = this;
switch (_that) {
case _EchoCommand():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EchoCommand value)?  $default,){
final _that = this;
switch (_that) {
case _EchoCommand() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String? text,  String type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EchoCommand() when $default != null:
return $default(_that.id,_that.text,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String? text,  String type)  $default,) {final _that = this;
switch (_that) {
case _EchoCommand():
return $default(_that.id,_that.text,_that.type);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String? text,  String type)?  $default,) {final _that = this;
switch (_that) {
case _EchoCommand() when $default != null:
return $default(_that.id,_that.text,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EchoCommand implements EchoCommand {
  const _EchoCommand({required this.id, this.text, this.type = EchoCommand.TYPE});
  factory _EchoCommand.fromJson(Map<String, dynamic> json) => _$EchoCommandFromJson(json);

@override final  int id;
@override final  String? text;
@override@JsonKey() final  String type;

/// Create a copy of EchoCommand
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EchoCommandCopyWith<_EchoCommand> get copyWith => __$EchoCommandCopyWithImpl<_EchoCommand>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EchoCommandToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EchoCommand&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,type);

@override
String toString() {
  return 'EchoCommand(id: $id, text: $text, type: $type)';
}


}

/// @nodoc
abstract mixin class _$EchoCommandCopyWith<$Res> implements $EchoCommandCopyWith<$Res> {
  factory _$EchoCommandCopyWith(_EchoCommand value, $Res Function(_EchoCommand) _then) = __$EchoCommandCopyWithImpl;
@override @useResult
$Res call({
 int id, String? text, String type
});




}
/// @nodoc
class __$EchoCommandCopyWithImpl<$Res>
    implements _$EchoCommandCopyWith<$Res> {
  __$EchoCommandCopyWithImpl(this._self, this._then);

  final _EchoCommand _self;
  final $Res Function(_EchoCommand) _then;

/// Create a copy of EchoCommand
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? text = freezed,Object? type = null,}) {
  return _then(_EchoCommand(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$EchoCommandResult {

 int get id; String? get resultText;
/// Create a copy of EchoCommandResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EchoCommandResultCopyWith<EchoCommandResult> get copyWith => _$EchoCommandResultCopyWithImpl<EchoCommandResult>(this as EchoCommandResult, _$identity);

  /// Serializes this EchoCommandResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EchoCommandResult&&(identical(other.id, id) || other.id == id)&&(identical(other.resultText, resultText) || other.resultText == resultText));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,resultText);

@override
String toString() {
  return 'EchoCommandResult(id: $id, resultText: $resultText)';
}


}

/// @nodoc
abstract mixin class $EchoCommandResultCopyWith<$Res>  {
  factory $EchoCommandResultCopyWith(EchoCommandResult value, $Res Function(EchoCommandResult) _then) = _$EchoCommandResultCopyWithImpl;
@useResult
$Res call({
 int id, String? resultText
});




}
/// @nodoc
class _$EchoCommandResultCopyWithImpl<$Res>
    implements $EchoCommandResultCopyWith<$Res> {
  _$EchoCommandResultCopyWithImpl(this._self, this._then);

  final EchoCommandResult _self;
  final $Res Function(EchoCommandResult) _then;

/// Create a copy of EchoCommandResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? resultText = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,resultText: freezed == resultText ? _self.resultText : resultText // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EchoCommandResult].
extension EchoCommandResultPatterns on EchoCommandResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EchoCommandResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EchoCommandResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EchoCommandResult value)  $default,){
final _that = this;
switch (_that) {
case _EchoCommandResult():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EchoCommandResult value)?  $default,){
final _that = this;
switch (_that) {
case _EchoCommandResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String? resultText)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EchoCommandResult() when $default != null:
return $default(_that.id,_that.resultText);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String? resultText)  $default,) {final _that = this;
switch (_that) {
case _EchoCommandResult():
return $default(_that.id,_that.resultText);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String? resultText)?  $default,) {final _that = this;
switch (_that) {
case _EchoCommandResult() when $default != null:
return $default(_that.id,_that.resultText);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EchoCommandResult implements EchoCommandResult {
  const _EchoCommandResult({required this.id, this.resultText});
  factory _EchoCommandResult.fromJson(Map<String, dynamic> json) => _$EchoCommandResultFromJson(json);

@override final  int id;
@override final  String? resultText;

/// Create a copy of EchoCommandResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EchoCommandResultCopyWith<_EchoCommandResult> get copyWith => __$EchoCommandResultCopyWithImpl<_EchoCommandResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EchoCommandResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EchoCommandResult&&(identical(other.id, id) || other.id == id)&&(identical(other.resultText, resultText) || other.resultText == resultText));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,resultText);

@override
String toString() {
  return 'EchoCommandResult(id: $id, resultText: $resultText)';
}


}

/// @nodoc
abstract mixin class _$EchoCommandResultCopyWith<$Res> implements $EchoCommandResultCopyWith<$Res> {
  factory _$EchoCommandResultCopyWith(_EchoCommandResult value, $Res Function(_EchoCommandResult) _then) = __$EchoCommandResultCopyWithImpl;
@override @useResult
$Res call({
 int id, String? resultText
});




}
/// @nodoc
class __$EchoCommandResultCopyWithImpl<$Res>
    implements _$EchoCommandResultCopyWith<$Res> {
  __$EchoCommandResultCopyWithImpl(this._self, this._then);

  final _EchoCommandResult _self;
  final $Res Function(_EchoCommandResult) _then;

/// Create a copy of EchoCommandResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? resultText = freezed,}) {
  return _then(_EchoCommandResult(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,resultText: freezed == resultText ? _self.resultText : resultText // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
