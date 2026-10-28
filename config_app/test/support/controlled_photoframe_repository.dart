import 'dart:async';

import 'package:config_app/features/config/data/repository/photoframe_repository.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';

class ControlledPhotoframeRepository implements PhotoframeRepository {
  final loads = <Completer<AppConfig>>[];
  final saves = <Completer<WebSocketResult>>[];
  final saved = <AppConfig>[];

  @override
  Future<AppConfig> getConfig() {
    final result = Completer<AppConfig>();
    loads.add(result);
    return result.future;
  }

  @override
  Future<WebSocketResult> saveConfig(AppConfig config) {
    saved.add(config);
    final result = Completer<WebSocketResult>();
    saves.add(result);
    return result.future;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
