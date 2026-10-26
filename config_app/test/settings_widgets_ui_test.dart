import 'package:config_app/features/config/presentation/pages/mqtt_editor_page.dart';
import 'package:config_app/features/config/presentation/wigdgets/settings_section.dart';
import 'package:config_app/features/theme/presentation/theme.dart';
import 'package:config_app/features/uikit/presentation/widgets/config_app_scaffold.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _app(Widget child, {Locale locale = const Locale('en')}) => MaterialApp(
  locale: locale,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  theme: createDarkTheme(),
  home: child,
);

void main() {
  testWidgets('a secret can be revealed without editing its value', (
    tester,
  ) async {
    var changes = 0;
    await tester.pumpWidget(
      _app(
        Scaffold(
          body: SettingsTextField(
            label: 'Token',
            initialValue: 'private-value',
            obscureText: true,
            onChanged: (_) => changes++,
          ),
        ),
        locale: const Locale('ru'),
      ),
    );
    await tester.pumpAndSettle();
    expect(
      tester.widget<EditableText>(find.byType(EditableText)).obscureText,
      isTrue,
    );
    await tester.tap(find.byTooltip('Показать значение'));
    await tester.pump();
    final editable = tester.widget<EditableText>(find.byType(EditableText));
    expect(editable.obscureText, isFalse);
    expect(editable.controller.text, 'private-value');
    expect(changes, 0);
    await tester.tap(find.byTooltip('Скрыть значение'));
    await tester.pump();
    expect(
      tester.widget<EditableText>(find.byType(EditableText)).obscureText,
      isTrue,
    );
  });

  testWidgets('a switch reflects an external draft reset', (tester) async {
    var value = true;
    late StateSetter update;
    await tester.pumpWidget(
      _app(
        Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) {
              update = setState;
              return SettingsSwitch(
                label: 'Enabled',
                value: value,
                onChanged: (next) => value = next,
              );
            },
          ),
        ),
      ),
    );
    expect(tester.widget<Switch>(find.byType(Switch)).value, isTrue);
    update(() => value = false);
    await tester.pump();
    expect(tester.widget<Switch>(find.byType(Switch)).value, isFalse);
  });

  testWidgets(
    'Back protects invalid child input and releases its registration',
    (tester) async {
      final config = AppConfig.fromJson({}).mqtt;
      final checks = <ValueGetter<bool>>{};
      await tester.pumpWidget(
        _app(
          Builder(
            builder: (context) => Scaffold(
              body: Center(
                child: FilledButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => MqttEditorPage(
                        config: config,
                        registerDraft: (check) {
                          checks.add(check);
                          return () => checks.remove(check);
                        },
                      ),
                    ),
                  ),
                  child: const Text('Open'),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      final port = find.widgetWithText(TextFormField, 'Port');
      await tester.enterText(port, '');
      await tester.pumpAndSettle();
      expect(config.serverPort, 1883);
      expect(checks.single(), isTrue);
      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsOneWidget);
      await tester.tap(find.text('Keep editing'));
      await tester.pumpAndSettle();
      expect(
        tester
            .widget<EditableText>(
              find.descendant(of: port, matching: find.byType(EditableText)),
            )
            .controller
            .text,
        '',
      );
      await tester.pageBack();
      await tester.pumpAndSettle();
      await tester.tap(find.text('Discard input'));
      await tester.pumpAndSettle();
      expect(find.text('Open'), findsOneWidget);
      expect(checks, isEmpty);
      expect(config.serverPort, 1883);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'desktop navigation stays visible and narrow forms fit enlarged Russian text',
    (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(1280, 900);
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(
        _app(const ConfigAppScaffold(body: Text('Content'))),
      );
      await tester.pumpAndSettle();
      expect(find.text('Photo frame'), findsOneWidget);
      expect(find.byType(Drawer), findsNothing);
      tester.view.physicalSize = const Size(320, 800);
      await tester.pumpWidget(
        _app(
          Builder(
            builder: (context) => MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(2)),
              child: ConfigAppScaffold(
                appBar: AppBar(title: const Text('Настройки')),
                body: SingleChildScrollView(
                  child: SettingsSection(
                    title: 'Расширенные настройки подключения',
                    children: [
                      SettingsDropdown<bool>(
                        label: 'Включить подключение',
                        value: true,
                        items: const [true, false],
                        itemLabelBuilder: (value) =>
                            value ? 'Включено' : 'Выключено',
                        onChanged: (_) {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          locale: const Locale('ru'),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byTooltip('Открыть меню навигации'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );
}
