// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'button_hint_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ButtonHintBinding {

 ButtonHintAction get action; bool get enabled;
/// Create a copy of ButtonHintBinding
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ButtonHintBindingCopyWith<ButtonHintBinding> get copyWith => _$ButtonHintBindingCopyWithImpl<ButtonHintBinding>(this as ButtonHintBinding, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ButtonHintBinding;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ButtonHintBinding&&(identical(other.action, _this.action) || other.action == _this.action)&&(identical(other.enabled, _this.enabled) || other.enabled == _this.enabled));
}


@override
int get hashCode {
  final _this = this as ButtonHintBinding;
  return Object.hash(runtimeType,_this.action,_this.enabled);
}

@override
String toString() {
  final _this = this as ButtonHintBinding;
  return 'ButtonHintBinding(action: ${_this.action}, enabled: ${_this.enabled})';
}


}

/// @nodoc
abstract mixin class $ButtonHintBindingCopyWith<$Res>  {
  factory $ButtonHintBindingCopyWith(ButtonHintBinding value, $Res Function(ButtonHintBinding) _then) = _$ButtonHintBindingCopyWithImpl;
@useResult
$Res call({
 ButtonHintAction action, bool enabled
});




}
/// @nodoc
class _$ButtonHintBindingCopyWithImpl<$Res>
    implements $ButtonHintBindingCopyWith<$Res> {
  _$ButtonHintBindingCopyWithImpl(this._self, this._then);

  final ButtonHintBinding _self;
  final $Res Function(ButtonHintBinding) _then;

/// Create a copy of ButtonHintBinding
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? action = null,Object? enabled = null,}) {
  return _then(ButtonHintBinding(
action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as ButtonHintAction,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ButtonHintBinding].
extension ButtonHintBindingPatterns on ButtonHintBinding {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ButtonHintBinding value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ButtonHintBinding() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ButtonHintBinding value)  $default,){
final _that = this;
switch (_that) {
case _ButtonHintBinding():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ButtonHintBinding value)?  $default,){
final _that = this;
switch (_that) {
case _ButtonHintBinding() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ButtonHintAction action,  bool enabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ButtonHintBinding() when $default != null:
return $default(_that.action,_that.enabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ButtonHintAction action,  bool enabled)  $default,) {final _that = this;
switch (_that) {
case _ButtonHintBinding():
return $default(_that.action,_that.enabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ButtonHintAction action,  bool enabled)?  $default,) {final _that = this;
switch (_that) {
case _ButtonHintBinding() when $default != null:
return $default(_that.action,_that.enabled);case _:
  return null;

}
}

}

/// @nodoc


class _ButtonHintBinding implements ButtonHintBinding {
  const _ButtonHintBinding({required this.action, this.enabled = true});
  

@override final  ButtonHintAction action;
@override@JsonKey() final  bool enabled;

/// Create a copy of ButtonHintBinding
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ButtonHintBindingCopyWith<_ButtonHintBinding> get copyWith => __$ButtonHintBindingCopyWithImpl<_ButtonHintBinding>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ButtonHintBinding&&(identical(other.action, action) || other.action == action)&&(identical(other.enabled, enabled) || other.enabled == enabled));
}


@override
int get hashCode {
    return Object.hash(runtimeType,action,enabled);
}

@override
String toString() {
    return 'ButtonHintBinding(action: $action, enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class _$ButtonHintBindingCopyWith<$Res> implements $ButtonHintBindingCopyWith<$Res> {
  factory _$ButtonHintBindingCopyWith(_ButtonHintBinding value, $Res Function(_ButtonHintBinding) _then) = __$ButtonHintBindingCopyWithImpl;
@override @useResult
$Res call({
 ButtonHintAction action, bool enabled
});




}
/// @nodoc
class __$ButtonHintBindingCopyWithImpl<$Res>
    implements _$ButtonHintBindingCopyWith<$Res> {
  __$ButtonHintBindingCopyWithImpl(this._self, this._then);

  final _ButtonHintBinding _self;
  final $Res Function(_ButtonHintBinding) _then;

/// Create a copy of ButtonHintBinding
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? action = null,Object? enabled = null,}) {
  return _then(_ButtonHintBinding(
action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as ButtonHintAction,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
