import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:config_app/features/uikit/presentation/widgets/config_app_scaffold.dart';
import 'package:config_app/features/upload/domain/upload_task.dart';
import 'package:config_app/features/upload/presentation/bloc/upload_queue_bloc.dart';
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
    return BlocListener<UploadQueueBloc, UploadQueueState>(
      listenWhen: (previous, current) =>
          previous.selectionRevision != current.selectionRevision,
      listener: (context, state) {
        final message = switch (state.selectionIssue) {
          UploadSelectionIssue.emptyFolder =>
            context.localizations.no_images_found_in_folder,
          UploadSelectionIssue.folderReadFailed =>
            context.localizations.upload_folder_scan_failed,
          null => null,
        };
        if (message != null) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message)));
        }
      },
      child: ConfigAppScaffold(
        appBar: AppBar(
          title: Text(context.localizations.upload_queue_title),
          actions: [
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
          buildWhen: (previous, current) =>
              previous.taskRevision != current.taskRevision ||
              previous.isScanningFolder != current.isScanningFolder,
          builder: (context, state) => Column(
            children: [
              if (state.isScanningFolder) const LinearProgressIndicator(),
              Expanded(
                child: state.tasks.isEmpty
                    ? _emptyQueue(context)
                    : ListView.separated(
                        itemCount: state.tasks.length,
                        separatorBuilder: (_, _) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final task =
                              state.tasks[state.tasks.length - index - 1];
                          return _UploadTaskTile(
                            key: ValueKey(task.id),
                            task: task,
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emptyQueue(BuildContext context) => Center(
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

  Future<void> _handleMenuSelection(
    BuildContext context,
    _UploadSelection value,
  ) async {
    final bloc = context.read<UploadQueueBloc>();
    switch (value) {
      case _UploadSelection.files:
        final files = await FilePicker.pickFiles(type: FileType.any);
        if (files.isNotEmpty && !bloc.isClosed) {
          bloc.add(
            UploadQueueEvent.addPlatformFiles(files: files, rootPath: ''),
          );
        }
      case _UploadSelection.folder:
        final directory = await FilePicker.getDirectoryPath();
        if (directory != null && !bloc.isClosed) {
          bloc.add(UploadQueueEvent.addFolder(directory));
        }
    }
  }
}

class _UploadTaskTile extends StatelessWidget {
  final UploadTask task;

  const _UploadTaskTile({super.key, required this.task});

  @override
  Widget build(BuildContext context) =>
      BlocSelector<UploadQueueBloc, UploadQueueState, double>(
        selector: (state) => state.activeProgress[task.id] ?? task.progress,
        builder: (context, progress) => ListTile(
          leading: _leading(context, progress),
          title: Text(p.basename(task.serverPath)),
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
                LinearProgressIndicator(value: progress),
              if (task.status == UploadStatus.error)
                Text(
                  switch (task.failure) {
                    UploadFailure.sourceUnavailable =>
                      context.localizations.upload_source_unavailable,
                    UploadFailure.lengthUnknown =>
                      context.localizations.upload_length_unknown,
                    UploadFailure.transferFailed =>
                      context.localizations.upload_transfer_failed,
                    null => context.localizations.error_text,
                  },
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 12,
                  ),
                ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (task.status == UploadStatus.error)
                IconButton(
                  icon: const Icon(Icons.refresh),
                  tooltip: context.localizations.retry_button,
                  onPressed: () => context.read<UploadQueueBloc>().add(
                    UploadQueueEvent.retryTask(task.id),
                  ),
                ),
              IconButton(
                icon: Icon(
                  task.status == UploadStatus.uploading
                      ? Icons.close
                      : Icons.delete,
                ),
                tooltip: task.status == UploadStatus.uploading
                    ? context.localizations.cancel_button
                    : context.localizations.upload_remove_task,
                onPressed: () => context.read<UploadQueueBloc>().add(
                  UploadQueueEvent.removeTask(task.id),
                ),
              ),
            ],
          ),
          isThreeLine: true,
        ),
      );

  Widget _leading(BuildContext context, double progress) =>
      switch (task.status) {
        UploadStatus.queued => Icon(
          Icons.hourglass_empty,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        UploadStatus.uploading => SizedBox(
          width: 40,
          height: 40,
          child: Stack(
            alignment: Alignment.center,
            children: [
              const CircularProgressIndicator(),
              Text(
                '${(progress * 100).toInt()}',
                style: const TextStyle(fontSize: 10),
              ),
            ],
          ),
        ),
        UploadStatus.completed => Icon(
          Icons.check_circle,
          color: Theme.of(context).colorScheme.primary,
        ),
        UploadStatus.error => Icon(
          Icons.error,
          color: Theme.of(context).colorScheme.error,
        ),
      };
}
