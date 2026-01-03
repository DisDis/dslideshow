import 'package:config_app/features/power/presentation/bloc/power_bloc.dart';
import 'package:config_app/features/power/presentation/bloc/power_event.dart';
import 'package:config_app/features/power/presentation/bloc/power_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PowerTab extends StatelessWidget {
  const PowerTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PowerBloc, PowerState>(
        builder: (
          BuildContext context,
          PowerState currentState,
        ) {
          if (currentState is UninitializedPowerState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is ErrorPowerState) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(currentState.errorMessage),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<PowerBloc>().add(const LoadPowerEvent());
                    },
                    child: const Text('Reload'),
                  ),
                ),
              ],
            ));
          }
          if (currentState is InitializedPowerState) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: Column(
                    children: [
                      ElevatedButton(
                        child: const Text('Restart application'),
                        onPressed: () {
                          context.read<PowerBloc>().add(const RestartAppPowerEvent());
                        },
                      ),
                      ElevatedButton(
                    child: const Text('Power off'),
                    onPressed: () {
                      context.read<PowerBloc>().add(const PowerOffPowerEvent());
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
}
