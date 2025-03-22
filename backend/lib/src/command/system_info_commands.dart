import 'package:dslideshow_backend/src/service/system_info/system_info.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'system_info_commands.g.dart';
part 'system_info_commands.freezed.dart';

@freezed
sealed class GetSystemInfoCommand with _$GetSystemInfoCommand implements RpcCommand {
  static const String TYPE = 'get_system_info_command';

  const factory GetSystemInfoCommand({
    required int id,
    @Default(GetSystemInfoCommand.TYPE) String type,
  }) = _GetSystemInfoCommand;

  factory GetSystemInfoCommand.fromJson(Map<String, dynamic> json) => _$GetSystemInfoCommandFromJson(json);
}

@freezed
sealed class GetSystemInfoCommandResult with _$GetSystemInfoCommandResult implements RpcResult {
  const factory GetSystemInfoCommandResult({
    required SystemInfo systemInfo,
    required int id,
  }) = _GetSystemInfoCommandResult;

  factory GetSystemInfoCommandResult.fromJson(Map<String, dynamic> json) => _$GetSystemInfoCommandResultFromJson(json);
}
