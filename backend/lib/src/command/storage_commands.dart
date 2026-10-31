// Freezed forwards factory annotations to the generated implementation.
// ignore_for_file: invalid_annotation_target
import 'package:dslideshow_common/rpc.dart';
import 'package:dslideshow_common/storage_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'storage_commands.g.dart';
part 'storage_commands.freezed.dart';

@freezed
sealed class StorageStatusCommand with _$StorageStatusCommand implements RpcCommand {
  static const String TYPE = 'storage_status';

  const factory StorageStatusCommand({
    required int id,
    @JsonKey(unknownEnumValue: StorageStatusEnum.off) required StorageStatusEnum status,
    @Default(StorageStatusCommand.TYPE) String type,
  }) = _StorageStatusCommand;

  factory StorageStatusCommand.fromJson(Map<String, dynamic> json) => _$StorageStatusCommandFromJson(json);
}

@freezed
sealed class GetMediaItemCommand with _$GetMediaItemCommand implements RpcCommand {
  static const String TYPE = 'get_media_item';
  const factory GetMediaItemCommand({
    required bool isCurrent,
    required int id,
    @Default(GetMediaItemCommand.TYPE) String type,
  }) = _GetMediaItemCommand;

  factory GetMediaItemCommand.fromJson(Map<String, dynamic> json) => _$GetMediaItemCommandFromJson(json);
}

@freezed
sealed class GetMediaItemCommandResult with _$GetMediaItemCommandResult implements RpcResult {
  const factory GetMediaItemCommandResult({String? mediaId, Uri? mediaUri, required int id}) =
      _GetMediaItemCommandResult;

  factory GetMediaItemCommandResult.fromJson(Map<String, dynamic> json) => _$GetMediaItemCommandResultFromJson(json);
}

@freezed
sealed class StorageNextCommand with _$StorageNextCommand implements RpcCommand {
  static const String TYPE = 'storage_next';

  const factory StorageNextCommand({required int id, @Default(StorageNextCommand.TYPE) String type}) =
      _StorageNextCommand;

  factory StorageNextCommand.fromJson(Map<String, dynamic> json) => _$StorageNextCommandFromJson(json);
}
