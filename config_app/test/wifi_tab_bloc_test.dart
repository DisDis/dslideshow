import 'dart:async';

import 'package:config_app/features/realtime/domain/services/realtime_service.dart';
import 'package:config_app/features/wifi_config/presentation/bloc/wifi_tab_bloc.dart';
import 'package:config_app/features/wifi_config/presentation/bloc/wifi_tab_event.dart';
import 'package:config_app/features/wifi_config/presentation/bloc/wifi_tab_state.dart';
import 'package:config_app/features/wifi_config/presentation/widgets/wifi_tab.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/serializers.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';

class _RealtimeService implements RealtimeService {
  _RealtimeService(this.handle);

  final Future<WebSocketResult> Function(WSSendRpcCommand command) handle;
  final commands = <WSSendRpcCommand>[];
  final timeouts = <Duration?>[];
  final firstRequest = Completer<void>();

  @override
  Future<WebSocketResult> send(WebSocketCommand command, {Duration? timeout}) {
    final rpc = command as WSSendRpcCommand;
    commands.add(rpc);
    timeouts.add(timeout);
    if (!firstRequest.isCompleted) firstRequest.complete();
    return handle(rpc);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  test('rescan reports a delayed RPC failure without logging its contents', () async {
    final result = Completer<WebSocketResult>();
    final client = _RealtimeService((_) => result.future);
    final bloc = WifiTabBloc(
      initialState: const InWifiTabState(availableNetworks: [], connections: []),
      client: client,
    );
    addTearDown(bloc.close);
    final records = <LogRecord>[];
    final logSubscription = Logger.root.onRecord.listen(records.add);
    addTearDown(logSubscription.cancel);
    final failed = bloc.stream.firstWhere((state) => state is ErrorWifiTabState);

    bloc.add(const RescanWifiTabEvent());
    await pumpEventQueue();

    expect(client.commands, hasLength(1));
    expect(serializers.deserialize(client.commands.single.commandData), isA<WiFiRescanCommand>());
    expect(bloc.state, isA<UnWifiTabState>());
    expect(client.timeouts, [const Duration(seconds: 65)]);

    result.completeError(StateError('private-server-response'));
    expect(await failed, isA<ErrorWifiTabState>());
    final wifiRecords = records.where((record) => record.loggerName == 'WifiTabBloc');
    expect(wifiRecords, isNotEmpty);
    expect(wifiRecords.map((record) => record.message).join(), isNot(contains('private-server-response')));
    expect(wifiRecords.where((record) => record.error != null), isNotEmpty);
    expect(
      wifiRecords
          .where((record) => record.error != null)
          .every((record) => record.stackTrace != null && record.stackTrace.toString().isNotEmpty),
      isTrue,
    );
    expect(
      wifiRecords.map((record) => record.message),
      containsAll([contains('event=started action=rescan'), contains('event=outcomeUnknown action=rescan')]),
    );
    expect(
      wifiRecords.singleWhere((record) => record.message.startsWith('event=outcomeUnknown ')).level,
      Level.WARNING,
    );
  });

  test('removing a connection reports an RPC error and does not reload', () async {
    final client = _RealtimeService(
      (command) => Future.error(WSErrorResult.byCommand('connection unavailable', command)),
    );
    final bloc = WifiTabBloc(initialState: const UnWifiTabState(), client: client);
    addTearDown(bloc.close);
    final failed = bloc.stream.firstWhere((state) => state is ErrorWifiTabState);

    bloc.add(const RemoveWifiTabEvent('connection-id'));

    expect(await failed, isA<ErrorWifiTabState>());
    expect(client.commands, hasLength(1));
    expect(serializers.deserialize(client.commands.single.commandData), isA<WiFiRemoveCommand>());
  });

  test('loading observes errors from both concurrent requests', () async {
    final listResult = Completer<WebSocketResult>();
    final storedResult = Completer<WebSocketResult>();
    final client = _RealtimeService((command) {
      return serializers.deserialize(command.commandData) is WiFiListCommand ? listResult.future : storedResult.future;
    });
    final bloc = WifiTabBloc(initialState: const UnWifiTabState(), client: client);
    addTearDown(bloc.close);
    final failed = bloc.stream.firstWhere((state) => state is ErrorWifiTabState);

    bloc.add(const LoadWifiTabEvent());
    await pumpEventQueue();
    expect(client.commands, hasLength(2));

    // The second request can fail while the first one is still pending.
    storedResult.completeError(StateError('stored connections failed'));
    await pumpEventQueue();
    listResult.completeError(StateError('network scan failed'));

    expect(await failed, isA<ErrorWifiTabState>());
  });

  test('loading keeps network and saved connection results in their fields', () async {
    const network = WiFiNetworkInfo(
      BSSID: '00:11:22:33:44:55',
      SSID: 'Photo frame',
      signal: 90,
      channel: 6,
      rate: 150,
      security: 'WPA2',
    );
    const connection = WiFiConnectionInfo(name: 'Home', UUID: 'connection-id', type: 'wifi', device: 'wlan0');
    final client = _RealtimeService((command) async {
      final rpc = serializers.deserialize(command.commandData);
      return WSRpcResult.byCommand(
        rpc is WiFiListCommand
            ? WiFiListResult(networks: [network], id: rpc.id)
            : WiFiGetConnectionsResult(networks: [connection], id: (rpc as WiFiGetConnectionsCommand).id),
        command,
      );
    });
    final bloc = WifiTabBloc(initialState: const UnWifiTabState(), client: client);
    addTearDown(bloc.close);
    final loaded = bloc.stream.firstWhere((state) => state is InWifiTabState);

    bloc.add(const LoadWifiTabEvent());

    final state = await loaded as InWifiTabState;
    expect(state.availableNetworks, [network]);
    expect(state.connections, [connection]);
  });

  test('add waits for backend acknowledgement before refreshing the lists', () async {
    final acknowledgement = Completer<WebSocketResult>();
    late _RealtimeService client;
    client = _RealtimeService((command) async {
      final rpc = serializers.deserialize(command.commandData) as RpcCommand;
      if (rpc is WiFiAddCommand) return acknowledgement.future;
      return WSRpcResult.byCommand(
        rpc is WiFiListCommand
            ? WiFiListResult(id: rpc.id, networks: const [])
            : WiFiGetConnectionsResult(
                id: rpc.id,
                networks: const [WiFiConnectionInfo(name: 'New network', UUID: 'new', type: 'wifi', device: 'wlan0')],
              ),
        command,
      );
    });
    final bloc = WifiTabBloc(initialState: const UnWifiTabState(), client: client);
    addTearDown(bloc.close);
    final loaded = bloc.stream.firstWhere((state) => state is InWifiTabState);
    bloc.add(const AddWifiTabEvent('New network', 'ssid', 'private-password'));
    await client.firstRequest.future;
    expect(client.commands, hasLength(1));
    expect(client.timeouts, [const Duration(seconds: 65)]);
    expect(bloc.state, isA<UnWifiTabState>());
    final command = client.commands.single;
    final rpc = serializers.deserialize(command.commandData) as WiFiAddCommand;
    acknowledgement.complete(WSRpcResult.byCommand(EmptyResult(id: rpc.id), command));
    final state = await loaded as InWifiTabState;
    expect(state.connections.single.name, 'New network');
    expect(client.commands, hasLength(3));
    expect(client.timeouts, everyElement(const Duration(seconds: 65)));
  });

  test('wrapped backend rejection is not mistaken for a successful mutation', () async {
    final client = _RealtimeService((command) async {
      final rpc = serializers.deserialize(command.commandData) as RpcCommand;
      return WSRpcResult.byCommand(ErrorResult(id: rpc.id, error: 'Wi-Fi add failed (exitCode, code=10)'), command);
    });
    final bloc = WifiTabBloc(initialState: const UnWifiTabState(), client: client);
    addTearDown(bloc.close);
    final failed = bloc.stream.firstWhere((state) => state is ErrorWifiTabState);
    bloc.add(const AddWifiTabEvent('name', 'ssid', 'private-password'));
    final state = await failed as ErrorWifiTabState;
    expect(state.kind, WifiFailureKind.rejected);
    expect(state.errorMessage, contains('code=10'));
    expect(client.commands, hasLength(1), reason: 'a rejected mutation must not trigger a refresh');
  });

  test('an acknowledged mutation keeps its known outcome when refresh times out', () async {
    final records = <LogRecord>[];
    final subscription = Logger.root.onRecord.listen(records.add);
    addTearDown(subscription.cancel);
    final client = _RealtimeService((command) async {
      final rpc = serializers.deserialize(command.commandData) as RpcCommand;
      if (rpc is WiFiAddCommand) {
        return WSRpcResult.byCommand(EmptyResult(id: rpc.id), command);
      }
      throw TimeoutException('private refresh URL');
    });
    final bloc = WifiTabBloc(initialState: const UnWifiTabState(), client: client);
    addTearDown(bloc.close);
    final failed = bloc.stream.firstWhere((state) => state is ErrorWifiTabState);
    bloc.add(const AddWifiTabEvent('name', 'ssid', 'private-password'));
    final state = await failed as ErrorWifiTabState;
    expect(state.kind, WifiFailureKind.refresh);
    expect(state.errorMessage, isEmpty);
    expect(client.commands, hasLength(3));
    final logs = records.where((record) => record.loggerName == 'WifiTabBloc');
    expect(
      logs.map((record) => record.message),
      containsAll([
        startsWith('event=acknowledged action=add'),
        startsWith('event=refreshFailed action=load sourceAction=add'),
      ]),
    );
    expect(logs.any((record) => record.message.contains('outcomeUnknown')), isFalse);
    expect(logs.map((record) => record.message).join(), isNot(contains('private refresh URL')));
  });

  test('a transport timeout is an unknown outcome without automatic mutation retry', () async {
    final pending = Completer<WebSocketResult>();
    final client = _RealtimeService((command) => pending.future);
    final bloc = WifiTabBloc(initialState: const UnWifiTabState(), client: client);
    addTearDown(bloc.close);
    final failed = bloc.stream.firstWhere((state) => state is ErrorWifiTabState);
    bloc.add(const RemoveWifiTabEvent('connection-id'));
    await client.firstRequest.future;
    pending.completeError(TimeoutException('private transport URL'));
    final state = await failed as ErrorWifiTabState;
    expect(state.kind, WifiFailureKind.unknown);
    expect(state.errorMessage, isEmpty);
    expect(client.commands, hasLength(1));
  });

  test('close cancels local waits and late mutation responses cannot refresh', () async {
    final pending = Completer<WebSocketResult>();
    final client = _RealtimeService((command) => pending.future);
    final bloc = WifiTabBloc(initialState: const UnWifiTabState(), client: client);
    final states = <WifiTabState>[];
    final subscription = bloc.stream.listen(states.add);
    final records = <LogRecord>[];
    final logSubscription = Logger.root.onRecord.listen(records.add);
    addTearDown(logSubscription.cancel);
    bloc.add(const AddWifiTabEvent('name', 'ssid', 'private-password'));
    await client.firstRequest.future;
    await bloc.close();
    expect(pending.isCompleted, isFalse);
    final count = states.length;
    final command = client.commands.single;
    final rpc = serializers.deserialize(command.commandData) as RpcCommand;
    pending.complete(WSRpcResult.byCommand(EmptyResult(id: rpc.id), command));
    await pumpEventQueue();
    expect(client.commands, hasLength(1));
    expect(states, hasLength(count));
    final cancelled = records.singleWhere(
      (record) => record.loggerName == 'WifiTabBloc' && record.message.startsWith('event=cancelled '),
    );
    expect(cancelled.level, Level.INFO);
    expect(cancelled.message, contains('action=add'));
    expect(cancelled.message, isNot(contains('operationId=')));
    expect(cancelled.message, isNot(contains('private-password')));
    expect(cancelled.error, isNull);
    await subscription.cancel();
  });

  for (final (kind, message) in [
    (WifiFailureKind.unknown, 'The operation result is unknown. Check the frame before trying again.'),
    (
      WifiFailureKind.refresh,
      'The Wi-Fi operation completed, but the lists could not be refreshed. Refresh before making another change.',
    ),
  ]) {
    testWidgets('${kind.name} renders the localized hint without transport details', (tester) async {
      final bloc = WifiTabBloc(
        initialState: ErrorWifiTabState('private transport URL', kind: kind),
        client: _RealtimeService((command) => throw StateError('No request expected')),
      );
      addTearDown(bloc.close);
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: BlocProvider.value(value: bloc, child: const WiFiConfigTab()),
        ),
      );
      expect(find.text(message), findsOneWidget);
      expect(find.text('private transport URL'), findsNothing);
    });
  }
}
