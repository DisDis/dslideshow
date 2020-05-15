library crazy_pig.serializers;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:dslideshow_backend/src/command/echo.dart';
import 'package:dslideshow_backend/src/command/storage_commands.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  EchoCommand,
  EchoCommandResult,
  GetMediaItemCommand,
  GetMediaItemCommandResult,
  StorageNextCommand,
  StorageEmptyResult
 ])
Serializers serializers = _$serializers;