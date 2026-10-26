import 'dart:io';

import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:config_app/features/uikit/presentation/widgets/config_app_scaffold.dart';
import 'package:config_app/features/upload/domain/upload_task.dart';
import 'package:config_app/features/upload/presentation/bloc/upload_queue_bloc.dart';
import 'package:dslideshow_common/file_settings.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as p;

enum _UploadSelection { files, folder }

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Блок уже должен быть предоставлен выше в дереве
    return ConfigAppScaffold(
      appBar: AppBar(
        title: Text(context.localizations.upload_queue_title),
        actions: [
          // Меню добавления
          PopupMenuButton<_UploadSelection>(
            icon: const Icon(Icons.add),
            tooltip: context.localizations.add_files_menu_item,
            onSelected: (value) => _handleMenuSelection(context, value),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: _UploadSelection.files,
                child: Text(context.localizations.add_files_menu_item),
              ),
              if (!kIsWeb)
                PopupMenuItem(
                  value: _UploadSelection.folder,
                  child: Text(context.localizations.add_folder_menu_item),
                ),
            ],
          ),
        ],
      ),

      body: BlocBuilder<UploadQueueBloc, UploadQueueState>(
        builder: (context, state) {
          if (state.tasks.isEmpty) {
            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.upload_file_outlined,
                      size: 56,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      context.localizations.queue_is_empty,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      context.localizations.upload_empty_hint,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    FilledButton.icon(
                      key: const ValueKey('upload-add-files'),
                      onPressed: () =>
                          _handleMenuSelection(context, _UploadSelection.files),
                      icon: const Icon(Icons.add),
                      label: Text(context.localizations.add_files_menu_item),
                    ),
                  ],
                ),
              ),
            );
          }

          // Показываем новые сверху или снизу? Обычно новые снизу.
          // Если хотим новые сверху: state.tasks.reversed.toList()
          final tasks = state.tasks.reversed.toList();

          return ListView.separated(
            itemCount: tasks.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, index) {
              return _UploadTaskTile(task: tasks[index]);
            },
          );
        },
      ),
    );
  }

  Future<void> _handleMenuSelection(
    BuildContext context,
    _UploadSelection value,
  ) async {
    final bloc = context.read<UploadQueueBloc>();
    switch (value) {
      case _UploadSelection.files:
        await _uploadFiles(bloc);
        break;
      case _UploadSelection.folder:
        await _uploadFolder(bloc, context);
        break;
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
    final result = await FilePicker.pickFiles();
    if (result.isNotEmpty) {
      // Для одиночных файлов rootPath считаем как папку, где они лежат
      final files = result
          .map((file) => file.path)
          .whereType<String>()
          .map((e) => File(e))
          .toList();
      if (files.isNotEmpty) {
        final root = p.dirname(files.first.path);
        bloc.add(UploadQueueEvent.addFiles(files: files, rootPath: root));
      }
    }
  }

  Future<void> _uploadFilesWeb(UploadQueueBloc bloc) async {
    final result = await FilePicker.pickFiles(type: FileType.any);
    if (result.isNotEmpty) {
      bloc.add(UploadQueueEvent.addPlatformFiles(files: result, rootPath: ''));
    }
  }

  Future<void> _uploadFolder(UploadQueueBloc bloc, BuildContext context) async {
    final String? selectedDirectory = await FilePicker.getDirectoryPath();
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
        bloc.add(
          UploadQueueEvent.addFiles(files: files, rootPath: selectedDirectory),
        );
      } else if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.localizations.no_images_found_in_folder),
          ),
        );
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
      leading: _buildLeadingIcon(context),
      title: Text(p.basename(task.serverPath)), // Показываем имя файла
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.serverPath,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          if (task.status == UploadStatus.uploading)
            LinearProgressIndicator(value: task.progress),
          if (task.status == UploadStatus.error)
            Text(
              task.errorMessage ?? context.localizations.error_text,
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontSize: 12,
              ),
            ),
        ],
      ),
      trailing: _buildAction(context),
      isThreeLine: true,
    );
  }

  Widget _buildLeadingIcon(BuildContext context) {
    switch (task.status) {
      case UploadStatus.queued:
        return Icon(
          Icons.hourglass_empty,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        );
      case UploadStatus.uploading:
        return Stack(
          alignment: Alignment.center,
          children: [
            const CircularProgressIndicator(),
            Text(
              "${(task.progress * 100).toInt()}",
              style: const TextStyle(fontSize: 10),
            ),
          ],
        );
      case UploadStatus.completed:
        return Icon(
          Icons.check_circle,
          color: Theme.of(context).colorScheme.primary,
        );
      case UploadStatus.error:
        return Icon(Icons.error, color: Theme.of(context).colorScheme.error);
    }
  }

  Widget? _buildAction(BuildContext context) {
    if (task.status == UploadStatus.completed) {
      return IconButton(
        icon: const Icon(Icons.delete),
        tooltip: context.localizations.upload_remove_task,
        onPressed: () {
          context.read<UploadQueueBloc>().add(
            UploadQueueEvent.removeTask(task.id),
          );
        },
      );
    } else if (task.status == UploadStatus.queued) {
      return IconButton(
        icon: const Icon(Icons.delete),
        tooltip: context.localizations.upload_remove_task,
        onPressed: () {
          context.read<UploadQueueBloc>().add(
            UploadQueueEvent.removeTask(task.id),
          );
        },
      );
    } else if (task.status == UploadStatus.error) {
      return IconButton(
        icon: const Icon(Icons.refresh),
        tooltip: context.localizations.retry_button,
        onPressed: () {
          context.read<UploadQueueBloc>().add(
            UploadQueueEvent.retryTask(task.id),
          );
        },
      );
    }
    return null; // Для загружающихся и завершенных действий нет (по ТЗ)
  }
}
