import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:dslideshow_backend/src/service/system_info/system_info.dart';
import 'package:dslideshow_common/rpc.dart';

part 'system_info_commands.g.dart';

abstract class GetSystemInfoCommand implements RpcCommand, Built<GetSystemInfoCommand, GetSystemInfoCommandBuilder> {
  static const String TYPE = 'get_system_info_command';
  @override
  String get type => TYPE;

  @override
  @nullable
  int get id;

  static Serializer<GetSystemInfoCommand> get serializer =>
      _$getSystemInfoCommandSerializer;

  factory GetSystemInfoCommand([void updates(GetSystemInfoCommandBuilder b)?]) = _$GetSystemInfoCommand;
  GetSystemInfoCommand._();
}

abstract class GetSystemInfoCommandResult implements RpcResult, Built<GetSystemInfoCommandResult, GetSystemInfoCommandResultBuilder> {
  SystemInfo get systemInfo;

  @override
  @nullable
  int get id;

  static Serializer<GetSystemInfoCommandResult> get serializer =>
      _$getSystemInfoCommandResultSerializer;

  factory GetSystemInfoCommandResult([void updates(GetSystemInfoCommandResultBuilder b)?]) = _$GetSystemInfoCommandResult;

  GetSystemInfoCommandResult._();
}