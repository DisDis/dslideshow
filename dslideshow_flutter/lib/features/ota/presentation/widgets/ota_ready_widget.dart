import 'package:dslideshow_common/version.dart';
import 'package:dslideshow_flutter/environment.dart' as environment;
import 'package:dslideshow_flutter/features/header/presentation/widgets/common_header.dart';
import 'package:dslideshow_flutter/features/ota/presentation/bloc/ota_state.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/status/slideshow_status_bloc.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/debug_widget.dart';
import 'package:dslideshow_flutter/src/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:dslideshow_flutter/features/theme/presentation/theme.dart';

class OtaReadyWidget extends StatelessWidget {
  // Colors are now defined in ThemeColors

  final OtaReadyState state;
  const OtaReadyWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(child: _buildOtaReadyContent()),
          ],
        ),
        const CommonHeaderWidget(),

        // 2. DEBUG СЛОЙ (поверх основного)
        if (!environment.isLinuxEmbedded)
          BlocBuilder<SlideshowStatusBloc, SlideshowStatusState>(
            builder: (context, state) {
              return DebugWidget(injector(), injector());
            },
          ),
      ],
    );
  }

  Widget _buildOtaReadyContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Левая часть - QR
        Expanded(flex: 4, child: Padding(
          padding: const EdgeInsets.fromLTRB(0,100.0,0,100.0),
          child: Center(child: _buildQrCode()),
        )),
        // Правая часть - Информация
        Expanded(
          flex: 2,
          child: Padding(padding: const EdgeInsets.only(right: 32.0), child: _buildInfoPanel()),
        ),
      ],
    );
  }

  Widget _buildQrCode() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ThemeColors.QRCodeBackground,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: ThemeColors.QRCodeShadow, blurRadius: 15, offset: const Offset(0, 10))],
      ),
      child: QrImageView(data: state.otaStartUrl, version: QrVersions.auto, backgroundColor: ThemeColors.QRCodeBackground),
    );
  }

  Widget _buildInfoPanel() {
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
            "Update firmware",
            style: TextStyle(color: ThemeColors.otaReadyHeaderTextColor, fontSize: ThemeSettings.otaReadyTitleSize, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              const Text("Current version: ", style: TextStyle(fontSize:  ThemeSettings.otaReadyNormalTextSize),),
              Text(
                "v${ApplicationInfo.frontendVersion}",
                style: TextStyle(color: ThemeColors.otaVersionCurrentColor, fontSize: ThemeSettings.otaReadyVersionSize, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildStepRow(Icons.qr_code_scanner, "1. Scan the QR code to update firmware"),
          const SizedBox(height: 12),
          _buildStepRow(Icons.wifi, "2. Make sure you are on the same Wi-Fi"),

          const Divider(height: 40, color: Colors.white24),

          Text(
            "Manual Connection",
            style: TextStyle(
              color: ThemeColors.otaReadySubheaderTextColor,
              fontSize: ThemeSettings.otaReadyNormalTextSize,
              // uppercase: true,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          SelectableText(
            state.otaStartUrl,
            style: TextStyle(color: ThemeColors.otaAccentColor, fontSize: ThemeSettings.otaReadyLinkSize, decoration: TextDecoration.underline),
          ),

          const SizedBox(height: 24),

          Text(
            "Access Code",
            style: TextStyle(
              color: ThemeColors.otaReadySubheaderTextColor,
              fontSize: ThemeSettings.otaReadyNormalTextSize,
              // uppercase: true,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: ThemeColors.otaReadyAccessCodeBgColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: ThemeColors.otaReadyAccessCodeBorderColor),
            ),
            child: Text(
              state.info.code,
              style: const TextStyle(
                color: ThemeColors.otaReadyNormalTextColor,
                fontSize: ThemeSettings.otaReadyAccessCodeSize,
                fontWeight: FontWeight.w900,
                letterSpacing: 4,
                fontFamily: 'Courier', // Моноширинный шрифт для кода
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: ThemeColors.otaAccentColor, size: ThemeSettings.otaReadyInstructionIconSize),
        const SizedBox(width: 12),
        Expanded(
          child: Text(text, style: TextStyle(color: ThemeColors.otaReadyNormalTextColor, fontSize: ThemeSettings.otaReadyNormalTextSize)),
        ),
      ],
    );
  }
}
