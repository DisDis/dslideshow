import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:config_app/features/uikit/presentation/widgets/config_app_scaffold.dart';
import 'package:config_app/features/ota/presentation/bloc/ota_bloc.dart';
import 'package:config_app/features/ota/presentation/bloc/ota_state.dart';
import 'package:config_app/features/ota/presentation/bloc/ota_event.dart';
import 'package:config_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';

class OtaMainPage extends StatelessWidget {
  const OtaMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ConfigAppScaffold(
      appBar: AppBar(title: Text(context.localizations.ota_update_title)),

      body: MultiBlocProvider(
        providers: [
          BlocProvider<OtaBloc>(
            create: (BuildContext context) => OtaBloc(
              initialState: const UninitializedOtaState(),
              client: sl(),
            ),
          ),
        ],
        child: Builder(
          builder: (context) {
            return const OtaPageContent();
          },
        ),
      ),
    );
  }
}

class OtaPageContent extends StatefulWidget {
  const OtaPageContent({super.key});

  @override
  State<OtaPageContent> createState() => _OtaPageContentState();
}

class _OtaPageContentState extends State<OtaPageContent> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtaBloc, OtaState>(
      listener: (context, state) {
        // Обработка состояний, например, показ ошибок
        if (state is ErrorOtaState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errorMessage,
                style: TextStyle(color: Theme.of(context).colorScheme.onError),
              ),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      },
      builder: (context, state) {
        return SettingsContent(
          maxWidth: 720,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: state.maybeWhen(
              uninitialized: () => _buildUninitializedState(context),
              initialized: (version) =>
                  _buildInitializedState(context, version),
              uploading: (progress) => _buildUploadingState(context, progress),
              uploadComplete: () => _buildUploadCompleteState(context),
              error: (errorMessage) => _buildErrorState(context, errorMessage),
              orElse: () =>
                  Center(child: Text(context.localizations.unknown_state)),
            ),
          ),
        );
      },
    );
  }

  Widget _buildUninitializedState(BuildContext context) {
    final uri = context.read<OtaBloc>().client.connectUri;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SelectableText(
            'http://${uri.host}:8282/ota_start',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            context.localizations.ota_update_title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context.read<OtaBloc>().add(const InitOtaEvent());
            },
            child: Text(context.localizations.initialize_button),
          ),
        ],
      ),
    );
  }

  Widget _buildInitializedState(BuildContext context, String version) {
    final tEdCode = TextEditingController(text: '');
    String? filePath;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.localizations.ota_version(version),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 10),
          TextField(
            controller: tEdCode,
            decoration: InputDecoration(
              labelText: context.localizations.ota_code_label,
            ),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ], // Only numbers can be entered
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              filePath = await _pickFile();
            },
            child: Text(context.localizations.select_file_button),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context.read<OtaBloc>().add(
                UploadFileOtaEvent(filePath!, tEdCode.value.text),
              );
            },
            child: Text(context.localizations.update_button),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadingState(BuildContext context, double progress) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.localizations.ota_uploading,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(value: progress),
          const SizedBox(height: 10),
          Text(
            NumberFormat.decimalPercentPattern(
              locale: Localizations.localeOf(context).toLanguageTag(),
              decimalDigits: 1,
            ).format(progress),
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadCompleteState(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.localizations.ota_upload_complete,
            style: Theme.of(context).textTheme.bodyLarge
                ?.copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context.read<OtaBloc>().add(const ResetOtaEvent());
            },
            child: Text(context.localizations.reset_button),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String errorMessage) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            context.localizations.error_with_message(errorMessage),
            style: Theme.of(context).textTheme.bodyLarge
                ?.copyWith(color: Theme.of(context).colorScheme.error),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context.read<OtaBloc>().add(const ResetOtaEvent());
            },
            child: Text(context.localizations.reset_button),
          ),
        ],
      ),
    );
  }

  Future<String?> _pickFile() async {
    final result = await FilePicker.pickFile(
      type: FileType.custom,
      allowedExtensions: ['deb'], // распространенные форматы прошивок
    );

    return result?.path;
  }
}
