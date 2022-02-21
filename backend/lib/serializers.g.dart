// GENERATED CODE - DO NOT MODIFY BY HAND

part of crazy_pig.serializers;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$serializers = (new Serializers().toBuilder()
      ..add(AreYouReadyCommand.serializer)
      ..add(ButtonType.serializer)
      ..add(CpuInfo.serializer)
      ..add(EchoCommand.serializer)
      ..add(EchoCommandResult.serializer)
      ..add(EmptyResult.serializer)
      ..add(GetMediaItemCommand.serializer)
      ..add(GetMediaItemCommandResult.serializer)
      ..add(GetSystemInfoCommand.serializer)
      ..add(GetSystemInfoCommandResult.serializer)
      ..add(LEDControlCommand.serializer)
      ..add(LEDType.serializer)
      ..add(NetworkInfo.serializer)
      ..add(NetworkInterfaceInfo.serializer)
      ..add(NetworkInterfaceStatus.serializer)
      ..add(OSInfo.serializer)
      ..add(OSType.serializer)
      ..add(OTAGetInfoCommand.serializer)
      ..add(OTAGetInfoCommandResult.serializer)
      ..add(OTAInfo.serializer)
      ..add(OTAOutputCommand.serializer)
      ..add(OTAReadyCommand.serializer)
      ..add(OTAStatus.serializer)
      ..add(PushButtonCommand.serializer)
      ..add(ScreenLockCommand.serializer)
      ..add(ScreenTurnCommand.serializer)
      ..add(SensorInfo.serializer)
      ..add(StorageNextCommand.serializer)
      ..add(SystemInfo.serializer)
      ..add(UpdateInfo.serializer)
      ..add(WSAuthCommand.serializer)
      ..add(WSAuthReqCommand.serializer)
      ..add(WSConfigContentCommand.serializer)
      ..add(WSConfigDownloadCommand.serializer)
      ..add(WSConfigUploadCommand.serializer)
      ..add(WSHelloCommand.serializer)
      ..add(WSRestartApplicationCommand.serializer)
      ..add(WSResultOk.serializer)
      ..add(WSRpcResult.serializer)
      ..add(WSSendRpcCommand.serializer)
      ..add(WebServerControlCommand.serializer)
      ..add(WebServerControlCommandResult.serializer)
      ..add(WiFiAddCommand.serializer)
      ..add(WiFiGetStoredCommand.serializer)
      ..add(WiFiGetStoredResult.serializer)
      ..add(WiFiNetworkInfo.serializer)
      ..add(WiFiRemoveCommand.serializer)
      ..add(WiFiScanCommand.serializer)
      ..add(WiFiScanResult.serializer)
      ..add(WiFiStoredNetworkInfo.serializer)
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(NetworkInterfaceInfo)]),
          () => new ListBuilder<NetworkInterfaceInfo>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(SensorInfo)]),
          () => new ListBuilder<SensorInfo>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(WiFiNetworkInfo)]),
          () => new ListBuilder<WiFiNetworkInfo>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(WiFiStoredNetworkInfo)]),
          () => new ListBuilder<WiFiStoredNetworkInfo>()))
    .build();

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
