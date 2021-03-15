import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:built_collection/built_collection.dart';

part 'hardware_commands.g.dart';

abstract class AreYouReadyCommand implements RpcCommand, Built<AreYouReadyCommand, AreYouReadyCommandBuilder> {
  static const String TYPE = 'are_you_ready?';
  @override
  String get type => TYPE;
  @override
  int get id;

  static Serializer<AreYouReadyCommand> get serializer =>
      _$areYouReadyCommandSerializer;

  factory AreYouReadyCommand([void updates(AreYouReadyCommandBuilder b)?]) = _$AreYouReadyCommand;
  AreYouReadyCommand._();
}

abstract class PushButtonCommand implements RpcCommand, Built<PushButtonCommand, PushButtonCommandBuilder> {
  static const String TYPE = 'push_button';
  @override
  String get type => TYPE;
  ButtonType get button;
  @override
  int get id;

  static Serializer<PushButtonCommand> get serializer =>
      _$pushButtonCommandSerializer;

  factory PushButtonCommand([void updates(PushButtonCommandBuilder b)?]) = _$PushButtonCommand;
  PushButtonCommand._();
}


abstract class LEDControlCommand implements RpcCommand, Built<LEDControlCommand,LEDControlCommandBuilder> {
  static const String TYPE = 'led_control';
  @override
  String get type => TYPE;
  LEDType get led;
  bool get value;
  @override
  int get id;

  static Serializer<LEDControlCommand> get serializer =>
      _$lEDControlCommandSerializer;

  factory LEDControlCommand([void updates(LEDControlCommandBuilder b)?]) = _$LEDControlCommand;
  LEDControlCommand._();
}

class LEDType extends EnumClass {
  static Serializer<LEDType> get serializer => _$lEDTypeSerializer;

  static const LEDType power = _$powerLed;

  const LEDType._(String name) : super(name);

  static BuiltSet<LEDType> get values => _$valuesLEDType;
  static LEDType valueOf(String name) => _$valueLEDTypeOf(name);
}

class ButtonType extends EnumClass {
  static Serializer<ButtonType> get serializer => _$buttonTypeSerializer;

  static const ButtonType menu = _$menu;
  static const ButtonType screentoggle = _$screentoggle;
  static const ButtonType pause = _$pause;

  const ButtonType._(String name) : super(name);

  static BuiltSet<ButtonType> get values => _$valuesButtonType;
  static ButtonType valueOf(String name) => _$valueButtonTypeOf(name);
}