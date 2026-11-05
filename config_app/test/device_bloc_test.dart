import 'dart:async';

import 'package:config_app/features/device/data/device_repository.dart';
import 'package:config_app/features/device/presentation/device_bloc.dart';
import 'package:config_app/features/realtime/domain/services/realtime_service.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/serializers.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

void main() {
  late _Client client;
  late DeviceRepository repository;

  setUp(() {
    client = _Client();
    repository = DeviceRepository(client);
  });

  tearDown(() => client.close());

  Future<void> close(WidgetTester tester, DeviceBloc bloc) async {
    await tester.runAsync(bloc.close);
  }

  Matcher failure(DeviceFailureKind kind) => isA<DeviceFailure>().having((error) => error.kind, 'kind', kind);

  test('repository sends typed RPC and decodes state, metrics and actions', () async {
    final frame = await repository.getState();
    expect(frame.frontend!.page, FramePage.slideshow);
    expect(frame.presence, FramePresence.present);
    expect((await repository.getSystemInfo()).updateInfo.memUsed, 512);

    final paused = await repository.setControl(FrameControl.pause, true);
    final command = client.commands.last as SetFrameControlCommand;
    expect(command.control, FrameControl.pause);
    expect(command.enabled, isTrue);
    expect(paused.frontend!.isPaused, isTrue);
  });

  test('repository recognizes nested RPC errors for reads and actions', () async {
    client.handle = (envelope, command) async =>
        WSRpcResult.byCommand(ErrorResult(id: command.id, error: 'private backend failure'), envelope);
    await expectLater(repository.getState(), throwsA(failure(DeviceFailureKind.load)));
    await expectLater(repository.setControl(FrameControl.screen, false), throwsA(failure(DeviceFailureKind.command)));
  });

  test('repository recognizes websocket and thrown transport errors', () async {
    client.handle = (envelope, _) async => WSErrorResult.byCommand('private websocket failure', envelope);
    await expectLater(repository.getState(), throwsA(failure(DeviceFailureKind.load)));
    client.handle = (_, command) =>
        Future.error(RpcErrorResultException(ErrorResult(id: command.id, error: 'failure')));
    await expectLater(repository.setControl(FrameControl.pause, true), throwsA(failure(DeviceFailureKind.command)));
  });

  test('request diagnostics retain original transport cause, stack and remote error text', () async {
    final records = <LogRecord>[];
    final previousLevel = Logger.root.level;
    Logger.root.level = Level.ALL;
    final subscription = Logger.root.onRecord.listen(records.add);
    addTearDown(() async {
      await subscription.cancel();
      Logger.root.level = previousLevel;
    });
    final error = StateError('frame transport failed https://frame.example/private?code=test-secret\nsecond line');
    final stack = StackTrace.fromString('#0 original-send\n#1 original-caller\n#2 final-source-frame');
    client.handle = (_, _) => Future.error(error, stack);
    await expectLater(repository.setControl(FrameControl.pause, true), throwsA(failure(DeviceFailureKind.command)));
    final original = records.singleWhere((record) => record.error == error);
    expect(original.message, contains('set_frame_control'));
    expect(original.error.toString(), contains('test-secret\nsecond line'));
    expect(original.stackTrace, same(stack));
    client.handle = (envelope, command) async =>
        WSRpcResult.byCommand(ErrorResult(id: command.id, error: 'backend original failure'), envelope);
    await expectLater(repository.getState(), throwsA(failure(DeviceFailureKind.load)));
    client.handle = (envelope, _) async => WSErrorResult.byCommand('websocket original failure', envelope);
    await expectLater(repository.getState(), throwsA(failure(DeviceFailureKind.load)));
    expect(records.any((record) => record.error == 'backend original failure'), isTrue);
    expect(records.any((record) => record.error == 'websocket original failure'), isTrue);
  });

  testWidgets('commands log intent, confirmation and unknown result without replay', (tester) async {
    final records = <LogRecord>[];
    final previousLevel = Logger.root.level;
    Logger.root.level = Level.ALL;
    final subscription = Logger.root.onRecord.listen(records.add);
    addTearDown(() async {
      await subscription.cancel();
      Logger.root.level = previousLevel;
    });
    final bloc = DeviceBloc(repository, telemetry: false)..start();
    await tester.pump();
    await bloc.setControl(FrameControl.pause, true);
    final error = TimeoutException('screen command result unknown');
    final stack = StackTrace.fromString('#0 screen-transport-source\n#1 screen-transport-caller');
    client.handle = (envelope, command) =>
        command is SetFrameControlCommand ? Future.error(error, stack) : client.respond(envelope, command);
    await bloc.setControl(FrameControl.screen, false);
    expect(bloc.state.stale, isTrue);
    expect(
      records.any(
        (record) => record.level == Level.INFO && record.message == 'Control started control=pause enabled=true',
      ),
      isTrue,
    );
    expect(records.any((record) => record.message == 'Control confirmed control=pause enabled=true'), isTrue);
    expect(
      records.any(
        (record) => record.level == Level.WARNING && record.message.contains('Control not confirmed control=screen'),
      ),
      isTrue,
    );
    expect(records.singleWhere((record) => record.error == error).stackTrace, same(stack));
    await tester.pump(const Duration(seconds: 1));
    expect(bloc.state.stale, isFalse);
    expect(client.actionCalls, 2);
    await close(tester, bloc);
  });

  testWidgets('application lifecycle suspends and resumes the page-owned poller', (tester) async {
    final bloc = DeviceBloc(repository, telemetry: false)..start();
    await tester.pump();
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.hidden);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    final calls = client.stateCalls;
    await tester.pump(const Duration(seconds: 3));
    expect(client.stateCalls, calls);
    expect(bloc.state.canControl, isFalse);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.hidden);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump();
    expect(client.stateCalls, calls + 1);
    expect(bloc.state.canControl, isTrue);
    await close(tester, bloc);
  });

  test('repository rejects malformed, mismatched and unexpected responses', () async {
    final invalidResponses = <Future<WebSocketResult> Function(WSSendRpcCommand, RpcCommand)>[
      (envelope, _) async => WSResultOk(id: envelope.id),
      (envelope, _) async => WSRpcResult(id: envelope.id, resultData: []),
      (envelope, command) async =>
          WSRpcResult.byCommand(GetFrameStateResult(id: command.id + 1, state: _frame()), envelope),
      (envelope, command) async => WSRpcResult(
        id: envelope.id + 1,
        resultData: serializers.serialize(GetFrameStateResult(id: command.id, state: _frame()))!,
      ),
      (envelope, command) async => WSRpcResult.byCommand(EmptyResult(id: command.id), envelope),
    ];
    for (final response in invalidResponses) {
      client.handle = response;
      await expectLater(repository.getState(), throwsA(failure(DeviceFailureKind.invalidResponse)));
    }
  });

  testWidgets('polls state every second, RPC every five and metrics every ten seconds', (tester) async {
    final records = <LogRecord>[];
    final previousLevel = Logger.root.level;
    Logger.root.level = Level.ALL;
    final logs = Logger.root.onRecord.listen(records.add);
    addTearDown(() async {
      await logs.cancel();
      Logger.root.level = previousLevel;
    });
    final bloc = DeviceBloc(repository, telemetry: true)..start();
    await tester.pump();
    expect(client.stateCalls, 1);
    expect(client.metricCalls, 1);
    expect(client.commands.whereType<GetRpcTelemetryCommand>(), hasLength(1));
    expect(bloc.state.canControl, isTrue);
    expect(bloc.state.loading, isFalse);
    expect(bloc.state.metricsSampledAt, _sampledAt);
    await tester.pump(const Duration(seconds: 1));
    expect(client.stateCalls, 2);
    expect(client.metricCalls, 1);
    await tester.pump(const Duration(seconds: 3));
    expect(client.commands.whereType<GetRpcTelemetryCommand>(), hasLength(1));
    await tester.pump(const Duration(seconds: 1));
    expect(client.commands.whereType<GetRpcTelemetryCommand>(), hasLength(2));
    expect(client.metricCalls, 1);
    await tester.pump(const Duration(seconds: 5));
    expect(client.metricCalls, 2);
    expect(client.commands.whereType<GetRpcTelemetryCommand>(), hasLength(3));
    await close(tester, bloc);
    await tester.pump(const Duration(seconds: 20));
    expect(client.metricCalls, 2);
    expect(client.commands.whereType<GetRpcTelemetryCommand>(), hasLength(3));
    expect(client.hasDisconnectListener, isFalse);
    expect(
      records.where((record) => record.loggerName == 'DeviceBloc' && record.message.startsWith('Polling started')),
      hasLength(1),
    );
    expect(records.any((record) => record.message == 'Polling started telemetry=true rpcIntervalSeconds=5'), isTrue);
    expect(records.any((record) => record.message == 'Polling stopped'), isTrue);
  });

  testWidgets('control page never fetches system metrics', (tester) async {
    final bloc = DeviceBloc(repository, telemetry: false)..start();
    await tester.pump();
    await tester.pump(const Duration(seconds: 10));
    await bloc.refresh();
    expect(client.metricCalls, 0);
    expect(client.commands.whereType<GetRpcTelemetryCommand>(), isEmpty);
    await close(tester, bloc);
  });

  testWidgets('RPC polling coalesces, keeps stale data and stops while hidden', (tester) async {
    final bloc = DeviceBloc(repository, telemetry: true)..start();
    await tester.pump();
    final original = bloc.state.rpc;
    expect(original, isNotNull);
    expect(bloc.state.rpcStale, isFalse);
    final pending = Completer<WebSocketResult>();
    client.handle = (envelope, command) {
      if (command is GetRpcTelemetryCommand) return pending.future;
      return client.respond(envelope, command);
    };
    await tester.pump(const Duration(seconds: 5));
    final calls = client.commands.whereType<GetRpcTelemetryCommand>().length;
    await tester.pump(const Duration(seconds: 10));
    expect(client.commands.whereType<GetRpcTelemetryCommand>(), hasLength(calls));
    expect(bloc.state.frame, isNotNull);
    expect(bloc.state.canControl, isTrue);
    await bloc.setControl(FrameControl.menu, true);
    expect(client.actionCalls, 1);
    expect(pending.isCompleted, isFalse);
    pending.completeError(TimeoutException('expected timeout'));
    await tester.pump();
    expect(bloc.state.rpc, same(original));
    expect(bloc.state.rpcStale, isTrue);
    bloc.setActive(false);
    await tester.pump(const Duration(seconds: 20));
    expect(client.commands.whereType<GetRpcTelemetryCommand>(), hasLength(calls));
    client.handle = client.respond;
    bloc.setActive(true);
    await tester.pump();
    expect(bloc.state.rpcStale, isFalse);
    await close(tester, bloc);
  });

  testWidgets('late RPC metrics cannot update a closed page', (tester) async {
    final pending = Completer<WebSocketResult>();
    client.handle = (envelope, command) {
      if (command is GetRpcTelemetryCommand) return pending.future;
      return client.respond(envelope, command);
    };
    final bloc = DeviceBloc(repository, telemetry: true)..start();
    await tester.pump();
    await close(tester, bloc);
    pending.completeError(StateError('late RPC error'));
    await tester.pump();
    expect(bloc.state.rpc, isNull);
    expect(tester.takeException(), isNull);
  });

  testWidgets('slow metrics do not delay state polling or duplicate metrics requests', (tester) async {
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
    final bloc = DeviceBloc(repository, telemetry: true)..start();
    await tester.pump();
    expect(bloc.state.loading, isFalse);
    expect(bloc.state.stale, isFalse);
    expect(bloc.state.metrics, isNull);
    final firstFrame = bloc.state.frame;
    for (var second = 0; second < 12; second++) {
      await tester.pump(const Duration(seconds: 1));
    }
    expect(client.stateCalls, 13);
    expect(bloc.state.frame, isNot(same(firstFrame)));
    expect(client.metricCalls, 1);
    expect(bloc.state.canControl, isTrue);
    response.complete(WSRpcResult.byCommand(GetSystemInfoCommandResult(id: rpc.id, systemInfo: _metrics()), request));
    await tester.pump();
    expect(client.metricCalls, 1);
    expect(bloc.state.metricsSampledAt, _sampledAt);
    await close(tester, bloc);
  });

  testWidgets('commands complete while a metrics request remains pending', (tester) async {
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
    final bloc = DeviceBloc(repository, telemetry: true)..start();
    await tester.pump();
    final action = bloc.setControl(FrameControl.pause, true);
    await tester.pump();
    expect(client.actionCalls, 1);
    expect(bloc.state.pendingControl, isNull);
    expect(bloc.state.frame!.frontend!.isPaused, isTrue);
    expect(bloc.state.metrics, isNull);
    await action;
    response.complete(WSRpcResult.byCommand(GetSystemInfoCommandResult(id: rpc.id, systemInfo: _metrics()), request));
    await tester.pump();
    expect(bloc.state.frame!.frontend!.isPaused, isTrue);
    expect(client.actionCalls, 1);
    await close(tester, bloc);
  });

  testWidgets('resume refreshes state independently and discards obsolete metrics response', (tester) async {
    final response = Completer<WebSocketResult>();
    client.handle = (envelope, command) {
      if (command is GetSystemInfoCommand && client.metricCalls == 1) {
        return response.future;
      }
      return client.respond(envelope, command);
    };
    final bloc = DeviceBloc(repository, telemetry: true)..start();
    await tester.pump();
    bloc.setActive(false);
    bloc.setActive(true);
    await tester.pump();
    expect(client.stateCalls, 2);
    expect(client.metricCalls, 1);
    expect(bloc.state.metrics, isNull);
    expect(bloc.state.canControl, isTrue);
    response.completeError(StateError('obsolete metrics failure'));
    await tester.pump();
    expect(client.metricCalls, 2);
    expect(bloc.state.metrics, isNotNull);
    expect(bloc.state.metricsFailure, isNull);
    expect(bloc.state.metricsStale, isFalse);
    await close(tester, bloc);
  });

  testWidgets('concurrent refreshes share one pending snapshot', (tester) async {
    final response = Completer<WebSocketResult>();
    late WSSendRpcCommand request;
    late RpcCommand rpc;
    client.handle = (envelope, command) {
      request = envelope;
      rpc = command;
      return response.future;
    };
    final bloc = DeviceBloc(repository, telemetry: false)..start();
    final firstRefresh = bloc.refresh();
    final secondRefresh = bloc.refresh();
    expect(firstRefresh, same(secondRefresh));
    response.complete(WSRpcResult.byCommand(GetFrameStateResult(id: rpc.id, state: _frame()), request));
    await firstRefresh;
    await tester.pump();
    expect(client.stateCalls, 1);
    await close(tester, bloc);
  });

  testWidgets('keeps successful state and old metrics timestamp after metrics failure', (tester) async {
    final bloc = DeviceBloc(repository, telemetry: true)..start();
    await tester.pump();
    final previousMetrics = bloc.state.metrics;
    client.handle = (envelope, command) async {
      if (command is GetSystemInfoCommand) {
        return WSRpcResult.byCommand(ErrorResult(id: command.id, error: 'failed'), envelope);
      }
      return WSRpcResult.byCommand(GetFrameStateResult(id: command.id, state: _frame(paused: true)), envelope);
    };
    await bloc.refresh();
    expect(bloc.state.frame!.frontend!.isPaused, isTrue);
    expect(bloc.state.stale, isFalse);
    expect(bloc.state.canControl, isTrue);
    expect(bloc.state.failure, isNull);
    expect(bloc.state.metrics, same(previousMetrics));
    expect(bloc.state.metricsSampledAt, _sampledAt);
    expect(bloc.state.metricsStale, isTrue);
    expect(bloc.state.metricsFailure!.kind, DeviceFailureKind.load);
    await close(tester, bloc);
  });

  testWidgets('state failure retains last values and disables commands until refresh', (tester) async {
    final bloc = DeviceBloc(repository, telemetry: false)..start();
    await tester.pump();
    final previousFrame = bloc.state.frame;
    client.handle = (_, _) => Future.error(TimeoutException('timed out'));
    await bloc.refresh();
    expect(bloc.state.frame, same(previousFrame));
    expect(bloc.state.stale, isTrue);
    expect(bloc.state.canControl, isFalse);
    await bloc.setControl(FrameControl.pause, true);
    expect(client.actionCalls, 0);
    client.handle = client.respond;
    await bloc.refresh();
    expect(bloc.state.stale, isFalse);
    expect(bloc.state.failure, isNull);
    await close(tester, bloc);
  });

  testWidgets('coalesces polling and waits for pending refresh before an action', (tester) async {
    final bloc = DeviceBloc(repository, telemetry: false)..start();
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
    final action = bloc.setControl(FrameControl.pause, true);
    expect(bloc.state.pendingControl, FrameControl.pause);
    expect(bloc.state.commandInFlight, isTrue);
    await tester.pump(const Duration(seconds: 3));
    expect(client.stateCalls, 2);
    expect(client.actionCalls, 0);
    poll.complete(WSRpcResult.byCommand(GetFrameStateResult(id: pollCommand.id, state: _frame()), pollEnvelope));
    await action;
    expect(client.actionCalls, 1);
    expect(bloc.state.frame!.frontend!.isPaused, isTrue);
    expect(bloc.state.pendingControl, isNull);
    expect(bloc.state.commandInFlight, isFalse);
    await close(tester, bloc);
  });

  testWidgets('command failure clears pending state and does not replay actions', (tester) async {
    final bloc = DeviceBloc(repository, telemetry: false)..start();
    await tester.pump();
    client.handle = (envelope, command) {
      if (command is SetFrameControlCommand) {
        return Future.error(TimeoutException('unknown result'));
      }
      return client.respond(envelope, command);
    };
    await bloc.setControl(FrameControl.pause, true);
    expect(bloc.state.pendingControl, isNull);
    expect(bloc.state.commandInFlight, isFalse);
    expect(bloc.state.failure!.kind, DeviceFailureKind.command);
    expect(bloc.state.stale, isTrue);
    await bloc.setControl(FrameControl.pause, true);
    expect(client.actionCalls, 1);
    await tester.pump(const Duration(seconds: 1));
    expect(bloc.state.stale, isFalse);
    expect(client.actionCalls, 1);
    await close(tester, bloc);
  });

  testWidgets('suspension cancels an action waiting for a poll', (tester) async {
    final records = <LogRecord>[];
    final subscription = Logger.root.onRecord.listen(records.add);
    addTearDown(subscription.cancel);
    final bloc = DeviceBloc(repository, telemetry: false)..start();
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
    final action = bloc.setControl(FrameControl.pause, true);
    expect(bloc.state.commandInFlight, isTrue);
    bloc.setActive(false);
    response.complete(WSRpcResult.byCommand(GetFrameStateResult(id: rpc.id, state: _frame()), request));
    await action;
    expect(records.any((record) => record.message == 'Control cancelled before send control=pause'), isTrue);
    expect(records.where((record) => record.level >= Level.WARNING), isEmpty);
    expect(bloc.state.pendingControl, isNull);
    expect(client.actionCalls, 0);
    client.handle = client.respond;
    bloc.setActive(true);
    await tester.pump();
    expect(client.actionCalls, 0);
    expect(bloc.state.canControl, isTrue);
    await close(tester, bloc);
  });

  testWidgets('resume waits for an in-flight action without replaying it', (tester) async {
    final bloc = DeviceBloc(repository, telemetry: false)..start();
    await tester.pump();
    final response = Completer<WebSocketResult>();
    late WSSendRpcCommand request;
    late RpcCommand rpc;
    client.handle = (envelope, command) {
      request = envelope;
      rpc = command;
      return response.future;
    };
    final action = bloc.setControl(FrameControl.pause, true);
    await tester.pump();
    expect(client.actionCalls, 1);
    bloc.setActive(false);
    client.handle = client.respond;
    bloc.setActive(true);
    await tester.pump(const Duration(seconds: 3));
    expect(client.stateCalls, 1);
    expect(bloc.state.canControl, isFalse);
    response.complete(WSRpcResult.byCommand(GetFrameStateResult(id: rpc.id, state: _frame(paused: true)), request));
    await action;
    await tester.pump();
    expect(client.stateCalls, 2);
    expect(client.actionCalls, 1);
    expect(bloc.state.frame!.frontend!.isPaused, isFalse);
    expect(bloc.state.canControl, isTrue);
    await close(tester, bloc);
  });

  testWidgets('hidden page stops timers, ignores late response and refreshes on resume', (tester) async {
    final response = Completer<WebSocketResult>();
    late WSSendRpcCommand request;
    late RpcCommand rpc;
    client.handle = (envelope, command) {
      request = envelope;
      rpc = command;
      return response.future;
    };
    final bloc = DeviceBloc(repository, telemetry: false)..start();
    expect(bloc.state.loading, isTrue);
    bloc.setActive(false);
    await tester.pump(const Duration(seconds: 10));
    expect(client.stateCalls, 1);
    response.complete(WSRpcResult.byCommand(GetFrameStateResult(id: rpc.id, state: _frame()), request));
    await tester.pump();
    expect(bloc.state.frame, isNull);
    expect(bloc.state.canControl, isFalse);
    client.handle = client.respond;
    bloc.setActive(true);
    await tester.pump();
    expect(client.stateCalls, 2);
    expect(bloc.state.frame, isNotNull);
    expect(bloc.state.canControl, isTrue);
    await close(tester, bloc);
  });

  testWidgets('resume waits for old refresh and discards its obsolete values', (tester) async {
    final response = Completer<WebSocketResult>();
    late WSSendRpcCommand request;
    late RpcCommand rpc;
    client.handle = (envelope, command) {
      request = envelope;
      rpc = command;
      return response.future;
    };
    final bloc = DeviceBloc(repository, telemetry: false)..start();
    bloc.setActive(false);
    client.handle = client.respond;
    bloc.setActive(true);
    expect(client.stateCalls, 1);
    response.complete(WSRpcResult.byCommand(GetFrameStateResult(id: rpc.id, state: _frame(paused: true)), request));
    await tester.pump();
    expect(client.stateCalls, 2);
    expect(bloc.state.frame!.frontend!.isPaused, isFalse);
    await close(tester, bloc);
  });

  testWidgets('disconnect retains values, ignores command result and stops all polling', (tester) async {
    final bloc = DeviceBloc(repository, telemetry: true)..start();
    await tester.pump();
    final oldFrame = bloc.state.frame;
    final oldMetrics = bloc.state.metrics;
    final response = Completer<WebSocketResult>();
    late WSSendRpcCommand request;
    late RpcCommand rpc;
    client.handle = (envelope, command) {
      request = envelope;
      rpc = command;
      return response.future;
    };
    final action = bloc.setControl(FrameControl.screen, false);
    await tester.pump();
    client.disconnect();
    await tester.pump();
    response.complete(WSRpcResult.byCommand(GetFrameStateResult(id: rpc.id, state: _frame(paused: true)), request));
    await action;
    expect(bloc.state.frame, same(oldFrame));
    expect(bloc.state.metrics, same(oldMetrics));
    expect(bloc.state.failure!.kind, DeviceFailureKind.disconnected);
    expect(bloc.state.stale, isTrue);
    expect(bloc.state.metricsStale, isTrue);
    expect(bloc.state.pendingControl, isNull);
    expect(bloc.state.canControl, isFalse);
    final calls = client.commands.length;
    await tester.pump(const Duration(seconds: 20));
    await bloc.refresh();
    await bloc.setControl(FrameControl.screen, true);
    expect(client.commands, hasLength(calls));
    await close(tester, bloc);
  });

  testWidgets('close ignores late failures without notifying or retaining subscriptions', (tester) async {
    final response = Completer<WebSocketResult>();
    client.handle = (_, _) => response.future;
    final bloc = DeviceBloc(repository, telemetry: false)..start();
    final previous = bloc.state;
    await close(tester, bloc);
    response.completeError(StateError('late failure'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 20));
    expect(bloc.state, previous);
    expect(bloc.isClosed, isTrue);
    expect(tester.takeException(), isNull);
    expect(client.hasDisconnectListener, isFalse);
    expect(client.stateCalls, 1);
  });
}

final _sampledAt = DateTime.utc(2026, 10, 26, 12);

FrameState _frame({bool paused = false}) => FrameState(
  sampledAt: _sampledAt,
  presence: FramePresence.present,
  presenceObservedAt: _sampledAt,
  autoWakeEnabled: true,
  isScreenOn: true,
  screenPhase: FrameScreenPhase.on,
  backendVersion: 'backend-test',
  nightMode: const NightModeState(),
  deviceLocalTime: _sampledAt,
  frontend: FrameFrontendState(
    isPaused: paused,
    isMenu: false,
    page: FramePage.slideshow,
    frontendVersion: 'frontend-test',
  ),
);

SystemInfo _metrics() => SystemInfo(
  cpuInfo: const CpuInfo(cores: 4, hardware: 'test', model: 'test frame', revision: '1'),
  networkInfo: NetworkInfo(lastUpdate: _sampledAt.millisecondsSinceEpoch, hasInternet: true, interfaces: []),
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
  late Future<WebSocketResult> Function(WSSendRpcCommand, RpcCommand) handle = respond;

  bool get hasDisconnectListener => _disconnects.hasListener;
  int get stateCalls => commands.whereType<GetFrameStateCommand>().length;
  int get metricCalls => commands.whereType<GetSystemInfoCommand>().length;
  int get actionCalls => commands.whereType<SetFrameControlCommand>().length;

  Future<WebSocketResult> respond(WSSendRpcCommand envelope, RpcCommand command) async {
    final RpcResult result;
    if (command is GetSystemInfoCommand) {
      result = GetSystemInfoCommandResult(id: command.id, systemInfo: _metrics());
    } else if (command is GetRpcTelemetryCommand) {
      result = GetRpcTelemetryResult(id: command.id, snapshot: const RpcTelemetrySnapshot());
    } else {
      result = GetFrameStateResult(
        id: command.id,
        state: _frame(
          paused: command is SetFrameControlCommand && command.control == FrameControl.pause && command.enabled,
        ),
      );
    }
    return WSRpcResult.byCommand(result, envelope);
  }

  @override
  Future<WebSocketResult> send(WebSocketCommand command, {Duration? timeout}) {
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
