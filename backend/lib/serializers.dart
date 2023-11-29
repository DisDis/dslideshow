library crazy_pig.serializers;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:dslideshow_backend/command.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  EchoCommand,
  EchoCommandResult,
  GetMediaItemCommand,
  GetMediaItemCommandResult,
  StorageNextCommand,
  ScreenTurnCommand,
  EmptyResult,
  GetSystemInfoCommand,
  GetSystemInfoCommandResult,
  SystemInfo,
  OSInfo,
  OSType,
  UpdateInfo,
  SensorInfo,
  CpuInfo,
  NetworkInfo,
  LEDControlCommand,
  PushButtonCommand,
  LEDType,
  ButtonType,
  ScreenLockCommand,
  WebServerControlCommand,
  WebServerControlCommandResult,
  AreYouReadyCommand,
  OTAReadyCommand,
  OTAGetInfoCommand,
  OTAGetInfoCommandResult,
  OTAOutputCommand,
  OTAStatus,
  WiFiAddCommand,
  WiFiGetStoredCommand,
  WiFiRemoveCommand,
  WiFiSaveConfigCommand,
  WiFiScanCommand,
  WiFiNetworkInfo,
  WiFiScanResult,
  WiFiGetStoredResult,
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
])
Serializers serializers = _$serializers;
