// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hardware_commands.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AreYouReadyCommand _$AreYouReadyCommandFromJson(Map<String, dynamic> json) {
  return _AreYouReadyCommand.fromJson(json);
}

/// @nodoc
mixin _$AreYouReadyCommand {
  int get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AreYouReadyCommandCopyWith<AreYouReadyCommand> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AreYouReadyCommandCopyWith<$Res> {
  factory $AreYouReadyCommandCopyWith(
          AreYouReadyCommand value, $Res Function(AreYouReadyCommand) then) =
      _$AreYouReadyCommandCopyWithImpl<$Res, AreYouReadyCommand>;
  @useResult
  $Res call({int id, String type});
}

/// @nodoc
class _$AreYouReadyCommandCopyWithImpl<$Res, $Val extends AreYouReadyCommand>
    implements $AreYouReadyCommandCopyWith<$Res> {
  _$AreYouReadyCommandCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AreYouReadyCommandImplCopyWith<$Res>
    implements $AreYouReadyCommandCopyWith<$Res> {
  factory _$$AreYouReadyCommandImplCopyWith(_$AreYouReadyCommandImpl value,
          $Res Function(_$AreYouReadyCommandImpl) then) =
      __$$AreYouReadyCommandImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String type});
}

/// @nodoc
class __$$AreYouReadyCommandImplCopyWithImpl<$Res>
    extends _$AreYouReadyCommandCopyWithImpl<$Res, _$AreYouReadyCommandImpl>
    implements _$$AreYouReadyCommandImplCopyWith<$Res> {
  __$$AreYouReadyCommandImplCopyWithImpl(_$AreYouReadyCommandImpl _value,
      $Res Function(_$AreYouReadyCommandImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_$AreYouReadyCommandImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AreYouReadyCommandImpl implements _AreYouReadyCommand {
  const _$AreYouReadyCommandImpl(
      {required this.id, this.type = AreYouReadyCommand.TYPE});

  factory _$AreYouReadyCommandImpl.fromJson(Map<String, dynamic> json) =>
      _$$AreYouReadyCommandImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final String type;

  @override
  String toString() {
    return 'AreYouReadyCommand(id: $id, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AreYouReadyCommandImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AreYouReadyCommandImplCopyWith<_$AreYouReadyCommandImpl> get copyWith =>
      __$$AreYouReadyCommandImplCopyWithImpl<_$AreYouReadyCommandImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AreYouReadyCommandImplToJson(
      this,
    );
  }
}

abstract class _AreYouReadyCommand implements AreYouReadyCommand {
  const factory _AreYouReadyCommand(
      {required final int id, final String type}) = _$AreYouReadyCommandImpl;

  factory _AreYouReadyCommand.fromJson(Map<String, dynamic> json) =
      _$AreYouReadyCommandImpl.fromJson;

  @override
  int get id;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$AreYouReadyCommandImplCopyWith<_$AreYouReadyCommandImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PushButtonCommand _$PushButtonCommandFromJson(Map<String, dynamic> json) {
  return _PushButtonCommand.fromJson(json);
}

/// @nodoc
mixin _$PushButtonCommand {
  ButtonType get button => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PushButtonCommandCopyWith<PushButtonCommand> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PushButtonCommandCopyWith<$Res> {
  factory $PushButtonCommandCopyWith(
          PushButtonCommand value, $Res Function(PushButtonCommand) then) =
      _$PushButtonCommandCopyWithImpl<$Res, PushButtonCommand>;
  @useResult
  $Res call({ButtonType button, int id, String type});
}

/// @nodoc
class _$PushButtonCommandCopyWithImpl<$Res, $Val extends PushButtonCommand>
    implements $PushButtonCommandCopyWith<$Res> {
  _$PushButtonCommandCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? button = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      button: null == button
          ? _value.button
          : button // ignore: cast_nullable_to_non_nullable
              as ButtonType,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PushButtonCommandImplCopyWith<$Res>
    implements $PushButtonCommandCopyWith<$Res> {
  factory _$$PushButtonCommandImplCopyWith(_$PushButtonCommandImpl value,
          $Res Function(_$PushButtonCommandImpl) then) =
      __$$PushButtonCommandImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ButtonType button, int id, String type});
}

/// @nodoc
class __$$PushButtonCommandImplCopyWithImpl<$Res>
    extends _$PushButtonCommandCopyWithImpl<$Res, _$PushButtonCommandImpl>
    implements _$$PushButtonCommandImplCopyWith<$Res> {
  __$$PushButtonCommandImplCopyWithImpl(_$PushButtonCommandImpl _value,
      $Res Function(_$PushButtonCommandImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? button = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_$PushButtonCommandImpl(
      button: null == button
          ? _value.button
          : button // ignore: cast_nullable_to_non_nullable
              as ButtonType,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PushButtonCommandImpl implements _PushButtonCommand {
  const _$PushButtonCommandImpl(
      {required this.button,
      required this.id,
      this.type = PushButtonCommand.TYPE});

  factory _$PushButtonCommandImpl.fromJson(Map<String, dynamic> json) =>
      _$$PushButtonCommandImplFromJson(json);

  @override
  final ButtonType button;
  @override
  final int id;
  @override
  @JsonKey()
  final String type;

  @override
  String toString() {
    return 'PushButtonCommand(button: $button, id: $id, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PushButtonCommandImpl &&
            (identical(other.button, button) || other.button == button) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, button, id, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PushButtonCommandImplCopyWith<_$PushButtonCommandImpl> get copyWith =>
      __$$PushButtonCommandImplCopyWithImpl<_$PushButtonCommandImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PushButtonCommandImplToJson(
      this,
    );
  }
}

abstract class _PushButtonCommand implements PushButtonCommand {
  const factory _PushButtonCommand(
      {required final ButtonType button,
      required final int id,
      final String type}) = _$PushButtonCommandImpl;

  factory _PushButtonCommand.fromJson(Map<String, dynamic> json) =
      _$PushButtonCommandImpl.fromJson;

  @override
  ButtonType get button;
  @override
  int get id;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$PushButtonCommandImplCopyWith<_$PushButtonCommandImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ExecuteSSActionCommand _$ExecuteSSActionCommandFromJson(
    Map<String, dynamic> json) {
  return _ExecuteSSActionCommand.fromJson(json);
}

/// @nodoc
mixin _$ExecuteSSActionCommand {
  SlideshowAction get action => throw _privateConstructorUsedError;
  bool get value => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExecuteSSActionCommandCopyWith<ExecuteSSActionCommand> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExecuteSSActionCommandCopyWith<$Res> {
  factory $ExecuteSSActionCommandCopyWith(ExecuteSSActionCommand value,
          $Res Function(ExecuteSSActionCommand) then) =
      _$ExecuteSSActionCommandCopyWithImpl<$Res, ExecuteSSActionCommand>;
  @useResult
  $Res call({SlideshowAction action, bool value, int id, String type});
}

/// @nodoc
class _$ExecuteSSActionCommandCopyWithImpl<$Res,
        $Val extends ExecuteSSActionCommand>
    implements $ExecuteSSActionCommandCopyWith<$Res> {
  _$ExecuteSSActionCommandCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? action = null,
    Object? value = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as SlideshowAction,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExecuteSSActionCommandImplCopyWith<$Res>
    implements $ExecuteSSActionCommandCopyWith<$Res> {
  factory _$$ExecuteSSActionCommandImplCopyWith(
          _$ExecuteSSActionCommandImpl value,
          $Res Function(_$ExecuteSSActionCommandImpl) then) =
      __$$ExecuteSSActionCommandImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SlideshowAction action, bool value, int id, String type});
}

/// @nodoc
class __$$ExecuteSSActionCommandImplCopyWithImpl<$Res>
    extends _$ExecuteSSActionCommandCopyWithImpl<$Res,
        _$ExecuteSSActionCommandImpl>
    implements _$$ExecuteSSActionCommandImplCopyWith<$Res> {
  __$$ExecuteSSActionCommandImplCopyWithImpl(
      _$ExecuteSSActionCommandImpl _value,
      $Res Function(_$ExecuteSSActionCommandImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? action = null,
    Object? value = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_$ExecuteSSActionCommandImpl(
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as SlideshowAction,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExecuteSSActionCommandImpl implements _ExecuteSSActionCommand {
  const _$ExecuteSSActionCommandImpl(
      {required this.action,
      required this.value,
      required this.id,
      this.type = ExecuteSSActionCommand.TYPE});

  factory _$ExecuteSSActionCommandImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExecuteSSActionCommandImplFromJson(json);

  @override
  final SlideshowAction action;
  @override
  final bool value;
  @override
  final int id;
  @override
  @JsonKey()
  final String type;

  @override
  String toString() {
    return 'ExecuteSSActionCommand(action: $action, value: $value, id: $id, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExecuteSSActionCommandImpl &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, action, value, id, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExecuteSSActionCommandImplCopyWith<_$ExecuteSSActionCommandImpl>
      get copyWith => __$$ExecuteSSActionCommandImplCopyWithImpl<
          _$ExecuteSSActionCommandImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExecuteSSActionCommandImplToJson(
      this,
    );
  }
}

abstract class _ExecuteSSActionCommand implements ExecuteSSActionCommand {
  const factory _ExecuteSSActionCommand(
      {required final SlideshowAction action,
      required final bool value,
      required final int id,
      final String type}) = _$ExecuteSSActionCommandImpl;

  factory _ExecuteSSActionCommand.fromJson(Map<String, dynamic> json) =
      _$ExecuteSSActionCommandImpl.fromJson;

  @override
  SlideshowAction get action;
  @override
  bool get value;
  @override
  int get id;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$ExecuteSSActionCommandImplCopyWith<_$ExecuteSSActionCommandImpl>
      get copyWith => throw _privateConstructorUsedError;
}

LEDControlCommand _$LEDControlCommandFromJson(Map<String, dynamic> json) {
  return _LEDControlCommand.fromJson(json);
}

/// @nodoc
mixin _$LEDControlCommand {
  LEDType get led => throw _privateConstructorUsedError;
  bool get value => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LEDControlCommandCopyWith<LEDControlCommand> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LEDControlCommandCopyWith<$Res> {
  factory $LEDControlCommandCopyWith(
          LEDControlCommand value, $Res Function(LEDControlCommand) then) =
      _$LEDControlCommandCopyWithImpl<$Res, LEDControlCommand>;
  @useResult
  $Res call({LEDType led, bool value, int id, String type});
}

/// @nodoc
class _$LEDControlCommandCopyWithImpl<$Res, $Val extends LEDControlCommand>
    implements $LEDControlCommandCopyWith<$Res> {
  _$LEDControlCommandCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? led = null,
    Object? value = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      led: null == led
          ? _value.led
          : led // ignore: cast_nullable_to_non_nullable
              as LEDType,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LEDControlCommandImplCopyWith<$Res>
    implements $LEDControlCommandCopyWith<$Res> {
  factory _$$LEDControlCommandImplCopyWith(_$LEDControlCommandImpl value,
          $Res Function(_$LEDControlCommandImpl) then) =
      __$$LEDControlCommandImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({LEDType led, bool value, int id, String type});
}

/// @nodoc
class __$$LEDControlCommandImplCopyWithImpl<$Res>
    extends _$LEDControlCommandCopyWithImpl<$Res, _$LEDControlCommandImpl>
    implements _$$LEDControlCommandImplCopyWith<$Res> {
  __$$LEDControlCommandImplCopyWithImpl(_$LEDControlCommandImpl _value,
      $Res Function(_$LEDControlCommandImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? led = null,
    Object? value = null,
    Object? id = null,
    Object? type = null,
  }) {
    return _then(_$LEDControlCommandImpl(
      led: null == led
          ? _value.led
          : led // ignore: cast_nullable_to_non_nullable
              as LEDType,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LEDControlCommandImpl implements _LEDControlCommand {
  const _$LEDControlCommandImpl(
      {required this.led,
      required this.value,
      required this.id,
      this.type = LEDControlCommand.TYPE});

  factory _$LEDControlCommandImpl.fromJson(Map<String, dynamic> json) =>
      _$$LEDControlCommandImplFromJson(json);

  @override
  final LEDType led;
  @override
  final bool value;
  @override
  final int id;
  @override
  @JsonKey()
  final String type;

  @override
  String toString() {
    return 'LEDControlCommand(led: $led, value: $value, id: $id, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LEDControlCommandImpl &&
            (identical(other.led, led) || other.led == led) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, led, value, id, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LEDControlCommandImplCopyWith<_$LEDControlCommandImpl> get copyWith =>
      __$$LEDControlCommandImplCopyWithImpl<_$LEDControlCommandImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LEDControlCommandImplToJson(
      this,
    );
  }
}

abstract class _LEDControlCommand implements LEDControlCommand {
  const factory _LEDControlCommand(
      {required final LEDType led,
      required final bool value,
      required final int id,
      final String type}) = _$LEDControlCommandImpl;

  factory _LEDControlCommand.fromJson(Map<String, dynamic> json) =
      _$LEDControlCommandImpl.fromJson;

  @override
  LEDType get led;
  @override
  bool get value;
  @override
  int get id;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$LEDControlCommandImplCopyWith<_$LEDControlCommandImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
