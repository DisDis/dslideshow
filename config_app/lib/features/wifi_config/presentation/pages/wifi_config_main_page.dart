import 'package:config_app/features/auth/presentation/bloc/authentication_bloc.dart';
import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:config_app/features/uikit/presentation/widgets/navigation_bar/configapp_navigation_bar.dart';
import 'package:config_app/features/web_server_config/presentation/widgets/web_tab.dart';
import 'package:config_app/features/wifi_config/presentation/bloc/wifi_tab_bloc.dart';
import 'package:config_app/features/wifi_config/presentation/bloc/wifi_tab_state.dart';
import 'package:config_app/features/wifi_config/presentation/widgets/wifi_tab.dart';
import 'package:config_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WiFiConfigMainPage extends StatelessWidget {
  const WiFiConfigMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("WiFi config")),
      drawer: const ConfigAppNavigationBar(),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<WifiTabBloc>(
            create: (BuildContext context) => WifiTabBloc(initialState: UnWifiTabState(), client: sl()),
          ), /*
    BlocProvider<BlocC>(
      create: (BuildContext context) => BlocC(),
    ),*/
        ],
        child: Builder(
          builder: (context) {
            return WiFiConfigTab(
              wifiTabBloc: context.read(),
            );
          },
        ),
      ),
    );
  }
}
