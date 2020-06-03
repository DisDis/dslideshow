// GENERATED CODE - DO NOT MODIFY BY HAND

part of crazy_pig.serializers;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$serializers = (new Serializers().toBuilder()
      ..add(CpuInfo.serializer)
      ..add(EchoCommand.serializer)
      ..add(EchoCommandResult.serializer)
      ..add(EmptyResult.serializer)
      ..add(GetMediaItemCommand.serializer)
      ..add(GetMediaItemCommandResult.serializer)
      ..add(GetSystemInfoCommand.serializer)
      ..add(GetSystemInfoCommandResult.serializer)
      ..add(NetworkInfo.serializer)
      ..add(NetworkInterfaceInfo.serializer)
      ..add(NetworkInterfaceStatus.serializer)
      ..add(OSInfo.serializer)
      ..add(ScreenTurnCommand.serializer)
      ..add(SensorInfo.serializer)
      ..add(StorageNextCommand.serializer)
      ..add(SystemInfo.serializer)
      ..add(UpdateInfo.serializer)
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(NetworkInterfaceInfo)]),
          () => new ListBuilder<NetworkInterfaceInfo>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(SensorInfo)]),
          () => new ListBuilder<SensorInfo>()))
    .build();

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
