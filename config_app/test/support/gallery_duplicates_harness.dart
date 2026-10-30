import 'package:config_app/features/gallery/presentation/pages/gallery_duplicates_page.dart';
import 'package:config_app/features/theme/presentation/theme.dart';
import 'package:config_app/src/gallery/gallery_session.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import '../gallery_image_loader_test.dart' show ControlledClient;
import 'gallery_management_harness.dart';

Future<GallerySession> mountSearch(
  WidgetTester tester,
  http.Client client, {
  bool compact = false,
  http.Client? images,
}) async {
  if (compact) {
    tester.view.physicalSize = const Size(320, 720);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  }
  final catalog = ManagedCatalogRepository([
    managedPhoto('a'),
    managedPhoto('b'),
  ]);
  final session = managedSession(catalog, client, images ?? ControlledClient());
  addTearDown(() async {
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
    await tester.runAsync(session.close);
  });
  await tester.pumpWidget(
    MaterialApp(
      theme: createLightTheme(),
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: compact
          ? (context, child) => MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: TextScaler.linear(1.5)),
              child: child!,
            )
          : null,
      home: Scaffold(
        body: GalleryDuplicatesPage(
          session: session,
          catalog: catalog.items,
          onRefresh: () async {},
        ),
      ),
    ),
  );
  await tester.pump();
  await tester.pump();
  return session;
}

Future<void> closeSearch(WidgetTester tester, GallerySession session) async {
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pump();
  await tester.runAsync(session.close);
}
