import 'package:config_app/features/config/domain/unsaved_draft_registration.dart';
import 'package:config_app/features/config/presentation/bloc/wake_settings_cubit.dart';
import 'package:config_app/features/config/presentation/wigdgets/draft_editor_form.dart';
import 'package:config_app/features/config/presentation/wigdgets/night_mode_details.dart';
import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WakeSettingsPage extends StatelessWidget {
  const WakeSettingsPage({super.key, required this.config, this.registerDraft, this.readDevice});
  final AppConfig config;
  final RegisterUnsavedDraft? registerDraft;
  final Future<FrameState> Function()? readDevice;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => WakeSettingsCubit(config, readDevice: readDevice),
    child: _WakeSettingsView(registerDraft: registerDraft),
  );
}

class _WakeSettingsView extends StatelessWidget {
  const _WakeSettingsView({this.registerDraft});
  final RegisterUnsavedDraft? registerDraft;

  Widget _field(BuildContext context, WakeSettingsState state, WakeField field, String label, {bool number = false}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: TextFormField(
          key: ValueKey('wake-${field.name}'),
          initialValue: state.inputs[field],
          keyboardType: number ? TextInputType.number : TextInputType.text,
          decoration: InputDecoration(labelText: label),
          onChanged: (text) => context.read<WakeSettingsCubit>().change(field, text),
        ),
      );

  @override
  Widget build(BuildContext context) => BlocBuilder<WakeSettingsCubit, WakeSettingsState>(
    builder: (context, state) {
      final l = context.localizations;
      final cubit = context.read<WakeSettingsCubit>();
      return Scaffold(
        appBar: AppBar(title: Text(l.wake_settings_title)),
        bottomNavigationBar: state.invalid
            ? SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    l.night_invalid_settings,
                    key: const ValueKey('wake-invalid'),
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                ),
              )
            : null,
        body: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: DraftEditorForm(
              registerDraft: registerDraft,
              hasInvalidInput: () => cubit.state.invalid,
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Text(l.config_editor_draft_hint),
                  Text(l.night_behavior_help),
                  _field(context, state, WakeField.absence, l.night_absence_seconds, number: true),
                  SwitchListTile(
                    key: const ValueKey('night-enabled'),
                    title: Text(l.night_enabled),
                    value: state.config.enabled,
                    onChanged: cubit.enable,
                  ),
                  DropdownButtonFormField<NightMode>(
                    key: const ValueKey('night-mode'),
                    initialValue: state.config.mode,
                    isExpanded: true,
                    decoration: InputDecoration(labelText: l.night_mode_label),
                    items: [
                      for (final mode in NightMode.values)
                        DropdownMenuItem(value: mode, child: Text(nightModeLabel(l, mode))),
                    ],
                    onChanged: (mode) {
                      if (mode != null) cubit.mode(mode);
                    },
                  ),
                  _field(context, state, WakeField.start, l.night_start),
                  _field(context, state, WakeField.end, l.night_end),
                  SwitchListTile(
                    key: const ValueKey('night-light-enabled'),
                    title: Text(l.night_use_light),
                    value: state.config.ambientLight.enabled,
                    onChanged: cubit.enableLight,
                  ),
                  Text(l.night_mqtt_help),
                  _field(context, state, WakeField.topic, l.night_light_topic),
                  _field(context, state, WakeField.valueField, l.night_light_field),
                  _field(context, state, WakeField.availabilityTopic, l.night_availability_topic),
                  _field(context, state, WakeField.darkBelow, l.night_dark_threshold, number: true),
                  _field(context, state, WakeField.lightAbove, l.night_light_threshold, number: true),
                  _field(context, state, WakeField.maxAge, l.night_max_age, number: true),
                  const Divider(),
                  if (state.device case final frame?)
                    NightModeDetails(frame: frame)
                  else
                    Text(l.night_device_state_help),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

@Preview(name: 'Wake and sleep settings', size: Size(760, 1000))
Widget wakeSettingsPreview() => MaterialApp(
  locale: const Locale('en'),
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: WakeSettingsPage(config: AppConfig.fromJson({})),
);
