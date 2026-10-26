import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/sessions/clock_screen_session.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/clock_screen_widget.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

ClockScreenSession clock(ClockScreenOptions options, DateTime Function() now) =>
    ClockScreenSession(
      SpecialScreenConfig(
        id: 'clock',
        type: SpecialScreenType.clock,
        options: options,
      ),
      now: now,
    );

Widget clockApp(
  ClockScreenSession session, {
  Locale? locale,
  bool localized = true,
  Size size = const Size(400, 200),
  double textScale = 1,
}) => MaterialApp(
  locale: locale,
  localizationsDelegates: localized
      ? AppLocalizations.localizationsDelegates
      : null,
  supportedLocales: localized
      ? AppLocalizations.supportedLocales
      : const [Locale('en')],
  home: Center(
    child: MediaQuery(
      data: MediaQueryData(textScaler: TextScaler.linear(textScale)),
      child: SizedBox.fromSize(
        size: size,
        child: ClockScreenWidget(session: session),
      ),
    ),
  ),
);

void main() {
  testWidgets('clock fonts and sizes are independent for time and date', (
    tester,
  ) async {
    final options = ClockScreenOptions(
      timeFontSizePercent: 30,
      dateFontSizePercent: 9,
      textColor: 0xFF12AB34,
    );
    final session = clock(options, () => DateTime(2026, 10, 26, 12, 34));
    addTearDown(session.dispose);
    const families = {
      ClockFont.system: null,
      ClockFont.roboto: 'packages/system_metrics_widget/Roboto',
      ClockFont.orbitron: 'packages/system_metrics_widget/Orbitron',
      ClockFont.righteous: 'packages/system_metrics_widget/Righteous',
      ClockFont.fredoka: 'packages/system_metrics_widget/FredokaOne',
    };
    for (var index = 0; index < ClockFont.values.length; index++) {
      options.timeFont = ClockFont.values[index];
      options.dateFont =
          ClockFont.values[(index + 1) % ClockFont.values.length];
      await tester.pumpWidget(clockApp(session));
      final time = tester.widget<Text>(find.text('12:34'));
      final date = tester.widget<Text>(find.text('26.10.2026'));
      expect(time.style!.fontFamily, families[options.timeFont]);
      expect(date.style!.fontFamily, families[options.dateFont]);
      final fallbacks = switch (options.timeFont) {
        ClockFont.system || ClockFont.roboto => null,
        _ => ['packages/system_metrics_widget/Roboto'],
      };
      expect(time.style!.fontFamilyFallback, fallbacks);
      expect(time.style!.fontSize, 60);
      expect(date.style!.fontSize, 18);
      expect(time.style!.color, const Color(0xFF12AB34));
      expect(date.style!.color, const Color(0xFF12AB34));
      expect(tester.takeException(), isNull);
    }
  });

  testWidgets('weekday uses the date style while date can stay hidden', (
    tester,
  ) async {
    final options = ClockScreenOptions(
      showDate: false,
      showWeekday: true,
      dateFont: ClockFont.righteous,
      dateFontSizePercent: 7,
    );
    final session = clock(options, () => DateTime(2026, 10, 26, 12, 34));
    addTearDown(session.dispose);
    await tester.pumpWidget(clockApp(session, locale: const Locale('ru')));
    expect(find.text('26.10.2026'), findsNothing);
    final weekday = tester.widget<Text>(find.text('Понедельник'));
    expect(weekday.style!.fontSize, 14);
    expect(
      weekday.style!.fontFamily,
      'packages/system_metrics_widget/Righteous',
    );
    expect(tester.widget<Text>(find.text('12:34')).style!.fontFamily, isNull);

    options.showDate = true;
    await tester.pumpWidget(clockApp(session, locale: const Locale('ru')));
    expect(find.text('26.10.2026'), findsOneWidget);
    expect(
      tester.widget<Text>(find.text('26.10.2026')).style,
      tester.widget<Text>(find.text('Понедельник')).style,
    );

    options.showDate = false;
    options.showWeekday = false;
    await tester.pumpWidget(clockApp(session, locale: const Locale('ru')));
    expect(find.text('Понедельник'), findsNothing);
    expect(find.text('12:34'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('all weekdays follow the current English or Russian locale', (
    tester,
  ) async {
    var now = DateTime(2026, 10, 26);
    final session = clock(ClockScreenOptions(showWeekday: true), () => now);
    addTearDown(session.dispose);
    const days = {
      'en': [
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
        'Sunday',
      ],
      'ru': [
        'Понедельник',
        'Вторник',
        'Среда',
        'Четверг',
        'Пятница',
        'Суббота',
        'Воскресенье',
      ],
    };
    for (final entry in days.entries) {
      for (var day = 0; day < entry.value.length; day++) {
        now = DateTime(2026, 10, 26 + day);
        await tester.pumpWidget(clockApp(session, locale: Locale(entry.key)));
        expect(find.text(entry.value[day]), findsOneWidget);
      }
    }
    expect(tester.takeException(), isNull);
  });

  testWidgets('weekday changes at midnight using the existing minute tick', (
    tester,
  ) async {
    var now = DateTime(2026, 10, 25, 23, 59, 59);
    final session = clock(
      ClockScreenOptions(showWeekday: true, showDate: false),
      () => now,
    );
    addTearDown(session.dispose);
    await tester.pumpWidget(clockApp(session, locale: const Locale('ru')));
    session.setActive(true);
    await tester.pump();
    expect(find.text('Воскресенье'), findsOneWidget);
    now = DateTime(2026, 10, 26);
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Понедельник'), findsOneWidget);
    expect(find.text('00:00'), findsOneWidget);
    await tester.pumpWidget(clockApp(session, locale: const Locale('en')));
    expect(find.text('Monday'), findsOneWidget);

    session.setActive(false);
    await tester.pump();
    now = DateTime(2026, 10, 27);
    await tester.pump(const Duration(minutes: 1));
    expect(find.text('Monday'), findsOneWidget);
    session.setActive(true);
    await tester.pump();
    expect(find.text('Tuesday'), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
    session.dispose();
    await tester.pump(const Duration(minutes: 1));
    expect(tester.takeException(), isNull);
  });

  testWidgets('standalone hosts have an English weekday fallback', (
    tester,
  ) async {
    final session = clock(
      ClockScreenOptions(showWeekday: true),
      () => DateTime(2026, 10, 26),
    );
    addTearDown(session.dispose);
    await tester.pumpWidget(clockApp(session, localized: false));
    expect(find.text('Monday'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('time, date and weekday fit a small canvas at maximum sizes', (
    tester,
  ) async {
    final session = clock(
      ClockScreenOptions(
        timeFormat: ClockTimeFormat.h12,
        showSeconds: true,
        showWeekday: true,
        timeFont: ClockFont.orbitron,
        dateFont: ClockFont.fredoka,
        timeFontSizePercent: 100,
        dateFontSizePercent: 100,
      ),
      () => DateTime(2026, 10, 26, 23, 59, 59),
    );
    addTearDown(session.dispose);
    await tester.pumpWidget(
      clockApp(
        session,
        locale: const Locale('ru'),
        size: const Size(260, 80),
        textScale: 2.5,
      ),
    );
    final bounds = tester.getRect(find.byType(ClockScreenWidget));
    for (final text in ['11:59:59 PM', '26.10.2026', 'Понедельник']) {
      final rect = tester.getRect(find.text(text));
      expect(rect.left, greaterThanOrEqualTo(bounds.left));
      expect(rect.right, lessThanOrEqualTo(bounds.right));
      expect(rect.top, greaterThanOrEqualTo(bounds.top));
      expect(rect.bottom, lessThanOrEqualTo(bounds.bottom));
    }
    expect(tester.takeException(), isNull);
  });
}
