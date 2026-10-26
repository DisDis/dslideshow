import 'package:config_app/features/config/domain/unsaved_draft_registration.dart';
import 'package:config_app/features/config/presentation/wigdgets/draft_editor_form.dart';
import 'package:config_app/features/config/presentation/wigdgets/settings_section.dart';
import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:config_app/features/uikit/presentation/widgets/config_app_scaffold.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:flutter/material.dart';

class MqttEditorPage extends StatelessWidget {
  final MqttConfig config;
  final RegisterUnsavedDraft? registerDraft;
  const MqttEditorPage({super.key, required this.config, this.registerDraft});

  @override
  Widget build(BuildContext context) {
    final l = context.localizations;
    return Scaffold(
      appBar: AppBar(title: Text(l.mqtt_settings_title)),
      body: SettingsContent(
        maxWidth: 760,
        child: DraftEditorForm(
          registerDraft: registerDraft,
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                child: Text(
                  l.config_editor_draft_hint,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              SettingsSection(
                title: l.connection_title,
                children: [
                  SettingsSwitch(
                    label: l.enabled_label,
                    value: config.enabled,
                    onChanged: (value) => config.enabled = value,
                  ),
                  SettingsTextField(
                    label: l.server_host_label,
                    initialValue: config.server,
                    onChanged: (value) => config.server = value,
                  ),
                  SettingsTextField(
                    label: l.port_label,
                    isNumber: true,
                    initialValue: config.serverPort.toString(),
                    validator: (text) {
                      final value = int.tryParse(text ?? '');
                      return value != null && value > 0 && value <= 65535
                          ? null
                          : l.invalid_port;
                    },
                    onChanged: (text) {
                      final value = int.tryParse(text);
                      if (value != null && value > 0 && value <= 65535) {
                        config.serverPort = value;
                      }
                    },
                  ),
                ],
              ),
              SettingsSection(
                title: l.authentication_title,
                children: [
                  SettingsTextField(
                    label: l.username,
                    initialValue: config.user,
                    onChanged: (value) => config.user = value,
                  ),
                  SettingsTextField(
                    label: l.password,
                    initialValue: config.pass,
                    obscureText: true,
                    onChanged: (value) => config.pass = value,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
