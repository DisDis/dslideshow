import 'dart:async';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/src/service/hardware/hardware.dart';
import 'package:dslideshow_backend/src/service/hardware/src/gpio_service.dart';
import 'package:dslideshow_backend/src/service/hardware/src/frame_state_reader.dart';
import 'package:dslideshow_backend/src/service/mqtt/mqtt_service.dart';
import 'package:dslideshow_backend/src/service/storage/storage.dart';
import 'package:dslideshow_backend/src/service/storage/storage_type.dart' as media;
import 'package:dslideshow_backend/src/service/storage/storage_provider_registry.dart';
import 'package:dslideshow_backend/src/service/system_info/system_info_service.dart';
import 'package:dslideshow_backend/src/service/wifi/wifi_service.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:fake_async/fake_async.dart';
import 'package:test/test.dart';

import 'controlled_screen_power.dart';
import 'storage_provider_registry_fixture.dart';

class FakeGPIO implements GPIOService {
  final motion = StreamController<bool>.broadcast();
  final buttons = StreamController<ButtonEvent>.broadcast();
  bool released = false;
  @override
  Stream<bool> get onMotion => motion.stream;
  @override
  Stream<ButtonEvent> get onButtonEvent => buttons.stream;
  @override
  Future<void> init() async {}
  @override
  Future<void> release() async {
    released = true;
    await motion.close();
    await buttons.close();
  }

  @override
  set powerLED(bool? value) {}
}

class FakeRemote implements RemoteService {
  final commands = <RpcCommand>[];
  final screenCommands = <ScreenTurnCommand>[];
  final pending = <Completer<RpcResult>>[];
  final storageCommands = <StorageStatusCommand>[];
  final storagePending = <Completer<RpcResult>>[];
  final _pendingStorageCommands = <StorageStatusCommand>[];
  bool hold = false;
  bool holdStorage = false;
  @override
  Future<RpcResult> send<T extends RpcCommand>(T command) async {
    commands.add(command);
    if (command is StorageStatusCommand) {
      storageCommands.add(command);
      if (holdStorage) {
        final completion = Completer<RpcResult>();
        storagePending.add(completion);
        _pendingStorageCommands.add(command);
        return completion.future;
      }
    }
    if (command is ScreenTurnCommand) {
      screenCommands.add(command);
      if (hold) {
        final completion = Completer<RpcResult>();
        pending.add(completion);
        return completion.future;
      }
    }
    return EmptyResult.respond(command);
  }

  void acknowledge(int index) => pending[index].complete(EmptyResult.respond(screenCommands[index]));
  void acknowledgeStorage(int index) =>
      storagePending[index].complete(EmptyResult.respond(_pendingStorageCommands[index]));
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class FakeMqtt implements MqttService {
  final pause = StreamController<bool>.broadcast();
  final screen = StreamController<bool>.broadcast();
  final menu = StreamController<bool>.broadcast();
  Future<void>? _closing;
  @override
  Stream<bool> get onPause => pause.stream;
  @override
  Stream<bool> get onScreen => screen.stream;
  @override
  Stream<bool> get onMenu => menu.stream;
  @override
  Future<void> close() => _closing ??= Future.wait<void>([pause.close(), screen.close(), menu.close()]);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class FakeStorage extends Storage {
  bool released = false;
  @override
  media.StorageType get type => media.StorageType.local;
  @override
  Future<void> init() async {}
  @override
  Future<void> release() async {
    released = true;
    closeStatusNotifications();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class FakeSystemInfo implements SystemInfoService {
  Completer<SystemInfo>? pending;
  bool released = false;
  @override
  Future<Null> init() async => null;
  @override
  Future<SystemInfo> getFullInfo() => pending!.future;
  @override
  Future<void> release() async {
    released = true;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class UnusedWiFi implements WiFiService {
  @override
  Future<void> close() async {}

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class UnusedPowerOff implements PowerOffService {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class HardwareFixture {
  final gpio = FakeGPIO();
  final remote = FakeRemote();
  final mqtt = FakeMqtt();
  final power = ControlledPower();
  final storage = FakeStorage();
  final systemInfo = FakeSystemInfo();
  late final ScreenService screen;
  late final ApplicationStateService application;
  late final HardwareService hardware;
  Future<void>? _closing;
  final bool _usesDefaultStorage;
  HardwareFixture({WiFiService? wifi, StorageProviderRegistry? storageProviders})
    : _usesDefaultStorage = storageProviders == null {
    final config = AppConfig.fromJson({
      'hardware': {'screenPowerOnTimerSec': 1},
    });
    screen = ScreenService(config.hardware, power: power);
    final providers =
        storageProviders ??
        createStorageProviderRegistry(
          selectedType: StorageType.DiskStorage,
          factories: {StorageType.DiskStorage: () => storage},
        );
    application = ApplicationStateService(screenService: screen, gpioService: gpio, storage: providers.selected);
    hardware = HardwareService(
      frontendService: remote,
      storageProviders: providers,
      gpioService: gpio,
      screenService: screen,
      systemInfoService: systemInfo,
      webServer: remote,
      mqttService: mqtt,
      wifiService: wifi ?? UnusedWiFi(),
      powerOffService: UnusedPowerOff(),
      applicationStateService: application,
      frameStateReader: FrameStateReader(
        frontendService: remote,
        screenService: screen,
        applicationStateService: application,
      ),
    );
  }
  Future<void> close() => _closing ??= hardware.dispose();

  void dispose(FakeAsync time, {Future<void>? additionalCleanup}) {
    var done = false;
    Future.wait([close(), if (additionalCleanup != null) additionalCleanup]).then((_) => done = true);
    time.flushMicrotasks();
    // StreamSubscription.cancel may return a shared future created outside the
    // fake zone. Let its real microtasks finish, then drain virtual callbacks.
    addTearDown(() async {
      for (var i = 0; i < 20 && !done; i++) {
        await Future<void>.delayed(Duration.zero);
        time.flushMicrotasks();
      }
      expect(done, isTrue);
      expect(mqtt.pause.isClosed, isTrue);
      expect(mqtt.screen.isClosed, isTrue);
      expect(mqtt.menu.isClosed, isTrue);
      expect(gpio.released, isTrue);
      if (_usesDefaultStorage) expect(storage.released, isTrue);
      expect(systemInfo.released, isTrue);
      expect(gpio.motion.hasListener, isFalse);
      expect(mqtt.screen.hasListener, isFalse);
      expect(time.pendingTimers, isEmpty);
    });
  }
}
