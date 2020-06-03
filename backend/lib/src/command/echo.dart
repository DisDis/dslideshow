import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:dslideshow_common/rpc.dart';

part 'echo.g.dart';

abstract class EchoCommand implements RpcCommand, Built<EchoCommand, EchoCommandBuilder> {
  static const String TYPE = 'echo';
  @override
  String get type => TYPE;
  String get text;
  @override
  @nullable
  int get id;

  static Serializer<EchoCommand> get serializer =>
      _$echoCommandSerializer;

  factory EchoCommand([void updates(EchoCommandBuilder b)]) = _$EchoCommand;
  EchoCommand._();
}

abstract class EchoCommandResult implements RpcResult, Built<EchoCommandResult, EchoCommandResultBuilder> {
  String get resultText;
  @override
  @nullable
  int get id;

  static Serializer<EchoCommandResult> get serializer =>
      _$echoCommandResultSerializer;

  factory EchoCommandResult([void updates(EchoCommandResultBuilder b)]) = _$EchoCommandResult;
  EchoCommandResult._();
}
