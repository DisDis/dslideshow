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
        await client.send(WSSendRpcCommand.byCommand(WiFiAddCommand(
          id: RpcCommand.generateId(),
          name: event.name,
          SSID: event.SSID,
          psk: event.psk,
        )));
        await _updateData(emit);
      } catch (e, st) {
        _log.severe('FATAL', e, st);
        emit(ErrorWifiTabState(e.toString()));
      }
    });

    on<RemoveWifiTabEvent>((RemoveWifiTabEvent event, emit) async {
      emit(const UnWifiTabState());
      await client.send(WSSendRpcCommand.byCommand(WiFiRemoveCommand(
          id: RpcCommand.generateId(), connectionId: event.connectionId)));
      await _updateData(emit);
    });

    on<EnableWifiTabEvent>((EnableWifiTabEvent event, emit) async {
      emit(const UnWifiTabState());
      // await _client.send(WSSendRpcCommand((b) => b.command = WiFiEnableCommand((b)=>b..wifiId=event.wifiId..value=event.value)));
      await _updateData(emit);
    });
  }

  Future<void> _updateData(Emitter<WifiTabState> emit) async {
    final fScan = client.send(WSSendRpcCommand.byCommand(
        WiFiScanCommand(id: RpcCommand.generateId())));
    final fStored = client.send(WSSendRpcCommand.byCommand(
        WiFiGetConnectionsCommand(id: RpcCommand.generateId())));
    final scanResult = serializers
        .deserialize((await fScan as WSRpcResult).resultData) as WiFiScanResult;
    final storedResult =
        serializers.deserialize((await fStored as WSRpcResult).resultData)
            as WiFiGetConnectionsResult;
    final availableNetworks = scanResult.networks.toList(growable: false);

    final connections = storedResult.networks.toList(growable: false);

    emit(InWifiTabState(
        availableNetworks: availableNetworks, connections: connections));
  }

  Future _onLoadWifi(WifiTabEvent event, emit) async {
    emit(const UnWifiTabState());
    try {
      await _updateData(emit);
    } catch (e, st) {
      _log.severe('FATAL', e, st);
      emit(ErrorWifiTabState(e.toString()));
    }
  }
}
