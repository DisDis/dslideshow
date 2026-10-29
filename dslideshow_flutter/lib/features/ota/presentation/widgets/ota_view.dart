import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_common/version.dart';
import 'package:dslideshow_flutter/environment.dart' as environment;
import 'package:dslideshow_flutter/features/header/presentation/widgets/common_header.dart';
import 'package:dslideshow_flutter/features/ota/presentation/bloc/ota_bloc.dart';
import 'package:dslideshow_flutter/features/ota/presentation/bloc/ota_state.dart';
import 'package:dslideshow_flutter/features/ota/presentation/bloc/ota_terminal_session.dart';
import 'package:dslideshow_flutter/features/ota/presentation/widgets/ota_ready_widget.dart';
import 'package:dslideshow_flutter/features/ota/presentation/widgets/ota_terminal_panel.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/status/slideshow_status_bloc.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/debug_widget.dart';
import 'package:dslideshow_flutter/features/theme/presentation/theme.dart';
import 'package:dslideshow_flutter/src/injector.dart';
import 'package:dslideshow_flutter/src/route_bloc.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OTAView extends StatelessWidget {
  const OTAView({super.key, required this.session});

  final OtaTerminalSession session;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<OtaBloc>().state;
    if (state is OtaReadyState) return OtaReadyWidget(state: state);
    return Stack(
      children: [
        Column(
          children: [
            const CommonHeaderWidget(),
            Expanded(
              child: state is OtaInitialState
                  ? const _PreparingPanel()
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
                      child: LayoutBuilder(
                        builder: (context, constraints) => Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: constraints.maxHeight * .45,
                              ),
                              child: SingleChildScrollView(
                                child: _StatusPanel(state: state),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Expanded(child: OtaTerminalPanel(session: session)),
                          ],
                        ),
                      ),
                    ),
            ),
          ],
        ),
        if (!environment.isLinuxEmbedded)
          BlocBuilder<SlideshowStatusBloc, SlideshowStatusState>(
            builder: (context, state) => DebugWidget(injector(), injector()),
          ),
      ],
    );
  }
}

class _PreparingPanel extends StatelessWidget {
  const _PreparingPanel();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.otaTitle,
              style: const TextStyle(
                color: ThemeColors.otaReadyHeaderTextColor,
                fontSize: ThemeSettings.otaReadyTitleSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              l10n.otaCurrentVersion,
              style: const TextStyle(
                color: ThemeColors.otaReadyNormalTextColor,
                fontSize: ThemeSettings.otaReadyNormalTextSize,
              ),
            ),
            Text(
              'v${ApplicationInfo.frontendVersion}',
              style: const TextStyle(
                color: ThemeColors.otaVersionCurrentColor,
                fontSize: ThemeSettings.otaReadyVersionSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            const CircularProgressIndicator(color: ThemeColors.otaAccentColor),
            const SizedBox(height: 24),
            Text(
              l10n.otaPreparing,
              style: const TextStyle(
                color: ThemeColors.otaReadyNormalTextColor,
                fontSize: ThemeSettings.otaReadyNormalTextSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusPanel extends StatelessWidget {
  const _StatusPanel({required this.state});
  final OtaState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: ThemeColors.otaCardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: ThemeColors.otaReadyInputBorderColor),
      ),
      child: switch (state) {
        OtaProgressState(:final info) => _buildProgress(context, info),
        OtaFailureState(:final info) => _StatusHeading(
          title: l10n.otaFailed,
          message: info.errorText?.isNotEmpty == true
              ? info.errorText!
              : l10n.otaUnknownError,
          detail: l10n.otaLogDetails,
          icon: Icons.error_outline,
          color: ThemeColors.otaErrorTextColor,
        ),
        OtaSuccessState(:final info) => _StatusHeading(
          title: l10n.otaComplete,
          message: info.status == OTAStatus.preReboot
              ? l10n.otaRestarting
              : l10n.otaWaitingRestart,
          detail: l10n.otaStageComplete,
          icon: Icons.check_circle_outline,
          color: ThemeColors.otaSuccessTextColor,
        ),
        OtaExitState() => _StatusHeading(
          title: l10n.otaLeaving,
          message: '',
          icon: Icons.exit_to_app,
        ),
        OtaInitialState() || OtaReadyState() => const SizedBox.shrink(),
      },
    );
  }

  Widget _buildProgress(BuildContext context, OTAInfo info) {
    final l10n = AppLocalizations.of(context);
    final uploading = info.status == OTAStatus.uploading;
    final percent = info.uploadingPercent.isFinite
        ? info.uploadingPercent.clamp(0, 100)
        : 0;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final heading = _StatusHeading(
              title: uploading ? l10n.otaUploading : l10n.otaInstalling,
              message: l10n.otaDoNotPowerOff,
              detail: uploading
                  ? l10n.otaStageUpload
                  : l10n.otaInstallationHint,
              icon: uploading
                  ? Icons.cloud_upload_outlined
                  : Icons.system_update_alt,
            );
            if (!uploading) return heading;
            final progress = Text(
              '${percent.toStringAsFixed(0)}%',
              style: const TextStyle(
                color: ThemeColors.otaProgressPercentColor,
                fontSize: ThemeSettings.otaProgressPercentSize,
                fontWeight: FontWeight.w900,
              ),
            );
            if (constraints.maxWidth < 1000) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [heading, progress],
              );
            }
            return Row(
              children: [
                Expanded(child: heading),
                const SizedBox(width: 32),
                progress,
              ],
            );
          },
        ),
        const SizedBox(height: 24),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: uploading ? percent / 100 : null,
            minHeight: ThemeSettings.otaProgressBarHeight,
            backgroundColor: ThemeColors.otaProgressBgColor,
            color: ThemeColors.otaProgressIconColor,
          ),
        ),
        if (!environment.isLinuxEmbedded) ...[
          const SizedBox(height: 12),
          const Align(
            alignment: Alignment.centerRight,
            child: TestConfigButton(),
          ),
        ],
      ],
    );
  }
}

class _StatusHeading extends StatelessWidget {
  const _StatusHeading({
    required this.title,
    required this.message,
    required this.icon,
    this.detail,
    this.color = ThemeColors.otaProgressTextColor,
  });

  final String title;
  final String message;
  final String? detail;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 64, color: color),
        const SizedBox(width: 24),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: ThemeSettings.otaProgressTitleSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (message.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  message,
                  style: const TextStyle(
                    color: ThemeColors.otaProgressTextColor,
                    fontSize: ThemeSettings.otaProgressSubtitleSize,
                  ),
                ),
              ],
              if (detail != null) ...[
                const SizedBox(height: 8),
                Text(
                  detail!,
                  style: const TextStyle(
                    color: ThemeColors.otaProgressSubtextColor,
                    fontSize: ThemeSettings.otaProgressSubtitleSize,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class TestConfigButton extends StatelessWidget {
  const TestConfigButton({super.key});
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        foregroundColor: ThemeColors.otaDevButtonColor,
      ),
      onPressed: () =>
          context.read<RouteBloc>().add(ChangePageEvent(RoutePage.config)),
      icon: const Icon(Icons.settings),
      label: Text(AppLocalizations.of(context).otaDevConfig),
    );
  }
}
