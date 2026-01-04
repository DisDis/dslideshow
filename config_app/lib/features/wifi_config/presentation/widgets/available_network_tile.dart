import 'package:dslideshow_backend/command.dart';
import 'package:flutter/material.dart';

class AvailableNetworkTile extends StatelessWidget {
  final WiFiNetworkInfo network;
  final VoidCallback onTap;

  const AvailableNetworkTile({super.key, required this.network, required this.onTap});

  @override
  Widget build(BuildContext context) {
    Color signalColor;
    if (network.signal >= 75) {
      signalColor = Colors.green;
    } else if (network.signal >= 50) {
      signalColor = Colors.orange;
    } else {
      signalColor = Colors.red;
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
              color: signalColor),
          if (isLocked)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(4)),
                child: const Icon(Icons.lock, size: 10, color: Colors.grey),
              ),
            )
        ],
      ),
      title: Text(network.SSID,
          style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Row(
        children: [
          if (is5Ghz) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                  color: Colors.blue.withAlpha((255.0 * 0.1).round()),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                      color: Colors.blue.withAlpha((255.0 * 0.3).round()))),
              child: const Text("5G",
                  style: TextStyle(
                      fontSize: 9,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 6),
          ],
          Text("${network.signal}%", style: const TextStyle(fontSize: 12)),
          const SizedBox(width: 6),
          Text("• Ch: ${network.channel}",
              style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
      trailing: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(8),
            elevation: 0,
            backgroundColor:
                Theme.of(context).colorScheme.surfaceContainerHighest),
        onPressed: onTap,
        child: const Icon(Icons.add, size: 20),
      ),
    );
  }
}
