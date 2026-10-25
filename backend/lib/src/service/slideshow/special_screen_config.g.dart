// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'special_screen_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpecialScreenSchedule _$SpecialScreenScheduleFromJson(
  Map<String, dynamic> json,
) => SpecialScreenSchedule(
  type:
      $enumDecodeNullable(
        _$SpecialScreenScheduleTypeEnumMap,
        json['type'],
        unknownValue: SpecialScreenScheduleType.everyMediaSlides,
      ) ??
      SpecialScreenScheduleType.everyMediaSlides,
  count: json['count'] == null ? 10 : _parseCount(json['count']),
  intervalMs: json['intervalMs'] == null
      ? 300000
      : _parseInterval(json['intervalMs']),
);

Map<String, dynamic> _$SpecialScreenScheduleToJson(
  SpecialScreenSchedule instance,
) => <String, dynamic>{
  'type': _$SpecialScreenScheduleTypeEnumMap[instance.type]!,
  'count': instance.count,
  'intervalMs': instance.intervalMs,
};

const _$SpecialScreenScheduleTypeEnumMap = {
  SpecialScreenScheduleType.everyMediaSlides: 'everyMediaSlides',
  SpecialScreenScheduleType.interval: 'interval',
};

ClockScreenOptions _$ClockScreenOptionsFromJson(Map<String, dynamic> json) =>
    ClockScreenOptions(
      timeFormat:
          $enumDecodeNullable(
            _$ClockTimeFormatEnumMap,
            json['timeFormat'],
            unknownValue: ClockTimeFormat.h24,
          ) ??
          ClockTimeFormat.h24,
      showSeconds: json['showSeconds'] as bool? ?? false,
      showDate: json['showDate'] as bool? ?? true,
      dateFormat:
          $enumDecodeNullable(
            _$ClockDateFormatEnumMap,
            json['dateFormat'],
            unknownValue: ClockDateFormat.dayMonthYear,
          ) ??
          ClockDateFormat.dayMonthYear,
      timeFontSizePercent: json['timeFontSizePercent'] == null
          ? 20
          : _parseTimeSize(json['timeFontSizePercent']),
      dateFontSizePercent: json['dateFontSizePercent'] == null
          ? 5
          : _parseDateSize(json['dateFontSizePercent']),
      textColor: json['textColor'] == null
          ? 0xFFFFFFFF
          : _parseTextColor(json['textColor']),
      backgroundColor: json['backgroundColor'] == null
          ? 0xFF000000
          : _parseBackgroundColor(json['backgroundColor']),
    );

Map<String, dynamic> _$ClockScreenOptionsToJson(ClockScreenOptions instance) =>
    <String, dynamic>{
      'timeFormat': _$ClockTimeFormatEnumMap[instance.timeFormat]!,
      'showSeconds': instance.showSeconds,
      'showDate': instance.showDate,
      'dateFormat': _$ClockDateFormatEnumMap[instance.dateFormat]!,
      'timeFontSizePercent': instance.timeFontSizePercent,
      'dateFontSizePercent': instance.dateFontSizePercent,
      'textColor': _colorToJson(instance.textColor),
      'backgroundColor': _colorToJson(instance.backgroundColor),
    };

const _$ClockTimeFormatEnumMap = {
  ClockTimeFormat.h24: 'h24',
  ClockTimeFormat.h12: 'h12',
};

const _$ClockDateFormatEnumMap = {
  ClockDateFormat.dayMonthYear: 'dd.MM.yyyy',
  ClockDateFormat.yearMonthDay: 'yyyy-MM-dd',
  ClockDateFormat.dayMonthYearSlashes: 'dd/MM/yyyy',
};

CameraConfig _$CameraConfigFromJson(Map<String, dynamic> json) => CameraConfig(
  id: json['id'] as String? ?? '',
  name: json['name'] as String? ?? '',
  url: json['url'] as String? ?? '',
  username: json['username'] as String? ?? '',
  password: json['password'] as String? ?? '',
);

Map<String, dynamic> _$CameraConfigToJson(CameraConfig instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'username': instance.username,
      'password': instance.password,
    };

CamerasScreenOptions _$CamerasScreenOptionsFromJson(
  Map<String, dynamic> json,
) => CamerasScreenOptions(
  mode:
      $enumDecodeNullable(
        _$CameraDisplayModeEnumMap,
        json['mode'],
        unknownValue: CameraDisplayMode.grid,
      ) ??
      CameraDisplayMode.grid,
  cameras: CamerasScreenOptions._parseCameras(json['cameras']),
  columns: json['columns'] == null ? 0 : _parseColumns(json['columns']),
  fit:
      $enumDecodeNullable(
        _$CameraImageFitEnumMap,
        json['fit'],
        unknownValue: CameraImageFit.contain,
      ) ??
      CameraImageFit.contain,
  showNames: json['showNames'] as bool? ?? true,
  refreshIntervalMs: json['refreshIntervalMs'] == null
      ? 5000
      : _parseRefresh(json['refreshIntervalMs']),
);

Map<String, dynamic> _$CamerasScreenOptionsToJson(
  CamerasScreenOptions instance,
) => <String, dynamic>{
  'mode': _$CameraDisplayModeEnumMap[instance.mode]!,
  'cameras': instance.cameras.map((e) => e.toJson()).toList(),
  'columns': instance.columns,
  'fit': _$CameraImageFitEnumMap[instance.fit]!,
  'showNames': instance.showNames,
  'refreshIntervalMs': instance.refreshIntervalMs,
};

const _$CameraDisplayModeEnumMap = {
  CameraDisplayMode.grid: 'grid',
  CameraDisplayMode.sequence: 'sequence',
};

const _$CameraImageFitEnumMap = {
  CameraImageFit.contain: 'contain',
  CameraImageFit.cover: 'cover',
};

UnknownScreenOptions _$UnknownScreenOptionsFromJson(
  Map<String, dynamic> json,
) => UnknownScreenOptions(json['json'] as Map<String, dynamic>);

Map<String, dynamic> _$UnknownScreenOptionsToJson(
  UnknownScreenOptions instance,
) => <String, dynamic>{'json': instance.json};

SpecialScreenConfig _$SpecialScreenConfigFromJson(Map<String, dynamic> json) =>
    SpecialScreenConfig(
      id: json['id'] as String? ?? '',
      type:
          $enumDecodeNullable(
            _$SpecialScreenTypeEnumMap,
            json['type'],
            unknownValue: SpecialScreenType.unknown,
          ) ??
          SpecialScreenType.unknown,
      name: json['name'] as String? ?? '',
      enabled: json['enabled'] as bool? ?? false,
      schedule: SpecialScreenConfig._parseSchedule(json['schedule']),
      displayTimeMs: json['displayTimeMs'] == null
          ? 10000
          : _parseDisplayTime(json['displayTimeMs']),
      options: SpecialScreenConfig._parsedOptions(json['options']),
    );

Map<String, dynamic> _$SpecialScreenConfigToJson(
  SpecialScreenConfig instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': _$SpecialScreenTypeEnumMap[instance.type]!,
  'name': instance.name,
  'enabled': instance.enabled,
  'schedule': instance.schedule.toJson(),
  'displayTimeMs': instance.displayTimeMs,
  'options': instance.options.toJson(),
};

const _$SpecialScreenTypeEnumMap = {
  SpecialScreenType.clock: 'clock',
  SpecialScreenType.cameras: 'cameras',
  SpecialScreenType.unknown: 'unknown',
};
