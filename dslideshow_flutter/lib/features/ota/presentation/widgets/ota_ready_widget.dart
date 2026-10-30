import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/features/header/presentation/widgets/buttons_hint/button_hint_action.dart';
import 'package:dslideshow_flutter/features/header/presentation/widgets/buttons_hint/page_buttons_hint.dart';
import 'package:dslideshow_flutter/features/ota/presentation/bloc/ota_bloc.dart';
import 'package:dslideshow_common/version.dart';
import 'package:dslideshow_flutter/environment.dart' as environment;
import 'package:dslideshow_flutter/features/header/presentation/widgets/common_header.dart';
import 'package:dslideshow_flutter/features/ota/presentation/bloc/ota_state.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/status/slideshow_status_bloc.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/debug_widget.dart';
import 'package:dslideshow_flutter/features/theme/presentation/theme.dart';
import 'package:dslideshow_flutter/src/injector.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dslideshow_flutter/features/shared/presentation/widgets/access_layout.dart';

class OtaReadyWidget extends StatelessWidget {
  final OtaReadyState state;

  const OtaReadyWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          child: AccessLayout(
            panel: _OtaQrPanel(state: state),
            information: _OtaReadyInfoPanel(state: state),
            hasAddress: state.otaStartUrl != null,
          ),
        ),
        const CommonHeaderWidget(),
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
            builder: (context, state) {
              return DebugWidget(injector(), injector());
            },
          ),
      ],
    );
  }
}

class _OtaQrPanel extends StatelessWidget {
  final OtaReadyState state;

  const _OtaQrPanel({required this.state});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final address = state.otaStartUrl;
    if (address == null) {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (state.isPreparingAddress)
              const CircularProgressIndicator(color: ThemeColors.otaAccentColor)
            else
              const Icon(
                Icons.wifi_off,
                size: ThemeSettings.otaMainStageIconSize,
                color: ThemeColors.otaAccentColor,
              ),
            const SizedBox(height: 24),
            Text(
              state.isPreparingAddress
                  ? l10n.otaPreparing
                  : l10n.otaAddressUnavailable,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: ThemeColors.otaReadyNormalTextColor,
                fontSize: ThemeSettings.otaProgressSubtitleSize,
              ),
            ),
          ],
        ),
      );
    }

    return AccessQrCode(address: address, label: l10n.otaScanInstruction);
  }
}

class _OtaReadyInfoPanel extends StatelessWidget {
  final OtaReadyState state;

  const _OtaReadyInfoPanel({required this.state});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final address = state.otaStartUrl;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: ThemeColors.otaCardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ThemeColors.otaReadyInputBorderColor),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.otaReadyTitle,
            style: const TextStyle(
              color: ThemeColors.otaReadyHeaderTextColor,
              fontSize: ThemeSettings.otaReadyTitleSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Text(l10n.otaCurrentVersion, style: _labelStyle),
          const SizedBox(height: 8),
          const Text(
            'v${ApplicationInfo.frontendVersion}',
            style: TextStyle(
              color: ThemeColors.otaVersionCurrentColor,
              fontSize: ThemeSettings.otaReadyVersionSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Text(l10n.otaAccessCode, style: _labelStyle),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: ThemeColors.otaReadyAccessCodeBgColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: ThemeColors.otaReadyAccessCodeBorderColor,
              ),
            ),
            child: Text(
              state.info.code,
              style: const TextStyle(
                color: ThemeColors.otaReadyNormalTextColor,
                fontSize: ThemeSettings.otaReadyAccessCodeSize,
                fontWeight: FontWeight.w900,
                letterSpacing: 4,
              ),
            ),
          ),
          const SizedBox(height: 24),
          _OtaInstructionRow(icon: Icons.wifi, text: l10n.otaSameNetwork),
          if (address != null) ...[
            const SizedBox(height: 16),
            _OtaInstructionRow(
              icon: Icons.qr_code_scanner,
              text: l10n.otaScanInstruction,
            ),
            const Divider(height: 40, color: Colors.white24),
            Text(l10n.otaManualConnection, style: _labelStyle),
            const SizedBox(height: 8),
            SelectableText(
              address,
              style: const TextStyle(
                color: ThemeColors.otaAccentColor,
                fontSize: ThemeSettings.otaReadyLinkSize,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ],
      ),
    );
  }

  static const _labelStyle = TextStyle(
    color: ThemeColors.otaReadySubheaderTextColor,
    fontSize: ThemeSettings.otaReadyNormalTextSize,
  );
}

class _OtaInstructionRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _OtaInstructionRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: ThemeColors.otaAccentColor,
          size: ThemeSettings.otaReadyInstructionIconSize,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: ThemeColors.otaReadyNormalTextColor,
              fontSize: ThemeSettings.otaReadyNormalTextSize,
            ),
          ),
        ),
      ],
    );
  }
}
