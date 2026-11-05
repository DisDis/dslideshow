import 'package:config_app/features/config/presentation/wigdgets/night_mode_details.dart';
import 'package:config_app/features/device/data/device_repository.dart';
import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_common/storage_status.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DeviceStatusCard extends StatelessWidget {
  const DeviceStatusCard({
    super.key,
    required this.frame,
    required this.stale,
    required this.failure,
    required this.canControl,
    required this.pendingControl,
    required this.detailsExpanded,
    required this.onDetailsChanged,
    this.onControl,
  });

  final FrameState frame;
  final bool stale;
  final DeviceFailureKind? failure;
  final bool canControl;
  final FrameControl? pendingControl;
  final bool detailsExpanded;
  final ValueChanged<bool> onDetailsChanged;
  final void Function(FrameControl, bool)? onControl;

  String _page(BuildContext context, FramePage page) {
    final l = context.localizations;
    return switch (page) {
      FramePage.slideshow => l.device_playback,
      FramePage.welcome => l.device_page_welcome,
      FramePage.config => l.device_page_config,
      FramePage.ota => l.device_page_ota,
      FramePage.unknown => l.unknown_state,
    };
  }

  String _phase(BuildContext context) {
    final l = context.localizations;
    return switch (frame.screenPhase) {
      FrameScreenPhase.on => l.device_screen_on,
      FrameScreenPhase.off => l.device_screen_off,
      FrameScreenPhase.waitingOff => l.device_screen_waiting,
      FrameScreenPhase.fadingOut => l.device_screen_fading_out,
      FrameScreenPhase.poweringOff => l.device_screen_powering_off,
      FrameScreenPhase.wakingUp => l.device_screen_waking,
      FrameScreenPhase.fadingIn => l.device_screen_fading_in,
      FrameScreenPhase.failed => l.device_screen_failed,
      FrameScreenPhase.unknown => l.unknown_state,
    };
  }

  String _summary(BuildContext context) {
    final l = context.localizations;
    final frontend = frame.frontend;
    switch (frame.screenPhase) {
      case FrameScreenPhase.failed:
      case FrameScreenPhase.fadingOut:
      case FrameScreenPhase.poweringOff:
      case FrameScreenPhase.wakingUp:
      case FrameScreenPhase.fadingIn:
        return _phase(context);
      case FrameScreenPhase.on:
      case FrameScreenPhase.off:
      case FrameScreenPhase.waitingOff:
      case FrameScreenPhase.unknown:
        break;
    }
    if (frame.isScreenOn == false) return l.device_summary_screen_off;
    if (frame.isScreenOn == null) return l.device_summary_screen_unknown;
    if (frontend == null) return l.device_summary_frontend_unavailable;
    if (frontend.page != FramePage.slideshow) return _page(context, frontend.page);
    if (frontend.isMenu) return l.device_summary_menu_open;
    return frontend.isPaused ? l.device_paused : l.device_summary_playing;
  }

  String _time(BuildContext context, DateTime value, {bool utc = false}) {
    final format = DateFormat.yMd(Localizations.localeOf(context).toLanguageTag()).add_Hms();
    return utc ? '${format.format(value.toUtc())} UTC' : format.format(value);
  }

  String _nightReason(BuildContext context) {
    final l = context.localizations;
    return switch (frame.nightMode.reason) {
      AutomaticSleepReason.schedule => l.night_reason_schedule,
      AutomaticSleepReason.darkness => l.night_reason_dark,
      AutomaticSleepReason.scheduleAndDarkness => l.night_reason_both,
      AutomaticSleepReason.lightUnavailable => l.night_reason_unknown,
      AutomaticSleepReason.none => l.night_wake_allowed,
    };
  }

  @override
  Widget build(BuildContext context) {
    final l = context.localizations;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final frontend = frame.frontend;
    final night = frame.nightMode;
    final screen = switch (frame.isScreenOn) {
      true => l.device_screen_on,
      false => l.device_screen_off,
      null => l.unknown_state,
    };
    final storage = switch (frame.storageStatus) {
      StorageStatusEnum.download => l.device_storage_downloading,
      StorageStatusEnum.off => l.device_storage_unavailable,
      StorageStatusEnum.done => l.device_storage_ready,
      StorageStatusEnum.error => l.device_storage_error,
    };
    final light = switch (night.lightStatus) {
      AmbientLightStatus.disabled => l.disabled_label,
      AmbientLightStatus.unavailable => l.night_light_unavailable,
      AmbientLightStatus.unknown => l.unknown_state,
      AmbientLightStatus.stale => l.night_light_stale,
      AmbientLightStatus.dark => l.night_light_dark,
      AmbientLightStatus.light => l.night_light_bright,
    };
    return Card(
      key: const ValueKey('device-status-card'),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(color: colors.secondaryContainer, borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Icon(Icons.settings_remote_outlined, color: colors.onSecondaryContainer),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l.device_status_title, style: theme.textTheme.titleMedium),
                      const SizedBox(height: 4),
                      Text(
                        '${l.device_sample_time}: ${_time(context, frame.sampledAt, utc: true)}',
                        style: theme.textTheme.bodySmall?.copyWith(color: colors.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              _summary(context),
              key: const ValueKey('device-status-summary'),
              style: theme.textTheme.headlineSmall?.copyWith(
                color: frame.screenPhase == FrameScreenPhase.failed ? colors.error : colors.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: [
                Text('${l.device_screen}: $screen'),
                if (frontend != null) ...[
                  Text('${l.device_current_page}: ${_page(context, frontend.page)}'),
                  Text('${l.device_menu}: ${frontend.isMenu ? l.device_menu_open : l.device_menu_closed}'),
                ],
              ],
            ),
            if (failure != null) ...[
              const SizedBox(height: 16),
              _StatusNotice(
                error: true,
                text: switch (failure!) {
                  DeviceFailureKind.command => l.device_command_failed,
                  DeviceFailureKind.disconnected => l.device_disconnected,
                  _ => l.device_load_failed,
                },
              ),
            ],
            if (stale) ...[const SizedBox(height: 12), _StatusNotice(text: l.device_stale)],
            if (onControl != null) ...[
              if (frontend == null) ...[
                const SizedBox(height: 12),
                _StatusNotice(text: l.device_frontend_unavailable),
              ] else if (frontend.page != FramePage.slideshow) ...[
                const SizedBox(height: 12),
                _StatusNotice(text: l.device_controls_context),
              ],
              const SizedBox(height: 20),
              _actions(context),
            ],
            const Padding(padding: EdgeInsets.symmetric(vertical: 20), child: Divider()),
            _StatusValue(
              label: l.device_storage_status,
              value: storage,
              icon: switch (frame.storageStatus) {
                StorageStatusEnum.done => Icons.check_circle_outline,
                StorageStatusEnum.download => Icons.sync,
                StorageStatusEnum.off => Icons.storage_outlined,
                StorageStatusEnum.error => Icons.error_outline,
              },
              error: frame.storageStatus == StorageStatusEnum.error,
            ),
            _StatusValue(label: l.device_auto_wake, value: frame.autoWakeEnabled ? l.enabled_label : l.disabled_label),
            _StatusValue(
              label: l.device_night_mode,
              value: night.enabled ? nightModeLabel(l, night.mode) : l.disabled_label,
            ),
            if (!frame.autoWakeEnabled || night.enabled) ...[
              const SizedBox(height: 8),
              _StatusNotice(
                icon: Icons.bedtime_outlined,
                text: [
                  if (!frame.autoWakeEnabled) l.device_auto_wake_disabled_help,
                  if (night.enabled) _nightReason(context),
                  if (night.nextBoundary != null) '${l.night_next_boundary}: ${_time(context, night.nextBoundary!)}',
                ].join('\n'),
              ),
            ],
            const SizedBox(height: 8),
            TextButton.icon(
              key: const ValueKey('device-details-toggle'),
              onPressed: () => onDetailsChanged(!detailsExpanded),
              icon: Icon(detailsExpanded ? Icons.expand_less : Icons.expand_more),
              label: Text(detailsExpanded ? l.device_hide_details : l.device_state_details),
              style: TextButton.styleFrom(alignment: Alignment.centerLeft, minimumSize: const Size(48, 48)),
            ),
            if (detailsExpanded) ...[
              const SizedBox(height: 8),
              if (frontend != null)
                _StatusValue(label: l.device_playback, value: frontend.isPaused ? l.device_paused : l.device_playing),
              _StatusValue(label: l.device_screen_phase, value: _phase(context)),
              _StatusValue(label: l.night_device_time, value: _time(context, frame.deviceLocalTime)),
              _StatusValue(label: l.night_light_status, value: light),
              if (night.illuminance != null)
                _StatusValue(
                  label: l.night_illuminance,
                  value:
                      '${NumberFormat.decimalPattern(Localizations.localeOf(context).toLanguageTag()).format(night.illuminance)} lx',
                ),
              if (night.lightReceivedAt != null)
                _StatusValue(label: l.night_received_at, value: _time(context, night.lightReceivedAt!, utc: true)),
              const SizedBox(height: 8),
              Text(
                l.device_screen_power_help,
                style: theme.textTheme.bodySmall?.copyWith(color: colors.onSurfaceVariant),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _actions(BuildContext context) {
    final l = context.localizations;
    final frontend = frame.frontend;
    final available = canControl && frontend != null;
    final slideshow = available && frontend.page == FramePage.slideshow;
    final buttons = [
      FilledButton.icon(
        key: const ValueKey('device-pause'),
        onPressed: slideshow ? () => onControl!(FrameControl.pause, !frontend.isPaused) : null,
        icon: _pendingIcon(context, FrameControl.pause, frontend?.isPaused == true ? Icons.play_arrow : Icons.pause),
        label: Text(frontend?.isPaused == true ? l.preview_resume : l.preview_pause),
      ),
      FilledButton.tonalIcon(
        key: const ValueKey('device-menu'),
        onPressed: slideshow ? () => onControl!(FrameControl.menu, !frontend.isMenu) : null,
        icon: _pendingIcon(context, FrameControl.menu, Icons.menu),
        label: Text(frontend?.isMenu == true ? l.device_close_menu : l.device_open_menu),
      ),
      FilledButton.tonalIcon(
        key: const ValueKey('device-screen'),
        onPressed: available ? () => onControl!(FrameControl.screen, frame.isScreenOn != true) : null,
        icon: _pendingIcon(context, FrameControl.screen, Icons.power_settings_new),
        label: Text(frame.isScreenOn != true ? l.device_turn_on : l.device_turn_off),
      ),
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        final scale = MediaQuery.textScalerOf(context).scale(14) / 14;
        if (constraints.maxWidth >= 600 * scale) {
          return Wrap(spacing: 12, runSpacing: 12, children: buttons);
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var i = 0; i < buttons.length; i++) ...[if (i > 0) const SizedBox(height: 12), buttons[i]],
          ],
        );
      },
    );
  }

  Widget _pendingIcon(BuildContext context, FrameControl control, IconData icon) => pendingControl == control
      ? SizedBox.square(
          dimension: 18,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            semanticsLabel: context.localizations.device_control_sending,
          ),
        )
      : Icon(icon);
}

class _StatusValue extends StatelessWidget {
  const _StatusValue({required this.label, required this.value, this.icon, this.error = false});
  final String label;
  final String value;
  final IconData? icon;
  final bool error;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final content = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 18, color: error ? theme.colorScheme.error : theme.colorScheme.primary),
          const SizedBox(width: 6),
        ],
        Flexible(
          child: SelectableText(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: error ? theme.colorScheme.error : theme.colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final title = Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          );
          final scale = MediaQuery.textScalerOf(context).scale(14) / 14;
          if (constraints.maxWidth >= 420 * scale) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: title),
                const SizedBox(width: 16),
                Expanded(child: content),
              ],
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [title, const SizedBox(height: 4), content],
          );
        },
      ),
    );
  }
}

class _StatusNotice extends StatelessWidget {
  const _StatusNotice({required this.text, this.error = false, this.icon = Icons.info_outline});
  final String text;
  final bool error;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: error ? colors.errorContainer : colors.surfaceContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(error ? Icons.error_outline : icon, color: error ? colors.onErrorContainer : colors.onSurfaceVariant),
            const SizedBox(width: 10),
            Expanded(
              child: Text(text, style: TextStyle(color: error ? colors.onErrorContainer : colors.onSurface)),
            ),
          ],
        ),
      ),
    );
  }
}
