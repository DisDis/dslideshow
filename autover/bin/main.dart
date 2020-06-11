

import 'dart:isolate';

import 'package:autover/autover.dart';
import 'package:logging/logging.dart';

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

Logger _log = new Logger('main');
void main(List<String> args) async{
  try {
    initLog('autover');
    await new AutoVer().execute(args);
  } catch (e,st){
    _log.severe('FATAL', e, st);
  }
}