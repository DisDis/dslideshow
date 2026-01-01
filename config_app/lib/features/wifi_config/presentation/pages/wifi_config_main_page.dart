import 'package:config_app/features/wifi_config/presentation/bloc/wifi_tab_bloc.dart';
import 'package:config_app/features/wifi_config/presentation/bloc/wifi_tab_event.dart';
import 'package:config_app/features/wifi_config/presentation/bloc/wifi_tab_state.dart';
import 'package:config_app/features/wifi_config/presentation/widgets/wifi_tab.dart';
import 'package:config_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WiFiConfigMainPage extends StatelessWidget {
  const WiFiConfigMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Здесь НЕТ Scaffold и НЕТ Drawer.
    // Только провайдер Блока.
    return BlocProvider<WifiTabBloc>(
      create: (BuildContext context) => WifiTabBloc(
        initialState: const UnWifiTabState(),
        client: sl(),
      )..add(const LoadWifiTabEvent()),
      child: const WiFiConfigTab(),
    );
  }
}