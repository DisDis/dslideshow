import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class NoAccessPage extends StatelessWidget {
  final Widget? drawerWidget;
  const NoAccessPage({super.key, this.drawerWidget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.localizations.no_access_title)),
      drawer: drawerWidget,
      body: Center(
          child: Column(
        children: [
          Text(context.localizations.no_access_contact_administrator),
          ElevatedButton(
              onPressed: () {
                context.go('/home');
              },
              child: Text(context.localizations.home_menu_item))
        ],
      )),
    );
  }
}
