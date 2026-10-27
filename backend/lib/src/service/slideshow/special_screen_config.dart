import 'package:dslideshow_backend/src/config_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'special_screen_config.g.dart';

/// String identifiers are confined to JSON; playback and editors use enums.
enum SpecialScreenType { clock, cameras, unknown }

enum SpecialScreenScheduleType { everyMediaSlides, interval }

enum CameraDisplayMode { grid, sequence }

enum ClockTimeFormat { h24, h12 }

enum ClockFont { system, roboto, orbitron, righteous, fredoka }

enum CameraImageFit { contain, cover }

enum ClockDateFormat {
  @JsonValue('dd.MM.yyyy')
  dayMonthYear,
  @JsonValue('yyyy-MM-dd')
  yearMonthDay,
  @JsonValue('dd/MM/yyyy')
  dayMonthYearSlashes,
}

Map<String, dynamic> _map(dynamic value) =>
    value is Map ? Map<String, dynamic>.from(value) : <String, dynamic>{};
int _positive(dynamic value, int fallback) =>
    value is num && value.isFinite && value > 0
    ? value.toInt().clamp(1, 86400000)
    : fallback;
double _size(dynamic value, double fallback) =>
    value is num && value.isFinite && value > 0 && value <= 100
    ? value.toDouble()
    : fallback;
int _color(dynamic value, int fallback) => value is int
    ? value
    : value is String
    ? int.tryParse(value, radix: 16) ?? fallback
    : fallback;
String _colorToJson(int value) => value.toRadixString(16);
int _parseCount(dynamic value) => _positive(value, 10);
int _parseInterval(dynamic value) => _positive(value, 300000);
int _parseDisplayTime(dynamic value) => _positive(value, 10000);
double _parseTimeSize(dynamic value) => _size(value, 50);
double _parseDateSize(dynamic value) => _size(value, 5);
int _parseTextColor(dynamic value) => _color(value, 0xFFFFFFFF);
int _parseBackgroundColor(dynamic value) => _color(value, 0xFF000000);
int _parseColumns(dynamic value) =>
    value is num && value.isFinite ? value.toInt().clamp(0, 16) : 0;
int _parseRefresh(dynamic value) => value == 0 ? 0 : _positive(value, 5000);
int _parseRequestTimeout(dynamic value) =>
    value is num && value.isFinite && value >= 100 && value <= 120000
    ? value.toInt()
    : 10000;

@JsonSerializable()
class SpecialScreenSchedule {
  @JsonKey(unknownEnumValue: SpecialScreenScheduleType.everyMediaSlides)
  SpecialScreenScheduleType type;
  @JsonKey(fromJson: _parseCount)
  int count;
  @JsonKey(fromJson: _parseInterval)
  int intervalMs;
  SpecialScreenSchedule({
    this.type = SpecialScreenScheduleType.everyMediaSlides,
    this.count = 10,
    this.intervalMs = 300000,
  });
  factory SpecialScreenSchedule.fromJson(Map<String, dynamic> json) =>
      _$SpecialScreenScheduleFromJson(json);
  Map<String, dynamic> toJson() => stripDefaults(
    _$SpecialScreenScheduleToJson(this),
    _$SpecialScreenScheduleToJson(SpecialScreenSchedule()),
  );
}

abstract class SpecialScreenOptions {
  Map<String, dynamic> toJson();
}

@JsonSerializable()
class ClockScreenOptions extends SpecialScreenOptions {
  @JsonKey(unknownEnumValue: ClockTimeFormat.h24)
  ClockTimeFormat timeFormat;
  bool showSeconds;
  bool showDate;
  bool showWeekday;
  @JsonKey(unknownEnumValue: ClockDateFormat.dayMonthYear)
  ClockDateFormat dateFormat;
  @JsonKey(unknownEnumValue: ClockFont.system)
  ClockFont timeFont;
  @JsonKey(unknownEnumValue: ClockFont.system)
  ClockFont dateFont;
  @JsonKey(fromJson: _parseTimeSize)
  double timeFontSizePercent;
  @JsonKey(fromJson: _parseDateSize)
  double dateFontSizePercent;
  @JsonKey(fromJson: _parseTextColor, toJson: _colorToJson)
  int textColor;
  @JsonKey(fromJson: _parseBackgroundColor, toJson: _colorToJson)
  int backgroundColor;
  ClockScreenOptions({
    this.timeFormat = ClockTimeFormat.h24,
    this.showSeconds = false,
    this.showDate = true,
    this.showWeekday = false,
    this.dateFormat = ClockDateFormat.dayMonthYear,
    this.timeFont = ClockFont.system,
    this.dateFont = ClockFont.system,
    this.timeFontSizePercent = 50,
    this.dateFontSizePercent = 5,
    this.textColor = 0xFFFFFFFF,
    this.backgroundColor = 0xFF000000,
  });
  factory ClockScreenOptions.fromJson(Map<String, dynamic> json) =>
      _$ClockScreenOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => stripDefaults(
    _$ClockScreenOptionsToJson(this),
    _$ClockScreenOptionsToJson(ClockScreenOptions()),
  );
}

@JsonSerializable()
class CameraConfig {
  @JsonKey(defaultValue: '')
  String id;
  String name;
  String url;
  String username;
  String password;
  CameraConfig({
    required this.id,
    this.name = '',
    this.url = '',
    this.username = '',
    this.password = '',
  });
  factory CameraConfig.fromJson(Map<String, dynamic> json) =>
      _$CameraConfigFromJson(json);
  Map<String, dynamic> toJson() => stripDefaults(
    _$CameraConfigToJson(this),
    _$CameraConfigToJson(CameraConfig(id: ''))
      ..remove('id')
      ..remove('url'),
  );
  bool get hasValidUrl {
    final uri = Uri.tryParse(url);
    return uri != null &&
        ['http', 'https'].contains(uri.scheme) &&
        uri.host.isNotEmpty;
  }
}

@JsonSerializable()
class CamerasScreenOptions extends SpecialScreenOptions {
  @JsonKey(unknownEnumValue: CameraDisplayMode.grid)
  CameraDisplayMode mode;
  @JsonKey(fromJson: _parseCameras)
  List<CameraConfig> cameras;
  @JsonKey(fromJson: _parseColumns)
  int columns;
  @JsonKey(unknownEnumValue: CameraImageFit.contain)
  CameraImageFit fit;
  bool showNames;
  @JsonKey(fromJson: _parseRefresh)
  int refreshIntervalMs;
  @JsonKey(fromJson: _parseRequestTimeout)
  int requestTimeoutMs;
  CamerasScreenOptions({
    this.mode = CameraDisplayMode.grid,
    List<CameraConfig>? cameras,
    this.columns = 0,
    this.fit = CameraImageFit.contain,
    this.showNames = true,
    this.refreshIntervalMs = 5000,
    this.requestTimeoutMs = 10000,
  }) : cameras = cameras ?? [];
  static List<CameraConfig> _parseCameras(dynamic value) {
    final result = <CameraConfig>[];
    for (final item in value is List ? value : []) {
      if (item is! Map) continue;
      final camera = CameraConfig.fromJson(_map(item));
      if (camera.id.isEmpty || result.any((c) => c.id == camera.id)) {
        var index = result.length + 1;
        while (result.any((c) => c.id == 'camera-$index')) {
          index++;
        }
        camera.id = 'camera-$index';
      }
      result.add(camera);
    }
    return result;
  }

  factory CamerasScreenOptions.fromJson(Map<String, dynamic> json) =>
      _$CamerasScreenOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => stripDefaults(
    _$CamerasScreenOptionsToJson(this),
    _$CamerasScreenOptionsToJson(CamerasScreenOptions()),
  );
}

/// Opaque payload of a future screen type. Preserve it when saving older apps.
@JsonSerializable()
class UnknownScreenOptions extends SpecialScreenOptions {
  final Map<String, dynamic> json;
  UnknownScreenOptions(this.json);
  factory UnknownScreenOptions.fromJson(Map<String, dynamic> json) =>
      _$UnknownScreenOptionsFromJson({'json': json});
  @override
  Map<String, dynamic> toJson() =>
      _$UnknownScreenOptionsToJson(this)['json'] as Map<String, dynamic>;
}

class SpecialScreenDefinition {
  final SpecialScreenOptions Function(Map<String, dynamic>) parseOptions;
  SpecialScreenDefinition(this.parseOptions);
  SpecialScreenOptions defaults() => parseOptions({});
}

class SpecialScreenRegistry {
  static final definitions = <SpecialScreenType, SpecialScreenDefinition>{
    SpecialScreenType.clock: SpecialScreenDefinition(
      ClockScreenOptions.fromJson,
    ),
    SpecialScreenType.cameras: SpecialScreenDefinition(
      CamerasScreenOptions.fromJson,
    ),
  };
}

@JsonSerializable()
class SpecialScreenConfig {
  @JsonKey(defaultValue: '')
  String id;
  @JsonKey(
    defaultValue: SpecialScreenType.unknown,
    unknownEnumValue: SpecialScreenType.unknown,
  )
  final SpecialScreenType type;
  String? _unsupportedType;
  String name;
  bool enabled;
  @JsonKey(fromJson: _parseSchedule)
  SpecialScreenSchedule schedule;
  @JsonKey(fromJson: _parseDisplayTime)
  int displayTimeMs;
  @JsonKey(fromJson: _parsedOptions)
  final SpecialScreenOptions options;
  SpecialScreenConfig({
    required this.id,
    required this.type,
    this.name = '',
    this.enabled = false,
    SpecialScreenSchedule? schedule,
    this.displayTimeMs = 10000,
    SpecialScreenOptions? options,
  }) : schedule = schedule ?? SpecialScreenSchedule(),
       options =
           options ??
           SpecialScreenRegistry.definitions[type]?.defaults() ??
           UnknownScreenOptions({});
  static SpecialScreenSchedule _parseSchedule(dynamic value) =>
      SpecialScreenSchedule.fromJson(_map(value));
  static SpecialScreenOptions _parsedOptions(dynamic value) =>
      value as SpecialScreenOptions;
  bool get isSupported => SpecialScreenRegistry.definitions.containsKey(type);
  factory SpecialScreenConfig.fromJson(Map<String, dynamic> json) {
    // The discriminator belongs to the envelope, so choose the concrete options
    // before delegating the common configuration fields to JsonSerializable.
    final type =
        SpecialScreenType.values.asNameMap()[json['type']] ??
        SpecialScreenType.unknown;
    final options =
        SpecialScreenRegistry.definitions[type]?.parseOptions(
          _map(json['options']),
        ) ??
        UnknownScreenOptions.fromJson(_map(json['options']));
    final result = _$SpecialScreenConfigFromJson({...json, 'options': options});
    if (type == SpecialScreenType.unknown)
      result._unsupportedType = json['type'] as String?;
    return result;
  }
  Map<String, dynamic> toJson() {
    final defaults =
        _$SpecialScreenConfigToJson(SpecialScreenConfig(id: '', type: type))
          ..remove('id')
          ..remove('type');
    // Preserve opaque options of future types, even an explicitly empty payload.
    if (!isSupported) defaults.remove('options');
    final result = stripDefaults(_$SpecialScreenConfigToJson(this), defaults);
    if (_unsupportedType != null) result['type'] = _unsupportedType;
    return result;
  }

  SpecialScreenConfig clone() => SpecialScreenConfig.fromJson(toJson());
}
