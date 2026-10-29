import 'dart:math' as math;

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
import 'package:qr_flutter/qr_flutter.dart';

class OtaReadyWidget extends StatelessWidget {
  final OtaReadyState state;

  const OtaReadyWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth >= 1100 &&
                    constraints.maxHeight >= 700) {
                  return Row(
                    children: [
                      Expanded(
                        flex: constraints.maxWidth >= 1600 ? 4 : 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 100),
                          child: Center(child: _OtaQrPanel(state: state)),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(0, 100, 32, 100),
                          child: _OtaReadyInfoPanel(state: state),
                        ),
                      ),
                    ],
                  );
                }

                return SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 100, 24, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (state.otaStartUrl != null)
                        Center(
                          child: SizedBox.square(
                            dimension: math.max(0, constraints.maxWidth - 48),
                            child: _OtaQrPanel(state: state),
                          ),
                        ),
                      const SizedBox(height: 32),
                      _OtaReadyInfoPanel(state: state),
                      if (state.otaStartUrl == null) ...[
                        const SizedBox(height: 32),
                        _OtaQrPanel(state: state),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        const CommonHeaderWidget(),
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

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ThemeColors.qrCodeBackground,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: ThemeColors.qrCodeShadow,
            blurRadius: 15,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: QrImageView(
        data: address,
        version: QrVersions.auto,
        backgroundColor: ThemeColors.qrCodeBackground,
        semanticsLabel: l10n.otaScanInstruction,
      ),
    );
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
