import 'dart:isolate';

import 'package:autover/autover.dart';
import 'package:logging/logging.dart';

void initLog([String? isolateMarker]) {
  isolateMarker ??= 'I${Isolate.current.hashCode}';
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    final message = StringBuffer();
    message.write('[$isolateMarker] ${rec.time} ${rec.level.name}:${rec.loggerName}: ${rec.message}');
    if (rec.error != null) {
      message.write(' ${rec.error}');
    }
    print(message);
  });
}

Logger _log = Logger('main');
void main(List<String> args) {
  try {
    initLog('autover');
    AutoVer(args);
  } on Exception catch (e, st) {
    _log.severe('FATAL', e, st);
  }
}
