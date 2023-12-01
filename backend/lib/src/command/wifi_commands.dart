import 'package:dslideshow_common/rpc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wifi_commands.g.dart';
part 'wifi_commands.freezed.dart';

@freezed
class WiFiScanCommand with _$WiFiScanCommand implements RpcCommand {
  static const String TYPE = 'wifi_scan';
  const factory WiFiScanCommand({
    required int id,
    @Default(WiFiScanCommand.TYPE) String type,
  }) = _WiFiScanCommand;

  factory WiFiScanCommand.fromJson(Map<String, dynamic> json) => _$WiFiScanCommandFromJson(json);
}

@freezed
class WiFiScanResult with _$WiFiScanResult implements RpcResult {
  const factory WiFiScanResult({
    required List<WiFiNetworkInfo> networks,
    required int id,
  }) = _WiFiScanResult;

  factory WiFiScanResult.fromJson(Map<String, dynamic> json) => _$WiFiScanResultFromJson(json);
}

@freezed
class WiFiNetworkInfo with _$WiFiNetworkInfo {
  const factory WiFiNetworkInfo({
    required String SSID,
    required int signal,
    required String capability,
    required int freq,
  }) = _WiFiNetworkInfo;

  factory WiFiNetworkInfo.fromJson(Map<String, dynamic> json) => _$WiFiNetworkInfoFromJson(json);
}

@freezed
class WiFiStoredNetworkInfo with _$WiFiStoredNetworkInfo {
  const factory WiFiStoredNetworkInfo({
    required int id,
    required String SSID,
    required bool disabled,
  }) = _WiFiStoredNetworkInfo;

  factory WiFiStoredNetworkInfo.fromJson(Map<String, dynamic> json) => _$WiFiStoredNetworkInfoFromJson(json);
}

@freezed
class WiFiRemoveCommand with _$WiFiRemoveCommand implements RpcCommand {
  static const String TYPE = 'wifi_remove';
  const factory WiFiRemoveCommand({
    required int wifiId,
    required int id,
    @Default(WiFiRemoveCommand.TYPE) String type,
  }) = _WiFiRemoveCommand;

  factory WiFiRemoveCommand.fromJson(Map<String, dynamic> json) => _$WiFiRemoveCommandFromJson(json);
}

@freezed
class WiFiSaveConfigCommand with _$WiFiSaveConfigCommand implements RpcCommand {
  static const String TYPE = 'wifi_savecfg';
  const factory WiFiSaveConfigCommand({
    required int id,
    @Default(WiFiSaveConfigCommand.TYPE) String type,
  }) = _WiFiSaveConfigCommand;

  factory WiFiSaveConfigCommand.fromJson(Map<String, dynamic> json) => _$WiFiSaveConfigCommandFromJson(json);
}

@freezed
class WiFiAddCommand with _$WiFiAddCommand implements RpcCommand {
  static const String TYPE = 'wifi_add';
  const factory WiFiAddCommand({
    required String SSID,
    required String psk,
    required int id,
    @Default(WiFiAddCommand.TYPE) String type,
  }) = _WiFiAddCommand;

  factory WiFiAddCommand.fromJson(Map<String, dynamic> json) => _$WiFiAddCommandFromJson(json);
}

@freezed
class WiFiGetStoredCommand with _$WiFiGetStoredCommand implements RpcCommand {
  static const String TYPE = 'wifi_get_stored';
  const factory WiFiGetStoredCommand({
    required int id,
    @Default(WiFiGetStoredCommand.TYPE) String type,
  }) = _WiFiGetStoredCommand;

  factory WiFiGetStoredCommand.fromJson(Map<String, dynamic> json) => _$WiFiGetStoredCommandFromJson(json);
}

@freezed
class WiFiGetStoredResult with _$WiFiGetStoredResult implements RpcResult {
  const factory WiFiGetStoredResult({
    required List<WiFiStoredNetworkInfo> networks,
    required int id,
  }) = _WiFiGetStoredResult;

  factory WiFiGetStoredResult.fromJson(Map<String, dynamic> json) => _$WiFiGetStoredResultFromJson(json);
}
