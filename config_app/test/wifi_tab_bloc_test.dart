import 'dart:async';

import 'package:config_app/features/realtime/domain/services/realtime_service.dart';
import 'package:config_app/features/wifi_config/presentation/bloc/wifi_tab_bloc.dart';
import 'package:config_app/features/wifi_config/presentation/bloc/wifi_tab_event.dart';
import 'package:config_app/features/wifi_config/presentation/bloc/wifi_tab_state.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/serializers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';

class _RealtimeService implements RealtimeService {
  _RealtimeService(this.handle);

  final Future<WebSocketResult> Function(WSSendRpcCommand command) handle;
  final commands = <WSSendRpcCommand>[];

  @override
  Future<WebSocketResult> send(WebSocketCommand command) {
    final rpc = command as WSSendRpcCommand;
    commands.add(rpc);
    return handle(rpc);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  test(
    'rescan reports a delayed RPC failure without logging its contents',
    () async {
      final result = Completer<WebSocketResult>();
      final client = _RealtimeService((_) => result.future);
      final bloc = WifiTabBloc(
        initialState: const InWifiTabState(
          availableNetworks: [],
          connections: [],
        ),
        client: client,
      );
      addTearDown(bloc.close);
      final records = <LogRecord>[];
      final logSubscription = Logger.root.onRecord.listen(records.add);
      addTearDown(logSubscription.cancel);
      final failed = bloc.stream.firstWhere(
        (state) => state is ErrorWifiTabState,
      );

      bloc.add(const RescanWifiTabEvent());
      await pumpEventQueue();

      expect(client.commands, hasLength(1));
      expect(
        serializers.deserialize(client.commands.single.commandData),
        isA<WiFiRescanCommand>(),
      );
      expect(bloc.state, isA<InWifiTabState>());

      result.completeError(StateError('private-server-response'));
      expect(await failed, isA<ErrorWifiTabState>());
      final wifiRecords = records.where(
        (record) => record.loggerName == 'WifiTabBloc',
      );
      expect(wifiRecords, isNotEmpty);
      expect(
        wifiRecords.map((record) => record.message).join(),
        isNot(contains('private-server-response')),
      );
      expect(wifiRecords.every((record) => record.error == null), isTrue);
    },
  );

  test(
    'removing a connection reports an RPC error and does not reload',
    () async {
      final client = _RealtimeService(
        (command) => Future.error(
          WSErrorResult.byCommand('connection unavailable', command),
        ),
      );
      final bloc = WifiTabBloc(
        initialState: const UnWifiTabState(),
        client: client,
      );
      addTearDown(bloc.close);
      final failed = bloc.stream.firstWhere(
        (state) => state is ErrorWifiTabState,
      );

      bloc.add(const RemoveWifiTabEvent('connection-id'));

      expect(await failed, isA<ErrorWifiTabState>());
      expect(client.commands, hasLength(1));
      expect(
        serializers.deserialize(client.commands.single.commandData),
        isA<WiFiRemoveCommand>(),
      );
    },
  );

  test('loading observes errors from both concurrent requests', () async {
    final listResult = Completer<WebSocketResult>();
    final storedResult = Completer<WebSocketResult>();
    final client = _RealtimeService((command) {
      return serializers.deserialize(command.commandData) is WiFiListCommand
          ? listResult.future
          : storedResult.future;
    });
    final bloc = WifiTabBloc(
      initialState: const UnWifiTabState(),
      client: client,
    );
    addTearDown(bloc.close);
    final failed = bloc.stream.firstWhere(
      (state) => state is ErrorWifiTabState,
    );

    bloc.add(const LoadWifiTabEvent());
    await pumpEventQueue();
    expect(client.commands, hasLength(2));

    // The second request can fail while the first one is still pending.
    storedResult.completeError(StateError('stored connections failed'));
    await pumpEventQueue();
    listResult.completeError(StateError('network scan failed'));

    expect(await failed, isA<ErrorWifiTabState>());
  });

  test(
    'loading keeps network and saved connection results in their fields',
    () async {
      const network = WiFiNetworkInfo(
        BSSID: '00:11:22:33:44:55',
        SSID: 'Photo frame',
        signal: 90,
        channel: 6,
        rate: 150,
        security: 'WPA2',
      );
      const connection = WiFiConnectionInfo(
        name: 'Home',
        UUID: 'connection-id',
        type: 'wifi',
        device: 'wlan0',
      );
      final client = _RealtimeService((command) async {
        final rpc = serializers.deserialize(command.commandData);
        return WSRpcResult.byCommand(
          rpc is WiFiListCommand
              ? WiFiListResult(networks: [network], id: rpc.id)
              : WiFiGetConnectionsResult(
                  networks: [connection],
                  id: (rpc as WiFiGetConnectionsCommand).id,
                ),
          command,
        );
      });
      final bloc = WifiTabBloc(
        initialState: const UnWifiTabState(),
        client: client,
      );
      addTearDown(bloc.close);
      final loaded = bloc.stream.firstWhere((state) => state is InWifiTabState);

      bloc.add(const LoadWifiTabEvent());

      final state = await loaded as InWifiTabState;
      expect(state.availableNetworks, [network]);
      expect(state.connections, [connection]);
    },
  );
}
