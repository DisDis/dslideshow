import 'package:dslideshow_backend/config.dart';

enum WakeField { absence, start, end, topic, valueField, availabilityTopic, darkBelow, lightAbove, maxAge }

enum WakeInputError {
  integer,
  nonnegativeInteger,
  time,
  differentTimes,
  required,
  exactTopic,
  differentTopics,
  lightThreshold,
  positiveInteger,
}

extension NightModeSettingsValidation on NightModeConfig {
  Map<WakeField, WakeInputError> get validationErrors {
    final errors = <WakeField, WakeInputError>{};
    if (startMinute < 0 || startMinute >= 1440) {
      errors[WakeField.start] = WakeInputError.time;
    }
    if (endMinute < 0 || endMinute >= 1440) {
      errors[WakeField.end] = WakeInputError.time;
    }
    if (errors.isEmpty && startMinute == endMinute) {
      errors[WakeField.end] = WakeInputError.differentTimes;
    }
    final light = ambientLight;
    if (light.darkBelowLux < 0) {
      errors[WakeField.darkBelow] = WakeInputError.nonnegativeInteger;
    }
    if (light.lightAboveLux <= light.darkBelowLux) {
      errors[WakeField.lightAbove] = WakeInputError.lightThreshold;
    }
    if (light.maxAgeSec <= 0) {
      errors[WakeField.maxAge] = WakeInputError.positiveInteger;
    }
    if (light.enabled && light.topic.trim().isEmpty) {
      errors[WakeField.topic] = WakeInputError.required;
    }
    if (light.enabled && light.valueField.trim().isEmpty) {
      errors[WakeField.valueField] = WakeInputError.required;
    }
    for (final (field, topic) in [
      (WakeField.topic, light.topic),
      (WakeField.availabilityTopic, light.availabilityTopic),
    ]) {
      if (topic.contains('#') || topic.contains('+') || topic.contains('\u0000')) {
        errors[field] = WakeInputError.exactTopic;
      }
    }
    if (light.availabilityTopic.trim().isNotEmpty && light.topic.trim() == light.availabilityTopic.trim()) {
      errors[WakeField.availabilityTopic] = WakeInputError.differentTopics;
    }
    return errors;
  }

  void validateForSave() {
    final errors = validationErrors;
    if (errors.isNotEmpty) {
      throw FormatException(
        'Invalid night settings: ${errors.entries.map((entry) => '${entry.key.name}=${entry.value.name}').join(', ')}',
      );
    }
  }
}
