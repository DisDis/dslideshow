// Run with PATH=/nonexistent and the absolute Dart binary. Never invokes sudo.
import 'dart:async';
import 'dart:io';

import 'package:dslideshow_backend/src/service/wifi/wifi_config.dart';
import 'package:dslideshow_backend/src/service/wifi/wifi_service.dart';
import 'package:logging/logging.dart';

Future<void> main() async {
  if (Platform.environment['PATH'] != '/nonexistent') {
    throw StateError(
      'This probe requires PATH=/nonexistent to prevent hardware access',
    );
  }
  Logger.root.level = Level.ALL;
  final failure = Completer<LogRecord>();
  final subscription = Logger.root.onRecord.listen((record) {
    if (record.loggerName == 'WiFiService' &&
        record.level == Level.SEVERE &&
        !failure.isCompleted) {
      failure.complete(record);
    }
  });
  try {
    WiFiService(WiFiConfig.fromJson({}))
        .addWiFiConnection('review', 'review', 'synthetic-review-password');
    final record = await failure.future.timeout(const Duration(seconds: 5));
    final exposed = '${record.message} ${record.error}'.contains(
      'synthetic-review-password',
    );
    print('process_launch_failure_exposes_password=$exposed');
    if (!exposed) throw StateError('The reviewed failure was not reproduced');
  } finally {
    await subscription.cancel();
  }
}
