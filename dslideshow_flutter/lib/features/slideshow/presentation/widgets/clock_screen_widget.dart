import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';

import '../sessions/clock_screen_session.dart';
import 'clock_font_style.dart';

class ClockScreenWidget extends StatelessWidget {
  final ClockScreenSession session;
  const ClockScreenWidget({super.key, required this.session});
  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: session,
    builder: (_, _) {
      final options = session.config.options as ClockScreenOptions;
      final now = session.now();
      final l10n =
          Localizations.of<AppLocalizations>(context, AppLocalizations) ??
          lookupAppLocalizations(const Locale('en'));
      String pad(int value) => value.toString().padLeft(2, '0');
      final hour = options.timeFormat == ClockTimeFormat.h12
          ? (now.hour % 12 == 0 ? 12 : now.hour % 12)
          : now.hour;
      var time = '${pad(hour)}:${pad(now.minute)}';
      if (options.showSeconds) time += ':${pad(now.second)}';
      if (options.timeFormat == ClockTimeFormat.h12) {
        time += now.hour < 12 ? ' AM' : ' PM';
      }
      final date = switch (options.dateFormat) {
        ClockDateFormat.yearMonthDay =>
          '${now.year}-${pad(now.month)}-${pad(now.day)}',
        ClockDateFormat.dayMonthYearSlashes =>
          '${pad(now.day)}/${pad(now.month)}/${now.year}',
        ClockDateFormat.dayMonthYear =>
          '${pad(now.day)}.${pad(now.month)}.${now.year}',
      };
      final weekday = switch (now.weekday) {
        DateTime.monday => l10n.special_weekday_monday,
        DateTime.tuesday => l10n.special_weekday_tuesday,
        DateTime.wednesday => l10n.special_weekday_wednesday,
        DateTime.thursday => l10n.special_weekday_thursday,
        DateTime.friday => l10n.special_weekday_friday,
        DateTime.saturday => l10n.special_weekday_saturday,
        _ => l10n.special_weekday_sunday,
      };
      return ColoredBox(
        color: Color(options.backgroundColor),
        child: LayoutBuilder(
          builder: (_, size) {
            final unit = size.biggest.shortestSide / 100;
            final dateStyle = options.dateFont.textStyle(
              color: Color(options.textColor),
              fontSize: unit * options.dateFontSizePercent,
            );
            return Center(
              child: Padding(
                padding: EdgeInsets.all(unit * 4),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        time,
                        style: options.timeFont.textStyle(
                          color: Color(options.textColor),
                          fontSize: unit * options.timeFontSizePercent,
                        ),
                      ),
                      if (options.showDate || options.showWeekday)
                        SizedBox(height: unit * 3),
                      if (options.showDate) Text(date, style: dateStyle),
                      if (options.showDate && options.showWeekday)
                        SizedBox(height: unit),
                      if (options.showWeekday) Text(weekday, style: dateStyle),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
