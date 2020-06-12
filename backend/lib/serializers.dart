library crazy_pig.serializers;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/src/service/system_info/cpu_info.dart';
import 'package:dslideshow_backend/src/service/system_info/network_info.dart';
import 'package:dslideshow_backend/src/service/system_info/os_info.dart';
import 'package:dslideshow_backend/src/service/system_info/sensor_info.dart';
import 'package:dslideshow_backend/src/service/system_info/system_info.dart';
import 'package:dslideshow_backend/src/service/system_info/update_info.dart';

import 'src/command/empty_result.dart';
import 'src/command/screen_commands.dart';

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
  AreYouReadyCommand
 ])
Serializers serializers = _$serializers;