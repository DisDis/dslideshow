// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hardware_commands.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const LEDType _$powerLed = const LEDType._('power');

LEDType _$valueLEDTypeOf(String name) {
  switch (name) {
    case 'power':
      return _$powerLed;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<LEDType> _$valuesLEDType = new BuiltSet<LEDType>(const <LEDType>[
  _$powerLed,
]);

const ButtonType _$menu = const ButtonType._('menu');
const ButtonType _$screentoggle = const ButtonType._('screentoggle');
const ButtonType _$pause = const ButtonType._('pause');

ButtonType _$valueButtonTypeOf(String name) {
  switch (name) {
    case 'menu':
      return _$menu;
    case 'screentoggle':
      return _$screentoggle;
    case 'pause':
      return _$pause;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<ButtonType> _$valuesButtonType =
    new BuiltSet<ButtonType>(const <ButtonType>[
  _$menu,
  _$screentoggle,
  _$pause,
]);

Serializer<AreYouReadyCommand> _$areYouReadyCommandSerializer =
    new _$AreYouReadyCommandSerializer();
Serializer<PushButtonCommand> _$pushButtonCommandSerializer =
    new _$PushButtonCommandSerializer();
Serializer<LEDControlCommand> _$lEDControlCommandSerializer =
    new _$LEDControlCommandSerializer();
Serializer<LEDType> _$lEDTypeSerializer = new _$LEDTypeSerializer();
Serializer<ButtonType> _$buttonTypeSerializer = new _$ButtonTypeSerializer();

class _$AreYouReadyCommandSerializer
    implements StructuredSerializer<AreYouReadyCommand> {
  @override
  final Iterable<Type> types = const [AreYouReadyCommand, _$AreYouReadyCommand];
  @override
  final String wireName = 'AreYouReadyCommand';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, AreYouReadyCommand object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  AreYouReadyCommand deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AreYouReadyCommandBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$PushButtonCommandSerializer
    implements StructuredSerializer<PushButtonCommand> {
  @override
  final Iterable<Type> types = const [PushButtonCommand, _$PushButtonCommand];
  @override
  final String wireName = 'PushButtonCommand';

  @override
  Iterable<Object?> serialize(Serializers serializers, PushButtonCommand object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'button',
      serializers.serialize(object.button,
          specifiedType: const FullType(ButtonType)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  PushButtonCommand deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PushButtonCommandBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'button':
          result.button = serializers.deserialize(value,
              specifiedType: const FullType(ButtonType)) as ButtonType;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$LEDControlCommandSerializer
    implements StructuredSerializer<LEDControlCommand> {
  @override
  final Iterable<Type> types = const [LEDControlCommand, _$LEDControlCommand];
  @override
  final String wireName = 'LEDControlCommand';

  @override
  Iterable<Object?> serialize(Serializers serializers, LEDControlCommand object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'led',
      serializers.serialize(object.led, specifiedType: const FullType(LEDType)),
      'value',
      serializers.serialize(object.value, specifiedType: const FullType(bool)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  LEDControlCommand deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new LEDControlCommandBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'led':
          result.led = serializers.deserialize(value,
              specifiedType: const FullType(LEDType)) as LEDType;
          break;
        case 'value':
          result.value = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$LEDTypeSerializer implements PrimitiveSerializer<LEDType> {
  @override
  final Iterable<Type> types = const <Type>[LEDType];
  @override
  final String wireName = 'LEDType';

  @override
  Object serialize(Serializers serializers, LEDType object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  LEDType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      LEDType.valueOf(serialized as String);
}

class _$ButtonTypeSerializer implements PrimitiveSerializer<ButtonType> {
  @override
  final Iterable<Type> types = const <Type>[ButtonType];
  @override
  final String wireName = 'ButtonType';

  @override
  Object serialize(Serializers serializers, ButtonType object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  ButtonType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ButtonType.valueOf(serialized as String);
}

class _$AreYouReadyCommand extends AreYouReadyCommand {
  @override
  final int id;

  factory _$AreYouReadyCommand(
          [void Function(AreYouReadyCommandBuilder)? updates]) =>
      (new AreYouReadyCommandBuilder()..update(updates)).build();

  _$AreYouReadyCommand._({required this.id}) : super._() {
    BuiltValueNullFieldError.checkNotNull(id, 'AreYouReadyCommand', 'id');
  }

  @override
  AreYouReadyCommand rebuild(
          void Function(AreYouReadyCommandBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AreYouReadyCommandBuilder toBuilder() =>
      new AreYouReadyCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AreYouReadyCommand && id == other.id;
  }

  @override
  int get hashCode {
    return $jf($jc(0, id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AreYouReadyCommand')..add('id', id))
        .toString();
  }
}

class AreYouReadyCommandBuilder
    implements Builder<AreYouReadyCommand, AreYouReadyCommandBuilder> {
  _$AreYouReadyCommand? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  AreYouReadyCommandBuilder();

  AreYouReadyCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AreYouReadyCommand other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AreYouReadyCommand;
  }

  @override
  void update(void Function(AreYouReadyCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$AreYouReadyCommand build() {
    final _$result = _$v ??
        new _$AreYouReadyCommand._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, 'AreYouReadyCommand', 'id'));
    replace(_$result);
    return _$result;
  }
}

class _$PushButtonCommand extends PushButtonCommand {
  @override
  final ButtonType button;
  @override
  final int id;

  factory _$PushButtonCommand(
          [void Function(PushButtonCommandBuilder)? updates]) =>
      (new PushButtonCommandBuilder()..update(updates)).build();

  _$PushButtonCommand._({required this.button, required this.id}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        button, 'PushButtonCommand', 'button');
    BuiltValueNullFieldError.checkNotNull(id, 'PushButtonCommand', 'id');
  }

  @override
  PushButtonCommand rebuild(void Function(PushButtonCommandBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PushButtonCommandBuilder toBuilder() =>
      new PushButtonCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PushButtonCommand &&
        button == other.button &&
        id == other.id;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, button.hashCode), id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PushButtonCommand')
          ..add('button', button)
          ..add('id', id))
        .toString();
  }
}

class PushButtonCommandBuilder
    implements Builder<PushButtonCommand, PushButtonCommandBuilder> {
  _$PushButtonCommand? _$v;

  ButtonType? _button;
  ButtonType? get button => _$this._button;
  set button(ButtonType? button) => _$this._button = button;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  PushButtonCommandBuilder();

  PushButtonCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _button = $v.button;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PushButtonCommand other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PushButtonCommand;
  }

  @override
  void update(void Function(PushButtonCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PushButtonCommand build() {
    final _$result = _$v ??
        new _$PushButtonCommand._(
            button: BuiltValueNullFieldError.checkNotNull(
                button, 'PushButtonCommand', 'button'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, 'PushButtonCommand', 'id'));
    replace(_$result);
    return _$result;
  }
}

class _$LEDControlCommand extends LEDControlCommand {
  @override
  final LEDType led;
  @override
  final bool value;
  @override
  final int id;

  factory _$LEDControlCommand(
          [void Function(LEDControlCommandBuilder)? updates]) =>
      (new LEDControlCommandBuilder()..update(updates)).build();

  _$LEDControlCommand._(
      {required this.led, required this.value, required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(led, 'LEDControlCommand', 'led');
    BuiltValueNullFieldError.checkNotNull(value, 'LEDControlCommand', 'value');
    BuiltValueNullFieldError.checkNotNull(id, 'LEDControlCommand', 'id');
  }

  @override
  LEDControlCommand rebuild(void Function(LEDControlCommandBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LEDControlCommandBuilder toBuilder() =>
      new LEDControlCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LEDControlCommand &&
        led == other.led &&
        value == other.value &&
        id == other.id;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, led.hashCode), value.hashCode), id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('LEDControlCommand')
          ..add('led', led)
          ..add('value', value)
          ..add('id', id))
        .toString();
  }
}

class LEDControlCommandBuilder
    implements Builder<LEDControlCommand, LEDControlCommandBuilder> {
  _$LEDControlCommand? _$v;

  LEDType? _led;
  LEDType? get led => _$this._led;
  set led(LEDType? led) => _$this._led = led;

  bool? _value;
  bool? get value => _$this._value;
  set value(bool? value) => _$this._value = value;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  LEDControlCommandBuilder();

  LEDControlCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _led = $v.led;
      _value = $v.value;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LEDControlCommand other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$LEDControlCommand;
  }

  @override
  void update(void Function(LEDControlCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$LEDControlCommand build() {
    final _$result = _$v ??
        new _$LEDControlCommand._(
            led: BuiltValueNullFieldError.checkNotNull(
                led, 'LEDControlCommand', 'led'),
            value: BuiltValueNullFieldError.checkNotNull(
                value, 'LEDControlCommand', 'value'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, 'LEDControlCommand', 'id'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
