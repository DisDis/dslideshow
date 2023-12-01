import 'package:dslideshow_common/rpc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'storage_commands.g.dart';
part 'storage_commands.freezed.dart';

@freezed
class GetMediaItemCommand with _$GetMediaItemCommand implements RpcCommand {
  static const String TYPE = 'get_media_item';
  const factory GetMediaItemCommand({
    required bool isCurrent,
    required int id,
    @Default(GetMediaItemCommand.TYPE) String type,
  }) = _GetMediaItemCommand;

  factory GetMediaItemCommand.fromJson(Map<String, dynamic> json) => _$GetMediaItemCommandFromJson(json);
}

@freezed
class GetMediaItemCommandResult with _$GetMediaItemCommandResult implements RpcResult {
  const factory GetMediaItemCommandResult({
    String? mediaId,
    Uri? mediaUri,
    required int id,
  }) = _GetMediaItemCommandResult;

  factory GetMediaItemCommandResult.fromJson(Map<String, dynamic> json) => _$GetMediaItemCommandResultFromJson(json);
}

@freezed
class StorageNextCommand with _$StorageNextCommand implements RpcCommand {
  static const String TYPE = 'storage_next';

  const factory StorageNextCommand({
    required int id,
    @Default(StorageNextCommand.TYPE) String type,
  }) = _StorageNextCommand;

  factory StorageNextCommand.fromJson(Map<String, dynamic> json) => _$StorageNextCommandFromJson(json);
}
