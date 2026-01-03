library dslideshow.serializers;

import 'package:dslideshow_backend/command.dart';
//import 'package:dslideshow_common/rpc.dart';
import 'package:dslideshow_common/serializers.dart';

// @SerializersFor()
// Serializers serializers = _$serializers;
Serializers serializers = _SerializersImpl();

class _SerializersImpl implements Serializers {
  Object? serialize<T>(T object) {
    if (object is EchoCommand) return ["EchoCommand", object.toJson()];

    if (object is EchoCommandResult)
      return ["EchoCommandResult", object.toJson()];

    if (object is GetMediaItemCommand)
      return ["GetMediaItemCommand", object.toJson()];

    if (object is GetMediaItemCommandResult)
      return ["GetMediaItemCommandResult", object.toJson()];

    if (object is StorageNextCommand)
      return ["StorageNextCommand", object.toJson()];

    if (object is ScreenTurnCommand)
      return ["ScreenTurnCommand", object.toJson()];

    if (object is PowerOffCommand) return ["PowerOffCommand", object.toJson()];

    if (object is UpdateFrontendStateCommand)
      return ["UpdateFrontendStateCommand", object.toJson()];

    if (object is RestartAppCommand)
      return ["RestartAppCommand", object.toJson()];

    if (object is EmptyResult) return ["EmptyResult", object.toJson()];

    if (object is GetSystemInfoCommand)
      return ["GetSystemInfoCommand", object.toJson()];

    if (object is GetSystemInfoCommandResult)
      return ["GetSystemInfoCommandResult", object.toJson()];

    if (object is SystemInfo) return ["SystemInfo", object.toJson()];

    if (object is OSInfo) return ["OSInfo", object.toJson()];

    if (object is UpdateInfo) return ["UpdateInfo", object.toJson()];

    if (object is SensorInfo) return ["SensorInfo", object.toJson()];

    if (object is CpuInfo) return ["CpuInfo", object.toJson()];

    if (object is NetworkInfo) return ["NetworkInfo", object.toJson()];

    if (object is LEDControlCommand)
      return ["LEDControlCommand", object.toJson()];

    if (object is ButtonChangeStateCommand)
      return ["ButtonChangeStateCommand", object.toJson()];

    if (object is EmulatePushButtonCommand)
      return ["EmulatePushButtonCommand", object.toJson()];

    if (object is ExecuteSSActionCommand)
      return ["ExecuteSSActionCommand", object.toJson()];

    if (object is ScreenLockCommand)
      return ["ScreenLockCommand", object.toJson()];

    if (object is WebServerControlCommand)
      return ["WebServerControlCommand", object.toJson()];

    if (object is WebServerControlCommandResult)
      return ["WebServerControlCommandResult", object.toJson()];

    if (object is AreYouReadyCommand)
      return ["AreYouReadyCommand", object.toJson()];

    if (object is OTAReadyCommand) return ["OTAReadyCommand", object.toJson()];

    if (object is OTAGetInfoCommand)
      return ["OTAGetInfoCommand", object.toJson()];

    if (object is OTAGetInfoCommandResult)
      return ["OTAGetInfoCommandResult", object.toJson()];

    if (object is OTAOutputCommand)
      return ["OTAOutputCommand", object.toJson()];

    if (object is WiFiAddCommand) return ["WiFiAddCommand", object.toJson()];

    if (object is WiFiGetConnectionsCommand)
      return ["WiFiGetConnectionsCommand", object.toJson()];

    if (object is WiFiRemoveCommand)
      return ["WiFiRemoveCommand", object.toJson()];

    if (object is WiFiScanCommand) return ["WiFiScanCommand", object.toJson()];

    if (object is WiFiNetworkInfo) return ["WiFiNetworkInfo", object.toJson()];

    if (object is WiFiScanResult) return ["WiFiScanResult", object.toJson()];

    if (object is WiFiGetConnectionsResult)
      return ["WiFiGetConnectionsResult", object.toJson()];

    if (object is WSHelloCommand) return ["WSHelloCommand", object.toJson()];

    if (object is WSAuthCommand) return ["WSAuthCommand", object.toJson()];

    if (object is WSErrorResult) return ["WSErrorResult", object.toJson()];

    if (object is WSConfigDownloadResult)
      return ["WSConfigDownloadResult", object.toJson()];

    if (object is WSConfigDownloadCommand)
      return ["WSConfigDownloadCommand", object.toJson()];

    if (object is WSConfigUploadCommand)
      return ["WSConfigUploadCommand", object.toJson()];

    if (object is WSSendRpcCommand)
      return ["WSSendRpcCommand", object.toJson()];

    if (object is WSRpcResult) return ["WSRpcResult", object.toJson()];

    if (object is WSResultOk) return ["WSResultOk", object.toJson()];

    if (object is WSEchoCommand) return ["WSEchoCommand", object.toJson()];

    if (object is WSEchoResult) return ["WSEchoResult", object.toJson()];

    throw ArgumentError('Not found serializer for "$T"');
  }

  Object? deserialize(Object? object) {
    if (object is List) {
      return _deserializeByType(object[0], object[1]);
    }
    throw ArgumentError('Not found deserialize for "$object"');
  }

  Object? _deserializeByType(String typeName, Map<String, dynamic> object) {
    switch (typeName) {
      case 'EchoCommand':
        return EchoCommand.fromJson(object);

      case 'EchoCommandResult':
        return EchoCommandResult.fromJson(object);

      case 'GetMediaItemCommand':
        return GetMediaItemCommand.fromJson(object);

      case 'GetMediaItemCommandResult':
        return GetMediaItemCommandResult.fromJson(object);

      case 'StorageNextCommand':
        return StorageNextCommand.fromJson(object);

      case 'ScreenTurnCommand':
        return ScreenTurnCommand.fromJson(object);

      case 'PowerOffCommand':
        return PowerOffCommand.fromJson(object);

      case 'UpdateFrontendStateCommand':
        return UpdateFrontendStateCommand.fromJson(object);

      case 'RestartAppCommand':
        return RestartAppCommand.fromJson(object);

      case 'EmptyResult':
        return EmptyResult.fromJson(object);

      case 'GetSystemInfoCommand':
        return GetSystemInfoCommand.fromJson(object);

      case 'GetSystemInfoCommandResult':
        return GetSystemInfoCommandResult.fromJson(object);

      case 'SystemInfo':
        return SystemInfo.fromJson(object);

      case 'OSInfo':
        return OSInfo.fromJson(object);

      case 'UpdateInfo':
        return UpdateInfo.fromJson(object);

      case 'SensorInfo':
        return SensorInfo.fromJson(object);

      case 'CpuInfo':
        return CpuInfo.fromJson(object);

      case 'NetworkInfo':
        return NetworkInfo.fromJson(object);

      case 'LEDControlCommand':
        return LEDControlCommand.fromJson(object);

      case 'ButtonChangeStateCommand':
        return ButtonChangeStateCommand.fromJson(object);

      case 'EmulatePushButtonCommand':
        return EmulatePushButtonCommand.fromJson(object);

      case 'ExecuteSSActionCommand':
        return ExecuteSSActionCommand.fromJson(object);

      case 'ScreenLockCommand':
        return ScreenLockCommand.fromJson(object);

      case 'WebServerControlCommand':
        return WebServerControlCommand.fromJson(object);

      case 'WebServerControlCommandResult':
        return WebServerControlCommandResult.fromJson(object);

      case 'AreYouReadyCommand':
        return AreYouReadyCommand.fromJson(object);

      case 'OTAReadyCommand':
        return OTAReadyCommand.fromJson(object);

      case 'OTAGetInfoCommand':
        return OTAGetInfoCommand.fromJson(object);

      case 'OTAGetInfoCommandResult':
        return OTAGetInfoCommandResult.fromJson(object);

      case 'OTAOutputCommand':
        return OTAOutputCommand.fromJson(object);

      case 'WiFiAddCommand':
        return WiFiAddCommand.fromJson(object);

      case 'WiFiGetConnectionsCommand':
        return WiFiGetConnectionsCommand.fromJson(object);

      case 'WiFiRemoveCommand':
        return WiFiRemoveCommand.fromJson(object);

      case 'WiFiScanCommand':
        return WiFiScanCommand.fromJson(object);

      case 'WiFiNetworkInfo':
        return WiFiNetworkInfo.fromJson(object);

      case 'WiFiScanResult':
        return WiFiScanResult.fromJson(object);

      case 'WiFiGetConnectionsResult':
        return WiFiGetConnectionsResult.fromJson(object);

      case 'WSHelloCommand':
        return WSHelloCommand.fromJson(object);

      case 'WSAuthCommand':
        return WSAuthCommand.fromJson(object);

      case 'WSErrorResult':
        return WSErrorResult.fromJson(object);

      case 'WSConfigDownloadResult':
        return WSConfigDownloadResult.fromJson(object);

      case 'WSConfigDownloadCommand':
        return WSConfigDownloadCommand.fromJson(object);

      case 'WSConfigUploadCommand':
        return WSConfigUploadCommand.fromJson(object);

      case 'WSSendRpcCommand':
        return WSSendRpcCommand.fromJson(object);

      case 'WSRpcResult':
        return WSRpcResult.fromJson(object);

      case 'WSResultOk':
        return WSResultOk.fromJson(object);

      case 'WSEchoCommand':
        return WSEchoCommand.fromJson(object);

      case 'WSEchoResult':
        return WSEchoResult.fromJson(object);

      default:
        throw ArgumentError('Not found deserialize for "$typeName"');
    }
  }
}
