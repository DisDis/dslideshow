import 'dart:convert';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/serializers.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:test/test.dart';

void main() {
  const cpu = CpuInfo(cores: 4, hardware: 'test', model: 'Pi', revision: '1');
  const network = NetworkInfo(lastUpdate: 1, hasInternet: true, interfaces: []);
  const os = OSInfo(name: 'Linux', osType: OSType.linux);
  const sensor = SensorInfo(name: 'temperature', value: '45');
  const update = UpdateInfo(
    cpuLoad1: 1,
    cpuLoad15: 2,
    cpuLoad5: 3,
    diskAvailable: 100,
    diskUsed: 50,
    diskUsedPercent: 33,
    lastUpdate: 1,
    memTotal: 100,
    memUsed: 50,
    sensors: [sensor],
    swapTotal: 10,
    swapUsed: 0,
    uptime: '1h',
  );
  const system = SystemInfo(
    cpuInfo: cpu,
    networkInfo: network,
    osInfo: os,
    updateInfo: update,
  );
  const ota = OTAInfo(
    status: OTAStatus.ready,
    uploadingPercent: 0,
    code: '1234',
  );
  const wifi = WiFiNetworkInfo(
    BSSID: '00:11:22:33:44:55',
    SSID: 'test',
    signal: 90,
    channel: 1,
    rate: 100,
    security: 'WPA2',
  );
  const frontend = FrameFrontendState(
    isPaused: true,
    isMenu: false,
    page: FramePage.slideshow,
    frontendVersion: 'test',
  );
  final state = FrameState(
    sampledAt: DateTime.utc(2026),
    presence: FramePresence.present,
    isScreenLocked: false,
    isScreenOn: true,
    screenPhase: FrameScreenPhase.on,
    backendVersion: 'test',
    frontend: frontend,
  );

  // The keys deliberately pin the existing protocol tags, independently of
  // class names in the annotation or private Freezed runtime implementations.
  final messages = <String, Object>{
    'ErrorResult': const ErrorResult(id: 1, error: 'failed'),
    'GetRpcTelemetryCommand': const GetRpcTelemetryCommand(id: 1),
    'GetRpcTelemetryResult': const GetRpcTelemetryResult(
      id: 1,
      snapshot: RpcTelemetrySnapshot(nodes: []),
    ),
    'GetFrameStateCommand': const GetFrameStateCommand(id: 1),
    'GetFrameStateResult': GetFrameStateResult(id: 1, state: state),
    'GetFrameFrontendStateCommand': const GetFrameFrontendStateCommand(id: 1),
    'GetFrameFrontendStateResult': const GetFrameFrontendStateResult(
      id: 1,
      state: frontend,
    ),
    'SetFrameControlCommand': const SetFrameControlCommand(
      id: 1,
      control: FrameControl.pause,
      enabled: true,
    ),
    'EchoCommand': const EchoCommand(id: 1, text: 'hello'),
    'EchoCommandResult': const EchoCommandResult(id: 1, resultText: 'hello'),
    'GetMediaItemCommand': const GetMediaItemCommand(id: 1, isCurrent: true),
    'GetMediaItemCommandResult': GetMediaItemCommandResult(
      id: 1,
      mediaId: 'photo',
      mediaUri: Uri.parse('file:///photo.jpg'),
    ),
    'StorageNextCommand': const StorageNextCommand(id: 1),
    'ScreenTurnCommand': const ScreenTurnCommand(id: 1, enabled: true),
    'PowerOffCommand': const PowerOffCommand(id: 1),
    'UpdateFrontendStateCommand': const UpdateFrontendStateCommand(
      id: 1,
      isPaused: true,
      isMenu: false,
    ),
    'RestartAppCommand': const RestartAppCommand(id: 1),
    'EmptyResult': const EmptyResult(id: 1),
    'GetSystemInfoCommand': const GetSystemInfoCommand(id: 1),
    'GetSystemInfoCommandResult': const GetSystemInfoCommandResult(
      id: 1,
      systemInfo: system,
    ),
    'SystemInfo': system,
    'OSInfo': os,
    'UpdateInfo': update,
    'SensorInfo': sensor,
    'CpuInfo': cpu,
    'NetworkInfo': network,
    'LEDControlCommand': const LEDControlCommand(
      id: 1,
      led: LEDType.power,
      value: true,
    ),
    'ButtonChangeStateCommand': const ButtonChangeStateCommand(
      id: 1,
      button: ButtonType.button0,
      event: ButtonEventType.pressed,
      durationMs: 100,
    ),
    'EmulatePushButtonCommand': const EmulatePushButtonCommand(
      id: 1,
      button: ButtonType.button1,
      durationMs: 100,
    ),
    'ExecuteSSActionCommand': const ExecuteSSActionCommand(
      id: 1,
      action: SlideshowAction.pause,
      value: true,
    ),
    'ScreenLockCommand': const ScreenLockCommand(id: 1, isLock: true),
    'WebServerControlCommand': const WebServerControlCommand(
      id: 1,
      enable: true,
    ),
    'WebServerControlCommandResult': const WebServerControlCommandResult(
      id: 1,
      enable: true,
      code: '1234',
    ),
    'AreYouReadyCommand': const AreYouReadyCommand(id: 1),
    'OTAReadyCommand': const OTAReadyCommand(id: 1, ready: true),
    'OTAGetInfoCommand': const OTAGetInfoCommand(id: 1, info: ota),
    'OTAGetInfoCommandResult': const OTAGetInfoCommandResult(id: 1, info: ota),
    'OTAOutputCommand': const OTAOutputCommand(id: 1, output: 'done'),
    'WiFiAddCommand': const WiFiAddCommand(
      id: 1,
      name: 'test',
      SSID: 'test',
      psk: 'secret',
    ),
    'WiFiGetConnectionsCommand': const WiFiGetConnectionsCommand(id: 1),
    'WiFiRemoveCommand': const WiFiRemoveCommand(id: 1, connectionId: 'test'),
    'WiFiRescanCommand': const WiFiRescanCommand(id: 1),
    'WiFiListCommand': const WiFiListCommand(id: 1),
    'WiFiNetworkInfo': wifi,
    'WiFiListResult': const WiFiListResult(id: 1, networks: [wifi]),
    'WiFiGetConnectionsResult': const WiFiGetConnectionsResult(
      id: 1,
      networks: [
        WiFiConnectionInfo(
          name: 'test',
          UUID: 'uuid',
          type: 'wifi',
          device: 'wlan0',
        ),
      ],
    ),
    'WSHelloCommand': const WSHelloCommand(id: 1),
    'WSAuthCommand': const WSAuthCommand(id: 1, userName: 'test', code: '1234'),
    'WSErrorResult': const WSErrorResult(id: 1, error: 'failed'),
    'WSConfigDownloadResult': const WSConfigDownloadResult(
      id: 1,
      content: '{}',
    ),
    'WSConfigDownloadCommand': const WSConfigDownloadCommand(id: 1),
    'WSConfigUploadCommand': const WSConfigUploadCommand(id: 1, content: '{}'),
    'WSSendRpcCommand': const WSSendRpcCommand(
      id: 1,
      commandData: [
        'EchoCommand',
        {'id': 2, 'text': 'nested', 'type': 'echo'},
      ],
    ),
    'WSRpcResult': const WSRpcResult(
      id: 1,
      resultData: [
        'EmptyResult',
        {'id': 2},
      ],
    ),
    'WSResultOk': const WSResultOk(id: 1),
    'WSEchoCommand': const WSEchoCommand(id: 1, msg: 'hello'),
    'WSEchoResult': const WSEchoResult(id: 1, msg: 'hello'),
  };

  for (final entry in messages.entries) {
    test('${entry.key} keeps its wire tag and survives JSON round-trip', () {
      final Object message = entry.value;
      final wire = jsonDecode(
        jsonEncode(serializers.serialize<Object>(message)),
      );
      final expectedPayload = jsonDecode(
        jsonEncode((message as dynamic).toJson()),
      );
      expect(wire, [entry.key, expectedPayload]);
      final decoded = serializers.deserialize(wire);
      expect(
        jsonDecode(jsonEncode(serializers.serialize<Object?>(decoded))),
        wire,
      );
    });
  }

  test('ErrorResult decodes the real registry envelope into the model', () {
    expect(
      serializers.deserialize([
        'ErrorResult',
        {'error': 'failed', 'id': 7},
      ]),
      const ErrorResult(id: 7, error: 'failed'),
    );
  });

  test('EchoCommand has the original envelope, payload and error behavior', () {
    expect(
      serializers.serialize<Object>(const EchoCommand(id: 7, text: 'hi')),
      [
        'EchoCommand',
        {'id': 7, 'text': 'hi', 'type': 'echo'},
      ],
    );
    expect(() => serializers.serialize(Object()), throwsArgumentError);
    expect(() => serializers.serialize(null), throwsArgumentError);
    expect(
      () => serializers.deserialize(['UnknownCommand', <String, dynamic>{}]),
      throwsArgumentError,
    );
    expect(() => serializers.deserialize({}), throwsArgumentError);
    expect(() => serializers.deserialize([]), throwsRangeError);
    expect(
      () => serializers.deserialize(['EchoCommand', 'invalid']),
      throwsA(isA<TypeError>()),
    );
    // Legacy decoding uses the first two entries, even if a sender adds more.
    final decoded = serializers.deserialize([
      'EchoCommand',
      {'id': 7},
      'extra',
    ]);
    expect(decoded, const EchoCommand(id: 7));
  });
}
