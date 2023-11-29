import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:config_app/src/page/home/bloc/wifi_tab_event.dart';
import 'package:config_app/src/page/home/bloc/wifi_tab_state.dart';
import 'package:config_app/src/service/client_service.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:logging/logging.dart';

class WifiTabBloc extends Bloc<WifiTabEvent, WifiTabState> {
  static final _log = Logger('WifiTabBloc');
  final ClientService _client;
  WifiTabBloc({required WifiTabState initialState, required ClientService client})
      : _client = client,
        super(initialState) {
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
      emit(UnWifiTabState());
      await _client.send(WSSendRpcCommand((b) => b.command = WiFiAddCommand((b) => b
        ..SSID = event.SSID
        ..psk = event.psk)));
      await _updateData(emit);
    });

    on<RemoveWifiTabEvent>((RemoveWifiTabEvent event, emit) async {
      emit(UnWifiTabState());
      await _client.send(WSSendRpcCommand((b) => b.command = WiFiRemoveCommand((b) => b..wifiId = event.wifiId)));
      await _updateData(emit);
    });

    on<EnableWifiTabEvent>((EnableWifiTabEvent event, emit) async {
      emit(UnWifiTabState());
      // await _client.send(WSSendRpcCommand((b) => b.command = WiFiEnableCommand((b)=>b..wifiId=event.wifiId..value=event.value)));
      await _updateData(emit);
    });
  }

  Future<void> _updateData(Emitter<WifiTabState> emit) async {
    final fScan = _client.send(WSSendRpcCommand((b) => b.command = WiFiScanCommand()));
    final fStored = _client.send(WSSendRpcCommand((b) => b.command = WiFiGetStoredCommand()));
    final scanResult = (await fScan as WSRpcResult).result as WiFiScanResult;
    final storedResult = (await fStored as WSRpcResult).result as WiFiGetStoredResult;
    //FIX: Remove delay
    await Future.delayed(const Duration(seconds: 1));
    //FIX: Remove stub data
    final availableNetworks = scanResult.networks!.isEmpty
        ? <WiFiNetworkInfo>[
            WiFiNetworkInfo((b) => b
              ..SSID = 'Tenda_7BF3B0'
              ..signal = '-88.00 dBm'
              ..capability = 'ESS Privacy ShortSlotTime (0x0411)'
              ..freq = 2437),
            WiFiNetworkInfo((b) => b
              ..SSID = 'Jazzir_2G'
              ..signal = '-67.00 dBm'
              ..capability = 'ESS Privacy ShortSlotTime RadioMeasure (0x1411)'
              ..freq = 2437),
            WiFiNetworkInfo((b) => b
              ..SSID = 'Jazzir_5G'
              ..signal = '-57.00 dBm'
              ..capability = 'ESS Privacy SpectrumMgmt RadioMeasure (0x1111)'
              ..freq = 5500)
          ]
        : scanResult.networks!.toList(growable: false);

    final storedNetworks = storedResult.networks!.toList(growable: false);

    emit(InWifiTabState(availableNetworks: availableNetworks, storedNetworks: storedNetworks));
  }

  Future _onLoadWifi(WifiTabEvent event, emit) async {
    emit(UnWifiTabState());
    try {
      await _updateData(emit);
    } catch (e, st) {
      _log.severe('FATAL', e, st);
      emit(ErrorWifiTabState(e.toString()));
    }
  }
}
