import 'package:config_app/features/auth/presentation/bloc/authentication_bloc.dart';
import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:config_app/features/uikit/presentation/widgets/navigation_bar/configapp_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static void route(BuildContext context) {
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.localizations.home_page_name)),
      drawer: const ConfigAppNavigationBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Builder(
              builder: (context) {
                final userId = context.select(
                  (AuthenticationBloc bloc) => bloc.state.user.id,
                );
                return Text(context.localizations.home_userid(userId));
              },
            ),
            ElevatedButton(
              child: Text(context.localizations.home_page_logout_button),
              onPressed: () {
                context.read<AuthenticationBloc>().add(const AuthenticationLogoutRequested());
              },
            ),
            ElevatedButton(
              child: const Text("config"),
              onPressed: () {
                context.go('/config');
              },
            ),
            ElevatedButton(
              child: const Text("Wifi"),
              onPressed: () {
                context.go('/wifi');
              },
            ),
            ElevatedButton(
              child: const Text("OTA"),
              onPressed: () {
                context.go('/ota');
              },
            ),
          ],
        ),
      ),
    );
  }
}
