import 'package:config_app/features/ota/presentation/bloc/ota_bloc.dart';
import 'package:config_app/features/ota/presentation/bloc/ota_event.dart';
import 'package:config_app/features/ota/presentation/bloc/ota_state.dart';
import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:config_app/features/uikit/presentation/widgets/config_app_scaffold.dart';
import 'package:config_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class OtaMainPage extends StatelessWidget {
  const OtaMainPage({super.key});

  @override
  Widget build(BuildContext context) => ConfigAppScaffold(
    appBar: AppBar(title: Text(context.localizations.ota_update_title)),
    body: BlocProvider(
      create: (_) => OtaBloc(client: sl()),
      child: const OtaPageContent(),
    ),
  );
}

class OtaPageContent extends StatelessWidget {
  const OtaPageContent({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<OtaBloc, OtaState>(
    builder: (context, state) {
      final bloc = context.read<OtaBloc>();
      final text = context.localizations;
      final uploading = state.phase == OtaPhase.uploading;
      return SettingsContent(
        maxWidth: 720,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (state.version.isNotEmpty) ...[
                Text(
                  text.ota_version(state.version),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
              ],
              if (state.failure case final failure?) ...[
                Text(
                  _failureText(context, failure),
                  key: const ValueKey('ota-error'),
                  style: Theme.of(context).textTheme.bodyMedium
                      ?.copyWith(color: Theme.of(context).colorScheme.error),
                ),
                const SizedBox(height: 16),
              ],
              if (state.phase == OtaPhase.initializing)
                const Center(child: CircularProgressIndicator())
              else if (state.phase == OtaPhase.completed) ...[
                Text(text.ota_upload_complete),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () => bloc.add(const OtaEvent.reset()),
                  child: Text(text.reset_button),
                ),
              ] else if (state.version.isEmpty) ...[
                SelectableText('${bloc.otaStartUri}'),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () => bloc.add(const OtaEvent.init()),
                  child: Text(text.initialize_button),
                ),
              ] else ...[
                TextFormField(
                  key: ValueKey('ota-code-${state.formGeneration}'),
                  initialValue: state.code,
                  enabled: !uploading,
                  onChanged: (value) => bloc.add(OtaEvent.codeChanged(value)),
                  decoration: InputDecoration(labelText: text.ota_code_label),
                  autocorrect: false,
                  enableSuggestions: false,
                ),
                const SizedBox(height: 16),
                if (state.filename case final filename?) ...[
                  Text(
                    text.ota_file_selected(filename),
                    key: const ValueKey('ota-selected-file'),
                  ),
                  const SizedBox(height: 12),
                ],
                FilledButton.tonal(
                  key: const ValueKey('ota-select-file'),
                  onPressed: uploading || state.pickingFile
                      ? null
                      : () => bloc.add(const OtaEvent.pickFile()),
                  child: Text(text.select_file_button),
                ),
                const SizedBox(height: 16),
                if (state.pickingFile) const LinearProgressIndicator(),
                if (uploading) ...[
                  Text(text.ota_uploading),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(value: state.progress),
                  const SizedBox(height: 8),
                  Text(
                    NumberFormat.decimalPercentPattern(
                      locale: Localizations.localeOf(context).toLanguageTag(),
                      decimalDigits: 1,
                    ).format(state.progress),
                  ),
                  const SizedBox(height: 16),
                ],
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    FilledButton(
                      key: const ValueKey('ota-upload'),
                      onPressed: state.canSubmit
                          ? () => bloc.add(const OtaEvent.upload())
                          : null,
                      child: Text(text.update_button),
                    ),
                    TextButton(
                      key: const ValueKey('ota-reset'),
                      onPressed: () => bloc.add(const OtaEvent.reset()),
                      child: Text(
                        uploading || state.pickingFile
                            ? text.cancel_button
                            : text.reset_button,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      );
    },
  );

  String _failureText(BuildContext context, OtaFailure failure) {
    final text = context.localizations;
    return switch (failure) {
      OtaFailure.invalidFile => text.ota_file_invalid,
      OtaFailure.emptyFile => text.ota_file_empty,
      OtaFailure.fileUnavailable => text.ota_file_unavailable,
      OtaFailure.invalidResponse => text.ota_response_invalid,
      OtaFailure.uploadRejected => text.ota_upload_rejected,
      OtaFailure.requestFailed ||
      OtaFailure.cancelled => text.ota_request_failed,
    };
  }
}
