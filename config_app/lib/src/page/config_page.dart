import 'package:flutter/material.dart';

class ConfigPage extends StatefulWidget {
  static const String routeName = '/config';

  const ConfigPage({Key? key}) : super(key: key);

  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  // final _configPageBloc = ConfigPageBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ConfigPage'),
        ),
        body: Column(
          children: const [Text('Test')],
        )
        // ConfigPageScreen(configPageBloc: _configPageBloc),
        );
  }
}
