// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'buttons_hint_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ButtonsHintEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ButtonsHintEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ButtonsHintEvent()';
  }
}

/// @nodoc
class $ButtonsHintEventCopyWith<$Res> {
  $ButtonsHintEventCopyWith(
      ButtonsHintEvent _, $Res Function(ButtonsHintEvent) __);
}

/// @nodoc

class _ButtonsHintEvent implements ButtonsHintEvent {
  const _ButtonsHintEvent();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _ButtonsHintEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ButtonsHintEvent()';
  }
}

/// @nodoc

class ButtonsHintShowEvent implements ButtonsHintEvent {
  const ButtonsHintShowEvent({required this.isShow});

  final bool isShow;

  /// Create a copy of ButtonsHintEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ButtonsHintShowEventCopyWith<ButtonsHintShowEvent> get copyWith =>
      _$ButtonsHintShowEventCopyWithImpl<ButtonsHintShowEvent>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ButtonsHintShowEvent &&
            (identical(other.isShow, isShow) || other.isShow == isShow));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isShow);

  @override
  String toString() {
    return 'ButtonsHintEvent.show(isShow: $isShow)';
  }
}

/// @nodoc
abstract mixin class $ButtonsHintShowEventCopyWith<$Res>
    implements $ButtonsHintEventCopyWith<$Res> {
  factory $ButtonsHintShowEventCopyWith(ButtonsHintShowEvent value,
          $Res Function(ButtonsHintShowEvent) _then) =
      _$ButtonsHintShowEventCopyWithImpl;
  @useResult
  $Res call({bool isShow});
}

/// @nodoc
class _$ButtonsHintShowEventCopyWithImpl<$Res>
    implements $ButtonsHintShowEventCopyWith<$Res> {
  _$ButtonsHintShowEventCopyWithImpl(this._self, this._then);

  final ButtonsHintShowEvent _self;
  final $Res Function(ButtonsHintShowEvent) _then;

  /// Create a copy of ButtonsHintEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isShow = null,
  }) {
    return _then(ButtonsHintShowEvent(
      isShow: null == isShow
          ? _self.isShow
          : isShow // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class ButtonsHintPushButtonEvent implements ButtonsHintEvent {
  const ButtonsHintPushButtonEvent({required this.button});

  final ButtonType button;

  /// Create a copy of ButtonsHintEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ButtonsHintPushButtonEventCopyWith<ButtonsHintPushButtonEvent>
      get copyWith =>
          _$ButtonsHintPushButtonEventCopyWithImpl<ButtonsHintPushButtonEvent>(
              this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ButtonsHintPushButtonEvent &&
            (identical(other.button, button) || other.button == button));
  }

  @override
  int get hashCode => Object.hash(runtimeType, button);

  @override
  String toString() {
    return 'ButtonsHintEvent.pushButton(button: $button)';
  }
}

/// @nodoc
abstract mixin class $ButtonsHintPushButtonEventCopyWith<$Res>
    implements $ButtonsHintEventCopyWith<$Res> {
  factory $ButtonsHintPushButtonEventCopyWith(ButtonsHintPushButtonEvent value,
          $Res Function(ButtonsHintPushButtonEvent) _then) =
      _$ButtonsHintPushButtonEventCopyWithImpl;
  @useResult
  $Res call({ButtonType button});
}

/// @nodoc
class _$ButtonsHintPushButtonEventCopyWithImpl<$Res>
    implements $ButtonsHintPushButtonEventCopyWith<$Res> {
  _$ButtonsHintPushButtonEventCopyWithImpl(this._self, this._then);

  final ButtonsHintPushButtonEvent _self;
  final $Res Function(ButtonsHintPushButtonEvent) _then;

  /// Create a copy of ButtonsHintEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? button = null,
  }) {
    return _then(ButtonsHintPushButtonEvent(
      button: null == button
          ? _self.button
          : button // ignore: cast_nullable_to_non_nullable
              as ButtonType,
    ));
  }
}

/// @nodoc
mixin _$ButtonsHintState {
  bool get isShow;
  Color get normalColor;
  Color get pushColor;
  IconData get button0Icon;
  bool get button0isPush;
  IconData get button1Icon;
  bool get button1isPush;
  IconData get button2Icon;
  bool get button2isPush;
  IconData get button3Icon;
  bool get button3isPush;

  /// Create a copy of ButtonsHintState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ButtonsHintStateCopyWith<ButtonsHintState> get copyWith =>
      _$ButtonsHintStateCopyWithImpl<ButtonsHintState>(
          this as ButtonsHintState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ButtonsHintState &&
            (identical(other.isShow, isShow) || other.isShow == isShow) &&
            (identical(other.normalColor, normalColor) ||
                other.normalColor == normalColor) &&
            (identical(other.pushColor, pushColor) ||
                other.pushColor == pushColor) &&
            (identical(other.button0Icon, button0Icon) ||
                other.button0Icon == button0Icon) &&
            (identical(other.button0isPush, button0isPush) ||
                other.button0isPush == button0isPush) &&
            (identical(other.button1Icon, button1Icon) ||
                other.button1Icon == button1Icon) &&
            (identical(other.button1isPush, button1isPush) ||
                other.button1isPush == button1isPush) &&
            (identical(other.button2Icon, button2Icon) ||
                other.button2Icon == button2Icon) &&
            (identical(other.button2isPush, button2isPush) ||
                other.button2isPush == button2isPush) &&
            (identical(other.button3Icon, button3Icon) ||
                other.button3Icon == button3Icon) &&
            (identical(other.button3isPush, button3isPush) ||
                other.button3isPush == button3isPush));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isShow,
      normalColor,
      pushColor,
      button0Icon,
      button0isPush,
      button1Icon,
      button1isPush,
      button2Icon,
      button2isPush,
      button3Icon,
      button3isPush);

  @override
  String toString() {
    return 'ButtonsHintState(isShow: $isShow, normalColor: $normalColor, pushColor: $pushColor, button0Icon: $button0Icon, button0isPush: $button0isPush, button1Icon: $button1Icon, button1isPush: $button1isPush, button2Icon: $button2Icon, button2isPush: $button2isPush, button3Icon: $button3Icon, button3isPush: $button3isPush)';
  }
}

/// @nodoc
abstract mixin class $ButtonsHintStateCopyWith<$Res> {
  factory $ButtonsHintStateCopyWith(
          ButtonsHintState value, $Res Function(ButtonsHintState) _then) =
      _$ButtonsHintStateCopyWithImpl;
  @useResult
  $Res call(
      {bool isShow,
      Color normalColor,
      Color pushColor,
      IconData button0Icon,
      bool button0isPush,
      IconData button1Icon,
      bool button1isPush,
      IconData button2Icon,
      bool button2isPush,
      IconData button3Icon,
      bool button3isPush});
}

/// @nodoc
class _$ButtonsHintStateCopyWithImpl<$Res>
    implements $ButtonsHintStateCopyWith<$Res> {
  _$ButtonsHintStateCopyWithImpl(this._self, this._then);

  final ButtonsHintState _self;
  final $Res Function(ButtonsHintState) _then;

  /// Create a copy of ButtonsHintState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isShow = null,
    Object? normalColor = null,
    Object? pushColor = null,
    Object? button0Icon = null,
    Object? button0isPush = null,
    Object? button1Icon = null,
    Object? button1isPush = null,
    Object? button2Icon = null,
    Object? button2isPush = null,
    Object? button3Icon = null,
    Object? button3isPush = null,
  }) {
    return _then(_self.copyWith(
      isShow: null == isShow
          ? _self.isShow
          : isShow // ignore: cast_nullable_to_non_nullable
              as bool,
      normalColor: null == normalColor
          ? _self.normalColor
          : normalColor // ignore: cast_nullable_to_non_nullable
              as Color,
      pushColor: null == pushColor
          ? _self.pushColor
          : pushColor // ignore: cast_nullable_to_non_nullable
              as Color,
      button0Icon: null == button0Icon
          ? _self.button0Icon
          : button0Icon // ignore: cast_nullable_to_non_nullable
              as IconData,
      button0isPush: null == button0isPush
          ? _self.button0isPush
          : button0isPush // ignore: cast_nullable_to_non_nullable
              as bool,
      button1Icon: null == button1Icon
          ? _self.button1Icon
          : button1Icon // ignore: cast_nullable_to_non_nullable
              as IconData,
      button1isPush: null == button1isPush
          ? _self.button1isPush
          : button1isPush // ignore: cast_nullable_to_non_nullable
              as bool,
      button2Icon: null == button2Icon
          ? _self.button2Icon
          : button2Icon // ignore: cast_nullable_to_non_nullable
              as IconData,
      button2isPush: null == button2isPush
          ? _self.button2isPush
          : button2isPush // ignore: cast_nullable_to_non_nullable
              as bool,
      button3Icon: null == button3Icon
          ? _self.button3Icon
          : button3Icon // ignore: cast_nullable_to_non_nullable
              as IconData,
      button3isPush: null == button3isPush
          ? _self.button3isPush
          : button3isPush // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class ButtonsHintDisplayState implements ButtonsHintState {
  const ButtonsHintDisplayState(
      {required this.isShow,
      required this.normalColor,
      required this.pushColor,
      required this.button0Icon,
      required this.button0isPush,
      required this.button1Icon,
      required this.button1isPush,
      required this.button2Icon,
      required this.button2isPush,
      required this.button3Icon,
      required this.button3isPush});

  @override
  final bool isShow;
  @override
  final Color normalColor;
  @override
  final Color pushColor;
  @override
  final IconData button0Icon;
  @override
  final bool button0isPush;
  @override
  final IconData button1Icon;
  @override
  final bool button1isPush;
  @override
  final IconData button2Icon;
  @override
  final bool button2isPush;
  @override
  final IconData button3Icon;
  @override
  final bool button3isPush;

  /// Create a copy of ButtonsHintState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ButtonsHintDisplayStateCopyWith<ButtonsHintDisplayState> get copyWith =>
      _$ButtonsHintDisplayStateCopyWithImpl<ButtonsHintDisplayState>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ButtonsHintDisplayState &&
            (identical(other.isShow, isShow) || other.isShow == isShow) &&
            (identical(other.normalColor, normalColor) ||
                other.normalColor == normalColor) &&
            (identical(other.pushColor, pushColor) ||
                other.pushColor == pushColor) &&
            (identical(other.button0Icon, button0Icon) ||
                other.button0Icon == button0Icon) &&
            (identical(other.button0isPush, button0isPush) ||
                other.button0isPush == button0isPush) &&
            (identical(other.button1Icon, button1Icon) ||
                other.button1Icon == button1Icon) &&
            (identical(other.button1isPush, button1isPush) ||
                other.button1isPush == button1isPush) &&
            (identical(other.button2Icon, button2Icon) ||
                other.button2Icon == button2Icon) &&
            (identical(other.button2isPush, button2isPush) ||
                other.button2isPush == button2isPush) &&
            (identical(other.button3Icon, button3Icon) ||
                other.button3Icon == button3Icon) &&
            (identical(other.button3isPush, button3isPush) ||
                other.button3isPush == button3isPush));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isShow,
      normalColor,
      pushColor,
      button0Icon,
      button0isPush,
      button1Icon,
      button1isPush,
      button2Icon,
      button2isPush,
      button3Icon,
      button3isPush);

  @override
  String toString() {
    return 'ButtonsHintState.display(isShow: $isShow, normalColor: $normalColor, pushColor: $pushColor, button0Icon: $button0Icon, button0isPush: $button0isPush, button1Icon: $button1Icon, button1isPush: $button1isPush, button2Icon: $button2Icon, button2isPush: $button2isPush, button3Icon: $button3Icon, button3isPush: $button3isPush)';
  }
}

/// @nodoc
abstract mixin class $ButtonsHintDisplayStateCopyWith<$Res>
    implements $ButtonsHintStateCopyWith<$Res> {
  factory $ButtonsHintDisplayStateCopyWith(ButtonsHintDisplayState value,
          $Res Function(ButtonsHintDisplayState) _then) =
      _$ButtonsHintDisplayStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool isShow,
      Color normalColor,
      Color pushColor,
      IconData button0Icon,
      bool button0isPush,
      IconData button1Icon,
      bool button1isPush,
      IconData button2Icon,
      bool button2isPush,
      IconData button3Icon,
      bool button3isPush});
}

/// @nodoc
class _$ButtonsHintDisplayStateCopyWithImpl<$Res>
    implements $ButtonsHintDisplayStateCopyWith<$Res> {
  _$ButtonsHintDisplayStateCopyWithImpl(this._self, this._then);

  final ButtonsHintDisplayState _self;
  final $Res Function(ButtonsHintDisplayState) _then;

  /// Create a copy of ButtonsHintState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isShow = null,
    Object? normalColor = null,
    Object? pushColor = null,
    Object? button0Icon = null,
    Object? button0isPush = null,
    Object? button1Icon = null,
    Object? button1isPush = null,
    Object? button2Icon = null,
    Object? button2isPush = null,
    Object? button3Icon = null,
    Object? button3isPush = null,
  }) {
    return _then(ButtonsHintDisplayState(
      isShow: null == isShow
          ? _self.isShow
          : isShow // ignore: cast_nullable_to_non_nullable
              as bool,
      normalColor: null == normalColor
          ? _self.normalColor
          : normalColor // ignore: cast_nullable_to_non_nullable
              as Color,
      pushColor: null == pushColor
          ? _self.pushColor
          : pushColor // ignore: cast_nullable_to_non_nullable
              as Color,
      button0Icon: null == button0Icon
          ? _self.button0Icon
          : button0Icon // ignore: cast_nullable_to_non_nullable
              as IconData,
      button0isPush: null == button0isPush
          ? _self.button0isPush
          : button0isPush // ignore: cast_nullable_to_non_nullable
              as bool,
      button1Icon: null == button1Icon
          ? _self.button1Icon
          : button1Icon // ignore: cast_nullable_to_non_nullable
              as IconData,
      button1isPush: null == button1isPush
          ? _self.button1isPush
          : button1isPush // ignore: cast_nullable_to_non_nullable
              as bool,
      button2Icon: null == button2Icon
          ? _self.button2Icon
          : button2Icon // ignore: cast_nullable_to_non_nullable
              as IconData,
      button2isPush: null == button2isPush
          ? _self.button2isPush
          : button2isPush // ignore: cast_nullable_to_non_nullable
              as bool,
      button3Icon: null == button3Icon
          ? _self.button3Icon
          : button3Icon // ignore: cast_nullable_to_non_nullable
              as IconData,
      button3isPush: null == button3isPush
          ? _self.button3isPush
          : button3isPush // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
