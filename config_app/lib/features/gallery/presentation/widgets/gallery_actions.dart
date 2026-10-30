import 'dart:async';

import 'package:dslideshow_common/gallery.dart';
import 'package:flutter/material.dart';

import '../../../theme/presentation/extensions/build_context_ext.dart';
import '../../../../src/gallery/gallery_management_repository.dart';
import '../bloc/gallery_undo_bloc.dart';
import '../bloc/gallery_mutation_confirmation.dart';
import 'gallery_file_size.dart';

const galleryDialogFileLimit = galleryConfirmationNameLimit;

SnackBar galleryNotification(String message, {SnackBarAction? action}) =>
    SnackBar(
      content: Text(message),
      action: action,
      showCloseIcon: true,
      persist: false,
      duration: action == null
          ? const Duration(seconds: 4)
          : const Duration(seconds: 8),
    );

String galleryErrorText(BuildContext context, GalleryErrorCode? code) {
  final l = context.localizations;
  return switch (code) {
    GalleryErrorCode.forbidden => l.gallery_error_forbidden,
    GalleryErrorCode.notFound => l.gallery_error_missing,
    GalleryErrorCode.revisionMismatch => l.gallery_error_revision,
    GalleryErrorCode.conflict => l.gallery_error_conflict,
    GalleryErrorCode.busy => l.gallery_error_busy,
    GalleryErrorCode.unsupported => l.gallery_not_supported,
    GalleryErrorCode.unavailable => l.gallery_error_unavailable,
    _ => l.gallery_action_failed,
  };
}

Future<bool> confirmGalleryPurge(
  BuildContext context,
  int count,
  int bytes, {
  List<String> names = const [],
}) async {
  final l = context.localizations;
  return _confirmGalleryFiles(
    context,
    title: l.gallery_purge_title,
    body: Tooltip(
      message: l.gallery_size_bytes(bytes),
      child: Text(
        l.gallery_purge_body(
          count,
          GalleryFileSize.formatMegabytes(context, bytes),
        ),
      ),
    ),
    confirmLabel: l.gallery_purge,
    count: count,
    names: names,
    remainingText: l.gallery_more_files_purge,
  );
}

Future<bool> confirmGalleryMutation(
  BuildContext context,
  GalleryMutationConfirmation confirmation,
) {
  final l = context.localizations;
  return switch (confirmation.action) {
    GalleryMutation.trash => _confirmGalleryFiles(
      context,
      title: l.gallery_trash_title,
      body: Text(l.gallery_trash_confirm_body(confirmation.items.length)),
      confirmLabel: l.gallery_move_to_trash,
      count: confirmation.items.length,
      names: confirmation.names,
      remainingText: l.gallery_more_files_trash,
    ),
    GalleryMutation.purge => confirmGalleryPurge(
      context,
      confirmation.items.length,
      confirmation.sizeBytes!,
      names: confirmation.names,
    ),
    GalleryMutation.restore => Future.value(true),
  };
}

Future<bool> _confirmGalleryFiles(
  BuildContext context, {
  required String title,
  required Widget body,
  required String confirmLabel,
  required int count,
  required List<String> names,
  required String Function(int) remainingText,
}) async {
  final shown = names.take(galleryDialogFileLimit).toList(growable: false);
  return await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: SizedBox(
            width: 480,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  body,
                  for (final name in shown)
                    ListTile(
                      title: Text(
                        name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  if (shown.length < count)
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(remainingText(count - shown.length)),
                    ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(confirmLabel),
            ),
          ],
        ),
      ) ??
      false;
}

void showGalleryUndo(
  BuildContext context,
  GalleryManagementRepository repository,
  List<String> trashIds,
  Future<void> Function() refresh,
) {
  final messenger = ScaffoldMessenger.of(context);
  final l = context.localizations;
  final bloc = GalleryUndoBloc(repository: repository, trashIds: trashIds);

  void closeWhenDismissed(
    ScaffoldFeatureController<SnackBar, SnackBarClosedReason> controller,
  ) {
    unawaited(
      controller.closed.then((reason) async {
        if (reason != SnackBarClosedReason.action) await bloc.close();
      }),
    );
  }

  Future<void> undo() async {
    if (bloc.isClosed) return;
    try {
      final result = await bloc.restore();
      // A disposed screen or a failed optional refresh cannot turn a confirmed
      // restore into a failure, nor cause it to be retried as unknown work.
      try {
        await refresh();
      } catch (_) {
        // The next gallery visit refreshes its own snapshot.
      }
      unawaited(bloc.close());
      if (!messenger.mounted) return;
      final failed = result.items.any(
        (item) => item.state == GalleryItemOperationState.failed,
      );
      messenger.showSnackBar(
        galleryNotification(
          failed
              ? l.gallery_failed_files
              : bloc.state.missingCount > 0
              ? l.gallery_undo_changed
              : l.gallery_restored,
        ),
      );
    } catch (_) {
      if (!messenger.mounted) {
        await bloc.close();
        return;
      }
      closeWhenDismissed(
        messenger.showSnackBar(
          galleryNotification(
            l.gallery_action_failed,
            action: SnackBarAction(label: l.retry_button, onPressed: undo),
          ),
        ),
      );
    }
  }

  closeWhenDismissed(
    messenger.showSnackBar(
      galleryNotification(
        l.gallery_trashed,
        action: trashIds.isEmpty
            ? null
            : SnackBarAction(label: l.gallery_undo, onPressed: undo),
      ),
    ),
  );
}
