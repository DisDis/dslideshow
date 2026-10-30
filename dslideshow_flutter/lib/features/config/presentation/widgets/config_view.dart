import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/features/header/presentation/widgets/buttons_hint/button_hint_action.dart';
import 'package:dslideshow_flutter/features/header/presentation/widgets/buttons_hint/page_buttons_hint.dart';
import 'package:dslideshow_flutter/environment.dart';
import 'package:dslideshow_flutter/features/config/presentation/bloc/config_bloc.dart';
import 'package:dslideshow_flutter/features/config/presentation/bloc/config_event.dart';
import 'package:dslideshow_flutter/features/config/presentation/bloc/config_state.dart';
import 'package:dslideshow_flutter/features/header/presentation/widgets/common_header.dart';
import 'package:dslideshow_flutter/features/shared/presentation/widgets/access_layout.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/status/slideshow_status_bloc.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/debug_widget.dart';
import 'package:dslideshow_flutter/features/theme/presentation/theme.dart';
import 'package:dslideshow_flutter/src/injector.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfigView extends StatelessWidget {
  const ConfigView({super.key});
  @override
  Widget build(BuildContext context) => BlocBuilder<ConfigBloc, ConfigState>(
    builder: (context, state) {
      final l10n = AppLocalizations.of(context);
      final address = state.phase == ConfigPhase.ready
          ? state.address?.toString()
          : null;
      return Scaffold(
        backgroundColor: ThemeColors.configBackgroundColor,
        body: Stack(
          fit: StackFit.expand,
          children: [
            AccessLayout(
              hasAddress: address != null,
              panel: address != null
                  ? AccessQrCode(
                      address: address,
                      label: l10n.configPageScanStep,
                    )
                  : _StatusPanel(state: state),
              information: _Information(state: state, address: address),
            ),
            const CommonHeaderWidget(),
            if (state.exit == ConfigExitStatus.active ||
                state.exit == ConfigExitStatus.failed)
              PageButtonsHint(
                frontend: context.read<ConfigBloc>().repository.frontend,
                buttons: injector<AppConfig>().slideshow.buttons,
                bindings: {
                  ButtonType.button0: ButtonHintBinding(
                    action: state.phase == ConfigPhase.closeFailure
                        ? ButtonHintAction.returnUnconfirmed
                        : ButtonHintAction.back,
                  ),
                  if (_hasRetry(state))
                    ButtonType.button3: ButtonHintBinding(
                      action: _retryAction(state),
                      enabled: state.canRetry,
                    ),
                },
              ),
            if (!isLinuxEmbedded)
              BlocBuilder<SlideshowStatusBloc, SlideshowStatusState>(
                builder: (context, state) =>
                    DebugWidget(injector(), injector()),
              ),
          ],
        ),
      );
    },
  );
}

String _statusText(BuildContext context, ConfigState state) {
  final l10n = AppLocalizations.of(context);
  return switch (state.phase) {
    ConfigPhase.preparing => l10n.configPageStarting,
    ConfigPhase.preparingAddress => l10n.configPageAddressPreparing,
    ConfigPhase.addressUnavailable => l10n.configPageNoAddress,
    ConfigPhase.closing =>
      context.read<ConfigBloc>().repository.alwaysEnabled
          ? l10n.configPageClosingAlways
          : l10n.configPageClosing,
    ConfigPhase.closeFailure => l10n.configPageCloseError,
    ConfigPhase.failure => switch (state.failure) {
      ConfigFailureKind.server => l10n.configPageServerError,
      ConfigFailureKind.network => l10n.configPageNetworkError,
      ConfigFailureKind.timeout => l10n.configPageTimeout,
      ConfigFailureKind.unknown || null => l10n.configPageUnknownError,
    },
    ConfigPhase.ready || ConfigPhase.exited => '',
  };
}

class _StatusPanel extends StatelessWidget {
  const _StatusPanel({required this.state});
  final ConfigState state;
  @override
  Widget build(BuildContext context) {
    final working = switch (state.phase) {
      ConfigPhase.preparing ||
      ConfigPhase.preparingAddress ||
      ConfigPhase.closing => true,
      _ => false,
    };
    final failure =
        state.phase == ConfigPhase.failure ||
        state.phase == ConfigPhase.closeFailure;
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (working)
            const CircularProgressIndicator(
              color: ThemeColors.configAccentColor,
            )
          else
            Icon(
              failure ? Icons.error_outline : Icons.wifi_off,
              size: 128,
              color: failure
                  ? ThemeColors.otaErrorTextColor
                  : ThemeColors.configAccentColor,
            ),
          const SizedBox(height: 24),
          Text(
            _statusText(context, state),
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 32),
          ),
        ],
      ),
    );
  }
}

class _Information extends StatelessWidget {
  const _Information({required this.state, required this.address});
  final ConfigState state;
  final String? address;
  static const _normal = TextStyle(
    color: ThemeColors.configNormalTextColor,
    fontSize: 24,
  );
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final active = state.exit == ConfigExitStatus.active;
    final code = active && state.access == ConfigAccessStatus.ready
        ? state.code
        : null;
    final hasRetry = _hasRetry(state);
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: ThemeColors.configCardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ThemeColors.configInputBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            l10n.configPageTitle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(l10n.configPageIntro, style: _normal),
          if (code != null) ...[
            const SizedBox(height: 24),
            Text(l10n.configPageCode, style: _normal),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: ThemeColors.configAccessCodeBgColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: ThemeColors.configAccessCodeBorderColor,
                ),
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  code,
                  key: const Key('config-access-code'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 136,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 4,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            _Instruction(icon: Icons.wifi, text: l10n.configPageNetworkStep),
            if (address != null) ...[
              const SizedBox(height: 16),
              _Instruction(
                icon: Icons.qr_code_scanner,
                text: l10n.configPageScanStep,
              ),
              const SizedBox(height: 16),
              _Instruction(icon: Icons.password, text: l10n.configPageCodeStep),
            ],
          ],
          if (address != null) ...[
            const Divider(height: 40, color: Colors.white24),
            Text(l10n.configPageManual, style: _normal),
            const SizedBox(height: 8),
            SelectableText(
              address!,
              style: const TextStyle(
                color: ThemeColors.configAccentColor,
                fontSize: 36,
              ),
            ),
          ],
          if (state.refreshing) ...[
            const SizedBox(height: 24),
            const LinearProgressIndicator(color: ThemeColors.configAccentColor),
            const SizedBox(height: 8),
            Text(l10n.configPageChecking, style: _normal),
          ],
          if ((state.phase == ConfigPhase.failure ||
                  state.phase == ConfigPhase.closeFailure) &&
              !state.canRetry)
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Text(l10n.configPagePending, style: _normal),
            ),
          if (active && state.phase != ConfigPhase.preparing) ...[
            const SizedBox(height: 16),
            Text(l10n.configPageCacheHint, style: _normal),
          ],
          const SizedBox(height: 24),
          if (hasRetry)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: FilledButton.icon(
                key: const Key('config-retry'),
                style: FilledButton.styleFrom(
                  backgroundColor: ThemeColors.configAccentColor,
                  foregroundColor: Colors.black,
                  textStyle: Theme.of(context).textTheme.labelLarge
                      ?.copyWith(fontSize: 24),
                  minimumSize: const Size(64, 64),
                ),
                onPressed: state.canRetry
                    ? () => context.read<ConfigBloc>().add(
                        const ConfigEvent.retry(),
                      )
                    : null,
                icon: Icon(_retryAction(state).icon, size: 32),
                label: Text(
                  state.phase == ConfigPhase.ready ||
                          state.phase == ConfigPhase.addressUnavailable
                      ? l10n.configPageCheck
                      : l10n.configPageRetry,
                ),
              ),
            ),
          if (state.phase != ConfigPhase.closing &&
              state.phase != ConfigPhase.exited)
            OutlinedButton.icon(
              key: const Key('config-return'),
              style: OutlinedButton.styleFrom(
                foregroundColor: ThemeColors.configAccentColor,
                textStyle: Theme.of(context).textTheme.labelLarge
                    ?.copyWith(fontSize: 24),
                minimumSize: const Size(64, 64),
              ),
              onPressed: () =>
                  context.read<ConfigBloc>().add(const ConfigEvent.exit()),
              icon: Icon(
                (state.phase == ConfigPhase.closeFailure
                        ? ButtonHintAction.returnUnconfirmed
                        : ButtonHintAction.back)
                    .icon,
                size: 32,
              ),
              label: Text(
                state.phase == ConfigPhase.closeFailure
                    ? l10n.configPageReturnAnyway
                    : l10n.configPageReturn,
              ),
            ),
        ],
      ),
    );
  }
}

class _Instruction extends StatelessWidget {
  const _Instruction({required this.icon, required this.text});
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(icon, color: ThemeColors.configAccentColor, size: 40),
      const SizedBox(width: 12),
      Expanded(
        child: Text(
          text,
          style: const TextStyle(
            color: ThemeColors.configNormalTextColor,
            fontSize: 24,
          ),
        ),
      ),
    ],
  );
}

ButtonHintAction _retryAction(ConfigState state) =>
    state.phase == ConfigPhase.ready ||
        state.phase == ConfigPhase.addressUnavailable
    ? ButtonHintAction.checkConnection
    : ButtonHintAction.retry;

bool _hasRetry(ConfigState state) => switch (state.phase) {
  ConfigPhase.ready ||
  ConfigPhase.addressUnavailable ||
  ConfigPhase.failure ||
  ConfigPhase.closeFailure => true,
  _ => false,
};
