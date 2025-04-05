// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
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
  int get id;
  String get type;

  /// Create a copy of AreYouReadyCommand
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AreYouReadyCommandCopyWith<AreYouReadyCommand> get copyWith =>
      _$AreYouReadyCommandCopyWithImpl<AreYouReadyCommand>(
          this as AreYouReadyCommand, _$identity);

  /// Serializes this AreYouReadyCommand to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AreYouReadyCommand &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, type);

  @override
  String toString() {
    return 'AreYouReadyCommand(id: $id, type: $type)';
  }
}

/// @nodoc
abstract mixin class $AreYouReadyCommandCopyWith<$Res> {
  factory $AreYouReadyCommandCopyWith(
          AreYouReadyCommand value, $Res Function(AreYouReadyCommand) _then) =
      _$AreYouReadyCommandCopyWithImpl;
  @useResult
  $Res call({int id, String type});
}

/// @nodoc
class _$AreYouReadyCommandCopyWithImpl<$Res>
    implements $AreYouReadyCommandCopyWith<$Res> {
  _$AreYouReadyCommandCopyWithImpl(this._self, this._then);

  final AreYouReadyCommand _self;
  final $Res Function(AreYouReadyCommand) _then;

  /// Create a copy of AreYouReadyCommand
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _AreYouReadyCommand implements AreYouReadyCommand {
  const _AreYouReadyCommand(
      {required this.id, this.type = AreYouReadyCommand.TYPE});
  factory _AreYouReadyCommand.fromJson(Map<String, dynamic> json) =>
      _$AreYouReadyCommandFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final String type;

  /// Create a copy of AreYouReadyCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AreYouReadyCommandCopyWith<_AreYouReadyCommand> get copyWith =>
      __$AreYouReadyCommandCopyWithImpl<_AreYouReadyCommand>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AreYouReadyCommandToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AreYouReadyCommand &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, type);

  @override
  String toString() {
    return 'AreYouReadyCommand(id: $id, type: $type)';
  }
}

/// @nodoc
abstract mixin class _$AreYouReadyCommandCopyWith<$Res>
    implements $AreYouReadyCommandCopyWith<$Res> {
  factory _$AreYouReadyCommandCopyWith(
          _AreYouReadyCommand value, $Res Function(_AreYouReadyCommand) _then) =
      __$AreYouReadyCommandCopyWithImpl;
  @override
  @useResult
  $Res call({int id, String type});
}

/// @nodoc
class __$AreYouReadyCommandCopyWithImpl<$Res>
    implements _$AreYouReadyCommandCopyWith<$Res> {
  __$AreYouReadyCommandCopyWithImpl(this._self, this._then);

  final _AreYouReadyCommand _self;
  final $Res Function(_AreYouReadyCommand) _then;

  /// Create a copy of AreYouReadyCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_AreYouReadyCommand(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$PushButtonCommand {
  ButtonType get button;
  int get id;
  String get type;

  /// Create a copy of PushButtonCommand
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PushButtonCommandCopyWith<PushButtonCommand> get copyWith =>
      _$PushButtonCommandCopyWithImpl<PushButtonCommand>(
          this as PushButtonCommand, _$identity);

  /// Serializes this PushButtonCommand to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PushButtonCommand &&
            (identical(other.button, button) || other.button == button) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, button, id, type);

  @override
  String toString() {
    return 'PushButtonCommand(button: $button, id: $id, type: $type)';
  }
}

/// @nodoc
abstract mixin class $PushButtonCommandCopyWith<$Res> {
  factory $PushButtonCommandCopyWith(
          PushButtonCommand value, $Res Function(PushButtonCommand) _then) =
      _$PushButtonCommandCopyWithImpl;
  @useResult
  $Res call({ButtonType button, int id, String type});
}

/// @nodoc
class _$PushButtonCommandCopyWithImpl<$Res>
    implements $PushButtonCommandCopyWith<$Res> {
  _$PushButtonCommandCopyWithImpl(this._self, this._then);

  final PushButtonCommand _self;
  final $Res Function(PushButtonCommand) _then;

  /// Create a copy of PushButtonCommand
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? button = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_self.copyWith(
      button: null == button
          ? _self.button
          : button // ignore: cast_nullable_to_non_nullable
              as ButtonType,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _PushButtonCommand implements PushButtonCommand {
  const _PushButtonCommand(
      {required this.button,
      required this.id,
      this.type = PushButtonCommand.TYPE});
  factory _PushButtonCommand.fromJson(Map<String, dynamic> json) =>
      _$PushButtonCommandFromJson(json);

  @override
  final ButtonType button;
  @override
  final int id;
  @override
  @JsonKey()
  final String type;

  /// Create a copy of PushButtonCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PushButtonCommandCopyWith<_PushButtonCommand> get copyWith =>
      __$PushButtonCommandCopyWithImpl<_PushButtonCommand>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PushButtonCommandToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PushButtonCommand &&
            (identical(other.button, button) || other.button == button) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, button, id, type);

  @override
  String toString() {
    return 'PushButtonCommand(button: $button, id: $id, type: $type)';
  }
}

/// @nodoc
abstract mixin class _$PushButtonCommandCopyWith<$Res>
    implements $PushButtonCommandCopyWith<$Res> {
  factory _$PushButtonCommandCopyWith(
          _PushButtonCommand value, $Res Function(_PushButtonCommand) _then) =
      __$PushButtonCommandCopyWithImpl;
  @override
  @useResult
  $Res call({ButtonType button, int id, String type});
}

/// @nodoc
class __$PushButtonCommandCopyWithImpl<$Res>
    implements _$PushButtonCommandCopyWith<$Res> {
  __$PushButtonCommandCopyWithImpl(this._self, this._then);

  final _PushButtonCommand _self;
  final $Res Function(_PushButtonCommand) _then;

  /// Create a copy of PushButtonCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? button = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_PushButtonCommand(
      button: null == button
          ? _self.button
          : button // ignore: cast_nullable_to_non_nullable
              as ButtonType,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$ExecuteSSActionCommand {
  SlideshowAction get action;
  bool get value;
  int get id;
  String get type;

  /// Create a copy of ExecuteSSActionCommand
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExecuteSSActionCommandCopyWith<ExecuteSSActionCommand> get copyWith =>
      _$ExecuteSSActionCommandCopyWithImpl<ExecuteSSActionCommand>(
          this as ExecuteSSActionCommand, _$identity);

  /// Serializes this ExecuteSSActionCommand to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExecuteSSActionCommand &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, action, value, id, type);

  @override
  String toString() {
    return 'ExecuteSSActionCommand(action: $action, value: $value, id: $id, type: $type)';
  }
}

/// @nodoc
abstract mixin class $ExecuteSSActionCommandCopyWith<$Res> {
  factory $ExecuteSSActionCommandCopyWith(ExecuteSSActionCommand value,
          $Res Function(ExecuteSSActionCommand) _then) =
      _$ExecuteSSActionCommandCopyWithImpl;
  @useResult
  $Res call({SlideshowAction action, bool value, int id, String type});
}

/// @nodoc
class _$ExecuteSSActionCommandCopyWithImpl<$Res>
    implements $ExecuteSSActionCommandCopyWith<$Res> {
  _$ExecuteSSActionCommandCopyWithImpl(this._self, this._then);

  final ExecuteSSActionCommand _self;
  final $Res Function(ExecuteSSActionCommand) _then;

  /// Create a copy of ExecuteSSActionCommand
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? action = null,
    Object? value = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_self.copyWith(
      action: null == action
          ? _self.action
          : action // ignore: cast_nullable_to_non_nullable
              as SlideshowAction,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ExecuteSSActionCommand implements ExecuteSSActionCommand {
  const _ExecuteSSActionCommand(
      {required this.action,
      required this.value,
      required this.id,
      this.type = ExecuteSSActionCommand.TYPE});
  factory _ExecuteSSActionCommand.fromJson(Map<String, dynamic> json) =>
      _$ExecuteSSActionCommandFromJson(json);

  @override
  final SlideshowAction action;
  @override
  final bool value;
  @override
  final int id;
  @override
  @JsonKey()
  final String type;

  /// Create a copy of ExecuteSSActionCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ExecuteSSActionCommandCopyWith<_ExecuteSSActionCommand> get copyWith =>
      __$ExecuteSSActionCommandCopyWithImpl<_ExecuteSSActionCommand>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ExecuteSSActionCommandToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExecuteSSActionCommand &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, action, value, id, type);

  @override
  String toString() {
    return 'ExecuteSSActionCommand(action: $action, value: $value, id: $id, type: $type)';
  }
}

/// @nodoc
abstract mixin class _$ExecuteSSActionCommandCopyWith<$Res>
    implements $ExecuteSSActionCommandCopyWith<$Res> {
  factory _$ExecuteSSActionCommandCopyWith(_ExecuteSSActionCommand value,
          $Res Function(_ExecuteSSActionCommand) _then) =
      __$ExecuteSSActionCommandCopyWithImpl;
  @override
  @useResult
  $Res call({SlideshowAction action, bool value, int id, String type});
}

/// @nodoc
class __$ExecuteSSActionCommandCopyWithImpl<$Res>
    implements _$ExecuteSSActionCommandCopyWith<$Res> {
  __$ExecuteSSActionCommandCopyWithImpl(this._self, this._then);

  final _ExecuteSSActionCommand _self;
  final $Res Function(_ExecuteSSActionCommand) _then;

  /// Create a copy of ExecuteSSActionCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? action = null,
    Object? value = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_ExecuteSSActionCommand(
      action: null == action
          ? _self.action
          : action // ignore: cast_nullable_to_non_nullable
              as SlideshowAction,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$LEDControlCommand {
  LEDType get led;
  bool get value;
  int get id;
  String get type;

  /// Create a copy of LEDControlCommand
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LEDControlCommandCopyWith<LEDControlCommand> get copyWith =>
      _$LEDControlCommandCopyWithImpl<LEDControlCommand>(
          this as LEDControlCommand, _$identity);

  /// Serializes this LEDControlCommand to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LEDControlCommand &&
            (identical(other.led, led) || other.led == led) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, led, value, id, type);

  @override
  String toString() {
    return 'LEDControlCommand(led: $led, value: $value, id: $id, type: $type)';
  }
}

/// @nodoc
abstract mixin class $LEDControlCommandCopyWith<$Res> {
  factory $LEDControlCommandCopyWith(
          LEDControlCommand value, $Res Function(LEDControlCommand) _then) =
      _$LEDControlCommandCopyWithImpl;
  @useResult
  $Res call({LEDType led, bool value, int id, String type});
}

/// @nodoc
class _$LEDControlCommandCopyWithImpl<$Res>
    implements $LEDControlCommandCopyWith<$Res> {
  _$LEDControlCommandCopyWithImpl(this._self, this._then);

  final LEDControlCommand _self;
  final $Res Function(LEDControlCommand) _then;

  /// Create a copy of LEDControlCommand
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? led = null,
    Object? value = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_self.copyWith(
      led: null == led
          ? _self.led
          : led // ignore: cast_nullable_to_non_nullable
              as LEDType,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _LEDControlCommand implements LEDControlCommand {
  const _LEDControlCommand(
      {required this.led,
      required this.value,
      required this.id,
      this.type = LEDControlCommand.TYPE});
  factory _LEDControlCommand.fromJson(Map<String, dynamic> json) =>
      _$LEDControlCommandFromJson(json);

  @override
  final LEDType led;
  @override
  final bool value;
  @override
  final int id;
  @override
  @JsonKey()
  final String type;

  /// Create a copy of LEDControlCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LEDControlCommandCopyWith<_LEDControlCommand> get copyWith =>
      __$LEDControlCommandCopyWithImpl<_LEDControlCommand>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LEDControlCommandToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LEDControlCommand &&
            (identical(other.led, led) || other.led == led) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, led, value, id, type);

  @override
  String toString() {
    return 'LEDControlCommand(led: $led, value: $value, id: $id, type: $type)';
  }
}

/// @nodoc
abstract mixin class _$LEDControlCommandCopyWith<$Res>
    implements $LEDControlCommandCopyWith<$Res> {
  factory _$LEDControlCommandCopyWith(
          _LEDControlCommand value, $Res Function(_LEDControlCommand) _then) =
      __$LEDControlCommandCopyWithImpl;
  @override
  @useResult
  $Res call({LEDType led, bool value, int id, String type});
}

/// @nodoc
class __$LEDControlCommandCopyWithImpl<$Res>
    implements _$LEDControlCommandCopyWith<$Res> {
  __$LEDControlCommandCopyWithImpl(this._self, this._then);

  final _LEDControlCommand _self;
  final $Res Function(_LEDControlCommand) _then;

  /// Create a copy of LEDControlCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? led = null,
    Object? value = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_LEDControlCommand(
      led: null == led
          ? _self.led
          : led // ignore: cast_nullable_to_non_nullable
              as LEDType,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$PowerOffCommand {
  String get type;
  int get id;

  /// Create a copy of PowerOffCommand
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PowerOffCommandCopyWith<PowerOffCommand> get copyWith =>
      _$PowerOffCommandCopyWithImpl<PowerOffCommand>(
          this as PowerOffCommand, _$identity);

  /// Serializes this PowerOffCommand to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PowerOffCommand &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, id);

  @override
  String toString() {
    return 'PowerOffCommand(type: $type, id: $id)';
  }
}

/// @nodoc
abstract mixin class $PowerOffCommandCopyWith<$Res> {
  factory $PowerOffCommandCopyWith(
          PowerOffCommand value, $Res Function(PowerOffCommand) _then) =
      _$PowerOffCommandCopyWithImpl;
  @useResult
  $Res call({String type, int id});
}

/// @nodoc
class _$PowerOffCommandCopyWithImpl<$Res>
    implements $PowerOffCommandCopyWith<$Res> {
  _$PowerOffCommandCopyWithImpl(this._self, this._then);

  final PowerOffCommand _self;
  final $Res Function(PowerOffCommand) _then;

  /// Create a copy of PowerOffCommand
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? id = null,
  }) {
    return _then(_self.copyWith(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _PowerOffCommand implements PowerOffCommand {
  const _PowerOffCommand({this.type = PowerOffCommand.TYPE, required this.id});
  factory _PowerOffCommand.fromJson(Map<String, dynamic> json) =>
      _$PowerOffCommandFromJson(json);

  @override
  @JsonKey()
  final String type;
  @override
  final int id;

  /// Create a copy of PowerOffCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PowerOffCommandCopyWith<_PowerOffCommand> get copyWith =>
      __$PowerOffCommandCopyWithImpl<_PowerOffCommand>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PowerOffCommandToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PowerOffCommand &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, id);

  @override
  String toString() {
    return 'PowerOffCommand(type: $type, id: $id)';
  }
}

/// @nodoc
abstract mixin class _$PowerOffCommandCopyWith<$Res>
    implements $PowerOffCommandCopyWith<$Res> {
  factory _$PowerOffCommandCopyWith(
          _PowerOffCommand value, $Res Function(_PowerOffCommand) _then) =
      __$PowerOffCommandCopyWithImpl;
  @override
  @useResult
  $Res call({String type, int id});
}

/// @nodoc
class __$PowerOffCommandCopyWithImpl<$Res>
    implements _$PowerOffCommandCopyWith<$Res> {
  __$PowerOffCommandCopyWithImpl(this._self, this._then);

  final _PowerOffCommand _self;
  final $Res Function(_PowerOffCommand) _then;

  /// Create a copy of PowerOffCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? type = null,
    Object? id = null,
  }) {
    return _then(_PowerOffCommand(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
