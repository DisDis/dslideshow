import 'package:config_app/features/config/presentation/wigdgets/settings_section.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:flutter/material.dart';

class WebServerEditorPage extends StatelessWidget {
  final WebServerConfig config;

  const WebServerEditorPage({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WebServer Settings')),
      body: ListView(
        children: [
          SettingsSection(
            title: 'Connection',
            children: [
              SettingsSwitch(
                label: 'Always Enabled',
                value: config.alwaysEnabled,
                onChanged: (v) => config.alwaysEnabled = v,
              ),
              SettingsTextField(
                label: 'Port',
                isNumber: true,
                initialValue: config.port.toString(),
                onChanged: (v) => config.port = int.tryParse(v) ?? 8080,
              ),
            ],
          ),
          SettingsSection(
            title: 'Auth',
            children: [
              // SettingsTextField(
              //   label: 'User',
              //   initialValue: config.user,
              //   onChanged: (v) => config.user = v,
              // ),
              SettingsTextField(
                label: 'Permanent code',
                initialValue: config.permanentCode,
                onChanged: (v) => config.permanentCode = v,
              ),
            ],
          ),
        ],
      ),
    );
  }
}