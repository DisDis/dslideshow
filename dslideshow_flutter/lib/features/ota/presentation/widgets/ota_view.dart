import 'package:dslideshow_common/version.dart';
import 'package:dslideshow_flutter/environment.dart' as environment;
import 'package:dslideshow_flutter/features/ota/presentation/bloc/ota_bloc.dart';
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
    final header = [
      // Text(
      //   "OTA - ${state.info.status}",
      //   style: const TextStyle(color: Colors.white),
      // ),
      const Text(
        "Version: v${ApplicationInfo.frontendVersion}",
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
      Text(
        "Code: ${state.info.code}",
        style: const TextStyle(color: Colors.white, fontSize: 65),
      ),
    ];
    final terminalView = Expanded(
        flex: 2,
        child: TerminalView(
          terminal,
          readOnly: true,
          autofocus: true,
          // textStyle: const TerminalStyle(fontFamily: ['Cascadia Mono']),
        ));
    return state.when(
      exit: (info) {
        return const CircularProgressIndicator();
      },
      initial: (info) => const CircularProgressIndicator(),
      failure: (info) => Column(children: [
        ...header,
        Text(
          "Error${state.info.errorText == null ? '' : '$state.info.errorText'}",
          style: const TextStyle(color: Colors.red, fontSize: 50),
        ),
        terminalView
      ]),
      progress: (info) => Column(children: [
        ...header,
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: LinearProgressIndicator(
            value: state.info.uploadingPercent / 100,
            semanticsLabel: 'OTA progress',
            minHeight: 15,
          ),
        ),
        if (!environment.isLinuxEmbedded) const TestConfigButton(),
        terminalView
      ]),
      ready: (info) => Column(children: [
        if (!environment.isLinuxEmbedded) const TestConfigButton(),
        // ElevatedButton(
        //   onPressed: () {
        //     _runTestCommand(terminal);
        //   },
        //   child: const Text('echo'),
        // ),
        ...header,
        terminalView
      ]),
      success: (info) => Column(children: [
        ...header,
        const Text(
          "Finished",
          style: TextStyle(color: Colors.green, fontSize: 50),
        ),
        terminalView
      ]),
    );
  }

  // _runTestCommand(Terminal terminal) async {
  //   var process = await io.Process.start(
  //     'htop',
  //     [],
  //     // 'tput', ['cols'],
  //     // 'sudo',
  //     // ['apt-get', '-f', '-y', 'install', 'test'],
  //     environment: {'LC_ALL': 'C', 'TERM': 'xterm-256color', 'COLUMNS': '120'},
  //     // runInShell: true,
  //   );
  //   // process.stdout.transform(utf8.decoder).forEach((str) {
  //   //   terminal.write(str);
  //   // });
  //   process.stdout.transform(utf8.decoder).listen((str) {
  //     terminal.write(str);
  //     terminal.write('\r');
  //   });
  //   process.stderr.transform(utf8.decoder).listen((str) {
  //     terminal.write(str);
  //     terminal.write('\r');
  //   });
  // }
}

class TestConfigButton extends StatelessWidget {
  const TestConfigButton({
    super.key,
  });

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
