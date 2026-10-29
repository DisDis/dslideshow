import 'package:dslideshow_flutter/features/ota/presentation/bloc/ota_bloc.dart';
import 'package:dslideshow_flutter/features/ota/presentation/bloc/ota_event.dart';
import 'package:dslideshow_flutter/features/ota/presentation/bloc/ota_terminal_session.dart';
import 'package:dslideshow_flutter/features/ota/presentation/widgets/ota_view.dart';
import 'package:dslideshow_flutter/features/theme/presentation/theme.dart';
import 'package:dslideshow_flutter/src/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OTAPage extends StatelessWidget {
  const OTAPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => OtaTerminalSession(),
      dispose: (session) => session.dispose(),
      child: BlocProvider(
        create: (context) => OtaBloc(
          frontendService: injector(),
          backend: context.read<OtaTerminalSession>().backend,
          routeBloc: injector(),
        )..add(const OtaEvent.initialization()),
        child: Builder(
          builder: (context) => Scaffold(
            backgroundColor: ThemeColors.configBackgroundColor,
            body: OTAView(session: context.read<OtaTerminalSession>()),
          ),
        ),
      ),
    );
  }
}
