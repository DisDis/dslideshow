import 'dart:async';
import 'dart:convert';
import 'dart:io';

enum ExternalProcessMode {
  literal,
  ok,
  flood,
  discarded,
  discardedFlood,
  resist,
  wait,
  diagnostic,
  diagnosticFlood,
  stdoutFlood,
  stderrFlood,
}

Future<void> main(List<String> args) async {
  final mode = ExternalProcessMode.values.byName(args.first);
  StreamSubscription<ProcessSignal>? signal;
  if ([
    ExternalProcessMode.resist,
    ExternalProcessMode.diagnostic,
    ExternalProcessMode.diagnosticFlood,
    ExternalProcessMode.stdoutFlood,
    ExternalProcessMode.stderrFlood,
  ].contains(mode)) {
    signal = ProcessSignal.sigterm.watch().listen((_) {});
  }
  if (args.length > 1 && args[1].isNotEmpty) {
    final ready = await Socket.connect(InternetAddress.loopbackIPv4, int.parse(args[1]));
    ready.write('ready');
    await ready.flush();
    await ready.close();
    ready.destroy();
  }
  switch (mode) {
    case ExternalProcessMode.literal:
      stdout.writeln(jsonEncode([args[2], Platform.environment['GALLERY_TEST']]));
      stderr.write('diagnostic');
    case ExternalProcessMode.ok:
      stdout.writeln('ok');
    case ExternalProcessMode.flood:
      stdout.write('x' * 4096);
      await stdout.flush();
      stderr.write('y' * 4096);
    case ExternalProcessMode.discarded:
    case ExternalProcessMode.discardedFlood:
      stdout.write('x' * 1048576);
      await stdout.flush();
      stderr.write(mode == ExternalProcessMode.discarded ? 'kept' : 'y' * 4096);
    case ExternalProcessMode.diagnostic:
      stderr.write('Unsupported filter from native decoder\n');
      exitCode = 23;
    case ExternalProcessMode.diagnosticFlood:
      stderr.write('native-diagnostic-prefix\n${'x' * 200000}');
      await stderr.flush();
      await Completer<void>().future;
    case ExternalProcessMode.stdoutFlood:
    case ExternalProcessMode.stderrFlood:
      final output = mode == ExternalProcessMode.stdoutFlood ? stdout : stderr;
      output.write('x' * 200000);
      await output.flush();
      await Completer<void>().future;
    case ExternalProcessMode.resist:
    case ExternalProcessMode.wait:
      // The subscription keeps this process alive until its owner terminates it.
      signal ??= ProcessSignal.sigterm.watch().listen((_) {});
      await Completer<void>().future;
  }
  await signal?.cancel();
}
