import 'package:config_app/features/web_server_config/presentation/bloc/web_tab_bloc.dart';
import 'package:config_app/features/web_server_config/presentation/bloc/web_tab_event.dart';
import 'package:config_app/features/web_server_config/presentation/bloc/web_tab_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WebConfigTab extends StatefulWidget {
  const WebConfigTab({
    required WebTabBloc tabBloc,
    super.key,
  }) : _tabBloc = tabBloc;

  final WebTabBloc _tabBloc;

  @override
  WebConfigTabState createState() {
    return WebConfigTabState();
  }
}

class WebConfigTabState extends State<WebConfigTab> {
  WebConfigTabState();

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WebTabBloc, WebTabState>(
        bloc: widget._tabBloc,
        builder: (
          BuildContext context,
          WebTabState currentState,
        ) {
          if (currentState is UnWebTabState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is ErrorWebTabState) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(currentState.errorMessage),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: ElevatedButton(
                    onPressed: _load,
                    child: const Text('Reload'),
                  ),
                ),
              ],
            ));
          }
          if (currentState is InWebTabState) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: TextEditingController(
                      text: currentState.config.webServer.port.toString()),
                  decoration: const InputDecoration(labelText: 'Port'),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ], // Only numbers can be entered
                ),
                TextField(
                  controller: TextEditingController(
                      text: currentState.config.webServer.permanentCode),
                  decoration:
                      const InputDecoration(labelText: 'Permanent Code'),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ], // Only numbers can be entered
                ),
                CheckboxListTile(
                  value: currentState.config.webServer.alwaysEnabled,
                  onChanged: (newValue) {},
                  title: const Text('Always Enabled'),
                ),

                /**"port": 8080,
    "alwaysEnabled": true,
    "permanentCode": "123" */
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: Column(
                    children: [
                      ElevatedButton(
                        child: const Text('Restart application'),
                        onPressed: () {
                          widget._tabBloc.add(const RestartAppWebTabEvent());
                        },
                      ),
                      ElevatedButton(
                    child: const Text('Power off'),
                    onPressed: () {
                      widget._tabBloc.add(const PowerOffWebTabEvent());
                    },
                  ),
                    ],
                  ),
                ),
                 
              ],
            ));
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  void _load() {
    widget._tabBloc.add(const LoadWebTabEvent());
  }
}
