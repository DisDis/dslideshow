import 'dart:io';

import 'package:dslideshow_backend/command.dart';

final serializersFor = SerializersFor(const [
  EchoCommand,
  EchoCommandResult,
  GetMediaItemCommand,
  GetMediaItemCommandResult,
  StorageNextCommand,
  ScreenTurnCommand,
  PowerOffCommand,
  UpdateFrontendStateCommand,
  RestartAppCommand,
  EmptyResult,
  GetSystemInfoCommand,
  GetSystemInfoCommandResult,
  SystemInfo,
  OSInfo,
  UpdateInfo,
  SensorInfo,
  CpuInfo,
  NetworkInfo,
  LEDControlCommand,
  PushButtonCommand,
  ExecuteSSActionCommand,
  ScreenLockCommand,
  WebServerControlCommand,
  WebServerControlCommandResult,
  AreYouReadyCommand,
  OTAReadyCommand,
  OTAGetInfoCommand,
  OTAGetInfoCommandResult,
  OTAOutputCommand,
  WiFiAddCommand,
  WiFiGetConnectionsCommand,
  WiFiRemoveCommand,
  WiFiScanCommand,
  WiFiNetworkInfo,
  WiFiScanResult,
  WiFiGetConnectionsResult,
  WSHelloCommand,
  WSAuthCommand,
  WSErrorResult,
  WSConfigDownloadResult,
  WSConfigDownloadCommand,
  WSConfigUploadCommand,
  WSSendRpcCommand,
  WSRpcResult,
  WSRestartApplicationCommand,
  WSResultOk,
  WSEchoCommand,
  WSEchoResult
]);

final outputSerializers = "./lib/serializers.dart";

void main(List<String> args) {
  final CASE_SER_CLASS = StringBuffer();
  final CASE_DESER_CLASS = StringBuffer();
  const String CASE_SER_Key = "___CASE_SER_CLASS___";
  const String CASE_DESER_Key = "___CASE_DESER_CLASS___";
  const String CLASS_Key = "___CLASS___";

  serializersFor.types.forEach((type) {
    final typeName = type.toString();
    CASE_SER_CLASS.writeln(_serializeClassTemplate.replaceAll(CLASS_Key, typeName));
    CASE_DESER_CLASS.writeln(_deserializeClassTemplate.replaceAll(CLASS_Key, typeName));
  });
  final out = fileTemplate.replaceFirst(CASE_SER_Key, CASE_SER_CLASS.toString()).replaceFirst(CASE_DESER_Key, CASE_DESER_CLASS.toString());
  print(out);
  File(outputSerializers).writeAsStringSync(out);
}

class SerializersFor {
  final List<Type> types;

  const SerializersFor(this.types);
}

final String _serializeClassTemplate = r"""
      if (object is ___CLASS___) return ["___CLASS___", object.toJson()];
""";
/*final String _serializeClassTemplate = r"""
      case ___CLASS___:
        return ["___CLASS___", (object as ___CLASS___).toJson()];
""";*/
final String _deserializeClassTemplate = r"""
      case '___CLASS___':
        return ___CLASS___.fromJson(object);
""";

/*switch (T) {
      ___CASE_SER_CLASS___
      default:
        throw ArgumentError('Not found serializer for "$T"');
    }*/

final String fileTemplate = r"""
library dslideshow.serializers;

import 'package:dslideshow_backend/command.dart';
//import 'package:dslideshow_common/rpc.dart';
import 'package:dslideshow_common/serializers.dart';


// @SerializersFor()
// Serializers serializers = _$serializers;
Serializers serializers = _SerializersImpl();

class _SerializersImpl implements Serializers {
  Object? serialize<T>(T object) {
    ___CASE_SER_CLASS___
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
      ___CASE_DESER_CLASS___
      default:
        throw ArgumentError('Not found deserialize for "$typeName"');
    }
  }
}
""";
