import 'dart:convert';
import 'dart:io';

Future<void> main(List<String> arguments) async {
  await File(Platform.environment['COMMAND_LOG']!).writeAsString('${jsonEncode(arguments)}\n', mode: FileMode.append);
  if (arguments.length >= 2 &&
      arguments[0] == 'pub' &&
      arguments[1] == 'get' &&
      Platform.environment['FAIL_PUB'] == '1') {
    exitCode = 7;
  }
}
