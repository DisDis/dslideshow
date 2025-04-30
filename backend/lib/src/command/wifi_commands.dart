import 'package:dslideshow_common/rpc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wifi_commands.g.dart';
part 'wifi_commands.freezed.dart';

@freezed
sealed class WiFiScanCommand with _$WiFiScanCommand implements RpcCommand {
  static const String TYPE = 'wifi_scan';
  const factory WiFiScanCommand({
    required int id,
    @Default(WiFiScanCommand.TYPE) String type,
  }) = _WiFiScanCommand;

  factory WiFiScanCommand.fromJson(Map<String, dynamic> json) => _$WiFiScanCommandFromJson(json);
}

@freezed
sealed class WiFiScanResult with _$WiFiScanResult implements RpcResult {
  const factory WiFiScanResult({
    required List<WiFiNetworkInfo> networks,
    required int id,
  }) = _WiFiScanResult;

  factory WiFiScanResult.fromJson(Map<String, dynamic> json) => _$WiFiScanResultFromJson(json);
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

  factory WiFiNetworkInfo.fromJson(Map<String, dynamic> json) => _$WiFiNetworkInfoFromJson(json);
}

@freezed
sealed class WiFiConnectionInfo with _$WiFiConnectionInfo {
  const factory WiFiConnectionInfo({
    required String name,
    required String UUID,
    required String type,
    required String device,
  }) = _WiFiConnectionInfo;

  factory WiFiConnectionInfo.fromJson(Map<String, dynamic> json) => _$WiFiConnectionInfoFromJson(json);
}

@freezed
sealed class WiFiRemoveCommand with _$WiFiRemoveCommand implements RpcCommand {
  static const String TYPE = 'wifi_remove';
  const factory WiFiRemoveCommand({
    required String connectionId,
    required int id,
    @Default(WiFiRemoveCommand.TYPE) String type,
  }) = _WiFiRemoveCommand;

  factory WiFiRemoveCommand.fromJson(Map<String, dynamic> json) => _$WiFiRemoveCommandFromJson(json);
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

  factory WiFiAddCommand.fromJson(Map<String, dynamic> json) => _$WiFiAddCommandFromJson(json);
}

@freezed
sealed class WiFiGetConnectionsCommand with _$WiFiGetConnectionsCommand implements RpcCommand {
  static const String TYPE = 'wifi_get_connections';
  const factory WiFiGetConnectionsCommand({
    required int id,
    @Default(WiFiGetConnectionsCommand.TYPE) String type,
  }) = _WiFiGetConnectionsCommand;

  factory WiFiGetConnectionsCommand.fromJson(Map<String, dynamic> json) => _$WiFiGetConnectionsCommandFromJson(json);
}

@freezed
sealed class WiFiGetConnectionsResult with _$WiFiGetConnectionsResult implements RpcResult {
  const factory WiFiGetConnectionsResult({
    required List<WiFiConnectionInfo> networks,
    required int id,
  }) = _WiFiGetConnectionsResult;

  factory WiFiGetConnectionsResult.fromJson(Map<String, dynamic> json) => _$WiFiGetConnectionsResultFromJson(json);
}
