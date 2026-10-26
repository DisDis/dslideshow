import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:flutter/material.dart';

class SavedConnectionTile extends StatelessWidget {
  final WiFiConnectionInfo connection;
  final VoidCallback? onDelete;

  const SavedConnectionTile({
    super.key,
    required this.connection,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    // Проверка на защищенные сети
    final isProtected =
        connection.name == 'AccessPopup' ||
        connection.name == 'preconfigured' ||
        connection.type == 'loopback' ||
        connection.type == 'ethernet';

    return ListTile(
      // 1. Меняем иконку и цвет в зависимости от типа сети
      leading: CircleAvatar(
        backgroundColor: isProtected
            ? colors.surfaceContainerHighest
            : colors.primaryContainer,
        child: Icon(
          isProtected ? Icons.lock_outline : Icons.wifi,
          color: isProtected
              ? colors.onSurfaceVariant
              : colors.onPrimaryContainer,
        ),
      ),

      title: Text(
        connection.name,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),

      subtitle: Text(
        context.localizations.device_connection_info(
          connection.device,
          connection.type,
        ),
      ),

      // 2. Кнопка удаления только для незащищенных сетей
      trailing: isProtected
          ? null //Icon(Icons.info_outline)
          : IconButton(
              icon: Icon(Icons.delete_outline, color: colors.error),
              tooltip: context.localizations.delete_connection,
              onPressed: onDelete, // Вызываем коллбек
            ),
    );
  }
}
