import 'package:config_app/features/wifi_config/presentation/bloc/wifi_tab_bloc.dart';
import 'package:config_app/features/wifi_config/presentation/bloc/wifi_tab_event.dart';
import 'package:flutter/material.dart';

class ConnectNetworkForm extends StatefulWidget {
  final String initialSSID;
  final WifiTabBloc wifiBloc;

  const ConnectNetworkForm(
      {super.key, required this.initialSSID, required this.wifiBloc});

  @override
  State<ConnectNetworkForm> createState() => _ConnectNetworkFormState();
}

class _ConnectNetworkFormState extends State<ConnectNetworkForm> {
  late TextEditingController _ssidController;
  late TextEditingController _passwordController;
  bool _obscurePassword = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _ssidController = TextEditingController(text: widget.initialSSID);
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _ssidController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.initialSSID.isEmpty ? "Add Network" : "Connect to Network",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _ssidController,
              decoration: const InputDecoration(
                labelText: 'SSID (Name)',
                prefixIcon: Icon(Icons.wifi_find),
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.key),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(_obscurePassword
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                const Spacer(),
                FilledButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      widget.wifiBloc.add(AddWifiTabEvent(
                          "${_ssidController.text} connection",
                          _ssidController.text,
                          _passwordController.text));
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(Icons.check),
                  label: const Text("Connect"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
