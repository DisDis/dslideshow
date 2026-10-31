import 'dart:async';

import 'package:dslideshow_common/log.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

void main() {
  test('console log includes isolate, category, error and stack trace', () async {
    final lines = <String>[];
    await runZoned(() async {
      initLog('web-test');
      Logger('GalleryTest').warning(
        'Native failure',
        StateError('test failure https://frame/private?code=secret\nsecond error line'),
        StackTrace.fromString('#0 original-source\n#1 original-caller\n#2 final-stack-marker'),
      );
      await Future<void>.delayed(Duration.zero);
    }, zoneSpecification: ZoneSpecification(print: (_, __, ___, line) => lines.add(line)));
    expect(lines, hasLength(1));
    expect(lines.single, contains('[web-test] WARNING:GalleryTest: Native failure'));
    expect(lines.single, contains('test failure https://frame/private?code=secret\nsecond error line'));
    expect(lines.single, contains('#0 original-source\n#1 original-caller\n#2 final-stack-marker'));
  });
}
