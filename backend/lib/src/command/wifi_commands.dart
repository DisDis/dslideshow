import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:built_collection/built_collection.dart';

part 'wifi_commands.g.dart';

abstract class WiFiScanCommand implements RpcCommand, Built<WiFiScanCommand, WiFiScanCommandBuilder> {
  static const String TYPE = 'wifi_scan';
  @override
  String get type => TYPE;
  @override
  int get id;

  static Serializer<WiFiScanCommand> get serializer => _$wiFiScanCommandSerializer;
  @BuiltValueHook(initializeBuilder: true)
  static void _setDefaults(WiFiScanCommandBuilder b) => b.id = RpcCommand.generateId();
  factory WiFiScanCommand([void updates(WiFiScanCommandBuilder b)?]) = _$WiFiScanCommand;
  WiFiScanCommand._();
}

abstract class WiFiScanResult implements RpcResult, Built<WiFiScanResult, WiFiScanResultBuilder> {
  @override
  int get id;

  BuiltList<WiFiNetworkInfo>? get networks;

  static Serializer<WiFiScanResult> get serializer => _$wiFiScanResultSerializer;

  factory WiFiScanResult([void updates(WiFiScanResultBuilder b)?]) = _$WiFiScanResult;
  factory WiFiScanResult.respond(RpcCommand command) {
    return _$WiFiScanResult((b) => b.id = command.id);
  }
  WiFiScanResult._();
}

abstract class WiFiNetworkInfo implements Built<WiFiNetworkInfo, WiFiNetworkInfoBuilder> {
  String get SSID;
  String get signal;
  String get capability;
  int get freq;

  @BuiltValueHook(initializeBuilder: true)
  static void _setDefaults(WiFiNetworkInfoBuilder b) => b
    ..SSID = ''
    ..signal = ''
    ..capability = ''
    ..freq = -1;

  static Serializer<WiFiNetworkInfo> get serializer => _$wiFiNetworkInfoSerializer;

  factory WiFiNetworkInfo([void updates(WiFiNetworkInfoBuilder b)]) = _$WiFiNetworkInfo;
  WiFiNetworkInfo._();
}

abstract class WiFiStoredNetworkInfo implements Built<WiFiStoredNetworkInfo, WiFiStoredNetworkInfoBuilder> {
  int get id;
  String get SSID;
  String get psk;

  static Serializer<WiFiStoredNetworkInfo> get serializer => _$wiFiStoredNetworkInfoSerializer;

  factory WiFiStoredNetworkInfo([void updates(WiFiStoredNetworkInfoBuilder b)]) = _$WiFiStoredNetworkInfo;
  WiFiStoredNetworkInfo._();
}

abstract class WiFiRemoveCommand implements RpcCommand, Built<WiFiRemoveCommand, WiFiRemoveCommandBuilder> {
  static const String TYPE = 'wifi_remove';
  @override
  String get type => TYPE;
  @override
  int get id;
  int get wifiId;

  static Serializer<WiFiRemoveCommand> get serializer => _$wiFiRemoveCommandSerializer;
  @BuiltValueHook(initializeBuilder: true)
  static void _setDefaults(WiFiRemoveCommandBuilder b) => b.id = RpcCommand.generateId();
  factory WiFiRemoveCommand([void updates(WiFiRemoveCommandBuilder b)?]) = _$WiFiRemoveCommand;
  WiFiRemoveCommand._();
}

abstract class WiFiAddCommand implements RpcCommand, Built<WiFiAddCommand, WiFiAddCommandBuilder> {
  static const String TYPE = 'wifi_add';
  @override
  String get type => TYPE;
  @override
  int get id;
  WiFiStoredNetworkInfo get info;

  static Serializer<WiFiAddCommand> get serializer => _$wiFiAddCommandSerializer;
  @BuiltValueHook(initializeBuilder: true)
  static void _setDefaults(WiFiAddCommandBuilder b) => b.id = RpcCommand.generateId();
  factory WiFiAddCommand([void updates(WiFiAddCommandBuilder b)?]) = _$WiFiAddCommand;
  WiFiAddCommand._();
}

abstract class WiFiGetStoredCommand implements RpcCommand, Built<WiFiGetStoredCommand, WiFiGetStoredCommandBuilder> {
  static const String TYPE = 'wifi_get_stored';
  @override
  String get type => TYPE;
  @override
  int get id;

  static Serializer<WiFiGetStoredCommand> get serializer => _$wiFiGetStoredCommandSerializer;
  @BuiltValueHook(initializeBuilder: true)
  static void _setDefaults(WiFiGetStoredCommandBuilder b) => b.id = RpcCommand.generateId();
  factory WiFiGetStoredCommand([void updates(WiFiGetStoredCommandBuilder b)?]) = _$WiFiGetStoredCommand;
  WiFiGetStoredCommand._();
}

abstract class WiFiGetStoredResult implements RpcResult, Built<WiFiGetStoredResult, WiFiGetStoredResultBuilder> {
  @override
  int get id;

  BuiltList<WiFiStoredNetworkInfo>? get networks;

  static Serializer<WiFiGetStoredResult> get serializer => _$wiFiGetStoredResultSerializer;

  factory WiFiGetStoredResult([void updates(WiFiGetStoredResultBuilder b)?]) = _$WiFiGetStoredResult;
  factory WiFiGetStoredResult.respond(RpcCommand command) {
    return _$WiFiGetStoredResult((b) => b.id = command.id);
  }
  WiFiGetStoredResult._();
}
