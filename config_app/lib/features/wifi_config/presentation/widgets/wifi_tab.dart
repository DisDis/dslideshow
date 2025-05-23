import 'package:config_app/features/wifi_config/presentation/bloc/wifi_tab_bloc.dart';
import 'package:config_app/features/wifi_config/presentation/bloc/wifi_tab_event.dart';
import 'package:config_app/features/wifi_config/presentation/bloc/wifi_tab_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dslideshow_backend/command.dart';

class WiFiConfigTab extends StatefulWidget {
  const WiFiConfigTab({
    required WifiTabBloc wifiTabBloc,
    super.key,
  }) : _wifiTabBloc = wifiTabBloc;

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
        const Text('Connections:'),
        Expanded(
          flex: 2,
          child: ListView(
            children: [
              for (var connection in currentState.connections) ConnectionListItem(connection: connection),
            ],
          ),
        ),
      ],
    );
  }

  void _load() {
    widget._wifiTabBloc.add(const LoadWifiTabEvent());
  }

  Widget _buttonAddNetworkConnection(BuildContext context) {
    return IconButton(
      onPressed: () {
        showNewAddNetworkDialog(context, '');
      },
      icon: const Icon(Icons.plus_one),
    );
  }

  // ignore: non_constant_identifier_names
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
              bloc.add(AddWifiTabEvent("${controllerSSID.text} connection", controllerSSID.text, controllerPassword.text));
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

class ConnectionListItem extends StatelessWidget {
  final WiFiConnectionInfo connection;
  const ConnectionListItem({super.key, required this.connection});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(connection.name),
      subtitle: Text(connection.type),
    );
  }
}

class WifiListItem extends StatelessWidget {
  final WiFiNetworkInfo network;
  const WifiListItem({super.key, required this.network});

  @override
  Widget build(BuildContext context) {
    final signal = network.signal;
    return ListTile(
      title: Text(network.SSID),
      leading: Icon(signal >= 85
          ? Icons.network_wifi
          : signal >= 70
              ? Icons.network_wifi_3_bar
              : signal >= 50
                  ? Icons.network_wifi_2_bar
                  : Icons.network_wifi_1_bar),
      subtitle: Row(children: [
        if (network.channel > 31) const Icon(Icons.five_g),
        Text("${network.signal} %"),
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
