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

class OtaReadyWidget extends StatelessWidget {
  final Color _cardColor = const Color(0xFF2C2C2C);
  final Color _accentColor = const Color(0xFF64B5F6);

  final OtaReadyState state;
  const OtaReadyWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            const CommonHeaderWidget(),
            Expanded(child: _buildOtaReadyContent()),
          ],
        ),

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
        Expanded(flex: 4, child: Center(child: _buildQrCode())),
        // Правая часть - Информация
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.only(right: 32.0),
            child: _buildInfoPanel(),
          ),
        ),
      ],
    );
  }

  Widget _buildQrCode() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: QrImageView(
        data: state.otaStartUrl,
        version: QrVersions.auto,
        size: 300.0,
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget _buildInfoPanel() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Update firmware",
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              const Text("Current version: "),
              Text(
                "v${ApplicationInfo.frontendVersion}",
                style: TextStyle(
                  color: Colors.red.withOpacity(0.9),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildStepRow(
            Icons.qr_code_scanner,
            "1. Scan the QR code to update firmware",
          ),
          const SizedBox(height: 12),
          _buildStepRow(Icons.wifi, "2. Make sure you are on the same Wi-Fi"),

          const Divider(height: 40, color: Colors.white24),

          Text(
            "Manual Connection",
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 12,
              // uppercase: true,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          SelectableText(
            state.otaStartUrl,
            style: TextStyle(
              color: _accentColor,
              fontSize: 18,
              decoration: TextDecoration.underline,
            ),
          ),

          const SizedBox(height: 24),

          Text(
            "Access Code",
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 12,
              // uppercase: true,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _accentColor.withOpacity(0.3)),
            ),
            child: Text(
              state.info.code,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 68,
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
        Icon(icon, color: _accentColor, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
