import 'package:config_app/features/config/domain/config_draft.dart';
import 'package:config_app/features/config/domain/night_mode_settings_validation.dart';
import 'package:config_app/features/config/presentation/bloc/wake_settings_cubit.dart';
import 'package:config_app/features/config/presentation/pages/wake_settings_page.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget app(Widget child) => MaterialApp(
  locale: const Locale('en'),
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: child,
);

Future<void> enter(WidgetTester tester, WakeField field, String value) async {
  final finder = find.byKey(ValueKey('wake-${field.name}'));
  if (finder.evaluate().isEmpty) {
    await tester.scrollUntilVisible(
      finder,
      400,
      scrollable: find.descendant(of: find.byType(ListView), matching: find.byType(Scrollable)).first,
    );
  }
  await tester.ensureVisible(finder);
  await tester.enterText(finder, value);
  await tester.pump();
}

TextField input(WidgetTester tester, WakeField field) => tester.widget<TextField>(
  find.descendant(of: find.byKey(ValueKey('wake-${field.name}')), matching: find.byType(TextField)),
);

void main() {
  testWidgets('all wake settings edit the shared draft and round-trip through config JSON', (tester) async {
    tester.view.physicalSize = const Size(1000, 2200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final saved = AppConfig.fromJson({});
    final draft = ConfigDraft()..replaceSaved(saved);
    await tester.pumpWidget(app(WakeSettingsPage(config: draft.value!)));
    await tester.tap(find.byKey(const ValueKey('night-enabled')));
    await tester.pump();
    await tester.tap(find.byKey(const ValueKey('night-mode')));
    await tester.pumpAndSettle();
    expect(find.text('Schedule OR darkness'), findsWidgets);
    expect(find.text('Schedule AND darkness'), findsWidgets);
    await tester.tap(find.text('Schedule OR darkness').last);
    await tester.pumpAndSettle();
    await enter(tester, WakeField.start, '22:30');
    await enter(tester, WakeField.end, '07:15');
    await enter(tester, WakeField.absence, '45');
    await tester.ensureVisible(find.byKey(const ValueKey('night-light-enabled')));
    await tester.tap(find.byKey(const ValueKey('night-light-enabled')));
    await tester.pump();
    await enter(tester, WakeField.topic, 'zigbee2mqtt/bedroom');
    await enter(tester, WakeField.valueField, 'illuminance');
    await enter(tester, WakeField.availabilityTopic, 'zigbee2mqtt/bedroom/availability');
    await enter(tester, WakeField.darkBelow, '3');
    await enter(tester, WakeField.lightAbove, '8');
    await enter(tester, WakeField.maxAge, '600');
    final config = AppConfig.fromJson(draft.value!.toStorageJson());
    expect(config.nightMode.enabled, isTrue);
    expect(config.nightMode.mode, NightMode.scheduleOrDarkness);
    expect((config.nightMode.startMinute, config.nightMode.endMinute), (1350, 435));
    expect(config.hardware.screenPowerOnTimerSec, 45);
    expect(
      config.nightMode.ambientLight,
      const AmbientLightConfig(
        enabled: true,
        topic: 'zigbee2mqtt/bedroom',
        availabilityTopic: 'zigbee2mqtt/bedroom/availability',
        darkBelowLux: 3,
        lightAboveLux: 8,
        maxAgeSec: 600,
      ),
    );
    expect(draft.hasChanges, isTrue);
    expect(saved.nightMode.enabled, isFalse);
    await tester.pumpWidget(const SizedBox.shrink());
    draft.discard();
    expect(draft.hasChanges, isFalse);
  });

  testWidgets('invalid raw settings preserve last valid config and register navigation guard', (tester) async {
    final config = AppConfig.fromJson({});
    final checks = <ValueGetter<bool>>{};
    await tester.pumpWidget(
      app(
        WakeSettingsPage(
          config: config,
          registerDraft: (check) {
            checks.add(check);
            return () => checks.remove(check);
          },
        ),
      ),
    );
    await enter(tester, WakeField.start, '24:00');
    expect(config.nightMode.startMinute, 1380);
    expect(checks.single(), isTrue);
    expect(input(tester, WakeField.start).decoration?.errorText, 'Enter a time in HH:mm format (00:00–23:59).');
    await enter(tester, WakeField.start, '22:00');
    expect(checks.single(), isFalse);
    await enter(tester, WakeField.end, '22:00');
    expect(config.nightMode.endMinute, 480);
    expect(checks.single(), isTrue);
    await enter(tester, WakeField.end, '07:00');
    expect(checks.single(), isFalse);
    for (final text in ['3.5', '3,5']) {
      await enter(tester, WakeField.darkBelow, text);
      expect(config.nightMode.ambientLight.darkBelowLux, 5);
      expect(checks.single(), isTrue);
      expect(input(tester, WakeField.darkBelow).decoration?.errorText, 'Enter a whole number.');
    }
    await enter(tester, WakeField.darkBelow, '3');
    expect(config.nightMode.ambientLight.darkBelowLux, 3);
    expect(checks.single(), isFalse);
    await tester.pumpWidget(const SizedBox.shrink());
    expect(checks, isEmpty);
  });

  testWidgets('MQTT topic fields accept Cyrillic and spaces as text', (tester) async {
    const lightTopic = 'zigbee2mqtt/Кухня датчик движения';
    const availabilityTopic = '$lightTopic/availability';
    final config = AppConfig.fromJson({})
      ..nightMode = const NightModeConfig(
        enabled: true,
        mode: NightMode.scheduleOrDarkness,
        ambientLight: AmbientLightConfig(enabled: true, topic: 'zigbee2mqtt/bedroom'),
      );
    final checks = <ValueGetter<bool>>{};
    await tester.pumpWidget(
      app(
        WakeSettingsPage(
          config: config,
          registerDraft: (check) {
            checks.add(check);
            return () => checks.remove(check);
          },
        ),
      ),
    );
    for (final (field, value) in [(WakeField.topic, lightTopic), (WakeField.availabilityTopic, availabilityTopic)]) {
      await enter(tester, field, value);
      expect(input(tester, field).keyboardType, TextInputType.text);
      expect(checks.single(), isFalse);
      expect(find.byKey(const ValueKey('wake-invalid')), findsNothing);
    }
    final restored = AppConfig.fromJson(config.toStorageJson()).nightMode.ambientLight;
    expect(restored.topic, lightTopic);
    expect(restored.availabilityTopic, availabilityTopic);
    await tester.pumpWidget(const SizedBox.shrink());
    expect(checks, isEmpty);
  });

  testWidgets('identical MQTT topics show only the availability error and allow an empty topic', (tester) async {
    const topic = 'zigbee2mqtt/Кухня датчик движения';
    final config = AppConfig.fromJson({})
      ..nightMode = const NightModeConfig(enabled: true, ambientLight: AmbientLightConfig(enabled: true, topic: topic));
    await tester.pumpWidget(app(WakeSettingsPage(config: config)));
    await enter(tester, WakeField.availabilityTopic, topic);
    expect(input(tester, WakeField.availabilityTopic).keyboardType, TextInputType.text);
    expect(
      input(tester, WakeField.availabilityTopic).decoration?.errorText,
      'The availability topic must differ from the illuminance topic. '
      'Leave it empty if online/offline messages are not published.',
    );
    expect(
      find.byWidgetPredicate((widget) => widget is TextField && widget.decoration?.errorText != null),
      findsOneWidget,
    );
    expect(find.text('Correct the highlighted fields.'), findsOneWidget);
    expect(config.nightMode.ambientLight.availabilityTopic, isEmpty);
    await enter(tester, WakeField.availabilityTopic, '');
    expect(input(tester, WakeField.availabilityTopic).decoration?.errorText, isNull);
    expect(find.byKey(const ValueKey('wake-invalid')), findsNothing);
  });

  testWidgets('editor displays active frame clock and policy independently of unsaved edits', (tester) async {
    final config = AppConfig.fromJson({});
    await tester.pumpWidget(
      app(
        WakeSettingsPage(
          config: config,
          readDevice: () async => FrameState(
            sampledAt: DateTime.utc(2026, 11, 1, 20),
            autoWakeEnabled: true,
            isScreenOn: false,
            backendVersion: 'test',
            deviceLocalTime: DateTime(2026, 11, 1, 23),
            nightMode: const NightModeState(
              enabled: true,
              inSchedule: true,
              automaticWakeBlocked: true,
              reason: AutomaticSleepReason.schedule,
            ),
          ),
        ),
      ),
    );
    await tester.pump();
    await tester.scrollUntilVisible(
      find.byKey(const ValueKey('night-mode-details')),
      500,
      scrollable: find.descendant(of: find.byType(ListView), matching: find.byType(Scrollable)).first,
    );
    expect(find.text('Frame local time: 2026-11-01T23:00:00'), findsOneWidget);
    expect(find.text('Active settings on the frame: Schedule only'), findsOneWidget);
    expect(find.text('Automatic wake blocked by schedule'), findsOneWidget);
    expect(config.nightMode.enabled, isFalse);
  });

  test('invalid MQTT edits stay in the editor until corrected', () async {
    final config = AppConfig.fromJson({});
    final cubit = WakeSettingsCubit(config);
    addTearDown(cubit.close);
    cubit.enableLight(true);
    expect(cubit.state.invalid, isTrue);
    expect(config.nightMode.ambientLight.enabled, isFalse);
    cubit.change(WakeField.topic, 'bedroom');
    expect(cubit.state.invalid, isFalse);
    final valid = config.nightMode;

    for (final (field, invalid, corrected, error) in [
      (WakeField.topic, 'bedroom/#', 'bedroom', WakeInputError.exactTopic),
      (WakeField.valueField, '', 'illuminance', WakeInputError.required),
      (WakeField.availabilityTopic, 'bedroom', '', WakeInputError.differentTopics),
      (WakeField.darkBelow, '-1', '5', WakeInputError.nonnegativeInteger),
      (WakeField.lightAbove, '5', '10', WakeInputError.lightThreshold),
      (WakeField.maxAge, '0', '1800', WakeInputError.positiveInteger),
    ]) {
      cubit.change(field, invalid);
      expect(cubit.state.invalid, isTrue, reason: field.name);
      expect(cubit.state.errors, {field: error}, reason: field.name);
      expect(config.nightMode, valid, reason: field.name);
      cubit.change(field, corrected);
      expect(cubit.state.invalid, isFalse, reason: field.name);
    }
  });
}
