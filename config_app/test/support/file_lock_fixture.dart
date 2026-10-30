import 'dart:convert';
import 'dart:io';

Future<void> main(List<String> args) async {
  final handle = await File(args.single).open(mode: FileMode.append);
  try {
    await handle.lock(FileLock.exclusive);
    stdout.writeln('locked');
    await stdout.flush();
    await stdin.transform(utf8.decoder).transform(const LineSplitter()).first;
  } finally {
    await handle.unlock();
    await handle.close();
  }
}
