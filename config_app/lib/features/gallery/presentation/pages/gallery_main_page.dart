import 'package:config_app/features/gallery/presentation/bloc/gallery_bloc.dart';
import 'package:config_app/features/gallery/presentation/widgets/gallery_widget.dart';
import 'package:config_app/features/uikit/presentation/widgets/navigation_bar/configapp_navigation_bar.dart';
import 'package:config_app/injection_container.dart';
import 'package:flutter/material.dart';
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
          BlocProvider<GalleryBloc>(
            create: (BuildContext context) => GalleryBloc(
                initialState: const UninitializedGalleryState(), client: sl())
              ..add(GalleryLoadEvent()),
          ),
        ],
        child: Builder(
          builder: (context) {
            return const GalleryWidget();
          },
        ),
      ),
    );
  }
}
