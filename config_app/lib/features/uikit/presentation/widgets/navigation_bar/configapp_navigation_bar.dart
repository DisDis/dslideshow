import 'package:config_app/features/auth/presentation/bloc/authentication_bloc.dart';
import 'package:config_app/features/realtime/domain/services/realtime_service.dart';
import 'package:config_app/features/theme/presentation/app_preferences.dart';
import 'package:config_app/features/theme/presentation/l10n/app_locale.dart';
import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:config_app/injection_container.dart';
import 'package:config_app/features/uikit/presentation/bloc/backend_version_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

enum AppDestination {
  home('/home', Icons.home_outlined),
  telemetry('/telemetry', Icons.monitor_heart_outlined),
  control('/device_control', Icons.settings_remote_outlined),
  gallery('/gallery', Icons.photo_library_outlined),
  upload('/upload', Icons.upload_file_outlined),
  config('/config', Icons.tune),
  ota('/ota', Icons.system_update_outlined),
  wifi('/wifi_config', Icons.wifi),
  power('/power', Icons.power_settings_new);

  const AppDestination(this.path, this.icon);
  final String path;
  final IconData icon;

  String label(BuildContext context) {
    final l = context.localizations;
    return switch (this) {
      home => l.home_menu_item,
      telemetry => l.device_telemetry_title,
      control => l.device_controls_title,
      gallery => l.gallery_menu_item,
      upload => l.upload_media_menu_item,
      config => l.configuration_menu_item,
      ota => l.ota_update_title,
      wifi => l.wifi_menu_item,
      power => l.system_control_menu_item,
    };
  }
}

class ConfigAppNavigationBar extends StatelessWidget {
  final Future<bool> Function()? onLogoutRequested;
  final bool embedded;

  const ConfigAppNavigationBar({super.key, this.onLogoutRequested, this.embedded = false});

  @override
  Widget build(BuildContext context) {
    final l = context.localizations;
    final theme = Theme.of(context);
    final router = GoRouter.maybeOf(context);
    final path = router?.routeInformationProvider.value.uri.path;
    final preferences = AppPreferencesScope.maybeOf(context);
    final client = sl.isRegistered<RealtimeService>() ? sl<RealtimeService>() : null;
    final uri = client?.connectUri;
    final address = uri == null || uri.host.isEmpty ? null : '${uri.host}${uri.hasPort ? ':${uri.port}' : ''}';
    final navigation = SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.filter_frames_outlined, color: theme.colorScheme.primary),
                    const SizedBox(width: 10),
                    Text('Dslideshow', style: theme.textTheme.titleMedium),
                  ],
                ),
                const SizedBox(height: 20),
                Text(l.device_panel_title, style: theme.textTheme.titleSmall),
                if (address != null) SelectableText(address, style: theme.textTheme.bodySmall),
                const _BackendVersion(),
              ],
            ),
          ),
          for (final destination in AppDestination.values)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: ListTile(
                key: ValueKey(destination),
                selected: path == destination.path,
                leading: Icon(destination.icon),
                title: Text(destination.label(context)),
                onTap: router == null
                    ? null
                    : () {
                        if (!embedded) Scaffold.maybeOf(context)?.closeDrawer();
                        if (path != destination.path) {
                          router.go(destination.path);
                        }
                      },
              ),
            ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Divider()),
          if (preferences != null)
            ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(horizontal: 12),
              leading: const Icon(Icons.palette_outlined),
              title: Text(l.appearance_title),
              childrenPadding: const EdgeInsets.only(top: 8, bottom: 16),
              children: [
                DropdownButtonFormField<AppLocale>(
                  key: ValueKey(preferences.appLocale),
                  initialValue: preferences.appLocale,
                  isExpanded: true,
                  decoration: InputDecoration(labelText: l.language_label),
                  items: [
                    for (final locale in AppLocale.values)
                      DropdownMenuItem(value: locale, child: Text(locale.toLanguage(context))),
                  ],
                  onChanged: (locale) {
                    if (locale != null) preferences.setLocale(locale);
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<ThemeMode>(
                  key: ValueKey(preferences.themeMode),
                  initialValue: preferences.themeMode,
                  isExpanded: true,
                  decoration: InputDecoration(labelText: l.theme_mode_label),
                  items: [
                    for (final mode in ThemeMode.values)
                      DropdownMenuItem(
                        value: mode,
                        child: Text(switch (mode) {
                          ThemeMode.system => l.ui_system_default,
                          ThemeMode.light => l.theme_mode_light,
                          ThemeMode.dark => l.theme_mode_dark,
                        }),
                      ),
                  ],
                  onChanged: (mode) {
                    if (mode != null) preferences.setThemeMode(mode);
                  },
                ),
              ],
            ),
          ListTile(
            title: Text(l.exit_menu_item),
            leading: const Icon(Icons.logout),
            onTap: () async {
              final mayLogout = await onLogoutRequested?.call() ?? true;
              if (mayLogout && context.mounted) {
                context.read<AuthenticationBloc?>()?.add(const AuthenticationLogoutRequested());
              }
            },
          ),
        ],
      ),
    );
    return embedded ? Material(color: theme.colorScheme.surface, child: navigation) : Drawer(child: navigation);
  }
}

class _BackendVersion extends StatelessWidget {
  const _BackendVersion();

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<BackendVersionBloc?>();
    if (bloc == null || bloc.state.status == BackendVersionStatus.idle) return const SizedBox.shrink();
    final state = bloc.state;
    final l = context.localizations;
    final theme = Theme.of(context);
    final mismatch = state.compatibility == BackendCompatibility.mismatched;
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              l.navigation_backend_version(state.compatibility == BackendCompatibility.unknown ? '—' : state.version!),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
          ),
          if (mismatch)
            Tooltip(
              key: const Key('backend-major-mismatch'),
              message: l.navigation_backend_major_mismatch(state.version!, bloc.expectedVersion),
              child: Icon(Icons.warning_amber_rounded, size: 20, color: theme.colorScheme.error),
            ),
          if (state.status == BackendVersionStatus.failure ||
              state.status == BackendVersionStatus.ready && state.compatibility == BackendCompatibility.unknown)
            Tooltip(message: l.navigation_backend_version_unknown, child: const Icon(Icons.help_outline, size: 18)),
        ],
      ),
    );
  }
}
