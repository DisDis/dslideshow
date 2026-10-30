import 'package:dslideshow_flutter/features/config/data/config_access_repository.dart';
import 'package:dslideshow_flutter/features/config/presentation/bloc/config_bloc.dart';
import 'package:dslideshow_flutter/features/config/presentation/bloc/config_event.dart';
import 'package:dslideshow_flutter/features/config/presentation/bloc/config_state.dart';
import 'package:dslideshow_flutter/features/config/presentation/widgets/config_view.dart';
import 'package:dslideshow_flutter/src/injector.dart';
import 'package:dslideshow_flutter/src/route_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfigPage extends StatelessWidget {
  const ConfigPage({super.key, this.repository});
  final ConfigAccessRepository? repository;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) =>
        ConfigBloc(repository: repository ?? injector())
          ..add(const ConfigEvent.initialize()),
    child: BlocListener<ConfigBloc, ConfigState>(
      listenWhen: (previous, current) => previous.phase != current.phase,
      listener: (context, state) {
        if (state.phase == ConfigPhase.exited) {
          context.read<RouteBloc>().add(ChangePageEvent(RoutePage.slideshow));
        }
      },
      child: const ConfigView(),
    ),
  );
}
