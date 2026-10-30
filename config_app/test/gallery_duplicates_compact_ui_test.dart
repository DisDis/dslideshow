import 'dart:convert';

import 'package:config_app/features/gallery/presentation/bloc/gallery_duplicates_bloc.dart';
import 'package:config_app/features/gallery/presentation/widgets/gallery_duplicate_search_dialog.dart';
import 'package:config_app/src/gallery/gallery_image_widget.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:logging/logging.dart';

import 'support/gallery_duplicates_harness.dart';
import 'support/gallery_management_harness.dart';
import 'gallery_image_loader_test.dart' show ControlledClient;

const _members = [
  GalleryDuplicateMember(
    mediaId: 'a',
    sourceRevision: '1',
    path: 'album/a.jpg',
    name: 'a.jpg',
    sizeBytes: 2500000,
    width: 6000,
    height: 4000,
  ),
  GalleryDuplicateMember(
    mediaId: 'b',
    sourceRevision: '1',
    path: 'album/b.jpg',
    name: 'b.jpg',
    sizeBytes: 1250000,
    width: 1600,
    height: 1000,
  ),
];
const _job = GalleryDuplicateJob(
  jobId: 'original',
  status: GalleryDuplicateStatus.completed,
  modes: [GalleryDuplicateMode.similar],
  groups: [
    GalleryDuplicateGroup(
      groupId: 'first',
      mode: GalleryDuplicateMode.similar,
      items: _members,
    ),
    GalleryDuplicateGroup(
      groupId: 'second',
      mode: GalleryDuplicateMode.exact,
      items: _members,
    ),
  ],
);

Finder _choice(String filename) => find.descendant(
  of: find.ancestor(of: find.text(filename), matching: find.byType(Card)),
  matching: find.byType(CheckboxListTile),
);
Future<void> _openSearch(WidgetTester tester) async {
  await tester.tap(find.widgetWithText(OutlinedButton, 'New search'));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 250));
}

Future<void> _cancel(WidgetTester tester) async {
  await tester.tap(
    find.descendant(
      of: find.byType(AlertDialog),
      matching: find.text('Cancel'),
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 250));
}

void main() {
  testWidgets(
    'opening and closing a larger photo preserves the card and shares its pending image request',
    (tester) async {
      final images = ControlledClient();
      final session = await mountSearch(
        tester,
        MockClient((request) async {
          if (request.url.pathSegments.contains('metadata')) {
            return http.Response(
              jsonEncode(photoMetadata(request.url.pathSegments[4]).toJson()),
              200,
            );
          }
          return duplicateResponse(request, _job);
        }),
        images: images,
      );
      final first = find.byType(GalleryImage).first;
      final originalState = tester.state(first);
      final bloc = tester.element(first).read<GalleryDuplicatesBloc>();
      final key = tester.widget<GalleryImage>(first).request.key;
      await Scrollable.ensureVisible(
        tester.element(find.text('Open photo').first),
        alignment: .5,
      );
      await tester.pump();
      final requestCount = images.requests.length;
      final activeRequests = images.requests
          .where((r) => !r.done && !r.aborted)
          .toList();
      await tester.tap(find.text('Open photo').first);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 250));
      expect(find.byType(Dialog), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(Dialog),
          matching: find.byType(InteractiveViewer),
        ),
        findsOneWidget,
      );
      expect(images.requests.length, requestCount);
      await tester.tap(
        find.descendant(
          of: find.byType(Dialog),
          matching: find.byTooltip('Close'),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 250));
      expect(find.byType(Dialog), findsNothing);
      final restored = find.byWidgetPredicate(
        (w) => w is GalleryImage && w.request.key == key,
      );
      expect(tester.state(restored), same(originalState));
      expect(activeRequests.every((r) => !r.aborted), isTrue);
      await tester.tap(find.text('Open photo').first);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 250));
      await tester.runAsync(bloc.close);
      for (final pending in images.requests.where(
        (r) => !r.done && !r.aborted,
      )) {
        pending.respond(status: 409);
        pending.complete(const []);
      }
      await tester.pump();
      await tester.pump();
      expect(
        tester.takeException(),
        isNull,
        reason: 'A late image mismatch must not dispatch to a closed workflow.',
      );
      await closeSearch(tester, session);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'compact header, explicit choices and fixed totals keep unique selections across next and previous groups',
    (tester) async {
      final groups = <int>[], posts = <http.Request>[];
      final session = await mountSearch(
        tester,
        MockClient((request) async {
          if (request.method == 'POST') posts.add(request);
          if (request.url.pathSegments.contains('metadata')) {
            return http.Response(
              jsonEncode(photoMetadata(request.url.pathSegments[4]).toJson()),
              200,
            );
          }
          if (request.url.pathSegments.contains('groups')) {
            groups.add(int.parse(request.url.pathSegments.last));
          }
          return duplicateResponse(request, _job);
        }),
      );
      expect(find.text('2 groups · Search completed'), findsOneWidget);
      expect(find.text('Group 1 of 2'), findsOneWidget);
      expect(
        find.text(
          'Select files to move to trash. Keep at least one file in the group.',
        ),
        findsNothing,
      );
      await tester.scrollUntilVisible(
        _choice('b.jpg'),
        180,
        scrollable: find.byType(Scrollable).first,
        maxScrolls: 10,
      );
      await tester.tap(_choice('b.jpg'));
      await tester.pump();
      final footer = find.byKey(const ValueKey('gallery-duplicate-selection'));
      expect(
        find.descendant(of: footer, matching: find.text('1 selected')),
        findsOneWidget,
      );
      expect(
        find.descendant(of: footer, matching: find.text('Volume: 1.25 MB')),
        findsOneWidget,
      );
      expect(
        tester.getRect(footer).bottom,
        lessThanOrEqualTo(tester.view.physicalSize.height),
      );
      await tester.scrollUntilVisible(
        find.text('Next group'),
        -180,
        scrollable: find.byType(Scrollable).first,
        maxScrolls: 10,
      );
      await tester.tap(find.text('Next group'));
      await tester.pump();
      await tester.pump();
      expect(find.text('Group 2 of 2'), findsOneWidget);
      await tester.scrollUntilVisible(
        _choice('b.jpg'),
        180,
        scrollable: find.byType(Scrollable).first,
        maxScrolls: 10,
      );
      expect(tester.widget<CheckboxListTile>(_choice('b.jpg')).value, isTrue);
      expect(
        find.text('Volume: 1.25 MB'),
        findsOneWidget,
        reason: 'The same file in overlapping groups is counted once.',
      );
      await tester.scrollUntilVisible(
        find.byTooltip('Previous group'),
        -180,
        scrollable: find.byType(Scrollable).first,
        maxScrolls: 10,
      );
      await tester.tap(find.byTooltip('Previous group'));
      await tester.pump();
      await tester.pump();
      expect(find.text('Group 1 of 2'), findsOneWidget);
      await tester.scrollUntilVisible(
        _choice('b.jpg'),
        180,
        scrollable: find.byType(Scrollable).first,
        maxScrolls: 10,
      );
      expect(tester.widget<CheckboxListTile>(_choice('b.jpg')).value, isTrue);
      await tester.tap(find.text('Clear selection'));
      await tester.pump();
      expect(find.text('0 selected'), findsOneWidget);
      expect(find.text('Volume: 0.00 MB'), findsOneWidget);
      expect(
        tester
            .widget<FilledButton>(
              find.widgetWithText(FilledButton, 'Move to trash'),
            )
            .onPressed,
        isNull,
      );
      expect(groups, [0, 1, 0]);
      expect(posts, isEmpty);
      await closeSearch(tester, session);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'search draft cancels without replacing cards or selection; confirmed mode is remembered after a failed search',
    (tester) async {
      final starts = <GalleryDuplicateStartRequest>[];
      var current = _job;
      final logs = <String>[];
      final oldLevel = Logger.root.level;
      Logger.root.level = Level.ALL;
      final subscription = Logger.root.onRecord.listen(
        (record) => logs.add(record.message),
      );
      addTearDown(() async {
        await subscription.cancel();
        Logger.root.level = oldLevel;
      });
      final session = await mountSearch(
        tester,
        MockClient((request) async {
          if (request.url.pathSegments.contains('metadata')) {
            return http.Response(
              jsonEncode(photoMetadata(request.url.pathSegments[4]).toJson()),
              200,
            );
          }
          if (request.method == 'POST') {
            final start = GalleryDuplicateStartRequest.fromJson(
              jsonDecode(request.body) as Map<String, dynamic>,
            );
            starts.add(start);
            current = _job.copyWith(
              jobId: start.operationId,
              modes: start.modes,
              status: GalleryDuplicateStatus.failed,
              error: GalleryErrorCode.unavailable,
            );
          }
          return duplicateResponse(request, current);
        }),
      );
      await tester.scrollUntilVisible(
        _choice('b.jpg'),
        180,
        scrollable: find.byType(Scrollable).first,
        maxScrolls: 10,
      );
      await tester.tap(_choice('b.jpg'));
      await tester.pump();
      final imageStates = {
        for (final element in find.byType(GalleryImage).evaluate())
          (element.widget as GalleryImage).request.key:
              (element as StatefulElement).state,
      };
      await _openSearch(tester);
      RadioListTile<GalleryDuplicateSearchChoice> radio(
        GalleryDuplicateSearchChoice mode,
      ) => tester.widget<RadioListTile<GalleryDuplicateSearchChoice>>(
        find.byWidgetPredicate(
          (w) =>
              w is RadioListTile<GalleryDuplicateSearchChoice> &&
              w.value == mode,
        ),
      );
      expect(radio(GalleryDuplicateSearchChoice.similar).selected, isTrue);
      await tester.tap(
        find.descendant(
          of: find.byType(AlertDialog),
          matching: find.text('Exact copies'),
        ),
      );
      await tester.pump();
      await _cancel(tester);
      expect(starts, isEmpty);
      expect(find.text('1 selected'), findsOneWidget);
      for (final element in find.byType(GalleryImage).evaluate()) {
        expect(
          (element as StatefulElement).state,
          same(imageStates[(element.widget as GalleryImage).request.key]),
        );
      }
      await _openSearch(tester);
      expect(radio(GalleryDuplicateSearchChoice.similar).selected, isTrue);
      await tester.tap(find.text('Exact and similar'));
      await tester.pump();
      await tester.tap(
        find.descendant(
          of: find.byType(AlertDialog),
          matching: find.widgetWithText(FilledButton, 'Start search'),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 250));
      await tester.pump();
      expect(starts.single.modes.toSet(), GalleryDuplicateMode.values.toSet());
      expect(find.text('1 selected'), findsOneWidget);
      await _openSearch(tester);
      expect(radio(GalleryDuplicateSearchChoice.both).selected, isTrue);
      await _cancel(tester);
      expect(logs.any((m) => m.contains('searchOptionsCancelled')), isTrue);
      expect(
        logs.any(
          (m) =>
              m.contains('jobStartRequested') &&
              m.contains('modes=exact,similar'),
        ),
        isTrue,
      );
      expect(
        logs.any(
          (m) =>
              m.contains('previousSelectionRestored') &&
              m.contains('selected=1'),
        ),
        isTrue,
      );
      expect(logs.join(), isNot(contains('album/')));
      await closeSearch(tester, session);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'search dialog fits EN 320px with enlarged text and keeps all three modes and actions reachable',
    (tester) async {
      final session = await mountSearch(
        tester,
        MockClient(
          (request) async => duplicateResponse(
            request,
            const GalleryDuplicateJob(
              jobId: '',
              status: GalleryDuplicateStatus.idle,
            ),
          ),
        ),
        compact: true,
      );
      await _openSearch(tester);
      for (final label in [
        'Exact copies',
        'Similar photos',
        'Exact and similar',
      ]) {
        await tester.ensureVisible(
          find.descendant(
            of: find.byType(AlertDialog),
            matching: find.text(label),
          ),
        );
        await tester.tap(
          find.descendant(
            of: find.byType(AlertDialog),
            matching: find.text(label),
          ),
        );
        await tester.pump();
      }
      final cancel = find.descendant(
        of: find.byType(AlertDialog),
        matching: find.text('Cancel'),
      );
      final start = find.descendant(
        of: find.byType(AlertDialog),
        matching: find.text('Start search'),
      );
      for (final button in [cancel, start]) {
        final rect = tester.getRect(button);
        expect(rect.left, greaterThanOrEqualTo(0));
        expect(rect.right, lessThanOrEqualTo(320));
        expect(rect.top, greaterThanOrEqualTo(0));
        expect(rect.bottom, lessThanOrEqualTo(720));
      }
      await _cancel(tester);
      await closeSearch(tester, session);
      expect(tester.takeException(), isNull);
    },
  );
}
