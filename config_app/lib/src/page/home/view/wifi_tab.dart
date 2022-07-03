import 'package:config_app/src/bloc/authentication_bloc.dart';
import 'package:config_app/src/page/home/bloc/home_cubit.dart';
import 'package:config_app/src/page/home/bloc/wifi_tab_bloc.dart';
import 'package:config_app/src/page/home/bloc/wifi_tab_event.dart';
import 'package:config_app/src/page/home/bloc/wifi_tab_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WiFiConfigTab extends StatefulWidget {
  const WiFiConfigTab({
    required WifiTabBloc wifiTabBloc,
    Key? key,
  })  : _wifiTabBloc = wifiTabBloc,
        super(key: key);

  final WifiTabBloc _wifiTabBloc;

  @override
  WifiTabScreenState createState() {
    return WifiTabScreenState();
  }
}

class WifiTabScreenState extends State<WiFiConfigTab> {
  WifiTabScreenState();

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WifiTabBloc, WifiTabState>(
        bloc: widget._wifiTabBloc,
        builder: (
          BuildContext context,
          WifiTabState currentState,
        ) {
          if (currentState is UnWifiTabState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is ErrorWifiTabState) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(currentState.errorMessage),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: ElevatedButton(
                    child: const Text('reload'),
                    onPressed: _load,
                  ),
                ),
              ],
            ));
          }
          if (currentState is InWifiTabState) {
            return _showNetworks(context, currentState);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Center _showNetworks(BuildContext context, InWifiTabState currentState) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('Available:'),
          for (var network in currentState.availableNetworks) Text('${network.SSID} ${network.signal} ${network.freq}'),
          const Text('Stored:'),
          for (var network in currentState.storedNetworks) Text(network.SSID),
        ],
      ),
    );
  }

  void _load() {
    widget._wifiTabBloc.add(LoadWifiTabEvent());
  }
}
