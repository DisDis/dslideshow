import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:config_app/features/realtime/domain/services/realtime_service.dart';
import 'package:config_app/features/wifi_config/presentation/bloc/wifi_tab_event.dart';
import 'package:config_app/features/wifi_config/presentation/bloc/wifi_tab_state.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/serializers.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:logging/logging.dart';

class WifiTabBloc extends Bloc<WifiTabEvent, WifiTabState> {
  static final _log = Logger('WifiTabBloc');
  final RealtimeService client;
  WifiTabBloc({required WifiTabState initialState, required this.client})
    : super(initialState) {
    // on<WifiTabEvent>((WifiTabEvent event, emit) {
    //   return emit.forEach<WifiTabState>(
    //     event.applyAsync(currentState: state, bloc: this),
    //     onData: (state) => state,
    //     onError: (error, stackTrace) {
    //       developer.log('$error', name: 'WifiTabBloc', error: error, stackTrace: stackTrace);
    //       return ErrorWifiTabState(error.toString());
    //     },
    //   );
    // });
    on<LoadWifiTabEvent>(_onLoadWifi);

    on<AddWifiTabEvent>((AddWifiTabEvent event, emit) async {
      emit(const UnWifiTabState());
      try {
        await client.send(
          WSSendRpcCommand.byCommand(
            WiFiAddCommand(
              id: RpcCommand.generateId(),
              name: event.name,
              SSID: event.SSID,
              psk: event.psk,
            ),
          ),
        );
        await _updateData(emit);
      } catch (e, st) {
        _log.severe(
          'Adding Wi-Fi connection failed (${e.runtimeType})',
          null,
          st,
        );
        emit(ErrorWifiTabState(e.toString()));
      }
    });

    on<RemoveWifiTabEvent>((RemoveWifiTabEvent event, emit) async {
      emit(const UnWifiTabState());
      try {
        await client.send(
          WSSendRpcCommand.byCommand(
            WiFiRemoveCommand(
              id: RpcCommand.generateId(),
              connectionId: event.connectionId,
            ),
          ),
        );
        await _updateData(emit);
      } catch (e, st) {
        _log.severe(
          'Removing Wi-Fi connection failed (${e.runtimeType})',
          null,
          st,
        );
        emit(ErrorWifiTabState(e.toString()));
      }
    });

    on<EnableWifiTabEvent>((EnableWifiTabEvent event, emit) async {
      emit(const UnWifiTabState());
      // await _client.send(WSSendRpcCommand((b) => b.command = WiFiEnableCommand((b)=>b..wifiId=event.wifiId..value=event.value)));
      try {
        await _updateData(emit);
      } catch (e, st) {
        _log.severe(
          'Loading Wi-Fi connections failed (${e.runtimeType})',
          null,
          st,
        );
        emit(ErrorWifiTabState(e.toString()));
      }
    });
    on<RescanWifiTabEvent>(_rescan);
  }

  Future<void> _rescan(
    RescanWifiTabEvent event,
    Emitter<WifiTabState> emit,
  ) async {
    try {
      await client.send(
        WSSendRpcCommand.byCommand(
          WiFiRescanCommand(id: RpcCommand.generateId()),
        ),
      );
    } catch (e, st) {
      _log.severe(
        'Scanning Wi-Fi networks failed (${e.runtimeType})',
        null,
        st,
      );
      emit(ErrorWifiTabState(e.toString()));
    }
  }

  Future<void> _updateData(
    Emitter<WifiTabState> emit, [
    minDuration = const Duration(milliseconds: 0),
  ]) async {
    final waitF = Future.delayed(minDuration);
    final results = await Future.wait([
      client.send(
        WSSendRpcCommand.byCommand(
          WiFiListCommand(id: RpcCommand.generateId()),
        ),
      ),
      client.send(
        WSSendRpcCommand.byCommand(
          WiFiGetConnectionsCommand(id: RpcCommand.generateId()),
        ),
      ),
    ]);
    final scanResult = serializers.deserialize(
      (results[0] as WSRpcResult).resultData,
    ) as WiFiListResult;
    final storedResult = serializers.deserialize(
      (results[1] as WSRpcResult).resultData,
    ) as WiFiGetConnectionsResult;
    final availableNetworks = scanResult.networks.toList(growable: false);

    final connections = storedResult.networks.toList(growable: false);
    await waitF;
    emit(
      InWifiTabState(
        availableNetworks: availableNetworks,
        connections: connections,
      ),
    );
  }

  Future _onLoadWifi(WifiTabEvent event, emit) async {
    emit(const UnWifiTabState());
    try {
      await _updateData(emit, Duration(milliseconds: 500));
    } catch (e, st) {
      _log.severe(
        'Loading Wi-Fi connections failed (${e.runtimeType})',
        null,
        st,
      );
      emit(ErrorWifiTabState(e.toString()));
    }
  }
}
