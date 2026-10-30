import 'dart:io';

import 'package:dslideshow_tools/src/ambient/cli.dart';
import 'package:dslideshow_tools/src/ambient/probe.dart';

import 'ambient_loopback.dart';

Future<void> main(List<String> args) async {
  exitCode = await runAmbient(
    ['--client-file', args[1], '--state-dir', args[2], '--videos', '0'],
    defaultStateDirectory: args[2],
    http: AmbientHttp(client: AmbientLoopbackClient(int.parse(args[0]))),
  );
}
