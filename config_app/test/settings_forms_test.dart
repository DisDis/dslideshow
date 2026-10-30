import 'package:config_app/features/config/domain/config_draft.dart';
import 'package:config_app/features/config/presentation/pages/storage_settings_page.dart';
import 'package:config_app/features/config/presentation/pages/webserver_editor.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _app(Widget child) => MaterialApp(
  locale: const Locale('en'),
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: child,
);

Finder _field(String label) => find.widgetWithText(TextFormField, label);

Future<void> _enter(WidgetTester tester, String label, String text) async {
  await tester.ensureVisible(_field(label));
  await tester.enterText(_field(label), text);
  await tester.pump();
}

Future<void> _provider(WidgetTester tester, String name) async {
  await tester.ensureVisible(find.byType(DropdownButtonFormField<StorageType>));
  await tester.tap(find.byType(DropdownButtonFormField<StorageType>));
  await tester.pumpAndSettle();
  await tester.tap(find.text(name).last);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('storage selection and edits belong to the shared draft', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(1000, 1600);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    final saved = AppConfig.fromJson({});
    final draft = ConfigDraft()..replaceSaved(saved);
    final config = draft.value!.storages;
    await tester.pumpWidget(_app(StorageSettingsPage(config: config)));
    expect(
      find.text('No configuration needed for local disk yet.'),
      findsOneWidget,
    );
    expect(draft.hasChanges, isFalse);

    await _provider(tester, 'Google Photos');
    final google = config.getOrCreateEmpty(
      StorageType.GPhotoStorage,
    ) as GPhotoStorageConfig;
    await _enter(tester, 'Refresh token', 'private-refresh');
    await _enter(tester, 'Client ID', 'client-identifier');
    await _enter(tester, 'Client secret', 'private-secret');
    await _enter(tester, 'Sync period', '12');
    await _enter(tester, 'Image width', '2400');
    await _enter(tester, 'Image height', '1600');
    await _enter(
      tester,
      'Album names, separated by commas',
      ' First, , Second , Third, ',
    );
    expect(google.refreshToken, 'private-refresh');
    expect(google.clientId.identifier, 'client-identifier');
    expect(google.clientId.secret, 'private-secret');
    expect(google.syncPeriod, const Duration(minutes: 12));
    expect((google.imageWidth, google.imageHeight), (2400, 1600));
    expect(google.albumNames, ['First', 'Second', 'Third']);
    await _enter(tester, 'Album names, separated by commas', 'Second');
    expect(google.albumNames, ['Second']);
    expect(draft.hasChanges, isTrue);
    expect(saved.storages.selected, StorageType.DiskStorage);

    await _provider(tester, 'Local disk');
    await _provider(tester, 'Google Photos');
    final text = tester.widget<EditableText>(
      find.descendant(
        of: _field('Refresh token'),
        matching: find.byType(EditableText),
      ),
    );
    expect(text.controller.text, 'private-refresh');
    expect(
      identical(config.getOrCreateEmpty(StorageType.GPhotoStorage), google),
      isTrue,
    );
    await tester.pumpWidget(const SizedBox.shrink());
    draft.discard();
    expect(draft.value!.storages.selected, StorageType.DiskStorage);
    expect(draft.hasChanges, isFalse);
  });

  testWidgets(
    'invalid storage numbers keep the last valid draft and guard registration',
    (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(1000, 1600);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetPhysicalSize);
      final config = AppConfig.fromJson({}).storages
        ..selected = StorageType.GPhotoStorage;
      final google = config.getOrCreateEmpty(
        StorageType.GPhotoStorage,
      ) as GPhotoStorageConfig;
      final checks = <ValueGetter<bool>>{};
      await tester.pumpWidget(
        _app(
          StorageSettingsPage(
            config: config,
            registerDraft: (check) {
              checks.add(check);
              return () => checks.remove(check);
            },
          ),
        ),
      );
      await _enter(tester, 'Sync period', '7');
      await _enter(tester, 'Sync period', '0');
      expect(google.syncPeriod, const Duration(minutes: 7));
      expect(find.text('Enter a positive whole number.'), findsOneWidget);
      expect(checks.single(), isTrue);
      await _enter(tester, 'Sync period', '8');
      expect(google.syncPeriod, const Duration(minutes: 8));
      expect(checks.single(), isFalse);
      final width = google.imageWidth;
      await _enter(tester, 'Image width', '-1');
      expect(google.imageWidth, width);
      expect(checks.single(), isTrue);
      await tester.pumpWidget(const SizedBox.shrink());
      expect(checks, isEmpty);
    },
  );

  testWidgets(
    'web server validates port boundaries and preserves draft and text on rebuild',
    (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(1000, 1000);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetPhysicalSize);
      final saved = AppConfig.fromJson({});
      final draft = ConfigDraft()..replaceSaved(saved);
      final config = draft.value!.webServer;
      final checks = <ValueGetter<bool>>{};
      Widget page() => _app(
        WebServerEditorPage(
          config: config,
          registerDraft: (check) {
            checks.add(check);
            return () => checks.remove(check);
          },
        ),
      );
      await tester.pumpWidget(page());
      await _enter(tester, 'Port', '1');
      expect(config.port, 1);
      for (final invalid in ['', '0', '65536', 'bad']) {
        await _enter(tester, 'Port', invalid);
        expect(config.port, 1);
        expect(find.text('Enter a port from 1 to 65535.'), findsOneWidget);
        expect(checks.single(), isTrue);
      }
      await _enter(tester, 'Port', '65535');
      expect(config.port, 65535);
      expect(checks.single(), isFalse);
      await _enter(tester, 'Permanent access code', ' leading 000 code ');
      await tester.tap(find.byType(Switch));
      await tester.pump();
      expect(config.alwaysEnabled, !saved.webServer.alwaysEnabled);
      await tester.pumpWidget(page());
      final code = tester.widget<EditableText>(
        find.descendant(
          of: _field('Permanent access code'),
          matching: find.byType(EditableText),
        ),
      );
      expect(code.controller.text, ' leading 000 code ');
      expect(config.permanentCode, ' leading 000 code ');
      expect(code.obscureText, isTrue);
      expect(draft.hasChanges, isTrue);
      expect(saved.webServer.port, isNot(65535));
      expect(saved.webServer.permanentCode, isNot(config.permanentCode));
      await tester.pumpWidget(const SizedBox.shrink());
      expect(checks, isEmpty);
      draft.discard();
      expect(draft.hasChanges, isFalse);
      expect(draft.value!.webServer.toJson(), saved.webServer.toJson());
    },
  );
}
