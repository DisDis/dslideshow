import 'package:logging/logging.dart';

Future<T> captureLogs<T>(Future<T> Function(List<LogRecord>) action) async {
  final previous = Logger.root.level;
  final records = <LogRecord>[];
  Logger.root.level = Level.ALL;
  final subscription = Logger.root.onRecord.listen(records.add);
  try {
    return await action(records);
  } finally {
    await subscription.cancel();
    Logger.root.level = previous;
  }
}
