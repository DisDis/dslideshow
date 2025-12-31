import 'package:json_annotation/json_annotation.dart';
import 'package:logging/logging.dart';

part 'slideshow_config.g.dart';

@JsonSerializable()
class SlideShowConfig {
  static final Logger _log = new Logger('SlideShowConfig');

  @JsonKey(fromJson: _parseButtons)
  SlideShowButtons buttons;

  @JsonKey(fromJson: _parseMenu)
  SlideShowMenuConfig menu;

  static SlideShowButtons _parseButtons(dynamic data) {
    _log.info("- parsing 'buttons' bind");
    final dataV = data is Map<String, dynamic> ? data : <String, dynamic>{};
    try {
      return SlideShowButtons.fromJson(dataV);
    } catch (e) {
      return SlideShowButtons(
        button0: SlideShowButtonConfig(
          action: SlideshowAction.showInfo,
          minPressingMs: 500,
        ),
        button1: SlideShowButtonConfig(
          action: SlideshowAction.toggleScreen,
          minPressingMs: 800,
        ),
        button2: SlideShowButtonConfig(
          action: SlideshowAction.showMenu,
          minPressingMs: 500,
        ),
        button3: SlideShowButtonConfig(
          action: SlideshowAction.pause,
          minPressingMs: 200,
        ),
        hintOffsetX: 320,
        hintOffsetY: 20,
      );
    }
  }

  static SlideShowMenuConfig _parseMenu(dynamic data) {
    _log.info("- parsing 'menu'");
    final dataV = data is Map<String, dynamic> ? data : <String, dynamic>{};
    return SlideShowMenuConfig.fromJson(dataV);
  }

  @JsonKey(defaultValue: 5000)
  int displayTimeMs;

  @JsonKey(defaultValue: 2000)
  int fadeTimeMs;

  /// How long do images change
  @JsonKey(defaultValue: 1000)
  int transitionTimeMs;

  /// Allowed effects
  @JsonKey(fromJson: _parseAllowedEffects)
  Iterable<String> allowedEffects;

  static List<String> _parseAllowedEffects(dynamic value) {
    final valueI = value is List<dynamic> ? value : <dynamic>[];
    return List<String>.from(valueI.map<String>((dynamic i) => i.toString()));
  }

  ///create a blurred background
  @JsonKey(defaultValue: true)
  bool isBlurredBackground;

  @JsonKey(defaultValue: 20)
  int backgroundBlurSigma;
  @JsonKey(defaultValue: 0.9)
  double backgroundOpacity;
  static const int DEFAULT_BACKGROUND_COLOR = 0xFFFFFFFF;
  @JsonKey(
    defaultValue: SlideShowConfig.DEFAULT_BACKGROUND_COLOR,
    fromJson: _parseColor,
    toJson: _colorToJson,
  )
  int backgroundColor;
  static int _parseColor(dynamic value) {
    if (value is int) {
      return value;
    }
    if (value is String) {
      return int.tryParse(value, radix: 16) ??
          SlideShowConfig.DEFAULT_BACKGROUND_COLOR;
    }
    return SlideShowConfig.DEFAULT_BACKGROUND_COLOR;
  }

  static String _colorToJson(int color) {
    return color.toRadixString(16);
  }

  SlideShowConfig({
    required this.allowedEffects,
    required this.backgroundBlurSigma,
    required this.backgroundColor,
    required this.backgroundOpacity,
    required this.displayTimeMs,
    required this.fadeTimeMs,
    required this.isBlurredBackground,
    required this.transitionTimeMs,
    required this.buttons,
    required this.menu,
  });

  factory SlideShowConfig.fromJson(Map<String, dynamic> json) =>
      _$SlideShowConfigFromJson(json);

  Map<String, dynamic> toJson() => _$SlideShowConfigToJson(this);
}

@JsonSerializable()
class SlideShowButtons {
  SlideShowButtonConfig button0;
  SlideShowButtonConfig button1;
  SlideShowButtonConfig button2;
  SlideShowButtonConfig button3;

  @JsonKey(defaultValue: 320)
  int hintOffsetX;
  @JsonKey(defaultValue: 20)
  int hintOffsetY;

  SlideShowButtons({
    required this.button0,
    required this.button1,
    required this.button2,
    required this.button3,
    required this.hintOffsetX,
    required this.hintOffsetY,
  });

  factory SlideShowButtons.fromJson(Map<String, dynamic> json) =>
      _$SlideShowButtonsFromJson(json);

  Map<String, dynamic> toJson() => _$SlideShowButtonsToJson(this);
}

@JsonSerializable()
class SlideShowButtonConfig {
  @JsonKey(
    fromJson: _parseAction,
    toJson: _actionToJson,
    defaultValue: SlideshowAction.none,
  )
  SlideshowAction action;
  @JsonKey(defaultValue: 200)
  int minPressingMs;

  SlideShowButtonConfig({required this.action, required this.minPressingMs});
  static String _actionToJson(SlideshowAction value) {
    return value.toString();
  }

  static SlideshowAction _parseAction(dynamic value) {
    if (value == null) {
      return SlideshowAction.none;
    }
    return SlideshowAction.values.firstWhere(
      (item) => item.toString() == value,
      orElse: () => SlideshowAction.none,
    );
  }

  factory SlideShowButtonConfig.fromJson(Map<String, dynamic> json) =>
      _$SlideShowButtonConfigFromJson(json);

  Map<String, dynamic> toJson() => _$SlideShowButtonConfigToJson(this);
}

@JsonSerializable()
class SlideShowMenuConfig {
  @JsonKey(defaultValue: 200)
  int minPressingMs;
  SlideShowMenuConfig({required this.minPressingMs});
  factory SlideShowMenuConfig.fromJson(Map<String, dynamic> json) =>
      _$SlideShowMenuConfigFromJson(json);
  Map<String, dynamic> toJson() => _$SlideShowMenuConfigToJson(this);
}

enum SlideshowAction { none, pause, toggleScreen, showMenu, showInfo }
