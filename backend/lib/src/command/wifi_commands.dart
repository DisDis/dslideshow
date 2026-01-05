import 'package:dslideshow_common/rpc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wifi_commands.g.dart';
part 'wifi_commands.freezed.dart';

@freezed
sealed class WiFiRescanCommand with _$WiFiRescanCommand implements RpcCommand {
  static const String TYPE = 'wifi_rescan';
  const factory WiFiRescanCommand({
    required int id,
    @Default(WiFiRescanCommand.TYPE) String type,
  }) = _WiFiRescanCommand;

  factory WiFiRescanCommand.fromJson(Map<String, dynamic> json) =>
      _$WiFiRescanCommandFromJson(json);
}

@freezed
sealed class WiFiListCommand with _$WiFiListCommand implements RpcCommand {
  static const String TYPE = 'wifi_list';
  const factory WiFiListCommand({
    required int id,
    @Default(WiFiListCommand.TYPE) String type,
  }) = _WiFiListCommand;

  factory WiFiListCommand.fromJson(Map<String, dynamic> json) =>
      _$WiFiListCommandFromJson(json);
}

@freezed
sealed class WiFiListResult with _$WiFiListResult implements RpcResult {
  const factory WiFiListResult({
    required List<WiFiNetworkInfo> networks,
    required int id,
  }) = _WiFiListResult;

  factory WiFiListResult.fromJson(Map<String, dynamic> json) =>
      _$WiFiListResultFromJson(json);
}

@freezed
sealed class WiFiNetworkInfo with _$WiFiNetworkInfo {
  const factory WiFiNetworkInfo({
    required String BSSID,
    required String SSID,
    required int signal,
    required int channel,
    required int rate,
    required String security,
  }) = _WiFiNetworkInfo;

  factory WiFiNetworkInfo.fromJson(Map<String, dynamic> json) =>
      _$WiFiNetworkInfoFromJson(json);
}

@freezed
sealed class WiFiConnectionInfo with _$WiFiConnectionInfo {
  const factory WiFiConnectionInfo({
    required String name,
    required String UUID,
    required String type,
    required String device,
  }) = _WiFiConnectionInfo;

  factory WiFiConnectionInfo.fromJson(Map<String, dynamic> json) =>
      _$WiFiConnectionInfoFromJson(json);
}

@freezed
sealed class WiFiRemoveCommand with _$WiFiRemoveCommand implements RpcCommand {
  static const String TYPE = 'wifi_remove';
  const factory WiFiRemoveCommand({
    required String connectionId,
    required int id,
    @Default(WiFiRemoveCommand.TYPE) String type,
  }) = _WiFiRemoveCommand;

  factory WiFiRemoveCommand.fromJson(Map<String, dynamic> json) =>
      _$WiFiRemoveCommandFromJson(json);
}

// @freezed
// sealed class WiFiSaveConfigCommand with _$WiFiSaveConfigCommand implements RpcCommand {
//   static const String TYPE = 'wifi_savecfg';
//   const factory WiFiSaveConfigCommand({
//     required int id,
//     @Default(WiFiSaveConfigCommand.TYPE) String type,
//   }) = _WiFiSaveConfigCommand;

//   factory WiFiSaveConfigCommand.fromJson(Map<String, dynamic> json) => _$WiFiSaveConfigCommandFromJson(json);
// }

@freezed
sealed class WiFiAddCommand with _$WiFiAddCommand implements RpcCommand {
  static const String TYPE = 'wifi_add';
  const factory WiFiAddCommand({
    required String name,
    required String SSID,
    required String psk,
    required int id,
    @Default(WiFiAddCommand.TYPE) String type,
  }) = _WiFiAddCommand;

  factory WiFiAddCommand.fromJson(Map<String, dynamic> json) =>
      _$WiFiAddCommandFromJson(json);
}

@freezed
sealed class WiFiGetConnectionsCommand
    with _$WiFiGetConnectionsCommand
    implements RpcCommand {
  static const String TYPE = 'wifi_get_connections';
  const factory WiFiGetConnectionsCommand({
    required int id,
    @Default(WiFiGetConnectionsCommand.TYPE) String type,
  }) = _WiFiGetConnectionsCommand;

  factory WiFiGetConnectionsCommand.fromJson(Map<String, dynamic> json) =>
      _$WiFiGetConnectionsCommandFromJson(json);
}

@freezed
sealed class WiFiGetConnectionsResult
    with _$WiFiGetConnectionsResult
    implements RpcResult {
  const factory WiFiGetConnectionsResult({
    required List<WiFiConnectionInfo> networks,
    required int id,
  }) = _WiFiGetConnectionsResult;

  factory WiFiGetConnectionsResult.fromJson(Map<String, dynamic> json) =>
      _$WiFiGetConnectionsResultFromJson(json);
}
