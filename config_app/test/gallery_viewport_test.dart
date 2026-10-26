import 'package:config_app/features/gallery/presentation/widgets/gallery_widget.dart';
import 'package:config_app/features/gallery/presentation/widgets/image_grid_item.dart';
import 'package:config_app/src/gallery/gallery_repository.dart';
import 'package:config_app/src/gallery/gallery_session.dart';
import 'package:config_app/src/gallery/media_image_loader.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'gallery_image_loader_test.dart' show ControlledClient;

void main() {
  testWidgets(
    'sliver viewport bounds demand through fling/reverse/resize/fullscreen/dispose',
    (tester) async {
      final client = ControlledClient();
      final loader = MediaImageLoader(
        client: client,
        maxActive: 2,
        maxPrefetch: 1,
      );
      final session = GallerySession(
        loader: loader,
        repository: GalleryRepository(
          baseUri: Uri.parse('http://localhost'),
          code: 'code',
        ),
      );
      final scroll = ScrollController();
      final items = List.generate(
        1000,
        (index) => GalleryItem(
          uri: Uri.parse('http://localhost/original-$index.jpg'),
          title: '$index',
          mediaId: '$index',
          thumbnailBaseUri: Uri.parse('http://localhost/thumbnail-$index'),
          thumbnailPolicy: const GalleryThumbnailPolicy(
            version: 1,
            sizes: [GalleryThumbnailSize.small],
          ),
          thumbnailsEnabled: true,
        ),
      );
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (context) => Scaffold(
              body: CustomScrollView(
                controller: scroll,
                slivers: [
                  const SliverAppBar(title: Text('gallery'), pinned: true),
                  SliverPadding(
                    padding: const EdgeInsets.all(8),
                    sliver: MediaGallerySliverGrid(
                      items: items,
                      selectedIds: const {},
                      onToggleSelect: (_) {},
                      session: session,
                      active: ModalRoute.isCurrentOf(context) ?? true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(loader.activeCount, 2);
      expect(loader.pendingCount, lessThan(30));
      scroll.jumpTo(20000);
      await tester.pump();
      await tester.pump();
      expect(
        client.requests.take(2).every((request) => request.aborted),
        isTrue,
      );
      expect(loader.activeCount, lessThanOrEqualTo(2));
      expect(loader.pendingCount, lessThan(30));
      scroll.jumpTo(0);
      await tester.pump();
      await tester.pump();
      tester.view.physicalSize = const Size(400, 600);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pump();
      await tester.pump();
      expect(loader.pendingCount, lessThan(30));
      await tester.tap(find.byType(ImageGridItem).first);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      await tester.pump();
      expect(client.requests.last.request.url.path, '/original-0.jpg');
      expect(loader.activeCount, 1);
      tester.state<NavigatorState>(find.byType(Navigator)).pop();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
      await session.close();
      scroll.dispose();
      expect(loader.pendingCount, 0);
      expect(loader.activeCount, 0);
      expect(client.peak, lessThanOrEqualTo(2));
      expect(tester.takeException(), isNull);
    },
  );
}
