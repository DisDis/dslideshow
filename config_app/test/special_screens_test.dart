import 'package:config_app/features/config/presentation/pages/special_screens_page.dart';
import 'package:config_app/features/config/presentation/pages/special_screen_editor_page.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget app(Widget home) => MaterialApp(
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: home,
);

void main() {
  testWidgets('adding a clock edits a draft; Done adds it to the screen list', (
    tester,
  ) async {
    final config = SlideShowConfig.fromJson({});
    await tester.pumpWidget(app(SpecialScreensPage(config: config)));
    await tester.tap(find.text('Add screen'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Date and time'));
    await tester.pumpAndSettle();
    expect(config.specialScreens, isEmpty);
    final name = find.widgetWithText(TextFormField, 'Name').first;
    await tester.ensureVisible(name);
    await tester.enterText(name, 'Hall clock');
    await tester.tap(find.text('Done'));
    await tester.pumpAndSettle();
    expect(config.specialScreens, hasLength(1));
    expect(config.specialScreens.single.type, SpecialScreenType.clock);
    expect(config.specialScreens.single.name, 'Hall clock');
    expect(find.text('Hall clock'), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
  });
  testWidgets('cancel leaves existing clock settings untouched', (
    tester,
  ) async {
    final config = SlideShowConfig.fromJson({});
    config.specialScreens.add(
      SpecialScreenConfig(
        id: 'clock',
        type: SpecialScreenType.clock,
        name: 'Original',
      ),
    );
    await tester.pumpWidget(app(SpecialScreensPage(config: config)));
    await tester.tap(find.text('Original'));
    await tester.pumpAndSettle();
    final name = find.widgetWithText(TextFormField, 'Name').first;
    await tester.ensureVisible(name);
    await tester.enterText(name, 'Changed');
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(config.specialScreens.single.name, 'Original');
    expect(find.text('Original'), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
  });
  testWidgets('camera editor validates URLs and keeps camera options local', (
    tester,
  ) async {
    final config = SpecialScreenConfig(
      id: 'cam',
      type: SpecialScreenType.cameras,
      options: CamerasScreenOptions(
        cameras: [CameraConfig(id: 'a', url: 'rtsp://camera/live')],
      ),
    );
    await tester.pumpWidget(app(SpecialScreenEditorPage(config: config)));
    await tester.pumpAndSettle();
    final url = find.widgetWithText(
      TextFormField,
      'Snapshot URL (HTTP/HTTPS, JPEG/PNG)',
    );
    await tester.ensureVisible(url);
    await tester.enterText(url, 'bad-url');
    await tester.tap(find.text('Done'));
    await tester.pump();
    expect(find.text('Enter an HTTP/HTTPS URL.'), findsOneWidget);
    expect(
      (config.options as CamerasScreenOptions).cameras.single.url,
      'rtsp://camera/live',
    );
    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(seconds: 1));
    expect(tester.takeException(), isNull);
  });
  testWidgets('clock form fits a narrow screen without overflow', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      app(
        SpecialScreenEditorPage(
          config: SpecialScreenConfig(
            id: 'clock',
            type: SpecialScreenType.clock,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.pumpWidget(const SizedBox());
  });
}
