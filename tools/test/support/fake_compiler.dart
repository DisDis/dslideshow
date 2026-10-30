import 'dart:convert';
import 'dart:io';

Future<void> main(List<String> args) async {
  final log = File(Platform.environment['COMPILER_TEST_LOG']!);
  await log.writeAsString(jsonEncode({'cwd': Directory.current.path, 'args': args}));
  final output = args[args.indexOf('-o') + 1];
  await File(output).writeAsString('compiled-linux-arm64');
}
