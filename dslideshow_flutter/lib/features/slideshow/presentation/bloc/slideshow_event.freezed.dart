// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'slideshow_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SlideshowEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SlideshowEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SlideshowEvent()';
}


}

/// @nodoc
class $SlideshowEventCopyWith<$Res>  {
$SlideshowEventCopyWith(SlideshowEvent _, $Res Function(SlideshowEvent) __);
}


/// Adds pattern-matching-related methods to [SlideshowEvent].
extension SlideshowEventPatterns on SlideshowEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SlideshowEvent value)?  $default,{TResult Function( SlideshowChageItemEvent value)?  changeItem,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SlideshowEvent() when $default != null:
return $default(_that);case SlideshowChageItemEvent() when changeItem != null:
return changeItem(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SlideshowEvent value)  $default,{required TResult Function( SlideshowChageItemEvent value)  changeItem,}){
final _that = this;
switch (_that) {
case _SlideshowEvent():
return $default(_that);case SlideshowChageItemEvent():
return changeItem(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SlideshowEvent value)?  $default,{TResult? Function( SlideshowChageItemEvent value)?  changeItem,}){
final _that = this;
switch (_that) {
case _SlideshowEvent() when $default != null:
return $default(_that);case SlideshowChageItemEvent() when changeItem != null:
return changeItem(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function()?  $default,{TResult Function()?  changeItem,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SlideshowEvent() when $default != null:
return $default();case SlideshowChageItemEvent() when changeItem != null:
return changeItem();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function()  $default,{required TResult Function()  changeItem,}) {final _that = this;
switch (_that) {
case _SlideshowEvent():
return $default();case SlideshowChageItemEvent():
return changeItem();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function()?  $default,{TResult? Function()?  changeItem,}) {final _that = this;
switch (_that) {
case _SlideshowEvent() when $default != null:
return $default();case SlideshowChageItemEvent() when changeItem != null:
return changeItem();case _:
  return null;

}
}

}

/// @nodoc


class _SlideshowEvent implements SlideshowEvent {
  const _SlideshowEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SlideshowEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SlideshowEvent()';
}


}




/// @nodoc


class SlideshowChageItemEvent implements SlideshowEvent {
  const SlideshowChageItemEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SlideshowChageItemEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SlideshowEvent.changeItem()';
}


}




// dart format on
