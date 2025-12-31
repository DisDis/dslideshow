import 'package:dslideshow_common/rpc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ota_commands.freezed.dart';
part 'ota_commands.g.dart';

@freezed
sealed class OTAReadyCommand with _$OTAReadyCommand implements RpcCommand {
  static const String TYPE = 'ota_ready';
  //
  //RpcCommand.generateId
  const factory OTAReadyCommand({
    required bool ready,
    required int id,
    @Default(OTAReadyCommand.TYPE) String type,
  }) = _OTAReadyCommand;
  factory OTAReadyCommand.fromJson(Map<String, dynamic> json) =>
      _$OTAReadyCommandFromJson(json);
}

@freezed
sealed class OTAGetInfoCommand with _$OTAGetInfoCommand implements RpcCommand {
  static const String TYPE = 'ota_getinfo';

  const factory OTAGetInfoCommand({
    OTAInfo? info,
    required int id,
    @Default(OTAGetInfoCommand.TYPE) String type,
  }) = _OTAGetInfoCommand;
  factory OTAGetInfoCommand.fromJson(Map<String, dynamic> json) =>
      _$OTAGetInfoCommandFromJson(json);
}

@freezed
sealed class OTAGetInfoCommandResult
    with _$OTAGetInfoCommandResult
    implements RpcResult {
  const factory OTAGetInfoCommandResult({
    required OTAInfo info,
    required int id,
  }) = _OTAGetInfoCommandResult;
  factory OTAGetInfoCommandResult.fromJson(Map<String, dynamic> json) =>
      _$OTAGetInfoCommandResultFromJson(json);
}

@freezed
sealed class OTAOutputCommand with _$OTAOutputCommand implements RpcCommand {
  static const String TYPE = 'ota_output';

  const factory OTAOutputCommand({
    required int id,
    required String output,
    @Default(OTAOutputCommand.TYPE) String type,
  }) = _OTAOutputCommand;
  factory OTAOutputCommand.fromJson(Map<String, dynamic> json) =>
      _$OTAOutputCommandFromJson(json);
}

@freezed
abstract class OTAInfo with _$OTAInfo {
  const factory OTAInfo({
    required OTAStatus status,
    required double uploadingPercent,
    required String code,
    int? exitCode,
    String? errorText,
  }) = _OTAInfo;
  factory OTAInfo.fromJson(Map<String, dynamic> json) =>
      _$OTAInfoFromJson(json);
}

enum OTAStatus {
  disabled,
  ready,
  uploading,
  instaling,
  finished,
  issue,
  preReboot,
}
