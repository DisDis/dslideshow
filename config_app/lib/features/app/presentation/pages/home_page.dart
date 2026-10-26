import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:config_app/features/uikit/presentation/widgets/config_app_scaffold.dart';
import 'package:config_app/features/uikit/presentation/widgets/navigation_bar/configapp_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static void route(BuildContext context) => context.go('/home');

  @override
  Widget build(BuildContext context) {
    final l = context.localizations;
    final theme = Theme.of(context);
    final destinations = AppDestination.values
        .where((item) => item != AppDestination.home)
        .toList();
    return ConfigAppScaffold(
      appBar: AppBar(title: Text(l.home_page_name)),
      body: SettingsContent(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text(l.device_panel_title, style: theme.textTheme.headlineMedium),
            const SizedBox(height: 8),
            Text(
              l.device_settings_description,
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 28),
            LayoutBuilder(
              builder: (context, constraints) {
                final columns = constraints.maxWidth >= 680 ? 2 : 1;
                final width =
                    (constraints.maxWidth - (columns - 1) * 16) / columns;
                return Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    for (final destination in destinations)
                      SizedBox(
                        width: width,
                        child: Card(
                          margin: EdgeInsets.zero,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () => context.go(destination.path),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: [
                                  Icon(
                                    destination.icon,
                                    color: theme.colorScheme.primary,
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          destination.label(context),
                                          style: theme.textTheme.titleMedium,
                                        ),
                                        const SizedBox(height: 6),
                                        Text(switch (destination) {
                                          AppDestination.telemetry =>
                                            l.device_telemetry_subtitle,
                                          AppDestination.control =>
                                            l.device_controls_subtitle,
                                          AppDestination.gallery =>
                                            l.view_media_subtitle,
                                          AppDestination.upload =>
                                            l.upload_media_subtitle,
                                          AppDestination.config =>
                                            l.system_settings_subtitle,
                                          AppDestination.ota =>
                                            l.firmware_upgrade_subtitle,
                                          AppDestination.wifi =>
                                            l.manage_connections_subtitle,
                                          AppDestination.power =>
                                            l.restart_app_power_off_subtitle,
                                          AppDestination.home =>
                                            l.device_settings_description,
                                        }, style: theme.textTheme.bodySmall),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.chevron_right),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
