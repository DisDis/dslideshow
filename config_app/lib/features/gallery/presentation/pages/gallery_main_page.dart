import 'package:config_app/features/gallery/presentation/bloc/gallery_bloc.dart';
import 'package:config_app/features/gallery/presentation/widgets/gallery_widget.dart';
import 'package:config_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GalleryMainPage extends StatelessWidget {
  const GalleryMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Убираем здесь Scaffold, AppBar и Drawer.
    // Они переезжают внутрь GalleryWidget.
    return BlocProvider<GalleryBloc>(
      create: (BuildContext context) => GalleryBloc(
        initialState: const UninitializedGalleryState(),
        client: sl(),
      )..add(const GalleryLoadEvent()),
      child: const GalleryWidget(),
    );
  }
}