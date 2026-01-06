import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:config_app/features/theme/presentation/theme.dart';
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
    // Проверка на защищенные сети
    final isProtected = connection.name == 'AccessPopup' ||
        connection.name == 'preconfigured' ||
        connection.type == 'loopback' ||
        connection.type == 'ethernet';

    return ListTile(
      // 1. Меняем иконку и цвет в зависимости от типа сети
      leading: CircleAvatar(
        backgroundColor: isProtected
            ? AppColors.connectonProtected
                .withAlpha((255.0 * 0.1).round()) // Серый фон для системных
            : AppColors.connectionNotProtected 
                .withAlpha((255.0 * 0.1).round()), // Зеленый для обычных
        child: Icon(
          isProtected ? Icons.lock_outline : Icons.wifi,
          color: isProtected ? AppColors.connectonProtected : AppColors.connectionNotProtected,
        ),
      ),

      title: Text(
        connection.name,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),

      subtitle: Text(
        context.localizations
            .device_connection_info(connection.device, connection.type),
      ),

      // 2. Кнопка удаления только для незащищенных сетей
      trailing: isProtected
          ? null //Icon(Icons.info_outline)
          : IconButton(
              icon: const Icon(Icons.delete_outline, color: AppColors.errorRedAccent),
              tooltip: 'Delete connection',
              onPressed: onDelete, // Вызываем коллбек
            ),
    );
  }
}
