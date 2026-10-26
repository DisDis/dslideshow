import 'dart:async';

import 'package:config_app/features/gallery/presentation/pages/single_item_viewer_page.dart';
import 'package:config_app/features/gallery/presentation/widgets/gallery_widget.dart';
import 'package:config_app/src/gallery/gallery_repository.dart';
import 'package:config_app/src/gallery/gallery_session.dart';
import 'package:config_app/src/gallery/media_image_loader.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'gallery_image_loader_test.dart' show ControlledClient;

void main() {
  for (final removed in [false, true]) {
    testWidgets(
      'fullscreen reads current snapshot after pre-mount refresh; removed=$removed',
      (tester) async {
        final client = ControlledClient();
        final loader = MediaImageLoader(client: client);
        final session = GallerySession(
          loader: loader,
          repository: GalleryRepository(
            baseUri: Uri.parse('http://localhost'),
            code: 'code',
            client: MockClient((_) async => http.Response('{}', 200)),
          ),
        );
        final updates = StreamController<GalleryItem?>.broadcast(sync: true);
        GalleryItem item(String revision) => GalleryItem(
          uri: Uri.parse('http://localhost/photo.jpg?rev=$revision'),
          title: 'photo',
          mediaId: 'stable',
          revision: revision,
        );
        GalleryItem? snapshot = item('old');
        final page = SingleItemViewerPage(
          item: snapshot,
          session: session,
          itemUpdates: updates.stream,
          currentItem: () => snapshot,
        );
        // Broadcast notification occurs while no route listener exists yet.
        snapshot = removed ? null : item('new');
        updates.add(snapshot);
        await tester.pumpWidget(
          MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: page,
          ),
        );
        await tester.pump();
        if (removed) {
          expect(client.requests, isEmpty);
        } else {
          expect(
            client.requests.single.request.url.queryParameters['rev'],
            'new',
          );
        }
        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump();
        await updates.close();
        await tester.runAsync(session.close);
        expect(tester.takeException(), isNull);
      },
    );
  }

  testWidgets(
    'catalog recovery replaces fullscreen revision and deletion cancels old work',
    (tester) async {
      final client = ControlledClient();
      final loader = MediaImageLoader(client: client);
      final session = GallerySession(
        loader: loader,
        repository: GalleryRepository(
          baseUri: Uri.parse('http://localhost'),
          code: 'code',
          client: MockClient((_) async => http.Response('{}', 200)),
        ),
      );
      final updates = StreamController<GalleryItem?>.broadcast(sync: true);
      GalleryItem item(String revision) => GalleryItem(
        uri: Uri.parse('http://localhost/photo.jpg?rev=$revision'),
        title: 'photo',
        mediaId: 'stable',
        revision: revision,
      );
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SingleItemViewerPage(
            item: item('old'),
            session: session,
            itemUpdates: updates.stream,
          ),
        ),
      );
      await tester.pump();
      expect(client.requests.single.request.url.queryParameters['rev'], 'old');
      updates.add(item('new'));
      await tester.pump();
      await tester.pump();
      expect(client.requests.first.aborted, isTrue);
      expect(client.requests.last.request.url.queryParameters['rev'], 'new');
      updates.add(null);
      await tester.pump();
      await tester.pump();
      expect(client.requests.last.aborted, isTrue);
      expect(loader.pendingCount, 0);
      await tester.pumpWidget(const SizedBox.shrink());
      await updates.close();
      await tester.runAsync(session.close);
      expect(tester.takeException(), isNull);
    },
  );
}
