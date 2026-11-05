// Freezed forwards constructor annotations to the generated implementation.
// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'night_mode_config.freezed.dart';
part 'night_mode_config.g.dart';

enum NightMode { scheduleOnly, scheduleOrDarkness, scheduleAndDarkness }

int _startFromJson(Object? value) => value == null ? 1380 : NightModeConfig.parseTime(value as String);
int _endFromJson(Object? value) => value == null ? 480 : NightModeConfig.parseTime(value as String);

@freezed
sealed class AmbientLightConfig with _$AmbientLightConfig {
  @JsonSerializable()
  const factory AmbientLightConfig({
    @Default(false) bool enabled,
    @Default('') String topic,
    @Default('illuminance') String valueField,
    @Default('') String availabilityTopic,
    @Default(5) int darkBelowLux,
    @Default(10) int lightAboveLux,
    @Default(1800) int maxAgeSec,
  }) = _AmbientLightConfig;

  factory AmbientLightConfig.fromJson(Map<String, dynamic> json) => _$AmbientLightConfigFromJson(json);
}

@freezed
sealed class NightModeConfig with _$NightModeConfig {
  const NightModeConfig._();

  @JsonSerializable(explicitToJson: true)
  const factory NightModeConfig({
    @Default(false) bool enabled,
    @Default(NightMode.scheduleOnly) NightMode mode,
    @JsonKey(name: 'start', fromJson: _startFromJson, toJson: NightModeConfig.formatTime)
    @Default(1380)
    int startMinute,
    @JsonKey(name: 'end', fromJson: _endFromJson, toJson: NightModeConfig.formatTime) @Default(480) int endMinute,
    @Default(AmbientLightConfig()) AmbientLightConfig ambientLight,
  }) = _NightModeConfig;

  factory NightModeConfig.fromJson(Map<String, dynamic> json) => _$NightModeConfigFromJson(json);

  static final _timePattern = RegExp(r'^([01][0-9]|2[0-3]):([0-5][0-9])$');

  static int parseTime(String value) {
    final match = _timePattern.firstMatch(value);
    if (match == null) throw const FormatException('Expected time HH:mm');
    return int.parse(match[1]!) * 60 + int.parse(match[2]!);
  }

  static String formatTime(int minute) =>
      '${(minute ~/ 60).toString().padLeft(2, '0')}:'
      '${(minute % 60).toString().padLeft(2, '0')}';

  bool contains(DateTime now) {
    final minute = now.hour * 60 + now.minute;
    return startMinute < endMinute
        ? minute >= startMinute && minute < endMinute
        : minute >= startMinute || minute < endMinute;
  }

  DateTime nextBoundary(DateTime now) {
    final candidates = <DateTime>[
      for (final day in [now.day, now.day + 1])
        for (final minute in [startMinute, endMinute])
          if (now.isUtc)
            DateTime.utc(now.year, now.month, day, minute ~/ 60, minute % 60)
          else
            DateTime(now.year, now.month, day, minute ~/ 60, minute % 60),
    ]..removeWhere((date) => !date.isAfter(now));
    candidates.sort();
    return candidates.first;
  }
}
