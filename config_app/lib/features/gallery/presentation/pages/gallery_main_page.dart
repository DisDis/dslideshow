import 'package:config_app/features/gallery/presentation/widgets/gallery.dart';
import 'package:config_app/features/uikit/presentation/widgets/navigation_bar/configapp_navigation_bar.dart';
import 'package:config_app/features/web_server_config/presentation/bloc/web_tab_bloc.dart';
import 'package:config_app/features/web_server_config/presentation/bloc/web_tab_state.dart';
import 'package:config_app/features/web_server_config/presentation/widgets/web_tab.dart';
import 'package:config_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GalleryMainPage extends StatelessWidget {
  const GalleryMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gallery")),
      drawer: const ConfigAppNavigationBar(),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<WebTabBloc>(
            create: (BuildContext context) => WebTabBloc(initialState: UnWebTabState(), client: sl()),
          ), /*
    BlocProvider<BlocC>(
      create: (BuildContext context) => BlocC(),
    ),*/
        ],
        child: Builder(
          builder: (context) {
            return const MediaGalleryWidget();
          },
        ),
      ),
    );
  }
}
