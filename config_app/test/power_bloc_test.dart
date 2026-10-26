import 'dart:async';
import 'dart:convert';

import 'package:config_app/features/config/data/repository/photoframe_repository.dart';
import 'package:config_app/features/power/presentation/bloc/power_bloc.dart';
import 'package:config_app/features/power/presentation/bloc/power_event.dart';
import 'package:config_app/features/power/presentation/bloc/power_state.dart';
import 'package:config_app/features/realtime/domain/services/realtime_service.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/serializers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';

const _configSecret = 'private-config-sentinel';
const _errorSecret = 'private-error-sentinel';

void main() {
  late List<LogRecord> records;
  late Level previousLogLevel;
  late StreamSubscription<LogRecord> logSubscription;

  setUp(() {
    records = [];
    previousLogLevel = Logger.root.level;
    Logger.root.level = Level.ALL;
    logSubscription = Logger.root.onRecord.listen(records.add);
  });

  tearDown(() async {
    await logSubscription.cancel();
    Logger.root.level = previousLogLevel;
  });

  void expectSafeLogs(String loggerName) {
    final matching = records
        .where((record) => record.loggerName == loggerName)
        .toList();
    expect(matching, isNotEmpty);
    final messages = matching.map((record) => record.message).join('\n');
    expect(messages, isNot(contains(_configSecret)));
    expect(messages, isNot(contains(_errorSecret)));
    expect(matching.every((record) => record.error == null), isTrue);
    expect(matching.every((record) => record.stackTrace == null), isTrue);
  }

  test('loads configuration without logging its secret fields', () async {
    final client = _RealtimeService(handleSend: _successfulConfig);
    final bloc = PowerBloc(
      initialState: const UninitializedPowerState(),
      client: client,
    );
    addTearDown(bloc.close);
    final loaded = bloc.stream.firstWhere(
      (state) => state is InitializedPowerState,
    );

    bloc.add(const LoadPowerEvent());

    final state = await loaded as InitializedPowerState;
    expect(state.config.webServer.permanentCode, _configSecret);
    expect(client.commands.single, isA<WSConfigDownloadCommand>());
    expectSafeLogs('PowerBloc');
  });

  test(
    'a delayed timeout exits loading with an error and allows retry',
    () async {
      final pending = Completer<WebSocketResult>();
      var requests = 0;
      final client = _RealtimeService(
        handleSend: (command) {
          ++requests;
          return requests == 1 ? pending.future : _successfulConfig(command);
        },
      );
      final bloc = PowerBloc(
        initialState: const UninitializedPowerState(),
        client: client,
      );
      addTearDown(bloc.close);
      final failed = bloc.stream.firstWhere(
        (state) => state is ErrorPowerState,
      );

      bloc.add(const LoadPowerEvent());
      await pumpEventQueue();
      expect(bloc.state, isA<UninitializedPowerState>());
      expect(client.commands, hasLength(1));

      pending.completeError(TimeoutException(_errorSecret));
      expect(await failed, isA<ErrorPowerState>());
      expectSafeLogs('PowerBloc');

      final retried = <PowerState>[];
      final retrySubscription = bloc.stream.listen(retried.add);
      addTearDown(retrySubscription.cancel);
      final loaded = bloc.stream.firstWhere(
        (state) => state is InitializedPowerState,
      );

      bloc.add(const LoadPowerEvent());

      expect(await loaded, isA<InitializedPowerState>());
      expect(retried, [
        isA<UninitializedPowerState>(),
        isA<InitializedPowerState>(),
      ]);
      expect(client.commands, hasLength(2));
    },
  );

  test(
    'malformed configuration exits loading without logging its contents',
    () async {
      final client = _RealtimeService(
        handleSend: (command) async =>
            WSConfigDownloadResult(id: command.id, content: '{$_configSecret'),
      );
      final bloc = PowerBloc(
        initialState: const UninitializedPowerState(),
        client: client,
      );
      addTearDown(bloc.close);
      final failed = bloc.stream.firstWhere(
        (state) => state is ErrorPowerState,
      );

      bloc.add(const LoadPowerEvent());

      expect(await failed, isA<ErrorPowerState>());
      expectSafeLogs('PowerBloc');
    },
  );

  for (final event in [
    const RestartAppPowerEvent(),
    const PowerOffPowerEvent(),
  ]) {
    test(
      '${event.runtimeType} converts a send failure into an error',
      () async {
        final client = _RealtimeService(
          handleSendOneWay: (_) => throw StateError(_errorSecret),
        );
        final bloc = PowerBloc(
          initialState: const UninitializedPowerState(),
          client: client,
        );
        addTearDown(bloc.close);
        final failed = bloc.stream.firstWhere(
          (state) => state is ErrorPowerState,
        );

        bloc.add(event);

        expect(await failed, isA<ErrorPowerState>());
        expect(client.oneWayCommands, hasLength(1));
        final command = client.oneWayCommands.single as WSSendRpcCommand;
        expect(
          serializers.deserialize(command.commandData),
          event is RestartAppPowerEvent
              ? isA<RestartAppCommand>()
              : isA<PowerOffCommand>(),
        );
        expectSafeLogs('PowerBloc');
      },
    );
  }

  test(
    'PhotoframeRepository download does not log secret configuration',
    () async {
      final client = _RealtimeService(handleSend: _successfulConfig);
      final repository = PhotoframeRepository(client);
      addTearDown(repository.dispose);

      final config = await repository.getConfig();

      expect(config.webServer.permanentCode, _configSecret);
      expectSafeLogs('PhotoframeRepository');
    },
  );
}

Future<WebSocketResult> _successfulConfig(WebSocketCommand command) async =>
    WSConfigDownloadResult(
      id: command.id,
      content: jsonEncode({
        'web': {'permanentCode': _configSecret},
      }),
    );

class _RealtimeService implements RealtimeService {
  _RealtimeService({this.handleSend, this.handleSendOneWay});

  final Future<WebSocketResult> Function(WebSocketCommand command)? handleSend;
  final void Function(WebSocketCommand command)? handleSendOneWay;
  final commands = <WebSocketCommand>[];
  final oneWayCommands = <WebSocketCommand>[];

  @override
  Future<WebSocketResult> send(WebSocketCommand command) {
    commands.add(command);
    return handleSend!(command);
  }

  @override
  void sendOneWay(WebSocketCommand command) {
    oneWayCommands.add(command);
    handleSendOneWay?.call(command);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
