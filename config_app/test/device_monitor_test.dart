import 'dart:async';

import 'package:config_app/features/device/data/device_repository.dart';
import 'package:config_app/features/device/presentation/device_monitor.dart';
import 'package:config_app/features/realtime/domain/services/realtime_service.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/serializers.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late _Client client;
  late DeviceRepository repository;

  setUp(() {
    client = _Client();
    repository = DeviceRepository(client);
  });

  tearDown(() => client.close());

  Matcher failure(DeviceFailureKind kind) =>
      isA<DeviceFailure>().having((error) => error.kind, 'kind', kind);

  test(
    'repository sends typed RPC and decodes state, metrics and actions',
    () async {
      final frame = await repository.getState();
      expect(frame.frontend!.page, FramePage.slideshow);
      expect(frame.presence, FramePresence.present);
      expect((await repository.getSystemInfo()).updateInfo.memUsed, 512);

      final paused = await repository.setControl(FrameControl.pause, true);
      final command = client.commands.last as SetFrameControlCommand;
      expect(command.control, FrameControl.pause);
      expect(command.enabled, isTrue);
      expect(paused.frontend!.isPaused, isTrue);
    },
  );

  test(
    'repository recognizes nested RPC errors for reads and actions',
    () async {
      client.handle = (envelope, command) async => WSRpcResult.byCommand(
        ErrorResult(id: command.id, error: 'private backend failure'),
        envelope,
      );
      await expectLater(
        repository.getState(),
        throwsA(failure(DeviceFailureKind.load)),
      );
      await expectLater(
        repository.setControl(FrameControl.screen, false),
        throwsA(failure(DeviceFailureKind.command)),
      );
    },
  );

  test('repository recognizes websocket and thrown transport errors', () async {
    client.handle = (envelope, _) async =>
        WSErrorResult.byCommand('private websocket failure', envelope);
    await expectLater(
      repository.getState(),
      throwsA(failure(DeviceFailureKind.load)),
    );
    client.handle = (_, command) => Future.error(
      RpcErrorResultException(ErrorResult(id: command.id, error: 'failure')),
    );
    await expectLater(
      repository.setControl(FrameControl.pause, true),
      throwsA(failure(DeviceFailureKind.command)),
    );
  });

  test(
    'repository rejects malformed, mismatched and unexpected responses',
    () async {
      final invalidResponses =
          <Future<WebSocketResult> Function(WSSendRpcCommand, RpcCommand)>[
            (envelope, _) async => WSResultOk(id: envelope.id),
            (envelope, _) async => WSRpcResult(id: envelope.id, resultData: []),
            (envelope, command) async => WSRpcResult.byCommand(
              GetFrameStateResult(id: command.id + 1, state: _frame()),
              envelope,
            ),
            (envelope, command) async => WSRpcResult(
              id: envelope.id + 1,
              resultData: serializers.serialize(
                GetFrameStateResult(id: command.id, state: _frame()),
              )!,
            ),
            (envelope, command) async =>
                WSRpcResult.byCommand(EmptyResult(id: command.id), envelope),
          ];
      for (final response in invalidResponses) {
        client.handle = response;
        await expectLater(
          repository.getState(),
          throwsA(failure(DeviceFailureKind.invalidResponse)),
        );
      }
    },
  );

  testWidgets('polls state every second and metrics every ten seconds', (
    tester,
  ) async {
    final monitor = DeviceMonitor(repository, telemetry: true)..start();
    await tester.pump();
    expect(client.stateCalls, 1);
    expect(client.metricCalls, 1);
    expect(monitor.canControl, isTrue);
    expect(monitor.loading, isFalse);
    expect(monitor.metricsSampledAt, _sampledAt);
    await tester.pump(const Duration(seconds: 1));
    expect(client.stateCalls, 2);
    expect(client.metricCalls, 1);
    await tester.pump(const Duration(seconds: 9));
    expect(client.metricCalls, 2);
    monitor.dispose();
    await tester.pump(const Duration(seconds: 20));
    expect(client.metricCalls, 2);
    expect(client.hasDisconnectListener, isFalse);
  });

  testWidgets('control page never fetches system metrics', (tester) async {
    final monitor = DeviceMonitor(repository, telemetry: false)..start();
    await tester.pump();
    await tester.pump(const Duration(seconds: 10));
    await monitor.refresh();
    expect(client.metricCalls, 0);
    monitor.dispose();
  });

  testWidgets(
    'slow metrics do not delay state polling or duplicate metrics requests',
    (tester) async {
      final response = Completer<WebSocketResult>();
      late WSSendRpcCommand request;
      late RpcCommand rpc;
      client.handle = (envelope, command) {
        if (command is GetSystemInfoCommand) {
          request = envelope;
          rpc = command;
          return response.future;
        }
        return client.respond(envelope, command);
      };
      final monitor = DeviceMonitor(repository, telemetry: true)..start();
      await tester.pump();
      expect(monitor.loading, isFalse);
      expect(monitor.stale, isFalse);
      expect(monitor.metrics, isNull);
      final firstFrame = monitor.frame;
      for (var second = 0; second < 12; second++) {
        await tester.pump(const Duration(seconds: 1));
      }
      expect(client.stateCalls, 13);
      expect(monitor.frame, isNot(same(firstFrame)));
      expect(client.metricCalls, 1);
      expect(monitor.canControl, isTrue);
      response.complete(
        WSRpcResult.byCommand(
          GetSystemInfoCommandResult(id: rpc.id, systemInfo: _metrics()),
          request,
        ),
      );
      await tester.pump();
      expect(client.metricCalls, 1);
      expect(monitor.metricsSampledAt, _sampledAt);
      monitor.dispose();
    },
  );

  testWidgets('commands complete while a metrics request remains pending', (
    tester,
  ) async {
    final response = Completer<WebSocketResult>();
    late WSSendRpcCommand request;
    late RpcCommand rpc;
    client.handle = (envelope, command) {
      if (command is GetSystemInfoCommand) {
        request = envelope;
        rpc = command;
        return response.future;
      }
      return client.respond(envelope, command);
    };
    final monitor = DeviceMonitor(repository, telemetry: true)..start();
    await tester.pump();
    final action = monitor.setControl(FrameControl.pause, true);
    await tester.pump();
    expect(client.actionCalls, 1);
    expect(monitor.pendingControl, isNull);
    expect(monitor.frame!.frontend!.isPaused, isTrue);
    expect(monitor.metrics, isNull);
    await action;
    response.complete(
      WSRpcResult.byCommand(
        GetSystemInfoCommandResult(id: rpc.id, systemInfo: _metrics()),
        request,
      ),
    );
    await tester.pump();
    expect(monitor.frame!.frontend!.isPaused, isTrue);
    expect(client.actionCalls, 1);
    monitor.dispose();
  });

  testWidgets(
    'resume refreshes state independently and discards obsolete metrics response',
    (tester) async {
      final response = Completer<WebSocketResult>();
      client.handle = (envelope, command) {
        if (command is GetSystemInfoCommand && client.metricCalls == 1) {
          return response.future;
        }
        return client.respond(envelope, command);
      };
      final monitor = DeviceMonitor(repository, telemetry: true)..start();
      await tester.pump();
      monitor.setActive(false);
      monitor.setActive(true);
      await tester.pump();
      expect(client.stateCalls, 2);
      expect(client.metricCalls, 1);
      expect(monitor.metrics, isNull);
      expect(monitor.canControl, isTrue);
      response.completeError(StateError('obsolete metrics failure'));
      await tester.pump();
      expect(client.metricCalls, 2);
      expect(monitor.metrics, isNotNull);
      expect(monitor.metricsFailure, isNull);
      expect(monitor.metricsStale, isFalse);
      monitor.dispose();
    },
  );

  testWidgets('concurrent refreshes share one pending snapshot', (
    tester,
  ) async {
    final response = Completer<WebSocketResult>();
    late WSSendRpcCommand request;
    late RpcCommand rpc;
    client.handle = (envelope, command) {
      request = envelope;
      rpc = command;
      return response.future;
    };
    final monitor = DeviceMonitor(repository, telemetry: false)..start();
    final firstRefresh = monitor.refresh();
    final secondRefresh = monitor.refresh();
    expect(firstRefresh, same(secondRefresh));
    response.complete(
      WSRpcResult.byCommand(
        GetFrameStateResult(id: rpc.id, state: _frame()),
        request,
      ),
    );
    await firstRefresh;
    await tester.pump();
    expect(client.stateCalls, 1);
    monitor.dispose();
  });

  testWidgets(
    'keeps successful state and old metrics timestamp after metrics failure',
    (tester) async {
      final monitor = DeviceMonitor(repository, telemetry: true)..start();
      await tester.pump();
      final previousMetrics = monitor.metrics;
      client.handle = (envelope, command) async {
        if (command is GetSystemInfoCommand) {
          return WSRpcResult.byCommand(
            ErrorResult(id: command.id, error: 'failed'),
            envelope,
          );
        }
        return WSRpcResult.byCommand(
          GetFrameStateResult(id: command.id, state: _frame(paused: true)),
          envelope,
        );
      };
      await monitor.refresh();
      expect(monitor.frame!.frontend!.isPaused, isTrue);
      expect(monitor.stale, isFalse);
      expect(monitor.canControl, isTrue);
      expect(monitor.failure, isNull);
      expect(monitor.metrics, same(previousMetrics));
      expect(monitor.metricsSampledAt, _sampledAt);
      expect(monitor.metricsStale, isTrue);
      expect(monitor.metricsFailure!.kind, DeviceFailureKind.load);
      monitor.dispose();
    },
  );

  testWidgets(
    'state failure retains last values and disables commands until refresh',
    (tester) async {
      final monitor = DeviceMonitor(repository, telemetry: false)..start();
      await tester.pump();
      final previousFrame = monitor.frame;
      client.handle = (_, _) => Future.error(TimeoutException('timed out'));
      await monitor.refresh();
      expect(monitor.frame, same(previousFrame));
      expect(monitor.stale, isTrue);
      expect(monitor.canControl, isFalse);
      await monitor.setControl(FrameControl.pause, true);
      expect(client.actionCalls, 0);
      client.handle = client.respond;
      await monitor.refresh();
      expect(monitor.stale, isFalse);
      expect(monitor.failure, isNull);
      monitor.dispose();
    },
  );

  testWidgets(
    'coalesces polling and waits for pending refresh before an action',
    (tester) async {
      final monitor = DeviceMonitor(repository, telemetry: false)..start();
      await tester.pump();
      final poll = Completer<WebSocketResult>();
      late WSSendRpcCommand pollEnvelope;
      late RpcCommand pollCommand;
      client.handle = (envelope, command) {
        if (command is GetFrameStateCommand) {
          pollEnvelope = envelope;
          pollCommand = command;
          return poll.future;
        }
        return client.respond(envelope, command);
      };
      await tester.pump(const Duration(seconds: 1));
      final action = monitor.setControl(FrameControl.pause, true);
      expect(monitor.pendingControl, FrameControl.pause);
      expect(monitor.busy, isTrue);
      await tester.pump(const Duration(seconds: 3));
      expect(client.stateCalls, 2);
      expect(client.actionCalls, 0);
      poll.complete(
        WSRpcResult.byCommand(
          GetFrameStateResult(id: pollCommand.id, state: _frame()),
          pollEnvelope,
        ),
      );
      await action;
      expect(client.actionCalls, 1);
      expect(monitor.frame!.frontend!.isPaused, isTrue);
      expect(monitor.pendingControl, isNull);
      expect(monitor.busy, isFalse);
      monitor.dispose();
    },
  );

  testWidgets(
    'command failure clears pending state and does not replay actions',
    (tester) async {
      final monitor = DeviceMonitor(repository, telemetry: false)..start();
      await tester.pump();
      client.handle = (envelope, command) {
        if (command is SetFrameControlCommand) {
          return Future.error(TimeoutException('unknown result'));
        }
        return client.respond(envelope, command);
      };
      await monitor.setControl(FrameControl.pause, true);
      expect(monitor.pendingControl, isNull);
      expect(monitor.busy, isFalse);
      expect(monitor.failure!.kind, DeviceFailureKind.command);
      expect(monitor.stale, isTrue);
      await monitor.setControl(FrameControl.pause, true);
      expect(client.actionCalls, 1);
      await tester.pump(const Duration(seconds: 1));
      expect(monitor.stale, isFalse);
      expect(client.actionCalls, 1);
      monitor.dispose();
    },
  );

  testWidgets('suspension cancels an action waiting for a poll', (
    tester,
  ) async {
    final monitor = DeviceMonitor(repository, telemetry: false)..start();
    await tester.pump();
    final response = Completer<WebSocketResult>();
    late WSSendRpcCommand request;
    late RpcCommand rpc;
    client.handle = (envelope, command) {
      request = envelope;
      rpc = command;
      return response.future;
    };
    await tester.pump(const Duration(seconds: 1));
    final action = monitor.setControl(FrameControl.pause, true);
    expect(monitor.busy, isTrue);
    monitor.setActive(false);
    response.complete(
      WSRpcResult.byCommand(
        GetFrameStateResult(id: rpc.id, state: _frame()),
        request,
      ),
    );
    await action;
    expect(monitor.pendingControl, isNull);
    expect(client.actionCalls, 0);
    client.handle = client.respond;
    monitor.setActive(true);
    await tester.pump();
    expect(client.actionCalls, 0);
    expect(monitor.canControl, isTrue);
    monitor.dispose();
  });

  testWidgets('resume waits for an in-flight action without replaying it', (
    tester,
  ) async {
    final monitor = DeviceMonitor(repository, telemetry: false)..start();
    await tester.pump();
    final response = Completer<WebSocketResult>();
    late WSSendRpcCommand request;
    late RpcCommand rpc;
    client.handle = (envelope, command) {
      request = envelope;
      rpc = command;
      return response.future;
    };
    final action = monitor.setControl(FrameControl.pause, true);
    await tester.pump();
    expect(client.actionCalls, 1);
    monitor.setActive(false);
    client.handle = client.respond;
    monitor.setActive(true);
    await tester.pump(const Duration(seconds: 3));
    expect(client.stateCalls, 1);
    expect(monitor.canControl, isFalse);
    response.complete(
      WSRpcResult.byCommand(
        GetFrameStateResult(id: rpc.id, state: _frame(paused: true)),
        request,
      ),
    );
    await action;
    await tester.pump();
    expect(client.stateCalls, 2);
    expect(client.actionCalls, 1);
    expect(monitor.frame!.frontend!.isPaused, isFalse);
    expect(monitor.canControl, isTrue);
    monitor.dispose();
  });

  testWidgets(
    'hidden page stops timers, ignores late response and refreshes on resume',
    (tester) async {
      final response = Completer<WebSocketResult>();
      late WSSendRpcCommand request;
      late RpcCommand rpc;
      client.handle = (envelope, command) {
        request = envelope;
        rpc = command;
        return response.future;
      };
      final monitor = DeviceMonitor(repository, telemetry: false)..start();
      expect(monitor.loading, isTrue);
      monitor.setActive(false);
      await tester.pump(const Duration(seconds: 10));
      expect(client.stateCalls, 1);
      response.complete(
        WSRpcResult.byCommand(
          GetFrameStateResult(id: rpc.id, state: _frame()),
          request,
        ),
      );
      await tester.pump();
      expect(monitor.frame, isNull);
      expect(monitor.canControl, isFalse);
      client.handle = client.respond;
      monitor.setActive(true);
      await tester.pump();
      expect(client.stateCalls, 2);
      expect(monitor.frame, isNotNull);
      expect(monitor.canControl, isTrue);
      monitor.dispose();
    },
  );

  testWidgets('resume waits for old refresh and discards its obsolete values', (
    tester,
  ) async {
    final response = Completer<WebSocketResult>();
    late WSSendRpcCommand request;
    late RpcCommand rpc;
    client.handle = (envelope, command) {
      request = envelope;
      rpc = command;
      return response.future;
    };
    final monitor = DeviceMonitor(repository, telemetry: false)..start();
    monitor.setActive(false);
    client.handle = client.respond;
    monitor.setActive(true);
    expect(client.stateCalls, 1);
    response.complete(
      WSRpcResult.byCommand(
        GetFrameStateResult(id: rpc.id, state: _frame(paused: true)),
        request,
      ),
    );
    await tester.pump();
    expect(client.stateCalls, 2);
    expect(monitor.frame!.frontend!.isPaused, isFalse);
    monitor.dispose();
  });

  testWidgets(
    'disconnect retains values, ignores command result and stops all polling',
    (tester) async {
      final monitor = DeviceMonitor(repository, telemetry: true)..start();
      await tester.pump();
      final oldFrame = monitor.frame;
      final oldMetrics = monitor.metrics;
      final response = Completer<WebSocketResult>();
      late WSSendRpcCommand request;
      late RpcCommand rpc;
      client.handle = (envelope, command) {
        request = envelope;
        rpc = command;
        return response.future;
      };
      final action = monitor.setControl(FrameControl.screen, false);
      await tester.pump();
      client.disconnect();
      await tester.pump();
      response.complete(
        WSRpcResult.byCommand(
          GetFrameStateResult(id: rpc.id, state: _frame(paused: true)),
          request,
        ),
      );
      await action;
      expect(monitor.frame, same(oldFrame));
      expect(monitor.metrics, same(oldMetrics));
      expect(monitor.failure!.kind, DeviceFailureKind.disconnected);
      expect(monitor.stale, isTrue);
      expect(monitor.metricsStale, isTrue);
      expect(monitor.pendingControl, isNull);
      expect(monitor.canControl, isFalse);
      final calls = client.commands.length;
      await tester.pump(const Duration(seconds: 20));
      await monitor.refresh();
      await monitor.setControl(FrameControl.screen, true);
      expect(client.commands, hasLength(calls));
      monitor.dispose();
    },
  );

  testWidgets(
    'dispose ignores late failures without notifying or retaining subscriptions',
    (tester) async {
      final response = Completer<WebSocketResult>();
      client.handle = (_, _) => response.future;
      final monitor = DeviceMonitor(repository, telemetry: false)..start();
      var notifications = 0;
      monitor.addListener(() => notifications++);
      monitor.dispose();
      monitor.dispose();
      response.completeError(StateError('late failure'));
      await tester.pump();
      await tester.pump(const Duration(seconds: 20));
      expect(notifications, 0);
      expect(client.hasDisconnectListener, isFalse);
      expect(client.stateCalls, 1);
    },
  );
}

final _sampledAt = DateTime.utc(2026, 10, 26, 12);

FrameState _frame({bool paused = false}) => FrameState(
  sampledAt: _sampledAt,
  presence: FramePresence.present,
  presenceObservedAt: _sampledAt,
  isScreenLocked: false,
  isScreenOn: true,
  screenPhase: FrameScreenPhase.on,
  backendVersion: 'backend-test',
  frontend: FrameFrontendState(
    isPaused: paused,
    isMenu: false,
    page: FramePage.slideshow,
    frontendVersion: 'frontend-test',
  ),
);

SystemInfo _metrics() => SystemInfo(
  cpuInfo: const CpuInfo(
    cores: 4,
    hardware: 'test',
    model: 'test frame',
    revision: '1',
  ),
  networkInfo: NetworkInfo(
    lastUpdate: _sampledAt.millisecondsSinceEpoch,
    hasInternet: true,
    interfaces: [],
  ),
  osInfo: const OSInfo(name: 'Linux', osType: OSType.linux),
  updateInfo: UpdateInfo(
    cpuLoad1: 0.1,
    cpuLoad5: 0.2,
    cpuLoad15: 0.3,
    diskAvailable: 1024,
    diskUsed: 1024,
    diskUsedPercent: 50,
    lastUpdate: _sampledAt.millisecondsSinceEpoch,
    memTotal: 1024,
    memUsed: 512,
    sensors: [],
    swapTotal: 0,
    swapUsed: 0,
    uptime: '1 day',
  ),
);

class _Client implements RealtimeService {
  final _disconnects = StreamController<void>.broadcast();
  final commands = <RpcCommand>[];
  late Future<WebSocketResult> Function(WSSendRpcCommand, RpcCommand) handle =
      respond;

  bool get hasDisconnectListener => _disconnects.hasListener;
  int get stateCalls => commands.whereType<GetFrameStateCommand>().length;
  int get metricCalls => commands.whereType<GetSystemInfoCommand>().length;
  int get actionCalls => commands.whereType<SetFrameControlCommand>().length;

  Future<WebSocketResult> respond(
    WSSendRpcCommand envelope,
    RpcCommand command,
  ) async {
    final RpcResult result;
    if (command is GetSystemInfoCommand) {
      result = GetSystemInfoCommandResult(
        id: command.id,
        systemInfo: _metrics(),
      );
    } else {
      result = GetFrameStateResult(
        id: command.id,
        state: _frame(
          paused:
              command is SetFrameControlCommand &&
              command.control == FrameControl.pause &&
              command.enabled,
        ),
      );
    }
    return WSRpcResult.byCommand(result, envelope);
  }

  @override
  Future<WebSocketResult> send(WebSocketCommand command) {
    final envelope = command as WSSendRpcCommand;
    final rpc = serializers.deserialize(envelope.commandData) as RpcCommand;
    commands.add(rpc);
    return handle(envelope, rpc);
  }

  @override
  Stream<void> get onDisconnect => _disconnects.stream;

  @override
  void disconnect() => _disconnects.add(null);

  Future<void> close() => _disconnects.close();

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
