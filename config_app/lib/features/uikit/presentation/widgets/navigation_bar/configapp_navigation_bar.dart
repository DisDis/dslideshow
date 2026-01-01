import 'package:config_app/features/auth/presentation/bloc/authentication_bloc.dart';
import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
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
                accountEmail: const Text('example@gmail.com'),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: Image.network(
                      state.user.avatarUrl.medium,
                      fit: BoxFit.cover,
                      width: 90,
                      height: 90,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.amber,
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
                  color: Colors.blue,
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
            title: Text("Home"),
            onTap: () => context.go('/home'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.web),
            title: const Text('Web'),
            onTap: () => context.go("/web_config"),
          ),
          ListTile(
            leading: const Icon(Icons.wifi),
            title: const Text('Wifi'),
            onTap: () => context.go('/wifi_config'),
          ),
          ListTile(
            leading: const Icon(Icons.slideshow),
            title: const Text('Slideshow'),
            onTap: () => context.go('/slideshow_config'),
          ),
          ListTile(
            leading: const Icon(Icons.update),
            title: const Text('OTA Update'),
            onTap: () => context.go('/ota'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.image),
            title: const Text('Gallery'),
            onTap: () => context.go('/gallery'),
          ),
          const Divider(),
          ListTile(
            title: const Text('Exit'),
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
