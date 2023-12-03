import 'package:json_annotation/json_annotation.dart';
import 'package:logging/logging.dart';

part 'slideshow_config.g.dart';

@JsonSerializable()
class SlideShowConfig {
  static final Logger _log = new Logger('SlideShowConfig');

  @JsonKey(fromJson: _parseButtons)
  SlideShowButtonBind buttons;

  static SlideShowButtonBind _parseButtons(dynamic data) {
    _log.info("- parsing 'buttons' bind");
    final dataV = data is Map<String, dynamic> ? data : <String, dynamic>{};
    return SlideShowButtonBind.fromJson(dataV);
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
      return int.tryParse(value, radix: 16) ?? SlideShowConfig.DEFAULT_BACKGROUND_COLOR;
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
  });

  factory SlideShowConfig.fromJson(Map<String, dynamic> json) => _$SlideShowConfigFromJson(json);

  Map<String, dynamic> toJson() => _$SlideShowConfigToJson(this);
}

@JsonSerializable()
class SlideShowButtonBind {
  @JsonKey(fromJson: _parseAction, toJson: _actionToJson, defaultValue: SlideshowAction.pause)
  SlideshowAction button0;
  @JsonKey(fromJson: _parseAction, toJson: _actionToJson, defaultValue: SlideshowAction.showMenu)
  SlideshowAction button1;
  @JsonKey(fromJson: _parseAction, toJson: _actionToJson, defaultValue: SlideshowAction.toggleScreen)
  SlideshowAction button2;
  @JsonKey(fromJson: _parseAction, toJson: _actionToJson, defaultValue: SlideshowAction.showInfo)
  SlideshowAction button3;

  SlideShowButtonBind({
    required this.button0,
    required this.button1,
    required this.button2,
    required this.button3,
  });

  static String _actionToJson(SlideshowAction value) {
    return value.toString();
  }

  static SlideshowAction _parseAction(dynamic value) {
    if (value == null) {
      return SlideshowAction.pause;
    }
    return SlideshowAction.values.firstWhere((item) => item.toString() == value, orElse: () => SlideshowAction.pause);
  }

  factory SlideShowButtonBind.fromJson(Map<String, dynamic> json) => _$SlideShowButtonBindFromJson(json);

  Map<String, dynamic> toJson() => _$SlideShowButtonBindToJson(this);
}

enum SlideshowAction {
  pause,
  toggleScreen,
  showMenu,
  showInfo;
}
