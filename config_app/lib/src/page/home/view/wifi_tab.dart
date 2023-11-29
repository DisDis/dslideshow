import 'package:config_app/src/bloc/authentication_bloc.dart';
import 'package:config_app/src/page/home/bloc/home_cubit.dart';
import 'package:config_app/src/page/home/bloc/wifi_tab_bloc.dart';
import 'package:config_app/src/page/home/bloc/wifi_tab_event.dart';
import 'package:config_app/src/page/home/bloc/wifi_tab_state.dart';
import 'package:dslideshow_backend/src/command/wifi_commands.dart';
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
                    onPressed: _load,
                    child: const Text('reload'),
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

  Widget _showNetworks(BuildContext context, InWifiTabState currentState) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text('Available:'),
        Expanded(
          flex: 2,
          child: ListView(
            children: [
              for (var network in currentState.availableNetworks) WifiListItem(network: network),
            ],
          ),
        ),
        const Text('Stored:'),
        for (var network in currentState.storedNetworks) Text(network.SSID),
      ],
    );
  }

  void _load() {
    widget._wifiTabBloc.add(LoadWifiTabEvent());
  }
}

class WifiListItem extends StatelessWidget {
  final WiFiNetworkInfo network;
  const WifiListItem({super.key, required this.network});

  @override
  Widget build(BuildContext context) {
    // network.signal
/*
SIGNAL STRENGTH (dBm)	Remarks
-30	Maximum possible signal strength.
-50	Excellent signal strength.
-60	Good signal strength.
-67	Reliable signal strength.
-70	Relatively weak signal strength.
-80	Unreliable. Most services will not work.
-90	Possibility of disconnection.
*/
    final signal = network.signal;

    return ListTile(
      title: Text(network.SSID),
      leading: Icon(signal >= -60
          ? Icons.network_wifi
          : signal >= -70
              ? Icons.network_wifi_3_bar
              : signal >= -80
                  ? Icons.network_wifi_2_bar
                  : Icons.network_wifi_1_bar),
      subtitle: Row(children: [
        if (network.freq > 4900) const Icon(Icons.five_g),
        Text("${network.signal} dBm"),
      ]),
      onTap: () => _onTap(context, network),
    );

    // ,
    // Text('${network.SSID}'),
  }

  _onTap(BuildContext context, WiFiNetworkInfo network) {
    context.read<WifiTabBloc>().add(AddWifiTabEvent("TestSSID123", "12456Test"));
    print("$network");
  }
}
