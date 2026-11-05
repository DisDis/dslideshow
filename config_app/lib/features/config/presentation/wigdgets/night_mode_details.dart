import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String nightModeLabel(AppLocalizations l, NightMode mode) => switch (mode) {
  NightMode.scheduleOnly => l.night_schedule_only,
  NightMode.scheduleOrDarkness => l.night_schedule_or_dark,
  NightMode.scheduleAndDarkness => l.night_schedule_and_dark,
};

class NightModeDetails extends StatelessWidget {
  const NightModeDetails({super.key, required this.frame});
  final FrameState frame;

  @override
  Widget build(BuildContext context) {
    final l = context.localizations;
    final night = frame.nightMode;
    final time = frame.deviceLocalTime;
    final number = NumberFormat.decimalPattern(Localizations.localeOf(context).toLanguageTag());
    final reason = switch (night.reason) {
      AutomaticSleepReason.schedule => l.night_reason_schedule,
      AutomaticSleepReason.darkness => l.night_reason_dark,
      AutomaticSleepReason.scheduleAndDarkness => l.night_reason_both,
      AutomaticSleepReason.lightUnavailable => l.night_reason_unknown,
      AutomaticSleepReason.none => l.night_wake_allowed,
    };
    final lightStatus = switch (night.lightStatus) {
      AmbientLightStatus.disabled => l.disabled_label,
      AmbientLightStatus.unavailable => l.night_light_unavailable,
      AmbientLightStatus.unknown => l.unknown_state,
      AmbientLightStatus.stale => l.night_light_stale,
      AmbientLightStatus.dark => l.night_light_dark,
      AmbientLightStatus.light => l.night_light_bright,
    };
    return Column(
      key: const ValueKey('night-mode-details'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${l.night_device_time}: ${time.toIso8601String().split('.').first}'),
        Text('${l.night_active_settings}: ${night.enabled ? nightModeLabel(l, night.mode) : l.disabled_label}'),
        Text(reason),
        if (night.nextBoundary != null)
          Text('${l.night_next_boundary}: ${night.nextBoundary!.toIso8601String().split('.').first}'),
        Text('${l.night_light_status}: $lightStatus'),
        if (night.illuminance != null) Text('${l.night_illuminance}: ${number.format(night.illuminance)} lx'),
        if (night.lightReceivedAt != null)
          Text('${l.night_received_at}: ${night.lightReceivedAt!.toUtc().toIso8601String()}'),
      ],
    );
  }
}
