import 'package:config_app/features/gallery/presentation/bloc/gallery_management_bloc.dart';
import 'package:config_app/features/gallery/presentation/bloc/gallery_viewer_bloc.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> confirmManagementMutation(
  GalleryManagementBloc bloc,
  GalleryMutation action,
) async {
  final state = bloc.state.confirmation != null
      ? bloc.state
      : await bloc.stream
            .firstWhere((state) => state.confirmation != null)
            .timeout(const Duration(seconds: 3));
  final confirmation = state.confirmation!;
  expect(confirmation.action, action);
  bloc.add(
    GalleryManagementEvent.mutationDecision(
      confirmationId: confirmation.token,
      confirmed: true,
    ),
  );
}

Future<void> confirmViewerMutation(
  GalleryViewerBloc bloc,
  GalleryMutation action,
) async {
  final state = bloc.state.confirmation != null
      ? bloc.state
      : await bloc.stream
            .firstWhere((state) => state.confirmation != null)
            .timeout(const Duration(seconds: 3));
  final confirmation = state.confirmation!;
  expect(confirmation.action, action);
  bloc.add(
    GalleryViewerEvent.mutationDecision(
      confirmationId: confirmation.token,
      confirmed: true,
    ),
  );
}

Future<void> confirmTrashDialog(WidgetTester tester) async {
  await tester.pump();
  final dialog = find.byType(AlertDialog);
  expect(dialog, findsOneWidget);
  expect(
    find.descendant(of: dialog, matching: find.text('Move to trash?')),
    findsOneWidget,
  );
  await tester.tap(
    find.descendant(
      of: dialog,
      matching: find.widgetWithText(FilledButton, 'Move to trash'),
    ),
  );
  // Wait for this finite modal transition, preserving any live media beneath it.
  var elapsed = Duration.zero;
  while (dialog.evaluate().isNotEmpty && elapsed < const Duration(seconds: 1)) {
    await tester.pump(const Duration(milliseconds: 16));
    elapsed += const Duration(milliseconds: 16);
  }
  expect(dialog, findsNothing);
}
