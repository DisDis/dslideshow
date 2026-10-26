import 'package:dslideshow_backend/command.dart';
import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:flutter/material.dart';

class AvailableNetworkTile extends StatelessWidget {
  final WiFiNetworkInfo network;
  final VoidCallback onTap;

  const AvailableNetworkTile({
    super.key,
    required this.network,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    Color signalColor;
    if (network.signal >= 75) {
      signalColor = colors.primary;
    } else if (network.signal >= 50) {
      signalColor = colors.tertiary;
    } else {
      signalColor = colors.error;
    }

    final is5Ghz = network.channel > 14;
    final isLocked =
        network.security.toUpperCase() != 'OPEN' && network.security.isNotEmpty;

    return ListTile(
      onTap: onTap,
      leading: Stack(
        children: [
          Icon(
            network.signal >= 85
                ? Icons.network_wifi
                : network.signal >= 70
                ? Icons.network_wifi_3_bar
                : network.signal >= 50
                ? Icons.network_wifi_2_bar
                : Icons.network_wifi_1_bar,
            color: signalColor,
          ),
          if (isLocked)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(
                  Icons.lock,
                  size: 10,
                  color: colors.onSurfaceVariant,
                ),
              ),
            ),
        ],
      ),
      title: Text(
        network.SSID,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Row(
        children: [
          if (is5Ghz) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                color: colors.secondaryContainer,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: colors.outlineVariant),
              ),
              child: Text(
                context.localizations.wifi_5ghz_label,
                style: TextStyle(
                  fontSize: 9,
                  color: colors.onSecondaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 6),
          ],
          Text("${network.signal}%", style: const TextStyle(fontSize: 12)),
          const SizedBox(width: 6),
          Text(
            "• ${context.localizations.channel_text(network.channel)}",
            style: Theme.of(context).textTheme.bodySmall
                ?.copyWith(color: colors.onSurfaceVariant),
          ),
        ],
      ),
      trailing: IconButton.filledTonal(
        tooltip: context.localizations.connect_button,
        onPressed: onTap,
        icon: const Icon(Icons.add, size: 20),
      ),
    );
  }
}
