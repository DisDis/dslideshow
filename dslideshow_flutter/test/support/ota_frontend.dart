import 'dart:async';

import 'package:dslideshow_backend/command.dart';

import 'slideshow_frontend.dart';

class OtaTestFrontend extends TestFrontend {
  final infoResult = Completer<OTAInfo>();
  final systemResult = Completer<SystemInfo>();
  final infoRequested = Completer<void>();
  final systemRequested = Completer<void>();
  Completer<void>? infoCancellation;
  bool _infoWasListened = false;
  late final infoEvents = StreamController<OTAInfo>(
    onListen: () => _infoWasListened = true,
    onCancel: () async {
      await infoCancellation?.future;
    },
  );
  final outputEvents = StreamController<String>.broadcast();
  final readyEvents = StreamController<bool>.broadcast();

  @override
  Stream<OTAInfo> get onOTAInfo => infoEvents.stream;

  @override
  Stream<String> get onOTAOutput => outputEvents.stream;

  @override
  Stream<bool> get onOTAReady => readyEvents.stream;

  @override
  Future<OTAInfo> getOTAInfo() {
    if (!infoRequested.isCompleted) infoRequested.complete();
    return infoResult.future;
  }

  @override
  Future<SystemInfo> getSystemInfo() {
    if (!systemRequested.isCompleted) systemRequested.complete();
    return systemResult.future;
  }

  @override
  Future<void> close() async {
    // A never-listened single-subscription controller otherwise cannot finish
    // closing in initial-state widget tests.
    final unusedInfo = !_infoWasListened
        ? infoEvents.stream.drain<void>()
        : null;
    await infoEvents.close();
    await unusedInfo;
    await outputEvents.close();
    await readyEvents.close();
    await super.close();
  }
}

SystemInfo otaSystemInfo({List<NetworkInterfaceInfo>? interfaces}) =>
    SystemInfo(
      cpuInfo: const CpuInfo(
        cores: 4,
        hardware: 'test',
        model: 'Pi',
        revision: '1',
      ),
      networkInfo: NetworkInfo(
        lastUpdate: 0,
        hasInternet: true,
        interfaces:
            interfaces ??
            const [
              NetworkInterfaceInfo(
                name: 'wlan0',
                status: NetworkInterfaceStatus.running,
                ip4: '192.168.50.143',
                ip6: '',
              ),
            ],
      ),
      osInfo: const OSInfo(name: 'Linux', osType: OSType.linux),
      updateInfo: const UpdateInfo(
        cpuLoad1: 0,
        cpuLoad15: 0,
        cpuLoad5: 0,
        diskAvailable: 100,
        diskUsed: 0,
        diskUsedPercent: 0,
        lastUpdate: 0,
        memTotal: 100,
        memUsed: 0,
        sensors: [],
        swapTotal: 0,
        swapUsed: 0,
        uptime: '1h',
      ),
    );
