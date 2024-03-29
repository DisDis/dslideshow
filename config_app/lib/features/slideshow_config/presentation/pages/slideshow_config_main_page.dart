import 'package:config_app/features/slideshow_config/presentation/widgets/effect_demo.dart';
import 'package:config_app/features/uikit/presentation/widgets/navigation_bar/configapp_navigation_bar.dart';
import 'package:config_app/features/wifi_config/presentation/bloc/wifi_tab_bloc.dart';
import 'package:config_app/features/wifi_config/presentation/bloc/wifi_tab_state.dart';
import 'package:config_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: implementation_imports
import 'package:dslideshow_flutter/src/effect/effect.dart';

class SlideshowConfigMainPage extends StatelessWidget {
  const SlideshowConfigMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Slideshow config")),
      drawer: const ConfigAppNavigationBar(),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<WifiTabBloc>(
            create: (BuildContext context) => WifiTabBloc(initialState: const UnWifiTabState(), client: sl()),
          ), /*
    BlocProvider<BlocC>(
      create: (BuildContext context) => BlocC(),
    ),*/
        ],
        child: Builder(
          builder: (context) {
            return const EffectDemoWidget(
              currentEffect: Effect.fadeEffect,
            );
          },
        ),
      ),
    );
  }
}
