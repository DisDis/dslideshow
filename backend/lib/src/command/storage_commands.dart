
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:dslideshow_common/rpc.dart';

part 'storage_commands.g.dart';


abstract class GetMediaItemCommand implements RpcCommand, Built<GetMediaItemCommand, GetMediaItemCommandBuilder> {
  static const String TYPE = 'get_media_item';
  @override
  String get type => TYPE;

  bool get isCurrent;
  @override
  int get id;

  static Serializer<GetMediaItemCommand> get serializer =>
      _$getMediaItemCommandSerializer;

  factory GetMediaItemCommand([void updates(GetMediaItemCommandBuilder b)?]) = _$GetMediaItemCommand;
  GetMediaItemCommand._();
}

abstract class GetMediaItemCommandResult implements RpcResult, Built<GetMediaItemCommandResult, GetMediaItemCommandResultBuilder> {
  String? get mediaId;
  Uri? get mediaUri;
  @override
  int get id;

  static Serializer<GetMediaItemCommandResult> get serializer =>
      _$getMediaItemCommandResultSerializer;

  factory GetMediaItemCommandResult([void updates(GetMediaItemCommandResultBuilder b)?]) = _$GetMediaItemCommandResult;
  GetMediaItemCommandResult._();
}


abstract class StorageNextCommand implements RpcCommand, Built<StorageNextCommand, StorageNextCommandBuilder> {
  static const String TYPE = 'storage_next';
  @override
  String get type => TYPE;

  @override
  int get id;

  static Serializer<StorageNextCommand> get serializer =>
      _$storageNextCommandSerializer;

  factory StorageNextCommand([void updates(StorageNextCommandBuilder b)?]) = _$StorageNextCommand;
  StorageNextCommand._();
}