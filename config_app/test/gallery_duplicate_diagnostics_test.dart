import 'dart:async';
import 'dart:convert';

import 'package:config_app/features/gallery/presentation/bloc/gallery_duplicates_bloc.dart';
import 'package:crypto/crypto.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'support/gallery_management_harness.dart';
import 'support/gallery_duplicates_harness.dart';

void main() {
  testWidgets('failed CLI job shows typed cause, version, exit code and counts on a compact screen', (tester) async {
    const job = GalleryDuplicateJob(
      jobId: 'job-failed',
      status: GalleryDuplicateStatus.failed,
      error: GalleryErrorCode.processingFailed,
      modes: [GalleryDuplicateMode.exact],
      diagnostics: GalleryDuplicateDiagnostics(
        stage: GalleryDuplicateStage.scanning,
        failureReason: GalleryDuplicateFailureReason.processFailed,
        toolVersion: '12.0.1',
        exitCode: 101,
        candidateCount: 2,
        snapshotSkippedCount: 1,
        mode: GalleryDuplicateMode.exact,
      ),
    );
    final session = await mountSearch(
      tester,
      MockClient((request) async => duplicateResponse(request, job)),
      compact: true,
    );
    expect(
      find.text('Czkawka CLI reported an error. Check the exit code and the backend log for this job.'),
      findsOneWidget,
    );
    for (final detail in [
      'Czkawka CLI version: 12.0.1',
      'Exit code: 101',
      'Candidates prepared: 2',
      'Matching files: 0',
      'Files skipped while preparing candidates: 1',
      'Stage: Running Czkawka CLI',
      'Search mode: Exact copies',
      'Error code: processingFailed',
    ]) {
      expect(find.text(detail), findsOneWidget, reason: detail);
    }
    expect(find.text('No matches found'), findsNothing);
    expect(tester.takeException(), isNull);
    await closeSearch(tester, session);
  });

  testWidgets('empty completed result distinguishes prepared and rejected counts without exposing raw diagnostics', (
    tester,
  ) async {
    const secret = 'https://frame.local/cache/AUTH-SECRET/get/private-photo.jpg';
    const job = GalleryDuplicateJob(
      jobId: secret,
      status: GalleryDuplicateStatus.completed,
      diagnostics: GalleryDuplicateDiagnostics(
        stage: GalleryDuplicateStage.validation,
        toolVersion: secret,
        candidateCount: 2,
        rejectedResultCount: 2,
        rootAliased: true,
      ),
    );
    var current = job;
    final session = await mountSearch(
      tester,
      MockClient((request) async {
        final segments = request.url.pathSegments;
        if (segments.contains('metadata')) {
          return http.Response(jsonEncode(photoMetadata(segments[segments.length - 2]).toJson()), 200);
        }
        return duplicateResponse(request, current);
      }),
    );
    expect(find.text('No matches found'), findsOneWidget);
    for (final detail in [
      'Candidates prepared: 2',
      'Matching files: 0',
      'Report entries rejected: 2',
      'Files skipped while preparing candidates: 0',
    ]) {
      expect(find.text(detail), findsOneWidget, reason: detail);
    }
    final digest = sha256.convert(utf8.encode(secret)).toString().substring(0, 12);
    expect(find.text('Job: id-$digest'), findsOneWidget);
    expect(find.textContaining('AUTH-SECRET'), findsNothing);
    expect(find.textContaining('private-photo.jpg'), findsNothing);
    expect(find.textContaining('Czkawka CLI version:'), findsNothing);
    expect(find.textContaining('Stage:'), findsNothing, reason: 'A completed report is not a live stage indicator');
    current = job.copyWith(
      groups: [
        GalleryDuplicateGroup(
          groupId: 'exact',
          mode: GalleryDuplicateMode.exact,
          items: [
            for (final id in ['a', 'b'])
              GalleryDuplicateMember(
                section: GalleryMediaSection.published,
                mediaId: id,
                sourceRevision: '1',
                path: '$id.jpg',
                name: '$id.jpg',
                sizeBytes: 100,
              ),
          ],
        ),
      ],
      diagnostics: job.diagnostics!.copyWith(matchedFileCount: 2, rejectedResultCount: 0, snapshotSkippedCount: 1),
    );
    final bloc = tester
        .element(find.byKey(const ValueKey('gallery-duplicate-diagnostics')))
        .read<GalleryDuplicatesBloc>();
    bloc.add(const GalleryDuplicatesEvent.load());
    await tester.pump();
    await tester.pump();
    expect(find.text('No matches found'), findsNothing);
    expect(find.text('Matching files: 2'), findsNothing);
    await tester.scrollUntilVisible(
      find.text('About the last search'),
      200,
      scrollable: find.byType(Scrollable).first,
      maxScrolls: 10,
    );
    await tester.tap(find.text('About the last search'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 250));
    expect(find.text('Matching files: 2'), findsOneWidget);
    expect(find.text('Files skipped while preparing candidates: 1'), findsOneWidget);
    final second = find.text('b.jpg');
    await tester.scrollUntilVisible(second, -150, scrollable: find.byType(Scrollable).first, maxScrolls: 10);
    expect(second, findsOneWidget);
    expect(
      find.descendant(
        of: find.ancestor(of: second, matching: find.byType(Card)),
        matching: find.widgetWithText(CheckboxListTile, 'Move to trash'),
      ),
      findsOneWidget,
    );
    await closeSearch(tester, session);
  });

  testWidgets('transport failure keeps its typed code and status retry clears it without claiming a CLI failure', (
    tester,
  ) async {
    var calls = 0;
    final recovery = Completer<http.Response>();
    final session = await mountSearch(
      tester,
      MockClient((_) async {
        if (++calls == 1) {
          return http.Response(jsonEncode(const GalleryErrorResponse(GalleryErrorCode.unavailable).toJson()), 503);
        }
        return recovery.future;
      }),
    );
    final card = find.byKey(const ValueKey('gallery-duplicate-diagnostics'));
    final bloc = tester.element(card).read<GalleryDuplicatesBloc>();
    expect(bloc.state.requestError, GalleryErrorCode.unavailable);
    expect(
      find.text('Could not get the search status from the backend. Check the connection and retry.'),
      findsOneWidget,
    );
    expect(find.text('The service is unavailable'), findsOneWidget);
    expect(find.textContaining('Search failed.'), findsNothing);
    await tester.tap(find.text('Retry'));
    await tester.pump();
    expect(bloc.state.requestError, GalleryErrorCode.unavailable);
    expect(card, findsOneWidget, reason: 'Keep the last error visible until status recovery is confirmed');
    recovery.complete(
      http.Response(
        jsonEncode(const GalleryDuplicateJob(jobId: '', status: GalleryDuplicateStatus.idle).toJson()),
        200,
      ),
    );
    await tester.pump();
    await tester.pump();
    expect(calls, 2);
    expect(bloc.state.requestError, isNull);
    expect(card, findsNothing);
    expect(tester.takeException(), isNull);
    await closeSearch(tester, session);
  });
}
