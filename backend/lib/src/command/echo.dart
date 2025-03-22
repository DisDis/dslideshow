import 'package:dslideshow_common/rpc.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'echo.freezed.dart';
part 'echo.g.dart';

@freezed
sealed class EchoCommand with _$EchoCommand implements RpcCommand {
  static const String TYPE = 'echo';

  const factory EchoCommand({required int id, String? text, @Default(EchoCommand.TYPE) String type}) = _EchoCommand;
  factory EchoCommand.fromJson(Map<String, dynamic> json) => _$EchoCommandFromJson(json);
}

@freezed
abstract class EchoCommandResult with _$EchoCommandResult implements RpcResult {
  const factory EchoCommandResult({required int id, String? resultText}) = _EchoCommandResult;
  factory EchoCommandResult.fromJson(Map<String, dynamic> json) => _$EchoCommandResultFromJson(json);
}
