// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'buttons_hint_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ButtonsHintEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ButtonsHintEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ButtonsHintEvent()';
}


}

/// @nodoc
class $ButtonsHintEventCopyWith<$Res>  {
$ButtonsHintEventCopyWith(ButtonsHintEvent _, $Res Function(ButtonsHintEvent) __);
}


/// Adds pattern-matching-related methods to [ButtonsHintEvent].
extension ButtonsHintEventPatterns on ButtonsHintEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ButtonsHintShowEvent value)?  show,TResult Function( ButtonsHintButtonChanged value)?  buttonChanged,TResult Function( ButtonsHintClearPress value)?  clearPress,TResult Function( ButtonsHintUpdateButtonsEvent value)?  updateButtons,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ButtonsHintShowEvent() when show != null:
return show(_that);case ButtonsHintButtonChanged() when buttonChanged != null:
return buttonChanged(_that);case ButtonsHintClearPress() when clearPress != null:
return clearPress(_that);case ButtonsHintUpdateButtonsEvent() when updateButtons != null:
return updateButtons(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ButtonsHintShowEvent value)  show,required TResult Function( ButtonsHintButtonChanged value)  buttonChanged,required TResult Function( ButtonsHintClearPress value)  clearPress,required TResult Function( ButtonsHintUpdateButtonsEvent value)  updateButtons,}){
final _that = this;
switch (_that) {
case ButtonsHintShowEvent():
return show(_that);case ButtonsHintButtonChanged():
return buttonChanged(_that);case ButtonsHintClearPress():
return clearPress(_that);case ButtonsHintUpdateButtonsEvent():
return updateButtons(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ButtonsHintShowEvent value)?  show,TResult? Function( ButtonsHintButtonChanged value)?  buttonChanged,TResult? Function( ButtonsHintClearPress value)?  clearPress,TResult? Function( ButtonsHintUpdateButtonsEvent value)?  updateButtons,}){
final _that = this;
switch (_that) {
case ButtonsHintShowEvent() when show != null:
return show(_that);case ButtonsHintButtonChanged() when buttonChanged != null:
return buttonChanged(_that);case ButtonsHintClearPress() when clearPress != null:
return clearPress(_that);case ButtonsHintUpdateButtonsEvent() when updateButtons != null:
return updateButtons(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( bool isShow)?  show,TResult Function( ButtonType button,  ButtonEventType type)?  buttonChanged,TResult Function( ButtonType button)?  clearPress,TResult Function()?  updateButtons,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ButtonsHintShowEvent() when show != null:
return show(_that.isShow);case ButtonsHintButtonChanged() when buttonChanged != null:
return buttonChanged(_that.button,_that.type);case ButtonsHintClearPress() when clearPress != null:
return clearPress(_that.button);case ButtonsHintUpdateButtonsEvent() when updateButtons != null:
return updateButtons();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( bool isShow)  show,required TResult Function( ButtonType button,  ButtonEventType type)  buttonChanged,required TResult Function( ButtonType button)  clearPress,required TResult Function()  updateButtons,}) {final _that = this;
switch (_that) {
case ButtonsHintShowEvent():
return show(_that.isShow);case ButtonsHintButtonChanged():
return buttonChanged(_that.button,_that.type);case ButtonsHintClearPress():
return clearPress(_that.button);case ButtonsHintUpdateButtonsEvent():
return updateButtons();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( bool isShow)?  show,TResult? Function( ButtonType button,  ButtonEventType type)?  buttonChanged,TResult? Function( ButtonType button)?  clearPress,TResult? Function()?  updateButtons,}) {final _that = this;
switch (_that) {
case ButtonsHintShowEvent() when show != null:
return show(_that.isShow);case ButtonsHintButtonChanged() when buttonChanged != null:
return buttonChanged(_that.button,_that.type);case ButtonsHintClearPress() when clearPress != null:
return clearPress(_that.button);case ButtonsHintUpdateButtonsEvent() when updateButtons != null:
return updateButtons();case _:
  return null;

}
}

}

/// @nodoc


class ButtonsHintShowEvent implements ButtonsHintEvent {
  const ButtonsHintShowEvent({required this.isShow});
  

 final  bool isShow;

/// Create a copy of ButtonsHintEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ButtonsHintShowEventCopyWith<ButtonsHintShowEvent> get copyWith => _$ButtonsHintShowEventCopyWithImpl<ButtonsHintShowEvent>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ButtonsHintShowEvent&&(identical(other.isShow, isShow) || other.isShow == isShow));
}


@override
int get hashCode {
    return Object.hash(runtimeType,isShow);
}

@override
String toString() {
    return 'ButtonsHintEvent.show(isShow: $isShow)';
}


}

/// @nodoc
abstract mixin class $ButtonsHintShowEventCopyWith<$Res> implements $ButtonsHintEventCopyWith<$Res> {
  factory $ButtonsHintShowEventCopyWith(ButtonsHintShowEvent value, $Res Function(ButtonsHintShowEvent) _then) = _$ButtonsHintShowEventCopyWithImpl;
@useResult
$Res call({
 bool isShow
});




}
/// @nodoc
class _$ButtonsHintShowEventCopyWithImpl<$Res>
    implements $ButtonsHintShowEventCopyWith<$Res> {
  _$ButtonsHintShowEventCopyWithImpl(this._self, this._then);

  final ButtonsHintShowEvent _self;
  final $Res Function(ButtonsHintShowEvent) _then;

/// Create a copy of ButtonsHintEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isShow = null,}) {
  return _then(ButtonsHintShowEvent(
isShow: null == isShow ? _self.isShow : isShow // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class ButtonsHintButtonChanged implements ButtonsHintEvent {
  const ButtonsHintButtonChanged({required this.button, required this.type});
  

 final  ButtonType button;
 final  ButtonEventType type;

/// Create a copy of ButtonsHintEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ButtonsHintButtonChangedCopyWith<ButtonsHintButtonChanged> get copyWith => _$ButtonsHintButtonChangedCopyWithImpl<ButtonsHintButtonChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ButtonsHintButtonChanged&&(identical(other.button, button) || other.button == button)&&(identical(other.type, type) || other.type == type));
}


@override
int get hashCode {
    return Object.hash(runtimeType,button,type);
}

@override
String toString() {
    return 'ButtonsHintEvent.buttonChanged(button: $button, type: $type)';
}


}

/// @nodoc
abstract mixin class $ButtonsHintButtonChangedCopyWith<$Res> implements $ButtonsHintEventCopyWith<$Res> {
  factory $ButtonsHintButtonChangedCopyWith(ButtonsHintButtonChanged value, $Res Function(ButtonsHintButtonChanged) _then) = _$ButtonsHintButtonChangedCopyWithImpl;
@useResult
$Res call({
 ButtonType button, ButtonEventType type
});




}
/// @nodoc
class _$ButtonsHintButtonChangedCopyWithImpl<$Res>
    implements $ButtonsHintButtonChangedCopyWith<$Res> {
  _$ButtonsHintButtonChangedCopyWithImpl(this._self, this._then);

  final ButtonsHintButtonChanged _self;
  final $Res Function(ButtonsHintButtonChanged) _then;

/// Create a copy of ButtonsHintEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? button = null,Object? type = null,}) {
  return _then(ButtonsHintButtonChanged(
button: null == button ? _self.button : button // ignore: cast_nullable_to_non_nullable
as ButtonType,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ButtonEventType,
  ));
}


}

/// @nodoc


class ButtonsHintClearPress implements ButtonsHintEvent {
  const ButtonsHintClearPress({required this.button});
  

 final  ButtonType button;

/// Create a copy of ButtonsHintEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ButtonsHintClearPressCopyWith<ButtonsHintClearPress> get copyWith => _$ButtonsHintClearPressCopyWithImpl<ButtonsHintClearPress>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ButtonsHintClearPress&&(identical(other.button, button) || other.button == button));
}


@override
int get hashCode {
    return Object.hash(runtimeType,button);
}

@override
String toString() {
    return 'ButtonsHintEvent.clearPress(button: $button)';
}


}

/// @nodoc
abstract mixin class $ButtonsHintClearPressCopyWith<$Res> implements $ButtonsHintEventCopyWith<$Res> {
  factory $ButtonsHintClearPressCopyWith(ButtonsHintClearPress value, $Res Function(ButtonsHintClearPress) _then) = _$ButtonsHintClearPressCopyWithImpl;
@useResult
$Res call({
 ButtonType button
});




}
/// @nodoc
class _$ButtonsHintClearPressCopyWithImpl<$Res>
    implements $ButtonsHintClearPressCopyWith<$Res> {
  _$ButtonsHintClearPressCopyWithImpl(this._self, this._then);

  final ButtonsHintClearPress _self;
  final $Res Function(ButtonsHintClearPress) _then;

/// Create a copy of ButtonsHintEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? button = null,}) {
  return _then(ButtonsHintClearPress(
button: null == button ? _self.button : button // ignore: cast_nullable_to_non_nullable
as ButtonType,
  ));
}


}

/// @nodoc


class ButtonsHintUpdateButtonsEvent implements ButtonsHintEvent {
  const ButtonsHintUpdateButtonsEvent();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ButtonsHintUpdateButtonsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ButtonsHintEvent.updateButtons()';
}


}




/// @nodoc
mixin _$ButtonsHintState {

 bool get isShow; Color get normalColor; Color get pushColor; IconData get button0Icon; bool get button0isPush; IconData get button1Icon; bool get button1isPush; IconData get button2Icon; bool get button2isPush; IconData get button3Icon; bool get button3isPush;
/// Create a copy of ButtonsHintState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ButtonsHintStateCopyWith<ButtonsHintState> get copyWith => _$ButtonsHintStateCopyWithImpl<ButtonsHintState>(this as ButtonsHintState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ButtonsHintState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ButtonsHintState&&(identical(other.isShow, _this.isShow) || other.isShow == _this.isShow)&&(identical(other.normalColor, _this.normalColor) || other.normalColor == _this.normalColor)&&(identical(other.pushColor, _this.pushColor) || other.pushColor == _this.pushColor)&&(identical(other.button0Icon, _this.button0Icon) || other.button0Icon == _this.button0Icon)&&(identical(other.button0isPush, _this.button0isPush) || other.button0isPush == _this.button0isPush)&&(identical(other.button1Icon, _this.button1Icon) || other.button1Icon == _this.button1Icon)&&(identical(other.button1isPush, _this.button1isPush) || other.button1isPush == _this.button1isPush)&&(identical(other.button2Icon, _this.button2Icon) || other.button2Icon == _this.button2Icon)&&(identical(other.button2isPush, _this.button2isPush) || other.button2isPush == _this.button2isPush)&&(identical(other.button3Icon, _this.button3Icon) || other.button3Icon == _this.button3Icon)&&(identical(other.button3isPush, _this.button3isPush) || other.button3isPush == _this.button3isPush));
}


@override
int get hashCode {
  final _this = this as ButtonsHintState;
  return Object.hash(runtimeType,_this.isShow,_this.normalColor,_this.pushColor,_this.button0Icon,_this.button0isPush,_this.button1Icon,_this.button1isPush,_this.button2Icon,_this.button2isPush,_this.button3Icon,_this.button3isPush);
}

@override
String toString() {
  final _this = this as ButtonsHintState;
  return 'ButtonsHintState(isShow: ${_this.isShow}, normalColor: ${_this.normalColor}, pushColor: ${_this.pushColor}, button0Icon: ${_this.button0Icon}, button0isPush: ${_this.button0isPush}, button1Icon: ${_this.button1Icon}, button1isPush: ${_this.button1isPush}, button2Icon: ${_this.button2Icon}, button2isPush: ${_this.button2isPush}, button3Icon: ${_this.button3Icon}, button3isPush: ${_this.button3isPush})';
}


}

/// @nodoc
abstract mixin class $ButtonsHintStateCopyWith<$Res>  {
  factory $ButtonsHintStateCopyWith(ButtonsHintState value, $Res Function(ButtonsHintState) _then) = _$ButtonsHintStateCopyWithImpl;
@useResult
$Res call({
 bool isShow, Color normalColor, Color pushColor, IconData button0Icon, bool button0isPush, IconData button1Icon, bool button1isPush, IconData button2Icon, bool button2isPush, IconData button3Icon, bool button3isPush
});




}
/// @nodoc
class _$ButtonsHintStateCopyWithImpl<$Res>
    implements $ButtonsHintStateCopyWith<$Res> {
  _$ButtonsHintStateCopyWithImpl(this._self, this._then);

  final ButtonsHintState _self;
  final $Res Function(ButtonsHintState) _then;

/// Create a copy of ButtonsHintState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isShow = null,Object? normalColor = null,Object? pushColor = null,Object? button0Icon = null,Object? button0isPush = null,Object? button1Icon = null,Object? button1isPush = null,Object? button2Icon = null,Object? button2isPush = null,Object? button3Icon = null,Object? button3isPush = null,}) {
  return _then(ButtonsHintState.display(
isShow: null == isShow ? _self.isShow : isShow // ignore: cast_nullable_to_non_nullable
as bool,normalColor: null == normalColor ? _self.normalColor : normalColor // ignore: cast_nullable_to_non_nullable
as Color,pushColor: null == pushColor ? _self.pushColor : pushColor // ignore: cast_nullable_to_non_nullable
as Color,button0Icon: null == button0Icon ? _self.button0Icon : button0Icon // ignore: cast_nullable_to_non_nullable
as IconData,button0isPush: null == button0isPush ? _self.button0isPush : button0isPush // ignore: cast_nullable_to_non_nullable
as bool,button1Icon: null == button1Icon ? _self.button1Icon : button1Icon // ignore: cast_nullable_to_non_nullable
as IconData,button1isPush: null == button1isPush ? _self.button1isPush : button1isPush // ignore: cast_nullable_to_non_nullable
as bool,button2Icon: null == button2Icon ? _self.button2Icon : button2Icon // ignore: cast_nullable_to_non_nullable
as IconData,button2isPush: null == button2isPush ? _self.button2isPush : button2isPush // ignore: cast_nullable_to_non_nullable
as bool,button3Icon: null == button3Icon ? _self.button3Icon : button3Icon // ignore: cast_nullable_to_non_nullable
as IconData,button3isPush: null == button3isPush ? _self.button3isPush : button3isPush // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ButtonsHintState].
extension ButtonsHintStatePatterns on ButtonsHintState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ButtonsHintDisplayState value)?  display,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ButtonsHintDisplayState() when display != null:
return display(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ButtonsHintDisplayState value)  display,}){
final _that = this;
switch (_that) {
case ButtonsHintDisplayState():
return display(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ButtonsHintDisplayState value)?  display,}){
final _that = this;
switch (_that) {
case ButtonsHintDisplayState() when display != null:
return display(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( bool isShow,  Color normalColor,  Color pushColor,  IconData button0Icon,  bool button0isPush,  IconData button1Icon,  bool button1isPush,  IconData button2Icon,  bool button2isPush,  IconData button3Icon,  bool button3isPush)?  display,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ButtonsHintDisplayState() when display != null:
return display(_that.isShow,_that.normalColor,_that.pushColor,_that.button0Icon,_that.button0isPush,_that.button1Icon,_that.button1isPush,_that.button2Icon,_that.button2isPush,_that.button3Icon,_that.button3isPush);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( bool isShow,  Color normalColor,  Color pushColor,  IconData button0Icon,  bool button0isPush,  IconData button1Icon,  bool button1isPush,  IconData button2Icon,  bool button2isPush,  IconData button3Icon,  bool button3isPush)  display,}) {final _that = this;
switch (_that) {
case ButtonsHintDisplayState():
return display(_that.isShow,_that.normalColor,_that.pushColor,_that.button0Icon,_that.button0isPush,_that.button1Icon,_that.button1isPush,_that.button2Icon,_that.button2isPush,_that.button3Icon,_that.button3isPush);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( bool isShow,  Color normalColor,  Color pushColor,  IconData button0Icon,  bool button0isPush,  IconData button1Icon,  bool button1isPush,  IconData button2Icon,  bool button2isPush,  IconData button3Icon,  bool button3isPush)?  display,}) {final _that = this;
switch (_that) {
case ButtonsHintDisplayState() when display != null:
return display(_that.isShow,_that.normalColor,_that.pushColor,_that.button0Icon,_that.button0isPush,_that.button1Icon,_that.button1isPush,_that.button2Icon,_that.button2isPush,_that.button3Icon,_that.button3isPush);case _:
  return null;

}
}

}

/// @nodoc


class ButtonsHintDisplayState implements ButtonsHintState {
  const ButtonsHintDisplayState({required this.isShow, required this.normalColor, required this.pushColor, required this.button0Icon, required this.button0isPush, required this.button1Icon, required this.button1isPush, required this.button2Icon, required this.button2isPush, required this.button3Icon, required this.button3isPush});
  

@override final  bool isShow;
@override final  Color normalColor;
@override final  Color pushColor;
@override final  IconData button0Icon;
@override final  bool button0isPush;
@override final  IconData button1Icon;
@override final  bool button1isPush;
@override final  IconData button2Icon;
@override final  bool button2isPush;
@override final  IconData button3Icon;
@override final  bool button3isPush;

/// Create a copy of ButtonsHintState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ButtonsHintDisplayStateCopyWith<ButtonsHintDisplayState> get copyWith => _$ButtonsHintDisplayStateCopyWithImpl<ButtonsHintDisplayState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ButtonsHintDisplayState&&(identical(other.isShow, isShow) || other.isShow == isShow)&&(identical(other.normalColor, normalColor) || other.normalColor == normalColor)&&(identical(other.pushColor, pushColor) || other.pushColor == pushColor)&&(identical(other.button0Icon, button0Icon) || other.button0Icon == button0Icon)&&(identical(other.button0isPush, button0isPush) || other.button0isPush == button0isPush)&&(identical(other.button1Icon, button1Icon) || other.button1Icon == button1Icon)&&(identical(other.button1isPush, button1isPush) || other.button1isPush == button1isPush)&&(identical(other.button2Icon, button2Icon) || other.button2Icon == button2Icon)&&(identical(other.button2isPush, button2isPush) || other.button2isPush == button2isPush)&&(identical(other.button3Icon, button3Icon) || other.button3Icon == button3Icon)&&(identical(other.button3isPush, button3isPush) || other.button3isPush == button3isPush));
}


@override
int get hashCode {
    return Object.hash(runtimeType,isShow,normalColor,pushColor,button0Icon,button0isPush,button1Icon,button1isPush,button2Icon,button2isPush,button3Icon,button3isPush);
}

@override
String toString() {
    return 'ButtonsHintState.display(isShow: $isShow, normalColor: $normalColor, pushColor: $pushColor, button0Icon: $button0Icon, button0isPush: $button0isPush, button1Icon: $button1Icon, button1isPush: $button1isPush, button2Icon: $button2Icon, button2isPush: $button2isPush, button3Icon: $button3Icon, button3isPush: $button3isPush)';
}


}

/// @nodoc
abstract mixin class $ButtonsHintDisplayStateCopyWith<$Res> implements $ButtonsHintStateCopyWith<$Res> {
  factory $ButtonsHintDisplayStateCopyWith(ButtonsHintDisplayState value, $Res Function(ButtonsHintDisplayState) _then) = _$ButtonsHintDisplayStateCopyWithImpl;
@override @useResult
$Res call({
 bool isShow, Color normalColor, Color pushColor, IconData button0Icon, bool button0isPush, IconData button1Icon, bool button1isPush, IconData button2Icon, bool button2isPush, IconData button3Icon, bool button3isPush
});




}
/// @nodoc
class _$ButtonsHintDisplayStateCopyWithImpl<$Res>
    implements $ButtonsHintDisplayStateCopyWith<$Res> {
  _$ButtonsHintDisplayStateCopyWithImpl(this._self, this._then);

  final ButtonsHintDisplayState _self;
  final $Res Function(ButtonsHintDisplayState) _then;

/// Create a copy of ButtonsHintState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isShow = null,Object? normalColor = null,Object? pushColor = null,Object? button0Icon = null,Object? button0isPush = null,Object? button1Icon = null,Object? button1isPush = null,Object? button2Icon = null,Object? button2isPush = null,Object? button3Icon = null,Object? button3isPush = null,}) {
  return _then(ButtonsHintDisplayState(
isShow: null == isShow ? _self.isShow : isShow // ignore: cast_nullable_to_non_nullable
as bool,normalColor: null == normalColor ? _self.normalColor : normalColor // ignore: cast_nullable_to_non_nullable
as Color,pushColor: null == pushColor ? _self.pushColor : pushColor // ignore: cast_nullable_to_non_nullable
as Color,button0Icon: null == button0Icon ? _self.button0Icon : button0Icon // ignore: cast_nullable_to_non_nullable
as IconData,button0isPush: null == button0isPush ? _self.button0isPush : button0isPush // ignore: cast_nullable_to_non_nullable
as bool,button1Icon: null == button1Icon ? _self.button1Icon : button1Icon // ignore: cast_nullable_to_non_nullable
as IconData,button1isPush: null == button1isPush ? _self.button1isPush : button1isPush // ignore: cast_nullable_to_non_nullable
as bool,button2Icon: null == button2Icon ? _self.button2Icon : button2Icon // ignore: cast_nullable_to_non_nullable
as IconData,button2isPush: null == button2isPush ? _self.button2isPush : button2isPush // ignore: cast_nullable_to_non_nullable
as bool,button3Icon: null == button3Icon ? _self.button3Icon : button3Icon // ignore: cast_nullable_to_non_nullable
as IconData,button3isPush: null == button3isPush ? _self.button3isPush : button3isPush // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
