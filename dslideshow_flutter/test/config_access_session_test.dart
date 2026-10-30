import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_flutter/features/config/data/config_access_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/config_frontend.dart';
import 'support/ota_frontend.dart';

void main() {
  late ConfigTestFrontend frontend;
  late ConfigAccessRepository repository;
  setUp(() {
    frontend = ConfigTestFrontend();
    repository = ConfigAccessRepository(
      frontend: frontend,
      port: 8081,
      alwaysEnabled: false,
    );
  });
  tearDown(() async {
    frontend.finishPending();
    await frontend.close();
  });

  test('late old cleanup cannot disable the new page', () async {
    frontend.holdStart = false;
    final old = repository.createSession();
    await old.start();
    final next = repository.createSession();
    final nextStart = next.start();
    final oldCleanup = old.release();
    await Future.wait([nextStart, oldCleanup]);
    expect(frontend.stops, isEmpty);
    await next.release();
    expect(frontend.stops, hasLength(1));
    await old.release();
    expect(frontend.stops, hasLength(1));
  });

  test('release during pending start is ordered before a new start', () async {
    final old = repository.createSession();
    final start = old.start();
    await Future<void>.value();
    final release = old.release();
    frontend.starts.single.complete('12345');
    expect(await start, '12345');
    await release;
    final next = repository.createSession();
    frontend.holdStart = false;
    await next.start();
    expect(frontend.stops, hasLength(1));
    await next.release();
  });

  test('failed stop may retry without poisoning the command queue', () async {
    frontend.holdStart = false;
    frontend.holdStop = true;
    final session = repository.createSession();
    await session.start();
    final failed = session.release();
    final expectedFailure = expectLater(failed, throwsException);
    await Future<void>.value();
    frontend.stops.single.completeError(Exception('failed'));
    await expectedFailure;
    frontend.holdStop = false;
    await session.release();
    expect(frontend.stops, hasLength(2));
  });

  test(
    'address selection handles missing/empty, loopback and inactive interfaces',
    () {
      expect(repository.addressFor(otaSystemInfo(interfaces: [])), isNull);
      expect(
        repository.addressFor(
          otaSystemInfo().copyWith(
            networkInfo: const NetworkInfo(
              lastUpdate: 0,
              hasInternet: false,
              interfaces: null,
            ),
          ),
        ),
        isNull,
      );
      const interfaces = [
        NetworkInterfaceInfo(
          name: 'lo',
          status: NetworkInterfaceStatus.running,
          ip4: '127.0.0.1',
          ip6: '',
        ),
        NetworkInterfaceInfo(
          name: 'eth1',
          status: NetworkInterfaceStatus.running,
          ip4: '',
          ip6: '',
        ),
        NetworkInterfaceInfo(
          name: 'eth9',
          status: NetworkInterfaceStatus.offline,
          ip4: '10.0.0.9',
          ip6: '',
        ),
        NetworkInterfaceInfo(
          name: 'eth0',
          status: NetworkInterfaceStatus.running,
          ip4: '10.0.0.2',
          ip6: '',
        ),
        NetworkInterfaceInfo(
          name: 'wlan0',
          status: NetworkInterfaceStatus.running,
          ip4: '10.0.0.3',
          ip6: '',
        ),
      ];
      final info = otaSystemInfo(interfaces: interfaces);
      final offline = info.copyWith(
        networkInfo: info.networkInfo.copyWith(hasInternet: false),
      );
      expect(repository.addressFor(offline).toString(), 'http://10.0.0.2:8081');
    },
  );
  test(
    'empty access code is rejected and retry performs a new request',
    () async {
      final session = repository.createSession();
      final start = session.start();
      final failure = expectLater(start, throwsStateError);
      await Future<void>.value();
      frontend.starts.single.complete('  ');
      await failure;
      frontend.holdStart = false;
      expect(await session.start(), '83472');
      expect(frontend.starts, hasLength(2));
      await session.release();
    },
  );
}
