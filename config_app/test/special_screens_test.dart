import 'package:config_app/features/config/presentation/pages/special_screens_page.dart';
import 'package:config_app/features/config/presentation/pages/special_screen_editor_page.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/sessions/special_screen_session.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/special_screen_renderers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget app(Widget home, {Locale? locale}) => MaterialApp(
  locale: locale,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: home,
);

void main() {
  testWidgets(
    'Check camera validates visible raw URL instead of requesting last valid URL',
    (tester) async {
      var sessions = 0;
      final original =
          SpecialScreenRenderers.definitions[SpecialScreenType.cameras]!;
      SpecialScreenRenderers.definitions[SpecialScreenType.cameras] =
          SpecialScreenRenderer((config, _) {
            sessions++;
            return _UnavailableSession(config);
          }, (_) => const SizedBox());
      addTearDown(
        () => SpecialScreenRenderers.definitions[SpecialScreenType.cameras] =
            original,
      );
      final config = SpecialScreenConfig(
        id: 'cam',
        type: SpecialScreenType.cameras,
        options: CamerasScreenOptions(
          cameras: [
            CameraConfig(id: 'a', url: 'https://camera.test/snapshot.jpg'),
          ],
        ),
      );
      await tester.pumpWidget(app(SpecialScreenEditorPage(config: config)));
      await tester.pumpAndSettle();
      expect(sessions, 1);
      await tester.tap(find.byKey(const ValueKey('preview-toggle')));
      await tester.pumpAndSettle();
      final url = find.widgetWithText(
        TextFormField,
        'Snapshot URL (HTTP/HTTPS, JPEG/PNG)',
      );
      await tester.ensureVisible(url);
      await tester.enterText(url, 'bad-url');
      await tester.pump();
      final check = find.text('Check snapshot');
      await tester.ensureVisible(check);
      await tester.tap(check);
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsNothing);
      expect(find.text('Enter an HTTP/HTTPS URL.'), findsOneWidget);
      expect(sessions, 1);
      expect(
        (config.options as CamerasScreenOptions).cameras.single.url,
        'https://camera.test/snapshot.jpg',
      );
      await tester.pumpWidget(const SizedBox());
      expect(tester.takeException(), isNull);
    },
  );
  testWidgets(
    'changing locale preserves incomplete numeric special-screen input',
    (tester) async {
      final checks = <ValueGetter<bool>>{};
      final config = SpecialScreenConfig(
        id: 'clock',
        type: SpecialScreenType.clock,
      );
      final editor = SpecialScreenEditorPage(
        config: config,
        registerDraft: (check) {
          checks.add(check);
          return () => checks.remove(check);
        },
      );
      await tester.pumpWidget(app(editor, locale: const Locale('en')));
      await tester.pumpAndSettle();
      final duration = find.widgetWithText(
        TextFormField,
        'Display duration (seconds)',
      );
      await tester.ensureVisible(duration);
      await tester.enterText(duration, '-');
      await tester.pump();
      final fieldKey = tester.widget<TextFormField>(duration).key;
      final field = find.byWidgetPredicate(
        (widget) => widget is TextFormField && widget.key == fieldKey,
      );
      final state = tester.state<FormFieldState<String>>(field);
      expect(state.value, '-');
      expect(checks.single(), isTrue);
      await tester.pumpWidget(app(editor, locale: const Locale('ru')));
      await tester.pumpAndSettle();
      expect(tester.state<FormFieldState<String>>(field), same(state));
      expect(state.value, '-');
      expect(checks.single(), isTrue);
      expect(find.byKey(const ValueKey('preview-last-valid')), findsOneWidget);
      expect(config.displayTimeMs, 10000);
      await tester.pumpWidget(const SizedBox());
      expect(checks, isEmpty);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'conditional date fields and locale preserve incomplete time-size and color input',
    (tester) async {
      final checks = <ValueGetter<bool>>{};
      final config = SpecialScreenConfig(
        id: 'clock',
        type: SpecialScreenType.clock,
      );
      final editor = SpecialScreenEditorPage(
        config: config,
        registerDraft: (check) {
          checks.add(check);
          return () => checks.remove(check);
        },
      );
      await tester.pumpWidget(app(editor, locale: const Locale('en')));
      await tester.pumpAndSettle();
      final timeSize = find.widgetWithText(
        TextFormField,
        'Time font (% of shorter screen side)',
      );
      await tester.ensureVisible(timeSize);
      await tester.enterText(timeSize, 'bad');
      await tester.pump();
      final timeKey = tester.widget<TextFormField>(timeSize).key;
      final timeField = find.byWidgetPredicate(
        (widget) => widget is TextFormField && widget.key == timeKey,
      );
      final timeState = tester.state<FormFieldState<String>>(timeField);
      final color = find.widgetWithText(TextFormField, 'Text color (AARRGGBB)');
      await tester.ensureVisible(color);
      await tester.enterText(color, 'ff00');
      await tester.pump();
      final fieldKey = tester.widget<TextFormField>(color).key;
      final field = find.byWidgetPredicate(
        (widget) => widget is TextFormField && widget.key == fieldKey,
      );
      final state = tester.state<FormFieldState<String>>(field);
      final showDate = find.widgetWithText(SwitchListTile, 'Show date');
      await tester.ensureVisible(showDate);
      await tester.tap(showDate);
      await tester.pumpAndSettle();
      expect(tester.state<FormFieldState<String>>(field), same(state));
      expect(state.value, 'ff00');
      expect(tester.state<FormFieldState<String>>(timeField), same(timeState));
      expect(timeState.value, 'bad');
      await tester.tap(showDate);
      await tester.pumpAndSettle();
      expect(tester.state<FormFieldState<String>>(field), same(state));
      await tester.pumpWidget(app(editor, locale: const Locale('ru')));
      await tester.pumpAndSettle();
      expect(tester.state<FormFieldState<String>>(field), same(state));
      expect(state.value, 'ff00');
      expect(tester.state<FormFieldState<String>>(timeField), same(timeState));
      expect(timeState.value, 'bad');
      expect(checks.single(), isTrue);
      expect(find.byKey(const ValueKey('preview-last-valid')), findsOneWidget);
      await tester.pumpWidget(const SizedBox());
      expect(checks, isEmpty);
      expect(tester.takeException(), isNull);
    },
  );
  testWidgets(
    'local draft registration follows Done, Cancel, Back and disposal',
    (tester) async {
      final config = SlideShowConfig.fromJson({});
      config.specialScreens.add(
        SpecialScreenConfig(
          id: 'clock',
          type: SpecialScreenType.clock,
          name: 'Original',
        ),
      );
      final checks = <ValueGetter<bool>>{};
      await tester.pumpWidget(
        app(
          SpecialScreensPage(
            config: config,
            registerDraft: (hasChanges) {
              checks.add(hasChanges);
              return () => checks.remove(hasChanges);
            },
          ),
        ),
      );

      Future<void> open() async {
        await tester.tap(find.text(config.specialScreens.single.name));
        await tester.pumpAndSettle();
        expect(checks, hasLength(1));
        expect(checks.single(), isFalse);
      }

      await open();
      final name = find.widgetWithText(TextFormField, 'Name').first;
      await tester.ensureVisible(name);
      await tester.enterText(name, 'Changed');
      expect(checks.single(), isTrue);
      await tester.enterText(name, 'Original');
      expect(checks.single(), isFalse);
      final duration = find.widgetWithText(
        TextFormField,
        'Display duration (seconds)',
      );
      await tester.ensureVisible(duration);
      await tester.enterText(duration, '');
      expect(checks.single(), isTrue);
      await tester.enterText(duration, '10.0');
      expect(checks.single(), isFalse);
      await tester.enterText(duration, '-1');
      expect(checks.single(), isTrue);
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(checks, isEmpty);
      expect(config.specialScreens.single.displayTimeMs, 10000);

      await open();
      await tester.ensureVisible(name);
      await tester.enterText(name, 'Done clock');
      await tester.tap(find.text('Done'));
      await tester.pumpAndSettle();
      expect(checks, isEmpty);
      expect(config.specialScreens.single.name, 'Done clock');

      await open();
      await tester.ensureVisible(name);
      await tester.enterText(name, 'Back discards this');
      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(checks, isEmpty);
      expect(find.byType(AlertDialog), findsNothing);
      expect(config.specialScreens.single.name, 'Done clock');

      await open();
      await tester.ensureVisible(name);
      await tester.enterText(name, 'Disposed clock');
      expect(checks.single(), isTrue);
      await tester.pumpWidget(const SizedBox.shrink());
      expect(checks, isEmpty);
      expect(tester.takeException(), isNull);
    },
  );

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

class _UnavailableSession extends SpecialScreenSession {
  _UnavailableSession(super.config);
  @override
  Future<bool> prepare() async => false;
}
