import 'package:config_app/features/uikit/presentation/widgets/navigation_bar/configapp_navigation_bar.dart';
import 'package:config_app/features/ota/presentation/bloc/ota_bloc.dart';
import 'package:config_app/features/ota/presentation/bloc/ota_state.dart';
import 'package:config_app/features/ota/presentation/bloc/ota_event.dart';
import 'package:config_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';

class OtaMainPage extends StatelessWidget {
  const OtaMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("OTA Update")),
      drawer: const ConfigAppNavigationBar(),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<OtaBloc>(
            create: (BuildContext context) => OtaBloc(
                initialState: const UninitializedOtaState(), client: sl()),
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
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return state.maybeWhen(
          uninitialized: () => _buildUninitializedState(context),
          initialized: (version) => _buildInitializedState(context, version),
          uploading: (progress) => _buildUploadingState(context, progress),
          uploadComplete: () => _buildUploadCompleteState(context),
          error: (errorMessage) => _buildErrorState(context, errorMessage),
          orElse: () => const Center(child: Text('Unknown state')),
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
            style: TextStyle(fontSize: 18),
            onTap: () {
            },
          ),
          const Text(
            'OTA Update',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context.read<OtaBloc>().add(const InitOtaEvent());
            },
            child: const Text('Initialize'),
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
            'Version: $version',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: tEdCode,
            decoration: const InputDecoration(labelText: 'OTA Code'),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ], // Only numbers can be entered
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              filePath = await _pickFile();
            },
            child: const Text('Select File'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context
                  .read<OtaBloc>()
                  .add(UploadFileOtaEvent(filePath!, tEdCode.value.text));
            },
            child: const Text('Update'),
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
          const Text(
            'Uploading firmware...',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[300],
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          const SizedBox(height: 10),
          Text(
            '${(progress * 100).toStringAsFixed(1)}%',
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
          // Text(
          //   'Version: $version',
          //   style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          // ),
          // const SizedBox(height: 10),
          // Text(
          //   'Update Code: $updateCode',
          //   style: const TextStyle(fontSize: 16),
          // ),
          // const SizedBox(height: 20),
          const Text(
            'Firmware upload completed successfully!',
            style: TextStyle(fontSize: 16, color: Colors.green),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context.read<OtaBloc>().add(const ResetOtaEvent());
            },
            child: const Text('Reset'),
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
            'Error: $errorMessage',
            style: const TextStyle(fontSize: 16, color: Colors.red),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context.read<OtaBloc>().add(const ResetOtaEvent());
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }

  Future<String?> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['deb'], // распространенные форматы прошивок
    );

    if (result != null) {
      return result.files.single.path;
    } else {
      // Пользователь отменил выбор файла
      return null;
    }
  }
}
