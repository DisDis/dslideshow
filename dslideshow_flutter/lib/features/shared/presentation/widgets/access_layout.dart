import 'dart:math' as math;

import 'package:dslideshow_flutter/features/theme/presentation/theme.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// Shared geometry for local access screens; owns no connection or state.
class AccessLayout extends StatelessWidget {
  const AccessLayout({
    super.key,
    required this.panel,
    required this.information,
    required this.hasAddress,
  });
  final Widget panel;
  final Widget information;
  final bool hasAddress;

  @override
  Widget build(BuildContext context) => SafeArea(
    child: LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1100 && constraints.maxHeight >= 700) {
          return Row(
            children: [
              Expanded(
                flex: constraints.maxWidth >= 1600 ? 4 : 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 100),
                  child: Center(child: panel),
                ),
              ),
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(0, 100, 32, 100),
                  child: information,
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
              if (hasAddress)
                Center(
                  child: SizedBox.square(
                    dimension: math.max(0, constraints.maxWidth - 48),
                    child: panel,
                  ),
                ),
              const SizedBox(height: 32),
              information,
              if (!hasAddress) ...[const SizedBox(height: 32), panel],
            ],
          ),
        );
      },
    ),
  );
}

class AccessQrCode extends StatelessWidget {
  const AccessQrCode({super.key, required this.address, required this.label});
  final String address;
  final String label;

  @override
  Widget build(BuildContext context) => Container(
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
      semanticsLabel: label,
    ),
  );
}
