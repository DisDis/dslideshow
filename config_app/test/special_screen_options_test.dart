import 'package:config_app/features/config/presentation/pages/special_screen_editor_page.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/sessions/special_screen_session.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/clock_screen_widget.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/special_screen_renderers.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _host(
  SpecialScreenConfig config,
  ValueChanged<SpecialScreenConfig?> completed,
) => MaterialApp(
  locale: const Locale('ru'),
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: Builder(
    builder: (context) => Scaffold(
      body: ElevatedButton(
        onPressed: () async => completed(
          await Navigator.of(context).push<SpecialScreenConfig>(
            MaterialPageRoute(
              builder: (_) => SpecialScreenEditorPage(config: config),
            ),
          ),
        ),
        child: const Text('Edit'),
      ),
    ),
  ),
);

Future<void> _refresh(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 450));
  await tester.pump();
}

Future<void> _selectFont(
  WidgetTester tester,
  String label,
  String choice,
) async {
  final field = find.widgetWithText(DropdownButtonFormField<ClockFont>, label);
  await tester.ensureVisible(field);
  await tester.tap(field);
  await tester.pumpAndSettle();
  await tester.tap(find.text(choice).last);
  await tester.pumpAndSettle();
  await _refresh(tester);
}

void main() {
  testWidgets(
    'clock font and weekday edits preview locally and transfer on Done',
    (tester) async {
      final config = SpecialScreenConfig(
        id: 'clock',
        type: SpecialScreenType.clock,
      );
      SpecialScreenConfig? result;
      await tester.pumpWidget(_host(config, (value) => result = value));
      await tester.tap(find.text('Edit'));
      await tester.pumpAndSettle();
      final l = AppLocalizations.of(
        tester.element(find.byType(SpecialScreenEditorPage)),
      );
      final showDate = find.widgetWithText(SwitchListTile, l.special_show_date);
      await tester.ensureVisible(showDate);
      await tester.tap(showDate);
      await tester.pump();
      final showWeekday = find.widgetWithText(
        SwitchListTile,
        l.special_show_weekday,
      );
      await tester.ensureVisible(showWeekday);
      await tester.tap(showWeekday);
      await tester.pump();
      await _selectFont(tester, l.special_time_font, 'Orbitron');
      await _selectFont(tester, l.special_date_font, 'Roboto');
      final preview = tester.widget<ClockScreenWidget>(
        find.byType(ClockScreenWidget),
      );
      final options = preview.session.config.options as ClockScreenOptions;
      expect(options.timeFont, ClockFont.orbitron);
      expect(options.dateFont, ClockFont.roboto);
      expect(options.showDate, isFalse);
      expect(options.showWeekday, isTrue);
      expect((config.options as ClockScreenOptions).timeFont, ClockFont.system);
      expect((config.options as ClockScreenOptions).showWeekday, isFalse);
      await tester.tap(find.text(l.special_done));
      await tester.pumpAndSettle();
      final saved = result!.options as ClockScreenOptions;
      expect(saved.timeFont, ClockFont.orbitron);
      expect(saved.dateFont, ClockFont.roboto);
      expect(saved.showWeekday, isTrue);
      expect(saved.showDate, isFalse);
      expect((config.options as ClockScreenOptions).showWeekday, isFalse);
      await tester.pumpWidget(const SizedBox());
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('Cancel discards clock font and weekday edits', (tester) async {
    final config = SpecialScreenConfig(
      id: 'clock',
      type: SpecialScreenType.clock,
    );
    SpecialScreenConfig? result;
    await tester.pumpWidget(_host(config, (value) => result = value));
    await tester.tap(find.text('Edit'));
    await tester.pumpAndSettle();
    final l = AppLocalizations.of(
      tester.element(find.byType(SpecialScreenEditorPage)),
    );
    await _selectFont(tester, l.special_time_font, 'Righteous');
    final showWeekday = find.widgetWithText(
      SwitchListTile,
      l.special_show_weekday,
    );
    await tester.ensureVisible(showWeekday);
    await tester.tap(showWeekday);
    await tester.pump();
    await tester.tap(find.text(l.special_cancel));
    await tester.pumpAndSettle();
    expect(result, isNull);
    final original = config.options as ClockScreenOptions;
    expect(original.timeFont, ClockFont.system);
    expect(original.showWeekday, isFalse);
    await tester.pumpWidget(const SizedBox());
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'camera timeout validates and is shared by preview, Check and Done',
    (tester) async {
      final captures = <SpecialScreenConfig>[];
      final original =
          SpecialScreenRenderers.definitions[SpecialScreenType.cameras]!;
      SpecialScreenRenderers.definitions[SpecialScreenType.cameras] =
          SpecialScreenRenderer((config, _) {
            captures.add(config);
            return _UnavailableSession(config);
          }, (_) => const SizedBox());
      addTearDown(
        () => SpecialScreenRenderers.definitions[SpecialScreenType.cameras] =
            original,
      );
      final config = SpecialScreenConfig(
        id: 'camera',
        type: SpecialScreenType.cameras,
        options: CamerasScreenOptions(
          cameras: [CameraConfig(id: 'a', url: 'http://camera.test/snapshot')],
        ),
      );
      SpecialScreenConfig? result;
      await tester.pumpWidget(_host(config, (value) => result = value));
      await tester.tap(find.text('Edit'));
      await tester.pumpAndSettle();
      final l = AppLocalizations.of(
        tester.element(find.byType(SpecialScreenEditorPage)),
      );
      final timeout = find.widgetWithText(
        TextFormField,
        l.special_request_timeout,
      );
      await tester.ensureVisible(timeout);
      await tester.enterText(timeout, '2,5');
      await _refresh(tester);
      expect(
        (captures.last.options as CamerasScreenOptions).requestTimeoutMs,
        2500,
      );
      for (final input in ['-1', '121']) {
        await tester.enterText(timeout, input);
        await _refresh(tester);
        expect(
          find.byKey(const ValueKey('preview-last-valid')),
          findsOneWidget,
        );
        final check = find.text(l.special_check_camera);
        await tester.ensureVisible(check);
        await tester.pumpAndSettle();
        final count = captures.length;
        await tester.tap(check);
        await tester.pumpAndSettle();
        expect(find.byType(AlertDialog), findsNothing);
        expect(captures, hasLength(count));
        expect(
          (captures.last.options as CamerasScreenOptions).requestTimeoutMs,
          2500,
        );
        await tester.ensureVisible(timeout);
      }
      await tester.enterText(timeout, '2,5');
      await _refresh(tester);
      final check = find.text(l.special_check_camera);
      await tester.ensureVisible(check);
      await tester.pumpAndSettle();
      await tester.tap(check);
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(captures.last.id, 'camera-check');
      expect(
        (captures.last.options as CamerasScreenOptions).requestTimeoutMs,
        2500,
      );
      await tester.tap(
        find.descendant(
          of: find.byType(AlertDialog),
          matching: find.text(l.special_done),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text(l.special_done));
      await tester.pumpAndSettle();
      expect((result!.options as CamerasScreenOptions).requestTimeoutMs, 2500);
      expect((config.options as CamerasScreenOptions).requestTimeoutMs, 10000);
      await tester.pumpWidget(const SizedBox());
      expect(tester.takeException(), isNull);
    },
  );
}

class _UnavailableSession extends SpecialScreenSession {
  _UnavailableSession(super.config);
  @override
  Future<bool> prepare() async => false;
}
