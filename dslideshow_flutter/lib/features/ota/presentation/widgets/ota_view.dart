import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_flutter/environment.dart' as environment;
import 'package:dslideshow_flutter/features/ota/presentation/bloc/ota_bloc.dart';
import 'package:dslideshow_flutter/features/ota/presentation/bloc/ota_state.dart';
import 'package:dslideshow_flutter/features/ota/presentation/widgets/ota_ready_widget.dart';
import 'package:dslideshow_flutter/src/route_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xterm/xterm.dart';

class OTAView extends StatelessWidget {
  final Terminal terminal;

  const OTAView({super.key, required this.terminal});
  @override
  Widget build(BuildContext context) {
    final state = context.watch<OtaBloc>().state;

    final terminalView = Expanded(
      flex: 2,
      child: TerminalView(
        deleteDetection: true,
        terminal,
        readOnly: true,
        autofocus: true,
        // textStyle: const TerminalStyle(fontFamily: ['Cascadia Mono']),
      ),
    );
    if (state is OtaExitState) {
      return const CircularProgressIndicator();
    } else if (state is OtaInitialState) {
      return const CircularProgressIndicator();
    } else if (state is OtaFailureState) {
      return Column(
        children: [
          Text("Error${state.info.errorText == null ? '' : '$state.info.errorText'}", style: const TextStyle(color: Colors.red, fontSize: 50)),
          terminalView,
        ],
      );
    } else if (state is OtaProgressState) {
      return Column(
        children: [
          if (state.info.status == OTAStatus.uploading)
            Text("Updating ${state.info.uploadingPercent}%", style: TextStyle(color: Colors.amberAccent, fontSize: 50)),
          if (state.info.status == OTAStatus.instaling) const Text("Installing", style: TextStyle(color: Colors.amberAccent, fontSize: 50)),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: LinearProgressIndicator(value: state.info.uploadingPercent / 100, semanticsLabel: 'OTA progress', minHeight: 15),
          ),
          if (!environment.isLinuxEmbedded) const TestConfigButton(),
          terminalView,
        ],
      );
    } else if (state is OtaReadyState) {
      return OtaReadyWidget(state: state);
    } else if (state is OtaSuccessState) {
      return Column(
        children: [
          const Text("Finished", style: TextStyle(color: Colors.green, fontSize: 50)),
          terminalView,
        ],
      );
    }
    return Text("Unknown state ${state.runtimeType}");
  }
}

class TestConfigButton extends StatelessWidget {
  const TestConfigButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<RouteBloc>().add(ChangePageEvent(RoutePage.config));
      },
      child: const Text('Config'),
    );
  }
}
