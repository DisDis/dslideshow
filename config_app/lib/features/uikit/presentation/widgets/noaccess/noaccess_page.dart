import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class NoAccessPage extends StatelessWidget {
  final Widget? drawerWidget;
  const NoAccessPage({super.key, this.drawerWidget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("No access")),
      drawer: drawerWidget,
      body: Center(
          child: Column(
        children: [
          const Text('No access, contact your administrator'),
          ElevatedButton(
              onPressed: () {
                context.go('/home');
              },
              child: const Text("Home"))
        ],
      )),
    );
  }
}
