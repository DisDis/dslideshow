import 'package:config_app/features/config/presentation/wigdgets/settings_section.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:flutter/material.dart';

class WelcomeEditorPage extends StatelessWidget {
  final WelcomeConfig config;

  const WelcomeEditorPage({Key? key, required this.config}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome Settings')),
      body: ListView(
        children: [
          SettingsTextField(
            label: 'Text',
            initialValue: config.text,
            onChanged: (v) => config.text = v,
          ),
          SettingsTextField(
            label: 'Text size',
            isNumber: true,
            initialValue: config.size.toString(),
            onChanged: (v) => config.size  = double.tryParse(v) ?? 100,
          ),
          SettingsTextField(
            label: 'Delay in ms',
            isNumber: true,
            initialValue: config.delayMs.toString(),
            onChanged: (v) => config.delayMs = int.tryParse(v) ?? 1000,
          ),
          
        ],
      ),
    );
  }
}