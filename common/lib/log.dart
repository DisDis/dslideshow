import 'package:logging/logging.dart' show Logger, Level, LogRecord;
import 'dart:isolate';

void initLog([String isolateMarker]) {
  if (isolateMarker == null){
    isolateMarker = "I${Isolate.current.hashCode}";
  }
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    StringBuffer message = new StringBuffer();
    message.write('[$isolateMarker] ${rec.time} ${rec.level.name}:${rec.loggerName}: ${rec.message}');
    if (rec.error != null) {
      message.write(' ${rec.error}');
    }
    print(message);
  });
}