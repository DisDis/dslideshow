import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:dslideshow_common/rpc.dart';

part 'screen_commands.g.dart';

abstract class ScreenTurnCommand implements RpcCommand, Built<ScreenTurnCommand, ScreenTurnCommandBuilder> {
  static const String TYPE = 'screen_turn';
  @override
  String get type => TYPE;
  bool get enabled;
  @override
  @nullable
  int get id;

  static Serializer<ScreenTurnCommand> get serializer =>
      _$screenTurnCommandSerializer;

  factory ScreenTurnCommand([void updates(ScreenTurnCommandBuilder b)]) = _$ScreenTurnCommand;
  ScreenTurnCommand._();
}