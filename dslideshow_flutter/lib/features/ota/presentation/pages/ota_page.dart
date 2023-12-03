import 'package:dslideshow_flutter/features/ota/presentation/bloc/ota_bloc.dart';
import 'package:dslideshow_flutter/features/ota/presentation/bloc/ota_event.dart';
import 'package:dslideshow_flutter/features/ota/presentation/bloc/terminal_backend.dart';
import 'package:dslideshow_flutter/features/ota/presentation/widgets/ota_view.dart';
import 'package:dslideshow_flutter/src/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:xterm/xterm.dart';

@immutable
// ignore: must_be_immutable
class OTAPage extends StatelessWidget {
  final Terminal terminal = Terminal(maxLines: 3000);
  late TerminalBackend backend = TerminalBackend(terminal);
  OTAPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: OtaBloc(frontendService: injector(), backend: backend)..add(const OtaEvent.initialization()),
        child: Scaffold(
            backgroundColor: Colors.black,
            body: OTAView(
              terminal: terminal,
            )));
  }
}
