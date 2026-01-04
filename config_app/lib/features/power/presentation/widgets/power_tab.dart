import 'package:config_app/features/power/presentation/bloc/power_bloc.dart';
import 'package:config_app/features/power/presentation/bloc/power_event.dart';
import 'package:config_app/features/power/presentation/bloc/power_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PowerTab extends StatelessWidget {
  const PowerTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PowerBloc, PowerState>(
      builder: (context, state) {
        // 1. LOADING
        if (state is UninitializedPowerState) {
          return const Center(child: CircularProgressIndicator());
        }

        // 2. ERROR
        if (state is ErrorPowerState) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.redAccent),
                  const SizedBox(height: 16),
                  Text(
                    "Connection Failed",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.errorMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: () => context.read<PowerBloc>().add(const LoadPowerEvent()),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Try Again'),
                  ),
                ],
              ),
            ),
          );
        }

        // 3. SUCCESS (Main Content)
        if (state is InitializedPowerState) {
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600), // Ограничиваем ширину на планшетах
                child: Column(
                  children: [
                    // Заголовок и иконка
                    Icon(
                      Icons.power_settings_new,
                      size: 80,
                      color: Theme.of(context).colorScheme.primary.withAlpha((255.0 * 0.5).round()),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Power Management",
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Choose an action to perform on the device",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                    const SizedBox(height: 40),

                    // Кнопка рестарта
                    _PowerActionCard(
                      title: 'Restart Application',
                      description: 'Reloads the software without rebooting the OS.',
                      icon: Icons.restart_alt,
                      color: Colors.orange,
                      onTap: () => _showConfirmationDialog(
                        context,
                        title: 'Restart Application?',
                        content: 'This will reload the configuration app and slideshow services.',
                        confirmText: 'Restart',
                        confirmColor: Colors.orange,
                        onConfirm: () {
                          context.read<PowerBloc>().add(const RestartAppPowerEvent());
                        },
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Кнопка выключения
                    _PowerActionCard(
                      title: 'Power Off',
                      description: 'Safely shuts down the device operating system.',
                      icon: Icons.power_off,
                      color: Colors.red,
                      isDangerous: true,
                      onTap: () => _showConfirmationDialog(
                        context,
                        title: 'Power Off Device?',
                        content: 'The device will shut down completely. You will need to physically turn it on again.',
                        confirmText: 'Power Off',
                        confirmColor: Colors.red,
                        onConfirm: () {
                          context.read<PowerBloc>().add(const PowerOffPowerEvent());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  // Метод для показа диалога (работает внутри Stateless)
  void _showConfirmationDialog(
    BuildContext context, {
    required String title,
    required String content,
    required String confirmText,
    required Color confirmColor,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(), // Закрыть
            child: const Text("Cancel"),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: confirmColor),
            onPressed: () {
              Navigator.of(ctx).pop(); // Сначала закрываем диалог
              onConfirm(); // Потом выполняем действие
            },
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }
}

// --- ВИДЖЕТ КАРТОЧКИ ДЕЙСТВИЯ ---

class _PowerActionCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final bool isDangerous;

  const _PowerActionCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.onTap,
    this.isDangerous = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: color.withAlpha((255.0 * 0.4).round()),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              // Круглая иконка
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: color.withAlpha((255.0 * 0.1).round()),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(width: 20),
              
              // Тексты
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isDangerous ? color : null,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                    ),
                  ],
                ),
              ),
              
              // Стрелочка
              Icon(Icons.chevron_right, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }
}