import 'package:dslideshow_backend/config.dart';
import 'package:flutter/foundation.dart';

abstract class SpecialScreenSession extends ChangeNotifier {
  final SpecialScreenConfig config;
  bool active = false;
  bool closed = false;
  SpecialScreenSession(this.config);
  Future<bool> prepare();
  void setActive(bool value) {
    if (closed || active == value) return;
    active = value;
    notifyListeners();
  }

  @override
  void dispose() {
    if (closed) return;
    closed = true;
    active = false;
    super.dispose();
  }
}
