import 'package:dslideshow_backend/command.dart';
import 'package:flutter/material.dart';

class SavedConnectionTile extends StatelessWidget {
  final WiFiConnectionInfo connection;
  const SavedConnectionTile({super.key, required this.connection});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.green.withAlpha((255.0 * 0.1).round()),
        child: const Icon(Icons.wifi, color: Colors.green),
      ),
      title: Text(connection.name,
          style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text("Device: ${connection.device} • ${connection.type}"),
      //trailing: const Icon(Icons.chevron_right, color: Colors.grey),
    );
  }
}
