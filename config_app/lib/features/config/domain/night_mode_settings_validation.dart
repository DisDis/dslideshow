import 'package:dslideshow_backend/config.dart';

extension NightModeSettingsValidation on NightModeConfig {
  void validateForSave() {
    if (startMinute < 0 || startMinute >= 1440 || endMinute < 0 || endMinute >= 1440 || startMinute == endMinute) {
      throw const FormatException('Night start and end must be different valid times');
    }
    final light = ambientLight;
    if (light.darkBelowLux < 0 || light.lightAboveLux <= light.darkBelowLux) {
      throw const FormatException('Light thresholds must be integers: 0 <= darkBelowLux < lightAboveLux');
    }
    if (light.maxAgeSec <= 0) throw const FormatException('Light maxAgeSec must be positive');
    if (light.enabled && (light.topic.trim().isEmpty || light.valueField.trim().isEmpty)) {
      throw const FormatException('Light topic and valueField are required');
    }
    for (final topic in [light.topic, light.availabilityTopic]) {
      if (topic.contains('#') || topic.contains('+') || topic.contains('\u0000')) {
        throw const FormatException('Light topics must be exact MQTT topics');
      }
    }
    if (light.availabilityTopic.isNotEmpty && light.topic == light.availabilityTopic) {
      throw const FormatException('Light state and availability topics must differ');
    }
  }
}
