import 'dart:io';

import 'package:config_app/features/uikit/presentation/widgets/navigation_bar/configapp_navigation_bar.dart';
import 'package:config_app/features/upload/domain/upload_task.dart';
import 'package:config_app/features/upload/presentation/bloc/upload_queue_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as p;

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Блок уже должен быть предоставлен выше в дереве
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Queue"),
        actions: [
          // Меню добавления
          PopupMenuButton<String>(
            icon: const Icon(Icons.add),
            onSelected: (value) => _handleMenuSelection(context, value),
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'files', child: Text("Add Files")),
              const PopupMenuItem(value: 'folder', child: Text("Add Folder")),
            ],
          )
        ],
      ),
      drawer: const ConfigAppNavigationBar(),
      body: BlocBuilder<UploadQueueBloc, UploadQueueState>(
        builder: (context, state) {
          if (state.tasks.isEmpty) {
            return const Center(child: Text("Queue is empty"));
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

    if (value == 'files') {
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
    } else if (value == 'folder') {
      final String? selectedDirectory =
          await FilePicker.platform.getDirectoryPath();
      if (selectedDirectory != null) {
        // Рекурсивно ищем файлы
        final dir = Directory(selectedDirectory);
        // Внимание: это может занять время, лучше вынести в compute или Future
        final List<File> files = dir
            .listSync(recursive: true)
            .whereType<File>()
            // Фильтр по расширениям картинки
            .where((f) => _isImage(f.path))
            .toList();

        if (files.isNotEmpty) {
          bloc.add(UploadQueueEvent.addFiles(
              files: files, rootPath: selectedDirectory));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("No images found in folder")));
        }
      }
    }
  }

  bool _isImage(String path) {
    final ext = p.extension(path).toLowerCase();
    return [
      '.jpg',
      '.jpeg',
      '.png',
      '.gif',
      '.webp',
    ].contains(ext);
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
              style: const TextStyle(fontSize: 10, color: Colors.grey)),
          if (task.status == UploadStatus.uploading)
            LinearProgressIndicator(value: task.progress),
          if (task.status == UploadStatus.error)
            Text(task.errorMessage ?? "Error",
                style: const TextStyle(color: Colors.red, fontSize: 12)),
        ],
      ),
      trailing: _buildAction(context),
      isThreeLine: true,
    );
  }

  Widget _buildLeadingIcon() {
    switch (task.status) {
      case UploadStatus.queued:
        return const Icon(Icons.hourglass_empty, color: Colors.grey);
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
        return const Icon(Icons.check_circle, color: Colors.green);
      case UploadStatus.error:
        return const Icon(Icons.error, color: Colors.red);
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
