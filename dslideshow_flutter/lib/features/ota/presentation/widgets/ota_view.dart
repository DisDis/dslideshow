import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/features/header/presentation/widgets/buttons_hint/button_hint_action.dart';
import 'package:dslideshow_flutter/features/header/presentation/widgets/buttons_hint/page_buttons_hint.dart';

import 'dart:math' as math;

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
                        builder: (context, constraints) {
                          final statusHeight = math.min(
                            ThemeSettings.otaStatusPanelHeight,
                            constraints.maxHeight * .45,
                          );
                          final emptyMessage = switch (state) {
                            OtaProgressState(:final info)
                                when info.status == OTAStatus.uploading =>
                              AppLocalizations.of(context)
                                  .otaTransferLogPending,
                            OtaProgressState() => AppLocalizations.of(
                              context,
                            ).otaInstallLogPending,
                            _ => null,
                          };
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(
                                height: statusHeight,
                                child: SingleChildScrollView(
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      minHeight: statusHeight,
                                    ),
                                    child: _StatusPanel(state: state),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              Expanded(
                                child: OtaTerminalPanel(
                                  session: session,
                                  emptyMessage: emptyMessage,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
        if (state.canReturnToSlideshow)
          PageButtonsHint(
            frontend: context.read<OtaBloc>().frontendService,
            buttons: injector<AppConfig>().slideshow.buttons,
            bindings: const {
              ButtonType.button0: ButtonHintBinding(
                action: ButtonHintAction.back,
              ),
            },
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
  static const _percentStyle = TextStyle(
    color: ThemeColors.otaProgressPercentColor,
    fontSize: ThemeSettings.otaProgressPercentSize,
    fontWeight: FontWeight.w900,
  );

  double _percentWidth(BuildContext context) {
    // Reserve the widest value at the actual font and accessibility scale.
    // A fixed width can wrap the percent sign when the transfer reaches 100%.
    final painter = TextPainter(
      text: TextSpan(
        text: '100%',
        style: DefaultTextStyle.of(context).style.merge(_percentStyle),
      ),
      textDirection: Directionality.of(context),
      textScaler: MediaQuery.textScalerOf(context),
      locale: Localizations.localeOf(context),
      maxLines: 1,
    );
    try {
      painter.layout();
      return painter.width.ceilToDouble();
    } finally {
      painter.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final uploading =
        state is OtaProgressState && state.info.status == OTAStatus.uploading;
    final working = state is OtaProgressState;
    final restarting =
        state is OtaSuccessState && state.info.status == OTAStatus.preReboot;
    final percent = state.info.uploadingPercent.isFinite
        ? state.info.uploadingPercent.clamp(0, 100)
        : 0;
    final heading = switch (state) {
      OtaProgressState() => _StatusHeading(
        title: uploading ? l10n.otaReceiving : l10n.otaInstalling,
        message: l10n.otaDoNotPowerOff,
        detail: uploading ? l10n.otaTransferHint : l10n.otaInstallationHint,
        icon: uploading ? Icons.download_rounded : Icons.settings_outlined,
        color: ThemeColors.otaAccentColor,
      ),
      OtaFailureState(:final info) => _StatusHeading(
        title: l10n.otaFailed,
        message: info.errorText?.isNotEmpty == true
            ? info.errorText!
            : l10n.otaUnknownError,
        detail: l10n.otaLogDetails,
        icon: Icons.error_outline,
        color: ThemeColors.otaErrorTextColor,
      ),
      OtaSuccessState() => _StatusHeading(
        title: restarting ? l10n.otaRestartTitle : l10n.otaInstalled,
        message: restarting ? l10n.otaDoNotPowerOff : l10n.otaWaitingRestart,
        icon: restarting ? Icons.restart_alt : Icons.check_circle_outline,
        color: restarting
            ? ThemeColors.otaAccentColor
            : ThemeColors.otaSuccessTextColor,
      ),
      OtaExitState() => _StatusHeading(
        title: l10n.otaLeaving,
        message: '',
        icon: Icons.exit_to_app,
      ),
      OtaInitialState() || OtaReadyState() => const SizedBox.shrink(),
    };
    final progress = Text(
      '${percent.toStringAsFixed(0)}%',
      style: _percentStyle,
      maxLines: 1,
      softWrap: false,
      textAlign: TextAlign.right,
    );
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: ThemeColors.otaCardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: ThemeColors.otaReadyInputBorderColor),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 1600) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    heading,
                    if (uploading)
                      Align(alignment: Alignment.centerRight, child: progress),
                  ],
                );
              }
              return Row(
                children: [
                  Expanded(child: heading),
                  const SizedBox(width: 32),
                  SizedBox(
                    width: _percentWidth(context),
                    child: uploading ? progress : null,
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 24),
          _StageSequence(state: state),
          const SizedBox(height: 16),
          SizedBox(
            height: ThemeSettings.otaProgressBarHeight,
            child: working
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: uploading ? percent / 100 : null,
                      minHeight: ThemeSettings.otaProgressBarHeight,
                      backgroundColor: ThemeColors.otaProgressBgColor,
                      color: ThemeColors.otaProgressIconColor,
                    ),
                  )
                : null,
          ),
          if (working && !environment.isLinuxEmbedded) ...[
            const SizedBox(height: 12),
            const Align(
              alignment: Alignment.centerRight,
              child: TestConfigButton(),
            ),
          ],
        ],
      ),
    );
  }
}

class _StatusHeading extends StatelessWidget {
  const _StatusHeading({
    required this.title,
    required this.message,
    required this.icon,
    this.detail,
    this.color = ThemeColors.otaAccentColor,
  });

  final String title;
  final String message;
  final String? detail;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 200),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox.square(
            dimension: ThemeSettings.otaStageIconAreaSize,
            child: Center(
              child: Icon(
                icon,
                size: ThemeSettings.otaStageIconSize,
                color: color,
              ),
            ),
          ),
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
      ),
    );
  }
}

enum _OtaStep { receiving, installing, restarting }

class _StageSequence extends StatelessWidget {
  const _StageSequence({required this.state});
  final OtaState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final current = switch (state) {
      OtaProgressState(:final info) =>
        info.status == OTAStatus.uploading
            ? _OtaStep.receiving
            : _OtaStep.installing,
      OtaSuccessState() => _OtaStep.restarting,
      _ => null,
    };
    return Wrap(
      spacing: 16,
      runSpacing: 12,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (final step in _OtaStep.values)
          Semantics(
            selected: step == current,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: step == current
                      ? ThemeColors.otaAccentColor
                      : ThemeColors.otaReadyInputBorderColor,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (current != null && step.index < current.index) ...[
                    const Icon(
                      Icons.check,
                      size: 24,
                      color: ThemeColors.otaSuccessTextColor,
                    ),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    switch (step) {
                      _OtaStep.receiving => l10n.otaStepReceive,
                      _OtaStep.installing => l10n.otaStepInstall,
                      _OtaStep.restarting => l10n.otaStepRestart,
                    },
                    style: TextStyle(
                      color: step == current
                          ? ThemeColors.otaAccentColor
                          : current != null && step.index < current.index
                          ? ThemeColors.otaSuccessTextColor
                          : ThemeColors.otaProgressSubtextColor,
                      fontSize: ThemeSettings.otaReadyNormalTextSize,
                      fontWeight: step == current
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
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
