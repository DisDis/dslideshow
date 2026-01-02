import 'package:config_app/features/config/presentation/wigdgets/settings_section.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:flutter/material.dart';

class MqttEditorPage extends StatelessWidget {
  final MqttConfig config;

  const MqttEditorPage({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MQTT Settings')),
      body: ListView(
        children: [
          SettingsSection(
            title: 'Connection',
            children: [
              SettingsSwitch(
                label: 'Enabled',
                value: config.enabled,
                onChanged: (v) => config.enabled = v,
              ),
              SettingsTextField(
                label: 'Server Host',
                initialValue: config.server,
                onChanged: (v) => config.server = v,
              ),
              SettingsTextField(
                label: 'Port',
                isNumber: true,
                initialValue: config.serverPort.toString(),
                onChanged: (v) => config.serverPort = int.tryParse(v) ?? 1883,
              ),
            ],
          ),
          SettingsSection(
            title: 'Auth',
            children: [
              SettingsTextField(
                label: 'User',
                initialValue: config.user,
                onChanged: (v) => config.user = v,
              ),
              SettingsTextField(
                label: 'Password',
                initialValue: config.pass,
                onChanged: (v) => config.pass = v,
              ),
            ],
          ),
        ],
      ),
    );
  }
}