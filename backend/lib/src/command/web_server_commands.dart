
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_common/rpc.dart';

part 'web_server_commands.g.dart';


abstract class WebServerControlCommand implements RpcCommand, Built<WebServerControlCommand, WebServerControlCommandBuilder> {
  static const String TYPE = 'web_server_control';
  @override
  String get type => TYPE;
  bool get enable;
  @override
  @nullable
  int get id;

  static Serializer<WebServerControlCommand> get serializer =>
      _$webServerControlCommandSerializer;

  factory WebServerControlCommand([void updates(WebServerControlCommandBuilder b)]) = _$WebServerControlCommand;
  WebServerControlCommand._();
}