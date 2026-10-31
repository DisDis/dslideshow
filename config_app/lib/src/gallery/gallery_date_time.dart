import 'package:intl/intl.dart';

/// Parses gallery timestamps and formats them in the panel's local time.
abstract final class GalleryDateTime {
  static final _dateTaken = RegExp(
    r'^(\d{4})([:-])(\d{2})\2(\d{2})[T ](\d{2}):(\d{2}):(\d{2})(?:[.,](\d+))?(?:\s*(Z|[+-]\d{2}:?\d{2}))?$',
    caseSensitive: false,
  );

  /// Reads EXIF or ISO timestamps, treating missing or invalid dates as unknown.
  static DateTime? parseDateTaken(String? value) {
    if (value == null) return null;
    final match = _dateTaken.firstMatch(value.trim());
    if (match == null) return null;
    final year = int.parse(match[1]!);
    final month = int.parse(match[3]!);
    final day = int.parse(match[4]!);
    final hour = int.parse(match[5]!);
    final minute = int.parse(match[6]!);
    final second = int.parse(match[7]!);
    if (year < 1 || month < 1 || month > 12 || day < 1 || day > 31 || hour > 23 || minute > 59 || second > 59) {
      return null;
    }
    if (DateTime.utc(year, month, day).day != day) return null;
    final offset = match[9]?.toUpperCase();
    if (offset != null && offset != 'Z') {
      final digits = offset.substring(1).replaceAll(':', '');
      if (int.parse(digits.substring(0, 2)) > 23 || int.parse(digits.substring(2)) > 59) return null;
    }
    final fraction = match[8] == null ? '' : '.${match[8]}';
    return DateTime.tryParse(
      '${match[1]}-${match[3]}-${match[4]}T${match[5]}:${match[6]}:${match[7]}$fraction${offset ?? ''}',
    );
  }

  /// Formats a timestamp through seconds, or an em dash when it is unavailable.
  static String format(DateTime? value, String locale) =>
      value == null ? '—' : DateFormat.yMd(locale).add_Hms().format(value.toLocal());
}
