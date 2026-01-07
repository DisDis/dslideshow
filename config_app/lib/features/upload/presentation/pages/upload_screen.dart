import 'dart:io';
import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:config_app/features/theme/presentation/theme.dart';
import 'package:config_app/features/uikit/presentation/widgets/navigation_bar/configapp_navigation_bar.dart';
import 'package:config_app/features/upload/domain/upload_task.dart';
import 'package:config_app/features/upload/presentation/bloc/upload_queue_bloc.dart';
import 'package:dslideshow_common/file_settings.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as p;

class UploadScreen extends StatelessWidget {
  static const _filesValue = 'files';
  static const _folderValue = 'folder';
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Блок уже должен быть предоставлен выше в дереве
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localizations.upload_queue_title),
        actions: [
          // Меню добавления
          PopupMenuButton<String>(
            icon: const Icon(Icons.add),
            onSelected: (value) => _handleMenuSelection(context, value),
            itemBuilder: (context) => [
              PopupMenuItem(
                  value: _filesValue,
                  child: Text(context.localizations.add_files_menu_item)),
              if (!kIsWeb)
                PopupMenuItem(
                    value: _folderValue,
                    child: Text(context.localizations.add_folder_menu_item)),
            ],
          )
        ],
      ),
      drawer: const ConfigAppNavigationBar(),
      body: BlocBuilder<UploadQueueBloc, UploadQueueState>(
        builder: (context, state) {
          if (state.tasks.isEmpty) {
            return Center(child: Text(context.localizations.queue_is_empty));
          }

          // Показываем новые сверху или снизу? Обычно новые снизу.
          // Если хотим новые сверху: state.tasks.reversed.toList()
          final tasks = state.tasks.reversed.toList();

          return ListView.separated(
            itemCount: tasks.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              return _UploadTaskTile(task: tasks[index]);
            },
          );
        },
      ),
    );
  }

  Future<void> _handleMenuSelection(BuildContext context, String value) async {
    final bloc = context.read<UploadQueueBloc>();
    switch (value) {
      case _filesValue:
        await _uploadFiles(bloc);
        break;
      case _folderValue:
        await _uploadFolder(bloc, context);
        break;
      default:
    }
  }

  Future<void> _uploadFiles(UploadQueueBloc bloc) async {
    if (kIsWeb) {
      await _uploadFilesWeb(bloc);
    } else {
      await _uploadFilesNative(bloc);
    }
  }

  Future<void> _uploadFilesNative(UploadQueueBloc bloc) async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      // Для одиночных файлов rootPath считаем как папку, где они лежат
      final files =
          result.paths.whereType<String>().map((e) => File(e)).toList();
      if (files.isNotEmpty) {
        final root = p.dirname(files.first.path);
        bloc.add(UploadQueueEvent.addFiles(files: files, rootPath: root));
      }
    }
  }

  Future<void> _uploadFilesWeb(UploadQueueBloc bloc) async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.any,
    );
    if (result != null && result.files.isNotEmpty) {
      // В веб-сборке result.files содержит XFile объекты
      final List<PlatformFile> xFiles = result.files;
   
      if (xFiles.isNotEmpty) {
        // В веб-сборке используем временную директорию как корневую
        bloc.add(UploadQueueEvent.addPlatformFiles(files: xFiles, rootPath: ''));
      }
    }
  }

  Future<void> _uploadFolder(UploadQueueBloc bloc, BuildContext context) async {
    final String? selectedDirectory =
        await FilePicker.platform.getDirectoryPath();
    if (selectedDirectory != null) {
      // Рекурсивно ищем файлы
      final dir = Directory(selectedDirectory);
      // Внимание: это может занять время, лучше вынести в compute или Future
      final List<File> files = dir
          .listSync(recursive: true)
          .whereType<File>()
          // Фильтр по расширениям
          .where((f) => _isSupportFile(f.path))
          .toList();

      if (files.isNotEmpty) {
        bloc.add(UploadQueueEvent.addFiles(
            files: files, rootPath: selectedDirectory));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(context.localizations.no_images_found_in_folder)));
      }
    }
  }

  bool _isSupportFile(String path) {
    return FileSettings.isSupportFile(p.extension(path));
  }
}

class _UploadTaskTile extends StatelessWidget {
  final UploadTask task;

  const _UploadTaskTile({required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _buildLeadingIcon(),
      title: Text(p.basename(task.serverPath)), // Показываем имя файла
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(task.serverPath,
              style:
                  const TextStyle(fontSize: 10, color: AppColors.uploadText)),
          if (task.status == UploadStatus.uploading)
            LinearProgressIndicator(value: task.progress),
          if (task.status == UploadStatus.error)
            Text(task.errorMessage ?? "Error",
                style: const TextStyle(
                    color: AppColors.uploadErrorText, fontSize: 12)),
        ],
      ),
      trailing: _buildAction(context),
      isThreeLine: true,
    );
  }

  Widget _buildLeadingIcon() {
    switch (task.status) {
      case UploadStatus.queued:
        return const Icon(Icons.hourglass_empty,
            color: AppColors.uploadQueuedIcon);
      case UploadStatus.uploading:
        return Stack(
          alignment: Alignment.center,
          children: [
            const CircularProgressIndicator(),
            Text("${(task.progress * 100).toInt()}",
                style: const TextStyle(fontSize: 10)),
          ],
        );
      case UploadStatus.completed:
        return const Icon(Icons.check_circle,
            color: AppColors.uploadCompletedIcon);
      case UploadStatus.error:
        return const Icon(Icons.error, color: AppColors.uploadErrorIcon);
    }
  }

  Widget? _buildAction(BuildContext context) {
    if (task.status == UploadStatus.completed) {
      return IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          context
              .read<UploadQueueBloc>()
              .add(UploadQueueEvent.removeTask(task.id));
        },
      );
    } else if (task.status == UploadStatus.queued) {
      return IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          context
              .read<UploadQueueBloc>()
              .add(UploadQueueEvent.removeTask(task.id));
        },
      );
    } else if (task.status == UploadStatus.error) {
      return IconButton(
        icon: const Icon(Icons.refresh),
        onPressed: () {
          context
              .read<UploadQueueBloc>()
              .add(UploadQueueEvent.retryTask(task.id));
        },
      );
    }
    return null; // Для загружающихся и завершенных действий нет (по ТЗ)
  }
}
