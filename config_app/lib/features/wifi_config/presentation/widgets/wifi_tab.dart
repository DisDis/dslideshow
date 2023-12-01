import 'package:config_app/features/wifi_config/presentation/bloc/wifi_tab_bloc.dart';
import 'package:config_app/features/wifi_config/presentation/bloc/wifi_tab_event.dart';
import 'package:config_app/features/wifi_config/presentation/bloc/wifi_tab_state.dart';
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
        builder: (BuildContext context, WifiTabState currentState) {
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
        Row(
          children: [
            const Text('Available:'),
            _buttonAddNetworkConnection(context),
          ],
        ),
        Expanded(
          flex: 2,
          child: ListView(
            children: [
              for (var network in currentState.availableNetworks) WifiListItem(network: network),
            ],
          ),
        ),
        const Text('Stored:'),
        for (var network in currentState.storedNetworks)
          Row(
            children: [
              Text(network.SSID),
              if (network.disabled)
                const Icon(
                  Icons.disabled_by_default_rounded,
                  color: Colors.red,
                )
            ],
          ),
      ],
    );
  }

  void _load() {
    widget._wifiTabBloc.add(LoadWifiTabEvent());
  }

  Widget _buttonAddNetworkConnection(BuildContext context) {
    return IconButton(
      onPressed: () {
        showNewAddNetworkDialog(context, '');
      },
      icon: const Icon(Icons.plus_one),
    );
  }

  static void showNewAddNetworkDialog(BuildContext context, [String SSID = '']) {
    final TextEditingController controllerSSID = TextEditingController(text: SSID);
    final TextEditingController controllerPassword = TextEditingController(text: "");
    final bloc = context.read<WifiTabBloc>();
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add network'),
        content: Column(
          children: [
            TextField(
              controller: controllerSSID,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.wifi),
                // suffixIcon: _ClearButton(controller: _controllerOutlined),
                labelText: 'SSID',
                hintText: 'Network name',
                helperText: 'Network name',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              obscureText: true,
              controller: controllerPassword,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.password),
                // suffixIcon: _ClearButton(controller: _controllerOutlined),
                labelText: 'Password',
                hintText: 'Password',
                helperText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          FilledButton(
            child: const Text('Add'),
            onPressed: () {
              bloc.add(AddWifiTabEvent(controllerSSID.text, controllerPassword.text));
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
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
    WifiTabScreenState.showNewAddNetworkDialog(context, network.SSID);
  }
}
