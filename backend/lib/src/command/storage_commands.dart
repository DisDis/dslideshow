
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
  @nullable
  int get id;

  static Serializer<GetMediaItemCommand> get serializer =>
      _$getMediaItemCommandSerializer;

  factory GetMediaItemCommand([void updates(GetMediaItemCommandBuilder b)]) = _$GetMediaItemCommand;
  GetMediaItemCommand._();
}

abstract class GetMediaItemCommandResult implements RpcResult, Built<GetMediaItemCommandResult, GetMediaItemCommandResultBuilder> {
  @nullable
  String get mediaId;
  @nullable
  Uri get mediaUri;
  @override
  @nullable
  int get id;

  static Serializer<GetMediaItemCommandResult> get serializer =>
      _$getMediaItemCommandResultSerializer;

  factory GetMediaItemCommandResult([void updates(GetMediaItemCommandResultBuilder b)]) = _$GetMediaItemCommandResult;
  GetMediaItemCommandResult._();
}


abstract class StorageNextCommand implements RpcCommand, Built<StorageNextCommand, StorageNextCommandBuilder> {
  static const String TYPE = 'storage_next';
  @override
  String get type => TYPE;

  @override
  @nullable
  int get id;

  static Serializer<StorageNextCommand> get serializer =>
      _$storageNextCommandSerializer;

  factory StorageNextCommand([void updates(StorageNextCommandBuilder b)]) = _$StorageNextCommand;
  StorageNextCommand._();
}

abstract class StorageEmptyResult implements RpcResult, Built<StorageEmptyResult, StorageEmptyResultBuilder> {
  @override
  @nullable
  int get id;

  static Serializer<StorageEmptyResult> get serializer => _$storageEmptyResultSerializer;


  factory StorageEmptyResult([void updates(StorageEmptyResultBuilder b)]) = _$StorageEmptyResult;
  StorageEmptyResult._();
}