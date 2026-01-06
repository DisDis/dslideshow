import 'package:config_app/features/power/presentation/bloc/power_bloc.dart';
import 'package:config_app/features/power/presentation/bloc/power_event.dart';
import 'package:config_app/features/power/presentation/bloc/power_state.dart';
import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:config_app/features/theme/presentation/theme.dart';
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
                  const Icon(Icons.error_outline, size: 64, color: AppColors.errorRedAccent),
                  const SizedBox(height: 16),
                  Text(
                    context.localizations.connection_failed,
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
                    label: Text(context.localizations.try_again_button),
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
                      context.localizations.power_management_title,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      context.localizations.choose_action_on_device,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColors.powerTabHint,
                          ),
                    ),
                    const SizedBox(height: 40),

                    // Кнопка рестарта
                    _PowerActionCard(
                      title: context.localizations.restart_application,
                      description: context.localizations.reload_software_without_rebooting_os,
                      icon: Icons.restart_alt,
                      color: AppColors.powerIconRestart,
                      onTap: () => _showConfirmationDialog(
                        context,
                        title: context.localizations.restart_application_question,
                        content: context.localizations.this_will_reload_configuration_app_and_slideshow_services,
                        confirmText: context.localizations.restart,
                        confirmColor: AppColors.powerIconRestart,
                        onConfirm: () {
                          context.read<PowerBloc>().add(const RestartAppPowerEvent());
                        },
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Кнопка выключения
                    _PowerActionCard(
                      title: context.localizations.power_off,
                      description: context.localizations.safely_shuts_down_the_device_operating_system,
                      icon: Icons.power_off,
                      color: AppColors.powerIconPowerOff,
                      isDangerous: true,
                      onTap: () => _showConfirmationDialog(
                        context,
                        title: context.localizations.power_off_device_question,
                        content: context.localizations.the_device_will_shut_down_completely,
                        confirmText: context.localizations.power_off_button,
                        confirmColor: AppColors.powerIconPowerOff,
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
            child: Text(context.localizations.cancel_button),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: confirmColor),
            onPressed: () {
              Navigator.of(ctx).pop(); // Сначала закрываем диалог
              onConfirm(); // Потом выполняем действие
            },
            child: Text(context.localizations.ok_button),
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
              Icon(Icons.chevron_right, color: AppColors.powerTabArrow ),
            ],
          ),
        ),
      ),
    );
  }
}