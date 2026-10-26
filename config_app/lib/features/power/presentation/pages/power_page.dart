import 'package:config_app/features/power/presentation/bloc/power_bloc.dart';
import 'package:config_app/features/power/presentation/bloc/power_event.dart';
import 'package:config_app/features/power/presentation/bloc/power_state.dart';
import 'package:config_app/features/power/presentation/widgets/power_tab.dart';
import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:config_app/features/uikit/presentation/widgets/config_app_scaffold.dart';
import 'package:config_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PowerMainPage extends StatelessWidget {
  const PowerMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ConfigAppScaffold(
      // Используем более "системное" название
      appBar: AppBar(title: Text(context.localizations.system_control_title)),

      body: MultiBlocProvider(
        providers: [
          BlocProvider<PowerBloc>(
            create: (BuildContext context) => PowerBloc(
              initialState: const UninitializedPowerState(),
              client: sl(),
            )..add(const LoadPowerEvent()),
          ),
        ],
        child: const PowerTab(),
      ),
    );
  }
}
