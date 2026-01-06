import 'package:config_app/features/auth/presentation/bloc/authentication_bloc.dart';
import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:config_app/features/theme/presentation/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// final _leftDrawerProvider = sl<LeftDrawerProvider>();

enum HomeTab { log, hardware, slideshow, welcome, web, mqtt, storage, wifi }

class ConfigAppNavigationBar extends StatelessWidget {
  static const Key _navKey = Key("#WANavigationBar");
  const ConfigAppNavigationBar() : super(key: _navKey);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              return UserAccountsDrawerHeader(
                accountName: Text(state.user.username),
                accountEmail: Text(context.localizations.example_email_address),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: Image.network(
                      state.user.avatarUrl.medium,
                      fit: BoxFit.cover,
                      width: 90,
                      height: 90,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: AppColors.noImageAvatar ,
                          alignment: Alignment.center,
                          child: const Text(
                            'No image',
                            style: TextStyle(fontSize: 30),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                decoration: const BoxDecoration(
                  color: AppColors.imageAvatar,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: Text(context.localizations.home_menu_item),
            onTap: () => context.go('/home'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: Text(context.localizations.gallery_menu_item),
            onTap: () => context.go('/gallery'),
          ),
          ListTile(
            leading: const Icon(Icons.upload_file),
            title: Text(context.localizations.upload_media_menu_item),
            onTap: () => context.go('/upload'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(context.localizations.configuration_menu_item),
            onTap: () => context.go('/config'),
          ),
          ListTile(
            leading: const Icon(Icons.system_update),
            title: Text(context.localizations.ota_update_title),
            onTap: () => context.go('/ota'),
          ),
          ListTile(
            leading: const Icon(Icons.wifi),
            title: Text(context.localizations.wifi_menu_item),
            onTap: () => context.go('/wifi_config'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.power_settings_new),
            title: Text(context.localizations.system_control_menu_item),
            onTap: () => context.go("/power"),
          ),
          const Divider(),
          ListTile(
            title: Text(context.localizations.exit_menu_item),
            leading: const Icon(Icons.exit_to_app),
            onTap: () => context
                .read<AuthenticationBloc>()
                .add(const AuthenticationLogoutRequested()),
          ),
          // ..._leftDrawerProvider.getMenuItems()
        ],
      ),
    );
  }
}
