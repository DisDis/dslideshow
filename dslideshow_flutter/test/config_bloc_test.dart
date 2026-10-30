import 'package:dslideshow_flutter/src/service/frontend.dart' show ButtonEvent;

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_flutter/features/config/data/config_access_repository.dart';
import 'package:dslideshow_flutter/features/config/presentation/bloc/config_bloc.dart';
import 'package:dslideshow_flutter/features/config/presentation/bloc/config_event.dart';
import 'package:dslideshow_flutter/features/config/presentation/bloc/config_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';

import 'support/config_frontend.dart';
import 'support/ota_frontend.dart';

void main() {
  late ConfigTestFrontend frontend;
  late ConfigAccessRepository repository;
  late ConfigBloc bloc;
  setUp(() {
    frontend = ConfigTestFrontend();
    repository = ConfigAccessRepository(
      frontend: frontend,
      port: 8181,
      alwaysEnabled: false,
    );
    bloc = ConfigBloc(repository: repository);
  });
  tearDown(() async {
    frontend.finishPending();
    await bloc.close();
    await frontend.close();
  });
  Future<ConfigState> until(bool Function(ConfigState) match) async {
    if (match(bloc.state)) return bloc.state;
    return bloc.stream.firstWhere(match).timeout(const Duration(seconds: 3));
  }

  Future<void> initialize() async {
    bloc.add(const ConfigEvent.initialize());
    await until((s) => s.pending.length == 2);
    // Start is serialized through the repository's future chain.
    await Future<void>.value();
  }

  Future<void> ready() async {
    await initialize();
    frontend.starts.single.complete('83472');
    frontend.systems.single.complete(otaSystemInfo());
    await until((s) => s.phase == ConfigPhase.ready);
  }

  for (final networkFirst in [false, true]) {
    test(
      'preparation handles networkFirst=$networkFirst and keeps configured port',
      () async {
        await initialize();
        if (networkFirst) {
          frontend.systems.single.complete(otaSystemInfo());
          await until((s) => s.network == ConfigNetworkStatus.ready);
          expect(bloc.state.phase, ConfigPhase.preparing);
          frontend.starts.single.complete('83472');
        } else {
          frontend.starts.single.complete('83472');
          await until((s) => s.phase == ConfigPhase.preparingAddress);
          expect(bloc.state.code, '83472');
          frontend.systems.single.complete(otaSystemInfo());
        }
        final state = await until((s) => s.phase == ConfigPhase.ready);
        expect(state.address.toString(), 'http://192.168.50.143:8181');
        bloc.add(const ConfigEvent.initialize());
        bloc.add(const ConfigEvent.retry());
        await until((s) => s.refreshing);
        expect(frontend.starts, hasLength(1));
        expect(bloc.state.code, '83472');
      },
    );
  }

  test(
    'live network loss/recovery supersedes an older pending snapshot',
    () async {
      await ready();
      bloc.add(const ConfigEvent.retry());
      await until((s) => s.refreshing);
      frontend.networkEvents.add(otaSystemInfo(interfaces: []));
      await until((s) => s.phase == ConfigPhase.addressUnavailable);
      expect(bloc.state.address, isNull);
      frontend.networkEvents.add(
        otaSystemInfo(
          interfaces: const [
            NetworkInterfaceInfo(
              name: 'eth0',
              status: NetworkInterfaceStatus.running,
              ip4: '192.168.1.9',
              ip6: '',
            ),
          ],
        ),
      );
      await until((s) => s.address?.host == '192.168.1.9');
      frontend.systems.last.complete(otaSystemInfo());
      await until((s) => !s.pending.contains(ConfigOperation.network));
      expect(bloc.state.address?.host, '192.168.1.9');
      expect(frontend.starts, hasLength(1));
    },
  );

  test(
    'network failure hides QR, preserves code and retries only the network',
    () async {
      await ready();
      bloc.add(const ConfigEvent.retry());
      await until((s) => s.refreshing);
      frontend.systems.last.completeError(Exception('secret URL'));
      await until((s) => s.phase == ConfigPhase.failure);
      expect(bloc.state.address, isNull);
      expect(bloc.state.code, '83472');
      expect(bloc.state.failure, ConfigFailureKind.network);
      bloc.add(const ConfigEvent.retry());
      await until((s) => s.phase == ConfigPhase.preparingAddress);
      frontend.systems.last.complete(otaSystemInfo());
      await until((s) => s.phase == ConfigPhase.ready);
      expect(frontend.starts, hasLength(1));
    },
  );

  test(
    'server failure wins over address; successful retry preserves snapshot',
    () async {
      await initialize();
      frontend.systems.single.complete(otaSystemInfo());
      frontend.starts.single.completeError(Exception('do not log me'));
      await until((s) => s.phase == ConfigPhase.failure);
      expect(bloc.state.failure, ConfigFailureKind.server);
      bloc.add(const ConfigEvent.retry());
      await until((s) => s.pending.contains(ConfigOperation.start));
      await Future<void>.value();
      frontend.starts.last.complete('12345');
      await until((s) => s.phase == ConfigPhase.ready);
      expect(bloc.state.code, '12345');
      expect(frontend.systems, hasLength(1));
    },
  );

  test('exit during start waits for cleanup, ignores late network and extra buttons', () async {
    await initialize();
    bloc.add(const ConfigEvent.exit());
    await until((s) => s.phase == ConfigPhase.closing);
    expect(frontend.stops, isEmpty);
    frontend.buttons.add(
      ButtonEvent(
        button: ButtonType.button0,
        event: ButtonEventType.released,
        durationMs: 1,
      ),
    );
    frontend.starts.single.complete('83472');
    frontend.systems.single.complete(otaSystemInfo());
    await until((s) => s.phase == ConfigPhase.exited);
    expect(bloc.state.code, isNull);
    expect(bloc.state.address, isNull);
    expect(frontend.stops, hasLength(1));
    await bloc.close();
    expect(frontend.buttons.hasListener, isFalse);
    expect(frontend.networkEvents.hasListener, isFalse);
  });

  test('stop failure permits retry and a single successful exit', () async {
    await ready();
    frontend.holdStop = true;
    bloc.add(const ConfigEvent.exit());
    await until((s) => s.phase == ConfigPhase.closing);
    await Future<void>.value();
    frontend.stops.single.completeError(Exception('stop refused'));
    await until((s) => s.phase == ConfigPhase.closeFailure);
    bloc.add(const ConfigEvent.retry());
    await until((s) => s.phase == ConfigPhase.closing);
    await Future<void>.value();
    frontend.stops.last.complete();
    await until((s) => s.phase == ConfigPhase.exited);
  });

  test(
    'logs correlate failures and cancellation without credentials',
    () async {
      final records = <LogRecord>[];
      final level = Logger.root.level;
      Logger.root.level = Level.ALL;
      final subscription = Logger.root.onRecord.listen(records.add);
      try {
        await initialize();
        frontend.starts.single.completeError(Exception('http://secret/83472'));
        await until((s) => s.phase == ConfigPhase.failure);
        frontend.holdStart = false;
        frontend.systems.single.complete(otaSystemInfo());
        bloc.add(const ConfigEvent.retry());
        await until((s) => s.phase == ConfigPhase.ready);
        bloc.add(const ConfigEvent.exit());
        await until((s) => s.phase == ConfigPhase.exited);
        await bloc.close();
        final logs = records
            .where((r) => r.loggerName == 'ConfigBloc')
            .map((r) => r.message)
            .join('\n');
        expect(logs, contains('action=start started'));
        expect(logs, contains('failed reason=server'));
        expect(logs, contains('action=stop completed'));
        expect(logs, contains('cancelling'));
        expect(logs, contains('retryOf='));
        expect(logs, isNot(contains('83472')));
        expect(logs, isNot(contains('http://')));
      } finally {
        await subscription.cancel();
        Logger.root.level = level;
      }
    },
  );
  test(
    'external disposal cancels subscriptions and cleans late successful start',
    () async {
      await initialize();
      await bloc.close();
      expect(frontend.buttons.hasListener, isFalse);
      expect(frontend.networkEvents.hasListener, isFalse);
      frontend.starts.single.complete('83472');
      frontend.systems.single.complete(otaSystemInfo());
      await frontend.stopRequested.future.timeout(const Duration(seconds: 2));
      expect(frontend.stops, hasLength(1));
      expect(bloc.isClosed, isTrue);
    },
  );

  test(
    'physical actions accept release only and do not duplicate start',
    () async {
      await ready();
      frontend.buttons.add(
        ButtonEvent(
          button: ButtonType.button0,
          event: ButtonEventType.pressed,
          durationMs: 0,
        ),
      );
      frontend.buttons.add(
        ButtonEvent(
          button: ButtonType.button3,
          event: ButtonEventType.released,
          durationMs: 0,
        ),
      );
      await until((s) => s.refreshing);
      expect(bloc.state.exit, ConfigExitStatus.active);
      expect(frontend.starts, hasLength(1));
      frontend.systems.last.complete(otaSystemInfo());
      await until((s) => !s.refreshing);
    },
  );
  test(
    'queued initialization and retry cannot start work after close begins',
    () async {
      bloc.add(const ConfigEvent.initialize());
      bloc.add(const ConfigEvent.retry());
      await bloc.close();
      expect(frontend.starts, isEmpty);
      expect(frontend.systems, isEmpty);
      expect(bloc.state.pending, isEmpty);
      expect(frontend.buttons.hasListener, isFalse);
      expect(frontend.networkEvents.hasListener, isFalse);
    },
  );
}
